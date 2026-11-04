# WWU CSCI 201 Syllabus

Code

Winter 2027

Published

Last modified: 2026-11-03 16:52:17 (PST)

> **NOTE:**
>
> This is the Winter 2027 syllabus. Items marked **TBD** (to be determined) have not been set yet. The syllabus is subject to change; I will announce in class any change made after the first day of class.

## Course Information

Number  
[CSCI 201](https://catalog.wwu.edu/search_advanced.php?cur_cat_oid=23&search_database=Search&search_db=Search&cpage=1&ecpage=1&ppage=1&spage=1&tpage=1&location=3&filter%5Bkeyword%5D=CSCI%20201)

Name  
Discrete Math and Functional Programming for Computer Scientists

Website  
[*Math for Computer Science* (mcs)](https://morrison-lab.github.io/mcs/)

Term  
Winter 2027 (January 5 to March 19, 2027)

Credits  
4 (three hours of lecture and two hours of lab each week)

Lecture  
Monday, Wednesday, and Friday, in one of two meeting times (see [Sections](#sections))

Lab  
One two-hour lab each week, on Thursday or Friday (see [Sections](#sections))

Office hours  
**TBD**, in my office (Communication Facility 463) unless otherwise noted

Prerequisites  
CSCI 145, and one of MATH 124, 125, 134, 135, or 138 (or a score of 3 or higher on the AP Calculus AB or BC exam), each with a grade of C- or better.

### Sections

Each section pairs a lecture time with a lab time. Attend the lecture and the lab of the section you registered for.

| CRN | Lecture (Monday, Wednesday, Friday) | Lab |
|:---|:---|:---|
| 13745 | 11:00–11:50am, Environmental Studies Center 313 | Friday 8:00–9:50am, Communication Facility 164 |
| 13746 | 11:00–11:50am, Environmental Studies Center 313 | Friday 12:00–1:50pm, Communication Facility 164 |
| 13747 | 9:00–9:50am, Communication Facility 023 | Thursday 2:00–3:50pm, Communication Facility 164 |
| 13748 | 9:00–9:50am, Communication Facility 023 | Thursday 12:00–1:50pm, Communication Facility 026 |

The times and rooms are from [WWU’s class schedule for CSCI 201 in Winter 2027](https://web4u.banner.wwu.edu/pls/wwis/bwckctlg.p_disp_listcrse?term_in=202710&subj_in=CSCI&crse_in=201&schd_in=C), read on 2026-10-23; check there for any change. The lab teaching assistants (TAs) and their office hours are **TBD**.

## Contact Information

Name  
Ezra Morrison

Office  
Communication Facility 463

Email  
<ezra.morrison@wwu.edu>, for matters unrelated to the course only (Teams chat is better for those)

All course-related correspondence goes through Canvas, including confidential matters; see [Communication](#communication).

## Course Description

This course is a rigorous introduction to the mathematical structures and reasoning techniques underlying computer science. Topics include sets, functions, relations, graphs, trees, and finite automata, with an emphasis on formal definitions and logical precision. You will learn to write mathematical proofs using direct proof, contrapositive, contradiction, and induction. Functional programming is introduced as a way to express computation and recursion within a mathematically grounded framework.

## Course Outcomes

Homework, labs, and exams test and measure the outcomes below. On completion of CSCI 201, students will demonstrate:

- A thorough understanding of the mathematical definitions of concepts important to computer science, including sets, tuples, functions, and relations.
- A basic understanding of graphs, trees, and their traversals.
- A basic understanding of the mathematical definition of finite automata.
- A basic understanding of asymptotic notation.
- A basic understanding of recurrence relations and loop invariants.
- The ability to prove basic theorems involving these concepts using direct proof, contradiction, contrapositive, and mathematical induction.
- The ability to use functional style effectively in a functional programming language.

## Textbooks and Readings

The course notes are this site, [*Math for Computer Science* (mcs)](https://morrison-lab.github.io/mcs/). Its definitions come from the lab’s [*Math for Data Science* (mds)](https://morrison-lab.github.io/mds/) notes, which also cover background mathematics this course builds on.

The readings in the [schedule](#schedule) are sections of:

- *Discrete Mathematics with Applications* (5th ed.), by Susanna Epp.

Other useful references:

- *Discrete Mathematics and Its Applications*, by Kenneth Rosen; any recent edition.
- *Building Blocks for Theoretical Computer Science*, by Margaret Fleck, which can be read at no cost on [the author’s webpage](https://mfleck.cs.illinois.edu/building-blocks/index-sp2020.html).

## Similar Courses

Other universities teach courses much like this one, and many post their materials at no cost. They are a good place to see a topic explained a second way.

Discrete mathematics and proofs:

- MIT’s [6.042J *Mathematics for Computer Science*](https://ocw.mit.edu/courses/6-042j-mathematics-for-computer-science-spring-2015/) (Spring 2015, on MIT OpenCourseWare), with recorded lectures, readings and problem sets.
- Stanford’s [CS 103 *Mathematical Foundations of Computing*](https://web.stanford.edu/class/cs103/), with lecture slides and problem sets.
- The University of Washington’s [CSE 311 *Foundations of Computing I*](https://courses.cs.washington.edu/courses/cse311/), with lecture slides and homework from past quarters.

Functional programming:

- Stanford’s [CS 107 *Programming Paradigms*](https://see.stanford.edu/Course/CS107) (Spring 2008, on Stanford Engineering Everywhere), whose recorded lectures 19 to 23 and handouts introduce Scheme, Racket’s parent language.
- Stanford’s [CS 242 *Programming Languages*](https://stanford-cs242.github.io/f19/) (Fall 2019), with lecture notes on the lambda calculus and functional programming.
- Stanford’s [CS 99 *Functional Programming and Theorem Proving in Lean 4*](https://web.stanford.edu/class/cs99/), which carries functional programming over to writing proofs.

## Materials

I will distribute worksheets, homework, and lab materials on Canvas. The lecture notes are on this site, listed in the menu bar. Each chapter is also available as slides and as a PDF handout, linked under **Other Formats** on the chapter’s page.

## Schedule

The topics and dates of future lectures may change. The [course calendar](../chapters/calendar.llms.md) gives the day-by-day agenda, including every deadline; the table below gives the topics and readings week by week. Readings are sections of Epp’s *Discrete Mathematics with Applications* (5th ed.). Classes begin on Tuesday, January 5, so the first lecture is on Wednesday, January 6. Monday, January 18 (Martin Luther King Jr. Day) and Monday, February 15 (Presidents’ Day) are university holidays, with no class.

| Week | Dates | Topics | Assigned work | Reading |
|:---|:---|:---|:---|:---|
| 1 | Jan 5–8 | Introduction to [functional programming](../chapters/functional-programming.llms.md); [propositional logic](../chapters/propositional-logic.llms.md), [predicates and quantifiers](../chapters/predicates-quantifiers.llms.md), [logical equivalence and negation](../chapters/equivalence-negation.llms.md) | Quiz 0; Lab 1 | 1.1, 2.1–2.3, 3.1 |
| 2 | Jan 11–15 | Proofs: [inference and direct proof](../chapters/direct-proof.llms.md), [contrapositive, and contradiction](../chapters/contrapositive-contradiction.llms.md) | Lab 2; Homework 1 | 4.1–4.2, 4.4 |
| 3 | Jan 18–22 | Proofs, continued; sets and functions | Lab 3; Homework 2 | 1.2–1.3, 4.7–4.8 |
| 4 | Jan 25–29 | Mathematical induction; loop invariants | **Midterm 1**, Wednesday, Jan 27 | 5.1–5.2 |
| 5 | Feb 1–5 | Induction, continued; recurrence relations | Lab 4; Homework 3 | 5.4–5.6 |
| 6 | Feb 8–12 | Growth rates of functions (big-O and asymptotic notation) | Lab 5; Homework 4 | 11.2–11.3 |
| 7 | Feb 15–19 | Relations; graphs: paths, cycles, and connectivity | **Midterm 2**, Wednesday, Feb 17 | 1.4, 8.1–8.3, 10.1 |
| 8 | Feb 22–26 | Graphs: breadth-first and depth-first traversal | Lab 6; Homework 5 | 10.1, 10.3, class notes |
| 9 | Mar 1–5 | State machines and finite automata | Lab 7; Homework 6 | 12.2 |
| 10 | Mar 8–12 | Trees and their traversal | Lab 8 | 10.4–10.6 |
| Finals | Mar 15–19 |  | **Final exam**: Tuesday, Mar 16 (CRNs 13745, 13746) or Thursday, Mar 18 (CRNs 13747, 13748), 10:30am–12:30pm |  |

The midterm dates are tentative. If a midterm’s date changes, I will announce the change at least two weeks before that exam is given.

## Communication

**Outbound.** I will send official class announcements through Canvas Announcements. Please set Canvas to notify you of them right away, so you do not miss important information: in the course’s Canvas notification settings, set the **Announcement** row’s **Email** column to **Notify immediately**.

**Inbound.** All course-related correspondence goes through Canvas. Post nearly all questions and comments for me or the TAs on the class discussion forum, Canvas Discussions (link **TBD**). Anything that should not be posted there, such as a grading question or objection, goes in a Canvas message to me.

Confidential matters, such as information about your health, also go in a Canvas message to me, not to my email.

## Questions and Corrections

If something in the course materials seems wrong, ask. The course materials include the notes, worksheets, assignments, and anything I say or show in class, including my slides. I will make mistakes, and so will the other authors of the materials.

Do not assume that you are the confused one when the material might be wrong. Ask your question first, in class or outside it, and we can talk through your reasoning together. If you are right, we all learn something and I fix the material. If you are not, we can jointly find out where the confusion started.

## Health Precautions

If you are sick with something that could be communicable, let me know ahead of time and I will try to arrange a way for you to keep up, so you can stay home and not expose others needlessly. Please contact me if you have questions, concerns, or suggestions.

## Software

The labs and the programming parts of homework use [Racket](https://racket-lang.org/), a functional programming language. Racket is free, and it comes with the DrRacket editor. For any software that comes pre-installed in the department labs, please use the default installed version.

## Active Learning

Class time is for working on problems, not only for listening. You will be asked to think about questions on your own, write down answers, discuss them in small groups, and share your answers with the class. Sometimes you may be asked to write on the board. I will give you time to think things through before you are put on the spot. Please give me feedback about the structure of the class, the activities, or group dynamics.

### ABCD Cards

On the first day of class, I will give each student an ABCD card, which you will use to vote on answers to questions in class. They work like electronic clickers, but they are free and need no batteries. They let both you and me quickly see how well you understand the material, so that I can adjust what I emphasize in class and you can adjust what you study outside it. Please bring this card to class each day. If you lose your card, print a new, landscape-mode color copy of the [ABCD card](../images/abcd-card.pdf).

### Worksheets

Most classes include a worksheet: guided practice that reinforces the day’s concepts and prepares you for the exams. Please keep your worksheets organized and bring them to later classes. You are encouraged to work on worksheet problems with classmates, but each student submits their own work and should be able to explain it. I will post selected worksheet solutions after the submission deadline, and review common mistakes at the start of the next class. Most midterm and final exam questions will be adapted from worksheet problems.

## Grading

Course grades are letter grades, based on:

| Category         | Weight |
|:-----------------|:-------|
| Homework         | 10%    |
| Programming labs | 30%    |
| Worksheets       | 15%    |
| Midterm 1        | 10%    |
| Midterm 2        | 10%    |
| Final exam       | 25%    |

I will assign final letter grades based on the weighted average of the categories above, by the standard scale:

| Cumulative score      | Letter grade |
|:----------------------|:-------------|
| 90% or higher         | A range      |
| 80% to just under 90% | B range      |
| 70% to just under 80% | C range      |
| 60% to just under 70% | D range      |
| under 60%             | F            |

Thresholds for plus and minus grades are at my discretion. The overall grade Canvas displays may be inaccurate; the weights above are the ones that count.

### Homework and Worksheets

Homework assignments combine written work and programming. Homework and worksheets are graded on completion, meaning whether you made a solid effort to solve each problem:

- Complete: 100%
- Substantial effort: 80%
- Minimal effort: 40%
- Missing: 0%

The lowest worksheet score is dropped.

**Quiz 0** is a short quiz in the first week that checks the CSCI 145 and precalculus material this course assumes. It is graded on completion and counts as one worksheet, and its main purpose is to show you (and me) what to review.

When writing up your work:

- Type all written work. You do not need to use LaTeX, but I recommend it.
- Hand-drawn diagrams are welcome when they help illustrate a concept, as long as they are legible.
- Format code and pseudocode in a fixed-width font. Do not submit screenshots of your editor or terminal.
- Show your work. An answer alone will not get full credit, on homework or on exams.

### Labs

Weekly labs give hands-on programming practice, with a TA available to answer questions during the lab period. To get full credit, **you must both attend lab and submit the deliverable by its deadline**, which will typically be 10pm on the Monday after the lab (or the next class day, when that Monday is a holiday).

- If you do not attend lab but submit the deliverable on time, your score is multiplied by 0.5. This penalty is waived automatically for one lab; if you have a legitimate reason to miss more, contact me and the TA ahead of time.
- Attending a lab section other than your own requires permission from both me and the TA(s).
- Late lab submissions are not accepted.

### Exams

The course has two in-class midterm exams, tentatively on Wednesday, January 27 (week 4) and Wednesday, February 17 (week 7), and a cumulative final exam during finals week, in our classroom at the time WWU’s [finals schedule](https://registrar.wwu.edu/calendars/finals) assigns, which is set by the lecture time: Tuesday, March 16 for the 11:00 sections (CRNs 13745 and 13746) and Thursday, March 18 for the 9:00 sections (CRNs 13747 and 13748), both 10:30am–12:30pm.

- Each midterm lasts 50 minutes, and you may bring one page of notes (front and back).
- The final exam lasts 120 minutes, and you may bring two pages of notes (front and back).

If you know in advance that you will be unable to take an exam at the scheduled time, let me know at least one week before the exam, and we may be able to reschedule it.

### Grading Questions

If you have a question about a grade, send it to me in writing, as a Canvas message (see [Communication](#communication)), within 48 hours of the graded work being returned. You will never lose points for asking.

## Deadlines and Late Work

Canvas lists every due date.

- Homework is due Friday at 10pm, with no-penalty extensions until Sunday at 10pm. I will not be available for help on weekends.
- The last homework, Homework 6, is due before finals week and has no extension.
- Lab deliverables are due as described under [Labs](#labs).

Please talk to me *in advance* if you need an accommodation or an extension; the day an assignment is due is too late. If you miss a deadline or an exam because of a medical emergency, contact me as soon as possible to discuss arrangements.

## Collaboration and AI Tools

**Collaboration.** You may work together on homework and worksheets unless an assignment or problem says it is individual. A group of about three works best, since it is hard for everyone to contribute in a large group. You may discuss the steps of an algorithm or proof on a whiteboard, but write your own math and code, and submit your own answers. Do not copy from classmates, the internet, a chatbot, or a forum.

**AI tools.** AI tools such as large language model chatbots are **allowed on homework and worksheets only**. Use them like a collaborator, not as a source of answers: you must still write your answer in your own words, and you are responsible for understanding it. **Say whether you used an AI tool, and name it,** on each assignment. Students who rely heavily on AI tools often struggle on exams, where the tools are not available. AI tools are not allowed on lab work, including lab work you finish after the lab period.

**Exams** are solo: work alone, without help from anyone else and without AI tools; the only aid allowed is your page(s) of notes, as described under [Exams](#exams).

## Academic Honesty

As a future professional, your integrity is crucial. It is your responsibility to read and be familiar with the university’s academic honesty policy, found in [Appendix D](https://catalog.wwu.edu/content.php?catoid=19&navoid=5073) of the Western Washington University Course Catalog; [Academic Honesty Resources for Students](https://academichonesty.wwu.edu/) explains the procedures and the appeal process. Cheating on an exam will result in failing the course (grade of F), and I will file documentation of the incident with the university. All cases of academic dishonesty will be reported. When in doubt, ask me.

## Computer Labs

Each section’s weekly lab meets in a department computer lab (see [Sections](#sections)). Outside your lab time, you should be able to use any of the department’s open labs, most of which run the Linux operating system. Racket is free, so you can also install it on your own computer (see [Software](#software)).

## Writing to Think

When you are stuck in this course, try putting your question into words in writing. Write it in full sentences, with the definitions, proof steps or code you used and what you have already tried.

The habit pays off in two ways. A written question can be posted on Canvas Discussions (see [Communication](#communication)) so I and others can help. Writing your thoughts down also helps clarify your question, and that sometimes answers it. In an interview on the *5 Minute Mentor* podcast, [Leslie Lamport](https://en.wikipedia.org/wiki/Leslie_Lamport) says:

> As someone said, “Writing is nature’s way of showing you how fuzzy your thinking is.” If you think you understand something, and don’t write down your ideas, you only think you’re thinking.
>
> — Leslie Lamport ([Lamport 2019](#ref-lamport2019think))

The same holds for proofs, which are the writing this course asks of you most.

## Library Writing Resources

The Hacherl Research & Writing Studio supports almost anything that involves words: group projects, essays, posters, podcasts, lab reports, applications, grad theses and more. You can work with them just like an open art studio or lab space, where you get work done with feedback along the way. Drop into the Studio on the second level of Haggard Hall or use their online chat to:

- stay focused and get things done;
- discuss ideas with someone;
- share something you’re making;
- ask for tips any time you have difficulty.

See <https://library.wwu.edu/rws> for details.

## Student Conduct

I am committed to maintaining an inclusive, supportive, and professional environment in all academic settings, including lectures, labs, and course-related online spaces. I expect students to live up to the [Association for Computing Machinery (ACM) Code of Ethics and Professional Conduct](https://www.acm.org/code-of-ethics), the ethical code adopted by nearly every software professional. A pattern of failing to follow the ACM Code of Ethics and Professional Conduct can negatively affect course grades, up to and including a failing grade for the course. Conduct is also considered when determining admission to the major.

## Course Materials

Do not sell or distribute questions or answers to any assignment, quiz, or exam, or other course materials given out on Canvas. The lecture notes on this site are open, under the license on the [home page](../index.llms.md).

## Disabilities

Reasonable accommodation for persons with documented disabilities should be established within the first two weeks of class and arranged through the Disability Access Center: telephone 360-650-3083; email <drsfrontdesk@wwu.edu>; and on the web at [Disability Access Center](https://disability.wwu.edu/).

## Student Services

Western encourages students to seek assistance and support at the onset of an illness, difficulty, or crisis.

- In the case of a medical concern or question, please contact the Health Center: 360-650-3400, or visit [Student Health](https://studenthealth.wwu.edu/).
- In the case of an emotional or psychological concern or question, please contact the Counseling and Wellness Center: 360-650-3164, or visit [Counseling and Wellness Center](https://cwc.wwu.edu/).
- In the case of a health and safety concern, please contact the University Police: 360-650-3555, or visit [University Police](https://police.wwu.edu/).
- In the case of a family or personal crisis or emergency, please contact the [Dean of Students](https://www.wwu.edu/dean-students).
- To seek confidential support related to sexual violence, please contact CASAS (360-650-3700), the Student Health Center, and/or the Counseling and Wellness Center. To report sexual violence, please contact University Police, Bellingham Police, and/or the Title IX Coordinator in Western’s [Civil Rights and Title IX Compliance](https://crtc.wwu.edu/) office (360-650-3307). Faculty are responsible employees who are required to report sex discrimination, including sexual violence that they learn about, to the Title IX Coordinator.

## Career Advising

I am glad to meet with you to discuss your short-, medium-, and long-term career goals. [Academic Advising & Career Readiness](https://aacr.wwu.edu/) is also available for help with academic planning or your career, such as finding jobs and internships or getting feedback on your resume.

## Other Policies

Please read [Syllabi@WWU](https://syllabi.wwu.edu/) for additional, important policies, including accommodations, equal opportunity, the medical excuse policy, ethical use of WWU computing resources, and the student conduct code.

## Start-of-Quarter Survey

Please fill out the anonymous [start-of-quarter survey](https://docs.google.com/forms/d/e/1FAIpQLSeR4g368PE_HCeyF2IVcyVmSFBxhTfrTP69BX8ZCSfB6_R80A/viewform) before class on Friday, January 8. Every question is optional. A few more optional questions need your name, so they are not on the form; answer them in a Canvas message to me instead.

## Anonymous Feedback

Unlike the start-of-quarter survey, the [anonymous feedback form](https://docs.google.com/forms/d/e/1FAIpQLSdGo-31iMGMyFMAMxgwGkPVa2mK4vK8lGEBN6fxCGwuZcfV-w/viewform) stays open all quarter, so you can use it at any time. Tell me what is working, what is not, and how I could improve the course. I read every response.

Back to top

## References

Lamport, Leslie. 2019. *Think and Write, with Leslie Lamport*. Interview by Edaena Salinas, 5 Minute Mentor podcast (Mentors.fm). <https://mentors.fm/2019/08/13/think-and-write-with-leslie-lamport/>.
