require 'spec_helper'

describe Pinata::Ruby::Cane do
  describe "#whack" do
    it "should return 1 when code has improved" do
      subject.previous_filepath = source_file('craptacular.rb')
      subject.current_filepath = source_file('elegant.rb') 
      subject.whack.should == 1
    end

    it "should return -1 when code has degraded" do
      subject.previous_filepath = source_file('elegant.rb')
      subject.current_filepath = source_file('craptacular.rb')
      subject.whack.should == -1
    end

    it "should return 0 when code has stayed the same" do
      subject.previous_filepath = source_file('craptacular.rb')
      subject.current_filepath = source_file('craptacular.rb')
      subject.whack.should == 0
    end

    it "should raise UnableToParseResults if files don't exist." do
      expect{ subject.whack }.to raise_error(Pinata::UnableToParseResults)
    end
  end
end
