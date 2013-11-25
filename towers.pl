
solve(_, T([],[],_)).
solve(1,A,_,C,[A-C]).
solve(N,A,B,C, AllMoves) :-
	M is N -1,
	solve(M,A,C,B,HalfMoves),
	solve(M,B,A,C,LastMoves),
	append(MoreMoves,[A-C|LastMoves],AllMoves).

solve2(1,A,_,C,[A-C|Z]-Z).
solve2(N,A, B, C, [HM|HMT]-LMT1) :-
	M is N - 1,
	solve2(M, A, C, B, [HM|HMT]-[A-C|Z]),
	solve2(M, B, A, C, Z-LMT1).

solve2(N,S,M,T,Sol):- N1 is N-1,
						solve2(N1,S,T,M,L1-T1),
						solve2(N1,M,S,T,L2-T2),
						dapp(L2-T2,[S-T-N|L1]-T1,Sol).

solveSlowly(InitialTowers, Moves) :- solveSlowly(InitialTowers, [InitialTowers], Moves).

solveSlowly(t([],[],_), _, []).
solveSlowly(CurrentState, Visited, [Move|RestOfMoves]) :-
				nextState(CurrentState, NextState, Move),
				\+member(NextState,Visited),
				solveSlowly(NextState,[NextState|Visited], RestOfMoves).



% State2 can be reached from State1 using Move
% if State2 is valid.

nextState(t([H|A],B,C), t(A,[H|B], C), a-b) :- isValid(t(A,[H|B], C)).
nextState(t([H|A],B,C), t(A,B,[H|C]), a-c) :- isValid(t(A,B,[H|C])).

nextState(t(A,[H|B],C), t([H|A],B,C), b-a) :- isValid(t([H|A],B,C)).
nextState(t(A,[H|B],C), t(A,B,[H|C]), b-c) :- isValid(t(A,B,[H|C])).

nextState(t(A,B,[H|C]), t([H|A],B,C), c-a) :- isValid(t([H|A],B,C)).
nextState(t(A,B,[H|C]), t(A,[H|B],C), c-b) :- isValid(t(A,[H|B],C)).




% A state isValid if all Towers are sorted.
isValid(t(A,B,C)) :- isSorted(A),
					 isSorted(B),
					 isSorted(C).

% L isSorted if every element is greater or equal
% to the previous one.
isSorted([]). 
isSorted([H|T]) :- isSorted([H|T],H).
isSorted([],_).
isSorted([H|T],Prev) :- H >= Prev, isSorted(T,H).