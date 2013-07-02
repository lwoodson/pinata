require 'spec_helper'

describe Pinata::Ruby::Cane do
  describe "#whack" do
    it "should return 1 when code has improved" do
      result = Pinata::Ruby::Cane.whack(improving_ruby_code_change)
      result.outcome.should == 1
    end

    it "should return -1 when code has degraded" do
      result = Pinata::Ruby::Cane.whack(regressing_ruby_code_change)
      result.outcome.should == -1
    end

    it "should return 0 when code has stayed the same" do
      result = Pinata::Ruby::Cane.whack(static_ruby_code_change)
      result.outcome.should == 0
    end

    it "should raise WhackerFailed if files don't exist." do
      expect{ Pinata::Ruby::Cane.whack(nil) }.to raise_error(Pinata::WhackerFailed)
    end

    it "should not raise an error if no results are found" do
      result = Pinata::Ruby::Cane.whack(code_change_with_no_result)
      result.outcome.should == 0
    end

    it "should correctly handle new files entering the project" do
      result = Pinata::Ruby::Cane.whack(code_change_for_new_file)
      result.outcome.should == -1
    end
  end
end
