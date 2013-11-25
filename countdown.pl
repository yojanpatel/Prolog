take([H|T], H, T).
take([H|T], R, [H|S]) :- take(T,R,S).

eval(plus(A,B),C) :- !, eval(A,A1), eval(B,B1), C is A1 + B1.
eval(minus(A,B),C) :- !,eval(A,A1), eval(B,B1), C is A1 - B1.
eval(mult(A,B),C) :- !, eval(A,A1), eval(B,B1), C is A1 * B1.
eval(divide(A,B),C) :- !, eval(A,A1), eval(B,B1), C is A1 // B1.
eval(A,A).

isGreater(A,B) :- eval(A,Av), eval(B,Bv), Av > Bv.

notOne(A) :- eval(A,Av), Av =\= 1.

isFactor(A,B) :- eval(A,Av), eval(B,Bv), 0 is Bv rem Av.


choose(1,L,[R],S) :-!, take(L,R,S).
choose(N, [H|L], [H|R], S) :- M is N - 1,
							choose(M,L,R,S).
choose(N,[H|L],R,[H|S]) :- choose(N,L,R,S).

arithop(A,B,plus(A,B)).
arithop(A,B,minus(A,B)) :- isGreater(A,B).
arithop(A,B,minus(B,A)) :- isGreater(B,A).
arithop(A,B,mult(A,B)) :- notOne(A), notOne(B).
arithop(A,B,divide(A,B)) :- notOne(B), isFactor(B,A).
arithop(A,B,divide(B,A)) :- notOne(A), isFactor(A,B).

countdown([Soln|_], Target, Soln) :- eval(Soln, Target).

countdown(L,Target,Soln) :-
	choose(2,L,[A,B], R),
	arithop(A,B,C),
	countdown([C|R], Target, Soln).