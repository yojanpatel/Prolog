% SORTING

take([H|T],H,T). 
take([H|T], R, [H|S]) :- take(T,R,S). 

min(A,B,A) :- A < B.
min(A,B,B) :- A >= B.

%Evaluates the minimum in a list
minimum([],Acc,Acc).
minimum([H|T], Acc, Min) :- min(H,Acc,M), !,
						minimum(T,M,Min).

minimum([H|T], Min) :- minimum(T,H,Min).


slowSort(L, [M|S]) :- minimum(L,M),
					take(L,M,L1), !,
					slowSort(L1,S).
slowSort([],[]).


% QUICK SORT
partition([],P,[],[],[P]).
partition([H|T], P, [H|Left], Right, Equal) :- H < P, !, partition(T,P,Left,Right,Equal).
partition([H|T], P, Left, [H|Right], Equal) :- H > P, !, partition(T,P,Left,Right,Equal).
partition([H|T], P, Left, Right, [H|Equal]) :- H = P, partition(T,P,Left,Right,Equal).

qSort([],[]).
qSort([H|T], X) :- partition(T,H,L,R,E),
					qSort(L, LS), qSort(R,RS), !,
					append(LS,E,A),
					append(A,RS, X).

% MERGE SORT
halve(L,A,B):- halve(L,[],A,B).

halve(L,L,[],L).      % for lists of even length
halve(L,[_|L],[],L).  % for lists of odd length
halve([H|T],Acc,[H|L],B) :- halve(T,[_|Acc],L,B).

merge([HA|LA],[HB|LB], [HB|Merged]) :- HA > HB, merge([HA|LA], LB, Merged).
merge([HA|LA],[HB|LB], [HA|Merged]) :- HA =< HB, merge(LA, [HB|LB], Merged).
merge([],L,L).
merge(L,[],L).

mergeSort([],[]).
mergeSort([X],[X]).
mergeSort(List, Sorted) :- halve(List, Left, Right),
							mergeSort(Left, LeftSorted), mergeSort(Right, RightSorted), !,
							merge(LeftSorted,RightSorted, Sorted).
