require_relative '../spec_helper'

module Wiresnark module Runner

  describe '.run' do
    it 'evaluates the file in the context of the DSL object' do
      env = MiniTest::Mock.new
      env.expect :send_to, nil, ['lo']
      Runner.run 'spec/fixtures/seven-to-lo.rb', env
      env.verify
    end
  end

end end
