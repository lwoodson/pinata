require 'text-table'

module Pinata
  module Reporters
    class DetailsTable < Base
      def make_report
        table.head = %w[File Whacker Outcome Previous Current]
        project.raw_results.each do |result|
          table.rows << row_for(result)
        end
        table.foot = foot_for(project.raw_results)
        write(table.to_s)
      end

      private
      def table
        @table ||= Text::Table.new
      end

      def row_for(result)
        [
          result.code_change.relative_filepath,
          result.whacker,
          result.outcome,
          result.previous_issues,
          result.current_issues
        ]
      end

      def foot_for(results)
        [
          'Totals',
          '',
          total_outcome_for(results),
          total_previous_issues_for(results),
          total_current_issues_for(results)
        ]
      end

      def total_outcome_for(results)
        results.inject(0) {|memo, result| memo += result.outcome}
      end

      def total_previous_issues_for(results)
        results.inject(0) {|memo, result| memo += result.previous_issues}
      end

      def total_current_issues_for(results)
        results.inject(0) {|memo, result| memo += result.current_issues}
      end
    end
  end
end
