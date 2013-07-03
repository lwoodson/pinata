module Pinata
  module Ruby
    class Cane
      def self.whack(code_change)
        ResultOfWhacking.new(self, code_change).tap do |result|
          result.previous_issues = previous_issues_in(code_change)
          result.current_issues = whack_on(code_change.current_filepath)
          result.outcome = result.previous_issues <=> result.current_issues
        end
      rescue StandardError => e
        raise Pinata::WhackerFailed.new(e)
      end

      private
      def self.previous_issues_in(code_change)
        if code_change.new_file?
          0
        else
          whack_on(code_change.previous_filepath)
        end
      end

      def self.whack_on(filepath)
        output, status = Open3.capture2e("cane -f #{filepath}")
        issues_in output
      end

      def self.issues_in(result)
        issues_line = result[/Total Violations: \d+/]
        if issues_line
          discard, issues = issues_line.split(':')
          issues = issues.strip.to_i
        else
          0
        end
      end
    end
  end
end
