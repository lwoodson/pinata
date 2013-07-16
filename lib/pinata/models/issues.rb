require 'delegate'

module Pinata
  class Issues < SimpleDelegator
    def initialize
      super(Hash.new(0))
    end

    def total
      keys.inject(0) do |memo, key|
        memo += self[key]
      end
    end
  end
end
