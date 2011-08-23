module Wiresnark class Interface

  def self.new name, stream = nil
    @interfaces       ||= {}
    @interfaces[name] ||= super
  end

  def initialize name, stream
    @name = name
    @stream = stream || Stream.for(name)
  end

  def inject packets, output = nil
    packets.each do |packet|
      output.puts "-> #{@name}\t#{packet}" if output
      @stream << packet.to_bin
    end
  end

end end
