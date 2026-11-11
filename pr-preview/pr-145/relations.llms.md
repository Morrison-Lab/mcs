# Relations

Code

Published

Last modified: 2026-11-11 02:27:42 (PST)

> **NOTE:**
>
> *Remark*. A [relation](functions.llms.md#def-relation) says which pairs of elements of a [set](sets.llms.md#def-set) are related. This page defines the properties that make a relation behave like equality, and the groups of elements that such a relation puts together.

# 1 Properties of relations

> **NOTE:**
>
> **Definition 1 (Reflexive relation)** Let $\sim$ be a [relation](functions.llms.md#def-relation) on a [set](sets.llms.md#def-set) $S$. The relation $\sim$ is **reflexive** ([Wikipedia contributors 2026c](#ref-wikipedia_reflexive_relation)) if $a \sim a$ for every $a \in S$.

> **NOTE:**
>
> **Example 1 (Reflexive and non-reflexive relations on the real numbers)** On $\mathbb{R}$, the [relation](functions.llms.md#def-relation) $=$ is [reflexive](#def-reflexive), since $a = a$ for every [real number](number-systems.llms.md#def-real-numbers) $a$. The relation $\le$ is also reflexive, since $a \le a$ for every real number $a$. The relation $<$ is not reflexive, since $2 < 2$ is false.

> **NOTE:**
>
> **Definition 2 (Symmetric relation)** Let $\sim$ be a [relation](functions.llms.md#def-relation) on a [set](sets.llms.md#def-set) $S$. The relation $\sim$ is **symmetric** ([Wikipedia contributors 2026d](#ref-wikipedia_symmetric_relation)) if, [for all](proof-writing.llms.md#def-universal-quantifier) $a, b \in S$, $a \sim b$ [implies](proof-writing.llms.md#def-implies) $b \sim a$.

> **NOTE:**
>
> **Example 2 (Symmetric and non-symmetric relations on the real numbers)** On $\mathbb{R}$, the [relation](functions.llms.md#def-relation) $=$ is [symmetric](#def-symmetric-relation): whenever $a = b$, also $b = a$. The relation $\le$ is not symmetric, since $2 \le 5$ is true but $5 \le 2$ is false.

# 2 Equivalence relations

> **NOTE:**
>
> **Definition 3 (Equivalence relation)** Let $\sim$ be a [relation](functions.llms.md#def-relation) on a [set](sets.llms.md#def-set) $S$. The relation $\sim$ is an **equivalence relation** ([Wikipedia contributors 2026b](#ref-wikipedia_equivalence_relation)) if it is [reflexive](#def-reflexive), [symmetric](#def-symmetric-relation), and [transitive](chapters/relations.llms.md#def-transitive).

> **NOTE:**
>
> **Example 3 (Integers with an even difference)** On the [integers](number-systems.llms.md#def-integers), define the [relation](functions.llms.md#def-relation) $\sim$ by $a \sim b$ when $a - b$ is [even](number-systems.llms.md#def-even-odd). For example, $7 \sim 3$, since $7 - 3 = 4 = 2 \cdot 2$, but $7 \not\sim 4$, since $7 - 4 = 3$ is [odd](number-systems.llms.md#def-odd). The relation $\sim$ is an [equivalence relation](#def-equivalence-relation).
>
> **[Reflexive](#def-reflexive).** For every [integer](number-systems.llms.md#def-integers) $a$, $a - a = 0 = 2 \cdot 0$, so $a \sim a$.
>
> **[Symmetric](#def-symmetric-relation).** Suppose $a \sim b$, so $a - b = 2k$ for some integer $k$. Then
>
> $$\begin{aligned}
> b - a
> &= -(a - b)
> && \text{(negate the difference)}
> \\
> &= -2k
> && \text{(} a - b = 2k \text{)}
> \\
> &= 2(-k),
> && \text{(factor out } 2 \text{)}
> \end{aligned}$$
>
> and $-k$ is an integer, so $b \sim a$.
>
> **[Transitive](chapters/relations.llms.md#def-transitive).** Suppose $a \sim b$ and $b \sim c$, so $a - b = 2j$ and $b - c = 2k$ for some integers $j$ and $k$. Then
>
> $$\begin{aligned}
> a - c
> &= (a - b) + (b - c)
> && \text{(the } b \text{ terms cancel)}
> \\
> &= 2j + 2k
> && \text{(} a - b = 2j \text{ and } b - c = 2k \text{)}
> \\
> &= 2(j + k),
> && \text{(distributive law)}
> \end{aligned}$$
>
> and $j + k$ is an integer, so $a \sim c$.

> **NOTE:**
>
> **Definition 4 (Equivalence class)** Let $\sim$ be an [equivalence relation](#def-equivalence-relation) on a [set](sets.llms.md#def-set) $S$, and let $a \in S$. The **equivalence class** ([Wikipedia contributors 2026a](#ref-wikipedia_equivalence_class)) of $a$ is the set of elements of $S$ related to $a$:
>
> $$[a] \stackrel{\text{def}}{=}{\mathopen{}\left\{b \in S : b \sim a\right\}\mathclose{}}.$$

> **NOTE:**
>
> **Example 4 (Equivalence classes of integers with an even difference)** Let $\sim$ be the [equivalence relation](#def-equivalence-relation) of [Example 3](#exm-equivalence-relation) on the [integers](number-systems.llms.md#def-integers). The [equivalence class](#def-equivalence-class) $[0]$ holds the integers $b$ with $b - 0$ even, which are the [even integers](number-systems.llms.md#def-even-odd): $[0] = \mathopen{}\left\{\ldots, -4, -2, 0, 2, 4, \ldots\right\}\mathclose{}$. The class $[1]$ holds the integers $b$ with $b - 1$ even, which are the [odd integers](number-systems.llms.md#def-odd): $[1] = \mathopen{}\left\{\ldots, -3, -1, 1, 3, 5, \ldots\right\}\mathclose{}$. The class $[2]$ is the same [set](sets.llms.md#def-set) as $[0]$, since $2 \sim 0$.

# Definitions on this page

- [Definition 1 (Reflexive relation)](#def-reflexive)
- [Definition 2 (Symmetric relation)](#def-symmetric-relation)
- [Definition 3 (Equivalence relation)](#def-equivalence-relation)
- [Definition 4 (Equivalence class)](#def-equivalence-class)

# References

Wikipedia contributors. 2026a. *Equivalence Class — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Equivalence_class>.

Wikipedia contributors. 2026b. *Equivalence Relation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Equivalence_relation>.

Wikipedia contributors. 2026c. *Reflexive Relation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Reflexive_relation>.

Wikipedia contributors. 2026d. *Symmetric Relation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Symmetric_relation>.

Back to top
