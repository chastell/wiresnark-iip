module Wiresnark class Executable

  def initialize files
    @files = files
  end

  def run runner
    runner.run @files.first
  end

end end
