% Oláh Tamás-Lajos
% otim1750
% 523 / 2

:- use_module(library(random)).

% 1. Használjuk a random predikátumot egy véletlen-számokat
% tartalmazó N elemű lista generálására.
% A véletlen-számokat az [1,D] intervallumból vegyük,
% ahol a D intervallum-hossz méretét is meg tudjuk adni.

veletlen(N,_,N,[]) :- !.

veletlen(N,D,X,[H|T]) :-
    X < N,
    random_between(1, D, H),
    XX is X+1,
    veletlen(N,D,XX,T).

veletlen(N,D,L) :-
    veletlen(N,D,0,L).


% 2. Írjunk predikátumot egy véletlen-permutáció generálására.
% Például a
%     randperm(4,L)
% válasza legyen az [1,2,3,4] valamely permutációja.

general(A,A,[A]):-!.
general(A,B,[A|T]) :-
    AA is A+1,
    general(AA,B,T).

veletlen_perm(_,[],[]):-!.

veletlen_perm(N,Ctrl,[H|T]) :-
    random_select(H, Ctrl, Rest),
    veletlen_perm(N,Rest,T).

veletlen_perm(N,L) :-
    general(1,N,Ctrl),
    veletlen_perm(N,Ctrl,L).

% 3. Írjuk meg a deriválás szabályait.
% Használjuk a négy alapműveletet (+,-,*,/)
% és a két trigonometriai függvényt (sin, cos).
% Például a
%     Kif=3*x+2
% kifejezés deriváltja legyen a
%     D=3
% (esetleges - átalunk végzett - egyszerűsítések után. Eredetileg lehet: D=3*1 + 0*3 + 0).

d(x,1) :- !.

d(-X,Out) :-
    d(X,DX),
    Out = -DX,
    !.

d(sin(X), Out) :-
    d(X,DX),
    Out = cos(X) * DX,
    !.

d(cos(X),Out) :-
    d(X,DX),
    Out = -sin(X) * DX,
    !.

d(X+Y,Out) :-
    d(X,DX),
    d(Y,DY),
    Out = DX + DY,
    !.

d(X-Y,Out) :-
    d(X,DX),
    d(Y,DY),
    Out = DX - DY,
    !.

d(X*Y,Out) :-
    d(X,DX),
    d(Y,DY),
    Out = (DX*Y)+(X*DY),
    !.

d(X/Y,Out) :-
    d(X,DX),
    d(Y,DY),
    Out = (DX*Y - X*DY) / (Y^2),
    !.

d(_,0).


% 4. Vizsgáljuk meg a FILMEK tudásbázist,
% mely a movies.pl-ban található.
% A file beolvasása a rendszerbe a:
%     consult(movies).
% vagy
%     [movies].
% paranccsal lehetséges.

% Vegyük észre a
%     :- style_check(-discontiguous).
% parancsot. Mi történik?

% KIVONAT A SWI PROLOG DOKUMENTÁCIÓJÁBÓL
% http://www.swi-prolog.org/pldoc/man?predicate=style_check/1
    % style_check(+Spec)
        % Modify/query style checking options. Spec is one of the terms below or a list of these.

            % +Style enables a style check
            % -Style disables a style check
            % ?(Style) queries a style check (note the brackets).
                % If Style is unbound, all active style check options are returned on backtracking.
        % ...
        % discontiguous(true)
            % Warn if the clauses for a predicate are not together in the same source file.
            % It is advised to disable the warning for discontiguous predicates
            % using the discontiguous/1 directive.

% A tudásbázisban az alábbi típusok tények vannak:
%     % movie(M,Y) -- movie M came out in year Y
%     movie(american_beauty, 1999).

%     % director(M,D) -- movie M was directed by director D
%     director(american_beauty, sam_mendes).

%     % actor(M,A,R) -- actor A played role R in movie M
%     actor(american_beauty, kevin_spacey, lester_burnham).

%     % actress(M,A,R) -- actress A played role R in movie M
%     actress(american_beauty, annette_bening, carolyn_burnham).

% Írjuk meg a következő lekérdezéseket,
% használva, ha lehetséges és ésszerű,
% összevonásokat - join műveleteket:

%     1. Találjuk meg az 1980 előtt rendezett filmek évszámait (egy listában).

before_1980(L) :-
    findall(X, ( movie(_,X) , X<1980 ), L),
    !.

%     Keressük meg a 2000 és 2005 közötti filmek rendezőit (egy listában).

bet_05_dir() :-
    findall(N, (director(X,N),movie(X,Y),Y>=2000,Y=<2005),L),
    print(L),
    !.

bet_05_dir(L) :-
    findall(N, (director(X,N),movie(X,Y),Y>=2000,Y=<2005),L),
    !.

%     2. Kérdezzük le, hogy két filmet ugyanabban az évben rendeztek-e.

ugyanaz_ev(F1,F2) :-
    movie(F1,X), movie(F2,X), F1 \== F2, X = X, !.

%     Keressük meg, hogy két színész (vagy színésznő) jóPartner-e.
%     jóPartner két színész, ha közösen játszott több, mint egy (1) filmben.

joPartner(X,Y) :-
    ( actor(_,X,_) ; actress(_,X,_) ),
    ( actor(_,Y,_) ; actress(_,Y,_) ),
    X \== Y,
    (actor(F1,X,_) ; actress(F1,X,_) ),
    (actor(F1,Y,_) ; actress(F1,Y,_) ),
    (actor(F2,X,_) ; actress(F2,X,_) ),
    (actor(F2,Y,_) ; actress(F2,Y,_) ),
    F1 \== F2, !.


%     3. A Film az Ev-nél régebbi-e.

% Regebbi-e mint Ev-szam
regebbi_e(Film,Ev) :-
    movie(Film,X),
    Ev>X.

% Idosebb-e Ev evnel
regebbi_e2(Film,Ev) :-
    movie(Film,X),
    Ctrl is 2018-X,
    Ev =< Ctrl.

%     Kérdezzük le azt, hogy egy Film korábbi-e egy másik Film-nél.

regebbi_film_e(F1,F2) :-
    movie(F1,Y1),
    movie(F2,Y2),
    Y1 < Y2.

%     4. Keressük meg hány különböző színész szerepel a tudásbázisban.

act(L) :-
    actor(_,L,_).

act(L) :-
    actress(_,L,_).

osszes_szinesz(Out) :-
    setof(L, act(L), Out).

osszes_szinesz() :-
    setof(L, act(L), Out),
    print(Out).

hany_szinesz(Ans) :-
    osszes_szinesz(L),
    length(L,Ans).

%     5. Keressük meg a favorit színészeket: azon 25 színész, melyek a legtöbb más társukkal jóPartnerek.

joPartner_num(A,X) :-
    findall(Q,joPartner(A,Q),Out),
    length(Out,X).

top25(X):-
    osszes_szinesz(L),
    
