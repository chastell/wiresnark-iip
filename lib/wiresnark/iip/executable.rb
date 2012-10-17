module Wiresnark::IIP class Executable
  def initialize args = ARGV
    @command = args.shift
    @args    = args
  end

  def run opts = { committer: Committer.new, getter: Getter.new, shower: Shower.new }
    case command
    when 'commit'
      ConfigParser.new(args.first).warnings.each { |warning| warn warning }
      opts[:committer].commit args.first
    when 'get'
      puts opts[:getter].get
    when 'show'
      puts opts[:shower].show args
    end
  end

  private

  attr_reader :args, :command
end end
