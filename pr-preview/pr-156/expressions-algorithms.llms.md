# Expressions and Algorithms

Code

Published

Last modified: 2026-11-11 18:18:30 (PST)

> **NOTE:**
>
> *Remark*. A function can be written down as an expression and computed by an algorithm. This page defines expressions, which write down the [functions](functions.llms.md) in the Morrison Lab’s probability and statistics notes, the parse trees of expressions, and algorithms, which compute those functions.

# 1 Expressions

> **NOTE:**
>
> **Definition 1 (Expression)** An **expression** ([Wikipedia contributors 2026c](#ref-wikipedia_expression_mathematics)) is a string of symbols, built from constants, variables, operations and function names according to the rules of the notation.

> **NOTE:**
>
> **Definition 2 (Denotes)** An [expression](#def-expression) **denotes** a [function](functions.llms.md#def-function) when evaluating the expression at each [input](functions.llms.md#def-argument) of the function, with the expression’s variables taking that input, gives the function’s [value](functions.llms.md#def-value) at that input.

> **NOTE:**
>
> **Example 1 (Two expressions for one function)** The [expressions](#def-expression) $a x^2 + b x + c$ and $(a x + b)\,x + c$ [denote](#def-denotes) the same [function](functions.llms.md#def-function) of $x$ for any fixed $a$, $b$ and $c$, because they give the same value at every $x$.
>
> Precedence parses $a x^2 + b x + c$ as a sum of three terms: the power $x^2$ is applied first, then $a$ multiplies $x^2$ and $b$ multiplies $x$, and the three products are added. The parentheses in $(a x + b)\,x + c$ force a different tree: $a$ multiplies $x$, $b$ is added, the sum multiplies $x$, and $c$ is added.

> **NOTE:**
>
> **Definition 3 (Closed-form expression (formula))** A **closed-form expression** (or **formula**) ([Wikipedia contributors 2026b](#ref-wikipedia_closed_form_expression)) is an [expression](#def-expression) built from constants and variables using a finite number of operations from a list of accepted [functions](functions.llms.md#def-function), such as [powers](https://morrison-lab.github.io/mds/algebra-basics.html#def-power), roots, exponentials, logarithms, and trigonometric functions. Which functions are accepted is a convention, and a source states it when the boundary matters.

> **NOTE:**
>
> **Example 2 (The quadratic formula)** For $a \neq 0$ with $b^2 - 4 a c \ge 0$, the roots of $a x^2 + b x + c = 0$ are
>
> $$x = \frac{-b \pm \sqrt{b^2 - 4 a c}}{2 a},$$
>
> where the right-hand side is a [closed-form expression](#def-closed-form-expression) in $a$, $b$, and $c$. By contrast, no closed-form expression is known for the root of $x - \cos x = 0$.

> **NOTE:**
>
> **Definition 4 (Closed-form solution)** A **closed-form solution** of a problem, such as solving an equation or minimizing a [function](functions.llms.md#def-function), is a [closed-form expression](#def-closed-form-expression) for the answer.

> **NOTE:**
>
> **Example 3 (Least squares versus logistic regression)** Minimizing the [squared-error](https://morrison-lab.github.io/mds/vector-calculus.html#def-squared-error) cost of a [linear](https://morrison-lab.github.io/mds/algebra.html#def-linear-function) model over $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}$ gives the [normal equations](https://morrison-lab.github.io/mds/linear-algebra-projections.html#def-normal-equations) ${\mathbf{D}}^{\top} \mathbf{D} \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}= {\mathbf{D}}^{\top} \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{y}}\vphantom{y}}$. When ${\mathbf{D}}^{\top} \mathbf{D}$ is [invertible](https://morrison-lab.github.io/mds/linear-algebra-special-matrices.html#def-matrix-inverse), the unique minimizer is
>
> $$\hat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}= {\mathopen{}\left({\mathbf{D}}^{\top} \mathbf{D}\right)\mathclose{}}^{-1} {\mathbf{D}}^{\top} \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{y}}\vphantom{y}},$$
>
> whose right-hand side is a [closed-form expression](#def-closed-form-expression), so [least squares](https://morrison-lab.github.io/mds/linear-algebra-projections.html#def-least-squares) has a [closed-form solution](#def-closed-form-solution).
>
> For logistic regression, no closed-form expression is known for a minimizer of the negative log-likelihood over $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}$, so that problem has no known closed-form solution. When a minimizer exists, an [iterative method](https://morrison-lab.github.io/mds/optimization.html#def-iterative-method) approximates it.

> **NOTE:**
>
> **Definition 5 (Parse tree)** The **parse tree** ([Wikipedia contributors 2026d](#ref-wikipedia_parse_tree)) of an [expression](#def-expression) is the tree that shows how its symbols group into operations. Its leaves are the constants and variables of the expression, and each internal node is an operation applied to the nodes below it.

> **NOTE:**
>
> **Example 4 (The parse tree of a polynomial)** The [parse tree](#def-parse-tree) of $(a x + b)\,x + c$, with each operation having two children, is drawn in [Figure 1](#fig-parse-trees) (left) and written out as a list here:
>
> - the root $+$, whose children are
>   - the node $\times$, whose children are
>     - the node $+$, whose children are
>       - the node $\times$, whose children are the leaves $a$ and $x$,
>       - the leaf $b$;
>     - the leaf $x$;
>   - the leaf $c$.
>
> Read from the leaves up, the tree says to multiply $a$ by $x$, add $b$, multiply by $x$, and add $c$. The [expression](#def-expression) $a x^2 + b x + c$ has a different tree ([Figure 1](#fig-parse-trees), right). Its root is the $+$ whose children are $a x^2 + b x$ and $c$, and the first of these is a $+$ whose children are $a x^2$ and $b x$.

Show code

``` r
# Each tree is a nested list: the first element is the node's label,
# and the remaining elements are its children.
times <- intToUtf8(215)
trees <- list(
  "(a * x + b) * x + c" = list(
    "+",
    list(times, list("+", list(times, "a", "x"), "b"), "x"),
    "c"
  ),
  "a * x^2 + b * x + c" = list(
    "+",
    list(
      "+",
      list(times, "a", list("^", "x", "2")),
      list(times, "b", "x")
    ),
    "c"
  )
)

# Leaves sit at consecutive x positions;
# each operation sits above the mean of its children.
layout_tree <- function(node, depth = 0, next_x = 0) {
  if (!is.list(node)) {
    return(list(
      nodes = data.frame(label = node, x = next_x, y = -depth, is_leaf = TRUE),
      edges = NULL,
      next_x = next_x + 1
    ))
  }
  nodes <- NULL
  edges <- NULL
  child_x <- numeric()
  for (child in node[-1]) {
    sub <- layout_tree(child, depth + 1, next_x)
    next_x <- sub$next_x
    child_x <- c(child_x, sub$nodes$x[1])
    edges <- rbind(
      edges,
      sub$edges,
      data.frame(
        x = NA_real_,
        y = -depth,
        xend = sub$nodes$x[1],
        yend = sub$nodes$y[1]
      )
    )
    nodes <- rbind(nodes, sub$nodes)
  }
  me <- data.frame(
    label = node[[1]],
    x = mean(child_x),
    y = -depth,
    is_leaf = FALSE
  )
  edges$x[is.na(edges$x)] <- me$x
  list(nodes = rbind(me, nodes), edges = edges, next_x = next_x)
}

laid_out <- lapply(trees, layout_tree)
tree_nodes <- do.call(rbind, Map(
  function(res, name) cbind(res$nodes, tree = name),
  laid_out,
  names(trees)
))
tree_edges <- do.call(rbind, Map(
  function(res, name) cbind(res$edges, tree = name),
  laid_out,
  names(trees)
))
tree_nodes$kind <- ifelse(tree_nodes$is_leaf, "leaf", "operation")
tree_nodes$tree <- factor(tree_nodes$tree, levels = names(trees))
tree_edges$tree <- factor(tree_edges$tree, levels = names(trees))

ggplot2::ggplot() +
  ggplot2::geom_segment(
    data = tree_edges,
    ggplot2::aes(x = x, y = y, xend = xend, yend = yend),
    colour = "grey50"
  ) +
  ggplot2::geom_label(
    data = tree_nodes,
    ggplot2::aes(x = x, y = y, label = label, fill = kind),
    size = 5,
    linewidth = 0
  ) +
  ggplot2::scale_fill_manual(
    values = c(operation = "#CCE5F6", leaf = "#F9DDBF")
  ) +
  ggplot2::facet_wrap(
    ~tree,
    scales = "free_x",
    labeller = ggplot2::label_parsed
  ) +
  ggplot2::labs(fill = "node type") +
  ggplot2::theme_void() +
  ggplot2::theme(
    legend.position = "bottom",
    strip.text = ggplot2::element_text(size = 12)
  )
```

[![Two parse trees, drawn with the root at the top. In the left tree the root plus has children times and the leaf c. That times has children plus and the leaf x. The plus below it has children times and the leaf b, and that times has the leaves a and x. In the right tree the root plus has children plus and the leaf c. That plus has two children, both times. The first times has the leaf a and a power node with leaves x and 2. The second times has the leaves b and x.](expressions-algorithms_files/figure-html/parse-trees-plot-1.png)](expressions-algorithms_files/figure-html/parse-trees-plot-1.png "Figure 1: The parse trees of (a x + b)\,x + c and a x^2 + b x + c. Each operation is a node with one child per argument, and the leaves are the symbols that are not operations. The caret is the power operation, which takes a base and an exponent.")

Figure 1: The [parse trees](#def-parse-tree) of $(a x + b)\,x + c$ and $a x^2 + b x + c$. Each operation is a node with one child per [argument](functions.llms.md#def-argument), and the leaves are the symbols that are not operations. The caret is the [power](https://morrison-lab.github.io/mds/algebra-basics.html#def-power) operation, which takes a [base](https://morrison-lab.github.io/mds/algebra-basics.html#def-power-base) and an [exponent](https://morrison-lab.github.io/mds/algebra-basics.html#def-power-exponent).

> **NOTE:**
>
> *Remark 1* (Expressions, precedence and parse trees). An [expression](#def-expression) does not say how to compute the [output](functions.llms.md#def-value) it fixes, and many [expressions](#def-expression) [denote](#def-denotes) the same [function](functions.llms.md#def-function). A function is the input-output relationship itself; an expression is one way of writing it down.
>
> The rules of operator precedence (PEMDAS: parentheses, exponents, multiplication and division, addition and subtraction) decide how the symbols group. They turn the string into its parse tree ([Definition 5](#def-parse-tree)).

# 2 Algorithms

> **NOTE:**
>
> **Definition 6 (Algorithm)** An **algorithm** ([Wikipedia contributors 2026a](#ref-wikipedia_algorithm)) is a finite list of unambiguous steps that, applied to any valid input, halts and returns an output.

> **NOTE:**
>
> **Definition 7 (Computes)** An [algorithm](#def-algorithm) **computes** a [function](functions.llms.md#def-function) when, for each [input](functions.llms.md#def-argument), it returns the function’s [value](functions.llms.md#def-value) at that input.

> **NOTE:**
>
> **Example 5 (Two algorithms for one function)** Take the [function](functions.llms.md#def-function) that [Example 1](#exm-expression) writes two ways. Evaluating the tree of $a x^2 + b x + c$, with $x^2$ computed as $x \cdot x$, takes three multiplications and two additions. Evaluating the tree of Horner’s form $(a x + b)\,x + c$ takes two multiplications and two additions. We evaluate both forms at $a = 2$, $b = -3$, $c = 5$ and $x = 1.5$, in R and in Python, and give each intermediate quantity a name. (The code calls $c$ `c0`, because `c` is a built-in function in R.) The two [algorithms](#def-algorithm) [compute](#def-computes) the same function, so the two [values](functions.llms.md#def-value) must agree.
>
> ## R
>
> ``` r
> a <- 2
> b <- -3
> c0 <- 5
> x <- 1.5
> # Expanded form: 3 multiplications, 2 additions
> square_term <- a * x * x
> linear_term <- b * x
> expanded <- square_term + linear_term + c0
> # Horner's form: 2 multiplications, 2 additions
> inner <- a * x + b
> horner <- inner * x + c0
> c(square_term, linear_term, expanded)
> #> [1]  4.5 -4.5  5.0
> c(inner, horner)
> #> [1] 0 5
> ```
>
> ## Python
>
> ``` python
> a = 2
> b = -3
> c0 = 5
> x = 1.5
> # Expanded form: 3 multiplications, 2 additions
> square_term = a * x * x
> linear_term = b * x
> expanded = square_term + linear_term + c0
> # Horner's form: 2 multiplications, 2 additions
> inner = a * x + b
> horner = inner * x + c0
> print(square_term, linear_term, expanded)
> #> 4.5 -4.5 5.0
> print(inner, horner)
> #> 0.0 5.0
> ```
>
> The expanded form adds 4.5, -4.5 and 5 to reach 5. Horner’s form multiplies 0 by 1.5 and adds 5 to reach 5. Different steps give the same [value](functions.llms.md#def-value).

> **NOTE:**
>
> *Remark 2* (Procedures that are not algorithms here). By the definition of an [algorithm](#def-algorithm), every algorithm [computes](#def-computes) some [function](functions.llms.md#def-function). That holds because an algorithm has unambiguous steps and halts on every valid [input](functions.llms.md#def-argument). A procedure that makes random choices can return different [values](functions.llms.md#def-value) for the same input. A procedure that never halts returns no [value](functions.llms.md#def-value) for some inputs. Neither computes a function, and neither is an algorithm in this sense, although some texts call them [algorithms](#def-algorithm).

> **NOTE:**
>
> *Remark 3* (How functions, expressions and algorithms relate). The three ideas fit together this way:
>
> - A [function](functions.llms.md#def-function) is the input-output relationship.
> - An [expression](#def-expression) [denotes](#def-denotes) a function, and many expressions denote the same one.
> - An [algorithm](#def-algorithm) [computes](#def-computes) a function, and many algorithms compute the same one.
>
> An expression is not an algorithm, because it does not say what to do, or in what order. Given values for its variables, evaluating its parse tree from the leaves up is one algorithm for the function it denotes, and a different expression for the same function gives a different tree and a different algorithm.

> **NOTE:**
>
> *Remark 4* (Values with no known algorithm). Some functions have no known finite algorithm for their exact values, and [expressions](#def-expression) that [denote](#def-denotes) them, such as a limit, a supremum, an integral with no closed form, or an $\arg \min$ over a set with no formula for the minimizer, cannot be evaluated by following their tree. Such a value can still be well defined and approximated by an algorithm.

> **NOTE:**
>
> **Example 6 (A minimizer with no known formula)** The minimizer $\arg \min_{x \in \mathbb{R}} \mathopen{}\left(x - \cos x\right)\mathclose{}^2$ is well defined, because $x - \cos x$ is strictly increasing and equals zero at one point, yet that point has no known closed-form expression, so no known finite list of arithmetic steps returns it exactly. An algorithm such as bisection approximates it as closely as we like.

# 3 Exercises

> **NOTE:**
>
> **Exercise 1 (Is an expression an algorithm?)** How do a [function](functions.llms.md#def-function), an [expression](#def-expression) and an [algorithm](#def-algorithm) differ?

> **NOTE:**
>
> *Solution 1*. A [function](functions.llms.md#def-function) is the input-output relationship. An [expression](#def-expression) is a string of symbols that [denotes](#def-denotes) a function, and many [expressions](#def-expression) denote the same one. An [algorithm](#def-algorithm) is a [finite](functions.llms.md#def-finite-sequence) list of steps that [computes](#def-computes) a function, and many [algorithms](#def-algorithm) compute the same one.

> **NOTE:**
>
> **Exercise 2 (Is an expression an algorithm? (part 2))** Use the setup of [Exercise 1](#exr-expression-or-algorithm).
>
> Which of the three does $a x^2 + b x + c$ name: a [function](functions.llms.md#def-function), an [expression](#def-expression) or an [algorithm](#def-algorithm)?

> **NOTE:**
>
> *Solution 2*. It is an [expression](#def-expression): it names a [function](functions.llms.md#def-function), and it is not an [algorithm](#def-algorithm).

> **NOTE:**
>
> **Exercise 3 (Is an expression an algorithm? (part 3))** Use the setup of [Exercise 1](#exr-expression-or-algorithm).
>
> Does the [expression](#def-expression) $a x^2 + b x + c$ tell you which arithmetic steps to carry out?

> **NOTE:**
>
> *Solution 3*. Not by itself. The [expression](#def-expression) says *what* to compute, not *how* to compute it. Once $a$, $b$, $c$ and $x$ are known, evaluating its [parse tree](#def-parse-tree) from the leaves up is an [algorithm](#def-algorithm).

> **NOTE:**
>
> **Exercise 4 (Is an expression an algorithm? (part 4))** Use the setup of [Exercise 1](#exr-expression-or-algorithm).
>
> What do the rules of precedence (PEMDAS) contribute to the [expression](#def-expression) $a x^2 + b x + c$?

> **NOTE:**
>
> *Solution 4*. Precedence resolves how the symbols group: $a x^2 + b x + c$ groups into three parts added together, with $x^2$ evaluated before the multiplication by $a$, and that grouping is a [tree](#def-parse-tree). Precedence is a rule for reading the [expression](#def-expression), not a step in an [algorithm](#def-algorithm) that evaluates it.

> **NOTE:**
>
> **Exercise 5 (Is an expression an algorithm? (part 5))** Use the setup of [Exercise 1](#exr-expression-or-algorithm).
>
> Write a second [expression](#def-expression) that [denotes](#def-denotes) the same [function](functions.llms.md#def-function) as $a x^2 + b x + c$ and needs fewer multiplications.

> **NOTE:**
>
> *Solution 5*. $(a x + b)\,x + c$, Horner’s form. It uses two multiplications and two additions, where the first form, with $x^2$ computed as $x \cdot x$, uses three multiplications and two additions. The two [expressions](#def-expression) denote the same [function](functions.llms.md#def-function) and describe different [algorithms](#def-algorithm).

# Definitions on this page

- [Definition 1 (Expression)](#def-expression)
- [Definition 2 (Denotes)](#def-denotes)
- [Definition 3 (Closed-form expression (formula))](#def-closed-form-expression)
- [Definition 4 (Closed-form solution)](#def-closed-form-solution)
- [Definition 5 (Parse tree)](#def-parse-tree)
- [Definition 6 (Algorithm)](#def-algorithm)
- [Definition 7 (Computes)](#def-computes)

# References

Wikipedia contributors. 2026a. *Algorithm — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Algorithm>.

Wikipedia contributors. 2026b. *Closed-Form Expression — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Closed-form_expression>.

Wikipedia contributors. 2026c. *Expression (Mathematics) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Expression_(mathematics)>.

Wikipedia contributors. 2026d. *Parse Tree — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Parse_tree>.

Back to top
