take([H|T],H,T). 
take([H|T], R, [H|S]) :- take(T,R,S). 

perm([],[]). 
perm(L,[H|T]) :- take(L,H,R), perm(R,T). 

anagram(W,A) :- perm(W,A), word(A).