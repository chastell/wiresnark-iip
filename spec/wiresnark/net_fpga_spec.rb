# encoding: UTF-8

require_relative '../spec_helper'

module Wiresnark describe NetFPGA do
  describe '#config=' do
    it 'sets the card’s configuration' do
      config = {
        0 => {
          local: 'ad:e3:3e:a4:23:aa',
          other: 'a3:a3:45:23:34:aa',
          phases: [
            { type: 'QOS', length: 184 },
            { type: 'CAN', length: 192 },
            { type: 'DSS', length: 200 },
            { type: 'MGT', length: 208 },
            { type: 'NIL', length: 216 },
          ],
        },
        1 => {
          local: 'ad:e3:3e:b4:23:aa',
          other: 'a3:aa:45:23:34:aa',
          phases: [],
        },
      }

      regbridge = MiniTest::Mock.new
      regbridge.expect :set, nil, [0x2000100, 0x0000ade3]
      regbridge.expect :set, nil, [0x200014c, 0x45233400]
      regbridge.expect :set, nil, [0x2000200, 4]
      regbridge.expect :set, nil, [0x2000208, 24]
      regbridge.expect :set, nil, [0x2000234, 0]
      nf = NetFPGA.new regbridge
      nf.config = config

      regbridge.verify
    end
  end

  describe '#get' do
    it 'gets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :get, 7, [0x2000200]
      nf = NetFPGA.new regbridge
      nf.get('SCHEDULER_0_NUM_PHASES_REG').must_equal 7
      regbridge.verify
    end
  end

  describe '#ports' do
    it 'returns the four NetFPGA’s ports' do
      nf = NetFPGA.new
      nf.ports.size.must_equal 4
      nf.ports.each { |p| p.must_be_instance_of NetFPGA::Port }
    end
  end

  describe '#registers' do
    it 'returns the given NetFPGA’s register map' do
      nf = NetFPGA.new
      nf.registers['SCHEDULER_0_NUM_PHASES_REG'].must_equal 0x2000200
    end
  end

  describe '#set' do
    it 'sets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :set, nil, [0x2000200, 7]
      nf = NetFPGA.new regbridge
      nf.set 'SCHEDULER_0_NUM_PHASES_REG', 7
      regbridge.verify
    end
  end
end end
