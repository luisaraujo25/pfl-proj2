%Testing setPiece/5 in utils.pl
%X=3 AND Y=2: CHANGE THE ELEMENT IN (X,Y) TO 0
testSetPiece(NewBoard) :-
    %input:
    setPiece([[1,2,3],[4,5,6],[7,8,9]],1,3,0,NewBoard).
    %expected output: NewBoard = [[1,2,3],[4,5,6],[7,0,9]].

%Testing getRow/3


%Testing replace/3


%Creating an empty board to test other predicates without using createBoard(ListOfLists) from board.pl
createEmptyBoard([
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null],
    [null,null,null,null,null,null,null,null,null]
]). 

%Testing initial_board in board.pl
testInitialBoard(Board) :-
    initial_board(Board).
    % getBoard(Board).

%Testing fill board
testFillBoard(Board) :-
    createEmptyBoard(Empty),
    fillBoard(Empty,9,Board)
.

%Testing fillRow in board.pl
testFillRow(NewBoard) :-
    createEmptyBoard(B),
    fillRow(B, 5, 1, 1, 10, NewBoard)
.
testFillRow2(NewBoard) :-
    testFillRow(B),
    fillRow(B, 5, 2, 1, 10, NewBoard)
.
testFillRow3(NewBoard) :-
    testFillRow2(B),
    fillRow(B, 6, 8, 1, 10, NewBoard)
.
testFillRow4(NewBoard) :-
    testFillRow3(B),
    fillRow(B, 6, 9, 1, 10, NewBoard)
.

%To check if a row is complete
check(R) :-
    testFillRow4(B),
    getRow(B,8,R)
.

%Testing createBoard in board.pl
testCreateBoard(Board) :-
    createBoard(Board)
.

%Testing createRow in board.pl
testCreateRow(Row) :-
    createRow(Row,9)
.


%getRow([[1,2,3],[4,5,6],[7,8,9]],2,Row).
%Result: Row = [7,8,9].
%replace(1,[7,8,9],0,NewRow).
%result: NewRow = [7,0,9].
%replace(2,[[1,2,3],[4,5,6],[7,8,9]],[7,0,9],NewBoard).
%Result: NewBoard = [[1,2,3],[4,5,6],[7,0,9]].
%
%Final result = [[1,2,3],[4,5,6],[7,0,9]].

/* This is an example of how the board is representented internally
[
    [black, black, black, black, black, black, black, black, black],
    [black, black, black, black, black, black, black, black, black],
    [none, none, none, none, none, none, none, none, none],
    [none, none, none, none, none, none, none, none, none],
    [none, none, none, none, none, none, none, none, none],
    [none, none, none, none, none, none, none, none, none],
    [none, none, none, none, none, none, none, none, none],
    [white, white, white, white, white, white, white, white, white],
    [white, white, white, white, white, white, white, white, white],
]
*/

%[1,2,3,4,5]
%[1,2] Acc
%[3 | 4,5]]  -> 

%append([1,2],[3], Lista)
%append(Lista,[4,5])


%BOARD EXEMPLO: [[1, 0, 2], [0, 2, 2], [0, 0, 1]]
%BOARD EXEMPLO2: [[1,0],[0,1]]
% N = [[w,n],[n,b]]

% ^Testing
getGameState(1, gameState(1, [
	[piece(none), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	[piece(none), piece(white), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(black), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(black), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(black), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)]
], player(human), player(human))).

getBoard([
	[piece(none), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	[piece(none), piece(white), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(black), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)]
]).