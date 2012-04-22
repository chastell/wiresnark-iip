require_relative '../spec_helper'

module Wiresnark describe Executable do
  describe '#run' do
    it 'passes the given file to the runner' do
      runner = MiniTest::Mock.new
      runner.expect :run, nil, ['spec/fixtures/three-to-lo.rb']
      Executable.new(['run', 'spec/fixtures/three-to-lo.rb']).run runner: runner
      runner.verify
    end

    it 'executes IIP commit command and prints warnings about the XML (if any)' do
      committer = MiniTest::Mock.new
      committer.expect :commit, nil, ['spec/fixtures/iip.conf.xml']

      stderr = capture_io do
        Executable.new(['iip', 'commit', 'spec/fixtures/iip.conf.xml']).run committer: committer
      end.last

      stderr.must_include 'BaseValue ignored'
      stderr.must_include 'DestinationAddressfiltering (ad:e3:3e:a4:24:aa) =/= MACDestinationAddress (a3:a3:45:23:34:aa)'

      committer.verify
    end

    it 'executes IIP show commands' do
      shower = MiniTest::Mock.new
      shower.expect :show, 'aa:bb:cc:dd:ee:ff', [['MACDA', 'eth0', 'v_1']]

      -> do
        Executable.new(['iip', 'show', 'MACDA', 'eth0', 'v_1']).run shower: shower
      end.must_output "aa:bb:cc:dd:ee:ff\n"

      shower.verify
    end

    it 'executes IIP get command' do
      getter = MiniTest::Mock.new
      getter.expect :get, 'XML with device configuration'

      -> do
        Executable.new(['iip', 'get']).run getter: getter
      end.must_output "XML with device configuration\n"

      getter.verify
    end
  end
end end
