# require 'sqlite3'

# $db = SQLite3::Database.new ":memory:"

module Database
  @@db = nil

  def self.initialize
#    @@db = SQLite3::Database.new ":memory:"
  end

  def self.execute(sql)
#    @@db.execute(sql)
  end

  def self.raw_query(sql)
#    @@db.execute2(sql)
  end

  def self.query(sql)
    headers, *rows = raw_query(sql)

    Table.new(headers, rows)
  end

  def self.get_table(table_name)
    query("SELECT * FROM #{table_name}")
  end

  def self.drop_table(table_name)
    execute("DROP TABLE #{table_name}")
  end
end

class String
  def indent
    lines.map { |s| "  " + s }.join
  end

  def unindent
    lines.map { |s| s.strip }.join("\n")
  end

  def blocks
    result = []
    current = ""
    
    lines.each do |line|
      if line.start_with?("#") then
        result.push(current)
        current = line
      else
        current += line
      end

      result.push(current)

      result
    end
  end
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
  def initialize(headers, rows)
    @headers = headers
    @rows = rows
  end

  attr_reader :headers, :rows
end



class Exercise
  # def self.parse(data)
  #   data =~ /#SETUP(.+)#QUERY(.+)$/m or abort "Could not read\n#{indent(data)}"
  #   setup, query = $1.strip, unindent($2)
  #   table_names = setup.scan(/CREATE TABLE (\w+) \(/).map { |x| x[0] } or abort "Could not find tables in\n#{indent(data)}"

  #   setup.split("\n\n").each do |sql|
  #     Database.execute(sql)
  #   end

  #   inputTables = table_names.map do |table_name|
  #     Database.get_table(table_name)
  #   end

  #   headers, *rows = Database.query(query)

  #   table_names.each do |table_name|
  #     Database.drop_table(table_name)
  #   end

  #   Exercise.new(inputTables, query, solutionTable)
  # end

  def self.parse(string)
    p(string.blocks)
  end

  def initialize(data)
    @data = data
  end

  def method_missing(id)
    @data[name.id2name]
  end
end



def process_file(data)
  data.scan(/#Exercise(.+?)#End/m).map do |exercise|
    exercise[0].strip
  end.each do |exercise|
    Exercise.parse(exercise)
  end
end


# process_file(IO.read('inner-joins.txt'))


x = <<END
#jfklfj jflf
fjdklf
fjdkl

#fjlkf fjkl
END

p(x.blocks.join(" | "))
