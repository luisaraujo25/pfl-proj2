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
% initial_state(gameState(TurnNumber, Board, player(PLAYER1), player(PLAYER2)))
% display_game(GameState),
% gameState(TurnNumber, Board).

% initial_state(+Size, -GameState) % Do we need size??
initial_state(gameState(TurnNumber, Board, _, _)) :-
	TurnNumber is 1,
	createBoard(Board).

play_game:-
    initial_state(GameState), %--> Iniciar a Board
    display_game(GameState),
    game_cycle(GameState).

getTurnColor(2, none).
getTurnColor(Num, white) :- Num mod 2 =:= 1.
getTurnColor(Num, black) :- Num mod 2 =:= 0.

% game_cycle(+GameState)
game_cycle(gameState(TurnNumber, Board, _, _)):-
    game_over(gameState(TurnNumber, Board, _, _), Winner), !,
    congratulate(Winner). %% ??
    
% game_cycle(+GameState)
game_cycle(gameState(TurnNumber, Board, player(Race1), player(Race2))):-
	(	(TurnNumber mod 2) =:= 1 ->
		getTurnColor(1, Player),
		(	Race1 =:= human	->
			playerAskMove(Player, Board, Move)
		 	;
			choose_move(gameState(TurnNumber, Board, _, _), 1, Move)
		)
		;
		getTurnColor(0, Player),
		(	Race2 =:= human	->
			playerAskMove(Player, Board, Move)
		 	;
			choose_move(gameState(TurnNumber, Board, _, _), 1, Move)
		)
	),
	getTurnColor(TurnNumber, Player),
	getMove(Player, Race1, Race2),
    move(gameState(TurnNumber, Board, player(Race1), player(Race2)), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState), !,
    game_cycle(NewGameState).
% 

getMove(white, human, _) :-
	playerAskMove(Player, Board, Move).

getMove(black, _, human) :-
	playerAskMove(Player, Board, Move).

getMove(white, computer, _) :-
	choose_move(gameState(TurnNumber, Board, _, _), 1, Move).

getMove(black, _, computer) :-
	choose_move(gameState(TurnNumber, Board, _, _), 1, Move).


% playerAskMove(+GameState, -move(Xi, Yi, Xf, Yf))
playerAskMove(gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
	getTurnColor(TurnNumber, Player),
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
			write('Not a possible move!'), playerAskMove(gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf))
		)
		;
		write('None of your pieces are in that place'), nl,
		playerAskMove(gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf))
	).
% 


% move(+GameState, +Move, -NewGameState)
% moves the Piece on the actual Board, defining the new state of the game
move(gamestate(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf), gameState(NewTurnNumber, NewBoard, P1, P2)):-
	getTurnColor(TurnNumber, Player),
	valid_moves(gamestate( TurnNumber, Board, _, _), ListMoves),
	( member(move(Xi, Yi, Xf, Yf), ListMoves) ->
		setPiece(Board, Xi, Yi, piece(none), Board2),
		setPiece(Board2, Xf, Yf, piece(Player), NewBoard),
		NewTurnNumber is TurnNumber + 1
		;
		write('Not valid Move')
	).
% 

% valid_moves(+GameState, -ListOfMoves)
% Seleciona todas os Moves possiveis tendo conta qualquer movimento possivel de qualquer peça do jogador
valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves) :- 
	getTurnColor(TurnNumber, Player),
	getPiece(Board, X, Y, piece(Player)),
	getcoordsMove(X, Y, N_X, N_Y),
	N_X > 0,
	N_X < 10,
	N_Y > 0,
	N_Y < 10,
	findall(move(X,Y, N_X, N_Y), vacant(N_X, N_Y, Board), ListOfMoves).
% 


% vacant(+X, +Y, +Board) 
% Checks if the position with coords (X,Y) is empty (occupied with piece(none))
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
	isRowFull(Board, 1, W),
	isRowFull(Board, 2, W),
	getTurnColor(1, Winner).

% will check if all the slots on the bottom two rows are filled with black
game_over(gameState(_, Board, _, _), Winner) :-
	boardSize(Size),
	isRowFull(Board, 7, B),
	isRowFull(Board, Size-1, B),
	getTurnColor(0, Winner).

game_over(_, Winner) :-
	getTurnColor(2, Winner).

%Checks whether or not a row is full of pieces from a single color
%isRowFull(+Board, +Row, +Piece)
isRowFull(Board, Row, Piece) :-
	boardSize(Size-1),
	between(1, Size-1, X),
	getPiece(Board, X, Row, Piece).

display_game(gameState(_, Board, _, _)) :-
	write('   a  b  c  d  f  g  h  i  '), nl,
	display_lines(Board, 1).

display_lines([], _).
display_lines([Head|Tail], N) :- write(N), write(' '), display_line(Head), nl, N1 is N +1, display_lines(Tail, N1).

display_line([]).
display_line([Piece|Tail]) :- printPiece(Piece), display_line(Tail).

% ^Testing
getGameState(1, gameState(_, [[piece(white), piece(black), piece(none), piece(white)],[piece(none), piece(black), piece(none), piece(white)]], _, _)).



