%Testing setPiece/5 in utils.pl
%X=3 AND Y=2: CHANGE THE ELEMENT IN (X,Y) TO 0
testSetPiece(NewBoard) :-
    %input:
    setPiece([[1,2,3],[4,5,6],[7,8,9]],3,2,0,NewBoard).
    %expected output: NewBoard = [[1,2,3],[4,5,6],[7,0,9]].

%Testing getRow/3


%Testing replace/3


%getRow([[1,2,3],[4,5,6],[7,8,9]],2,Row).
%Result: Row = [7,8,9].
%replace(1,[7,8,9],0,NewRow).
%result: NewRow = [7,0,9].
%replace(2,[[1,2,3],[4,5,6],[7,8,9]],[7,0,9],NewBoard).
%Result: NewBoard = [[1,2,3],[4,5,6],[7,0,9]].
%
%Final result = [[1,2,3],[4,5,6],[7,0,9]].