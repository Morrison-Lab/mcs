# Propositional Logic

Code

Propositions, connectives, and conditionals

Published

Last modified: 2026-10-24 10:48:15 (PDT)

> **NOTE:**
>
> Adapted from Kameron Decker Harris’s Fall 2026 lecture notes “Logic 1” and “Logic 2”, which are typed transcriptions of Scott Wehrwein’s Spring 2025 handwritten lecture notes. The examples of propositions, the truth tables to decode, the list of English phrasings of a conditional, and the “only if” example come from those notes; the other exercises are new.
>
> The definitions are included from the [mathematics prerequisites](https://morrison-lab.github.io/mds/proof-writing.html#sec-proof-definitions) notes, so they read the same in both places.

# 1 Propositions

> **NOTE:**
>
> **Exercise 1 (True, false, or neither?)** Which of these sentences and expressions are definitely true or definitely false?
>
> - Add 5 to both sides.
> - \\42\\
> - \\42\\ is an integer.
> - Adding 5 to both sides of \\x - 5 = 37\\ gives \\x = 42\\.
> - What is the solution of \\2x = 84\\?
> - The solution of \\2x = 84\\ is \\41\\.
> - \\42\\ is not a number.
> - \\x\\ is a multiple of \\8\\.

> **NOTE:**
>
> *Solution 1*.
>
> - “Add 5 to both sides” is an instruction, so it is neither true nor false.
> - “\\42\\” is a number, not a sentence, so it is neither true nor false.
> - “\\42\\ is an integer” is true.
> - “Adding 5 to both sides of \\x - 5 = 37\\ gives \\x = 42\\” is true.
> - “What is the solution of \\2x = 84\\?” is a question, so it is neither true nor false.
> - “The solution of \\2x = 84\\ is \\41\\” is false, since the solution is \\42\\. A false sentence still has a definite truth value.
> - “\\42\\ is not a number” is false.
> - “\\x\\ is a multiple of \\8\\” is neither until we know \\x\\: it is true when \\x = 16\\ and false when \\x = 3\\.
>
> The four sentences with a definite truth value are propositions. The last sentence, whose truth value depends on \\x\\, is a predicate.

> **NOTE:**
>
> **Definition 1 (Proposition (statement))** A **proposition** ([Wikipedia contributors 2026j](#ref-wikipedia_proposition)), or **statement**, is a declarative sentence that is either true or false.

> **NOTE:**
>
> **Definition 2 (Predicate)** A **predicate** ([Wikipedia contributors 2026i](#ref-wikipedia_predicate_mathematical_logic)) \\P(x)\\ is a declarative sentence about a variable \\x\\ that becomes a proposition ([Definition 1](#def-proposition)) whenever a value is substituted for \\x\\.

> **NOTE:**
>
> *Remark 1* (Other names). Many textbooks call a proposition a *statement*, and call a predicate an *open sentence* or a *propositional function*. These notes say proposition and predicate.

> **NOTE:**
>
> **Example 1 (A proposition whose truth value nobody knows)** Start with a positive integer \\n\\. If \\n\\ is even, replace it with \\n / 2\\; if \\n\\ is odd, replace it with \\3n + 1\\. Repeat. Starting from \\n = 6\\ gives \\6, 3, 10, 5, 16, 8, 4, 2, 1\\.
>
> The *Collatz conjecture* ([Wikipedia contributors 2026a](#ref-wikipedia_collatz_conjecture)) is the sentence “starting from any positive integer, the process reaches 1 after finitely many steps”. It is a proposition, because it is either true or false, but nobody has yet proved which. A proposition needs a definite truth value, not a known one.

# 2 Logical connectives

> **NOTE:**
>
> **Exercise 2 (What do these symbols mean?)** Each table lists every combination of truth values of propositions \\P\\ and \\Q\\ (T for true, F for false), and the truth value of a new proposition built from them. Describe in words when each new proposition is true.
>
> | \\P\\ | \\Q\\ | \\P \land Q\\ |
> |:-----:|:-----:|:-------------:|
> |   T   |   T   |       T       |
> |   T   |   F   |       F       |
> |   F   |   T   |       F       |
> |   F   |   F   |       F       |
>
> | \\P\\ | \\Q\\ | \\P \lor Q\\ |
> |:-----:|:-----:|:------------:|
> |   T   |   T   |      T       |
> |   T   |   F   |      T       |
> |   F   |   T   |      T       |
> |   F   |   F   |      F       |
>
> | \\P\\ | \\\neg P\\ |
> |:-----:|:----------:|
> |   T   |     F      |
> |   F   |     T      |

> **NOTE:**
>
> *Solution 2*.
>
> - \\P \land Q\\ is true only in the first row, where \\P\\ and \\Q\\ are both true. It reads “\\P\\ and \\Q\\”.
> - \\P \lor Q\\ is false only in the last row, where \\P\\ and \\Q\\ are both false, so it is true when at least one of them is true. It reads “\\P\\ or \\Q\\”. It is true in the first row too, where both are true.
> - \\\neg P\\ has the opposite truth value to \\P\\. It reads “not \\P\\”.

> **NOTE:**
>
> **Definition 3 (Logical connective)** A **logical connective** ([Wikipedia contributors 2026e](#ref-wikipedia_logical_connective)) builds a new proposition ([Definition 1](#def-proposition)) from one or two propositions \\P\\ and \\Q\\, with a truth value that depends only on the truth values of \\P\\ and \\Q\\. These notes use five, each defined next: not, and, or, implies, and if and only if.

> **NOTE:**
>
> **Definition 4 (Not)** The logical connective ([Definition 3](#def-logical-connective)) **not** ([Wikipedia contributors 2026h](#ref-wikipedia_negation)) is written \\\neg P\\ (“not \\P\\”); it is true when \\P\\ is false, and false when \\P\\ is true.

> **NOTE:**
>
> **Definition 5 (And)** The logical connective ([Definition 3](#def-logical-connective)) **and** is written ([Wikipedia contributors 2026d](#ref-wikipedia_logical_conjunction)) \\P \land Q\\ (“\\P\\ and \\Q\\”); it is true when \\P\\ and \\Q\\ are both true, and false otherwise.

> **NOTE:**
>
> **Definition 6 (Or)** The logical connective ([Definition 3](#def-logical-connective)) **or** is written ([Wikipedia contributors 2026f](#ref-wikipedia_logical_disjunction)) \\P \lor Q\\ (“\\P\\ or \\Q\\”); it is true when at least one of \\P\\ and \\Q\\ is true, and false when both are false.

> **NOTE:**
>
> *Remark 2* (Notation, and the inclusive “or”). Some textbooks write \\\sim P\\ for \\\neg P\\. Programming languages spell the same three connectives as words or symbols: Racket writes `(not p)`, `(and p q)` and `(or p q)`, and Java and C write `!p`, `p && q` and `p || q`.
>
> In everyday English, “soup or salad” often means one but not both. The logical “or” always allows both, as the first row of the table for \\P \lor Q\\ in [Exercise 2](#exr-decode-connectives) shows.

## 2.1 Evaluating compound propositions

> **NOTE:**
>
> **Exercise 3 (Evaluate a compound proposition)** Suppose \\P\\ is true, \\Q\\ is false, and \\R\\ is false. Is \\(\neg P \lor Q) \land \neg R\\ true or false?

> **NOTE:**
>
> *Solution 3*. Substitute the truth values, then evaluate from the innermost parentheses outward:
>
> \\ \begin{aligned} (\neg P \lor Q) \land \neg R &= (\neg \mathrm{T} \lor \mathrm{F}) \land \neg \mathrm{F} \\ &= (\mathrm{F} \lor \mathrm{F}) \land \mathrm{T} \\ &= \mathrm{F} \land \mathrm{T} \\ &= \mathrm{F} \end{aligned} \\
>
> The proposition is false.

> **NOTE:**
>
> **Exercise 4 (Evaluate another compound proposition)** With the same truth values as [Exercise 3](#exr-evaluate-or-and) (\\P\\ true, \\Q\\ false, \\R\\ false), is \\\neg (P \land Q) \lor R\\ true or false?

> **NOTE:**
>
> *Solution 4*. \\ \begin{aligned} \neg (P \land Q) \lor R &= \neg (\mathrm{T} \land \mathrm{F}) \lor \mathrm{F} \\ &= \neg \mathrm{F} \lor \mathrm{F} \\ &= \mathrm{T} \lor \mathrm{F} \\ &= \mathrm{T} \end{aligned} \\
>
> The proposition is true.

## 2.2 Truth tables

> **NOTE:**
>
> **Exercise 5 (How many cases?)** [Exercise 4](#exr-evaluate-not-and) found the truth value of \\\neg (P \land Q) \lor R\\ for one choice of truth values of \\P\\, \\Q\\ and \\R\\. How many different choices are there?

> **NOTE:**
>
> *Solution 5*. Each of \\P\\, \\Q\\ and \\R\\ is either true or false, independently of the other two, so there are \\2 \times 2 \times 2 = 2^3 = 8\\ choices. With \\n\\ propositions there are \\2^n\\.

> **NOTE:**
>
> **Definition 7 (Truth table)** A **truth table** for a proposition built from \\P_1, \ldots, P_n\\ with logical connectives ([Definition 3](#def-logical-connective)) has one row for each of the \\2^n\\ combinations of truth values of \\P_1, \ldots, P_n\\, and gives the truth value of the proposition in each row.

> **NOTE:**
>
> **Exercise 6 (A truth table with three propositions)** Make a truth table ([Definition 7](#def-truth-table)) for \\\neg (P \land Q) \lor R\\.
>
> > **TIP:**
> >
> > Add columns for the pieces, \\P \land Q\\ and \\\neg (P \land Q)\\, before the last column.

> **NOTE:**
>
> *Solution 6*.
>
> | \\P\\ | \\Q\\ | \\R\\ | \\P \land Q\\ | \\\neg (P \land Q)\\ | \\\neg (P \land Q) \lor R\\ |
> |:--:|:--:|:--:|:--:|:--:|:--:|
> | T | T | T | T | F | T |
> | T | T | F | T | F | F |
> | T | F | T | F | T | T |
> | T | F | F | F | T | T |
> | F | T | T | F | T | T |
> | F | T | F | F | T | T |
> | F | F | T | F | T | T |
> | F | F | F | F | T | T |
>
> The proposition is false in only one row: \\P\\ and \\Q\\ true, and \\R\\ false. The fourth row is the case in [Exercise 4](#exr-evaluate-not-and).

# 3 Conditionals

> **NOTE:**
>
> **Exercise 7 (When is a promise broken?)** A parent tells a child, “If you clean your room, then you get dessert.” In which of these four situations did the parent break the promise?
>
> | Room cleaned? | Dessert? |
> |:-------------:|:--------:|
> |      yes      |   yes    |
> |      yes      |    no    |
> |      no       |   yes    |
> |      no       |    no    |

> **NOTE:**
>
> *Solution 7*. Only in the second row: the child cleaned the room and got no dessert.
>
> When the room was not cleaned, the promise says nothing about dessert, so the parent kept it whether or not dessert came.
>
> Writing \\P\\ for “you clean your room” and \\Q\\ for “you get dessert”, the promise “if \\P\\, then \\Q\\” is false only when \\P\\ is true and \\Q\\ is false.

> **NOTE:**
>
> **Definition 8 (Implies)** The logical connective ([Definition 3](#def-logical-connective)) **implies** is written ([Wikipedia contributors 2026g](#ref-wikipedia_material_conditional)) \\P \Rightarrow Q\\ (“if \\P\\, then \\Q\\”, or “\\P\\ implies \\Q\\”); it is false when \\P\\ is true and \\Q\\ is false, and true otherwise.

> **NOTE:**
>
> *Remark 3* (Names for the parts, and other notation). In \\P \Rightarrow Q\\, \\P\\ is the *premise* (also called the *hypothesis* or *antecedent*) and \\Q\\ is the *conclusion* (also called the *consequent*). A proposition of this form is also called a *conditional* or an *implication*.
>
> Many textbooks write \\P \rightarrow Q\\ for \\P \Rightarrow Q\\.

> **NOTE:**
>
> **Example 2 (Implications with a true and a false premise)** Take \\x = 3\\.
>
> - \\x \> 2 \Rightarrow x \> 1\\ is true: the premise \\3 \> 2\\ is true and the conclusion \\3 \> 1\\ is true.
> - \\x \> 2 \Rightarrow x \> 4\\ is false: the premise \\3 \> 2\\ is true, but the conclusion \\3 \> 4\\ is false.
> - \\x \> 5 \Rightarrow x \> 4\\ is true: the premise \\3 \> 5\\ is false, so the implication is true whatever the conclusion.

> **NOTE:**
>
> **Exercise 8 (A false premise)** Is each of these propositions true or false?
>
> 1.  If \\7\\ is even, then \\7\\ is divisible by \\4\\.
> 2.  If \\7\\ is even, then \\7\\ is odd.

> **NOTE:**
>
> *Solution 8*. Both are true. The premise “\\7\\ is even” is false, so each implication ([Definition 8](#def-implies)) is true whatever its conclusion says. The conclusion of the first is false and the conclusion of the second is true, and neither matters.

> **NOTE:**
>
> *Remark 4* (Reading an implication). An implication with a false premise, as in [Exercise 8](#exr-false-premise), is sometimes called *vacuously true*. Three habits help with implications that sound strange:
>
> - Apply the definition ([Definition 8](#def-implies)) rather than intuition about the sentence.
> - Read \\P \Rightarrow Q\\ as a promise, as in [Exercise 7](#exr-broken-promise).
> - Look at the cases where \\P\\ is true; they are the only cases where \\P \Rightarrow Q\\ can be false.

## 3.1 The converse

> **NOTE:**
>
> **Exercise 9 (Reverse an implication)** For all real numbers \\x\\ and \\y\\, “if \\x = y\\, then \\x^2 = y^2\\” is true. Is “if \\x^2 = y^2\\, then \\x = y\\” also true for all real numbers \\x\\ and \\y\\?

> **NOTE:**
>
> *Solution 9*. No. Take \\x = 1\\ and \\y = -1\\. Then \\x^2 = 1 = y^2\\, so the premise is true, but \\x \ne y\\, so the conclusion is false.
>
> Swapping the premise and the conclusion of a true implication can give a false one.

> **NOTE:**
>
> **Definition 9 (Converse)** The **converse** ([Wikipedia contributors 2026b](#ref-wikipedia_converse_logic)) of the proposition “if \\P\\, then \\Q\\” is the proposition “if \\Q\\, then \\P\\”.

## 3.2 Conditionals in English

> **NOTE:**
>
> **Exercise 10 (“Only if”)** Rewrite “I go to class only if I am healthy” in the form “if \\P\\, then \\Q\\”.

> **NOTE:**
>
> *Solution 10*. “If I go to class, then I am healthy.”
>
> The sentence says that going to class requires being healthy, so whenever I go to class, I am healthy. It does not say “if I am healthy, then I go to class”; that is its converse ([Definition 9](#def-converse)), and a healthy person may still skip class.
>
> In general, “\\P\\ only if \\Q\\” means \\P \Rightarrow Q\\.

> **NOTE:**
>
> *Remark 5* (English phrasings of \\P \Rightarrow Q\\). Each of these sentences means \\P \Rightarrow Q\\:
>
> - If \\P\\, then \\Q\\.
> - \\Q\\ if \\P\\.
> - \\Q\\ whenever \\P\\.
> - \\Q\\, provided that \\P\\.
> - Whenever \\P\\, then also \\Q\\.
> - \\P\\ is a sufficient condition for \\Q\\.
> - For \\Q\\, it is sufficient that \\P\\.
> - \\Q\\ is a necessary condition for \\P\\.
> - For \\P\\, it is necessary that \\Q\\.
> - \\P\\ only if \\Q\\.

# 4 Biconditionals

> **NOTE:**
>
> **Exercise 11 (Split “if and only if”)** “\\P\\ if and only if \\Q\\” combines “\\P\\ if \\Q\\” and “\\P\\ only if \\Q\\”. Write each of the two halves as an implication.

> **NOTE:**
>
> *Solution 11*.
>
> - “\\P\\ if \\Q\\” is \\Q \Rightarrow P\\ ([Remark 5](#rem-conditional-phrasings)).
> - “\\P\\ only if \\Q\\” is \\P \Rightarrow Q\\ ([Solution 10](#sol-only-if)).
>
> So “\\P\\ if and only if \\Q\\” says that \\P \Rightarrow Q\\ and \\Q \Rightarrow P\\ are both true.

> **NOTE:**
>
> **Definition 10 (If and only if)** The logical connective ([Definition 3](#def-logical-connective)) **if and only if** is written ([Wikipedia contributors 2026c](#ref-wikipedia_logical_biconditional)) \\P \Leftrightarrow Q\\ (“\\P\\ if and only if \\Q\\”); it is true when \\P\\ and \\Q\\ have the same truth value, and false otherwise.

> **NOTE:**
>
> *Remark 6* (Other names and notation). “If and only if” is often shortened to “iff”. A proposition of the form \\P \Leftrightarrow Q\\ is also called a *biconditional*, and many textbooks write \\P \leftrightarrow Q\\.

> **NOTE:**
>
> **Exercise 12 (Check a biconditional)** Is “\\n\\ is even if and only if \\n\\ is divisible by \\3\\” true or false when \\n = 6\\? When \\n = 4\\? When \\n = 5\\?

> **NOTE:**
>
> *Solution 12*.
>
> | \\n\\ | \\n\\ is even | \\n\\ is divisible by \\3\\ | biconditional |
> |:-----:|:-------------:|:---------------------------:|:-------------:|
> | \\6\\ |       T       |              T              |       T       |
> | \\4\\ |       T       |              F              |       F       |
> | \\5\\ |       F       |              F              |       T       |
>
> By [Definition 10](#def-iff), the biconditional is true exactly when its two sides have the same truth value. When \\n = 5\\, both sides are false, so the biconditional is true.

# References

Wikipedia contributors. 2026a. *Collatz Conjecture — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Collatz_conjecture>.

Wikipedia contributors. 2026b. *Converse (Logic) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Converse_(logic)>.

Wikipedia contributors. 2026c. *Logical Biconditional — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Logical_biconditional>.

Wikipedia contributors. 2026d. *Logical Conjunction — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Logical_conjunction>.

Wikipedia contributors. 2026e. *Logical Connective — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Logical_connective>.

Wikipedia contributors. 2026f. *Logical Disjunction — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Logical_disjunction>.

Wikipedia contributors. 2026g. *Material Conditional — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Material_conditional>.

Wikipedia contributors. 2026h. *Negation — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Negation>.

Wikipedia contributors. 2026i. *Predicate (Mathematical Logic) — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Predicate_(mathematical_logic)>.

Wikipedia contributors. 2026j. *Proposition — Wikipedia, the Free Encyclopedia*. <https://en.wikipedia.org/wiki/Proposition>.

Back to top
