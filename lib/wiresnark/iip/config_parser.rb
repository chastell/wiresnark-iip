module Wiresnark module IIP class ConfigParser
  DefaultMAC   = '00:00:00:00:00:00'
  ValidBinary  = /\A[01]+\Z/
  ValidDecimal = /\A\d+\Z/
  ValidHex     = /\A0x\h\h\h\h\Z/
  ValidIface   = /\Aeth\d\Z/
  ValidMAC     = /\A\h\h(:\h\h){5}\Z/

  ValidFormats = {
    'Cyclelength'           => { text: -> text { text =~ ValidDecimal } },
    'MACDestinationAddress' => { text: -> text { text =~ ValidMAC     } },
    'MACSourceAddress'      => { text: -> text { text =~ ValidMAC     } },
    'MACType'               => { text: -> text { text =~ ValidHex     } },
    'NumberPhases'          => { text: -> text { text =~ ValidDecimal } },
    'PIH'                   => { text: -> text { text =~ ValidBinary  } },
    'PhaseLength'           => { text: -> text { text =~ ValidDecimal }, attr: { 'pi'   => -> pi   { TypeBytes.keys.include? pi } } },
    'interface'             => {                                         attr: { 'name' => -> name { name =~ ValidIface         } } },
  }

  def initialize path
    @xml = Nokogiri::XML File.read path
  end

  def parse
    Hash[@xml.xpath('/interfaces/interface').map do |interface|
      [interface.attr('name')[/\d$/].to_i, {
        ether_type: interface.at_xpath('v_port/MACType/text()').to_s.to_i(16),
        local:      mac_from_interface('MACSourceAddress', interface),
        other:      mac_from_interface('MACDestinationAddress', interface),
        phases:     phases_from_interface(interface),
        type_map:   type_map_from_interface(interface),
      }]
    end]
  end

  def warnings
    private_methods.grep(/^warn_/).map { |meth| send meth }.flatten.compact
  end

  private

  def mac_from_interface element, interface
    mac = interface.at_xpath("v_port/#{element}/text()").to_s
    mac =~ ValidMAC ? mac : DefaultMAC
  end

  def phases_from_interface interface
    interface.xpath('Scheduler[@type = "XenNet"]/PhaseLength').map { |p| { type: p.attr('pi'), length: p.text.to_i } }
  end

  def type_map_from_interface interface
    Hash[interface.xpath('v_port/pi').map do |pi|
      [pi.attr('type'), pi.at_xpath('PIH/text()').to_s.to_i(2)]
    end]
  end

  def warn_attrless_elements
    attr = { 'interface' => 'name', 'Scheduler' => 'type', 'PhaseLength' => 'pi' }
    @xml.xpath('//interface | //Scheduler | //PhaseLength').map do |element|
      "#{attr[element.name]}less #{element.name}" unless element.attr attr[element.name]
    end
  end

  def warn_cl_different_than_sum_of_pl
    @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      if scheduler.at_xpath 'Cyclelength'
        cl     = scheduler.at_xpath('Cyclelength/text()').to_s.to_i
        pl_sum = scheduler.xpath('PhaseLength/text()').map { |pl| pl.to_s.to_i }.inject :+
        "Cyclelength (#{cl}) =/= sum of PhaseLength (#{pl_sum})" unless cl == pl_sum
      end
    end
  end

  def warn_daf_different_than_macda
    @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      if v_port.at_xpath 'DestinationAddressfiltering'
        daf   = v_port.at_xpath('DestinationAddressfiltering/text()').to_s
        macda = v_port.at_xpath('MACDestinationAddress/text()').to_s
        "DestinationAddressfiltering (#{daf}) =/= MACDestinationAddress (#{macda})" unless daf == macda
      end
    end
  end

  def warn_ignored_elements_exist
    parsed = [
      'Cyclelength', 'DestinationAddressfiltering', 'MACDestinationAddress',
      'MACSourceAddress', 'MACType', 'NumberPhases', 'PIH', 'PhaseLength',
      'Scheduler', 'interface', 'interfaces', 'pi', 'v_port',
    ]
    (@xml.xpath('//*').map(&:name) - parsed).map { |element| "#{element} ignored" }
  end

  def warn_mac_is_missing
    @xml.xpath('/interfaces/interface/v_port').map do |v_port|
      ['MACDestinationAddress', 'MACSourceAddress'].map do |mac|
        "#{mac} set to #{DefaultMAC}" unless v_port.at_xpath mac
      end
    end
  end

  def warn_np_different_than_number_of_pl
    @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]').map do |scheduler|
      if scheduler.at_xpath 'NumberPhases'
        np     = scheduler.at_xpath('NumberPhases/text()').to_s.to_i
        pl_num = scheduler.xpath('PhaseLength').size
        "NumberPhases (#{np}) =/= number of PhaseLengths (#{pl_num})" unless np == pl_num
      end
    end
  end

  def warn_pl_will_be_rounded
    @xml.xpath('/interfaces/interface/Scheduler[@type = "XenNet"]/PhaseLength/text()').map do |pl|
      pl      = pl.to_s.to_i
      rounded = pl / NetFPGA::Port::LengthUnit * NetFPGA::Port::LengthUnit
      "PhaseLength of #{pl} ns will be rounded to #{rounded} ns" unless pl == rounded
    end
  end

  # FIXME: TOO MUCH CLEVER
  def warn_wrong_formats
    ValidFormats.map do |name, hash|
      @xml.xpath("//#{name}").map do |element|
        hash.map do |key, value|
          case key
          when :text
            "bad #{name}: #{element.text}" unless value.call element.text
          when :attr
            value.map do |attr, validator|
              "bad #{name} #{attr}: #{element.attr attr}" unless validator.call element.attr attr
            end
          end
        end
      end
    end
  end
end end end
