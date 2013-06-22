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

    it "should raise UnableToParseResults if files don't exist." do
      expect{ Pinata::Ruby::Cane.whack(nil) }.to raise_error(Pinata::WhackerFailed)
    end
  end
end
