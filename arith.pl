#is Operator using first order logic


prim(1,i).
prim(X,s(A)) :- prim(Y,A), X is Y+1.


plusPrim(X,i,s(X)).
plusPrim(X,s(Y),s(Z)) :- plusPrim(X,Y,Z).

plus(X,Y,Z) :- plusPrim(X,Y,Z1), prim(Z,Z1).


multPrim(X,i,X).
multPrim(X,s(Y),Z) :- multPrim(X,Y,Z1), plusPrim(Z1,X,Z).

mult(X,Y,Z) :- multPrim(X,Y,Z1), prim(Z,Z1).

factorialR(0,1).
factorialR(N,Fact) :- N1 is N-1,
				  factorialR(N1,Fact1),
				  Fact is N*Fact1.

#with LCO as using an accumulator
FactorialI(0,Fact,Fact).
factorialI(N,Acc,Fact) :- N1 is N-1, Acc1 = N*Acc,
					factorialI(N1,Acc1,Fact).
