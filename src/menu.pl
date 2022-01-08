menu :-
	%clearScreen,
	write('***SHI***'), nl,
	write('1. PLAY'), nl,
	write('2. RULES'), nl,	
	write('3. EXIT'), nl,
	readInput(Input),
	menuOptionHandler(Input).

readInput(Input) :-
	get_code(Input).

menuOptionHandler(49) :-
	playingOptions.

menuOptionHandler(50) :-
	showRules.

menuOptionHandler(51).

menuOptionHandler(_) :-
	invalidInput,
	menu.
	

playingOptions :-
	%clearScreen,
	write('1. USER VS USER'), nl,
	write('2. USER VS COMPUTER'), nl,
	write('3. COMPUTER VS COMPUTER'), nl,
	readInput(Input),
	playingOptionHandler(Input).

playingOptionHandler(49) :- start(user,user).

playingOptionHandler(50) :- start(user,computer).

playingOptionHandler(51) :- start(computer1,computer2).

playingOptionHandler(_) :- invalidInput.

showRules :-
	%clearScreen,
	write('*rules*'), nl,
	backMenu.

backMenu :-
	write('Press enter to go back to the main menu'), nl,
	get_code(Input),
	goBack(Input).

%10 is the code for enter

goBack(10) :- menu.

goBack(_) :- backMenu.

invalidInput :- write('Invalid input'), nl.
