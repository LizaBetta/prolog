:- dynamic male/1, female/1, parent/2, maried/2.
:- discontiguous index/2, male/1, female/1.


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

%-----------------------------
% supplimentary predicates

exists(HUMAN) :- male(HUMAN); female(HUMAN).

partners_parent(PARENT, HUMAN) :-
	happy_maried(HUMAN, PARTNER),
	parent(PARENT, PARTNER).

happy_maried(A, B) :-
	maried(A, B);
	maried(B, A).

has_same_parents(CHILD1, CHILD2) :-
	father(FATHER, CHILD1),
	mother(MOTHER, CHILD1),
	father(FATHER, CHILD2),
	mother(MOTHER, CHILD2),
	not(CHILD1 = CHILD2).

uncle_aunt_like(UNCLE_AUNT, CHILD) :-
	parent(PARENT, CHILD),
	has_same_parents(PARENT, UNCLE_AUNT).

double_like(DVOYURODNIE, CHILD) :-
	uncle_aunt_like(PARENT2, CHILD),
	parent(PARENT2, DVOYURODNIE).

grandparent(GRAND, CHILD) :-
	parent(PARENT, CHILD),
	parent(GRAND, PARENT).

%------------------------------

husband(HUSBAND, HUMAN) :-
	happy_maried(HUSBAND, HUMAN),
	male(HUSBAND).

wife(WIFE, HUMAN) :-
	happy_maried(WIFE, HUMAN),
	female(WIFE).

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

brother(BROTHER, CHILD) :-
	male(BROTHER),
	has_same_parents(BROTHER, CHILD),
	not(BROTHER = CHILD).

sister(SISTER, CHILD) :-
	female(SISTER),
	has_same_parents(SISTER, CHILD),
	not(SISTER = CHILD).

uncle(UNCLE, CHILD) :-
	male(UNCLE),
	uncle_aunt_like(UNCLE, CHILD).

aunt(AUNT, CHILD) :-
	female(AUNT),
	uncle_aunt_like(AUNT, CHILD).

double_brother(DOUBLE_B, CHILD) :-
	double_like(DOUBLE_B, CHILD),
	male(DOUBLE_B).

double_sister(DOUBLE_S, CHILD) :-
	double_like(DOUBLE_S, CHILD),
	male(DOUBLE_S).

grandfather(GRAND, CHILD) :-
	grandparent(GRAND, CHILD),
	male(GRAND).

grandmother(GRAND, CHILD) :-
	grandparent(GRAND, CHILD),
	female(GRAND).

grandson(GRANDSON, GRANDPARENT) :-
	grandparent(GRANDPARENT, GRANDSON),
	male(GRANDSON).

grandaughter(GRANDAUGHTER, GRANDPARENT) :-
	grandparent(GRANDPARENT, GRANDAUGHTER),
	female(GRANDAUGHTER).

tesha(TESHA, HUMAN) :-
	partners_parent(TESHA, HUMAN),
	male(HUMAN),
	female(TESHA).

test(TEST, HUMAN) :-
	partners_parent(TEST, HUMAN),
	male(HUMAN),
	male(TEST).

svekrov(SVEKROV, HUMAN) :-
	partners_parent(SVEKROV, HUMAN),
	female(HUMAN),
	female(SVEKROV).

svekr(SVEKR, HUMAN) :-
	partners_parent(SVEKR, HUMAN),
	female(HUMAN),
	male(SVEKR).

cousin(COUSIN, HUMAN) :-
	uncle_aunt_like(HUMAN, COUSIN),
	female(COUSIN).

nephew(NEPHEW, HUMAN) :-
	uncle_aunt_like(HUMAN, NEPHEW),
	male(NEPHEW).

shurin(SHURIN, HUMAN) :-
	wife(WIFE, HUMAN),
	brother(SHURIN, WIFE).

svoyachenitsa(SVOYACHENITSA, HUMAN) :-
	wife(WIFE, HUMAN),
	sister(SVOYACHENITSA, WIFE).

zolovka(ZOLOVKA, HUMAN) :-
	husband(HUSBAND, HUMAN),
	sister(ZOLOVKA, HUSBAND).

dever(DEVER, HUMAN) :-
	husband(HUSBAND, HUMAN),
	brother(DEVER, HUSBAND).

snoha(SNOHA, HUMAN) :-
	svekrov(HUMAN, SNOHA);
	svekr(HUMAN, SNOHA).

zyat(ZYAT, HUMAN) :-
	tesha(HUMAN, ZYAT),
	test(HUMAN, ZYAT).

relationship(HUMAN1, HUMAN2, husband)        :- husband(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, wife)           :- wife(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, son)            :- son(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, daughter)       :- daughter(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, mother)         :- mother(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, father)         :- father(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, brother)        :- brother(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, sister)         :- sister(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, uncle)          :- uncle(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, aunt)           :- aunt(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, double_brother) :- double_brother(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, double_sister)  :- double_sister(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, grandfather)    :- grandfather(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, grandmother)    :- grandmother(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, grandson)       :- grandson(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, grandaughter)   :- grandaughter(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, tesha)          :- tesha(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, test)           :- test(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, svekrov)        :- svekrov(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, svekr)          :- svekr(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, snoha)          :- snoha(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, zyat)           :- zyat(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, cousin)         :- cousin(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, nephew)         :- nephew(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, shurin)         :- shurin(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, svoyachenitsa)  :- svoyachenitsa(HUMAN1, HUMAN2).
relationship(HUMAN1, HUMAN2, zolovka)        :- zolovka(HUMAN1, HUMAN2).

whoisindex(I1, I2) :- index(HUMAN1, I1), index(HUMAN2, I2), whois(HUMAN1, HUMAN2).
whois(HUMAN1, HUMAN2) :- complicated_path(HUMAN1, HUMAN2, PATH), print_path(PATH).
%whois(HUMAN1, HUMAN2) :-
%	relationship(HUMAN1, HUMAN2, RELATION), writef("%t is %t's %t\n", [HUMAN1, HUMAN2, RELATION]);
%	not(relationship(HUMAN1, HUMAN2, RELATION)), !, writef("unknown relationship\n").

complicated_path(HUMAN1, HUMAN2, [HUMAN1 | RESTPATH]) :- last(RESTPATH, HUMAN2), path([HUMAN1 | RESTPATH]).

path([HUMAN1, RELATION12, HUMAN2]) :- relationship(HUMAN1, HUMAN2, RELATION12).
path([HUMAN1, RELATION12, HUMAN2 | REST]) :- relationship(HUMAN1, HUMAN2, RELATION12), path([HUMAN2 | REST]).

print_path([HUMAN1, RELATION12, HUMAN2]) :- writef("%t is %t of %t\n", [HUMAN1, RELATION12, HUMAN2]), !.
print_path([HUMAN1, RELATION12, HUMAN2 | REST]) :- writef("%t is %t of %t, when ", [HUMAN1, RELATION12, HUMAN2]), print_path([HUMAN2 | REST]).

%---------------------------------

consistant() :- not(inconsistant()), not(bad_mariage()).

inconsistant() :- relationship(HUMAN1, HUMAN2, REL1), relationship(HUMAN1, HUMAN2, REL2), not(REL1 == REL2), !, writef("bad assertion because %t and %t are not %t and %t\n", [HUMAN1, HUMAN2, REL1, REL2]).

incorrect_mariage(HUMAN1, HUMAN2) :-
	not(female(HUMAN1));
	not(male(HUMAN2)).

bad_mariage() :- maried(HUMAN1, HUMAN2), incorrect_mariage(HUMAN1, HUMAN2), writef("bad mariage because of gender with %t and %t\n", [HUMAN1, HUMAN2]).

maybe_retract_male(NEW_MALE) :-
	consistant(), !, true;
	retract(male(NEW_MALE)), !, fail.

maybe_retract_female(NEW_FEMALE) :-
	consistant(), !, true;
	retract(female(NEW_FEMALE)), !, fail.

maybe_retract_parent(NEW_PARENT, NEW_CHILD) :-
	consistant(), !, true;
	retract(parent(NEW_PARENT, NEW_CHILD)), !, fail.

maybe_retract_mariage(FEMALE, MALE) :-
	consistant(), !, true;
	retract(maried(FEMALE, MALE)), !, fail.

add_male(X, ok) :- female(X), retract(female(X)), asserta(male(X)), maybe_retract_male(X), !.
add_male(X, ok) :- asserta(male(X)), maybe_retract_male(male(X)), !.
add_male(_, not_ok) :- !, fail.

add_female(X, ok) :- male(X), retract(fefemale(X)), asserta(female(X)), maybe_retract_female(X), !.
add_female(X, ok) :- asserta(female(X)), maybe_retract_female(female(X)), !.
add_female(_, not_ok) :- !, fail.

add_parent(P, C, ok) :- retract(parent(P, C)), asserta(parent(P, C)), maybe_retract_parent(P, C), !.
add_parent(P, C, ok) :- asserta(parent(P, C)), maybe_retract_parent(P, C), !.
add_parent(_, _, not_ok) :- !, fail.

add_mariage(FEMALE, MALE, STATUS) :- retract(maried(FEMALE, MALE)), asserta(maried(FEMALE, MALE)), maybe_retract_mariage(FEMALE, MALE), !.
add_mariage(FEMALE, MALE, STATUS) :- asserta(maried(FEMALE, MALE)), maybe_retract_mariage(FEMALE, MALE), !.
add_mariage(_, _, not_ok) :- !, fail.

main :-
	repeat,
		write("\nMenu: "),
		write("\n1. Relationship between 2 people: "),
		write("\n2. Add new human: "),
		write("\n3. Add new relation: "),
		write("\n0. Exit"),
		write("\nSelect one to process: "),
		read(X),
		menu(X),
		write("\n").

menu(0).

menu(1) :-
	write("\n in menu1"),
	repeat,
		write("\nGive me name: "),
		read(HUMAN1),
		(exists(HUMAN1), !; writef("\n Unexistent human %s", [HUMAN1]), fail),
	repeat,
		write("\nGive me name: "),
		read(HUMAN2),
		(exists(HUMAN2), !; writef("\n Unexistent human %s", [HUMAN2]), fail),
	(
		complicated_path(HUMAN1, HUMAN2, PATH), print_path(PATH), !
	),
	fail.

menu(2) :-
	repeat,
		write("\nGive me name: "),
		read(Name),
	repeat,
		write("\n1. Press 1, if you want a male"),
		write("\n2. Press 2, if you want a female"),
		write("\n0. Press 0, if you want to exit"),
		read(Num),
		(
			(Num == 1, add_male(Name, ok), !);
			(Num == 2, add_female(Name, ok), !);
			(Num == 0, !);
			write("\n Incorrect input"), fail
		), fail.

menu(3) :-
	repeat,
		write("\nGive me a name: "),
		read(HUMAN1),
		(exists(HUMAN1), !; writef("\n Unexistent human %s", [HUMAN1]), fail),
	repeat,
		write("\nGive me a name: "),
		read(HUMAN2),
		(exists(HUMAN2), !; writef("\n Unexistent human %s", [HUMAN2]), fail),
	repeat,
		write("\n1. Press 1, if you want the first one to become a wife of the second one"),
		write("\n2. Press 2, if you want the first one to become a husband of the second one"),
		write("\n3. Press 3, if you want the first one to become a parent of the second one"),
		write("\n0. Press 0, if you want to exit"),
		read(Num),
		(
			(Num == 1, add_mariage(HUMAN1, HUMAN2, ok),!);
			(Num == 2, add_mariage(HUMAN2, HUMAN1, ok),!);
			(Num == 3, add_parent(HUMAN1, HUMAN2, ok),!);
			(Num == 0, !);
			write("\n Incorrect input"), fail
		), fail.

