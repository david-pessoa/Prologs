/****************************************************
membro de uma lista
membro (5, [2, 3, 4, 5, 6, 1]).
>true
****************************************************/
membro(A, [A|X]).
membro(A, [B|X]) :- membro(A, X).
