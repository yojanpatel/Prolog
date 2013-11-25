solve1([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]) :-
    Var = [S,E,N,D,M,O,R,Y],
    Var in 0..9, all_different(Var),
    1000 * S + 100 * E + 10 * N + D + 1000 * M + 100 * O + 10 * R + E 
       #=
    10000 * M + 1000 * O + 100 * N + 10 * E + Y,
    labeling([],Var).