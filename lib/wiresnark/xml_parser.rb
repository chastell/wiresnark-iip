module Wiresnark module XMLParser
  def self.parse path
    Hash[Nokogiri::XML(File.read path).xpath('/interfaces/interface').map do |interface|
      local = interface.xpath('v_port/MACSourceAddress').first.text
      other = interface.xpath('v_port/MACDestinationAddress').first.text

      phases = interface.xpath('Scheduler/PhaseLength').map { |p| { type: p.attr('pi'), length: p.text.to_i } }
      [interface.attr('name'), { local: local, other: other, phases: phases }]
    end]
  end
end end
