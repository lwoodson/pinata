require 'spec_helper'

describe Pinata::Filetypes do
  describe "#whacker_for" do
    it "should identify that the Pinata::Ruby module is appropriate for *.rb files" do
      code_change = Pinata::CodeChange.new
      code_change.relative_filepath = source_file('elegant.rb')
      Pinata::Filetypes.whacker_for(code_change).should == Pinata::Ruby
    end

    it "should return nil for an un-recognized file type" do
      code_change = Pinata::CodeChange.new
      code_change.relative_filepath = 'asdasd.324234'
      Pinata::Filetypes.whacker_for(code_change).should be_nil
    end

    it "should return nil for an empty CodeChange" do
      code_change = Pinata::CodeChange.new
      Pinata::Filetypes.whacker_for(code_change).should be_nil
    end
  end
end
