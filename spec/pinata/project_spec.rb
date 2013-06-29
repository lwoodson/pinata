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
          project.should have_regressed
          project.should have_improved
          project.shift.should == 0
        end
      end
    end
  end
end
