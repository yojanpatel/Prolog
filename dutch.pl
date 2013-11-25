collect([],[],[],[]).
collect([red|T], [red|R],W,B) :- collect(T,R,W,B).
collect([white|T], R, [white|W], B) :- collect(T,R,W,B).
collect([blue|T], R, W, [blue|B]) :- collect(T,R,W,B).

flag(In, Out) :- collect(In,R,W,B),
				append(R,W,RW), !,
				append(RW, B, Out).


collect(A-A1,B-B,C-C,D-D):-unify_with_occurs_check(A,A1).

collect([red|T]-T1, [red|R]-R1, W-W1, B-B1) :-
				collect(T-T1,R-R1,W-W1,B-B1), !.


collect([white|T]-T1, R-R1, [white|W]-W1, B-B1) :-
				collect(T-T1,R-R1,W-W1,B-B1), !.

collect([blue|T]-T1, R-R1, W-W1, [blue|B]-B1) :-
				collect(T-T1,R-R1,W-W1,B-B1), !.

%collect(A-A1,B-B1,C-C1,D-D1).

flag(I-I1, R-B1) :- collect(I-I1, R-W,W-B,B-B1).


dutch(A-A1,R-R1,R1-W1,W1-B1,R-B1):- unify_with_occurs_check(A,A1).

dutch([red|T]-T1,R-R1,W-W1,B-B1,X-X1) :- dutch(T-T1,[red|R]-R1,W-W1,B-B1,X-X1),!.
dutch([white|T]-T1,R-R1,W-W1,B-B1,X-X1) :- dutch(T-T1,R-R1,[white|W]-W1,B-B1,X-X1),!.
dutch([blue|T]-T1,R-R1,W-W1,B-B1,X-X1) :- dutch(T-T1,R-R1,W-W1,[blue|B]-B1,X-X1).