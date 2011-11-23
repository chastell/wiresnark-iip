module Wiresnark module RegParser
  def self.parse path
    Hash[File.read(path).scan(/^#define\s+(\S+)\s+(\S+)$/).map do |reg, val|
      [
        reg,
        case val
        when /^\d+$/          then val.to_i
        when /^0x[0-9a-f]+$/i then val.to_i 16
        when /^"(.*)"$/       then $1
        end
      ]
    end]
  end
end end
