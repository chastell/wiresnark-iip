module Wiresnark class XMLParser
  def initialize path
    @xml = Nokogiri::XML File.read path
  end

  def parse
    Hash[@xml.xpath('/interfaces/interface').map do |interface|
      local = interface.at_xpath('v_port/MACSourceAddress').text
      other = interface.at_xpath('v_port/MACDestinationAddress').text

      phases = interface.xpath('Scheduler/PhaseLength').map { |p| { type: p.attr('pi'), length: p.text.to_i } }
      [interface.attr('name').chars.to_a.last.to_i, { local: local, other: other, phases: phases }]
    end]
  end

  def verify
    parsed = [
      'interfaces', 'interface', 'v_port', 'Scheduler',
      'MACDestinationAddress', 'MACSourceAddress',
      'Cyclelength', 'NumberPhases', 'PhaseLength',
    ]

    warnings = @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      daf   = v_port.at_xpath('DestinationAddressfiltering').text
      macda = v_port.at_xpath('MACDestinationAddress').text
      "DestinationAddressfiltering (#{daf}) =/= MACDestinationAddress (#{macda})" unless daf == macda
    end.compact

    {
      ignored:  (@xml.xpath('//*').map(&:name) - parsed).uniq.sort,
      warnings: warnings,
    }
  end
end end
