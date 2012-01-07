module Wiresnark class Executable

  def initialize args = ARGV
    @command = args.shift
    @args    = args
  end

  def run opts = { nf_class: NetFPGA, runner: Runner.new, shower: Shower.new }
    case @command
    when 'run'  then opts[:runner].run @args.first
    when 'iip'
      case @args.shift
      when 'commit' then opts[:nf_class].new.config = XMLParser.parse(@args.first)
      when 'show'   then puts opts[:shower].show @args
      end
    end
  end

end end
