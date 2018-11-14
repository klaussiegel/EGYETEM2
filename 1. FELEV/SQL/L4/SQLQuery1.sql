USE Lab4_1

--	1. Adjuk meg minden felhasznalo eseten az elmult negyedevben publikalt cikkeinek szamat!
--	(Felhasznalok.FelhasznaloNev, CikkekSzama)

SELECT Felhasznalok.FelhasznaloNev, COUNT(Felhasznalok.FelhasznaloNev) AS Darab_Negyedevben FROM Felhasznalok, Cikkek
WHERE Felhasznalok.FelhasznaloID=Cikkek.SzerzoID AND MONTH(Cikkek.Datum)>=7 AND MONTH(Cikkek.Datum)<=9
GROUP BY FelhasznaloNev

--	2. Adjuk meg a legfrissebben regisztralt romaniai felhasznalo(k) cikkeinek szamat! (OsszCikkszam)

SELECT COUNT(DISTINCT Cikkek.CikkID) AS OsszCikkszam FROM Felhasznalok, Orszagok, Cikkek
WHERE Felhasznalok.FelhasznaloID=Cikkek.SzerzoID AND Felhasznalok.OrszagID=Orszagok.OrszagID AND Orszagok.OrszagNev LIKE '%Romania%'

--	3. Adjuk meg azon felhasznalo(ka)t, aki(k) minden kategoriaba irt(ak) cikket! (Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim)

DECLARE @sajat TABLE(
	CikkID INT,
	CikkCim VARCHAR(50),
	Datum DATE DEFAULT '1990-01-01',
	Szoveg VARCHAR(max),
	SzerzoID INT,
	KategoriaID INT,
	Ertekeles INT
)

INSERT INTO @sajat 
SELECT *  FROM Cikkek

INSERT INTO @sajat(CikkID,CikkCim,Datum,Szoveg,SzerzoID,KategoriaID,Ertekeles) VALUES (11,'Seged1', '2018-10-10', null, 1, 1, 3),
(12,'Seged2', '2018-10-10', null, 1, 3, 3),
(13,'Seged3', '2018-10-10', null, 1, 4, 3),
(14,'Seged4', '2018-10-10', null, 1, 5, 3)

SELECT DISTINCT Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim INTO #a

DECLARE @i INT = 1;
DECLARE @max INT = (SELECT COUNT(*) FROM Kategoriak)

WHILE (@i<=@max)
BEGIN
	SELECT * FROM #a
	INNER JOIN Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim FROM Felhasznalok, @sajat AS S, Kategoriak
	WHERE Felhasznalok.FelhasznaloID=S.SzerzoID AND S.KategoriaID=Kategoriak.KategoriaID
	AND S.KategoriaID = @i

	SET @i += 1;
END

	SELECT * FROM #a

--SELECT Felhasznalok.FelhasznaloNev, Felhasznalok.FelhasznaloID FROM Felhasznalok, #a
--WHERE
--	Felhasznalok.FelhasznaloNev=#a.FelhasznaloNev AND #a.FelhasznaloNev=#b.FelhasznaloNev AND
--	#b.FelhasznaloNev=#c.FelhasznaloNev AND #c.FelhasznaloNev=#d.FelhasznaloNev AND #d.FelhasznaloNev=#e.FelhasznaloNev

--	4. Adjuk meg kategoriakon belul szerzonkent a cikkek maximalis ertekeleset!
--	(Kategoriak.KategoriaNev, Felhasznalok.FelhasznaloNev, MaxCikkErtekeles)

--SELECT Kategoriak.KategoriaNev, Felhasznalok.FelhasznaloNev FROM Kategoriak, Felhasznalok, Cikkek
--WHERE Kategoriak.KategoriaID=Cikkek.KategoriaID AND Cikkek.SzerzoID=Felhasznalok.FelhasznaloID

--	5. Adjuk meg azon felhasznalo(ka)t, aki(k) minimum 3x hozzaszolt(ak) a legkisebb ertekelessel rendelkezo cikk(ek)hez! (Felhasznalok.FelhasznaloNev)

--	6. Adjuk meg minden kulcsszo eseten a hozzajuk rendelt cikk(ek) ertekelesenek atlagat, ezen atlag szerint csokkeno sorrendbe rendezve a kulcsszavakat! (Kulcsszavak.KulcsszoNev, AtlagErtekeles)

--	7. Adjuk meg felhasznalonkent a cikkeikhez rendelt kulcsszavak szamat! (Azon felhasznalok is erdekelnek, akik egyetlen kulcsszot sem rendeltek a cikkeikhez.) (Cikkek.CikkCim, FelhasznalokSzama)

--	8. Adjuk meg azon orszagokat, amelynek felhasznaloi ritkan irtak cikket az elmult 2 honapban! (ritkan = kevesebb, mint 3 cikk/orszag)