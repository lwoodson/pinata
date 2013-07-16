require 'spec_helper'

describe Pinata::Reporters::DetailsTable do
  include StreamSpecHelper
  let(:project) {double(Pinata::Project)}
  let(:reporter) {Pinata::Reporters::DetailsTable.new(project, stream)}

  shared_examples_for "table_reporter" do
    it "should output headers" do
      reporter.make_report
      regex = /File.+Whacker.+Outcome.+Previous.+Current/
      output.scan(regex).flatten.should_not be_empty
    end

    it "should output totals" do
      reporter.make_report
      output.scan(/Totals.+\d+.+\d+.+\d+/).flatten.should_not be_empty
    end
  end

  describe "#make_report" do
    context "when there are no changes" do
      before do
        project.stub(:has_changes?) {false}
        project.stub(:raw_results) {[]}
      end

      it_behaves_like "table_reporter"
    end

    context "when there are changes" do
      let (:code_change) do 
        Pinata::CodeChange.new.tap do |code_change|
          code_change.relative_filepath = 'test.rb'
        end
      end
      let (:result) do
        Pinata::ResultOfWhacking.new(Pinata::Ruby::Cane, code_change).tap do |result|
          result.outcome = 0
          result.previous_issues = Pinata::Issues.new
          result.current_issues = Pinata::Issues.new
        end
      end

      before do
        project.stub(:has_changes?) {true}
        project.stub(:raw_results) {Array(result)}
      end

      it_behaves_like "table_reporter"

      it "should output a row for a whacker" do
        reporter.make_report
        output.scan(/test\.rb.+Pinata::Ruby::Cane/).flatten.should_not be_empty
      end
    end
  end
end
