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
      SELECT col1, SUM(col2) as som
      FROM foo
      GROUP BY col1
      ORDER BY col1
    END
  end

  exercise do
    table( 'foo', [ 'col1', 'col2' ] ) do
      row [ 'a', 5 ]
      row [ 'b', 2 ]
      row [ 'c', 3 ]
      row [ 'a', 4 ]
      row [ 'c', 2 ]
      row [ 'c', 6 ]
      row [ 'c', 1 ]
    end

    query <<-END
      SELECT col1, MIN(col2) as min
      FROM foo
      GROUP BY col1
      ORDER BY min
    END
  end
end




puts LaTeX::format_bundle( IO.read('template.tex'), ExerciseDatabase::exercises )



