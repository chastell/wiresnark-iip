module Wiresnark class NetFPGA::Bridge
  extend FFI::Library
  ffi_lib "#{File.dirname __FILE__}/../../../ext/wiresnark/regset.so"

  attach_function :get_register, [:uint],        :uint
  attach_function :set_register, [:uint, :uint], :void
end end
