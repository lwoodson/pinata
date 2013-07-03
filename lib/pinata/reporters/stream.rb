# encoding: UTF-8
module Pinata
  module Reporters
    class Stream
      attr_reader :project, :stream

      def initialize(project, stream=STDOUT)
        @project = project
        project.observe {|event| self.update(event)}
        @stream = stream
      end

      def update(event)
        send(event[:type], event)
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
      def starting(event)
        write "Lining up..."
      end

      def code_change(event)
        write "Whacking #{event[:payload].relative_filepath}..."
      end

      def whacker(event)
        if event[:payload]
          write "#{event[:payload].name.capitalize} takes a swing!"
        else
          write "No appropriate whacker found at this party"
        end
      end

      def display(msg)
        output = <<-EOS
PINATA REPORT
=============
#{msg}

See https://github.com/lwoodson/pinata for more details.
        EOS
        write(output.strip)
      end

      def write(msg)
        stream.write(msg)
      end
    end
  end
end
