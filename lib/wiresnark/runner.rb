module Wiresnark module Runner

  def self.run file, env = Object.new.extend(DSL::WiresnarkDSL)
    env.instance_eval File.read file

    env.generator_blocks.each do |block|
      gen = Object.new.extend DSL::GeneratorDSL
      gen.instance_eval &block

      iface  = Interface.new gen.interface
      output = gen.verbose ? $stdout : nil

      case
      when gen.count
        iface.inject Generator.generate(gen), output
      when gen.phase_usecs
        phase_times = Hash[gen.phase_types.zip gen.phase_usecs]
        phase_pckts = Hash[gen.phase_types.map { |type| [gen.type(type), Generator.generate(gen, phase_times[type])] }]
        phase_times.cycle(gen.cycles) do |type, time|
          stop = Time.now + (time / 1_000_000.0)
          catch :next_type do
            phase_pckts[type].cycle do |packet|
              iface.inject [packet], output
              throw :next_type if Time.now > stop
            end
          end
        end
      end
    end

    env.monitor_blocks.each do |block|
      mon = Object.new.extend DSL::MonitorDSL
      mon.instance_eval &block

      return unless mon.verbose?

      # FIXME: deuglify the below
      type, count, bytes = nil, 0, 0
      Interface.new(mon.interface).stream.each do |bin|
        packet = Packet.new bin
        if type and packet.type != type
          puts "\t#{count} #{type}\t#{bytes} bytes\n\n"
          type, count, bytes = packet.type, 1, packet.size
        else
          type   = packet.type
          count += 1
          bytes += packet.size
        end
        puts "#{mon.interface} ->\t#{packet}"
      end
      puts "\t#{count} #{type}\t#{bytes} bytes\n\n"
    end
  end

end end
