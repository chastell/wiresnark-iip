module Wiresnark class Shower
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def show opts
    port = @net_fpga.ports[opts['interface'][/\d$/].to_i]

    case opts['param']
    when 'CL'    then port.phases.map { |p| p[:length] }.inject :+
    when 'MACDA' then port.other_mac
    when 'MACSA' then port.local_mac
    when 'NP'    then port.phases.size
    end
  end
end end
