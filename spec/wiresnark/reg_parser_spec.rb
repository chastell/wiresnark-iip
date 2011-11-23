require_relative '../spec_helper'

module Wiresnark describe RegParser do
  describe '.parse' do
    it 'plucks the register definitions from the passed file' do
      hash = RegParser.parse 'spec/fixtures/reg_defines_simple_system_iip.h'
      hash['DEVICE_PROJ_DIR'].must_equal    'simple_system_iip'
      hash['IO_QUEUE_STAGE_NUM'].must_equal 255
      hash['PCI_ADDR_WIDTH'].must_equal     32
    end
  end
end end
