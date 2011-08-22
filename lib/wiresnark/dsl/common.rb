module Wiresnark module DSL::Common

  def interface interface = nil
    interface.nil? ? @interface : @interface = interface
  end

end end
