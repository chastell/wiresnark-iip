module Wiresnark class Interface

  def self.new name, pcap = nil
    @interfaces       ||= {}
    @interfaces[name] ||= super
  end

  def initialize name, pcap
    @stream = pcap.open_live(name, 0xffff, true, 0) if pcap.respond_to? :open_live
  end

  def inject packets
    packets.each do |packet|
      @stream.inject packet.to_bin
    end
  end

end end
