# encoding: UTF-8
module Pinata
  module Reporters
    class Stream
      attr_reader :project, :stream

      def initialize(project, stream=STDOUT)
        @project = project
        @stream = stream
      end

      def make_report
        if project.has_changes?
          if project.has_improved?
            msg = "¡Felicidades!  Your project's code has improved.\n\n"
            msg << "Project shift: #{project.shift}"
          elsif project.has_regressed?
            msg = "¡Que Feo!  Your project's code has regressed.\n\n"
            msg << "Project shift: #{project.shift}"
          else
            msg = "¡Ay carramba!  Your project's code shows no improvement.\n\n"
            msg << "Project shift: #{project.shift}"
          end
        else
          msg = 'No changes detected in current project'
        end
        display(msg)
      end

      private
      def display(msg)
        output = <<-EOS
PINATA REPORT
=============
#{msg}

See https://github.com/lwoodson/pinata for more details.
        EOS
        stream.write(output.strip)
      end
    end
  end
end
