require_relative '../spec_helper'

module Wiresnark describe XMLParser do
  describe '.parse' do
    it 'parses the IIP XML config file' do
      hash = XMLParser.parse 'spec/fixtures/iip.conf.xml'
      hash['eth0'][:local].must_equal 'ad:e3:3e:a4:23:aa'
      hash['eth1'][:other].must_equal 'a3:aa:45:23:34:aa'
      hash['eth0'][:phases].must_equal [
        { type: 'QOS', length: 180 },
        { type: 'CAN', length: 190 },
        { type: 'DSS', length: 200 },
        { type: 'MGT', length: 210 },
        { type: 'NIL', length: 220 },
      ]
    end
  end
end end
