public boolean reveal(char letter) {
    boolean result = false;

    for ( HintBox box : this.hintBoxes ) {
        result = result || box.reveal(letter);
    }

    return result;
}
