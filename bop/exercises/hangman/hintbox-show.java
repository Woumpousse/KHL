public String show() {
    if ( this.isRevealed ) {
        return "" + this.letter;
    }
    else {
        return "_";
    }
}
