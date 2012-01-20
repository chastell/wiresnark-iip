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

    it 'parses empty(ish) config files' do
      empty = {
        0 => { local: '00:00:00:00:00:00', other: '00:00:00:00:00:00', phases: [] }
      }
      XMLParser.new('spec/fixtures/iip.conf.empty-v_port+scheduler.xml').parse.must_equal empty
      XMLParser.new('spec/fixtures/iip.conf.empty-interface.xml').parse.must_equal empty
      XMLParser.new('spec/fixtures/iip.conf.empty-interfaces.xml').parse.must_equal({})
    end
  end

  describe '#warnings' do
    it 'warns about ignored elements' do
      warns = xml_parser.warnings
      [
        'BaseValue', 'CBS', 'CIR', 'MACType', 'MACVLAN-tag', 'MTU', 'PIH',
        'SourceAddressfiltering', 'VLAN-TAG', 'VLAN-tagfiltering', 'WFQ', 'ifgap', 'pi',
      ].each { |elem| warns.must_include "#{elem} ignored" }
    end

    it 'warns on DAF not matching MACDA' do
      warns = xml_parser.warnings
      warns.must_include 'DestinationAddressfiltering (ad:e3:3e:a4:24:aa) =/= MACDestinationAddress (a3:a3:45:23:34:aa)'
    end

    it 'warns on Cyclelength and NumberPhases being out of sync with PhaseLength entries' do
      warns = XMLParser.new('spec/fixtures/iip.conf.bad-cyclelength.xml').warnings
      warns.must_include 'Cyclelength (900) =/= sum of PhaseLength (1000)'

      warns = XMLParser.new('spec/fixtures/iip.conf.bad-numberphases.xml').warnings
      warns.must_include 'NumberPhases (4) =/= number of PhaseLengths (5)'
    end

    it 'warns on PhaseLengths not being multiples of 8' do
      xml_parser.warnings.must_include 'PhaseLength of 180 ns will be rounded to 176 ns'
    end

    it 'returns no warnings on a minimal, valid XML' do
      XMLParser.new('spec/fixtures/iip.conf.minimal.xml').warnings.must_be :empty?
    end

    it 'verifies empty(ish) config files' do
      warns = XMLParser.new('spec/fixtures/iip.conf.empty-v_port+scheduler.xml').warnings
      warns.must_include 'MACSourceAddress set to 00:00:00:00:00:00'
      warns.must_include 'MACDestinationAddress set to 00:00:00:00:00:00'

      XMLParser.new('spec/fixtures/iip.conf.empty-interface.xml').warnings.must_be :empty?
      XMLParser.new('spec/fixtures/iip.conf.empty-interfaces.xml').warnings.must_be :empty?
    end

    it 'verfies value formats' do
      warns = XMLParser.new('spec/fixtures/iip.conf.bad-values.xml').warnings
      warns.must_include 'bad MACSourceAddress: 11:22:33:44:55'
      warns.must_include 'bad MACDestinationAddress: gg:hh:ii:jj:kk:ll'
      warns.must_include 'bad Cyclelength: foo'
      warns.must_include 'bad NumberPhases: bar'
      warns.must_include 'bad PhaseLength: baz'
      warns.must_include 'bad PhaseLength pi: QUX'
    end
  end
end end
