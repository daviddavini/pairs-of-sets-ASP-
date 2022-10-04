elem(0..n-1).
{num_selected(N) : elem(N)} = 1.

{in_set_a(X) : elem(X)} = N :- num_selected(N).
{in_set_b(X) : elem(X)} = N :- num_selected(N).

is_difference_a_from((X - Y + n) \ n, X, Y) :- in_set_a(X), in_set_a(Y), X != Y.
is_difference_b_from((X - Y + n) \ n, X, Y) :- in_set_b(X), in_set_b(Y), X != Y.

:- #count{d(a, X, Y) : is_difference_a_from(D, X, Y); d(b, X, Y) : is_difference_b_from(D, X, Y)} > 1, elem(D).

is_difference_a_b_from((X - Y + n) \ n, X, Y) :- in_set_a(X), in_set_b(Y).
is_difference_b_a_from((X - Y + n) \ n, X, Y) :- in_set_b(X), in_set_a(Y).

:- #count{d(a_b, X, Y) : is_difference_a_b_from(D, X, Y); d(b_a, X, Y) : is_difference_b_a_from(D, X, Y)} > 1, elem(D).

:~ num_selected(N). [-N]

#show in_set_a/1.
#show in_set_b/1.
#show num_selected/1.