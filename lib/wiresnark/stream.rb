module Wiresnark module Stream

  def self.for name, pcap = nil
    pcap.respond_to?(:open_live) ? pcap.open_live(name, 0xffff, false, 0) : []
  end

end end
