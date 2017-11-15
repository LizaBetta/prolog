append2([], X, X).
append2([A | B], C, [A | D]) :- append2(B, C, D).

step_reverse(X, X, []).
step_reverse(A, B, [C | D]) :- append([C], A, X), step_reverse(X, B, D).

reverse2([], []).
reverse2(A, B) :- step_reverse([], A, B).

delete_first2(E, [], []).
delete_first2(E, [E | L1], L1).
delete_first2(E, [A | L1], [E | L2]) :- !, fail.
delete_first2(E, [A | L1], [B | L2]) :- delete_first2(E, L1, L2).

delete_all2(E, [], []).
delete_all2(E, [E | A], [E | B]) :- !, fail.
delete_all2(E, [A | B], [C | D]) :- delete_all2(E, B, D).
delete_all2(E, [E | A], B) :- delete_all2(E, A, B).

delete_one2(E, A, A) :- not(member(E, A)).
delete_one2(E, A, A) :- member(E, A), !, fail.
delete_one2(E, [E | L1], L1).
delete_one2(E, [E | L1], [E | L2]) :- member(E, L1), delete_one2(E, L1, L2), !.
delete_one2(E, [A | L1], [B | L2]) :- A=B, delete_one2(E, L1, L2).
