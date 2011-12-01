module Wiresnark class NetFPGA::Port
  def initialize net_fpga, number
    @net_fpga = net_fpga
    @number   = number
  end

  def local_mac
    hi = @net_fpga.get "MAC_RXTX_#{@number}_LOCAL_MAC_HI_REG"
    lo = @net_fpga.get "MAC_RXTX_#{@number}_LOCAL_MAC_LO_REG"
    ints = [(hi & 0xff00) >> 8, hi & 0xff, (lo & 0xff000000) >> 24, (lo & 0xff0000) >> 16, (lo & 0xff00) >> 8, lo & 0xff]
    ints.map { |i| i.to_s(16).rjust 2, '0'}.join ':'
  end

  def other_mac
    hi = @net_fpga.get "MAC_RXTX_#{@number}_OTHER_MAC_HI_REG"
    lo = @net_fpga.get "MAC_RXTX_#{@number}_OTHER_MAC_LO_REG"
    ints = [(hi & 0xff00) >> 8, hi & 0xff, (lo & 0xff000000) >> 24, (lo & 0xff0000) >> 16, (lo & 0xff00) >> 8, lo & 0xff]
    ints.map { |i| i.to_s(16).rjust 2, '0'}.join ':'
  end
end end
