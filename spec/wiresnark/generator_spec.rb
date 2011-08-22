require_relative '../spec_helper'

module Wiresnark describe Generator do

  describe '.generate' do
    it 'generates packages based on the passed block' do
      Generator.generate do
        count 3
      end.must_equal [Packet.new, Packet.new, Packet.new]
    end
  end

end end
