require_relative '../../spec_helper'

module Wiresnark describe NetFPGA::Port do
  let :net_fpga do
    net_fpga = Object.new
    def net_fpga.get reg
      case reg
      when 'MAC_RXTX_0_LOCAL_MAC_HI_REG' then 0x0000ade3
      when 'MAC_RXTX_0_LOCAL_MAC_LO_REG' then 0x3ea42300
      when 'MAC_RXTX_1_OTHER_MAC_HI_REG' then 0x0000a3a3
      when 'MAC_RXTX_1_OTHER_MAC_LO_REG' then 0x45233400
      when 'SCHEDULER_2_NUM_PHASES_REG'  then 4
      when 'SCHEDULER_2_PH_1_LENGTH_REG' then 23
      when 'SCHEDULER_2_PH_2_LENGTH_REG' then 24
      when 'SCHEDULER_2_PH_3_LENGTH_REG' then 25
      when 'SCHEDULER_2_PH_4_LENGTH_REG' then 26
      when 'SCHEDULER_2_PH_1_TYPE_REG'   then 4
      when 'SCHEDULER_2_PH_2_TYPE_REG'   then 2
      when 'SCHEDULER_2_PH_3_TYPE_REG'   then 7
      when 'SCHEDULER_2_PH_4_TYPE_REG'   then 0
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
      net_fpga.expect :set, nil, ['MAC_RXTX_0_LOCAL_MAC_HI_REG', 0x0000ade3]
      net_fpga.expect :set, nil, ['MAC_RXTX_0_LOCAL_MAC_LO_REG', 0x3ea42300]
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
      net_fpga.expect :set, nil, ['MAC_RXTX_1_OTHER_MAC_HI_REG', 0x0000a3a3]
      net_fpga.expect :set, nil, ['MAC_RXTX_1_OTHER_MAC_LO_REG', 0x45233400]
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
  end

  describe '#phases=' do
    it 'sets the phases' do
      net_fpga = MiniTest::Mock.new
      net_fpga.expect :set, nil, ['SCHEDULER_3_NUM_PHASES_REG',  4]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_1_LENGTH_REG', 23]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_2_LENGTH_REG', 24]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_3_LENGTH_REG', 25]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_4_LENGTH_REG', 26]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_1_TYPE_REG',   4]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_2_TYPE_REG',   2]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_3_TYPE_REG',   7]
      net_fpga.expect :set, nil, ['SCHEDULER_3_PH_4_TYPE_REG',   0]
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
end end
