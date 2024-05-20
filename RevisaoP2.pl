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
