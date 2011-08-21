require_relative '../../spec_helper'

module Wiresnark describe DSL::Wiresnark do

  describe '#send_to, #send_to_blocks' do

    it 'stores the passed interface and block for future execution' do
      env = Object.new.extend DSL::Wiresnark
      block_a = -> { count 7 }
      block_b = -> { count 3 }
      env.send_to 'iface_a', &block_a
      env.send_to 'iface_b', &block_b
      env.send_to_blocks.must_equal [
        { interface: 'iface_a', block: block_a },
        { interface: 'iface_b', block: block_b },
      ]
    end

  end

end end
