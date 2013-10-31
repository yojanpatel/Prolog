append([],A,A).
append([H|T],A,[H|R]) :- append(T,A,R).

a([H|T]) :- a([H|T],H).
a([],_).
a([H|T],Prev) :- H >= Prev, a(T,H).

b(X,X) :- a(X).
b(X,Y) :- append(A,[H1,H2|B],X), H1 > H2, append(A,[H2,H1|B], X1), b(X1,Y).

:-
a([1,2,4]),
b([4,3,6,1],X),
print(X).