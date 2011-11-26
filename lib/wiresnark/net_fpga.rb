module Wiresnark class NetFPGA
  attr_reader :registers

  def initialize reg_path, regbridge = nil
    @regbridge = regbridge
    @registers = RegParser.parse reg_path
  end

  def get register
    @regbridge.get @registers[register]
  end
end end
