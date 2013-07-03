module Pinata
  # Represents a change in code
  class CodeChange
    attr_accessor :relative_filepath, :previous_dir, :current_dir
    attr_writer :new_file

    def initialize
      new_file = false
    end

    def previous_filepath
      if new_file?
        ''
      else
        File.join(previous_dir, relative_filepath)
      end
    end

    def current_filepath
      File.join(current_dir, relative_filepath)
    end

    def new_file?
      @new_file ||= false
    end
  end
end
