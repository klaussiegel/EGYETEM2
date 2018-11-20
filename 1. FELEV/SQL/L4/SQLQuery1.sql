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

DECLARE @min_ert INT = (SELECT MIN(Cikkek.Ertekeles) FROM Cikkek)

DECLARE @min_cid INT = (SELECT Cikkek.CikkID FROM Cikkek
WHERE Cikkek.Ertekeles = @min_ert)

DROP TABLE #q
SELECT CikkCim, Ertekeles, FelhasznaloID INTO #q FROM Cikkek, Hozzaszolasok
WHERE Cikkek.CikkID=Hozzaszolasok.CikkID

DECLARE @fel_sz INT = (SELECT COUNT(FelhasznaloID) FROM Felhasznalok)
DECLARE @ij INT = 1

WHILE (@ij<=@fel_sz)
BEGIN
	DECLARE @cnt INT = (SELECT COUNT(*) FROM Hozzaszolasok WHERE CikkID=@min_cid AND FelhasznaloID=@ij)
	PRINT @cnt

	IF (@cnt=3)
	SELECT Felhasznalok.FelhasznaloNev FROM Felhasznalok WHERE FelhasznaloID=@ij

	SET @ij += 1
END

--	6. Adjuk meg minden kulcsszo eseten a hozzajuk rendelt cikk(ek) ertekelesenek atlagat,
--	ezen atlag szerint csokkeno sorrendbe rendezve a kulcsszavakat!
--	(Kulcsszavak.KulcsszoNev, AtlagErtekeles)

DECLARE @segedd TABLE (
	KulcsszoNev VARCHAR(30),
	AtlagErtekeles FLOAT
)

DECLARE @ksz_n INT = (SELECT COUNT(*) FROM Kulcsszavak)
DECLARE @ijk INT = 1

WHILE (@ijk<=@ksz_n)
BEGIN
	DECLARE @ertek FLOAT = (SELECT AVG(Cikkek.Ertekeles) FROM Cikkek, Kulcsszavai
	WHERE Cikkek.CikkID = Kulcsszavai.CikkID AND Kulcsszavai.KulcsszoID=@ijk)

	DECLARE @ksznev VARCHAR(30) = (SELECT Kulcsszavak.KulcsszoNev FROM Kulcsszavak WHERE Kulcsszavak.KulcsszoID=@ijk)

	INSERT INTO @segedd(KulcsszoNev,AtlagErtekeles) VALUES (@ksznev,@ertek)

	SET @ijk += 1
END

SELECT * FROM @segedd
WHERE AtlagErtekeles IS NOT NULL

--	7. Adjuk meg felhasznalonkent a cikkeikhez rendelt kulcsszavak szamat!
--	(Azon felhasznalok is erdekelnek, akik egyetlen kulcsszot sem rendeltek a cikkeikhez.)
--	(Cikkek.CikkCim, FelhasznalokSzama)

DECLARE @segede TABLE(
	CikkCim VARCHAR(50),
	FelhasznalokSzama INT
)

DECLARE @max_cikk INT = (SELECT COUNT(*) FROM Cikkek)
DECLARE @iter INT = 1

WHILE (@iter<=@max_cikk)
BEGIN
	DECLARE @nev VARCHAR(50) = (SELECT Cikkek.CikkCim FROM Cikkek WHERE Cikkek.CikkID=@iter)
	DECLARE @ksz INT = (SELECT COUNT(*) FROM Kulcsszavai WHERE Kulcsszavai.CikkID=@iter)

	INSERT INTO @segede(CikkCim,FelhasznalokSzama) VALUES (@nev,@ksz)

	SET @iter += 1
END

SELECT * FROM @segede

--	8. Adjuk meg azon orszagokat, amelynek felhasznaloi ritkan irtak cikket az elmult 2 honapban! (ritkan = kevesebb, mint 3 cikk/orszag)















-- III. Feladat: 
-- A lab3 II. 9-12. feladatait oldjatok meg valtozok, temporalis tablak es/vagy tabla tipusu valtozok hasznalataval!

--		9. Modositsuk azon baratok cimet ’ismeretlen’-re,
--		akik kedvelik a 'Orren Broadhurst' nevu kocsmat!

DECLARE @kocsma_nev VARCHAR(30) = 'Orren Broadhurst'

UPDATE Baratok
SET Baratok.Cim='ismeretlen'
WHERE Baratok.BaratID IN (
	SELECT Baratok.BaratID FROM Baratok, Kedvencek, Kocsmak
	WHERE Baratok.BaratID=Kedvencek.BaratID AND Kedvencek.KocsmaID=Kocsmak.KocsmaID AND Kocsmak.Nev=@kocsma_nev
)

--		10. Toroljuk a 'Rik Turbard’ nevu baratot!

DECLARE @magic_name VARCHAR(20)='Rik Turbard'

DELETE FROM Kedvencek
WHERE Kedvencek.BaratID IN (SELECT Baratok.BaratID FROM Baratok WHERE Baratok.Nev=@magic_name)

DELETE FROM Baratok
WHERE Baratok.Nev=@magic_name

--		11. Szurjuk be azon barato(ka)t a Kedvencek tablaba,
--		akik e-mail cime ’.com’-ban vegzodik, a ’Lewes Ledbetter’ kocsmaval!

DECLARE @LL_id int;
SET @LL_id = (SELECT Kocsmak.KocsmaID FROM Kocsmak WHERE Kocsmak.Nev='Lewes Ledbetter')

INSERT INTO Kedvencek(KocsmaID,BaratID)
SELECT @LL_id,BaratID FROM Baratok
WHERE Baratok.Email LIKE '%.com'

--		12. Noveljuk az alkoholos italok arat 10-zel es csokkentsuk a ’tea’ és ’tonic’
--		tipusu italoket 5-tel, amennyiben a csokkentes muvelet nem eredmenyez negativ arat!

	DECLARE @Alkoholos TABLE (ItalID int)
	INSERT INTO @Alkoholos
		SELECT Italok.ItalID FROM Italok,ItalTipusok
		WHERE Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev NOT IN ('tea','tonic')


	DECLARE @Alkoholmentes TABLE (ItalID int)
	INSERT INTO @Alkoholmentes
		SELECT Italok.ItalID FROM Italok,ItalTipusok
		WHERE Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev IN ('tea','tonic')

	UPDATE Arak
	SET Arak.Ar = CASE
		WHEN Arak.ItalID NOT IN (SELECT * FROM @Alkoholmentes AS Al) THEN Arak.Ar + 10
		ELSE CASE
			WHEN Arak.Ar>=5 THEN Arak.Ar - 5
			ELSE Arak.Ar
		END
	END