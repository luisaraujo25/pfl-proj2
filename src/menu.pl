menu :-
	%clearScreen,
	write('***SHI***'), nl,
	write('1. PLAY'), nl,
	write('2. RULES'), nl,	
	write('3. EXIT'), nl,
	readInput(Input),
	optionHandler(Input).

readInput(Input) :-
	get_code(Input).

optionHandler(49) :-
	playingOptions.

optionHandler(50) :-
	showRules.

optionHandler(51).

optionHandler(_) :-
	invalidInput,
	menu.
	

playingOptions :-
	%clearScreen,
	write('1. USER VS USER'), nl,
	write('2. USER VS COMPUTER'), nl,
	write('3. COMPUTER VS COMPUTER'), nl.

showRules :-
	%clearScreen,
	write('*rules*'), nl,
	backMenu.

backMenu :-
	write('Press enter to go back to the main menu'), nl,
	get_code(Input),
	goBack(Input).

goBack(10) :- menu.

goBack(_) :- backMenu.

invalidInput :- write('Invalid input'), nl.
