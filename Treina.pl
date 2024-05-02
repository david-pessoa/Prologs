/* Para rodar no compilador execute:
consult("Caminho para o arquivo").
Para sair: halt().

Para mudar a base de conhecimento (modificar regras e fatos):
        :- dynamic NomeDoPredicado/Aridade

--> assert/1 -> acrescenta o fato/regra como último item do predicado
--> asserta/1 -> acrescenta o fato/regra como primeiro item do predicado;

--> retract/1 -> remove da base de conhecimento a primeira claúsula (fato ou regra) que unifica com o termo
que é passado como parâmetro
--> retractall/1 -> remove da base de conhecimento todas as claúsulas (fato ou regra) que unificam com o termo
que é passado como parâmetro

--> abolish/1 -> remove da base de conhecimento todas as claúsula (fato ou regra) pelo nome da regra fato/Aridade
que é passada como parâmetro (são removidos predicados estáticos também)
--> abolish/2 -> semelhante a abolish/1, mas passando o nome da claúsula e a sua Aridade separadamente
(são removidos predicados estáticos também).



start() :- write('Digite o valor de X: '), nl,
        read(X), nl,
        write(X), nl.
*/


estados(sp, "São Paulo").
estados(mg, "Belo Horizonte").
estados(rj, "Rio de Janeiro").
estados(es, "Vitória").

capital(Estado, X) :- estados(Estado, X).

doa(o, a).
doa(o, b).
doa(o, ab).
doa(o, o).

doa(a, a).
doa(a, ab).

doa(b, b).
doa(b, ab).
doa(ab, ab).

recebe(X, Y) :- doa(Y, X).