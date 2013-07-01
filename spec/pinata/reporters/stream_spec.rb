require 'spec_helper'
require 'stringio'

describe Pinata::Reporters::Stream do
  let(:stream) {StringIO.new}
  let(:project) {double(Pinata::Project)}
  let(:reporter) {Pinata::Reporters::Stream.new(project, stream)}

  def output
    stream.rewind
    stream.read
  end

  describe "#make_report" do
    context "when there are no code changes" do
      it "should report no code changes" do
        project.stub(:has_changes?) {false}
        reporter.make_report
        output.scan(/No changes/).flatten.should_not be_empty
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
          output.scan(/no improvement/).flatten.should_not be_empty
          output.scan(/shift: (\d+)/).flatten.first.should == '0'
        end
      end

      context "that has improved the codebase" do
        it "should report a positive change" do
          project.stub(:has_changes?) {true}
          project.stub(:has_improved?) {true}
          project.stub(:shift) {10}
          reporter.make_report
          output.scan(/code has improved/).flatten.should_not be_empty
          output.scan(/shift: (\d+)/).flatten.first.should == '10'
        end
      end

      context "that has regressed the codebase" do
        it "should report a negative change" do
          project.stub(:has_changes?) {true}
          project.stub(:has_improved?) {false}
          project.stub(:has_regressed?) {true}
          project.stub(:shift) {-10}
          reporter.make_report
          output.scan(/code has regressed/).flatten.should_not be_empty
          output.scan(/shift: (-\d+)/).flatten.first.should == '-10'
        end
      end
    end
  end
end
