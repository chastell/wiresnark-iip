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

  describe '#verbose, #verbose?' do
    it 'turns on and reads the verbose flag' do
      env = Object.new.extend DSL::Common
      refute env.verbose?
      env.verbose
      assert env.verbose?
    end
  end

end end
