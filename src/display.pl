samurais([s,s,s,s,s,s,s,s]).

ninjas([n,n,n,n,n,n,n,n]).

board([
	samurais,
	[],
	[],
	[],
	[],
	[],
	[],
	ninjas
]).

displayBoard :-
	clearScreen,
	write(board),
	write('FIRST SENTENCE').





