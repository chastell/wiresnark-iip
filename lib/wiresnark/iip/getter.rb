module Wiresnark module IIP class Getter
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def get
    Nokogiri::XML::Builder.new do |xml|
      xml.interfaces do
        @net_fpga.ports.each.with_index do |port, i|
          xml.interface name: "eth#{i}" do
            xml.v_port name: 'v_1' do
              port.type_map.each do |type, value|
                xml.pi type: type do
                  xml.PIH value.to_s(2).rjust 3, '0'
                end
              end
              xml.MACSourceAddress port.local_mac
              xml.MACDestinationAddress port.other_mac
              xml.MACType "0x#{port.ether_type.to_s 16}"
              xml.MTU port.mtu
              xml.ifgap port.ifgap
            end
            xml.Scheduler type: 'XenNet' do
              xml.Cyclelength port.cycle_length
              xml.NumberPhases port.phase_number
              port.phases.each do |phase|
                xml.PhaseLength phase[:length], pi: phase[:type]
              end
            end
          end
        end
      end
    end.to_xml
  end
end end end
