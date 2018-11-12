# Labor 4

1. sorszám (**Online újság adatbázisa**):

## I. Feladat

**Töltsük le** a `Files/laborok/lab4/L4_1.sql` scriptet,
majd **futtassuk**!
A feladatok **a script által létrehozott adatbázisra
és a benne lévő adatokra vonatkoznak**.

**Orszagok** (**OrszagID**, OrszagNev)
**Felhasznalok** (**FelhasznaloID**, FelhasznaloNev, TeljesNev, EmailCim, RegisztracioDatuma, *OrszagID*, Neme, FelhErtekeles, Fizetes)
**Kategoriak** (**KategoriaID**, KategoriaNev)
**Cikkek** (**CikkID**, CikkCim, Datum, Szoveg, *SzerzoID*, *KategoriaID*, Ertekeles)
**Kulcsszavak** (**KulcsszoID**, KulcsszoNev)
**Kulcsszavai** (**CikkID**, **KulcsszoID**)
**Hozzaszolasok** (**HozzaszolasID**, *FelhasznaloID*, *CikkID*, HozzaszolasDatuma, HozzaszolasSzovege)
**Kedvencek** (**FelhasznaloID**, **CikkID**)

## II. Feladat

1. Adjuk meg minden felhasználó esetén az elmúlt negyedévben publikált cikkeinek számát!  (Felhasznalok.FelhasznaloNev, CikkekSzama)

2. Adjuk meg a legfrissebben regisztrált romániai felhasználó(k) cikkeinek számát! (OsszCikkszam)

3. Adjuk meg azon felhasználó(ka)t, aki(k) minden kategóriába írt(ak) cikket! (Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim)

4. Adjuk meg kategóriákon belül szerzőnként a cikkek maximális értékelését!  (Kategoriak.KategoriaNev, Felhasznalok.FelhasznaloNev, MaxCikkErtekeles)

5. Adjuk meg azon felhasználó(ka)t, aki(k) minimum 3x hozzászólt(ak) a legkisebb értékeléssel rendelkező cikk(ek)hez! (Felhasznalok.FelhasznaloNev)

6. Adjuk meg minden kulcsszó esetén a hozzájuk rendelt cikk(ek) értékelésének átlagát, ezen átlag szerint csökkenő sorrendbe rendezve a kulcsszavakat! (Kulcsszavak.KulcsszoNev, AtlagErtekeles)

7. Adjuk meg felhasználónként a cikkeikhez rendelt kulcsszavak számát! (Azon felhasználók is érdekelnek, akik egyetlen kulcsszót sem rendeltek a cikkeikhez.) (Cikkek.CikkCim, FelhasznalokSzama)

8. Adjuk meg azon országokat, amelynek felhasználói ritkán írtak cikket az elmúlt 2 hónapban! (ritkán = kevesebb, mint 3 cikk/ország)

## III. Feladat:

A lab3 II. 9-12. feladatait oldjátok meg változók, temporális táblák és/vagy tábla típusú változók használatával!

9. Módosítsuk azon barátok címét ’ismeretlen’-re, akik kedvelik a 'Orren Broadhurst' nevű kocsmát!

10. Töröljük a 'Rik Turbard’ nevű barátot!

11. Szúrjuk be azon baráto(ka)t a Kedvencek táblába, akik e-mail címe ’.com’-ban végződik, a ’Lewes Ledbetter’ kocsmával!

12. Növeljük az alkoholos italok árát 10-zel és csökkentsük a ’tea’ és ’tonic’ típusú italokét 5-tel, amennyiben a csökkentés művelet nem eredményez negatív árat!

### Megj.

- A II. alpontban levő feladatok megoldásánál is használhattok változókat, temporális táblákat és/vagy tábla típusú változókat. FIGYELEM! Minimum 3 feladatnál mindkét megoldást tüntessétek fel: 1. egyetlen select-tel történő megoldás (természetesen lehet benne alkérdés), 2. változók, temporális táblák és/vagy tábla típusú változók használatával történő megoldás.
- A feladatok megoldása elé másoljátok be kommentben a feladat szövegét is!
- A feladatok esetén csak a zárójelben levő értékek kell megjelenjenek a lekérdezés eredményében!
- Minden feladatra érvényes: lekérdezéssel keressétek meg a külső kulcsok értékét és NEM manuálisan!
- Ha valamelyik lekérdezés nem ad vissza eredményt, akkor szúrjatok be sorokat a megfelelő táblá(k)ba!