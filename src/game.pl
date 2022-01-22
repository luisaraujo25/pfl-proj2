:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).
:- use_module(library(between)).
:- use_module(library(random)).

:- include('board.pl').
:- include('display.pl').
:- include('menu.pl').
:- include('bot.pl').
:- include('input.pl').
:- include('utils.pl').

play :-
	menu.

% start(PLAYER1, PLAYER2) :-
% 	boardSize(Size).


% gameState(TurnNumber, Board).

% initial_state(+Size, -GameState) % Do we need size??
initial_state(gameState(TurnNumber, Board, _, _)) :-
	TurnNumber is 1,
	createBoard(Board).

play_game:-
    initial_state(GameState), %--> Iniciar a Board
    display_game(GameState),
    game_cycle(GameState).

% game_cycle(+GameState)
game_cycle(gameState(TurnNumber, Board, _, _)):-
    game_over(gameState(TurnNumber, Board, _, _), Winner), !,
    congratulate(Winner). %% ??
    

game_cycle(gameState(TurnNumber, Board, player1(Race1), player2(Race2))):-
	(	(TurnNumber mod 2) =:= 1 ->
		Player is white,
		(	Race1 =:= human	->
			playerAskMove(Player, Board, Move)
		 	;
			choose_move(gameState(TurnNumber, Board, _, _), 1, Move)
		)
		;
		Player is black,
		(	Race1 =:= human	->
			playerAskMove(Player, Board, Move)
		 	;
			choose_move(gameState(TurnNumber, Board, _, _), 1, Move)
		)
	),
    move(gameState(TurnNumber, Board, player1(Race1), player2(Race2)), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState), !,
    game_cycle(NewGameState).
% 


% playerAskMove(+Player, +Board, -move(Xi, Yi, Xf, Yf))
playerAskMove(Player, Board, move(Xi, Yi, Xf, Yf)) :-
	(	(TurnNumber mod 2) =:= 1 ->
		Player is white
		;
		Player is black
	),
	write('What piece you want to move? (write coordinates)'), nl, write('X: '), get_code(Xinput), nl, write('Y: '), get_code(Yinput), nl,
	asciitonum(Xinput, Xi),
	asciitonum(Yinput, Yi),
	getPiece(Board, Xi, Yi, piece(Color)),
	(	Color =:= Player ->
		write('Where you want to move it to? (write coordinates)'), nl, write('X: '), get_code(Xfinput), nl, write('Y: '), get_code(Yfinput), nl,
		asciitonum(Xfinput, Xf),
		asciitonum(Yfinput, Yf),
		valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves),
		( 	\+member(move(Xi, Yi, Xf, Yf), ListOfMoves) ->
			write('Not a possible move!'), playerAskMove(Player, Board, move(Xi, Yi, Xf, Yf))
		)
		;
		write('None of your pieces are in that place'), nl,
		playerAskMove(Player, Board, move(Xi, Yi, Xf, Yf))
	).
% 


% setPiece(Board, X, Y, Piece, NewBoard) :-
% move(+GameState, +Move, -NewGameState)
move(gamestate( TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf), gameState(NewTurnNumber, NewBoard, P1, P2)):-
	(	(TurnNumber mod 2) =:= 1 ->
		Player is white
		;
		Player is black
	),
	valid_moves(gamestate( TurnNumber, Board, _, _), ListMoves),
	( member(move(Xi, Yi, Xf, Yf), ListMoves) ->
		setPiece(Board, Xi, Yi, piece(none), Board2),
		setPiece(Board2, Xf, Yf, piece(Player), NewBoard),
		NewTurnNumber is TurnNumber +1
		;
		write('Not valid Move')
	).
% 

% valid_moves(+GameState, -ListOfMoves)
valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves) :- % Seleciona todas as Boards possiveis tendo conta qualquer movimento possivel de qualquer peça do jogador
	(	(TurnNumber mod 2) =:= 1 ->
		Player is white
		;
		Player is black
	),
	getPiece(Board, X, Y, piece(Player)),
	getcoordsMove(X, Y, N_X, N_Y),
	N_X > 0,
	N_X < 10,
	N_Y > 0,
	N_Y < 10,
	findall(move(X,Y, N_X, N_Y), vacant(N_X, N_Y, Board), ListOfMoves).
% 


% vacant(+X, +Y, +Board) 
vacant(X, Y, Board) :-
	boardSize(Size),
	between(1, Size, X),
	between(1, Size, Y),
	getPiece(Board, X, Y, piece(none)). 
%

% TO get possible moves out a determinate pair of coords
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 1, Y is IniY +2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 1, Y is IniY +2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 1, Y is IniY -2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 1, Y is IniY -2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 2, Y is IniY +1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 2, Y is IniY +1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 2, Y is IniY -1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 2, Y is IniY -1.
% 
	

%game_over(+State, -Winner) 
%game will be over, if all the slots on the top two rows are filled with white pieces
% or if all the slots on the bottom two rows are filled with white pieces
game_over(gameState(_, Board, _, _), Winner):-
	isRowFull(Board, 0, W),
	isRowFull(Board, 1, W),
	Winner is white.

% will check if all the slots on the bottom two rows are filled with black
game_over(gameState(_, Board, _, _), Winner) :-
	boardSize(Size),
	isRowFull(Board, 8, B),
	isRowFull(Board, Size, B),
	Winner is black.

game_over(_, Winner) :-
	Winner is none.

%isRowFull(+Board, +Row, +Piece)
isRowFull(Board, Row, Piece) :-
	boardSize(Size),
	between(1, Size, X),
	getPiece(Board, X, Row, Piece).

