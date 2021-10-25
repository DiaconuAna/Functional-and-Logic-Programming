%a. Write a predicate to transform a list in a set, considering the first occurrence
%eg. [1,2,3,1,2] is transformed in [1,2,3].

%delete_occ(E -integer, L- list, R-list)
%E - element to be removes, L - initial list, R - final list

%delete all occurrences of an element E from the list
%flow model: (i,i,i), (i,i,o)

%Mathematical model:
%delete_occ(e, l1l2...ln) =
%{ Ø, if n = 0
%{ l1 ∪ delete_occ(e, l2l3...ln), if l1 ≠ e
%{ delete_occ(e, l2l3..ln), if l1 = e

%base case, list  is empty
delete_occ(_,[],[]).

%the head of the list is NOT equal  to the current element
delete_occ(E, [H|T], [H|R]):-
    H=\=E,
    delete_occ(E,T,R).

% the head of the list IS the element we want to delete, so we get rid
% of it
delete_occ(E,[H|T], R):-
    H=:=E,
    delete_occ(E,T,R).

% firstoccurence - check if an element appears in a list
% firstOccs(E-integer, L-list)
% flow model: (i,i), (i,i)

%Mathematical model
%firstOccs(e, l1l2...ln) =
%{ false, if n=0
%{ true, if l1 = e
%{ firstOccs(e, l2l3...ln), otherwise

firstOccs(_,[]):- false.
firstOccs(E,[H|_]):-
    H=:=E,
    !.
firstOccs(E,[H|T]):-
    H=\=E,
    firstOccs(E,T).



%ListSet
%%algorithm to transform a list into a set
%listToSet(L- initial list, S - list with properties of a set)
%flow model : (i,i) - (i,o)
%
%Mathematical model
%listSet(l1l2...ln) =
%{Ø, if n = 0
%{l1 ∪ listSet(delete_occ(l1, l2l3...ln)), if l1 belongs to (l2...ln)
%{l1 ∪ listSet(l2l3...ln), otherwise

listSet([],[]).

% If the element appears more than once in the list, we delete the
% rest of its occurrences, leaving only the first one (which we add to
% the set
listSet([H|T],[H|S]):-
    firstOccs(H,T),
    delete_occ(H,T,S1),
    listSet(S1,S).
%if the element appears only once in the list, we can add it to the
%set and move on to the next element
listSet([H|T],[H|S]):-
    \+ firstOccs(H,T),
    listSet(T,S).

% B. Write a predicate to decompose a list in a list respecting the
% following: [list of even numbers list of odd numbers] and also return
% the number of even numbers and the numbers of odd numbers.

%addEnd(L - list of elements, E- element to be added, R - resulted list)
%flow model (i,i,i) (i,i,o)

%Mathematical Model
% addEnd(l1l2...ln,e) =  { [e], if n = 0
%                        { l1 ∪ addEnd(l2...ln, e), otherwise

addEnd([],E,[E]).
addEnd([H|T],E,[H|R]):-
addEnd(T,E,R).


%decomposes a list into [list of even numbers list of odd numbers]
%decomposeList(L - list, R - list)
%flow model: (i,i), (i,o)
%
%Mathematical Model
%decomposeList(l1l2...ln) =
%{ Ø, if n=0
%{ l1 ∪ decomposeList(l2l3...ln), if l1%2 = 0
%{ decomposeList(l2l3...ln)∪l1, if l1%2 = 1

decomposeList([],[]).
decomposeList([H|T],[H|E]):-
    mod(H,2)=:=0,
    decomposeList(T,E).
decomposeList([H|T],L):-
    mod(H,2)=:=1,
    decomposeList(T,L1),
    addEnd(L1,H,L).


%Counts the number of even elements in a list of numbers
%countEven(L- list, N - integer)
%flow (i,i), (i,o)
%
%Mathematical model:
%countEven(l1l2...ln) =
%{ 0, if n=0
%{ 1+countEven(l2l3...ln), if l1%2=0
%{ countEven(l2l3...ln), otherwise

countEven([],0).
countEven([H|T],N):-
    mod(H,2)=:=0,
    countEven(T,N1),
    N is N1+1.
countEven([H|T],N):-
    mod(H,2)=:=1,
    countEven(T,N).

%Counts the number of odd elements in a list of numbers
%countOdd(L- list, N - integer)
%flow (i,i), (i,o)
%
%Mathematical model:
%countOdd(l1l2...ln) =
%{ 0, if n=0
%{ 1+countOdd(l2l3...ln), if l1%2=1
%{ countOdd(l2l3...ln), otherwise


countOdd([],0).
countOdd([H|T],N):-
    mod(H,2)=:=1,
    countOdd(T,N1),
    N is N1+1.
countOdd([H|T],N):-
    mod(H,2)=:=0,
    countOdd(T,N).

%L - initial list, R - [even list | odd list]
%E - number of even elements, O - number of odd elements
decomposeMain(L,R,E,O):-
    decomposeList(L,R),
    countOdd(R,O),
    countEven(R,E).

