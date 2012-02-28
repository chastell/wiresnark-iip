# encoding: UTF-8

require_relative '../../spec_helper'

module Wiresnark describe NetFPGA::Port do
  let :net_fpga do
    net_fpga = Object.new
    def net_fpga.get reg
      case reg
      when 'PORT_0_LOCAL_MAC_HI_REG' then 0x0000ade3
      when 'PORT_0_LOCAL_MAC_LO_REG' then 0x3ea42300
      when 'PORT_1_OTHER_MAC_HI_REG' then 0x0000a3a3
      when 'PORT_1_OTHER_MAC_LO_REG' then 0x45233400
      when 'PORT_1_PIH_DSS_REG'      then 1
      when 'PORT_1_PIH_CAN_REG'      then 2
      when 'PORT_1_PIH_QOS_REG'      then 4
      when 'PORT_1_PIH_MGT_REG'      then 7
      when 'PORT_2_ETHER_TYPE_REG'   then 0x86dd
      when 'PORT_2_NUM_PHASES_REG'   then 4
      when 'PORT_2_PH_0_LENGTH_REG'  then 23
      when 'PORT_2_PH_1_LENGTH_REG'  then 24
      when 'PORT_2_PH_2_LENGTH_REG'  then 25
      when 'PORT_2_PH_3_LENGTH_REG'  then 26
      when 'PORT_2_PH_0_TYPE_REG'    then 4
      when 'PORT_2_PH_1_TYPE_REG'    then 2
      when 'PORT_2_PH_2_TYPE_REG'    then 7
      when 'PORT_2_PH_3_TYPE_REG'    then 0
      when 'PORT_3_ETHER_TYPE_REG'   then 0xdeadbeef
      when 'PORT_3_NUM_PHASES_REG'   then 0xdeadbeef
      when 'PORT_3_PIH_DSS_REG'      then 0xdeadbeef
      end
    end
    net_fpga
  end

  describe '#cycle_length' do
    it 'returns the length of the cycle' do
      port = NetFPGA::Port.new net_fpga, 2
      port.cycle_length.must_equal 784
    end
  end

  describe '#ether_type' do
    it 'returns the EtherType' do
      NetFPGA::Port.new(net_fpga, 2).ether_type.must_equal 0x86dd
    end

    it 'zeroes the EtherType if it would be more than 0xffff' do
      NetFPGA::Port.new(net_fpga, 3).ether_type.must_be :zero?
    end
  end

  describe '#ether_type=' do
    it 'sets the EtherType' do
      net_fpga = MiniTest::Mock.new
      net_fpga.expect :set, nil, ['PORT_0_ETHER_TYPE_REG', 0x86dd]
      port = NetFPGA::Port.new net_fpga, 0
      port.ether_type = 0x86dd
      net_fpga.verify
    end
  end

  describe '#ifgap' do
    it 'returns the ifgap size' do
      port = NetFPGA::Port.new NetFPGA.new, 0
      port.ifgap.must_equal 24
    end
  end

  describe '#local_mac' do
    it 'gets the local MAC address' do
      port = NetFPGA::Port.new net_fpga, 0
      port.local_mac.must_equal 'ad:e3:3e:a4:23:00'
    end
  end

  describe '#local_mac=' do
    it 'sets the local MAC address' do
      net_fpga = MiniTest::Mock.new
      net_fpga.expect :set, nil, ['PORT_0_LOCAL_MAC_HI_REG', 0x0000ade3]
      net_fpga.expect :set, nil, ['PORT_0_LOCAL_MAC_LO_REG', 0x3ea42300]
      port = NetFPGA::Port.new net_fpga, 0
      port.local_mac = 'ad:e3:3e:a4:23:00'
      net_fpga.verify
    end
  end

  describe '#mtu' do
    it 'returns the MTU size' do
      port = NetFPGA::Port.new NetFPGA.new, 0
      port.mtu.must_equal 2048
    end
  end

  describe '#other_mac' do
    it 'gets the other MAC address' do
      port = NetFPGA::Port.new net_fpga, 1
      port.other_mac.must_equal 'a3:a3:45:23:34:00'
    end
  end

  describe '#other_mac=' do
    it 'sets the other MAC address' do
      net_fpga = MiniTest::Mock.new
      net_fpga.expect :set, nil, ['PORT_1_OTHER_MAC_HI_REG', 0x0000a3a3]
      net_fpga.expect :set, nil, ['PORT_1_OTHER_MAC_LO_REG', 0x45233400]
      port = NetFPGA::Port.new net_fpga, 1
      port.other_mac = 'a3:a3:45:23:34:00'
      net_fpga.verify
    end
  end

  describe '#phase_number' do
    it 'returns the number of phases' do
      port = NetFPGA::Port.new net_fpga, 2
      port.phase_number.must_equal 4
    end

    it 'defaults to 0 if it’s more than 8' do
      port = NetFPGA::Port.new net_fpga, 3
      port.phase_number.must_be :zero?
    end
  end

  describe '#phases' do
    it 'gets the phases' do
      port = NetFPGA::Port.new net_fpga, 2
      port.phases.must_equal [
        { type: 'QOS', length: 184 },
        { type: 'CAN', length: 192 },
        { type: 'MGT', length: 200 },
        { type: 'NIL', length: 208 },
      ]
    end

    it 'does not raise on uninitialised NetFPGA' do
      port = NetFPGA::Port.new net_fpga, 3
      port.phases
    end
  end

  describe '#phases=' do
    it 'sets the phases' do
      net_fpga = MiniTest::Mock.new
      net_fpga.expect :set, nil, ['PORT_3_NUM_PHASES_REG',  4]
      net_fpga.expect :set, nil, ['PORT_3_PH_0_LENGTH_REG', 23]
      net_fpga.expect :set, nil, ['PORT_3_PH_1_LENGTH_REG', 24]
      net_fpga.expect :set, nil, ['PORT_3_PH_2_LENGTH_REG', 25]
      net_fpga.expect :set, nil, ['PORT_3_PH_3_LENGTH_REG', 26]
      net_fpga.expect :set, nil, ['PORT_3_PH_0_TYPE_REG',   4]
      net_fpga.expect :set, nil, ['PORT_3_PH_1_TYPE_REG',   2]
      net_fpga.expect :set, nil, ['PORT_3_PH_2_TYPE_REG',   7]
      net_fpga.expect :set, nil, ['PORT_3_PH_3_TYPE_REG',   0]
      port = NetFPGA::Port.new net_fpga, 3
      port.phases = [
        { type: 'QOS', length: 184 },
        { type: 'CAN', length: 192 },
        { type: 'MGT', length: 200 },
        { type: 'NIL', length: 208 },
      ]
      net_fpga.verify
    end
  end

  describe '#type_map' do
    it 'gets the type map' do
      NetFPGA::Port.new(net_fpga, 1).type_map.must_equal({
        'DSS' => 1, 'CAN' => 2, 'QOS' => 4, 'MGT' => 7,
      })
    end

    it 'zeroes unset type values and ones larger than 0xff' do
      NetFPGA::Port.new(net_fpga, 3).type_map.must_equal({
        'DSS' => 0, 'CAN' => 0, 'QOS' => 0, 'MGT' => 0,
      })
    end
  end

  describe '#type_map=' do
    it 'sets the type map' do
      net_fpga = MiniTest::Mock.new
      net_fpga.expect :set, nil, ['PORT_1_PIH_CAN_REG', 2]
      net_fpga.expect :set, nil, ['PORT_1_PIH_MGT_REG', 7]
      port = NetFPGA::Port.new net_fpga, 1
      port.type_map = { 'CAN' => 2, 'MGT' => 7 }
      net_fpga.verify
    end
  end
end end
