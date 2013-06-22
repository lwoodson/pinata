require 'english'
require 'open3'
require 'pinata/version'
require 'pinata/ruby'

module Pinata
  class WhackerFailed < StandardError; end

  # Represents a change in code
  CodeChange = Struct.new(:previous_filepath, :current_filepath)

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
