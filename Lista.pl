% --------------------------- Exercício 1 ----------------------


% --------------------------- Exercício 2 ----------------------
ateh(E, [E | L], [E]).
ateh(E, [], []).
ateh(E, [X | L], R) :- ateh(E, L, R1), R = [X | R1].

%--------------------------- Exercício 3 -----------------------
apos(E, [], []).
apos(E, [E | L], L).
apos(E, [X | L], R) :- apos(E, L, R1), R = R1.

%--------------------------- Exercício 4 -----------------------
npri(0, []).
npri(N, Lista) :- N1 is N - 1, npri(N1, Lista1), append(Lista1, [N], Lista).

%-------------------------- Exercício 5 -------------------------
gera_m_mult(_, 0, []).
gera_m_mult(N, M, Lista) :- M1 is M - 1,
    (M mod N =:= 0, gera_m_mult(N, M1, Lista1), append(Lista1, [M], Lista); 
    gera_m_mult(N, M1, Lista)).

%-------------------------- Exercício 6 -------------------------
conta(_, [], 0).
conta(N, [X | Lista], F) :- N =:= X, conta(N, Lista, F2), F is F2 + 1;
    conta(N, Lista, F).

find_max([], _, MaxF, MaxN, MaxN).
find_max([X | Lista], L, MaxF, MaxN, R) :-
    conta(X, L, F),
    F > MaxF,
    find_max(Lista, L, F, X, R).
find_max([X | Lista], L, MaxF, MaxN, R) :-
    conta(X, L, F),
    F =< MaxF,
    find_max(Lista, L, MaxF, MaxN, R).

main :-
    Lista = [3, 3, 4, 3, 4, 8, 8, 8, 8, 8, 3, 3, 3],
    find_max(Lista, Lista, 0, 0, R),

%------------------------ Exercício 7 -----------------------------
