module Wiresnark module Generator

  def self.generate env
    Array.new(env.count) { Packet.new env }
  end

end end
