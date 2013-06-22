require 'set'

module Pinata
  module Filetypes
    class Mappings
      def initialize(&block)
        @mappers = Set.new
        self.instance_exec &block
      end

      # Maps a regular expression to a filetype module.
      def map(regex, filetype_module)
        @mappers << [regex, filetype_module]
      end

      def filetype_module_for(filename)
        mapper = @mappers.find {|tuple| tuple[0] =~ filename}
        mapper ? mapper[1] : nil
      end
    end

    @mappings = Mappings.new do
      map(/.+\.rb$/, Pinata::Ruby)
    end

    class << self
      def whacker_for(code_change)
        @mappings.filetype_module_for(code_change.relative_filepath)
      end
    end
  end
end
