% Lista de exercícios 01 

% 01 Escreva as cláusulas para concatenar duas listas. 
% Em PROLOG: concatenar(L1+,L2+,L3-).
% Por exemplo:
% ?- concatenar([a,b,c],[d,e,f,g,h], L).
% Deve retornar:
% L = [a,b,c,d,e,f,g,h].


concatenar([],L2,L2).
concatenar([X|R],L2,[X|W]):- concatenar(R,L2,W).

% Questão 2 
% Escreva as cláusulas para concatenar duas listas, sendo que a segunda lista vem na frente.
% a) Em PROLOG: concatenarInv(L1+,L2+,L3-). Neste caso dê exemplos das
% metas. Por exemplo: ?- concatenarInv([a,b,c],[d,e,f,g,h], L). Deve retornar: L = [d,e,f,g,h,a,b,c].

concatena2(L1,L2,L3):- concatenar(L2,L1,L3).


% Questao 3 
% Escreva as cláusulas para concatenar uma lista de listas.
% a) Em PROLOG: concatenar(LL+,L-).Por exemplo:
% ?- concatenar([[a,b],[c],[e,f,g]], L). Deve retornar: L = [a,b,c,d,e,f,g].

concatena3([],[]).
concatena3([L|RLL], LR) :- concatena3(RLL, LP),
    						concatenar(L,LP,LR). 

%Questão 4 
%Escreva as cláusulas para juntar duas listas, intercalando seus elementos.
%b) Em PROLOG: mesclando(L1+,L2+,L3-).Por exemplo:?- mesclando([a,b,c],[d,e,f,g,h], L).Deve retornar:
%L = [a,d,b,e,c,f,g,h].

mescla([],L2,L2):- !.
mescla(L1,[],L1):- !.
mescla([X|R],[Y|W],[X,Y|Z]) :- mescla(R,W,Z).


%em ordem

mescla01([],L2,L2):- !.
mescla01(L1,[],L1):- !.
mescla01([X|R],[Y|W],[X|Z]) :- X =< Y,mescla01(R,[Y|W],Z).
mescla01([X|R],[Y|W],[Y|Z]) :- X > Y, mescla01([X|R],W,Z).


%Questão 5 Escreva as cláusulas para adicionar um elemento ao final de uma lista. (acertei!)
%a) Em PROLOG: adicionarFinal(E+,L+,LR?). Por exemplo: 
%?- adicionarFinal(z,[a,b,c], L). Deve retornar: L = [a,b,c,z].

addFim(X,[],[X]):- !.
addFim(X,[Y|R],[Y|W]):- addFim(X,R,W).

%Questão 6 
%Escreva as cláusulas para inverter uma lista.
%a) Em PROLOG: inverter(L+,Linv-).
%Por exemplo:?- inverter([a,b,c], L).Deve retornar:L = [c,b,a].

inverteLista([],[]):- !.
inverteLista([X|R],W):- inverteLista(R,LA),
    					addFim(X,LA,W).


%Questão 7
%Escreva as cláusulas para inverter uma lista genérica de tal forma que todas as suas sublistas
%sejam também invertidas a) Em PROLOG: inverterLG(LG,Linv).
%Por exemplo:
%?- inverterLG([a,b,[c,d,e]], L). Deve retornar:L = [[e,d,c],b,a].
%Dica: implemente a clausula is_list(L) que retorna true se L é uma lista.

inverterLG([],[]).
inverterLG([L|RLL],LF) :- is_list(L),
    					  inverterLG(L,LI),
    					  inverterLG(RLL, RL),
    					  append(RL,[LI],LF).
inverterLG([RLL|RRLL],LF) :- inverterLG(RRLL,LA),
    						 addFim(RLL,LA,LF).

                        

%%Questões da prova de 2019-T02
%Questão 1 (2 pontos) - C2: Escreva em PROLOG as cláusulas liste(+N,?L) que lista N números em ordem
%decrescente de N para 1. Por exemplo:
%?- liste(5, L); L = [5,4,3,2,1].

liste(1,[1]).
liste(N,[N|R]):- N > 1,
    			 N1 is N-1,
    			 liste(N1,R).


%Questão 2 (2 pontos) – C2: Escreva em PROLOG as cláusulas para testar se dois conjuntos C1 e C2 representados
%por listas são iguais (a ordem dos elementos não importa). As cláusulas 
%devem retornar corretamente metas do tipo: iguais(?C1,?C2). 
%Por exemplo:?- iguais([1,2,3],[1,2,3]). true.

iguais([],[]).
iguais([X|R],L2) :- member(X,L2),
    				delete(L2,X,C),
    				iguais(R,C).
   

%Questão 3 (2 pontos) – C6: Escreva em PROLOG as cláusulas mescleLL(+LL,?L), que recebe uma lista de
%listas ordenadas (não vazia) e as mescla em um única lista ordenada. Por exemplo:
%?- mescleLL([[4,7],[1,3,6],[2,5,8]],L).
%X = [1,2,3,4,5,6,7,8].
%Dica: escreva a rotina mescle(+Lista1,+Lista2,?ListaR) como função auxiliar.

mescleLL([],[]).
mescleLL([L|RLL],LR) :- mescleLL(RLL,LI),
    				    mescla2(L,LI,LR).
    				 
mescla2([],L2,L2):- !.
mescla2(L1,[],L1):- !.
mescla2([X|R],[Y|W],[X|Z]) :- X =< Y, mescla2(R,[Y|W],Z).
mescla2([X|R],[Y|W],[Y|Z]) :- X > Y, mescla2([X|R],W,Z).


%Questão 4 (2 pontos) – C3 (C4 é mais fácil): Escreva em PROLOG a cláusula decodifica(+LL,?L) que
%produz uma lista L a partir da decodificação de LL. LL é uma lista de listas, onde cada lista Li de LL contém um par
%[N,A] que diz quantas vezes o átomo A vai se repetir em L. Por exemplo:
%?- decodifica( [[3,a],[2,b],[2,a],[1,d]] ,L).
%L = [a, a, a, b, b, a, a, d].
%Você pode assumir a existência da cláusula append/3 do PROLOG.  (append(?List1, ?List2, ?List1AndList2)

decodifica([],[]).
decodifica([[N,A]|R],LF) :- 
    repete(N, A, L1),
    decodifica(R, L2),
    append(L1, L2, LF).

repete(0, _,[]).
repete(N, A, [A|R]):-
    N > 0,
    N1 is N-1,
    repete(N1,A, R).

%Questão 5 (2 pontos) – C4: Define-se uma lista genérica como uma lista em que cada elemento pode ser um átomo
%ou uma lista genérica. Escreva em PROLOG a cláusula profundidade(+LG,?N), que recebe uma lista genérica
%LG e retorna sua profundidade. Por exemplo:
%?- profundidade([a,b,c,[d],e,f],N).
%N = 2. ?- profundidade([a,b,[[d]],[[e,[f]]],f],P).P = 4.
 
    
% Jesus abençoe





%%Questões da prova de 2019-T01

%Questão 1 (2 pontos) - C2: Escreva em PROLOG as cláusulas juntar(+L1,+L2,?L3) para juntar duas listas,
%intercalando seus elementos, como pedido na Questão 4 da Lista 1. Por exemplo:
%?- juntar([a,b,c],[d,e,f,g,h], L).
%L = [a,d,b,e,c,f,g,h].
%IMPORTANTE: você só deve utilizar somente duas cláusulas para resolver esta questão. Soluções com mais de
%duas cláusulas valem zero. DICA: inverta a posição de L1 e L2 na chamada recursiva. 


juntar([],L2,L2).
juntar([X|R],[Y|Z],[X,Y|W]):- juntar(R,Z,W).


%Questão 2 (2 pontos) - C2: Escreva em PROLOG as cláusulas divide(+L,+N,?L1,?L2)que divide a lista L
%nas listas L1 e L2, sendo que os N primeiros elementos de L estarão em L1 e o restante em L2. Por exemplo:
%?- divide([a,b,c,d,e,f,g,h,i,k],3,L1,L2).
%L1 = [a,b,c]
%L2 = [d,e,f,g,h,i,k]
%As cláusulas devem falhar se N for maior que o comprimento de L.

divide2([],_,[],[]).
divide2(L, 0, [], L):- !.
divide2(L, N, _, _) :-
    length(L, Len),
    N > Len, !, fail.
divide2([X|R],N,[X|L1],L2):- 
    				M is N-1,
   				    divide2(R,M,L1,L2).
    				  

%Questão 3: ) - C5: Escreva em PROLOG as cláusulas empacote(+L,?LL), que transforma uma lista
%em uma lista de listas, empacotando elementos iguais em sublistas distintas. Por exemplo:
%?- empacote([a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [[a,a,a,a,a],[b],[c,c],[d],[e,e,e,e]]	


empacote([], []).
empacote(L, [LS|LL]) :-
    separa(L, LS, LR),
    empacote(LR, LL).


separa([X], [X], []).
separa([X|L], [X,X|L1], L2) :- separa(L, [X|L1], L2).
separa([X|L], L1, [X|L2]) :- separa(L, L1, L2).


%Questão 4 (2 pontos) - C3: Escreva em PROLOG as cláusulas codifique(+L,?LL), que codifica a lista L em
%uma lista de listas LL codificada por comprimento linear dos elementos repetidos em L. Por exemplo:
%?- codifique([a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [[5,a],[1,b],[2,c],[1,d],[4,e]] Você pode assumir a existência das cláusulas 
%empacote da questão anterior e length/2 do Prolog

codifique([], []).
codifique(L, [[X,N]|LL]) :-
    separa(L, [X|LS], LR),
    length([X|LS], N),
    codifique(LR, LL).
    					   
    					
    				  			
% questão de desempacotar

desempacote([], []).
desempacote([H|T], L) :-
    desempacote(T, L1),
    append(H, L1, L).



%Questao 5 (C5: Escreva em PROLOG as cláusulas circule(+L,+N,?LR), que recebe uma lista L e
%gira ciclicamente os seus elementos N vezes para esquerda, se N>0 e para direita, se N<0 . Por exemplo:
%?- circule([a,b,c,d,e,f,g,h],3,X). X = [d,e,f,g,h,a,b,c]
%?- circule([a,b,c,d,e,f,g,h],-2,X). X = [g,h,a,b,c,d,e,f]. Você pode assumir a existência das cláusulas append/3 do PROLO


circule(L, 0, L).
circule(L, N, LO) :-
   N > 0,
   M is N-1,
   append(R, [X], LO),
   circule(L, M, [X|R]).
circule(L, N, [X|LO]) :-
   N < 0,
   M is N+1,
   append(LO, [X], R),
   circule(L, M, R).
    				
