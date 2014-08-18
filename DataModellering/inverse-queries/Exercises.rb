require './Shared.rb'
require './Exercise.rb'
require './LaTeX.rb'


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
  $current_exercise.add_table( $current_table )
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
    SELECT col1, SUM(col2)
    FROM foo
    GROUP BY col1
  END
end

p $exercises[0].solution
