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

% tsort(T, L).
tsort(L, S):- maketree(L, T), preorder(T, S).

% prefix(L, X).
prefix([], []).
prefix([H|T], [H|S]):-prefix(T, S).

% prefix1(L, X).
prefix1(L, X):- append(X, _, L).

% sufix(L, X).
sufix(L, X):-append(_, X, L).

% infix(L, X).
infix(L, X):- append(S, _, L), append(_, X, S);

% subset(L, S).
subset(L, []).
subset([H|T], S):-subset(T, S).
subset([H|T], [H|T1]):- subset(T, T1).

% subset1(L, X).
subset1([], L).
subset1([H|T], L):-append(_, [H|B], L), subset(T, B).

% sorted(L).
sorted([]).
sorted([_]).
sorted([A,B|T]):-less(A, B), sorted([B|T]).

% bogosort(L).
bogosort(S, L):- perm(S, L), sorted(S).

% n(N).
n(0).
n(X):- n(Y), X is Y + 1.

% z(N).
z(0).
z(X):-n(Y), Y > 0, member(P, [1,-1]), X is Y * P.

% o(N).
o(1).
o(X):- o(Y), X is Y + 2.

% o1(N).
o1(X):- n(X), X mod 2 =:= 1.

% e(N).
e(X):- n(X), X mod 2 =:= 0.

% between(X, A, B).
between(A, A, B).
between(X, A, B):- A < B, P is A + 1, between(X, P, B).

% npair(X, Y).
npair(X, Y):-n(A), between(X, 0, A), Y is A - X.

% zpair(X, Y).
zpair(X, Y):- npair(X1, Y1), member(C1, [1, -1]), member(D1, [1, -1]), X is X1 * C1, Y is Y1 * D1.

% norg(N, L).
% n(0, []).
% n(N, [H|T]):- N > 0, between(H, 0, S), S1 is S - H, N1 is N - 1, n(N1, T, S1).

% n(N, L, S).
% n(N, L):-n(S), n(N, L, S).

% sumN(L, N).
sumN([H|T], N):- n(H), n(P), H is N - P, sumN(T, N). 

% nSumOf4QubeN(N).
nSumOf4QubeN(N):- between(X1, 0, 31), between(X2, 0, 31), between(X3, 0, 31), between(X4, 0, 31), N is X1 * X1 + X2 * X2 + X3 * X3 + X4 * X4.

% group(L, G).
group([], []).
group([H], [[H]]).
group([H|[H|T]], [[H|F]|G]):- group([H|T], [F|G]).
group([H|[X|T]], [[H]|G]):- H\=X, group([X|T], G).

% graph([V, E]).

% empty graph
empty([[], []]).

% edge(G, X, Y).
edge([V, E], X, Y):- member([X, Y], E); member([Y, X], E).

% dfs(X).
% dfs(X):- goal(X).
% dfs(X):- edge(X, Y), dfs(Y).

% path (G, X, Y, P).
pathVertices(G, V, X, X, [X|V]).
pathVertices(G, V, X, Y, P):- edge(G, X, X1), not(member(X1, V)), pathVertices(G, [X|V], X1, Y, P).
pathVertices(G, X, Y, P):- pathVertices(G, [], X, Y, Q), reverse2(Q, P).

pathEdges(G, V, X, X, V).
pathEdges(G, V, X, Y, P):- edge(G, X, X1), not(member(X1, V)), pathEdges(G, [[X, X1]|V], X1, Y, P).
pathEdges(G, X, Y, P):- pathEdges(G, [], X, Y, Q), reverse2(Q, P).

% tree
treeGen(0, []).
treeGen(N, [A, B]):- N > 0, N1 is N - 1, between(X, 0, N1), Y is N1 - X, treeGen(X, A), treeGen(Y, B).
treeGen(X):- n(P), treeGen(P, X).

% sums
sums(0, []).
sums(N, [H|T]):- between(H, 0, N), N1 is N - H, sums(N1, T).
sumsGen(X):- n(P), sums(P, X).

% nlist
nlist(M, 0, []).
nlist(M, N, [H|T]):- between(H, 0, M), N1 is N - 1, nlist(M, N1, T).

% nlistGen
nlistGen(X):- n(P), nlist(10, P, X).

% isDivisor(N, P).
isDivisor(N, P):- N mod P =:= 0.

% isPrime
isPrime(2).
isPrime(N):- N > 1, N1 is N - 1, not((between(P, 2, N1), N mod P =:= 0)).

% pd(A, X).
pd(A, X):- between(X, 2, A), isPrime(X), isDivisor(A, X).

% pdc(A, B).
pdc(A, B):- not((pd(A, X), not(pd(B, X)))).

% p(A, B).
p(A, B):- pdc(A, B), pdc(B, A).

% transponse 

transponse([[]|_], []).
transponse(M, [H|T]):- transp(M, H, M1), transponse(M1, T).

transp([], [], []).
transp([[H|T]|L], [H|T1], [T|L1]):- transp(L, T1, L1).	
