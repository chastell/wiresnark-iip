module Wiresnark::IIP class NetFPGA
  attr_reader :registers

  def initialize regbridge = NetFPGA::Bridge.new
    @regbridge = regbridge
    path = "#{File.dirname __FILE__}/../../../ext/wiresnark/iip/reg_defines_ip_qos_iip_system.h"
    @registers = RegParser.new.parse path
  end

  def config= config
    config.each do |i, params|
      next unless (0..3).include? i
      ports[i].ether_type = params[:ether_type]
      ports[i].local_mac  = params[:local]
      ports[i].other_mac  = params[:other]
      ports[i].phases     = params[:phases]
      ports[i].type_map   = params[:type_map]
    end
  end

  def get register
    regbridge.get_register registers[register]
  end

  def ports
    @ports ||= (0..3).map { |i| Port.new self, i }
  end

  def set register, value
    regbridge.set_register registers[register], value
  end

  attr_reader :regbridge
  private     :regbridge
end end
