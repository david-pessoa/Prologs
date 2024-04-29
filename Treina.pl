/* Para rodar no compilador execute:
consult("Caminho para o arquivo").
Para sair: halt().
*/
start() :- write('Digite o valor de X: '), nl,
        read(X), nl,
        write(X), nl.