%15.
% a. Define a predicate to determine the predecessor of a number
% represented as digits in a list.
%Eg.: [1 9 3 6 0 0] => [1 9 3 5 9 9]

%predecessor(L - list, SF - integer, R -list)
%L - initial list, SF - substitution flag, R - resulting list
%flow model  (i,i,o)
%Mathematical model :
%predecessor(l1l2...ln, SF) =
%{ [], if n = 0
%{ ([9], SF=1), if n=1 and l1 = 0
%{ ([l1-1], SF=0), if n = 1 and l1 ≠ 0
%{  9 ∪ predecessor(l2l3...ln, 1), if SF=1 and l1=0
%{  (l1 - SF) ∪ predecessor(l2l3...ln, SF), otherwise

predecessor([],0,[]):- !.
predecessor([0],1,[9]):-!.
predecessor([H],0,[H1]):-
    H1 is H-1,
    !.
predecessor([0|T],1,[9|R]):-
    predecessor(T,1,R),
    !.
predecessor([H|T],0,[H1|R]):-
    predecessor(T,SF,R),
    H1 is H-SF.

%predecessorMain(L - list, R - list)
%flow model  (i,o).
%predecessorMain(l1l2..ln) = predecessor(l1l2...ln, 0)
predecessorMain(L,R):-
    predecessor(L,0,R).


%b. For a heterogeneous list, formed from integer numbers and list of numbers,
% define a predicate to determine the predecessor of the every sublist
% considered as numbers.
%Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] =>
%[1, [2, 2], 4, 5, [6, 7, 8], 10, 11, [1, 1, 9] 6]
%
%Mathematical model
%listPredecessor(l1l2...ln) =
%{ [], if n = 0
%{ l1 ∪ listPredecessor(l2l3...ln), if number(l1) = true
% { predecessorMain(l1) ∪ listPredecessor(l2l3...ln), if is_list(l1)=true

listPredecessor([],[]).
listPredecessor([H|T],[H|R]):-
    number(H),
    !,
    listPredecessor(T,R).
listPredecessor([H|T],[H1|R]):-
    is_list(H),
    listPredecessor(T,R),
    predecessorMain(H,H1).
