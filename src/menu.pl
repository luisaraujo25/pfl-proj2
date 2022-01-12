:- include('utils.pl').

menu :-
	clearScreen,
	printName,
	write('1. PLAY'), nl,
	write('2. RULES'), nl,	
	write('3. EXIT'), nl,
	readInput(Input),
	menuOptionHandler(Input).

readInput(Input) :-
	get_code(Input).

% If the user has selected the option '1' (ASCII code 49), display the playing options
menuOptionHandler(49) :-
	playingOptions.

% If the user has selected the option '2' (ASCII code 50), display the rules
menuOptionHandler(50) :-
	showRules.

% If the user has selected the option '3' (ASCII code 51), exit the game
menuOptionHandler(51).

% If the user has selected an invalid option, then display the menu again
menuOptionHandler(_) :-
	invalidInput,
	menu.
	

playingOptions :-
	clearScreen,
	write('1. USER VS USER'), nl,
	write('2. USER VS COMPUTER'), nl,
	write('3. COMPUTER VS USER'), nl,
	write('4. COMPUTER VS COMPUTER'), nl,
	write('5. GO BACK TO MAIN MENU'), nl.
	%readInput(Input),
	%playingOptionHandler(Input).

playingOptionHandler(49) :- start(user,user).

playingOptionHandler(50) :- start(user,computer).

playingOptionHandler(51) :- start(computer, user).

playingOptionHandler(52) :- start(computer1, computer2).

playingOptionHandler(53) :- menu.

playingOptionHandler(_) :- invalidInput.


invalidInput :- write('Invalid input'), nl.


% RULES
showRules :-
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


backMenu :-
	write('Press enter to go back to the main menu'), nl,
	get_code(Input),
	goBack(Input).

%10 is the code for enter
goBack(10) :- menu.
goBack(_) :- backMenu.
