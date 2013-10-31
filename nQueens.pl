take([H|T],H,T).
take([H|T], R, [H|S]) :- take(T,R,S).

perm([],[]).
perm(L,[H|T]) :- take(L,H,R), perm(R,T).

nList(1,[1]).
nList(N,[H|T]) :- N = H, Y is N-1, nList(Y,T).


checkUp1(A,[],B).
checkUp1(X,[H|T],Acc) :- U is H-Acc, X =\= U, Acc1 is Acc+1, checkUp1(X,T,Acc1).

checkUp([]).
checkUp([H|T]) :- checkUp1(H,T,1), checkUp(T).


checkDown1(A,[],B).
checkDown1(X,[H|T],Acc) :- U is H+Acc, X =\= U, Acc1 is Acc+1, checkDown1(X,T,Acc1).

checkDown([]).
checkDown([H|T]) :- checkDown1(H,T,1), checkDown(T).

checkDiagonals(L) :- checkUp(L), checkDown(L).


nQueens(N, P) :- nList(N,L), perm(L,P), checkDiagonals(P).