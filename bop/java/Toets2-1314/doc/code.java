public class Media {
    private Movie   movie;
    private String  type; // DVD, BluRay, ...

    public Media(Movie movie, String type) { ... }

    public Movie getMovie() { ... }
    public String getType() { ... }
}

public class MovieCollection {
    private Media[] movies;

    public MovieCollection() { ... }

    public void add(Media media) { ... }
    public Media[] getMedia() { ... }
    public List<Media> findWithTitle(String title) { ... }
}
