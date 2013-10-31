exists(A, [A|T]).
exists(A, [_|T]) :- exists(A, T).

leftOf(A, B, [A,B|T]).
leftOf(A, B, [_|T]) :- leftOf(A, B, T).

rightOf(A, B, [B,A|T]).
rightOf(A, B, [_|T]) :- rightOf(A, B, T).

middleHouse(A, [_,_,A,_,_]).

firstHouse(A,[A|_]).

nextTo(A, B, L) :- rightOf(A, B, L).
nextTo(A, B, L) :- leftOf(A, B, L).

listLength([],0).
listLength([H|T], X) :- listLength(T, X1), X is X1 + 1.

:-      listLength(Houses, 5),
        exists(house(british,_,_,_,red),Houses),
        exists(house(spanish,dog,_,_,_),Houses),
        exists(house(_,_,_,coffee,green),Houses),
        exists(house(ukranian,_,_,tea,_),Houses),
        rightOf(house(_,_,_,_,green),house(_,_,_,_,ivory),Houses),
        exists(house(_,snail,oldgold,_,_),Houses),
        exists(house(_,_,kools,_,yellow),Houses),
        middleHouse(house(_,_,_,milk,_),Houses),
        firstHouse(house(norwegian,_,_,_,_),Houses),
        nextTo(house(_,_,chesterfields,_,_),house(_,fox,_,_,_),Houses),
        nextTo(house(_,_,kools,_,_),house(_,horse,_,_,_),Houses),
        exists(house(_,_,luckystrike,orangejuice,_),Houses),
        exists(house(japanese,_,parliaments,_,_),Houses),
        nextTo(house(norwegian,_,_,_,_),house(_,_,_,_,blue),Houses),
        exists(house(WaterDrinker,_,_,water,_),Houses),
        exists(house(ZebraOwner,zebra,_,_,_),Houses),
        
        print(WaterDrinker), print('\n'),
        print(ZebraOwner), print('\n').