module Solutions
{
    export function createGrid<T>(width : number, height : number, value : T) : Array<Array<T>> {
        var result = new Array(width);

        for ( var i = 0; i !== width; ++i ) {
            result[i] = new Array(height);

            for ( var j = 0; j !== height; ++j ) {
                result[i][j] = value;
            }
        }

        return result;
    }

    export function arrayLengths(xss : Array<Array<any>>) : Array<Number>
    {
        var result = new Array(xss.length);

        for ( var i = 0; i !== xss.length; ++i )
        {
            result[i] = xss[i].length;
        }

        return result;
    }

    export function allEqual<T>(xs : Array<T>) : boolean
    {
        if ( xs.length == 0 )
        {
            return true;
        }
        else
        {
            for ( var i = 1; i !== xs.length; ++i )
            {
                if ( xs[i] !== xs[0] )
                {
                    return false;
                }
            }

            return true;
        }
    }

    export function isRectangular<T>(xss : Array<Array<T>>) : boolean
    {
        return allEqual( arrayLengths(xss) );
    }

    export function width<T>(xss : Array<Array<T>>) : number
    {
        return xss.length;
    }

    export function height<T>(xss : Array<Array<T>>) : number
    {
        return xss[0].length;
    }

    export function isSquare<T>(xss : Array<Array<T>>) : boolean
    {
        return isRectangular(xss) && width(xss) === height(xss);
    }

    export function zigZag(width : number, height : number) : Array<Array<number>>
    {
        var result = createGrid(width, height, 0);

        var i = 0;
        var x = 0;
        var dx = 1;

        for ( var y = 0; y !== height; ++y )
        {
            while ( 0 <= x && x < width )
            {
                result[x][y] = i;
                ++i;
                x += dx;
            }
            dx = -dx;
            x += dx;
        }

        return result;
    }

    export function getRow<T>(xss : Array<Array<T>>, row : number) : Array<T>
    {
        var result = new Array( width(xss) );

        for ( var col = 0; col !== result.length; ++col )
        {
            result[col] = xss[col][row];
        }

        return result;
    }

    export function getColumn<T>(xss : Array<Array<T>>, col : number) : Array<T>
    {
        var result = new Array( height(xss) );

        for ( var row = 0; row !== result.length; ++row )
        {
            result[row] = xss[col][row];
        }

        return result;
    }

    export function sum(xs : Array<number>) : number
    {
        var result = 0;

        for ( var i = 0; i !== xs.length; ++i )
        {
            result += xs[i];
        }

        return result;
    }

    export function rowSums(xss : Array<Array<number>>) : Array<number>
    {
        var result = new Array( height(xss) );

        for ( var i = 0; i !== result.length; ++i )
        {
            result[i] = sum( getRow(xss, i) );
        }

        return result;
    }

    export function columnSums(xss : Array<Array<number>>) : Array<Number>
    {
        var result = new Array( width(xss) );

        for ( var i = 0; i !== result.length; ++i )
        {
            result[i] = sum( getColumn(xss, i) );
        }

        return result;
    }
}
