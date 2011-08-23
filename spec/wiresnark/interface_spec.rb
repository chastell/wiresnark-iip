require_relative '../spec_helper'

module Wiresnark describe Interface do

  before do
    Interface.instance_variable_set :@interfaces, {}
  end

  describe '.new' do
    it 'returns the same interface on subsequent calls' do
      Interface.new('foo').must_be_same_as Interface.new 'foo'
      Interface.new('foo').wont_be_same_as Interface.new 'bar'
    end
  end

  describe '#inject' do
    it 'injects the given packets to the interface' do
      stream = MiniTest::Mock.new
      stream.expect :inject, nil, [Packet.new.to_bin]
      Interface.new('lo').inject [Packet.new], nil, stream
      stream.verify
    end

    it 'prints the injected packets to the output' do
      foo = Object.new.extend DSL::PacketDSL
      bar = Object.new.extend DSL::PacketDSL
      foo.payload 'foo'
      bar.payload 'bar'
      Interface.new('lo').inject [Packet.new(foo), Packet.new(bar)], output = StringIO.new
      output.rewind
      output.read.must_equal <<-END
\t-> lo\tEth  00:00:00:00:00:00 00:00:00:00:00:00 08 00 66 6f 6f#{' 00' * 43}
\t-> lo\tEth  00:00:00:00:00:00 00:00:00:00:00:00 08 00 62 61 72#{' 00' * 43}
      END
    end
  end

end end
