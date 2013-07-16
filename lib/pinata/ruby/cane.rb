module Pinata
  module Ruby
    class Cane
      def self.whack(code_change)
        ResultOfWhacking.new(self, code_change).tap do |result|
          result.previous_issues = previous_issues_in(code_change)
          result.current_issues = whack_on(code_change.current_filepath)
          result.outcome = result.previous_issues.total <=> result.current_issues.total
        end
      rescue StandardError => e
        raise Pinata::WhackerFailed.new(e).tap {|ex| ex.set_backtrace(e.backtrace)}
      end

      private
      def self.previous_issues_in(code_change)
        if code_change.new_file?
          Issues.new
        else
          whack_on(code_change.previous_filepath)
        end
      end

      def self.whack_on(filepath)
        output, status = Open3.capture2e("cane -f #{filepath}")
        issues_in output
      end

      def self.issues_in(result)
        Issues.new.tap do |issues|
          result.split("\n").each do |line|
            if line =~ /^\s/
              key = line.split[1..-1].join(' ')
              issues[key] += 1
            end
          end
        end
      end
    end
  end
end
