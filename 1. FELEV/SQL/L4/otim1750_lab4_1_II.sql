-- Oláh Tamás-Lajos
-- otim1750
-- 523 / 2

USE Lab4_1

--	1. Adjuk meg minden felhasznalo eseten az elmult negyedevben publikalt cikkeinek szamat!
--	(Felhasznalok.FelhasznaloNev, CikkekSzama)

SELECT Felhasznalok.FelhasznaloNev, COUNT(Felhasznalok.FelhasznaloNev) AS Darab_Negyedevben FROM Felhasznalok, Cikkek
WHERE Felhasznalok.FelhasznaloID=Cikkek.SzerzoID AND MONTH(Cikkek.Datum)>=7 AND MONTH(Cikkek.Datum)<=9
GROUP BY FelhasznaloNev

--	2. Adjuk meg a legfrissebben regisztralt romaniai felhasznalo(k) cikkeinek szamat! (OsszCikkszam)

DECLARE @maxDATE DATE = (SELECT MAX(RegisztracioDatuma) FROM Felhasznalok)

SELECT COUNT(DISTINCT Cikkek.CikkID) AS OsszCikkszam FROM Felhasznalok, Orszagok, Cikkek
WHERE Felhasznalok.FelhasznaloID=Cikkek.SzerzoID AND Felhasznalok.OrszagID=Orszagok.OrszagID
AND Orszagok.OrszagNev LIKE '%Romania%' AND Felhasznalok.RegisztracioDatuma=@maxDATE

--	3. Adjuk meg azon felhasznalo(ka)t, aki(k) minden kategoriaba irt(ak) cikket!
--	(Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim)

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

GO
CREATE FUNCTION FelhKszN (@FID INT)
RETURNS INT
BEGIN
	DECLARE @temppp INT = (
		SELECT COUNT(Kulcsszavai.KulcsszoID) FROM Cikkek, Kulcsszavai
		WHERE Cikkek.SzerzoID=@FID AND Cikkek.CikkID=Kulcsszavai.CikkID
	)

	RETURN @temppp
END
GO

DECLARE @segede TABLE(
	CikkCim VARCHAR(50),
	FelhasznalokSzama INT
)

DECLARE @seged222 TABLE(
	FelhasznaloNev VARCHAR(20),
	KulcsszoSzam INT
)

DECLARE @max_felh INT = (SELECT COUNT(*) FROM Felhasznalok)
DECLARE @it_felh INT = 1

WHILE (@it_felh<=@max_felh)
BEGIN
	DECLARE @temporary INT = (SELECT [dbo].[FelhKszN] (@it_felh))

	DECLARE @fnevv VARCHAR(20) = (SELECT Felhasznalok.FelhasznaloNev FROM Felhasznalok WHERE Felhasznalok.FelhasznaloID=@it_felh)

	INSERT INTO @seged222(FelhasznaloNev,KulcsszoSzam)
	VALUES (@fnevv,@temporary)

	SET @it_felh += 1
END

SELECT * FROM @seged222

--	8. Adjuk meg azon orszagokat, amelynek felhasznaloi ritkan irtak cikket
--	az elmult 2 honapban! (ritkan = kevesebb, mint 3 cikk/orszag)

GO
CREATE FUNCTION orszag_szam_elem_2_ho (@OrszagID INT)
RETURNS INT
BEGIN
	DECLARE @szam INT = (
		SELECT COUNT(*) FROM Orszagok, Felhasznalok, Cikkek
		WHERE Orszagok.OrszagID=@OrszagID AND Felhasznalok.OrszagID=Orszagok.OrszagID AND Cikkek.SzerzoID=Felhasznalok.FelhasznaloID
		AND ABS(MONTH(Cikkek.Datum)-MONTH(GETDATE()))<=2
	)

	RETURN @szam
END
GO

DECLARE @outputO TABLE (
	OrszagNev VARCHAR(30)
)

DECLARE @orsz_n INT = (SELECT COUNT(*) FROM Orszagok)
DECLARE @orsz_i INT = 1

WHILE (@orsz_i<=@orsz_n)
BEGIN
	DECLARE @tempp INT = (select [dbo].[orszag_szam_elem_2_ho] (@orsz_i))

	IF (@tempp<3)
		INSERT INTO @outputO
		SELECT Orszagok.OrszagNev FROM Orszagok WHERE Orszagok.OrszagID=@orsz_i

	SET @orsz_i += 1
END

SELECT * FROM @outputO