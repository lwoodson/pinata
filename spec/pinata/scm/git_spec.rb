require 'spec_helper'
require 'sandbox_repo_helper'
require 'pinata/scm/git'

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

  describe "#local_modifications" do
    context "when local and remote head are in sync"  do
      it "should return an empty Array" do
        in_sandbox do |git|
          Pinata::SCM::Git.local_modifications.should == []
        end
      end
    end
  end
end
