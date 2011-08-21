module Wiresnark module DSL::Generator

  def interface interface = nil
    interface.nil? ? @interface : @interface = interface
  end

end end
