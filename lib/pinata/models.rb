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


  # Represents the regressions introduced with a code change.
  class Regressions
    def initialize
      @data = {}
    end

    # Offers the result to the regression, which will accept it if it
    # has regressed.
    def offer(result)
      @data[result.whacker] = result if result.regressed?
    end

    # Retrieve the ResultOfWhacking that encapsulates the details of the
    # regression by its key.
    def [](key)
      @data[key]
    end

    # Iterates over all accepted regressions, passing each to a supplied
    # block.
    def each(&block)
      @data.keys.each do |key|
        block.call(@data[key])
      end
    end
  end
end
