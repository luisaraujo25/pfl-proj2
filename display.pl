:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).

displayBoard(B) :-
	write('\33\[2J'),
	write('FIRST SENTENCE').