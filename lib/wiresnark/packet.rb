module Wiresnark class Packet

  TypeBytes = {
    'Eth' => '',
    'QoS' => "\x01",
    'CAN' => "\x02",
    'DSS' => "\x03",
    'MGT' => "\x04",
  }

  def initialize arg = Object.new.extend(DSL::PacketDSL)
    case arg
    when String
      @bin = arg
    else
      @bin = "\x00" * 6 + "\x00" * 6 + "\x08\x00" + "\x00" * 46

      self.destination_mac = arg.destination_mac if arg.destination_mac
      self.source_mac      = arg.source_mac      if arg.source_mac
      self.payload         = arg.payload         if arg.payload
    end
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

  def payload
    @bin[14..-1]
  end

  def payload= payload
    payload += "\x00" * (46 - payload.size) if payload.size < 46
    @bin[14..-1] = payload
  end

  def source_mac
    @bin[6..11].unpack('H2H2H2H2H2H2').join ':'
  end

  def source_mac= mac
    @bin[6..11] = mac.split(':').pack 'H2H2H2H2H2H2'
  end

  def to_bin
    @bin
  end

  def type
    TypeBytes.invert[@bin[14]] or 'Eth'
  end

end end
