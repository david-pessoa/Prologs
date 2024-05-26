% David Pessoa 10402647

:- use_module(library(pairs)).
:- use_module(library(pio)).

huffman :-
    %ler mensagem do in.txt
    read_file_to_string('in.txt', L, []), %lê arquivo
    atom_chars(L, LA), %transforma a string L numa lista contendo os caracteres da string L
    msort(LA, LS), %Ordena lista LA
    packList(LS, PL), %Cria lista com as frequências de cada caractere
    sort(PL, PLS), %Ordena a lista, colocando os caracteres de menor sequência na frente
    build_tree(PLS, A), %Cria a árvore de huffman A
    coding(A, [], C), %Gera tabela C com a relação entre número de frequência, caractere e número binário correspondentes.
    sort(C, SC), %Ordena C

    % Substituir caracteres pelos códigos binários correspondentes
    substituir_caracteres(LA, SC, ListaMensagemCodificada),

    concatenar_lista(ListaMensagemCodificada, MensagemCodificada), %Apartir da lista com os caracteres codificados, gera-se a string MensagemCodificada
    escrever_em_arquivo(MensagemCodificada, 'out.txt'),

    atom_chars(MensagemCodificada, ListaBits), %Transforma a MensagemCodificada numa lista de bits
    decodificar(ListaBits, A, A, []). %decodifica a mensagem (resultado impresso dentro da função, na última recursão)

%Constrói árvore
build_tree([[V1|R1], [V2|R2]|T], AF) :- 
    V is V1 + V2, 
    A = [V, [V1|R1], [V2|R2]],
    (   T=[] -> AF=A ;  sort([A|T], NT), build_tree(NT, AF) ).

%Gera tabela com a relação entre número de frequência, caractere e número binário
coding([_A,FG,FD], Code, CF) :-
    (   is_node(FG) ->  coding(FG, [0 | Code], C1)
             ;  leaf_coding(FG, [0 | Code], C1) ),
    (   is_node(FD) ->  coding(FD, [1 | Code], C2)
             ;  leaf_coding(FD, [1 | Code], C2) ),
    append(C1, C2, CF).

leaf_coding([FG,FD], Code, CF) :-
    reverse(Code, CodeR),
    CF = [[FG, FD, CodeR]] .

is_node([_V, _FG, _FD]).

%Cria lista com as frequências de cada caractere
packList([], []).
packList([X], [[1,X]]) :- !.
packList([X|Rest], [XRun|Packed]):-
    run(X, Rest, XRun, RRest),
    packList(RRest, Packed).

run(V, [], [1,V], []).
run(V, [V|LRest], [N1,V], RRest):-
    run(V, LRest, [N, V], RRest),
    N1 is N + 1.
run(V, [Other|RRest], [1,V], [Other|RRest]):-
    dif(V, Other).

% Substituir caracteres pelos códigos binários correspondentes
substituir_caracteres([], _, []).
substituir_caracteres([Caractere|MensagemRestante], Codificacao, MensagemCodificadaRestante) :-
    (   member([_, Caractere, CodigoBinario | X], Codificacao) ->
        lista_inteiros_para_string(CodigoBinario, Code_str),
        MensagemCodificadaRestante = [Code_str|MensagemCodificadaRestanteRestante]
    ),
    substituir_caracteres(MensagemRestante, Codificacao, MensagemCodificadaRestanteRestante).

%Transforma uma lista em string
concatenar_lista([], '').
concatenar_lista([String|Resto], StringConcatenada) :-
    concatenar_lista(Resto, RestoConcatenado),
    string_concat(String, RestoConcatenado, StringConcatenada).

%Escreve no arquivo "out.txt"
escrever_em_arquivo(String, NomeArquivo) :-
    open(NomeArquivo, write, Stream, [encoding(utf8)]),
    write(Stream, String),
    close(Stream).

%Transforma a uma lista de inteiros para uma string
lista_inteiros_para_string([], '').
lista_inteiros_para_string([Inteiro|Resto], String) :-
    convert(Caractere, Inteiro),
    lista_inteiros_para_string(Resto, RestoString),
    string_chars(RestoString, RestoChars),
    string_chars(String, [Caractere|RestoChars]).

%Converte o bit de inteiro para string
convert('0', 0).
convert('1', 1).

%Decodifica a mensagem percorrendo a árvore
decodificar([], [_, Char], _, Decodifica) :-
    append(Decodifica, [Char], Deci), 
	concatenar_lista(Deci, MensagemDecodificada),
	writeln("Mensagem decodificada:"),
	writeln(MensagemDecodificada).

decodificar(['1' | Bits], [_, Item2, Item3 | X], Arvore, Decodifica) :- 
	decodificar(Bits, Item3, Arvore, Decodifica).

decodificar(['0' | Bits], [_, Item2, Item3 | X], Arvore, Decodifica) :- 
    decodificar(Bits, Item2, Arvore, Decodifica).

decodificar(Bits, [_, Char], Arvore, Decodifica) :- 
    append(Decodifica, [Char], Deci),
    decodificar(Bits, Arvore, Arvore, Deci).