require 'pinata'
require 'pry'
require 'tmpdir'

def source_file(name)
  File.join('spec', 'source', name)
end

def ruby_code_change(previous, current, opts={})
  Pinata::CodeChange.new.tap do |code_change|
    code_change.relative_filepath = 'test_class.rb'
    code_change.current_dir = File.join('spec', 'source', current)
    if opts[:new_file]
      code_change.new_file = true
    else
      code_change.previous_dir = File.join('spec', 'source', previous)
    end
  end
end

def improving_ruby_code_change
  ruby_code_change('craptacular', 'elegant')
end

def regressing_ruby_code_change
  ruby_code_change('elegant', 'craptacular')
end

def static_ruby_code_change
  ruby_code_change('elegant', 'elegant')
end

def code_change_with_no_result
  ruby_code_change('empty', 'empty')
end

def code_change_for_new_file
  ruby_code_change(nil, 'elegant', new_file: true)
end
