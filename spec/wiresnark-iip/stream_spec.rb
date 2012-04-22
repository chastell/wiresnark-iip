require_relative '../spec_helper'

module Wiresnark describe Stream do
  describe '.for' do
    it 'returns the stream for the given interface and pcap lib' do
      pcap = MiniTest::Mock.new
      pcap.expect :nil?,      false
      pcap.expect :open_live, [], ['lo', 0xffff, true, 0]
      Stream.for 'lo', pcap
      pcap.verify
    end

    it 'returns an empty Array if not root and no lib specified' do
      Stream.for('lo').must_equal [] unless Process.uid.zero?
    end

    it 'returns an object which responds to <<' do
      Stream.for('lo').must_respond_to :<<
    end

    it 'returns the same stream for the same interface' do
      Stream.for('lo').must_be_same_as Stream.for 'lo'
      Stream.for('lo').wont_be_same_as Stream.for 'eth0'
    end
  end
end end
