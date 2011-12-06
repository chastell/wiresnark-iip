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
      when 'SCHEDULER_0_NUM_PHASES_REG'  then 4
      end
    end
    net_fpga
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

  describe '#number_of_phases' do
    it 'gets the number of phases' do
      port = NetFPGA::Port.new net_fpga, 0
      port.number_of_phases.must_equal 4
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
end end
