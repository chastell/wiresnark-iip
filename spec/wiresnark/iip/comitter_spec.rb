require_relative '../../spec_helper'

module Wiresnark module IIP describe Committer do
  describe '#commit' do
    it 'configures NetFPGA with the passed XML' do
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

      Committer.new(net_fpga).commit 'spec/fixtures/iip.conf.xml'

      net_fpga.verify
    end
  end
end end end
