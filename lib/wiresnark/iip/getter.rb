module Wiresnark::IIP class Getter
  def initialize net_fpga = NetFPGA.new
    @net_fpga = net_fpga
  end

  def get
    Nokogiri::XML::Builder.new do |xml|
      xml.interfaces do
        net_fpga.ports.each.with_index do |port, i|
          xml.interface name: "pnf2c#{i}" do
            port.type_map.each.with_index do |(type, value), j|
              xml.v_port name: "v_#{j+1}" do
                xml.pi type: type do
                  xml.PIH value
                end
                xml.MACSourceAddress port.local_mac
                xml.MACDestinationAddress port.other_mac
                xml.MACType "0x#{port.ether_type.to_s(16).rjust 4, '0'}"
                xml.MTU port.mtu
                xml.ifgap port.ifgap
              end
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

  attr_reader :net_fpga
  private     :net_fpga
end end
