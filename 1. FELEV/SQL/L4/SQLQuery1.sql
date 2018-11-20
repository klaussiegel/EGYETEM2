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


DECLARE @i INT = 1;
DECLARE @max INT = (SELECT COUNT(*) FROM Kategoriak)
DECLARE @a TABLE(
	FelhasznaloID INT,
	FelhasznaloNev VARCHAR(20),
	EmailCim VARCHAR(20)
)

INSERT INTO @a(FelhasznaloID,FelhasznaloNev,EmailCim)
SELECT DISTINCT Felhasznalok.FelhasznaloID, Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim
FROM Felhasznalok

WHILE (@i<=@max)
BEGIN
	DECLARE @x TABLE(
		FelhasznaloID INT,
		FelhasznaloNev VARCHAR(20),
		EmailCim VARCHAR(20)
	)

	DELETE FROM @x

	INSERT INTO @x
	SELECT Felhasznalok.FelhasznaloID, Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim FROM Felhasznalok, @sajat AS S, @a AS a, Kategoriak
	WHERE Felhasznalok.FelhasznaloID=S.SzerzoID AND S.KategoriaID=Kategoriak.KategoriaID
	AND S.KategoriaID = @i AND a.FelhasznaloID=Felhasznalok.FelhasznaloID

	DELETE FROM @a
	
	INSERT INTO @a
	SELECT DISTINCT FelhasznaloID, FelhasznaloNev, EmailCim FROM @x

	SET @i += 1;
END

	SELECT FelhasznaloNev, EmailCim FROM @a

--SELECT Felhasznalok.FelhasznaloNev, Felhasznalok.FelhasznaloID FROM Felhasznalok, #a
--WHERE
--	Felhasznalok.FelhasznaloNev=#a.FelhasznaloNev AND #a.FelhasznaloNev=#b.FelhasznaloNev AND
--	#b.FelhasznaloNev=#c.FelhasznaloNev AND #c.FelhasznaloNev=#d.FelhasznaloNev AND #d.FelhasznaloNev=#e.FelhasznaloNev

--	4. Adjuk meg kategoriakon belul szerzonkent a cikkek maximalis ertekeleset!
--	(Kategoriak.KategoriaNev, Felhasznalok.FelhasznaloNev, MaxCikkErtekeles)

DECLARE @s2 TABLE(
	KategoriaNev VARCHAR(30),
	FelhasznaloNev VARCHAR(20),
	MaxCikkErtekeles INT
)

DECLARE @iii INT = 1;
SET @iii = 1
DECLARE @max2 INT = (SELECT COUNT(*) FROM Kategoriak)

WHILE(@iii<=@max2)
BEGIN
	
	DECLARE @KatNev VARCHAR(30) = (SELECT Kategoriak.KategoriaNev FROM Kategoriak WHERE Kategoriak.KategoriaID=@iii)
	DECLARE @ii INT = 1
	DECLARE @n INT = (SELECT MAX(FelhasznaloID) FROM Felhasznalok)

	WHILE (@ii<=@n)
	BEGIN

		DECLARE @fnev VARCHAR(20) = (SELECT Felhasznalok.FelhasznaloNev FROM Felhasznalok WHERE FelhasznaloID=@ii)
		DECLARE @max_szem INT = (SELECT MAX(Ertekeles) FROM Cikkek WHERE Cikkek.SzerzoID=@ii AND Cikkek.KategoriaID=@iii)

		PRINT @max_szem

		IF @max_szem IS NOT NULL
		BEGIN
			PRINT @fnev
			INSERT INTO @s2(KategoriaNev,FelhasznaloNev,MaxCikkErtekeles) VALUES (@KatNev,@fnev,@max_szem)
		END

		SET @ii += 1
	END

	SET @iii += 1
END
SELECT * FROM @s2
--	5. Adjuk meg azon felhasznalo(ka)t, aki(k) minimum 3x hozzaszolt(ak) a
--	legkisebb ertekelessel rendelkezo cikk(ek)hez!
--	(Felhasznalok.FelhasznaloNev)

--	6. Adjuk meg minden kulcsszo eseten a hozzajuk rendelt cikk(ek) ertekelesenek atlagat, ezen atlag szerint csokkeno sorrendbe rendezve a kulcsszavakat! (Kulcsszavak.KulcsszoNev, AtlagErtekeles)

--	7. Adjuk meg felhasznalonkent a cikkeikhez rendelt kulcsszavak szamat! (Azon felhasznalok is erdekelnek, akik egyetlen kulcsszot sem rendeltek a cikkeikhez.) (Cikkek.CikkCim, FelhasznalokSzama)

--	8. Adjuk meg azon orszagokat, amelynek felhasznaloi ritkan irtak cikket az elmult 2 honapban! (ritkan = kevesebb, mint 3 cikk/orszag)