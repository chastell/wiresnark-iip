require_relative '../spec_helper'

module Wiresnark module Runner

  describe '.run' do
    it 'evaluates the contents of the file in the context of the passed object' do
      env = MiniTest::Mock.new
      env.expect :instance_eval, nil, [File.read('spec/fixtures/seven-to-lo.rb')]
      Runner.run 'spec/fixtures/seven-to-lo.rb', env
      env.verify
    end
  end

end end
