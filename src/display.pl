clearScreen :- write('\33\[2J').

printPiece(samurai) :- write(' S ').

printPiece(ninja) :- write(' N ').

printPiece(none) :- write('   ').

printPiece(e):- write(' e ').

printRow(Piece) :-
	boardSize(Size),
	printRowAux(Piece, Size), nl.

printRowAux(Piece,0).
printRowAux(Piece, N) :-
	N>0,
	N1 is N-1,
	printRowAux(Piece,N1),
	printPiece(Piece).

printBoard :-
	clearScreen,
	boardSize(Size),
	printRow(samurai), nl,
	printEmpty(Size-2),
	printRow(ninja).

printEmpty(0).
printEmpty(N) :-
	N>0,
	N1 is N-1,
	printEmpty(N1),
	printRow(none), nl.




