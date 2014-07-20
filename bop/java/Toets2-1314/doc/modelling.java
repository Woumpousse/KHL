Person sergio = new Person("Sergio", "Leone");
Person clint = new Person("Clint", "Eastwood");
Person lee = new Person("Lee", "Van Cleef");
Person eli = new Person("Eli", "Wallach");

Movie fistful = new Movie("A Fistful of Dollars",
			  sergio);
Movie more = new Movie("For a Few Dollars More",
		       fistful,
		       sergio);
Movie gbu = new Movie("The Good, the Bad and the Ugly",
		      more,
		      sergio);

fistful.addActor(clint);
more.addActor(clint);
more.addActor(lee);
gbu.addActor(clint);
gbu.addActor(lee);
gbu.addActor(eli);

MovieCollection collection = new MovieCollection();

collection.add( new Media( fistful, "DVD" ) );
collection.add( new Media( more, "DVD" ) );
collection.add( new Media( gbu, "DVD" ) );
collection.add( new Media( gbu, "BluRay" ) );
