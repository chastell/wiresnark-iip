module Wiresnark class Shower
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def show opts
    port = opts['interface'][/\d$/].to_i

    case opts['param']
    when 'CL'    then @net_fpga.ports[port].phases.map { |p| p[:length] }.inject :+
    when 'MACDA' then @net_fpga.ports[port].other_mac
    when 'MACSA' then @net_fpga.ports[port].local_mac
    when 'NP'    then @net_fpga.ports[port].phases.size
    end
  end
end end
