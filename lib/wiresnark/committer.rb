module Wiresnark class Committer
  def initialize net_fpga
    @net_fpga = net_fpga
  end

  def commit xml_path
    @net_fpga.config = XMLParser.new(xml_path).parse
  end
end end
