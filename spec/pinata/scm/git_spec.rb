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

  describe "#modified_files" do
    context "when local and remote head are in sync"  do
      it "should return an empty Array" do
        in_sandbox do |git|
          Pinata::SCM::Git.modified_files.should == []
        end
      end
    end

    context "when local has commits not in remote" do
      it "should return an Array containing the changed file names" do
        in_sandbox do |git|
          git.refactor_player_to_not_suck
          Pinata::SCM::Git.modified_files.should == ['player.rb']
        end
      end
    end
  end

  describe "#local_content_of" do
    it "should return the contents of the local file" do
      in_sandbox do |git|
        git.refactor_player_to_not_suck
        contents = Pinata::SCM::Git.local_contents_of('player.rb')
        contents.should == SandboxRepoHelper::GOOD_PLAYER_CONTENTS
      end
    end
  end
end
