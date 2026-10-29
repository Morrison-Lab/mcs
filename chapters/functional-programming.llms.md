# Functional Programming

Code

Expressions, functions and cases in Racket

Published

Last modified: 2026-10-29 13:30:08 (PDT)

> **NOTE:**
>
> Kameron Decker Harris’s Fall 2026 syllabus opens the course with an introduction to functional programming; this chapter, its examples and its exercises are new.
>
> The definitions of expression, function, argument and value are included from the [mathematics prerequisites](https://morrison-lab.github.io/mds/) notes, so they read the same in both places.

# 1 Expressions

> **NOTE:**
>
> *Remark 1* (Running Racket). This course writes its programs in [Racket](https://racket-lang.org/), a programming language that grew out of Scheme, a dialect of Lisp. Racket comes with DrRacket, the program you use to write and run Racket code, and Lab 1 walks through using it. Each Racket file in this course starts with the line `#lang racket`. The [Racket Guide](https://docs.racket-lang.org/guide/) is the reference for anything these notes do not cover.

> **NOTE:**
>
> **Exercise 1 (Operation first)** Racket writes \\7 - 2\\ as `(- 7 2)`, with the operation first and the parentheses around the whole expression. Guess what each Racket expression returns:
>
> 1.  `(* (+ 1 2) (- 10 4))`
> 2.  `(- 20 (* 3 (+ 1 1)))`
> 3.  `(+ 1 2 3 4)`
>
> Then write \\(2 + 3) \cdot 4 - 1\\ in Racket.

> **NOTE:**
>
> *Solution 1*. Work from the innermost parentheses outward.
>
> 1.  `(+ 1 2)` is 3 and `(- 10 4)` is 6, so the expression is `(* 3 6)`, which returns 18.
> 2.  `(+ 1 1)` is 2, so `(* 3 (+ 1 1))` is 6, and `(- 20 6)` returns 14.
> 3.  `+` can take any number of operands, and adds them all, so the expression returns 10.
>
> The expression \\(2 + 3) \cdot 4 - 1\\ subtracts 1 from the product of \\2 + 3\\ and 4, so in Racket it is `(- (* (+ 2 3) 4) 1)`, which returns 19.

> **NOTE:**
>
> **Definition 1 (Function (map, mapping, transformation))** A **function** \\f\\ from a set \\A\\ to a set \\B\\, ([Wikipedia contributors 2026b](#ref-wikipedia_function_mathematics)) written \\f : A \to B\\, assigns to each element \\a \in A\\ exactly one element \\f(a) \in B\\.
>
> A function is also called a **map** (or **mapping**) or a **transformation**; on this site the three words mean the same thing, although some authors reserve “transformation” for a function from a set to itself.

> **NOTE:**
>
> **Definition 2 (Expression)** An **expression** ([Wikipedia contributors 2026a](#ref-wikipedia_expression_mathematics)) is a string of symbols, built from constants, variables, operations and function names according to the rules of the notation. When its variables are read as inputs, an expression *denotes* a [function](../chapters/functional-programming.llms.md#def-function): it fixes the output for each input.

> **NOTE:**
>
> **Definition 3 (Racket expression, prefix notation)** A **Racket expression** ([Definition 2](#def-expression)) is one of:
>
> - a constant, such as the number `7`;
> - a name, such as `x` or `+`;
> - an **application** `(f e1 ... en)`: an expression `f` for an operation or function, followed by its operands `e1`, …, `en`, which are expressions too, all inside one pair of parentheses.
>
> Writing the operation before its operands is called prefix notation. Racket needs no precedence rules, because the nesting of the parentheses says which operation comes first: `(* (+ 2 3) 4)` adds first, and `(+ 2 (* 3 4))` multiplies first.

> **NOTE:**
>
> *Remark 2* (How Racket evaluates an application). To **evaluate** an application `(f e1 ... en)` ([Definition 3](#def-racket-expression)), Racket evaluates each operand `e1`, …, `en` to a value, then applies `f` to those values. In part 1 of [Exercise 1](#exr-evaluate-nested):
>
> ``` text
> (* (+ 1 2) (- 10 4))
> = (* 3 (- 10 4))
> = (* 3 6)
> = 18
> ```
>
> Each `=` replaces one application by its value, and the evaluation ends with a value, which cannot be simplified further.

# 2 Functions

> **NOTE:**
>
> **Exercise 2 (Reading a definition)** This Racket code defines a function named `h`:
>
> ``` racket
> (define (h x)
>   (- (* x x) (* 2 x)))
> ```
>
> 1.  Write \\h(x)\\ as a formula in ordinary mathematical notation.
> 2.  What does `(h 5)` return?
> 3.  What does `(h (h 3))` return?

> **NOTE:**
>
> *Solution 2*.
>
> 1.  \\h(x) = x^2 - 2x\\, since `(* x x)` is \\x^2\\ and `(* 2 x)` is \\2x\\.
> 2.  \\h(5) = 25 - 10 = 15\\, so `(h 5)` returns 15.
> 3.  Racket first evaluates the argument `(h 3)`, which is \\9 - 6 = 3\\, and then applies `h` to it, so `(h (h 3))` is `(h 3)` again and returns 3.

> **NOTE:**
>
> **Definition 4 (Argument (input))** An **argument** (or **input**) of a [function](#def-function) \\f : A \to B\\ is an element \\a \in A\\ that \\f\\ is applied to.

> **NOTE:**
>
> **Definition 5 (Value (output))** The **value** (or **output**) of a [function](#def-function) \\f : A \to B\\ at an [argument](#def-argument) \\a \in A\\ is the element \\f(a) \in B\\ that \\f\\ assigns to \\a\\.

> **NOTE:**
>
> **Definition 6 (Defining a function in Racket)** The Racket definition
>
> ``` racket
> (define (f x1 ... xn)
>   body)
> ```
>
> defines a function named `f` with **parameters** `x1`, …, `xn`: names that stand for its arguments ([Definition 4](#def-argument)). To evaluate an application `(f a1 ... an)`, Racket evaluates the arguments `a1`, …, `an`, replaces each parameter in `body` by the value of its argument, and evaluates the result. The value of the application is the value ([Definition 5](#def-value)) of `f` at those arguments.

> **NOTE:**
>
> **Example 1 (Replacing a parameter by its argument)** With `h` from [Exercise 2](#exr-formula-from-code), [Definition 6](#def-racket-define) evaluates `(h 5)` in four steps:
>
> ``` text
> (h 5)
> = (- (* 5 5) (* 2 5))
> = (- 25 (* 2 5))
> = (- 25 10)
> = 15
> ```
>
> The first step replaces `x` by 5 in the body of `h`, just as computing \\h(5)\\ replaces \\x\\ by 5 in \\x^2 - 2x\\. Each later step replaces one application by its value ([Remark 2](#rem-evaluation)).

# 3 Cases

> **NOTE:**
>
> **Exercise 3 (Choosing a case)** A museum sets its ticket price, in dollars, by age:
>
> ``` racket
> (define (ticket-price age)
>   (cond [(< age 5) 0]
>         [(< age 18) 8]
>         [else 12]))
> ```
>
> Each line in square brackets pairs a test with a value.
>
> 1.  Guess what `(ticket-price 4)`, `(ticket-price 5)`, `(ticket-price 17)` and `(ticket-price 70)` return.
> 2.  Write the function as a formula with cases, for a whole number of years \\a \ge 0\\.

> **NOTE:**
>
> *Solution 3*.
>
> 1.  Racket tries the tests in order and returns the value beside the first true one:
>
>     - `(ticket-price 4)` returns 0, since \\4 \< 5\\.
>     - `(ticket-price 5)` returns 8, since \\5 \< 5\\ is false but \\5 \< 18\\ is true.
>     - `(ticket-price 17)` returns 8, since \\17 \< 18\\.
>     - `(ticket-price 70)` returns 12, since neither test is true, so the `else` line applies.
>
> 2.  The second case holds only when the first test is false, so its condition is \\5 \le a \< 18\\, not just \\a \< 18\\:
>
>     \\ p(a) = \begin{cases} 0 & \text{if } a \< 5, \\ 8 & \text{if } 5 \le a \< 18, \\ 12 & \text{if } a \ge 18. \end{cases} \\

> **NOTE:**
>
> **Definition 7 (True and false in Racket)** Racket writes the two truth values as `#t` (true) and `#f` (false). A comparison such as `(< 4 5)` or `(= 3 7)` returns one of them, and `and`, `or` and `not` combine them: `(and (< 1 2) (< 3 2))` returns `#f`.

> **NOTE:**
>
> **Definition 8 (`if` and `cond`)** The expression `(if test a b)` evaluates `test`, and returns the value of `a` if `test` is true and the value of `b` if it is false.
>
> The expression
>
> ``` racket
> (cond [test1 a1]
>       [test2 a2]
>       ...
>       [else an])
> ```
>
> evaluates the tests in order and returns the value of the expression beside the first true one, or the value of `an` if none is true. Like a function defined by cases in mathematics, each case of a `cond` applies only when every case before it fails.
>
> `if` and `cond` look like applications ([Definition 3](#def-racket-expression)), but they are not: an application evaluates all of its operands ([Remark 2](#rem-evaluation)), while `if` and `cond` evaluate only the tests they need and the one branch they return. `and`, `or` and `define` are not applications either.

> **NOTE:**
>
> **Example 2 (Absolute value with `if`)** The absolute value \\ \mathopen{}\left\|x\right\|\mathclose{} = \begin{cases} -x & \text{if } x \< 0, \\ x & \text{otherwise} \end{cases} \\ has two cases, so one `if` ([Definition 8](#def-if-cond)) is enough:
>
> ``` racket
> (define (absolute x)
>   (if (< x 0)
>       (- x)
>       x))
> ```
>
> `(absolute -7)` returns 7, and `(absolute 2)` returns 2. Racket already has this function, under the name `abs`.

# 4 Pure functions

> **NOTE:**
>
> **Exercise 4 (Same call, different answer)** This Python code hands out ID numbers:
>
> ``` python
> count = 0
>
> def next_id():
>     global count
>     count = count + 1
>     return count
> ```
>
> 1.  The program calls `next_id()` twice in a row. What does each call return?
> 2.  Is there a mathematical function \\f\\ ([Definition 1](#def-function)) with no arguments whose value is what `next_id()` returns every time it is called?

> **NOTE:**
>
> *Solution 4*.
>
> 1.  The first call changes `count` from 0 to 1 and returns 1. The second call changes `count` from 1 to 2 and returns 2.
> 2.  No. A function with no arguments has exactly one value, but `next_id()` returned 1 and then 2. What it returns depends on the variable `count`, which is not an argument and which each call changes.

> **NOTE:**
>
> **Definition 9 (Side effect)** A **side effect** of a piece of code is any change it makes besides returning a value, such as changing a variable, printing, or writing a file. `next_id` in [Exercise 4](#exr-next-id) has a side effect: it changes `count`.

> **NOTE:**
>
> **Definition 10 (Pure function)** A function in a program is **pure** ([Wikipedia contributors 2026e](#ref-wikipedia_pure_function)) if
>
> - it returns the same value whenever it is called with the same arguments, and
> - it has no side effects ([Definition 9](#def-side-effect)).
>
> A pure function computes a mathematical function ([Definition 1](#def-function)) of its arguments.

> **NOTE:**
>
> **Definition 11 (Functional programming)** **Functional programming** ([Wikipedia contributors 2026c](#ref-wikipedia_functional_programming)) is a style of programming in which a program is built by defining and applying pure functions ([Definition 10](#def-pure-function)), rather than by running statements that change variables.

> **NOTE:**
>
> *Remark 3* (Why this course uses functional programming). In a program built from pure functions ([Definition 10](#def-pure-function)), an expression can be replaced by its value anywhere it appears without changing what the program does. That is what makes evaluation by substitution ([Example 1](#exm-substitution)) work, and it is also how algebra works: \\h(5)\\ can be replaced by 15 in any formula. So a pure function can be checked with the same reasoning as a formula, and this course proves facts about programs that way.
>
> `next_id` in [Exercise 4](#exr-next-id) is not pure, so `next_id() + next_id()` cannot be simplified to `2 * next_id()`. On a fresh start, `next_id() + next_id()` returns 3, from \\1 + 2\\, but `2 * next_id()` returns 2. Racket can change variables too, with `set!`, but this course does not use it.

# 5 Functions as values

> **NOTE:**
>
> **Exercise 5 (A function as an argument)** The function `twice` takes a function `f` and a value `x`:
>
> ``` racket
> (define (twice f x)
>   (f (f x)))
>
> (define (add-three x)
>   (+ x 3))
> ```
>
> Guess what each expression returns:
>
> 1.  `(twice add-three 10)`
> 2.  `(twice h 4)`, with `h` from [Exercise 2](#exr-formula-from-code)
> 3.  `(twice add-three (twice add-three 0))`

> **NOTE:**
>
> *Solution 5*. Replace `f` and `x` in the body `(f (f x))` ([Definition 6](#def-racket-define)):
>
> 1.  `(twice add-three 10)` is `(add-three (add-three 10))`, which is `(add-three 13)`, which returns 16.
> 2.  `(twice h 4)` is `(h (h 4))`. Since \\h(4) = 16 - 8 = 8\\ and \\h(8) = 64 - 16 = 48\\, it returns 48.
> 3.  The argument `(twice add-three 0)` returns 6, so the whole expression is `(twice add-three 6)`, which returns 12.

> **NOTE:**
>
> **Definition 12 (Higher-order function)** A **higher-order function** ([Wikipedia contributors 2026d](#ref-wikipedia_higher_order_function)) is a function that takes a function as an argument, or returns a function as its value. `twice` in [Exercise 5](#exr-twice) is a higher-order function.

> **NOTE:**
>
> **Example 3 (`map` and `filter`)** Racket’s `(list 5 7 9)` makes the list of 5, 7 and 9, which Racket prints as `'(5 7 9)`. Two built-in higher-order functions ([Definition 12](#def-higher-order)) work on lists:
>
> - `(map f L)` applies `f` to each element of the list `L`, and returns the list of results. With `add-three` from [Exercise 5](#exr-twice), `(map add-three (list 5 7 9))` returns `'(8 10 12)`.
> - `(filter p L)` returns the list of the elements `x` of `L` for which `(p x)` is true. `(filter even? (list 5 6 7 8))` returns `'(6 8)`.
>
> Neither one changes `L`; each returns a new list.

# References

Wikipedia contributors. 2026a. *Expression (Mathematics) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Expression_(mathematics)>.

Wikipedia contributors. 2026b. *Function (Mathematics) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Function_(mathematics)>.

Wikipedia contributors. 2026c. *Functional Programming — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Functional_programming>.

Wikipedia contributors. 2026d. *Higher-Order Function — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Higher-order_function>.

Wikipedia contributors. 2026e. *Pure Function — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Pure_function>.

Back to top
