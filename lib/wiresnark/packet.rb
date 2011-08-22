module Wiresnark class Packet

  def initialize arg = Object.new.extend(DSL::PacketDSL)
    @bin = "\x00" * 6 + "\x00" * 6 + "\x08\x00" + "\x00" * 46

    self.destination_mac = arg.destination_mac if arg.destination_mac
    self.source_mac      = arg.source_mac      if arg.source_mac
    self.payload         = arg.payload         if arg.payload
  end

  def == other
    to_bin == other.to_bin
  end

  def destination_mac
    @bin[0..5].unpack('H2H2H2H2H2H2').join ':'
  end

  def destination_mac= mac
    @bin[0..5] = mac.split(':').pack 'H2H2H2H2H2H2'
  end

  def payload= payload
    payload += "\x00" * (46 - payload.size) if payload.size < 46
    @bin[14..-1] = payload
  end

  def source_mac= mac
    @bin[6..11] = mac.split(':').pack 'H2H2H2H2H2H2'
  end

  def to_bin
    @bin
  end

end end
