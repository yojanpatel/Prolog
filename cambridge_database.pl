
%tName(acr31,'Andrew Rice').
tName(arb33, 'Alastair Beresford').

tCollege(acr31, 'Churchill').
tCollege(arb33, 'Robinson').

tGrade(acr31,'IA',2.1).
tGrade(acr31,'IB',1).
tGrade(acr31,'II',1).
tGrade(arb33,'IA',1).
tGrade(arb33,'IB',1).
tGrade(arb33,'II',1).


tName(yp242,'Yojan Patel').
%tCollege(yp242, 'Robinson').
tGrade(yp242, 'IA', 2.1).

tDOB(acr31,'03/04/1980').
tDOB(arb33, '18/08/1981').
tDOB(yp242,'19/07/1994').

qNameCollege(F,C) :- tName(CRSID,F), tCollege(CRSID,C).

%specific CRSID
qNameCollege(CRSID,F,C) :- tName(CRSID,F), tCollege(CRSID,C).


%Full Name & College, college blank if unknown
qNC(F,C) :- tName(CRSID,F), tCollege(CRSID,C).
qNC(F,C) :- tName(CRSID,F), not(tCollege(CRSID, _)).

%Full Name or College blank if unknown
qNC2(F,C) :- tName(CRSID,F), tCollege(CRSID,C).
qNC2(F,C) :- tCollege(CRSID,C), not(tName(CRSID,_)).
qNC2(F,C) :- tName(CRSID,F), not(tCollege(CRSID, _)).



append([],A,A).
append([H|T],L,[H|R]) :- append(T,L,R).


min([],X,X).
min([H|T],M,X) :- H =< M, !, min(T,H,X).
min([H|T],M,X) :- M < H,!, min(T,M,X).
min([H|T],X) :- min(T,H,X).


%22S.5
%evaluate as a list all the grades CRSID has got
allGrades(CRSID, PreviousYears, AllGrades) :-
	tGrade(CRSID, Year, G),
	not(member(Year,PreviousYears)),
	append(PreviousYears,[Year],Visited),
	allGrades(CRSID,Visited,Grades),!,
	append(Grades,[G],AllGrades).

allGrades(CRSID, V, []).

minList([X],X).
minList([H1,H2|T],M) :- 
	!,H1 =< H2,!,
	minList([H1|T],M).

minList([H1,H2|T],M) :-
	!,H1 > H2,!,
	minList([H2|T],M).

lowestGrade(CRSID,LowestGrade) :-
	allGrades(CRSID,[],AllGrades), !,
	minList(AllGrades,LowestGrade).


%22S.6
%totalFirsts for a given CRSID
totalFirsts(CRSID, V, Firsts) :- 
	tGrade(CRSID,Y,G),
	not(member(Y,V)),
	G = 1,
	append(V,[Y],Visited),
	totalFirsts(CRSID,Visited,F), 
	Firsts is F + 1.

totalFirsts(CRSID,_,0).

%CList tracks what CRSIDs have been counted already
totalFirsts(X,CList) :-
	firsts(CID,F),
	not(member(CID,CList)),
	append(CList,[CID],NewCList),
	totalFirsts(X1,NewCList), !,
	X is X1 + F.

totalFirsts(0,_).

%Initially seen no CRSIDs
totalFirsts(X) :- totalFirsts(X,[]).
