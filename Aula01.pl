/****************************************************
membro de uma lista
membro (5, [2, 3, 4, 5, 6, 1]).
>true

membro(A, [A|X]).
membro(A, [B|X]) :- membro(A, X).

/****************************************************
interseccao
inter(1, 2, 3, 4], [4, 5, 2, 9], R).
>R = [2, 4]

inter([], _, []).
inter([], _, []).
inter([A|X], L, [A|Z]) :- membro(A, L), inter(X, L, Z).
inter([A|X], L, Z) :- inter().

****************************************************/
deleta primeira ocorrência

delpri(5, [3, 5, 2, 1, 5, 5, 6], R).
R = [3, 2, 1, 5, 5, 6]

****************************************************/
