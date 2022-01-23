printPiece(piece(white)) :- write(' W ').

printPiece(piece(black)) :- write(' B ').

printPiece(piece(none))  :- write(' . ').

%printPiece(e):- write(' e ').

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

%printName\0
%Prints in the console the title of the game
printName :-
	clearScreen,
	write(' ----------------------------------------------------------------------------------------------------------'), nl,
    write('|    0101101  0101101  0     0  101001   110100   1010011  1010011  0101101  101001   0101101  0      0    |'), nl,
	write('|    1     0  1        0 0   0  0     1  0     0  0     1  0     1  1     0  0     1  1        0 0    0    |'), nl,
	write('|    0101101  1101     0  0  0  1     1  011100   1100011  1100011  0101101  1     1  1101     0   0  0    |'), nl,
	write('|    0     1  0        0   0 0  1     0  0        1     1  1     1  0     1  1     0  0        0    0 0    |'), nl,
	write('|    1      0 0101101  0     0  010100   1        1     0  1     0  1      0 010100   0101101  0      0    |'), nl,
	write(' ----------------------------------------------------------------------------------------------------------'), nl, nl.



%printRules\0
%Prints in the console the rules of the game
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

% getPiece(Board, X, Y, Piece)