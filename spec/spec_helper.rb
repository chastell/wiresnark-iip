gem 'minitest', '>= 2.3'
require 'minitest/autorun'

require 'stringio'

require_relative '../lib/wiresnark'

MiniTest::Spec.before do
  Wiresnark::Stream.instance_variable_set :@streams, {}
end
