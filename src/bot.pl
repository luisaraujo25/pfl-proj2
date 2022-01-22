%Bot picks a move (from valid moves)
%choose_move(+GameState, +Level, -Move)
choose_move(gamestate(TurnNumber, Board, _, _), 1, Move) :-
	valid_moves(gamestate(TurnNumber, Board, _, _), ListOfMoves),
	random_member(Move, ListOfMoves).

