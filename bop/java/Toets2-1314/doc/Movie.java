public class Movie {
    private String title;
    private Movie directSequelTo;
    private Movie[] similarTo;
    private Person director;
    private Person[] actors;

    public Movie(String title,
                 Movie directSequelTo,
                 Movie[] similarTo,
                 Person director,
                 Person[] actors) {
        this.title = title;
        this.directSequelTo = directSequelTo;
        this.similarTo = similarTo;
        this.director = director;
        this.actors = actors;
    }

    public Movie(String title, Person director) {
        this(title, null, director);
    }

    public Movie(String title, Movie sequelTo, Person director) {
        this(title, sequelTo,
             new Movie[0], director, new Person[0]);
    }

    private void registerSimilarMovie(Movie movie) {
        Movie[] similar = new Movie[ similarTo.length + 1 ];
        for ( int i = 0; i != similarTo.length; ++i ) {
            similar[i] = similarTo[i];
        }
        similar[similarTo.length] movie;
        similarTo = similar;
    }

    public void addSimilarMovie(Movie movie) {
        this.registerSimilarMovie(movie);
        movie.registerSimilarMovie(this);
    }
}
