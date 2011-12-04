module Wiresnark class NetFPGA::Port
  def initialize net_fpga, number
    @net_fpga = net_fpga
    @number   = number
  end

  def local_mac
    get_mac 'LOCAL'
  end

  def local_mac= mac
    set_mac mac, 'LOCAL'
  end

  def other_mac
    get_mac 'OTHER'
  end

  def other_mac= mac
    set_mac mac, 'OTHER'
  end

  private

  def get_mac locality
    hi = @net_fpga.get "MAC_RXTX_#{@number}_#{locality}_MAC_HI_REG"
    lo = @net_fpga.get "MAC_RXTX_#{@number}_#{locality}_MAC_LO_REG"
    ints = [(hi & 0xff00) >> 8, hi & 0xff, (lo & 0xff000000) >> 24, (lo & 0xff0000) >> 16, (lo & 0xff00) >> 8, lo & 0xff]
    ints.map { |i| i.to_s(16).rjust 2, '0'}.join ':'
  end

  def set_mac mac, locality
    ints = mac.split(':').map { |hex| hex.to_i 16 }
    @net_fpga.set "MAC_RXTX_#{@number}_#{locality}_MAC_HI_REG", ints[0] << 8 | ints[1]
    @net_fpga.set "MAC_RXTX_#{@number}_#{locality}_MAC_LO_REG", ints[2] << 24 | ints[3] << 16 | ints[4] << 8 | ints[5]
  end
end end
