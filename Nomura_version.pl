% Pedro Nomura 10401616
% João Pedro Souza 10400720
% Victor Vaglieri 10400787

%#Funções que criam e escrevem nos arquivos
escrever(Saida) :-
    open("out.txt",write,Stream),
    write(Stream,Saida),
    close(Stream).
escrever2(Saida) :-
    open("outDecodificado.txt",write,Stream),
    write(Stream,Saida),
    close(Stream).
    

%#Bubble sort que ordena vetores de inteiro
troca([A],[A]).
troca([A,B|X],[B|R]) :- A > B, troca([A|X],R).
troca([A,B|X],[A|R]) :- troca([B|X],R).
bubble(Lista,N,N,Lista).
bubble(Lista,Cont,N,R) :- troca(Lista,R1), Cont1 is Cont + 1, bubble(R1,Cont1,N,R).

%#Variação do bubble sort que ordena matriz
troca2([A],[A]).
troca2([A,B|X],[B|R]) :- segundo(A,A1),segundo(B,B1), A1 > B1, troca2([A|X],R).
troca2([A,B|X],[A|R]) :- troca2([B|X],R).
bubble2(Lista,N,N,Lista).
bubble2(Lista,Cont,N,R) :- troca2(Lista,R1), Cont1 is Cont + 1, bubble2(R1,Cont1,N,R).


primeiro([A|_],A).
segundo([_,A|_],A).
terceiro([_,_,A],A).

%#Função que cria uma tabela das ocorrencias dos caracteres
tabela([],Char,Cont,[[Char,Cont]]).
tabela([A|X],A,Cont,R) :- Cont1 is Cont + 1, tabela(X,A,Cont1,R).
tabela([A|X],Char,Cont,[[Char,Cont]|R]) :- tabela(X,A,1,R). 


%#Função que cria a arvore de huffman
huffman([A],[A]).
huffman([A,B|Lista],R) :- 
    segundo(A,A2), segundo(B,B2), Soma is A2+B2,
    append([[A,Soma,B]],Lista,Lista1), 
    length(Lista1,Len), bubble2(Lista1, 0,Len,Lista1Ordenada), 
    huffman(Lista1Ordenada,R).


%#Função que cria uma tabela com os codigos referentes a arvore de huffman
codigo(Arvore,Codigo,[[Char,Codigo]]) :- 
    length(Arvore,Len), Len =:= 2, primeiro(Arvore,Char).
    
codigo(Arvore,Codigo,R) :- 
    primeiro(Arvore,Esquerda), terceiro(Arvore,Direita),
    string_concat(Codigo,"0",CodigoE), string_concat(Codigo,"1",CodigoD),
    codigo(Esquerda,CodigoE,RE), codigo(Direita,CodigoD,RD), append(RE,RD,R).


%#Funções que codificam a string original com base na tabela de codigos
codificar([],_,"").
codificar([Char|X],Codigos,R) :- 
    codificarAux(Char,Codigos,R1), codificar(X,Codigos,R2), string_concat(R1,R2,R).

codificarAux(Char,[A|_],A2) :- primeiro(A,A1), A1 =:= Char, segundo(A,A2).
codificarAux(Char,[_|X],R) :- codificarAux(Char,X,R).


%#Funções que decodificam a string codificada com base na tabela de codigos
decodificar(_,Len,Len,_,_,[]).
decodificar(String,Cont,Len,Codigo,Tabela,R) :- 
    nth0(Cont,String,Bit), string_concat(Codigo,Bit,Codigo1),
    decodificarAux(Codigo1,Tabela,Char), Char \= nil, Cont1 is Cont+1,
    decodificar(String,Cont1,Len,"",Tabela,R1),append(Char,R1,R).

decodificar(String,Cont,Len,Codigo,Tabela,R) :-
    nth0(Cont,String,Bit), string_concat(Codigo,Bit,Codigo1),
    decodificarAux(Codigo1,Tabela,_), Cont1 is Cont+1,
    decodificar(String,Cont1,Len,Codigo1,Tabela,R).

decodificarAux(_,[],nil).
decodificarAux(Codigo,[A|_],[A1]) :- segundo(A,A2), A2 = Codigo, primeiro(A,A1).
decodificarAux(Codigo,[_|X],R) :- decodificarAux(Codigo,X,R).


main() :-
    %#Lê o arquivo texto e salva o conteúdo numa string
    read_file_to_string("in.txt",String,[]),
    writeln(String),

    %#Transforma a string em uma lista de inteiros referente ao codigo ascii
    string_codes(String,Lista),
    length(Lista,Len), bubble(Lista,0,Len,Ordenada),
    primeiro(Ordenada,Primeiro), tabela(Ordenada,Primeiro,0,Tabela),
    length(Tabela,Len2), bubble2(Tabela,0,Len2,TabelaOrdenada),

    huffman(TabelaOrdenada, ArvoreSuja), primeiro(ArvoreSuja, Arvore),
    codigo(Arvore,"",Codigos),
    codificar(Lista, Codigos, StringCodificada),
    writeln(StringCodificada),

    %#Escreve no arquivo de saida "out.txt" o texto codificado
    escrever(StringCodificada),

    %#Separa a string numa lista com cada caracter
    string_chars(StringCodificada, ListaCodificada),
    length(ListaCodificada,LenCodificada),
    write("Codigos: "), writeln(Codigos),
    decodificar(ListaCodificada,0,LenCodificada,"",Codigos,ListaDecodificada),

    %#Transforma os codigos ascii de volta para os caracteres
    string_codes(StringDecodificada,ListaDecodificada),
    writeln(""), writeln(StringDecodificada),

    %#Escreve no arquivo "outDecodificado.txt" o texto decodificado
    escrever2(StringDecodificada).