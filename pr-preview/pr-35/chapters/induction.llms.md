# Mathematical Induction

Code

Ordinary and strong induction

Published

Last modified: 2026-10-27 13:12:35 (PDT)

> **NOTE:**
>
> Adapted from Kameron Decker Harris’s Fall 2026 lecture notes “Induction” and “More Induction!”, which are typed transcriptions of Scott Wehrwein’s Spring 2025 handwritten lecture notes. These come from those notes:
>
> - the names of the parts of a proof by induction: base case, induction hypothesis and inductive step;
> - the comparison of ordinary and strong induction;
> - the chocolate bar example of strong induction, with its proof;
> - the false claim that all horses are the same color, and where an induction proof of it fails.
>
> The exercises, the other examples and the text of the false proof are new.

# 1 Proof by induction

> **NOTE:**
>
> **Exercise 1 (Adding unit fractions of neighbors)** Consider the claim that for every natural number ([Definition: Natural numbers (our convention)](../chapters/sets.llms.md#def-natural-numbers)) \\n\\,
>
> \\ \frac{1}{1 \cdot 2} + \frac{1}{2 \cdot 3} + \cdots + \frac{1}{n(n + 1)} = \frac{n}{n + 1}. \\
>
> 1.  Check the claim for \\n = 1\\, \\n = 2\\ and \\n = 3\\.
> 2.  Suppose the claim holds for some natural number \\k\\. Add the next term, \\\frac{1}{(k + 1)(k + 2)}\\, to both sides, and show that the claim then holds for \\k + 1\\.

> **NOTE:**
>
> *Solution 1*.
>
> 1.  For \\n = 1\\, the left side is \\\frac{1}{2}\\ and the right side is \\\frac{1}{2}\\. For \\n = 2\\, the left side is \\\frac{1}{2} + \frac{1}{6} = \frac{2}{3}\\ and the right side is \\\frac{2}{3}\\. For \\n = 3\\, the left side is \\\frac{2}{3} + \frac{1}{12} = \frac{3}{4}\\ and the right side is \\\frac{3}{4}\\.
>
> 2.  Suppose \\\frac{1}{1 \cdot 2} + \cdots + \frac{1}{k(k + 1)} = \frac{k}{k + 1}\\. Then
>
>     \\ \begin{aligned} & \frac{1}{1 \cdot 2} + \cdots + \frac{1}{k(k + 1)} + \frac{1}{(k + 1)(k + 2)} \\&= \frac{k}{k + 1} + \frac{1}{(k + 1)(k + 2)} && \text{(the supposition)} \\&= \frac{k(k + 2) + 1}{(k + 1)(k + 2)} && \text{(common denominator)} \\&= \frac{k^2 + 2k + 1}{(k + 1)(k + 2)} \\&= \frac{(k + 1)^2}{(k + 1)(k + 2)} && \text{(} k^2 + 2k + 1 = (k + 1)^2 \text{)} \\&= \frac{k + 1}{k + 2}, && \text{(cancel } k + 1 \text{)} \end{aligned} \\
>
>     which is the claim for \\k + 1\\.
>
> Part 1 shows the claim for \\n = 1\\, and part 2 carries it from each natural number to the next, so it holds for \\n = 2, 3, 4, \ldots\\ in turn.

> **NOTE:**
>
> **Definition 1 (Proof by induction)** Let \\n_0\\ be an [integer](../chapters/direct-proof.llms.md#def-integers), and let \\P(n)\\ be a [predicate](../chapters/propositional-logic.llms.md#def-predicate) about the integers \\n \ge n_0\\. A **proof by induction** ([Wikipedia contributors 2026b](#ref-wikipedia_mathematical_induction)) on \\n\\ shows that \\P(n)\\ holds for every integer \\n \ge n_0\\ by showing two things:
>
> 1.  **Base case:** \\P(n_0)\\ holds.
> 2.  **Inductive step:** for every integer \\n \> n_0\\, if \\P(n - 1)\\ holds, then \\P(n)\\ holds.
>
> In the inductive step, the assumption that \\P(n - 1)\\ holds is called the **induction hypothesis**.

> **NOTE:**
>
> *Remark 1* (Stepping from \\k\\ to \\k + 1\\). [Definition 1](#def-proof-by-induction) states the inductive step as “if \\P(n - 1)\\, then \\P(n)\\, for every \\n \> n_0\\”. Many sources, and part 2 of [Solution 1](#sol-unit-fractions), state it as “if \\P(k)\\, then \\P(k + 1)\\, for every \\k \ge n_0\\”. The two say the same thing, with \\k = n - 1\\, and the rest of this chapter uses the second form.
>
> Writing the goal \\P(k + 1)\\ correctly is a common place to go wrong: replace *every* \\n\\ in \\P(n)\\ with \\k + 1\\, including in the last term of a sum and on the other side of the equation.

> **NOTE:**
>
> *Remark 2* (The shape of a proof by induction). A proof by induction that \\P(n)\\ holds for every integer \\n \ge n_0\\ has two parts:
>
> > **Base case.** Show \\P(n_0)\\.\
> > \
> > **Inductive step.** Let \\k \ge n_0\\ be an integer, and suppose \\P(k)\\.\
> > \\\vdots\\\
> > Therefore \\P(k + 1)\\.\
> > \
> > So \\P(n)\\ holds for every integer \\n \ge n_0\\, by induction.
>
> Write out the induction hypothesis \\P(k)\\ and the goal \\P(k + 1)\\ before starting the step, and mark the line where the step uses the hypothesis.

> **NOTE:**
>
> **Example 1 (A sum of products of neighbors)** Claim: for every natural number \\n\\,
>
> \\ 1 \cdot 2 + 2 \cdot 3 + \cdots + n(n + 1) = \frac{n(n + 1)(n + 2)}{3}. \\
>
> Let \\P(n)\\ be this equation, and follow [Remark 2](#rem-induction-template) with \\n_0 = 1\\.
>
> **Base case.** For \\n = 1\\, the left side is \\1 \cdot 2 = 2\\ and the right side is \\\frac{1 \cdot 2 \cdot 3}{3} = 2\\.
>
> **Inductive step.** Let \\k \ge 1\\, and suppose \\P(k)\\:
>
> \\ 1 \cdot 2 + \cdots + k(k + 1) = \frac{k(k + 1)(k + 2)}{3}. \\
>
> The goal \\P(k + 1)\\ is
>
> \\ 1 \cdot 2 + \cdots + k(k + 1) + (k + 1)(k + 2) = \frac{(k + 1)(k + 2)(k + 3)}{3}. \\
>
> Starting from its left side,
>
> \\ \begin{aligned} & 1 \cdot 2 + \cdots + k(k + 1) + (k + 1)(k + 2) \\&= \frac{k(k + 1)(k + 2)}{3} + (k + 1)(k + 2) && \text{(induction hypothesis)} \\&= \frac{k(k + 1)(k + 2) + 3(k + 1)(k + 2)}{3} && \text{(common denominator)} \\&= \frac{(k + 1)(k + 2)(k + 3)}{3}. && \text{(factor out } (k + 1)(k + 2) \text{)} \end{aligned} \\
>
> So \\P(k + 1)\\ holds, and by induction \\P(n)\\ holds for every natural number \\n\\.

# 2 Starting at another integer

> **NOTE:**
>
> **Exercise 2 (When does \\2^n\\ catch up with \\n^2\\?)** Compare \\n^2\\ with \\2^n\\ for \\n = 1, 2, \ldots, 6\\. Find the smallest natural number \\n_0\\ such that \\n^2 \le 2^n\\ holds for \\n_0\\ and for every \\n\\ you checked after it.

> **NOTE:**
>
> *Solution 2*.
>
> |  \\n\\  |  1  |  2  |  3  |  4  |  5  |  6  |
> |:-------:|:---:|:---:|:---:|:---:|:---:|:---:|
> | \\n^2\\ |  1  |  4  |  9  | 16  | 25  | 36  |
> | \\2^n\\ |  2  |  4  |  8  | 16  | 32  | 64  |
>
> The inequality holds for \\n = 1\\ and \\n = 2\\, fails for \\n = 3\\, and holds for \\n = 4, 5, 6\\. So \\n_0 = 4\\.

> **NOTE:**
>
> **Example 2 (An induction that starts at 4)** Claim: \\n^2 \le 2^n\\ for every integer ([Definition: Integers](../chapters/direct-proof.llms.md#def-integers)) \\n \ge 4\\.
>
> Let \\P(n)\\ be the inequality \\n^2 \le 2^n\\ ([Definition: Inequality](https://morrison-lab.github.io/mds/proof-writing.html#def-inequality)), and follow [Remark 2](#rem-induction-template) with \\n_0 = 4\\. [Solution 2](#sol-squares-powers) shows that \\n_0 = 1\\ would not work, since \\P(3)\\ is false.
>
> **Base case.** \\4^2 = 16 \le 16 = 2^4\\.
>
> **Inductive step.** Let \\k \ge 4\\, and suppose \\k^2 \le 2^k\\. The goal is \\(k + 1)^2 \le 2^{k + 1}\\. Since \\k \ge 4\\, we have \\k^2 \ge 4k = 2k + 2k \ge 2k + 8 \> 2k + 1\\. So
>
> \\ \begin{aligned} (k + 1)^2 &= k^2 + 2k + 1 \\&\< k^2 + k^2 && \text{(} 2k + 1 \< k^2 \text{)} \\&= 2k^2 \\&\le 2 \cdot 2^k && \text{(induction hypothesis)} \\&= 2^{k + 1}. \end{aligned} \\
>
> So \\P(k + 1)\\ holds, and by induction \\n^2 \le 2^n\\ for every integer \\n \ge 4\\. The inductive step works for every \\k \ge 3\\, since \\2k + 1 \< k^2\\ already holds at \\k = 3\\. The induction starts at 4 because of the base case: \\P(3)\\ is false.

# 3 Strong induction

> **NOTE:**
>
> **Exercise 3 (Breaking a chocolate bar)** A chocolate bar is a row of \\n\\ squares. One break splits one piece into two pieces along a line between squares. How many breaks does it take to split a bar of 1, 2, 3 or 4 squares into single squares? Does the answer depend on where you break first?

> **NOTE:**
>
> *Solution 3*. A bar of 1 square takes 0 breaks, 2 squares take 1, 3 squares take 2, and 4 squares take 3. For 4 squares, breaking first in the middle gives two pieces of 2 squares, which take 1 break each, for \\1 + 1 + 1 = 3\\ breaks; breaking first at one end gives pieces of 1 and 3 squares, which take 0 and 2 breaks, for \\1 + 0 + 2 = 3\\ breaks. For these bars, the answer does not depend on where you break first.

> **NOTE:**
>
> **Definition 2 (Proof by strong induction)** Let \\n_0\\ be an [integer](../chapters/direct-proof.llms.md#def-integers), and let \\P(n)\\ be a [predicate](../chapters/propositional-logic.llms.md#def-predicate) about the [integers](../chapters/direct-proof.llms.md#def-integers) \\n \ge n_0\\. A **proof by strong induction** ([Wikipedia contributors 2026b](#ref-wikipedia_mathematical_induction)) on \\n\\ shows that \\P(n)\\ holds for every integer \\n \ge n_0\\ by showing one thing: for every integer \\n \ge n_0\\, if \\P(k)\\ holds for every integer \\k\\ with \\n_0 \le k \< n\\, then \\P(n)\\ holds.
>
> The assumption that \\P(k)\\ holds for every integer \\k\\ with \\n_0 \le k \< n\\ is the **strong induction hypothesis**.
>
> For \\n = n_0\\ no integer \\k\\ satisfies \\n_0 \le k \< n\\, so the strong induction hypothesis is [vacuously true](../chapters/sets.llms.md#def-vacuous-truth), and the proof for \\n = n_0\\ is a [base case](../chapters/induction.llms.md#def-proof-by-induction). When the proof for \\n\\ needs particular earlier cases that do not exist for the first few \\n\\, those few cases are shown separately as further [base cases](../chapters/induction.llms.md#def-proof-by-induction).

> **NOTE:**
>
> **Theorem 1 (Breaking a chocolate bar takes one break fewer than its squares)** For every natural number ([Definition: Natural numbers (our convention)](../chapters/sets.llms.md#def-natural-numbers)) \\n\\, splitting a bar of chocolate, a row of \\n\\ squares, into single squares takes exactly \\n - 1\\ breaks, however the breaks are made.

> **NOTE:**
>
> *Proof*. We use strong induction ([Definition 2](#def-strong-induction)). Let \\P(n)\\ be the claim for a bar of \\n\\ squares, let \\n\\ be a natural number, and suppose \\P(k)\\ holds for every natural number \\k \< n\\.
>
> If \\n = 1\\, the bar is already a single square, so it takes \\0 = n - 1\\ breaks.
>
> If \\n \ge 2\\, the first break splits the bar into two pieces of \\a\\ and \\b\\ squares, with \\a + b = n\\, \\a \ge 1\\ and \\b \ge 1\\, so \\a \< n\\ and \\b \< n\\. Each later break splits a single piece, so it falls inside one of these two pieces, and the later breaks are the breaks of the \\a\\-square piece together with the breaks of the \\b\\-square piece. By the strong induction hypothesis, the piece of \\a\\ squares takes \\a - 1\\ breaks and the piece of \\b\\ squares takes \\b - 1\\ breaks. So the whole bar takes
>
> \\ \begin{aligned} 1 + (a - 1) + (b - 1) &= a + b - 1 \\&= n - 1 \end{aligned} \\
>
> breaks.

> **NOTE:**
>
> *Remark 3* (Why the proof needs strong induction). The proof of [Theorem 1](#thm-chocolate) uses \\P(a)\\ and \\P(b)\\, where \\a\\ and \\b\\ can be any sizes smaller than \\n\\, not only \\n - 1\\. Ordinary induction gives only \\P(n - 1)\\ in the step. Strong induction gives \\P(k)\\ for every \\k \< n\\, which is what the proof needs.

> **NOTE:**
>
> **Definition 3 (Recursively defined sequence)** Let \\n_0\\ be an [integer](../chapters/direct-proof.llms.md#def-integers) and \\m\\ a positive integer. A [sequence](https://morrison-lab.github.io/mds/functions.html#def-sequence) \\a\_{n_0}, a\_{n_0 + 1}, \ldots\\ is **recursively defined** ([Wikipedia contributors 2026c](#ref-wikipedia_recurrence_relation)) by two things:
>
> 1.  **Initial [terms](https://morrison-lab.github.io/mds/functions.html#def-sequence-term):** specific [values](https://morrison-lab.github.io/mds/functions.html#def-value) for \\a\_{n_0}, \ldots, a\_{n_0 + m - 1}\\.
> 2.  **Recurrence:** a rule that gives \\a_n\\ from the \\m\\ entries \\a\_{n-1}, \ldots, a\_{n-m}\\ just before it, for every integer \\n \ge n_0 + m\\.
>
> The initial terms and the recurrence together fix every [term](https://morrison-lab.github.io/mds/functions.html#def-sequence-term): the first \\m\\ entries are given, and each later entry follows from the \\m\\ entries before it.

> **NOTE:**
>
> **Example 3 (Powers of 3)** The [sequence](https://morrison-lab.github.io/mds/functions.html#def-sequence) \\a_0, a_1, \ldots\\ with initial [term](https://morrison-lab.github.io/mds/functions.html#def-sequence-term) \\a_0 = 1\\ and recurrence \\a_n = 3 a\_{n-1}\\ for \\n \ge 1\\ has \\m = 1\\, and its [terms](https://morrison-lab.github.io/mds/functions.html#def-sequence-term) are \\1, 3, 9, 27, \ldots\\ A [proof by induction](../chapters/induction.llms.md#def-proof-by-induction) shows \\a_n = 3^n\\ for every [integer](../chapters/direct-proof.llms.md#def-integers) \\n \ge 0\\, using the recurrence in the inductive step: if \\a\_{n-1} = 3^{n-1}\\, then \\a_n = 3 \cdot 3^{n-1} = 3^n\\.

> **NOTE:**
>
> **Definition 4 (Fibonacci sequence)** The **Fibonacci sequence** \\F_1, F_2, \ldots\\ ([Wikipedia contributors 2026a](#ref-wikipedia_fibonacci_sequence)) is the [recursively defined sequence](#def-recursive-sequence) with \\m = 2\\, initial [terms](https://morrison-lab.github.io/mds/functions.html#def-sequence-term) \\F_1 = 1\\ and \\F_2 = 1\\, and recurrence \\F_n = F\_{n-1} + F\_{n-2}\\ for every [integer](../chapters/direct-proof.llms.md#def-integers) \\n \ge 3\\.

> **NOTE:**
>
> **Example 4 (The first Fibonacci numbers)** \\F_3 = F_2 + F_1 = 1 + 1 = 2\\, \\F_4 = F_3 + F_2 = 2 + 1 = 3\\, \\F_5 = F_4 + F_3 = 3 + 2 = 5\\, and \\F_6 = F_5 + F_4 = 5 + 3 = 8\\. So the [sequence](https://morrison-lab.github.io/mds/functions.html#def-sequence) begins \\1, 1, 2, 3, 5, 8, \ldots\\

> **NOTE:**
>
> **Example 5 (Every term of the Fibonacci sequence is less than a power of 2)** Let \\F_1, F_2, \ldots\\ be the [Fibonacci sequence](#def-fibonacci-sequence). To prove \\F_n \< 2^n\\ for every \\n \in \mathbb{N}\\, let \\P(n)\\ be the [inequality](https://morrison-lab.github.io/mds/proof-writing.html#def-inequality) \\F_n \< 2^n\\ and use [Definition 2](#def-strong-induction) with \\n_0 = 1\\.
>
> **[Base cases](../chapters/induction.llms.md#def-proof-by-induction), \\n = 1\\ and \\n = 2\\.** The step below uses the two entries \\F\_{n-1}\\ and \\F\_{n-2}\\ before \\F_n\\, which do not exist for \\n = 1\\ and \\n = 2\\, so these two cases are shown directly:
>
> \\ \begin{aligned} F_1 &= 1 \< 2 = 2^1 && \text{(} 1 \< 2 \text{)} \\ F_2 &= 1 \< 4 = 2^2. && \text{(} 1 \< 4 \text{)} \end{aligned} \\
>
> **Step of the [strong induction](#def-strong-induction), \\n \ge 3\\.** Let \\n \ge 3\\, and suppose \\P(k)\\ holds for every [integer](../chapters/direct-proof.llms.md#def-integers) \\k\\ with \\1 \le k \< n\\. Then \\k = n - 1\\ and \\k = n - 2\\ both satisfy \\1 \le k \< n\\, so \\F\_{n-1} \< 2^{n-1}\\ and \\F\_{n-2} \< 2^{n-2}\\. Therefore
>
> \\ \begin{aligned} F_n &= F\_{n-1} + F\_{n-2} && \text{(definition of } F_n \text{, since } n \ge 3 \text{)} \\ &\< 2^{n-1} + 2^{n-2} && \text{(strong induction hypothesis, twice)} \\ &\< 2^{n-1} + 2^{n-1} && \text{(} 2^{n-2} \< 2^{n-1} \text{)} \\ &= 2 \cdot 2^{n-1} && \text{(} a + a = 2a \text{)} \\ &= 2^n, && \text{(} 2 \cdot 2^{n-1} = 2^n \text{)} \end{aligned} \\
>
> which is \\P(n)\\. By [Definition 2](#def-strong-induction), \\F_n \< 2^n\\ for every \\n \in \mathbb{N}\\.

# 4 A proof by induction that fails

> **NOTE:**
>
> **Example 6 (A proof by induction that fails)** Claim (false): in every group of \\n \ge 1\\ horses, all the horses are the same color.
>
> “Proof”:
>
> - **Base case.** A group of 1 horse has only one color.
> - **Inductive step.** Suppose every group of \\k\\ horses is all one color, and take a group of \\k + 1\\ horses. Leaving out the first horse leaves \\k\\ horses, which are all one color, and leaving out the last horse leaves \\k\\ horses, which are all one color. The horses in the middle are in both groups, so the two colors are the same, and all \\k + 1\\ horses are one color.
>
> The inductive step fails for \\k = 1\\: a group of 2 horses splits into two groups of 1 horse with no horse in both, so nothing links the two colors. So \\P(1)\\ does not imply \\P(2)\\, and the chain of implications breaks at its first link. An inductive step has to work for *every* \\k \ge n_0\\, including the smallest.

# References

Wikipedia contributors. 2026a. *Fibonacci Sequence — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Fibonacci_sequence>.

Wikipedia contributors. 2026b. *Mathematical Induction — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Mathematical_induction>.

Wikipedia contributors. 2026c. *Recurrence Relation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Recurrence_relation>.

Back to top
