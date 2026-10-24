# Inference and Direct Proof

Code

What follows from what, and how to write it down

Published

Last modified: 2026-10-24 10:49:25 (PDT)

> **NOTE:**
>
> Adapted from Kameron Decker Harris’s Fall 2026 lecture notes “Logic 4, Proofs Intro, Direct Proof”, which are typed transcriptions of Scott Wehrwein’s Spring 2025 handwritten lecture notes. The rules of inference, the definition of “divides”, the observation that a definition’s “if” means “if and only if”, the template for a direct proof, and the ideas of proof by cases and “without loss of generality” come from those notes; the exercises are new.
>
> The definitions of logical entailment, the integers, even and odd integers, and proof are included from the [mathematics prerequisites](https://morrison-lab.github.io/mds/) notes, so they read the same in both places.

# 1 Rules of inference

> **NOTE:**
>
> **Exercise 1 (Which conclusions are safe?)** Let \\P\\ be “the tests pass”, \\Q\\ be “the build is deployed” and \\R\\ be “the build is rolled back”. Each argument below lists some propositions, then “so”, then one more proposition. For each argument, decide whether the proposition after “so” must be true whenever all of the propositions before it are true.
>
> 1.  \\P \Rightarrow Q\\ and \\P\\, so \\Q\\.
> 2.  \\P \Rightarrow Q\\ and \\Q\\, so \\P\\.
> 3.  \\P \Rightarrow Q\\ and \\\neg Q\\, so \\\neg P\\.
> 4.  \\P \lor R\\ and \\\neg R\\, so \\P\\.

> **NOTE:**
>
> *Solution 1*.
>
> 1.  Yes. \\P \Rightarrow Q\\ is false when \\P\\ is true and \\Q\\ is false ([Definition: Implies](../chapters/propositional-logic.llms.md#def-implies)), so if \\P \Rightarrow Q\\ and \\P\\ are both true, \\Q\\ is true.
> 2.  No. If the tests fail but someone deploys the build by hand, \\P\\ is false and \\Q\\ is true. Then \\P \Rightarrow Q\\ and \\Q\\ are both true, and \\P\\ is false.
> 3.  Yes. \\\neg Q\\ is true, so \\Q\\ is false ([Definition: Not](../chapters/propositional-logic.llms.md#def-not)). If \\P\\ were true, \\P \Rightarrow Q\\ would be false, so \\P\\ is false and \\\neg P\\ is true.
> 4.  Yes. \\\neg R\\ is true, so \\R\\ is false ([Definition: Not](../chapters/propositional-logic.llms.md#def-not)). \\P \lor R\\ is true only if \\P\\ or \\R\\ is true ([Definition: Or](../chapters/propositional-logic.llms.md#def-or)), so \\P\\ is true.

> **NOTE:**
>
> **Definition 1 (Argument)** An **argument** is a list of propositions ([Definition: Proposition (statement)](../chapters/propositional-logic.llms.md#def-proposition)), called its premises, together with one more proposition, called its conclusion. An argument is written with “so” or \\\therefore\\ before its conclusion.

> **NOTE:**
>
> *Remark 1* (Two uses of “premise” and “conclusion”). The premise and conclusion of a conditional \\P \Rightarrow Q\\ ([Remark: Names for the parts, and other notation](../chapters/propositional-logic.llms.md#rem-implies-terms)) are its parts \\P\\ and \\Q\\. The premises and conclusion of an argument ([Definition 1](#def-argument)) are whole propositions: in argument 1 of [Exercise 1](#exr-valid-arguments), the premises are \\P \Rightarrow Q\\ and \\P\\, and the conclusion is \\Q\\.

> **NOTE:**
>
> **Definition 2 (Logical entailment (logical consequence, deductive consequence))** Propositions or predicates \\P_1, \ldots, P_n\\ ([Definition: Proposition (statement)](../chapters/propositional-logic.llms.md#def-proposition), [Definition: Predicate](../chapters/propositional-logic.llms.md#def-predicate)) **logically entail** ([Wikipedia contributors 2026b](#ref-wikipedia_logical_consequence)) a proposition or predicate \\Q\\ when every choice of values for their variables that makes all of \\P_1, \ldots, P_n\\ true also makes \\Q\\ true. Then \\Q\\ is a **logical consequence**, or **deductive consequence**, of \\P_1, \ldots, P_n\\.

> **NOTE:**
>
> **Example 1 (Entailment in the deployment arguments)** In [Exercise 1](#exr-valid-arguments), the premises of arguments 1, 3 and 4 ([Definition 1](#def-argument)) logically entail their conclusions ([Definition 2](#def-logical-entailment)). The premises of argument 2 do not: the values \\P\\ false and \\Q\\ true make both premises true and the conclusion false.

> **NOTE:**
>
> **Definition 3 (Rule of inference)** A **rule of inference** is a pattern of argument ([Definition 1](#def-argument)), written in terms of propositions \\P, Q, \ldots\\, whose premises logically entail its conclusion ([Definition 2](#def-logical-entailment)) whatever propositions are put in place of \\P, Q, \ldots\\. It is written with its premises above a line and its conclusion below: \\ \frac{P_1, \ldots, P_n}{Q}. \\

> **NOTE:**
>
> **Example 2 (Modus ponens)** Argument 1 of [Exercise 1](#exr-valid-arguments) follows the pattern \\ \frac{P \Rightarrow Q, \quad P}{Q}, \\ called modus ponens. It is a rule of inference ([Definition 3](#def-rule-of-inference)): by [Solution 1](#sol-valid-arguments), its premises entail its conclusion for any propositions \\P\\ and \\Q\\, not only for tests and builds.

> **NOTE:**
>
> **Theorem 1 (Common rules of inference)** For propositions \\P\\ and \\Q\\, each of the following is a rule of inference ([Definition 3](#def-rule-of-inference)):
>
> 1.  modus ponens: \\ \frac{P \Rightarrow Q, \quad P}{Q} \\
> 2.  modus tollens: \\ \frac{P \Rightarrow Q, \quad \neg Q}{\neg P} \\
> 3.  disjunctive syllogism: \\ \frac{P \lor Q, \quad \neg P}{Q} \\
> 4.  simplification: \\ \frac{P \land Q}{P} \\
> 5.  conjunction: \\ \frac{P, \quad Q}{P \land Q} \\
> 6.  addition: \\ \frac{P}{P \lor Q} \\

> **NOTE:**
>
> *Proof*. For each rule, suppose every premise is true, and show that the conclusion is true.
>
> 1.  \\P \Rightarrow Q\\ is false when \\P\\ is true and \\Q\\ is false ([Definition: Implies](../chapters/propositional-logic.llms.md#def-implies)). \\P\\ is true and \\P \Rightarrow Q\\ is true, so \\Q\\ is not false.
> 2.  \\\neg Q\\ is true, so \\Q\\ is false ([Definition: Not](../chapters/propositional-logic.llms.md#def-not)). If \\P\\ were true, \\P \Rightarrow Q\\ would be false, so \\P\\ is false and \\\neg P\\ is true.
> 3.  \\\neg P\\ is true, so \\P\\ is false. \\P \lor Q\\ is true only if \\P\\ or \\Q\\ is true ([Definition: Or](../chapters/propositional-logic.llms.md#def-or)), so \\Q\\ is true.
> 4.  \\P \land Q\\ is true only if both \\P\\ and \\Q\\ are true ([Definition: And](../chapters/propositional-logic.llms.md#def-and)), so \\P\\ is true.
> 5.  \\P\\ and \\Q\\ are both true, so \\P \land Q\\ is true ([Definition: And](../chapters/propositional-logic.llms.md#def-and)).
> 6.  \\P\\ is true, so \\P \lor Q\\ is true ([Definition: Or](../chapters/propositional-logic.llms.md#def-or)).

> **NOTE:**
>
> **Example 3 (Modus tollens on a slow page)** “If the cache is warm, then the page loads in under a second” and “the page did not load in under a second” together give “the cache is not warm”, by modus tollens ([Theorem 1](#thm-inference-rules)).

> **NOTE:**
>
> *Remark 2* (Two arguments that are not rules of inference). Argument 2 of [Exercise 1](#exr-valid-arguments), \\ \frac{P \Rightarrow Q, \quad Q}{P}, \\ is called affirming the consequent, since it concludes \\P\\ from the consequent \\Q\\ of \\P \Rightarrow Q\\ ([Remark: Names for the parts, and other notation](../chapters/propositional-logic.llms.md#rem-implies-terms)). It is not a rule of inference ([Definition 3](#def-rule-of-inference)): \\P\\ false and \\Q\\ true make its premises true and its conclusion false.
>
> Denying the antecedent, \\ \frac{P \Rightarrow Q, \quad \neg P}{\neg Q}, \\ fails for the same values of \\P\\ and \\Q\\. Both read like modus ponens or modus tollens ([Theorem 1](#thm-inference-rules)), which is why they are common mistakes.

# 2 Even, odd and divisible

> **NOTE:**
>
> **Exercise 2 (Two times something, plus maybe one)** Write each of \\14\\, \\15\\, \\-7\\ and \\0\\ as \\2k\\ or as \\2k + 1\\, for an integer \\k\\.

> **NOTE:**
>
> *Solution 2*.
>
> - \\14 = 2 \cdot 7\\.
> - \\15 = 2 \cdot 7 + 1\\.
> - \\-7 = 2 \cdot (-4) + 1\\.
> - \\0 = 2 \cdot 0\\.

> **NOTE:**
>
> **Definition 4 (Integers)** The **integers** ([Wikipedia contributors 2026a](#ref-wikipedia_integer)) are the whole numbers, together with their negatives and \\0\\:
>
> \\\mathbb{Z} \stackrel{\text{def}}{=}\mathopen{}\left\\\ldots, -3, -2, -1, 0, 1, 2, 3, \ldots\right\\\mathclose{}\\
>
> An **integer** is an element of \\\mathbb{Z}\\.

> **NOTE:**
>
> **Definition 5 (Positive integers)** The integers ([Definition 4](#def-integers)) greater than \\0\\ are the **positive integers**.

> **NOTE:**
>
> **Definition 6 (Negative integers)** The integers ([Definition 4](#def-integers)) less than \\0\\ are the **negative integers**.

> **NOTE:**
>
> **Example 4 (Integers and non-integers)**  
>
> - \\-7\\, \\0\\, and \\12\\ are integers.
> - \\\frac{1}{2}\\ and \\-2.5\\ are not integers.
> - \\\frac{6}{3}\\ is an integer, because \\\frac{6}{3} = 2\\.

> **NOTE:**
>
> **Definition 7 (Even integer)** An integer ([Definition 4](#def-integers)) \\n\\ is **even** ([Wikipedia contributors 2026d](#ref-wikipedia_parity_mathematics)) if \\n = 2k\\ for some integer \\k\\.

> **NOTE:**
>
> **Definition 8 (Odd integer)** An integer ([Definition 4](#def-integers)) \\n\\ is **odd** ([Wikipedia contributors 2026d](#ref-wikipedia_parity_mathematics)) if \\n = 2k + 1\\ for some integer \\k\\.

> **NOTE:**
>
> **Example 5 (Even and odd integers)**  
>
> - \\6\\ is even, because \\6 = 2 \cdot 3\\.
> - \\0\\ is even, because \\0 = 2 \cdot 0\\.
> - \\-3\\ is odd, because \\-3 = 2 \cdot(-2) + 1\\.
> - \\7\\ is odd, because \\7 = 2 \cdot 3 + 1\\.
> - \\2.5\\ is neither even nor odd, because it is not an integer.

> **NOTE:**
>
> *Remark 3* (Facts about integers used without proof). These notes use two facts about the integers ([Definition 4](#def-integers)) without proving them:
>
> - the sum, difference and product of two integers are integers;
> - every integer is even or odd ([Definition 7](#def-even-odd), [Definition 8](#def-odd)), and none is both.

> **NOTE:**
>
> *Remark 4* (A definition’s “if” means “if and only if”). [Definition 7](#def-even-odd) says that \\n\\ is even “if” \\n = 2k\\ for some integer \\k\\, but it means “if and only if” ([Definition: If and only if](../chapters/propositional-logic.llms.md#def-iff)): an integer is even exactly when it can be written as \\2k\\. So a proof can use a definition in both directions: to show that \\n\\ is even, write \\n\\ as \\2k\\; and from “\\n\\ is even”, conclude that \\n = 2k\\ for some integer \\k\\.

> **NOTE:**
>
> **Definition 9 (Divides)** Let \\a\\ and \\b\\ be integers ([Definition 4](#def-integers)). We say that \\a\\ **divides** \\b\\, written \\a \mid b\\, if \\b = a c\\ for some integer \\c\\. When \\a\\ does not divide \\b\\, we write \\a \nmid b\\.

> **NOTE:**
>
> **Example 6 (Divisors)**  
>
> - \\3 \mid 12\\, because \\12 = 3 \cdot 4\\.
> - \\-2 \mid 6\\, because \\6 = (-2) \cdot (-3)\\.
> - \\3 \nmid 13\\: \\3 c\\ increases with \\c\\, \\3 \cdot 4 = 12\\ and \\3 \cdot 5 = 15\\, and there is no integer between \\4\\ and \\5\\, so no integer \\c\\ gives \\3 c = 13\\.
> - Every integer \\a\\ divides \\0\\, because \\0 = a \cdot 0\\.
> - \\0\\ divides only \\0\\, because \\0 \cdot c = 0\\ for every integer \\c\\.

> **NOTE:**
>
> *Remark 5* (Divisibility in Racket). For a nonzero integer `a`, Racket’s `(remainder b a)` returns `0` exactly when \\a \mid b\\ ([Definition 9](#def-divides)), so `(zero? (remainder b a))` tests divisibility. `(zero? (remainder 12 3))` returns `#t` and `(zero? (remainder 13 3))` returns `#f`, as in [Example 6](#exm-divides). `(remainder 12 0)` raises an error, so a Racket test of \\a \mid b\\ has to handle \\a = 0\\ on its own.

# 3 Direct proof

> **NOTE:**
>
> **Exercise 3 (An odd input)** Show that if \\n\\ is an odd integer, then \\3 n + 5\\ is even.
>
> > **TIP:**
> >
> > What does [Definition 8](#def-odd) let you write in place of \\n\\?

> **NOTE:**
>
> *Solution 3*. Suppose \\n\\ is an odd integer. By [Definition 8](#def-odd), \\n = 2 k + 1\\ for some integer \\k\\. Then \\ 3 n + 5 = 3 (2 k + 1) + 5 = 6 k + 3 + 5 = 6 k + 8 = 2 (3 k + 4). \\ Since \\3 k + 4\\ is an integer ([Remark 3](#rem-integer-closure)), \\3 n + 5\\ is even, by [Definition 7](#def-even-odd).

> **NOTE:**
>
> **Definition 10 (Proof)** A **proof** ([Wikipedia contributors 2026c](#ref-wikipedia_mathematical_proof)) of a proposition ([Definition: Proposition (statement)](../chapters/propositional-logic.llms.md#def-proposition)) is a finite list of statements that ends with that proposition, in which each statement is
>
> - an assumption,
> - a definition,
> - a previously proved result, or
> - a consequence of earlier statements in the list, by one rule of logic or algebra.

> **NOTE:**
>
> **Example 7 (A proof, statement by statement)** [Solution 3](#sol-odd-linear) is a proof ([Definition 10](#def-proof)) of “\\3 n + 5\\ is even” in which “\\n\\ is an odd integer” is an assumption. Its statements are:
>
> - the assumption: \\n\\ is an odd integer;
> - a definition: \\n = 2 k + 1\\ for some integer \\k\\, by [Definition 8](#def-odd);
> - consequences by algebra: \\3 n + 5 = 6 k + 8 = 2 (3 k + 4)\\;
> - a definition: \\3 n + 5\\ is even, by [Definition 7](#def-even-odd), since \\3 k + 4\\ is an integer.

> **NOTE:**
>
> **Definition 11 (Direct proof)** A **direct proof** of a conditional \\P \Rightarrow Q\\ ([Definition: Implies](../chapters/propositional-logic.llms.md#def-implies)) is a proof ([Definition 10](#def-proof)) of \\Q\\ in which \\P\\ is an assumption.

> **NOTE:**
>
> **Example 8 (A direct proof)** [Solution 3](#sol-odd-linear) is a direct proof ([Definition 11](#def-direct-proof)) of “if \\n\\ is an odd integer, then \\3 n + 5\\ is even”: it assumes \\P\\, “\\n\\ is an odd integer”, and ends with \\Q\\, “\\3 n + 5\\ is even”.

> **NOTE:**
>
> *Remark 6* (The shape of a direct proof). A direct proof ([Definition 11](#def-direct-proof)) of “if \\P\\, then \\Q\\” has this shape:
>
> > Suppose \\P\\.\
> > \\\vdots\\\
> > Therefore \\Q\\.
>
> Write the first and last lines first, then fill in the middle, usually by replacing each defined term with its definition ([Remark 4](#rem-definitions-iff)).
>
> A direct proof proves \\P \Rightarrow Q\\: when \\P\\ is true, the proof shows that \\Q\\ is true, and when \\P\\ is false, \\P \Rightarrow Q\\ is true anyway ([Definition: Implies](../chapters/propositional-logic.llms.md#def-implies)).
>
> When the statement is about every element of a set, as in “for every odd integer \\n\\” ([Definition: Universal quantifier](../chapters/predicates-quantifiers.llms.md#def-universal-quantifier)), the proof starts from an arbitrary element: “Suppose \\n\\ is an odd integer.” Since the proof uses nothing about \\n\\ except that \\n\\ is odd, the same steps work for every odd integer.

> **NOTE:**
>
> **Exercise 4 (Divisors of divisors)** Let \\a\\, \\b\\ and \\c\\ be integers. Prove that if \\a \mid b\\ and \\b \mid c\\, then \\a \mid c\\.

> **NOTE:**
>
> *Solution 4*. Suppose \\a \mid b\\ and \\b \mid c\\. By [Definition 9](#def-divides), \\b = a j\\ and \\c = b k\\ for some integers \\j\\ and \\k\\. Then \\ c = b k = (a j) k = a (j k). \\ Since \\j k\\ is an integer ([Remark 3](#rem-integer-closure)), \\a \mid c\\, by [Definition 9](#def-divides).

# 4 Proof by cases

> **NOTE:**
>
> **Exercise 5 (Even for every integer)** Prove that \\n^2 + n\\ is even for every integer \\n\\.
>
> > **TIP:**
> >
> > Every integer is even or odd ([Remark 3](#rem-integer-closure)). Handle the two kinds separately.

> **NOTE:**
>
> *Solution 5*. Let \\n\\ be an integer. Every integer is even or odd ([Remark 3](#rem-integer-closure)), so one of these cases holds.
>
> **Case 1: \\n\\ is even.** By [Definition 7](#def-even-odd), \\n = 2 k\\ for some integer \\k\\, and \\ n^2 + n = (2 k)^2 + 2 k = 4 k^2 + 2 k = 2 (2 k^2 + k). \\
>
> **Case 2: \\n\\ is odd.** By [Definition 8](#def-odd), \\n = 2 k + 1\\ for some integer \\k\\, and \\ n^2 + n = (2 k + 1)^2 + (2 k + 1) = (4 k^2 + 4 k + 1) + (2 k + 1) = 4 k^2 + 6 k + 2 = 2 (2 k^2 + 3 k + 1). \\
>
> In each case, \\n^2 + n\\ is \\2\\ times an integer ([Remark 3](#rem-integer-closure)), so \\n^2 + n\\ is even, by [Definition 7](#def-even-odd).

> **NOTE:**
>
> **Definition 12 (Proof by cases)** A **proof by cases** splits the situation into cases that together cover every possibility, and proves the conclusion separately in each case.

> **NOTE:**
>
> **Example 9 (Two cases)** [Solution 5](#sol-consecutive-product) is a proof by cases ([Definition 12](#def-proof-by-cases)): every integer is even or odd ([Remark 3](#rem-integer-closure)), so its two cases cover every integer \\n\\.

> **NOTE:**
>
> **Exercise 6 (Larger plus smaller)** For real numbers \\x\\ and \\y\\, let \\\max(x, y)\\ be the larger of \\x\\ and \\y\\ and \\\min(x, y)\\ the smaller (both equal \\x\\ when \\x = y\\). Prove that \\\max(x, y) + \min(x, y) = x + y\\.

> **NOTE:**
>
> *Solution 6*. Let \\x\\ and \\y\\ be real numbers. Either \\x \le y\\ or \\y \le x\\. Both sides of the equation stay the same when \\x\\ and \\y\\ are swapped, so without loss of generality, suppose \\x \le y\\. Then \\\max(x, y) = y\\ and \\\min(x, y) = x\\, so \\ \max(x, y) + \min(x, y) = y + x = x + y. \\

> **NOTE:**
>
> *Remark 7* (Without loss of generality). [Solution 6](#sol-max-min) is a proof by cases ([Definition 12](#def-proof-by-cases)) with two cases, \\x \le y\\ and \\y \le x\\. The proof of the second case is the proof of the first with the names \\x\\ and \\y\\ swapped, which changes neither side of the equation. “Without loss of generality, suppose \\x \le y\\” says this, and writes out only the first case. Use it only when the other cases really are the same proof with names changed.

# References

Wikipedia contributors. 2026a. *Integer — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Integer>.

Wikipedia contributors. 2026b. *Logical Consequence — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Logical_consequence>.

Wikipedia contributors. 2026c. *Mathematical Proof — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Mathematical_proof>.

Wikipedia contributors. 2026d. *Parity (Mathematics) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Parity_(mathematics)>.

Back to top
