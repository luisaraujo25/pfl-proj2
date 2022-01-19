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

play :-
	menu.

% gameState(TurnNumber, Board).

% initial_state(+Size, -GameState) % Do we need size??
initial_state(gameState(TurnNumber, Board)) :-
	TurnNumber is 1,
	createBoard(Board).

play_game:-
    initial_state(GameState), %--> Iniciar a Board
    display_game(GameState),
    game_cycle(GameState).

game_cycle(gameState(TurnNumber, Board)):-
    game_over(GameState, Winner), !,
    congratulate(Winner). %% ??
    
game_cycle(gameState(TurnNumber, Board)):-
	(	(TurnNumber mod 2) =:= 1 ->
		Player is white
		;
		Player is black
	),
    choose_move(GameState, Player, Move),
    move(GameState, Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState), !,
    game_cycle(NewGameState).


% start(PLAYER1, PLAYER2) :-
% 	boardSize(Size).

% move(+GameState, +Move, -NewGameState)
move(gamestate( TurnNumber, Board), move(Xi, Yi, Xf, Yf), NewGameState):-
	valid_moves(gamestate( TurnNumber, Board), ListMoves),
	( member(Move, ListMoves) ->
		replace ....
		;
		write('Not valid Move')
	).


% valid_moves(+GameState, -ListOfMoves)
valid_moves(gameState(TurnNumber, Board), ListOfMoves) :- % Seleciona todas as Boards possiveis tendo conta qualquer movimento possivel de qualquer peça do jogador
  	% select(Color, Board, Motionboard),
	% get_playerturn(GameState, Color),
	% get_board(GameState, Board),
	(	(TurnNumber mod 2) =:= 1 ->
		Player is white
		;
		Player is black
	),
	getElement(Board, X, Y, Player),
	getcoordsMove(X, Y, N_X, N_Y),
	N_X > 0,
	N_X < 10,
	N_Y > 0,
	N_Y < 10,
	findall(move(X,Y, N_X, N_Y), vacant(N_X, N_Y, Board), vacant(N_X, N_Y, Board)).
	% (   
		
	% 	vacant(N_X, N_Y, Board) ->
    % 	ListOfMoves = [move(X,Y, N_X, N_Y)| ListOfMoves] % ????????
	% ).
    % not valid move? 

vacant(X, Y, Board) :-
  between(1, 9, X),
  between(1, 9, Y),
  getElement(Board, X, Y, piece(none)). %% ????

getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 1, Y is IniY +2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 1, Y is IniY +2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 1, Y is IniY -2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 1, Y is IniY -2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 2, Y is IniY +1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 2, Y is IniY +1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 2, Y is IniY -1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 2, Y is IniY -1.


asciitonum(NumCode, Num) :-
	between(1, 9, NumCode),
	Num is NumCode.

asciitonum(NumCode, Num) :-
	between(97, 105, NumCode),
	Num is NumCode - 96.

% choose_move(+GameState, +Level, -Move)
% choose_move(gamestate(TurnNumber, Board), Level, Move).


%game_over(+State, -Winner) 
%game will be over, if all the slots on the top two rows are filled with white pieces
% or if all the slots on the bottom two rows are filled with white pieces
game_over(State, Winner):-
	isRowFull(Board, 0, W),
	isRowFull(Board, 1, W),
	Winner is white.

% will check if all the slots on the bottom two rows are filled with black
game_over(State, Winner) :-
	isRowFull(Board, 8, B),
	isRowFull(Board, 9, B),
	Winner is black.

game_over(State, Winner) :-
	Winner is none.

%isRowFull(+Board, +Row, +Piece)
isRowFull(Board, Row, Piece) :-
	between(1, 9, X),
	getPiece(Board, X, Row, Piece),

