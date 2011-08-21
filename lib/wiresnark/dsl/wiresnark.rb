module Wiresnark module DSL module Wiresnark

  def generator &block
    generator_blocks << block
  end

  def generator_blocks
    @generator_blocks ||= []
  end

end end end
