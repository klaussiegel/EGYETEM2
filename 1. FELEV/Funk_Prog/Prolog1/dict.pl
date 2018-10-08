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

kszor(1,[A|X],[A,A|X]).
kszor(_,[],[]).
kszor(N,[H|T],[H,H|T]) :-
    Nn is N - 1,
    kszor(Nn,[H|T],[H,H|T]),
    kszor(N,T,[H|T]).


% 3. Adjuk össze egy lista elemeit
% (megoldásnál nem kell ellenőrizni a lista
% numerikus voltát, a Prolog csak a numerikus
% listákra ad eredményt).

osszead([Item],Item).
osszead([A,B|T],Ans) :- osszead([A+B|T],Ans).