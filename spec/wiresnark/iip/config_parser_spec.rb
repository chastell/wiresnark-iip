require_relative '../../spec_helper'

module Wiresnark::IIP describe ConfigParser do
  let(:parser) { ConfigParser.new 'spec/fixtures/iip.conf.xml' }

  describe '#parse' do
    it 'parses the IIP XML config file' do
      hash = parser.parse
      hash[0][:ether_type].must_equal 0xabcd
      hash[0][:local].must_equal 'ad:e3:3e:a4:23:aa'
      hash[1][:other].must_equal 'a3:aa:45:23:34:aa'
      hash[0][:phases].must_equal [
        { type: 'QOS', length: 180 },
        { type: 'CAN', length: 190 },
        { type: 'DSS', length: 200 },
        { type: 'MGT', length: 210 },
        { type: 'NIL', length: 220 },
      ]
      hash[0][:type_map].must_equal({ 'CAN' => 2 })
    end

    it 'parses empty(ish) config files' do
      empty = { 0 => { ether_type: 0, local: '00:00:00:00:00:00',
        other: '00:00:00:00:00:00', phases: [], type_map: {} } }
      ConfigParser.new('spec/fixtures/iip.conf.empty-v_port+scheduler.xml')
        .parse.must_equal empty
      ConfigParser.new('spec/fixtures/iip.conf.empty-interface.xml')
        .parse.must_equal empty
      ConfigParser.new('spec/fixtures/iip.conf.empty-interfaces.xml')
        .parse.must_equal({})
    end

    it 'zeroes bad MAC addresses' do
      bad = ConfigParser.new('spec/fixtures/iip.conf.bad-values.xml').parse
      bad[0][:local].must_equal '00:00:00:00:00:00'
      bad[0][:other].must_equal '00:00:00:00:00:00'
    end

    it 'parses type_map from subequent v_ports' do
      ConfigParser.new('spec/fixtures/iip.conf.multiple-v_ports.xml')
        .parse[0][:type_map].must_equal({ 'CAN' => 2, 'MGT' => 7 })
    end
  end

  describe '#warnings' do
    it 'warns about ignored elements' do
      ['BaseValue', 'CBS', 'CIR', 'MACVLAN-tag', 'MTU',
        'SourceAddressfiltering', 'VLAN-TAG', 'VLAN-tagfiltering', 'WFQ',
        'ifgap'].each { |elem| parser.warnings.must_include "#{elem} ignored" }
    end

    it 'warns on DAF not matching MACSA' do
      parser.warnings.must_include 'DestinationAddressfiltering (bd:e3:3e:a4:23:aa) =/= MACSourceAddress (ad:e3:3e:a4:23:aa)'
    end

    it 'warns on SAF not matching MACDA' do
      parser.warnings.must_include 'SourceAddressfiltering (ad:e3:3e:a4:24:aa) =/= MACDestinationAddress (a3:a3:45:23:34:aa)'
    end

    it 'warns on Cyclelength being out of sync with sum of PhaseLengths' do
      ConfigParser.new('spec/fixtures/iip.conf.bad-cyclelength.xml').warnings
        .must_include 'Cyclelength (900) =/= sum of PhaseLength (1000)'
    end

    it 'warns on NumberPhases being out of sync with number of PhaseLengths' do
      ConfigParser.new('spec/fixtures/iip.conf.bad-numberphases.xml').warnings
        .must_include 'NumberPhases (4) =/= number of PhaseLengths (5)'
    end

    it 'warns on PhaseLengths not being multiples of 8' do
      parser.warnings
        .must_include 'PhaseLength of 180 ns will be rounded to 176 ns'
    end

    it 'returns no warnings on a minimal, valid XML' do
      ConfigParser.new('spec/fixtures/iip.conf.minimal.xml').warnings
        .must_be :empty?
    end

    it 'verifies empty(ish) config files' do
      warns = ConfigParser.new('spec/fixtures/iip.conf.empty-v_port+scheduler.xml').warnings
      warns.must_include 'MACSourceAddress set to 00:00:00:00:00:00'
      warns.must_include 'MACDestinationAddress set to 00:00:00:00:00:00'

      ConfigParser.new('spec/fixtures/iip.conf.empty-interface.xml').warnings
        .must_be :empty?
      ConfigParser.new('spec/fixtures/iip.conf.empty-interfaces.xml').warnings
        .must_be :empty?
    end

    it 'verfies value formats' do
      warns = ConfigParser.new('spec/fixtures/iip.conf.bad-values.xml').warnings
      warns.must_include 'bad MACSourceAddress: 11:22:33:44:55'
      warns.must_include 'bad MACDestinationAddress: gg:hh:ii:jj:kk:ll'
      warns.must_include 'bad MACType: boo'
      warns.must_include 'bad Cyclelength: foo'
      warns.must_include 'bad MTU: bah'
      warns.must_include 'bad NumberPhases: bar'
      warns.must_include 'bad PIH: foo'
      warns.must_include 'bad PhaseLength: baz'
      warns.must_include 'bad PhaseLength pi: QUX'
      warns.must_include 'bad interface name: ath0'
    end

    it 'warns on attrless elements' do
      warns = ConfigParser.new('spec/fixtures/iip.conf.nameless.xml').warnings
      warns.must_include 'nameless interface'
      warns.must_include 'typeless Scheduler'
      warns.must_include 'piless PhaseLength'
    end
  end
end end
