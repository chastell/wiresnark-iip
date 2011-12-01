require_relative '../../spec_helper'

module Wiresnark describe NetFPGA::Port do
  describe '#local_mac' do
    it 'gets the local MAC address' do
      nf = Object.new
      def nf.get reg
        case reg
        when 'MAC_RXTX_0_LOCAL_MAC_HI_REG' then 0x0000ade3
        when 'MAC_RXTX_0_LOCAL_MAC_LO_REG' then 0x3ea42300
        end
      end
      port = NetFPGA::Port.new nf, 0
      port.local_mac.must_equal 'ad:e3:3e:a4:23:00'
    end
  end

  describe '#other_mac' do
    it 'gets the other MAC address' do
      nf = Object.new
      def nf.get reg
        case reg
        when 'MAC_RXTX_1_OTHER_MAC_HI_REG' then 0x0000a3a3
        when 'MAC_RXTX_1_OTHER_MAC_LO_REG' then 0x45233400
        end
      end
      port = NetFPGA::Port.new nf, 1
      port.other_mac.must_equal 'a3:a3:45:23:34:00'
    end
  end
end end
