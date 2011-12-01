module Wiresnark class NetFPGA::Port
  def initialize net_fpga, number
    @net_fpga = net_fpga
    @number   = number
  end

  def local_mac
    mac :local
  end

  def other_mac
    mac :other
  end

  private

  def mac locality
    hi = @net_fpga.get "MAC_RXTX_#{@number}_#{locality.upcase}_MAC_HI_REG"
    lo = @net_fpga.get "MAC_RXTX_#{@number}_#{locality.upcase}_MAC_LO_REG"
    ints = [(hi & 0xff00) >> 8, hi & 0xff, (lo & 0xff000000) >> 24, (lo & 0xff0000) >> 16, (lo & 0xff00) >> 8, lo & 0xff]
    ints.map { |i| i.to_s(16).rjust 2, '0'}.join ':'
  end
end end
