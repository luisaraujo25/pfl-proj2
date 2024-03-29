%The board size in this game is always 9 (?)
%board(+Size).
boardSize(9).

%initial_board/1 -> initializes the board with pieces in their initial position
%initial_board(+Size, -Board) 
initial_board(Size, Board) :-
    % boardSize(Size),
    createBoard(EmptyBoard),
    fillBoard(EmptyBoard, Size, Board), !.

%Row number 0 is the first row in the board.
%Using S since X and Y start at 1. So if we think about a for loop it would be for(i=1;i<3,i++) and it would only replace 2 elements...
%this way we have for(i=1,i<4;i++)
%fillBoard(+EmptyBoard,+Size, -Board)
fillBoard(EmptyBoard, Size, Board) :-
    S is Size+1,
    fillRow(EmptyBoard, piece(black), 1, 1, S, B1),
    fillRow(B1, piece(black), 2, 1, S, B2),
    fillRow(B2, piece(white), 8, 1, S, B3),
    fillRow(B3, piece(white), 9, 1, S, Board).

%Fills a whole row Row with the piece Piece
%fillRow(+Board, +Piece, -NewBoard).
fillRow(Board, _, _, Size, Size, Board) :- !.
fillRow(Board, Piece, X, Acc, Size, NewBoard) :-
    setPiece(Board, X, Acc, Piece, NewB),
    Acc1 is Acc+1,
    fillRow(NewB, Piece, X, Acc1, Size, NewBoard).


%createBoard/1 -> Creates an "empty" board (list of lists) filled with nulls
%createBoard(-ListOfLists)
createBoard(ListOfLists) :-
    boardSize(Size),
    createBoard(ListOfLists, Size, Size, []).

%createBoard(-ListOfLists, +Size, +Size, +Aux)
createBoard(ListOfLists, 0, _, ListOfLists) :- !.
createBoard(ListOfLists, Size, RowSize, Aux) :-
    createRow(Row,RowSize),
    append(Aux, [Row], Aux1),
    N is Size-1,
    createBoard(ListOfLists, N, RowSize, Aux1).

%createRow/1 -> Creates an empty row (filles with nulls)
%createRow(-Row,+Size).
createRow(_,0) :- !.
createRow([Head | Tail], Size) :-
    Head = piece(none),
    S is Size-1,
    createRow(Tail, S).



