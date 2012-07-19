# encoding: UTF-8

require_relative '../../spec_helper'

module Wiresnark::IIP describe NetFPGA do
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
          type_map: { 'CAN' => 2, 'MGT' => 7 },
        },
        1 => {
          ether_type: 0,
          local: 'ad:e3:3e:b4:23:aa',
          other: 'a3:aa:45:23:34:aa',
          phases: [],
          type_map: {},
        },
      }

      regbridge = MiniTest::Mock.new

      # port 0, EtherType
      regbridge.expect :set_register, nil, [0x2000010, 0xabcd]

      # port 0, local MAC
      regbridge.expect :set_register, nil, [0x2000000, 0x0000ade3]
      regbridge.expect :set_register, nil, [0x2000004, 0x3ea423aa]

      # port 0, other MAC
      regbridge.expect :set_register, nil, [0x2000008, 0x0000a3a3]
      regbridge.expect :set_register, nil, [0x200000c, 0x452334aa]

      # port 0, number of phases
      regbridge.expect :set_register, nil, [0x200002c, 5]

      # port 0, phase types + lenghts
      regbridge.expect :set_register, nil, [0x2000050, 1]
      regbridge.expect :set_register, nil, [0x2000030, 23]

      regbridge.expect :set_register, nil, [0x2000054, 2]
      regbridge.expect :set_register, nil, [0x2000034, 24]

      regbridge.expect :set_register, nil, [0x2000058, 3]
      regbridge.expect :set_register, nil, [0x2000038, 25]

      regbridge.expect :set_register, nil, [0x200005c, 4]
      regbridge.expect :set_register, nil, [0x200003c, 26]

      regbridge.expect :set_register, nil, [0x2000060, 0]
      regbridge.expect :set_register, nil, [0x2000040, 27]

      # port 0, type map
      regbridge.expect :set_register, nil, [0x2000020, 2]
      regbridge.expect :set_register, nil, [0x2000028, 7]

      # port 1, EtherType
      regbridge.expect :set_register, nil, [0x2000110, 0]

      # port 1, local MAC
      regbridge.expect :set_register, nil, [0x2000100, 0x0000ade3]
      regbridge.expect :set_register, nil, [0x2000104, 0x3eb423aa]

      # port 1, other MAC
      regbridge.expect :set_register, nil, [0x2000108, 0x0000a3aa]
      regbridge.expect :set_register, nil, [0x200010c, 0x452334aa]

      # port 1, number of phases
      regbridge.expect :set_register, nil, [0x200012c, 0]

      nf = NetFPGA.new regbridge
      nf.config = config

      regbridge.verify
    end
  end

  describe '#get' do
    it 'gets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :get_register, 7, [0x200002c]
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
      nf.registers['PORT_0_NUM_PHASES_REG'].must_equal 0x200002c
    end
  end

  describe '#set' do
    it 'sets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :set_register, nil, [0x200002c, 7]
      nf = NetFPGA.new regbridge
      nf.set 'PORT_0_NUM_PHASES_REG', 7
      regbridge.verify
    end
  end
end end
