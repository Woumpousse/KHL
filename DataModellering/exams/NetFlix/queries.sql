-- Selecteer de gebruikers (gesorteerd op naam) die voor meer dan 90% van hun bestellingen ook beoordelingen hebben ingevoerd.
-- Kolommen: gebruikersnaam
.print "Selecteer de gebruikers (gesorteerd op naam) die voor meer dan 90% van hun bestellingen ook beoordelingen hebben ingevoerd."

SELECT G.naam as gebruikersnaam
FROM gebruikers G
INNER JOIN bestellingen B ON B.gebruiker_id = G.id
LEFT OUTER JOIN beoordelingen R ON R.gebruiker_id = G.id AND B.film_id = R.film_id
GROUP BY G.naam
HAVING COUNT(R.score) >= COUNT(B.id) * 0.9
ORDER BY G.naam;


-- Sorteer (dalend) de acteurs op opgeleverde winst.
-- Kolommen: acteur, winst
.print
.print "Sorteer de acteurs op opgeleverde winst."

SELECT A.naam acteur, SUM(B.kost) winst
FROM acteurs A
INNER JOIN films_acteurs FA on FA.acteur_id = A.id
INNER JOIN bestellingen B on B.film_id = FA.film_id
GROUP BY A.naam
ORDER BY winst DESC;


-- Zoek naar films die werden besteld door minder dan 5 verschillende gebruikers. Sorteer op titel.
-- Kolommen: film
.print
.print "Zoek naar films die werden besteld door minder dan 5 verschillende gebruikers. Sorteer op titel."

SELECT F.titel as film
FROM films F
LEFT OUTER JOIN bestellingen B ON F.id = B.film_id
GROUP BY F.titel
HAVING COUNT(DISTINCT B.gebruiker_id) < 5
ORDER BY F.titel;


-- Sorteer (dalend) acteurs op aantal bestellingen van films waarin ze meespelen. Acteurs die "nooit besteld" werden moeten ook getoond worden.
-- Kolommen: acteur, aantal_bestellingen
.print
.print "Sorteer acteurs op aantal bestellingen van films waarin ze meespelen."

SELECT A.naam as acteur, COUNT(B.id) as aantal_bestellingen
FROM acteurs A
INNER JOIN films_acteurs FA ON FA.acteur_id = A.id
LEFT OUTER JOIN bestellingen B ON B.film_id = FA.film_id
GROUP BY A.naam
ORDER BY aantal_bestellingen DESC;


-- Selecteer paren acteurs (geen duplicaten, paar X Y == paar Y X)
-- en bereken de winst van de filmbestellingen waar ze beiden in voorkomen. Sorteer op dalende winst
-- Indien 2 acteurs nooit samen in een film gespeeld hebben, moeten ze niet voorkomen in het resultaat.
-- Indien er geen bestellingen zijn gemaakt van een film waarin ze beiden spelen, telt dit als winst 0.
-- Kolommen: acteur1, acteur2, winst
.print
.print "Paren acteurs"

SELECT A1.naam as acteur1, A2.naam as acteur2, CASE WHEN SUM(X.kost) IS NULL
                                                    THEN 0
                                                    ELSE SUM(X.kost) / 2 END as winst
FROM acteurs A1
INNER JOIN acteurs A2 ON A1.id < A2.id
INNER JOIN films_acteurs FA1 ON A1.id = FA1.acteur_id
INNER JOIN films_acteurs FA2 ON A2.id = FA2.acteur_id AND FA1.film_id = FA2.film_id
LEFT OUTER JOIN (films F INNER JOIN bestellingen B ON B.film_id = F.id) X ON X.film_id = FA1.film_id
GROUP BY A1.naam, A2.naam
ORDER BY winst DESC;


-- We zoeken naar films die aanslaan bij onze jonge gebruikers.
-- Bereken per film de gemiddelde score komende van gebruikers jonger dan 6.
-- Toon enkel films waarvoor er minstens 5 stemmen zijn van jonge gebruikers.
-- Sorteer dalend op gemiddelde.
-- (Deze query zal niks te maken hebben met de tabel leeftijdscategorieen)
-- Kolommen: film, gemiddelde
.print
.print "We zoeken naar films die aanslaan bij onze jonge gebruikers."

SELECT F.titel as film, AVG(B.score) as gemiddelde
FROM films F
INNER JOIN beoordelingen B ON F.id = B.film_id
INNER JOIN gebruikers G ON G.id = B.gebruiker_id
WHERE strftime('%Y', date('now')) - strftime('%Y', G.geboortedatum) <= 6 -- EXTRACT(YEAR FROM AGE(G.geboortedatum))
GROUP BY F.titel
HAVING COUNT(B.score) >= 5
ORDER BY gemiddelde DESC;



-- We gaan na bij welk geslacht elke film het populairst is.
-- Bereken per film de gemiddelde score van enerzijds
-- mannelijke, anderzijds vrouwelijke gebruikers.
-- Indien het mannelijk gemiddelde hoger is, is het een 'mannenfilm'.
-- Indien het vrouwelijk gemiddelde hoger is, is het een 'vrouwenfiln'.
-- Indien de gemiddeldes gelijk zijn, is het 'beide'.
-- Sorteer op titel.
-- Kolommen: titel, type_film
.print
.print "We zoeken naar films die gemiddeld hoger scoren bij mannen dan bij vrouwen."

SELECT F.titel as film, CASE
                        WHEN AVG(BM.score) > AVG(BF.score)
                        THEN "mannenfilm"
                        WHEN AVG(BM.score) < AVG(BF.score)
                        THEN "vrouwenfilm"
                        ELSE "beide"
                        END as type_film
FROM films F
INNER JOIN beoordelingen BM ON F.id = BM.film_id
INNER JOIN gebruikers GM ON GM.id = BM.gebruiker_id AND GM.is_man
INNER JOIN beoordelingen BF ON F.id = BF.film_id
INNER JOIN gebruikers GF ON GF.id = BF.gebruiker_id AND NOT GF.is_man
GROUP BY F.titel
ORDER BY film ASC;


-- Tel per leeftijdscategorie het aantal mannen en vrouwen, alsook het totaal aantal gebruikers (= man+vrouw).
-- Kolommen: ondergrens, bovengrens, mannen, vrouwen, totaal
.print
.print "Tel per leeftijdscategorie het aantal mannen en vrouwen."

SELECT LC.ondergrens | '-' | LC.bovengrens, COUNT(CASE WHEN G.is_man THEN 1 ELSE NULL END) as mannen, COUNT(CASE WHEN G.is_man THEN NULL ELSE 1 END) as vrouwen, COUNT(G.id) as totaal
FROM leeftijdscategorieen LC
INNER JOIN gebruikers G ON strftime('%Y', date('now')) - strftime('%Y', G.geboortedatum) BETWEEN LC.ondergrens AND LC.bovengrens
GROUP BY LC.ondergrens, LC.bovengrens;

