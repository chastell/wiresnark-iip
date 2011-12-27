require_relative '../spec_helper'

module Wiresnark describe Shower do
  describe '#show' do
    it 'prints the proper NetFPGA params' do
      port0 = MiniTest::Mock.new
      port1 = MiniTest::Mock.new
      nf    = MiniTest::Mock.new
      port0.expect :local_mac, '00:11:22:33:44:55'
      port1.expect :other_mac, 'aa:bb:cc:dd:ee:ff'
      nf.expect :ports, [port0, port1]

      Shower.new(nf).show({ 'interface' => 'eth0', 'param' => 'MACSA', 'vport' => 'v_1' }).must_equal '00:11:22:33:44:55'
      Shower.new(nf).show({ 'interface' => 'eth1', 'param' => 'MACDA', 'vport' => 'v_1' }).must_equal 'aa:bb:cc:dd:ee:ff'

      port0.verify
      port1.verify
      nf.verify
    end
  end
end end
