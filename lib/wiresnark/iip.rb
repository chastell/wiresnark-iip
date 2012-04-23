require 'ffi'
require 'nokogiri'

module Wiresnark module IIP
  TypeBytes = {
    'NIL' => 0,
    'DSS' => 1,
    'CAN' => 2,
    'QOS' => 4,
    'MGT' => 7,
  }
end end

Dir["#{File.dirname(__FILE__)}/**/*.rb"].sort.each { |f| require f }
