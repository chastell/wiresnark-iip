require_relative '../spec_helper'

module Wiresnark describe Executable do

  describe '#run' do
    it 'passes the given file to the runner' do
      runner = MiniTest::Mock.new
      runner.expect :run, nil, ['spec/fixtures/three-to-lo.rb']
      Executable.new(['run', 'spec/fixtures/three-to-lo.rb']).run runner: runner
      runner.verify
    end

    it 'executes IIP commands' do
      shower = MiniTest::Mock.new
      shower.expect :show, nil, [{ 'interface' => 'eth0', 'param' => 'MACDA', 'vport' => 'v_1' }]
      Executable.new(['iip', 'show', 'param=MACDA', 'interface=eth0', 'vport=v_1']).run shower: shower
      shower.verify
    end
  end

end end
