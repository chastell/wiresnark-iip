module Wiresnark class Executable

  def initialize files = ARGV
    @files = files
  end

  def run runner = Runner
    runner.run @files.first
  end

end end
