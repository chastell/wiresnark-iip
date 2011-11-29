# encoding: UTF-8

require_relative '../spec_helper'

module Wiresnark describe NetFPGA do
  describe '#get' do
    it 'gets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :get, 7, [0x2000200]
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h', regbridge
      nf.get('SCHEDULER_0_NUM_PHASES_REG').must_equal 7
      regbridge.verify
    end
  end

  describe '#mac' do
    it 'returns the MAC of the given interface' do
      regbridge = Object.new
      def regbridge.get reg
        case reg
        when 0x2000100 then 0x0000ade3
        when 0x2000104 then 0x3ea42300
        when 0x2000148 then 0x0000a3a3
        when 0x200014c then 0x45233400
        end
      end
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h', regbridge
      nf.mac(0, :local).must_equal 'ad:e3:3e:a4:23:00'
      nf.mac(1, :other).must_equal 'a3:a3:45:23:34:00'
    end
  end

  describe '#mac_set' do
    it 'sets the MAC of the given interface' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :set, nil, [0x2000100, 0x0000ade3]
      regbridge.expect :set, nil, [0x2000104, 0x3ea42300]
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h', regbridge
      nf.mac_set 0, :local, 'ad:e3:3e:a4:23:00'
      regbridge.verify
    end
  end

  describe '#registers' do
    it 'returns the given NetFPGA’s register map' do
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h'
      nf.registers['SCHEDULER_0_NUM_PHASES_REG'].must_equal 0x2000200
    end
  end

  describe '#set' do
    it 'sets the register contents (via the passed bridge)' do
      regbridge = MiniTest::Mock.new
      regbridge.expect :set, nil, [0x2000200, 7]
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h', regbridge
      nf.set 'SCHEDULER_0_NUM_PHASES_REG', 7
      regbridge.verify
    end
  end
end end
