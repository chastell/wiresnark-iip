require_relative '../../spec_helper'

module Wiresnark describe NetFPGA::Bridge do
  it 'has #{g,s}et_register methods' do
    bridge = NetFPGA::Bridge.new
    assert bridge.respond_to? :get_register
    assert bridge.respond_to? :set_register
  end
end end
