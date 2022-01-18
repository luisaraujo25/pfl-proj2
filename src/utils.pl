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


replace(Index, List, Elem, NewList) :-
    Aux is Index-1,
    nth0(Aux, List, OldElem),
    write(OldElem),
    append(N,[OldElem|T],_),
    append(N,[Elem|T],NewList).

replace2(OLD,LIST,NEW,FINAL) :-
	append(AUX,[OLD|T],LIST),
	append(AUX,[NEW|T],FINAL).

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