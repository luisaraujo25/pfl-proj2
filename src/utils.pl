%0 stands for none (pieces)
%1 stands for white
%2 stands for black

%Returns the new board after a move is made
%TESTE: setPiece ([[1, 0], [0, 1]], 2, 1, 2, N)
%setPiece(+Board, +X, +Y, +Piece, -NewBoard)
setPiece(Board, X, Y, Piece, NewBoard) :-
    AuxY is Y-1,
    AuxX is X-1,
    getRow(Board, AuxX, Row), %this is working -> [1, 0]
    replace(AuxY, Row, Piece, NewRow),
    replace(AuxX, Board, NewRow, NewBoard). 

%testing set piece:
%X=3 AND Y=2: CHANGE THE ELEMENT 8 TO 0
%getRow([[1,2,3],[4,5,6],[7,8,9]],2,Row).
%Result: Row = [7,8,9].
%replace(1,[7,8,9],0,NewRow).
%result: NewRow = [7,0,9].
%replace(2,[[1,2,3],[4,5,6],[7,8,9]],[7,0,9],NewBoard).
%Result: NewBoard = [[1,2,3],[4,5,6],[7,0,9]].

%Row is a list, Board is a list of lists and Num is row's index in board
%replaceRow(+Board, +Num, +Row, -NewBoard)
% replaceRow(Board, Num, Row, NewBoard) :-
%     replace(Num,Row,)

%Returns piece in board's position (X,Y) through Piece.
%getPiece(+Board, +X, +Y, -Piece)
getPiece(Board, X, Y, Piece) :-
    nth0(X, Board, List),
    nth0(Y, List, Piece).


getRow(Board, Num, Row) :-
    nth0(Num, Board, Row).

%Replaces the item in the list List with index Index by a new item Elem.
%replace(+Index, +List, +Elem, -NewList)
replace(Index, List, Elem, NewList) :-
    replaceAux(Index, List, Elem, [], NewList).

replaceAux(0, [H|T], Elem, List, FinalList) :-
    append(List, [Elem], Aux),
    append(Aux,T, FinalList).

replaceAux(Index, [H|T], Elem, Aux, NewList) :-
    N is Index-1,
    append(Aux, [H], Aux1),
    replaceAux(N, T, Elem, Aux1, NewList).


%Returns list Size through "Size".
%getListSize(+List, -Size)
getListSize(List, Size) :-
	getListSizeAux(List, Size, 0).

getListSizeAux([], Size, Size).
getListSizeAux([_|T], Size, Acc) :-
	Acc1 is Acc+1,
	getListSizeAux(T, Size, Acc1).


%asciitonum(+NumCode, -Num)
asciitonum(NumCode, Num) :- 
	boardSize(Size),
	between(1, Size, NumCode),
	Num is NumCode.

asciitonum(NumCode, Num) :-
	between(97, 105, NumCode),
	Num is NumCode - 97.

%[1,2,3,4,5]
%[1,2] Acc
%[3 | 4,5]]  -> 

%append([1,2],[3], Lista)
%append(Lista,[4,5])


%BOARD EXEMPLO: [[1, 0, 2], [0, 2, 2], [0, 0, 1]]
%BOARD EXEMPLO2: [[1,0],[0,1]]
% N = [[w,n],[n,b]]




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