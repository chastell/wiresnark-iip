module Wiresnark module Runner

  def self.run file, env = Object.new.extend(DSL::WiresnarkDSL)
    env.instance_eval File.read file

    env.generator_blocks.each do |block|
      gen = Object.new.extend DSL::GeneratorDSL
      gen.instance_eval &block
      Interface.new(gen.interface).inject Generator.generate(gen), (gen.verbose ? $stdout : nil)
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
