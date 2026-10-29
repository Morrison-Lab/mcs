# Predicates and Quantifiers

Code

For all, there exists, and the order they come in

Published

Last modified: 2026-10-29 12:51:24 (PDT)

> **NOTE:**
>
> Adapted from Kameron Decker Harris’s Fall 2026 lecture notes “Logic 2” and “Logic 3”, which are typed transcriptions of Scott Wehrwein’s Spring 2025 handwritten lecture notes. The convention that a conditional about a variable means “for all” comes from those notes; the exercises are new.
>
> The definitions are included from the [mathematics prerequisites](https://morrison-lab.github.io/mds/proof-writing.html#sec-proof-definitions) notes, so they read the same in both places.

# 1 Predicates

> **NOTE:**
>
> **Exercise 1 (Plug in a value)** Let \\L(s)\\ be the sentence “the string \\s\\ has more than 3 characters”.
>
> 1.  Is \\L(s)\\ true or false?
> 2.  What are the truth values of \\L(\texttt{"cat"})\\, \\L(\texttt{"logic"})\\ and \\L(\texttt{""})\\?

> **NOTE:**
>
> *Solution 1*.
>
> 1.  Neither: \\L(s)\\ has no truth value until we know which string \\s\\ is. It is a predicate ([Definition: Predicate](../chapters/propositional-logic.llms.md#def-predicate)), not a proposition ([Definition: Proposition (statement)](../chapters/propositional-logic.llms.md#def-proposition)).
>
> 2.  Each value of \\s\\ turns \\L(s)\\ into a proposition:
>
>     - \\L(\texttt{"cat"})\\ is false, since `"cat"` has 3 characters.
>     - \\L(\texttt{"logic"})\\ is true, since `"logic"` has 5 characters.
>     - \\L(\texttt{""})\\ is false, since the empty string has 0 characters.

> **NOTE:**
>
> **Definition 1 (Domain (domain of discourse, universe of discourse))** The **domain** of a predicate ([Definition: Predicate](../chapters/propositional-logic.llms.md#def-predicate)), also called its **domain of discourse** or **universe of discourse**, is the set of values its variable may take.

> **NOTE:**
>
> *Remark 1* (Predicates with more than one variable). A predicate can have more than one variable: “\\x \< y\\” is a predicate \\P(x, y)\\ in the two variables \\x\\ and \\y\\. Its domain ([Definition 1](#def-domain)) is a set of pairs, such as the pairs \\(x, y)\\ of real numbers.

> **NOTE:**
>
> *Remark 2* (Predicates in Racket). A Racket procedure that returns `#t` or `#f` is also called a predicate, and by convention its name ends in `?`, as in `even?` and `string?`. The predicate \\L(s)\\ from [Exercise 1](#exr-predicate-values) is
>
> ``` racket
> (define (long? s)
>   (> (string-length s) 3))
> ```
>
> and `(long? "logic")` returns `#t`.

# 2 Quantifiers

> **NOTE:**
>
> **Exercise 2 (All or some)** Let \\S = \\2, 3, 5, 7\\\\. Which of these four sentences are true?
>
> 1.  Every element of \\S\\ is prime.
> 2.  Every element of \\S\\ is odd.
> 3.  Some element of \\S\\ is even.
> 4.  Some element of \\S\\ is greater than 10.

> **NOTE:**
>
> *Solution 2*.
>
> 1.  True: \\2\\, \\3\\, \\5\\ and \\7\\ are all prime.
> 2.  False: \\2\\ is not odd. One element that fails is enough.
> 3.  True: \\2\\ is even. One element that works is enough.
> 4.  False: none of \\2\\, \\3\\, \\5\\ and \\7\\ is greater than \\10\\.

> **NOTE:**
>
> **Definition 2 (Quantifier)** A **quantifier** ([Wikipedia contributors 2026c](#ref-wikipedia_quantifier_logic)) turns a predicate \\P(x)\\ ([Definition: Predicate](../chapters/propositional-logic.llms.md#def-predicate)) about the elements \\x\\ of a set \\S\\ into a proposition ([Definition: Proposition (statement)](../chapters/propositional-logic.llms.md#def-proposition)). There are two, each defined next: the universal quantifier and the existential quantifier.

> **NOTE:**
>
> **Definition 3 (Universal quantifier)** The **universal quantifier** ([Wikipedia contributors 2026d](#ref-wikipedia_universal_quantification)) “for all” is a quantifier ([Definition 2](#def-quantifier)): \\\forall x \in S, P(x)\\ (“for every \\x\\ in \\S\\, \\P(x)\\”) is true when \\P(x)\\ is true for every element \\x\\ of \\S\\, and false otherwise.

> **NOTE:**
>
> **Definition 4 (Existential quantifier)** The **existential quantifier** ([Wikipedia contributors 2026b](#ref-wikipedia_existential_quantification)) “there exists” is a quantifier ([Definition 2](#def-quantifier)): \\\exists x \in S, P(x)\\ (“there is an \\x\\ in \\S\\ such that \\P(x)\\”) is true when \\P(x)\\ is true for at least one element \\x\\ of \\S\\, and false otherwise.

> **NOTE:**
>
> *Remark 3* (Reading and writing quantifiers). English has many phrasings of each quantifier:
>
> - \\\forall\\: “for all”, “for every”, “for each”, “for any”, “every”, “all”.
> - \\\exists\\: “there exists”, “there is”, “for some”, “some”, “at least one”.
>
> Books also differ in punctuation: \\\forall x \in S, P(x)\\ is also written \\\forall x \in S : P(x)\\, \\(\forall x \in S)\\ P(x)\\, or \\\forall x \in S .\\ P(x)\\. When the domain is clear, it is often left out, as in \\\forall x, P(x)\\.

> **NOTE:**
>
> *Remark 4* (Quantifiers in Racket). On a finite list, Racket computes the two quantifiers with `andmap` and `ormap`. `(andmap odd? (list 2 3 5 7))` returns `#f`, as in part 2 of [Exercise 2](#exr-finite-quantifiers), and `(ormap even? (list 2 3 5 7))` returns `#t`, as in part 3.

> **NOTE:**
>
> **Exercise 3 (Nothing to check)** Let \\\emptyset\\ be the empty set, the set with no elements. What are the truth values of \\\forall x \in \emptyset, x \> 5\\ and \\\exists x \in \emptyset, x \> 5\\?
>
> > **TIP:**
> >
> > What would make each one false?

> **NOTE:**
>
> *Solution 3*. \\\forall x \in \emptyset, x \> 5\\ is true. It would be false only if some element of \\\emptyset\\ were not greater than \\5\\, and \\\emptyset\\ has no elements.
>
> \\\exists x \in \emptyset, x \> 5\\ is false, since \\\emptyset\\ has no element at all, let alone one greater than \\5\\.
>
> Racket agrees: `(andmap positive? '())` returns `#t`, and `(ormap positive? '())` returns `#f`.

> **NOTE:**
>
> **Definition 5 (Vacuous truth)** A universally quantified proposition \\\forall x \in S, P(x)\\ whose domain \\S\\ is empty is **vacuously true**: it is true, because \\S\\ has no element \\x\\ for which \\P(x)\\ could be false.

# 3 Counterexamples

> **NOTE:**
>
> **Exercise 4 (A pattern that breaks)** Consider the claim “for every integer \\n \ge 0\\, \\n^2 + n + 41\\ is prime”.
>
> 1.  Check the claim for \\n = 0, 1, 2, 3\\.
> 2.  Find an integer \\n \ge 0\\ for which the claim fails.
>
> > **TIP:**
> >
> > Look for an \\n\\ that makes every term of \\n^2 + n + 41\\ a multiple of \\41\\.

> **NOTE:**
>
> *Solution 4*.
>
> 1.  The values are \\41\\, \\43\\, \\47\\ and \\53\\, which are all prime.
> 2.  Take \\n = 41\\: \\41^2 + 41 + 41 = 41 \cdot (41 + 1 + 1) = 41 \cdot 43\\, which is not prime. The value \\n = 40\\ also fails: \\40^2 + 40 + 41 = 1681 = 41^2\\.
>
> The claim held for every value we checked in part 1, and it is still false: checking some cases cannot prove a universal claim.

> **NOTE:**
>
> **Definition 6 (Counterexample)** A **counterexample** ([Wikipedia contributors 2026a](#ref-wikipedia_counterexample)) to a proposition of the form “for every \\x\\ in \\A\\, \\P(x)\\”, where \\P(x)\\ is a predicate ([Definition: Predicate](../chapters/propositional-logic.llms.md#def-predicate)), is an element \\x\\ of \\A\\ for which \\P(x)\\ is false. A single counterexample shows that the proposition is false.

> **NOTE:**
>
> *Remark 5* (One example, or every element). Settling a quantified proposition takes one element in two cases, and every element of the domain in the other two:
>
> - To show that \\\exists x \in S, P(x)\\ is true, it is enough to find one \\x\\ in \\S\\ with \\P(x)\\ true.
> - To show that \\\forall x \in S, P(x)\\ is false, it is enough to find one \\x\\ in \\S\\ with \\P(x)\\ false.
> - To show that \\\forall x \in S, P(x)\\ is true, show \\P(x)\\ for every \\x\\ in \\S\\.
> - To show that \\\exists x \in S, P(x)\\ is false, show that \\P(x)\\ is false for every \\x\\ in \\S\\.
>
> When \\S\\ is infinite, the last two need a proof rather than a check of each element.

# 4 Quantified conditionals

> **NOTE:**
>
> **Exercise 5 (A hidden “for all”)** Consider the sentence “if a string has more than 3 characters, then it is not empty”. Let \\L(s)\\ be “\\s\\ has more than 3 characters” and \\N(s)\\ be “\\s\\ is not empty”, for strings \\s\\.
>
> 1.  Write the sentence in symbols, with its quantifier.
> 2.  Is it true?
> 3.  Is its converse ([Definition: Converse](../chapters/propositional-logic.llms.md#def-converse)) true?

> **NOTE:**
>
> *Solution 5*.
>
> 1.  The sentence is about every string, so it is \\\forall s, (L(s) \Rightarrow N(s))\\.
> 2.  True: a string with more than 3 characters has at least 1 character, so it is not empty.
> 3.  The converse is \\\forall s, (N(s) \Rightarrow L(s))\\: “if a string is not empty, then it has more than 3 characters”. It is false. The string `"ab"` is a counterexample: it is not empty, but it has only 2 characters.

> **NOTE:**
>
> *Remark 6* (A conditional about a variable means “for all”). By convention, a conditional whose parts are predicates, such as “if \\x \> 3\\, then \\x \> 1\\”, means the universal statement \\\forall x, (x \> 3 \Rightarrow x \> 1)\\, even though no quantifier is written. Mathematical statements leave out “for all” in this way all the time, so put it back before deciding whether the statement is true.

# 5 Nested quantifiers

> **NOTE:**
>
> **Exercise 6 (Who takes what)** Three students take courses as follows.
>
> | Student | Courses  |
> |---------|----------|
> | Ana     | 201, 241 |
> | Ben     | 241      |
> | Cy      | 201, 247 |
>
> Let \\E(s, c)\\ be “student \\s\\ takes course \\c\\”, where \\s\\ ranges over the students and \\c\\ over the courses 201, 241 and 247. Which of these are true?
>
> 1.  \\\forall s, \exists c, E(s, c)\\
> 2.  \\\exists c, \forall s, E(s, c)\\
> 3.  \\\forall c, \exists s, E(s, c)\\
> 4.  \\\exists s, \forall c, E(s, c)\\

> **NOTE:**
>
> *Solution 6*.
>
> 1.  True: “every student takes some course”. Ana takes 201, Ben takes 241, and Cy takes 201.
> 2.  False: “some course is taken by every student”. Ben does not take 201, Cy does not take 241, and Ana does not take 247.
> 3.  True: “every course has some student”. Ana takes 201 and 241, and Cy takes 247.
> 4.  False: “some student takes every course”. Ana does not take 247, Ben does not take 201, and Cy does not take 241.
>
> Parts 1 and 2 use the same quantifiers and the same predicate in a different order, and they have different truth values.

> **NOTE:**
>
> *Remark 7* (Order of quantifiers). Read nested quantifiers from left to right. In \\\forall s, \exists c, E(s, c)\\, the course \\c\\ is chosen after the student \\s\\, so it may depend on \\s\\. In \\\exists c, \forall s, E(s, c)\\, one course \\c\\ must work for every student.
>
> Swapping two quantifiers of the same kind does not change the meaning: \\\forall x, \forall y, P(x, y)\\ means the same as \\\forall y, \forall x, P(x, y)\\, and likewise for \\\exists\\. Swapping a \\\forall\\ and an \\\exists\\ can change it, as parts 1 and 2 of [Exercise 6](#exr-enrollment) show.

> **NOTE:**
>
> **Exercise 7 (English to symbols)** Write each sentence in symbols, and say whether it is true.
>
> 1.  Some integer \\n\\ satisfies \\n^2 = 2n + 3\\.
> 2.  No integer is both positive and negative.
> 3.  Every list of integers has a largest element.

> **NOTE:**
>
> *Solution 7*.
>
> 1.  \\\exists n \in \mathbb{Z}, n^2 = 2n + 3\\. True: \\3^2 = 9 = 2 \cdot 3 + 3\\.
> 2.  \\\forall n \in \mathbb{Z}, \neg (n \> 0 \land n \< 0)\\. True: an integer greater than \\0\\ is not less than \\0\\.
> 3.  Let \\\mathcal{L}\\ be the set of lists of integers. The sentence says that each list \\\ell\\ has an element \\m\\ that is at least as large as every element \\x\\ of \\\ell\\: \\ \forall \ell \in \mathcal{L},\\ \exists m \in \ell,\\ \forall x \in \ell,\\ x \le m. \\ Here “\\m \in \ell\\” means “\\m\\ is an element of the list \\\ell\\”. False: the empty list has no elements, so it has no largest element. The sentence is true for every nonempty list.

# References

Wikipedia contributors. 2026a. *Counterexample — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Counterexample>.

Wikipedia contributors. 2026b. *Existential Quantification — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Existential_quantification>.

Wikipedia contributors. 2026c. *Quantifier (Logic) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Quantifier_(logic)>.

Wikipedia contributors. 2026d. *Universal Quantification — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Universal_quantification>.

Back to top
