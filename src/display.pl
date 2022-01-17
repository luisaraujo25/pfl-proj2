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


printName :-
	clearScreen,
	write(' ----------------------------------------------------------------------------------------------------------'), nl,
    write('|    0101101  0101101  0     0  101001   110100   1010011  1010011  0101101  101001   0101101  0      0    |'), nl,
	write('|    1     0  1        0 0   0  0     1  0     0  0     1  0     1  1     0  0     1  1        0 0    0    |'), nl,
	write('|    0101101  1101     0  0  0  1     1  011100   1100011  1100011  0101101  1     1  1101     0   0  0    |'), nl,
	write('|    0     1  0        0   0 0  1     0  0        1     1  1     1  0     1  1     0  0        0    0 0    |'), nl,
	write('|    1      0 0101101  0     0  010100   1        1     0  1     0  1      0 010100   0101101  0      0    |'), nl,
	write(' ----------------------------------------------------------------------------------------------------------'), nl, nl.

clearScreen :- write('\33\[2J').


printRules :-
	clearScreen,
	write(' ---------------------------------------------------'), nl,
    write('|     0101101  0     1  0       0101101 0101101     |'), nl,
	write('|     1      0 0     1  0       1       1           |'), nl,
	write('|     0101101  0     1  1       1101    0101101     |'), nl,
	write('|     0     1  0     1  0       0             1     |'), nl,
	write('|     1      0 0101101  0101101 0101101 0101101     |'), nl,
	write(' ---------------------------------------------------'), nl, nl,
	
	write('** SYMBOLS **'), nl, 
	write('B - Black piece'), nl, 
	write('W - White piece'), nl, nl,
	
	write('** BOARD **'), nl, 
	write('\tThe game is played on a 9x9 square board'), nl, nl,
	
	write('** INITIAL SETUP **'), nl, 
	write('\tEach player starts with 18 stones:'), nl,
	write('\tPlayer 1 has 9 stones on each of the two top rows'), nl,
	write('\tPlayer 2 has 9 stones on each of the two bottom rows'), nl, nl, 
	
	write('** HOW TO PLAY **'), nl, 
	write('\tA player moves their stones on at a time'), nl,
	write('\tEach stone moves like the chess Knight.'), nl, nl,
	
	write('** WINNING CONDITION **'), nl,
	write('\tIf you manage to place all your stones in the opponent''s starting position, you win the game'), nl,
	backMenu.
