function bubbleSortPass( rij#, tot# ) {@\label{line:sorteer:bubble-sort-opt2:bubbleSortPass}@
    #var laatstBewerkt = -1;#@\label{line:sorteer:bubble-sort-opt2:var-laatstBewerkt}@

    for ( var i = 0; #i < tot#; i++ ) {
        if ( rij[i] > rij[i+1] ) {
            #laatstBewerkt = i+1;#@\label{line:sorteer:bubble-sort-opt2:laatstBewerkt-set}@
            verwissel( rij, i, i+1 );
        }
    }

    return #laatstBewerkt#;
}

function bubbleSort( rij ) {
    #var ongesorteerdTot = rij.length-1;#@\label{line:sorteer:bubble-sort-opt2:ongesorteerdTot-var}@

    while ( #ongesorteerdTot >= 0# ) {@\label{line:sorteer:bubble-sort-opt2:while}@
        #ongesorteerdTot = bubbleSortPass( rij, ongesorteerdTot );#@\label{line:sorteer:bubble-sort-opt2:body}@
    }
}
