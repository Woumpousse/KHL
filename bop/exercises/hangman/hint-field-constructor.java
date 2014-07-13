public class Hint {
    private String word;

    public Hint(String word) {
        // Geldige invoer afdwingen
        if ( word == null || word.trim().length() == 0 ) {
            abort();
        }
        else {
            // Bewaren in veld
            this.word = word;
        }
    }
}
