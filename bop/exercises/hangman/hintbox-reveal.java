public boolean reveal(char c) {
    if ( this.letter == c ) {
        this.isRevealed = true;
        return true;
    }
    else {
        return false;
    }
}
