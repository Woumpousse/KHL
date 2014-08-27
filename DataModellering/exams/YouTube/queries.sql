-- Tel het aantal filmpjes die gebruiker met naam Griet een upvote gaf. Ga ervan uit dat er maar één gebruiker is met die naam.
.print 'Tel het aantal filmpjes die gebruiker met naam Griet een upvote gaf.'

SELECT COUNT(F.id)
FROM votes V
INNER JOIN filmpjes F ON F.id = V.film_id AND V.upvote
INNER JOIN gebruikers G ON G.id = V.gebruiker_id AND G.naam = 'girl 1';


-- Tel de nettoscore per film. Score = +1 bij een upvote, -1 bij een downvote.
.print 'Tel de nettoscore per film. Score = +1 bij een upvote, -1 bij een downvote.'
SELECT F.titel, COUNT(CASE WHEN upvote THEN 1 ELSE -1 END)
FROM votes V
INNER JOIN filmpjes F ON F.id = V.film_id
INNER JOIN gebruikers G ON G.id = V.gebruiker_id
GROUP BY F.titel;

-- Geef de films die gebruiker met naam Jan nog niet gezien heeft (d.i. er zijn geen views op zijn naam)
.print
.print 'Geef de films die gebruiker met naam Jan nog niet gezien heeft (d.i. er zijn geen views op zijn naam)'
SELECT F.titel
FROM filmpjes F
LEFT OUTER JOIN (views V INNER JOIN gebruikers G ON V.gebruiker_id = G.id AND G.naam = 'boy 1') ON V.film_id = F.id
WHERE G.id IS NULL
;

-- Vind de film die op het meest op publieke playlists voorkomt.
.print
.print 'Vind de film die op het meest op publieke playlists voorkomt.'
SELECT F.titel, COUNT(FxP.playlist_id) as aantal
FROM filmpjes F
INNER JOIN filmpjes_playlists FxP ON F.id = FxP.film_id
INNER JOIN playlists P ON FxP.playlist_id = P.id AND P.publiek
GROUP BY F.titel
ORDER BY aantal DESC
LIMIT 1
;


-- Vind de namen van de gebruikers die het filmpje met titel 'X' op één van hun private playlists hebben staan. Sorteer alfabetisch op naam.
.print
.print 'Vind de namen van de gebruikers die het filmpje met titel X op één van hun private playlists hebben staan.'
SELECT G.naam
FROM gebruikers G
INNER JOIN playlists P ON G.id = P.eigenaar AND NOT P.publiek
INNER JOIN filmpjes_playlists FxP ON P.id = FxP.playlist_id
INNER JOIN filmpjes F ON FxP.film_id = F.id AND F.titel = 'Movie F 1'
ORDER BY G.naam
;



-- Geef per gebruiker voor elk van zijn/haar playlists het aantal upvotes (d.i. de som van alle upvotes van alle filmpjes in die playlist).
-- Sorteer alfabetisch op gebruiker, dan dalend op aantal upvotes. 
-- Kolommen: eigenaar, playlist, aantal_upvotes
.print 'Upvotes per playlist per gebruiker'
.print '---'
SELECT G.naam as eigenaar, P.naam as playlist, COUNT(V.film_id) as aantal_upvotes
FROM playlists P
INNER JOIN filmpjes_playlists FxP ON FxP.playlist_id = P.id
INNER JOIN filmpjes F ON FxP.film_id = F.id
INNER JOIN votes V ON V.film_id = F.id AND V.upvote
INNER JOIN gebruikers G ON P.eigenaar = G.id
GROUP BY eigenaar, playlist
HAVING aantal_upvotes > 50
ORDER BY eigenaar ASC, aantal_upvotes DESC
;


-- Zoek alle filmpjes met minder dan 5 comments.
.print
.print 'Filmpjes met minder dan 5 comments'
SELECT F.titel, COUNT(C.film_id) AS aantal
FROM filmpjes F
LEFT OUTER JOIN comments C ON C.film_id = F.id
GROUP BY F.titel
HAVING aantal < 5
ORDER BY aantal DESC
;
