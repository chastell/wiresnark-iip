# encoding: UTF-8

require_relative '../../spec_helper'

module Wiresnark::IIP describe Getter do
  describe '#get' do
    it 'returns the XML representation of the given NetFPGA’s configuration' do
      port = MiniTest::Mock.new
      4.times do
        port.expect :ether_type, 0x0abc
        port.expect :ifgap, 24
        port.expect :local_mac, 'ad:e3:3e:a4:23:aa'
        port.expect :mtu, 2048
        port.expect :other_mac, 'a3:a3:45:23:34:aa'
      end
      port.expect :cycle_length, 984
      port.expect :phase_number, 5
      port.expect :phases, [
        { type: 'QOS', length: 176 },
        { type: 'CAN', length: 184 },
        { type: 'DSS', length: 200 },
        { type: 'MGT', length: 208 },
        { type: 'NIL', length: 216 },
      ]
      port.expect :type_map, { 'QOS' => 1, 'CAN' => 2, 'DSS' => 4, 'MGT' => 7 }

      net_fpga = MiniTest::Mock.new
      net_fpga.expect :ports, [port]

      xml = File.read 'spec/fixtures/iip.conf.gotten.xml'
      Getter.new(net_fpga).get.must_equal xml

      port.verify
      net_fpga.verify
    end
  end
end end
