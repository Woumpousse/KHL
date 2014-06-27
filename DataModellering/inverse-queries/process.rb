require 'sqlite3'
require 'logger'

class Array
  def pick(n)
    (0..length-1).to_a.shuffle[0..n-1].map do |i|
      self[i]
    end
  end
end


class String
  def indent(n = 2)
    lines.map { |s| (" " * n) + s }.join
  end

  def unindent
    lines.map { |s| s.strip }.join("\n")
  end

  def blocks
    result = Hash.new
    name = nil
    accumulator = ""
    
    strip.lines.each do |line|
      if line.start_with?("#") then
        result[name] = accumulator
        name = line[1..-1].strip
        accumulator = ""
      else
        accumulator += line
      end

      result[name] = accumulator
    end

    result
  end
end


module Log
  @@err = Logger.new(STDERR)

  def self.error( msg )
    @@err.error( msg )
  end

  def self.info( msg )
    @err.info( msg )
  end
end


module Database
  @@db = SQLite3::Database.new ":memory:"

  class DatabaseError < Exception

  end

  def self.execute(sql)
    begin
      @@db.execute2(sql)
    rescue SQLite3::Exception => e
      Log.error( <<END )
#{e.to_s.indent}
while executing
#{sql.indent}
END
      raise DatabaseError
    end
  end

  def self.query(sql)
    headers, *rows = execute(sql)

    Table.new(headers, rows)
  end

  def self.get_table(table_name)
    headers, *rows = execute("SELECT * FROM #{table_name}")
    Table.new(headers, rows)
  end

  def self.drop_table(table_name)
    execute("DROP TABLE #{table_name}")
  end

  class Table
    def initialize(headers, rows)
      @headers = headers
      @rows = rows
    end

    attr_reader :headers, :rows
  end
end


module LaTeX
  def self.format_exercises(exercises)
    generate_document( exercises.map { |exercise| format_exercise(exercise) }.join("\n") )
  end

  def self.generate_document(contents)
    IO.read('template.tex').gsub('%TEMPLATE%') { contents }
  end

  def self.format_exercise(exercise)
    formatted_input_tables = format_input_tables(exercise.tables)
    formatted_query = format_query(exercise.query)

    <<END
\\begin{exercise}
#{formatted_input_tables}
#{formatted_query}
\\end{exercise}
END
  end

  def self.format_query(query)
    <<END
\\begin{center}
  \\begin{minipage}{.8\\textwidth}
    \\begin{center}
      \\begin{tabular}{c}
        \\begin{lstlisting}
#{query.unindent}
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

    <<END
\\begin{center}
#{formatted_tables.indent}
\\end{center}
END
  end

  def self.format_named_table(table_name, table)
    formatted_table = format_table(table)

    <<END
\\namedtable{#{table_name}}{
#{formatted_table.indent}
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

    <<END
\\begin{tabular}#{colSpecs}
  #{formattedHeaders} \\\\
  \\toprule
#{formattedRows.indent}
\\end{tabular}
END

  end
end


class Exercise
  def self.parse(string)
    Exercise.new(string.blocks)
  end

  def initialize(data)
    @data = data
  end

  def method_missing(id)
    @data[id.id2name]
  end

  def tables
    solve unless @tables
    @tables
  end

  def solution
    solve unless @solution
    @solution
  end

  private
  def solve
    initialize_tables
    build_solution
    drop_tables
  end

  def initialize_tables
    setup.strip.split("\n\n").each do |sql|
      Database.execute(sql)
    end

    @tables = Hash.new

    find_table_names.each do |table_name|
      @tables[table_name] = Database.get_table(table_name)
    end
  end

  def build_solution
    @solution = Database.query(self.query)
  end

  def drop_tables
    find_table_names.each do |table_name|
      Database.drop_table(table_name)
    end
  end

  def find_table_names
    table_names = setup.scan(/CREATE TABLE (\w+) \(/).map { |x| x[0] } or abort "Could not find tables in\n#{indent(setup)}"
  end
end


def read_exercises(data)
  exercises = data.scan(/#exercise(.+?)#end/m).map do |exercise|
    exercise[0].strip
  end.map do |exercise|
    begin
      Exercise.parse(exercise)
    rescue Database::DatabaseError => e
      p e
    end
  end

  exercises
end


$exercises = read_exercises(IO.read('inner-joins.txt'))
$exercise = $exercises[0]

# p $exercise.tables
puts (LaTeX.format_exercises $exercises)


