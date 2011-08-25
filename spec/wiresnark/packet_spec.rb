require_relative '../spec_helper'

module Wiresnark describe Packet do

  describe '.new' do
    it 'creates an empty Eth packet by default' do
      Packet.new.to_bin.must_equal "\x00" * 12 + "\x08\x00" + "\x00" * 46
    end

    it 'creates a packet based on the passed object' do
      spec = Object.new.extend DSL::PacketDSL
      spec.destination_mac 'aa:bb:cc:dd:ee:ff'
      spec.min_size 100
      spec.source_mac '11:22:33:44:55:66'
      spec.payload 'foo'
      spec.type 'CAN'
      Packet.new(spec).to_bin.must_equal "\xaa\xbb\xcc\xdd\xee\xff" + "\x11\x22\x33\x44\x55\x66" + "\x08\x00" + "\x02" + 'foo' + "\x00" * 82
    end

    it 'creates a packet based on the passed binary String' do
      packet = Packet.new "\xaa\xbb\xcc\xdd\xee\xff" + "\x11\x22\x33\x44\x55\x66" + "\x08\x00" + "\x02" + 'foo' + "\x00" * 42
      packet.destination_mac.must_equal 'aa:bb:cc:dd:ee:ff'
      packet.source_mac.must_equal '11:22:33:44:55:66'
      packet.payload.must_equal 'foo' + "\x00" * 42
      packet.type.must_equal 'CAN'
    end
  end

  describe '#==' do
    it 'compares packets based on their binary representation' do
      Packet.new.must_equal Packet.new
      spec = Object.new.extend DSL::PacketDSL
      spec.destination_mac 'aa:bb:cc:dd:ee:ff'
      spec.source_mac '11:22:33:44:55:66'
      spec.payload 'foo'
      spec.type 'CAN'
      Packet.new(spec).must_equal Packet.new spec
    end
  end

  describe '#destination_mac' do
    it 'reads its destination MAC' do
      Packet.new.destination_mac.must_equal '00:00:00:00:00:00'
      Packet.new("\xaa\xbb\xcc\xdd\xee\xff" + "\x00" * 6 + "\x08\x00" + "\x00" * 46).destination_mac.must_equal 'aa:bb:cc:dd:ee:ff'
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
      Packet.new.payload.must_equal "\x00" * 46
      Packet.new("\x00" * 12 + "\x08\x00" + 'foo' + "\x00" * 43).payload.must_equal 'foo' + "\x00" * 43
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
      Packet.new.source_mac.must_equal '00:00:00:00:00:00'
      Packet.new("\x00" * 6 + "\x11\x22\x33\x44\x55\x66" + "\x08\x00" + "\x00" * 46).source_mac.must_equal '11:22:33:44:55:66'
    end
  end

  describe '#source_mac=' do
    it 'sets its source MAC' do
      packet = Packet.new
      packet.source_mac = '11:22:33:44:55:66'
      packet.to_bin[6..11].must_equal "\x11\x22\x33\x44\x55\x66"
    end
  end

  describe '#to_s' do
    it 'returns a human-readable packet representation' do
      Packet.new.to_s.must_equal "Eth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00]" + ' [00]' + ' 00' * 5

      spec = Object.new.extend DSL::PacketDSL
      spec.destination_mac 'aa:bb:cc:dd:ee:ff'
      spec.payload 'foo'
      spec.source_mac '11:22:33:44:55:66'
      spec.type 'DSS'
      Packet.new(spec).to_s.must_equal "DSS\t60\t[aa:bb:cc:dd:ee:ff] [11:22:33:44:55:66] [08.00] [03] 66 6f 6f 00 00"
    end

    it 'truncates the payload after the specified byte' do
      Packet.new.to_s(7).must_equal "Eth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00]" + ' [00]' + ' 00' * 7
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

  describe '#type=' do
    it 'sets its type, preserving payload on type changes (Eth -> non-Eth -> non-Eth -> Eth -> Eth)' do
      packet = Packet.new
      packet.payload = 'foo' * 10

      packet.type.must_equal 'Eth'
      packet.payload.must_equal 'foo' * 10 + "\x00" * 16

      packet.type = 'QoS'
      packet.type.must_equal 'QoS'
      packet.payload.must_equal 'foo' * 10 + "\x00" * 16

      packet.payload = 'foo' * 10
      packet.type.must_equal 'QoS'
      packet.payload.must_equal 'foo' * 10 + "\x00" * 15

      packet.type = 'DSS'
      packet.type.must_equal 'DSS'
      packet.payload.must_equal 'foo' * 10 + "\x00" * 15

      packet.type = 'Eth'
      packet.type.must_equal 'Eth'
      packet.payload.must_equal 'foo' * 10 + "\x00" * 16

      packet.type = 'Eth'
      packet.type.must_equal 'Eth'
      packet.payload.must_equal 'foo' * 10 + "\x00" * 16
    end
  end

end end
