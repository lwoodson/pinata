require 'git'

module Pinata
  module SCM
    def scm(dir='.')
      # TODO flesh out more, only supporting git right now
      require 'pinata/scm/git'
      @scm ||= Pinata::SCM::Git
    end
  end
end
