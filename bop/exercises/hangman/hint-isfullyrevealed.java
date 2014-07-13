public boolean isFullyRevealed() {
    for ( HintBox box : this.hintBoxes ) {
        if ( !box.isRevealed() ) {
            return false;
        }
    }

    return true;
}
