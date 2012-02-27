module Wiresnark module IIP class Committer
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def commit config_path
    @net_fpga.config = ConfigParser.new(config_path).parse
  end
end end end
