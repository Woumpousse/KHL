public String show() {
    String result = "";

    for ( HintBox box : this.hintBoxes ) {
        result += box.show();
        result += " ";
    }

    // remove the redundant space at the end
    result = result.trim();

    return result;
}
