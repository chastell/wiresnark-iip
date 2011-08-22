module Wiresnark class Packet

  def initialize
    @bin = "\x00" * 6 + "\x00" * 6 + "\x08\x00" + "\x00" * 46
  end

  def == other
    to_bin == other.to_bin
  end

  def destination_mac= mac
    @bin[0..5] = mac.split(':').pack 'H2H2H2H2H2H2'
  end

  def to_bin
    @bin
  end

end end
