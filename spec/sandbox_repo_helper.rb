require 'git'
require 'tmpdir'
require 'fileutils'
require 'delegate'

module SandboxRepoHelper
  SANDBOX_GITHUB='git@github.com:lwoodson/pinata-test-repo.git'
  SANDBOX_START_BRANCH='master'
  SANDBOX_START_SHA='621752d1cfa9f34c3fea4eafeb9f3c2621541031'

  class SandboxGit < ::SimpleDelegator
    def initialize(git)
      super(git)
    end
  end

  def in_sandbox(&block)
    rspec_dir = FileUtils.pwd
    sandbox = File.join(Dir.tmpdir, 'pinata-test-sandbox')
    FileUtils.rm_rf(sandbox) if Dir.exists? sandbox
    git = SandboxGit.new(Git.clone(SANDBOX_GITHUB, sandbox))
    git.checkout(SANDBOX_START_BRANCH)
    git.reset(SANDBOX_START_SHA)
    begin
      FileUtils.cd(sandbox)
      block.call(git)
    ensure
      FileUtils.cd(rspec_dir)
    end
  end
end
