:- include('utils.pl').
:- include('board.pl').

printPiece(white) :- write(' W ').

printPiece(black) :- write(' B ').

printPiece(none)  :- write('   ').

%printPiece(e):- write(' e ').

printRow(Piece) :-
	boardSize(Size),
	printRowAux(Piece, Size), nl.

printRowAux(Piece,0).
printRowAux(Piece,N) :-
	N>0,
	N1 is N-1,
	printRowAux(Piece,N1),
	printPiece(Piece).

printBoard :-
	clearScreen,
	boardSize(Size),
	printRow(white),
	printRow(white),
	printEmpty(Size-2),
	printRow(black),
	printRow(black).

printEmpty(0).
printEmpty(N) :-
	N>0,
	N1 is N-1,
	printEmpty(N1),
	printRow(none), nl.




