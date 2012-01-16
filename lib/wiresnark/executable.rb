module Wiresnark class Executable
  def initialize args = ARGV
    @command = args.shift
    @args    = args
  end

  def run opts = { net_fpga: NetFPGA.new, runner: Runner.new, shower: Shower.new }
    case @command
    when 'run'
      opts[:runner].run @args.first
    when 'iip'
      case @args.shift
      when 'commit'
        xml = XMLParser.new @args.first
        xml.warnings.each { |warning| warn warning }
        opts[:net_fpga].config = xml.parse
      when 'show'
        puts opts[:shower].show @args
      end
    end
  end
end end
