#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Cryptography],
    writer: "HADIOUCHE Azouaou",
  )
)

#chapter[Introduction][]

#let card = math.op("#")

#section(level: 1)[Cryptographic Group Actions]
The group action in the Diffie-Hellman key exchange is the triplet $(X, G, star)$ with $X$ a set and $G$ a commutative group. Fix $x_0 in X$.
#grid(
  columns: (1fr, 2cm, 1fr),
  align: horizon + center,
  [
    #align(center)[Alice]
    $
      a <- G\
      A = a star x_0 \
      K_A = a star B
    $
  ],
  [
    #v(0.5cm)
    $
      limits(-->)^A
      \
      limits(<--)_B
    $
  ],
  [
    #align(center)[Bob]
    $
      b <- G\
      B = b star x_0 \
      K_B = b star A
    $
  ],
)

Which works directly from the commutativity of $G$. We can rephrase the Group-DH as a GA-DH. By considering the set $X$ as the group $G$ and $G$ to be the multiplicative group $(ZZ_p)^star$, therefore $
  exp: (ZZ_p)^star times G & -> G\
  (x, g) &|-> g^x
$

#section[Group Actions For Cryptography]
For group actions to be used in cryptography, it should satisfy the effectiveness and security.

#def(name: "Effective", count: false)[
  Let $(G, X, star)$ an action group, it is effective if
  - $G$ is finite.
    - Membership testing, it is easy to check if an element in the group $G$.
    - Equality testing, given two elements $g, h$, it is easy to check that $g = h$.
    - Operation, it is efficient to calculate $g h$ for $g, h in G$.
    - Inversion, it is efficient to calculate $g^(-1)$ for $g in G$.
    - Sampling, it is easy execute $g <-_\$ G$.
  - $X$ is finite.
    - Membership testing.
    - Unique representation.
  - $exists x_0 in X$ distinguished.
  - Efficient evaluation of the action.
]

#def(count: false, name: "Regular")[
  Let $(G, X, star)$ be an action group, it is said to be regular for any $x, x' in X$, there exists a unique $g in G$ such that $x' = g star x$.
]

In practice, we want $(G, X, star)$ is regular.

#exr(count: false)[
  $(ZZ_p)^star times H \\ {"id"} -> H \\ {"id"}$ is regular.
]

#def(name: "Security", count: false)[
  Let $(G, X, star)$ be an action group, it is said to be secure if the following problems are hard to solve:
  - Problem 1 (DLOG): given $x, x' in X$ find $g in G$ such that $g star x = x'$.
  - Problem 2 (Computational DH): given $x, x' in X, g star x$, find $x'' = g star x'$.
]

#alg(count: false, name: "Baby-Step Giant-Step Algorithm")[
  Let $(G, X, star)$ an action group, given $x, x'$, the goal is to find $g in G$ such that $x' = g star x$.
  - Baby Steps: we calculate $x_0, dots, x_k$ with $k tilde.eq sqrt(N)$ with $N = card G$.
  - Giant Steps: take $y_j = (h^k)^j star x'$.
  If we find a collision $y_j = x_i$ then $(h^k)^j star x' = h^i star x => x' = h^(i - k j) star x$.
]

#thm(count: false)[
  Discrete logarithm is random self-reducible, that is, fix a group $G = chevron.l g chevron.r$, given an algorithm $cal(A)$ that solves $"DLOG"_g (u)$ with probability $0 < epsilon <= 1$ with $u$ uniformly chosen from $G$, we can construct an algorithm $B$ with same complexity as $A$, that solves $"DLOG"_g (u)$ with probability $epsilon$ for any $u in G$.
]

#section[Interactive Protocols]
#def(name: "Language", count: false)[
  A language is a relation between a set of statements $S$ and a set of witnesses $W$, $cal(L) subset S times W$. If $(s, w) in cal(L)$, we say that $s$ is in the language $s in cal(L)$ and that $w$ is a witness for $s$.
]

#def(name: "NP/P", count: false)[
  Let $cal(L)_lambda$ be a family of languages with $lambda -> infinity$
  - $cal(L)$ is in $"NP"$ if there exists a deterministic $"poly"(lambda)$ algorithm $cal(A)_lambda$ such that $
    cal(A)_lambda (s, w) -> cases(
      0 &"if" (s, w) in.not cal(L)_lambda,
      1 &"if" (s, w) in cal(L)_lambda
    )
  $
  - $cal(L)$ is in $"P"$ if there exists a deterministic $"poly"(lambda)$ algorithm $cal(A)_lambda$ such that $
    cal(A)_lambda (s) -> cases(
      0 &"if" s in.not cal(L)_lambda,
      1 &"if" s in cal(L)_lambda
    )
  $
  - $cal(L)$ is said to be $"PSPACE"$ if there exist a $"poly"(lambda)$-space algorithm $cal(A)_lambda$ $
    cal(A)_lambda (s) -> cases(
      0 &"if" s in.not cal(L)_lambda,
      1 &"if" s in cal(L)_lambda
    )
  $
]

#exm[
  - $cal(L) = {(g^x, x) | chevron.l g chevron.r = G, 0 <= x <= card G - 1} in "NP"$
]

#def(name: "Interactive Protocol (IP)", count: false)[
  An interactive protocol for $Lambda_1$.
  - Verifier is $"poly"(lambda)$ probabilistic.
  - Prover is unbounded.
  - Verifier is a public coin.
  It is complete if $(s, w) in cal(L)_lambda$ the verifier always outputs $1$. And it is sound if $s in.not in cal(L)_lambda$ then $Pr("Verifier" -> 1) = c <<_lambda 1$, where $c$ is the soundness error.
]

#thm(count: false, name: "Shamir")[
  $"IP" = "PSPACE"$.
]

#def(name: "Simulator/Zero Knowledge (ZK)", count: false)[
  There exists a probabilistic $"poly"(lambda)$ simulator $"Sim"$ such that $"Sim"(s)$ simulates a conversation between prover and verifier same as in the original protocol.
]

#chapter[Elliptic Curve Cryptography][]
Recall that we have
- DH: Diffie-Hellman key exchange from groups.
- Points on an elliptic curve (EC) form a group.
We have an algorithm EC-DH which goes as follows.
  - Setup: Let $E\/FF_p$ an elliptic curve, $P in E(FF_p), "ord"(P) = N$ then $chevron.l P chevron.r = {infinity, dots, [N-1] P}$.

On elliptic curves, the operations as follows: $P_1 = (x_1, y_1)$ and $P_2 = (x_2, y_2)$, $P_3 = (x_3, y_3) = P_1 + P_2$
  - $x_1 != x_2$: $m = (y_2 - y_1)/(x_2 - x_1) => x_3 = m^2 - x_1 - x_2, y_3 = m(x_1 - x_3) - y_1$.
  - $x_1 = x_2$, $y_1 = y_2 != 0$: $m = (3x_1^2 - a)/(2y_1)$, $x_3 = m^2 - 2 x_1, y_3 = m(x_1 - x_3) - y_1$.
  - otherwise: $P_3 = infinity$.

We want the scalar multiplication to be the cryptographic one-way function for $a in ZZ, P in E, f_P: ZZ -> E, P |-> [a]P$. For it to be used as a one-way function it should satisfy:
- Hard to invert
- EC-DLOG: given $P in E(FF_p)$ and $Q in chevron.l P chevron.r$, find $a in ZZ, [a] P = Q$.

Observe, depending on $E$, easy instances called "anomalous curves", "low embedding-degrees".

#exm[
  Consider the elliptic curve $E: Y^2 = X^3 + 3X$ over $FF_5$. Fir $P = (2, 2)$, if Alice takes $a = 3$, she gets $A = [3]P = (3, 4)$ and Bob takes $b = 8$ then $B = [8]P = (1, 2)$. then $K = [a b] P = (4, 4)$. Since $card E (FF_5) = 10$ then $[5]A = [5] [3] P = [15] P = [5] P = (0, 0)$. and $[5] B = [5][8]P = [40]P = [4][10]P = infinity$.
  
  The main observation is that by computing $[N/2]P$, public key, we get one bit of a secret key. More generally, the difficulty of DLOG depends on the largest prime factor of $N$, $N = "ord"(P)$, so we chose $P$ a point of prime order. (Pohlig-Hellman).

  #exr(count: false)[
    $N=2^n$, $"ord"(P) = N$ and $Q in chevron.l P chevron.r$, find $a, [a] P = Q$ in $n$ steps.
  ]
]

Invalid Curve Attack: consider a curve $E: y^2 = x^3 + a x + b$, $card E(FF_p) = q$ prime and take $P$ with $chevron.l P chevron.r = E(FF_p)$. Alice takes $a <- ZZ$ uniformly, and Mallory considers another elliptic curve $E': y^2 = x^3 + a x + b'$, $A = [a] P$. Alice sends $A$ to Mallory, Mallory chooses $p'$ such that $p' in E' (FF_p), "ord"(p') = 2$ and sends it back $p'$. We obtain $K = [a] P'$ which will be either $P'$ or $infinity_(E')$, therefore Mallory can find a single bit from the secret key, repeating this process, it can deduce the whole secret key.

*Counter-measures:*
- Say $P' = (x', y') in^"?" E(FF_p)$, that is $y'^2 =^"?" x'^3 + alpha x' + beta$ which will not be satisfied if we take another curve $y'^2 = x'^3 + alpha x' + beta'$, thus we just check if $P' in E$ to make sure there is no attack.

#section[Isogeny-Based Cryptography]

