module Wiresnark module DSL::Common

  def interface interface = nil
    interface.nil? ? @interface : @interface = interface
  end

  def verbose
    @verbose = true
  end

  def verbose?
    @verbose
  end

end end