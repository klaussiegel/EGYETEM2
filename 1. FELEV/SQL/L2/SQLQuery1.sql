/*
	Olah Tamas-Lajos
	otim1750
	523 / 2
*/

CREATE DATABASE AutoKolcsonzo

/*
1. sorszam (Autokolcsonzo adatbazisa): 

Markak (MarkaID, MarkaNev)
Tipusok (TipusID, TipusNev, MarkaID)
Szinek (SzinKod, SzinNev)
Autok (Rendszam, TipusID, SzinKod, GyartasiDatum, NapiDij, Csillag) 
Extrak (ExtraID, ExtraNev)
AutoExtraja (Rendszam, ExtraID)
Berlok (SzemSzam, Nev, Helyseg, Utca, Hazszam)
Berel (Rendszam, SzemSzam, Mikortol, Meddig, Ar)
*/

USE AutoKolcsonzo
GO

-- Markak (MarkaID, MarkaNev)
CREATE TABLE Markak (
	MarkaID int IDENTITY,
	MarkaNev varchar(255),

	CONSTRAINT Markak_PK PRIMARY KEY(MarkaID),
);

-- Tipusok (TipusID, TipusNev, MarkaID)
CREATE TABLE Tipusok (
	TipusID int IDENTITY,
	TipusNev varchar(255),
	MarkaID int REFERENCES Markak(MarkaID),

	CONSTRAINT Tipusok_PK PRIMARY KEY(TipusID)
);

-- Szinek (SzinKod, SzinNev)

CREATE TABLE Szinek (
	SzinKod int IDENTITY,
	SzinNev varchar(255),

	CONSTRAINT Szinek_PK PRIMARY KEY(SzinKod)
)

-- Autok (Rendszam, TipusID, SzinKod, GyartasiDatum, NapiDij, Csillag) 

CREATE TABLE Autok (
	Rendszam varchar(255),
	TipusID int REFERENCES Tipusok(TipusID),
	SzinKod int REFERENCES Szinek(SzinKod),
	GyartasiDatum date,
	NapiDij money,
	Csillag int,

	CONSTRAINT Autok_PK PRIMARY KEY(Rendszam)
);

-- Extrak (ExtraID, ExtraNev)
CREATE TABLE Extrak (
	ExtraID int IDENTITY,
	ExtraNev varchar(255),

	CONSTRAINT Extrak_PK PRIMARY KEY(ExtraID)
);

-- AutoExtraja (Rendszam, ExtraID)
CREATE TABLE AutoExtraja (
	Rendszam varchar(255),
	ExtraID int,

	CONSTRAINT AutoExtraja_FK1 FOREIGN KEY(Rendszam) REFERENCES Autok(Rendszam),
	CONSTRAINT AutoExtraja_FK2 FOREIGN KEY(ExtraID) REFERENCES Extrak(ExtraID),
	CONSTRAINT AutoExtraja_PK PRIMARY KEY(Rendszam,ExtraID)
);

-- Berlok (SzemSzam, Nev, Helyseg, Utca, Hazszam)
CREATE TABLE Berlok (
	SzemSzam varchar(255),
	Nev varchar(255),
	Helyseg varchar(255),
	Utca varchar(255),
	Hazszam int,

	CONSTRAINT Berlok_PK PRIMARY KEY(SzemSzam)
);

-- Berel (Rendszam, SzemSzam, Mikortol, Meddig, Ar)
CREATE TABLE Berel (
	Rendszam varchar(255),
	SzemSzam varchar(255),
	Mikortol date,
	Meddig date,
	Ar money,

	CONSTRAINT Berel_FK1 FOREIGN KEY(Rendszam) REFERENCES Autok(Rendszam),
	CONSTRAINT Berel_FK2 FOREIGN KEY(SzemSzam) REFERENCES Berlok(SzemSzam),
	CONSTRAINT Berel_PK PRIMARY KEY(Rendszam,SzemSzam,Mikortol)
);

-- ELSO RESZ
	-- 1. A Berlok tablaba szurjuk be a BerloID mezot, mely legyen automatikusan sorszamozhato
	-- es a Berlok tabla elsodleges kulcsa.
	-- A sorszamozas 1-tol kezdodjon es az ertekek harmasaval novekedjenek (1, 4, 7, stb.).
		ALTER TABLE Berlok DROP Berlok_PK;
		ALTER TABLE Berlok ADD BerloID int IDENTITY(1,3);
		ALTER TABLE Berlok ADD CONSTRAINT Berlok_PK PRIMARY KEY(BerloID);

	-- 2. Toroljuk az Utca es Hazszam oszlopokat a Berlok tablabol!
		ALTER TABLE Berlok DROP COLUMN Utca, Hazszam;

	-- 3. Szurjunk be egy Cim oszlopot a Berlok tablaba!
		ALTER TABLE Berlok ADD Cim varchar(255);

	-- 4. Modositsuk az Autok tabla Csillag mezojet oly modon, hogy erteke 1 es 5 kozotti lehessen!
		ALTER TABLE Autok ADD CONSTRAINT Csillag_LIM CHECK (Csillag>=1 AND Csillag<=5);

	-- 5. Szurjuk be a Berlok tablaba egy SzulDatum nevu oszlopot,
	-- melynek alapertelmezes szerinti erteke legyen: 1990. januar 1!
		ALTER TABLE Berlok ADD SzulDatum date DEFAULT 1990-01-01;



-- MASODIK RESZ
	-- Szurjunk be minden tablaba legalabb 5 sort!
		-- Markak
		INSERT INTO Markak(MarkaNev) VALUES ('Audi'),('BMW'),('Volvo'),('Volkswagen'),('Dacia');

		-- Tipusok
		INSERT INTO Tipusok(TipusNev,MarkaID) VALUES ('A4',1),('M3',2),('V50',3),('V40',3),('Golf GTI',4),('Sandero',5);

		-- Szinek
		INSERT INTO Szinek(SzinNev) VALUES ('piros'),('feher'),('zold'),('lila'),('fekete'),('kek');

		-- Autok
		INSERT INTO Autok(Rendszam,TipusID,SzinKod,GyartasiDatum,NapiDij,Csillag) VALUES
		('CJ 11 VUF',4,6,2001-09-11,25.40,4),
		('CJ 12 PJZ',3,5,2008-04-12,50.30,5),
		('SJ 69 SQL',6,4,2005-05-05,10.00,2),
		('VS 66 OMG',1,2,2015-06-04,50.23,3),
		('B 15 PSD',2,3,2017-10-15,66.60,3);

		-- Extrak
		INSERT INTO Extrak(ExtraNev) VALUES
		('legkondi'), ('kerekek'), ('radio'), ('lehuzhato ablakok'), ('MP3'), ('Plasma TV'), ('Beepitett WC')

		-- AutoExtraja
		INSERT INTO AutoExtraja(Rendszam,ExtraID) VALUES
		('CJ 11 VUF',1), ('CJ 11 VUF',2), ('CJ 11 VUF', 3),
		('B 12 PSD',6), ('B 12 PSD',7)

		-- Berlok
		INSERT INTO Berlok(SzemSzam,Nev,Helyseg,Cim) VALUES
		('1980907123456','Nagy Lajos','Cluj','Str. A nr. 12'),
		('2040506159753','Kanalos Veronika','Salaj','Str. R nr. 789'),
		('1120103789456','Lakatos Bela','Cluj','Str. B nr. 13'),
		('1120205787856','Lakatos Pista','Bucuresti','Str. ABC nr. 1'),
		('2111015445778','Karoly Istvan','Oradea','Str. XYZ nr. 23');

		-- Berel
		INSERT INTO Berel(Ar,Meddig,Mikortol,Rendszam,SzemSzam) VALUES
		(12.00,2018-01-02,2018-01-01,'CJ 11 VUF','1980907123456'),
