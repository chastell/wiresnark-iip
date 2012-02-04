module Wiresnark class Shower
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def show opts
    param, iface, _, type = *opts

    port = @net_fpga.ports[iface[/\d$/].to_i]

    case param
    when 'CL'    then port.cycle_length
    when 'MACDA' then port.other_mac
    when 'MACSA' then port.local_mac
    when 'MTU'   then port.mtu
    when 'NP'    then port.phase_number
    when 'PL'
      pls = type ? port.phases.select { |p| p[:type] == type } : port.phases
      pls.map { |p| "#{p[:type]}=#{p[:length]}" }.join(',')
    when 'ifgap' then port.ifgap
    when 'BV', 'CBS', 'CIR', 'CLASS', 'DAF', 'MACT', 'MACVLANT', 'PIH', 'PIT', 'PIVT', 'SAF', 'VLANTF', 'VPTIin', 'VPTIout', 'WFQ'
      warn "unhandled parameter: #{param}"
    else
      warn "unknown parameter: #{param}"
    end
  end
end end
