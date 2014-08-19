require './Shared.rb'
require './Exercise.rb'
require './ExerciseDatabase.rb'
require './LaTeX.rb'


module ExerciseDatabase
  category('aggregatie') do
    difficulty(:easy) do
      exercise do
        table( 'foo', [ 'col1', 'col2' ] ) do
          row [ 'a', 2 ]
          row [ 'b', 1 ]
          row [ 'b', 2 ]
          row [ 'c', 1 ]
          row [ 'c', 1 ]
          row [ 'c', 3 ]
        end

        query <<-END
          SELECT col1, SUM(col2) as sum
          FROM foo
          GROUP BY col1
          ORDER BY col1 ASC
        END
      end

      exercise do
        table( 'foo', [ 'col1', 'col2' ] ) do
          row [ 'a', 2 ]
          row [ 'b', 1 ]
          row [ 'b', 2 ]
          row [ 'c', 1 ]
          row [ 'c', 1 ]
          row [ 'c', 3 ]
        end

        query <<-END
          SELECT col1, COUNT(col2) as count
          FROM foo
          GROUP BY col1
          ORDER BY col1 ASC
        END
      end

      exercise do
        table( 'foo', [ 'col1', 'col2' ] ) do
          row [ 'a', 2 ]
          row [ 'b', 1 ]
          row [ 'b', 2 ]
          row [ 'c', 1 ]
          row [ 'c', 1 ]
          row [ 'c', 3 ]
        end

        query <<-END
          SELECT col1, MAX(col2) as max
          FROM foo
          GROUP BY col1
          ORDER BY col1 ASC
        END
      end

      exercise do
        table( 'foo', [ 'col1', 'col2' ] ) do
          row [ 'a', 2 ]
          row [ 'b', 1 ]
          row [ 'b', 2 ]
          row [ 'c', 1 ]
          row [ 'c', 1 ]
          row [ 'c', 3 ]
        end

        query <<-END
          SELECT col1, MIN(col2) as min
          FROM foo
          GROUP BY col1
          ORDER BY col1 ASC
        END
      end
    end

    difficulty(:medium) do
      exercise do
        table( 'foo', [ 'col1', 'col2' ] ) do
          row [ 'c', 2 ]
          row [ 'a', 1 ]
          row [ 'b', 2 ]
          row [ 'd', 'NULL' ]
          row [ 'c', 1 ]
          row [ 'b', 1 ]
          row [ 'c', 3 ]
          row [ 'd', 3 ]
          row [ 'e', 'NULL' ]
        end

        query <<-END
          SELECT col1, SUM(col2) as som, COUNT(col2) as count
          FROM foo
          GROUP BY col1
          ORDER BY col1 ASC
        END
      end

      exercise do
        table( 'foo', [ 'col1', 'col2' ] ) do
          row [ 'a', 5 ]
          row [ 'b', 2 ]
          row [ 'c', 3 ]
          row [ 'a', 2 ]
          row [ 'c', 2 ]
          row [ 'c', 6 ]
          row [ 'c', 1 ]
          row [ 'd', 2 ]
          row [ 'd', 3 ]
        end

        query <<-END
          SELECT col1, MIN(col2) as min, MAX(col2) as max
          FROM foo
          GROUP BY col1
          ORDER BY min ASC, max ASC
        END
      end
    end
  end # category('aggregatie')

  category('inner join') do
    
  end
end




# puts LaTeX::format_bundle( IO.read('template.tex'), ExerciseDatabase::exercises )

ExerciseDatabase::exercises.each do |exercise|
  puts exercise[:difficulty]
  puts( LaTeX::format_table(exercise.solution) )
end
