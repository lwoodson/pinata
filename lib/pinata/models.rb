module Pinata
  # Represents a change in code
  class CodeChange
    attr_accessor :relative_filepath, :previous_dir, :current_dir

    def previous_filepath
      File.join(previous_dir, relative_filepath)
    end

    def current_filepath
      File.join(current_dir, relative_filepath)
    end
    #attr_accessor :relative_filepath, :previous_filepath, :current_filepath
  end


  # The result of whacking the pinata that is your code by a specific
  # whacker for some sort of code inspection tool.
  class ResultOfWhacking
    attr_reader :whacker
    attr_accessor :outcome
    def initialize(whacker)
      @whacker = whacker
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
