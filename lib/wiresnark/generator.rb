module Wiresnark module Generator

  def self.generate env, count = env.count
    Array.new(count) do |n|
      env.payload "\x00" + [(n % 0x100000000).to_s(16).rjust(8, '0')].pack('H8') if env.sequence?
      Packet.new env
    end
  end

end end
