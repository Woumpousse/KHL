var Solutions = ( function () {


    function zeros(n)
    {
        if ( n == 0 )
        {
            return 1;
        }
        else if ( n % 10 === 0 )
        {
            return 1 + zeros(n / 10);
        }
        else
        {
            return 0;
        }
    }

    function createGrid(width, height, initialValue)
    {
        var result = new Array(width);

        for ( var i = 0; i !== width; ++i )
        {
            result[i] = new Array(height);


            for ( var j = 0; j !== height; ++j )
            {
                result[i][j] = initialValue;
            }
        }

        return result;
    }

    function width(grid)
    {
        return grid.length;
    }

    function height(grid)
    {
        return grid[0].length;
    }

    function slideOne(grid, x, y)
    {
        var val = grid[x][y];
        var i = x - 1;

        while ( i >= 0 && grid[i][y] === null )
        {
            i--;
        }

        grid[x][y] = null;

        if ( i === -1 )
        {
            grid[0][y] = val;
        }
        else if ( grid[i][y] === val )
        {
            grid[i][y] *= 2;
        }
        else
        {
            grid[i + 1][y] = val;
        }
    }

    function slideAll(grid)
    {
        for ( var y = 0; y !== height(grid); ++y )
        {
            for ( var x = width(grid) - 1; x > 0; --x )
            {
                slideOne(grid, x, y);
            }
        }
    }    

    function rotateClockwise(grid)
    {
        var w = width(grid);
        var h = height(grid);

        var result = createGrid( h, w );

        for ( var x = 0; x !== w; ++x )
        {
            for ( var y = 0; y !== h; ++y )
            {
                result[h-y-1][x] = grid[x][y];
            }
        }

        return result;
    }

    function rotateCounterClockwise(grid)
    {
        return rotateClockwise(rotateClockwise(rotateClockwise(grid)));
    }

    return {
        zeros: zeros,
        createGrid: createGrid,
        width: width,
        height: height,
        slideOne: slideOne,
        slideAll: slideAll,
        rotateClockwise: rotateClockwise,
        rotateCounterClockwise: rotateCounterClockwise,
    };
} )();
