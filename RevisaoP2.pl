% Arvore T1
t1(no(5,
        no(7, 
              no(2, f(1), f(9)),
              f(8)),
        no(3, f(4), f(6)))).

/******************** Altura do Nó ***********************/
h(f(_), 1).
h(no(_, Te, Td), H) :- h(Te, He), h(Td, Hd), maior(He, Hd, Hvenc), H is 1 + Hvenc.

maior(A, B, A) :- A > B.
maior(A, B, B) :- B >= A.

/******************** Troca valor por altura **************/
trocaH(f(_), f(1)).
trocaH(no(_, Te, Td), no(H, Te2, Td2)) :-
        h(no(_, Te, Td), H),
        trocaH(Te, Te2),
        trocaH(Td, Td2).
        
/******************** Troca valor por numero de ocorrencia *************/
qtde(Val, Tree, N).
qtde(Val, f(Val), 1).
qtde(V1, f(V2), 0) :- V1 \= V2.
qtde(Val, no(Val, Te, Td), N) :- qtde(Val, Te, Ne), qtde(Val, Td, Nd), N is 1 + Ne + Nd.
qtde(V1, no(V2, Te, Td), N) :- qtde(Val, Te, Ne), qtde(Val, Td, Nd), N is Ne + Nd.
