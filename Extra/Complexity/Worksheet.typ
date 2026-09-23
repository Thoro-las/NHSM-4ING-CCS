#import "@preview/finite:0.5.0" as finite: automaton
#import "@THR/Sum:1.0.0": *
#show: template.with(mainpage: false)

#ctitle("DFAs & NFAs")
#exr(ovcount: false)[
  Let $M=(Sigma, Q, delta, q_0, F)$ a DFA with
  - $Sigma = {a, b, c}$.
  - $Q = {q_0, q_1, q_2, q_4}$.
  - $F = {q_0}$.
  - $delta$ is defined with the table
  #align(center)[
    #table(
      columns: 3,
      $q in Q$, $c in Sigma$, $delta(q, c)$,
      $q_0$, $b, c$, $q_4$,
      $q_0$, $a$, $q_1$,
      $q_1$, $a, c$, $q_4$,
      $q_1$, $b$, $q_2$,
      $q_2$, $a, b$, $q_4$,
      $q_2$, $c$, $q_0$,
      $q_4$, $a, b, c$, $q_4$
    )
  ]

  + Draw the diagram of the DFA $M$.
  + Check which of the following strings are in the language of $M$:
    - $a a a$.
    - $a b a b c$.
    - $a b c a b c$.
  + Deduce $cal(L)(M)$.
]

#exr(ovcount: false)[
  + Prove that for $x in NN, x = overline(b_n b_(n-1) dots b_0)^2$, $2$ divides $x$ if and only if $b_0 = 0$.
  + Make a DFA taking the alphabet $Sigma = {0, 1}$, and accepts the string $S=s_1 dots s_n$ if and only if the number $overline(s_1 dots s_n)^2$ is divisible by $2$.
]

#exr(ovcount: false)[
  Consider the two deterministic automatons $
    M_1&=(Sigma, Q_1, delta_1, q_0^1, F_1).\
    M_2&=(Sigma, Q_2, delta_2, q_0^2, F_2).
  $ and define the automaton $
    M = M_1 times M_2 = (Sigma, Q, delta, q_0, F).
  $
  with the components
  - $Q = Q_1 times Q_2$.
  - $delta((q_1, q_2), c) = (delta(q_1, c), delta(q_2, c))$.
  - $q_0 = (q_0^1, q_0^2)$.
  - $F = F_1 times F_2$.

  + Prove that $cal(L)(M) = cal(L)(M_1) inter cal(L)(M_2)$.
  + By changing $F$, find a way to obtain a machine $M$ such that $cal(L)(M) = cal(L)(M_1) union cal(L)(M_2)$.
  + Try to find a way to also define a machine $M$ such that $cal(L)(M) = Sigma^* \\ cal(L)(M_1)$.
  + Deduce that the set of regular languages is an algebra of sets.
]

#exr(ovcount: false)[
  Find the languages of the following automatons
  #align(center)[
    #automaton(
      (
        q0: (q0: "b", q1: "a"),
        q1: (q1: "a", q2: "b"),
        q2: (q1: "a", q0: "b")
      ),
      style: (
        state: (fill: none),
        q0-q1: (curve: 0, label: (dist: -.43)),
        transition: (label: (angle: 0deg))
      ),
      layout: (
        q0: (0, 0),
        q1: (2, 0),
        q2: (2, -2)
      )
    )
    #line(length: 100%, stroke: (paint: blue, dash: "dashed"))
    #automaton(
      (
        q0: (q1: "b", q0: "a"),
        q1: (q2: "b", q0: "a"),
        q2: (q2: "b", q0: "a"),
      ),
      final: "q2",
      style: (
        transition: (label: (angle: 0deg, dist: 0.5)),
        q0-q1: (curve: 0.1),
        q1-q2: (curve: 0),
        q2-q0: (curve: 2),
        q1-q0: (curve: 0.1),
        q1-q1: (anchor: right),
        q2-q2: (anchor: right),
        state: (fill: none)
      )
    )
    #line(length: 100%, stroke: (paint: blue, dash: "dashed"))
    #automaton(
      (
        q0: (q1: "a", q3: "b"),
        q1: (q1: "b", q2: "a"),
        q2: (q2: "a", q1: "b"),
        q3: (q3: "a", q4: "b"),
        q4: (q3: "a", q4: "b")
      ),
      final: ("q2", "q3"),
      layout: (
        q0: (0, 0),
        q1: (2, 1.5),
        q2: (4, 1.5),
        q3: (2, -1.5),
        q4: (4, -1.5)
      ),
      style: (
        state: (fill: none),
        q0-q1: (curve: 0, label: (dist: -.33, angle: 0deg)),
        q0-q3: (curve: 0, label: (dist: .33, angle: 0deg)),
        q3-q3: (anchor: bottom),
        q4-q4: (anchor: bottom)
      )
    )
  ]
]

#exr(ovcount: false)[
  Construct an NFA for each of the following languages
  + $cal(L) = {a^n b^m | n, m in NN}$.
  + $cal(L) = {a S a | S in Sigma^*}$.
  + for $x, y in NN$, $cal(L)_(x, y) = {a^(x n + y) | n in NN }$.
]

#exr(ovcount: false, name: "Pumping Lemma")[
  Let $M$ be a DFA with $p$ states and let $S = s_1 s_2 dots s_n in Sigma^*$ a string.
  + Suppose that $S in cal(L)(M)$ and $n > p$, conclude that there exists at least one loop inside of the DFA, such that $S$ can be divided into $3$ sub-words, $x, y, z in Sigma^*$ such that $S = x y z$ and $y$ is detected by the loop.
  + Deduce that if $S = x y z$ like the previous question then $S = x y z in cal(L)(M) => forall i in NN, x y^i z in cal(L)(M)$, we call that pumping, that is, we can pump a string and keep it inside of the language which is a property of the regular languages.
  + Deduce that if a language does not accept pumping then it is not regular and thus there is no DFA that has that language.
    #lem(count: false)[
      Let $cal(L)$ be a language. If for all $p >= 1$\ there exists a string $S in cal(L)$ such that $|S| >= p$\ and for any $x, y, z in Sigma^*, |x y| <= p, |y| > 0$\ $S = x y z$ and there exists $i in NN, x y^i z in.not cal(L)$ then $cal(L)$ is not a regular language thus there is no DFA that has language $cal(L)$.
    ]
  + Apply the lemma on $cal(L) = {a^n b^n | n in NN}$ and deduce that $cal(L)$ is not regular.
]
