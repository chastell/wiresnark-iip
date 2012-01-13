module Wiresnark class XMLParser
  def initialize path
    @xml = Nokogiri::XML File.read path
  end

  def parse
    Hash[@xml.xpath('/interfaces/interface').map do |interface|
      macsa = interface.at_xpath 'v_port/MACSourceAddress'
      macda = interface.at_xpath 'v_port/MACDestinationAddress'
      local = macsa ? macsa.text : '00:00:00:00:00:00'
      other = macda ? macda.text : '00:00:00:00:00:00'

      phases = interface.xpath('Scheduler/PhaseLength').map { |p| { type: p.attr('pi'), length: p.text.to_i } }
      [interface.attr('name').chars.to_a.last.to_i, { local: local, other: other, phases: phases }]
    end]
  end

  def warnings
    parsed = [
      'interfaces', 'interface', 'v_port', 'Scheduler',
      'DestinationAddressfiltering', 'MACDestinationAddress', 'MACSourceAddress',
      'Cyclelength', 'NumberPhases', 'PhaseLength',
    ]

    warnings = (@xml.xpath('//*').map(&:name) - parsed).map { |w| "#{w} ignored" }

    warnings += @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      if v_port.at_xpath 'DestinationAddressfiltering'
        daf   = v_port.at_xpath('DestinationAddressfiltering').text
        macda = v_port.at_xpath('MACDestinationAddress').text
        "DestinationAddressfiltering (#{daf}) =/= MACDestinationAddress (#{macda})" unless daf == macda
      end
    end

    warnings += @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      'MACSourceAddress set to 00:00:00:00:00:00' unless v_port.at_xpath 'MACSourceAddress'
    end

    warnings += @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      'MACDestinationAddress set to 00:00:00:00:00:00' unless v_port.at_xpath 'MACDestinationAddress'
    end

    warnings += @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      if scheduler.at_xpath 'Cyclelength'
        cl     = scheduler.at_xpath('Cyclelength').text.to_i
        pl_sum = scheduler.xpath('PhaseLength').map { |pl| pl.text.to_i }.inject :+
        "Cyclelength (#{cl}) =/= sum of PhaseLength (#{pl_sum})" unless cl == pl_sum
      end
    end

    warnings += @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      if scheduler.at_xpath 'NumberPhases'
        np     = scheduler.at_xpath('NumberPhases').text.to_i
        pl_num = scheduler.xpath('PhaseLength').size
        "NumberPhases (#{np}) =/= number of PhaseLengths (#{pl_num})" unless np == pl_num
      end
    end

    warnings += @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]/PhaseLength').map do |pl|
      pl      = pl.text.to_i
      rounded = pl / NetFPGA::Port::LengthUnit * NetFPGA::Port::LengthUnit
      "PhaseLength of #{pl} ns will be rounded to #{rounded} ns" unless pl == rounded
    end

    warnings.compact
  end
end end
