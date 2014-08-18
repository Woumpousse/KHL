require './Exercise.rb'



module ExerciseDatabase
  @@exercises = []
  @@current_exercise = nil
  @@current_table = nil

  def self.exercises
    @@exercises
  end

  def self.exercise
    abort "Nested exercises are not allowed" if @@current_exercise

    @@current_exercise = Exercise.new
    yield
    @@current_exercise.finalize
    @@exercises.push( @@current_exercise )
    @@current_exercise = nil
  end

  def self.table(name, cols)
    abort "Nested tables are not allowed" if @@current_table
    abort "Table definitions only allowed within exercises" unless @@current_exercise

    @@current_table = Table.new(name, cols)
    yield
    @@current_table.finalize
    @@current_exercise.add_table( @@current_table )
    @@current_table = nil
  end

  def self.row(data)
    abort "Row definitions only allowed within tables" unless @@current_table

    @@current_table.add_row(data)
  end

  def self.query(string)
    abort "Query only allowed inside exercise" unless @@current_exercise
    abort "Query not allowed inside table" if @@current_table

    @@current_exercise.query = string.unindent  
  end
end
