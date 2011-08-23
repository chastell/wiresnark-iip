module Wiresnark module Generator

  def self.generate env, count = env.count
    Array.new(count) { Packet.new env }
  end

end end
