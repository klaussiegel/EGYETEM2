# 1. sorszám (Autókölcsönző adatbázisa)

Tekintsük a `lab1`-ben létrehozott táblákat:

`Markak` (**MarkaID**, *MarkaNev*)<br>
`Tipusok` (**TipusID**, *TipusNev*, ***MarkaID***)<br>
`Szinek` (**SzinKod**, *SzinNev*)<br>
`Autok` (**Rendszam**, ***TipusID***, *SzinKod*, *GyartasiDatum*, *NapiDij*, *Csillag*)<br>
`Extrak` (**ExtraID**, *ExtraNev*)<br>
`AutoExtraja` (***Rendszam***, ***ExtraID***)<br>
`Berlok` (**SzemSzam**, *Nev*, *Helyseg*, *Utca*, *Hazszam*)<br>
`Berel` (***Rendszam***, ***SzemSzam***, *Mikortol*, *Meddig*, *Ar*)<br>

## I. rész
`ALTER TABLE` utasítással végezzük el a következő műveleteket!
1. A `Berlok` táblába **szúrjuk be** a `BerloID` mezőt, mely legyen **automatikusan sorszámozható** és a `Berlok` tábla **elsődleges kulcsa**. A sorszámozás **1-től kezdődjön** és az értékek **hármasával növekedjenek** *(1, 4, 7, stb.)*.
2. **Töröljük** az `Utca` és `Hazszam` oszlopokat a `Berlok` táblából!
3. **Szúrjunk be** egy `Cim` oszlopot a `Berlok` táblába!
4. **Módosítsuk** az `Autok` tábla `Csillag` mezőjét oly módon, hogy **értéke 1 és 5 közötti lehessen**!
5. **Szúrjuk be** a `Berlok` táblába egy `SzulDatum` nevu oszlopot, melynek **alapértelmezés szerinti értéke legyen: `1990. január 1`**!


### **Megjegyzés!**
**Minden megszorítást nevezzünk el** (**újakat és a lab1-ben megadottakat is**)!<br>Legegyszerűbb megoldás a lab1-ben megadott megszorítások átnevezésére:<br>
<tab>`CREATE TABLE` utasítások átírása.<br>Lab2-beli megszorítások esetén:<br>`ALTER TABLE` utasításokkal dolgozunk!


## II. rész
**Szúrjunk be minden táblába legalább 5 sort!**

## III.  rész

Lekérdezéseket (`SELECT` utasításokat) használva:

1. **Kérdezzük le** a `Tipusok` tábla **tartalmát**!
2. **Adjuk meg** az **első öt bérlőt** (`név`, `helység`, `születési dátum`) az adatbázisból!
3. **Adjuk meg** a `'kolozsvári'` **bérlők közül** azokat, akik a `'Kogalniceanu'` utcán laknak!
4. **Adjuk meg** azon **bérlők** **nevét**, akiknek a neve `‘A’` **betűvel kezdődik** és a **második félévben** (*júliustól decemberig*) **születtek**!
5. **Adjuk meg** azon **autók rendszámát**, melyek **2-es vagy 4-es csillaggal** rendelkeznek!

### Megjegyzés!
Az egyes alpontoknál a **saját adatbázisnak megfelelő adattal lehet helyettesíteni** a `‘_’` között megadott adatokat. **Minden lekérdezés esetében használjuk a megfelelő string- és dátumfüggvényeket!**