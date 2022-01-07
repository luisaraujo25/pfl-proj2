menu :-
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
	clearScreen,
	menu.
	

playingOptions :-
	write('1. USER VS USER'), nl,
	write('2. USER VS COMPUTER'), nl,
	write('3. COMPUTER VS COMPUTER'), nl.

showRules :-
	write('*rules*').