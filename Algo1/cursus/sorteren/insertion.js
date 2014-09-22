function voegIn( rij, i ) {@\label{line:sorteer:insertion:voegin}@
    while ( i-1 >= 0 && rij[i-1] > rij[i] ) {@\label{line:sorteer:insertion:voegin:while}@
        verwissel(rij, i-1, i);@\label{line:sorteer:insertion:voegin:swap}@
        i--;@\label{line:sorteer:insertion:voegin:dec}@
    }@\label{line:sorteer:insertion:voegin:while-end}@
}@\label{line:sorteer:insertion:voegin-end}@

function insertionSort( rij ) {@\label{line:sorteer:insertion:insertion-sort}@
    for ( var i = 1; i < rij.length; i++ ) {@\label{line:sorteer:insertion:for}@
        voegIn( rij, i );@\label{line:sorteer:insertion:voegin-inv}@
    }@\label{line:sorteer:insertion:for-end}@
}@\label{line:sorteer:insertion:insertion-sort-end}@
