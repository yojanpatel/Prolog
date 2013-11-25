%Missionaries & Cannibals
%state(3,3,1) ---> state(0,0,0).
% state(M,C,B):
% M - number of missionaries on the left side
% C - number of cannibals on the left side
% B - boat on right side?

isValid2(state(M,C,_)) :- M >= C.
isValid2(state(M,C,_)) :- M = 0, C > 0.

isValid(state(X,X,_)).
isValid(state(3,X,_)).
isValid(state(0,X,_)).

solve(state(0,0,_),_,[]).
solve(CurrentState, Visited, [Move|NextMoves]) :- 
	move(CurrentState, NextState),
	\+member(NextState, Visited),
	makeMove(CurrentState, NextState, Move),
	solve(NextState,[NextState|Visited], NextMoves).


makeMove(state(M1,C1,1), state(M2,C2,0), move(M,C,0)) :-
	M is M1 - M2, C is C1 - C2.

makeMove(state(M1,C1,0), state(M2,C2,1), move(M,C,1)) :-
	M is M2 - M1, C is C2 - C1.

% Move One Missionary
move(state(M,C,0),state(N,C,1)) :- N is M+1, M < 3, isValid(state(N,C,1)).
move(state(M,C,1),state(N,C,0)) :- N is M-1, M > 0, isValid(state(N,C,0)).

% Move Two Missionaries
move(state(M,C,0),state(N,C,1)) :- N is M+2, M < 2, isValid(state(N,C,1)).
move(state(M,C,1),state(N,C,0)) :- N is M-2, M >1, isValid(state(N,C,0)).

% Move One Cannibal
move(state(M,C,0), state(M,D,1)) :- D is C+1, C < 3, isValid(state(M,D,1)).
move(state(M,C,1), state(M,D,0)) :- D is C-1, C > 0, isValid(state(M,D,0)).

% Move Two Cannibals
move(state(M,C,0), state(M,D,1)) :- D is C+2, C < 2, isValid(state(M,D,1)).
move(state(M,C,1), state(M,D,0)) :- D is C-2, C < 1, isvalid(state(M,D,0)).

% Move one of each
move(state(M,C,0), state(N,D,1)) :- N is M+1, D is C+1,
									M < 3, C < 3,
									isValid(state(N,D,1)).

move(state(M,C,1), state(N,D,0)) :- N is M-1, D is C-1,
									M > 0, C > 0,
									isValid(state(N,D,0)).



