%waits for an enter as input
getEnter :-
	get_code(_).

%clears the screen (so later can be displayed again more clearly)
clearScreen :- write('\33\[2J').

%Users have the option of picking different board sizes
chooseBoardSize :- 
    write('Choose Board Size: '), 
    read(Size), 
    assert(boardSize(Size)), !.