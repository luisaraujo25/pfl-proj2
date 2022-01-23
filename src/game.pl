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

getTurnColor(-1, none).
getTurnColor(Num, white) :- Num mod 2 =:= 1.
getTurnColor(Num, black) :- Num mod 2 =:= 0.

% game_cycle(+GameState)
game_cycle(gameState(TurnNumber, Board, _, _)):-
    game_over(gameState(TurnNumber, Board, _, _), Winner), !,
    congratulate(Winner). %% ??
    
congratulate(Winner) :- write('You won '), write(Winner), write('!').
% game_cycle(+GameState)

% If it is Player 1 turn, (whites)
% in case player is human function called for movement is playerAskMove
% 
game_cycle(gameState(TurnNumber, Board, player(human), P2)):-
	TurnNumber mod 2 =:= 1,
	getTurnColor(TurnNumber, Player),
	playerAskMove(gameState(TurnNumber, Board, player(human), P2), Move),
    move(gameState(TurnNumber, Board, player(human), P2), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState),
	get_code(NL),
    game_cycle(NewGameState).
% 
% 
% in case player is computer function called for movement is choose_move
game_cycle(gameState(TurnNumber, Board, player(computer), P2)):-
	TurnNumber mod 2 =:= 1,
	getTurnColor(TurnNumber, Player),
	choose_move(gameState(TurnNumber, Board, _, _), 1, Move),
    move(gameState(TurnNumber, Board, player(computer), P2), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState),
	get_code(NL),
    game_cycle(NewGameState).
% 
% % If it is Player 2 turn, (blacks)
% in case player is human function called for movement is playerAskMove
% 
game_cycle(gameState(TurnNumber, Board, P1, player(human))):-
	TurnNumber mod 2 =:= 0,
	getTurnColor(TurnNumber, Player),
	playerAskMove(gameState(TurnNumber, Board, P1, player(human)), Move),
	write('here'),
    move(gameState(TurnNumber, Board, P1, player(human)), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState),
	get_code(NL),
    game_cycle(NewGameState).
% 
% 
% in case player is computer function called for movement is choose_move
game_cycle(gameState(TurnNumber, Board, P1, player(computer))):-
	TurnNumber mod 2 =:= 0,
	getTurnColor(TurnNumber, Player),
	choose_move(gameState(TurnNumber, Board, _, _), 1, Move),
    move(gameState(TurnNumber, Board, P1, player(computer)), Move, NewGameState), % TurnNumberNext is TurnNumber +1, should be included in move function
    display_game(NewGameState),
	get_code(NL),
    game_cycle(NewGameState).
% 



testinput :-
	get_code(A),get_code(B),get_code(C).


% playerAskMove(+GameState, -move(Xi, Yi, Xf, Yf))
playerAskMove(gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
	getTurnColor(TurnNumber, Player),
	write('What piece you want to move? (write coordinates)'), nl, write('X: '), get_code(Xinput), nl, write('Y: '), get_code(Nl),
	get_code(Yinput),
	write(Xinput), nl, get_code(None), write(Yinput), nl,% get_code(None), write(None),nl, 
	asciitonum(Xinput, Xi),
	asciitonum(Yinput, Yi),
	write(Xi), nl, write(Yi),nl,
	getPiece(Board, Yi, Xi, piece(Color)), write(Color), nl,
	matchingColor(Color, Player, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)).
	% (	Color =:= Player ->
	% 	write('Where you want to move it to? (write coordinates)'), nl, write('X: '), get_code(Xfinput), nl, write('Y: '), get_code(Yfinput), nl,
	% 	asciitonum(Xfinput, Xf),
	% 	asciitonum(Yfinput, Yf),
	% 	valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves),
	% 	( 	\+member(move(Xi, Yi, Xf, Yf), ListOfMoves) ->
	% 		write('Not a possible move!'), playerAskMove(gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf))
	% 	)
	% 	;
	% 	write('None of your pieces are in that place'), nl,
	% 	playerAskMove(gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf))
	% ).
% 

matchingColor(Color, Color, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
	write('Where you want to move it to? (write coordinates)'), nl, write('X: '), get_code(Xfinput), nl, write('Y: '), get_code(None), nl,
	get_code(Yfinput), nl,
	write(Xfinput), nl,write(Yfinput),nl, write(None),nl,
	asciitonum(Xfinput, Xf),
	asciitonum(Yfinput, Yf),
	write(Xf), nl,write(Yf),nl, write(None),nl, 
	isDestinationValid(Color, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)).

matchingColor(Color, NotColor, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
	write('player 2 aqui'), write(Color), write('-'), write(NotColor), write('-'), 
	playerAskMove(gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)).


isDestinationValid(Color, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
	valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves),
	member(move(Xi, Yi, Xf, Yf), ListOfMoves), write('valid').

isDestinationValid(Color, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)) :-
	valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves),
	\+member(move(Xi, Yi, Xf, Yf), ListOfMoves),
	write('Not a valid move'), nl, get_code(Nl),
	matchingColor(Color, Color, gameState(TurnNumber, Board, _, _), move(Xi, Yi, Xf, Yf)).



% move(+GameState, +Move, -NewGameState)
% moves the Piece on the actual Board, defining the new state of the game
move(gameState(TurnNumber, Board, P1, P2), move(Xi, Yi, Xf, Yf), gameState(NewTurnNumber, NewBoard, P1, P2)):-
	getTurnColor(TurnNumber, Player), write(Player),
	% valid_moves(gamestate( TurnNumber, Board, _, _), ListMoves),
	XiP is Xi +1, YiP is Yi +1, XfP is Xf +1, YfP is Yf +1,
	setPiece(Board, YiP, XiP, piece(none), Board2),
	setPiece(Board2, YfP, XfP, piece(Player), NewBoard),
	NewTurnNumber is TurnNumber + 1.
% 

% valid_moves(+GameState, -ListOfMoves)
% Seleciona todas os Moves possiveis tendo conta qualquer movimento possivel de qualquer peça do jogador
valid_moves(gameState(TurnNumber, Board, _, _), ListOfMoves) :- 
	getTurnColor(TurnNumber, Player),
	write(Player),
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
	isRowFull(Board, 0, piece(white)),
	isRowFull(Board, 1, piece(white)),
	getTurnColor(TurnNumber, Winner).

% will check if all the slots on the bottom two rows are filled with black
game_over(gameState(TurnNumber, Board, _, _), Winner) :-
	getTurnColor(TurnNumber, white),
	boardSize(Size),
	Size1 is Size -1,
	Size2 is Size -2,
	isRowFull(Board, Size2, piece(black)),
	isRowFull(Board, Size1, piece(black)),
	getTurnColor(TurnNumber, Winner).

% game_over(_, Winner) :-
% 	getTurnColor(2, Winner).

%Checks whether or not a row is full of pieces from a single color
%isRowFull(+Board, +Row, +Piece)
% isRowFull(Board, Row, Piece, N)
isRowFull(Board, Row, piece(Color)) :-
	boardSize(Size),
	Size1 is Size -1,
	between(0, Size1, X), !,
	write(X),
	getPiece(Board, X, Row, piece(Color)), write(Color).
	% N1 is N +1,
	% isRowFull(Board, Row, Piece, N1).

% isRowFull(Board, Row, Piece) :-
% 	boardSize(Size-1),
% 	between(1, Size-1, X),
% 	getPiece(Board, X, Row, Piece).

display_game(gameState(_, Board, _, _)) :-
	% nl, write('   1  2  3  4  5  6  7  '), nl,
	boardSize(Size),
	nl, write('   '), print1Line(Size, 1),
	display_lines(Board, 1).

print1Line(0, _) :- nl, !.
print1Line(Size, Num) :- write(Num), write('  '), N1 is Num +1, Size1 is Size -1, print1Line(Size1, N1).

display_lines([], _).
display_lines([Head|Tail], N) :- write(N), write(' '), display_line(Head), nl, N1 is N +1, display_lines(Tail, N1).

display_line([]).
display_line([Piece|Tail]) :- printPiece(Piece), display_line(Tail).

% ^Testing
getGameState(1, gameState(1, [
	[piece(none), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	[piece(none), piece(white), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(black), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)]
], player(human), player(human))).

getBoard([
	[piece(none), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	% [piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black), piece(black)],
	[piece(none), piece(white), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none), piece(none)],
	[piece(black), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)],
	[piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white), piece(white)]
]).

