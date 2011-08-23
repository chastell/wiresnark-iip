require_relative '../spec_helper'

module Wiresnark describe Interface do

  describe '.new' do
    it 'returns the same interface on subsequent calls' do
      Interface.new('foo').must_be_same_as Interface.new 'foo'
      Interface.new('foo').wont_be_same_as Interface.new 'bar'
    end
  end

  describe '#inject' do
    it 'injects the given packets to its stream' do
      stream = []
      Interface.new('lo', stream).inject [Packet.new, Packet.new]
      stream.must_equal [Packet.new.to_bin, Packet.new.to_bin]
    end

    it 'prints the injected packets to the output' do
      foo = Object.new.extend DSL::PacketDSL
      bar = Object.new.extend DSL::PacketDSL
      foo.payload 'foo'
      bar.payload 'bar'
      Interface.new('lo').inject [Packet.new(foo), Packet.new(bar)], output = StringIO.new
      output.rewind
      output.read.must_equal <<-END
-> lo\tEth\t60\t00:00:00:00:00:00 00:00:00:00:00:00 08 00 66 6f 6f#{' 00' * 43}
-> lo\tEth\t60\t00:00:00:00:00:00 00:00:00:00:00:00 08 00 62 61 72#{' 00' * 43}
      END
    end
  end

  describe '#stream' do
    it 'returns the related stream' do
      stream = []
      lo = Interface.new 'lo', stream
      lo.stream.must_be_same_as stream
      lo.inject [Packet.new, Packet.new]
      lo.stream.must_equal [Packet.new.to_bin, Packet.new.to_bin]
    end
  end

end end
