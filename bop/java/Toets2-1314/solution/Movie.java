public class Movie
{
    private String title;
    private Movie directSequelTo;
    private Movie[] similarTo;
    private Person director;
    private Person[] actors;

    public Movie(String title, Movie directSequelTo, Movie[] similarTo, Person director, Person[] actors)
    {
        setTitle(title);
        setDirectSequelTo(  directSequelTo );
        setSimilarTo(similarTo);
        setDirector(director);
        setActors( actors );
    }

    public Movie(String title, Person director)
    {
        this( title, null, director );
    }

    public Movie(String title, Movie sequelTo, Person director)
    {
        this( title, sequelTo, new Movie[0], director, new Person[0] );
    }
    
    private void setTitle(String title)
    {
        if ( title == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.title = title;
        }
    }
    
    private void setDirectSequelTo(Movie directSequelTo)
    {
        if ( directSequelTo == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.directSequelTo = directSequelTo;
        }
    }
    
    private void setSimilarTo(Movie[] similarTo)
    {
        if ( similarTo == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.similarTo = similarTo;
        }
    }
    
    private void setDirector(Person director)
    {
        if ( director == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.director = director;
        }
    }
    
    private void setActors(Person[] actors)
    {
        if ( actors == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.actors = actors;
        }
    }

    private void registerSimilarMovie(Movie movie) {
        Movie[] similar = new Movie[ similarTo.length + 1 ];
        for ( int i = 0; i != similarTo.length; ++i ) {
            similar[i] = similarTo[i];
        }
        similar[similarTo.length] = movie;
        similarTo = similar;
    }

    public void addSimilarMovie(Movie movie)
    {
        this.registerSimilarMovie( movie );
        movie.registerSimilarMovie( this );
    }

    public String getTitle()
    {
        return title;
    }

    public Movie getDirectSequelTo()
    {
        return directSequelTo;
    }

    public Movie[] getSimilarTo()
    {
        return similarTo;
    }

    public Person getDirector()
    {
        return director;
    }

    public Person[] getActors()
    {
        return actors;
    }    
}
