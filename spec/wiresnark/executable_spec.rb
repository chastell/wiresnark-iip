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
      config = {
        0 => {
          local: 'ad:e3:3e:a4:23:aa',
          other: 'a3:a3:45:23:34:aa',
          phases: [
            { type: 'QOS', length: 180 },
            { type: 'CAN', length: 190 },
            { type: 'DSS', length: 200 },
            { type: 'MGT', length: 210 },
            { type: 'NIL', length: 220 },
          ],
        },
        1 => {
          local: 'ad:e3:3e:b4:23:aa',
          other: 'a3:aa:45:23:34:aa',
          phases: [],
        },
      }

      net_fpga = MiniTest::Mock.new
      net_fpga.expect :config=, nil, [config]

      stderr = capture_io do
        Executable.new(['iip', 'commit', 'spec/fixtures/iip.conf.xml']).run net_fpga: net_fpga
      end.last

      stderr.must_include 'BaseValue ignored'
      stderr.must_include 'DestinationAddressfiltering (ad:e3:3e:a4:24:aa) =/= MACDestinationAddress (a3:a3:45:23:34:aa)'

      net_fpga.verify
    end

    it 'executes IIP show commands' do
      shower = MiniTest::Mock.new
      shower.expect :show, 'aa:bb:cc:dd:ee:ff', [['MACDA', 'eth0', 'v_1']]

      -> do
        Executable.new(['iip', 'show', 'MACDA', 'eth0', 'v_1']).run shower: shower
      end.must_output "aa:bb:cc:dd:ee:ff\n"

      shower.verify
    end
  end

end end
