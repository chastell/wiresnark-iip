require_relative '../spec_helper'

module Wiresnark describe Runner do

  describe '.run' do
    it 'evaluates the passed file and sends packets as per spec' do
      env = MiniTest::Mock.new
      env.expect :instance_eval,    nil, [File.read('spec/fixtures/three-to-lo.rb')]
      env.expect :generator_blocks, []
      env.expect :monitor_blocks,   []
      Runner.run 'spec/fixtures/three-to-lo.rb', env
      env.verify
    end

    it 'outputs the traffic info if so instructed' do
      -> { Runner.run 'spec/fixtures/three-to-lo.rb' }.must_output <<-END
-> lo\tEth\t00:00:00:00:00:00 00:00:00:00:00:00 08 00#{' 00' * 46}
-> lo\tEth\t00:00:00:00:00:00 00:00:00:00:00:00 08 00#{' 00' * 46}
-> lo\tEth\t00:00:00:00:00:00 00:00:00:00:00:00 08 00#{' 00' * 46}
lo ->\tEth\t00:00:00:00:00:00 00:00:00:00:00:00 08 00#{' 00' * 46}
lo ->\tEth\t00:00:00:00:00:00 00:00:00:00:00:00 08 00#{' 00' * 46}
lo ->\tEth\t00:00:00:00:00:00 00:00:00:00:00:00 08 00#{' 00' * 46}
      END
    end

    it 'cycles through the packet types if so instructed' do
      out, _ = capture_io { Runner.run 'spec/fixtures/cycle-to-lo.rb' }
      out.must_match /#{'QoS.*CAN.*DSS.*MGT.*' * 4}/m
      out.count('QoS').must_be :>, out.count('MGT')
    end
  end

end end
