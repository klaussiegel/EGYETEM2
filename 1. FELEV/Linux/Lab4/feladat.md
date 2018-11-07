# L4 - Szemaforok

```c++
// Oláh Tamás-Lajos
// otim1750
// 523 / 2
```

**S04_01_otim1750.gz**

Hozzunk létre egy **osztott-memória területet**, melyet két "**torpedózó**" játékos használ.
Az osztott-memória terület tartalmazzon egy **játékos-azonosítót**, a **célpont sor- és oszlopszámát**, és egy **`0` (ha az előző lövés talált)** vagy **`1` (ha az előző lövés nem talált)** vagy **`-1` (ha az előző lövés teli találat volt)** értéket.
Egy játékos **csak akkor lép be a játékba**, ha **nincs még két játékos, aki már játszik**. A *játékosnak megfelelő programban* egy **12x12-es mátrixot generálunk**, melyen **7 egymás utáni (*vízszintes* vagy *függőleges*) pozíciót megjelölünk**. A következő célpont kijelölése **vagy a billentyűzetről** történik, vagy **egy intelligens algoritmus** segítségével.


