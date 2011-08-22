require_relative '../spec_helper'

module Wiresnark describe Packet do

  describe '.new' do
    it 'creates an empty Eth packet by default' do
      Packet.new.to_bin.must_equal "\x00" * 12 + "\x08\x00" + "\x00" * 46
    end

    it 'creates a packet based on the passed object' do
      spec = Object.new.extend DSL::PacketDSL
      spec.destination_mac 'aa:bb:cc:dd:ee:ff'
      spec.source_mac '11:22:33:44:55:66'
      spec.payload 'foo'
      Packet.new(spec).to_bin.must_equal "\xaa\xbb\xcc\xdd\xee\xff" + "\x11\x22\x33\x44\x55\x66" + "\x08\x00" + 'foo' + "\x00" * 43
    end
  end

  describe '#==' do
    it 'compares packets based on their binary representation' do
      Packet.new.must_equal Packet.new
    end
  end

  describe '#destination_mac' do
    it 'reads its destination MAC' do
      packet = Packet.new
      packet.destination_mac.must_equal '00:00:00:00:00:00'
      packet.destination_mac = 'aa:bb:cc:dd:ee:ff'
      packet.destination_mac.must_equal 'aa:bb:cc:dd:ee:ff'
    end
  end

  describe '#destination_mac=' do
    it 'sets its destination MAC' do
      packet = Packet.new
      packet.destination_mac = 'aa:bb:cc:dd:ee:ff'
      packet.to_bin[0..5].must_equal "\xaa\xbb\xcc\xdd\xee\xff"
    end
  end

  describe '#payload=' do
    it 'sets its payload' do
      packet = Packet.new
      packet.payload = 'foo'
      packet.to_bin[14..-1].must_equal 'foo' + "\x00" * 43
    end

    it 'sets the payload even when its bigger than 46 bytes' do
      packet = Packet.new
      packet.payload = 'foo' * 16
      packet.to_bin[14..-1].must_equal 'foo' * 16
    end

    it 'truncates the previous payload if needed' do
      packet = Packet.new
      packet.payload = 'foo' * 20
      packet.payload = 'bar' * 16
      packet.to_bin[14..-1].must_equal 'bar' * 16
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
