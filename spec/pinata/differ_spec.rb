require 'spec_helper'
require 'sandboxes/git_repo_helper'

describe Pinata::Differ do
  include GitRepoHelper
  describe "#get_code_changes" do
    context "when there are no changes" do
      it "should return an empty array" do
        in_sandbox do
          Pinata::Differ.new.get_code_changes.should == []
        end
      end
    end

    context "when there are changes" do
      it "should return a code change for each file modified" do
        in_sandbox do |git|
          git.refactor_player_to_not_suck
          result = Pinata::Differ.new.get_code_changes
          result.size.should == 1
          result.first.previous_filepath.scan(/player.rb/).should_not be_empty
          result.first.current_filepath.scan(/player.rb/).should_not be_empty
        end
      end

      it "should return code changes pointing to files on the filesystem" do
        in_sandbox do |git|
          git.refactor_player_to_not_suck
          code_change = Pinata::Differ.new.get_code_changes.first
          File.exists?(code_change.previous_filepath).should == true
          File.exists?(code_change.current_filepath).should == true
        end
      end

      it "should return code changes pointing to files with source code" do
        in_sandbox do |git|
          git.refactor_player_to_not_suck
          code_change = Pinata::Differ.new.get_code_changes.first
          previous_source = File.read(code_change.previous_filepath)
          current_source = File.read(code_change.current_filepath)

          previous_source.should == GitRepoHelper::BAD_PLAYER_CONTENTS
          current_source.should == GitRepoHelper::GOOD_PLAYER_CONTENTS
        end
      end
    end
  end
end
