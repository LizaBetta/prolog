%1
% (i, i, i)
% (o, i, i)
% (i, o, i)
% (i, i, o)

my_append([], X, X).
my_append([A | B], C, [A | D]) :- my_append(B, C, D).

%2
% (i, i)
% (o, i)
% (i, o)

my_reverse([], []).
my_reverse(A, B) :- step_reverse([], A, B).

step_reverse(X, X, []).
step_reverse(A, B, [C | D]) :- append([C], A, X), step_reverse(X, B, D).

%3
% (i, i, i)
% (o, i, i)
% (i, o, i)
% (i, i, o)

my_delete_first(E, [], []).
my_delete_first(E, [E | L1], L1).
my_delete_first(E, [A | L1], [A | L2]) :- not(A=E), my_delete_first(E, L1, L2).

%4
% (i, i, i)
% (o, i, i)
% (i, o, i) undeterm
% (i, i, o)
my_delete_all(E, A, A) :- n_member(E, A).
my_delete_all(E, A, B) :- member(E, A), my_delete_first(E, A, X), my_delete_all(E, X, B).

%5
% (i, i, i)
% (o, i, i)
% (i, o, i) undeterm
% (i, i, o)
my_delete_one(E, [E | L], L).
my_delete_one(E, [S | A], [S | B]) :- my_delete_one(E, A, B).

%6
% (i, i)
% (o, i) undeterm
% (i, o)
my_no_doubles([], []).
my_no_doubles([A | L1], [A | L2]) :- my_delete_all(A, L1, X), n_member(A, L2), my_no_doubles(X, L2).

n_member(E, []).
n_member(E, [A | L]) :- not(E == A), n_member(E, L).

%7
% (i, i)
% (o, i) undeterm
% (i, o) undeterm
my_sublist([], L).
my_sublist([A | B], [A | C]) :- my_sublist(B, C).
my_sublist(A, [B | C]) :- my_sublist(A, C).

%8
my_number(E, 0, [E | L]).
my_number(E, X, [A | B]) :- Y is X-1, Y >= 0, my_number(E, Y, B).


%9
my_sort(A, B) :- permutation(A, B), my_sorted(B).

my_sorted([]).
my_sorted([A | B]) :- not(greatet_then_some(A, B)), my_sorted(B).

greatet_then_some(A, B) :- member(M, B), A > M.

%--------------------------------------

%10
my_subset([], A).
my_subset([A | B], C) :- member(A, C), my_subset(B, C).

%11
my_union([], A, B) :- !, seteq(A, B).
my_union([E | L], A, B) :- member(E, B), is_set(B), my_delete_all(E, B, X), my_delete_all(E, A, Y), my_delete_all(E, L, Z), my_union(Z, Y, X), !.

seteq(A, B) :- is_set(A), permutation(A, B).

%--------------------------------------

max(A, B, B) :- A < B.
max(A, B, A) :- A >= B.

%12
my_tree_depth(empty, 0).
my_tree_depth(tree(L, R, N), X) :- my_tree_depth(L, A), my_tree_depth(R, B), max(A, B, S), X is S+1.

my_tree_eq(empty, empty).
my_tree_eq(tree(L1, R1, N), tree(my_L, my_R, N)) :- my_tree_eq(L1, my_L), my_tree_eq(R1, my_R).

%13
my_sub_tree(A, A).
my_sub_tree(tree(L, R, N), X) :- my_tree_eq(L, X) ; my_tree_eq(R, X) ; my_sub_tree(L, X) ; my_sub_tree(R, X).

%14

my_flatten_tree(empty, []).
my_flatten_tree(tree(L, R, N), S) :- member(N, S), my_delete_first(N, S, X), my_flatten_tree(L, A), my_flatten_tree(R, B), my_append(A, B, X).

%15

my_substitute(empty, A, B, empty).
my_substitute(tree(L1, R1, A), A, B, tree(my_L, my_R, Y)) :- !, Y is B, my_substitute(L1, A, B, my_L), my_substitute(R1, A, B, my_R).
my_substitute(tree(L1, R1, X), A, B, tree(my_L, my_R, X)) :- my_substitute(L1, A, B, my_L), my_substitute(R1, A, B, my_R).

%--------------------------------------
% 16

edge(a, c, 8).
edge(a, b, 3).
edge(c, d, 12).
edge(b, d, 0).
edge(e, d, 9).

neighbours(A, B) :- edge(A, B, _).
neighbours(A, B) :- edge(B, A, _).

neighbours2(A, B, X) :- edge(A, B, X).
neighbours2(A, B, X) :- edge(B, A, X).

is_set([]).
is_set([A | B]) :- n_member(A, B), is_set(B).

path(X, Y, L) :- step_path(X, Y, [], L), n_member(X, L).

step_path(X, X, _, []).
step_path(X, Y, R, [A | B]) :- neighbours(X, A), n_member(A, R), append([A], R, Z), step_path(A, Y, Z, B).

all_paths(X, Y, LP) :- step_all_paths(X, Y, [], LP).

step_all_paths(X, Y, AP, LP) :- path(X, Y, P), n_member(P, AP), !, append([P], AP, Z), step_all_paths(X, Y, Z, LP).
step_all_paths(X, Y, LP, LP).

% 17
short_path(X, Y, M) :- step_short_path(X, Y, [], M).

step_short_path(X, Y, L, M) :- path(X, Y, P), n_member(P, L), !, append([P], L, Z), step_short_path(X, Y, Z, M).
step_short_path(X, Y, L, M) :- member(M, L), maplist([A,B]>>(length(A,B)), L, Z), my_sort(Z, S), length(M, Q), my_number(Q, 0, S).

% 18

min_path(X, Y, M) :- step_min_path(X, Y, [], M).

path_weight([A, T], W) :- neighbours2(A, T, W).
path_weight([A, B | C], W) :- append([B], C, Z), path_weight(Z, WW), neighbours2(A, B, WWW), W is WW + WWW.

step_min_path(X, Y, L, M) :- path(X, Y, P), append([X], P, PP), n_member(PP, L), !, append([PP], L, Z), step_min_path(X, Y, Z, M).
step_min_path(X, Y, L, M) :- member(M, L), maplist([A,B]>>(path_weight(A,B)), L, Z), my_sort(Z, S), path_weight(M, Q), my_number(Q, 0, S).

% 19

cyclic :- neighbours(A, B), all_paths(A, B, L), length(L, X), X > 1, !.

%20

is_connected :- not(is_disconnected).

is_disconnected :- neighbours(A, _), neighbours(B, _), not(A = B), all_paths(A, B, L), length(L, 0).
