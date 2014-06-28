require 'sqlite3'


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

