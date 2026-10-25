# Recurrence Relations and Growth Rates

Code

Solving recurrence relations, running times, and big-O notation

Published

Last modified: 2026-10-24 20:24:13 (PDT)

> **NOTE:**
>
> The topics of this chapter follow the course calendar and Kameron Decker Harris’s Fall 2026 lecture notes, which name recurrence relations and order of growth as the topics after recursive algorithms. One idea comes from those notes: the running time of a recursive function is the running time of its recursive call plus the work outside it.
>
> Everything else is new: the exercises, the examples, the algorithms `pal_loop`, `table` and `pairs`, the Racket functions, the theorems and their proofs. The algorithms `pal` and `root` come from earlier chapters of these notes.

# 1 Recurrence relations

> **NOTE:**
>
> **Exercise 1 (Double and add a power of 2)** A sequence ([Definition: Sequence](https://morrison-lab.github.io/mds/functions.html#def-sequence)) starts with \\b_0 = 0\\, and for every integer ([Definition: Integers](../chapters/direct-proof.llms.md#def-integers)) \\n \ge 1\\ the term \\b_n\\ is twice the term before it, plus \\2^n\\. Find \\b_1\\, \\b_2\\, \\b_3\\, \\b_4\\ and \\b_5\\.

> **NOTE:**
>
> *Solution 1*. Each term comes from the one before it:
>
> \\ \begin{aligned} b_1 &= 2 \cdot 0 + 2^1 = 2, \\ b_2 &= 2 \cdot 2 + 2^2 = 8, \\ b_3 &= 2 \cdot 8 + 2^3 = 24, \\ b_4 &= 2 \cdot 24 + 2^4 = 64, \\ b_5 &= 2 \cdot 64 + 2^5 = 160. \end{aligned} \\

> **NOTE:**
>
> **Definition 1 (Recurrence relation)** A **recurrence relation** ([Wikipedia contributors 2026e](#ref-wikipedia_recurrence_relation)) is the recurrence of a recursively defined sequence ([Definition: Recursively defined sequence](../chapters/induction.llms.md#def-recursive-sequence)), that is, its recursive rule ([Definition: Recursive definition](../chapters/recursion.llms.md#def-recursive-definition)) written as an equation, which gives the term \\a_n\\ in terms of the \\m\\ terms \\a\_{n-1}, \ldots, a\_{n-m}\\ just before it, for every integer \\n \ge n_0 + m\\.

> **NOTE:**
>
> **Example 1 (The sequence \\b_n\\, defined recursively)** The sequence of [Exercise 1](#exr-double-plus-power-terms) is recursively defined ([Definition: Recursively defined sequence](../chapters/induction.llms.md#def-recursive-sequence)) with \\n_0 = 0\\ and \\m = 1\\. Its initial term is \\b_0 = 0\\, and its recurrence relation ([Definition 1](#def-recurrence-relation)) is
>
> \\ b_n = 2 b\_{n-1} + 2^n \quad\text{for every integer } n \ge 1. \\
>
> In Racket, where `(expt 2 n)` is \\2^n\\, the recurrence relation becomes a recursive function:
>
> ``` racket
> (define (b n)
>   (if (= n 0)
>       0
>       (+ (* 2 (b (- n 1))) (expt 2 n))))
> ```
>
> `(b 5)` leads to calls of `(b 4)`, `(b 3)`, `(b 2)`, `(b 1)` and `(b 0)` in turn, and returns 160, as in [Solution 1](#sol-double-plus-power-terms).

> **NOTE:**
>
> **Definition 2 (Closed form)** A **closed form** ([Wikipedia contributors 2026b](#ref-wikipedia_closed_form_expression)) for a sequence \\a\_{n_0}, a\_{n_0 + 1}, \ldots\\ ([Definition: Sequence](https://morrison-lab.github.io/mds/functions.html#def-sequence)) is a formula for \\a_n\\ that uses only \\n\\ and fixed numbers, combined by a fixed number of operations such as addition, multiplication, powers and floors ([Definition: Floor](../chapters/loop-invariants.llms.md#def-floor)), and that uses no other term of the sequence.

> **NOTE:**
>
> **Example 2 (Closed forms and recurrence relations)** The double-minus-one sequence of [Example: The double-minus-one sequence, defined recursively](../chapters/recursion.llms.md#exm-doubling-sequence) has the recurrence relation ([Definition 1](#def-recurrence-relation)) \\a_n = 2 a\_{n-1} - 1\\, which is not a closed form ([Definition 2](#def-closed-form)), since it uses the term \\a\_{n-1}\\. By [Theorem: A formula for the double-minus-one sequence](../chapters/recursion.llms.md#thm-doubling-closed), \\a_n = 2^n + 1\\ is a closed form for the same sequence: it gives \\a\_{50} = 2^{50} + 1\\ without finding \\a_1\\ through \\a\_{49}\\ first. Finding a closed form for a sequence from its recurrence relation is called *solving* the recurrence relation.

# 2 Solving recurrence relations by iteration

> **NOTE:**
>
> **Exercise 2 (Using the recurrence relation three times)** Let \\b_0, b_1, \ldots\\ be the sequence of [Example 1](#exm-double-plus-power-sequence), and let \\n \ge 3\\. Starting from \\b_n = 2 b\_{n-1} + 2^n\\, replace \\b\_{n-1}\\ by \\2 b\_{n-2} + 2^{n-1}\\, and then replace \\b\_{n-2}\\ by \\2 b\_{n-3} + 2^{n-2}\\, to write \\b_n\\ in terms of \\b\_{n-3}\\.

> **NOTE:**
>
> *Solution 2*. Replacing \\b\_{n-1}\\ gives \\b_n\\ in terms of \\b\_{n-2}\\:
>
> \\ \begin{aligned} b_n &= 2 \mathopen{}\left(2 b\_{n-2} + 2^{n-1}\right)\mathclose{} + 2^n \\&= 4 b\_{n-2} + 2^n + 2^n \\&= 4 b\_{n-2} + 2 \cdot 2^n. \end{aligned} \\
>
> Replacing \\b\_{n-2}\\ then gives \\b_n\\ in terms of \\b\_{n-3}\\:
>
> \\ \begin{aligned} b_n &= 4 \mathopen{}\left(2 b\_{n-3} + 2^{n-2}\right)\mathclose{} + 2 \cdot 2^n \\&= 8 b\_{n-3} + 2^n + 2 \cdot 2^n \\&= 8 b\_{n-3} + 3 \cdot 2^n. \end{aligned} \\

> **NOTE:**
>
> **Definition 3 (Iteration (unrolling))** Solving a recurrence relation ([Definition 1](#def-recurrence-relation)) by **iteration**, also called **unrolling**, finds a closed form ([Definition 2](#def-closed-form)) for its sequence in three steps:
>
> 1.  use the recurrence relation again and again to write \\a_n\\ in terms of \\a\_{n-1}\\, then \\a\_{n-2}\\, then \\a\_{n-3}\\, and so on;
> 2.  guess, from the pattern, a formula for \\a_n\\ in terms of \\a\_{n-k}\\ for every number \\k\\ of steps;
> 3.  choose \\k\\ so that \\a\_{n-k}\\ is an initial term, and put in its value.

> **NOTE:**
>
> **Example 3 (Unrolling \\b_n = 2 b\_{n-1} + 2^n\\)** The recurrence relation and [Solution 2](#sol-substitute-once) give the first steps of iteration ([Definition 3](#def-iteration)) for the sequence of [Example 1](#exm-double-plus-power-sequence):
>
> \\ \begin{aligned} b_n &= 2 b\_{n-1} + 1 \cdot 2^n, \\ b_n &= 4 b\_{n-2} + 2 \cdot 2^n, \\ b_n &= 8 b\_{n-3} + 3 \cdot 2^n. \end{aligned} \\
>
> After \\k\\ steps the factor in front of \\b\_{n-k}\\ is \\2^k\\, and the multiple of \\2^n\\ is \\k\\, so the pattern suggests
>
> \\ b_n = 2^k b\_{n-k} + k \cdot 2^n \quad\text{for } k = 1, 2, \ldots, n. \\
>
> The initial term is \\b_0\\, which is \\b\_{n-k}\\ when \\k = n\\. With \\k = n\\ and \\b_0 = 0\\,
>
> \\ \begin{aligned} b_n &= 2^n b_0 + n \cdot 2^n \\&= n \cdot 2^n. \end{aligned} \\
>
> This agrees with [Solution 1](#sol-double-plus-power-terms): for example, \\5 \cdot 2^5 = 160 = b_5\\.

> **NOTE:**
>
> *Remark 1* (Iteration gives a guess). In [Example 3](#exm-double-plus-power-iteration), the formula for general \\k\\ came from the three cases \\k = 1, 2, 3\\. Nothing proved that the pattern continues, so the closed form \\b_n = n \cdot 2^n\\ is still a guess. Induction ([Definition: Proof by induction](../chapters/induction.llms.md#def-proof-by-induction)) turns such a guess into a theorem, with the recurrence relation in the inductive step.

# 3 Checking a closed form by induction

> **NOTE:**
>
> **Exercise 3 (Checking a guess)** A sequence starts with \\e_0 = 1\\, and has the recurrence relation ([Definition 1](#def-recurrence-relation))
>
> \\ e_n = 3 e\_{n-1} + 2^n \quad\text{for every integer } n \ge 1. \\
>
> Someone guesses the closed form ([Definition 2](#def-closed-form)) \\e_n = 3^{n+1} - 2^{n+1}\\. Find \\e_1\\, \\e_2\\ and \\e_3\\ from the recurrence relation, and check the guess for \\n = 0, 1, 2, 3\\.

> **NOTE:**
>
> *Solution 3*. From the recurrence relation, \\e_1 = 3 \cdot 1 + 2 = 5\\, \\e_2 = 3 \cdot 5 + 4 = 19\\ and \\e_3 = 3 \cdot 19 + 8 = 65\\.
>
> |         \\n\\         |  0  |  1  |  2  |  3  |
> |:---------------------:|:---:|:---:|:---:|:---:|
> |        \\e_n\\        |  1  |  5  | 19  | 65  |
> |      \\3^{n+1}\\      |  3  |  9  | 27  | 81  |
> |      \\2^{n+1}\\      |  2  |  4  |  8  | 16  |
> | \\3^{n+1} - 2^{n+1}\\ |  1  |  5  | 19  | 65  |
>
> The guess is right for \\n = 0, 1, 2, 3\\. Four cases do not prove it for every \\n\\.

> **NOTE:**
>
> **Theorem 1 (A closed form for \\b_n = 2 b\_{n-1} + 2^n\\)** Let \\b_0, b_1, \ldots\\ be the sequence with \\b_0 = 0\\ and \\b_n = 2 b\_{n-1} + 2^n\\ for every integer \\n \ge 1\\ ([Example 1](#exm-double-plus-power-sequence)). Then \\b_n = n \cdot 2^n\\ for every non-negative integer ([Definition: Non-negative integers](https://morrison-lab.github.io/mds/number-systems.html#def-nonnegative-integers)) \\n\\.

> **NOTE:**
>
> *Proof*. We use induction ([Definition: Proof by induction](../chapters/induction.llms.md#def-proof-by-induction)), following [Remark: The shape of a proof by induction](../chapters/induction.llms.md#rem-induction-template) with \\n_0 = 0\\. Let \\P(n)\\ be the equation \\b_n = n \cdot 2^n\\.
>
> **Base case.** \\b_0 = 0 = 0 \cdot 2^0\\.
>
> **Inductive step.** Let \\k \ge 0\\ be an integer, and suppose \\P(k)\\: \\b_k = k \cdot 2^k\\. The goal \\P(k + 1)\\ is \\b\_{k + 1} = (k + 1) \cdot 2^{k + 1}\\. Since \\k + 1 \ge 1\\, the recurrence relation gives \\b\_{k + 1}\\, and
>
> \\ \begin{aligned} b\_{k + 1} &= 2 b_k + 2^{k + 1} && \text{(recurrence relation)} \\&= 2 \cdot k \cdot 2^k + 2^{k + 1} && \text{(induction hypothesis)} \\&= k \cdot 2^{k + 1} + 2^{k + 1} \\&= (k + 1) \cdot 2^{k + 1}. \end{aligned} \\
>
> So \\P(k + 1)\\ holds, and by induction \\b_n = n \cdot 2^n\\ for every non-negative integer \\n\\.

> **NOTE:**
>
> **Theorem 2 (A closed form for \\e_n = 3 e\_{n-1} + 2^n\\)** Let \\e_0, e_1, \ldots\\ be the sequence with \\e_0 = 1\\ and \\e_n = 3 e\_{n-1} + 2^n\\ for every integer \\n \ge 1\\. Then \\e_n = 3^{n+1} - 2^{n+1}\\, as guessed in [Exercise 3](#exr-triple-plus-power-check), for every non-negative integer ([Definition: Non-negative integers](https://morrison-lab.github.io/mds/number-systems.html#def-nonnegative-integers)) \\n\\.

> **NOTE:**
>
> *Proof*. We use induction ([Definition: Proof by induction](../chapters/induction.llms.md#def-proof-by-induction)), following [Remark: The shape of a proof by induction](../chapters/induction.llms.md#rem-induction-template) with \\n_0 = 0\\. Let \\P(n)\\ be the equation \\e_n = 3^{n+1} - 2^{n+1}\\.
>
> **Base case.** \\e_0 = 1 = 3 - 2 = 3^1 - 2^1\\.
>
> **Inductive step.** Let \\k \ge 0\\ be an integer, and suppose \\P(k)\\: \\e_k = 3^{k+1} - 2^{k+1}\\. The goal \\P(k + 1)\\ is \\e\_{k + 1} = 3^{k+2} - 2^{k+2}\\. Since \\k + 1 \ge 1\\, the recurrence relation gives \\e\_{k + 1}\\, and
>
> \\ \begin{aligned} e\_{k + 1} &= 3 e_k + 2^{k + 1} && \text{(recurrence relation)} \\&= 3 \mathopen{}\left(3^{k+1} - 2^{k+1}\right)\mathclose{} + 2^{k + 1} && \text{(induction hypothesis)} \\&= 3^{k+2} - 3 \cdot 2^{k+1} + 2^{k + 1} \\&= 3^{k+2} - 2 \cdot 2^{k+1} \\&= 3^{k+2} - 2^{k+2}. \end{aligned} \\
>
> So \\P(k + 1)\\ holds, and by induction \\e_n = 3^{n+1} - 2^{n+1}\\ for every non-negative integer \\n\\.

> **NOTE:**
>
> **Example 4 (A guess that fails)** The sequence of [Exercise 3](#exr-triple-plus-power-check) starts \\e_0 = 1\\, \\e_1 = 5\\, which are \\5^0\\ and \\5^1\\. So one might guess \\e_n = 5^n\\. The guess fails at \\n = 2\\, since \\e_2 = 19\\ and \\5^2 = 25\\.
>
> An attempt to prove the guess by induction ([Definition: Proof by induction](../chapters/induction.llms.md#def-proof-by-induction)) shows where it goes wrong. Supposing \\e_k = 5^k\\, the recurrence relation gives
>
> \\ \begin{aligned} e\_{k + 1} &= 3 e_k + 2^{k + 1} \\&= 3 \cdot 5^k + 2^{k + 1}, \end{aligned} \\
>
> and the inductive step needs this to equal \\5^{k + 1} = 5 \cdot 5^k\\, which happens only when \\2^{k + 1} = 2 \cdot 5^k\\, that is, only when \\k = 0\\.

> **NOTE:**
>
> *Remark 2* (Finding a closed form, then proving it). Iteration ([Definition 3](#def-iteration)) and checking small cases, as in [Exercise 3](#exr-triple-plus-power-check), find a closed form ([Definition 2](#def-closed-form)) to try. Induction proves it, as in [Theorem 1](#thm-double-plus-power-closed) and [Theorem 2](#thm-triple-plus-power-closed), or shows that it is wrong, as in [Example 4](#exm-wrong-guess). A proof by induction needs the closed form before it starts: it can check a formula, but it cannot find one.

# 4 Running times of recursive algorithms

> **NOTE:**
>
> **Exercise 4 (How many calls does `pal` make?)** Let `pal` be the algorithm of [Exercise: Is it a palindrome?](../chapters/recursion.llms.md#exr-palindrome-trace). How many calls of `pal`, including the first, does `pal(abbaabba)` make?

> **NOTE:**
>
> *Solution 4*. `pal(abbaabba)` calls `pal(bbaabb)`, which calls `pal(baab)`, which calls `pal(aa)`, which calls `pal` on the empty string, which returns true. That is 5 calls, on strings of 8, 6, 4, 2 and 0 symbols: each call removes the first and last symbols.

> **NOTE:**
>
> *Remark 3* (The size of an input and a step). To count the work an algorithm ([Definition: Algorithm](https://morrison-lab.github.io/mds/expressions-algorithms.html#def-algorithm)) does, we first fix two things:
>
> - the *size* of an input, such as the number of symbols in a string or the number of entries in an array;
> - what one *step* is, such as one comparison, one arithmetic operation or one call of a function.

> **NOTE:**
>
> **Definition 4 (Running time)** Fix, for an algorithm ([Definition: Algorithm](https://morrison-lab.github.io/mds/expressions-algorithms.html#def-algorithm)), the size of an input and what one step is ([Remark 3](#rem-size-step)). The **running time** ([Wikipedia contributors 2026f](#ref-wikipedia_time_complexity)) of the algorithm is the function \\T\\ ([Definition: Function (map, mapping, transformation)](https://morrison-lab.github.io/mds/functions.html#def-function)) whose value \\T(n)\\ is the largest number of steps that the algorithm takes on any input of size \\n\\.

> **NOTE:**
>
> **Example 5 (The running time of `pal`)** Take the size ([Remark 3](#rem-size-step)) of the input of `pal` ([Exercise: Is it a palindrome?](../chapters/recursion.llms.md#exr-palindrome-trace)) to be the number \\n\\ of symbols in the string, and count each call of `pal` as one step, since apart from its recursive call each call does at most two comparisons. This assumes that the call on `s[2..n-1]` passes the shorter string as a pair of positions in `s`, which takes a fixed number of operations; copying its \\n - 2\\ symbols into a new string would add about \\n\\ steps to every call. Let \\T(n)\\ be the running time ([Definition 4](#def-running-time)). The running time of a call is the running time of its recursive call plus the work outside it.
>
> - When \\n \le 1\\, `pal` returns without calling itself, so \\T(0) = T(1) = 1\\.
> - When \\n \ge 2\\, the call that takes longest is one whose first and last symbols match, since otherwise `pal` returns at once. It calls `pal` on a string of \\n - 2\\ symbols, which can be any such string, so \\T(n) = T(n - 2) + 1\\.
>
> Iteration ([Definition 3](#def-iteration)) gives
>
> \\ \begin{aligned} T(n) &= T(n - 2) + 1 \\&= T(n - 4) + 2 \\&= T(n - 6) + 3, \end{aligned} \\
>
> and in general \\T(n) = T(n - 2k) + k\\, as long as \\n - 2k \ge 0\\. To reach an initial term, take \\k = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{}\\ ([Definition: Floor](../chapters/loop-invariants.llms.md#def-floor)): then \\n - 2k\\ is 0 when \\n\\ is even and 1 when \\n\\ is odd, and either way \\T(n - 2k) = 1\\. So the guess is
>
> \\ T(n) = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} + 1, \\
>
> which gives \\T(8) = 5\\, as in [Solution 4](#sol-pal-calls). [Theorem 3](#thm-pal-running-time) proves it.

> **NOTE:**
>
> **Theorem 3 (A closed form for the running time of `pal`)** Let \\T(0) = T(1) = 1\\ and \\T(n) = T(n - 2) + 1\\ for every integer \\n \ge 2\\, as in [Example 5](#exm-pal-running-time). Then \\T(n) = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} + 1\\ ([Definition: Floor](../chapters/loop-invariants.llms.md#def-floor)) for every non-negative integer ([Definition: Non-negative integers](https://morrison-lab.github.io/mds/number-systems.html#def-nonnegative-integers)) \\n\\.

> **NOTE:**
>
> *Proof*. The recurrence relation uses \\T(n - 2)\\, not \\T(n - 1)\\, so we use strong induction ([Definition: Proof by strong induction](../chapters/induction.llms.md#def-strong-induction)). Let \\n \ge 0\\ be an integer, and suppose \\T(m) = \mathopen{}\left\lfloor m / 2\right\rfloor\mathclose{} + 1\\ for every integer \\m\\ with \\0 \le m \< n\\.
>
> If \\n \le 1\\, then \\T(n) = 1 = 0 + 1 = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} + 1\\.
>
> If \\n \ge 2\\, then \\0 \le n - 2 \< n\\, and \\\mathopen{}\left\lfloor(n - 2) / 2\right\rfloor\mathclose{} = \mathopen{}\left\lfloor n / 2 - 1\right\rfloor\mathclose{} = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} - 1\\, since subtracting the integer 1 from a real number subtracts 1 from its floor. So
>
> \\ \begin{aligned} T(n) &= T(n - 2) + 1 && \text{(recurrence relation)} \\&= \mathopen{}\left\lfloor(n - 2) / 2\right\rfloor\mathclose{} + 1 + 1 && \text{(strong induction hypothesis)} \\&= \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} - 1 + 2 \\&= \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} + 1. \end{aligned} \\
>
> So the formula holds for \\n\\, and by strong induction it holds for every non-negative integer \\n\\.

# 5 Two recursive calls

> **NOTE:**
>
> **Exercise 5 (A function that calls itself twice)** This Racket function computes the double-minus-one sequence of [Example: The double-minus-one sequence, defined recursively](../chapters/recursion.llms.md#exm-doubling-sequence), but it finds \\2 a\_{n-1}\\ as \\a\_{n-1} + a\_{n-1}\\, with two recursive calls:
>
> ``` racket
> (define (dm n)
>   (if (= n 0)
>       2
>       (- (+ (dm (- n 1)) (dm (- n 1))) 1)))
> ```
>
> Write down every call of `dm` that running `(dm 2)` involves, counting `(dm 2)` itself, and the value that each call returns.

> **NOTE:**
>
> *Solution 5*. `(dm 2)` calls `(dm 1)` twice, and each of those calls `(dm 0)` twice:
>
> ``` text
> (dm 2)
>   (dm 1)
>     (dm 0)  returns 2
>     (dm 0)  returns 2
>   returns 2 + 2 - 1 = 3
>   (dm 1)
>     (dm 0)  returns 2
>     (dm 0)  returns 2
>   returns 2 + 2 - 1 = 3
> returns 3 + 3 - 1 = 5
> ```
>
> That is 7 calls, counting `(dm 2)` itself, and 4 of them are calls of `(dm 0)`. `(dm 2)` returns 5, which is \\a_2\\. The two calls of `(dm 1)` do exactly the same work.

> **NOTE:**
>
> **Theorem 4 (Two calls of size \\n - 1\\ give \\2^n\\ base cases)** For every non-negative integer ([Definition: Non-negative integers](https://morrison-lab.github.io/mds/number-systems.html#def-nonnegative-integers)) \\n\\, the calls that `(dm n)` of [Exercise 5](#exr-twice-calls) makes include exactly \\2^n\\ calls of `(dm 0)`, counting `(dm 0)` itself when \\n = 0\\. So, counting each call as one step, the running time ([Definition 4](#def-running-time)) of `dm` satisfies \\T(n) \ge 2^n\\.

> **NOTE:**
>
> *Proof*. Let \\B(n)\\ be the number of calls of `(dm 0)` among the calls that `(dm n)` makes. Every call of `(dm n)` does the same work, so \\B(n)\\ depends only on \\n\\. When \\n \ge 1\\, `(dm n)` is not itself a call of `(dm 0)`, and it calls `(dm (- n 1))` twice, as in [Solution 5](#sol-twice-calls), so
>
> \\ B(0) = 1, \qquad B(n) = 2 B(n - 1) \quad\text{for } n \ge 1. \\
>
> We use induction ([Definition: Proof by induction](../chapters/induction.llms.md#def-proof-by-induction)), following [Remark: The shape of a proof by induction](../chapters/induction.llms.md#rem-induction-template) with \\n_0 = 0\\, with \\P(n)\\ the equation \\B(n) = 2^n\\.
>
> **Base case.** \\B(0) = 1 = 2^0\\.
>
> **Inductive step.** Let \\k \ge 0\\ be an integer, and suppose \\B(k) = 2^k\\. Then \\B(k + 1) = 2 B(k) = 2 \cdot 2^k = 2^{k + 1}\\.
>
> So \\B(n) = 2^n\\ for every non-negative integer \\n\\. Each of these calls is a step, so `(dm n)` takes at least \\2^n\\ steps.

> **NOTE:**
>
> *Remark 4* (One call instead of two). The function `dm` of [Exercise 5](#exr-twice-calls) finds the same value \\a\_{n-1}\\ twice. Writing the recursive rule of [Example: The double-minus-one sequence, defined recursively](../chapters/recursion.llms.md#exm-doubling-sequence) directly, with one recursive call,
>
> ``` racket
> (define (dm1 n)
>   (if (= n 0)
>       2
>       (- (* 2 (dm1 (- n 1))) 1)))
> ```
>
> returns the same values, but each call of `dm1` makes only one recursive call, so its calls form a single chain instead of a tree that doubles at every level. By [Theorem 4](#thm-twice-base-calls), `(dm 30)` makes more than a billion calls, since \\2^{30} = 1073741824\\.

# 6 Asymptotic notation

> **NOTE:**
>
> **Exercise 6 (Which running time is better?)** One algorithm takes \\100 n\\ steps on an input of size \\n\\, and another takes \\n^2\\ steps. Compare \\100 n\\ with \\n^2\\ for \\n = 10, 50, 100, 200, 1000\\. Which algorithm takes fewer steps on small inputs, and which on large ones?

> **NOTE:**
>
> *Solution 6*.
>
> |   \\n\\   |  10  |  50  |  100  |  200  |  1000   |
> |:---------:|:----:|:----:|:-----:|:-----:|:-------:|
> | \\100 n\\ | 1000 | 5000 | 10000 | 20000 | 100000  |
> |  \\n^2\\  | 100  | 2500 | 10000 | 40000 | 1000000 |
>
> The second algorithm takes fewer steps when \\n \< 100\\, and the two take the same number at \\n = 100\\. For every \\n \> 100\\, \\n^2 = n \cdot n \> 100 n\\, so the first algorithm takes fewer steps, and the ratio \\n^2 / (100 n) = n / 100\\ grows without bound. The factor 100 decides which is better on small inputs; the powers \\n\\ and \\n^2\\ decide which is better on large ones.

> **NOTE:**
>
> **Definition 5 (Big-O)** Let \\f\\ and \\g\\ be [functions](https://morrison-lab.github.io/mds/functions.html#def-function) from the [natural numbers](../chapters/sets.llms.md#def-natural-numbers) to the [real numbers](../chapters/sets.llms.md#def-real-numbers). Then \\f(n)\\ is **big-O** of \\g(n)\\ ([Wikipedia contributors 2026a](#ref-wikipedia_big_o_notation)), written \\f(n) = O(g(n))\\, when there exist a [real number](../chapters/sets.llms.md#def-real-numbers) \\c \> 0\\ and a [natural number](../chapters/sets.llms.md#def-natural-numbers) \\N\\ such that, for every natural number \\n \ge N\\, \\ \|f(n)\| \le c \\ \|g(n)\|. \\ In words, from some point \\N\\ on, the [absolute value](https://morrison-lab.github.io/mds/algebra-basics.html#def-absolute-value) of \\f(n)\\ is at most a fixed multiple \\c\\ of the absolute value of \\g(n)\\. The “there exist” is an [existential quantifier](../chapters/predicates-quantifiers.llms.md#def-existential-quantifier), and the “for every” is a [universal quantifier](../chapters/predicates-quantifiers.llms.md#def-universal-quantifier).

> **NOTE:**
>
> **Definition 6 (Witnesses)** A real number \\c \> 0\\ and a natural number \\N\\ for which the inequality in [Definition 5](#def-big-o) holds for every natural number ([Definition: Natural numbers (our convention)](../chapters/sets.llms.md#def-natural-numbers)) \\n \ge N\\ are a pair of **witnesses** for \\f(n) = O(g(n))\\. Witnesses for \\f(n) = \Omega(g(n))\\ are defined in the same way, from [Definition 7](#def-big-omega). Some books write \\n_0\\ for \\N\\.

> **NOTE:**
>
> **Example 6 (The running time of `pal` is \\O(n)\\)** By [Example 5](#exm-pal-running-time), `pal` takes \\T(n) = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} + 1\\ steps on a string of \\n\\ symbols. For every natural number \\n \ge 2\\,
>
> \\ \begin{aligned} \mathopen{}\left\|T(n)\right\|\mathclose{} &= \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} + 1 && \text{(} T(n) \> 0 \text{)} \\&\le n / 2 + 1 && \text{(definition of the floor)} \\&\le n / 2 + n / 2 && \text{(} 1 \le n / 2 \text{, since } n \ge 2 \text{)} \\&= n, \end{aligned} \\
>
> so \\c = 1\\ and \\N = 2\\ are witnesses ([Definition 6](#def-witness)) for \\T(n) = O(n)\\ ([Definition 5](#def-big-o)). At \\n = 1\\, also \\T(1) = 1 \le 1\\, so \\c = 1\\ and \\N = 1\\ are witnesses too. Witnesses are not unique: any larger \\c\\ or \\N\\ works as well.

> **NOTE:**
>
> **Example 7 (Finding witnesses for \\2 n^3 + 40 = O(n^3)\\)** To prove \\2 n^3 + 40 = O(n^3)\\ ([Definition 5](#def-big-o)), we look for witnesses ([Definition 6](#def-witness)) \\c\\ and \\N\\. Since \\2 n^3 + 40 \> 2 n^3\\, the term \\2 n^3\\ needs \\c \> 2\\. With \\c = 3\\, the inequality \\2 n^3 + 40 \le 3 n^3\\ is the same as \\40 \le n^3\\, which holds when \\n \ge 4\\, since \\4^3 = 64\\, but not when \\n = 3\\, since \\3^3 = 27\\. So for every natural number \\n \ge 4\\,
>
> \\ \begin{aligned} \mathopen{}\left\|2 n^3 + 40\right\|\mathclose{} &= 2 n^3 + 40 && \text{(} 2 n^3 + 40 \> 0 \text{)} \\&\le 2 n^3 + n^3 && \text{(} 40 \le 64 \le n^3 \text{, since } n \ge 4 \text{)} \\&= 3 \mathopen{}\left\|n^3\right\|\mathclose{}, \end{aligned} \\
>
> and \\c = 3\\, \\N = 4\\ are witnesses. A larger \\c\\ allows a smaller \\N\\: since \\40 \le 40 n^3\\ for every \\n \ge 1\\, the pair \\c = 42\\, \\N = 1\\ also works.

> **NOTE:**
>
> **Definition 7 (Big-Omega)** Let \\f\\ and \\g\\ be [functions](https://morrison-lab.github.io/mds/functions.html#def-function) from the [natural numbers](../chapters/sets.llms.md#def-natural-numbers) to the [real numbers](../chapters/sets.llms.md#def-real-numbers). Then \\f(n)\\ is **big-Omega** of \\g(n)\\ ([Wikipedia contributors 2026a](#ref-wikipedia_big_o_notation)), written \\f(n) = \Omega(g(n))\\, when there exist a [real number](../chapters/sets.llms.md#def-real-numbers) \\c \> 0\\ and a [natural number](../chapters/sets.llms.md#def-natural-numbers) \\N\\ such that, for every natural number \\n \ge N\\, \\ \|f(n)\| \ge c \\ \|g(n)\|. \\ In words, from some point \\N\\ on, the [absolute value](https://morrison-lab.github.io/mds/algebra-basics.html#def-absolute-value) of \\f(n)\\ is at least a fixed positive multiple \\c\\ of the absolute value of \\g(n)\\. Dividing by \\c\\ shows that \\f(n) = \Omega(g(n))\\ exactly when \\g(n) = O(f(n))\\ in the sense of [Definition 5](#def-big-o).

> **NOTE:**
>
> **Example 8 (\\2 n^3 + 40 = \Omega(n^3)\\)** For every natural number \\n \ge 1\\,
>
> \\ \begin{aligned} \mathopen{}\left\|2 n^3 + 40\right\|\mathclose{} &= 2 n^3 + 40 && \text{(} 2 n^3 + 40 \> 0 \text{)} \\&\ge 2 n^3 && \text{(} 40 \ge 0 \text{)} \\&= 2 \mathopen{}\left\|n^3\right\|\mathclose{}, \end{aligned} \\
>
> so \\c = 2\\ and \\N = 1\\ are witnesses ([Definition 6](#def-witness)) for \\2 n^3 + 40 = \Omega(n^3)\\ ([Definition 7](#def-big-omega)).

> **NOTE:**
>
> **Definition 8 (Big-Theta)** Let \\f\\ and \\g\\ be [functions](https://morrison-lab.github.io/mds/functions.html#def-function) from the [natural numbers](../chapters/sets.llms.md#def-natural-numbers) to the [real numbers](../chapters/sets.llms.md#def-real-numbers). Then \\f(n)\\ is **big-Theta** of \\g(n)\\ ([Wikipedia contributors 2026a](#ref-wikipedia_big_o_notation)), written \\f(n) = \Theta(g(n))\\, when both \\f(n) = O(g(n))\\ ([big-O](#def-big-o)) and \\f(n) = \Omega(g(n))\\ ([big-Omega](#def-big-omega)). In words, \\f(n)\\ and \\g(n)\\ are within fixed multiples of each other, from some point on.

> **NOTE:**
>
> **Example 9 (\\2 n^3 + 40 = \Theta(n^3)\\)** By [Example 7](#exm-cubic-big-o), \\2 n^3 + 40 = O(n^3)\\, and by [Example 8](#exm-cubic-big-omega), \\2 n^3 + 40 = \Omega(n^3)\\. So \\2 n^3 + 40 = \Theta(n^3)\\ by [Definition 8](#def-big-theta). The constant 40 and the factor 2 do not change how fast \\2 n^3 + 40\\ grows.

> **NOTE:**
>
> **Theorem 5 (Sums of big-O functions)** Let \\f\\, \\g\\ and \\h\\ be functions ([Definition: Function (map, mapping, transformation)](https://morrison-lab.github.io/mds/functions.html#def-function)) from the natural numbers ([Definition: Natural numbers (our convention)](../chapters/sets.llms.md#def-natural-numbers)) to the real numbers ([Definition: Real numbers](../chapters/sets.llms.md#def-real-numbers)). If \\f(n) = O(h(n))\\ and \\g(n) = O(h(n))\\ ([Definition 5](#def-big-o)), then \\f(n) + g(n) = O(h(n))\\.

> **NOTE:**
>
> *Proof*. Let \\c_1\\, \\N_1\\ be witnesses ([Definition 6](#def-witness)) for \\f(n) = O(h(n))\\, and \\c_2\\, \\N_2\\ witnesses for \\g(n) = O(h(n))\\. Let \\N\\ be the larger of \\N_1\\ and \\N_2\\. The triangle inequality ([Wikipedia contributors 2026g](#ref-wikipedia_triangle_inequality)) says that \\\mathopen{}\left\|x + y\right\|\mathclose{} \le \mathopen{}\left\|x\right\|\mathclose{} + \mathopen{}\left\|y\right\|\mathclose{}\\ for all real numbers \\x\\ and \\y\\. For every natural number \\n \ge N\\, both \\n \ge N_1\\ and \\n \ge N_2\\ hold, so
>
> \\ \begin{aligned} \mathopen{}\left\|f(n) + g(n)\right\|\mathclose{} &\le \mathopen{}\left\|f(n)\right\|\mathclose{} + \mathopen{}\left\|g(n)\right\|\mathclose{} && \text{(triangle inequality)} \\&\le c_1 \mathopen{}\left\|h(n)\right\|\mathclose{} + c_2 \mathopen{}\left\|h(n)\right\|\mathclose{} && \text{(} n \ge N_1 \text{ and } n \ge N_2 \text{)} \\&= (c_1 + c_2) \mathopen{}\left\|h(n)\right\|\mathclose{}. \end{aligned} \\
>
> So \\c_1 + c_2\\ and \\N\\ are witnesses for \\f(n) + g(n) = O(h(n))\\.

# 7 Disproving a bound

> **NOTE:**
>
> **Exercise 7 (Is \\n \cdot 2^n\\ big-O of \\2^n\\?)** By [Theorem 1](#thm-double-plus-power-closed), the sequence of [Example 1](#exm-double-plus-power-sequence) has \\b_n = n \cdot 2^n\\. Show that \\n \cdot 2^n = O(2^n)\\ ([Definition 5](#def-big-o)) is false.

> **NOTE:**
>
> *Solution 7*. We use proof by contradiction ([Definition: Proof by contradiction](../chapters/contrapositive-contradiction.llms.md#def-proof-by-contradiction)). Suppose \\n \cdot 2^n = O(2^n)\\, with witnesses ([Definition 6](#def-witness)) \\c \> 0\\ and \\N\\. Then \\n \cdot 2^n \le c \cdot 2^n\\ for every natural number \\n \ge N\\, and dividing by \\2^n \> 0\\ gives \\n \le c\\ for every natural number \\n \ge N\\.
>
> Let \\n = N + \mathopen{}\left\lfloor c\right\rfloor\mathclose{} + 1\\, where \\\mathopen{}\left\lfloor c\right\rfloor\mathclose{}\\ is the floor ([Definition: Floor](../chapters/loop-invariants.llms.md#def-floor)) of \\c\\. Then \\n\\ is a natural number with \\n \ge N\\, so \\n \le c\\. But \\\mathopen{}\left\lfloor c\right\rfloor\mathclose{} + 1 \> c\\ by the definition of the floor, and \\N \ge 1\\, so \\n \> c\\. This is a contradiction, so \\n \cdot 2^n = O(2^n)\\ is false.

> **NOTE:**
>
> *Remark 5* (How to disprove a big-O bound). The statement \\f(n) = O(g(n))\\ ([Definition 5](#def-big-o)) says that there exist \\c \> 0\\ and \\N\\ such that every \\n \ge N\\ has \\\mathopen{}\left\|f(n)\right\|\mathclose{} \le c \mathopen{}\left\|g(n)\right\|\mathclose{}\\. Its negation says that for every \\c \> 0\\ and every \\N\\, some natural number \\n \ge N\\ has \\\mathopen{}\left\|f(n)\right\|\mathclose{} \> c \mathopen{}\left\|g(n)\right\|\mathclose{}\\, by the rules for negating the existential ([Definition: Existential quantifier](../chapters/predicates-quantifiers.llms.md#def-existential-quantifier)) and universal ([Definition: Universal quantifier](../chapters/predicates-quantifiers.llms.md#def-universal-quantifier)) quantifiers. So a disproof cannot pick \\c\\ and \\N\\: like [Solution 7](#sol-not-big-o), it takes any \\c\\ and \\N\\ and finds such an \\n\\, which depends on \\c\\ and \\N\\. Checking that the inequality fails for a few chosen \\c\\ and \\N\\ is not a disproof.

# 8 Common growth rates

> **NOTE:**
>
> **Exercise 8 (Seven functions at \\n = 16\\)** Here \\\log_2 n\\ is the power to which 2 must be raised to give \\n\\, so \\\log_2 16 = 4\\ since \\2^4 = 16\\, and \\n!\\ is the product \\1 \cdot 2 \cdots n\\. Find the values at \\n = 16\\ of
>
> - \\1\\,
> - \\\log_2 n\\,
> - \\n\\,
> - \\n \log_2 n\\,
> - \\n^2\\,
> - \\2^n\\,
> - \\n!\\,
>
> and put the values in increasing order.

> **NOTE:**
>
> *Solution 8*.
>
> | \\1\\ | \\\log_2 n\\ | \\n\\ | \\n \log_2 n\\ | \\n^2\\ | \\2^n\\ |     \\n!\\     |
> |:-----:|:------------:|:-----:|:--------------:|:-------:|:-------:|:--------------:|
> |   1   |      4       |  16   |       64       |   256   |  65536  | 20922789888000 |
>
> The values are already in increasing order. For \\n!\\, \\1 \cdot 2 \cdots 16 = 20922789888000\\, about \\2 \times 10^{13}\\.

> **NOTE:**
>
> **Definition 9 (Logarithm)** Let \\b \> 1\\ be a real number ([Definition: Real numbers](../chapters/sets.llms.md#def-real-numbers)). For every real number \\x \> 0\\, the **logarithm** of \\x\\ to the base \\b\\ ([Wikipedia contributors 2026d](#ref-wikipedia_logarithm)), written \\\log_b x\\, is the real number \\y\\ with \\b^y = x\\ ([Definition: Power with a real exponent](https://morrison-lab.github.io/mds/algebra-exponentials.html#def-real-power)).

> **NOTE:**
>
> **Example 10 (Some logarithms)** By [Definition 9](#def-logarithm),
>
> - \\\log_2 16 = 4\\, since \\2^4 = 16\\;
> - \\\log_2 1 = 0\\, since \\2^0 = 1\\;
> - \\\log\_{10} 1000 = 3\\, since \\10^3 = 1000\\;
> - \\\log_2 2^n = n\\ for every integer \\n\\.
>
> The logarithm \\\log_2 n\\ grows by 1 each time \\n\\ doubles: \\\log_2 (2 n) = \log_2 n + 1\\, since \\2^{\log_2 n + 1} = 2 \cdot 2^{\log_2 n} = 2 n\\.

> **NOTE:**
>
> *Remark 6* (The base of a logarithm is a constant factor). For every real number \\x \> 0\\, let \\y = \log\_{10} x\\ ([Definition 9](#def-logarithm)). Then \\x = 10^y = \mathopen{}\left(2^{\log_2 10}\right)\mathclose{}^y = 2^{y \log_2 10}\\, so \\\log_2 x = \log_2 10 \cdot \log\_{10} x\\. The factor \\\log_2 10\\, about 3.32, does not depend on \\x\\, so \\\log_2 n = \Theta(\log\_{10} n)\\ ([Definition 8](#def-big-theta)), with \\c = \log_2 10\\ and \\N = 1\\ as witnesses ([Definition 6](#def-witness)) for both the big-O and the big-Omega bound. For this reason big-O bounds often write \\\log n\\ without a base.

> **NOTE:**
>
> **Definition 10 (Factorial)** For a natural number ([Definition: Natural numbers (our convention)](../chapters/sets.llms.md#def-natural-numbers)) \\n\\, the **factorial** of \\n\\ ([Wikipedia contributors 2026c](#ref-wikipedia_factorial)), written \\n!\\, is the product \\1 \cdot 2 \cdots n\\ of the natural numbers from 1 to \\n\\.

> **NOTE:**
>
> **Example 11 (Some factorials)** By [Definition 10](#def-factorial), \\1! = 1\\, \\3! = 1 \cdot 2 \cdot 3 = 6\\ and \\5! = 1 \cdot 2 \cdot 3 \cdot 4 \cdot 5 = 120\\. The number of orders in which 5 different books can stand on a shelf is \\5! = 120\\: 5 choices for the first, then 4 for the second, and so on.

> **NOTE:**
>
> **Theorem 6 (A chain of growth rates)** For every natural number ([Definition: Natural numbers (our convention)](../chapters/sets.llms.md#def-natural-numbers)) \\n \ge 4\\,
>
> \\ 1 \le \log_2 n \< n \le n \log_2 n \< n^2 \le 2^n \le n!, \\
>
> where \\\log_2\\ is the logarithm to the base 2 ([Definition 9](#def-logarithm)) and \\n!\\ is the factorial ([Definition 10](#def-factorial)).

> **NOTE:**
>
> *Proof*. We use that \\2^y \< 2^z\\ for real numbers \\y \< z\\. Let \\n \ge 4\\ be a natural number, and let \\y = \log_2 n\\, so that \\2^y = n\\.
>
> **\\1 \le \log_2 n\\.** If \\y \< 1\\, then \\n = 2^y \< 2^1 = 2\\, which is false.
>
> **\\\log_2 n \< n\\.** First, \\m \< 2^m\\ for every natural number \\m\\, by induction ([Definition: Proof by induction](../chapters/induction.llms.md#def-proof-by-induction)).
>
> **Base case.** \\1 \< 2 = 2^1\\.
>
> **Inductive step.** If \\k \< 2^k\\ for an integer \\k \ge 1\\, then \\k + 1 \le 2^k \< 2^k + 2^k = 2^{k + 1}\\.
>
> So \\n \< 2^n\\. If \\y \ge n\\, then \\n = 2^y \ge 2^n\\, which is false.
>
> **\\n \le n \log_2 n\\ and \\n \log_2 n \< n^2\\.** Multiply \\1 \le \log_2 n \< n\\ by \\n \> 0\\.
>
> **\\n^2 \le 2^n\\.** This is [Example: An induction that starts at 4](../chapters/induction.llms.md#exm-squares-powers), since \\n \ge 4\\.
>
> **\\2^n \le n!\\.** By induction, following [Remark: The shape of a proof by induction](../chapters/induction.llms.md#rem-induction-template) with \\n_0 = 4\\.
>
> **Base case.** \\2^4 = 16 \le 24 = 4!\\.
>
> **Inductive step.** If \\2^k \le k!\\ for an integer \\k \ge 4\\, then
>
> \\ \begin{aligned} 2^{k + 1} &= 2 \cdot 2^k \\&\le 2 \cdot k! && \text{(induction hypothesis)} \\&\< (k + 1) \cdot k! && \text{(} 2 \< k + 1 \text{)} \\&= (k + 1)!. \end{aligned} \\

> **NOTE:**
>
> *Remark 7* (The common growth rates). By [Theorem 6](#thm-growth-chain), each function in the chain
>
> \\ 1, \quad \log_2 n, \quad n, \quad n \log_2 n, \quad n^2, \quad 2^n, \quad n! \\
>
> is big-O ([Definition 5](#def-big-o)) of the next, with witnesses ([Definition 6](#def-witness)) \\c = 1\\ and \\N = 4\\. In the other direction, none is big-O of the one before it. [Solution 7](#sol-not-big-o) shows how to prove such a statement for \\n \cdot 2^n\\ and \\2^n\\, and the same argument, dividing by \\n\\ instead of \\2^n\\, shows that \\n^2 = O(n)\\ is false. A running time that is \\\Theta\\ ([Definition 8](#def-big-theta)) of one of these functions is called, in order,
>
> - *constant*, for \\1\\;
> - *logarithmic*, for \\\log_2 n\\;
> - *linear*, for \\n\\;
> - *\\n \log n\\*, for \\n \log_2 n\\;
> - *quadratic*, for \\n^2\\;
> - *exponential*, for \\2^n\\;
> - *factorial*, for \\n!\\.
>
> Other powers of \\n\\ fit between \\n\\ and \\2^n\\. For natural numbers \\a \le b\\, \\n^a \le n^b\\ for every natural number \\n\\, so \\n^a = O(n^b)\\. Every power \\n^a\\ is also \\O(2^n)\\, though the witness \\N\\ grows with \\a\\: for example, \\n^4 \le 2^n\\ holds for every \\n \ge 16\\, where \\16^4 = 65536 = 2^{16}\\, but not for \\n = 15\\, since \\15^4 = 50625 \> 32768 = 2^{15}\\. We do not prove the general statement here.

# 9 Counting the steps of loops

> **NOTE:**
>
> **Exercise 9 (Printing a multiplication table)** The algorithm `table`, in the pseudocode of [Remark: How to read the pseudocode in this chapter](../chapters/loop-invariants.llms.md#rem-pseudocode), prints a multiplication table:
>
> ``` text
> procedure table(n)       // n is a natural number
>     for i := 1 to n
>         for j := 1 to n
>             print i * j
> ```
>
> Here `print x` writes the value of `x` as output. How many times does the line `print i * j` run, as a function of \\n\\?

> **NOTE:**
>
> *Solution 9*. For each value of \\i\\, the inner loop runs `print i * j` once for each of \\j = 1, 2, \ldots, n\\, that is, \\n\\ times. The outer loop makes \\n\\ passes, one for each of \\i = 1, 2, \ldots, n\\, so the line runs \\n + n + \cdots + n = n \cdot n = n^2\\ times, once for each entry of an \\n\\ by \\n\\ table. For example, when \\n = 4\\ it runs \\4 \cdot 4 = 16\\ times.

> **NOTE:**
>
> *Remark 8* (Counting the steps of loops). To find the running time ([Definition 4](#def-running-time)) of an algorithm with loops:
>
> - a loop whose body takes the same number \\s\\ of steps on each of \\p\\ passes takes \\p \cdot s\\ steps, so the steps of nested loops multiply, as in [Solution 9](#sol-table-loops);
> - parts of an algorithm that run one after the other take the sum of their steps, and [Theorem 5](#thm-sum-rule) turns big-O bounds for the parts into a big-O bound for the sum.
>
> Each test of a loop’s guard ([Definition: Guard of a loop](../chapters/loop-invariants.llms.md#def-loop-guard)) and each line of setup is also a step, but counting them too changes the count by at most a fixed multiple plus a fixed number, which does not change a \\\Theta\\ bound ([Definition 8](#def-big-theta)) on a count that is at least 1.

> **NOTE:**
>
> **Example 12 (A loop, then a nested loop)** The algorithm `pairs` takes an array `A[1..n]` of numbers, where \\n \ge 1\\:
>
> ``` text
> procedure pairs(A, n)    // A[1..n] is an array of numbers, n >= 1
>     s := 0
>     for i := 1 to n
>         s := s + A[i]
>     t := 0
>     for i := 1 to n
>         for j := 1 to n
>             t := t + A[i] * A[j]
>     return s + t
> ```
>
> Count each run of an assignment inside a loop as one step. The first loop takes \\n\\ steps, and the nested loops take \\n \cdot n = n^2\\ steps, as in [Solution 9](#sol-table-loops), so the algorithm takes \\f(n) = n + n^2\\ steps. Since \\n \le n^2\\ and \\n^2 \le n^2\\ for every natural number \\n\\, both \\n = O(n^2)\\ and \\n^2 = O(n^2)\\ ([Definition 5](#def-big-o)) with witnesses ([Definition 6](#def-witness)) \\c = 1\\, \\N = 1\\, so \\f(n) = O(n^2)\\ by [Theorem 5](#thm-sum-rule). Also \\f(n) \ge n^2\\, so \\f(n) = \Omega(n^2)\\ ([Definition 7](#def-big-omega)) with \\c = 1\\, \\N = 1\\. So \\f(n) = \Theta(n^2)\\ ([Definition 8](#def-big-theta)): the nested loops decide the growth, and the first loop does not.

> **NOTE:**
>
> **Example 13 (A loop with the same recurrence as `pal`)** The algorithm `pal_loop` tests whether a string is a palindrome ([Definition: Palindrome](../chapters/recursion.llms.md#def-palindrome)) with a loop instead of recursion:
>
> ``` text
> procedure pal_loop(s)    // s is a string s[1] s[2] ... s[n] of n symbols
>     i := 1
>     j := n
>     while i < j and s[i] = s[j]
>         i := i + 1
>         j := j - 1
>     return i >= j
> ```
>
> The test `s[i] = s[j]` is made only when `i < j` is true. Let \\L(n)\\ be the largest number of passes through the body on a string of \\n\\ symbols. When \\n \le 1\\, the guard is false at once, so \\L(0) = L(1) = 0\\. When \\n \ge 2\\, the most passes come when the first and last symbols match; after the first pass, the loop then runs exactly as it would on the string \\s\[2..n-1\]\\ of \\n - 2\\ symbols, with every index one larger. So \\L(n) = L(n - 2) + 1\\, the same recurrence relation ([Definition 1](#def-recurrence-relation)) as for `pal` in [Example 5](#exm-pal-running-time), with initial terms one smaller.
>
> So \\L(n) = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{}\\ ([Definition: Floor](../chapters/loop-invariants.llms.md#def-floor)), by strong induction ([Definition: Proof by strong induction](../chapters/induction.llms.md#def-strong-induction)) as in the proof of [Theorem 3](#thm-pal-running-time): if \\n \le 1\\, then \\L(n) = 0 = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{}\\, and if \\n \ge 2\\ and the formula holds for \\n - 2\\, then \\L(n) = \mathopen{}\left\lfloor(n - 2) / 2\right\rfloor\mathclose{} + 1 = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} - 1 + 1 = \mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{}\\. The guard is tested once more than the body runs, \\\mathopen{}\left\lfloor n / 2\right\rfloor\mathclose{} + 1\\ times, which is the number of calls of `pal` by [Theorem 3](#thm-pal-running-time), and is \\O(n)\\ by [Example 6](#exm-pal-big-o).

> **NOTE:**
>
> **Example 14 (`root` takes \\\Theta(\sqrt{n})\\ steps)** The algorithm `root` of [Exercise: Tracing a square-root loop](../chapters/loop-invariants.llms.md#exr-root-trace) returns \\r = \mathopen{}\left\lfloor\sqrt{n}\right\rfloor\mathclose{}\\ ([Definition: Square root](https://morrison-lab.github.io/mds/algebra-basics.html#def-square-root)), the largest integer whose square is at most \\n\\, and its body adds 1 to `r` on each pass, starting from 0. So on input \\n\\ the body runs exactly \\\mathopen{}\left\lfloor\sqrt{n}\right\rfloor\mathclose{}\\ times. Let \\f(n) = \mathopen{}\left\lfloor\sqrt{n}\right\rfloor\mathclose{}\\, for natural numbers \\n\\.
>
> - \\f(n) \le \sqrt{n}\\, so \\f(n) = O(\sqrt{n})\\ ([Definition 5](#def-big-o)) with witnesses ([Definition 6](#def-witness)) \\c = 1\\, \\N = 1\\.
> - \\f(n) \ge 1\\ since \\n \ge 1\\, and \\\sqrt{n} \< f(n) + 1 \le 2 f(n)\\ by the definition of the floor ([Definition: Floor](../chapters/loop-invariants.llms.md#def-floor)), so \\f(n) \> \frac{1}{2} \sqrt{n}\\, and \\f(n) = \Omega(\sqrt{n})\\ ([Definition 7](#def-big-omega)) with \\c = \frac{1}{2}\\, \\N = 1\\.
>
> So \\f(n) = \Theta(\sqrt{n})\\ ([Definition 8](#def-big-theta)). Since \\\sqrt{n} \le n\\ for \\n \ge 1\\, the body of `root` runs no more times than the body of a loop with \\n\\ passes: on \\n = 10^6\\, its body runs \\1000\\ times.

# References

Wikipedia contributors. 2026a. *Big O Notation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Big_O_notation>.

Wikipedia contributors. 2026b. *Closed-Form Expression — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Closed-form_expression>.

Wikipedia contributors. 2026c. *Factorial — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Factorial>.

Wikipedia contributors. 2026d. *Logarithm — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Logarithm>.

Wikipedia contributors. 2026e. *Recurrence Relation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Recurrence_relation>.

Wikipedia contributors. 2026f. *Time Complexity — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Time_complexity>.

Wikipedia contributors. 2026g. *Triangle Inequality — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Triangle_inequality>.

Back to top
