module Wiresnark class Interface

  def self.new name
    @interfaces       ||= {}
    @interfaces[name] ||= super
  end

  def initialize name
    @name = name
    @stream = Stream.for name
  end

  def inject packets, output = nil, stream = @stream
    packets.each do |packet|
      output.puts "\t-> #{@name}\t#{packet}" if output
      stream.inject packet.to_bin
    end
  end

end end
