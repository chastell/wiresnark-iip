module Wiresnark module DSL::GeneratorDSL

  include DSL::CommonDSL

  def count count = nil
    count.nil? ? @count : @count = count
  end

end end
