%X starts counting on 1
setPiece(Board, X, Y, Piece, NewBoard) :-
    getColumn(Y, Board, Column).
    select(Y, Column, Piece, NewColumn).

%Board is the list of lists
getPiece(Board, X, Y, Piece) :-
    nth0(X, Board, List),
    nth0(Y, List, Piece).

getColumn(Board, Num, Column) :-
    nth0(Num, Board, Column).