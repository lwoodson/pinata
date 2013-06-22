require 'spec_helper'

describe Pinata::Ruby do
  describe "#whackers" do
    it "should include the Cane whacker" do
      Pinata::Ruby.whackers.include?(Pinata::Ruby::Cane).should == true
    end
  end

  describe "#start_whacking" do
    context "when code has gotten better" do
      before do
        @code_change = Pinata::CodeChange.new
        @code_change.previous_filepath = source_file('craptacular.rb')
        @code_change.current_filepath = source_file('elegant.rb')
      end

      it "should not contain results from Cane" do
        regressions = Pinata::Ruby.start_whacking(@code_change)
        regressions[Pinata::Ruby::Cane].should be_nil
      end
    end

    context "when code has gotten worse" do
      before do
        @code_change = Pinata::CodeChange.new
        @code_change.previous_filepath = source_file('elegant.rb')
        @code_change.current_filepath = source_file('craptacular.rb')
      end

      it "should contain results from Cane" do
        regressions = Pinata::Ruby.start_whacking(@code_change)
        regressions[Pinata::Ruby::Cane].should_not be_nil
      end
    end

    context "when code has stayed the same" do
      before do
        @code_change = Pinata::CodeChange.new
        @code_change.previous_filepath = source_file('elegant.rb')
        @code_change.current_filepath = source_file('elegant.rb')
      end

      it "should not contain results from Cane" do
        regressions = Pinata::Ruby.start_whacking(@code_change)
        regressions[Pinata::Ruby::Cane].should be_nil
      end
    end
  end
end
