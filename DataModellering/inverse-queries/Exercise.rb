require './Shared.rb'
require './Database.rb'


class Exercise
  def initialize
    @tables = []
    @query = nil
    @solution = nil
    @metadata = {}
  end

  def [](key)
    @metadata[key]
  end

  def []=(key, value)
    @metadata[key] = value
  end

  def finalize
    check_query
  end

  def add_table(table)
    @tables << table
  end

  def solution
    execute unless @solution
    @solution
  end

  attr_reader :tables
  attr_accessor :query

  private
  def execute
    @tables.each do |table|
      Database::execute( table.creation_sql )
      Database::execute( table.insertion_sql )
    end

    @solution = Database::query(@query)

    @tables.each do |table|
      Database::drop_table(table.name)
    end
  end

  def check_query
    throw "Missing query" unless @query
  end
end


class Table
  def initialize(name, headers)
    @name = name
    @rows = []
    @headers = headers
    @types = nil
  end

  def finalize
    check_row_existence
    check_row_sizes
    check_headers
    check_types
  end

  def add_row(data)
    throw "Row size not consistent with headers" unless data.length == @headers.length

    @rows << data
  end

  def creation_sql
    headers = @headers.zip(@types).map do |header, type|
      "#{header} #{type_to_sql(type)}"
    end.join(",\n")

    "CREATE TABLE #{@name}\n(\n#{headers.indent(2)}\n)"
  end

  def insertion_sql
    tuples = @rows.map do |row|
      tuple_string = row.map do |value|
        case value
        when Fixnum then value
        when String then "'#{value}'"
        else abort "Don't know how to convert #{value} to SQL"
        end
      end.join(", ")

      "(#{tuple_string})"
    end.join(",")

    "INSERT INTO #{@name} VALUES #{tuples}"
  end

  attr_reader :name, :rows, :headers

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

  def check_headers
    rowSize = @rows[0].length
    headersSize = @headers.length

    throw "Headers inconsistent with rows" unless rowSize == headersSize
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
