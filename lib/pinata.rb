require 'english'
require 'open3'
require 'pinata/version'
require 'pinata/ruby'

module Pinata
  class WhackerFailed < StandardError; end

  CodeChange = Struct.new(:previous_filepath, :current_filepath)

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

  class Regressions
    def initialize
      @data = {}
    end

    def offer(result)
      @data[result.whacker] = result if result.regressed?
    end

    def [](key)
      @data[key]
    end
  end
end
