require 'git'

module Pinata
  module SCM
    module Git
      class << self
        # Returns the underlying repository interface.  Part of a public API
        # that any other SCM modules would need to implement
        def repo(dir='.')
          @git ||= ::Git.open(dir)
        end

        alias_method :git, :repo

        # Returns the name of the current branch.  Part of a public API that
        # any other SCM modules would need to implement.
        def current_branch
          git.branch.name
        end

        # Returns all files modified between the local and remote branches.
        # Part of a public API that any other SCM modules would need to implement.
        def modified_files
          diff = git.diff(local_branch, remote_branch(local_branch))
          diff.stats[:files].keys
        end

        # Returns the contents of the local head of current branch.
        def local_contents_of(file)
          contents_of(local_branch, file)
        end

        # Returns the remote contents of the remote head of current branch
        def remote_contents_of(file)
          contents_of(remote_branch(local_branch), file)
        end

        private
        def contents_of(branch, file)
          recurse = lambda do |tree, file|
            next_part, *remainder = file.split(File::SEPARATOR)
            if remainder.empty?
              blob = tree ? tree.blobs[next_part] : nil
              blob ? blob.contents : ''
            else
              recurse.call(tree.subtrees[next_part], remainder.join(File::SEPARATOR))
            end
          end
          recurse.call(branch.gcommit.gtree, file)
        end

        def local_branch
          git.branches.local.find{|branch| branch.current}
        end

        def remote_branch(local)
          remotes = git.branches.remote.to_a
          remotes.reject(&pointers).find(&remote_of(local))
        end

        # Identifies remotes/origin/HEAD -> origin/master named branches
        # that we have to avoid (not sure why)
        def pointers
          lambda {|branch| branch.full[/->/]}
        end

        def remote_of(local)
          lambda {|branch| branch.full.split('/')[-1] == local.name}
        end
      end
    end
  end
end
