require_relative '../../spec_helper'

module Wiresnark describe DSL::PacketDSL do

  describe '#destination_mac, #min_size, #payload, #random_size, #source_mac, #type and #params' do
    it 'stores the set packet params' do
      env = Object.new.extend DSL::PacketDSL

      env.params.must_equal({})

      env.destination_mac 'aa:bb:cc:dd:ee:ff'
      env.min_size 100
      env.payload 'foo'
      env.random_size 60..100
      env.source_mac '11:22:33:44:55:66'
      env.type 'QOS'

      env.params.must_equal({
        destination_mac: 'aa:bb:cc:dd:ee:ff',
        min_size: 100,
        random_size: 60..100,
        payload: 'foo',
        source_mac: '11:22:33:44:55:66',
        type: 'QOS',
      })
    end
  end

end end
