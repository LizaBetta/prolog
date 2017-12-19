female(mary). index(mary, 1).
male(james). index(james, 2).
female(irma). index(irma, 3).
female(ruth). index(ruth, 4).
male(brian). index(brian, 5).
female(anna). index(anna, 6).
male(kevin). index(kevin, 7).
male(jason). index(jason, 8).
male(larry). index(larry, 9).
female(jean). index(jean, 10).
male(frank). index(frank, 11).
male(scott). index(scott, 12).
female(joan). index(joan, 13).
female(rose). index(rose, 14).
male(jerry). index(jerry, 15).
male(peter). index(peter, 16).
male(henry). index(henry, 17).
female(judy). index(judy, 18).
female(lena). index(lena, 19).
male(terry). index(terry, 20).
female(jane). index(jane, 21).
male(keith). index(keith, 22).
male(ralph). index(ralph, 23).
male(bruce). index(bruce, 24).
female(lori). index(lori, 25).
female(sara). index(sara, 26).
male(harry). index(harry, 27).
female(nora). index(nora, 28).
female(ruby). index(ruby, 29).

maried(mary, james).
maried(irma, jason).
maried(ruth, brian).
maried(anna, kevin).
maried(lori, larry).
maried(lena, terry).
maried(rose, jerry).
maried(joan, peter).
maried(jean, henry).
maried(sara, harry).
maried(judy, ralph).
maried(jane, keith).
maried(nora, bruce).

parent(mary,  irma).
parent(james, irma).
parent(mary,  ruth).
parent(james, ruth).
parent(irma,  larry).
parent(jason, larry).
parent(irma,  jean).
parent(jason, jean).
parent(ruth,  jason).
parent(brian, jason).
parent(ruth,  scott).
parent(brian, scott).
parent(anna,  brian).
parent(kevin, brian).
parent(lori,  sara).
parent(larry, sara).
parent(lena,  frank).
parent(terry, frank).
parent(lena,  rose).
parent(terry, rose).
parent(rose,  peter).
parent(jerry, peter).
parent(joan,  henry).
parent(peter, henry).
parent(jean,  judy).
parent(henry, judy).
parent(sara,  nora).
parent(harry, nora).
parent(judy,  bruce).
parent(ralph, bruce).
parent(jane,  ralph).
parent(keith, ralph).
parent(nora,  ruby).
parent(bruce, ruby).


son(SON, PARENT) :-
	male(SON),
	parent(PARENT, SON).

daughter(DAUGHTER, PARENT) :-
	female(DAUGHTER),
	parent(PARENT, DAUGHTER).

mother(MOTHER, CHILD) :-
	female(MOTHER),
	parent(MOTHER, CHILD).

father(FATHER, CHILD) :-
	male(FATHER),
	parent(FATHER, CHILD).

has_same_parents(CHILD1, CHILD2) :-
	father(FATHER, CHILD1),
	mother(MOTHER, CHILD1),
	father(FATHER, CHILD2),
	mother(MOTHER, CHILD2),
	not(CHILD1 = CHILD2).

brother(BROTHER, CHILD) :-
	male(BROTHER),
	has_same_parents(BROTHER, CHILD),
	not(BROTHER = CHILD).

sister(SISTER, CHILD) :-
	female(SISTER),
	has_same_parents(SISTER, CHILD),
	not(SISTER = CHILD).

uncle_aunt_like(UNCLE_AUNT, CHILD) :-
	parent(PARENT, CHILD),
	has_same_parents(PARENT, UNCLE_AUNT).

uncle(UNCLE, CHILD) :-
	uncle_aunt_like(UNCLE, CHILD),
	male(UNCLE).

aunt(AUNT, CHILD) :-
	female(AUNT),
	uncle_aunt_like(AUNT, CHILD),
	index(CHILD, Y), index(AUNT, X), print([Y, X, CHILD]).
