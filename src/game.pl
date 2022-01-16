:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).
:- use_module(library(between)).
% :- include('board.pl').

play :-
	menu.

% start(PLAYER1, PLAYER2) :-
% 	boardSize(Size).

% valid_moves(Piece, Board) :-


choose_move(Board, Color, MoveBoard):-
	write('Choose coordinates'), nl, write('X: '), get_code(InputX), nl, write('Y: '), get_code(InputY), nl,
	asciitonum(InputX, X),
	asciitonum(InputY, Y),
	(member(piece(Color, Y, X), Board) ->
		select(piece(Color, X, Y), Board, MoveBoard) % Escolher o move,
		;
		write('Move not possible'),
		choose_move(Board, Color, MoveBoard)
	).

	%   (
%     N_X is X + 1, N_Y is Y + 2;
%     N_X is X - 1, N_Y is Y + 2;
%     N_X is X + 1, N_Y is Y - 2;
%     N_X is X - 1, N_Y is Y - 2;
%     N_X is X + 2, N_Y is Y + 1;
%     N_X is X - 2, N_Y is Y + 1;
%     N_X is X + 2, N_Y is Y - 1;
%     N_X is X - 2, N_Y is Y - 1
%   ),

initial_board(Board) :-
    findall(Piece, initial(Piece), Board).

initial(piece(white, 1, 1)).
initial(piece(white, 2, 1)).
initial(piece(white, 3, 1)).
initial(piece(white, 4, 1)).
initial(piece(white, 5, 1)).
initial(piece(white, 6, 1)).
initial(piece(white, 7, 1)).
initial(piece(white, 8, 1)).
initial(piece(white, 9, 1)).


possible_move(Board, Color, Endboard) :- % Seleciona todas as Boards possiveis tendo conta qualquer movimento possivel de qualquer peça do jogador
  	select(piece(Color, X, Y), Board, Motionboard),
	getcoordsMove(X, Y, N_X, N_Y),
	N_X > 0,
	N_X < 10,
	N_Y > 0,
	N_Y < 10,
	(   vacant(N_X, N_Y, Board) ->
    	place(piece(Color, N_X, N_Y), Motionboard, Endboard)
	).
    % not valid move? 

vacant(X, Y, Board) :-
  between(1, 9, X),
  between(1, 9, Y),
  \+(member(piece(_, X, Y), Board)).

getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 1, Y is IniY +2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 1, Y is IniY +2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 1, Y is IniY -2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 1, Y is IniY -2.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 2, Y is IniY +1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 2, Y is IniY +1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX + 2, Y is IniY -1.
getcoordsMove(IniX, IniY, X, Y) :- X is IniX - 2, Y is IniY -1.

place(Piece, MotionBoard, EndBoard) :-
	EndBoard = [Piece | MotionBoard].

asciitonum(NumCode, Num) :-
	between(1, 9, NumCode),
	Num is NumCode.

asciitonum(NumCode, Num) :-
	between(97, 105, NumCode),
	Num is NumCode - 96.