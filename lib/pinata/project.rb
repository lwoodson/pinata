module Pinata
  # Facade into the whole enchilada.
  class Project
    def whack_it!
      code_changes.each do |code_change|
        whacker = whacker_for(code_change)
        next unless whacker
        whacker.start_whacking(code_change).each do |result|
          shift(result.outcome)
          improvements << result if result.improved?
          regressions << result if result.regressed?
        end
      end
    end

    def shift(amt=0)
      @shift ||= 0
      @shift += amt
    end

    def has_changes?
      !code_changes.empty?
    end

    def has_improved?
      !improvements.empty?
    end

    def has_regressed?
      !regressions.empty?
    end

    def has_skipped?
      !skipped.empty? 
    end

    def improvements
      @improvements ||= []
    end

    def regressions
      @regressions ||= []
    end

    def skipped
      @skipped ||= []
    end

    private
    def whacker_for(code_change)
      Pinata::Filetypes.whacker_for(code_change).tap do |whacker|
        skipped << code_change.current_filepath unless whacker
      end
    end

    def code_changes
      @code_changes ||= Pinata::Differ.new.get_code_changes
    end
  end
end
