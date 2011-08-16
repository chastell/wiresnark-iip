module Wiresnark module Runner

  def self.run file, env
    env.instance_eval File.read file
  end

end end
