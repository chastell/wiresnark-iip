module Wiresnark::IIP class Committer
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def commit config_path
    net_fpga.config = ConfigParser.new(config_path).parse
  end

  private

  attr_reader :net_fpga
end end
