module Wiresnark class Interface

  def self.new name
    @interfaces       ||= {}
    @interfaces[name] ||= super
  end

end end
