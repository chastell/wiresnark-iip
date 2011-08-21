require_relative '../../spec_helper'

module Wiresnark describe DSL::Wiresnark do

  describe '#generator, #generator_blocks' do
    it 'stores the passed block for future execution' do
      env = Object.new.extend DSL::Wiresnark
      block_a = -> { interface 'iface_a'; count 7 }
      block_b = -> { interface 'iface_b'; count 3 }
      env.generator &block_a
      env.generator &block_b
      env.generator_blocks.must_equal [block_a, block_b]
    end
  end

end end
