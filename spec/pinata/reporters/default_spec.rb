require 'spec_helper'

describe Pinata::Reporters::Default do
  include StreamSpecHelper
  let(:project) {double(Pinata::Project)}
  let(:reporter) {Pinata::Reporters::Default.new(project, stream)}

  before do
    project.stub(:observe)
  end

  describe "#update" do
    context "when receiving an unrecognized event" do
      it "should raise an error" do
        expect{reporter.update type: :foo}.to raise_error
      end
    end

    context "when receiving a starting event" do
      it "should write message to stream" do
        reporter.update type: :starting
        output.should_not be_empty
      end
    end

    context "when receiving a code_change event" do
      it "should write message to stream" do
        code_change = Pinata::CodeChange.new
        code_change.relative_filepath = 'test.rb'
        reporter.update type: :code_change, payload: code_change
        output.should_not be_empty
      end
    end

    context "when receiving a whacker event with module payload" do
      it "should write a message to stream" do
        reporter.update type: :whacker, payload: Pinata::Ruby::Cane 
        output.should_not be_empty
      end
    end


    context "when receiving a whacker event with nil payload" do
      it "should write a message to stream" do
        reporter.update type: :whacker, payload: nil
        output.should_not be_empty
      end
    end
  end

  describe "#make_report" do
    context "when there are no code changes" do
      it "should report no code changes" do
        project.stub(:has_changes?) {false}
        reporter.make_report
        output.scan(/nothing here/).flatten.should_not be_empty
      end
    end

    context "when there are code changes" do
      context "That has left the codebase the same" do
        it "should report no change" do
          project.stub(:has_changes?) {true}
          project.stub(:has_improved?) {false}
          project.stub(:has_regressed?) {false}
          project.stub(:shift) {0}
          reporter.make_report
          output.scan(/doesn't appear that you left any mark/).flatten.should_not be_empty
        end
      end

      context "that has improved the codebase" do
        it "should report a positive change" do
          project.stub(:has_changes?) {true}
          project.stub(:has_improved?) {true}
          project.stub(:shift) {10}
          reporter.make_report
          output.scan(/code has improved/).flatten.should_not be_empty
        end
      end

      context "that has regressed the codebase" do
        it "should report a negative change" do
          project.stub(:has_changes?) {true}
          project.stub(:has_improved?) {false}
          project.stub(:has_regressed?) {true}
          project.stub(:shift) {-10}
          reporter.make_report
          output.scan(/code has degraded/).flatten.should_not be_empty
        end
      end
    end
  end
end
