%:- include('file.pl').
:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).

clearScreen :- write('\33\[2J').

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





