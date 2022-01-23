:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).
:- use_module(library(between)).
:- use_module(library(random)).
:- use_module(library(system)).

:- include('board.pl').
:- include('display.pl').
:- include('menu.pl').
:- include('bot.pl').
:- include('input.pl').
:- include('utils.pl').
:- include('tests.pl').

:-dynamic boardSize/1.

play :-
	menu.

% start(+Player1, +Player2)
% Initializes the gameState variable
start(PLAYER1, PLAYER2) :-
	% chooseBoardSize,
	boardSize(Size),
	initial_state(gameState(TurnNumber, Board, player(PLAYER1), player(PLAYER2))),
	% getGameState(1, GameState), %Teste ----
	display_game(gameState(TurnNumber, Board, player(PLAYER1), player(PLAYER2))),
	% display_game(GameState), % -- Test
	get_code(_),
	game_cycle(gameState(TurnNumber, Board, player(PLAYER1), player(PLAYER2))).
	% game_cycle(GameState). % -- Test

% initial_state(+Size, -GameState)
initial_state(gameState(TurnNumber, Board, _, _)) :-
	TurnNumber is 1,
	% getBoard(Board).
	initial_board(Board).


% getTurnColor(+Num, -Color).
% According to the turnNumbers gets the player (color) that will make a move
getTurnColor(-1, none).
getTurnColor(Num, white) :- Num mod 2 =:= 1.
getTurnColor(Num, black) :- Num mod 2 =:= 0.

% game_cycle(+GameState)
game_cycle(gameState(TurnNumber, Board, _, _)):-
    game_over(gameState(TurnNumber, Board, _, _), Winner), !,
    congratulate(Winner), sleepTime, sleepTime,
	menu.
    
congratulate(Winner) :- write('You won '), write(Winner), write('!').
% game_cycle(+GameState)

% If it is Player 1 turn, (whites)
% in case player is human function called for movement is playerAskMove
% 
game_cycle(gameState(TurnNumber, Board, player(human), P2)):-
	TurnNumber mod 2 =:= 1,
	playerAskMove(gameState(TurnNumber, Board, player(human), P2), Move),
    move(gameState(TurnNumber, Board, player(human), P2), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState),
	get_code(_),
    game_cycle(NewGameState).
% 
% in case player is computer function called for movement is choose_move
game_cycle(gameState(TurnNumber, Board, player(computer), P2)):-
	TurnNumber mod 2 =:= 1,
	sleepTime,
	choose_move(gameState(TurnNumber, Board, _, _), 1, Move),
    move(gameState(TurnNumber, Board, player(computer), P2), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    write('Computer`s Turn'),
	display_game(NewGameState),
    game_cycle(NewGameState).
% 
% % If it is Player 2 turn, (blacks)
% in case player is human function called for movement is playerAskMove
% 
game_cycle(gameState(TurnNumber, Board, P1, player(human))):-
	TurnNumber mod 2 =:= 0,
	playerAskMove(gameState(TurnNumber, Board, P1, player(human)), Move),
    move(gameState(TurnNumber, Board, P1, player(human)), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState),
	get_code(_),
    game_cycle(NewGameState).
% 
% 
% in case player is computer function called for movement is choose_move
game_cycle(gameState(TurnNumber, Board, P1, player(computer))):-
	TurnNumber mod 2 =:= 0,
	SleepTime is 2,
	sleep(SleepTime),
	choose_move(gameState(TurnNumber, Board, _, _), 1, Move),
    move(gameState(TurnNumber, Board, P1, player(computer)), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    write('Computer`s Turn'),
	display_game(NewGameState),
    game_cycle(NewGameState).
% 


% playerAskMove(+GameState, -move(Xi, Yi, Xf, Yf))
% Asks the player the move he wants to make, starting by making him choose a piece
playerAskMove(gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf)) :-
	getTurnColor(TurnNumber, Player), write('('), write(Player), write(')'),
	write('What piece you want to move? (write coordinates)'), nl, write('X: '), get_code(Xinput), write('Y: '), get_code(_),
	get_code(Yinput),
	get_code(_),
	asciitonum(Xinput, Xi),
	asciitonum(Yinput, Yi),
	getPiece(Board, Yi, Xi, piece(Color)),
	matchingColor(Color, Player, gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf)).
% 
% matchingColor(+Color1, +ColorPlayer, +GameState, move(+Xi, +Yi, -Xf, -Yf))
% Checks if they piece chosen by the player belongs to him
% matchingColor(1, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
matchingColor(Color, Color, gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf)) :-
	write('Where do you want to move it to? (write coordinates)'), nl, write('X: '), get_code(Xfinput), write('Y: '), get_code(_),
	get_code(Yfinput),  nl,
	asciitonum(Xfinput, Xf),
	asciitonum(Yfinput, Yf),
	isDestinationValid(Color, gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf)).

% In case the piece doesnt belong to the player, goes back to asking the player for a piece
% matchingColor(0, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
matchingColor(Color, NotColor, gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf)) :-
	write('didnt pick the right piece!-('), write(Color), write('=/'),write(NotColor), write(')'), nl, 
	game_cycle(gameState(TurnNumber, Board, P1, P2)).


% isDestinationValid(+Color, +GameState, + Move)
% Checks if the chosen move is a valid move
isDestinationValid(_, gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf)) :-
	valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves),
	member(move(Xi, Yi, Xf, Yf), ListOfMoves), write('valid').

% In case the chosen move isnt valid, goes back to asking the player a move (Asking for what piece to move again,
% because a piece initially chosen might really not have a possible move to be made)
isDestinationValid(_, gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf)) :-
	valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves),
	\+member(move(Xi, Yi, Xf, Yf), ListOfMoves),
	write('Not a valid move'), nl, get_code(_),
	game_cycle(gameState(TurnNumber, Board, P1, P2)).
% 


% move(+GameState, +Move, -NewGameState)
% moves the Piece on the actual Board, defining the new state of the game
move(gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf), gameState(NewTurnNumber, NewBoard, P1, P2)):-
	getTurnColor(TurnNumber, Player),
	XiP is Xi +1, YiP is Yi +1, XfP is Xf +1, YfP is Yf +1,
	setPiece(Board, YiP, XiP, piece(none), Board2),
	setPiece(Board2, YfP, XfP, piece(Player), NewBoard),
	NewTurnNumber is TurnNumber + 1.
% 

% valid_moves(+GameState, -ListOfMoves)
% Seleciona todas os Moves possiveis tendo conta qualquer movimento possivel de qualquer peça do jogador
valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves) :- 
	getTurnColor(TurnNumber, Player),
	getPiece(Board, Y, X, piece(Player)),
	getcoordsMove(X, Y, N_X, N_Y),
	N_X > -1,
	N_X < 10,
	N_Y > -1,
	N_Y < 10,
	findall(move(X,Y, N_X, N_Y), vacant(N_X, N_Y, Board), ListOfMoves).
% 


% vacant(+X, +Y, +Board) 
% Checks if the position with coords (X,Y) is empty (occupied with piece(none))
vacant(X, Y, Board) :-
	boardSize(Size),
	between(0, Size, X),
	between(0, Size, Y),
	getPiece(Board, Y, X, piece(none)). 
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
game_over(gameState(TurnNumber, Board, _, _), Winner):-
	getTurnColor(TurnNumber, white),
	% write('Tryingamevoer'),
	isRowFull(Board, 0, piece(white)),
	isRowFull(Board, 1, piece(white)),
	getTurnColor(TurnNumber, Winner).

% will check if all the slots on the bottom two rows are filled with black
game_over(gameState(TurnNumber, Board, _, _), Winner) :-
	getTurnColor(TurnNumber, black),
	boardSize(Size),
	Size1 is Size -1,
	Size2 is Size -2,
	isRowFull(Board, Size2, piece(black)),
	isRowFull(Board, Size1, piece(black)),
	getTurnColor(TurnNumber, Winner).
% 


%Checks whether or not a row is full of pieces from a single color
%isRowFull(+Board, +Row, +Piece)
isRowFull(Board, Row, piece(Color)) :-
	boardSize(Size),
	Size1 is Size -1,
	between(0, Size1, X), !,
	getPiece(Board, Row, X, piece(Color)).



