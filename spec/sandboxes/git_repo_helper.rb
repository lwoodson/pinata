require 'git'
require 'tmpdir'
require 'fileutils'
require 'delegate'

module GitRepoHelper
  SANDBOX_GITHUB='git@github.com:lwoodson/pinata-test-repo.git'
  SANDBOX_START_BRANCH='master'
  SANDBOX_START_SHA='621752d1cfa9f34c3fea4eafeb9f3c2621541031'
  GOOD_PLAYER_CONTENTS = <<-EOS
class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end
EOS
  GOOD_PLAYER_CONTENTS.strip!
  BAD_PLAYER_CONTENTS = "class Player; def initialize(name) @name = name; end; end;     "
  BAD_TENNIS_MATCH_CONTENTS = 'class TennisMatch; def start; puts "Ooh, we are going to play us some tennis, yes we are.  Hahaha we are going to watch the most amazing display of non-athleticism ever."; end; end'

  class SandboxGit < ::SimpleDelegator
    def initialize(git)
      super(git)
    end

    def refactor_player_to_not_suck
      File.open('player.rb', 'w') do |source_file|
        source_file.write(GitRepoHelper::GOOD_PLAYER_CONTENTS)
      end
      commit_all('refactoring Player to not suck')
    end

    def refactor_tennis_match_to_suck
      File.open('tennis-match.rb', 'w') do |source_file|
        source_file.write(GitRepoHelper::BAD_TENNIS_MATCH_CONTENTS)
      end
      commit_all('refactoring TennisMatch to suck')
    end

    def create_new_file(name, contents)
      mkdirs_for(name)
      File.open(name, 'w') do |file|
        file.write(contents)
      end
      add(name)
      commit_all('created #{name} file')
    end

    def mkdirs_for(name)
      dirs = name.split(File::SEPARATOR)[0..-2].join(File::SEPARATOR)
      FileUtils.mkdir_p(dirs) unless dirs.empty?
    end

    def update_file(name, contents)
      File.open(name, 'w') do |file|
        file.write(contents)
      end
      add(name)
      commit_all('created #{name} file')
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
