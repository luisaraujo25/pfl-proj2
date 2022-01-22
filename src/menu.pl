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

playingOptionHandler(49) :- start(human,human).

playingOptionHandler(50) :- start(human, bot).

playingOptionHandler(51) :- start(bot, human).

playingOptionHandler(52) :- start(bot1, bot2).

playingOptionHandler(53) :- menu.

playingOptionHandler(_) :- invalidInput.


invalidInput :- write('Invalid input'), nl.

% RULES
backMenu :-
	write('Press enter to go back to the main menu'), nl,
	get_code(Input),
	goBack(Input).

%10 is the code for enter
goBack(10) :- menu.
goBack(_) :- backMenu.
