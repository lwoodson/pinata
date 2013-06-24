require 'spec_helper'
require 'sandbox_repo_helper'

describe Pinata::SCM::Git do
  include SandboxRepoHelper

  describe "#current_branch" do
    it "should return the currently checked out branch" do
      in_sandbox do |git|
        result = Pinata::SCM::Git.current_branch
        result.should == "master"
      end
    end
  end
end
