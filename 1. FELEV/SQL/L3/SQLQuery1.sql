/*
	Oláh Tamás-Lajos
	otim1750
	523 / 2
*/

USE Lab3_1
GO

--	1. sorszám
--		I.	Töltsük le a Files/laborok/lab3/L3_1.sql scriptet, majd futtassuk!
--			A feladatok a script által létrehozott adatbázisra és a benne lévő adatokra vonatkoznak.

--		Baratok (BaratID, Nev, Tel, Email, Cim)
--		Kocsmak (KocsmaID, Nev, Cim)
--		Kedvencek (BaratID, KocsmaID)
--		Italok (ItalID, Nev, TipusID)
--		ItalTipusok (TipusID, TipusNev)
--		Arak (KocsmaID, ItalID, Ar)

--	II. Feladat: 

--		Adjuk meg azon kocsmá(ka)t, ahol CSAK vodkát árulnak! (Kocsmak.Nev)

SELECT Kocsmak.Nev FROM Kocsmak
WHERE Kocsmak.KocsmaID NOT IN (
	SELECT Kocsmak.KocsmaID
	FROM Kocsmak, Arak,Italok, ItalTipusok
	WHERE Kocsmak.KocsmaID=Arak.KocsmaID AND Arak.ItalID=Italok.ItalID AND Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev!='vodka'
)

--		Adjuk meg azon barát(ok) nevét és címét,
--		aki(k) kedvelik a ‘Frederico Sawley’-ot,
--		DE ‘Daisy Geeve’-t ÉS a ‘Hedwiga Ledbetter’-t NEM!
--		(Baratok.Nev, Baratok.Cim)

SELECT Baratok.Nev, Baratok.Cim FROM Baratok,Kedvencek,Kocsmak
WHERE Baratok.BaratID=Kedvencek.BaratID AND Kocsmak.KocsmaID=Kedvencek.KocsmaID AND ( Kocsmak.Nev='Frederico Sawley' AND Kocsmak.Nev!='Hedwiga Ledbetter' AND Kocsmak.Nev!='Daisy Geeve')

--		Adjuk meg azon barát(ok) nevét és címét, aki(k) kedveli(k)
--		a következő listában szereplő kocsmák valamelyikét:
--		(‘Bulgakov’, ‘Insomnia’, ‘Moonshine’)!
--		Minden barát csak egyszer jelenjen meg az eredményben! (Baratok.nev, Baratok.cim)

SELECT Baratok.Nev, Baratok.Cim FROM Baratok,Kedvencek,Kocsmak
WHERE Kedvencek.BaratID=Kedvencek.KocsmaID AND Kedvencek.KocsmaID=Kocsmak.KocsmaID AND Kocsmak.Nev IN ('Bulgakov', 'Insomnia', 'Moonshine')

--		Adjuk meg a ‘bor’ típusú ital(ok) nevét(neveit)! (Italok.Nev)

SELECT Italok.Nev FROM Italok, ItalTipusok
WHERE Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev='bor'

--		Adjuk meg azon baráto(ka)t, aki(k) kedveli(k)
--		a ‘Hedwiga Ledbetter’ és a 'Sandra Tweed' kocsmákat! (Baratok.Nev)

SELECT Baratok.Nev FROM Baratok,Kedvencek,Kocsmak
WHERE Baratok.BaratID=Kedvencek.BaratID AND Kedvencek.KocsmaID=Kocsmak.KocsmaID AND
Kocsmak.Nev='Hedwiga Ledbetter' AND Baratok.Nev IN (
	SELECT Baratok.Nev FROM Baratok,Kedvencek,Kocsmak
	WHERE Baratok.BaratID=Kedvencek.BaratID AND Kedvencek.KocsmaID=Kocsmak.KocsmaID AND
	Kocsmak.Nev='Sandra Tweed'
)

--		Adjuk meg azon kocsmá(ka)t, ahol árulnak vodkát! (Kocsmak.Nev)

SELECT Kocsmak.Nev FROM Kocsmak,Arak,Italok,ItalTipusok
WHERE Kocsmak.KocsmaID=Arak.KocsmaID AND Arak.ItalID=Italok.ItalID AND Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev='vodka'
GROUP BY Kocsmak.Nev

--		Adjuk meg azon kocsmá(ka)t, ahol van
--		‘fekete tea’ és legfennebb 25 RON-ba kerül!
--		(Kocsmak.Nev, Kocsmak.Cim)

SELECT Kocsmak.Nev, Kocsmak.Cim FROM Kocsmak,Arak,Italok
WHERE Kocsmak.KocsmaID=Arak.KocsmaID AND Arak.ItalID=Italok.ItalID AND
(Italok.Nev='Fekete tea' AND Arak.Ar<=25)

--		Adjuk meg a legolcsóbb italt áruló kocsmá(k) nevét! (Kocsmak.nev)

SELECT Kocsmak.Nev FROM Kocsmak,Italok,Arak
WHERE Kocsmak.KocsmaID=Arak.KocsmaID AND Italok.ItalID=Arak.ItalID AND Arak.Ar = (SELECT MIN(Arak.Ar) FROM Arak)

--		Módosítsuk azon barátok címét ’ismeretlen’-re,
--		akik kedvelik a 'Orren Broadhurst' nevű kocsmát!

UPDATE Baratok
SET Baratok.Cim='ismeretlen'
WHERE Baratok.BaratID IN (
	SELECT Baratok.BaratID FROM Baratok, Kedvencek, Kocsmak
	WHERE Baratok.BaratID=Kedvencek.BaratID AND Kedvencek.KocsmaID=Kocsmak.KocsmaID AND Kocsmak.Nev='Orren Broadhurst'
)

--		Töröljük a 'Rik Turbard’ nevű barátot!

DELETE FROM Kedvencek
WHERE Kedvencek.BaratID IN (SELECT Baratok.BaratID FROM Baratok WHERE Baratok.Nev='Rik Turbard')

DELETE FROM Baratok
WHERE Baratok.Nev='Rik Turbard'

--		Szúrjuk be azon baráto(ka)t a Kedvencek táblába,
--		akik e-mail címe ’.com’-ban végződik, a ’Lewes Ledbetter’ kocsmával!

DECLARE @LL_id int;
SET @LL_id = (SELECT Kocsmak.KocsmaID FROM Kocsmak WHERE Kocsmak.Nev='Lewes Ledbetter')

INSERT INTO Kedvencek(KocsmaID,BaratID)
SELECT @LL_id,BaratID FROM Baratok
WHERE Baratok.Email LIKE '%.com'

--		Növeljük az alkoholos italok árát 10-zel és csökkentsük a ’tea’ és ’tonic’
--		típusú italokét 5-tel, amennyiben a csökkentés művelet nem eredményez negatív árat!

--SELECT * FROM Arak,Italok,ItalTipusok
--WHERE Arak.ItalID=Italok.ItalID AND Italok.TipusID=ItalTipusok.TipusID

-- ALKOHOLMENTES

UPDATE Arak
SET Arak.Ar = Arak.Ar-5
WHERE Arak.Ar>=5 AND Arak.ItalID IN (
	SELECT Italok.ItalID FROM Italok,ItalTipusok
	WHERE Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev IN ('tea','tonic')
)

-- ALKOHOLOS
UPDATE Arak
SET Arak.Ar = Arak.Ar + 10
WHERE Arak.ItalID IN (
	SELECT Italok.ItalID FROM Italok,ItalTipusok
	WHERE Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev NOT IN ('tea','tonic')
)

--	Fontos: 
--		Az 1-8 feladatok esetén csak a zárójelben levő értékek kell megjelenjenek a lekérdezés eredményében!
--		Minden feladatra érvényes-az adatmódosító műveletekre (beszúrás, módosítás, törlés) IS: Lekérdezéssel keressétek meg a külső kulcsok értékét és NEM manuálisan! 
