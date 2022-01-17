choose_move(GameState, Level, Move):-
	valid_moves(GameState, ListOfMoves),
	getListSize(ListOfMoves, Size),
	random_between(0, Size, Move).

getListSize(List, Size) :-
	getListSizeAux(List, Size, 0).

getListSizeAux([], Size, Size).
getListSizeAux([_|T], Size, Acc) :-
	Acc1 is Acc+1,
	getListSizeAux(T, Size, Acc1).
