# Proving Non-Conditional Statements

Code

If and only if, existence, and disproof

Published

Last modified: 2026-10-30 11:32:11 (PDT)

> **NOTE:**
>
> Adapted from Kameron Decker Harris’s Fall 2026 lecture notes “Proving Non-Conditional Statements, Disproof”, which are typed transcriptions of Scott Wehrwein’s Spring 2025 handwritten lecture notes. These come from those notes:
>
> - the outline of an “if and only if” proof;
> - the outline of an existence proof that names an element;
> - proving that several propositions are equivalent with a cycle of conditionals;
> - the constructive example of half of a positive number;
> - the non-constructive example of an irrational power of an irrational number;
> - disproving a proposition by proving its negation.
>
> The exercises are new.

# 1 Proving if and only if

> **NOTE:**
>
> **Exercise 1 (A sum of squares equal to zero)** Let \\x\\ and \\y\\ be real numbers. Prove: \\x^2 + y^2 = 0\\ if and only if \\x = 0\\ and \\y = 0\\ ([Definition: If and only if](../chapters/propositional-logic.llms.md#def-iff)).
>
> Hint: prove the two directions one at a time.

> **NOTE:**
>
> *Solution 1*. **If \\x = 0\\ and \\y = 0\\, then \\x^2 + y^2 = 0\\.** Suppose \\x = 0\\ and \\y = 0\\. Then \\x^2 + y^2 = 0^2 + 0^2 = 0\\.
>
> **If \\x^2 + y^2 = 0\\, then \\x = 0\\ and \\y = 0\\.** Suppose \\x^2 + y^2 = 0\\. A square of a real number is never negative, so \\y^2 \ge 0\\, and
>
> \\ \begin{aligned} x^2 &= -y^2 && \text{(subtract } y^2 \text{ from both sides of } x^2 + y^2 = 0 \text{)} \\&\le 0. && \text{(} y^2 \ge 0 \text{)} \end{aligned} \\
>
> Also \\x^2 \ge 0\\, so \\x^2 = 0\\, and so \\x = 0\\. The same steps with \\x\\ and \\y\\ swapped give \\y = 0\\.

> **NOTE:**
>
> **Theorem 1 (A biconditional is two conditionals)** For propositions \\P\\ and \\Q\\,
>
> \\ (P \Leftrightarrow Q) \equiv \mathopen{}\left((P \Rightarrow Q) \land (Q \Rightarrow P)\right)\mathclose{}. \\

> **NOTE:**
>
> *Proof*. The fifth and last columns of this truth table ([Definition: Truth table](../chapters/propositional-logic.llms.md#def-truth-table)) match in every row ([Definition: If and only if](../chapters/propositional-logic.llms.md#def-iff), [Definition: Implies](../chapters/propositional-logic.llms.md#def-implies), [Definition: And](../chapters/propositional-logic.llms.md#def-and)):
>
> | \\P\\ | \\Q\\ | \\P \Rightarrow Q\\ | \\Q \Rightarrow P\\ | \\(P \Rightarrow Q) \land (Q \Rightarrow P)\\ | \\P \Leftrightarrow Q\\ |
> |:--:|:--:|:--:|:--:|:--:|:--:|
> | T | T | T | T | T | T |
> | T | F | F | T | F | F |
> | F | T | T | F | F | F |
> | F | F | T | T | T | T |
>
> So the two propositions are logically equivalent ([Definition: Logical equivalence](../chapters/equivalence-negation.llms.md#def-logical-equivalence)).

> **NOTE:**
>
> **Example 1 (Proving both directions)** Claim: let \\n\\ be an integer. Then \\n\\ is even if and only if \\n + 2\\ is even.
>
> By [Theorem 1](#thm-biconditional-split), it is enough to prove two conditionals.
>
> - If \\n\\ is even, then \\n = 2k\\ for some integer \\k\\ ([Definition: Even integer](../chapters/direct-proof.llms.md#def-even-odd)), so \\n + 2 = 2k + 2 = 2(k + 1)\\, and \\k + 1\\ is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)). So \\n + 2\\ is even.
> - If \\n + 2\\ is even, then \\n + 2 = 2m\\ for some integer \\m\\, so \\n = 2m - 2 = 2(m - 1)\\, and \\m - 1\\ is an integer. So \\n\\ is even.

> **NOTE:**
>
> *Remark 1* (The shape of an “if and only if” proof). A proof of “\\P\\ if and only if \\Q\\” has two parts:
>
> > (\\\Rightarrow\\) Suppose \\P\\.\
> > \\\vdots\\\
> > Therefore \\Q\\.\
> > \
> > (\\\Leftarrow\\) Suppose \\Q\\.\
> > \\\vdots\\\
> > Therefore \\P\\.
>
> Each part is a proof of a conditional, so each can be a direct proof ([Definition: Direct proof](../chapters/direct-proof.llms.md#def-direct-proof)), a proof by contrapositive ([Definition: Proof by contrapositive](../chapters/contrapositive-contradiction.llms.md#def-proof-by-contrapositive)), or a proof by contradiction ([Definition: Proof by contradiction](../chapters/contrapositive-contradiction.llms.md#def-proof-by-contradiction)), and the two parts need not use the same method.

> **NOTE:**
>
> **Theorem 2 (A cycle of conditionals)** Let \\P_1, P_2, \ldots, P_k\\ be propositions. If \\P_1 \Rightarrow P_2\\, \\P_2 \Rightarrow P_3\\, \\\ldots\\, \\P\_{k-1} \Rightarrow P_k\\ and \\P_k \Rightarrow P_1\\ are all true, then \\P_1, \ldots, P_k\\ all have the same truth value.

> **NOTE:**
>
> *Proof*. Suppose one of the propositions, \\P_i\\, is true. By modus ponens ([Theorem: Common rules of inference](../chapters/direct-proof.llms.md#thm-inference-rules)), \\P_i \Rightarrow P\_{i+1}\\ makes \\P\_{i+1}\\ true, then \\P\_{i+1} \Rightarrow P\_{i+2}\\ makes \\P\_{i+2}\\ true, and so on around the cycle, with \\P_k \Rightarrow P_1\\ leading from \\P_k\\ back to \\P_1\\, until every proposition in the list is true. So either all of \\P_1, \ldots, P_k\\ are true, or none of them is true, and then all of them are false.

> **NOTE:**
>
> **Example 2 (Three ways to say “odd”)** Let \\n\\ be an integer, and consider
>
> - \\P_1\\: \\n\\ is odd;
> - \\P_2\\: \\n + 1\\ is even;
> - \\P_3\\: \\n - 1\\ is even.
>
> By [Theorem 2](#thm-equivalent-cycle), three conditionals show that all three have the same truth value.
>
> - \\P_1 \Rightarrow P_2\\: if \\n = 2k + 1\\ ([Definition: Odd integer](../chapters/direct-proof.llms.md#def-odd)), then \\n + 1 = 2k + 2 = 2(k + 1)\\.
> - \\P_2 \Rightarrow P_3\\: if \\n + 1 = 2m\\, then \\n - 1 = 2m - 2 = 2(m - 1)\\.
> - \\P_3 \Rightarrow P_1\\: if \\n - 1 = 2j\\, then \\n = 2j + 1\\.
>
> In each step the new multiplier, \\k + 1\\, \\m - 1\\ or \\j\\, is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)). Proving all six conditionals between pairs would have taken twice as many steps.

# 2 Proving existence

> **NOTE:**
>
> **Exercise 2 (A solution in integers)** Show that there are integers \\x\\ and \\y\\ with \\5x + 3y = 1\\.

> **NOTE:**
>
> *Solution 2*. Take \\x = 2\\ and \\y = -3\\. Then \\5x + 3y = 5 \cdot 2 + 3 \cdot(-3) = 10 - 9 = 1\\. So integers with \\5x + 3y = 1\\ exist ([Definition: Existential quantifier](../chapters/predicates-quantifiers.llms.md#def-existential-quantifier)). Other pairs work too, such as \\x = -1\\ and \\y = 2\\.

> **NOTE:**
>
> **Definition 1 (Constructive proof)** A **constructive proof** of a proposition \\\exists x \in S,\\ P(x)\\ ([Definition: Existential quantifier](../chapters/predicates-quantifiers.llms.md#def-existential-quantifier)) names a particular element of \\S\\ and shows that \\P\\ is true of it ([Wikipedia contributors 2026](#ref-wikipedia_constructive_proof)). A proposition with several existential quantifiers, such as “there are integers \\m\\ and \\n\\ with \\m + n = 1\\”, gets a constructive proof that names one element for each quantifier.

> **NOTE:**
>
> **Example 3 (Half of a positive number)** Claim: for every positive real number \\x\\, there is a positive real number \\y\\ with \\y \< x\\.
>
> Let \\x\\ be a positive real number. We give a constructive proof of “there is a positive real number \\y\\ with \\y \< x\\” for this \\x\\: take \\y = \frac{x}{2}\\. Then \\y \> 0\\, because \\x \> 0\\, and
>
> \\ \begin{aligned} x - y &= x - \frac{x}{2} && \text{(substitute } y = \tfrac{x}{2} \text{)} \\&= \frac{x}{2} && \text{(arithmetic)} \\&\> 0, && \text{(} x \> 0 \text{)} \end{aligned} \\
>
> so \\y \< x\\. The element named, \\\frac{x}{2}\\, depends on \\x\\, which a “for every \\x\\, there is a \\y\\” statement allows.
>
> The solution to [Exercise 2](#exr-five-three) is also a constructive proof: it names the integers \\2\\ and \\-3\\.

> **NOTE:**
>
> **Definition 2 (Non-constructive proof)** A **non-constructive proof** of a proposition \\\exists x \in S,\\ P(x)\\ shows that it is true without naming any element \\x\\ of \\S\\ for which \\P(x)\\ is true ([Wikipedia contributors 2026](#ref-wikipedia_constructive_proof)).

> **NOTE:**
>
> **Example 4 (An irrational power of an irrational number)** Claim: there are irrational numbers \\x\\ and \\y\\ ([Definition: Irrational numbers](../chapters/contrapositive-contradiction.llms.md#def-irrational-numbers)) for which \\x^y\\ is rational ([Definition: Rational numbers](../chapters/contrapositive-contradiction.llms.md#def-rational-numbers)).
>
> The number \\\sqrt{2}\\ is irrational ([Theorem: \\\sqrt{2}\\ is irrational](../chapters/contrapositive-contradiction.llms.md#thm-sqrt-two)). Consider \\\sqrt{2}^{\sqrt{2}}\\, and take two cases ([Definition: Proof by cases](../chapters/direct-proof.llms.md#def-proof-by-cases)).
>
> **Case 1: \\\sqrt{2}^{\sqrt{2}}\\ is rational.** Then \\x = \sqrt{2}\\ and \\y = \sqrt{2}\\ work.
>
> **Case 2: \\\sqrt{2}^{\sqrt{2}}\\ is irrational.** Then take \\x = \sqrt{2}^{\sqrt{2}}\\ and \\y = \sqrt{2}\\, both irrational, and
>
> \\ \begin{aligned} x^y &= \mathopen{}\left(\sqrt{2}^{\sqrt{2}}\right)\mathclose{}^{\sqrt{2}} && \text{(substitute } x \text{ and } y \text{)} \\&= \sqrt{2}^{\sqrt{2} \cdot\sqrt{2}} && \text{(a power of a power multiplies the exponents)} \\&= \sqrt{2}^{2} && \text{(} \sqrt{2} \cdot\sqrt{2} = 2 \text{)} \\&= 2, \end{aligned} \\
>
> which is rational, since \\2 = \frac{2}{1}\\.
>
> Every number is rational or irrational, so one of the cases holds, and the claim is true. The proof does not say which case holds, so it does not name a pair \\x, y\\ that works.

# 3 Disproof

> **NOTE:**
>
> **Exercise 3 (Prove or disprove)** Prove or disprove: for every real number \\x\\, if \\x^2 \> 1\\, then \\x \> 1\\.

> **NOTE:**
>
> *Solution 3*. The proposition is false. Take \\x = -2\\. Then \\x^2 = 4 \> 1\\, but \\x \> 1\\ is false. So \\x = -2\\ makes “if \\x^2 \> 1\\, then \\x \> 1\\” false ([Definition: Implies](../chapters/propositional-logic.llms.md#def-implies)), and so it is a counterexample ([Definition: Counterexample](../chapters/predicates-quantifiers.llms.md#def-counterexample)) to the proposition.

> **NOTE:**
>
> **Definition 3 (Disproof)** A **disproof** of a proposition \\P\\ is a proof ([Definition: Proof](../chapters/direct-proof.llms.md#def-proof)) of its negation, \\\neg P\\ ([Definition: Not](../chapters/propositional-logic.llms.md#def-not)).

> **NOTE:**
>
> **Example 5 (No integer squares to two)** Claim to disprove: there is an integer \\n\\ with \\n^2 = 2\\.
>
> By [Theorem: Negating a quantifier](../chapters/equivalence-negation.llms.md#thm-negate-quantifiers), its negation is “for every integer \\n\\, \\n^2 \ne 2\\”. We prove the negation by cases ([Definition: Proof by cases](../chapters/direct-proof.llms.md#def-proof-by-cases)). Let \\n\\ be an integer.
>
> - If \\n\\ is \\-1\\, \\0\\ or \\1\\, then \\n^2\\ is \\1\\, \\0\\ or \\1\\, which is not \\2\\.
> - Otherwise \\n \le -2\\ or \\n \ge 2\\, so \\\mathopen{}\left\|n\right\|\mathclose{} \ge 2\\, and \\n^2 = \mathopen{}\left\|n\right\|\mathclose{}^2 \ge 2^2 = 4\\, so \\n^2 \ne 2\\.

> **NOTE:**
>
> **Exercise 4 (An equation with a solution)** Prove or disprove: there are integers \\m\\ and \\n\\ with \\6m + 4n = 2\\.

> **NOTE:**
>
> *Solution 4*. The proposition is true. Take \\m = 1\\ and \\n = -1\\. Then \\6m + 4n = 6 - 4 = 2\\.

> **NOTE:**
>
> **Exercise 5 (An equation without a solution)** Prove or disprove: there are integers \\m\\ and \\n\\ with \\6m + 4n = 3\\.

> **NOTE:**
>
> *Solution 5*. The proposition is false. Applying [Theorem: Negating a quantifier](../chapters/equivalence-negation.llms.md#thm-negate-quantifiers) to each of its two quantifiers in turn, its negation is “for all integers \\m\\ and \\n\\, \\6m + 4n \ne 3\\”, and we prove that. Let \\m\\ and \\n\\ be integers. Then \\6m + 4n = 2(3m + 2n)\\, and \\3m + 2n\\ is an integer ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), so \\6m + 4n\\ is even ([Definition: Even integer](../chapters/direct-proof.llms.md#def-even-odd)). But \\3 = 2 \cdot 1 + 1\\ is odd ([Definition: Odd integer](../chapters/direct-proof.llms.md#def-odd)), and no integer is both even and odd ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), so \\6m + 4n \ne 3\\.

# Definitions on this page

- [Definition 1 (Constructive proof)](#def-constructive-proof)
- [Definition 2 (Non-constructive proof)](#def-nonconstructive-proof)
- [Definition 3 (Disproof)](#def-disproof)

# References

Wikipedia contributors. 2026. *Constructive Proof — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Constructive_proof>.

Back to top
