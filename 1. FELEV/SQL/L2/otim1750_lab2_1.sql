/*
	Olah Tamas-Lajos
	otim1750
	523 / 2
*/

SET DATEFORMAT ymd

CREATE DATABASE [AutoKolcsonzo]
GO

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

USE [AutoKolcsonzo]
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
		Rendszam varchar(255) NOT NULL,
		SzemSzam varchar(255),
		Mikortol date NOT NULL,
		Meddig date,
		Ar money,

		CONSTRAINT Berel_FK1 FOREIGN KEY(Rendszam) REFERENCES Autok(Rendszam),
		CONSTRAINT Berel_FK2 FOREIGN KEY(SzemSzam) REFERENCES Berlok(SzemSzam),
		CONSTRAINT Berel_PK PRIMARY KEY(Rendszam,SzemSzam,Mikortol)
	);
	
	
	GO


	-- ELSO RESZ
		-- 1. A Berlok tablaba szurjuk be a BerloID mezot, mely legyen automatikusan sorszamozhato
		-- es a Berlok tabla elsodleges kulcsa.
		-- A sorszamozas 1-tol kezdodjon es az ertekek harmasaval novekedjenek (1, 4, 7, stb.).
			ALTER TABLE Berel DROP CONSTRAINT Berel_PK;
			ALTER TABLE Berel DROP CONSTRAINT Berel_FK2;
			ALTER TABLE Berel DROP COLUMN SzemSzam;
			ALTER TABLE Berlok DROP Berlok_PK;
			ALTER TABLE Berlok ADD BerloID int IDENTITY(1,3) NOT NULL;
			ALTER TABLE Berlok ADD CONSTRAINT Berlok_PK PRIMARY KEY(BerloID);
			ALTER TABLE Berel ADD BerloID int NOT NULL;
			ALTER TABLE Berel ADD CONSTRAINT Berlok_FK2 FOREIGN KEY(BerloID) REFERENCES Berlok(BerloID);
			ALTER TABLE Berel ADD CONSTRAINT Berel_PK PRIMARY KEY(RendSzam,BerloID,Mikortol);

		-- 2. Toroljuk az Utca es Hazszam oszlopokat a Berlok tablabol!
			ALTER TABLE Berlok DROP COLUMN Utca, Hazszam;

		-- 3. Szurjunk be egy Cim oszlopot a Berlok tablaba!
			ALTER TABLE Berlok ADD Cim varchar(255);

		-- 4. Modositsuk az Autok tabla Csillag mezojet oly modon, hogy erteke 1 es 5 kozotti lehessen!
			ALTER TABLE Autok ADD CONSTRAINT Csillag_LIM CHECK (Csillag>=1 AND Csillag<=5);

		-- 5. Szurjuk be a Berlok tablaba egy SzulDatum nevu oszlopot,
		-- melynek alapertelmezes szerinti erteke legyen: 1990. januar 1!
			ALTER TABLE Berlok ADD SzulDatum date DEFAULT '1990-01-01';


	GO
	-- MASODIK RESZ // ALTER TABLE
		-- Szurjunk be minden tablaba legalabb 5 sort!
			-- Markak
			INSERT INTO Markak(MarkaNev) VALUES ('Audi'),('BMW'),('Volvo'),('Volkswagen'),('Dacia');

			-- Tipusok
			INSERT INTO Tipusok(TipusNev,MarkaID) VALUES ('A4',1),('M3',2),('V50',3),('V40',3),('Golf GTI',4),('Sandero',5);

			-- Szinek
			INSERT INTO Szinek(SzinNev) VALUES ('piros'),('feher'),('zold'),('lila'),('fekete'),('kek');

			-- Autok
			INSERT INTO Autok(Rendszam,TipusID,SzinKod,GyartasiDatum,NapiDij,Csillag) VALUES
			('CJ 11 VUF',4,6,'2001-09-11',25.40,4),
			('CJ 12 PJZ',3,5,'2008-04-12',50.30,5),
			('MS 69 SQL',2,4,'2005-05-05',10.00,2),
			('VS 66 OMG',1,2,'2015-06-04',50.23,3),
			('B 15 PSD',2,3,'2017-10-15',66.60,3);

			-- Extrak
			INSERT INTO Extrak(ExtraNev) VALUES
			('legkondi'), ('kerekek'), ('radio'), ('lehuzhato ablakok'), ('MP3'), ('Plasma TV'), ('Beepitett WC')

			-- AutoExtraja
			INSERT INTO AutoExtraja(Rendszam,ExtraID) VALUES
			('CJ 11 VUF',1), ('CJ 11 VUF',2), ('CJ 11 VUF', 3),
			('B 15 PSD',6), ('B 15 PSD',7);

			-- Berlok
			INSERT INTO Berlok(SzemSzam,Nev,Helyseg,Cim,SzulDatum) VALUES
			('1980907123456','Nagy Lajos','Cluj','Str. Kogalniceanu, nr. 12','1998-09-07'),
			('2970506159753','Antal Veronika','Salaj','Str. M. Eminescu, nr. 789','2001-09-11'),
			('1180103789456','Lakatos Bela','Cluj','Str. Kogalniceanu, nr. 13','2001-08-31'),
			('1120205787856','Alkesz Pista','Bucuresti','Pta. Victoriei, nr. 1','1999-07-05'),
			('2081015445778','Karoly Ilus','Oradea','Str. Rogerius, nr. 23','1990-01-01'),
			('1050505283185','Lorem Ipsum','Salem','Bld. Witch, nr. 666','2004-03-12');

			-- Berel
			INSERT INTO Berel(Ar,Mikortol,Meddig,Rendszam,BerloID) VALUES
			(12.00,'2018-01-01','2018-01-02','CJ 11 VUF',1),
			(10.50,'2018-02-02','2018-02-10','B 15 PSD',4),
			(50.20,'2018-03-10','2018-03-15','CJ 12 PJZ',7),
			(25.50,'2018-05-01','2018-06-01','MS 69 SQL',10),
			(13.13,'2018-09-07','2018-09-11','VS 66 OMG',4);

	GO
	-- HARMADIK RESZ // SELECT
		-- 1. Kerdezzuk le a Tipusok tabla tartalmat!
			SELECT * FROM Tipusok;

		-- 2. Adjuk meg az elso ot berlot (nev, helyseg, szuletesi datum) az adatbazisbol!
			SELECT TOP 5 Nev,Helyseg,SzulDatum FROM Berlok;

		-- 3. Adjuk meg a 'kolozsvari' ('Cluj') berlok kozul azokat, akik a 'Kogalniceanu' utcan laknak!
			SELECT * FROM Berlok WHERE (Helyseg='Cluj' AND Cim LIKE 'Str. Kogalniceanu,%');

		-- 4. Adjuk meg azon berlok nevet, akiknek a neve ‘A’ betuvel kezdodik
		-- es a masodik felevben (juliustol decemberig) szulettek!
			SELECT Nev FROM Berlok WHERE (Nev LIKE 'A%' AND MONTH(SzulDatum)-6>=0);

		-- 5. Adjuk meg azon autok rendszamat, melyek 2-es vagy 4-es csillaggal rendelkeznek!
			SELECT Rendszam FROM Autok WHERE (Csillag=2 OR Csillag=4);