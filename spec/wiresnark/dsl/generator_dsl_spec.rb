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

  describe '#phase_types' do
    it 'stores the passed types as array' do
      env = Object.new.extend DSL::GeneratorDSL
      env.phase_types.must_be_nil
      env.phase_types 'QoS', 'CAN', 'DSS', 'MGT'
      env.phase_types.must_equal ['QoS', 'CAN', 'DSS', 'MGT']
    end
  end

  describe '#phase_usecs' do
    it 'stores the passed times as array' do
      env = Object.new.extend DSL::GeneratorDSL
      env.phase_usecs.must_be_nil
      env.phase_usecs 100, 200, 300, 400
      env.phase_usecs.must_equal [100, 200, 300, 400]
    end
  end

end end
