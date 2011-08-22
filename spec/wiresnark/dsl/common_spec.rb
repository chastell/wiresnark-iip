require_relative '../../spec_helper'

module Wiresnark describe DSL::Common do

  describe '#interface' do
    it 'stores the passed interface' do
      env = Object.new.extend DSL::Common
      env.interface.must_be_nil
      env.interface 'lo'
      env.interface.must_equal 'lo'
    end
  end

end end
