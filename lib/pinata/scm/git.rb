require 'git'

module Pinata
  module SCM
    module Git
      def self.modified_files
        diff = git.diff(local_branch, remote_branch(local_branch))
        diff.stats[:files].keys
      end

      def self.current_branch
        git.branch.name
      end

      def self.git(dir='.')
        @git ||= ::Git.open(dir)
      end

      private
      def self.local_branch
        git.branches.local.find{|branch| branch.current}
      end

      def self.remote_branch(local)
        remotes = git.branches.remote.to_a
        remotes.reject(&pointers).find(&remote_of(local))
      end

      # Identifies remotes/origin/HEAD -> origin/master named branches
      # that we have to avoid (not sure why)
      def self.pointers
        lambda {|branch| branch.full[/->/]}
      end

      def self.remote_of(local)
        lambda {|branch| branch.full.split('/')[-1] == local.name}
      end
    end
  end
end
