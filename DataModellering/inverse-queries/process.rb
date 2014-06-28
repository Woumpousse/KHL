require 'logger'
require './Parser.rb'
require './Database.rb'


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



module LaTeX
  def self.format_exercise_sets(exercise_sets)
    exercise_sets.map do |exercise_set|
      format_exercise_set(exercise_set)
    end.join("\n")
  end

  def self.format_exercise_set(exercises)
    <<END
\\begin{questionset}
#{format_exercises(exercises).indent}
\\end{questionset}
END
  end

  def self.format_exercises(exercises)
    exercises.map { |exercise| format_exercise(exercise) }.join("\n")
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

  def self.format_solution(table)
    format_table(table)
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
  def self.from_hash(hash)    
    category = hash['category'].join or raise "Missing category (line #{hash[:line]})"
    difficulty = hash['difficulty'].join.to_i or raise "Missing difficulty (line #{hash[:line]})"
    setup = hash['setup'].join("\n") or raise "Missing setup (line #{hash[:line]})"
    query = hash['query'].join("\n") or raise "Missing query (line #{hash[:line]})"

    Exercise.new(category, difficulty, setup, query)
  end

  def initialize(category, difficulty, setup, query)
    @category = category
    @difficulty = difficulty
    @setup = setup
    @query = query
  end

  def tables
    solve unless @tables
    @tables
  end

  def solution
    solve unless @solution
    @solution
  end

  attr_reader :category, :difficulty, :setup, :query

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


module Exercises
  @@exercises = []

  def self.add(exercise)
    @@exercises.push(exercise)
  end

  def self.read_from_string(string)
    Parser.parse_lines(string.lines).each do |hash|
      add(Exercise.from_hash(hash))
    end
  end

  def self.read_from_file(filename)
    read_from_string(IO.read(filename))
  end

  def self.exercises
    @@exercises
  end
end


Exercises.read_from_file('exercises.txt')

p Exercises.exercises

# puts LaTeX.generate_document(LaTeX.format_exercises( Exercises.exercises ))
