module Pinata
  module Ruby
    class Cane
      def self.whack(code_change)
        ResultOfWhacking.new(self, code_change).tap do |result|
          previous_violations = previous_violations_in(code_change)
          current_violations = whack_on(code_change.current_filepath)
          result.outcome = previous_violations <=> current_violations
        end
      rescue StandardError => e
        raise Pinata::WhackerFailed.new(e)
      end

      private
      def self.previous_violations_in(code_change)
        if code_change.new_file?
          0
        else
          whack_on(code_change.previous_filepath)
        end
      end

      def self.whack_on(filepath)
        output, status = Open3.capture2e("cane -f #{filepath}")
        violations_in output
      end

      def self.violations_in(result)
        violations_line = result[/Total Violations: \d+/]
        if violations_line
          discard, violations = violations_line.split(':')
          violations = violations.strip.to_i
        else
          0
        end
      end
    end
  end
end
