require 'git'

module Pinata
  module SCM
    module Git
      def self.current_branch
        git.branch.name 
      end

      def self.git(dir='.')
        @git ||= ::Git.open(dir)
      end
    end
  end
end
