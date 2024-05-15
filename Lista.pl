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
conta(N, [X | Lista], F) :- N =:= X, conta(N, Lista, F2), F is F2 + 1.
   

conta(N, [X | Lista], F) :- N \= X, conta(N, Lista, F).

find_max([], _, MaxF, MaxN, MaxN).
find_max([X | Lista], L, MaxF, MaxN, R) :-
    conta(X, L, F),
    F > MaxF,
    find_max(Lista, L, F, X, R).
find_max([X | Lista], L, MaxF, MaxN, R) :-
    conta(X, L, F),
    F =< MaxF,
    find_max(Lista, L, MaxF, MaxN, R).

menu :-
    Lista = [3, 3, 4, 3, 4, 8, 8, 8, 8, 8, 3, 3, 3],
    find_max(Lista, Lista, 0, 0, R),
    write("Número com maior frequência na lista: "),
    write(R).
%------------------------ Exercício 7 -----------------------------
mtam([], []).
mtam([X | ListaA], [Y | ListaB]) :- mtam(ListaA, ListaB).

%----------------------- Exercício 8 -------------------------------
tri([], []).
tri([X | Lista], [X, X, X | ListaTriplicada]) :- tri(Lista, ListaTriplicada).

%------------------------ Exercício 9 -------------------------------
node(No, Pai, FilhoEsq, FilhoDir). %Nó qualquer
node(No, [], [], []). %árvore de um nó
node(No, [], FilhoEsq, FilhoDir). %primeiro nó 
node(No, Pai, FilhoEsq, []). %nó com pai e filho FilhoEsq
node(No, Pai, [], FilhoDir). %nó com pai e filho FilhoDir

folha(No, Pai, [], []). %nó folha


subs(A, B, tree(NO, ND, NE), tree(NR, NDR1, NER1)) :- 
    NO =:= A, subs(A, B, tree(B, ND, NE), tree(B, NDR1, NER1));
    NO \= A, subs(A, B, tree(NO, ND, NE), tree(NO, NDR1, NER1)).


%subs(3, 2, tree(1, 2, 3), tree(NO, NDR1, NER1)).
