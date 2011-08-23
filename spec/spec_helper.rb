gem 'minitest', '>= 2.3'
require 'minitest/autorun'

require 'stringio'

require_relative '../lib/wiresnark'

MiniTest::Spec.before do
  Wiresnark::Interface.instance_variable_set :@interfaces, {}
end
