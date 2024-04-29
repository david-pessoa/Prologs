/****************************************************/ 
/*
membro de uma lista
membro (5, [2, 3, 4, 5, 6, 1]).
>true 
*/
membro(A, [A|X]).
membro(A, [B|X]) :- membro(A, X).

/****************************************************/ 
/*
interseccao
inter([1, 2, 3, 4], [4, 5, 2, 9], R).
>R = [2, 4] 
*/
inter([], _, []).
inter([], _, []).
inter([A|X], L, [A|Z]) :- membro(A, L), inter(X, L, Z).
inter([A|X], L, Z) :- inter().

/****************************************************/ 
/*
deleta primeira ocorrência
delpri(5, [3, 5, 2, 1, 5, 5, 6], R).
R = [3, 2, 1, 5, 5, 6]
*/
delpri(Elem, [], []).
delpri(Elem, [Elem|X]], X).
delpri(Elem, [A|X], [A|Z]) :- delpri(Elem, X, Z). 

/****************************************************/ 
/*divide lista */
divide([], [], []).
divide([A], [B], []).
divide([A, B|X], [A|As], [B|Bs]) :- divide(X, As, Bs).

divide2(L, R1, R2) :- divide2(L, [], [], R1, R2).
divide2([], R1, R2, R1, R2).
divide2([A], L1, R2, [A|L1], R2).
divide2([A, B|X], L1, L2, R1, R2) :- divide2(Z, [A|L1], [B|L2], R1, R2).















