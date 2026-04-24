#import "@preview/commute:0.3.0": arr, commutative-diagram, node
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Random Number Generation",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures given by Dr. OUZANI.],
  ),
)

#let iso = $tilde.equiv$
#let card = math.op("#")

#chapter[Introduction To Random Number Generators][
  Random number generation is an important part of many modern applications both in science and technology. It provides a source for randomness for stochastic simulations, cryptography, security, also adds realism for games by adding predictability. Yet, computers are known to be deterministic machines, that is, there is no intrinsic randomness is inside of those machines. So the goal is to study algorithms that give pseudo-random sequences that can be used in each of their appropriate application.
]

The existence of randomness is a philosophical debate, whether the world is deterministic or not is a question yet to be answered, especially with the developments of quantum mechanics. But, for all intents and purposes, we usually refer by random events to events that are hard to predict. Thus, we define a sequence to be pseudo-random if it is deterministically generated but its values are predictable without knowing all the inputs and the workflow of the algorithm.

Pseudo-random number generation relies on the following criteria to improve its practicality:
- Computationally impredictive: given a sequence from the pseudo-random number generator, it is hard to determine the algorithm or the inputs that were used to create it, and predict the upcoming values.
- Uniformly distributed: the generated numbers should be uniformly distributed.
- Absence of correlation: there should be no correlation between observations at a certain moment and the next values.
- Sufficient period length: given that the algorithm is deterministic and the amount of representeable numbers is finite, then the algorithm will at some point turn back to its initial values, but such a period should be extremely large.

Differently from random number generation in simulations or other areas, RNG in cryptography, the security of a system is highly dependent on many parts, one of them being the unpredictability of the keys for encryption.

#section[Types Of Random Number Generators]
+ TRNG (True Random Number Generator): such random number generators use physical phenomena to generate values, and thus, it is practically impossible to have the exact same circumstances for the generation which makes it impredictible and irreproducible and is not forced to have any period.
+ PRNG (Pseudo Random Number Generator): uses deterministic algorithms with a seed to generate a pseudo-random sequence of numbers, which is reproducible if given the same seed but generally with a huge period.
+ QRNG (Quasi Random Number Generator): is also a deterministic sequence, but its goal is to have a low discrepancy, that is, the sequences are generated to be mainly equidistributed on the space, and are not as impredictible in general.

#table(
  columns: (1fr,) * 4,
  [*Criteria*], [*TRNG*], [*PRNG*], [*QRNG*],
  [*Source*], [Physical], [Algorithmic], [Deterministic],
  [*Reproducible*], [No], [Yes given seed], [Yes],
  [*Period*], [None], [Finite], [Finite],
  [*Speed*], [Slow], [Fast], [Fast],
  [*Secure*], [Yes], [Yes], [No],
  [*Cost*], [Expensive], [Cheap], [Cheap],
  [*Uniformity*], [Variable], [Excellent], [Optimal],
)

#chapter[Pseudo-Random Number Generation][]

#def(name: "PRNG")[
  A PRNG is a deterministic algorithm which generates a sequence of numbers that seem random, which uses an initial value called the seed and generates the next terms based on previous ones.
]

Generally, we try to use external sources to find seeds like the temperature of a CPU, the number of processes running or the current time of execution, and thus increases its unpredictability.

Characteristics of such generators are:
- From the definition, given the same seed, we can get the same sequence.
- Generate sequences quite efficiently for high performance applications.
- It would necessarily have a finite period.

#section[Congruence Generators]
Define the set $ZZ^(n star) = union_(n in NN) ZZ^n$ the set of all possible finite sequences from $ZZ$, and $Theta$ a set of all possible parameters $theta$.

#def(name: "Congruence Generator")[
  Let $f: ZZ^(n star) times Theta -> ZZ$, $theta in Theta$, $m in ZZ$, and ${X_n}$ a sequence with $X_0$ being the seed, and is defined as $ X_n = f((X_i)_(i=1)^(n-1); theta) mod m $
]
Here the generator depends on two prior parameters $(theta, m)$, also a seed to generate the same sequence. We start with the most basic congruence generator.

#subsection[Simple Linear Congruence Generator]

#def(name: "Simple Linear Congruence Generator")[
  We consider in this case $Theta = ZZ^2$, $f((X_i)_(i=1)^(n-1); (a, b)) = a X_(n-1) + b$, and so we get $ X_n = a X_(n-1) + b mod m $
]

#table(
  columns: (1fr, 1fr),
  align: left,
  table.header([Advantages], [Disadvantages]),
  [
    - Simple to implement.
    - Quick execution.
    - For large $m$, uniform on $[0, 1]$.
  ],
  [
    - Often predictable.
    - Bounded by $m$ values.
  ],
)

#pro[
  A SLCG sequence is of a period at most $m$.
]

#ooc[
  #prf[
    Let $(X_n)_(n in NN)$ be a sequence generated by a simple linear congruence generator, there are at most $m$ different values for each term $X_n$ so by pigeon-hole principle, if we take the first $m + 1$ terms then there are $2$ numbers that are equal. Notice also that if $X_i = X_j$ for some $i != j$, then necessarily $X_(i+1) = X_(j+1)$ and thus the period is exactly the smallest number that repeats. And from our previous step, it is clear that in the best case the smallest repeating number would be the $m^"th"$ term.
  ]

  So, our goal is to find some conditions to get the maximum period, that is, period $m$, which is given in the following theorem.
]

#thm(name: "Hull-Dobell")[
  Let $(X_n)_(n in NN)$ a sequence generated by an SLCG $X_n = a X_(n-1) + b mod m$, $(X_n)$ has a period $m$ if and only if the following conditions are true:
  - $b$ and $m$ are coprime.
  - $a-1$ is divisible by all prime factors of $m$.
  - if $4$ divides $m$, then $4$ divides $a-1$.
]

#colbreak()
#exm[
  + The RANDU generator from IBM is a SLCG which takes the following iterations $X_(n+1) equiv 65539 dot.c X_n mod 2^(31)$. This generator is bad, as when plotting in 3D the values ${(X_n, X_(n+1), X_(n+2))}_(n in NN)$ we can see a clear correlation between points.
  + Park & Miller generator is good SLCG which takes the form $X_(n+1) equiv 16807 dot.c X_n mod (2^31 - 1)$ and it is considered to be a standard.
]

#subsection[Multi-Linear Congruence Generator]
#def(name: "Multi-Linear Congruence Generator")[
  Let $k in NN^*$, We consider in here $Theta = ZZ^(k+1)$, $f((X_i)_(i=1)^(n-1); (a_1, dots, a_k, b)) = sum_(i=1)^k a_i X_(n-i) + b$, and so we get $ X_n = sum_(i=1)^k a_i X_(n-k) + b mod m $
]

#table(
  columns: (1fr, 1fr),
  align: left,
  table.header([Advantages], [Disadvantages]),
  [
    - Bigger period.
    - Less correlation.
    - For large $m$, uniform on $[0, 1]$.
  ],
  [
    - Computationally expansive relative to simple LCR.
  ],
)

#pro[
  Similar to the SLCG, a MLCG sequence has a period of at most $m^k$.
]

#ooc[
  #prf[
    Similarly to the SLCG, each term has at most $m$ possible values, by the pigeon-hole principle yet again, if we take the first $m^k + 1$ terms, then there is necessarily $i != j$ such that $(X_(i+l))_(l=1)^k = (X_(j+l))_(l=1)^k$ and thus by recursion we obtain that the next terms are equal, so the period is exactly the smallest $i$ such that $(X_(i+l))_(l=1)^k$ repeats which is at most $m^k$.
  ]
]

#exm[
  - Lewis, Goodman & Miller generator defined as #h(1fr) $ X_n equiv (6 X_(n-1) + 9 X_(n-2) mod 2^(31) $
]

#section[Linear Feedback Shift Register]

#ooc[
  Define the operation XOR on ${0,1}$ as follows $a plus.o b = 1 <=> a != b$, and $plus.o.big_(i=1)^n a_n = a_1 plus.o a_2 plus.o dots.c plus.o a_n$ and it is easy to prove by induction that this can be simplified into $plus.o.big_(i=1)^n a_n = 1 <=> card {i in [|1, n|] | a_i = 1}$ is odd.
]

#def(name: "Linear Feedback Shift Register")[
  Let $n, k in NN^*$ and ${i_1, dots, i_k} subset [|0, n|]$, define the sequence $(X_n)_(n in NN)$ with $X_0$ some seed and $ X_n = sum_(i=0)^n b_i 2^i => X_(n+1) = sum_(i=1)^(n) b_(i-1) 2^i + plus.o.big_(j=1)^k b_(i_j) $
]

#table(
  columns: (1fr, 1fr),
  align: left,
  table.header([Advantages], [Disadvantages]),
  [
    - Very fast.
    - Good distribution of bits.
  ],
  [
    - Predictable behavior.
    - Less flexible.
  ],
)

#section[Quality Of RNGs]

#subsection[Uniformity Tests]
Suppose you generate $N$ points using some RNG, these are some tests that can be used to check the uniformity.
+ *$chi^2$ On Classes:*
  - Consider a partition of $[0, 1]$ into $k$ classes.
  - Calculate the amount of points generated inside the class $j$ and denote it $O_j$.
  - Calculate the expected amount which is $E_j = N\/k$.
  - The statistic is $chi^2 = sum_(j=1)^k ((O_j - E_j)^2)/E_j$ with $"dll" = k - 1$.
  - If the $p$ value is small, reject the uniformity hypothesis.
+ *Kolmogorov-Smirnov Test:* We compare the function of empirical repartition $F_N$ to the function $f(x) = x$, which will be uniform if it is close.
+ *Autocorrelation Sampling:* We try to detect the correlation between the elements $U_n$ and $U_(n+k)$, we consider the statistic $
  hat(rho)_h = (sum_(i=h+1)^N (U_i - overline(U))(U_(i - h) - overline(U)))/(sum_(i=1)^N (U_i - overline(U))^2)
$ when it is independent, we get that $hat(p)_h tilde cal(N)(0, 1/N)$.

#chapter[Cryptographically Secure PRNGs][
  Random number generation can be used for many situations, depending on the situations, some properties are needed or neglected. Some of the generators we went through can be predicted, either the initial seed, the sequence terms or future states, which is unwanted in cryptographic random generation.
]

#def(name: "CSPRNG")[
  A cryptographic secure PRNG is a PRNG which for no efficient algorithm (polynomial time) can distinguish the output of a CSPRNG sequence from a truly uniformly random generated sequence with probability significantly higher then $1\/2$.
]

To define what "distinguish with probability" means, consider the game, you have an adversary and a challenger. The challenger chooses either a true random number generator or the CSPRNG, sample a sequence from the chosen generator and sends it to the adversary. The adversary is supposed to take the generated sequence and answer to the challenger, either the sequence came from a TRNG or a CSPRNG. 

#align(center)[
  #grid(
    columns: (5fr, 1fr, 5fr),
    row-gutter: 3mm,
    [*Challenger*], [], [*Adversary*],
    [ Chose TRNG or CSPRNG ], [], [],
    [ Generate sequence with generator ], [$-->$], [ Receive generated sequence ],
    [], [], [Run checking algorithm],
    [Check if adversary is right], [$<--$], [Send back the check]
  )
]

If the adversary does not know anything about the generation and has nothing to exploit, the best he can do is to randomly chose its either a TRNG or CSPRNG, thus you get the chance to distinguish near $1\/2$, if not, then the adversary would have a way to exploit to check if it is a CSPRNG.

#def(name: "Secure CSPRNG")[
  A CSPRNG is said to be secure if for any deterministic polynomial-time tester $T$, we have $
    |P(T(G_n) = 1) - P(T(U_n) = 1)| < epsilon(n)
  $
  - $G_n(s)$ is the output of the CSPRNG with length $n$ and seed $s$.
  - $U_n$ a uniformly sequence of length $n$.
  - $epsilon(n)$ a neglegible function.
]
