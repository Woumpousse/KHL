function quickSortRec(rij, begin, einde) {@\label{line:sorteer:quick:quickSortRec}@
    if ( begin < einde ) {@\label{line:sorteer:quick:quickSortRec:if}@
        var spilIndex = partitioneer(rij, begin, einde);@\label{line:sorteer:quick:quickSortRec:partition}@
        quickSortRec(rij, begin, spilIndex-1);@\label{line:sorteer:quick:quickSortRec:recl}@
        quickSortRec(rij, spilIndex+1, einde);@\label{line:sorteer:quick:quickSortRec:recr}@
    }
}@\label{line:sorteer:quick:quickSortRec-end}@

function quickSort(rij) {@\label{line:sorteer:quick:quickSort}@
    quickSortRec(rij, 0, rij.length-1);
}@\label{line:sorteer:quick:quickSort-end}@
