require 'pinata/ruby/cane'

module Pinata
  # Module containing all of the angry kids appropriate for Ruby files.
  module Ruby
    @whackers = []

    # Collect any classes that have wound up in the Pinata::Ruby namespace
    # by now as whackers.
    constants.each do |constant|
      constant = const_get(constant)
      @whackers << constant if constant.kind_of?(Class)
    end

    class << self
      def whackers
        @whackers.dup
      end

      # Starts all the angry kids whacking on your file to see
      # if any new candy regressions spill out.
      def start_whacking(code_change)
        Pinata::Regressions.new.tap do |regressions|
          whackers.each do |whacker|
            regressions.offer(whacker.whack(code_change))
          end
        end
      end
    end
  end
end
