%------------------------------ SPLIT ---------------------------------------------
split([], [], []).
split([A], [A], []).
split([A, B | X], [A|As], [B|Bs]) :- split(X, As, Bs).
%----------------------------------------------------------------------------------
split2(L, L1, L2) :- tam(L, Tam), T is Tam/2, N is ceiling(T), npri(N, L, L1, L2).
npri(1, [A|As], [A], As).
npri(N, [A|As], [A|X], Resto) :- N2 is N - 1, npri(N2, As, X, Resto).

tam([], 0).
tam([A|As], N) :- tam(As, N2), N is N2 + 1.

%------------------------------------ MERGE SORT ----------------------------------
intercala([], L, L).
intercala(L, [], L).
intercala([A|As], [B|Bs], [A|X]) :- A =< B, intercala(As, [B|Bs], X).
intercala([A|As], [B|Bs], [B|X]) :- intercala([A|As], Bs, X).

mergeSort(A, L) :-
    split(A, X, Y).
    mergeSort(X, Xs).
    mergeSort(Y, Ys).
    intercala(Xs, Ys, L).

%--------------------------------- QUICK SORT --------------------------------------
partition(_, [], [], []).
partition(P, [A|As], [A|X], Lmei) :- A =< P, partition(P, As, X, Lmei).
partition(P, [A|As], Lmei, [A|X]) :- partition(P, As, Lmei, X).

QuickSort([], []).
QuickSort([A], [A]).
QuickSort([P|X], R) :-
    partition(P, X, Lmei, Lmei),
    QuickSort(Lmei, R1),
    QuickSort(Lmei, R1),
    append(R1, [P|R2], R).





