require_relative '../spec_helper'

module Wiresnark describe Generator do

  describe '.generate' do
    it 'generates packages based on the passed block' do
      Generator.generate do
        count 3
      end.must_equal [Packet.new, Packet.new, Packet.new]

      packet = Packet.new "\xaa\xbb\xcc\xdd\xee\xff" + "\x11\x22\x33\x44\x55\x66" + "\x08\x00" + "\x02" + 'foo' + "\x00" * 42
      Generator.generate do
        count 5
        destination_mac 'aa:bb:cc:dd:ee:ff'
        payload 'foo'
        source_mac '11:22:33:44:55:66'
        type 'CAN'
      end.must_equal [packet, packet, packet, packet, packet]
    end
  end

end end
