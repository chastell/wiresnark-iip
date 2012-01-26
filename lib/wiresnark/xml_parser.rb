module Wiresnark class XMLParser
  ValidIface  = /\Aeth\d\Z/
  ValidMAC    = /\A\h\h(:\h\h){5}\Z/
  ValidNumber = /\A\d+\Z/

  def initialize path
    @xml = Nokogiri::XML File.read path
  end

  def parse
    Hash[@xml.xpath('/interfaces/interface').map do |interface|
      macsa = interface.at_xpath('v_port/MACSourceAddress/text()').to_s
      macda = interface.at_xpath('v_port/MACDestinationAddress/text()').to_s
      local = macsa =~ ValidMAC ? macsa : '00:00:00:00:00:00'
      other = macda =~ ValidMAC ? macda : '00:00:00:00:00:00'

      phases = interface.xpath('Scheduler/PhaseLength').map { |p| { type: p.attr('pi'), length: p.text.to_i } }
      [interface.attr('name').chars.to_a.last.to_i, { local: local, other: other, phases: phases }]
    end]
  end

  def warnings
    warnings = private_methods.grep(/^warn_/).map do |method|
      send method
    end.flatten.compact
  end

  private

  def warn_daf_macda
    @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      if v_port.at_xpath 'DestinationAddressfiltering'
        daf   = v_port.at_xpath('DestinationAddressfiltering').text
        macda = v_port.at_xpath('MACDestinationAddress').text
        "DestinationAddressfiltering (#{daf}) =/= MACDestinationAddress (#{macda})" unless daf == macda
      end
    end
  end

  def warn_cl_sum_of_pl
    @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      if scheduler.at_xpath 'Cyclelength'
        cl     = scheduler.at_xpath('Cyclelength').text.to_i
        pl_sum = scheduler.xpath('PhaseLength').map { |pl| pl.text.to_i }.inject :+
        "Cyclelength (#{cl}) =/= sum of PhaseLength (#{pl_sum})" unless cl == pl_sum
      end
    end
  end

  def warn_iface_format
    @xml.xpath('//interface').map do |iface|
      "bad interface name: #{iface.attr 'name'}" unless iface.attr('name') =~ ValidIface
    end
  end

  def warn_ignored
    parsed = [
      'interfaces', 'interface', 'v_port', 'Scheduler',
      'DestinationAddressfiltering', 'MACDestinationAddress', 'MACSourceAddress',
      'Cyclelength', 'NumberPhases', 'PhaseLength',
    ]
    (@xml.xpath('//*').map(&:name) - parsed).map { |w| "#{w} ignored" }
  end

  def warn_mac_format
    @xml.xpath('//MACDestinationAddress | //MACSourceAddress').map do |element|
      "bad #{element.name}: #{element.text}" unless element.text =~ ValidMAC
    end
  end

  def warn_macda_missing
    @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      'MACDestinationAddress set to 00:00:00:00:00:00' unless v_port.at_xpath 'MACDestinationAddress'
    end
  end

  def warn_macsa_missing
    @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      'MACSourceAddress set to 00:00:00:00:00:00' unless v_port.at_xpath 'MACSourceAddress'
    end
  end

  def warn_np_number_of_pl
    @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      if scheduler.at_xpath 'NumberPhases'
        np     = scheduler.at_xpath('NumberPhases').text.to_i
        pl_num = scheduler.xpath('PhaseLength').size
        "NumberPhases (#{np}) =/= number of PhaseLengths (#{pl_num})" unless np == pl_num
      end
    end
  end

  def warn_number_format
    @xml.xpath('//Cyclelength | //NumberPhases | //PhaseLength').map do |element|
      "bad #{element.name}: #{element.text}" unless element.text =~ ValidNumber
    end
  end

  def warn_pi_format
    @xml.xpath('//PhaseLength').map do |pl|
      "bad PhaseLength pi: #{pl.attr 'pi'}" unless TypeBytes.keys.include? pl.attr 'pi'
    end
  end

  def warn_pl_rounding
    @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]/PhaseLength').map do |pl|
      pl      = pl.text.to_i
      rounded = pl / NetFPGA::Port::LengthUnit * NetFPGA::Port::LengthUnit
      "PhaseLength of #{pl} ns will be rounded to #{rounded} ns" unless pl == rounded
    end
  end
end end
