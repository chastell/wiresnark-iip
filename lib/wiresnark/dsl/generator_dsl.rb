module Wiresnark module DSL::GeneratorDSL

  include DSL::CommonDSL, DSL::PacketDSL

  def count count = nil
    count.nil? ? @count : @count = count
  end

end end
