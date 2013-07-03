module Pinata
  # The result of whacking the pinata that is your code by a specific
  # whacker for some sort of code inspection tool.
  class ResultOfWhacking
    attr_reader :whacker, :code_change
    attr_accessor :outcome, :previous_issues, :current_issues

    def initialize(whacker, code_change)
      @whacker = whacker
      @code_change = code_change
    end

    def improved?
      outcome > 0
    end

    def regressed?
      outcome < 0
    end

    def unchanged?
      outcome == 0
    end
  end
end
