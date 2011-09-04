require_relative '../../spec_helper'

module Wiresnark describe DSL::PacketDSL do

  describe '#destination_mac, #min_size, #payload, #random_size, #source_mac, #type' do
    it 'stores the passed packet params' do
      env = Object.new.extend DSL::PacketDSL

      env.destination_mac.must_be_nil
      env.min_size.must_equal 60
      env.payload.must_be_nil
      env.random_size.must_be_nil
      env.source_mac.must_be_nil
      env.type.must_be_nil

      env.destination_mac 'aa:bb:cc:dd:ee:ff'
      env.min_size 100
      env.payload 'foo'
      env.random_size 60..100
      env.source_mac '11:22:33:44:55:66'
      env.type 'QoS'

      env.destination_mac.must_equal 'aa:bb:cc:dd:ee:ff'
      env.min_size.must_equal 100
      env.random_size.must_equal 60..100
      env.payload.must_equal 'foo'
      env.source_mac.must_equal '11:22:33:44:55:66'
      env.type.must_equal 'QoS'
    end
  end

end end
