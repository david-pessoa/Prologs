
/*---------------------------------------------------------------------
(1) Escreva o partit, que recebe uma lista L não vazia e particiona a
lista da seguinte maneira: devolve a tripla Lmen, Pivot, Lmai, onde
Lmen é a lista dos elementos menores que o pivot e Lmai é a lista dos
maiores iguais. O pivot é o primeiro elemento da lista. A seguir temos
um exemplo de execução do partit
---------------------------------------------------------------------*/

partit([Pivot|As],(Lmen,Pivot,Lmai)) :- part(As,Pivot,[],[],Lmen,Lmai).

part([],P,Lmen,Lmai,Lmen,Lmai).
part([A|As],P,Lmen,Lmai,Rmen,Rmai) :-
    A =< P,
    append(Lmen,[A],Lmen2),
    part(As,P,Lmen2,Lmai,Rmen,Rmai).
part([A|As],P,Lmen,Lmai,Rmen,Rmai) :-
    append(Lmai,[A],Lmai2),
    part(As,P,Lmen,Lmai2,Rmen,Rmai).

/*---------------------------------------------------------------------
(2) Crie o interc do mergesort. O interc recebe 2 listas ordenadas
(ordem não decrescente) e as intercala em uma única lista ordenada
(idem).
---------------------------------------------------------------------*/

interc(L,[],L).
interc([],L,L).
interc([A|As],[B|Bs],[A|Xs]) :-
    A =< B,
    interc(As,[B|Bs],Xs).
interc([A|As],[B|Bs],[B|Xs]) :-
    interc([A|As],Bs,Xs).

/*---------------------------------------------------------------------
(3) Escreva o selection sort.
---------------------------------------------------------------------*/

selsort([],[]).
selsort(L,[M|R]) :- menor(L,M), delpri(M,L,L2), selsort(L2,R).

menor([A|As],R) :- menor(As,A,R).
menor([],R,R).
menor([A|As],Ac,R) :- A<Ac, menor(As,A,R).
menor([A|As],Ac,R) :- menor(As,Ac,R).

delpri(E,[],[]).
delpri(E,[E|Es],Es).
delpri(E,[A|As],[A|X]) :- delpri(E,As,X).

/*---------------------------------------------------------------------
(4) Escreva o mergesort
---------------------------------------------------------------------*/

ms([],[]).
ms([A],[A]).
ms(L,R) :- split(L,L1,L2), ms(L1,R1), ms(L2,R2), interc(R1,R2,R).

split([],[],[]).
split([A],[A],[]).
split([A,B|X],[A|As],[B|Bs]) :- split(X,As,Bs).

/*---------------------------------------------------------------------
(5) Escreva o quicksort
---------------------------------------------------------------------*/

qs([],[]).
qs([A],[A]).
qs(L,R) :-
    partit(L,(Lmen,P,Lmai)),
    qs(Lmen,Rmen),
    qs(Lmai,Rmai),
    append(Rmen,[P|Rmai],R).

/*---------------------------------------------------------------------
(6) Escreva o programa vseq que verifica se uma lista L1 ocorre---na
sequência---dentro de outra lista L2.
---------------------------------------------------------------------*/

vseq([],_).
vseq(L1,L2) :- vseq(L1,L1,L2).

vseq([],_,_).
vseq([A|As],L1,[A|Xs]) :- vseq(As,L1,Xs).
vseq([A|As],L1,[B|Bs]) :- vseq(L1,L1,Bs).

/*---------------------------------------------------------------------
(7) Escreva um programa para encontrar a altura de uma árvore
equivalente a árvore tipo T vista no Haskell.
---------------------------------------------------------------------*/

arv(folha(N)).
arv(no(N,A,B)) :- arv(A), arv(B).

t1(no(10, 
    no(10,folha(10),folha(5)),
    no(20,no(20,folha(5),folha(10)),folha(30)))).
%120

t2(no(10, 
    no(10,folha([3,7]),folha([5,5,5,5,5,5])),
    no(20,no(20,folha([10,5,5,5,5,5,5]),folha([10,10,10])),folha([1,2,3,4])))).
%% 180

maior(A,B,A) :- A >= B.
maior(A,B,B).


h(folha(_),1).
h(no(_,Te,Td),R) :- h(Te,He), h(Td,Hd), maior(He,Hd,M), R is M+1. 

/*---------------------------------------------------------------------
(8) Efetue os percursos pre, in e pos em uma árvore tipo arv.
---------------------------------------------------------------------*/

pre(folha(N)) :- write(' '), write(N).
pre(no(N,Te,Td)) :-  write(' '), write(N), pre(Te), pre(Td).

in(folha(N)) :- write(' '), write(N).
in(no(N,Te,Td)) :- in(Te), write(' '), write(N), in(Td).

pos(folha(N)) :- write(' '), write(N).
pos(no(N,Te,Td)) :- pos(Te), pos(Td), write(' '), write(N).

/*---------------------------------------------------------------------
(9) Encontre a soma de todos os valores de uma árvore que tem listas
nas folhas e inteiros nos nós.
---------------------------------------------------------------------*/

somaT(folha(L),S) :- sum(L,S).
somaT(no(N,Te,Td),R) :-
    somaT(Te,Se),
    somaT(Td,Sd),
    R is Se+Sd+N.

val(N,N) :- integer(N).
val([N|Ns],R) :- sum([N|Ns],R).

sum([],0).
sum([A|As],R) :- sum(As,T), R is T+A.

/*---------------------------------------------------------------------
(10) Escreva um predicado que recebe como entrada uma árvore T e
retorna como resultado, uma árvore de mesmo tipo, mas com o valor
original de cada nó ou folha, substituído pela quantidade de vezes que
aquele valor apareceu na árvore.
---------------------------------------------------------------------*/

troc_val_qtd(Tree1,Tree2) :- tvq(Tree1,Tree1,Tree2).

tvq(folha(Val),Tree,folha(Qtd)) :- qtdVal(Val,Tree,Qtd). 
tvq(no(Val,Te1,Td1),Tree,no(Qtd,Te2,Td2)) :-
    qtdVal(Val,Tree,Qtd),
    tvq(Te1,Tree,Te2),
    tvq(Td1,Tree,Td2).
    
qtdVal(Val,folha(Val),1).
qtdVal(_,folha(_),0).
qtdVal(Val,no(Val,Te,Td),R) :-
    qtdVal(Val,Te,Re),
    qtdVal(Val,Td,Rd),
    R is Re+Rd+1.
qtdVal(Val,no(_,Te,Td),R) :-
    qtdVal(Val,Te,Re),
    qtdVal(Val,Td,Rd),
    R is Re+Rd.