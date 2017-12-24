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

my_delete_first(_, [], []).
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

n_member(_, []).
n_member(E, [A | L]) :- not(E = A), n_member(E, L).

%7
% (i, i)
% (o, i) undeterm
% (i, o) undeterm

my_head([], _).
my_head([A | B], [A | C]) :- my_head(B, C).

my_sublist([], _).
my_sublist([A | B], [A | C]) :- my_head(B, C).
my_sublist(A, [_ | C]) :- my_sublist(A, C).

%8
% (i, i, i)
% (o, i, i)
% (i, o, i) undeterm
my_number(E, 0, [E | _]).
my_number(E, X, [_ | B]) :- my_number(E, Y, B), X is Y+1.


%9
% (i, i)
% (i, o)
my_sort(A, B) :- my_merge_sort(A, B).

my_merge_sort([A, B], [A, B]) :- max(A, B, B), !.
my_merge_sort([B, A], [A, B]) :- max(A, B, B), !.
my_merge_sort([A], [A]) :- !.
my_merge_sort(A, SORTED) :- half_list(A, SH, BH), my_merge_sort(SH, SSH), my_merge_sort(BH, BBH), my_merge(SSH, BBH, SORTED).

my_merge([], A, A) :- !.
my_merge(A, [], A) :- !.
my_merge([A | B], [C | D], [A | SORTED] ) :- max(A, C, C), !, my_merge(B, [C | D], SORTED).
my_merge([A | B], [C | D], [C | SORTED] ) :- max(A, C, A), !, my_merge([A | B], D, SORTED).

half_list(A, SH, BH) :- length(A, LA), divmod(LA, 2, X, Y), LSH is Y + X,length(SH, LSH), my_head(SH, A), append(SH, BH, A).

%--------------------------------------

my_is_set([]).
my_is_set([A | B]) :- n_member(A, B), my_is_set(B).

%10
% (i, i)
% (o, i) undeterm
my_subset([], A) :- my_is_set(A).
my_subset(A, A) :- my_is_set(A).
my_subset([A | B], C) :- member(A, C), n_member(A, B), my_is_set(B), my_subset(B, C).

%11
%(i, i, i)
%(i, i, o) undeterm
my_intersection([], _, []) :- !.
my_intersection(_, [], []) :- !.
my_intersection(A, B, [C | CC])  :- member(C, A), member(C, B), my_delete_all(C, A, AA), my_delete_all(C, B, BB), my_intersection(AA, BB, CC).
my_intersection(A, B, []) :- not(have_intersections(A, B)), !.

have_intersections(A, B) :- member(E, A), member(E, B).

%--------------------------------------

max(A, B, B) :- A < B.
max(A, B, A) :- A >= B.

%12
% (i, i)
% (i, o)
% my_tree_depth(tree(empty, tree(empty, empty, 0), 0), X).
my_tree_depth(empty, 0).
my_tree_depth(tree(L, R, _), X) :- my_tree_depth(L, A), my_tree_depth(R, B), max(A, B, S), X is S+1.

my_tree_eq(empty, empty).
my_tree_eq(tree(L1, R1, N), tree(L2, R2, N)) :- my_tree_eq(L1, L2), my_tree_eq(R1, R2).

%13
% (i, i)
% (i, o) undeterm
% (o, i) undeterm
% my_subtree(tree(empty, tree(empty, empty, 0), 0), tree(empty, empty, 0)).
my_subtree(A, A) :- not(A == empty).
my_subtree(tree(L, R, _), X) :- X == L, not(X == empty); X == R, not(X == empty); my_subtree(L, X) ; my_subtree(R, X).

%14
% (i, i)
% (i, o)
% my_flatten_tree(tree(empty, tree(tree(empty, empty, 2), empty, 0), 1), X).
my_flatten_tree(T, L) :- step_flat(T, [], L).

step_flat(empty, L, L).
step_flat(tree(empty, empty, V), L, [V | L]) :- !.
step_flat(tree(L, R, V), LF, [V | RF]) :- step_flat(L, LF, LL), step_flat(R, LL, RF).

%15
% (i, i, i, i)
% (i, i, i, o)
% (i, i, o, i)
% (i, o, i, i)
% my_substitute(tree(tree(empty, empty, 0), tree(empty, empty, 2), 0), 0, 1, tree(tree(empty, empty, 1), tree(empty, empty, 2), 1)).

my_substitute(empty, _, _, empty).
my_substitute(tree(L1, R1, A), A, B, tree(L2, R2, Y)) :- !, Y = B, my_substitute(L1, A, B, L2), my_substitute(R1, A, B, R2).
my_substitute(tree(L1, R1, X), A, B, tree(L2, R2, X)) :- my_substitute(L1, A, B, L2), my_substitute(R1, A, B, R2).

%--------------------------------------
edge(a, c, 8).
edge(a, b, 3). %COMMENT THIS LINE TO MAKE NOT CYCLIC
edge(c, d, 12).
edge(b, d, 0).
edge(e, d, 9).

neighbours(A, B) :- edge(A, B, _).
neighbours(A, B) :- edge(B, A, _).

neighbours2(A, B, X) :- edge(A, B, X).
neighbours2(A, B, X) :- edge(B, A, X).

is_set([]).
is_set([A | B]) :- n_member(A, B), is_set(B).

% 16
% (i, i, i)
% (i, i, o)
% (i, o, i)
% (o, i, i)

path(X, Y, L) :- step_path(X, Y, [], L), n_member(X, L).

step_path(X, X, _, []).
step_path(X, Y, R, [A | B]) :- neighbours(X, A), n_member(A, R), append([A], R, Z), step_path(A, Y, Z, B).

%all_paths(X, Y, LP) :- step_all_paths(X, Y, [], LP).
all_paths(X, Y, PATHS) :- findall(Z, path(X, Y, Z), PATHS).

step_all_paths(X, Y, AP, LP) :- path(X, Y, P), n_member(P, AP), !, append([P], AP, Z), step_all_paths(X, Y, Z, LP).
step_all_paths(_, _, LP, LP).

% 17
% (i, i, i)
% (i, i, o) undeterm

min_path(X, Y, M) :- step_min_path(X, Y, [], M).

path_weight([A, T], W) :- neighbours2(A, T, W).
path_weight([A, B | C], W) :- append([B], C, Z), path_weight(Z, WW), neighbours2(A, B, WWW), W is WW + WWW.

step_min_path(X, Y, L, M) :- path(X, Y, P), append([X], P, PP), n_member(PP, L), !, append([PP], L, Z), step_min_path(X, Y, Z, M).
step_min_path(_, _, L, M) :- member(M, L), maplist(path_weight, L, Z), my_sort(Z, S), path_weight(M, Q), my_number(Q, 0, S).

% 18
% (i, i, i)
% (i, i, o) undeterm

add_to_set(E, X, X) :- member(E, X), !.
add_to_set(E, X, XX) :- n_member(E, X), !, append([E], X, XX).

merge_sets([], C, C).
merge_sets([A | B], C, D) :- add_to_set(A, C, CC), merge_sets(B, CC, D).

valid_path([A, B]) :- neighbours(A, B).
valid_path([A, B | C]) :- neighbours(A, B), valid_path([B | C]).

% current paths in PATHS
% all seen nodes in SEEN
% returns all valid paths that are 1 step deeper in NEW_PATHS
% returns all seen nodes in NEW_SEEN
step_path_depth(PATHS, SEEN, NEW_PATHS, NEW_SEEN) :-
	findall(B, (member(PATH, PATHS), last(PATH, A), neighbours(A, X), n_member(X, SEEN), append(PATH, [X], B), valid_path(B)), NEW_PATHS),
	setof(X, (member(PATH, PATHS), last(PATH, A), neighbours(A, X), n_member(X, SEEN)), NEW_NODES), !,
	merge_sets(SEEN, NEW_NODES, NEW_SEEN).

step_find_shortest(X, Y, BEST_PATH, PATHS, SEEN) :- setof(PATH, (member(PATH, PATHS), my_number(X, 0, PATH), last(PATH, Y)), BEST_PATHS), not(BEST_PATHS = []), !, member(BEST_PATH, BEST_PATHS).
step_find_shortest(X, Y, BEST_PATH, PATHS, SEEN) :- step_path_depth(PATHS, SEEN, NEW_PATHS, NEW_SEEN), step_find_shortest(X, Y, BEST_PATH, NEW_PATHS, NEW_SEEN).

short_path(X, Y, M) :- step_find_shortest(X, Y, M, [[X]], [X]).

% 19

cyclic :- neighbours(A, B), all_paths(A, B, L), length(L, X), X > 1, !.

%20
%UNCOMMENT FOLLOWING LINE TO MAKE GRAPH DISCONNECTED
%edge(q, w, 10).

is_connected :- not(is_disconnected).

is_disconnected :- neighbours(A, _), neighbours(B, _), not(A = B), all_paths(A, B, L), length(L, 0).
