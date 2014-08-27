CREATE TABLE componenten
(
        id INTEGER NOT NULL PRIMARY KEY,
        merk VARCHAR(64) NOT NULL,
        omschrijving VARCHAR(1024) NOT NULL,
        garantie INTEGER NOT NULL,
        prijs DOUBLE NOT NULL
);

CREATE TABLE moederborden
(
        id INTEGER NOT NULL PRIMARY KEY,
        cpu_socket VARCHAR(32) NOT NULL,
        ram_type VARCHAR(32) NOT NULL,
        FOREIGN KEY(id) REFERENCES componenten(id)
);

CREATE TABLE processoren
(
        id INTEGER NOT NULL PRIMARY KEY,
        cpu_socket VARCHAR(32) NOT NULL,
        FOREIGN KEY(id) REFERENCES componenten(id)
);

CREATE TABLE geheugen
(
        id INTEGER NOT NULL PRIMARY KEY,
        ram_type VARCHAR(32) NOT NULL,
        FOREIGN KEY(id) REFERENCES componenten(id)
);

CREATE TABLE computers
(
        id INTEGER NOT NULL PRIMARY KEY,
        moederbord INTEGER NOT NULL,
        processor INTEGER NOT NULL,
        ram INTEGER NOT NULL,
        FOREIGN KEY(id) REFERENCES componenten(id),
        FOREIGN KEY (moederbord) REFERENCES moederborden(id),
        FOREIGN KEY (processor) REFERENCES processoren(id),
        FOREIGN KEY (ram) REFERENCES geheugen(id)
);

CREATE TABLE winkels
(
        id INTEGER NOT NULL PRIMARY KEY,
        stad VARCHAR(128) NOT NULL
);

CREATE TABLE stock
(
        winkel_id INTEGER NOT NULL,
        component_id INTEGER NOT NULL,
        aantal INTEGER NOT NULL,
        PRIMARY KEY (winkel_id, component_id),
        FOREIGN KEY (winkel_id) REFERENCES winkels(id),
        FOREIGN KEY (component_id) REFERENCES componenten(id)
);

CREATE TABLE klanten
(
        id INTEGER NOT NULL PRIMARY KEY,
        naam VARCHAR(64) NOT NULL,
        straat VARCHAR(64) NOT NULL,
        huisnr INTEGER NOT NULL,
        postcode VARCHAR(10) NOT NULL,
        stad VARCHAR(10) NOT NULL        
);

CREATE TABLE bestellingen
(
        id INTEGER NOT NULL PRIMARY KEY,
        klantid INTEGER NOT NULL,
        datum DATE NOT NULL,
        FOREIGN KEY (klantid) REFERENCES klanten
);

CREATE TABLE componenten_bestellingen
(
        bestelling_id INTEGER NOT NULL,
        component_id INTEGER NOT NULL,
        PRIMARY KEY (bestelling_id, component_id),
        FOREIGN KEY (bestelling_id) REFERENCES bestellingen(id),
        FOREIGN KEY (component_id) REFERENCES componenten(id)
);
