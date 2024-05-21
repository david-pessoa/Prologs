:- use_module(library(pairs)).
:- use_module(library(pio)).

huffman :-
    %ler mensagem do in.txt
    read_file_to_string('in.txt', L, []),
    atom_chars(L, LA),
    msort(LA, LS),
    packList(LS, PL),
    sort(PL, PLS),
    build_tree(PLS, A),
    coding(A, [], C),
    sort(C, SC),

    % Substituir caracteres pelos códigos binários correspondentes
    substituir_caracteres(LA, SC, ListaMensagemCodificada),

    concatenar_lista(ListaMensagemCodificada, MensagemCodificada),
    escrever_em_arquivo(MensagemCodificada, 'out.txt'),

    atom_chars(MensagemCodificada, ListaBits),
    decodificar(ListaBits, A, A, []).


build_tree([[V1|R1], [V2|R2]|T], AF) :- 
    V is V1 + V2, 
    A = [V, [V1|R1], [V2|R2]],
    (   T=[] -> AF=A ;  sort([A|T], NT), build_tree(NT, AF) ).

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

print_code([N, Car, Code]):-
    format('~w :~t~w~t~30|', [Car, N]),
    forall(member(V, Code), write(V)),
    nl.

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

substituir_caracteres([], _, []).
substituir_caracteres([Caractere|MensagemRestante], Codificacao, MensagemCodificadaRestante) :-
    (   member([_, Caractere, CodigoBinario | X], Codificacao) ->
        lista_inteiros_para_string(CodigoBinario, Code_str),
        MensagemCodificadaRestante = [Code_str|MensagemCodificadaRestanteRestante]
    ),
    substituir_caracteres(MensagemRestante, Codificacao, MensagemCodificadaRestanteRestante).

concatenar_lista([], '').
concatenar_lista([String|Resto], StringConcatenada) :-
    concatenar_lista(Resto, RestoConcatenado),
    string_concat(String, RestoConcatenado, StringConcatenada).


escrever_em_arquivo(String, NomeArquivo) :-
    open(NomeArquivo, write, Stream, [encoding(utf8)]),
    write(Stream, String),
    close(Stream).


lista_inteiros_para_string([], '').
lista_inteiros_para_string([Inteiro|Resto], String) :-
    convert(Caractere, Inteiro),
    lista_inteiros_para_string(Resto, RestoString),
    string_chars(RestoString, RestoChars),
    string_chars(String, [Caractere|RestoChars]).

convert('0', 0).
convert('1', 1).

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