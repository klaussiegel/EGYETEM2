{-
    Oláh Tamás-Lajos
    otim1750
    523 / 2
-}



-- 1. Írjunk függvényt, mely kétszerez egy listát.
-- Például a ketszer [1,2,3] eredménye legyen az [1,1,2,2,3,3] lista.

ketszer [] = []
ketszer (x:xs) = x:x: ketszer xs

-- OUTPUT
    -- > ketszer ["bu","ek"]
    -- ["bu","bu","ek","ek"]




-- 2. Határozzuk meg az N-edik Fibonacci-számot.
-- Számítsuk ki a 30-adik elemét a sornak.
-- Mi történik, ha az 150-edik Fibonacci-számot szeretnénk meghatározni?
-- F(N) Fibonacci-szám, ha F(N) = F(N-1) + F(N-2), illetve F(0)=1, és F(1)=1.

f 0 = 1
f 1 = 1
f x = f (x-1) + f (x-2)

-- OUTPUT
    -- > f 30
    -- 1346269

    -- > f 150
    -- running... running... - I get the gist: it's not optimal







-- 3. Határozzuk meg a Fibonacci-számok (végtelen) listáját,
-- majd a TAKE függvényt használva határozzuk meg az első 30,
-- majd az első 150 elemet.

fib = 0 : 1 : zipWith (+) fib (tail fib)

-- OUTPUT:
    -- > take 30 fib
    -- [0,1,1,2,3,5,8,13,21,...,196418,317811,514229]

    -- > take 150 fib
    -- [0,1,1,2,3,5,8,13,21,...,3807901929474025356630904134051,6161314747715278029583501626149]






-- 4. Írjunk függvényt, mely visszaadja egy lista legkisebb elemét.

-- TERNARY OPERATOR
data Cond a = a :? a

infixl 0 ?
infixl 1 :?

(?) :: Bool -> Cond a -> a
True  ? (x :? _) = x
False ? (_ :? y) = y

legkisebb :: [Int] -> Int
legkisebb [] = -1
legkisebb xs = foldr1 (\x y -> (x<=y)?x:?y) xs

-- 5 Írjunk függvényt, mely visszaadja egy lista két legnagyobb elemét
-- (ne használjunk rendezést vagy listamódosítást igénylő műveleteket).






-- 6 Írjunk függvényt, mely kettéoszt egy listát úgy, hogy az egyik elemet az első listába,
-- a következőt a második listába teszi.
-- Javaslat: a függvény legyen oszt::[a] -> ([a], [a]) típusú.

-- oszt :: [a] -> ([a],[a])
oszt x:xs = ([x],[])++oszt xs


-- 7. Írjunk függvényt, mely összefésül két listát.
-- A két listáról feltételezzük, hogy rendezettek és
-- legyen a kimenő lista is rendezett.




-- 8. Írjuk meg két szám legkisebb közös többszörösét meghatározó függvényt.




-- 9. Írjunk függvényt, mely egy listáról meghatározza,
-- hogy palindróma-e: a lista ugyanaz, mint a lista fordítottja
-- (pl. a "lehel" igen, a "csato" nem).





-- 10. Töröljük egy lista minden K-adik elemét.





-- 11. Valósítsuk meg a "run-length encoding" algoritmust Haskell-ben:
-- egy redundáns - sok egyforma elemet tartalmazó - listát úgy alakítunk kompakt formába,
-- hogy az ismétlődő elemek helyett egy párost tárolunk, ahol az első az elem, a második a multiplicitás.
-- Például
--     kompakt(["a","a","a","c","c","b"]) -> [("a",3),("c",2),("b",1)]
--     Írjuk meg a kódokat úgy, hogy a listát csak egy alkalommal járjuk be.