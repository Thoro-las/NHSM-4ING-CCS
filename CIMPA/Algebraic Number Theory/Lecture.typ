#import "@preview/lilaq:0.6.0" as lq

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Algebraic\ Number Theory],
    writer: "HADIOUCHE Azouaou",
    disclaimer: [
      This will be a rewrite of the course of Pr. P. STEVENHAGEN, it will be far from the explanations or the accompanied textbook of the course.
    ],
  ),
)

#let ord = math.op("ord")

#chapter[Introduction][
  In this part, we motivate the usage of algebraic number theory using elliptic curves. Consider the following elliptic curve
  #align(center)[
    $ E: y^2 = x^3 - 1 $
    #{
      let x = lq.linspace(1, 5, num: 70)
      lq.diagram(
        width: 7cm,
        height: 7cm,
        xlim: (0, 6),
        lq.plot(x, x => calc.sqrt(calc.pow(x, 3) - 1), color: blue, mark: none, smooth: true),
        lq.plot(x, x => -calc.sqrt(calc.pow(x, 3) - 1), color: blue, mark: none, smooth: true),
      )
    }
  ]
]

We would like to prove the following theorem
#thm(count: false)[
  The only integral solution to $E$ is $(0, 1)$.
]

#prf[
  By rewriting our equation into $x^3 = y^2 + 1$, we can think of writing the RHS as a product, that is, by considering on the ring $ZZ[i] subset QQ[i]$, which is a unique factorization domain, we have that $y^2 + 1 = (y + i)(y - i)$.

  Now we prove that $y+i$ and $y-i$ are coprime. Suppose that there is a prime $pi$ such that $pi | y + i$ and $pi | y - i$, then $pi | y + i - y + i = 2 i$ and since $i in (ZZ[i])^star$ then necessarily $pi | 2$. In $ZZ[i]$, $2$ is factorized as $(1+i)(1-i) = -i (1+i)^2$, thus $pi$ is necessarily $i+1$ times some unit. By reducing mod $4$ both $x^3$ and $y^2 + 1$, we obtain that $x^3 equiv 0, 1 mod 4$ and $y^2 + 1 equiv 1, 2 mod 4$ thus $x^3 equiv 1 mod 4$ so $x$ is odd and $y^2 equiv 0 mod 4$ so $y$ is even. Given that $i+1 | pi$ then necessarily we have $1 + i | y + i$ which is impossible since $y$ is even. Thus, $y+i$ and $y-i$ are coprime.
]

#chapter[$p$-adic Numbers][
  Consider $K\/QQ$ a number field, to be able to understand the arithmetic of $K$, we want to understand for every $p$ prime the decomposition $ p dot.c O_k = frak(p)_1^(e_1) dots.c frak(p)_t^(e_t) $ for now the way we can do it is using the Kummer-Dedekind criterion stating that if $alpha in O_k$ such that $K = QQ(alpha)$ and $p divides.not [O_k : ZZ[alpha]]$, then we can understand $p dot.c O_k$ from the factorization modulo $p$ of $"min"_alpha (X) in ZZ[x]$.

  In particular, if $overline("min"_alpha)(X) = product_(i=1)^t overline(g_i)(X)^(e_i), overline(g_i)(X) in FF_p[X]$ irreducible, then we obtain the following factorization $p dot.c O_k = frak(p)_1^(e_1) dots.c frak(p)_t^(e_t)$ where $frak(p)_i = (p, g_i (alpha))$ where $g_i in ZZ[X]$ is any lift of $overline(g_i) (x)$.

  The problem happens when $p | [O_k : ZZ[alpha]]$ for any $alpha in O_k$. The aim of this part of the course is to get around this issue.
]

We will see that we can build for any prime $p$ a field $QQ_p \/ QQ$ such that $K times.o_QQ QQ_p = product_(i=1)^t K_(frak(p)_i)$ with $K_(frak(p)_i)\/QQ_p$ finite extension $[K_(frak(p)_i):QQ_p] = e_i f_i$ and $p dot.c O_k = frak(p)_1^(e_1) dots.c frak(p)_t^(e_t)$.

#nte[
  If $K = QQ(alpha) = QQ[X]\/("min"_alpha (X))$ then $ K times.o_QQ QQ_p = QQ[X]\/(f(X)) times.o_QQ QQ_p \ tilde.equiv QQ_p [X]\/(f(X)) tilde.equiv product_(i=1)^t QQ_p [X]\/(h_i (X)) $ by the CRT, $f(x) = h_1 (X) dots.c h_t (X)$ in $QQ_p [X]$, $h_i(X)$ irreducible over $QQ_p [X]$. If instead of $QQ_p$ we take $RR$, we have $ K times.o_QQ RR tilde.equiv RR[X]\/(f(X)) tilde.equiv product_(i=1)^r RR[X]/(x - alpha_i) times product_(j=1)^s RR[X]/(h_j (X)) tilde.equiv RR^r times CC^s $ where $f(X) = (X-alpha_1) dots.c (X-alpha_r) h_1 (X) dots.c h_s (X)$, $h_i in RR[X]$ irreducible of degree $2$, $r$ is the number of real embeddings and $s$ the number of pairs of complex conjugate embeddings.
]

Now we go on how to build $RR$ starting from $QQ$. On $QQ$ we have the Euclidean absolute value $ Phi_infinity: QQ & -> QQ_(>=0) \
               x & |-> |x| $ and $RR$ is the completion of $QQ$ with respect to $Phi_infinity$. We define $R$ as the set of Cauchy sequences with respect to $Phi_infinity$ and $m$ as the set of sequences that tends to zero.

#exr(count: false)[
  Prove that $R$ with component-wise addition and multiplication form a ring, and $m$ is an ideal of $R$ thus $R\/m$ is a ring and more specifically it is a field, which we denote as $RR = R\/m$.
]

If you look at the exercise you will see that the only thing you need in order to have that $R\/m$ is a field is a function $Phi: QQ &-> QQ_(>=0)$ that satisfies:
- $Phi(x) = 0 <=> x = 0$.
- $Phi(x y) = Phi(x) Phi(y)$.
- $Phi(x + y) <= C dot.c max(Phi(x), Phi(y))$

#section[$bold(p)$-adic Numbers]
Fix a prime $p in ZZ$, we defined the order function as follows $ "ord"_p: QQ\\{0} & -> ZZ quad quad a/b & |-> "ord"_p (a) - "ord"_p (b) $ with $a, b in ZZ, gcd(a, b) = 1$, where if $a in ZZ$ $"ord"_p (a) = n$, $p^n | a$ and $p^(n+1) divides.not a$.

#exm[
  For $p = 5$:
  - $"ord"_5 (7) = 0$.
  - $"ord"_5 (30) = "ord"_5 (5 dot.c 6) = 1$.
  - $"ord"_5 (-4/125) = "ord"_5 (-4) - "ord"_5 (5^3) = - 3$.
]

#nte[
  We extend $"ord"_p$ to $QQ$ by defining $"ord"_p (0) = infinity$.
]

#def(count: false, name: [$p$-adic Norm])[
  Let $c in (0, 1)$, then we can define $ Phi_p: QQ & -> RR_(>=0) quad quad
              x & |-> c^("ord"_p (x)) $
]

#exr(count: false)[
  - $Phi_p (x) = 0 <=> x = 0$.
  - $Phi_p (x y) = Phi_p (x) Phi_p (y)$.
  - $Phi_p (x + y) <= max(Phi_p (x), Phi_p (y))$.
]

#def(count: false, name: "")[
  We take $QQ_p = R\/m$ where $R$ is the set of Cauchy sequences of $QQ$ with respect to $Phi_p$, and $m$ is the set of sequences of $QQ$ that tend to $0$ with respect to $Phi_p$.
]

In the real numbers, any $x in RR$ is written as $x = plus.minus sum_(n=k)^infinity a_n dot.c 10^(-n)$ for some $k in ZZ$ and $a_n in {0, dots.c, 9}$. Similarly, over $QQ_p$ every element can be written as $sum_(n=k)^infinity a_n p^n$ with $k in ZZ$ and $a_n in {0, dots, p-1}$.

#lem(count: false)[
  Define $ZZ_p = {x in QQ_p | Phi_p (x) <= 1}$
  - $ZZ_p$ is a ring.
  - $ZZ subset ZZ_p$.
  - $ZZ_p$ has just one non-zero prime ideal given by $p ZZ_p subset ZZ_p$, we have that $ZZ_p \/ p ZZ_p tilde.equiv ZZ \/ p ZZ$.
]

#pro(count: false)[
  For any $x in QQ_p$, there exists a unique sequence $(a_n)_(n in NN) subset {0, dots, p-1}^NN$ such that $x = sum_(n=0)^infinity a_n p^n$.
]

#prf[
  // $sum_(n=k)^infinity a_n dot.c p^n$ for $k in ZZ, a_n in {0, dots.c, p-1}$ is well defined in $QQ_p$. Note that, $S_N = sum_(n=k)^N a_n p^n$ then $lim_(N-> infinity) S_N = sum_(n=k)^infinity$. We need to check that $(S_N)_(N in NN)$ is Cauchy, $Phi_p (S_M - S_N) = Phi_p (sum_(n=N+1)^M a_n p^n) = c^(N+1) -> 0$ where $Phi_p (a_n p^n) = c^n$.

  Let $x in QQ_p$.
  - There exists $k in ZZ_(>=0), p^k x in ZZ_p$. (Exercise: $Phi_p (p^k x) = c^k Phi_p (x) <= 1$.)
  - Show that for $x in ZZ_p, x = sum_(n=0)^infinity a_n p^n$.
  - Take $a_0 in [|0, p-1|], x equiv a_0 mod p$ thus $x - a_0 = p x_1$ for some $x_1 in ZZ_p$. Take $a_1$ such that $x_1 equiv a_1 mod p$ thus $x-a_0 - p a_1 - dots - p^n a_n equiv 0 mod p^n$ hence $x = sum_(n=0)^infinity a_n p^n$.
]

#section[Factorizing Polynomials Over $QQ_p [X]$]
If $alpha in QQ_p$ is a root of $f(X)$ then $f(X) = (X - alpha) g(X)$. Start with $f(X) in ZZ[X]$.
- If $f(X) equiv 0 mod p$ has no solution, then we don't have any solution over $ZZ_p$.
- If $f(X) equiv 0 mod p$ has a solution, we take $alpha_1 in ZZ_p, f(alpha_1) equiv 0 mod p$.
- If $f(X) equiv 0 mod p^2$ has a solution, we take $alpha_2 in ZZ_p$ such that $f(alpha_2) equiv 0 mod p^2$ and $alpha_2 equiv alpha_1 mod p$.
- By continuing this process, assume that $exists alpha_n in ZZ_p$ such that $f(alpha_n) equiv 0 mod p^n$ and $alpha_n equiv alpha_(n-1) mod p^(n-1)$.
Therefore, $(a_n)_(n in NN)$ is a sequence of elements in $ZZ_p$. By $alpha_n equiv alpha_(n-1) mod p^(n-1)$, we get that the sequence $(alpha_n)_(n in NN)$ is Cauchy, thus there exists $alpha = lim_(n -> infinity) alpha_n in ZZ_p$, and from the condition $f(alpha_n) equiv 0 mod p^n$ we get $lim_(n -> infinity) f(alpha_n) = 0 = f(alpha)$.

#lem(count: false, name: "Hensel")[
  Let $f(X) in ZZ_p [X]$ be a polynomial, let $alpha_0 in ZZ_p$ with $ Phi_p (f(alpha_0)) < Phi_p (f'(alpha_0))^2 $ or equivalently $ "ord"_p (f(alpha_0)) > 2 dot.c ord_P (f'(alpha_0)) \
  => ord_p (f(alpha_0)) > 0 => f(alpha_0) equiv 0 mod p $
  Then $exists alpha in ZZ_p$ such that $f(alpha) = 0$ and $Phi_p (alpha - alpha_0) <= Phi_p ((f(alpha_0))/(f'(alpha_0)))$.
]

#nte[
  If $f(X) in ZZ[X]$ and $alpha_0 in ZZ$ such that $f(alpha_0) equiv 0 mod p$ and $f'(alpha_0) equiv.not 0 mod p$. Thus, there exists $alpha in ZZ_p$ such that $f(alpha) = 0$.

  *In Fact:*
  $f(alpha_0) equiv 0 mod p => ord_p (f(alpha_0)) >= 1 => Phi_p (f(alpha_0)) <= c$. $f'(alpha_0) equiv.not mod p => ord_p (f'(alpha_0)) = 0 => Phi_p (f'(alpha_0)) = 1 => Phi_p (f(alpha_0)) < Phi_p (f'(alpha_0))^2 = 1 => exists alpha in ZZ_p, f(alpha) = 0$ by Hensel's lemma.
]

#exm(count: false)[
  - $K = QQ(sqrt(-13)) = QQ[X] \/ (X^2 + 13)$, $f(X) = X^2 + 13, f'(X) = 2 X$ and $p = 7$. Then $f(1) = 14 equiv 0 mod 7$ and $f'(1) = 2 equiv.not 0 mod 7$ then $exists alpha in ZZ_7, f(alpha) = 0 => X^2 + 13 = (X-alpha)(X+alpha)$ and we have $ K times.o_QQ QQ_7 equiv (QQ_7 [X]) / ((X^2 + 13)) equiv (QQ_7 [X]) / ((X-alpha)) times (QQ_7 [X]) / ((X+alpha)) equiv QQ_7 times QQ_7 $
  #exr[
    Compare it with $7 dot.c O_k$ using Kummer-Dedekind criteria.
  ]

  - When is $alpha in ZZ_2$ a square ?
    - $alpha = 13, f(X) = X^2 - 13, f'(X) = 2 X$
      - $mod 2: f(1) equiv -12 equiv 0 mod 2, f'(1) equiv 2 equiv 0 mod 2$.
      - $mod 8: f(X) = X^2 - 13$ has no solution thus there is no solution over $ZZ_2$.
    - $alpha = 17, f(X) = X^2 - 17, f'(X) = 2 X$
      - $mod 2: f(1) equiv -16 equiv 0 mod 2, f'(1) equiv 2 equiv 0 mod 2$.
      - $mod 8: f(1) equiv 0 mod 8 => Phi_p (f(1)) <= c^3$, $f'(1) equiv 2 equiv.not 0 mod 8$ then $Phi_p (f'(1)) = c$, $exists alpha in ZZ_2, f(alpha) = 0$.

  - Consider $f(X) = X^3 - X^2 - 2X - 8$ then $f'(X) = 3X^2 - 2X - 2$, we want to know how to factor $f(X)$ in $QQ_2 [X]$
    + $f(X) equiv 0 mod 16$ has $5$ solutions which are $4, 6, 7, 12, 14$.
      + for $alpha = 7, Phi_2 (f(7)) = c^3, Phi_2 (f'(7)) = 1$ then there exists $alpha in ZZ_2$ such that $f(alpha_1) = 0$.
      + for $alpha = 6, 12$ we have $phi_2 (f(alpha)) = c^5, phi_2 (f'(alpha)) = c$ thus $exists alpha_2, alpha_3 in ZZ_2, f(alpha_2) = f(alpha_3) = 0$.
      + Over $QQ_2$ we have $3$ different roots so $
          f(X) = (X - alpha_1) (X - alpha_2) (X - alpha_3)
        $ and hence $K times.o QQ_2 equiv Q_2 times Q_2 times Q_2 => 2 dot.c O_k = frak(p)_1 frak(p)_2 frak(p)_3$.
    Assume that $exists O in O_k$ st that $2 divides.not [O_k: ZZ[O]]$, we can read the factorization of $ZZ$ from the real modulo $ZZ$ of $min_O (X)$. However, $min_O (x)$ cannot have three different linear factors over $FF_2 [X]$ ($X$ and $X+1$ are the only linear factors).
]

#lem(count: false)[
  Suppose that $f(X) in ZZ_p [X]$ is monic, if modulo $overline(f) (T) = overline(g)(T) dot.c overline(h)(T) mod p$ with $overline(g)(T), overline(h)(T) in FF_p [T]$ coprime, then $exists g(T), h(T) in ZZ_p [T]$ such that $f(T) = g(T) dot.c h(T)$ with $deg (g) = deg(overline(g)), g(T) equiv overline(g)(T) mod p, deg(h) = deg(overline(h)), h(T) equiv overline(h)(T) mod p$.
]

#exm[
  - The coprime assumption cannot be removed, by taking $f(T) = T^2 - 3$ over $ZZ_3 [T]$. We have $overline(f)(T) = T^2 = T dot.c T$ but $f(T)$ is irreducible in $ZZ_3 [T]$ (show that it has no solution modulo $9$).
  - $f(X) = X^6 - 6 X^5 - 8 X^4 - 6 X - 10$. By reducing on $ZZ_3$ we have $overline(f)(X) = X^6 + X^4 + X^2 - 1 = (X^3 - X + 1)(X^3 - X - 1) = overline(g)(X) overline(h)(X)$, then $overline(g)(X), overline(h)(X)$ are coprime, and they are irreducible. Thus, by Hensel's lemma, we have that $f(X) = g(X) h(X)$ with $deg(g) = deg(H) = 3$ with $g(X)$ and $h(X)$ are irreducible since they are of degree $3$ and they don't have any root.
]
