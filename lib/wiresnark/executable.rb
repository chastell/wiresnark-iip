module Wiresnark class Executable

  def initialize args = ARGV
    @command = args.shift
    @args    = args
  end

  def run opts = { runner: Runner, shower: Shower.new }
    case @command
    when 'run'  then opts[:runner].run @args.first
    when 'iip'
      case @args.shift
      when 'show' then opts[:shower].show Hash[@args.map { |a| a.split '=' }]
      end
    end
  end

end end
