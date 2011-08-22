require_relative '../spec_helper'

module Wiresnark describe Interface do

  describe '.new' do
    it 'returns the same interface on subsequent calls' do
      Interface.new('foo').must_be_same_as Interface.new 'foo'
      Interface.new('foo').wont_be_same_as Interface.new 'bar'
    end
  end

end end
