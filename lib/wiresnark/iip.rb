require 'ffi'
require 'nokogiri'

module Wiresnark module IIP
end end

require_relative 'iip/committer'
require_relative 'iip/config_parser'
require_relative 'iip/executable'
require_relative 'iip/getter'
require_relative 'iip/net_fpga'
require_relative 'iip/net_fpga/bridge'
require_relative 'iip/net_fpga/port'
require_relative 'iip/reg_parser'
require_relative 'iip/shower'
