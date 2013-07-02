require 'tmpdir'
require 'fileutils'

module Pinata
  class Differ
    include Pinata::SCM

    def get_code_changes
      scm.modified_files.each_with_object([]) do |file, results|
        code_change = build_code_change_for(file)
        handle_remote(code_change)
        copy(local_contents_of(code_change), code_change.current_dir, code_change.current_filepath)
        results << code_change
      end
    end

    private
    def handle_remote(code_change)
      remote_contents = remote_contents_of(code_change)
      if remote_contents.empty?
        code_change.new_file = true
      else
        copy(remote_contents, code_change.previous_dir, code_change.previous_filepath)
      end
    end

    def remote_contents_of(code_change)
      scm.remote_contents_of(code_change.relative_filepath)
    end

    def local_contents_of(code_change)
      scm.local_contents_of(code_change.relative_filepath)
    end

    def copy(contents, dir, path)
      ensure_dir_exists(dir)
      File.open(path, 'w') do |file|
        file.write(contents)
      end
    end

    def ensure_dir_exists(dir)
      FileUtils.mkdir_p(dir) unless Dir.exists?(dir)
    end

    def build_code_change_for(file)
      CodeChange.new.tap do |code_change|
        code_change.previous_dir = previous_dir
        code_change.current_dir = current_dir
        code_change.relative_filepath = file
      end
    end

    def work_dir
      File.join(Dir.tmpdir, 'pinata', Time.new.to_i.to_s)
    end

    def previous_dir
      File.join(work_dir, 'previous')
    end

    def current_dir
      File.join(work_dir, 'current')
    end
  end
end
