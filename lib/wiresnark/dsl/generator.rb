module Wiresnark module DSL::Generator

  include DSL::Common

  def count count = nil
    count.nil? ? @count : @count = count
  end

end end
