module Pinata
  module Ruby
    class Cane
      attr_accessor :previous_filepath, :current_filepath, :previous_results,
                    :current_results, :previous_status, :current_status
      def self.whack(code_change)
        ResultOfWhacking.new(whacker: self.name).tap do |result|
          previous_violations = whack_on(code_change.previous_filepath)
          current_violations = whack_on(code_change.current_filepath)
          result.outcome = previous_violations <=> current_violations
        end
      rescue StandardError => e
        raise Pinata::WhackerFailed.new(e)
      end

      def self.whack_on(filepath)
        output, status = Open3.capture2e("cane -f #{filepath}")
        violations_in output
      end

      def self.violations_in(result)
        result[/Total Violations: \d+/].split(':')[1].strip.to_i
      end
    end
  end
end
