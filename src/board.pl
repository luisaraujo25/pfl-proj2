%the board size in this game is always 8
boardSize(8).

%Pieces
piece(samurai, 'S').
piece(ninja, 'N').
piece(none, ' ').

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
