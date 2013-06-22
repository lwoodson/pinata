require 'spec_helper'

describe Pinata::SCM::Git do
  describe "#current_branch" do
    it "should return the currently checked out branch" do
      result = Pinata::SCM::Git.current_branch
      result.should == `git branch | awk '{print $2}'`.strip
    end
  end
end
