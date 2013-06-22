require 'pinata'
require 'pry'

def source_file(name)
  File.join('spec', 'source', name)
end

def ruby_code_change(previous, current)
  Pinata::CodeChange.new.tap do |code_change|
    code_change.relative_filepath = 'test_class.rb'
    code_change.previous_dir = File.join('spec', 'source', previous)
    code_change.current_dir = File.join('spec', 'source', current)
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
