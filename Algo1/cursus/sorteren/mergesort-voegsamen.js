function voegSamen( rij, begin, midden, einde ) {
    var links  = begin;@\label{line:sorteer:mergesort:voegSamen:links}@
    var rechts = midden+1;@\label{line:sorteer:mergesort:voegSamen:rechts}@
    var output = new Array(einde - begin + 1);@\label{line:sorteer:mergesort:voegSamen:output}@
    var i      = 0;@\label{line:sorteer:mergesort:voegSamen:i}@
    
    while ( links <= midden && rechts <= einde ) {@\label{line:sorteer:mergesort:voegSamen:while1}@
        if ( rij[links] <= rij[rechts] ) {@\label{line:sorteer:mergesort:voegSamen:while1:if}@
            output[i] = rij[links];@\label{line:sorteer:mergesort:voegSamen:while1:lcopy}@
            links++;@\label{line:sorteer:mergesort:voegSamen:while1:linc}@
        }
        else {
            output[i] = rij[rechts];@\label{line:sorteer:mergesort:voegSamen:while1:rcopy}@
            rechts++;@\label{line:sorteer:mergesort:voegSamen:while1:rinc}@
        }
        i++;@\label{line:sorteer:mergesort:voegSamen:while1:inc}@
    }@\label{line:sorteer:mergesort:voegSamen:while1-end}@

    while ( links <= midden ) {@\label{line:sorteer:mergesort:voegSamen:while2}@
        output[i] = rij[links];
        links++;
        i++;
    }@\label{line:sorteer:mergesort:voegSamen:while2-end}@

    while ( rechts <= einde ) {@\label{line:sorteer:mergesort:voegSamen:while3}@
        output[i] = rij[rechts];
        rechts++;
        i++;
    }@\label{line:sorteer:mergesort:voegSamen:while3-end}@

    for ( i = begin; i <= einde; i++ ) {@\label{line:sorteer:mergesort:voegSamen:for}@
        rij[i] = output[i - begin];
    }@\label{line:sorteer:mergesort:voegSamen:for-end}@
}
