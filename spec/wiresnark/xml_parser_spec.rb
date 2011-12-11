require_relative '../spec_helper'

module Wiresnark describe XMLParser do
  describe '.parse' do
    it 'parses the IIP XML config file' do
      hash = XMLParser.parse 'spec/fixtures/iip.conf.xml'
      hash['eth0'][:local].must_equal 'ad:e3:3e:a4:23:00'
      hash['eth1'][:other].must_equal 'a3:a3:45:23:34:00'
      hash['eth2'][:phases].must_equal [
        { type: 'QoS',    length: 300 },
        { type: 'CAN',    length: 300 },
        { type: 'MGT',    length: 300 },
        { type: 'silent', length: 100 },
      ]
    end
  end
end end
