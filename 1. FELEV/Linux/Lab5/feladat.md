# Lab5 - Üzenetsorok

[DOKUMENTÁCIÓ](http://www.cs.ubbcluj.ro/~laura/so2/dokumentacio/uzenet.htm)

```c++
// Oláh Tamás-Lajos
// otim1750
// 523 / 2
```

```bash
tar -czf S05_01_otim1750.gz ./*.cpp
```

**Megj.:** Az alábbi feladatok megoldásához **két C program** megírására van szükség: lesz egy **szerver** folyamat és egy **kliens** folyamat.

**A kliens folyamat kérést küld a szerver folyamatnak, az pedig a kérésnek megfelelő választ visszaküldi a kliensnek**.

A két folyamat közti kommunikáció **üzenetsor(ok) segítségével történik**.

Ahol **nem ismert a válasz hossza**, **több adagban küldjük** azt vissza.

Ha valaki a **`last`** parancs kimenetét kell feldolgozza, és **saját gépen szeretne dolgozni**, használhatja az **alábbi wtmp állományt** (*az egyetem szerveréről*)...

**`last -f <filenév>`**
hívással a **fenti wtmp állomány nevét adjuk meg**, és azt a kimenetet kapjuk, amit az egyetem szerverén **dec. 2**-án délben adott volna a rendszer.

## FELADAT

A kliens egy **időpontot küld a szervernek**, a szerver pedig visszaküldi a kliensnek az **összes felhasználó nevét, akik éppen dolgoznak**, és **a megadott időpont után léptek be a rendszerbe**.

## Tippek / gyakori hibák

- Ne felejtsük el az üzenet **típusát** a megfelelőképpen beállítani (*System V IPC*). (**az üzenet típusa kötelezően az üzenet első mezője**, és egy **`Long` típusú változó**)
- A "múltkor/vagy otthon még ment és most nem működik, pedig semmit nem módosítottam" - típusú hiba esetén megpróbálhatjuk **megcserélni a kulcsot**. (ettől függetlenül fontos, hogy a függvények visszaadott értékét **teszteljük**, és a **hibákat kezeljük**. Lásd. **`perror`**, aminek segítségével **értelmes hibaüzenetet kaphatunk**.)
- Minden olyan esetben, amikor **a szerver válaszának a maximális hosszát nem lehet előre tudni**, **küldjük, illetve fogadjuk a választ több részletben** (vagyis a **válaszküldés-, illetve fogadás ne egyetlen üzenetváltásból álljon, hanem tegyük ciklusba**).
- Természetesen **több kliens indításával is működnie kell** a házinak (**nem csak egy kliens kommunikál a szerverrel**)
- **POSIX-es üzenetsor esetén** az egyes kliensek **külön-külön üzenetsoron keresztül kapják meg a választ**. Minden kliens **a saját válaszának megfelelő üzenetsorát maga hozza létre**, még a **kérés elküldése ELŐTT** (*különben megtörténhetne, hogy a szerver akarja küldeni a választ, de az üzenetsor még nincs létrehozva*)
- **System V IPC esetén** **egyetlen üzenetsoron keresztül megvalósítható a kommunikáció több kliens és egy szerver közt** (tipikusan **a szerver 1-es típusú üzenetet fogad**, és minden kliens **saját pid-jének megfelelő típusú üzenettel válaszol**).