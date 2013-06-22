module Pinata
  module SCM
    module Git
      def self.current_branch
        # TODO replace this with ruby git lib
        `git branch | awk '{print $2}'`.strip
      end
    end
  end
end
