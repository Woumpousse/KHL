require './ExercisePool.rb'


# Extends the exercise pool
module ExercisePool

  # All exercises in this block will be categorized automatically
  # It is also possible to add categories manually
  auto_categorize do

    #
    # Easy difficulty
    #
    difficulty(:easy) do
      exercise(__FILE__, __LINE__) do
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

      exercise(__FILE__, __LINE__) do
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

      exercise(__FILE__, __LINE__) do
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

      exercise(__FILE__, __LINE__) do
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

      exercise(__FILE__, __LINE__) do
        table( 'foo', [ 'id', 'col' ] ) do
          row [ 1, 'a' ]
          row [ 2, 'b' ]
          row [ 3, 'c' ]
        end

        table( 'bar', [ 'id', 'col' ] ) do
          row [ 1, 'x' ]
          row [ 2, 'y' ]
          row [ 3, 'z' ]
        end

        query <<-END
          SELECT foo.col, bar.col
          FROM foo
          INNER JOIN bar ON foo.id = bar.id
          ORDER BY foo.col, bar.col
        END
      end

      exercise(__FILE__, __LINE__) do
        table( 'foo', [ 'col1' ] ) do
          row [ 1 ]
          row [ 2 ]
          row [ 3 ]
        end

        table( 'bar', [ 'col1', 'col2' ] ) do
          row [ 1, 'x' ]
          row [ 2, 'y' ]
          row [ 2, 'z' ]
        end

        query <<-END
          SELECT foo.col1, COUNT(bar.col2)
          FROM foo
          INNER JOIN bar ON foo.col1 = bar.col1
          GROUP BY foo.col1
          ORDER BY foo.col1
        END
      end

    end


    #
    # Medium difficulty
    #
    difficulty(:medium) do
      exercise(__FILE__, __LINE__) do
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

      exercise(__FILE__, __LINE__) do
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


    #
    # Hard difficulty
    #
    difficulty(:hard) do
      exercise(__FILE__, __LINE__) do
        table( 'foo', [ 'col1', 'col2', 'col3' ] ) do
          row [ 'a', 'a', 1 ]
          row [ 'a', 'a', 2 ]
          row [ 'a', 'b', 3 ]
          row [ 'a', 'b', 4 ]
          row [ 'a', 'b', 5 ]
          row [ 'b', 'a', 'NULL' ]
          row [ 'b', 'b', 2 ]
          row [ 'b', 'b', 'NULL' ]
        end

        query <<-END
          SELECT col1, col2, SUM(col3) as som, COUNT(col3) as count
          FROM foo
          GROUP BY col1, col2
          ORDER BY col1 ASC
        END
      end
    end
  end
end

