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

    it 'creates a packet based on the passed binary String' do
      packet = Packet.new "\xaa\xbb\xcc\xdd\xee\xff" + "\x11\x22\x33\x44\x55\x66" + "\x08\x00" + 'foo' + "\x00" * 43
      packet.destination_mac.must_equal 'aa:bb:cc:dd:ee:ff'
      packet.source_mac.must_equal '11:22:33:44:55:66'
      packet.payload.must_equal 'foo' + "\x00" * 43
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

  describe '#payload' do
    it 'reads its payload' do
      packet = Packet.new
      packet.payload.must_equal "\x00" * 46
      packet.payload = 'foo'
      packet.payload.must_equal 'foo' + "\x00" * 43
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

    it 'truncates the previous payload and pads the new one if needed' do
      packet = Packet.new
      packet.payload = 'foo' * 100
      packet.payload = 'bar' * 10
      packet.to_bin[14..-1].must_equal 'bar' * 10 + "\x00" * 16
    end
  end

  describe '#source_mac' do
    it 'reads its source MAC' do
      packet = Packet.new
      packet.source_mac.must_equal '00:00:00:00:00:00'
      packet.source_mac = '11:22:33:44:55:66'
      packet.source_mac.must_equal '11:22:33:44:55:66'
    end
  end

  describe '#source_mac=' do
    it 'sets its source MAC' do
      packet = Packet.new
      packet.source_mac = '11:22:33:44:55:66'
      packet.to_bin[6..11].must_equal "\x11\x22\x33\x44\x55\x66"
    end
  end

  describe '#type' do
    it 'reads its type' do
      Packet.new.type.must_equal 'Eth'

      qos_bin = Packet.new.to_bin
      qos_bin[14] = "\x01"
      Packet.new(qos_bin).type.must_equal 'QoS'

      can_bin = Packet.new.to_bin
      can_bin[14] = "\x02"
      Packet.new(can_bin).type.must_equal 'CAN'

      dss_bin = Packet.new.to_bin
      dss_bin[14] = "\x03"
      Packet.new(dss_bin).type.must_equal 'DSS'

      mgt_bin = Packet.new.to_bin
      mgt_bin[14] = "\x04"
      Packet.new(mgt_bin).type.must_equal 'MGT'
    end
  end

end end
