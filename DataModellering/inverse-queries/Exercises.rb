require './Shared.rb'
require './Exercise.rb'
require './ExerciseDatabase.rb'
require './LaTeX.rb'




module ExerciseDatabase
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
end

puts LaTeX::format_exercise( ExerciseDatabase::exercises[0] )
# puts LaTeX::format_table( $exercises[0].solution )
