module Wiresnark class Packet

  def initialize
    @bin = "\x00" * 6 + "\x00" * 6 + "\x08\x00" + "\x00" * 46
  end

  def to_bin
    @bin
  end

end end
