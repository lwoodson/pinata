module Pinata
  ResultsRow = Struct.new(:file, :whacker, :outcome, :previous_issues, :current_issues)
  TotalsRow = Struct.new(:outcome, :previous_issues, :current_issues)

  class ResultsTable
    attr_reader :results

    def initialize(results)
      @results = Array(results)
    end

    def each(&block)
      results.each do |result|
        row = ResultsRow.new(result.code_change.relative_filepath, result.whacker, result.outcome, result.previous_issues, result.current_issues)
        block.call(row)
      end      
    end

    def totals
      TotalsRow.new(outcome_sum, previous_issues_sum, current_issues_sum)
    end

    private
    def outcome_sum
      results.inject(0) {|memo, result| memo += result.outcome}
    end

    def previous_issues_sum
      results.inject(0) {|memo, result| memo += result.previous_issues}
    end

    def current_issues_sum
      results.inject(0) {|memo, result| memo += result.current_issues}
    end
  end
end
