require_relative '../../spec_helper'

module Wiresnark describe DSL::Monitor do

  it 'stores the passed interface' do
    env = Object.new.extend DSL::Monitor
    env.interface.must_be_nil
    env.interface 'lo'
    env.interface.must_equal 'lo'
  end

end end
