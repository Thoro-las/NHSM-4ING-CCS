#import "@THR/Base:1.0.0": *
#import "../resources/commands.typ": *

#chapter[Turing Machines & Universality Of Computation][
  Since the beginning of history, computations were an important part of the human daily life. From the simple finance calculations for price predictions in the old times, to the huge large language models we have now. Throughout history, multiple models, and ways to describe computation machines came. But the one that is most used is the Turing machine.
]

= The Birth Of Turing Machines
In the $20^"th"$ century, mathematics went through trouble of setting foundations, after some unintuitive results like the existence of multiple infinities by Cantor, and contradictory sets by Russel. By then, multiple mathematicians, mainly Hilbert, set out proposed to formalize all mathematics in a complete, decidable and consistent axiomatic system. The questions more specifically were:

+ Completeness: can every true statement be proven.
+ Consistency: are all statements free of contradiction.
+ Decidable: is there a procedure to determine truth.

Turing set out to find an answer for the decidability problem, and thus had to find a formal definition to what a "procedure" is, so he imagined an idealized "computer" that follows fixed rules, and reduced the computation to the following components: a tape, a pointer that reads and writes on the tape, and a finite set of instructions. Turing was able to prove that no axiomatic system would be decidable algorithmically. And it opened a gate to the study of computations also complexity after.


= Turing Machines
Beginning by talking about an intuitive way to create a machine that does exactly what a human does when stating or proving theorems, same as the situation Turing thought of in the create of those machines. To think of a machine that can do this, it needs 3 components:
+ An ability to read the inputs.
+ An ability to write the outputs.
+ An ability to process the data.

#grid(
  columns: (1fr, 2fr),
  rows: (3.5cm,) * 4,
  align: (center + horizon, left + horizon),
  row-gutter: 3mm,

  image("../resources/visuals1.png"),
  [
    Consider an idealized human, or the parts that we need for describing a process. It needs a paper to be able to write, read and register the intermediate steps, as well as an eye and pen to be able to do these operations, and also a brain that does the processing.
  ],

  image("../resources/visuals2.png"),
  [
    Texts, books or any paper come in multiple different shapes, sizes, but the idea is the same, thus we abstract it into a tape, which may have any length possible and describes the data in symbols on the cells of the tape.
  ],

  image("../resources/visuals3.png"),
  [
    We can abstract the ability to read and write to a pointer at a position on the tape, which does actually act exactly like a hand and eye would do. And makes it less cumbersome to have just a single position to do the work at.
  ],

  image("../resources/visuals4.png"),
  [
    The human mind while in a process passes through multiple steps, each can be represented by a state-machine, that given inputs and intermediate steps in the process, may change to other states to continue the process.
  ],
)

#def(name: "Turing Machine", count: false)[
  A Turing machine $M$ is a tuple $(Q, Sigma, Gamma, delta, q_0, q_a, q_r)$ where:
  - $Q$: finite set of states.
  - $Sigma$: finite alphabet for transitions.
  - $Gamma$: finite alphabets for tape with $sp in Gamma\\Sigma$.
  - $q_0, q_a, q_r in Q$: the start, accept, and reject states.
  - $delta: Q times Gamma -> Q times Gamma times {L, R}$: a transition function which does the "processing".
]

Turing machines may be defined in many other ways, many books or lectures take the freedom of chosing the one that works most for them, for example here are some other different definitions:
- $M$ has multiple tapes for input, for work, for output.
- $delta: Q times Gamma -> Q times Gamma times {L, S, R}$, where $S$ is a state jump without the head of the pointer moving.
- $Sigma = {0, 1}$ thus representing all the states we want using some binary encoding.
#v(-2mm)
After working with some Turing machines, the reader can easily prove that those are equivalent definitions. Now that we defined Turing machines, we will define what a computation is in said machine.

+ Start with the tape having $w_1, dots, w_n, sp, sp, dots -> infinity$ and with the state machine being at $q_0$.
  #align(center)[ #tm($0$, 0, ($w_1$, $w_2$, $dots.c$, $w_n$, $sp$, $dots.c$)) ]
+ At each step, we are at a state $q_i$, and the pointer is on the $p_i^"th"$ position, we evaluate the transition function to get the following $ delta(q_i, c) = (q_j, c', N) $ with $q_i, q_j in Q, c, c' in Gamma, N in {L, R}$ the instruction here is "if you are at state $q_i$ and the pointer points at the symbol $c$, then change the state to $q_j$, change the symbol at the current position in the tape to $c'$ and then move the pointer $N$ (either right for $R$ or left for $L$)".


  #align(center)[
    #tm($i$, 2, ($dots.c$, $w_(k-1)$, $w_(k)$, $w_(k+1)$, $w_(k+2)$, $dots.c$))
    $arrow.b$\
    $delta(q_i, w_k) = (q_(j), "a", R)$ \
    $arrow.b$
    #tm($j$, 3, ($dots.c$, $w_(k-1)$, "a", $w_(k+1)$, $w_(k+2)$, $dots.c$))
    #v(2mm)
  ]
+ If at any step, $q_i = q_a$ or $q_i = q_r$, the computation is finished, the result will be on the tape and the result is accepted if $q_i = q_a$ and rejected if $q_i = q_r$.

Notice that nothing in this process forces the computation to terminate, and thus, there may exists infinite loops that never reject nor accept, we will talk about this more in the section of undecidability.

We define the language of a Turing machine $M$ the set $cal(L)(M) = {w in Sigma^* | M "accepts" w}$. We start by creating some Turing machines for some known algorithms to see in practice how they work. Below are some useful notations that we may need later in the proofs.

#ntt(count: false)[
  - $Sigma^*$ is the set of all possible words written with $Sigma$.
  -
    - A word $w$ is any element of $Sigma^*$.
    - $w=w_1 dots w_n$ represents $w=(w_1, dots, w_n)$.
    - $w=(w_i), v=(v_i) => w v = w_1 dots w_n v_1 dots v_m$.
  -
    - A language $cal(L)$ is any subset of $Sigma^*$.
    - $cal(L)_1, cal(L)_2 subset Sigma^*, cal(L)_1 cal(L)_2 = { v w | v in cal(L)_1, w in cal(L)_2 }$.
  -
    - $chevron.l x chevron.r$ is a canonical representation of the mathematical object $x$ in the language.
    - $chevron.l (x_1, dots, x_n) chevron.r = chevron.l x_1, dots, x_n chevron.r$.
    - $|x|$ represents the length of the representation of the mathematical object $x$ in the language.
]



== Two's Complement Inverter
Let $K=k_n dots k_0$ be the two's complement representation of a number $x$, to get the representation of $-x$, we have an easy algorithm:
+ Start from right to left.
+ Move until first $1$, denote it $k_i$.
+ Flip all bits after $k_i$.
To create the Turing machine, we specify all the parts given in the definition.
- $Q = {q_"w", q_"s", q_"f", q_"d", q_"r"}$.
- $Sigma = {0, 1, end}$.
- $Gamma = {0, 1, end, sp}$.
- $(q_0, q_a, q_r) = (q_"w", q_"d", q_"r")$.
- $delta$ is defined in the table below
#align(center)[
  #table(
    columns: 3,
    column-gutter: (0pt, 3pt, 0pt),
    $q in Q$, $c in Gamma$, $delta(q, c) in Q times Gamma times {L, R}$,
    $q_"w"$, $0, 1, end$, $(q_"w", c, R)$,
    $q_"w"$, $sp$, $(q_"s", sp, L)$,
    $q_"s"$, $0$, $(q_"s", 0, L)$,
    $q_"s"$, $1$, $(q_"f", 1, L)$,
    $q_"s"$, $end$, $(q_"d", end, L)$,
    $q_"s"$, $sp$, $(q_"r", sp, L)$,
    $q_"f"$, $0$, $(q_"f", 1, L)$,
    $q_"f"$, $1$, $(q_"f", 0, L)$,
    $q_"f"$, $end$, $(q_"d", end, L)$,
    $q_"f"$, $sp$, $(q_"r", sp, L)$,
  )
]
Here we just take the first element of the tape is $end$ to specify that end of the binary representation string. We simulate it now, we start by preparing the tape and the pointer. Take the number $K = 101100$ which represents $-20$. Here is how the tape would be shown
#align(center, tmtape((end, 1, 0, 1, 1, 0, 0, sp, $dots.c$)))
We start with the pointer at position $0$, moves until it arrives to the space character, and then it starts "processing" the input on the tape.
#align(center)[
  #tm("w", 0, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("w", 1, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("w", 2, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("w", 3, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("w", 4, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("w", 5, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("w", 6, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("w", 7, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("s", 6, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("s", 5, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("f", 4, (end, 1, 0, 1, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("f", 3, (end, 1, 0, 0, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("f", 2, (end, 1, 1, 0, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("f", 1, (end, 0, 1, 0, 1, 0, 0, sp, $dots.c$), start-color: 3)
  #v(-2mm) #tm("d", 0, (end, 0, 1, 0, 1, 0, 0, sp, $dots.c$), start-color: 3)
]
Reading from the tape we get that the representation of the inverse if $010100$ which is $18$. It is easy to notice that the language of this machine is $cal(L)(M) = end {0, 1}^* sp^NN$, we usually ignore the infinite blanks after the significant part of the text, thus $cal(L)(M) = end {0, 1}^*$.

== Different Definitions Of Turing Machines
Multiple definitions exist for Turing machines, we will prove the equivalence of the definitions.

+ $Gamma = {0, 1, sp, st}$: consider a machine $M$ with alphabet $Gamma'$, we take the tape of the machine $M$, for each cell, we create $ceil(log_2 (|Gamma'|))$ cells, we can create special states for each of the symbols of $Gamma'$ to recognize it after a sequence of the new symbols.
+ Multiple tape turing machine: consider a machine $M$ with $k$-tapes, we can make a new machine that uses just one tape, and that is by using the following mapping $                    (ZZ^k)^NN & -> ZZ^NN \
  ((a_i^n)_(i=1)^k )_(n in NN) & |-> (a_(n mod k)^(floor(n \/ k)))_(n in NN) $
+ "Stay" movement: the machine that has a Stay movement would work as follows, consider $delta(q_i, c) = (q_j, c', S)$, we can set it as two steps $delta(q_i, c) = (q^*, c', R)$ then $delta(q^*, c) = (q_j, c, L)$.

= Undecidability
We talked earlier in the birth of Turing machines section about the reason for the existence of Turing machines, and that is, to find a solution for the decidability problem that states that is there a procedure to determine the truth of a statement. Now that we have the formal tool to define procedure, we can answer our question. We introduce the concept of decidability.

#def(count: false, name: "Decidable Languages/Decider")[\
  Let $cal(L) subset Sigma^*$ be a language, we say that $cal(L)$ is decidable if there exists a Turing machine $M$ such that $     x in L & <=> M "accepts" x \
  x in.not L & <=> M "rejects" x $
  We call $M$ the decider of the language $cal(L)$.
]

Here in the definition, we notice that $M$ necessarily should halt for any input, since if it loops then $M$ neither accepts nor rejects, so $not(x in L or x in.not L)$ which contradictory by the law of excluded middle. We prove that there exists an undecidable language.

#lem(count: false, name: "Typewriter Principle")[
  Let $S$ be a set such that every element of $S$ can be determined uniquely by a string in $Sigma^*$, then $S$ is countable.
]

#prf[
  $Sigma^* = union.big_(k >= 0) Sigma^k$ which is a countable union of countable sets thus it is countable, $S$ can be determined uniquely by a string in $Sigma^*$ implies that there exists an injective map $phi: S -> Sigma^*$, and since $Sigma^*$ is countable, then so is $S$.
]

#thm(count: false)[
  There exists an undecidable language.
]

#prf[
  Let $D$ be the set of deciders and $cal(L)_D ("TM")$ be the set of languages decidable by a Turing machine. Notice that every Turing machine in $D$ has a unique element in $cal(L)_D ("TM")$ which is its language, and thus $card cal(L)_D ("TM") <= card D$, we can describe a Turing machine in a finite string given that it has finite states, symbols, and transitions in a unique way, thus by the Typewriter principle, $D$ is countable, and so is $cal(L)_D ("TM")$. We have that $Sigma^*$ is countable, by Cantor's theorem, $cal(P)(Sigma^*)$ would be uncountable. Any map $phi: cal(L)_D ("TM") -> cal(P)(Sigma^*)$ would never be surjective since $card cal(L)_D ("TM") < cal(P)(Sigma^*)$, thus we conclude that there exists undecidable languages.
]

Now we look for one of the most significant undecidable problems, the HALT language which is defined as follows $ "HALT" = { chevron.l M, x chevron.r | M "halts on" x}. $ $"HALT"$ being undecidable means that it is impossible to have a machine that predicts in prior for any Turing machine if it would halt on some given input.

#thm(count: false)[
  The language $"HALT"$ is undecidable.
]

#prf[
  Suppose on the contrary that $"HALT"$ is decidable. Then there exists a Turing machine $H$ such that for any machine $M$ and input $x$, $H$ accepts when $M$ halts on $x$ and rejects when $M$ does not halt on $x$. Now we build another machine $D$ which uses $H$ as a subprogram. $D$ would be defined as follows
  #align(center, ```lua
  D(M):
  | if (H(M, M) halts)
  |   then loop
  |   else halt
  ```)
  Now we do $D(chevron.l D chevron.r)$, if it halts, then $H(M, M)$ did not halt, then $D(chevron.l D chevron.r)$ would not halt, else if it does not halt, then $H(M, M)$ halts, then $D(chevron.l D chevron.r)$ would halt. Contradiction, thus $H$ cannot exist.
]

A consequence of such a theorem is the following. Consider the set $cal(T)$ of all representations of Turing machines $cal(T) = {chevron.l M chevron.r | M "a Turing machine"} subset Sigma^*$.

#thm(count: false, name: "Rice")[
  Let $P subset cal(T)$ such that:
  - $P != cal(T)$ and $P != emptyset$.
  - $P$ is closed under the relation $forall chevron.l M_1 chevron.r, chevron.l M_2 chevron.r in T$, #v(-2mm) $ chevron.l M_1 chevron.r tilde chevron.l M_2 chevron.r => cal(L)(M_1) = cal(L)(M_2). $ #v(-2mm)
  Then the language $P$ is undecidable, that is, there is no TM that can decide for any $M$, $cal(L)(M) in P$.
]

Rice theorem states in essence that it is impossible to have a machine tells exactly that any machine would have a semantic property, that is, it is impossible to decide in prior if a property would be satisfied or not. The proof is somewhat really technical, so we give just the idea of the proof by reduction to the halting problem.

Suppose that we take some non-trivial property, like P: "The machine prints 'Hello, World!'". Suppose that there is a machine $M_P$ such that it decides if a Turing machine satisfies $P$. We create a new machine $D$ that runs
#align(center, ```lua
D(M):
| if (M halts)
|   then print 'Hello, World!'
|   else loop
```)
thus using the decider $M_P$, one can deduce if the machine $M$ halts, thus $D$ is a machine that can decide if any machine halts or not, which is contradictory, given that the HALT language is undecidable. We can use this argument for any property. The proof uses a similar idea but in a more formal environment.

Even though the Turing machines seem limited by the existence of undecidable statements, but that is in nature what a procedure satisfies. We now express one of the most important statements about computation theory.

= Uncomputable Functions
#def(name: "Computable Function", count: false)[
  A function $f: NN^k -> NN, (n_1, dots, n_k) |-> f(n_1, dots, n_k)$, $f$ is said to be computable if there exists a Turing machine $M$ such that given $chevron.l n_1, dots, n_k chevron.r$, it computes the output $chevron.l f(n_1, dots, n_k) chevron.r$ and halts.
]

Even though it seems like all functions are computable, it is indeed not the case. A known uncomputable function is the Busy Beaver function.

#def(name: "Busy Beaver", count: false)[
  The Busy Beaver function $B B (n)$ is defined as the maximum numbers of $1$'s a halting $n$-state Turing machine can write before halting, starting from a tape with all $0$s.
]

This function is well defined since the number of machines is finite and thus the ones that halt at some point. We prove the following proposition.

#pro(count: false)[
  The function $B B (n)$ is uncomputable.
]

#prf[
  Assume that $B B (n)$ is computable, take $m in NN$ and define the following property $P_m = {chevron.l M chevron.r | M "halts on exactly" B B (m) "ones"}$, $P_m$ satisfies the Rice theorem, thus $P_m$ is undecidable, but if $B B (n)$ is computable, then $P_m$ is decidable, contradiction. Thus, $B B (n)$ is uncomputable.
]

= Church-Turing Thesis
One of the most important statements in the theory of computation is the Church-Turing Thesis, which states in principle the following:
#align(center, box(width: 90%, align(left)[
  #set text(style: "italic")
  + Any formalization of a computation machine is equivalent or less strong than a Turing machine.
  + The human mind is a Turing machine.
]))
This statement is really strong, yet not provable, given its nature being mostly philosophical more than mathematical. This thesis is mostly accepted as true given that whenever we take any model for computation like $lambda$-calculus, tag-systems and other computation machines, we can simulate them by a Turing machine, and we can simulate a Turing machine with them thus they are equivalent in power. Due to its meta-physical statement, it can give really weird statements such as the following

#align(center, box(width: 80%, text(style: "italic", [
  "It is impossible to verify algorithmically that an AGI (Artificial General Intelligence) either understands language, is conscious, or any other property on it, except for specific cases."
])))

This applies given that AGIs try to imitate the human mind which is by the Church-Turing thesis, a Turing machine equivalent in power.

= Universal Turing Machines
== Modern Programming Languages
For the proof of the existence of universal Turing machines, we would like an easier way to "program" Turing machines, so we start by giving a proof that if something can be written in a programming language, then it is equivalent to some Turing machine.

#lem(count: false)[
  Any Turing machine is equivalent to a code written in the following language

  Consider the simple programming language, with the symbols ${0, 1, sp, st}$ it has an infinite array $T[i]$, $i$ being a pointer at a location and it has the format:
  #align(center, ``` label: if (T[i] = c) then { cmds... }```)
  and we consider the following commands with it
  #align(center)[
    #table(
      columns: (27%, auto),
      align: left,
      table.header([Command], [Description]),
      [`set c`], [sets the symbol at $T[i]$ to $c$.],
      [`inc / dec`], [increment/decrement the pointer $i$.],
      [`goto l`], [jumps to label $l$.],
      [`hlt b`], [halt the machine, accepting if $b = 1$.],
    )
  ]
]

#prf[
  We will now prove that we can create a machine for any code of this form. We make a naming convention, we take the labels to be $l_k$ which is the $k^"th"$ label and their subcommands to be $c_k^j$ which is the $j^"th"$ command in the $k^"th"$ instruction. The set of states would be of the form $Q = {q_(k, j)}_(k in NN, j in NN) union (q_a, q_r)$, now we define how for each command how the transition function behaves. For simplification, we consider $q_"next_ins"$ to be $q_(l_(k+1))$, $q_"next"$ to be either $q_(c_(k)^(j+1))$ if it is available, or $q_"next_ins"$ else. We define the transition function as follows
  #align(center)[
    #table(
      columns: (auto, auto),
      align: left + horizon,
      inset: 3mm,
      table.header([Command], [Transitions]),
      `if (T[i] = c)`,
      [$
        delta(q_l, x) =
        cases(
          (q_"next_ins", x, S) & "if" x != c,
          (q_(c_l^1), x, S) & "if" x = c
        )
      $],

      `set c`,
      [$
        delta(q_(c_l^k), x) = (q_"next", c, S)
      $],

      `inc`,
      [$
        delta(q_(c_l^k), x) = (q_"next", x, R)
      $],

      `dec`,
      [$
        delta(q_(c_l^k), x) = (q_"next", x, L)
      $],

      `goto l`,
      [$
        delta(q_(c_l^k), x) = (q_l, x, S)
      $],

      `hlt b`,
      [$
        delta(q_(c_l^k), x) = cases(
          (q_a, x, S) & "if" b = 1,
          (q_r, x, S) & "if" b = 0
        )
      $],
    )
  ]

  We proved that given a code, we can make a machine that simulates a code written in this simple language. Now we prove the converse, that given any machine, we can represent it by this language. Let $M$ with states ${q_0, dots, q_n, q_r, q_a}$, and suppose $delta(q_i, c) = (q_j, c', N)$, we can translate this to a code as follows:
  #align(center, ```
  state_qi: if (T[i] = c) {
    set c'
    <if N = R> inc
    <if N = L> dec
    goto state_qj
  }
  ```)
  and we add the two following instructions
  #align(center, ```
  state_qr: hlt 0
  state_qa: hlt 1
  ```)
  We finished proving the equivalence of this simple language and the Turing machine.
]

Now we use this lemma and the Church-Turing thesis to deduce the following theorem

#thm(count: false)[
  Any modern programming language that can simulate the simple code we have written, is equivalent to a Turing machine.
]

#prf[
  Suppose that a language has the ability to define labels, have arrays, do conditions, read and write on the array, then it can write the simple language we defined in the previous lemma. So any Turing machine can be written inside the modern programming language, since the programming language is a computation formalism, then by the Church-Turing thesis, it will not be stronger than a Turing machine, so it is exactly as powerful as a Turing machine can be since it can simulate it.
]

== Turing Completness
A small discussion on the Turing completness may be brought up from the previous theorem, that some languages have the ability to simulate Turing machines and thus by the Church-Turing thesis they are Turing machines. This property of being able to simulate a Turing machine is called the Turing Completness.

#def(name: "Turing Complete", count: false)[
  A system $S$ is Turing complete if for any given Turing machine $M$, there exists a program $P$ (given as input), such that for every $x$, executing $P$ on $x$ yields the same result as running $M$ on $x$.
]

Most modern languages are Turing complete, which allows the expressiveness of the model but also the halting problem. We show the existence of one of such Turing complete machines.

== Universal Machines & Their Existence
#def(count: false, name: "Universal Turing Machine")[
  A universal Turing machine $U$ is a machine that takes as input a description of a Turing machine $M$, $x$ as input of $M$ and simulates $M$ on $x$, that is:
  #align(center)[
    $U$ loops on $chevron.l M, x chevron.r$ $<=>$ $M$ loops on $x$\
    $U$ accepts $chevron.l M, x chevron.r$ $<=>$ $M$ accepts $x$\
    $U$ rejects $chevron.l M, x chevron.r$ $<=>$ $M$ rejects $x$\
  ]
]

We can think of such a universal machine as a typical computer, and the description of a Turing machine $M$ as a program that runs on the computer, and $x$ are the inputs that go into the program. In such a way, the computer simulates a smaller machine that just runs the program. To prove such a statement, we need some theorems prior to simplify the writing of the code that encodes the universal Turing machine. To prove it, we will use what we proved in the previous section, that we can find a Turing machine for any program in a Turing complete language, and we just write a python code to create the universal Turing machine.

```python
def tm_sim(desc, inp):
  Q = desc['states']
  T = desc['tape']
  d = desc['trans']

  st = desc['q0']
  acc = desc['qa']
  rej = desc['qe']
  tape = list(inp)

  s = st
  pos = 0
  step = 0

  while s not in (acc, rej):
    step += 1
    sym = tape[pos]
    key = (s, sym)

    if key not in tr:
      s = rej
      break

    ns, ws, mv = tr[key]
    tape[pos] = ws
    if mv == 'L':
      pos = pos - 1
      if pos < 0:
        tape.insert(0, '_')
        pos = 0

    elif mv == 'R':
      pos = pos + 1
      if pos >= len(tape):
        tape.append('_')

    s = ns

  return s == acc, tape
```

Which is indeed a simulator of a universal Turing machine, thus finishes our proof of its existence.


= Decidability & Computability
In the majority of this document, we give statements on languages but not on algorithms or problems. That is intentional, here we will discuss and justify why it is equivalent to talk about decision as languages, or computation done with a typical input/output.

Consider $I$ be the set of all possible inputs of some problem and $O$ be the set of outputs possible from the problem.

#def(count: false, name: "Computational Problem")[
  A computation problem is a relation $Pi subset I times O$, such that for each $x in I$, zero or more $y in O$ satisfy $(x, y) in Pi$. $Pi$ is said to be computable if there exists a machine such that starting with the tape having $chevron.l x chevron.r$, the computation stops at some point and writes $chevron.l y chevron.r$ on the tape.
]

#def(count: false, name: "Decision Problem")[
  A decision problem is $D subset I$, where for $x in I$, checks for $x in D$. $D$ is said to be decidable, if there exists a machine such that given $x$, it accepts if $x in D$ and rejects if $x in.not D$.
]

#thm(count: false)[
  Let $Pi subset I times O$ be a computational problem, and define its decision version $ D_Pi = {chevron.l x, y chevron.r | (x, y) in Pi}. $ then we have the following equivalence
  #align(center)[
    $Pi$ is computable $<=>$ $D_Pi$ is decidable.
  ]
]

We will do an informal proof-sketch for this theorem, given that it needs lots of construction that are technical.

#prf[
  - $=>$ Suppose that $Pi$ is computable, consider $M_Pi$ be the machine that computes $Pi$, now we create a machine $M_D$ such that for any input $chevron.l x, y chevron.r$, $M_D$ runs $M_Pi$ as a subprogram and returns $y'$, then $M_D$ checks if $y = y'$, thus $M_D$ decides $D_Pi$ so $D_Pi$ is decidable.
  - $arrow.l.double$ Suppose that $D_Pi$ is decidable, consider $M_D$ be the machine that decides $D_Pi$, create a new machine $M_Pi$ that takes some input $chevron.l x chevron.r$ and enumerate all $y$, and runs $M_D$ on $chevron.l x, y chevron.r$, return on first $y$ that satisfies the decider $M_D$, thus $M_Pi$ computes $Pi$.
]

Notice that it is significantly easier to turn a computation problem into a decision problem, while the inverse requires a lot more steps. This is insignificant in the study of computation, since we assume in theory however much time it needs as long as it is finite, and just about the possibility of computation, not its time.

To give an example of such a situation, consider the following problem, let $a, b, c$ three variables, and we define the computational problem $Pi$ such that $ (P) quad cases(
  a x^2 + b x + c = 0,
  x >= 0
)\ $
We can directly reduce $Pi$ into a decision problem by considering the decision problem of the defined language ${chevron.l a, b, c, x chevron.r | x "satisfies" (P) "with parameters" a, b, c}$. Thus, anything proved on languages and deciders, works also on computations.

= Types Of Turing Machines
The Turing machine was initially created to discuss and prove the undecidability of some statements in mathematics. Yet it branched off to one of the most used tools to describe and model modern machines in computation power and it expanded to having multiple types. The one we described was the deterministic Turing machine.

== Deterministic Turing Machine
This is the usual model that we use even in computers. The "determinism" comes from the fact that the transition function having only one next state to go to.

== Non-Deterministic Turing Machine
This is a different type of Turing machines, which can accept to move to multiple states at once, that can be described with the transition function being defined as $ delta: Q times Gamma -> cal(P)(Q times Gamma times {L, R}) $ We start by giving an example and then explaining how these types of machines can be interpreted, we consider the machine that given a word on the tape, it checks if it is in the language $cal(L) = { w w | w in Sigma^* }$. Here is the NDTM
- The alphabet $Gamma = {0, 1, X_0, X_1, "[", "]", sp}$.
- The states $Q$:
  - $q_(w)$: walking state for start-points.
  - $q_(r 0 0), q_(r 0 1), q_(r 1 0), q_(r 1 1)$: remember one or zero state.
  - $q_(m r 0), q_(m r 1)$: mark remembered state.
  - $q_(n c 0), q_(n c 1)$: next character states.
  - $q_(v s), q_(v n)$: verification states.
  - $q_v, q_a, q_r$: accept and reject states.
- The transition function $delta$:
#align(center)[
  #table(
    inset: 3mm,
    columns: (1fr, 1fr, 2fr),
    column-gutter: (auto, 1mm),
    align: (center + horizon, center + horizon, left + horizon),
    $q in Q$, $c in Gamma$, $cal(P)(Q times Gamma times {L, R})$,

    table.cell($q_w$, rowspan: 3),
    $"["$, [- $(q_w, "[", R)$],
    $"]"$, [- $(q_r, "]", L)$],
    $0, 1$,
    table.cell([
      - $(q_w, c, R)$
        #v(1.5mm)
      - $cases(
          (q_(r 1 0), X_1, L) "if" c = 1,
          (q_(r 0 0), X_0, L) "if" c = 0
        )$
      #v(1mm)
    ]),

    table.cell($q_(r i 0)$, rowspan: 2),
    $X_1, X_0$, [- $(q_(r i 0), c, L)$],
    $1, 0$, [- $(q_(r i 1), c, L)$],

    table.cell($q_(r i 1)$, rowspan: 2),
    $1, 0$, [- $(q_(r i 1), c, L)$],
    $X_1, X_0, [$, [- $(q_(m r i), c, R)$],

    table.cell($q_(m r i)$, rowspan: 1),
    $c = i$, [- $(q_(n c 0), X_i, R)$],

    table.cell($q_(n c 0)$, rowspan: 2),
    $1, 0$, [- $(q_(n c 0), c, L)$],
    $X_1, X_0$, [- $(q_(n c 1), c, L)$],

    table.cell($q_(n c 1)$, rowspan: 3),
    $"]"$, [- $(q_(v s), ], R)$],
    $X_1, X_0$, [- $(q_(n c 1), c, L)$],
    $1, 0$,
    [
      - $cases(
          (q_(r 1 0), X_1, L) "if" c = 1,
          (q_(r 0 0), X_0, L) "if" c = 0
        )$
    ],

    table.cell($q_(v s)$, rowspan: 2),
    $0, 1, X_0, X_1$, [- $(q_(v s), c, L)$],
    $"["$, [- $(q_(v n), "[", R)$],

    table.cell($q_(v n)$, rowspan: 2),
    $X_0, X_1$, [- $(q_(v n), c, L)$],
    $"]"$, [- $(q_a, "]", L)$],
  )
]
To make the table not too long, we used implicit rejections, that is, if there is a transition that is not available in the table, then it is a transition to the reject state. The workflow is quite easy, the machine starts with the tape of this form $[w_1 dots w_n]$ and accepts only if it can be written of the form $w w$. Here is a runtime of a non-deterministic Turing machine, notice that many machines were created in the process when running this non-deterministic machine.

#align(center)[
  #ntm(8, (
    (1, $w$, 0, ("[", 1, 0, 1, 1, 0, 1, "]")),
  ))

  #v(-2mm)

  #ntm(8, (
    (1, $w$, 1, ("[", 1, 0, 1, 1, 0, 1, "]")),
  ))

  #v(-2mm)

  #ntm(8, (
    (1, $w$, 2, ("[", 1, 0, 1, 1, 0, 1, "]")),
    (2, $r 00$, 1, ("[", $X_1$, 0, 1, 1, 0, 1, "]")),
  ))

  #v(-2mm)

  #ntm(8, (
    (1, $w$, 3, ("[", 1, 0, 1, 1, 0, 1, "]")),
    (2, $v n$, 0, ("[", $X_1$, 0, 1, 1, 0, 1, "]")),
    (3, $r 00$, 2, ("[", 1, $X_0$, 1, 1, 0, 1, "]")),
  ))

  #v(-2mm)

  #ntm(8, (
    (1, $w$, 4, ("[", 1, 0, 1, 1, 0, 1, "]")),
    (2, $v n$, 1, ("[", $X_1$, 0, 1, 1, 0, 1, "]")),
    (4, $r 10$, 3, ("[", 1, 0, $X_1$, 1, 0, 1, "]")),
  ))

  #v(-2mm)

  #ntm(8, (
    (1, $w$, 5, ("[", 1, 0, 1, 1, 0, 1, "]")),
    (2, $v n$, 2, ("[", $X_1$, 0, 1, 1, 0, 1, "]")),
    (4, $r 10$, 3, ("[", 1, 0, $X_1$, 1, 0, 1, "]")),
    (5, $r 10$, 4, ("[", 1, 0, 1, $X_1$, 0, 1, "]")),
  ))

  #v(-2mm)

  #ntm(8, (
    (1, $w$, 6, ("[", 1, 0, 1, 1, 0, 1, "]")),
    (4, $r 11$, 2, ("[", 1, 0, $X_1$, 1, 0, 1, "]")),
    (5, $r 11$, 3, ("[", 1, 0, 1, $X_1$, 0, 1, "]")),
    (6, $r 00$, 5, ("[", 1, 0, 1, 1, $X_0$, 1, "]")),
  ))

  #text($dots.v$, size: 1.6em)
]

As it can be seen here, it is quite difficult to simulate all of them, but the machine that will actually arrive to the accept state is $M_5$ in this case, which can be easily verified by just moving through the states as the transitions become deterministic after we exit the walk state. Also notice that this language can be decided by the deterministic Turing machine too, as we can just iterate through each of the machines using one machine. An interesting theorem that comes from the Turing theory is that

#thm(count: false)[
  The set of languages of the deterministic Turing machines is the same as the one the language of non-deterministic Turing machines.
]

Even though both can recognize the language, the deterministic equivalent machine will add in the number of steps since they will not be done in "parallel", we will talk more about this in a next section.

#v(-3mm)
= Complexity & Runtimes
Now that we defined a Turing machine, we can talk about complexity in a more formal way.

#def(count: false, name: "Steps")[
  Let $M$ be a (deterministic/non-deterministic) Turing machine, the number of steps is a function that takes $n$ the number of non-empty symbols on the tape, and returns $f(n)$ the number of usages of transitions to visit states until the machine halts.
]

We use the previously defined notations like $Oh(.)$. It can clearly be seen for example in the inverter example that it takes $Oh(n)$ steps, while the non-deterministic Turing machine for checking $cal(L) = {w w | w in Sigma^*}$ is $Theta (n^2)$ and its equivalent deterministic Turing machine is of order $Theta (n^3)$ since it has to go through the process $2n$ times for each machine.

#v(-3mm)

= Classes Of Complexity
Since we defined the measure of complexity, we can now define the classes of complexity. Usually, we talk about problems being in class $PC$, $NPC$, $NPC$-Complete... etc. We consider a language to be DTM(resp. NDTM)-decidable in $Oh(f)$ if there exists a deterministic(resp. non-deterministic) Turing machine that decides the language $cal(L)$ in $Oh(f)$.

#def(name: "TIME/NTIME", count: false)[
  $
     "TIME"(f(n)) & = { cal(L) "DTM-decidable in" Oh(f) } \
    "NTIME"(f(n)) & = { cal(L) "NDTM-decidable in" Oh(f) }
  $
]

#v(-3mm)
== Deterministic Polynomial Class $PC$
#def(name: [$PC$ Class], count: false)[ $
  PC = union.big_(k >= 0) "TIME"(n^k)
$ ]
which we usually take as the class of "efficient" algorithms, the philosophy for this choice comes from the fact that we usually accept that an algorithm of order $Oh(n)$ or $Oh(n^2)$ is quite efficient, also an algorithm calling another efficient algorithm efficiently is also efficient, so for example $Oh(n^3)$ calls an algorithm of $Oh(n^2)$, $Oh(n)$ times.

== Non-Deterministic Polynomial Class $NPC$
#def(name: [$NPC$ Class], count: false)[ $
  NPC = union.big_(k >= 0) "NTIME"(n^k)
$ ]
which we usually take as the class of non-efficient algorithms, since it does not satisfy the criterion of efficiency per say of the class $PC$. A good property that comes from the class $NPC$ is that any algorithm in $NPC$ can be verified in polynomial time with a deterministic Turing machine, that is, there exists an algorithm $cal(A) in PC$ to verify that the solution given by $NPC$ is correct.

To explain the relation more, we will do an analogy, and then prove this statement. Consider a finite square grid, and a walker, that has to figure a path to arrive at a certain location in the grid. We simulate it below using a non-deterministic Turing machine, that at each point it takes all the possible paths, up, down, left, and right and we see the first one that solves the problem.

#align(center)[
  #grid(
    columns: 4,
    gutter: 3mm,
    align: center + horizon,
    ..rw(
      7,
      7,
      2.95mm,
      (0, 0),
      (6, 6),
      16,
      config: range(4).map(i => (3, i)) + range(3).map(i => (i, 5)) + range(4).map(i => (5, 3 + i)),
      path: (
        (0, 0),
        (1, 1),
        (2, 2),
        (2, 3),
        (2, 4),
        (3, 4),
        (4, 4),
        (4, 3),
        (4, 2),
        (5, 2),
        (6, 2),
        (6, 3),
        (6, 4),
        (6, 5),
        (6, 6),
      ),
    )
  )
]

Every colored grid here represents a new machine that went in a different transition. Notice that in any setup that is like this, it will take at most $n^2$ machines to find the path, and after finding it, we take the set of transitions of the machine that got to the accepted state first, and we make it into a deterministic machine. Thus, we can notice that a problem that is $NPC$ can be verified in $PC$ time.

#def(name: "Certificate", count: false)[
  Let $cal(L) in NPC$, a certificate of an instance $x$ is a string $y$, that given with $x$ to a verifier, proves that $x in cal(L)$.
]

Consider the following SAT problem $ phi = (x_1 or overline(x_2)) and (x_2 or x_3) and (overline(x_1) or overline(x_3)) $ we take $x = chevron.l phi chevron.r$ its representation in the Turing machines, a certificate for this instance is an encoding of an assignment for $phi$, in this case $y = chevron.l quote.l x_1 = 1, x_2 = 0, x_3 = 1 quote.r chevron.r$. Or in the example above, given $x$ an encoding of the obstacles, start and stop of the path finder algorithm, $y$ would be the path that is drawn clearly in the last grid.

#def(name: "Verifier", count: false)[
  A verifier for a language $cal(L)$ is a deterministic Turing machine $V$ that takes inputs of the form $chevron.l x, y chevron.r$ and satisfies:
  + Completeness: if $x in L$ then there exists a certificate $y$ with $|y| <= p(|x|)$ with $p$ a polynomial such that $V(x, y)$ accepts.
  + Soundness: if $x in.not L$ then $forall y, V(x, y)$ rejects.
  + $V in PC$.
]

#thm(count: false)[
  #align(center)[
    $cal(L) in NPC$ $<=>$ there exists a verifier $V$ for $cal(L)$.
  ]
]

#prf[
  + $=>$ Let $cal(L) in NPC$, let $M_cal(L)$ be a non-deterministic Turing machine in $q(n)$ time, where $q$ is a polynomial. Given that the states and symbols are finite, then at each computation, there is at most a constant $c$ of possible next moves. We can encode those choices of each possible path of computation in the non-deterministic paths into a string $y$ that would have length $Oh(q(n))$.

    Thus, we create the machine $V$ such that for any input $chevron.l x, y chevron.r$, it simulates $M_cal(L)$ on $x$, but instead of going through all the possible non-deterministic paths, it chooses the path given by $y$, which would run in a polynomial, the verifier accepts only if $M_cal(L)$ accepts $x$ on the path given by $y$.

    $V$ indeed verifies $cal(L)$ since if $x in cal(L)$, then there exists an accepting path $M$ in $x$ encoded by $y$ of length less than $<= p(|x|)$ and $V(x, y)$ accepts. And $x in.not cal(L)$ then there is no paths for acceptance so $y$ would not exist.

  + $arrow.double.l$ Let $V$ be a verifier of $cal(L)$. We construct the non-deterministic Turing machine $M$ for $cal(L)$ as follows: for input $x$, it uses the non-deterministic behavior to write all possible strings $y in Sigma^*$ such that $|y| <= p(|x|)$, then in each of those run $V(x, y)$, accept if $V$ accepts and reject otherwise.

    $M$ runs in a polynomial time given that for each value of $y$ it takes $p(|x|)$ steps, and running $V$ takes polynomial time in $|x| + |y|$ which would be polynomial in $|x|$. If $x in cal(L)$, then there exists $y in Sigma^*$ such that $V(x, y)$ accepts so $M$ accepts $x$ and if $x in.not cal(L)$, then $y$ would not exist so all computation paths would reject thus $M$ rejects $x$. Then $M$ decides $cal(L)$ and since $M$ is non-deterministic polynomial then $cal(L) in NPC$.
]

The central problem of complexity since its birth is the question of how different the $PC$ and $NPC$ classes are, that is

#align(center)[
  $NPC eq.quest PC$.
]

This question is among the seven Millennium Prize Problems, due to its sheer difficulty in proving or disproving it. Most theoretical computer scientist and mathematicians tend to believe that it is false, that is, $PC != NPC$. The absurdity from their equality is more clear when you take an example. A nice example is the path finding algorithm we developed earlier, by taking a big maze, knowing how many obstacles and where they are, also the start and end position, you can fairly quickly check if a given solution is correct, the absurdity when $PC = NPC$ is the existence of an algorithm that just given those prior variables, can know what path to chose in the somewhat the same efficiency of checking the solution.

The problem I given before is known to be polynomial just by the breadth-first search algorithm, but the question still seems weird and tends to feel like it is an inequality, but for now it is not proved yet. Throughout the last century, an interesting equivalence has been set to simplify the search for this problem, which we will talk about in the next section.

== NP-Complete Class $NPCC$

#def(name: [$PC$-Computable Functions], count: false)[
  Let $f: D subset Sigma^* -> Sigma^*$, $f$ is said to be computable in polynomial time, or $PC$-computable, if there exists a Turing machine $M$ such that, for any $x in D$, $M$ halts with $f(x)$ written on the tape, and runs in at most $p(|x|)$ steps with $p$ polynomial.
]
#def(name: "Polynomial Reduction", count: false)[
  Let $A, B subset Sigma^*$ two languages, we say that $A$ reduces to $B$ in polynomial time, denoted $A rp B$, if there exists a polynomial-time computable function $f: Sigma^* -> Sigma^*$ such that $forall x in Sigma^*, x in A <=> f(x) in B$.
]

#lem(count: false)[
  + if $B in PC$ and $A rp B$ then $A in PC$.
  + if $B in NPC$ and $A rp B$ then $A in NPC$.
]

#prf[
  + Suppose that $B in PC$ and $A rp B$, let $f: Sigma^* -> Sigma^*$ the polynomial-time computable function that reduces $B$ to $A$, denote the polynomial of the reduction $f$, $p(n)$, and $M_B$ the polynomial-time algorithm that decides $B$. We construct a machine $M_A$ such as for any $x in Sigma^*$, compute $f(x)$, then run $M_B$ on $f(x)$ and accept or reject if $M_B$ accepts or rejects and since $x in A <=> f(x) in B$, the number of steps that $M_A$ takes is: $p(|x|)$ for the calculation of $f(x)$, then running $M_B$ on $f(x)$ which takes $q(|f(x)|)$ so the number of steps is $p(|x|) + q(p(|x|)) = Oh(p(|x|))$ then $M_A$ is a decider for $A$ in polynomial time.
  + Suppose that $B in NPC$ and $A rp B$, let $f: Sigma^* -> Sigma^*$ the polynomial-time computable function that reduces $B$ to $A$, since $B in NPC$ then there exists a polynomial-time verifier $V_B$ for $B$, we construct $V_A (x, y)$ as follows: compute $f(x)$ and run $V_B (f(x), y)$, we get the result using the same reasoning as earlier.
]

#def(name: [$NPC$-Complete Class], count: false)[
  A language $cal(L)$ is said to be $NPCC$ ($NPC$-complete) if $cal(L) in NPC$ and $forall cal(L)' in NPC, cal(L)' rp cal(L)$.
]

The existence of $NPC$-complete algorithms comes from a theorem proved by Cook-Levin Theorem.

#thm(count: false, name: "Cook-Levin")[
  The language $"SAT"$ $ "SAT" = {
    chevron.l phi chevron.r | phi "is a boolean formula in CNF"\ exists a "assignment", phi(a) = 1
  } $ is an NP-Complete problem.
]

A special case is the $3-"SAT"$, which given just $3$ variables instead of arbitrary ones in the SAT language, is also an $NPC$-complete problem. Multiple known $NPC$-complete problems are known such as:

- Knapsack problem.
- Subset sum problem.
- Graph coloring problem.
- Hamiltonian path problem.
- Subgraph isomorphism problem.
- Boolean satisfiability problem (SAT).
- Travelling salesman problem.

= Conclusion
Turing machines are a really useful formalism for computations which allowed us to see more complicated proofs on the how does algorithms work and practices.

