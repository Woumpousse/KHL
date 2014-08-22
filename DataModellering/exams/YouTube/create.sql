CREATE TABLE gebruikers
(
        id INTEGER NOT NULL PRIMARY KEY,
        naam VARCHAR(256) NOT NULL,
        is_man BOOLEAN NOT NULL,
        land VARCHAR(256) NOT NULL,
        geboortedatum DATE NOT NULL
);

CREATE TABLE filmpjes
(
        id INTEGER NOT NULL PRIMARY KEY,
        titel VARCHAR(256) NOT NULL,
        jaar INT NOT NULL,
        uploader INT NOT NULL,
        lengte_in_seconden INT NOT NULL,
        FOREIGN KEY (uploader) REFERENCES gebruikers(id)
);

CREATE TABLE views
(
        film_id INTEGER NOT NULL,
        gebruiker_id INTEGER NOT NULL,
        datum_uur DATETIME,
        PRIMARY KEY (film_id, gebruiker_id, datum_uur),
        FOREIGN KEY (film_id) REFERENCES filmpjes(id),
        FOREIGN KEY (gebruiker_id) REFERENCES gebruikers(id)
);

CREATE TABLE votes
(
        film_id INTEGER NOT NULL,
        gebruiker_id INTEGER NOT NULL,
        upvote BOOLEAN NOT NULL,
        PRIMARY KEY (film_id, gebruiker_id),
        FOREIGN KEY (film_id) REFERENCES filmpjes(id),
        FOREIGN KEY (gebruiker_id) REFERENCES gebruikers(id)
);

CREATE TABLE comments
(
        film_id INTEGER NOT NULL,
        gebruiker_id INTEGER NOT NULL,
        datum_uur DATETIME NOT NULL,
        commentaar VARCHAR(1024) NOT NULL,
        PRIMARY KEY (film_id, gebruiker_id),
        FOREIGN KEY (film_id) REFERENCES filmpjes(id),
        FOREIGN KEY (gebruiker_id) REFERENCES gebruikers(id)
);

CREATE TABLE playlists
(
        id INTEGER NOT NULL PRIMARY KEY,
        eigenaar INTEGER NOT NULL,
        naam VARCHAR(256) NOT NULL,
        publiek BOOLEAN NOT NULL,
        FOREIGN KEY (eigenaar) REFERENCES gebruikers(id)
);

CREATE TABLE filmpjes_playlists
(
        playlist_id INTEGER NOT NULL,
        film_id INTEGER NOT NULL,
        PRIMARY KEY(playlist_id, film_id),
        FOREIGN KEY (playlist_id) REFERENCES playlists(id),
        FOREIGN KEY (film_id) REFERENCES filmpjes(id)
);
