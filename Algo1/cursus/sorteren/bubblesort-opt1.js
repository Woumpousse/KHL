function bubbleSortPass( rij ) {
    #var bewerkt = false;#@\label{line:sorteer:bubble-sort-opt:var-bewerkt}@

    for ( var i = 0; i < rij.length - 1; i++ ) {
        if ( rij[i] > rij[i+1] ) {@\label{line:sorteer:bubble-sort-opt:cmp}@
            #bewerkt = true;#@\label{line:sorteer:bubble-sort-opt:bewerkt-true}@
            verwissel( rij, i, i+1 );
        }
    }

    #return bewerkt;#@\label{line:sorteer:bubble-sort-opt:return}@
}

function bubbleSort( rij ) {
    #var ongesorteerd = true;#@\label{line:sorteer:bubble-sort-opt:var-ongesorteerd}@

    #while ( ongesorteerd ) {#@\label{line:sorteer:bubble-sort-opt:while}@
        #ongesorteerd = bubbleSortPass( rij );#@\label{line:sorteer:bubble-sort-opt:ongesorteerd-set}@
    #}#@\label{line:sorteer:bubble-sort-opt:while-end}@
}
