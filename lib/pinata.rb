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
      whacker = whacker
    end
  end
end
