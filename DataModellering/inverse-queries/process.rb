require 'sqlite3'

$db = SQLite3::Database.new ":memory:"


def indent(string)
  string.lines.map { |s| "  " + s }.join
end

def unindent(string)
  string.lines.map { |s| s.strip }.join("\n")
end

def format_table(headers, rows)
  colSpecs = "{" + "c" * headers.length + "}"

  formattedHeaders = headers.map do |header|
    "{\\bf #{header}}"
  end.join(" & ")

  formattedRows = rows.map do |row|
    row.join(" & ")
  end

<<END
\\begin{tabular}#{colSpecs}
  #{formattedHeaders} \\\\
  \\toprule
  #{formattedRows}"
\\end{tabular}
END
end


class Table
  def initialize(name, headers, rows)
    @name = name
    @headers = headers
    @rows = rows
  end

  attr_reader :name, :headers, :rows
end

class Exercise
  def self.parse(data)
    data =~ /#SETUP(.+)#QUERY(.+)$/m or abort "Could not read\n#{indent(data)}"
    setup, query = $1.strip, unindent($2)
    tableNames = setup.scan(/CREATE TABLE (\w+) \(/).map { |x| x[0] } or abort "Could not find tables in\n#{indent(data)}"

    setup.split("\n\n").each do |sql|
      $db.execute(sql)
    end

    inputTables = tableNames.map do |tableName|
      headers, *rows = $db.execute2("SELECT * FROM #{tableName}")
      Table.new(tableName, headers, rows)
    end

    headers, *rows = $db.execute2(query)
    solutionTable = Table.new("solution", headers, rows)

    tableNames.each do |tableName|
      $db.execute("DROP TABLE #{tableName}")
    end

    Exercise.new(inputTables, query, solutionTable)
  end

  def initialize(tables, query, solution)
    @tables = tables
    @query = query
    @solution = solution
  end

  attr_reader :tables, :query, :solution
end


# def process_exercise(data)
#   begin
#     db = SQLite3::Database.new ":memory:"

#     data =~ /#SETUP(.+)#QUERY(.+)$/m or abort "Could not read\n#{indent(data)}"
#     setup, query = $1.strip, $2.strip
#     tableNames = setup.scan(/CREATE TABLE (\w+) \(/).map { |x| x[0] } or abort "Could not find tables in\n#{indent(data)}"

#     setup.split("\n\n").each do |sql|
#       db.execute(sql)
#     end

#     inputTables = tableNames.map do |tableName|
#       headers, *rows = db.execute2("SELECT * FROM #{tableName}")
#       Table.new(tableName, headers, rows)
#     end

#     headers, *rows = db.execute2(query)
#     solutionTable = Table.new("solution", headers, rows)

#     tableNames.each do |tableName|
#       db.execute("DROP TABLE #{tableName}")
#     end

#     Exercise.new(inputTables, query, solutionTable)

#   rescue SQLite3::Exception => e
#     puts "Error"
#     puts "#{indent(e.to_s)}"
#     puts "while processing"
#     puts(indent(data))

#     abort

#   ensure
#     db.close
#   end
# end


def process_file(data)
  data.scan(/#EXERCISE(.+?)#END/m).map do |exercise|
    exercise[0].strip
  end.each do |exercise|
    # process_exercise(exercise)
    p Exercise.parse(exercise)
  end
end


process_file(IO.read('inner-joins.txt'))


# def process(contents)
#   begin
#     puts "Creating database..."
#     db = SQLite3::Database.new ":memory:"

#     contents.gsub(/%<(.*?)%>/m) do |match|
#       command = $1.strip

#       case command
#       when /^SQL(.*)$/m
#         $1.split(/;/).select do |x|
#           x.strip.length > 0
#         end.each do |sql|
#           puts "Executing\n#{sql.strip}\n\n"
#           db.execute(sql)
#         end

#         ""

#       when /^SELECT-TABLE(.*)$/m
#         sql = $1

#         puts "Formatting table for\n#{sql.strip}\n\n"
#         headers, *rows = db.execute2(sql)

#         latexPrefix = "\\begin{tabular}{#{"l" * headers.length}}\n"
#         latexPostfix= "\\end{tabular}\n"

#         latexHeaders = headers.map { |x| "\\textbf{#{x}}" }.join(" & ") + ' \\\\ \toprule' + "\n"
#         latexRows = rows.map do |row|
#           row.map do |value|
#             if value == nil
#             then "\\textsc{null}"
#             else value
#             end
#           end.join(" & ")
#         end.join(" \\\\\n") + "\n"

#         latexPrefix + latexHeaders + latexRows + latexPostfix

#       when /^EXECUTE-SCRIPT(.*)$/m
#         script = $1.strip
#         puts "Executing script {#1}"

#         IO.readlines(script).join.split(';').map { |x| x.strip }.select { |x| x.length > 0 }.each do |sql|
#           puts "Executing\n#{sql}"
#           db.execute(sql)
#         end

#         ""
#       else
#         puts "Unknown command\n#{command}"
#         abort
#       end
#     end

#   rescue SQLite3::Exception => e
#     puts "Error\n#{e}"
#     abort
#   ensure
#     db.close
#   end
# end


# Dir['*.template'].each do |input|
#   input =~ /^(.*)\.template$/
#   output = $1

#   puts "PROCESSING #{input} -> #{output}"
#   contents = IO.readlines(input).join
#   result = process(preprocess(contents))

#   File.open(output, 'w') do |out|
#     out.write result
#   end
# end


