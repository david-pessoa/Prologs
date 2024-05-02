/*
=< --> Menor ou igual a
=:= --> Igual: avalia se dois valores são iguais
= --> checa se os "objetos" são iguais, ou atribui valores às variáveis (unificação de termos)
is --> aytribuição
\= --> diferente
\+ --> negação

*/

soma(A, B, S) :- S is A + B.

checa() :- write("Digite o valor de X: "), nl,
           read(X), nl,
           (
           (X =< 100, write("O número é menor ou igual a 100")), nl;
           (X > 100, write("O número é maior que 100")), nl
           ).

