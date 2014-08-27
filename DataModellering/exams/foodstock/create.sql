-- DROP DATABASE IF EXISTS food;
-- CREATE DATABASE food;
-- USE food;

CREATE TABLE recepten
(
        receptid INTEGER NOT NULL PRIMARY KEY,
        naam VARCHAR(64) NOT NULL,
        bereidingstijd INT NOT NULL
);

CREATE TABLE ingredienten
(
        naam VARCHAR(64) NOT NULL PRIMARY KEY,
        calorieen INTEGER NOT NULL
);

CREATE TABLE recept_ingredienten
(
        receptid INTEGER NOT NULL,
        ingredient VARCHAR(64) NOT NULL,
        hoeveelheid DOUBLE NOT NULL,
        FOREIGN KEY(receptid) REFERENCES recepten(receptid),
        FOREIGN KEY(ingredient) REFERENCES ingredienten(naam)
);

CREATE TABLE stock
(
        ingredient VARCHAR(64) NOT NULL,
        hoeveelheid DOUBLE NOT NULL,
        FOREIGN KEY(ingredient) REFERENCES ingredienten(naam)
);

CREATE TABLE winkels
(
        winkelid INTEGER NOT NULL PRIMARY KEY,
        keten VARCHAR(64) NOT NULL,
        straat VARCHAR(64) NOT NULL,
        straatnr INTEGER NOT NULL,
        gemeente VARCHAR(64) NOT NULL,
        land VARCHAR(64) NOT NULL
);

CREATE TABLE winkelprijzen
(
        winkelid INTEGER NOT NULL,
        ingredient VARCHAR(64) NOT NULL,
        prijs DOUBLE NOT NULL,
        FOREIGN KEY(winkelid) REFERENCES winkels(winkelid),
        FOREIGN KEY(ingredient) REFERENCES ingredienten(naam)
);

        
-- Recepten
INSERT INTO recepten(receptid, naam, bereidingstijd)
VALUES
       (0, 'moelleux', 60),
       (1, 'chocoladecake', 50),
       (2, 'dame blanche', 15),
       (3, 'vanille ijsje', 2),
       (4, 'creme brulee', 90);

-- Ingredienten
INSERT INTO ingredienten(naam, calorieen)
VALUES ('ei', 40),
       ('bloem', 450),
       ('boter', 900),
       ('zwarte chocolade', 500),
       ('suiker', 700),
       ('cacaopoeder', 300),
       ('vanilleijs', 800),
       ('room', 1200),
       ('zout', 0),
       ('vanillestok', 25);

-- Moelleux recept
INSERT INTO recept_ingredienten(receptid, ingredient, hoeveelheid)
VALUES (0, 'ei', 5),
       (0, 'bloem', 0.075),
       (0, 'suiker', 0.125),
       (0, 'zwarte chocolade', 0.250),
       (0, 'boter', 0.175);

-- Chocoladecake recept
INSERT INTO recept_ingredienten(receptid, ingredient, hoeveelheid)
VALUES (1, 'ei', 4),
       (1, 'bloem', 0.75),
       (1, 'suiker', 0.100),
       (1, 'cacaopoeder', 0.025),
       (1, 'boter', 0.050);

-- Dame blanche recept
INSERT INTO recept_ingredienten(receptid, ingredient, hoeveelheid)
VALUES (2, 'vanilleijs', 0.200),
       (2, 'zwarte chocolade', 0.100);

-- Vanille ijsje recept
INSERT INTO recept_ingredienten(receptid, ingredient, hoeveelheid)
VALUES (3, 'vanilleijs', 0.100);

-- Creme brulee
INSERT INTO recept_ingredienten(receptid, ingredient, hoeveelheid)
VALUES (4, 'room', 0.250),
       (4, 'suiker', 0.200),
       (4, 'ei', 10),
       (4, 'vanillestok', 1),
       (4, 'zout', 0.002);


-- Stock
INSERT INTO stock(ingredient, hoeveelheid)
VALUES ('ei', 24),
       ('bloem', 5.0),
       ('suiker', 10.0),
       ('vanilleijs', 2.5),
       ('boter', 4.0),
       ('room', 2.0);

-- Winkels
INSERT INTO winkels(winkelid, keten, straat, straatnr, gemeente, land)
VALUES (0, 'Delhaize', 'Naamsepoort', 20, 'Heverlee', 'Belgie'),
       (1, 'Carrefour', 'Tiensesteenweg', 104, 'Kessel-Lo', 'Belgie'),
       (2, 'Colruyt', 'Tiensesteenweg', 55, 'Kessel-Lo', 'Belgie'),
       (3, 'Free Record Shop', 'Bondgenotenlaan', 78, 'Leuven', 'Belgie');

-- Prijzen
INSERT INTO winkelprijzen(winkelid, ingredient, prijs)
VALUES (0, 'ei', 0.33),
       (0, 'bloem', 1.25),
       (0, 'boter', 9.16),
       (0, 'zwarte chocolade', 11.23),
       (0, 'suiker', 1.20),
       (0, 'cacaopoeder', 16.60),
       (0, 'vanilleijs', 3.79),
       (0, 'room', 4.75),
       (0, 'vanillestok', 2.25),
       (0, 'zout', 22.00),
       (1, 'ei', 1.31),
       (1, 'bloem', 1.28),
       (1, 'boter', 8.89),
       (1, 'zwarte chocolade', 13.22),
       (1, 'suiker', 1.05),
       (1, 'cacaopoeder', 17.33),
       (1, 'vanilleijs', 3.77),
       (1, 'room', 4.55),
       (1, 'vanillestok', 2.15),
       (1, 'zout', 22.30),
       (2, 'ei', 0.24),
       (2, 'bloem', 1.19),
       (2, 'boter', 8.77),
       (2, 'zwarte chocolade', 10.99),
       (2, 'suiker', 1.11),
       (2, 'cacaopoeder', 16.55),
       (2, 'vanilleijs', 3.76),
       (2, 'room', 4.20),
       (2, 'vanillestok', 1.98),
       (2, 'zout', 21.22),
       (3, 'ei', 10.24),
       (3, 'bloem', 11.19),
       (3, 'boter', 18.77),
       (3, 'zwarte chocolade', 110.99),
       (3, 'suiker', 11.11),
       (3, 'cacaopoeder', 116.55),
       (3, 'vanilleijs', 13.76),
       (3, 'room', 14.20),
       (3, 'vanillestok', 11.98),
       (3, 'zout', 121.22);



-- .print 'Reken per recept het aantal calorieen uit en order ze van calorierijkst tot caloriearmst'
SELECT R.naam, SUM(RI.hoeveelheid * I.calorieen) as totaal
FROM recepten R
INNER JOIN recept_ingredienten RI ON R.receptid = RI.receptid
INNER JOIN ingredienten I ON I.naam = RI.ingredient
GROUP BY R.naam
ORDER BY totaal DESC
;


-- .print
-- .print 'Zoek voor het recept voor chocoladecake per ingredient op welke winkel het goedkoopst is'
SELECT IR.ingredient,
       W.keten,
       W.straat,
       W.gemeente,
       P.prijs
FROM recepten R
INNER JOIN recept_ingredienten IR ON IR.receptid = R.receptid AND R.naam = 'chocoladecake'
INNER JOIN winkelprijzen P ON P.ingredient = IR.ingredient
INNER JOIN winkels W on P.winkelid = W.winkelid
INNER JOIN winkelprijzen P2 ON P2.ingredient = IR.ingredient
GROUP BY IR.ingredient, W.winkelid
HAVING P.prijs = MIN(P2.prijs)
;


-- .print
-- .print 'Zoek per recept en per winkel hoeveel de ingredienten in totaal kosten en sorteer van duur naar goedkoop'
SELECT R.naam,
       W.keten,
       W.straat,
       W.gemeente,
       SUM(IR.hoeveelheid * P.prijs) as totaal
FROM recepten R
INNER JOIN recept_ingredienten IR ON R.receptid = IR.receptid
INNER JOIN winkelprijzen P on P.ingredient = IR.ingredient
INNER JOIN winkels W ON P.winkelid = W.winkelid
GROUP BY R.naam, W.winkelid
ORDER BY totaal DESC
;


-- .print
-- .print 'Zoek voor het recept "moelleux" hoeveel van elk ingredient ontbreekt in de stock'
SELECT R.naam,
       IR.ingredient,
       CASE WHEN S.hoeveelheid is NULL THEN IR.hoeveelheid
            ELSE IR.hoeveelheid - S.hoeveelheid
       END
FROM recepten R
INNER JOIN recept_ingredienten IR ON IR.receptid = R.receptid AND R.naam = 'moelleux'
LEFT OUTER JOIN stock S ON S.ingredient = IR.ingredient
WHERE S.hoeveelheid IS NULL OR S.hoeveelheid < IR.hoeveelheid
;


-- .print
-- .print 'Zoek per recept hoeveel van elk ingredient ontbreekt in de stock'
SELECT R.naam,
       IR.ingredient,
       CASE WHEN S.hoeveelheid is NULL THEN IR.hoeveelheid
            ELSE IR.hoeveelheid - S.hoeveelheid
       END
FROM recepten R
INNER JOIN recept_ingredienten IR ON IR.receptid = R.receptid
LEFT OUTER JOIN stock S ON S.ingredient = IR.ingredient
WHERE S.hoeveelheid IS NULL OR S.hoeveelheid < IR.hoeveelheid
;
        

-- .print
-- .print 'Zoek per recept en per winkel hoeveel de *ontbrekende* ingredienten in totaal kosten'
SELECT R.naam,
       W.keten,
       W.straat,
       W.gemeente,
       SUM(
       CASE WHEN S.hoeveelheid is NULL THEN IR.hoeveelheid
            WHEN IR.hoeveelheid > S.hoeveelheid THEN IR.hoeveelheid - S.hoeveelheid
            ELSE 0
       END * P.prijs) as kost
FROM recepten R
INNER JOIN recept_ingredienten IR ON IR.receptid = R.receptid
LEFT OUTER JOIN stock S ON S.ingredient = IR.ingredient
INNER JOIN winkelprijzen P ON P.ingredient = IR.ingredient
INNER JOIN winkels W ON P.winkelid = W.winkelid
GROUP BY R.naam, W.winkelid
HAVING kost <= 3
ORDER BY kost ASC
;
-- .print


-- .print
-- .print 'Bonnetjestabel'
CREATE TABLE coupons
(
        couponid INT NOT NULL PRIMARY KEY,
        ingredient VARCHAR(64) NOT NULL,
        winkelid INTEGER NOT NULL,
        korting DOUBLE NOT NULL,
        geldigheid DATE NOT NULL,
        gebruiktop DATE,
        FOREIGN KEY(ingredient) REFERENCES ingredienten(naam),
        FOREIGN KEY(winkelid) REFERENCES winkels(winkelid),
        CONSTRAINT geldige_korting CHECK(0 < korting AND korting < 1)
);


-- 
UPDATE stock
SET hoeveelheid = (SELECT stock.hoeveelheid - RI.hoeveelheid
                   FROM recept_ingredienten RI
                   INNER JOIN recepten R ON RI.receptid = R.receptid AND R.naam = 'moelleux'
                   WHERE RI.ingredient = stock.ingredient)
WHERE (SELECT 1
       FROM recept_ingredienten RI
       INNER JOIN recepten R
       ON stock.ingredient = RI.ingredient
       AND RI.receptid = R.receptid
       AND R.naam = 'moelleux');



DELETE FROM winkelprijzen
WHERE (SELECT 1
       FROM winkels
       WHERE winkels.winkelid = winkelprijzen.winkelid AND winkels.keten = 'Free Record Shop');

DELETE FROM winkels
WHERE winkels.keten = 'Free Record Shop';

SELECT * FROM winkelprijzen;

