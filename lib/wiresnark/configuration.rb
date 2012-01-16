module Wiresnark module Configuration
  class << self
    attr_accessor :payload_bytes
  end
end end

Wiresnark::Configuration.payload_bytes = 5
