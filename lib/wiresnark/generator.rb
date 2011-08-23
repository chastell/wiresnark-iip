module Wiresnark module Generator

  def self.generate env, count = env.count
    Array.new(count) do |n|
      env.payload (n % 0x10000).to_s(16).rjust(8, '0').chars.each_slice(2).map(&:join).pack('H2H2H2H2') if env.sequence?
      Packet.new env
    end
  end

end end
