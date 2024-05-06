split([], [], []).
split([A], [A], []).
split([A, B | X], [A|As], [B|Bs]) :- split(X, As, Bs).
%----------------------------------------------------------------------------------
split2(L, L1, L2) :- tam(L, Tam), T is Tam/2, N is ceiling(T), npri(N, L, L1, L2).
npri(1, [A|As], [A], As).
npri(N, [A|As], [A|X], Resto) :- N2 is N - 1, npri(N2, As, X, Resto).
%----------------------------------------------------------------------------------
