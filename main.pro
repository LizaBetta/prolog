append2([], X, X).
append2([A | B], C, [A | D]) :- append2(B, C, D).

step_reverse(X, X, []).
step_reverse(A, B, [C | D]) :- append([C], A, X), step_reverse(X, B, D).

reverse2([], []).
reverse2(A, B) :- step_reverse([], A, B).

delete_first2(E, [], []).
delete_first2(E, [E | L1], L1).
delete_first2(E, [A | L1], [A | L2]) :- not(A=E), delete_first2(E, L1, L2).

delete_all2(E, A, A) :- n_member(E, A).
delete_all2(E, A, B) :- member(E, A), delete_first2(E, A, X), delete_all2(E, X, B).

delete_one2(E, [E | L], L).
delete_one2(E, [S | A], [S | B]) :- delete_one2(E, A, B).

no_doubles2([], []).
no_doubles2([A | L1], [A | L2]) :- delete_all2(A, L1, X), n_member(A, L2), no_doubles2(X, L2).

n_member(E, []).
n_member(E, [A | L]) :- not(E == A), n_member(E, L).

sublist2([], L).
sublist2([A | B], [A | C]) :- sublist2(B, C).
sublist2(A, [B | C]) :- sublist2(A, C).

number2(E, 0, [E | L]).
number2(E, X, [A | B]) :- Y is X-1, Y >= 0, number2(E, Y, B).


sort2([], []).

%--------------------------------------

subset2([], A).
subset2([A | B], C) :- member(A, C), subset2(B, C).

union2([], A, B) :- seteq(A, B).
union2([E | L], A, B) :- member(E, B), delete_all2(E, B, X), print(E), print(B), print(L), print(A), print(X), print(' '), union2(L, A, X).

seteq([], []).
seteq([A | B], L) :- member(A, L), delete_all2(A, L, X), seteq(B, X).

%--------------------------------------

max(A, B, B) :- A < B.
max(A, B, A) :- A >= B.

tree_depth2(empty, 0).
tree_depth2(tree(L, R, N), X) :- tree_depth2(L, A), tree_depth2(R, B), max(A, B, S), X is S+1.

tree_eq2(empty, empty).
tree_eq2(tree(L1, R1, N), tree(L2, R2, N)) :- tree_eq2(L1, L2), tree_eq2(R1, R2).

sub_tree2(A, A).
sub_tree2(tree(L, R, N), X) :- tree_eq2(L, X) ; tree_eq2(R, X) ; sub_tree2(L, X) ; sub_tree2(R, X).

flatten_tree2(empty, []).
flatten_tree2(tree(L, R, N), S) :- member(N, S), delete_first2(N, S, X), flatten_tree2(L, A), flatten_tree2(R, B), append2(A, B, X).

substitute2(empty, A, B, empty).
substitute2(tree(L1, R1, A), A, B, tree(L2, R2, Y)) :- !, Y is B, substitute2(L1, A, B, L2), substitute2(R1, A, B, R2).
substitute2(tree(L1, R1, X), A, B, tree(L2, R2, X)) :- substitute2(L1, A, B, L2), substitute2(R1, A, B, R2).

%--------------------------------------

edge(a, c, 8).
edge(a, b, 3).
edge(c, d, 12).
edge(b, d, 0).
edge(e, d,9).

neighbours(A, B) :- edge(A, B, Z) ; edge(B, A, Z).

is_set([]).
is_set([A | B]) :- n_member(A, B), is_set(B).

path(X, X, []).
path(X, Y, [A | B]) :- is_set(B), neighbours(X, A), n_member(A, B), path(A, Y, B).
