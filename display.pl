%:- include('file.pl').
:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).

clearScreen :- write('\33\[2J').

displayBoard :-
	clearScreen,
	write('FIRST SENTENCE').