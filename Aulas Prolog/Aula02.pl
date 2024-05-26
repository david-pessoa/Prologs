
t1(no(10,no(8,no(4,f(2),f(5)),f(3)),no(6,f(1),f(9)))).



/***********************************

Troca valor pela soma da subárvore

***********************************/

trocaSoma(f(Val),f(Val)).
trocaSoma(no(Val,Te,Td),no(Soma,Te2,Td2)) :-
    somaTree(no(Val,Te,Td),Soma),
    trocaSoma(Te,Te2),
    trocaSoma(Td,Td2).


/***********************************

      Soma valores da árvore

***********************************/

somaTree(f(Val),Val).
somaTree(no(Val,Te,Td),Soma) :- somaTree(Te,Se), somaTree(Td,Sd), Soma is Val + Se + Sd.



/***********************************

      Troca valor pela altura

***********************************/

trocah(f(_),f(1)).
trocah(no(_,Te,Td),no(H,Te2,Td2)) :-
    h(no(_,Te,Td),H),
    trocah(Te,Te2),
    trocah(Td,Td2).




/***********************************

             altura 

***********************************/

h(f(_),1).
h(no(_,Te,Td),H) :- h(Te,He), h(Td,Hd), maior(He,Hd,Ht), H is 1 + Ht.

maior(A,B,A) :- A > B.
maior(A,B,B) :- B >= A.



/***********************************

             Soma No

***********************************/

soma_no(f(_),0).
soma_no(no(Val,Te,Td),R) :-
    soma_no(Te,Ve),
    soma_no(Td,Vd),
    R is Val + Ve + Vd.

/***********************************

             Soma Folha

***********************************/

soma_f(f(Val),Val).
soma_f(no(Val,Te,Td),R) :-
    soma_f(Te,Ve),
    soma_f(Td,Vd),
    R is Ve + Vd.


/***********************************

              Pre Order               

***********************************/

pre(f(Val),[Val]).
pre(no(Val,Te,Td),Resp) :-
    pre(Te,Re),
    pre(Td,Rd),
    append([Val],Re,Aux),
    append(Aux,Rd,Resp).


/***********************************

              In Order  

***********************************/

in(f(Val),[Val]).
in(no(Val,Te,Td),Resp) :-
    in(Te,Re),
    in(Td,Rd),
    append(Re,[Val],Aux),
    append(Aux,Rd,Resp).



/***********************************

             Pos Order   

***********************************/

pos(f(Val),[Val]).
pos(no(Val,Te,Td),Resp) :-
    pos(Te,Re),
    pos(Td,Rd),
    append(Re,Rd,Aux),
    append(Aux,[Val],Resp).


/***********************************

         RLE - Codificacao

***********************************/

rle([],[]).
rle([C|Cs],R) :- rle(Cs,C,1,R).

rle([],C,N,[(C,N)]).
rle([C|Cs],C,N,R) :- N2 is N+1, rle(Cs,C,N2,R).
rle([C|Cs],A,N,[(A,N)|X]) :- rle(Cs,C,1,X).


/***********************************

         RLE - Decodificacao

***********************************/

repete(_,0,[]).
repete(C,N,[C|Cs]) :- N2 is N-1, repete(C,N2,Cs).

rld([],[]).
rld([(C,N)|Duplas],R) :-
    rld(Duplas,R2),
    repete(C,N,Seq),
    append(Seq,R2,R).



/********************************************
 
                    hanoi

********************************************/

hanoi(1,E,C,D) :- write(E), write(" para "), writeln(C).
hanoi(N,E,C,D) :-
    N2 is N-1,
    hanoi(N2,E,D,C),
    hanoi(1,E,C,D),
    hanoi(N2,D,C,E).
