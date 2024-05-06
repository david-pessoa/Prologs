/*
=< --> Menor ou igual a
=:= --> Igual: avalia se dois valores são iguais
= --> checa se os "objetos" são iguais, ou atribui valores às variáveis (unificação de termos)
is --> atribuição
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

nota(joao, 5.0).
nota(beatriz, 6.0).
nota(maria, 7.5).
nota(joaquim, 10).
nota(josevaldo, 0).
nota(leticia, 8).

situacao(Aluno, Situacao) :- nota(Aluno, X),
                             (
                              (X > 7.0, X =< 10, Situacao = "Aprovado");
                              (X >= 5.0, X =< 6.9, Situacao = "Recuperação");
                              (X < 5.0, Situacao = "Reprovado")
                             ).

fatorial(0, 1).
fatorial(N, F) :- N > 0, 
                  N1 is N - 1, 
                  fatorial(N1, F1), 
                  F is N * F1.

regraRecorrencia(1, 2).
regraRecorrencia(N, X) :- N > 1, 
                          N1 is N - 1,
                          regraRecorrencia(N1, X1),
                          X is X1 - (3 * N * N).

