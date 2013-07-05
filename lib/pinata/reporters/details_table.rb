module Pinata
  module Reporters
    class DetailsTable < Base
      # TODO this needs some work to format properly.
      def make_report
        table = Pinata::ResultsTable.new(project.raw_results)
        write(table.column_names.map(&:capitalize).join("\t\t"))
        if project.has_changes?
          table.each_row do |row|
            write("#{row.file}\t\t#{row.whacker}\t\t#{row.outcome}\t\t#{row.previous_issues}\t\t#{row.current_issues}\n")
          end
        else
          write("\n* no results *\n")
        end
        write("Totals\t\t\t\t#{table.totals.outcome}\t\t#{table.totals.previous_issues}\t\t#{table.totals.current_issues}\n")
      end
    end
  end
end
