#import "@preview/finite:0.5.0" as finite: automaton
#import "@preview/wrap-it:0.1.1": wrap-content

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Complexity Theory],
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This course is one I write from some sources I read. Please be careful about the information given here.]
  )
)

#let card = math.op("#")
#let subset = $subset.eq$

#chapter([Introduction])[
  Computational complexity theory, or complexity theory in short, is a theory made for classifying algorithms and computational problems by their time, memory, or other resources usage throughout their runtime which allows a clear objective comparison between algorithms performance in general.
]

It is easy to notice that for different kind of machines, the same algorithm will lead to different running times, and even sometimes in the same machine. To be objective, we will start by making a model for a universal machine, the Turing machine, that allows us to compare algorithms independent of the hardware they run on, thus giving us an objective measure for efficiency of algorithms.

#ntt[
  Let $Sigma$ be a set of alphabets. We define the following:
  - $NN = {0, 1, 2, dots}$ and for $n<m$, $[|n, m|] = {n, n+1, dots, m-1, m}$.
  - $Sigma^n = Sigma times dots.c times Sigma$ the set of all words written with $n$ alphabets of $Sigma$, for $n = 0$, we get $Sigma^n = {epsilon}$ where $epsilon$ is the empty word.
  - If $Sigma = {a}$ then $Sigma^n = {a}^n$ and we denote it $a^n$.
  - $Sigma^* = union_(n in NN) Sigma^n$ the set of all possible words written with alphabets of $Sigma$.
  - Instead of using the notation $x = (x_1, x_2, dots, x_n)$ we will use the word notation $x=x_1 x_2 dots x_n$.
  - If $x=x_1 x_2 dots x_n in Sigma^n, y = y_1 y_2 dots y_m in Sigma^m$, we define the concatenation operation $x y$ such that $x y = x_1 x_2 dots x_n y_1 y_2 dots y_m in Sigma^(n + m)$ and for $S_1, S_2$ two sets of words, we define $S_1 S_2 = {x y | x in S_1, y in S_2}$.
  - Define the length $|dot.c|: Sigma^star -> NN, S |-> |S|=min{n in N | S in Sigma^n}$.
]

#colbreak()
#section("Machines & Automata")
We will present briefly some more basic machines and their workflow, to give a general idea of how computation is formalized and a motivation for some later concepts that will be used with Turing machines.

#subsection("Deterministic Automaton")
#def(name: "DFA", count: false)[
  Let $M = (Sigma, Q, delta, q_0, F)$ a _deterministic finite automaton_ (DFA), it satisfies: 
  - $Sigma$ an alphabet.
  - $Q$ a finite set of states.
  - $delta: Q times Sigma -> Q$ a transition function.
  - $q_0 in Q$ a starting state.
  - $F subset Q$ a set of accepted/final states.
  A _computation in $M$_ is done as follows: let $S = s_1 s_2 dots s_m in Sigma^*$, define the sequence ${D_i}_(i in [|1, m|]) subset Q$ that satisfies the recursion
  #v(-1mm)
  $
    cases(
      D_0 = q_0,
      D_(i) = delta(D_(i-1), s_(i)) "with" i in [|1, m|]
    )
  $
  #v(-2mm)
  $M$ is said to accept $S$ if and only if $D_m in F$, it is said to be rejected otherwise. We define the _language_ of $M$ denoted $cal(L)(M)$ as the set of all strings in $Sigma^*$ that the machine $M$ accepts.
]


#wrap-content(
  align: right,
  scale(100%)[#align(center)[
    #table(
      columns: 2,
      gutter: 1cm,
      stroke: 0mm,
      table(
        columns: 3,
        [$q in Q$], [$c in Sigma$], [$delta(q, c)$],
        [$q_0$], [$a$], [$q_1$],
        [$q_0$], [$b$], [$q_2$],
        [$q_1$], [$a$], [$q_2$],
        [$q_1$], [$b$], [$q_1$],
        [$q_2$], [$a, b$], [$q_3$],
        [$q_3$], [$a, b$], [$q_2$]
      )
    )
  ]],
  [
    Note that the finite in DFA comes from the fact that the set of states is finite. We have a natural way to represent DFAs as a graph which is similar to discrete Markov chains. We take the following example: Let $M = (Sigma, Q, delta, q_0, F)$ with $Sigma = {a, b}$, $Q = {q_0, q_1, q_2, q_3}$ and $F = {q_3}$ and the transition function is

    We represent the machine in the previous diagram, the starting state has an arrow "start" pointing to it, the final states having a double circle around them, the states are represented using circles with the name of the state inside, and the transitions are represented going from the state to the one it has to go through with the input given.
  ]
)


#align(center)[
  #automaton(
    (
      q0: (q1: "a", q3: "b"),
      q1: (q2: "a", q1: "b"),
      q2: (q3: "a, b"),
      q3: (q3: "a, b")
    ), 
    final: "q2",
    layout: (
      q0: (0, 0),
      q1: (3, 0),
      q2: (6, 0),
      q3: (3, -2)
    ),
    style: (
      q3-q3: (anchor: bottom),
      q0-q1: (curve: 0),
      q1-q2: (curve: 0),
      q0-q3: (curve: -1, label: (dist: -.43, angle: 0deg)),
      q2-q3: (curve: 1, label: (dist: .43, angle: 0deg)),
    ),
  )
]

We will run it on multiple examples, 
- $S = a b b a$
  + $D_0 = q_0$, $S <- a b b a$
  + $D_1 = delta(D_0, s_1) = delta(q_0, a) = q_1$, $S <- b b a$
  + $D_2 = delta(D_1, s_2) = delta(q_1, b) = q_1$, $S <- b a$
  + $D_3 = delta(D_2, s_3) = delta(q_1, b) = q_1$, $S <- a$
  + $D_4 = delta(D_3, s_4) = delta(q_1, a) = q_2$, $S <- epsilon$
Notice that $D_4 = q_2 in F$ thus $S in cal(L)(M)$, we will represent these transitions using the machine and we will get the same result.

#table(
  columns: 1,
  stroke: 0mm,
  align: horizon + center,
  [
    #scale(100%)[
      #automaton(
        (
          q0: (q1: "a", q3: "b"),
          q1: (q2: "a", q1: "b"),
          q2: (q3: "a, b"),
          q3: (q3: "a, b")
        ), 
        final: "q2",
        layout: (
          q0: (0, 0),
          q1: (3, 0),
          q2: (6, 0),
          q3: (3, -2)
        ),
        style: (
          q3-q3: (anchor: bottom),
          q0-q1: (curve: 0),
          q1-q2: (curve: 0),
          q0-q3: (curve: -1, label: (dist: -.43, angle: 0deg)),
          q2-q3: (curve: 1, label: (dist: .43, angle: 0deg)),
          
          q0: (fill: green.lighten(50%))
        ),
      )
    ]
  ],
  [
    #scale(100%)[
      #automaton(
        (
          q0: (q1: "a", q3: "b"),
          q1: (q2: "a", q1: "b"),
          q2: (q3: "a, b"),
          q3: (q3: "a, b")
        ), 
        final: "q2",
        layout: (
          q0: (0, 0),
          q1: (3, 0),
          q2: (6, 0),
          q3: (3, -2)
        ),
        style: (
          q3-q3: (anchor: bottom),
          q0-q1: (curve: 0),
          q1-q2: (curve: 0),
          q0-q3: (curve: -1, label: (dist: -.43, angle: 0deg)),
          q2-q3: (curve: 1, label: (dist: .43, angle: 0deg)),
          
          q1: (fill: green.lighten(50%))
        ),
      )
    ]
  ],
  table.cell([
    #scale(100%)[
      #automaton(
        (
          q0: (q1: "a", q3: "b"),
          q1: (q2: "a", q1: "b"),
          q2: (q3: "a, b"),
          q3: (q3: "a, b")
        ), 
        final: "q2",
        layout: (
          q0: (0, 0),
          q1: (3, 0),
          q2: (6, 0),
          q3: (3, -2)
        ),
        style: (
          q3-q3: (anchor: bottom),
          q0-q1: (curve: 0),
          q1-q2: (curve: 0),
          q0-q3: (curve: -1, label: (dist: -.43, angle: 0deg)),
          q2-q3: (curve: 1, label: (dist: .43, angle: 0deg)),
          q2: (fill: green.lighten(50%))
        ),
      )
    ]
  ], colspan: 1),
)

// #exr(count: false)[
//   Check which one of these strings is accepted by the automaton $M$.
//   #table(
//     columns: 2,
//     align: left,
//     stroke: 0mm,
//     column-gutter: 0.5cm,
//     $S = a b a b a$,
//     $S = a b b a a b$,
//     $S = b a a b$,
//     $S = a a b$
//   )
// ]

It is easy to notice that $cal(L)(M) = {a b^k a | k in NN}$, we will prove it
#pro(count: false)[
  Let $M$ the defined automaton in the previous example, then $cal(L)(M) = {a b^k a | k in NN}$.
]
#prf[
  Let $S=s_1 s_2 dots.c s_n in cal(L)(M)$ and $D_i$ the associated sequence of steps.
    - $s_1 = a$: suppose by contradiction that $s_1 = b$, then $D_1 = delta(D_0, b) = q_3$ thus we get $forall i in [|1, n|], D_i = q_3$ but $q_3 in.not F$, so $s_1 = a$.
    - $forall i in [|2, n-1|], s_i = b$: since $s_1 = a$ then $D_2 = q_1$, if for some $i in [|2, n-1|], s_i = a$ then $D_i = q_2$ thus $D_(i+1) = q_3$ and using the same argument as before we get that $q_3 in.not F$ which is a contradiction, thus $forall i in [|2, n-1|], s_i = b$.
    - $s_n = a$: notice that $D_(n-1) = q_1$ thus if $s_n = b$, $D_n = q_1 in.not F$ hence $s_n = a$.
]
#v(-2mm)

We will go through a series of examples of automata and their languages. We consider $Sigma = {a, b}$.

+ The language of the automaton below is the set of words with length exactly $2$ which we can write as $cal(L)(M) = Sigma^2$
  #v(-0.4cm)
  #align(center)[
    #automaton(
      (
        q0: (q1: "a, b"),
        q1: (q2: "a, b"),
        q2: (q3: "a, b"),
        q3: (q3: "a, b"),
      ),
      final: "q2",
      style: (
        transition: (curve: 0, label: (angle: 0deg, dist: 0.5)),
        q1-q1: (anchor: right),
        q2-q2: (anchor: right),
      )
    )
  ]
  #v(0.5cm)

+ The language of the automaton below is the set of words starting with $a$, written as $cal(L)(M) = a Sigma^* = {a w | w in Sigma^*}$.
  #v(0.5cm)
  #align(center)[
    #automaton(
      (
        q0: (q1: "a", q2: "b"),
        q1: (q1: "a, b"),
        q2: (q2: "a, b")
      ),
      final: "q1",
      layout: (
        q0: (0, 0),
        q1: (2, 1),
        q2: (2, -1)
      ),
      style: (
        transition: (curve: 0, label: (angle: 0deg, dist: 0.5)),
        q1-q1: (anchor: right),
        q2-q2: (anchor: right),
        q0-q1: (label: (dist: -0.5))
      )
    )
  ]
  #v(0.5cm)

+ The language of the automaton below is the set of words that have an even number of $b$s, $cal(L)(M) = { S in Sigma^* | card b(S) "is even"}$, notice in this case the $epsilon in cal(L)(M)$ since $card b(epsilon) = 0$ is even too.
  #v(-1mm)
  #align(center)[
    #automaton(
      (
        q0: (q1: "b", q0: "a"),
        q1: (q0: "b", q1: "a"),
      ),
      final: "q0",
      style: (
        transition: (curve: 0.8)
      )
    )
  ]
  #v(-1mm)

+ The language of the automaton below is the set of words that are of the form $a a$, $a a a a$, $a a a a a a$, ..., $a^(2 n)$, $cal(L)(M) = {a^(2 n) | n in NN}$.
  #v(-1mm)
  #align(center)[
    #automaton(
      (
        q0: (q1: "a", q2: "b"),
        q1: (q0: "a", q2: "b"),
        q2: (q2: "a, b")
      ),
      final: "q0",
      layout: (
        q0: (0, 0),
        q1: (3, 0),
        q2: (1.5, -3)
      ),
      style: (
        q0-q2: (curve: -1, label: (dist: -.33)),
        q1-q0: (label: (dist: -0.33)),
        transition: (label: (angle: 0deg))
      )
    )
  ]

+ The language of the automaton below is the set of words that have either $1$ or $3$ $mod 5$ $a$s, $cal(L)(M)={S in Sigma^* | (card a(S) mod 5) in {1, 3}}$.
  #align(center)[
    #automaton(
      (
        q0: (q1: "a", q0: "b"),
        q1: (q2: "a", q1: "b"),
        q2: (q3: "a", q2: "b"),
        q3: (q4: "a", q3: "b"),
        q4: (q0: "a", q4: "b"),
      ),
      final: ("q1", "q3"),
      layout: finite.layout.circular,
      style: (
        transition: (curve: 0, label: (angle: 0deg)),
        q0: (initial: bottom + left),
        q0-q0: (anchor: top + left),
        q1-q1: (anchor: bottom),
        q2-q2: (anchor: top + right),
        q3-q3: (anchor: bottom + right),
        q4-q4: (anchor: bottom + left),
      )
    )
  ]

The expression of such a machine is really limited, that is, if the set of languages $cal(L) subset Sigma^*$ that deterministic finite automatas can determine is really limited, the set of languages that the deterministic finite automata can detect is called regular languages. An example of a language that is not regular is $cal(L) = {a^n b^n | n in NN}$ where $Sigma = {a, b}$.

#subsection("Non-Deterministic Finite Automaton")
A non-deterministic automaton is a generalization of the automaton, where we give it more abilities to be stronger than the deterministic finite automata.

#def(name: "NFA", count: false)[
  Let $M=(Sigma, Q, delta, q_0, F)$ a _non-deterministic finite automaton_ (NDFA or NFA), it satisfies:
  - $Sigma$ an alphabet.
  - $Q$ a finite set of states.
  - $delta: Q times (Sigma union {epsilon}) -> Q$.
  - $q_0$ a starting state.
  - $F subset Q$ a set of accepted/final states.
  A computation in $M$ is done as follows: let $S = s_1 s_2 dots s_m in Sigma^*$, $S$ is said to be accepted by $S$ if there exists a sequence ${D_i}_(i in [|1, m|]) subset Q$ that satisfies the recursion. $
    cases(
      D_0 = q_0,
      D_i in delta(D_(i-1), s_i)
    )
  $
  and $D_m in F$, it is said to reject otherwise.
]

#ooc[
  The definition above is taken directly from Wikipedia, I have a doubt about it so here is how I formalized it, even though it is a mouthful.
  $ cases(
    D_0 = {(q_0, S)},
    D_i = limits(union.big)_((q, S) in D_(i-1)\ S = s_1 s_2 dots s_n) (union_(q' in delta(q, s_1)) {(q', s_2 s_3 dots s_n)}) union (union_(q' in delta(q, epsilon)) {(q', S)})
  ) $
  $M$ is said to accept $S$ if and only if $exists (q, epsilon) in D_m, q in F$ and it is said to reject otherwise.
]

In this new model, we have 3 additional features:
+ The ability to jump without consuming any character from the string with the $epsilon$-transitions, that is, the transitions that have $epsilon$ as the character.
+ The ability to jump to multiple states using just one letter of the string, this comes from the fact that $delta(q, c)$ is a set of possible paths to take.
+ The implicit transitions to trap states, that is, if $delta(q, c)$ is not defined, then we assume implicitly that it jumps to a state $q_(emptyset)$ and does not transition to anything else. To do this, we just create a new state $q_(-1)$, and whenever there is no transition from a state $q_i$ with letter $c$ then we define $delta(q_i, c) = {q_(-1)}$ and we define $forall c in Sigma union {epsilon}, delta(q_(-1), c) = {q_(-1)}$.

#align(center)[
  #table(
    columns: 3,
    stroke: 0mm,
    align: center + horizon,
    column-gutter: 0.3cm,
    [
      #automaton(
        (
          q0: (q1: "a"),
          q1: (q1: "b")
        ),
        style: (
          q0-q1: (curve: 0)
        )
      )
    ],
    text($equiv$, size: 1.5em),
    [
      #automaton(
        (
          q0: (q1: "a", q2: "b"),
          q1: (q1: "b", q2: "a"),
          q2: (q2: "a, b")
        ),
        final: "q1",
        labels: (
          q2: [q#sub([-1])],
        ),
        layout: (
          q0: (0, 0),
          q1: (1.7, 1),
          q2: (1.7, -1)
        ),
        style: (
          transition: (curve: 0, label: (angle: 0deg, dist: 0.33)),
          q1-q1: (anchor: right),
          q2-q2: (anchor: right),
          q0-q1: (label: (dist: -0.33)),
          q1-q2: (label: (dist: -.33))
        )
      )
    ]
  )
]

The non-determinism comes from the fact that we do not have a deterministic path we walk along, but each step may lead to many paths. We will go through a series of examples of NFAs to see how those features add expression.

+ The language of the automaton below is the set of words that end with $3$ $a$s, which we can write as $cal(L)(M) = Sigma^* a a a$. Notice that there are two transitions with $a$ that go from $q_0$.
  #align(center)[
    #automaton(
      (
        q0: (q0: "a, b", q1: "a"),
        q1: (q2: "a"),
        q2: (q3: "a"),
      ),
      final: "q3",
      style: (
        transition: (curve: 0, label: (angle: 0deg, dist: 0.5)),
      )
    )
  ]
  #v(2cm)
+ The language of the automaton below is the set of words that either have an odd number of $b$s or have an even number of $a$s, which can be written as follows $cal(L)(M) = { S in Sigma | card a(S) "is even" or card b(S) "is odd"}$.
  #align(center)[
    #automaton(
      (
        q0: (q1: "a", q3: "a"),
        q1: (q1: "b", q2: "b"),
        q2: (q2: "a", q1: "b"),
        q3: (q3: "b", q4: "a"),
        q4: (q3: "a", q4: "b")
      ),
      final: ("q2", "q3"),
      labels: (
        q0-q1: $epsilon$,
        q0-q3: $epsilon$,
      ),
      layout: (
        q0: (0, 0),
        q1: (2, 1.5),
        q2: (4, 1.5),
        q3: (2, -1.5),
        q4: (4, -1.5)
      ),
      style: (
        q0-q1: (curve: 0, label: (text: $epsilon$, dist: -.33, angle: 0deg)),
        q0-q3: (curve: 0, label: (text: $epsilon$, dist: .33, angle: 0deg)),
      )
    )
  ]


From the previous examples, we can assume that an NFA will be stronger than an NFA, which is wrong. The set of languages that can be determined with an NFA is exactly the one that can be determined by a DFA. It is clear that any DFA is an NFA. Now we will prove that the languages from NFA can be determined using DFA too.

#thm(count: false)[
  Let $M$ be a non-deterministic automaton, then there exists a deterministic automaton $M'$ such that $cal(L)(M) = cal(L)(M')$.
]
#prf[
  Let $M=(Sigma, Q, delta, q_0, F)$ be an NFA and define the function $r: Q -> cal(P)(Q)$ such that $r(q) = {q' in Q | exists (q_j)_(j in [|1, k|]), q_1 = q, q_k = q', q_j in delta(q_(j-1), epsilon)}$, that is, $r(q)$ is the set of states that $q$ can reach with using only $epsilon$-transitions. We define the DFA $M'=(Sigma, Q', delta', q_0', F')$ where $Q' = cal(P)(Q)$, $delta'({q_1, dots, q_k}, c) = union_(i=1)^k r(delta(q_i), a)$, $q_0' = r(q_0)$, $F' = {f subset Q | f inter F != emptyset}$. 
]

#nte[
  The proof is incomplete, given that we have to prove that the languages are the same. I am finding a difficulty to prove it given that the definition given by Wikipedia seems to not make sense with the $epsilon$-transitions, and my definition is not usable in this context.
]

We have proved the equivalence of expression of both models, but there is a difference. A DFA explores a single, unique path of computation for each step and goes step by step while the NFA can explore multiple paths in parallel. So even though in theory they express the same languages, in practice using the method given in the proof results in an exponential increase of time for the simulation of the same language using the DFA instead of NFA.
