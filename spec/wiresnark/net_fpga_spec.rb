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
