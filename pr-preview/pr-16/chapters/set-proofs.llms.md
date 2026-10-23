# Proofs with Sets

Code

Membership, subsets and set equality

Published

Last modified: 2026-10-23 15:03:02 (PDT)

> **NOTE:**
>
> Adapted from Kameron Decker Harris’s Fall 2026 lecture notes “Proofs Involving Sets”, which are typed transcriptions of Scott Wehrwein’s Spring 2025 handwritten lecture notes. These come from those notes:
>
> - what to show to prove that an element is in a set given in set-builder notation;
> - the direct and contrapositive outlines of a subset proof;
> - proving set equality by proving that each set is a subset of the other;
> - the theorem that a nonempty factor cancels from both sides of an equation between Cartesian products, with the proof of its first half.
>
> The exercises, the second half of that proof, the membership test for a set built with an expression, and the section on disproving a claim about sets are new.

# 1 Proving membership

> **NOTE:**
>
> **Exercise 1 (In or out)** Let \\T = {\mathopen{}\left\\3k + 2 : k \in \mathbb{Z}\right\\\mathclose{}}\\ ([Definition: Set-builder notation with an expression](../chapters/sets.llms.md#def-set-builder-expression)). Prove that \\17 \in T\\ and that \\19 \notin T\\.

> **NOTE:**
>
> *Solution 1*. **\\17 \in T\\.** An element of \\T\\ is a number of the form \\3k + 2\\ with \\k\\ an integer. Take \\k = 5\\, which is an integer. Then \\3k + 2 = 3 \cdot 5 + 2 = 17\\, so \\17 \in T\\.
>
> **\\19 \notin T\\.** Suppose, for contradiction, that \\19 \in T\\ ([Definition: Proof by contradiction](../chapters/contrapositive-contradiction.llms.md#def-proof-by-contradiction)). Then \\19 = 3k + 2\\ for some integer \\k\\. Subtracting 2 from both sides gives \\3k = 17\\, so \\k = 17/3\\. But \\17/3\\ is not an integer, since \\3 \cdot 5 = 15 \< 17 \< 18 = 3 \cdot 6\\. This contradicts that \\k\\ is an integer, so \\19 \notin T\\.

> **NOTE:**
>
> *Remark 1* (What to show for membership). To prove that \\a\\ is an element of a set, show that \\a\\ passes the set’s test ([Definition: Set-builder notation](../chapters/sets.llms.md#def-set-builder), [Definition: Set-builder notation with an expression](../chapters/sets.llms.md#def-set-builder-expression)):
>
> - for \\S = {\mathopen{}\left\\x : P(x)\right\\\mathclose{}}\\, the same set-builder notation with no set \\A\\ named, show that \\P(a)\\ is true;
> - for \\S = {\mathopen{}\left\\x \in A : P(x)\right\\\mathclose{}}\\, show that \\a \in A\\ and that \\P(a)\\ is true;
> - for \\S = {\mathopen{}\left\\f(k) : k \in A\right\\\mathclose{}}\\, find some \\k \in A\\ with \\f(k) = a\\.
>
> The last case is an existence proof, so it usually names the \\k\\ ([Definition: Constructive proof](../chapters/iff-existence-disproof.llms.md#def-constructive-proof)). To prove that \\a \notin S\\, prove the negation of the test, often by contradiction, as in [Solution 1](#sol-three-k-plus-two).

> **NOTE:**
>
> **Example 1 (A root of a polynomial)** Let \\S = {\mathopen{}\left\\x \in \mathbb{R}: 2x^2 - x = 0\right\\\mathclose{}}\\. Then \\\frac{1}{2} \in S\\.
>
> The set has the form \\{\mathopen{}\left\\x \in A : P(x)\right\\\mathclose{}}\\, so there are two things to show ([Remark 1](#rem-membership)). First, \\\frac{1}{2}\\ is a real number. Second,
>
> \\ \begin{aligned} 2 \mathopen{}\left(\frac{1}{2}\right)\mathclose{}^2 - \frac{1}{2} &= 2 \cdot \frac{1}{4} - \frac{1}{2} \\&= \frac{1}{2} - \frac{1}{2} \\&= 0. \end{aligned} \\

# 2 Proving a subset

> **NOTE:**
>
> **Exercise 2 (Where a quadratic is negative)** Prove that \\{\mathopen{}\left\\x \in \mathbb{R}: x^2 - 3x + 2 \< 0\right\\\mathclose{}} \subseteq {\mathopen{}\left\\x \in \mathbb{R}: 0 \< x \< 3\right\\\mathclose{}}\\ ([Definition: Subset](../chapters/sets.llms.md#def-subset)).
>
> Hint: factor \\x^2 - 3x + 2\\.

> **NOTE:**
>
> *Solution 2*. Let \\x \in {\mathopen{}\left\\x \in \mathbb{R}: x^2 - 3x + 2 \< 0\right\\\mathclose{}}\\. Then \\x\\ is a real number, and \\x^2 - 3x + 2 = (x - 1)(x - 2) \< 0\\. We show that \\1 \< x \< 2\\, by ruling out the other two cases ([Definition: Proof by cases](../chapters/direct-proof.llms.md#def-proof-by-cases)).
>
> - If \\x \le 1\\, then \\x - 1 \le 0\\ and \\x - 2 \< 0\\, so \\(x - 1)(x - 2) \ge 0\\, since the product of two numbers that are not positive is not negative. That contradicts \\(x - 1)(x - 2) \< 0\\.
> - If \\x \ge 2\\, then \\x - 1 \> 0\\ and \\x - 2 \ge 0\\, so \\(x - 1)(x - 2) \ge 0\\, again a contradiction.
>
> So \\1 \< x \< 2\\, and so \\0 \< x \< 3\\. So \\x \in {\mathopen{}\left\\x \in \mathbb{R}: 0 \< x \< 3\right\\\mathclose{}}\\.

> **NOTE:**
>
> *Remark 2* (The shape of a subset proof). By [Definition: Subset](../chapters/sets.llms.md#def-subset), \\A \subseteq B\\ means the conditional “if \\a \in A\\, then \\a \in B\\” is true for every \\a\\. So a proof of \\A \subseteq B\\ is a proof of that conditional, either directly ([Definition: Direct proof](../chapters/direct-proof.llms.md#def-direct-proof)):
>
> > Suppose \\a \in A\\.\
> > \\\vdots\\\
> > Therefore \\a \in B\\.\
> > So \\A \subseteq B\\.
>
> or by contrapositive ([Definition: Proof by contrapositive](../chapters/contrapositive-contradiction.llms.md#def-proof-by-contrapositive)):
>
> > Suppose \\a \notin B\\.\
> > \\\vdots\\\
> > Therefore \\a \notin A\\.\
> > So \\A \subseteq B\\.
>
> The element \\a\\ is arbitrary: the proof may use only that \\a \in A\\ (or that \\a \notin B\\), nothing else about it.

> **NOTE:**
>
> **Example 2 (A subset proof by contrapositive)** Claim: \\{\mathopen{}\left\\x \in \mathbb{R}: x^3 + x \> 0\right\\\mathclose{}} \subseteq {\mathopen{}\left\\x \in \mathbb{R}: x \> 0\right\\\mathclose{}}\\.
>
> We use the contrapositive outline of [Remark 2](#rem-subset-template). Suppose \\a \notin {\mathopen{}\left\\x \in \mathbb{R}: x \> 0\right\\\mathclose{}}\\. If \\a\\ is not a real number, then \\a\\ is not in the left-hand set either, since every element of that set is a real number. Otherwise \\a\\ is a real number with \\a \le 0\\. Then \\a^3 = a \cdot a^2 \le 0\\, since \\a \le 0\\ and \\a^2 \ge 0\\, so
>
> \\ a^3 + a \le 0 + 0 = 0. \\
>
> So \\a \notin {\mathopen{}\left\\x \in \mathbb{R}: x^3 + x \> 0\right\\\mathclose{}}\\.
>
> The direct outline would start from “\\a^3 + a \> 0\\”, and would have to get from a cubic back to \\a\\, which is harder.

> **NOTE:**
>
> **Theorem 1 (Subsets of subsets)** Let \\A\\, \\B\\ and \\C\\ be sets. If \\A \subseteq B\\ and \\B \subseteq C\\, then \\A \subseteq C\\.

> **NOTE:**
>
> *Proof*. Suppose \\A \subseteq B\\ and \\B \subseteq C\\, and let \\a \in A\\. Since \\A \subseteq B\\, \\a \in B\\ ([Definition: Subset](../chapters/sets.llms.md#def-subset)). Since \\B \subseteq C\\, \\a \in C\\. So every element of \\A\\ is in \\C\\, and \\A \subseteq C\\.

> **NOTE:**
>
> **Example 3 (A chain of subsets)** [Solution 2](#sol-between-roots) shows that \\{\mathopen{}\left\\x \in \mathbb{R}: x^2 - 3x + 2 \< 0\right\\\mathclose{}} \subseteq {\mathopen{}\left\\x \in \mathbb{R}: 0 \< x \< 3\right\\\mathclose{}}\\, and every real number between 0 and 3 is positive, so \\{\mathopen{}\left\\x \in \mathbb{R}: 0 \< x \< 3\right\\\mathclose{}} \subseteq {\mathopen{}\left\\x \in \mathbb{R}: x \> 0\right\\\mathclose{}}\\. By [Theorem 1](#thm-subset-transitive), \\{\mathopen{}\left\\x \in \mathbb{R}: x^2 - 3x + 2 \< 0\right\\\mathclose{}} \subseteq {\mathopen{}\left\\x \in \mathbb{R}: x \> 0\right\\\mathclose{}}\\.

# 3 Proving set equality

> **NOTE:**
>
> **Exercise 3 (Absorbing an intersection)** Let \\A\\ and \\B\\ be sets. Prove that \\A \cup (A \cap B) = A\\ ([Definition: Union](../chapters/sets.llms.md#def-union), [Definition: Intersection](../chapters/sets.llms.md#def-intersection)).
>
> Hint: prove that each side is a subset of the other.

> **NOTE:**
>
> *Solution 3*. **\\A \cup (A \cap B) \subseteq A\\.** Let \\x \in A \cup (A \cap B)\\. Then \\x \in A\\ or \\x \in A \cap B\\. In the first case, \\x \in A\\. In the second case, \\x \in A\\ and \\x \in B\\, so again \\x \in A\\. Either way, \\x \in A\\ ([Definition: Proof by cases](../chapters/direct-proof.llms.md#def-proof-by-cases)).
>
> **\\A \subseteq A \cup (A \cap B)\\.** Let \\x \in A\\. Then “\\x \in A\\ or \\x \in A \cap B\\” is true, since its first part is true ([Definition: Or](../chapters/propositional-logic.llms.md#def-or)), so \\x \in A \cup (A \cap B)\\.
>
> Each side is a subset of the other, so an element is in one side exactly when it is in the other, and the two sets are equal ([Definition: Set](../chapters/sets.llms.md#def-set)).

> **NOTE:**
>
> **Theorem 2 (Equal sets are subsets of each other)** Let \\A\\ and \\B\\ be sets. Then \\A = B\\ if and only if \\A \subseteq B\\ and \\B \subseteq A\\.

> **NOTE:**
>
> *Proof*. By [Definition: Set](../chapters/sets.llms.md#def-set), \\A = B\\ means that every \\x\\ has \\x \in A \Leftrightarrow x \in B\\. By [Theorem: A biconditional is two conditionals](../chapters/iff-existence-disproof.llms.md#thm-biconditional-split), that biconditional is the same as “\\x \in A \Rightarrow x \in B\\, and \\x \in B \Rightarrow x \in A\\”. A conjunction is true for every \\x\\ exactly when each of its two parts is true for every \\x\\. The first conditional, for every \\x\\, is \\A \subseteq B\\ ([Definition: Subset](../chapters/sets.llms.md#def-subset)), and the second, for every \\x\\, is \\B \subseteq A\\.

> **NOTE:**
>
> *Remark 3* (The shape of a set equality proof). By [Theorem 2](#thm-double-inclusion), a proof of \\A = B\\ has two parts, each a subset proof ([Remark 2](#rem-subset-template)):
>
> > (\\\subseteq\\) Suppose \\a \in A\\.\
> > \\\vdots\\\
> > Therefore \\a \in B\\.\
> > \
> > (\\\supseteq\\) Suppose \\a \in B\\.\
> > \\\vdots\\\
> > Therefore \\a \in A\\.\
> > \
> > So \\A = B\\.
>
> This is the “if and only if” outline of [Remark: The shape of an “if and only if” proof](../chapters/iff-existence-disproof.llms.md#rem-iff-template), applied to \\a \in A\\ and \\a \in B\\.

> **NOTE:**
>
> **Example 4 (Two kinds of odd number)** Claim: \\{\mathopen{}\left\\4k + 1 : k \in \mathbb{Z}\right\\\mathclose{}} \cup {\mathopen{}\left\\4k + 3 : k \in \mathbb{Z}\right\\\mathclose{}} = {\mathopen{}\left\\2m + 1 : m \in \mathbb{Z}\right\\\mathclose{}}\\.
>
> (\\\subseteq\\) Let \\x\\ be in the left-hand side. If \\x = 4k + 1\\ for some integer \\k\\, then \\x = 2(2k) + 1\\. If \\x = 4k + 3\\ for some integer \\k\\, then \\x = 2(2k + 1) + 1\\. Both \\2k\\ and \\2k + 1\\ are integers ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)), so either way \\x\\ is in the right-hand side.
>
> (\\\supseteq\\) Let \\x = 2m + 1\\ for some integer \\m\\. The integer \\m\\ is even or odd ([Remark: Facts about integers used without proof](../chapters/direct-proof.llms.md#rem-integer-closure)).
>
> - If \\m\\ is even, then \\m = 2j\\ for some integer \\j\\ ([Definition: Even integer](../chapters/direct-proof.llms.md#def-even-odd)), so \\x = 2(2j) + 1 = 4j + 1\\, and \\x \in {\mathopen{}\left\\4k + 1 : k \in \mathbb{Z}\right\\\mathclose{}}\\.
> - If \\m\\ is odd, then \\m = 2j + 1\\ for some integer \\j\\ ([Definition: Odd integer](../chapters/direct-proof.llms.md#def-odd)), so \\x = 2(2j + 1) + 1 = 4j + 3\\, and \\x \in {\mathopen{}\left\\4k + 3 : k \in \mathbb{Z}\right\\\mathclose{}}\\.
>
> Either way, \\x\\ is in the left-hand side. So the two sets are equal ([Theorem 2](#thm-double-inclusion)).

> **NOTE:**
>
> **Theorem 3 (A subset is its own intersection)** Let \\A\\ and \\B\\ be sets. Then \\A \subseteq B\\ if and only if \\A \cap B = A\\.

> **NOTE:**
>
> *Proof*. (\\\Rightarrow\\) Suppose \\A \subseteq B\\. We show \\A \cap B = A\\ with [Theorem 2](#thm-double-inclusion). If \\x \in A \cap B\\, then \\x \in A\\ ([Definition: Intersection](../chapters/sets.llms.md#def-intersection)). If \\x \in A\\, then \\x \in B\\, since \\A \subseteq B\\, so \\x \in A \cap B\\.
>
> (\\\Leftarrow\\) Suppose \\A \cap B = A\\, and let \\x \in A\\. Then \\x \in A \cap B\\, since the two sets are equal, so \\x \in B\\. So \\A \subseteq B\\.

> **NOTE:**
>
> **Example 5 (Intersecting with a larger set)** Let \\B = {\mathopen{}\left\\1, 2, 3, 4\right\\\mathclose{}}\\.
>
> - \\{\mathopen{}\left\\2, 4\right\\\mathclose{}} \subseteq B\\, and \\{\mathopen{}\left\\2, 4\right\\\mathclose{}} \cap B = {\mathopen{}\left\\2, 4\right\\\mathclose{}}\\, as [Theorem 3](#thm-subset-intersection) says.
> - \\{\mathopen{}\left\\2, 5\right\\\mathclose{}} \not\subseteq B\\, since \\5 \notin B\\, and \\{\mathopen{}\left\\2, 5\right\\\mathclose{}} \cap B = {\mathopen{}\left\\2\right\\\mathclose{}}\\, which is not \\{\mathopen{}\left\\2, 5\right\\\mathclose{}}\\.

> **NOTE:**
>
> **Theorem 4 (Cancelling a factor of a Cartesian product)** Let \\A\\, \\B\\ and \\C\\ be sets with \\C \ne \emptyset\\. If \\A \times C = B \times C\\, then \\A = B\\ ([Definition: Cartesian product](../chapters/sets.llms.md#def-cartesian-product)).

> **NOTE:**
>
> *Proof*. Suppose \\A \times C = B \times C\\. Since \\C \ne \emptyset\\, there is some \\c \in C\\ ([Definition: Empty set](../chapters/sets.llms.md#def-empty-set)).
>
> (\\\subseteq\\) Let \\a \in A\\. Then \\(a, c) \in A \times C\\. Since \\A \times C = B \times C\\, also \\(a, c) \in B \times C\\, so \\(a, c) = (b, c')\\ for some \\b \in B\\ and \\c' \in C\\ ([Definition: Cartesian product](../chapters/sets.llms.md#def-cartesian-product)). Two ordered pairs are equal only when their first entries are equal ([Definition: Ordered pair](../chapters/sets.llms.md#def-ordered-pair)), so \\a = b\\, and \\a \in B\\.
>
> (\\\supseteq\\) Let \\b \in B\\. Then \\(b, c) \in B \times C = A \times C\\, so \\b \in A\\, by the same steps with \\A\\ and \\B\\ swapped.
>
> So \\A = B\\ ([Theorem 2](#thm-double-inclusion)).

> **NOTE:**
>
> **Example 6 (Why \\C\\ must not be empty)** The condition \\C \ne \emptyset\\ in [Theorem 4](#thm-cartesian-cancel) is needed. Let \\A = {\mathopen{}\left\\1\right\\\mathclose{}}\\, \\B = {\mathopen{}\left\\2\right\\\mathclose{}}\\ and \\C = \emptyset\\. A pair in \\A \times C\\ would need a second entry in \\C\\, and \\C\\ has none, so \\A \times C = \emptyset\\, and likewise \\B \times C = \emptyset\\. So \\A \times C = B \times C\\, but \\A \ne B\\.
>
> The proof uses the condition in its first step, to find an element \\c \in C\\.

# 4 Disproving a claim about sets

> **NOTE:**
>
> **Exercise 4 (Regrouping differences)** Show that the claim “for all sets \\A\\, \\B\\ and \\C\\, \\A - (B - C) = (A - B) - C\\” is false ([Definition: Set difference](../chapters/sets.llms.md#def-set-difference)).

> **NOTE:**
>
> *Solution 4*. A counterexample ([Definition: Counterexample](../chapters/predicates-quantifiers.llms.md#def-counterexample)) is one choice of \\A\\, \\B\\ and \\C\\ for which the two sides differ. Let \\A = B = C = {\mathopen{}\left\\1\right\\\mathclose{}}\\. Then
>
> \\ \begin{aligned} A - (B - C) &= {\mathopen{}\left\\1\right\\\mathclose{}} - ({\mathopen{}\left\\1\right\\\mathclose{}} - {\mathopen{}\left\\1\right\\\mathclose{}}) \\&= {\mathopen{}\left\\1\right\\\mathclose{}} - \emptyset \\&= {\mathopen{}\left\\1\right\\\mathclose{}}, \end{aligned} \\
>
> while
>
> \\ \begin{aligned} (A - B) - C &= ({\mathopen{}\left\\1\right\\\mathclose{}} - {\mathopen{}\left\\1\right\\\mathclose{}}) - {\mathopen{}\left\\1\right\\\mathclose{}} \\&= \emptyset - {\mathopen{}\left\\1\right\\\mathclose{}} \\&= \emptyset. \end{aligned} \\
>
> The two sides differ, so the claim is false.

> **NOTE:**
>
> *Remark 4* (Disproving a claim about all sets). A claim of the form “for all sets \\A\\, \\B\\, …, some equation holds” is disproved by one choice of sets for which it fails ([Definition: Disproof](../chapters/iff-existence-disproof.llms.md#def-disproof)). Small sets, such as \\\emptyset\\ and \\{\mathopen{}\left\\1\right\\\mathclose{}}\\, are a good place to look. A Venn diagram ([Definition: Venn diagram](../chapters/sets.llms.md#def-venn-diagram)) can suggest where to look: shade each side, find a region shaded on one side only, and put an element in that region.

> **NOTE:**
>
> **Example 7 (A union does not cancel)** Claim to disprove: for all sets \\A\\, \\B\\ and \\C\\, if \\A \cup B = A \cup C\\, then \\B = C\\.
>
> Let \\A = {\mathopen{}\left\\1\right\\\mathclose{}}\\, \\B = {\mathopen{}\left\\1\right\\\mathclose{}}\\ and \\C = \emptyset\\. Then \\A \cup B = {\mathopen{}\left\\1\right\\\mathclose{}}\\ and \\A \cup C = {\mathopen{}\left\\1\right\\\mathclose{}}\\, so \\A \cup B = A \cup C\\, but \\B \ne C\\. So the claim is false.

Back to top
