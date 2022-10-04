import clyngor
from clyngor import Answers

n = 37
while True:

    print(n, end=" ", flush=True)
    answers: Answers = clyngor.solve("core.lp", "find_k.lp", constants={"n": n})

    *_, last_answer = answers.by_predicate
    (k,), = last_answer["num_selected"]
    print(k)
    n += 1