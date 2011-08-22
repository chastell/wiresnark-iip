require_relative '../../spec_helper'

module Wiresnark describe DSL::PacketDSL do

  describe '#destination_mac, #payload, #source_mac, #type' do
    it 'stores the passed packet param' do
      env = Object.new.extend DSL::PacketDSL

      env.destination_mac.must_be_nil
      env.payload.must_be_nil
      env.source_mac.must_be_nil
      env.type.must_be_nil

      env.destination_mac 'aa:bb:cc:dd:ee:ff'
      env.payload 'foo'
      env.source_mac '11:22:33:44:55:66'
      env.type 'QoS'

      env.destination_mac.must_equal 'aa:bb:cc:dd:ee:ff'
      env.payload.must_equal 'foo'
      env.source_mac.must_equal '11:22:33:44:55:66'
      env.type.must_equal 'QoS'
    end
  end

end end
