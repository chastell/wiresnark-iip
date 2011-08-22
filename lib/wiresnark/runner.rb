module Wiresnark module Runner

  def self.run file, env = Object.new.extend(DSL::WiresnarkDSL)
    env.instance_eval File.read file
  end

end end
