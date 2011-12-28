require_relative '../spec_helper'

module Wiresnark describe Shower do
  describe '#show' do
    it 'prints the proper NetFPGA params' do
      p0 = MiniTest::Mock.new
      p1 = MiniTest::Mock.new
      p2 = MiniTest::Mock.new
      p3 = MiniTest::Mock.new
      nf = MiniTest::Mock.new
      p0.expect :local_mac, '00:11:22:33:44:55'
      p1.expect :other_mac, 'aa:bb:cc:dd:ee:ff'
      p2.expect :phases, [{ type: 'QOS', length: 100 }, { type: 'CAN', length: 200 }, { type: 'MGT', length: 300 }, { type: 'NIL', length: 400 }]
      nf.expect :ports, [p0, p1, p2]

      Shower.new(nf).show({ 'interface' => 'eth0', 'param' => 'MACSA', 'vport' => 'v_1' }).must_equal '00:11:22:33:44:55'
      Shower.new(nf).show({ 'interface' => 'eth1', 'param' => 'MACDA', 'vport' => 'v_1' }).must_equal 'aa:bb:cc:dd:ee:ff'
      Shower.new(nf).show({ 'interface' => 'eth2', 'param' => 'CL',    'vport' => 'v_1' }).must_equal 1000
      Shower.new(nf).show({ 'interface' => 'eth2', 'param' => 'NP',    'vport' => 'v_1' }).must_equal 4

      p0.verify
      p1.verify
      p2.verify
      nf.verify
    end
  end
end end
