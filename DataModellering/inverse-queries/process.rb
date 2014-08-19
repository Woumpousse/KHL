require './Parser.rb'
require './Database.rb'
require './Shared.rb'
require './LaTeX.rb'




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



# puts LaTeX.generate_document(LaTeX.format_exercises( Exercises.exercises ))
