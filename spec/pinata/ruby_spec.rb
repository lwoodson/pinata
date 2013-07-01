require 'spec_helper'

describe Pinata::Ruby do
  describe "#whackers" do
    it "should include the Cane whacker" do
      Pinata::Ruby.whackers.include?(Pinata::Ruby::Cane).should == true
    end
  end

  describe "#start_whacking" do
    context "when code has gotten better" do
      it "should not contain results from Cane" do
        results = Pinata::Ruby.start_whacking(improving_ruby_code_change)
        results.should_not be_empty
      end
    end

    context "when code has gotten worse" do
      it "should contain results from Cane" do
        results = Pinata::Ruby.start_whacking(regressing_ruby_code_change)
        results.should_not be_empty
      end
    end

    context "when code has stayed the same" do
      it "should not contain results from Cane" do
        results = Pinata::Ruby.start_whacking(static_ruby_code_change)
        results.should_not be_empty
      end
    end
  end
end
