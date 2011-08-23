module Wiresnark module Runner

  def self.run file, env = Object.new.extend(DSL::WiresnarkDSL)
    env.instance_eval File.read file
    env.generator_blocks.each do |block|
      gen = Object.new.extend DSL::GeneratorDSL
      gen.instance_eval &block
      Interface.new(gen.interface).inject Generator.generate(gen), (gen.verbose ? $stdout : nil)
    end
  end

end end
