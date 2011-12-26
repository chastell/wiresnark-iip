require_relative '../spec_helper'

module Wiresnark describe Shower do
  describe '#show' do
    it 'prints the proper NetFPGA params' do
      port = MiniTest::Mock.new
      nf   = MiniTest::Mock.new
      port.expect :other_mac, 'aa:bb:cc:dd:ee:ff'
      nf.expect :ports, [port]

      Shower.new(nf).show({ 'interface' => 'eth0', 'param' => 'MACDA', 'vport' => 'v_1' }).must_equal 'aa:bb:cc:dd:ee:ff'

      port.verify
      nf.verify
    end
  end
end end
