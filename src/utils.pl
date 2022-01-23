%0 stands for none (pieces)
%1 stands for white
%2 stands for black

sleepTime :-
    sleep(2).

%Returns the new board after a move is made
%Test available in tests.pl
%setPiece(+Board, +X, +Y, +Piece, -NewBoard)
setPiece(Board, X, Y, Piece, NewBoard) :-
    AuxY is Y-1,
    AuxX is X-1,
    getRow(Board, AuxX, Row), %this is working -> [1, 0]
    replace(AuxY, Row, Piece, NewRow),
    replace(AuxX, Board, NewRow, NewBoard). 

%Row is a list, Board is a list of lists and Num is row's index in board
%replaceRow(+Board, +Num, +Row, -NewBoard)
% replaceRow(Board, Num, Row, NewBoard) :-
%     replace(Num,Row,)

%Returns piece in board's position (X,Y) through Piece.
%getPiece(+Board, +X, +Y, -Piece)
getPiece(Board, X, Y, Piece) :-
    nth0(X, Board, List),
    nth0(Y, List, Piece). %TRoquei X e Y

%Returns the row number Num.
%getRow(+Board, +Num, -Row)
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


%"Converts" letters to numbers
%asciitonum(+NumCode, -Num)
asciitonum(NumCode, Num) :- 
	boardSize(Size),
	between(49, 57, NumCode),
	Num is NumCode -49.

asciitonum(NumCode, Num) :-
	between(97, 105, NumCode),
	Num is NumCode - 97.
