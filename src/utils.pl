%0 stands for none (pieces)
%1 stands for white
%2 stands for black

%X starts counting on 1
%setPiece ([[1, 0], [0, 1]], 2, 1, 2, N)
setPiece(Board, X, Y, Piece, NewBoard) :-
    Aux is Y-1,
    getRow(Board, Aux, Row), %this is working -> [1, 0]
    replace(X, Row, Piece, NewRow),
    replace(Y, NewRow, Piece, NewBoard). 


%Board is the list of lists
getPiece(Board, X, Y, Piece) :-
    nth0(X, Board, List),
    nth0(Y, List, Piece).

getRow(Board, Num, Row) :-
    nth0(Num, Board, Row).

%Replaces the item in a list List with index Index by a new item Elem.
replace(Index, List, Elem, NewList) :-
    replaceAux(Index, List, Elem, [], NewList).

replaceAux(0, [H|T], Elem, List, FinalList) :-
    append(List, [Elem], Aux),
    append(Aux,T, FinalList).

replaceAux(Index, [H|T], Elem, Aux, NewList) :-
    N is Index-1,
    append(Aux, [H], Aux1),
    replaceAux(N, T, Elem, Aux1, NewList).

%[1,2,3,4,5]
%[1,2] Acc
%[3 | 4,5]]  -> 

%append([1,2],[3], Lista)
%append(Lista,[4,5])


%BOARD EXEMPLO: [[1, 0, 2], [0, 2, 2], [0, 0, 1]]
%BOARD EXEMPLO2: [[1,0],[0,1]]
% N = [[w,n],[n,b]]


/*
[
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [2, 2, 2, 2, 2, 2, 2, 2, 2],
    [2, 2, 2, 2, 2, 2, 2, 2, 2],
]
*/