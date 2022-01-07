menu :-
	%clearScreen,
	write('***SHI***'), nl,
	write('1. PLAY'), nl,
	write('2. RULES'), nl,	
	write('3. EXIT'), nl,
	readInput(Input),
	optionHandler(Input).

readInput(Input) :-
	get_char(Input).

optionHandler('1') :-
	playingOptions.

optionHandler('2') :-
	showRules.

optionHandler('3').

optionHandler(_) :-
	write('Invalid input'),
	menu.
	

playingOptions :-
	%clearScreen,
	write('1. USER VS USER'), nl,
	write('2. USER VS COMPUTER'), nl,
	write('3. COMPUTER VS COMPUTER'), nl.

showRules :-
	%clearScreen,
	write('*rules*'), nl,
	write('Press enter to go back to the main menu'), nl,
	readInput(_),
	readInput(Input),
	goBack(Input).

goBack('a') :- menu.
goBack(_) :- write('not going back').
