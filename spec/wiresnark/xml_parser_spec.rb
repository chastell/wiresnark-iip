require_relative '../spec_helper'

module Wiresnark describe XMLParser do
  let(:xml_parser) { XMLParser.new 'spec/fixtures/iip.conf.xml' }

  describe '#parse' do
    it 'parses the IIP XML config file' do
      hash = xml_parser.parse
      hash[0][:local].must_equal 'ad:e3:3e:a4:23:aa'
      hash[1][:other].must_equal 'a3:aa:45:23:34:aa'
      hash[0][:phases].must_equal [
        { type: 'QOS', length: 180 },
        { type: 'CAN', length: 190 },
        { type: 'DSS', length: 200 },
        { type: 'MGT', length: 210 },
        { type: 'NIL', length: 220 },
      ]
    end
  end

  describe '#verify' do
    it 'verfies that the config file is sane' do
      -> { xml_parser.verify }.must_output '', <<-end.gsub(/^\s*/, '')
        BaseValue ignored
        CBS ignored
        CIR ignored
        DestinationAddressfiltering ignored
        MACType ignored
        MACVLAN-tag ignored
        MTU ignored
        PIH ignored
        SourceAddressfiltering ignored
        VLAN-TAG ignored
        VLAN-tagfiltering ignored
        WFQ ignored
        ifgap ignored
        pi ignored
      end
    end
  end
end end
