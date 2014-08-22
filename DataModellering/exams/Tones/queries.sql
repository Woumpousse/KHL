-- UITLEG
-- Een moederbord is compatibel met een processor indien ze hetzelfde sockettype ondersteunen.
-- Een moederbord is compatibel met geheugen indien het type overeenkomt.


-- Tel het aantal mogelijke moederbord/cpu/ram combinaties er zijn waarvoor de prijs lager is dan 500.
-- Let wel, enkel compatibele componenten moeten beschouwd worden.
-- Headers: aantal
.print "Aantal goedkope combinaties"
SELECT COUNT(*) as aantal
FROM moederborden M
INNER JOIN processoren P ON M.cpu_socket = P.cpu_socket
INNER JOIN geheugen G ON M.ram_type = G.ram_type
INNER JOIN componenten CM ON CM.id = M.id
INNER JOIN componenten CP on CP.id = P.id
INNER JOIN componenten CG on CG.id = G.id
WHERE CM.prijs + CP.prijs + CG.prijs < 500
;


-- Reken de winst uit per computer. De winst is gelijk aan het verschil
-- tussen de prijs van de computer zelf, en de som van de prijzen van de componenten.
-- Geef als uitvoer
--   "winst" indien de winst > 0 is,
--   "verlies" bij winst <= 0,
-- Headers: computer_id, computer_prijs, winst
.print "Winst"
SELECT C.id as computer_id,
       CC.prijs as computer_prijs,
       CASE WHEN CC.prijs - CM.prijs - CG.prijs - CP.prijs > 0
            THEN 'winst'
            ELSE 'verlies'
            END as winst
FROM computers C
INNER JOIN moederborden M ON C.moederbord = M.id
INNER JOIN processoren P ON C.processor = P.id
INNER JOIN geheugen G ON C.ram = G.id
INNER JOIN componenten CM ON CM.id = M.id
INNER JOIN componenten CP on CP.id = P.id
INNER JOIN componenten CG on CG.id = G.id
INNER JOIN componenten CC on CC.id = C.id
;


-- Vind moederborden waarvoor geen processoren met overeenkomstige socket
-- of ram van het juiste type in de catalogus is opgenomen.
-- Headers: moederbord_id, cpu_socket, ram_type
.print "Moederborden zonder cpu of ram"
SELECT M.id as moederbord_id, M.cpu_socket, M.ram_type
FROM moederborden M
LEFT OUTER JOIN processoren P ON M.cpu_socket = P.cpu_socket
LEFT OUTER JOIN geheugen G on M.ram_type = G.ram_type
WHERE P.id IS NULL OR G.id IS NULL
;



-- Genereer de lijst van klanten die reeds voor meer dan
-- 1000 euro bestellingen geplaatst hebben.
-- Headers: klant, totaal
-- Sorteer dalend op totaal
.print "Goeie klanten"
SELECT K.naam as klant, SUM(C.prijs) as totaal
FROM klanten K
INNER JOIN bestellingen B ON K.id = B.klantid
INNER JOIN componenten_bestellingen CxB ON B.id = CxB.bestelling_id
INNER JOIN componenten C ON C.id = CxB.component_id
GROUP BY K.naam
HAVING totaal > 1000
ORDER BY totaal DESC
;



-- Selecteer pc's waarvan de componenten in stock zijn in de winkel in Leuven.
-- Headers: computer_id, prijs
.print "Beschikbare pc's"
SELECT C.id as computer_id, CC.prijs
FROM computers C
INNER JOIN winkels W ON stad = 'Leuven'
INNER JOIN stock SM ON SM.component_id = C.moederbord AND SM.aantal > 0 AND SM.winkel_id = W.id
INNER JOIN stock SP ON SP.component_id = C.processor AND SP.aantal > 0 AND SP.winkel_id = W.id
INNER JOIN stock SG ON SG.component_id = C.ram AND SG.aantal > 0 AND SG.winkel_id = W.id
INNER JOIN componenten CC USING (id)
ORDER BY CC.prijs
;
