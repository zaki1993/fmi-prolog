% append(A, B, AB).
append([], B, B).
append([H|A], B, [H|AB]):- append(A, B, AB).

% len(A, X).
len([], 0).
len([H|T], X):- len(T, Y), X is 1 + Y.

% sum(A, X).
sum([], 0).
sum([H|T], X):- sum(T, Y), X is H + Y.

% mult(A, X).
mult([], 1).
mult([H|T], X):- mult(T, Y), X is H * Y.

r(m, 1000).
r(cm, 900).
r(d, 500).
r(cd, 400).
r(c, 100).
r(xc, 90).
r(l, 50).
r(xl, 40).
r(x, 10).
r(ix, 9).
r(v, 5).
r(iv, 4).
r(l, 1).

% rom(N).
rom(0).
rom(X):-r(Z, Y), not(X<Y), write(Z), X1 is X - Y, rom(X1).

% fact(N, RESULT).
fact(1, 1).
fact(N, P):- Q is N - 1, fact(Q, S), P is N * S.

% fib(N, RESULT).
fib(0, 1).
fib(1, 1).
fib(N, P):- N1 is N - 1, N2 is N - 2, fib(N1, R1), fib(N2, R2), P is R1 + R2.

% remove(X, L, S).
remove(X, [], []).
remove(X, [X|T], T).
remove(X, [H|T], [H|S]):- remove(X, T, S).

% remove2(X, L, X).
remove2(X, L, N):-append(M, [X|P], L), append(M, P, N).

% reverse2(L, R).
reverse2([], []).
reverse2([H|T], X):- reverse2(T, X1), append(X1, [H], X).

% member(X, L).
member(X, L):- append(_, [X|_], L).

% add (X, L, R).
add(X, L, [X|L]).

% car(X, R).
car([H|T], H).

% cdr(X, R).
cdr([H|T], T).

% is_first(X, L).
is_first(X, [X|_]).

% perm(L, P). INCOMPLETE
perm([], []).
perm([H|T], P):-remove(H, P, N), perm(T, N).

% less(A, B).
less(A, B):- A < B.

% split2(X, L, L1, L2).
split2(X, [], [], []).
split2(X, [H|T], [H|A], B):-less(H, X), split2(X, T, A, B).
split2(X, [H|T], A, [H|B]):-not(less(H, X)), split2(X, T, A, B).

% qsort(L, S).
qsort([], []).
qsort([H|T], S):- split2(H, T, L, R), qsort(L, S1), qsort(R, S2), append(S1, [H|S2], S).

% min(L, X).
min([X], X).
min([H|T], S):- min(T, S), less(S, H).
min([H|T], H):- min(T, S), not(less(S, H)).

% max(X, L).
max([X], X).
max([H|T], H):- max(T, P), less(P, H).
max([H|T], P):- max(T, P), not(less(P, H)).

% selsort(L, X).
selsort([], []).
selsort(L, [M|S]):-min(L, M), remove(M, L, N), selsort(N, S).

% tree (L, X, R).
% empty = empty tree

% treeadd(X, T, T1).
treeadd(X, empty, tree(empty, X, empty)).
treeadd(X, tree(L, T, R), tree(L1, T, R)):- less(X, T),treeadd(X, L, L1).
treeadd(X, tree(L, T, R), tree(L, T, R1)):- not(less(X, T)), treeadd(X, R, R1). 

% maketree(LST, TREE).
maketree([], empty).
maketree([H|T], P):-maketree(T, P1), treeadd(H, P1, P).

% preorder(T, LST).
preorder(empty, []).
preorder(tree(L, T, R), LST):- preorder(L, L1), preorder(R, R1), append(L1, [T|R1], LST).

tsort(L, S):- maketree(L, T), preorder(T, S).
