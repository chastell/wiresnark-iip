require_relative '../../spec_helper'

module Wiresnark describe DSL::GeneratorDSL do
  before do
    @env = Object.new.extend DSL::GeneratorDSL
  end

  describe '#count' do
    it 'stores the passed count' do
      @env.count.must_be_nil
      @env.count 7
      @env.count.must_equal 7
    end
  end

  describe '#cycles' do
    it 'stores the passed cycles' do
      @env.cycles.must_be_nil
      @env.cycles 3
      @env.cycles.must_equal 3
    end
  end

  describe '#phase_types' do
    it 'stores the passed types as array' do
      @env.phase_types.must_be_nil
      @env.phase_types 'QOS', 'CAN', 'DSS', 'MGT'
      @env.phase_types.must_equal ['QOS', 'CAN', 'DSS', 'MGT']
    end
  end

  describe '#phase_usecs' do
    it 'stores the passed times as array' do
      @env.phase_usecs.must_be_nil
      @env.phase_usecs 100, 200, 300, 400
      @env.phase_usecs.must_equal [100, 200, 300, 400]
    end
  end

  describe '#sequence, #sequence?' do
    it 'turns on and reads the sequence flag' do
      refute @env.sequence?
      @env.sequence
      assert @env.sequence?
    end
  end
end end
