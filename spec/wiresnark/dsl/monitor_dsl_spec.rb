require_relative '../../spec_helper'

module Wiresnark describe DSL::MonitorDSL do

  describe '#running_tally, #running_tally?' do
    it 'turns on and reads the running_tally flag' do
      env = Object.new.extend DSL::MonitorDSL

      refute env.running_tally?
      env.running_tally
      assert env.running_tally?
    end
  end

end end
