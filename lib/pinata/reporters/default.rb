# encoding: UTF-8
module Pinata
  module Reporters
    class Default < Base
      def initialize(project, stream=STDOUT)
        super(project, stream)
        project.observe {|event| self.update(event)}
      end

      def update(event)
        send(event[:type], event)
      end

      def make_report
        if project.has_changes?
          msg = "Looks like something popped out!  Lets take a look...\n"
          msg << "#{emoticon} #{description} (#{project.shift})"
        else
          msg = "There is nothing here.  The pinata just dangles there mockingly"
        end
        write(msg)
      end

      private
      def description
        if project.shift > 0
          "Your project's code has improved!"
        elsif project.shift < 0
          "Your project's code has degraded!"
        else
          "It doesn't appear that you left any mark whatsoever"
        end
      end

      def emoticon
        if project.shift > 0
          ":)"
        elsif project.shift < 0
          ":O"
        else
          ":|"
        end
      end

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
    end
  end
end
