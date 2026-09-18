set search_path to cruise_db;

-- ============================== QUERY 1 ==============================
-- Laat alle passagiers zien waarvoor een bepaalde hoofdboeker heeft geboekt en in welke kamer ze zitten
SELECT 
    p.voornaam || ' ' || p.naam AS "Passagier Volledige Naam",
    b.boeker_id AS "Boeker ID",
    b.cruise_id AS "Cruise ID",
    b.kamer_id AS "Kamer ID",
    boeker.voornaam || ' ' || boeker.naam AS "Hoofdboeker Volledige Naam"
FROM 
    boekt b
INNER JOIN 
    passagier p ON b.passagier_id = p.id
INNER JOIN 
    boeker boeker ON b.boeker_id = boeker.id
WHERE 
    boeker.voornaam = 'Quinn' 
    AND boeker.naam = 'Williams';


-- ============================== QUERY 2 ==============================
-- Toon cruises met een "b" of "B" in hun havennaam, gesorteerd op dalende cruise-id
SELECT 
    c.id AS "Cruise ID",
    c.naam AS "Cruise Naam",
    h.naam AS "Haven Naam"
FROM 
    cruise_reis c
INNER JOIN cruise_parkeert_in_haven p ON c.id = p.cruise_id
INNER JOIN haven h ON p.haven_id = h.id
WHERE 
    h.naam LIKE '%b%' OR h.naam LIKE '%B%'
ORDER BY 
    c.id DESC


-- ============================== QUERY 3 ==============================
-- Toont cruises met meer geboekte kamers dan het gemiddelde aantal geboekte kamers
SELECT 
    c.id AS "Cruise ID",
    c.naam AS "Cruise Naam",
    COUNT(b.kamer_id) AS TotaalGeboekteKamers
FROM 
    cruise_reis c
INNER JOIN 
    boekt b ON c.id = b.cruise_id
GROUP BY 
    c.id
-- Filtert cruises met meer geboekte kamers dan het gemiddelde
HAVING 
    COUNT(b.kamer_id) > (
        -- Subquery om het gemiddelde aantal geboekte kamers over alle cruises te berekenen
        SELECT 
            COUNT(b2.kamer_id) / COUNT(c2.id)
        FROM 
            boekt b2
        INNER JOIN
            cruise_reis c2 ON c2.id = b2.cruise_id
    )
ORDER BY 
    TotaalGeboekteKamers DESC;


-- ============================== QUERY 4 ==============================
-- Overzicht van crewleden met naam, telefoonnummer, aantal cruises en gewerkte dagen in 2024, toont alleen de top 10 met de meeste gewerkte dagen.
SELECT 
    c.id AS "Cruise ID",
    c.voornaam || ' ' || c.naam AS "Crew Volledige Naam",
    c.telefoonnummer AS "Crew Telefoonnummer",
    -- Telt het aantal cruises per bemanningslid
    COUNT(w.cruise_id) AS AantalCruises,
     -- Totaal aantal dagen gewerkt
    SUM(w.einddatum - w.startdatum) AS TotaalDagen
FROM 
    crew c
INNER JOIN crew_werkt_op_cruise_reis w ON c.id = w.crew_id
WHERE 
    w.startdatum >= '2024-01-01' 
    AND w.einddatum <= '2024-12-31'
GROUP BY 
    c.id, c.voornaam, c.naam, c.telefoonnummer
ORDER BY 
    TotaalDagen DESC,
    AantalCruises DESC
LIMIT 10;


-- ============================== QUERY 5 ==============================
-- Identificeer passagiers die wel een cruise hebben geboekt maar aan geen enkele activiteit deelnemen
SELECT 
    p.id AS "Passagier ID",
    (p.voornaam || ' ' || p.naam) AS "Passagier Volledige Naam"
FROM 
    passagier p
INNER JOIN boekt b ON p.id = b.passagier_id
WHERE 
    p.id NOT IN (
        SELECT pa.passagier_id
        FROM passagier_neemt_deel_aan_activiteit pa
    )
ORDER BY 
    p.naam, p.voornaam ASC;