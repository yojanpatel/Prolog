%	Missionaries & cannibals.
%	state(M,C,B)
%	M is the number of missionaries on the left bank
%	C is the number of cannibals on the left bank
%	B describes position of boat.

solve(Moves) :- !, solve(state(3,3,left), [state(3,3,left)], Moves).


solve(state(0, 0, right), _, []).
solve(CurrentState, Visited, [Move | RestOfMoves]) :-
        nextState(CurrentState, NextState),
        \+member(NextState, Visited),
        makeMove(CurrentState, NextState, Move),
        solve(NextState, [NextState | Visited], RestOfMoves).


%Takes difference of two states to figure out the move to add
% to the list of moves
makeMove(state(M1, C1, left), state(M2, C2, right), move(M, C, right)) :-
        M is M1 - M2,
        C is C1 - C2.
makeMove(state(M1, C1, right), state(M2, C2, left), move(M, C, left)) :-
        M is M2 - M1,
        C is C2 - C1.

% Possible ways to move missionaries & Cannibals
move(2, 0).
move(1, 0).
move(1, 1).
move(0, 1).
move(0, 2).

%State is valid if equal number of M as C, or if there are no Ms on a bank.
isValid(X, X).
isValid(3, X).
isValid(0, X).

% nextState(State1, State2) is true if it is possible to get from State1
% to State2.
nextState(state(M1, C1, left), state(M2, C2, right)) :-
        move(M, C),
        M =< M1,
        C =< C1,
        M2 is M1 - M,
        C2 is C1 - C,
        isValid(M2, C2).
nextState(state(M1, C1, right), state(M2, C2, left)) :-
        move(M, C),
        M2 is M1 + M,
        C2 is C1 + C,
        M2 =< 3,
        C2 =< 3,
        isValid(M2, C2).