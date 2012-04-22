module Wiresnark module Stream
  def self.for name, pcap = nil
    streams[name] ||= begin
      pcap = Pcap if pcap.nil? and Process.uid.zero?
      if pcap.respond_to? :open_live
        stream = pcap.open_live name, 0xffff, true, 0
        stream.instance_eval { alias << inject }
        stream
      else
        []
      end
    end
  end

  private

  def self.streams
    @streams ||= {}
  end
end end
