# Prerequisite Self-Test

Code

Check the background that CSCI 201 assumes, before the course starts

Published

Last modified: 2026-11-13 17:03:18 (PST)

This self-test checks the background that CSCI 201 assumes from its first week: programming from CSCI 141 and 145, and the algebra from your math prerequisite. It is not graded, and nobody sees your answers.

Work each exercise on paper, without notes or a calculator, before you open its solution. The whole test takes about 45 minutes. Only your final answers need checking, but work that you can follow helps you find a mistake. Each solution explains the answer and names a page to review if you missed the exercise. The code is in Python. The course itself programs in Racket, which it teaches from the start.

Your results tell you what to do next:

- If you got almost everything right, you are ready.
- If you missed a few exercises, read the review pages that their solutions name before the first week.
- If you missed several exercises in one part, send me a message through the Canvas inbox in the first week, and we will plan how you can catch up.

# Programming

> **NOTE:**
>
> **Exercise 1 (A Boolean expression)** Let `x` hold the value 2.
>
> Is this Python expression `True` or `False`?
>
> ``` python
> not (x % 3 == 0) and (x > 4 or x == 2)
> ```

> **NOTE:**
>
> *Solution 1*. The expression is `True`. Here `x % 3` is 2, so `not (x % 3 == 0)` is `True`. Also `x == 2` is `True`, so `x > 4 or x == 2` is `True`. Then `True and True` is `True`.
>
> The [Propositional Logic](../chapters/propositional-logic.llms.md) chapter treats `and`, `or` and `not` as operations on truth values, called [logical connectives](../chapters/propositional-logic.llms.md#def-logical-connective).

> **NOTE:**
>
> **Exercise 2 (Integer division)** In Python, `//` is integer division.
>
> What is the value of `2027 // 10`?

> **NOTE:**
>
> *Solution 2*. The value is 202. Dividing a nonnegative integer by 10 with `//` drops its last decimal digit.
>
> For nonnegative integers, `n // d` is the [floor](../chapters/loop-invariants.llms.md#def-floor) of $n / d$.

> **NOTE:**
>
> **Exercise 3 (A remainder)** In Python, `%` gives the remainder after integer division.
>
> What is the value of `2027 % 10`?

> **NOTE:**
>
> *Solution 3*. The value is 7. The remainder after dividing a nonnegative integer by 10 is its last decimal digit, because $2027 = 202 \cdot 10 + 7$.
>
> To review remainders and divisibility, read [Definition: Divides](../chapters/direct-proof.llms.md#def-divides).

> **NOTE:**
>
> **Exercise 4 (Nested loops)** Consider this Python code:
>
> ``` python
> count = 0
> for i in range(5):
>     for j in range(i, 5):
>         count = count + 1
> ```
>
> What is the value of `count` after the code runs?

> **NOTE:**
>
> *Solution 4*. The value is 15. `range(5)` gives `i` the values 0, 1, 2, 3 and 4. For each `i`, `range(i, 5)` has $5 - i$ values, so the inner loop runs 5, 4, 3, 2 and 1 times. The total is $5 + 4 + 3 + 2 + 1 = 15$.
>
> An answer of 10 or 20 points to the ends of `range`: `range(a, b)` includes `a` and excludes `b`. Counting loop iterations with a sum like this one starts the chapter [Recurrences and Growth](../chapters/recurrences-growth.llms.md).

> **NOTE:**
>
> **Exercise 5 (Tracing a recursive function)** Consider this Python function:
>
> ``` python
> def p(b, n):
>     if n == 0:
>         return 1
>     return b * p(b, n - 1)
> ```
>
> What does `p(3, 4)` return?

> **NOTE:**
>
> *Solution 5*. `p(3, 4)` returns 81. The calls are `p(3, 4) = 3 * p(3, 3)`, `p(3, 3) = 3 * p(3, 2)`, `p(3, 2) = 3 * p(3, 1)`, `p(3, 1) = 3 * p(3, 0)` and `p(3, 0) = 1`. So `p(3, 4)` is $3 \cdot 3 \cdot 3 \cdot 3 \cdot 1 = 81$.
>
> The course writes functions like this one in Racket, starting in [Functional Programming](../chapters/functional-programming.llms.md) and continuing in [Recursion](../chapters/recursion.llms.md).

> **NOTE:**
>
> **Exercise 6 (What a recursive function computes)** The Python function `p` computes a familiar quantity:
>
> ``` python
> def p(b, n):
>     if n == 0:
>         return 1
>     return b * p(b, n - 1)
> ```
>
> In one sentence, what does `p(b, n)` compute for a nonnegative integer `n`?

> **NOTE:**
>
> *Solution 6*. `p(b, n)` computes $b^n$, the `n`th power of `b`. Each call multiplies by `b` once, and the calls stop after `n` multiplications, when `n` reaches 0.
>
> If this exercise was hard, review recursion from CSCI 145 before the course reaches [Recursion](../chapters/recursion.llms.md).

> **NOTE:**
>
> **Exercise 7 (Writing a recursive function)** You may use `xs == []` to test for the empty list, `xs[0]` for the first element of a list `xs` and `xs[1:]` for the list without its first element.
>
> Write a recursive Python function `total(xs)` that returns the sum of the numbers in the list `xs`, without a loop or the built-in `sum`.

> **NOTE:**
>
> *Solution 7*.
>
> ``` python
> def total(xs):
>     if xs == []:
>         return 0
>     return xs[0] + total(xs[1:])
> ```
>
> A correct answer has two parts:
>
> - a base case: the sum of the empty list is 0;
> - a recursive case that adds the first element to `total` of the rest of the list.
>
> Pseudocode or another language is fine, as long as the base case and the recursive call are clear. In Racket, `first` and `rest` play the parts of `xs[0]` and `xs[1:]` (see [Recursion](../chapters/recursion.llms.md)).

> **NOTE:**
>
> **Exercise 8 (A stack)** Start with an empty stack and perform these operations in order:
>
> push 5, push 8, push 2, pop, push 7, pop, pop.
>
> Which values do the three pops return, in order?

> **NOTE:**
>
> *Solution 8*. The pops return 2, 7 and 8, in that order. A stack is last in, first out: each pop removes the last value pushed that is still on the stack. After the three pops, the stack holds only 5.
>
> The course uses stacks to explain how recursive calls run.

> **NOTE:**
>
> **Exercise 9 (A queue)** Start with an empty queue and perform these operations in order, where “add” puts a value at the back and “remove” takes the value at the front:
>
> add 5, add 8, add 2, remove, add 7, remove, remove.
>
> Which values do the three removes return, in order?

> **NOTE:**
>
> *Solution 9*. The removes return 5, 8 and 2, in that order. A queue is first in, first out: each remove takes the value that has waited longest. After the three removes, the queue holds only 7.
>
> The course uses queues for breadth-first search on [Graphs](../chapters/graphs.llms.md).

# Math

> **NOTE:**
>
> **Exercise 10 (Multiplying powers)** Write $8^3 \cdot 2^4$ as a single power of 2, such as $2^7$.

> **NOTE:**
>
> *Solution 10*. The product is $2^{13}$. Since $8 = 2^3$, $8^3 = 2^9$ by the rule for [a power of a power](https://morrison-lab.github.io/mds/algebra-exponentials.html#thm-double-exp). Then $2^9 \cdot 2^4 = 2^{9 + 4}$ by the rule for [a power of a sum](https://morrison-lab.github.io/mds/algebra-exponentials.html#thm-power-sum).
>
> To review powers, read [Definition: Exponent of a power](https://morrison-lab.github.io/mds/algebra-basics.html#def-power-exponent).

> **NOTE:**
>
> **Exercise 11 (Doubling a power)** Let $n$ be an integer.
>
> Write $2^n + 2^n$ as a single power of 2.

> **NOTE:**
>
> *Solution 11*. The sum is $2^{n+1}$, because $2^n + 2^n = 2 \cdot 2^n = 2^{n+1}$.
>
> Steps like this one come up in many [Induction](../chapters/induction.llms.md) proofs. To review adding exponents, read [Theorem: Power of a sum](https://morrison-lab.github.io/mds/algebra-exponentials.html#thm-power-sum).

> **NOTE:**
>
> **Exercise 12 (A logarithm)** Evaluate $\log_2 \mathopen{}\left(8^5\right)\mathclose{}$ without a calculator.

> **NOTE:**
>
> *Solution 12*. The value is 15. Since $8 = 2^3$, $8^5 = \mathopen{}\left(2^3\right)\mathclose{}^5 = 2^{15}$, and the logarithm to the base 2 of $2^{15}$ is 15.
>
> To review logarithms, read [Definition: Logarithm](../chapters/recurrences-growth.llms.md#def-logarithm) and [Theorem: Logarithm of a power](https://morrison-lab.github.io/mds/algebra-exponentials.html#thm-log-exp).

> **NOTE:**
>
> **Exercise 13 (Rounding a logarithm down)** For a real number $x$, the floor $\mathopen{}\left\lfloor x\right\rfloor\mathclose{}$ is the largest integer that is at most $x$.
>
> Find $\mathopen{}\left\lfloor\log_2 100\right\rfloor\mathclose{}$ without a calculator.

> **NOTE:**
>
> *Solution 13*. The value is 6. Since $2^6 = 64 \le 100 < 128 = 2^7$, $\log_2 100$ is between 6 and 7.
>
> The value is also the number of times that 100 can be halved before reaching 1, rounding down each time: 100, 50, 25, 12, 6, 3, 1. That count is why logarithms come up so often in computer science, for example as the number of steps of binary search. To review, read [Definition: Logarithm](../chapters/recurrences-growth.llms.md#def-logarithm) and [Definition: Floor](../chapters/loop-invariants.llms.md#def-floor).

> **NOTE:**
>
> **Exercise 14 (Composing two functions)** Let $f(x) = 3x - 1$ and $g(x) = x^2$.
>
> Find $f(g(2))$.

> **NOTE:**
>
> *Solution 14*. The value is 11. First, $g(2) = 4$, so $f(g(2)) = f(4) = 3 \cdot 4 - 1 = 11$.
>
> The course writes $f(g(x))$ as $(f \circ g)(x)$ and uses composition throughout. To review, read [Definition: Composition](../chapters/relations.llms.md#def-composition).

> **NOTE:**
>
> **Exercise 15 (Composing in the other order)** Let $f(x) = 3x - 1$ and $g(x) = x^2$.
>
> Find $g(f(2))$.

> **NOTE:**
>
> *Solution 15*. The value is 25. First, $f(2) = 5$, so $g(f(2)) = g(5) = 25$. Composing in the other order gives $f(g(2)) = 11$ instead, so the order of a composition matters.
>
> To review, read [Definition: Composition](../chapters/relations.llms.md#def-composition).

> **NOTE:**
>
> **Exercise 16 (Evaluating a sum)** Evaluate $\sum_{i=0}^{4} 2^i$.

> **NOTE:**
>
> *Solution 16*. The sum is 31. The terms for $i = 0, 1, 2, 3, 4$ are $1, 2, 4, 8, 16$, and their sum is 31. The index starts at 0, so the sum has five terms.
>
> To review, read [Definition: Summation notation](https://morrison-lab.github.io/mds/algebra-sums.html#def-summation).

> **NOTE:**
>
> **Exercise 17 (Writing a sum)** Write $3 + 6 + 9 + \cdots + 30$ in summation notation.

> **NOTE:**
>
> *Solution 17*. One answer is $\sum_{k=1}^{10} 3k$. Other correct forms are fine, such as $\sum_{k=0}^{9} 3(k + 1)$ or $3 \sum_{k=1}^{10} k$.
>
> To review, read [Definition: Summation notation](https://morrison-lab.github.io/mds/algebra-sums.html#def-summation).

> **NOTE:**
>
> **Exercise 18 (Expanding a square)** Let $n$ be an integer.
>
> Simplify $(n + 1)^2 - n^2$.

> **NOTE:**
>
> *Solution 18*. The expression simplifies to $2n + 1$, because $(n + 1)^2 = n^2 + 2n + 1$.
>
> Steps like this one make up most of the algebra in [Induction](../chapters/induction.llms.md) proofs. To review algebra, see the free textbook Abramson et al. ([2021](#ref-abramson2021algebra)).

> **NOTE:**
>
> **Exercise 19 (Adding to a fraction)** Let $n$ be an integer.
>
> Write $\dfrac{n(n + 1)}{2} + (n + 1)$ as one fraction whose numerator is factored.

> **NOTE:**
>
> *Solution 19*. The sum is $\dfrac{(n + 1)(n + 2)}{2}$. Write $n + 1$ as $\dfrac{2(n + 1)}{2}$, add the two fractions, and factor out $n + 1$:
>
> $$\frac{n(n + 1) + 2(n + 1)}{2} = \frac{(n + 1)(n + 2)}{2}.$$
>
> This step appears in the [Induction](../chapters/induction.llms.md) chapter. To review algebra, see the free textbook Abramson et al. ([2021](#ref-abramson2021algebra)).

> **NOTE:**
>
> **Exercise 20 (Solving an inequality)** For which integers $n$ is $3n - 7 > n + 5$?

> **NOTE:**
>
> *Solution 20*. The inequality holds for every integer $n > 6$, that is, for $n \ge 7$. Subtracting $n$ from both sides and adding 7 gives $2n > 12$, and dividing both sides by 2 gives $n > 6$.
>
> To review, read [Theorem: Multiplying both sides of an inequality by a positive number](https://morrison-lab.github.io/mds/algebra-basics.html#thm-mult-ineq).

> **NOTE:**
>
> **Exercise 21 (Negating an inequality)** True or false: for all real numbers $a$ and $b$, if $a < b$ then $-a < -b$.

> **NOTE:**
>
> *Solution 21*. The statement is false. Multiplying both sides of an inequality by a negative number reverses it, so $a < b$ gives $-a > -b$. For example, $1 < 2$, but $-1 > -2$.
>
> To review, read [Theorem: Negating both sides of an inequality](https://morrison-lab.github.io/mds/algebra-basics.html#thm-neg-ineq).

# References

Abramson, Jay et al. 2021. *Algebra and Trigonometry*. 2nd ed. OpenStax. <https://openstax.org/books/algebra-and-trigonometry-2e/pages/preface>.

Back to top
