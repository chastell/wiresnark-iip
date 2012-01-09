module Wiresnark class NetFPGA
  attr_reader :registers

  def initialize regbridge = NetFPGA::Bridge.new
    @regbridge = regbridge
    @registers = RegParser.new.parse "#{File.dirname __FILE__}/../../ext/reg_defines_simple_system_iip.h"
  end

  def config= config
    config.each do |i, params|
      ports[i].local_mac = params[:local]
      ports[i].other_mac = params[:other]
      ports[i].phases    = params[:phases]
    end
  end

  def get register
    @regbridge.get_register @registers[register]
  end

  def ports
    (0..3).map { |i| Port.new self, i }
  end

  def set register, value
    @regbridge.set_register @registers[register], value
  end
end end
