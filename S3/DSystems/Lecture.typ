
#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Dynamical Systems],
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures given by Dr. Chemllal.],
  ),
)

#let pO = math.op($cal(O)$)
#let Per = math.op("Per")

#chapter[Discrete Dynamical Systems][]

#section[Discrete Dynamical System]

#def(name: "Discrete Dynamical System")[
  A pair $(X, F)$ is discrete dynamical system if $X$ is a topological space and $F: X -> X$ is a continuous function.
]

#def(name: "Orbits")[
  Let $(X, F)$ be a DDS and $x in X$.
  - Positive orbit of $x$ is defined as $pO(x) = {F^n (x) | n in NN}$.
  - $x$ is periodic if $exists "period" p in NN^*, F^p (x) = x, forall i < p, F^i (x) != x$.
  - $x$ is said to be eventually periodic if $exists k in NN, F^k (x)$ is periodic.
  - The set of periodic points is denoted $Per(F)$.
]

#exm[
  - Rotations: let $X = [0, 1)$, the unit circle, and $R_alpha: [0, 1) -> [0, 1), x |-> x + alpha mod 1$
    #pro[
      There exists a no periodic point $<->$ $alpha$ is rational.
    ]

  - Doubling map: let $X = [0, 1)$ and $B: [0, 1) -> [0, 1), x |-> 2 x mod 1$
    #pro[
      $Per(B)$ is dense.
    ]
]

#subsection[Dynamical Systems Of The Interval]

We consider a dynamical system defined on $X = [a, b]$, we have the following theorem.

#thm(name: "Sharkovskii")[
  Define the following order on $n$: $
    2^k p prec 2^(k') p' <-> k > k' "or" (k = k' "and" p < p')
  $ which gives the following lexicographical order $
    mat(delim: #none,
      3 ,succ, 5 ,succ, 7 ,succ, 9 ,succ, 11 ,succ, dots.c;

      2 dot.c 3 ,succ, 2 dot.c 5 ,succ, 2 dot.c 7 ,succ, 2 dot.c 9 ,succ, 2 dot.c 11 ,succ, dots.c;

      dots.v ,, dots.v ,, dots.v ,, dots.v ,, dots.v ;

      2^n dot.c 3 ,succ, 2^n dot.c 5 ,succ, 2^n dot.c 7 ,succ, 2^n dot.c 9 ,succ, 2^n dot.c 11 ,succ, dots.c;

      dots.v ,, dots.v ,, dots.v ,, dots.v ,, dots.v ;
    )
  $

  Then if $f$ has a point of period $n$ it has a point of all periods $m succ n$.
]

#subsection[Dynamical Systems On Symbol Spaces]
#def(name: "Bernoulli Shift")[
  Let $A$ be a finite set of alphabets, we define the Bernoulli shift as the map $sigma: A^NN -> A^NN, x |-> sigma(x)$ with $forall i in NN, sigma(x)_i = x_(i+1)$.
]


An automaton is defined as a dynamical system $((ZZ\/p ZZ)^NN, O)$.

#section[Lyapunov Stability]

#def(name: "Stable/Attractive")[
  Let $(X, F)$ be a DDS and let $x_0 in X$ is a fixed point.
  - $x$ is stable if $forall epsilon > 0, exists delta > 0, forall y in B(x, delta), forall n in NN, F^n (y) in B(x, epsilon)$.
  - $x$ is attractive if $exists delta > 0, forall y in B(x, delta), lim_(n -> infinity) F^n (y) = x$.
  - $x$ is asymptotically stable if it is attractive and stable.
]

#subsection[Stability Of Interval Maps]
Suppose that $F: [a, b] -> [a, b]$ a differentiable function, and $x$ is a fixed point, then if $|F'(x)| < 1$ then $x$ is asymptotically stable, if $|F'(x)| > 1$ then $x$ is unstable.

#subsection[Equicontinuity]
Let $(X, F)$ be a DDS, we say that $x$ is an equicontinuity point if $forall epsilon > 0, exists delta > 0, forall y in B(x, delta), forall n in NN^*, F^n (y) in B(F^n (x), epsilon)$. We say that $(X, F)$ is equicontinuous if all its points are equicontinuity points.
