
/*---------------------------------------------
--01 membro da lst
---------------------------------------------*/

membro(A,[A|X]).
membro(A,[_|X]) :- membro(A,X).

/*---------------------------------------------
--02 quantos elementos na lst
---------------------------------------------*/

tam([],0).
tam([_|X],R) :- tam(X,T), R is T+1.

/*---------------------------------------------
--03 soma os elementos da lst
---------------------------------------------*/

soma([],0).
soma([A|X],R) :- soma(X,T), R is T+A.


/*---------------------------------------------
--04 soma 2 listas, elem a elem
---------------------------------------------*/

soma2L([],L,L).
soma2L(L,[],L).
soma2L([A|As],[B|Bs],[C|Cs]) :- C is A+B, soma2L(As,Bs,Cs).

/*---------------------------------------------
--05 cria um conjunto a partir de uma lista
---------------------------------------------*/

conj([],[]).
conj([A],[A]).
conj([A|X],Z) :- membro(A,X), conj(X,Z).
conj([A|X],[A|Z]) :- conj(X,Z).

/*---------------------------------------------
--06 intersecção entre dois conjuntos 
---------------------------------------------*/

inters([],L,[]).
inters(L,[],[]).
inters([A|X],L,[A|Z]) :- membro(A,L), inters(X,L,Z).

/*---------------------------------------------
--13 acha menor de uma lista nao vazia
---------------------------------------------*/

menor([A],A).
menor([A|As],R) :- menor(As,A,R).

menor([],M,M).
menor([A|As],M,R) :- A < M, menor(As,A,R).
menor([A|As],M,R) :- menor(As,M,R).

/*---------------------------------------------
--14 deleta 1a ocorrência de um elem da lst
---------------------------------------------*/

delpri(Elem,[],[]).
delpri(Elem,[Elem|X],X).
delpri(Elem,[A|As],[A|X]) :- delpri(Elem,As,X).

/*---------------------------------------------
--15 deleta todas as ocorr do elem na lst
---------------------------------------------*/

delall(Elem,[],[]).
delall(Elem,[Elem|X],Z) :- delall(Elem,X,Z).
delall(Elem,[A|As],[A|X]) :- delall(Elem,As,X).
