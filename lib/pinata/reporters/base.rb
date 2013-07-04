# encoding: UTF-8
module Pinata
  module Reporters
    class Base
      attr_reader :project, :stream

      def initialize(project, stream=STDOUT)
        @project = project
        @stream = stream
      end

      private
      def write(msg)
        stream.write(msg)
      end
    end
  end
end
