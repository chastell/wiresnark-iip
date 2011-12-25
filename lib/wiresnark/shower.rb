module Wiresnark class Shower
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def show opts
    port = opts['interface'][/\d$/].to_i

    puts case opts['param']
         when 'MACDA' then @net_fpga.ports[port].other_mac
         end
  end
end end
