module Pinata
  module Ruby
    class Cane
      attr_accessor :previous_filepath, :current_filepath, :previous_results,
                    :current_results, :previous_status, :current_status
      def whack
        @previous_results, previous_status = whack_on previous_filepath
        @current_results, current_status = whack_on current_filepath
        previous_violations <=> current_violations
      rescue StandardError => e
        raise Pinata::UnableToParseResults.new(e)
      end

      def whack_on(filepath)
        Open3.capture2e("cane -f #{filepath}")
      end

      def previous_violations
        @previous_violations ||= violations_in previous_results
      end

      def current_violations
        @current_violations ||= violations_in current_results
      end

      def violations_in(result)
        result[/Total Violations: \d+/].split(':')[1].strip.to_i
      end
    end
  end
end
