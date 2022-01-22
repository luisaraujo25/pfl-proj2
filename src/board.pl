%the board size in this game is always 9
boardSize(9).
chooseBoardSize(Size) :- 
    write('Choose Board Size'),
    get_char(Size).

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

%board
createBoard(ListOfLists) :-
    boardSize(Size),
    createBoard(ListOfList, Size, Size, []).

createBoard(ListOfList, 0, _, ListOfList) :- !.
createBoard(ListOfList, Size, RowSize, Aux) :-
    createRow(Row,RowSize),
    append(Aux, [Row], Aux1),
    N is Size-1,
    createBoard(ListOfList, N, RowSize, Aux1).

%rows
createRow(_,0) :- !.
createRow([Head | Tail], Size) :-
    Head = null,
    S is Size-1,
    createRow(Tail, S).


% Create a Row of pieces
createRowP(_, _, 0) :- !.
createRowP(Piece, [Head|Tail], Size) :-
    Head = Piece,
    S1 is Size -1,
    createRowP(Piece, Tail, S1).

% getRow3(Piece, Row) :-
%     nth0(12, Row, Piece).

% getElemenFRow(Num) :-
%     createRowP(piece(white), Row, 9),
%     getRow3(Num, Row).


