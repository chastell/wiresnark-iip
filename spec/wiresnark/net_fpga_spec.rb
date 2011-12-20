# encoding: UTF-8

require_relative '../spec_helper'

module Wiresnark describe NetFPGA do
  describe '#config=' do
    # FIXME: an awful spec
    it 'sets the card’s configuration' do
      config = {
        0 => {
          local: 'ad:e3:3e:a4:23:aa',
          other: 'a3:a3:45:23:34:aa',
          phases: [
            { type: 'QOS', length: 180 },
            { type: 'CAN', length: 190 },
            { type: 'DSS', length: 200 },
            { type: 'MGT', length: 210 },
            { type: 'NIL', length: 220 },
          ],
        },
        1 => {
          local: 'ad:e3:3e:b4:23:aa',
          other: 'a3:aa:45:23:34:aa',
          phases: [],
        },
      }

      $port0 = MiniTest::Mock.new
      $port0.expect :local_mac=, nil, ['ad:e3:3e:a4:23:aa']
      $port0.expect :other_mac=, nil, ['a3:a3:45:23:34:aa']
      $port0.expect :phases=,    nil, [config[0][:phases]]

      $port1 = MiniTest::Mock.new
      $port1.expect :local_mac=, nil, ['ad:e3:3e:b4:23:aa']
      $port1.expect :other_mac=, nil, ['a3:aa:45:23:34:aa']
      $port1.expect :phases=,    nil, [[]]

      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h'
      def nf.ports; [$port0, $port1]; end
      nf.config = config

      $port0.verify
      $port1.verify
    end
  end

  describe '#get' do
    it 'gets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :get, 7, [0x2000200]
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h', regbridge
      nf.get('SCHEDULER_0_NUM_PHASES_REG').must_equal 7
      regbridge.verify
    end
  end

  describe '#ports' do
    it 'returns the four NetFPGA’s ports' do
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h'
      nf.ports.size.must_equal 4
      nf.ports.each { |p| p.must_be_instance_of NetFPGA::Port }
    end
  end

  describe '#registers' do
    it 'returns the given NetFPGA’s register map' do
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h'
      nf.registers['SCHEDULER_0_NUM_PHASES_REG'].must_equal 0x2000200
    end
  end

  describe '#set' do
    it 'sets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :set, nil, [0x2000200, 7]
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h', regbridge
      nf.set 'SCHEDULER_0_NUM_PHASES_REG', 7
      regbridge.verify
    end
  end
end end
