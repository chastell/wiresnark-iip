require_relative '../spec_helper'

module Wiresnark describe Runner do

  describe '.run' do
    it 'evaluates the passed file and sends packets as per spec' do
      skip if Process.uid.zero?

      env = MiniTest::Mock.new
      env.expect :instance_eval,    nil, [File.read('spec/fixtures/three-to-lo.rb')]
      env.expect :generator_blocks, []
      env.expect :monitor_blocks,   []

      Runner.run 'spec/fixtures/three-to-lo.rb', env

      env.verify
    end

    it 'outputs the traffic info if so instructed' do
      skip if Process.uid.zero?

      -> { Runner.run 'spec/fixtures/three-to-lo.rb' }.must_output <<-END
-> lo\tEth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00] [00] [0000000000]
-> lo\tEth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00] [00] [0000000001]
-> lo\tEth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00] [00] [0000000002]
lo ->\tEth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00] [00] [0000000000]
lo ->\tEth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00] [00] [0000000001]
lo ->\tEth\t60\t[00:00:00:00:00:00] [00:00:00:00:00:00] [08.00] [00] [0000000002]
\t3 Eth\t180 bytes\t60 bytes/packet

      END
    end

    it 'cycles through the packet types if so instructed' do
      skip if Process.uid.zero?

      out = capture_io { Runner.run 'spec/fixtures/cycle-to-lo.rb' }.first

      out.must_match /#{'QoS.*CAN.*DSS.*MGT.*' * 4}/m
      out.count('QoS').must_be :>, out.count('MGT')
    end

    it 'includes packet counts and size sums on packet type changes' do
      skip if Process.uid.zero?

      capture_io { Runner.run 'spec/fixtures/cycle-to-lo.rb' }.first.must_include "\t1 MGT\t60 bytes"
    end

    it 'includes only packet counts and size sums in non-verbose mode' do
      skip if Process.uid.zero?

      out = capture_io { Runner.run 'spec/fixtures/quiet-lo.rb' }.first

      out.wont_include "-> lo\tEth\t60"
      out.must_include "\t3 Eth\t180 bytes"
    end

    it 'includes per-type running tally in running_tally mode' do
      skip if Process.uid.zero?

      out = capture_io { Runner.run 'spec/fixtures/running-tally.rb' }.first

      out.must_match 'Eth:     6 p,   360 b,    60 b/p    DSS:     4 p,   240 b,    60 b/p    CAN:     3 p,   180 b,    60 b/p    QoS:     2 p,   120 b,    60 b/p    MGT:     5 p,   300 b,    60 b/p'
    end
  end

end end
