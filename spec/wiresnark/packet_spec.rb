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

  describe '#destination_mac=' do
    it 'sets its destination MAC' do
      packet = Packet.new
      packet.destination_mac = 'aa:bb:cc:dd:ee:ff'
      packet.to_bin[0..5].must_equal "\xaa\xbb\xcc\xdd\xee\xff"
    end
  end

  describe '#source_mac=' do
    it 'sets its source MAC' do
      packet = Packet.new
      packet.source_mac = '11:22:33:44:55:66'
      packet.to_bin[6..11].must_equal "\x11\x22\x33\x44\x55\x66"
    end
  end

end end
