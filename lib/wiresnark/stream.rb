module Wiresnark module Stream

  def self.for name, pcap
    pcap.open_live name, 0xffff, false, 0
  end

end end
