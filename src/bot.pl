% choose_move(GameState, Level, Move):-
% 	valid_moves(GameState, ListOfMoves),
% 	getListSize(ListOfMoves, Size),
% 	random_between(0, Size, Move).

% choose_move(+GameState, +Level, -Move)
choose_move(gamestate(TurnNumber, Board, _, _), 1, Move) :-
	valid_moves(gamestate(TurnNumber, Board, _, _), ListOfMoves),
	random_member(Move, ListOfMoves).

getListSize(List, Size) :-
	getListSizeAux(List, Size, 0).

getListSizeAux([], Size, Size).
getListSizeAux([_|T], Size, Acc) :-
	Acc1 is Acc+1,
	getListSizeAux(T, Size, Acc1).
