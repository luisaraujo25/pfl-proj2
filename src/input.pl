% asciitonum(+NumCode, -Num)
asciitonum(NumCode, Num) :- 
	boardSize(Size),
	between(1, Size, NumCode),
	Num is NumCode.

asciitonum(NumCode, Num) :-
	between(97, 105, NumCode),
	Num is NumCode - 96.
