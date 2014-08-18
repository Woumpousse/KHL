require './Shared.rb'


module LaTeX
  def self.format_exercise(exercise)
    formatted_input_tables = format_input_tables(exercise.tables)
    formatted_query = format_query(exercise.query)

    <<-END
      \\begin{exercise}
      #{formatted_input_tables}
      #{formatted_query}
      \\end{exercise}
    END
  end

  def self.format_query(query)
    <<-END
      \\begin{center}
        \\begin{minipage}{.8\\textwidth}
          \\begin{center}
            \\begin{tabular}{c}
              \\begin{lstlisting}
                #{query}
              \\end{lstlisting}
           \\end{tabular}
          \\end{center}
        \\end{minipage}
      \\end{center}
    END
  end

  def self.format_input_tables(tables)
    formatted_tables = tables.map do |table_name, table|
      format_named_table(table_name, table)
    end.join

    <<-END
      \\begin{center}
        #{formatted_tables.indent}
      \\end{center}
    END
  end

  def self.format_named_table(table_name, table)
    formatted_table = format_table(table)

    <<-END
      \\namedtable{#{table_name}}{
      #{formatted_table.strip.indent}
      }
    END
  end

  def self.format_table(table)
    headers, rows = table.headers, table.rows

    colSpecs = "{" + "c" * headers.length + "}"

    formattedHeaders = headers.map do |header|
      "{\\bf #{header}}"
    end.join(" & ")

    formattedRows = rows.map do |row|
      row.join(" & ") + " \\\\"
    end.join("\n")

    <<-END
      \\begin{tabular}#{colSpecs}
        #{formattedHeaders} \\\\
        \\toprule
      #{formattedRows.indent}
      \\end{tabular}
    END
  end
end
