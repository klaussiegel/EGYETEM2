/*
	Oláh Tamás-Lajos
	otim1750
	523 / 2
*/

USE Lab3_1
GO

--		Növeljük az alkoholos italok árát 10-zel és csökkentsük a ’tea’ és ’tonic’
--		típusú italokét 5-tel, amennyiben a csökkentés művelet nem eredményez negatív árat!

SELECT Italok.ItalID, Italok.Nev, ItalTipusok.TipusNev, Arak.Ar FROM Arak,Italok,ItalTipusok
WHERE Arak.ItalID=Italok.ItalID AND Italok.TipusID=ItalTipusok.TipusID

-- ALKOHOLMENTES

--UPDATE Arak
--SET Arak.Ar = Arak.Ar-5
--WHERE Arak.Ar>=5 AND Arak.ItalID IN (
--	SELECT Italok.ItalID FROM Italok,ItalTipusok
--	WHERE Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev IN ('tea','tonic')
--)

---- ALKOHOLOS
--UPDATE Arak
--SET Arak.Ar = Arak.Ar + 10
--WHERE Arak.ItalID IN (
--	SELECT Italok.ItalID FROM Italok,ItalTipusok
--	WHERE Italok.TipusID=ItalTipusok.TipusID AND ItalTipusok.TipusNev NOT IN ('tea','tonic')
--)

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

SELECT Italok.ItalID, Italok.Nev, ItalTipusok.TipusNev, Arak.Ar FROM Arak,Italok,ItalTipusok
WHERE Arak.ItalID=Italok.ItalID AND Italok.TipusID=ItalTipusok.TipusID