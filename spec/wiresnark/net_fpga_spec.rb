# encoding: UTF-8

require_relative '../spec_helper'

module Wiresnark describe NetFPGA do
  describe '#registers' do
    it 'returns the given NetFPGA’s register map' do
      nf = NetFPGA.new 'spec/fixtures/reg_defines_simple_system_iip.h'
      nf.registers['SCHEDULER_0_NUM_PHASES_REG'].must_equal 0x2000200
    end
  end
end end
