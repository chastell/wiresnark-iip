module Wiresnark module DSL::Monitor

  def interface interface = nil
    interface.nil? ? @interface : @interface = interface
  end

end end
