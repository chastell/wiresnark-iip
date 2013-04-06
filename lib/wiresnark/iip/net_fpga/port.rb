module Wiresnark::IIP class NetFPGA::Port
  LengthUnit = 8
  PhaseTypes = { 0 => 'NIL', 1 => 'QOS', 2 => 'CAN', 3 => 'DSS', 4 => 'MGT' }

  def initialize net_fpga, port
    @net_fpga = net_fpga
    @port     = port
  end

  def cycle_length
    phases.map { |p| p[:length] }.reduce :+
  end

  def ether_type
    ether_type = net_fpga.get "PORT_#{port}_ETHER_TYPE_REG"
    ether_type > 0xffff ? 0 : ether_type
  end

  def ether_type= ether_type
    net_fpga.set "PORT_#{port}_ETHER_TYPE_REG", ether_type
  end

  def ifgap
    24
  end

  def local_mac
    get_mac 'LOCAL'
  end

  def local_mac= mac
    set_mac mac, 'LOCAL'
  end

  def mtu
    2048
  end

  def other_mac
    get_mac 'OTHER'
  end

  def other_mac= mac
    set_mac mac, 'OTHER'
  end

  def phase_number
    num_phases = net_fpga.get "PORT_#{port}_NUM_PHASES_REG"
    num_phases > 8 ? 0 : num_phases
  end

  def phases
    Array.new phase_number do |ph|
      {
        type:   PhaseTypes[net_fpga.get "PORT_#{port}_PH_#{ph}_TYPE_REG"] || 'NIL',
        length: net_fpga.get("PORT_#{port}_PH_#{ph}_LENGTH_REG") * LengthUnit,
      }
    end
  end

  def phases= phases
    net_fpga.set "PORT_#{port}_NUM_PHASES_REG", phases.size
    phases.each.with_index do |phase, ph|
      net_fpga.set "PORT_#{port}_PH_#{ph}_TYPE_REG",   PhaseTypes.invert[phase[:type]]
      net_fpga.set "PORT_#{port}_PH_#{ph}_LENGTH_REG", phase[:length] / LengthUnit
    end
  end

  def type_map
    Hash[PhaseTypes.values.reject { |k| k == 'NIL' }.map do |type|
      pih = net_fpga.get "PORT_#{port}_PIH_#{type}_REG"
      pih ||= 0
      [type, pih > 0xff ? 0 : pih]
    end]
  end

  def type_map= type_map
    type_map.each do |type, value|
      net_fpga.set "PORT_#{port}_PIH_#{type}_REG", value
    end
  end

  attr_reader :net_fpga, :port
  private     :net_fpga, :port

  private

  def get_mac locality
    hi = net_fpga.get "PORT_#{port}_#{locality}_MAC_HI_REG"
    lo = net_fpga.get "PORT_#{port}_#{locality}_MAC_LO_REG"
    ints = [(hi & 0xff00) >> 8, hi & 0xff, (lo & 0xff000000) >> 24, (lo & 0xff0000) >> 16, (lo & 0xff00) >> 8, lo & 0xff]
    ints.map { |i| i.to_s(16).rjust 2, '0'}.join ':'
  end

  def set_mac mac, locality
    ints = mac.split(':').map { |hex| hex.to_i 16 }
    net_fpga.set "PORT_#{port}_#{locality}_MAC_HI_REG", ints[0] << 8 | ints[1]
    net_fpga.set "PORT_#{port}_#{locality}_MAC_LO_REG", ints[2] << 24 | ints[3] << 16 | ints[4] << 8 | ints[5]
  end
end end
