module Wiresnark class Executable
  def initialize args = ARGV
    @command = args.shift
    @args    = args
  end

  def run opts = { committer: IIP::Committer.new, getter: IIP::Getter.new, runner: Runner.new, shower: IIP::Shower.new }
    case @command
    when 'run'
      opts[:runner].run @args.first
    when 'iip'
      case @args.shift
      when 'commit'
        XMLParser.new(@args.first).warnings.each { |warning| warn warning }
        opts[:committer].commit @args.first
      when 'get'
        puts opts[:getter].get
      when 'show'
        puts opts[:shower].show @args
      end
    end
  end
end end
