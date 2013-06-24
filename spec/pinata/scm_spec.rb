require 'spec_helper'
require 'sandbox_repo_helper'

describe Pinata::SCM do
  include SandboxRepoHelper
  describe "#scm" do
    it "should return Pinata::SCM::Git when encountering a Git project" do
      in_sandbox do
        Pinata::SCM.scm.should == Pinata::SCM::Git
      end
    end
  end
end
