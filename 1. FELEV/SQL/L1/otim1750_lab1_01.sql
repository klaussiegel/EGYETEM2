/*
Oláh Tamás-Lajos
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
	MarkaID int PRIMARY KEY IDENTITY,
	MarkaNev varchar(255),
);

-- Tipusok (TipusID, TipusNev, MarkaID)
CREATE TABLE Tipusok (
	TipusID int PRIMARY KEY IDENTITY,
	TipusNev varchar(255),
	MarkaID int REFERENCES Markak(MarkaID),
);

-- Szinek (SzinKod, SzinNev)

CREATE TABLE Szinek (
	SzinKod int PRIMARY KEY IDENTITY,
	SzinNev varchar(255),
)

-- Autok (Rendszam, TipusID, SzinKod, GyartasiDatum, NapiDij, Csillag) 

CREATE TABLE Autok (
	Rendszam varchar(255) PRIMARY KEY,
	TipusID int REFERENCES Tipusok(TipusID),
	SzinKod int REFERENCES Szinek(SzinKod),
	GyartasiDatum date,
	NapiDij float,
	Csillag int
);

-- Extrak (ExtraID, ExtraNev)
CREATE TABLE Extrak (
	ExtraID int PRIMARY KEY IDENTITY,
	ExtraNev varchar(255)
);

-- AutoExtraja (Rendszam, ExtraID)
CREATE TABLE AutoExtraja (
	Rendszam varchar(255) REFERENCES Autok(Rendszam),
	ExtraID int REFERENCES Extrak(ExtraID)
);

-- Berlok (SzemSzam, Nev, Helyseg, Utca, Hazszam)
CREATE TABLE Berlok (
	SzemSzam varchar(255) PRIMARY KEY,
	Nev varchar(255),
	Helyseg varchar(255),
	Utca varchar(255),
	Hazszam int
);

-- Berel (Rendszam, SzemSzam, Mikortol, Meddig, Ar)
CREATE TABLE Berel (
	Rendszam varchar(255) REFERENCES Autok(Rendszam),
	SzemSzam varchar(255) REFERENCES Berlok(SzemSzam),
	Mikortol date,
	Meddig date,
	Ar float
);