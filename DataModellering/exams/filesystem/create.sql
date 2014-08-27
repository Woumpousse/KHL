-- DROP DATABASE IF EXISTS food;
-- CREATE DATABASE food;
-- USE food;

CREATE TABLE entries
(
	id INTEGER NOT NULL PRIMARY KEY,
	naam CHAR(8) NOT NULL,
        extensie CHAR(3) NOT NULL,
	parent_id INTEGER,
        aanmaak DATE NOT NULL,
	FOREIGN KEY(parent_id) REFERENCES entries(id)
);

CREATE TABLE bestanden
(
	id INTEGER NOT NULL PRIMARY KEY,
	bestandsgrootte INTEGER NOT NULL,
	FOREIGN KEY(id) REFERENCES entries(id)
);

CREATE TABLE folders
(
	id INTEGER NOT NULL PRIMARY KEY,
	geencrypteerd BOOLEAN NOT NULL,
	FOREIGN KEY(id) REFERENCES entries(id)
);

CREATE TABLE eigenaars
(
	id INTEGER NOT NULL PRIMARY KEY,
	naam VARCHAR(32) NOT NULL
);

CREATE TABLE gebruikers
(
	id INTEGER NOT NULL PRIMARY KEY,
	paswoord VARCHAR(32) NOT NULL,
        home INTEGER NOT NULL,
	FOREIGN KEY(id) REFERENCES eigenaars(id)
);

CREATE TABLE groepen
(
	id INTEGER NOT NULL PRIMARY KEY,
        beschrijving VARCHAR(256),
	FOREIGN KEY(id) REFERENCES gebruikers(id)
);

CREATE TABLE groepsleden
(
	gebruikersid INTEGER NOT NULL,
	groepsid INTEGER NOT NULL,
	PRIMARY KEY (gebruikersid, groepsid),
	FOREIGN KEY(gebruikersid) REFERENCES gebruikers(id),
	FOREIGN KEY(groepsid) REFERENCES groepen(id)
);

CREATE TABLE rechten
(
	eigenaarsid INTEGER NOT NULL,
	entryid INTEGER NOT NULL,
        leesrechten BOOLEAN NOT NULL,
        schrijfrechten BOOLEAN NOT NULL,
	PRIMARY KEY (eigenaarsid, entryid),
	FOREIGN KEY(eigenaarsid) REFERENCES eigenaars(id),
	FOREIGN KEY(entryid) REFERENCES entries(id)
);

INSERT INTO entries
VALUES (0, 'root', '', NULL, '1/1/2000'),
       (1, 'users', '', 0, '1/1/2000'),
       (2, 'griet', '', 1, '1/1/2000'),
       (3, 'patrick', '', 1, '1/1/2000'),
       (4, 'merel', '', 1, '1/1/2000'),
       (5, 'dansje', 'gif', 2, '1/1/2000'),
       (6, 'jobbeurs', 'pdf', 2, '1/1/2000'),
       (7, 'kikker', 'jpg', 3, '1/1/2000'),
       (8, 'algo2', '', 4, '1/1/2000'),
       (9, 'quiz', 'pdf', 8, '1/1/2000'),
       (10, 'kic', '', 3, '1/1/2000'),
       (11, 'export', '', 0, '1/1/2000'),
       (12, 'dm', '', 11, '1/1/2000'),
       (13, 'algo2', '', 11, '1/1/2000'),
       (14, 'jef', '', 1, '1/1/2000'),
       (15, 'joren', '', 1, '1/1/2000'),
       (16, 'dorien', '', 1, '1/1/2000'),
       (17, 'liesbeth', '', 1, '1/1/2000'),
       (18, 'loner', '', 1, '1/1/2000'),
       (19, 'foo', 'tmp', 18, '1/1/2000');

INSERT INTO folders
VALUES (0, 0),
       (1, 0),
       (2, 0),
       (3, 0),
       (4, 0),
       (8, 0),
       (10, 1),
       (11, 0),
       (12, 0),
       (13, 0),
       (14, 0),
       (15, 0),
       (16, 0),
       (17, 0),
       (18, 0);


INSERT INTO bestanden
VALUES (5, 10),
       (6, 20),
       (7, 30),
       (9, 40),
       (19, 50);

INSERT INTO eigenaars
VALUES (0, 'griet'),
       (1, 'patrick'),
       (2, 'merel'),
       (3, 'dm'),
       (4, 'algo2'),
       (5, 'lector'),
       (6, 'student'),
       (7, 'jef'),
       (8, 'joren'),
       (9, 'dorien'),
       (10, 'liesbeth'),
       (11, 'loner');

INSERT INTO gebruikers
VALUES (0, '123', 2),
       (1, '456', 3),
       (2, '789', 4),
       (7, '147', 14),
       (8, '258', 15),
       (9, 'xyz', 16),
       (10, 'gfg', 17),
       (11, 'fqs', 18);

INSERT INTO groepen
VALUES (3, NULL),
       (4, NULL),
       (5, NULL),
       (6, NULL);

INSERT INTO groepsleden
VALUES (0, 3),
       (1, 3),
       (2, 3),
       (2, 4),
       (0, 5),
       (1, 5),
       (2, 5),
       (7, 6),
       (8, 6),
       (9, 6),
       (10, 6),
       (7, 4),
       (9, 3),
       (10, 4),
       (7, 3);

INSERT INTO rechten
VALUES (0, 2, 1, 1),
       (1, 3, 1, 1),
       (2, 4, 1, 1),
       (3, 12, 1, 0),
       (4, 13, 1, 0),
       (5, 12, 1, 1),
       (5, 13, 1, 1),
       (0, 5, 1, 1),
       (0, 6, 1, 1),
       (1, 7, 1, 1),
       (2, 9, 1, 1),
       (7, 14, 1, 1),
       (8, 15, 1, 1),
       (9, 16, 0, 0),
       (10, 17, 1, 1),
       (11, 18, 1, 1);




.print "--- a"

-- Welke gebruikers zijn lid van meer dan 1 groep?
-- Sorteer op dalend op aantal groepen gevolgd op stijgende naam.
-- Kolommen: naam, aantal_groepen
SELECT E.naam as naam, COUNT(GL.groepsid) as aantal_groepen
FROM gebruikers G
INNER JOIN eigenaars E USING (id)
INNER JOIN groepsleden GL ON (G.id = GL.gebruikersid)
GROUP BY E.naam
HAVING aantal_groepen > 1
ORDER BY aantal_groepen DESC, naam ASC;



.print "--- b"

-- Welke gebruikers zitten in geen enkele groep?
-- Sorteer stijgend op naam.
-- Kolommen: naam
SELECT E.naam as naam
FROM gebruikers G
INNER JOIN eigenaars E USING (id)
LEFT OUTER JOIN groepsleden GL ON (G.id = GL.gebruikersid)
WHERE GL.groepsid IS NULL
ORDER BY naam ASC;




.print "--- d"

-- Op welke entries heeft elke gebruiker (geen groepen!) schrijfrechten?
-- Hou rekening met het feit dat indien een gebruiker in een groep zit
-- die zelf schrijfrechten heeft, deze entry ook mee opgenomen moet worden
-- in het resultaat.
-- Sorteer alfabetisch op gebruikersnaam, gevolgd door alfabetisch op entrynaam.
-- Kolommen: gebruikersnaam, entrynaam
SELECT DISTINCT EIG.naam as gebruikersnaam, ENT.naam as entrynaam
FROM eigenaars EIG
INNER JOIN gebruikers GEB USING (id)
INNER JOIN groepsleden GL ON (EIG.id = GL.gebruikersid)
INNER JOIN entries ENT
INNER JOIN rechten R ON ENT.id = R.entryid AND
                        R.schrijfrechten AND
                        (R.eigenaarsid = GEB.id OR R.eigenaarsid = GL.groepsid)
ORDER BY EIG.naam ASC, ENT.naam ASC;




.print "--- e"

-- Op hoeveel entries heeft elke gebruiker (geen groepen!) schrijfrechten.
-- Hou rekening met het feit dat indien een gebruiker in een groep zit
-- die zelf schrijfrechten heeft, deze entry ook mee opgenomen moet worden
-- in het resultaat.
-- Indien een gebruiker op geen enkele entry schrijfrechten heeft, moet
-- er 0 staan als aantal.
-- Kolommen: gebruikersnaam, aantal
SELECT EIG.naam as gebruikersnaam, COUNT(R.entryid) as aantal
FROM eigenaars EIG
INNER JOIN gebruikers GEB USING (id)
INNER JOIN groepsleden GL ON (EIG.id = GL.gebruikersid)
INNER JOIN entries ENT
LEFT OUTER JOIN rechten R ON ENT.id = R.entryid AND
                             R.schrijfrechten AND
                             (R.eigenaarsid = GEB.id OR R.eigenaarsid = GL.groepsid)
GROUP BY EIG.naam;




.print "--- f"

-- Geef per gebruiker de som van de groottes van alle bestanden die in zijn home directory staan.
-- Negeer subdirectories. Sorteer stijgend op totaal.
-- Kolommen: gebruikersnaam, totaal
SELECT E.naam as gebruikersnaam, SUM(B.bestandsgrootte) as totaal
FROM eigenaars E
INNER JOIN gebruikers G USING (id)
INNER JOIN folders HOMES ON G.home = HOMES.id
INNER JOIN entries ENT ON ENT.parent_id = HOMES.id
INNER JOIN bestanden B ON ENT.id = B.id
GROUP BY E.naam
ORDER BY totaal ASC;




.print "--- g"

-- Tel het aantal entries in de homedirectory van elke gebruiker.
-- Indien een homedirectory leeg is, moet aantal = 0.
-- Sorteer alfabetisch op gebruikersnaam
-- Kolommen: gebruikersnaam, aantal
SELECT E.naam as gebruikersnaam, COUNT(ENT.id) as aantal
FROM eigenaars E
INNER JOIN gebruikers G USING (id)
INNER JOIN folders HOMES ON G.home = HOMES.id
LEFT OUTER JOIN entries ENT ON ENT.parent_id = HOMES.id
GROUP BY E.naam
ORDER BY gebruikersnaam ASC;




.print "--- h"

-- Welke gebruikers zitten in groep 'dm'?
-- Sorteer alfabetisch op naam.
-- Kolommen: gebruikersnaam
SELECT E.naam as gebruikersnaam
FROM eigenaars E
INNER JOIN groepsleden GL1 ON GL1.gebruikersid = E.id
INNER JOIN groepen G1 ON GL1.groepsid = G1.id
INNER JOIN eigenaars E1 ON E1.id = G1.id AND E1.naam = 'dm'
ORDER BY E.naam;




.print "--- i"

-- Welke gebruikers zitten zowel in groep 'algo2' als in groep 'dm'
-- Kolommen: gebruikersnaam
SELECT E.naam as gebruikersnaam
FROM eigenaars E
INNER JOIN groepsleden GL1 ON GL1.gebruikersid = E.id
INNER JOIN groepen G1 ON GL1.groepsid = G1.id
INNER JOIN eigenaars E1 ON E1.id = G1.id AND E1.naam = 'algo2'
INNER JOIN groepsleden GL2 ON GL2.gebruikersid = E.id
INNER JOIN groepen G2 ON GL2.groepsid = G2.id
INNER JOIN eigenaars E2 ON E2.id = G2.id AND E2.naam = 'dm';




.print "--- j"

-- Welke gebruikers zitten niet in de groep 'dm'?
-- Kolommen: gebruikersnaam
SELECT E.naam as gebruikersnaam
FROM eigenaars E
INNER JOIN gebruikers USING (id)
OUTER LEFT JOIN (groepsleden GL2
                 INNER JOIN groepen G2 ON GL2.groepsid = G2.id
                 INNER JOIN eigenaars E2 ON E2.id = G2.id AND E2.naam = 'dm') X ON X.gebruikersid = E.id
WHERE G2.id IS NULL;




.print "--- k"

-- Welke gebruikers zitten in groep 'dm' maar niet in groep 'algo2'?
-- Kolommen: gebruikersnaam
SELECT E.naam
FROM eigenaars E
INNER JOIN groepsleden GL1 ON GL1.gebruikersid = E.id
INNER JOIN groepen G1 ON GL1.groepsid = G1.id
INNER JOIN eigenaars E1 ON E1.id = G1.id AND E1.naam = 'dm'
OUTER LEFT JOIN (groepsleden GL2
                 INNER JOIN groepen G2 ON GL2.groepsid = G2.id
                 INNER JOIN eigenaars E2 ON E2.id = G2.id AND E2.naam = 'algo2') X ON X.gebruikersid = E.id
WHERE G2.id IS NULL;




.print "--- l"

-- Zoek naar bestanden die slechts door een enkele gebruiker leesbaar zijn.
-- Kolommen: gebruikersnaam, bestandsnaam, bestandsgrootte
SELECT EIG.naam as gebruikersnaam, ENT.naam as bestandsnaam, B.bestandsgrootte
FROM rechten R
INNER JOIN eigenaars EIG ON R.eigenaarsid = EIG.id AND R.leesrechten
INNER JOIN bestanden B ON R.entryid = B.id
INNER JOIN entries ENT ON ENT.id = B.id
GROUP BY ENT.naam
HAVING COUNT(EIG.id);


.print "--- m"

-- Toon per gebruiker de lees- en schrijfrechten van zijn homedir.
-- Kolommen: gebruikersnaam, leesrechten, schrijfrechten.
SELECT EIG.naam AS gebruikersnaam, R.leesrechten, R.schrijfrechten
FROM eigenaars EIG
INNER JOIN gebruikers G USING (id)
INNER JOIN entries E ON G.home = E.id
INNER JOIN rechten R ON e.id = R.entryid;


-- Geef elke gebruiker opnieuw lees en schrijfrechten voor zijn homedirectory.
UPDATE rechten
SET leesrechten = 1, schrijfrechten = 1
WHERE (SELECT 1
       FROM gebruikers G
       WHERE G.home = rechten.entryid);


-- Voeg een tabel toe om emailadressen toe te kennen aan gebruikers.
-- Elke gebruiker kan nul of meer emailadressen toegekend krijgen.
CREATE TABLE emails
(
    gebruikersid INTEGER NOT NULL,
    emailadres VARCHAR(256) NOT NULL,
    PRIMARY KEY(gebruikersid, emailadres),
    FOREIGN KEY(gebruikersid) REFERENCES gebruikers(id)
);


-- Verwijder alle bestanden met extensie 'tmp'
DELETE FROM bestanden
WHERE (SELECT 1
       FROM entries E
       WHERE E.id = bestanden.id
       AND E.extensie = 'tmp');

DELETE FROM entries
WHERE extensie = 'tmp';


