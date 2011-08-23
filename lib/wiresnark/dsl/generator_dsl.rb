module Wiresnark module DSL::GeneratorDSL

  include DSL::CommonDSL, DSL::PacketDSL

  def count count = nil
    count.nil? ? @count : @count = count
  end

  def phase_usecs *phase_usecs
    phase_usecs.empty? ? @phase_usecs : @phase_usecs = phase_usecs
  end

end end
