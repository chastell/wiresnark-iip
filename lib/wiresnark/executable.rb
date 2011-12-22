module Wiresnark class Executable

  def initialize args = ARGV
    @command = args.shift
    @files   = args
  end

  def run opts = { runner: Runner }
    case @command
    when 'run' then opts[:runner].run @files.first
    end
  end

end end
