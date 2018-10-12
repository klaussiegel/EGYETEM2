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

torolk([],_,[]).
torolk([A|B],0,B).
torolk([A|B],K,L) :-
