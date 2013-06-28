require 'english'
require 'open3'
require 'pinata/version'
require 'pinata/models'
require 'pinata/scm'
require 'pinata/ruby'
require 'pinata/differ'

require 'pinata/filetypes'

module Pinata
  class WhackerFailed < StandardError; end
end
