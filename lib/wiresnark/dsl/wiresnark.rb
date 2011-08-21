module Wiresnark module DSL module Wiresnark

  def generator &block
    generator_blocks << block
  end

  def generator_blocks
    @generator_blocks ||= []
  end

  def monitor &block
    monitor_blocks << block
  end

  def monitor_blocks
    @monitor_blocks ||= []
  end

end end end
