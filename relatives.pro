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

%-----------------------------
% supplimentary predicates

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

whois(HUMAN1, HUMAN2) :- complicated_path(HUMAN1, HUMAN2, PATH), print_path(PATH).
%whois(HUMAN1, HUMAN2) :-
%	relationship(HUMAN1, HUMAN2, RELATION), writef("%t is %t's %t\n", [HUMAN1, HUMAN2, RELATION]);
%	not(relationship(HUMAN1, HUMAN2, RELATION)), !, writef("unknown relationship\n").

complicated_path(HUMAN1, HUMAN2, [HUMAN1 | RESTPATH]) :- last(RESTPATH, HUMAN2), path([HUMAN1 | RESTPATH]).

path([HUMAN1, RELATION12, HUMAN2]) :- relationship(HUMAN1, HUMAN2, RELATION12).
path([HUMAN1, RELATION12, HUMAN2 | REST]) :- relationship(HUMAN1, HUMAN2, RELATION12), path([HUMAN2 | REST]).

print_path([HUMAN1, RELATION12, HUMAN2]) :- writef("%t is %t of %t\n", [HUMAN1, RELATION12, HUMAN2]), !.
print_path([HUMAN1, RELATION12, HUMAN2 | REST]) :- writef("%t is %t of %t, when ", [HUMAN1, RELATION12, HUMAN2]), print_path([HUMAN2 | REST]).
