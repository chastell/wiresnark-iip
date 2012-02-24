# encoding: UTF-8

require_relative '../spec_helper'

module Wiresnark describe NetFPGA do
  describe '#config=' do
    it 'sets the card’s configuration' do
      config = {
        0 => {
          ether_type: 0xabcd,
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
          ether_type: 0,
          local: 'ad:e3:3e:b4:23:aa',
          other: 'a3:aa:45:23:34:aa',
          phases: [],
        },
      }

      regbridge = MiniTest::Mock.new

      # port 0, EtherType
      regbridge.expect :set_register, nil, [0x2000110, 0xabcd]

      # port 0, local MAC
      regbridge.expect :set_register, nil, [0x2000100, 0x0000ade3]
      regbridge.expect :set_register, nil, [0x2000104, 0x3ea423aa]

      # port 0, other MAC
      regbridge.expect :set_register, nil, [0x2000108, 0x0000a3a3]
      regbridge.expect :set_register, nil, [0x200010c, 0x452334aa]

      # port 0, number of phases
      regbridge.expect :set_register, nil, [0x200012c, 5]

      # port 0, phase types + lenghts
      regbridge.expect :set_register, nil, [0x2000150, 4]
      regbridge.expect :set_register, nil, [0x2000130, 23]

      regbridge.expect :set_register, nil, [0x2000154, 2]
      regbridge.expect :set_register, nil, [0x2000134, 24]

      regbridge.expect :set_register, nil, [0x2000158, 1]
      regbridge.expect :set_register, nil, [0x2000138, 25]

      regbridge.expect :set_register, nil, [0x200015c, 7]
      regbridge.expect :set_register, nil, [0x200013c, 26]

      regbridge.expect :set_register, nil, [0x2000160, 0]
      regbridge.expect :set_register, nil, [0x2000140, 27]

      # port 1, EtherType
      regbridge.expect :set_register, nil, [0x2000210, 0]

      # port 1, local MAC
      regbridge.expect :set_register, nil, [0x2000200, 0x0000ade3]
      regbridge.expect :set_register, nil, [0x2000204, 0x3eb423aa]

      # port 1, other MAC
      regbridge.expect :set_register, nil, [0x2000208, 0x0000a3aa]
      regbridge.expect :set_register, nil, [0x200020c, 0x452334aa]

      # port 1, number of phases
      regbridge.expect :set_register, nil, [0x200022c, 0]

      nf = NetFPGA.new regbridge
      nf.config = config

      regbridge.verify
    end
  end

  describe '#get' do
    it 'gets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :get_register, 7, [0x200012c]
      nf = NetFPGA.new regbridge
      nf.get('PORT_0_NUM_PHASES_REG').must_equal 7
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
      nf.registers['PORT_0_NUM_PHASES_REG'].must_equal 0x200012c
    end
  end

  describe '#set' do
    it 'sets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :set_register, nil, [0x200012c, 7]
      nf = NetFPGA.new regbridge
      nf.set 'PORT_0_NUM_PHASES_REG', 7
      regbridge.verify
    end
  end
end end
