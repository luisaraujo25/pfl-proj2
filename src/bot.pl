%Bot picks a move (from valid moves)
%choose_move(+GameState, +Level, -Move)
choose_move(gameState(TurnNumber, Board, _, _), 1, Move) :-
	valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves),
	% nth0(1, ListOfMoves, Move).
	% member(X, ListOfMoves),
	random_member(Move, ListOfMoves).

