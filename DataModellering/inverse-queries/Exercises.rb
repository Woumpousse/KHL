require './Shared.rb'

class Exercise
  def initialize
    @tables = []
    @query = nil
  end

  def finalize
    check_query
  end

  attr_reader :tables
  attr_accessor :query

  private
  def check_query
    throw "Missing query" unless @query
  end
end


class Table
  def initialize(name, cols)
    @name = name
    @rows = []
    @cols = cols
    @types = nil
  end

  def finalize
    check_row_existence
    check_row_sizes
    check_cols
    check_types
  end

  def add_row(data)
    throw "Row size not consistent with columns" unless data.length == @cols.length

    @rows << data
  end

  def to_sql
    columns = @cols.zip(@types).map do |col, type|
      "#{col} #{type_to_sql(type)}"
    end.join(",\n")

    "CREATE TABLE #{@name}\n(\n#{columns.indent(2)}\n)"
  end

  attr_reader :name, :rows

  private
  def check_row_existence
    throw "Table without rows" unless @rows.length > 0
  end

  def check_row_sizes
    sizes = @rows.map do |row|
      row.length
    end

    minSize = sizes.min
    maxSize = sizes.max

    throw "Rows don't all have the same size" unless minSize == maxSize
    throw "Rows don't contain data" unless minSize > 0
  end

  def check_cols
    rowSize = @rows[0].length
    colSize = @cols.length

    throw "Columns inconsistent with rows" unless rowSize == colSize
  end

  def check_types
    if @types
      rowSize = @rows[0].length
      typeSize = @types.length

      throw "Types inconsistent with rows" unless rowSize == typeSize
    else
      @types = @rows[0].map do |value|
        value.class
      end
    end
  end

  def type_to_sql(type)
    mapping = {
      String => 'VARCHAR(128)',
      Fixnum => 'INTEGER'
    }

    if mapping.has_key? type
    then mapping[type]
    else throw "Unknown SQL type for #{type.to_s}"
    end
  end
end


$exercises = []
$current_exercise = nil
$current_table = nil

def exercise
  abort "Nested exercises are not allowed" if $current_exercise

  $current_exercise = Exercise.new
  yield
  $current_exercise.finalize
  $exercises.push( $current_exercise )
  $current_exercise = nil
end

def table(name, cols)
  abort "Nested tables are not allowed" if $current_table
  abort "Table definitions only allowed within exercises" unless $current_exercise

  $current_table = Table.new(name, cols)
  yield
  $current_table.finalize
  $current_exercise.tables << $current_table
  $current_table = nil
end

def row(data)
  abort "Row definitions only allowed within tables" unless $current_table

  $current_table.add_row(data)
end

def query(string)
  abort "Query only allowed inside exercise" unless $current_exercise
  abort "Query not allowed inside table" if $current_table

  $current_exercise.query = string.unindent  
end


exercise do
  table( 'foo', [ 'col1', 'col2' ] ) do
    row [ 'a', 1 ]
    row [ 'b', 1 ]
    row [ 'b', 2 ]
    row [ 'c', 1 ]
    row [ 'c', 2 ]
    row [ 'c', 3 ]
  end

  query <<-END
    SELECT a, SUM(b)
    FROM foo
    GROUP BY a
  END
end

puts ($exercises[0].tables[0].to_sql)
