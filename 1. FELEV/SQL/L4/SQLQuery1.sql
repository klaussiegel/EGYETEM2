--	1. Adjuk meg minden felhasznalo eseten az elmult negyedevben publikalt cikkeinek szamat!
--	(Felhasznalok.FelhasznaloNev, CikkekSzama)

SELECT Felhasznalok.FelhasznaloNev, COUNT(Felhasznalok.FelhasznaloNev) AS Darab_Negyedevben FROM Felhasznalok, Cikkek
WHERE Felhasznalok.FelhasznaloID=Cikkek.SzerzoID AND MONTH(Cikkek.Datum)>=7 AND MONTH(Cikkek.Datum)<=9
GROUP BY FelhasznaloNev

--	2. Adjuk meg a legfrissebben regisztralt romaniai felhasznalo(k) cikkeinek szamat! (OsszCikkszam)

SELECT COUNT(DISTINCT Cikkek.CikkID) AS Romaniai_Cikkek_Szama FROM Felhasznalok, Orszagok, Cikkek
WHERE Felhasznalok.FelhasznaloID=Cikkek.SzerzoID AND Felhasznalok.OrszagID=Orszagok.OrszagID AND Orszagok.OrszagNev LIKE '%Romania%'

--	3. Adjuk meg azon felhasznalo(ka)t, aki(k) minden kategoriaba irt(ak) cikket! (Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim)

SELECT Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim FROM Felhasznalok, Cikkek, Kategoriak
WHERE Felhasznalok.FelhasznaloID=Cikkek.SzerzoID AND Cikkek.KategoriaID=Kategoriak.KategoriaID
-- AND

--	4. Adjuk meg kategoriakon belul szerzonkent a cikkek maximalis ertekeleset!  (Kategoriak.KategoriaNev, Felhasznalok.FelhasznaloNev, MaxCikkErtekeles)

--	5. Adjuk meg azon felhasznalo(ka)t, aki(k) minimum 3x hozzaszolt(ak) a legkisebb ertekelessel rendelkezo cikk(ek)hez! (Felhasznalok.FelhasznaloNev)

--	6. Adjuk meg minden kulcsszo eseten a hozzajuk rendelt cikk(ek) ertekelesenek atlagat, ezen atlag szerint csokkeno sorrendbe rendezve a kulcsszavakat! (Kulcsszavak.KulcsszoNev, AtlagErtekeles)

--	7. Adjuk meg felhasznalonkent a cikkeikhez rendelt kulcsszavak szamat! (Azon felhasznalok is erdekelnek, akik egyetlen kulcsszot sem rendeltek a cikkeikhez.) (Cikkek.CikkCim, FelhasznalokSzama)

--	8. Adjuk meg azon orszagokat, amelynek felhasznaloi ritkan irtak cikket az elmult 2 honapban! (ritkan = kevesebb, mint 3 cikk/orszag)