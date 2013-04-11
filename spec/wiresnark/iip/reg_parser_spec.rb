require_relative '../../spec_helper'

module Wiresnark::IIP describe RegParser do
  describe '#parse' do
    it 'plucks the register definitions from the passed file' do
      hash = RegParser.new('spec/fixtures/reg_defines_ip_qos_iip_system.h').parse
      hash['DEVICE_PROJ_DIR'].must_equal    'ip_qos_iip_system'
      hash['IO_QUEUE_STAGE_NUM'].must_equal 255
      hash['PCI_ADDR_WIDTH'].must_equal     32
    end
  end
end end
