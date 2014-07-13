public class Hint {
    private HintBox[] hintBoxes;

    public Hint(String word) {
        this.hintBoxes = new HintBox[ word.length() ];

        for ( int i = 0; i != word.length(); ++i ) {
            char currentLetter = word.charAt(i);

            hintBoxes[i] = new HintBox( currentLetter );
        }
    }
}
