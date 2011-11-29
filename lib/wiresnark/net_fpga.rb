module Wiresnark class NetFPGA
  attr_reader :registers

  def initialize reg_path, regbridge = nil
    @regbridge = regbridge
    @registers = RegParser.parse reg_path
  end

  def get register
    @regbridge.get @registers[register]
  end

  def mac i, locality
    hi = get "MAC_RXTX_#{i}_#{locality.upcase}_MAC_HI_REG"
    lo = get "MAC_RXTX_#{i}_#{locality.upcase}_MAC_LO_REG"
    ints = [(hi & 0xff00) >> 8, hi & 0xff, (lo & 0xff000000) >> 24, (lo & 0xff0000) >> 16, (lo & 0xff00) >> 8, lo & 0xff]
    ints.map { |i| i.to_s(16).rjust 2, '0'}.join ':'
  end

  def mac_set i, locality, mac
    ints = mac.split(':').map { |hex| hex.to_i 16 }
    set "MAC_RXTX_#{i}_#{locality.upcase}_MAC_HI_REG", ints[0] << 8 | ints[1]
    set "MAC_RXTX_#{i}_#{locality.upcase}_MAC_LO_REG", ints[2] << 24 | ints[3] << 16 | ints[4] << 8 | ints[5]
  end

  def set register, value
    @regbridge.set @registers[register], value
  end
end end
