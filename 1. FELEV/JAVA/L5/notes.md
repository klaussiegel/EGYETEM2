# 5. Laborfeladat

Az alább feladatok megoldásához használjunk **AWT**-t.

Hozzunk létre egy **keretet** (`Frame`). A keret **színét** változtassuk `Choice` komponens segítségével: **a keret mindig legyen az aktuálisan kiválasztott opciónak megfelelő színű**. Az opciók között legyen egy "`random`" opció is, ennek hatására a keret színe **változzon véletlenszerűen**.

**Tipp**:
tetszőleges színt a [`Color(int r, int g, int b, int a)`](https://docs.oracle.com/javase/7/docs/api/java/awt/Color.html#Color(int,%20int,%20int,%20int)) konstruktorhívással tudunk előállítani, ahol az `r`, `g` és `b` **0 és 255** közötti értékek - **ezeket generáljuk véletlenszerűen**.

Hozzunk létre egy **keretet** és adjunk hozzá egy **szövegmezőt** (`TextField`), illetve egy **gombot** a `„Filter”` felirattal. A gomb, illetve szövegmező **alá** adjunk hozzá egy `TextArea` komponenst. Gombnyomásra végezzünk **szűrést**: a `TextArea` komponensből kérjük le a kijelölt **szövegrészt**, és ebből a szövegrészből **töröljük** a szövegmezőbe írt **szót**. A gomb **lenyomása után** a `TextArea`-ban maradjon csak **a kijelölt szövegrész szűrt változata**.

**Tipp**: **törlésre** használhatjuk a `String` osztály `replace()` metódusát.

Hozzunk létre egy **keretet**, és **ezen belül** helyezzünk el **egymás mellett** **két listaablakot** (`List`). Az **első listát** töltsük fel **gyümölcsnevekkel**, a másodikat **zöldségnevekkel**. A két listaablak **közé** adjunk hozzá **két gombot**, egyet a “`>>`”, és egyet a “`<<`” **felirattal**. Ha a felhasználó a “`>>`” **gombra kattint**, akkor az **első listaablakban kijelölt szavak átkerülnek a második listaablakba**, és **fordítva**. **Egy listaablakon belül egyszerre több elem is kijelölhető.**

**Megjegyzés**: A különböző komponensek **konténerekhez** történő hozzáadását **`LayoutManager`-ek segítségével valósítsuk meg**, **kerüljük a komponensek méretének és pozíciójának explicit megadását**!

**Hasznos link**: különböző `LayoutManager`-ek és használatuk - [LINK](https://docs.oracle.com/javase/tutorial/uiswing/layout/visual.html)