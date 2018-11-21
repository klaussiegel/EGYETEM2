-- Oláh Tamás-Lajos
-- otim1750
-- 523 / 2

USE Lab3_1

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