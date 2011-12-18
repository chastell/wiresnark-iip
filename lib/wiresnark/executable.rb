module Wiresnark class Executable

  def initialize args = ARGV
    @command = args.shift
    @files   = args
  end

  def run runner = Runner
    case @command
    when 'run' then runner.run @files.first
    end
  end

end end
