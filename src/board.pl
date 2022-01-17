%the board size in this game is always 9
boardSize(9).

%Pieces
% piece(white, 'W').
% piece(black, 'B').
% piece(none, ' ').
% initial(piece(white, X, 1)) :-
%     between(1, 8, X).

initial(piece(white, 1, 1)).
initial(piece(white, 2, 1)).
initial(piece(white, 3, 1)).
initial(piece(white, 4, 1)).
initial(piece(white, 5, 1)).
initial(piece(white, 6, 1)).
initial(piece(white, 7, 1)).
initial(piece(white, 8, 1)).
initial(piece(white, 9, 1)).


% initial(piece(white, X, 2)) :-
%     between(1, 9, X).
% initial(piece(black, X, 9)) :-
%     between(1, 9, X).
% initial(piece(black, X, 8)) :-
%     between(1, 9, X).

initial_board(Board) :-
    findall(Piece, initial(Piece), Board).


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



