require 'spec_helper'
require 'sandboxes/git_repo_helper'

describe Pinata::SCM do
  include GitRepoHelper
  include Pinata::SCM
  describe "#scm" do
    it "should return Pinata::SCM::Git when encountering a Git project" do
      in_sandbox do
        scm.should == Pinata::SCM::Git
      end
    end
  end
end
