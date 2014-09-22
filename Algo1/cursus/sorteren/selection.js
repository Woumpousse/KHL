function zoekIndexMinimum( rij, i, imax ) {@\label{line:sorteer:selection:zoekMin}@
    var resultaat = i;@\label{line:sorteer:selection:zoekMin:resultaat-var}@
    i++;@\label{line:sorteer:selection:zoekMin:i-inc}@
    while ( i <= imax ) {@\label{line:sorteer:selection:zoekMin:while}@
        if ( rij[i] < rij[resultaat] ) {@\label{line:sorteer:selection:zoekMin:if}@
            resultaat = i;@\label{line:sorteer:selection:zoekMin:set-resultaat}@
        }
        i++;@\label{line:sorteer:selection:zoekMin:i-inc2}@
    }@\label{line:sorteer:selection:zoekMin:while-end}@
    return resultaat;@\label{line:sorteer:selection:zoekMin:return}@
}@\label{line:sorteer:selection:zoekMin-end}@

function selectionSort( rij ) {@\label{line:sorteer:selection:sort}@
    for ( var i = 0; i < rij.length - 1; i++ ) {@\label{line:sorteer:selection:sort:for}@
        var minimumIndex = zoekIndexMinimum(rij, i, rij.length - 1);@\label{line:sorteer:selection:min}@
        verwissel(rij, i, minimumIndex);@\label{line:sorteer:selection:swap}@
    }@\label{line:sorteer:selection:sort:for-end}@
}@\label{line:sorteer:selection:sort-end}@
