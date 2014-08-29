require 'sqlite3'


module Database
  @@db = SQLite3::Database.new ":memory:"

  class DatabaseError < Exception
    def initialize(message, sql)
      @message = message
      @sql = sql
    end

    attr_reader :message, :sql

    def to_s
      self.message
    end
  end

  class SimpleTable
    def initialize(headers, rows)
      @headers = headers
      @rows = rows
    end

    attr_reader :headers, :rows
  end

  def self.execute(sql)
    begin
      @@db.execute2(sql)
    rescue SQLite3::Exception => e
      # puts( <<-END.unindent )
      #   #{e.to_s.indent}
      #   while executing
      #   #{sql.indent}
      #   END
      raise DatabaseError.new(e.to_s, sql)
    end
  end

  def self.query(sql)
    headers, *rows = execute(sql)

    SimpleTable.new(headers, rows)
  end

  def self.get_table(table_name)
    headers, *rows = execute("SELECT * FROM #{table_name}")
    Table.new(headers, rows)
  end

  def self.drop_table(table_name)
    execute("DROP TABLE #{table_name}")
  end
end
