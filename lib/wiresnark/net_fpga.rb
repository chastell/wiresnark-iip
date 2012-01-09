module Wiresnark class NetFPGA
  ConstMTU   = 2048
  Constifgap = 24

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
    @regbridge.get @registers[register]
  end

  def ports
    (0..3).map { |i| Port.new self, i }
  end

  def set register, value
    @regbridge.set @registers[register], value
  end
end end
