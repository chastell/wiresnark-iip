module Wiresnark class Committer
  def initialize xml_path, net_fpga
    @config   = XMLParser.new(xml_path).parse
    @net_fpga = net_fpga
  end

  def commit
    @net_fpga.config = @config
  end
end end
