%------------------------- Elimina elementos de N em N --------------------------
elimina(_, _, [], []).
elimina(N, Count, [_ | Lista], R) :-
    0 is mod(Count, N), Count2 is Count + 1,
    elimina(N, Count2, Lista, R).


elimina(N, Count, [X | Lista], [X | R]) :-
    Count2 is Count + 1,
    elimina(N, Count2, Lista, R).

%------------------------ Totaliza N em N --------------------------------------
len(N, [], N).
len(N, [_ | Lista], R) :- N2 is N + 1, len(N2, Lista, R).

soma(Sum, [], Sum).
soma(Sum, [X | Lista], R) :- Sum2 is Sum + X, soma(Sum2, Lista, R).

totn(_, _, _, [], []).
totn(N, I, _, Lista, ListaRes) :-
    len(0, Lista, X), X < N, Y is mod(I, N), Y \= 0,
    soma(0, Lista, L),
    ListaRes = [L].


totn(N, I, Sum, [X| Lista], [Soma | ListaRes]) :-
    0 is mod(I, N), I2 is I + 1, Soma is Sum + X,
    totn(N, I2, 0, Lista, ListaRes).

totn(N, I, Sum, [X| Lista], ListaRes) :-
    Y is mod(I, N), Y \= 0,
    I2 is I + 1, Soma is Sum + X,
    totn(N, I2, Soma, Lista, ListaRes).

totn(N, Lista, Resultado) :-
    totn(N, 1, 0, Lista, Resultado).

%------------------------ Mantém elementos de N em N e elimina o resto ---------------------

mantem(_, _, [], []).

mantem(N, I, [X | Lista], [X | ListaRes]) :-
    0 is mod(I, N), I2 is I + 1, 
    mantem(N, I2, Lista, ListaRes).

mantem(N, I, [_ | Lista], ListaRes) :-
    Y is mod(I, N), I2 is I + 1, Y \= 0,
    mantem(N, I2, Lista, ListaRes).

%---------------------------- enúplica os elementos de uma lista -----------------------
multiplica(0, _, []).
multiplica(N, E, [E | R]) :- N > 0, N2 is N - 1, multiplica(N2, E, R).

enuplica(_, [], []).
enuplica(N, [X | Lista], ListaRes) :-
    multiplica(N, X, L2),
    enuplica(N, Lista, Lista2), append(L2, Lista2, ListaRes).

%------- Responde verdadeiro se a soma dos maiores ou iguais a N é maior que a soma dos menores que N---------

verifica(N, L) :- verifica(N, 0, 0, L).

verifica(_, SumMenores, SumMaiores, []) :- SumMaiores > SumMenores.

verifica(Num, SumMenores, SumMaiores, [X | Lista]) :-
    X >= Num, SumMaiores2 is SumMaiores + X,
    verifica(Num, SumMenores, SumMaiores2, Lista).

verifica(Num, SumMenores, SumMaiores, [X | Lista]) :-
    X < Num, SumMenores2 is SumMenores + X,
    verifica(Num, SumMenores2, SumMaiores, Lista).
