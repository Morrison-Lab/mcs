# Growth Rates

Code

Published

Last modified: 2026-11-11 23:43:35 (PST)

> **NOTE:**
>
> *Remark*. The running time of an [algorithm](expressions-algorithms.llms.md#def-algorithm) is a [function](functions.llms.md#def-function) of the size $n$ of its [input](functions.llms.md#def-argument). To compare running times, we ignore fixed factors and small inputs. This page defines the notation for that comparison.

# 1 Upper bounds

> **NOTE:**
>
> **Definition 1 (Big-O)** Let $f$ and $g$ be [functions](functions.llms.md#def-function) from the [natural numbers](number-systems.llms.md#def-natural-numbers) to the [real numbers](number-systems.llms.md#def-real-numbers). Then $f(n)$ is **big-O** of $g(n)$ ([Wikipedia contributors 2026](#ref-wikipedia_big_o_notation)), written $f(n) = O(g(n))$, when there exist a [real number](number-systems.llms.md#def-real-numbers) $c > 0$ and a [natural number](number-systems.llms.md#def-natural-numbers) $N$ such that, for every natural number $n \ge N$, $$|f(n)| \le c \, |g(n)|.$$ In words, from some point $N$ on, the [absolute value](https://morrison-lab.github.io/mds/algebra.html#def-absolute-value) of $f(n)$ is at most a fixed multiple $c$ of the absolute value of $g(n)$. The “there exist” is an [existential quantifier](proof-writing.llms.md#def-existential-quantifier), and the “for every” is a [universal quantifier](proof-writing.llms.md#def-universal-quantifier).

> **NOTE:**
>
> **Example 1 (The function** $3n + 5$ is big-O of $n$) Let $f(n) = 3n + 5$ and $g(n) = n$. To show $f(n) = O(g(n))$ by [Definition 1](#def-big-o), choose $c = 4$ and $N = 5$. For every [natural number](number-systems.llms.md#def-natural-numbers) $n \ge 5$,
>
> $$\begin{aligned}
> |f(n)|
> &= 3n + 5
> && \text{(} 3n + 5 > 0 \text{)}
> \\
> &\le 3n + n
> && \text{(} 5 \le n \text{, since } n \ge 5 \text{)}
> \\
> &= 4n
> && \text{(} 3n + n = 4n \text{)}
> \\
> &= 4 \, |g(n)|,
> && \text{(} n = |n| \text{, since } n \ge 0 \text{)}
> \end{aligned}$$
>
> which is the [inequality](proof-writing.llms.md#def-inequality) in [Definition 1](#def-big-o) with $c = 4$. Hence $3n + 5 = O(n)$.

# 2 Lower bounds

> **NOTE:**
>
> **Definition 2 (Big-Omega)** Let $f$ and $g$ be [functions](functions.llms.md#def-function) from the [natural numbers](number-systems.llms.md#def-natural-numbers) to the [real numbers](number-systems.llms.md#def-real-numbers). Then $f(n)$ is **big-Omega** of $g(n)$ ([Wikipedia contributors 2026](#ref-wikipedia_big_o_notation)), written $f(n) = \Omega(g(n))$, when there exist a [real number](number-systems.llms.md#def-real-numbers) $c > 0$ and a [natural number](number-systems.llms.md#def-natural-numbers) $N$ such that, for every natural number $n \ge N$, $$|f(n)| \ge c \, |g(n)|.$$ In words, from some point $N$ on, the [absolute value](https://morrison-lab.github.io/mds/algebra.html#def-absolute-value) of $f(n)$ is at least a fixed positive multiple $c$ of the absolute value of $g(n)$. Dividing by $c$ shows that $f(n) = \Omega(g(n))$ exactly when $g(n) = O(f(n))$ in the sense of [Definition 1](#def-big-o).

> **NOTE:**
>
> **Example 2 (The function** $3n + 5$ is big-Omega of $n$) Let $f(n) = 3n + 5$ and $g(n) = n$. To show $f(n) = \Omega(g(n))$ by [Definition 2](#def-big-omega), choose $c = 3$ and $N = 1$. For every [natural number](number-systems.llms.md#def-natural-numbers) $n \ge 1$,
>
> $$\begin{aligned}
> |f(n)|
> &= 3n + 5
> && \text{(} 3n + 5 > 0 \text{)}
> \\
> &\ge 3n
> && \text{(} 5 \ge 0 \text{)}
> \\
> &= 3 \, |g(n)|,
> && \text{(} n = |n| \text{, since } n \ge 0 \text{)}
> \end{aligned}$$
>
> which is the [inequality](proof-writing.llms.md#def-inequality) in [Definition 2](#def-big-omega) with $c = 3$. Hence $3n + 5 = \Omega(n)$.

# 3 Matching bounds

> **NOTE:**
>
> **Definition 3 (Big-Theta)** Let $f$ and $g$ be [functions](functions.llms.md#def-function) from the [natural numbers](number-systems.llms.md#def-natural-numbers) to the [real numbers](number-systems.llms.md#def-real-numbers). Then $f(n)$ is **big-Theta** of $g(n)$ ([Wikipedia contributors 2026](#ref-wikipedia_big_o_notation)), written $f(n) = \Theta(g(n))$, when both $f(n) = O(g(n))$ ([big-O](#def-big-o)) and $f(n) = \Omega(g(n))$ ([big-Omega](#def-big-omega)). In words, $f(n)$ and $g(n)$ are within fixed multiples of each other, from some point on.

> **NOTE:**
>
> **Example 3 (The function** $3n + 5$ is big-Theta of $n$) Let $f(n) = 3n + 5$ and $g(n) = n$. By [Example 1](#exm-big-o), $f(n) = O(n)$, and by [Example 2](#exm-big-omega), $f(n) = \Omega(n)$. Therefore $f(n) = \Theta(n)$ by [Definition 3](#def-big-theta).

# Definitions on this page

- [Definition 1 (Big-O)](#def-big-o)
- [Definition 2 (Big-Omega)](#def-big-omega)
- [Definition 3 (Big-Theta)](#def-big-theta)

# References

Wikipedia contributors. 2026. *Big O Notation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Big_O_notation>.

Back to top
