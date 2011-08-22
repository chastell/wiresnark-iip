module Wiresnark class Interface

  def self.new name
    @interfaces       ||= {}
    @interfaces[name] ||= super
  end

  def initialize name
    @stream = Stream.for name
  end

  def inject packets, stream
    packets.each do |packet|
      stream.inject packet.to_bin
    end
  end

end end
