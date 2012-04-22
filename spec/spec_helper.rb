require 'bundler/setup'
require 'minitest/autorun'
require 'stringio'

require_relative '../lib/wiresnark-iip'

MiniTest::Spec.before do
  Wiresnark::Configuration.payload_bytes = 5
  Wiresnark::Stream.instance_variable_set :@streams, {}
end
