require_relative '../spec_helper'

module Wiresnark describe Shower do
  describe '#show' do
    it 'returns the proper Port params' do
      p0 = MiniTest::Mock.new
      p1 = MiniTest::Mock.new
      p2 = MiniTest::Mock.new
      nf = MiniTest::Mock.new
      p0.expect :local_mac, '00:11:22:33:44:55'
      p1.expect :other_mac, 'aa:bb:cc:dd:ee:ff'
      p2.expect :cycle_length, 1000
      p2.expect :phase_number, 4
      nf.expect :ports, [p0, p1, p2]

      Shower.new(nf).show(['MACSA', 'eth0', 'v_1']).must_equal '00:11:22:33:44:55'
      Shower.new(nf).show(['MACDA', 'eth1', 'v_1']).must_equal 'aa:bb:cc:dd:ee:ff'
      Shower.new(nf).show(['CL',    'eth2', 'v_1']).must_equal 1000
      Shower.new(nf).show(['NP',    'eth2', 'v_1']).must_equal 4

      p0.verify
      p1.verify
      p2.verify
      nf.verify
    end

    it 'returns the proper phase params' do
      p0 = MiniTest::Mock.new
      nf = MiniTest::Mock.new
      p0.expect :phases, [{ type: 'QOS', length: 100 }, { type: 'CAN', length: 200 }, { type: 'MGT', length: 300 }, { type: 'NIL', length: 400 }]
      nf.expect :ports, [p0]

      Shower.new(nf).show(['PL', 'eth0', 'v_1', 'QOS']).must_equal 100
      Shower.new(nf).show(['PL', 'eth0', 'v_1', 'NIL']).must_equal 400

      p0.verify
      nf.verify
    end

    it 'returns the proper constant params' do
      nf = MiniTest::Mock.new.expect :ports, []
      Shower.new(nf).show(['MTU',   'eth0', 'v_1']).must_equal 2048
      Shower.new(nf).show(['ifgap', 'eth1', 'v_1']).must_equal 24
    end
  end
end end
