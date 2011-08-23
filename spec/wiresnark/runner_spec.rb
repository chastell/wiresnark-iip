require_relative '../spec_helper'

module Wiresnark module Runner

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
  end

end end
