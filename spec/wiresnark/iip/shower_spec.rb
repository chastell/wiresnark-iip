require_relative '../../spec_helper'

module Wiresnark::IIP describe Shower do
  describe '#show' do
    it 'returns the proper Port params' do
      p0 = MiniTest::Mock.new
      p1 = MiniTest::Mock.new
      p2 = MiniTest::Mock.new
      nf = MiniTest::Mock.new
      p0.expect :local_mac, '00:11:22:33:44:55'
      p1.expect :other_mac, 'aa:bb:cc:dd:ee:ff'
      p1.expect :ether_type, 0xabcd
      p2.expect :cycle_length, 1000
      p2.expect :phase_number, 4
      5.times { nf.expect :ports, [p0, p1, p2] }

      Shower.new(nf).show(['MACSA', 'eth0', 'v_1']).must_equal '00:11:22:33:44:55'
      Shower.new(nf).show(['MACDA', 'eth1', 'v_1']).must_equal 'aa:bb:cc:dd:ee:ff'
      Shower.new(nf).show(['MACT',  'eth1', 'v_1']).must_equal '0xabcd'
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
      2.times do
        p0.expect :phases, [{ type: 'QOS', length: 100 }, { type: 'CAN', length: 200 }, { type: 'MGT', length: 300 }, { type: 'NIL', length: 400 }]
        nf.expect :ports, [p0]
      end

      Shower.new(nf).show(['PL', 'eth0', 'v_1', 'QOS']).must_equal 'QOS=100,,,'
      Shower.new(nf).show(['PL', 'eth0', 'v_1', 'NIL']).must_equal ',,,NIL=400'

      p0.verify
      nf.verify
    end

    it 'returns all phase params' do
      p0 = MiniTest::Mock.new
      nf = MiniTest::Mock.new
      p0.expect :phases, [{ type: 'QOS', length: 100 }, { type: 'CAN', length: 200 }, { type: 'MGT', length: 300 }, { type: 'NIL', length: 400 }]
      nf.expect :ports, [p0]

      Shower.new(nf).show(['PL', 'eth0', 'v_1']).must_equal 'QOS=100,CAN=200,MGT=300,NIL=400'

      p0.verify
      nf.verify
    end

    it 'returns the proper type value' do
      p0 = MiniTest::Mock.new
      nf = MiniTest::Mock.new
      2.times do
        p0.expect :type_map, { 'DSS' => 1, 'CAN' => 2, 'QOS' => 4, 'MGT' => 7 }
        nf.expect :ports, [p0]
      end

      Shower.new(nf).show(['PIH', 'eth0', 'v_1', 'CAN']).must_equal '010'
      Shower.new(nf).show(['PIH', 'eth0', 'v_1', 'QOS']).must_equal '100'

      p0.verify
      nf.verify
    end

    it 'returns all type values' do
      p0 = MiniTest::Mock.new
      nf = MiniTest::Mock.new
      p0.expect :type_map, { 'DSS' => 1, 'CAN' => 2, 'QOS' => 4, 'MGT' => 7 }
      nf.expect :ports, [p0]

      Shower.new(nf).show(['PIH', 'eth0', 'v_1']).must_equal 'DSS=001,CAN=010,QOS=100,MGT=111'

      p0.verify
      nf.verify
    end

    it 'returns the proper constant params' do
      Shower.new.show(['MTU',   'eth0', 'v_1']).must_equal 2048
      Shower.new.show(['ifgap', 'eth1', 'v_1']).must_equal 24
    end

    it 'warns on unhandled params' do
      nf = MiniTest::Mock.new.expect :ports, []
      -> { Shower.new(nf).show(['MACVLANT', 'eth0', 'v_1']) }.must_output '', "unhandled parameter: MACVLANT\n"
    end

    it 'warns on unknown params' do
      nf = MiniTest::Mock.new.expect :ports, []
      -> { Shower.new(nf).show(['foo', 'eth0', 'v_1']) }.must_output '', "unknown parameter: foo\n"
    end
  end
end end
