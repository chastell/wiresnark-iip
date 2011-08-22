require_relative '../../spec_helper'

module Wiresnark describe DSL::GeneratorDSL do

  describe '#count' do
    it 'stores the passed count' do
      env = Object.new.extend DSL::GeneratorDSL
      env.count.must_be_nil
      env.count 7
      env.count.must_equal 7
    end
  end

end end
