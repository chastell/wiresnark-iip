module Wiresnark module Generator

  def self.generate &block
    env = Object.new.extend DSL::GeneratorDSL
    env.instance_eval &block
    Array.new(env.count) { Packet.new }
  end

end end
