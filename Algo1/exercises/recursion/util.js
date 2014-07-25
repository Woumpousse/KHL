String.prototype.format = function() {
    var result = this;
    
    for (var i = 0; i != arguments.length; i++) {
	var regEx = new RegExp("\\{" + i + "\\}", "gm");
	result = result.replace(regEx, arguments[i]);
    }
	
    return result;
}

if ( !("forEach" in Array.prototype) ) {
    Array.prototype.forEach = function( func ) {
        for ( var i = 0; i != this.length; ++i ) {
            func( this[i] );
        }
    };
}

Array.prototype.toString = function() {
    var result = "[";
    for ( var i = 0; i != this.length; ++i ) {
        if ( i !== 0 ) result += ",";
        result += this[i].toString();
    }
    result += "]";

    return result;
}
