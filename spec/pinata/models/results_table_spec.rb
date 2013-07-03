require 'spec_helper'

describe Pinata::ResultsTable do
  let(:code_change) {Pinata::CodeChange.new}
  let(:result) {Pinata::ResultOfWhacking.new(Pinata::Ruby::Cane, code_change)}

  before do
    code_change.relative_filepath = 'test.rb'
    result.outcome = 1
    result.previous_issues = 3
    result.current_issues = 2
  end

  describe "#each" do
    let(:table) {Pinata::ResultsTable.new(result)}

    it "should yield ResultRow for each ResultOfWhacking" do
      result_row = nil
      table.each {|row| result_row = row}
      result_row.file.should == 'test.rb'
      result_row.whacker.kind_of?(Module).should == true
      result_row.outcome.should == 1
      result_row.previous_issues.should == 3
      result_row.current_issues.should == 2
    end
  end

  describe "#totals" do
    let(:table) {Pinata::ResultsTable.new([result, result])}

    it "should have an outcome that is the sum of all result's outcomes" do
      table.totals.outcome.should == 2
    end

    it "should have a previous_issues value that is the sum of all results" do
      table.totals.previous_issues.should == 6
    end

    it "should have a current_issues value that is the sum of all results" do
      table.totals.current_issues.should == 4
    end
  end
end
