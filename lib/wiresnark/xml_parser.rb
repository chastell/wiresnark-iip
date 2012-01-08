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
      'DestinationAddressfiltering', 'MACDestinationAddress', 'MACSourceAddress',
      'Cyclelength', 'NumberPhases', 'PhaseLength',
    ]

    warnings = @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      daf   = v_port.at_xpath('DestinationAddressfiltering').text
      macda = v_port.at_xpath('MACDestinationAddress').text
      "DestinationAddressfiltering (#{daf}) =/= MACDestinationAddress (#{macda})" unless daf == macda
    end

    warnings += @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      cl     = scheduler.at_xpath('Cyclelength').text.to_i
      pl_sum = scheduler.xpath('PhaseLength').map { |pl| pl.text.to_i }.inject :+
      "Cyclelength (#{cl}) =/= sum of PhaseLength (#{pl_sum})" unless cl == pl_sum
    end

    warnings += @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      np     = scheduler.at_xpath('NumberPhases').text.to_i
      pl_num = scheduler.xpath('PhaseLength').size
      "NumberPhases (#{np}) =/= number of PhaseLengths (#{pl_num})" unless np == pl_num
    end

    {
      ignored:  (@xml.xpath('//*').map(&:name) - parsed).uniq.sort,
      warnings: warnings.compact,
    }
  end
end end
