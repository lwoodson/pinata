require 'spec_helper'
require 'sandboxes/git_repo_helper'

describe Pinata::SCM do
  include GitRepoHelper
  describe "#scm" do
    it "should return Pinata::SCM::Git when encountering a Git project" do
      in_sandbox do
        Pinata::SCM.scm.should == Pinata::SCM::Git
      end
    end
  end
end
