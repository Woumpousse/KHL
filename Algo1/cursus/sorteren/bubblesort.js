function bubbleSortPass( rij ) {@\label{line:sorteer:bubble-sort:pass-begin}@
    for ( var i = 0; i < rij.length - 1; i++ ) { @\label{line:sorteer:bubble-sort:pass-forloop}@
        if ( rij[i] > rij[i+1] ) { @\label{line:sorteer:bubble-sort:pass-if}@
            verwissel( rij, i, i+1 ); @\label{line:sorteer:bubble-sort:pass-swap}@
        } @\label{line:sorteer:bubble-sort:pass-if-end}@
    } @\label{line:sorteer:bubble-sort:pass-forloop-end}@
}@\label{line:sorteer:bubble-sort:pass-end}@

function bubbleSort( rij ) {@\label{line:sorteer:bubble-sort:sort-begin}@
    for ( var i = 0; i < rij.length - 1; i++ ) {@\label{line:sorteer:bubble-sort:sort-for}@
        bubbleSortPass( rij ); @\label{line:sorteer:bubble-sort:sort-passcall}@
    } @\label{line:sorteer:bubble-sort:sort-for-end}@
}@\label{line:sorteer:bubble-sort:sort-end}@
