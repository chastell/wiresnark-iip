module Wiresnark module Runner

  def self.run file, env = Object.new.extend(DSL::WiresnarkDSL)
    env.instance_eval File.read file

    env.generator_blocks.each do |block|
      gen = Object.new.extend DSL::GeneratorDSL
      gen.instance_eval &block

      case
      when gen.count
        Interface.new(gen.interface).inject Generator.generate(gen), (gen.verbose ? $stdout : nil)
      when gen.phase_usecs
        iface = Interface.new gen.interface
        phase_times = Hash[gen.phase_types.zip gen.phase_usecs]
        phase_pckts = Hash[gen.phase_types.map { |type| [gen.type(type), Generator.generate(gen, phase_times[type])] }]
        phase_times.cycle(gen.cycles) do |type, time|
          stop = Time.now + (time / 1_000_000.0)
          catch :next_type do
            phase_pckts[type].cycle do |packet|
              iface.inject [packet], (gen.verbose ? $stdout : nil)
              throw :next_type if Time.now > stop
            end
          end
        end
      end
    end

    env.monitor_blocks.each do |block|
      mon = Object.new.extend DSL::MonitorDSL
      mon.instance_eval &block
      Interface.new(mon.interface).stream.each do |bin|
        puts "#{mon.interface} ->\t#{Packet.new bin}" if mon.verbose?
      end
    end
  end

end end
