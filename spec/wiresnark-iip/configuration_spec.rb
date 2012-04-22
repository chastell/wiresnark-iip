require_relative '../spec_helper'

module Wiresnark describe Configuration do
  describe '.payload_bytes, .payload_bytes=' do
    it 'allows reading and setting the number of payload bytes to disply' do
      Configuration.payload_bytes.must_equal 5
      Configuration.payload_bytes = 7
      Configuration.payload_bytes.must_equal 7
    end
  end
end end
