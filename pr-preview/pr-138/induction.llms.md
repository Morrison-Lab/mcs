# Induction and Recursion

Code

Published

Last modified: 2026-11-11 15:55:37 (PST)

> **NOTE:**
>
> *Remark*. A [proof by induction](proof-writing.llms.md#def-proof-by-induction) proves a [proposition](proof-writing.llms.md#def-proposition) about every [integer](number-systems.llms.md#def-integers) from some starting integer on. A [sequence](functions.llms.md#def-sequence) defined by a rule on its earlier [terms](functions.llms.md#def-sequence-term) is the usual place to use it. This page defines such [sequences](functions.llms.md#def-sequence), then adds the stronger form, [strong induction](induction.llms.md#def-strong-induction), that they often need.

# 1 Recursively defined sequences

> **NOTE:**
>
> **Definition 1 (Recursively defined sequence)** Let $n_0$ be an [integer](number-systems.llms.md#def-integers) and $m$ a positive integer. A [sequence](functions.llms.md#def-sequence) $a_{n_0}, a_{n_0 + 1}, \ldots$ is **recursively defined** ([Wikipedia contributors 2026c](#ref-wikipedia_recurrence_relation)) by two things:
>
> 1.  **Initial [terms](functions.llms.md#def-sequence-term):** specific [values](functions.llms.md#def-value) for $a_{n_0}, \ldots, a_{n_0 + m - 1}$.
> 2.  **Recurrence:** a rule that gives $a_n$ from the $m$ entries $a_{n-1}, \ldots, a_{n-m}$ just before it, for every integer $n \ge n_0 + m$.
>
> The initial terms and the recurrence together fix every [term](functions.llms.md#def-sequence-term): the first $m$ entries are given, and each later entry follows from the $m$ entries before it.

> **NOTE:**
>
> **Example 1 (Powers of 3)** The [sequence](functions.llms.md#def-sequence) $a_0, a_1, \ldots$ with initial [term](functions.llms.md#def-sequence-term) $a_0 = 1$ and recurrence $a_n = 3 a_{n-1}$ for $n \ge 1$ has $m = 1$, and its [terms](functions.llms.md#def-sequence-term) are $1, 3, 9, 27, \ldots$ A [proof by induction](proof-writing.llms.md#def-proof-by-induction) shows $a_n = 3^n$ for every [integer](number-systems.llms.md#def-integers) $n \ge 0$, using the recurrence in the inductive step: if $a_{n-1} = 3^{n-1}$, then $a_n = 3 \cdot 3^{n-1} = 3^n$.

> **NOTE:**
>
> **Definition 2 (Fibonacci sequence)** The **Fibonacci sequence** $F_1, F_2, \ldots$ ([Wikipedia contributors 2026a](#ref-wikipedia_fibonacci_sequence)) is the [recursively defined sequence](#def-recursive-sequence) with $m = 2$, initial [terms](functions.llms.md#def-sequence-term) $F_1 = 1$ and $F_2 = 1$, and recurrence $F_n = F_{n-1} + F_{n-2}$ for every [integer](number-systems.llms.md#def-integers) $n \ge 3$.

> **NOTE:**
>
> **Example 2 (The first Fibonacci numbers)** $F_3 = F_2 + F_1 = 1 + 1 = 2$, $F_4 = F_3 + F_2 = 2 + 1 = 3$, $F_5 = F_4 + F_3 = 3 + 2 = 5$, and $F_6 = F_5 + F_4 = 5 + 3 = 8$. So the [sequence](functions.llms.md#def-sequence) begins $1, 1, 2, 3, 5, 8, \ldots$

# 2 Strong induction

> **NOTE:**
>
> **Definition 3 (Proof by strong induction)** Let $n_0$ be an [integer](number-systems.llms.md#def-integers), and let $P(n)$ be a [predicate](proof-writing.llms.md#def-predicate) about the [integers](number-systems.llms.md#def-integers) $n \ge n_0$. A **proof by strong induction** ([Wikipedia contributors 2026b](#ref-wikipedia_mathematical_induction)) on $n$ shows that $P(n)$ holds for every integer $n \ge n_0$ by showing one thing: for every integer $n \ge n_0$, if $P(k)$ holds for every integer $k$ with $n_0 \le k < n$, then $P(n)$ holds.
>
> The assumption that $P(k)$ holds for every integer $k$ with $n_0 \le k < n$ is the **strong induction hypothesis**.
>
> For $n = n_0$ no integer $k$ satisfies $n_0 \le k < n$, so the strong induction hypothesis is [vacuously true](chapters/predicates-quantifiers.llms.md#def-vacuous-truth), and the proof for $n = n_0$ is a [base case](proof-writing.llms.md#def-proof-by-induction). When the proof for $n$ needs particular earlier cases that do not exist for the first few $n$, those few cases are shown separately as further [base cases](proof-writing.llms.md#def-proof-by-induction).

> **NOTE:**
>
> **Example 3 (Every term of the Fibonacci sequence is less than a power of 2)** Let $F_1, F_2, \ldots$ be the [Fibonacci sequence](#def-fibonacci-sequence). To prove $F_n < 2^n$ for every $n \in \mathbb{N}$, let $P(n)$ be the [inequality](proof-writing.llms.md#def-inequality) $F_n < 2^n$ and use [Definition 3](#def-strong-induction) with $n_0 = 1$.
>
> **[Base cases](proof-writing.llms.md#def-proof-by-induction),** $n = 1$ and $n = 2$. The step below uses the two entries $F_{n-1}$ and $F_{n-2}$ before $F_n$, which do not exist for $n = 1$ and $n = 2$, so these two cases are shown directly:
>
> $$\begin{aligned}
> F_1 &= 1 < 2 = 2^1
> && \text{(} 1 < 2 \text{)}
> \\
> F_2 &= 1 < 4 = 2^2.
> && \text{(} 1 < 4 \text{)}
> \end{aligned}$$
>
> **Step of the [strong induction](#def-strong-induction),** $n \ge 3$. Let $n \ge 3$, and suppose $P(k)$ holds for every [integer](number-systems.llms.md#def-integers) $k$ with $1 \le k < n$. Then $k = n - 1$ and $k = n - 2$ both satisfy $1 \le k < n$, so $F_{n-1} < 2^{n-1}$ and $F_{n-2} < 2^{n-2}$. Therefore
>
> $$\begin{aligned}
> F_n
> &= F_{n-1} + F_{n-2}
> && \text{(definition of } F_n \text{, since } n \ge 3 \text{)}
> \\
> &< 2^{n-1} + 2^{n-2}
> && \text{(strong induction hypothesis, twice)}
> \\
> &< 2^{n-1} + 2^{n-1}
> && \text{(} 2^{n-2} < 2^{n-1} \text{)}
> \\
> &= 2 \cdot 2^{n-1}
> && \text{(} a + a = 2a \text{)}
> \\
> &= 2^n,
> && \text{(} 2 \cdot 2^{n-1} = 2^n \text{)}
> \end{aligned}$$
>
> which is $P(n)$. By [Definition 3](#def-strong-induction), $F_n < 2^n$ for every $n \in \mathbb{N}$.

# 3 Further reading

- Velleman ([2019](#ref-velleman2019prove)) is a structured introduction to proof techniques, including [proof by induction](proof-writing.llms.md#def-proof-by-induction).

# Definitions on this page

- [Definition 1 (Recursively defined sequence)](#def-recursive-sequence)
- [Definition 2 (Fibonacci sequence)](#def-fibonacci-sequence)
- [Definition 3 (Proof by strong induction)](#def-strong-induction)

# References

Velleman, Daniel J. 2019. *How to Prove It: A Structured Approach*. 3rd ed. Cambridge University Press. <https://doi.org/10.1017/9781108539890>.

Wikipedia contributors. 2026a. *Fibonacci Sequence — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Fibonacci_sequence>.

Wikipedia contributors. 2026b. *Mathematical Induction — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Mathematical_induction>.

Wikipedia contributors. 2026c. *Recurrence Relation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Recurrence_relation>.

Back to top
