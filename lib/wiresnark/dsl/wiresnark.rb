module Wiresnark module DSL module Wiresnark

  def send_to interface, &block
    send_to_blocks << { interface: interface, block: block }
  end

  def send_to_blocks
    @send_to_blocks ||= []
  end

end end end
