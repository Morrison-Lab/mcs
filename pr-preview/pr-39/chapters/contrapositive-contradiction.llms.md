# Contrapositive and Contradiction

Code

Proving a statement by way of its negation

Published

Last modified: 2026-10-29 12:51:24 (PDT)

> **NOTE:**
>
> Adapted from Kameron Decker Harris’s Fall 2026 lecture notes “Contrapositive Proof” and “Proof by Contradiction”, which are typed transcriptions of Scott Wehrwein’s Spring 2025 handwritten lecture notes. These come from those notes:
>
> - the definition of congruence modulo \\n\\, and the point that it is not the mod operator;
> - the human and mammal illustration of a contrapositive;
> - the example of a product not divisible by \\5\\;
> - the truth table showing why a proof by contradiction works;
> - the outlines of a proof by contrapositive, a proof by contradiction, and a proof of a conditional by contradiction;
> - the definition and examples of a prime number, and the fact that every integer above one has a prime divisor;
> - the statement that \\\sqrt{2}\\ is irrational (the proof here is different);
> - Euclid’s proof that there are infinitely many primes.
>
> The exercises are new.
>
> The definitions of the contrapositive, proof by contrapositive, proof by contradiction, and rational and irrational numbers, their examples of a proof by contradiction and of rational and irrational numbers, and the theorem that a conditional is equivalent to its contrapositive, are included from the [mathematics prerequisites](https://morrison-lab.github.io/mds/) notes, so they read the same in both places.

# 1 Congruence modulo \\n\\

> **NOTE:**
>
> **Exercise 1 (Differences divisible by five)** For each integer \\a\\ in the list \\23\\, \\38\\, \\50\\, \\-7\\, compute \\a - 8\\, and decide whether \\5 \mid (a - 8)\\ ([Definition: Divides](../chapters/direct-proof.llms.md#def-divides)).

> **NOTE:**
>
> *Solution 1*.
>
> - \\23 - 8 = 15 = 5 \cdot 3\\, so \\5 \mid (23 - 8)\\.
> - \\38 - 8 = 30 = 5 \cdot 6\\, so \\5 \mid (38 - 8)\\.
> - \\50 - 8 = 42\\. Since \\5 \cdot 8 = 40 \< 42 \< 45 = 5 \cdot 9\\, no integer \\c\\ has \\5c = 42\\, so \\5 \nmid (50 - 8)\\.
> - \\-7 - 8 = -15 = 5 \cdot(-3)\\, so \\5 \mid (-7 - 8)\\.

> **NOTE:**
>
> **Definition 1 (Congruence modulo \\n\\)** Let \\a\\ and \\b\\ be integers ([Definition: Integers](../chapters/direct-proof.llms.md#def-integers)), and let \\n\\ be a positive integer. We say that \\a\\ is **congruent to \\b\\ modulo \\n\\**, written \\a \equiv b \pmod{n}\\, if \\n \mid (a - b)\\ ([Definition: Divides](../chapters/direct-proof.llms.md#def-divides)) ([Wikipedia contributors 2026d](#ref-wikipedia_modular_arithmetic)). When \\a\\ is not congruent to \\b\\ modulo \\n\\, we write \\a \not\equiv b \pmod{n}\\.

> **NOTE:**
>
> **Example 1 (Congruences)**  
>
> - By [Solution 1](#sol-minus-eight), \\23 \equiv 8 \pmod{5}\\, \\38 \equiv 8 \pmod{5}\\ and \\-7 \equiv 8 \pmod{5}\\, but \\50 \not\equiv 8 \pmod{5}\\.
> - A 24-hour clock that reads \\19\\ shows the same hour as a 12-hour clock that reads \\7\\, and \\19 \equiv 7 \pmod{12}\\, because \\19 - 7 = 12 = 12 \cdot 1\\.

> **NOTE:**
>
> *Remark 1* (Two meanings of \\\equiv\\, and the mod operator). The symbol \\\equiv\\ also means logical equivalence ([Definition: Logical equivalence](../chapters/equivalence-negation.llms.md#def-logical-equivalence)). The “\\(\operatorname{mod} n)\\” after it says which meaning is in use: \\23 \equiv 8 \pmod{5}\\ is a statement about two integers, and \\P \equiv Q\\ is a statement about two propositions.
>
> Congruence is related to the mod operator of a programming language, but it is not the same thing. In Racket, `(modulo 23 5)` is the number \\3\\, while \\23 \equiv 8 \pmod{5}\\ is a proposition ([Definition: Proposition (statement)](../chapters/propositional-logic.llms.md#def-proposition)), which is true or false.

# 2 Proof by contrapositive

> **NOTE:**
>
> **Exercise 2 (An odd sum)** Let \\x\\ and \\y\\ be integers. Prove: if \\x + y\\ is odd, then \\x \ne y\\.
>
> First try a direct proof ([Definition: Direct proof](../chapters/direct-proof.llms.md#def-direct-proof)), starting from “Suppose \\x + y\\ is odd.” Then try starting from “Suppose \\x = y\\.”

> **NOTE:**
>
> *Solution 2*. The direct start gives \\x + y = 2k + 1\\ for some integer \\k\\ ([Definition: Odd integer](../chapters/direct-proof.llms.md#def-odd)), which says little about whether \\x\\ and \\y\\ are equal.
>
> The second start goes further. Suppose \\x = y\\. Then \\x + y = x + x = 2x\\, and \\x\\ is an integer, so \\x + y\\ is even ([Definition: Even integer](../chapters/direct-proof.llms.md#def-even-odd)). No integer is both even and odd ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), so \\x + y\\ is not odd.
>
> That proves “if \\x = y\\, then \\x + y\\ is not odd”. Why proving this proposition proves the one we were asked about is the subject of this section.

> **NOTE:**
>
> **Definition 2 (Contrapositive)** The **contrapositive** ([Wikipedia contributors 2026a](#ref-wikipedia_contraposition)) of the [proposition](../chapters/propositional-logic.llms.md#def-proposition) “if \\P\\, then \\Q\\” is the proposition “if \\\neg Q\\, then \\\neg P\\”.

> **NOTE:**
>
> **Example 2 (Contrapositives)**  
>
> - The contrapositive of “if \\x\\ is a human, then \\x\\ is a mammal” is “if \\x\\ is not a mammal, then \\x\\ is not a human”.
> - In [Exercise 2](#exr-sum-odd), \\P\\ is “\\x + y\\ is odd” and \\Q\\ is “\\x \ne y\\”. The negation of \\Q\\ is “\\x = y\\” ([Definition: Not](../chapters/propositional-logic.llms.md#def-not)), so the contrapositive is “if \\x = y\\, then \\x + y\\ is not odd”, which is what [Solution 2](#sol-sum-odd) proved.

> **NOTE:**
>
> **Theorem 1 (A conditional is equivalent to its contrapositive)** For any [propositions](../chapters/propositional-logic.llms.md#def-proposition) \\P\\ and \\Q\\,
>
> \\ (P \Rightarrow Q) \equiv (\neg Q \Rightarrow \neg P). \\

> **NOTE:**
>
> *Proof*. By the definition of [implies](../chapters/propositional-logic.llms.md#def-implies), \\P \Rightarrow Q\\ is false exactly when \\P\\ is true and \\Q\\ is false. By the same definition, \\\neg Q \Rightarrow \neg P\\ is false exactly when \\\neg Q\\ is true and \\\neg P\\ is false, that is, exactly when \\Q\\ is false and \\P\\ is true. So the two [propositions](../chapters/propositional-logic.llms.md#def-proposition) are false in the same row of a [truth table](../chapters/propositional-logic.llms.md#def-truth-table) and true in the other three, which is [Definition: Logically equivalent](https://morrison-lab.github.io/mds/proof-writing.html#def-logically-equivalent).

> **NOTE:**
>
> **Example 3 (A proposition and its contrapositive)** Take “if today is Saturday, then today is a weekend day”, which is true.
>
> Its contrapositive is “if today is not a weekend day, then today is not Saturday”. It is also true, as [Theorem 1](#thm-contrapositive) says it must be: Monday through Friday are the days that are not weekend days, and none of them is Saturday.

> **NOTE:**
>
> **Definition 3 (Proof by contrapositive)** A **proof by contrapositive** ([Wikipedia contributors 2026a](#ref-wikipedia_contraposition)) of a [proposition](../chapters/propositional-logic.llms.md#def-proposition) “if \\P\\, then \\Q\\” is a [direct proof](../chapters/direct-proof.llms.md#def-direct-proof) of its [contrapositive](#def-contrapositive), “if \\\neg Q\\, then \\\neg P\\”: it assumes that \\Q\\ is false and reaches the conclusion that \\P\\ is false. By [Theorem 1](#thm-contrapositive), proving the contrapositive proves the original proposition.

> **NOTE:**
>
> **Example 4 (A product not divisible by \\5\\)** Claim: let \\x\\ and \\y\\ be integers. If \\5 \nmid xy\\, then \\5 \nmid x\\ and \\5 \nmid y\\.
>
> A direct proof would start from \\5 \nmid xy\\, which says only that \\xy\\ is not \\5\\ times an integer, and gives no equation to work with. By De Morgan’s laws ([Theorem: De Morgan’s laws](../chapters/equivalence-negation.llms.md#thm-de-morgan-logic)), the negation of “\\5 \nmid x\\ and \\5 \nmid y\\” is “\\5 \mid x\\ or \\5 \mid y\\”, so the contrapositive ([Definition 2](#def-contrapositive)) is “if \\5 \mid x\\ or \\5 \mid y\\, then \\5 \mid xy\\”. We prove it by cases ([Definition: Proof by cases](../chapters/direct-proof.llms.md#def-proof-by-cases)).
>
> **Case 1: \\5 \mid x\\.** Then \\x = 5c\\ for some integer \\c\\ ([Definition: Divides](../chapters/direct-proof.llms.md#def-divides)), so
>
> \\ \begin{aligned} xy &= (5c) y && \text{(substitute } x = 5c \text{)} \\&= 5 (c y), && \text{(regroup the product)} \end{aligned} \\
>
> and \\c y\\ is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), so \\5 \mid xy\\.
>
> **Case 2: \\5 \mid y\\.** Then \\y = 5d\\ for some integer \\d\\, so \\xy = x (5d) = 5 (x d)\\, and \\x d\\ is an integer, so \\5 \mid xy\\.
>
> In both cases \\5 \mid xy\\, which proves the contrapositive and so the claim ([Theorem 1](#thm-contrapositive)). For example, \\x = 3\\ and \\y = 7\\ give \\xy = 21\\, which \\5\\ does not divide, and indeed \\5\\ divides neither \\3\\ nor \\7\\.

> **NOTE:**
>
> *Remark 2* (The shape of a proof by contrapositive). A proof by contrapositive ([Definition 3](#def-proof-by-contrapositive)) of “if \\P\\, then \\Q\\” has this shape:
>
> > Suppose \\\neg Q\\.\
> > \\\vdots\\\
> > Therefore \\\neg P\\.
>
> Use it when \\\neg Q\\ gives you more to work with than \\P\\ does. In [Exercise 2](#exr-sum-odd), \\\neg Q\\ was the equation \\x = y\\, while \\P\\ said only that \\x + y\\ is odd.

> **NOTE:**
>
> **Exercise 3 (A square not divisible by three)** Let \\n\\ be an integer. Prove: if \\3 \nmid n^2\\, then \\3 \nmid n\\.

> **NOTE:**
>
> *Solution 3*. We prove the contrapositive ([Definition 3](#def-proof-by-contrapositive)): if \\3 \mid n\\, then \\3 \mid n^2\\.
>
> Suppose \\3 \mid n\\. Then \\n = 3c\\ for some integer \\c\\ ([Definition: Divides](../chapters/direct-proof.llms.md#def-divides)), so
>
> \\ \begin{aligned} n^2 &= (3c)^2 && \text{(substitute } n = 3c \text{)} \\&= 9 c^2 && \text{(square each factor)} \\&= 3 (3 c^2), && \text{(write } 9 = 3 \cdot 3 \text{)} \end{aligned} \\
>
> and \\3 c^2\\ is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), so \\3 \mid n^2\\. By [Theorem 1](#thm-contrapositive), this proves the original proposition.

# 3 Proof by contradiction

> **NOTE:**
>
> **Exercise 4 (No solution in integers)** Show that there are no integers \\m\\ and \\n\\ with \\6m + 9n = 1\\.
>
> Hint: suppose there were. What would \\6m + 9n = 1\\ say about \\3\\ and \\1\\?

> **NOTE:**
>
> *Solution 4*. Suppose there are integers \\m\\ and \\n\\ with \\6m + 9n = 1\\. Then
>
> \\ \begin{aligned} 1 &= 6m + 9n && \text{(the assumption, read from right to left)} \\&= 3 (2m + 3n), && \text{(distributive law, read from right to left)} \end{aligned} \\
>
> and \\2m + 3n\\ is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), so \\3 \mid 1\\ ([Definition: Divides](../chapters/direct-proof.llms.md#def-divides)).
>
> But \\3 \nmid 1\\: since \\3 \cdot 0 = 0 \< 1 \< 3 = 3 \cdot 1\\, no integer \\c\\ has \\3c = 1\\. So \\3 \mid 1\\ and \\3 \nmid 1\\, which is impossible. The assumption must be false, so there are no integers \\m\\ and \\n\\ with \\6m + 9n = 1\\.

> **NOTE:**
>
> **Definition 4 (Proof by contradiction)** A **proof by contradiction** ([Wikipedia contributors 2026f](#ref-wikipedia_proof_by_contradiction)) of a proposition \\P\\ assumes that \\P\\ is false, and derives from that assumption a proposition that is known to be false.

> **NOTE:**
>
> **Example 5 (No integer is both even and odd)** Suppose, for contradiction, that some integer \\n\\ is both even and odd ([definition](../chapters/direct-proof.llms.md#def-even-odd)). Then \\n = 2j\\ and \\n = 2k + 1\\ for some integers \\j\\ and \\k\\, and
>
> \\ \begin{aligned} 2j &= 2k + 1 && \text{(both equal } n \text{)} \\ 2j - 2k &= 1 && \text{(subtract } 2k \text{ from both sides)} \\ 2(j - k) &= 1 && \text{(distributive law)} \\ j - k &= \tfrac{1}{2} && \text{(divide both sides by } 2 \text{)} \end{aligned} \\
>
> The third line uses the [distributive law](https://morrison-lab.github.io/mds/algebra.html#def-distributive). But \\j - k\\ is an integer, and \\\frac{1}{2}\\ is not, so the last line is false. So no integer is both even and odd. For example, \\6 = 2 \cdot 3\\ is even, and \\6 = 2k + 1\\ would need \\k = 2.5\\, which is not an integer.

> **NOTE:**
>
> **Theorem 2 (Why a proof by contradiction works)** For propositions \\P\\ and \\C\\,
>
> \\ P \equiv \mathopen{}\left(\neg P \Rightarrow (C \land \neg C)\right)\mathclose{}. \\

> **NOTE:**
>
> *Proof*. \\C \land \neg C\\ is false in every row ([Definition: And](../chapters/propositional-logic.llms.md#def-and), [Definition: Not](../chapters/propositional-logic.llms.md#def-not)), so it is a contradiction ([Definition: Contradiction](../chapters/equivalence-negation.llms.md#def-contradiction)). So, by [Definition: Implies](../chapters/propositional-logic.llms.md#def-implies), \\\neg P \Rightarrow (C \land \neg C)\\ is true exactly in the rows where \\\neg P\\ is false, which are the rows where \\P\\ is true:
>
> | \\P\\ | \\C\\ | \\\neg P\\ | \\C \land \neg C\\ | \\\neg P \Rightarrow (C \land \neg C)\\ |
> |:--:|:--:|:--:|:--:|:--:|
> | T | T | F | F | T |
> | T | F | F | F | T |
> | F | T | T | F | F |
> | F | F | T | F | F |
>
> The first and last columns match in every row ([Definition: Logical equivalence](../chapters/equivalence-negation.llms.md#def-logical-equivalence)).

> **NOTE:**
>
> **Example 6 (The six and nine proof, read through the theorem)** In [Solution 4](#sol-six-nine), \\P\\ is “there are no integers \\m\\ and \\n\\ with \\6m + 9n = 1\\”, and \\C\\ is “\\3 \mid 1\\”. The solution assumed \\\neg P\\, that such integers exist, and derived both \\C\\ and \\\neg C\\. That proves \\\neg P \Rightarrow (C \land \neg C)\\, so, by [Theorem 2](#thm-contradiction-works), it proves \\P\\.

> **NOTE:**
>
> *Remark 3* (The shape of a proof by contradiction). A proof by contradiction ([Definition 4](#def-proof-by-contradiction)) of a proposition \\P\\ has this shape:
>
> > Suppose \\\neg P\\.\
> > \\\vdots\\\
> > Therefore \\C\\ and \\\neg C\\.
>
> Two things differ from a proof by contrapositive ([Remark 2](#rem-contrapositive-template)). \\P\\ need not be a conditional. And the proof does not know \\C\\ in advance: any proposition \\C\\ for which the argument derives both \\C\\ and \\\neg C\\ will do.

> **NOTE:**
>
> *Remark 4* (Proving a conditional by contradiction). To prove “if \\P\\, then \\Q\\” by contradiction, suppose its negation, which is “\\P\\ and \\\neg Q\\” ([Theorem: Negating a conditional](../chapters/equivalence-negation.llms.md#thm-negate-conditional)):
>
> > Suppose \\P\\ and \\\neg Q\\.\
> > \\\vdots\\\
> > Therefore \\C\\ and \\\neg C\\.
>
> A proof by contrapositive ([Remark 2](#rem-contrapositive-template)) assumes only \\\neg Q\\, and has the fixed goal \\\neg P\\. A proof by contradiction assumes both \\P\\ and \\\neg Q\\, and any contradiction will do.

> **NOTE:**
>
> **Example 7 (A number plus its reciprocal)** Claim: let \\x\\ be a real number. If \\x \> 0\\, then \\x + \frac{1}{x} \ge 2\\.
>
> Suppose, for contradiction, that \\x \> 0\\ and \\x + \frac{1}{x} \< 2\\. Since \\x \> 0\\, multiplying both sides by \\x\\ keeps the inequality, so
>
> \\ \begin{aligned} x^2 + 1 &\< 2x && \text{(multiply both sides by } x \> 0 \text{)} \\ x^2 - 2x + 1 &\< 0 && \text{(subtract } 2x \text{ from both sides)} \\ (x - 1)^2 &\< 0. && \text{(square of a difference)} \end{aligned} \\
>
> Let \\C\\ be “\\(x - 1)^2 \ge 0\\”. \\C\\ is true, because a square of a real number is never negative, and the last line says \\\neg C\\. That is a contradiction, so the claim holds. The proof used \\x \> 0\\ in the first step, and the contradiction it reached is not \\x \le 0\\. For example, \\x = 4\\ gives \\4 + \frac{1}{4} = 4.25 \ge 2\\.

> **NOTE:**
>
> **Exercise 5 (Squares one apart)** Prove that there are no positive integers \\x\\ and \\y\\ with \\x^2 - y^2 = 1\\.

> **NOTE:**
>
> *Solution 5*. Suppose, for contradiction, that \\x\\ and \\y\\ are positive integers with \\x^2 - y^2 = 1\\. Then
>
> \\ \begin{aligned} 1 &= x^2 - y^2 && \text{(the assumption, read from right to left)} \\&= (x - y)(x + y). && \text{(difference of squares)} \end{aligned} \\
>
> Since \\x \ge 1\\ and \\y \ge 1\\, \\x + y \ge 2\\. Dividing both sides by \\x + y\\ gives \\x - y = \frac{1}{x + y}\\, and \\0 \< \frac{1}{x + y} \le \frac{1}{2}\\, so \\x - y\\ is strictly between \\0\\ and \\1\\ and is not an integer. But \\x - y\\ is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)). That is a contradiction, so there are no such \\x\\ and \\y\\.

# 4 Irrational numbers

> **NOTE:**
>
> **Exercise 6 (Bounds on a fraction for \\\sqrt{2}\\)** Suppose \\a\\ and \\b\\ are positive integers with \\\frac{a}{b} = \sqrt{2}\\. Use \\1 \< 2 \< 4\\ to show that \\b \< a \< 2b\\.

> **NOTE:**
>
> *Solution 6*. Square roots keep the order of positive numbers, so \\1 \< 2 \< 4\\ gives \\1 \< \sqrt{2} \< 2\\, that is, \\1 \< \frac{a}{b} \< 2\\. Multiplying each part by \\b\\, which is positive, keeps the order, and gives \\b \< a \< 2b\\.

> **NOTE:**
>
> **Definition 5 (Rational numbers)** A **rational number** ([Wikipedia contributors 2026h](#ref-wikipedia_rational_number)) is a number that can be written as a fraction \\\frac{a}{b}\\, where \\a\\ and \\b\\ are integers ([Definition: Integers](../chapters/direct-proof.llms.md#def-integers)) and \\b \ne 0\\. The set of rational numbers is written \\\mathbb{Q}\\:
>
> \\\mathbb{Q} \stackrel{\text{def}}{=}\mathopen{}\left\\\frac{a}{b} : a \in \mathbb{Z},\\ b \in \mathbb{Z},\\ b \ne 0\right\\\mathclose{}\\

> **NOTE:**
>
> **Example 8 (Rational numbers)**  
>
> - \\\frac{3}{4}\\ is rational, with \\a = 3\\ and \\b = 4\\.
> - \\0.75\\ is rational, because \\0.75 = \frac{3}{4}\\.
> - Every integer is rational: for example, \\-5 = \frac{-5}{1}\\.
> - \\0.333\ldots\\, with the \\3\\s repeating forever, is rational, because \\0.333\ldots = \frac{1}{3}\\.

> **NOTE:**
>
> **Definition 6 (Irrational numbers)** An **irrational number** ([Wikipedia contributors 2026c](#ref-wikipedia_irrational_number)) is a real number ([Definition: Real numbers](../chapters/sets.llms.md#def-real-numbers)) that is not rational ([Definition 5](#def-rational-numbers)).

> **NOTE:**
>
> **Example 9 (Irrational numbers)**  
>
> - \\\sqrt{2} = 1.41421\ldots\\, the [square root](https://morrison-lab.github.io/mds/algebra.html#def-square-root) of \\2\\, is irrational: no fraction of integers \\\frac{a}{b}\\ squares to \\2\\ ([Wikipedia contributors 2026i](#ref-wikipedia_square_root_of_2)).
> - \\\pi = 3.14159\ldots\\ is irrational ([Wikipedia contributors 2026g](#ref-wikipedia_proof_that_pi_is_irrational)).
> - \\1.5\\ is not irrational, because \\1.5 = \frac{3}{2}\\ is rational.

> **NOTE:**
>
> *Remark 5* (Smallest elements). These notes use one more fact about the integers without proving it ([Wikipedia contributors 2026j](#ref-wikipedia_well_ordering_principle)):
>
> - every set of positive integers that has at least one element has a smallest element.
>
> For example, the set of positive integers \\b\\ for which \\\frac{3}{4} b\\ is an integer has the elements \\4\\, \\8\\, \\12\\ and so on, and its smallest element is \\4\\.

> **NOTE:**
>
> **Theorem 3 (\\\sqrt{2}\\ is irrational)** The square root of \\2\\ is irrational ([Definition 6](#def-irrational-numbers)) ([Wikipedia contributors 2026i](#ref-wikipedia_square_root_of_2)).

> **NOTE:**
>
> *Proof*. Suppose, for contradiction, that \\\sqrt{2}\\ is rational ([Definition 5](#def-rational-numbers)). Then \\\sqrt{2} = \frac{a}{b}\\ for some integers \\a\\ and \\b\\ with \\b \ne 0\\. Since \\\sqrt{2} \> 0\\, we can take \\a\\ and \\b\\ positive (if \\b \< 0\\, replace \\a\\ and \\b\\ with \\-a\\ and \\-b\\). So the set of positive integers \\b\\ for which \\\sqrt{2}\\ b\\ is an integer has an element, and by [Remark 5](#rem-well-ordering) it has a smallest element. Let \\b\\ be that smallest element, and let \\a = \sqrt{2}\\ b\\, a positive integer.
>
> By [Solution 6](#sol-sqrt-bounds), \\b \< a \< 2b\\, so \\b' = a - b\\ is an integer with \\0 \< b' \< b\\. Let \\a' = 2b - a\\, also an integer. Then
>
> \\ \begin{aligned} \sqrt{2}\\ b' &= \sqrt{2}\\ (a - b) && \text{(definition of } b' \text{)} \\&= \sqrt{2}\\ a - \sqrt{2}\\ b && \text{(distributive law)} \\&= \sqrt{2}\\ \sqrt{2}\\ b - a && \text{(substitute } a = \sqrt{2}\\ b \text{ in the first term, and } \sqrt{2}\\ b = a \text{ in the second)} \\&= 2b - a && \text{(} \sqrt{2}\\ \sqrt{2} = 2 \text{)} \\&= a'. && \text{(definition of } a' \text{)} \end{aligned} \\
>
> So \\b'\\ is a positive integer for which \\\sqrt{2}\\ b'\\ is an integer, and \\b' \< b\\. That contradicts the choice of \\b\\ as the smallest such integer. So \\\sqrt{2}\\ is not rational.

> **NOTE:**
>
> **Example 10 (The step in the proof, on a fraction near \\\sqrt{2}\\)** The proof of [Theorem 3](#thm-sqrt-two) turns a fraction \\\frac{a}{b}\\ into \\\frac{2b - a}{a - b}\\. Applied to \\\frac{7}{5} = 1.4\\, whose square is \\\frac{49}{25} = 1.96\\, it gives \\\frac{10 - 7}{7 - 5} = \frac{3}{2} = 1.5\\, whose square is \\\frac{9}{4} = 2.25\\. Neither fraction is exactly \\\sqrt{2}\\, and the step moved from denominator \\5\\ to the smaller denominator \\2\\. If some fraction were exactly \\\sqrt{2}\\, the step would give another fraction exactly equal to \\\sqrt{2}\\, with a smaller positive denominator, and a smallest positive denominator could not exist.

# 5 Infinitely many primes

> **NOTE:**
>
> **Exercise 7 (Which are prime?)** Which of \\51\\, \\53\\ and \\57\\ have no positive divisors other than \\1\\ and themselves? Hint: try dividing by \\2\\, \\3\\, \\5\\ and \\7\\.

> **NOTE:**
>
> *Solution 7*.
>
> - \\51 = 3 \cdot 17\\, so \\3\\ divides \\51\\ ([Definition: Divides](../chapters/direct-proof.llms.md#def-divides)).
> - \\57 = 3 \cdot 19\\, so \\3\\ divides \\57\\.
> - \\53\\ is not divisible by \\2\\, \\3\\, \\5\\ or \\7\\, because it lies strictly between two multiples of each: \\2 \cdot 26 = 52 \< 53 \< 54 = 2 \cdot 27\\, \\3 \cdot 17 = 51 \< 53 \< 54 = 3 \cdot 18\\, \\5 \cdot 10 = 50 \< 53 \< 55 = 5 \cdot 11\\, and \\7 \cdot 7 = 49 \< 53 \< 56 = 7 \cdot 8\\. A divisor \\d\\ of \\53\\ with \\1 \< d \< 53\\ would pair with \\\frac{53}{d}\\, and one of the two would be at most \\7\\, because \\8 \cdot 8 = 64 \> 53\\. It would be one of \\2, \ldots, 7\\, and \\4\\ or \\6\\ would make \\2\\ a divisor too, since \\2\\ divides both ([Exercise: Divisors of divisors](../chapters/direct-proof.llms.md#exr-divides-transitive)). So \\53\\ has no positive divisors other than \\1\\ and \\53\\.

> **NOTE:**
>
> **Definition 7 (Prime number)** An integer \\n \ge 2\\ is **prime** if its only positive divisors ([Definition: Divides](../chapters/direct-proof.llms.md#def-divides)) are \\1\\ and \\n\\ ([Wikipedia contributors 2026e](#ref-wikipedia_prime_number)).

> **NOTE:**
>
> **Example 11 (Prime and not prime)**  
>
> - \\2\\, \\3\\, \\5\\, \\7\\, \\11\\ and \\13\\ are prime.
> - \\9\\ is not prime, because \\3 \mid 9\\, and \\3\\ is neither \\1\\ nor \\9\\.
> - \\1\\ is not prime, because [Definition 7](#def-prime) applies only to integers \\n \ge 2\\.

> **NOTE:**
>
> *Remark 6* (Every integer above one has a prime divisor). These notes use one more fact without proving it:
>
> - every integer \\n \ge 2\\ is divisible by at least one prime ([Definition 7](#def-prime)).
>
> For example, \\91\\ is divisible by the primes \\7\\ and \\13\\, since \\91 = 7 \cdot 13\\.

> **NOTE:**
>
> **Theorem 4 (There are infinitely many primes)** There are infinitely many prime numbers ([Definition 7](#def-prime)) ([Wikipedia contributors 2026b](#ref-wikipedia_euclids_theorem)).

> **NOTE:**
>
> *Proof*. Suppose, for contradiction, that there are only finitely many primes, and list them all as \\p_1, p_2, \ldots, p_k\\. The list is not empty, because \\2\\ is prime. Let
>
> \\ N = p_1 p_2 \cdots p_k + 1. \\
>
> Each \\p_i \ge 2\\, so \\N \ge 3\\, and by [Remark 6](#rem-prime-divisor) some prime \\p\\ divides \\N\\: \\N = p s\\ for some integer \\s\\. The list holds every prime, so \\p\\ is one of \\p_1, \ldots, p_k\\, and so \\p\\ also divides their product: \\p_1 p_2 \cdots p_k = p t\\ for some integer \\t\\. Then
>
> \\ \begin{aligned} 1 &= N - p_1 p_2 \cdots p_k && \text{(definition of } N \text{)} \\&= p s - p t && \text{(substitute both products)} \\&= p (s - t). && \text{(distributive law, read from right to left)} \end{aligned} \\
>
> Since \\s - t\\ is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), \\p \mid 1\\. But \\p \ge 2\\, and \\p \cdot 0 = 0 \< 1 \< p = p \cdot 1\\, so no integer \\c\\ has \\p c = 1\\, and \\p \nmid 1\\. That is a contradiction, so there are infinitely many primes.

> **NOTE:**
>
> **Example 12 (The number \\N\\ in the proof)** The proof of [Theorem 4](#thm-infinitely-many-primes) does not claim that \\N\\ is prime.
>
> - From the list \\2, 3, 5\\, \\N = 2 \cdot 3 \cdot 5 + 1 = 31\\, which is prime.
> - From the list \\2, 3, 5, 7, 11, 13\\, \\N = 30030 + 1 = 30031 = 59 \cdot 509\\, which is not prime. Its prime divisors \\59\\ and \\509\\ are not in the list, which is what the proof needs: every list of primes misses some prime.

# 6 Choosing a method

> **NOTE:**
>
> *Remark 7* (Which method to try).
>
> - Try a direct proof ([Definition: Direct proof](../chapters/direct-proof.llms.md#def-direct-proof)) first.
> - Try the contrapositive ([Definition 3](#def-proof-by-contrapositive)) when \\\neg Q\\ is the easier assumption ([Remark 2](#rem-contrapositive-template)).
> - Try contradiction ([Definition 4](#def-proof-by-contradiction)) when the proposition says that something does not exist or is not true, as in “no integers satisfy”, “is irrational” or “infinitely many”: its negation hands you an object to work with.

# References

Wikipedia contributors. 2026a. *Contraposition — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Contraposition>.

Wikipedia contributors. 2026b. *Euclid’s Theorem — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Euclid%27s_theorem>.

Wikipedia contributors. 2026c. *Irrational Number — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Irrational_number>.

Wikipedia contributors. 2026d. *Modular Arithmetic — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Modular_arithmetic>.

Wikipedia contributors. 2026e. *Prime Number — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Prime_number>.

Wikipedia contributors. 2026f. *Proof by Contradiction — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Proof_by_contradiction>.

Wikipedia contributors. 2026g. *Proof That Pi Is Irrational — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Proof_that_%CF%80_is_irrational>.

Wikipedia contributors. 2026h. *Rational Number — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Rational_number>.

Wikipedia contributors. 2026i. *Square Root of 2 — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Square_root_of_2>.

Wikipedia contributors. 2026j. *Well-Ordering Principle — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Well-ordering_principle>.

Back to top
