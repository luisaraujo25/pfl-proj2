%The board size in this game is always 9
boardSize(9).

%Users have the option of picking different board sizes
chooseBoardSize(Size) :- 
    write('Choose Board Size'),
    get_char(Size).


initial_board(Board) :-
    boardSize(Size),
    createBoard(EmptyBoard),
    fillBoard(EmptyBoard, Board).

%Row number 0 is the first row in the board.
fillBoard(EmptyBoard, Board) :-
    boardSize(Size),
    getRow(Board, 0, Row),
    replace(0, Board, FilledRow, NewBoard)
    fillRows(Row, Piece, NewRow).

%fillRow(+Board, +Piece, -NewBoard).
% fillRow(_, 0, Row).
fillRow(Board, X, Y, Piece, NewBoard) :-
    setPiece(Board, X, Aux, N),
    Aux is Y-1,
    fillRow(Board, X, Aux, Piece, NewBoard).


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
    S1 is Size-1,
    createRowP(Piece, Tail, S1).

% getRow3(Piece, Row) :-
%     nth0(12, Row, Piece).

% getElemenFRow(Num) :-
%     createRowP(piece(white), Row, 9),
%     getRow3(Num, Row).


