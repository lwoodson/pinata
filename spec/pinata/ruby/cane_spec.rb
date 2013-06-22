require 'spec_helper'

describe Pinata::Ruby::Cane do
  describe "#whack" do
    it "should return 1 when code has improved" do
      code_change = Pinata::CodeChange.new
      code_change.previous_filepath = source_file('craptacular.rb')
      code_change.current_filepath = source_file('elegant.rb')
      result = Pinata::Ruby::Cane.whack(code_change)
      result.outcome.should == 1
    end

    it "should return -1 when code has degraded" do
      code_change = Pinata::CodeChange.new
      code_change.previous_filepath = source_file('elegant.rb')
      code_change.current_filepath = source_file('craptacular.rb')
      result = Pinata::Ruby::Cane.whack(code_change)
      result.outcome.should == -1
    end

    it "should return 0 when code has stayed the same" do
      code_change = Pinata::CodeChange.new
      code_change.previous_filepath = source_file('elegant.rb')
      code_change.current_filepath = source_file('elegant.rb')
      result = Pinata::Ruby::Cane.whack(code_change)
      result.outcome.should == 0
    end

    it "should raise UnableToParseResults if files don't exist." do
      expect{ Pinata::Ruby::Cane.whack(nil) }.to raise_error(Pinata::WhackerFailed)
    end
  end
end
