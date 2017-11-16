append2([], X, X).
append2([A | B], C, [A | D]) :- append2(B, C, D).

step_reverse(X, X, []).
step_reverse(A, B, [C | D]) :- append([C], A, X), step_reverse(X, B, D).

reverse2([], []).
reverse2(A, B) :- step_reverse([], A, B).

delete_first2(E, [], []).
delete_first2(E, [E | L1], L1).
delete_first2(E, [A | L1], [A | L2]) :- not(A=E), delete_first2(E, L1, L2).

delete_all2(E, A, A) :- not(member(E, A)).
delete_all2(E, A, B) :- member(E, A), delete_first2(E, A, X), delete_all2(E, X, B).

delete_one2(E, A, A) :- not(member(E, A)).
delete_one2(E, A, A) :- member(E, A), !, fail.
delete_one2(E, [E | L1], L1).
delete_one2(E, [E | L1], [E | L2]) :- member(E, L1), delete_one2(E, L1, L2), !.
delete_one2(E, [A | L1], [B | L2]) :- A=B, delete_one2(E, L1, L2).

no_doubles2([], []).
no_doubles2([A | L1], [A | L2]) :- !, not(member(A, L2)), delete_all2(A, L1, X), no_doubles2(X, L2).
