module Wiresnark class NetFPGA
  attr_reader :registers

  def initialize reg_path
    @registers = RegParser.parse reg_path
  end
end end
