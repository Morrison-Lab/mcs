# Sets

Code

Published

Last modified: 2026-11-12 00:48:36 (PST)

> **NOTE:**
>
> *Remark*. Probability and statistics describe events, outcomes, and parameters as sets. This page collects the definitions of sets that the Morrison Lab’s probability and statistics notes build on. The [Functions](functions.llms.md) page defines functions between sets, and the [Expressions and Algorithms](expressions-algorithms.llms.md) page defines the expressions that write functions down and the algorithms that compute them.

> **NOTE:**
>
> **Definition 1 (Set)** A **[set](https://en.wikipedia.org/wiki/Set_(mathematics))** is a collection of distinct objects, called its elements. We write $a \in A$ when $a$ is an element of the set $A$, and $a \notin A$ when it is not. Two sets are equal when they have exactly the same elements.

> **NOTE:**
>
> *Remark 1* (Naive and formal set theory). [Definition 1](#def-set) is the informal (“naive”) notion of a set, which is all these notes need. Formal set theory states axioms for sets instead ([Wikipedia contributors 2026n](#ref-wikipedia_set_mathematics)). For example, the last sentence of [Definition 1](#def-set), that two sets are equal when they have exactly the same elements, is one of those axioms, the *axiom of extensionality*.

> **NOTE:**
>
> **Example 1 (Sets of die rolls)** The possible results of rolling a six-sided die form the set ${\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$, with $3 \in {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$ and $7 \notin {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$. The sets ${\mathopen{}\left\{1, 2, 3\right\}\mathclose{}}$ and ${\mathopen{}\left\{3, 2, 1\right\}\mathclose{}}$ are equal, because they have the same elements; the order in which the elements are listed does not matter.

> **NOTE:**
>
> **Definition 2 (Roster notation)** Writing a [set](#def-set) by listing its elements between braces, as in ${\mathopen{}\left\{1, 2, 3\right\}\mathclose{}}$, is called **roster notation** ([Wikipedia contributors 2026n](#ref-wikipedia_set_mathematics)). An ellipsis, “$\ldots$”, can stand for elements that follow a clear pattern, as in ${\mathopen{}\left\{10, 20, 30, \ldots, 90\right\}\mathclose{}}$.

> **NOTE:**
>
> **Example 2 (Rosters of vowels and odd integers)**  
>
> In [roster notation](#def-roster-notation), the vowels of English are ${\mathopen{}\left\{a, e, i, o, u\right\}\mathclose{}}$, and the [odd integers](number-systems.llms.md#def-odd) from $1$ to $99$ are ${\mathopen{}\left\{1, 3, 5, \ldots, 99\right\}\mathclose{}}$, where the ellipsis stands for the odd integers from $7$ to $97$. Listing an element twice does not add an element: ${\mathopen{}\left\{a, a, e\right\}\mathclose{}}$ and ${\mathopen{}\left\{a, e\right\}\mathclose{}}$ are the same [set](#def-set), since they have the same elements.

> **NOTE:**
>
> **Definition 3 (Set-builder notation)** For a set $A$ and a statement $P(x)$ about an element $x$, **set-builder notation** ([Wikipedia contributors 2026o](#ref-wikipedia_set_builder_notation)) ${\mathopen{}\left\{x \in A : P(x)\right\}\mathclose{}}$ denotes the set of elements $x$ of $A$ for which $P(x)$ is true.

> **NOTE:**
>
> **Example 3 (Even die rolls in set-builder notation)** ${\mathopen{}\left\{x \in {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}} : x \text{ is even}\right\}\mathclose{}} = {\mathopen{}\left\{2, 4, 6\right\}\mathclose{}}$ is the set of [even](number-systems.llms.md#def-even-odd) rolls, and ${\mathopen{}\left\{x \in \mathbb{R}: x > 0\right\}\mathclose{}}$ is the set of positive [real numbers](number-systems.llms.md#def-real-numbers).

> **NOTE:**
>
> **Definition 4 (Set-builder notation with an expression)** For a [set](#def-set) $A$ and a rule $f(x)$ that gives an object for each element $x$ of $A$, the notation ${\mathopen{}\left\{f(x) : x \in A\right\}\mathclose{}}$ stands for the set of the objects $f(x)$ for $x \in A$ ([Wikipedia contributors 2026o](#ref-wikipedia_set_builder_notation)). That is, an object $y$ is an element of ${\mathopen{}\left\{f(x) : x \in A\right\}\mathclose{}}$ when $y = f(x)$ for some $x \in A$.

> **NOTE:**
>
> **Example 4 (Squaring die rolls)**  
>
> Squaring each possible roll of a six-sided die gives the [set](#def-set)
>
> $${\mathopen{}\left\{x^2 : x \in {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}\right\}\mathclose{}} = {\mathopen{}\left\{1, 4, 9, 16, 25, 36\right\}\mathclose{}},$$
>
> written in [set-builder notation with an expression](#def-set-builder-expression). Two choices of $x$ can give the same $x^2$, and that object is then one element of the set: ${\mathopen{}\left\{x^2 : x \in {\mathopen{}\left\{-2, -1, 0, 1, 2\right\}\mathclose{}}\right\}\mathclose{}} = {\mathopen{}\left\{0, 1, 4\right\}\mathclose{}}$, since $(-2)^2 = 2^2$ and $(-1)^2 = 1^2$.

> **NOTE:**
>
> **Definition 5 (Subset)** A set $A$ is a **subset** ([Wikipedia contributors 2026p](#ref-wikipedia_subset)) of a set $B$, written $A \subseteq B$, if every element of $A$ is an element of $B$.

> **NOTE:**
>
> **Example 5 (Even die rolls)** The even die rolls form a subset of the possible rolls: ${\mathopen{}\left\{2, 4, 6\right\}\mathclose{}} \subseteq {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$, because each of $2$, $4$, and $6$ is a possible roll. The set ${\mathopen{}\left\{2, 4, 7\right\}\mathclose{}}$ is not a subset of ${\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$, because $7$ is not a possible roll.

> **NOTE:**
>
> **Theorem 1 (Every set is a subset of itself)** For every set $A$, $A \subseteq A$.

> **NOTE:**
>
> *Proof*. Every element of $A$ is an element of $A$, which is [Definition 5](#def-subset) with $B = A$.

> **NOTE:**
>
> **Definition 6 (Strict subset, proper subset)** A [set](#def-set) $A$ is a **strict subset** (also called a **proper subset**) of a set $B$, written $A \subsetneq B$, if $A$ is a [subset](#def-subset) of $B$ and $A \neq B$.

> **NOTE:**
>
> *Remark 2* (The symbol $\subset$). Sources disagree about the symbol $\subset$: some use it for “subset” ($\subseteq$), and others for “strict subset” ($\subsetneq$) ([Wikipedia contributors 2026p](#ref-wikipedia_subset)). For example, ${\mathopen{}\left\{1, 2\right\}\mathclose{}} \subset {\mathopen{}\left\{1, 2\right\}\mathclose{}}$ is true in the first reading, because ${\mathopen{}\left\{1, 2\right\}\mathclose{}} \subseteq {\mathopen{}\left\{1, 2\right\}\mathclose{}}$, and false in the second, because the two sets are equal. These notes avoid $\subset$ and write $\subseteq$ or $\subsetneq$.

> **NOTE:**
>
> **Definition 7 (Superset)** A set $B$ is a **superset** of a set $A$, written $B \supseteq A$, if every element of $A$ is an element of $B$.

> **NOTE:**
>
> *Remark 3* (Superset and subset). $B \supseteq A$ means the same thing as $A \subseteq B$ ([subset](#def-subset)). For example, ${\mathopen{}\left\{1, 2, 3\right\}\mathclose{}} \supseteq {\mathopen{}\left\{1, 3\right\}\mathclose{}}$, and ${\mathopen{}\left\{1, 3\right\}\mathclose{}} \subseteq {\mathopen{}\left\{1, 2, 3\right\}\mathclose{}}$. But ${\mathopen{}\left\{1, 3\right\}\mathclose{}}$ is not a superset of ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$, because $2 \in {\mathopen{}\left\{1, 2\right\}\mathclose{}}$ and $2 \notin {\mathopen{}\left\{1, 3\right\}\mathclose{}}$.

> **NOTE:**
>
> **Definition 8 (Strict superset)** A set $B$ is a **strict superset** of a set $A$, written $B \supsetneq A$, if $B$ is a [superset](#def-superset) of $A$ and $B \neq A$.

> **NOTE:**
>
> *Remark 4* (Strict superset and strict subset). $B \supsetneq A$ means the same thing as $A \subsetneq B$ ([strict subset](#def-strict-subset)). For example, ${\mathopen{}\left\{1, 2, 3\right\}\mathclose{}} \supsetneq {\mathopen{}\left\{1, 3\right\}\mathclose{}}$, because ${\mathopen{}\left\{1, 2, 3\right\}\mathclose{}}$ contains $2$ and ${\mathopen{}\left\{1, 3\right\}\mathclose{}}$ does not.

> **NOTE:**
>
> **Example 6 (Strict subsets and supersets of die rolls)** For the even rolls $A = {\mathopen{}\left\{2, 4, 6\right\}\mathclose{}}$ and the possible rolls $B = {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$:
>
> - $A \subsetneq B$, because $A \subseteq B$ ([Example 5](#exm-subset)) and $1 \in B$ but $1 \notin A$, so $A \neq B$;
> - $B \supseteq A$ and $B \supsetneq A$, for the same reasons;
> - $B \subseteq B$, but $B$ is not a strict subset of itself, because $B = B$; likewise $B \supseteq B$, but $B$ is not a strict superset of itself, because $B = B$.

> **NOTE:**
>
> **Definition 9 (Empty set)** The **empty set** ([Wikipedia contributors 2026e](#ref-wikipedia_empty_set)), denoted $\emptyset$, is the set that has no elements.

> **NOTE:**
>
> *Remark 5* (Other notation for the empty set). Other sources write ${\mathopen{}\left\{\right\}\mathclose{}}$ for $\emptyset$ ([Wikipedia contributors 2026e](#ref-wikipedia_empty_set)). Some sources call it the **null set**, but in measure theory a “null set” usually means a set of [measure zero](https://morrison-lab.github.io/mds/measures.html#def-measure-zero), which need not be empty. For example, the interval $[0, 0] = {\mathopen{}\left\{0\right\}\mathclose{}}$ has length $0 - 0 = 0$, so it is a null set in that sense, but it is not empty, because $0 \in {\mathopen{}\left\{0\right\}\mathclose{}}$.

> **NOTE:**
>
> **Example 7 (Impossible die rolls)** No roll of a six-sided die is greater than 6, so ${\mathopen{}\left\{x \in {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}} : x > 6\right\}\mathclose{}} = \emptyset$.

> **NOTE:**
>
> **Definition 10 (Vacuous truth)** A statement of the form “every element of $A$ has property $P$” is **vacuously true** ([Wikipedia contributors 2026s](#ref-wikipedia_vacuous_truth)) when $A$ is the [empty set](#def-empty-set): $A$ has no elements, so no element of $A$ fails to have property $P$.

> **NOTE:**
>
> **Example 8 (Every impossible die roll is even)** The set of die rolls greater than 6 is $\emptyset$ ([Example 7](#exm-empty-set)). So “every die roll greater than 6 is even” is vacuously true, and so is “every die roll greater than 6 is odd”: there is no such roll to fail either statement.

> **NOTE:**
>
> **Theorem 2 (There is only one empty set)** If $E_1$ and $E_2$ are sets with no elements, then $E_1 = E_2$.

> **NOTE:**
>
> *Proof*. Neither set has any elements, so every element of $E_1$ is an element of $E_2$ and vice versa, [vacuously](#def-vacuous-truth). Sets with the same elements are equal ([Definition 1](#def-set)).

> **NOTE:**
>
> **Theorem 3 (The empty set is a subset of every set)** For every set $A$, $\emptyset \subseteq A$.

> **NOTE:**
>
> *Proof*. By [Definition 5](#def-subset), $\emptyset \subseteq A$ fails only if some element of $\emptyset$ is not in $A$. The [empty set](#def-empty-set) has no elements, so no such element exists.

> **NOTE:**
>
> **Definition 11 (Power set)** The **power set** ([Wikipedia contributors 2026m](#ref-wikipedia_power_set)) of a [set](#def-set) $A$, written ${\mathcal{P}\mathopen{}\left(A\right)\mathclose{}}$, is the set of all [subsets](#def-subset) of $A$:
>
> $${\mathcal{P}\mathopen{}\left(A\right)\mathclose{}} \stackrel{\text{def}}{=}{\mathopen{}\left\{S : S \subseteq A\right\}\mathclose{}}$$

> **NOTE:**
>
> **Example 9 (The power set of a two-element set)**  
>
> The [power set](#def-power-set) of ${\mathopen{}\left\{0, 1\right\}\mathclose{}}$ has four elements:
>
> $${\mathcal{P}\mathopen{}\left({\mathopen{}\left\{0, 1\right\}\mathclose{}}\right)\mathclose{}} = {\mathopen{}\left\{\emptyset, {\mathopen{}\left\{0\right\}\mathclose{}}, {\mathopen{}\left\{1\right\}\mathclose{}}, {\mathopen{}\left\{0, 1\right\}\mathclose{}}\right\}\mathclose{}}$$
>
> It contains the [empty set](#def-empty-set), since the empty set is a [subset](#def-subset) of every [set](#def-set) by [Theorem 3](#thm-empty-subset), and it contains ${\mathopen{}\left\{0, 1\right\}\mathclose{}}$ itself, by [Theorem 1](#thm-subset-reflexive). Its elements are [sets](#def-set): ${\mathopen{}\left\{0\right\}\mathclose{}} \in {\mathcal{P}\mathopen{}\left({\mathopen{}\left\{0, 1\right\}\mathclose{}}\right)\mathclose{}}$, but $0 \notin {\mathcal{P}\mathopen{}\left({\mathopen{}\left\{0, 1\right\}\mathclose{}}\right)\mathclose{}}$.

> **NOTE:**
>
> **Definition 12 (Lower bound and upper bound)** For a [subset](#def-subset) $S \subseteq \mathbb{R}$ of the [real numbers](number-systems.llms.md#def-real-numbers), a [real number](number-systems.llms.md#def-real-numbers) $a$ is a **lower bound** of $S$ if $a \le x$ for every $x \in S$, and a real number $b$ is an **upper bound** of $S$ if $x \le b$ for every $x \in S$; each is a **bound** of $S$.

> **NOTE:**
>
> **Definition 13 (Interval)** An **interval** ([Wikipedia contributors 2026k](#ref-wikipedia_interval_mathematics)) is a [subset](#def-subset) of the [real numbers](number-systems.llms.md#def-real-numbers) that consists of all real numbers between two bounds $a \le b$ ([Definition 12](#def-bound)), possibly including one or both bounds, or of all real numbers on one side of a single bound, or all of $\mathbb{R}$. The bounds $a$ and $b$ that define the interval are its **endpoints**.

> **NOTE:**
>
> **Definition 14 (Closed interval)** For [real numbers](number-systems.llms.md#def-real-numbers) $a \le b$, the **closed interval** is the interval ([Definition 13](#def-interval)) $[a, b] \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: a \le x \le b\right\}\mathclose{}}$ that includes both bounds ([Definition 12](#def-bound)).

> **NOTE:**
>
> **Definition 15 (Open interval)** For [real numbers](number-systems.llms.md#def-real-numbers) $a \le b$, the **open interval** is the interval ([Definition 13](#def-interval)) $(a, b) \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: a < x < b\right\}\mathclose{}}$ that includes neither bound ([Definition 12](#def-bound)).

> **NOTE:**
>
> **Definition 16 (Half-open intervals)** For [real numbers](number-systems.llms.md#def-real-numbers) $a \le b$, the **half-open intervals** are the intervals ([Definition 13](#def-interval)) $[a, b) \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: a \le x < b\right\}\mathclose{}}$ and $(a, b] \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: a < x \le b\right\}\mathclose{}}$ that include one bound ([Definition 12](#def-bound)) and not the other.

> **NOTE:**
>
> **Definition 17 (Unbounded intervals)** For [real numbers](number-systems.llms.md#def-real-numbers) $a$ and $b$, the **unbounded intervals** are the intervals ([Definition 13](#def-interval)) with at most one bound ([Definition 12](#def-bound)):
>
> - $[a, \infty) \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: x \ge a\right\}\mathclose{}}$ and $(a, \infty) \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: x > a\right\}\mathclose{}}$;
> - $(-\infty, b] \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: x \le b\right\}\mathclose{}}$ and $(-\infty, b) \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in \mathbb{R}: x < b\right\}\mathclose{}}$;
> - $(-\infty, \infty) \stackrel{\text{def}}{=}\mathbb{R}$.

> **NOTE:**
>
> *Remark 6* (Brackets and parentheses in interval notation). In the notation for an [interval](#def-interval), a bracket marks an [endpoint](#def-interval) that belongs to the interval, while a parenthesis marks an endpoint that is excluded. The symbols $\infty$, $-\infty$ denote no [real number](number-systems.llms.md#def-real-numbers), so they always get a parenthesis.

> **NOTE:**
>
> **Example 10 (Which numbers are in an interval)**  
>
> - $1 \in [1, 2]$, but $1 \notin (1, 2)$.
> - $2 \in (1, 2]$, but $2 \notin [1, 2)$.
> - $1.5$ is in all four of $[1, 2]$, $(1, 2)$, $[1, 2)$, and $(1, 2]$.
> - $[0, \infty)$ is the set of non-negative real numbers: $0 \in [0, \infty)$ and $1000 \in [0, \infty)$, but $-0.1 \notin [0, \infty)$.

> **NOTE:**
>
> **Definition 18 (Collection of sets, family of sets)** A **collection of sets** (also called a **family of sets**) ([Wikipedia contributors 2026g](#ref-wikipedia_family_of_sets)) is a set whose elements are themselves sets.

> **NOTE:**
>
> **Example 11 (The collection of all subsets of a two-element set)** The subsets of ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$ are $\emptyset$, ${\mathopen{}\left\{1\right\}\mathclose{}}$, ${\mathopen{}\left\{2\right\}\mathclose{}}$, and ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$ ([Theorem 3](#thm-empty-subset) and [Theorem 1](#thm-subset-reflexive) give the first and the last), so the collection of all subsets of ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$ is
>
> $${\mathopen{}\left\{\emptyset, {\mathopen{}\left\{1\right\}\mathclose{}}, {\mathopen{}\left\{2\right\}\mathclose{}}, {\mathopen{}\left\{1, 2\right\}\mathclose{}}\right\}\mathclose{}}$$
>
> It has four elements, each of them a set. The collection ${\mathopen{}\left\{\emptyset\right\}\mathclose{}}$ has one element, the empty set, so it is not equal to $\emptyset$, which has none.

> **NOTE:**
>
> **Definition 19 (Label)** A **label** is a name or symbol attached to an object, so that we can refer to the object and tell it apart from other objects.

> **NOTE:**
>
> **Example 12 (Labels)** The numbers $1, 2, 3$ can label three students in a class list. Then “student 2” refers to one particular student. The letters $A$ and $B$ can label two sets.

> **NOTE:**
>
> **Definition 20 (Index set)** An **index set** ([Wikipedia contributors 2026h](#ref-wikipedia_index_set)) is a set whose elements are used as [labels](#def-label) for objects. Each element of the index set is called an index.

> **NOTE:**
>
> **Example 13 (Index sets)** The set $\{1, \ldots, n\}$ labels the entries of a vector with $n$ entries. The set of nonnegative real numbers can label moments in time.

> **NOTE:**
>
> **Definition 21 (Indexed family)** An **indexed family** ([Wikipedia contributors 2026i](#ref-wikipedia_indexed_family)) is a collection of objects, one for each element of a given [index set](#def-index-set). The object for the index $i$ is written $a_i$.

> **NOTE:**
>
> **Example 14 (Indexed families)** The entries $x_1, \ldots, x_n$ of a vector are an indexed family of numbers, with index set $\{1, \ldots, n\}$. The functions $f_\theta$, one for each parameter value $\theta$ in a parameter set, are an indexed family of functions.

# 1 Combining sets

> **NOTE:**
>
> **Definition 22 (Union)** The **union** ([Wikipedia contributors 2026r](#ref-wikipedia_union_set_theory)) of sets $A$ and $B$, written $A \cup B$, is the set of elements that are in $A$, in $B$, or in both:
>
> $$A \cup B \stackrel{\text{def}}{=}{\mathopen{}\left\{x : x \in A \text{ or } x \in B\right\}\mathclose{}}$$

> **NOTE:**
>
> **Definition 23 (Union of a family of sets)** Let $I$ be a set of indices, such as $\mathopen{}\left\{1, \ldots, n\right\}\mathclose{}$ or $\mathopen{}\left\{1, 2, 3, \ldots\right\}\mathclose{}$, and let $A_i$ be a set for each $i \in I$. The **union** of the sets $A_i$, written $\bigcup_{i \in I} A_i$, is the set of elements that are in at least one $A_i$. For $I = \mathopen{}\left\{1, \ldots, n\right\}\mathclose{}$, it is also written $\bigcup_{i=1}^{n} A_i$ or $A_1 \cup \cdots \cup A_n$, and for $I = \mathopen{}\left\{1, 2, 3, \ldots\right\}\mathclose{}$, it is written $\bigcup_{i=1}^{\infty} A_i$.

> **NOTE:**
>
> **Definition 24 (Intersection)** The **intersection** ([Wikipedia contributors 2026j](#ref-wikipedia_intersection_set_theory)) of sets $A$ and $B$, written $A \cap B$, is the set of elements that are in both $A$ and $B$:
>
> $$A \cap B \stackrel{\text{def}}{=}{\mathopen{}\left\{x : x \in A \text{ and } x \in B\right\}\mathclose{}}$$

> **NOTE:**
>
> **Definition 25 (Intersection of a family of sets)** Let $I$ be a nonempty set of indices, such as $\mathopen{}\left\{1, \ldots, n\right\}\mathclose{}$ or $\mathopen{}\left\{1, 2, 3, \ldots\right\}\mathclose{}$, and let $A_i$ be a set for each $i \in I$. The **intersection** of the sets $A_i$, written $\bigcap_{i \in I} A_i$, is the set of elements that are in every $A_i$. For $I = \mathopen{}\left\{1, \ldots, n\right\}\mathclose{}$, it is also written $\bigcap_{i=1}^{n} A_i$ or $A_1 \cap \cdots \cap A_n$, and for $I = \mathopen{}\left\{1, 2, 3, \ldots\right\}\mathclose{}$, it is written $\bigcap_{i=1}^{\infty} A_i$.

> **NOTE:**
>
> **Definition 26 (Set difference)** The **set difference** ([Wikipedia contributors 2026b](#ref-wikipedia_complement_set_theory)) of sets $A$ and $B$, written $A \setminus B$, is the set of elements of $A$ that are not in $B$:
>
> $$A \setminus B \stackrel{\text{def}}{=}{\mathopen{}\left\{x \in A : x \notin B\right\}\mathclose{}}$$

> **NOTE:**
>
> **Definition 27 (Complement)** Let $A$ be a [subset](#def-subset) of a set $S$. The **complement** ([Wikipedia contributors 2026b](#ref-wikipedia_complement_set_theory)) of $A$ in $S$ is the set difference ([Definition 26](#def-set-difference)) $S \setminus A$: the elements of $S$ that are not in $A$. When the set $S$ is clear from context, the complement of $A$ is written $A^c$:
>
> $$A^c \stackrel{\text{def}}{=}S \setminus A = {\mathopen{}\left\{x \in S : x \notin A\right\}\mathclose{}}$$

> **NOTE:**
>
> **Example 15 (Complements of sets of die rolls)** Let $S = {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$ be the possible rolls of a die.
>
> - The complement of the even rolls $A = {\mathopen{}\left\{2, 4, 6\right\}\mathclose{}}$ is $A^c = {\mathopen{}\left\{1, 3, 5\right\}\mathclose{}}$, the odd rolls.
> - The complement of $S$ itself is $S^c = \emptyset$, and the complement of $\emptyset$ is $\emptyset^c = S$.
>
> The complement depends on $S$: in $S = {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$, the complement of ${\mathopen{}\left\{2, 4, 6\right\}\mathclose{}}$ is ${\mathopen{}\left\{1, 3, 5\right\}\mathclose{}}$, but in $S = {\mathopen{}\left\{2, 4, 6, 8\right\}\mathclose{}}$, it is ${\mathopen{}\left\{8\right\}\mathclose{}}$.

> **NOTE:**
>
> **Example 16 (Combining sets of die rolls)** Let $A = {\mathopen{}\left\{2, 4, 6\right\}\mathclose{}}$ (the even rolls) and $B = {\mathopen{}\left\{1, 2, 3\right\}\mathclose{}}$ (the rolls of at most 3). Then:
>
> - $A \cup B = {\mathopen{}\left\{1, 2, 3, 4, 6\right\}\mathclose{}}$, the rolls that are even or at most 3;
> - $A \cap B = {\mathopen{}\left\{2\right\}\mathclose{}}$, the only roll that is both;
> - $A \setminus B = {\mathopen{}\left\{4, 6\right\}\mathclose{}}$, the even rolls greater than 3;
> - ${\mathopen{}\left\{2, 4, 6\right\}\mathclose{}} \cap {\mathopen{}\left\{1, 3, 5\right\}\mathclose{}} = \emptyset$: no roll is both even and odd.

> **NOTE:**
>
> **Example 17 (Unions and intersections of many sets)**  
>
> - $$\begin{aligned}
>   \bigcup_{i=1}^{3} {\mathopen{}\left\{i, i + 1\right\}\mathclose{}} &= {\mathopen{}\left\{1, 2\right\}\mathclose{}} \cup {\mathopen{}\left\{2, 3\right\}\mathclose{}} \cup {\mathopen{}\left\{3, 4\right\}\mathclose{}} \\
>   &= {\mathopen{}\left\{1, 2, 3, 4\right\}\mathclose{}}.
>   \end{aligned}$$
>
> - $\bigcup_{i=1}^{\infty} {\mathopen{}\left\{i\right\}\mathclose{}} = \mathbb{N}$: each natural number $n$ is in the set ${\mathopen{}\left\{n\right\}\mathclose{}}$, and each set ${\mathopen{}\left\{i\right\}\mathclose{}}$ contains only the natural number $i$.
>
> - $\bigcap_{i=1}^{\infty} [0, 1/i] = {\mathopen{}\left\{0\right\}\mathclose{}}$: $0$ is in every interval $[0, 1/i]$; a number $x > 0$ is not in $[0, 1/i]$ once $i > 1/x$; and a number $x < 0$ is in none of them.

> **NOTE:**
>
> **Theorem 4 (De Morgan’s laws)** Let $S$ be a set, let $I$ be a nonempty set of indices, and let $A_i$ be a [subset](#def-subset) of $S$ for each $i \in I$. Then the complement of a union is the intersection of the complements, ([Wikipedia contributors 2026c](#ref-wikipedia_de_morgans_laws)) and the complement of an intersection is the union of the complements:
>
> $$\begin{aligned}
> S \setminus \bigcup_{i \in I} A_i &= \bigcap_{i \in I} (S \setminus A_i) \\
> S \setminus \bigcap_{i \in I} A_i &= \bigcup_{i \in I} (S \setminus A_i)
> \end{aligned}$$
>
> With the complement notation of [Definition 27](#def-complement), these read $\mathopen{}\left(\bigcup_{i \in I} A_i\right)\mathclose{}^c = \bigcap_{i \in I} A_i^c$ and $\mathopen{}\left(\bigcap_{i \in I} A_i\right)\mathclose{}^c = \bigcup_{i \in I} A_i^c$.

> **NOTE:**
>
> *Proof*. Two sets are equal when they have the same elements ([Definition 1](#def-set)), so it is enough to show that an element $x$ is in the left-hand side [if and only if](proof-writing.llms.md#def-necessary-sufficient) ($\iff$) it is in the right-hand side. Each step applies the definition named at its right: set difference ([Definition 26](#def-set-difference)), union ([Definition 22](#def-union)) or intersection ([Definition 24](#def-intersection)). For the first law:
>
> $$\begin{aligned}
> x \in S \setminus \bigcup_{i \in I} A_i
> &\iff x \in S \text{ and } x \notin \bigcup_{i \in I} A_i
> && \text{(set difference)} \\
> &\iff x \in S \text{ and } x \notin A_i \text{ for every } i \in I
> && \text{(union)} \\
> &\iff x \in S \setminus A_i \text{ for every } i \in I
> && \text{(set difference)} \\
> &\iff x \in \bigcap_{i \in I} (S \setminus A_i)
> && \text{(intersection)}
> \end{aligned}$$
>
> For the second law:
>
> $$\begin{aligned}
> x \in S \setminus \bigcap_{i \in I} A_i
> &\iff x \in S \text{ and } x \notin \bigcap_{i \in I} A_i
> && \text{(set difference)} \\
> &\iff x \in S \text{ and } x \notin A_i \text{ for some } i \in I
> && \text{(intersection)} \\
> &\iff x \in S \setminus A_i \text{ for some } i \in I
> && \text{(set difference)} \\
> &\iff x \in \bigcup_{i \in I} (S \setminus A_i)
> && \text{(union)}
> \end{aligned}$$

> **NOTE:**
>
> **Example 18 (De Morgan’s laws for die rolls)** In $S = {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$, let $A = {\mathopen{}\left\{2, 4, 6\right\}\mathclose{}}$ and $B = {\mathopen{}\left\{1, 2, 3\right\}\mathclose{}}$, as in [Example 16](#exm-set-operations), so $A^c = {\mathopen{}\left\{1, 3, 5\right\}\mathclose{}}$ and $B^c = {\mathopen{}\left\{4, 5, 6\right\}\mathclose{}}$.
>
> - $$\begin{aligned}
>   (A \cup B)^c &= {\mathopen{}\left\{1, 2, 3, 4, 6\right\}\mathclose{}}^c \\
>   &= {\mathopen{}\left\{5\right\}\mathclose{}},
>   \end{aligned}$$
>
>   and
>
>   $$\begin{aligned}
>   A^c \cap B^c &= {\mathopen{}\left\{1, 3, 5\right\}\mathclose{}} \cap {\mathopen{}\left\{4, 5, 6\right\}\mathclose{}} \\
>   &= {\mathopen{}\left\{5\right\}\mathclose{}}.
>   \end{aligned}$$
>
> - $$\begin{aligned}
>   (A \cap B)^c &= {\mathopen{}\left\{2\right\}\mathclose{}}^c \\
>   &= {\mathopen{}\left\{1, 3, 4, 5, 6\right\}\mathclose{}},
>   \end{aligned}$$
>
>   and
>
>   $$\begin{aligned}
>   A^c \cup B^c &= {\mathopen{}\left\{1, 3, 5\right\}\mathclose{}} \cup {\mathopen{}\left\{4, 5, 6\right\}\mathclose{}} \\
>   &= {\mathopen{}\left\{1, 3, 4, 5, 6\right\}\mathclose{}}.
>   \end{aligned}$$

> **NOTE:**
>
> **Definition 28 (Disjoint sets)** Two [sets](#def-set) $A$ and $B$ are **disjoint** if their [intersection](#def-intersection) is the [empty set](#def-empty-set):
>
> $$A \cap B = \emptyset$$

> **NOTE:**
>
> **Example 19 (Two disjoint sets of die rolls)** For the die rolls $D = {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$ ([sets of die rolls](#exm-set)), the sets ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$ and ${\mathopen{}\left\{5, 6\right\}\mathclose{}}$ are disjoint: no roll is in both. The sets ${\mathopen{}\left\{2, 4, 6\right\}\mathclose{}}$ and ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$ are not, because $2$ is in both.

> **NOTE:**
>
> **Definition 29 (Pairwise disjoint sets, mutually disjoint sets)** Some [sets](#def-set) $A_1, A_2, \ldots$ (a list that may end or go on without end) are **pairwise disjoint** ([Wikipedia contributors 2026d](#ref-wikipedia_disjoint_sets)) (also called **mutually disjoint**) when every two of them are [disjoint](#def-disjoint-sets):
>
> $$A_i \cap A_j = \emptyset \quad \text{for all } i \neq j$$

> **NOTE:**
>
> **Example 20 (Low, middle and high die rolls)** For the die rolls $D = {\mathopen{}\left\{1, 2, 3, 4, 5, 6\right\}\mathclose{}}$ ([sets of die rolls](#exm-set)), the sets ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$, ${\mathopen{}\left\{3, 4\right\}\mathclose{}}$ and ${\mathopen{}\left\{5, 6\right\}\mathclose{}}$ are [pairwise disjoint](#def-pairwise-disjoint): no roll is in more than one of them. The sets ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$, ${\mathopen{}\left\{3, 4\right\}\mathclose{}}$ and ${\mathopen{}\left\{2, 5\right\}\mathclose{}}$ are not, because $2$ is in both the first and the third.

> **NOTE:**
>
> **Definition 30 (Ordered pair)** An **ordered pair** ([Wikipedia contributors 2026l](#ref-wikipedia_ordered_pair)) $(a, b)$ is a pair of objects listed in order, with $a$ first and $b$ second; two ordered pairs are equal, $(a, b) = (c, d)$, when $a = c$ and $b = d$.

> **NOTE:**
>
> **Definition 31 (Cartesian product)** The **Cartesian product** ([Wikipedia contributors 2026a](#ref-wikipedia_cartesian_product)) of sets $A$ and $B$, written $A \times B$, is the set of ordered pairs whose first entry is in $A$ and whose second entry is in $B$:
>
> $$A \times B \stackrel{\text{def}}{=}{\mathopen{}\left\{(a, b) : a \in A \text{ and } b \in B\right\}\mathclose{}}$$

> **NOTE:**
>
> **Example 21 (Cartesian products)**  
>
> - ${\mathopen{}\left\{1, 2\right\}\mathclose{}} \times {\mathopen{}\left\{5, 6\right\}\mathclose{}} = {\mathopen{}\left\{(1, 5), (1, 6), (2, 5), (2, 6)\right\}\mathclose{}}$. The pair $(5, 1)$ is not in it, because its first entry, $5$, is not in ${\mathopen{}\left\{1, 2\right\}\mathclose{}}$; so $(1, 5) \ne (5, 1)$.
> - The results of rolling a die twice form ${\mathopen{}\left\{1, \ldots, 6\right\}\mathclose{}} \times {\mathopen{}\left\{1, \ldots, 6\right\}\mathclose{}}$, which has $6 \cdot 6 = 36$ elements, such as $(3, 5)$: a 3 on the first roll and a 5 on the second.
> - $[0, 2] \times [0, 3]$ is the set of points $(x, y)$ in the plane with $0 \le x \le 2$ and $0 \le y \le 3$: a rectangle of width $2$ and height $3$.

> **NOTE:**
>
> **Definition 32 (Tuple)** For a [natural number](number-systems.llms.md#def-natural-numbers) $n$, an $n$-tuple ([Wikipedia contributors 2026q](#ref-wikipedia_tuple)) $(a_1, a_2, \ldots, a_n)$ is a list of $n$ objects in order. Two $n$-tuples are equal when their entries are equal in each position.

> **NOTE:**
>
> **Example 22 (Dates as tuples)**  
>
> A calendar date can be written as a $3$-[tuple](#def-tuple) (year, month, day), such as $(2027, 1, 4)$ for 4 January 2027. The $3$-tuples $(2027, 1, 4)$ and $(2027, 4, 1)$ are not the same, because their second entries differ, and they name different days. An [ordered pair](#def-ordered-pair) is a $2$-tuple.

> **NOTE:**
>
> **Definition 33 (Cartesian product of several sets)** For a [natural number](number-systems.llms.md#def-natural-numbers) $n$ and [sets](#def-set) $A_1, A_2, \ldots, A_n$, the **Cartesian product** ([Wikipedia contributors 2026a](#ref-wikipedia_cartesian_product)) $A_1 \times A_2 \times \cdots \times A_n$ is the [set](#def-set) of $n$-[tuples](#def-tuple) whose $i$th entry is in $A_i$ for each $i$:
>
> $$A_1 \times \cdots \times A_n \stackrel{\text{def}}{=}{\mathopen{}\left\{(a_1, \ldots, a_n) : a_i \in A_i \text{ for each } i\right\}\mathclose{}}$$

> **NOTE:**
>
> **Example 23 (Three coin flips)**  
>
> Let $C = {\mathopen{}\left\{H, T\right\}\mathclose{}}$ be the faces of a coin. The ways three flips can come out form the [Cartesian product](#def-cartesian-product-many) $C \times C \times C$, whose elements are the eight $3$-[tuples](#def-tuple)
>
> $$(H, H, H), (H, H, T), (H, T, H), (H, T, T), (T, H, H), (T, H, T), (T, T, H), (T, T, T).$$
>
> For example, $(H, T, T)$ is heads on the first flip and tails on the second and third.

# 2 Extended non-negative real numbers

> **NOTE:**
>
> **Definition 34 (Extended non-negative real numbers)** The **extended non-negative real numbers**, written $[0, \infty]$, are the non-negative real numbers together with an extra element $\infty$ that is greater than every real number:
>
> $$[0, \infty] \stackrel{\text{def}}{=}[0, \infty) \cup {\mathopen{}\left\{\infty\right\}\mathclose{}}$$
>
> Addition extends to $[0, \infty]$ by setting
>
> $$\begin{aligned}
> x + \infty &= \infty + x \\
> &= \infty
> \end{aligned}$$
>
> for every $x \in [0, \infty]$.

> **NOTE:**
>
> *Remark 7* (Arithmetic with $\infty$). $\infty$ is not a real number, so some real-number arithmetic does not extend to it: $\infty - \infty$ is left undefined, and $\infty + 1 = \infty + 2$ does not imply $1 = 2$. Measure theory uses $[0, \infty]$ because the size of a set, such as the length of the whole real line, can be infinite ([Wikipedia contributors 2026f](#ref-wikipedia_extended_real_number_line)).

> **NOTE:**
>
> **Example 24 (Adding with** $\infty$) In $[0, \infty]$, $2 + 3 = 5$ as usual, while $2 + \infty = \infty$ and $\infty + \infty = \infty$.

# 3 Further reading

These books and articles treat sets and the logic behind them in more depth.

- Devlin ([1993](#ref-devlin1993joy)) is an undergraduate introduction to axiomatic set theory. It covers the axioms of set theory, ordinals, and cardinals, which go well beyond the countable sets and functions in these notes.
- Halmos ([1974](#ref-halmos1974naive)) is a short, informal treatment of the same axioms, covering relations, functions, families of sets, and cardinal numbers.
- Enderton ([2001](#ref-enderton2001logic)) is a standard introduction to mathematical logic. Its first chapter collects the facts about sets, relations, and functions that the later chapters use.
- Barker-Plummer et al. ([2011](#ref-barkerplummer2011language)) teaches propositional and first-order logic, the language behind statements such as “for every set $A$ there exists…”.

# Definitions on this page

- [Definition 1 (Set)](#def-set)
- [Definition 2 (Roster notation)](#def-roster-notation)
- [Definition 3 (Set-builder notation)](#def-set-builder)
- [Definition 4 (Set-builder notation with an expression)](#def-set-builder-expression)
- [Definition 5 (Subset)](#def-subset)
- [Definition 6 (Strict subset, proper subset)](#def-strict-subset)
- [Definition 7 (Superset)](#def-superset)
- [Definition 8 (Strict superset)](#def-strict-superset)
- [Definition 9 (Empty set)](#def-empty-set)
- [Definition 10 (Vacuous truth)](#def-vacuous-truth)
- [Definition 11 (Power set)](#def-power-set)
- [Definition 12 (Lower bound and upper bound)](#def-bound)
- [Definition 13 (Interval)](#def-interval)
- [Definition 14 (Closed interval)](#def-closed-interval)
- [Definition 15 (Open interval)](#def-open-interval)
- [Definition 16 (Half-open intervals)](#def-half-open-interval)
- [Definition 17 (Unbounded intervals)](#def-unbounded-interval)
- [Definition 18 (Collection of sets, family of sets)](#def-collection)
- [Definition 19 (Label)](#def-label)
- [Definition 20 (Index set)](#def-index-set)
- [Definition 21 (Indexed family)](#def-indexed-family)
- [Definition 22 (Union)](#def-union)
- [Definition 23 (Union of a family of sets)](#def-indexed-union)
- [Definition 24 (Intersection)](#def-intersection)
- [Definition 25 (Intersection of a family of sets)](#def-indexed-intersection)
- [Definition 26 (Set difference)](#def-set-difference)
- [Definition 27 (Complement)](#def-complement)
- [Definition 28 (Disjoint sets)](#def-disjoint-sets)
- [Definition 29 (Pairwise disjoint sets, mutually disjoint sets)](#def-pairwise-disjoint)
- [Definition 30 (Ordered pair)](#def-ordered-pair)
- [Definition 31 (Cartesian product)](#def-cartesian-product)
- [Definition 32 (Tuple)](#def-tuple)
- [Definition 33 (Cartesian product of several sets)](#def-cartesian-product-many)
- [Definition 34 (Extended non-negative real numbers)](#def-extended-nonneg-reals)

# References

Barker-Plummer, Dave, Jon Barwise, and John Etchemendy. 2011. *Language, Proof and Logic*. 2nd ed. CSLI Publications. <https://www.amazon.com/dp/1575866323>.

Devlin, Keith. 1993. *The Joy of Sets: Fundamentals of Contemporary Set Theory*. 2nd ed. Undergraduate Texts in Mathematics. Springer. <https://doi.org/10.1007/978-1-4612-0903-4>.

Enderton, Herbert B. 2001. *A Mathematical Introduction to Logic*. 2nd ed. Academic Press. <https://doi.org/10.1016/C2009-0-22107-6>.

Halmos, Paul R. 1974. *Naive Set Theory*. Undergraduate Texts in Mathematics. Springer. <https://doi.org/10.1007/978-1-4757-1645-0>.

Wikipedia contributors. 2026a. *Cartesian Product — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Cartesian_product>.

Wikipedia contributors. 2026b. *Complement (Set Theory) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Complement_(set_theory)>.

Wikipedia contributors. 2026c. *De Morgan’s Laws — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/De_Morgan%27s_laws>.

Wikipedia contributors. 2026d. *Disjoint Sets — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Disjoint_sets>.

Wikipedia contributors. 2026e. *Empty Set — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Empty_set>.

Wikipedia contributors. 2026f. *Extended Real Number Line — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Extended_real_number_line>.

Wikipedia contributors. 2026g. *Family of Sets — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Family_of_sets>.

Wikipedia contributors. 2026h. *Index Set — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Index_set>.

Wikipedia contributors. 2026i. *Indexed Family — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Indexed_family>.

Wikipedia contributors. 2026j. *Intersection (Set Theory) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Intersection_(set_theory)>.

Wikipedia contributors. 2026k. *Interval (Mathematics) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Interval_(mathematics)>.

Wikipedia contributors. 2026l. *Ordered Pair — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Ordered_pair>.

Wikipedia contributors. 2026m. *Power Set — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Power_set>.

Wikipedia contributors. 2026n. *Set (Mathematics) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Set_(mathematics)>.

Wikipedia contributors. 2026o. *Set-Builder Notation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Set-builder_notation>.

Wikipedia contributors. 2026p. *Subset — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Subset>.

Wikipedia contributors. 2026q. *Tuple — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Tuple>.

Wikipedia contributors. 2026r. *Union (Set Theory) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Union_(set_theory)>.

Wikipedia contributors. 2026s. *Vacuous Truth — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Vacuous_truth>.

Back to top
