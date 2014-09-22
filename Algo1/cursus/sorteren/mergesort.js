function mergeSortRec( rij, begin, einde ) {@\label{line:sorteer:merge:mergeSortRec}@
    if ( begin < einde ) {@\label{line:sorteer:merge:rec:if}@
        var midden = Math.floor( (begin + einde) / 2 );@\label{line:sorteer:merge:rec:midden}@
        mergeSortRec(rij, begin, midden);@\label{line:sorteer:merge:rec:recleft}@
        mergeSortRec(rij, midden + 1, einde);@\label{line:sorteer:merge:rec:recright}@
        voegSamen(rij, begin, midden, einde);@\label{line:sorteer:merge:rec:merge}@
    }
}@\label{line:sorteer:merge:mergeSortRec-end}@

function mergeSort( rij ) {@\label{line:sorteer:merge:mergeSort}@
    mergeSortRec( rij, 0, rij.length - 1 );@\label{line:sorteer:merge:rec-call}@
}@\label{line:sorteer:merge:mergeSort-end}@
