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
      self.type            = arg.type            if arg.type
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
    @bin[(14 + TypeBytes[type].size)..-1]
  end

  def payload= payload
    @bin[(14 + TypeBytes[type].size)..-1] = payload
    pad_if_needed
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

  def type= type
    TypeBytes[self.type].size.zero? ? @bin.insert(14, TypeBytes[type]) : @bin[14] = TypeBytes[type]
    pad_if_needed
  end

  private

  def pad_if_needed
    @bin << "\x00" * (60 - @bin.size) if @bin.size < 60
  end

end end
