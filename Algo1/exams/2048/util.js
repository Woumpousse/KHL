String.prototype.format = function () {
    var result = this;
    
    for (var i = 0; i != arguments.length; i++) {
	var regEx = new RegExp("\\{" + i + "\\}", "gm");
	result = result.replace(regEx, arguments[i]);
    }
	
    return result;
};

String.prototype.trimLength = function (maxLength)
{
    if ( this.length > maxLength )
    {
        return this.substring(0, maxLength) + "...";
    }
    else
    {
        return this;
    }
}

function stringOf(x, maxLength)
{
    if ( x === null )
    {
        return "null";
    }
    else if ( x === undefined )
    {
        return "undefined";
    }
    else
    {
        var result = x.toString();

        if ( maxLength ) {
            result = result.trimLength(maxLength);
        }

        return result;
    }
}

function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

Array.prototype.toString = function() {
    var result = "[";
    for ( var i = 0; i != this.length; ++i ) {
        if ( i !== 0 ) result += ",";

        if ( this[i] === null ) {
            result += "null";
        }
        else if ( this[i] === undefined ) {
            result += "undefined";
        }
        else {
            result += this[i].toString();
        }
    }
    result += "]";

    return result;
};

function lexicographical(suborder) {
    return function ( xs, ys ) {
        var i = 0;
        var j = 0;

        while ( i < xs.length && j < ys.length ) {
            var cmp = suborder(xs[i], ys[i]);

            if ( cmp < 0 ) {
                return -1;
            }
            else if ( cmp > 0 ) {
                return 1;
            }

            ++i;
            ++j;
        }

        return xs.length - ys.length;
    };
}

Array.prototype.eachIndex = function (f) {
    for ( var i = 0; i != length; ++i ) {
        f(i);
    }
};

Array.initialize = function (length, f) {
    var result = new Array(length);

    result.eachIndex( function (index) {
        result[index] = f(index);
    } );

    return result;
};

Array.prototype.isPermutationOf = function (that, eq) {
    if ( this.length != that.length ) {
        return false;
    }
    else {
        var eq = eq ? eq : function (x, y) { return x === y; };
        var visited = Array.initialize( this.length, function () { return false; } );
        var i = 0;
        var j;
        
        while ( i < this.length ) {
            while ( j < that.length && visited[j] && !eq(this[i], that[j]) ) {
                ++j;
            }

            if ( j == that.length ) {
                return false;
            }
            else {
                visited[j] = true;
                ++i;
            }
        }

        return true;
    }
}

Array.prototype.sum = function () {
    return _.reduce(this, function (acc, x) { return acc + x; }, 0);
};

Array.prototype.removeAt = function(idx) {
    return this.slice(0, idx).concat(this.slice(idx + 1));
};

Array.prototype.isSubsetOf = function (that) {
    if ( this.length === 0 ) {
        return true;
    }
    else {
        var idx = _.indexOf(that, this[0]);

        return idx !== -1 && this.slice(1).isSubsetOf( that.removeAt(idx) );
    }
};

Array.prototype.transpose = function () {
    return _.zip.apply(_, this);
};
