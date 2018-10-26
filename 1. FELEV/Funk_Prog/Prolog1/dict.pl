% Oláh Tamás-Lajos
% otim1750
% 513 / 2

% 1. Duplázzunk meg egy listát - azaz az [a,b,c] listára az
% eredmény legyen [a,a,b,b,c,c]. Törekedjünk hatékony megoldásra.
% Például:
%         (1) legyen igaz a dupla([c,v],[c,c,v,v]) kijelentés;
%         (2) a dupla([1,2,3],L) kiértékelés az L=[1,1,2,2,3,3]
%         eredményt adja.
dupla([],[]).
dupla([A|X],[A,A|Y]) :- dupla(X,Y).

% 2. Sokszorozzunk meg egy listát - hasonlóan a
% duplázáshoz - ahol mindegyik elem 'K'-szor jelenjen meg.
%  Például: a kszor(3,[bu,ek],L) kiértékelés az
%           L=[bu,bu,bu,ek,ek,ek]
%           eredményt adja.

duplazz(_,0,[]).
duplazz(E,K,[E|T]) :-
    K>0,
    KK is K-1,
    duplazz(E,KK,T).

kszor(_,[],[]).
kszor(N,[A|H],L) :-
    duplazz(A,N,LL),
    kszor(N,H,LLL),
    append(LL,LLL,L).

% 3. Adjuk össze egy lista elemeit
% (megoldásnál nem kell ellenőrizni a lista
% numerikus voltát, a Prolog csak a numerikus
% listákra ad eredményt).

osszead([],0).
osszead([A|T],Ans) :-
    osszead(T,AAns),
    Ans is AAns + A.

% 4. Generáljuk a számok listáját 'a' és 'b' között.
general(A,A,[A|_]).
general(A,B,L) :-
    BB is B-1,
    general(A,BB,LL),
    append(LL, [B], L).

% 5. Invertáljunk egy listát.
% Használjuk a lista-invertálást az 1-18000
% lista inverzének a kiszámítására.

invertal([A],[A]).
invertal([A|B],L) :-
    invertal(B,LL),
    append(LL,[A],L).

% 6. Töröljük egy lista minden K-adik elemét,
% azaz legyen igaz a
%       torolk([1,2,3,4,5,6,7,8],2,[1,3,5,7])
% predikátum.

% torolk(In,K,Out) :-
%    same_length(In,[_|Out]),
%    append(Pre,[_|Suf],In),
%    length([_|Pre],K),
%    append(Pre,Suf,Out).

delete_nth(L,C,R) :-
    findall(E, (nth1(I,L,E),I mod C =\= 0), R).
delete_nth(L,0,L).


% 7. Teszteljük, hogy egy lista lehet-e permutációja az
% [1..N] közötti számoknak, ahol N a lista hossza:
%  minden eleme az 1 és N között van.
% Például:
%       perm([1,2,3,4]) -> true, illetve
%       perm([1,2,4,4]) -> false.
%
% Javaslat:
%       számítsuk ki a lista hosszát, generáljuk az 1..N közötti elemek listáját,
%       majd teszteljük, hogy a két lista egymás permutációja-e.

len([],0).
len([_|Xs],L) :-
    len(Xs,N),
    L is N+1.

is_permutation(Xs, Ys) :-
    msort(Xs, Sorted),
    msort(Ys, Sorted).

perm(L) :-
    len(L,LL),
    numlist(1, LL, Ctrl),
    is_permutation(L,Ctrl).

% 8. Alakítsunk át egy listát kompakt formába:
% az ismétlődő egymásutáni atomokat helyettesítsük egy olyan kételemű listával,
% melyben az első az atom, a második az atom sokszorossága faktora.
%
% Amennyiben az atom számossága 1, akkor egyszerűen másoljuk át az elemet a "kimenet"-be.
%
% Például:
%       A kompakt([a,a,a,b,a,a,c,c,b,d,d,d,d],[[a,3],b,[a,2],[c,2],b,[d,4]]).
%       predikátum igaz kell, hogy legyen. (kezeljük az összes esetet)

felsorol([],[]).
felsorol([H|T],[[H,1]|Out]) :-
    felsorol(T,Out).

osszecsuk([],[]).
osszecsuk([X],[X]).
osszecsuk([[X,A1],[X,A2]|T],Out) :-
    N is A1+A2,
    osszecsuk([[X,N]|T],Out).

osszecsuk([[X,A1],[Y,A2]|T],[[X,A1]|Out]) :-
    X \= Y,
    osszecsuk([[Y,A2]|T],Out).

kompakt(L,Out) :-
    felsorol(L,X),
    osszecsuk(X,Out).


% 9. Tekintsük az alábbi logikai feladatot:
%     S E N D   +
%     M O R E  =
%   ----------
%   M O N E Y
%
% Tudva, hogy a fenti betűk különböző számjegyeket kódolnak úgy,
% hogy egyik első számjegy sem nulla, találjuk meg a megoldásokat.

% D E M N O R S Y

szam(0).
szam(1).
szam(2).
szam(3).
szam(4).
szam(5).
szam(6).
szam(7).
szam(8).
szam(9).

megold(L) :-
    L = [D,E,M,N,O,R,S,Y],
    szam(D),
    szam(E),
    M is 1,
    szam(N),
    szam(O),
    szam(R),
    szam(S),
    szam(Y),
    D\=E, D\=M, D\=N, D\=O, D\=R, D\=S, D\=Y,
    E\=M, E\=N, E\=O, E\=R, E\=S, E\=Y,
    M\=N, M\=O, M\=R, M\=S, M\=Y,
    N\=O, N\=R, N\=S, N\=Y,
    O\=R, O\=S, O\=Y,
    R\=S, R\=Y,
    S\=Y,
    S \= 0, M \= 0,
    A is D + 10*N + 100*E + 1000*S,
    B is E + 10*R + 100*O + 1000*M,
    C is Y + 10*E + 100*N + 1000*O + 10000*M,
    CC is A+B,
    C = CC.


% 10.	Adott a filmek adatbázis (movies.zip) .
% Az adatbázist be tudjuk olvasni a Prolog-ba (a rendszer indítása után) a
%               ?- consult(movies),
% paranccsal (figyeljünk arra, hogy a movies.pl az aktuális könyvtárban legyen)
%    (rövid formában ez: [movies]. )

%   a.) Keressük meg azon színészeket (actor vagy actress),
%       akik csak egy filmben játszanak.

lista_actor(L) :-
    findall(LL, actor(_,LL,_), L).

lista_actress(L) :-
    findall(LL, actress(_,LL,_), L).

bejar([],[]).

bejar([_|T1],T2) :-
    bejar(T1,T2).

bejar([[A,1]|T1],[A|T2]) :-
    bejar(T1,T2).

bejar([[A,1]|T],[A])  :-
    bejar(T,[A]).

egyszer(Out,Out_L) :-
    lista_actor(LM),
    lista_actress(LF),
    append(LM, LF, LN),
    sort(LN, LNS),
    kompakt(LNS,LC),
    bejar(LC,Out),
    length(Out,Out_L).


%   b.) Keressük meg azon színészeket (actor vagy actress),
%       akik pontosan két filmben játszanak.

bejar2([],[]).

bejar2([[_,_]|Com],Rest) :-
    bejar2(Com,Rest).

bejar2([[A,2]|Com],[A|Rest]) :-
    bejar2(Com,Rest).

ketszer(Out,Out_L) :-
    lista_actor(LM),
    lista_actress(LF),
    append(LM, LF, LN),
    sort(LN, LNS),
    kompakt(LNS,LC),
    bejar2(LC,Out),
    length(Out,Out_L).


%   c.) az adatbázisban találunk színészeket,
%       akik nem játszottak egy filmben sem?
