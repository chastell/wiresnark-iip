require_relative '../../spec_helper'

module Wiresnark::IIP describe Executable do
  describe '#run' do
    it 'executes IIP commit command and prints warnings about the XML (if any)' do
      committer = MiniTest::Mock.new
      committer.expect :commit, nil, ['spec/fixtures/iip.conf.xml']

      stderr = capture_io do
        Executable.new(['commit', 'spec/fixtures/iip.conf.xml']).run committer: committer
      end.last

      stderr.must_include 'BaseValue ignored'
      stderr.must_include 'SourceAddressfiltering (ad:e3:3e:a4:24:aa) =/= MACDestinationAddress (a3:a3:45:23:34:aa)'

      committer.verify
    end

    it 'executes IIP show commands' do
      shower = MiniTest::Mock.new
      shower.expect :show, 'aa:bb:cc:dd:ee:ff', [['MACDA', 'pnf2c0', 'v_1']]

      -> do
        Executable.new(['show', 'MACDA', 'pnf2c0', 'v_1']).run shower: shower
      end.must_output "aa:bb:cc:dd:ee:ff\n"

      shower.verify
    end

    it 'executes IIP get command' do
      getter = MiniTest::Mock.new
      getter.expect :get, 'XML with device configuration'

      -> do
        Executable.new(['get']).run getter: getter
      end.must_output "XML with device configuration\n"

      getter.verify
    end
  end
end end
