require_relative '../spec_helper'

module Wiresnark describe Packet do

  describe '.new' do
    it 'creates empty Eth packet by default' do
      Packet.new.to_bin.must_equal "\x00" * 12 + "\x08\x00" + "\x00" * 46
    end
  end

  describe '#==' do
    it 'compares packets based on their binary representation' do
      Packet.new.must_equal Packet.new
    end
  end

end end
