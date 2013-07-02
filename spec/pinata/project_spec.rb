require 'spec_helper'
require 'sandboxes/git_repo_helper'

describe Pinata::Project do
  include GitRepoHelper

  describe "public interface" do
    context "in a project with no local changes" do
      it "should not indicate that the project has changed, improved or regressed" do
        in_sandbox do
          project = Pinata::Project.new
          project.whack_it!
          project.should_not have_changes
          project.should_not have_skipped
          project.should_not have_improved
          project.should_not have_regressed
          project.shift.should == 0
        end
      end
    end

    context "when encountering a file new to the project" do
      context "with no detected style violations" do
        it "should indicate there is a change and that there are no regressions" do
          in_sandbox do |git|
            git.create_new_file('test.rb', 'puts "this is a test"')
            project = Pinata::Project.new
            project.whack_it!
            project.should have_changes
            project.should_not have_regressed
            project.shift.should == 0
            project.should_not have_skipped
            project.should_not have_improved
          end
        end
      end

      context "with detected style violations" do
        it "should indicate there is a change and regressions" do
          in_sandbox do |git|
            git.create_new_file('test.rb', GitRepoHelper::BAD_PLAYER_CONTENTS)
            project = Pinata::Project.new
            project.whack_it!
            project.should have_changes
            project.should have_regressed
            (project.shift < 0).should == true
            project.should_not have_skipped
            project.should_not have_improved
          end
        end
      end
    end

    context "when encountering a code change to a file for which it has no whacker" do
      it "should indicate that it skipped the file" do
        in_sandbox do |git|
          git.update_file('README.md', 'this is a readme file')
          project = Pinata::Project.new
          project.whack_it!
          project.should have_changes
          project.should have_skipped
          project.should_not have_improved
          project.should_not have_regressed
          project.shift.should == 0
        end
      end
    end

    context "in a project with local change improving code" do
      it "should indicate project has changed and improved and not regressed" do
        in_sandbox do |git|
          git.refactor_player_to_not_suck
          project = Pinata::Project.new
          project.whack_it!
          project.should have_changes
          project.should_not have_skipped
          project.should have_improved
          project.should_not have_regressed
          project.shift.should == 1
        end
      end
    end

    context "in a project with local changes regressing code" do
      it "should indicate project has changed and regressed but not improved" do
        in_sandbox do |git|
          git.refactor_tennis_match_to_suck
          project = Pinata::Project.new
          project.whack_it!
          project.should have_changes
          project.should_not have_skipped
          project.should have_regressed
          project.should_not have_improved
          project.shift.should == -1
        end
      end
    end

    context "in a project with local changes improving and regressing code" do
      it "should indicate project has changed, regressed and improved" do
        in_sandbox do |git|
          git.refactor_player_to_not_suck
          git.refactor_tennis_match_to_suck
          project = Pinata::Project.new
          project.whack_it!
          project.should have_changes
          project.should_not have_skipped
          project.should have_regressed
          project.should have_improved
          project.shift.should == 0
        end
      end
    end
  end
end
