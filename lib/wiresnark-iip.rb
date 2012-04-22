require 'ffi'
require 'nokogiri'
require 'pcaprub'

module Wiresnark
  module DSL
  end

  TypeBytes = {
    'NIL' => 0,
    'DSS' => 1,
    'CAN' => 2,
    'QOS' => 4,
    'MGT' => 7,
  }
end

Dir["#{File.dirname(__FILE__)}/**/*.rb"].sort.each { |f| require f }
