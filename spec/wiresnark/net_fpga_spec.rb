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
      regbridge.expect :set_register, nil, [0x2000000, 0x0000ade3]
      regbridge.expect :set_register, nil, [0x2000004, 0x3ea423aa]
      regbridge.expect :set_register, nil, [0x2000008, 0x0000a3a3]
      regbridge.expect :set_register, nil, [0x200000c, 0x452334aa]
      regbridge.expect :set_register, nil, [0x2000040, 0x0000ade3]
      regbridge.expect :set_register, nil, [0x2000044, 0x3eb423aa]
      regbridge.expect :set_register, nil, [0x2000048, 0x0000a3aa]
      regbridge.expect :set_register, nil, [0x200004c, 0x452334aa]
      regbridge.expect :set_register, nil, [0x2000100, 5]
      regbridge.expect :set_register, nil, [0x2000104, 23]
      regbridge.expect :set_register, nil, [0x2000108, 24]
      regbridge.expect :set_register, nil, [0x200010c, 25]
      regbridge.expect :set_register, nil, [0x2000110, 26]
      regbridge.expect :set_register, nil, [0x2000114, 27]
      regbridge.expect :set_register, nil, [0x2000124, 4]
      regbridge.expect :set_register, nil, [0x2000128, 2]
      regbridge.expect :set_register, nil, [0x200012c, 1]
      regbridge.expect :set_register, nil, [0x2000130, 7]
      regbridge.expect :set_register, nil, [0x2000134, 0]
      regbridge.expect :set_register, nil, [0x2000180, 0]
      nf = NetFPGA.new regbridge
      nf.config = config

      regbridge.verify
    end
  end

  describe '#get' do
    it 'gets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :get_register, 7, [0x2000100]
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
      nf.registers['SCHEDULER_0_NUM_PHASES_REG'].must_equal 0x2000100
    end
  end

  describe '#set' do
    it 'sets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :set_register, nil, [0x2000100, 7]
      nf = NetFPGA.new regbridge
      nf.set 'SCHEDULER_0_NUM_PHASES_REG', 7
      regbridge.verify
    end
  end
end end
