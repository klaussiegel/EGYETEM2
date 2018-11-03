USE master;
GO
IF EXISTS(select * from sys.databases where name='Lab3_1')
	DROP DATABASE Lab3_1

CREATE DATABASE Lab3_1;
GO
USE Lab3_1;
GO

CREATE TABLE Baratok(
	BaratID INT PRIMARY KEY,
	Nev VARCHAR(30),
	Tel VARCHAR(12),
	Email VARCHAR(30) DEFAULT 'UNKNOWN',
	Cim VARCHAR(30) DEFAULT 'UNKNOWN')
CREATE TABLE Kocsmak(
	KocsmaID INT PRIMARY KEY,
	Nev VARCHAR(30),
	Cim VARCHAR(30))
CREATE TABLE Kedvencek(
	BaratID INT FOREIGN KEY REFERENCES Baratok(BaratID),
	KocsmaID INT FOREIGN KEY REFERENCES Kocsmak(KocsmaID),
	PRIMARY KEY(BaratID, KocsmaID))
CREATE TABLE ItalTipusok(
	TipusID INT PRIMARY KEY,
	TipusNev VARCHAR(30) UNIQUE)
CREATE TABLE Italok(
	ItalID INT PRIMARY KEY,
	Nev VARCHAR(30),
	TipusID INT FOREIGN KEY REFERENCES ItalTipusok(TipusID))
CREATE TABLE Arak(
	KocsmaID INT FOREIGN KEY REFERENCES Kocsmak(KocsmaID),
	ItalID INT FOREIGN KEY REFERENCES Italok(ItalID),
	Ar INT,
	PRIMARY KEY(KocsmaID, ItalID))

insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (1, 'Fern Dunphy', '6483578626', 'fdunphy0@princeton.edu', '8261 Waxwing Place');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (2, 'Dinnie Hebble', '1821798103', 'dhebble1@angelfire.com', '76066 Tennessee Road');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (3, 'Prisca Dronsfield', '8331573181', 'pdronsfield2@guardian.co.uk', '5824 Brown Center');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (4, 'Dennie Billison', '2911989379', 'dbillison3@twitter.com', '9 Bay Lane');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (5, 'Elle Shortell', '8449569855', 'eshortell4@topsy.com', '291 Holy Cross Parkway');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (6, 'Gipsy Yashunin', '6315387706', 'gyashunin5@csmonitor.com', '9 Meadow Ridge Hill');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (7, 'Aarika Mashal', '5523618089', 'amashal6@wired.com', '288 Lotheville Avenue');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (8, 'Celestina Woolaston', '9998149794', 'cwoolaston7@alibaba.gov.cn', '934 Kings Center');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (9, 'Garvey Chartre', '4934922638', 'gchartre8@alibaba.com', '218 Spenser Terrace');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (10, 'Rik Turbard', '8485977307', 'rturbard9@vistaprint.com', '737 Ramsey Plaza');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (11, 'Lucius Elce', '4104352971', 'lelcea@taobao.com', '3636 Mockingbird Lane');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (12, 'Adeline Whittington', '6226594773', 'awhittingtonb@kickstarter.com', '09 Lillian Street');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (13, 'Ganny Ffoulkes', '4649570937', 'gffoulkesc@qq.com', '26595 Macpherson Court');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (14, 'Bryn Darragon', '7278018298', 'bdarragond@youtube.com', '782 Fremont Crossing');
insert into Baratok (BaratID, Nev, Tel, Email, Cim) values (15, 'Karim Measor', '3237902132', 'kmeasore@sitemeter.com', '10 Division Lane');

insert into Kocsmak (KocsmaID, Nev, Cim) values (1, 'Frederico Sawley', '9 Logan Way');
insert into Kocsmak (KocsmaID, Nev, Cim) values (2, 'Orren Broadhurst', '87124 Basil Avenue');
insert into Kocsmak (KocsmaID, Nev, Cim) values (3, 'Daisy Geeve', '5265 Maple Wood Point');
insert into Kocsmak (KocsmaID, Nev, Cim) values (4, 'Hedwiga Ledbetter', '6 Packers Parkway');
insert into Kocsmak (KocsmaID, Nev, Cim) values (5, 'Talia Henrionot', '20571 Waxwing Junction');
insert into Kocsmak (KocsmaID, Nev, Cim) values (6, 'Nilson Allflatt', '954 Roth Pass');
insert into Kocsmak (KocsmaID, Nev, Cim) values (7, 'Lewes Ashbrook', '10 Clyde Gallagher Crossing');
insert into Kocsmak (KocsmaID, Nev, Cim) values (8, 'Sandra Tweed', '8 Superior Alley');
insert into Kocsmak (KocsmaID, Nev, Cim) values (9, 'Perrine Chuney', '26 Almo Road');
insert into Kocsmak (KocsmaID, Nev, Cim) values (10, 'Sosanna Segeswoeth', '4 Cody Park');
insert into Kocsmak (KocsmaID, Nev, Cim) values (11, 'Lewes Ledbetter', '6 Hyde Park');

insert into Kedvencek (BaratID, KocsmaID) values (11, 10);
insert into Kedvencek (BaratID, KocsmaID) values (7, 2);
insert into Kedvencek (BaratID, KocsmaID) values (6, 9);
insert into Kedvencek (BaratID, KocsmaID) values (4, 9);
insert into Kedvencek (BaratID, KocsmaID) values (10, 5);
insert into Kedvencek (BaratID, KocsmaID) values (3, 1);
insert into Kedvencek (BaratID, KocsmaID) values (2, 2);
insert into Kedvencek (BaratID, KocsmaID) values (9, 7);
insert into Kedvencek (BaratID, KocsmaID) values (10, 4);
insert into Kedvencek (BaratID, KocsmaID) values (10, 8);

insert into Kedvencek (BaratID, KocsmaID) values (1,1);
insert into Kedvencek (BaratID, KocsmaID) values (5,1);

insert into Kedvencek (BaratID, KocsmaID) values (15,1);

insert into ItalTipusok (TipusID, TipusNev) values (1, 'whiskey');
insert into ItalTipusok (TipusID, TipusNev) values (2, 'vodka');
insert into ItalTipusok (TipusID, TipusNev) values (3, 'konyak');
insert into ItalTipusok (TipusID, TipusNev) values (4, 'tea');
insert into ItalTipusok (TipusID, TipusNev) values (5, 'tonic');

insert into Italok (ItalID, Nev, TipusID) values (1, 'Valenties', 1);
insert into Italok (ItalID, Nev, TipusID) values (2, 'Alexandrion', 3);
insert into Italok (ItalID, Nev, TipusID) values (3, 'Absolute', 2);
insert into Italok (ItalID, Nev, TipusID) values (4, 'Alexander', 2);
insert into Italok (ItalID, Nev, TipusID) values (5, 'V33', 2);
insert into Italok (ItalID, Nev, TipusID) values (6, 'Tatra tea', 4);
insert into Italok (ItalID, Nev, TipusID) values (7, 'Coca Cola', 5);
insert into Italok (ItalID, Nev, TipusID) values (8, 'Banderas', 3);
insert into Italok (ItalID, Nev, TipusID) values (9, 'Fekete tea', 4);
insert into Italok (ItalID, Nev, TipusID) values (10, 'Fanta', 5);

insert into Arak (KocsmaID, ItalID, Ar) values (4, 6, 33);
insert into Arak (KocsmaID, ItalID, Ar) values (2, 2, 38);
insert into Arak (KocsmaID, ItalID, Ar) values (4, 7, 15);
insert into Arak (KocsmaID, ItalID, Ar) values (9, 2, 16);
insert into Arak (KocsmaID, ItalID, Ar) values (6, 5, 39);
insert into Arak (KocsmaID, ItalID, Ar) values (1, 4, 9);
insert into Arak (KocsmaID, ItalID, Ar) values (9, 3, 39);
insert into Arak (KocsmaID, ItalID, Ar) values (9, 4, 28);
insert into Arak (KocsmaID, ItalID, Ar) values (7, 9, 17);
insert into Arak (KocsmaID, ItalID, Ar) values (4, 9, 29);
insert into Arak (KocsmaID, ItalID, Ar) values (6, 3, 6);
insert into Arak (KocsmaID, ItalID, Ar) values (7, 3, 21);
insert into Arak (KocsmaID, ItalID, Ar) values (8, 9, 22);
insert into Arak (KocsmaID, ItalID, Ar) values (7, 4, 19);
insert into Arak (KocsmaID, ItalID, Ar) values (1, 9, 25);
insert into Arak (KocsmaID, ItalID, Ar) values (8, 10, 29);
insert into Arak (KocsmaID, ItalID, Ar) values (8, 2, 35);
insert into Arak (KocsmaID, ItalID, Ar) values (9, 5, 36);
insert into Arak (KocsmaID, ItalID, Ar) values (2, 7, 39);
insert into Arak (KocsmaID, ItalID, Ar) values (5, 2, 21);
insert into Arak (KocsmaID, ItalID, Ar) values (10, 4, 8);
insert into Arak (KocsmaID, ItalID, Ar) values (2, 10, 32);
insert into Arak (KocsmaID, ItalID, Ar) values (1, 2, 16);
insert into Arak (KocsmaID, ItalID, Ar) values (4, 2, 30);
insert into Arak (KocsmaID, ItalID, Ar) values (1, 10, 29);
insert into Arak (KocsmaID, ItalID, Ar) values (1, 8, 45);
insert into Arak (KocsmaID, ItalID, Ar) values (11, 9, 6);
insert into Arak (KocsmaID, ItalID, Ar) values (1, 5, 6);
insert into Arak (KocsmaID, ItalID, Ar) values (1, 1, 8);
