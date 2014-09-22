function partitioneer(rij, begin, einde) {
    var spil   = rij[begin];@\label{line:sorteer:quicksort:partition:spil}@
    var links  = begin + 1;@\label{line:sorteer:quicksort:partition:links}@
    var rechts = einde;@\label{line:sorteer:quicksort:partition:rechts}@
    
    while ( links <= rechts ) {@\label{line:sorteer:quicksort:partition:outer-while}@
        while ( links <= rechts && rij[links] <= spil ) {@\label{line:sorteer:quicksort:partition:while-1}@
            links++;
        }@\label{line:sorteer:quicksort:partition:while-1-end}@

        while ( links <= rechts && spil < rij[rechts] ) {@\label{line:sorteer:quicksort:partition:while-2}@
            rechts--;
        }@\label{line:sorteer:quicksort:partition:while-2-end}@

        if ( links < rechts ) {@\label{line:sorteer:quicksort:partition:if}@
            verwissel(rij, links, rechts);@\label{line:sorteer:quicksort:partition:swap}@
        }@\label{line:sorteer:quicksort:partition:if-end}@
    }@\label{line:sorteer:quicksort:partition:outer-while-end}@

    verwissel(rij, begin, rechts);@\label{line:sorteer:quicksort:partition:lastswap}@

    return rechts;@\label{line:sorteer:quicksort:partition:return}@
}
