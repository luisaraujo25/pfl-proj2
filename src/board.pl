%the board size in this game is always 9
boardSize(9).

%Pieces
piece(white, 'W').
piece(black, 'B').
piece(none, ' ').

%addPiece

%movePiece

%board
createBoard(ListofList) :-
    boardSize(Size),
    N is Size-1, 
    createBoard(N),
    createRow(List, Size),
    write(List).

%rows
createRow(_,0).
createRow([Head | Tail], Size) :-
    Head = null,
    write(Head), nl,
    createRow(Tail, Size-1).

%getValue(Board, Row, Column, Value) :-
%    nth0(Row, Board, )


getPiece(_, Piece, 0, _).
getPiece(Board, Piece, X, Y) :-
    N is X-1,
    getPiece(Board,Piece,N,Y).