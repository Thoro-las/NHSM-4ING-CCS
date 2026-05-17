#import "@preview/wrap-it:0.1.1": wrap-content
#import "@preview/commute:0.3.0": *

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Algebraic\ Number Theory],
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This course is presented by Pr. CAMPAGNA Francesco and Pr. STEVENHAGEN Peter.]
  )
)

#let card = math.op("#")

#chapter[Introduction][]

- *Problem 1:* Find all prime numbers $p in NN$, such that $exists x, y in ZZ, p = x^2 + y^2$. For small values we have
  #align(center, table(
    columns: 2,
    $p$, $(x, y)$,
    $2$, $(1, 1)$,
    $3$, $crossmark$,
    $5$, $(1, 2)$,
    $7$, $crossmark$,
    $11$, $crossmark$,
    $13$, $(2, 3)$
  ))

  We have the following observation, if $p != 2$ then $p = x^2 + y^2$ then $p equiv 1 mod 4$, which is true since $x^2 + y^2 equiv 0, 1, 2 mod 4$ and since $p$ is an odd prime then necessarily $p equiv 1, 3 mod 4$ hence $p equiv 1 mod 4$.

  Now the question is if the other implication, if $p equiv 1 mod 4$ then is it necessary that $p = x^2 + y^2$. If we consider the equation $p = x^2 + y^2$ in the Gaussian integers $ZZ[i]$, then we have that $p = (x + i y) (x - i y)$. $ZZ[i]$ is a Euclidean domain (if we consider $alpha = beta q + r$, we can rewrite it as $abs(alpha\/beta - q) = abs(r\/beta) < 1$, the disks with radius $1$ around each points of the lattice $ZZ[i]$ cover the whole space) and thus it is a principal ideal domain, so $alpha$ factors into irreducibles. Looking at $FF_p^star$, we have that $-1 in FF_p^star$ has order $2$, if $p equiv 1 mod 4$ then there exists an element $x in ZZ, x^2 equiv -1 mod p$, $p | x^2 + 1 = (x + i) (x - i)$ in $ZZ[i]$ but $p divides.not x + i$ and $p divides.not x - i$ thus $p$ is not irreducible in $ZZ[i]$, thus $p = pi dot.c pi'$ with $pi$ irreducible, we have $p = N(p) = N(pi dot.c pi') = N(pi) N(pi') => N(pi) | p^2$, if $N(pi) = 1$ then $pi in i^NN$ which is not the case, hence $N(pi) != 1$ and the same for $N(pi')$, thus $N(pi) = p$, since $pi = a + b i$ then $p = N(pi) = a^2 + b^2$.

- *Problem 2:* Find all integer solutions of the equation $y^3 = x^2 + 1$. By considering it on $ZZ[i]$ we have the equivalent equation $y^3 = (x-i)(x+i)$, $(x-i)$ and $(x+i)$ are coprime given that if there is $pi in ZZ[i]$ such that it divides them both, then it divides the difference $pi | 2i => pi | 2$, and thus from the equation $2 | y => 8 | y^3$ thus $x^2 equiv -1 mod 8$ which is impossible, thus $x-i$ and $x+i$ are coprime. In an UFD, if $a, b$ coprime and $a b = gamma^2$ then $a, b$ are squares up to a unit, we have that $x+i = (a + b i)^3 = a^3 + 3 a^2 b i - 3 a b^2 - b^3 i  = (a^3 - a b^2) + (3a^2 b - b^3)i => x = a^3 - a b^2, 1 = 3 a^2 b - b^3$, from the second equation we have that necessarily $b^2 = 1$, replacing it back we have that if $b = 1$ then $3 a^2 - 1 = 1 => a^2 = 2/3$ which is impossible, if $b = -1$ then $a = 0$ and thus $x = 1$, therefore, the only solutions there are in this case is $(x, y) = (0, 1)$.

- *Problem 3:* Solve the Diophantine equation $y^3 = x^2 + 19$. By doing the same process as earlier, we have that $y^3 = (x + sqrt(-19))(x - sqrt(-19))$ in $ZZ[sqrt(-19)]$ which is a number ring, lets imagine that $ZZ[sqrt(-19)]$ has the same properties as $ZZ[i]$, by the same way we can have that $x - sqrt(-19)$ and $x + sqrt(-19)$ are coprime, thus we deduce that $x + sqrt(-19) = (a + b sqrt(-19))^3 u$, we define the norm $N: ZZ[sqrt(-19)] -> NN, a + b sqrt(-19) |-> a^2 + 19 b^2$, we have that the units satisfy that $N(u) = 1$ thus we deduce $N(u) = a^2 + 19 b^2 = 1$ which gives necessarily $u = plus.minus 1$, then we have that $x + sqrt(-19) = (a + b sqrt(-19))^3 = (a^3 - 3 dot.c 19 a b^2) + (3 a^2 b - 19 b^3) i$, by identification and enumerating the cases for $b = plus.minus 1$, we have that $3 a^2 = 20$ which is impossible, and $a^2 = 6$ which is impossible too, thus there are no solutions. But notice that $7^3 = 18^2 + 19$ is a solution, which is contradictory, which comes from the fact that we assumed $ZZ[sqrt(-19)]$ has the properties $ZZ[i]$, but $ZZ[sqrt(-19)]$ is not even a UFD since $35 = 5 dot.c 7 = (4 + sqrt(-19))(4 - sqrt(-19))$, we can take a better ring that contains $ZZ[sqrt(-19)]$, which is $ZZ[sqrt(-19)] subset ZZ[(1 + sqrt(-19))/2]$ called the ring of integers of $QQ(sqrt(-19))$.
  #exr[
    Show that this implies that the only solutions for $y^3 = x^2 + 19$ are $y = 7$ and $x = plus.minus 18$.
  ]
  But it is not necessary in general that the ring of integers of a number field is a UFD. But, it has a unique factorization of prime ideals in rings of integers. Not all ideals are principal.

- *Problem 4:* Pell equation, let $d > 0$ consider the equation $x^2 - d y^2 = 1$, again, we take it in $ZZ[sqrt(d)]$, $(x + sqrt(d) y) (x - sqrt(d) y) = 1$, the norm $x + sqrt(d) |-> x^2 - d y^2$, thus the problem of finding solutions to the Pell equation is equivalent to finding the units of the norm, almost all, if we take for example $d = 3$, we have that $x^2 - 3 y^2 = -1$ is impossible since $mod 4$ we obtain $x^2 + y^2 equiv 3 mod 4$, therefore in this case, we have that the set of solutions is exactly the units. Since $(2, 1)$ is a solution then $2 + sqrt(3) in ZZ[sqrt(3)]^star$ and thus it has infinitely many units so infinitely many solutions, we have that $chevron.l -1 chevron.r times chevron.l 2 + sqrt(3) chevron.r subset ZZ[sqrt(3)]^star$, more specifically, $chevron.l -1 chevron.r times chevron.l 2 + sqrt(3) chevron.r = ZZ[sqrt(3)]^star$.

  #thm(name: "Dirichlet Unit Theorem", count: false)[
    For any quadratic ring $ZZ[sqrt(d)]$, with $ZZ[sqrt(d)]^star = chevron.l -1 chevron.r times chevron.l epsilon_d chevron.r$ where $epsilon_d$ is a fundamental unit with infinite order.
  ]

#exr(ovcount: false)[
  Let $p equiv 1 mod 4$ prime, show that $y = ((p-1)/2)!$ satisfies $y^2 equiv -1 mod p$.
]

#exr(ovcount: false)[
  + Show that $ZZ[sqrt(-2)]$ is a Euclidean domain, $N: a + b sqrt(-2) |-> a^2 + 2 b^2$.
  + Find the solutions for $y^3 = x^2 + 2$.
]

#exr(ovcount: false)[
  Show that for $k in ZZ$ the sum of two integer squares if and only if $forall p | k, p equiv 3 mod 4$ then $p$ appears with even exponent in the factorization of $n$.
]

Consider the ring $R = ZZ[(1+sqrt(-19))/2] = ZZ[alpha]$, it is not a Euclidean domain, that is, any function $h: R\\{0} -> ZZ_(>=0)$ that satisfies $forall a, b in R, exists! q, r in R, a = b q + r, r = 0 or h(r) < h(b)$. Suppose by contradiction that $h$ exists, we have the minimal polynomial of $alpha$ is $f(X) = X^2 - X + 5$, to find $R^star$ we consider the norm on $R$ as $N: R -> ZZ, a + b alpha |-> a^2 + 2a b + 5 b^2$, $x in R^star <=> N(x) = 1 <=> (a+b)^2 + 4b^2 = plus.minus 1 <=> a = plus.minus 1, b = 0$ thus $R^star = {plus.minus 1}$. Now take $x in R \\ (R^star union {0})$, with $h(x)$ minimal, look at $R\/(x R)$, notice that by the Euclidean division, we get a surjection $R ->> R\/x R$. For any $beta in R, exists q, r in R, beta = q x + r$, if $r = 0$ then $overline(beta) = 0 in R\/x R$, else if $r != 0$ then $h(r) < h(x)$ hence $r in R^star, overline(beta) = overline(r) in R\/x R$. Therefore, $R\/x R tilde.equiv {overline(0), overline(r)} => card (R \/ x R) <= 3 => R \/ x R$ is either $FF_2$ and $FF_3$, we have that $overline(alpha) in R\/x R$, $overline(alpha)^2 - overline(alpha) + 5 = 0$ but $f(X)$ is irreducible in $FF_3 [X]$.

#chapter[Number Fields][]

#def(name: "Number Field", ovcount: false)[
  A field $K$ is said to be a number field if the extension $K\/Q$ is finite.
]

#def(name: "Number Ring", ovcount: false)[
  Any subring of a number field is said to be a number ring.
]

#thm(ovcount: false)[
  For any number field $K$, there exists a primitive element $alpha$, such that $K = QQ(alpha) = QQ[X]\/(f)$ with $f$ the minimal polynomial of $alpha$.
]

#exm[
  + Quadratic extensions of $QQ$: the primitive element is canonical, $[K:QQ] = 2$ then there exists a unique square free integer $d$ such that $K = QQ(sqrt(d))$.
  + Cyclotomic extensions: Let $QQ subset overline(QQ)$ an algebraic closure of $QQ$, fix $n in NN_(>0)$, and we take the roots of unity $X^n - 1$ in $overline(QQ)$, there are $n$ of them, and $mu_n$ is a cyclic group of order $n$, any generator is called a primitive $n^"th"$ root of unity $zeta_n$, their minimal polynomial is called the $n^"th"$ cyclotomic polynomial $Phi_n in ZZ[X]$, that is $
    Phi_n (X) = product_(zeta_n "primitive") (X - zeta_n) in overline(QQ)[X]
  $ and we have that $deg Phi_n = phi(n) = card(ZZ\/n ZZ)^star$.
  #align(center, table(
    columns: 2,
    align: (center, left),
    $n$, $Phi_n (X)$,
    $1$, $X-1$,
    $2$, $X+1$,
    $3$, $X^2 + X + 1$,
    $4$, $X^2 + 1$,
    $5$, $X^4 + X^3 + X^2 + X + 1$,
    $6$, $X^2 - X + 1$,
    $7$, $X^6 + X^5 + dots.c + X + 1$,
    $8$, $X^4 + 1$,
    $9$, $X^6 + X^3 + 1$,
    $10$, $X^4 - X^3 + X^2 - X + 1$
  )) Notice that if $n$ is prime then $Phi_n (X) = X^(n-1) + dots.c + X + 1$, also, all the coefficients of $Phi_n$ are $plus.minus 1$. But it is false, the first counterexample is $Phi_(105)$ because $105 = 3 dot.c 5 dot.c 7$.
]

#section[Galois Theory]
#def(name: "Galois Extension", ovcount: false)[
  Let $K$ be a field extension of $QQ$, we say that $K \/ QQ$ is a Galois extension if the minimal polynomial of any $alpha in K$ splits in $K[X]$, equivalently, $K$ is splitting field of a polynomial $P in QQ[X]$.
]

#exm[
  + Quadratic extensions are Galois.
  + Cyclotomic extensions are Galois given that it is the splitting field of $X^n - 1$.
  + $QQ subset QQ(root(5, 2))$, is not Galois since $QQ(root(5, 2)) subset RR$ but there are complex roots of $X^5 - 2$.
]

#thm(name: "Galois Theorem", ovcount: false)[
  Let $K\/QQ$ be a Galois extension, there is an inclusion reversing bijection: $
    {"subfield of" K} &<--> &&{"subgroups of" "Gal"(K\/QQ)}\
    L &-> && "Gal"(K\/L)\
    K^H & <- && H
  $ where $
    "Gal"(K\/QQ) &= {sigma: K -> K "automorphism" | sigma|_(QQ) = id|_(QQ)}\
    K^H &= {x in K | forall sigma in H, sigma(x) = x}
  $ and we have that $[L:QQ] = ("Gal"(K\/QQ):"Gal"(K\/L))$, $|H| = [K:K^H]$ and we have that $H$ is normal in $"Gal"(K\/QQ)$ if and only if $K^H$ is Galois.
]

#exm[
  + Consider $K = QQ(root(3, 5), zeta_3)$, we have that $[K:QQ] = 6$, it is Galois since it is the splitting field of $X^3 - 5$ over $QQ$, we have then $card "Gal"(K\/QQ) = 6$, we compute the elements of $"Gal"(K\/QQ)$, we have 
    #align(center, grid(
      columns: 2,
      column-gutter: 2cm,
      align: center + horizon,
      $
        sigma&: cases(
          root(3, 5) &|-> zeta_3 root(3, 5),
          zeta_3 &|-> zeta_3
        )\
        sigma^2&: cases(
          root(3, 5) &|-> zeta_3^2 root(3, 5),
          zeta_3 &|-> zeta_3
        )
      $,
      $
        tau&: cases(
          root(3, 5) &|-> root(3, 5),
          zeta_3 &|-> zeta_3^2
        )\
        tau^2&: cases(
          root(3, 5) &|-> zeta_3 root(3, 5),
          zeta_3 &|-> zeta_3^2
        )\
        tau^3&: cases(
          root(3, 5) &|-> zeta_3^2 root(3, 5),
          zeta_3 &|-> zeta_3^2
        )
      $
    ))
    It is easy to calculate that $sigma tau != tau sigma$, thus $"Gal"(K\/QQ) = S_3$.
  + *Cyclotomic Fields:* Let $zeta_n$ be a primitive element of unity. Let $f in "Gal"(QQ(zeta_n)\/QQ)$, then $f: zeta_n |-> zeta_n^a$ with $gcd(a, n) = 1$, and we have that $
      "Gal"(QQ(zeta_n)\/QQ) &-> (ZZ\/n ZZ)^star\
      (zeta_n |-> zeta_n^a) &|-> a mod n
    $ an isomorphism, for example taking $n = 7$, we have that $"Gal"(QQ(zeta_7)\/QQ) = (ZZ\/7ZZ)^star = C_6$, thus there are two subgroups $C_2$ and $C_3$, which correspond to the subfields $QQ(zeta_7 + zeta_7^(-1))$ and $QQ(zeta_7 + zeta_7^2 + zeta_7^4)$ respectively. We have that $[QQ(zeta_7 + zeta_7^2 + zeta_7^4):QQ] = 2$ thus $QQ(zeta_7, zeta_7^2 + zeta_7^4) = QQ(sqrt(d))$, to find $d$, we consider the action of $zeta_n |-> zeta_n^(-1)$ on $zeta_7 + zeta_7^2 + zeta_7^4$ and we get $"Min"(zeta_7 + zeta_7^2 + zeta_7^4) = (X - (zeta_7 + zeta_7^2 + zeta_7^4))(X - (zeta_7^3 + zeta_7^5 + zeta_7^6)) = X^2 - X + 2$ by having the heart to calculate it.
]

#section[Ideals In Number Rings]

#def(name: "Operations On Ideals", ovcount: false)[
  Let $R$ be a ring and $I, J$ be ideals.
  - Addition: $I + J = {x + y | x in I, y in J}$.
  - Multiplication: $I J = {sum x_i y_i | x_i in I, y_i in J}$
]

#exm[
  - Let $R = ZZ[sqrt(-5)]$ and $I = (2, 1 + sqrt(-5))$, we have #h(1fr) $
      I^2 &= (2, 1 + sqrt(-5)) (2, 1 + sqrt(-5))\
      &= (4, 2(1 + sqrt(-5)), -4 + 2 sqrt(-5))\
      &= (4, 2 + 2 sqrt(-5), 6) = (2)
    $ but $I$ is not principal, suppose by contradiction that there exists $alpha = a + b sqrt(-5) in R$ such that $I = (alpha)$, we have that $(2) = I^2 = (alpha)^2 = (alpha^2)$ thus $(2) = (alpha^2) => alpha^2 = 2 u$ with $u in R^star = {plus.minus 1}$, so $alpha^2 = plus.minus 2 => (a + b sqrt(-5))^2 = a^2 - 5 b^2 + 2 a b sqrt(-5) = plus.minus 2 => a b = 0 => a = 0$ or $b = 0$ which is a contradiction.
]

#def(name: "Coprime Ideals", ovcount: false)[
  Let $R$ be a ring and $I, J$ be two ideals, we say that $I$ and $J$ are coprime if $I + J = R$.
]

#exm[
  - If $I = (x)$ and $J = (y)$ then $I + J = R <=> exists a, b in R, a x + b y = 1$.
  - If $I, J$ are coprime then for any $n >= 1, I^n, J^n$ are coprime. Let $I, J$ coprime, then $R = I + J => R = R^(2 n) = (I + J)^(2n)$ which is equal to
    $
      underbrace(I^(2n), subset I^n) + dots.c + underbrace(I^(n+1) J^(n-1), subset I^n) + underbrace(I^n J^n, subset I^n + J^n) + underbrace(I^(n-1) J^(n+1), subset J^n) + dots.c + underbrace(J^(2n), subset J^n) subset I^n + J^n
    $ thus $R = I^n + J^n$ so $I^n, J^n$ are coprime.
]

#thm(ovcount: false)[
  Let $I, J, Z$ be ideals of $R$, $I$ and $J$ are coprime, suppose that $I J = Z^n$ then we have that $I = (I + Z)^n$ and $J = (J + Z)^n$.
]

_Proof sketch:_ $(I+Z)^n = I^n + I^(n-1) Z + dots.c + Z^n = I(I^(n-1) + I^(n-2) Z + dots.c + Z^(n-1) + J) = I R = I$.

#exm[
  Consider $R = ZZ[-19]$, we have $(18 + sqrt(-19))(18 - sqrt(-19)) = 7^3$ then $(18 + sqrt(-19))_R (18 - sqrt(-19))_R = (7)_R^3$, we have then $
    (18 + sqrt(-19)) &= [(18 + sqrt(-19)) + (7)]^3 = (18 + sqrt(-19), 7)^3
  $ which is not principal.
]

#subsection[Fractional Ideals]
Let $R$ be a number ring, and $K = "Frac"(R)$ the field of fractions or $R$.

#def(name: "Fractional Ideal", ovcount: false)[
  Let $I subset K, I != {0}$, we say that $I$ is fractional if it an additive subgroup of $K$ that satisfies:
  - $forall r in R, r I subset I$. (Ideal of $R$)
  - $exists x in K^star, x I subset R$.
]

#exm[
  + Ideals of $R$ are fractional ideals (integral ideals).
  + $forall x in K^star, x R = (x)_R$ is a fractional ideal (principal fractional ideals).
  + Take $R = ZZ[sqrt(-5)]$, $I = R + R (1+sqrt(-5))/2$ is a fractional non-principal ideal.
]

#def(name: "Ideal Quotient", ovcount: false)[
  Let $I, J$ be two fractional ideals of $R$, we define the quotient of $I$ over $J$ as $
    I:J = {x in K mid(|) x J subset I}
  $ 
]

#pro(ovcount: false)[
  Let $I, J$ be two fractional ideals of $R$, then $I:J$ is also a fractional ideal of $R$.
]

#prf[
  $(I:J) != {0}$ since if we take $a in I \\ {0}$ and $b in K^star: b J subset R$ then $a b J subset a R subset I => a b in (I:J)$. It is clear that it is an additive subgroup of $K$. Take $x in (I:J)$ we have that $x J subset I => r x J subset r I subset I => r (I:J) subset (I:J)$. Let $c in K^star$ such that $c I subset R$, and $d in J\\{0}$, take $x in (I:J), c d x in R, d x in I => c d x in R => c d (I:J) subset R$. Thus, $(I:J)$ is a fractional ideal.
]

#def(name: "Inverse/Multiplier Ring", ovcount: false)[
  Let $I$ be a fractional ideal, then
  - Inverse ideal: $I^(-1) = R:I &= {x in K | x I subset R}$
  - Multiplier ring: $r(I) = I:I &= {x in K | x I subset I}$
]

#pro(ovcount: false)[
  Let $R$ be a ring and $I$ a fractional ideal of $R$.
  - $I I^(-1) subset R$.
  - If $I = (a)$ then $I^(-1) = (a^(-1))$ and $I I^(-1) = R$.
  - The multiplier ring $r(I)$ is a subring of $K$.
]

#ooc[
  #prf[
    - $forall x in I^(-1), x I subset R => I^(-1) I = I I^(-1) subset R$.
    - Suppose $I = (a) = a R$, let $x in I^(-1)$ then $x a R = x I subset R <=> x a R subset R <=> x R subset a^(-1) R <=> x in a^(-1) R$ and hence $I^(-1) = a^(-1) R = (a^(-1))$, also, $I I^(-1) = (a R) (a^(-1) R) = a a^(-1) R = R$.
    - Do it.
  ]
]


#exm[
  Notice that in general, we do not necessarily have that $I I^(-1) = R$. Consider $R = ZZ[sqrt(5)]$ and $I = (2, 1 + sqrt(5))$, we claim that $I I^(-1) != R$. Suppose that $I I^(-1) = R$, we have $
      I^2 = (4, 6 + 2 sqrt(5), 2 + 2 sqrt(5)) = (4, 2 + 2 sqrt(5)) = 2 (2, 1 + sqrt(5)) = 2 I
    $A, multiplying both sides by $I^(-1)$ we get $I = I R = (2)$ then $I$ is principal, but we have that $I$ is indeed not principal, contradiction, so $I I^(-1) != R$.
]

#def(name: "Invertible Ideal", ovcount: false)[
  A fractional ideal $I$ is said to be invertible if $I I^(-1) = R$. The set of invertible ideals is denoted $I(R)$.
]

#pro(ovcount: false)[
  $I(R)$ forms a group under ideal multiplication.
]

#subsection[Factoring Into Prime Ideals]
Let $n in ZZ$, from the fundamental theorem of arithmetic, we have that $n$ can be decomposed into $n = product_i p_i^(e_i)$ unique up to units and order. We can deduce that $(n) = product_i (p_i)^(e_i)$. The question now is by considering any ideal $I subset R$, can we decompose in a similar way the ideal $I$ into a product $I = product frak(p)_i^(e_i)$ where $frak(p)_i$ are prime ideals.

#exr(ovcount: false)[
  Let $R$ be a number ring, and let $I != {0}$ be an ideal of $R$, prove that $I$ contains a positive integer.
]

#ooc[
  Let $alpha in I \\ {0}$, given that $alpha in R$ then $alpha$ is algebraic over $QQ$, then there exists $(a_i)_(i=1)^n in ZZ, a_n alpha^n + dots.c + a_1 alpha + a_0 = 0$, moving elements around we get $
    a_n alpha^(n) + dots.c + a_1 alpha = - a_0
  $ we have that the LHS is in the ideal since $(alpha) subset I$, and thus $- a_0 in I => |a_0| in I$, and $|a_0|$ is a positive integer.
]

Let $R$ be a number ring and $I != {0}$ an ideal of $R$, and take a prime ideal $frak(p)_i$ such that $I subset frak(p)_i$, from the exercise we have that there exists $n in I$ thus $n in frak(p)_i$ but $frak(p)_i$ is prime then it contains a prime number $p_i$ therefore $frak(p)_i inter ZZ = p_i ZZ$.

#thm(ovcount: false)[
  Every ideal $I$ in a number ring $R$ has finite index.
]

#ooc[
  #prf[
    Let $R$ be a number ring and $K = "Frac"(R)$ a number field, $[K:QQ] = t$. From the exercise, we have that there exists a positive integer $a in I$. We have that $(a) subset I$, then there exists a surjective map $R\/a R ->> R\/I$, thus it is enough to prove that $R\/a R$ is finite.

    #lem(count: false)[
      Let $G$ be a group, such that any finitely generated subgroup of $G$ is of order at most $n$, then $G$ is a finite of order at most $n$.
    ]

    Let $M$ be a finitely generated subgroup of $R$ as an additive group. $M$ has no elements of finite order given that $"char"(R) = "char"(K) = 0$, thus $M$ is a free abelian group, and since $[K:QQ] = t$ then $"rank"(M) <= t$. Any finitely generated subgroup of $R\/a R$ is the image of a finitely generated subgroup of $R$ by the surjection $R ->> R\/a R$, and thus any finitely generated subgroup of $R\/a R$ has order $a^k <= a^t$, thus we conclude that $R\/a R$ has finite order.
  ]
]

#colbreak()
#cor(ovcount: false)[
  Every prime ideal of a number ring is maximal.
]

#ooc[
  #prf[
    Let $frak(p)$ be a prime ideal of $R$, we have that $R\/frak(p)$ is finite and an integral domain, thus $R\/frak(p)$ is a field, and thus $frak(p)$ is a maximal ideal in $R$.
  ]
]

In general, prime ideal factorization does not hold even if $I$ is invertible, the problem is the lack of invertibility of prime ideals, which offers two solutions:
+ Avoid non-invertible prime ideals.
+ Find rings $R$ where every prime ideal is invertible (Dedkind rings).

#exr(ovcount: false)[
  + Show that the ideals of $(18 + sqrt(-19))$ and $(18 - sqrt(-19))$ are coprime in $ZZ[sqrt(-19)]$.
  + Show that $(18 + sqrt(-19), 7)$ is a maximal ideal of index $7$ in $ZZ[sqrt(-19)]$.
  + Show that if $I, J subset R$ are coprime then $I J = I inter J$.
  + Compute $r(I)$ for $I=(2, sqrt(5) + 1)$ in $ZZ[sqrt(5)]$.
  + Show that $I=(2, 1 + sqrt(-5))$ is invertible in $ZZ[sqrt(-5)]$.
  + Show that any ideal $I != {0}$ of a number ring contains a positive integer.
  + Show that a number ring has only finitely many ideals $I$ satisfying for some fixed bound $B$, $card (R:I) <= B$.
]

Let $K$ be a number field, we have that $K = QQ(alpha)$ for some primitive element $alpha$. We have that $ZZ subset QQ$ thus $ZZ subset K$ and $alpha in K$ so $ZZ[alpha] subset K$.

#align(center)[
  #commutative-diagram(
    node-padding: (2cm, 2cm),
    padding: 0.3cm,
    node((0, 1), $QQ$),
    node((0, 0), $ZZ$),
    node((1, 1), $K$),
    node((1, 0), $ZZ[alpha]$),

    arr($QQ$, $K$, $n$, "inj"),
    arr($ZZ$, $ZZ[alpha]$, "", "inj"),
    arr($ZZ[alpha]$, $K$, $subset$),
    arr($ZZ$, $QQ$, $subset$),
  )
]

$ZZ[alpha]^star$ can be infinite, but it is finitely generated, as stated in the Dirichlet unit theorem.

Consider now the field $K = QQ[X]\/(f(X))$ where $f(X) = X^2 + 5$, and the ring $R = ZZ[sqrt(-5)]$, take the ideal $I = (6) = 6 ZZ[sqrt(-5)]$ which we want to factorize, we start by finding all prime ideals $frak(p)$ such that $(6) subset frak(p) subset ZZ[sqrt(-5)]$. We have that $ZZ[sqrt(-5)] = ZZ + ZZ sqrt(-5)$, $
  R\/I = (ZZ + ZZ sqrt(-5))/(6 ZZ + 6 ZZ sqrt(-5)) tilde.equiv (ZZ\/6 ZZ) times (ZZ\/6ZZ)
$ and therefore $card R\/I = 36 = 2^2 dot.c 3^2$, since any ideal of a number field is maximal, then $R\/I$ is a field, we have $4$ possible fields it can be, either a field of order $2, 3, 2^2, 3^2$ so $R\/I$ can have either characteristic $2$, $3$. Suppose that the characteristic is $3$, and consider a morphism from $ZZ[sqrt(-5)]$ to $FF_3$ defined as $phi_3: a + b sqrt(-5) |-> a + b alpha mod 3$, for $phi_3$ to be a ring morphism we need $alpha$ to be a root of $f mod 3$ which is $X^2 - 1 = (X - 1)(X + 1) mod 3$ so we take $alpha = plus.minus 1$, the kernel of those morphisms would give ideals of $ZZ[sqrt(-5)]$ which are $frak(p)_3 = ker (a + b sqrt(-5) |-> a + b mod 3) = (3, 1 - sqrt(-5))$ and $frak(q)_3 = ker (a + b sqrt(-5) |-> a - b mod 3 = (3, 1 + sqrt(-5))$, notice now that $frak(p)_3 frak(q)_3 = (3, 1 - sqrt(-5)) (3, 1 + sqrt(-5)) = (9, 3 + 3 sqrt(-5), 3 - 3 sqrt(-5), 6) = (3)$, now suppose that the field is of characteristic $2$, then $phi_2: a + b sqrt(-5) |-> a + b mod 2$ since $X^2 + 5 = (X + 1)^2 mod 2$, $ker phi_2 = (2, 1 + sqrt(-5)) = frak(p)_2$, we have that $frak(p)_2^2 = (4, 2 + 2 sqrt(-5), -4 + 2 sqrt(-5)) = (2)$. We have that $6 = 2 dot.c 3 => (6) = (2) (3) = frak(p)_2^2 frak(p)_3 frak(q)_3$, notice that we can get other decomposition of $6$ inside of $ZZ[sqrt(-5)]$ by considering other orders of the product of those ideals, for example taking $(6) = frak(p)_2 frak(p)_3 frak(p)_2 frak(q)_3 = (6, 1 + sqrt(-5)) (6, 1 - sqrt(-5))$, so $6$ can be decomposed also into $(1 + sqrt(-5)) (1 - sqrt(-5))$.

#follow-bar[Stevenhagen Course Unfinished]
#chapter[Rings Of Integers][]

#def(name: "Integral Element/Ring Of Integers", ovcount: false)[
  Let $K$ be a number field, and $beta in K$. We say that $beta$ is an integral element in $K$ if there exists a monic polynomial $f in ZZ[T]$ such that $f(beta) = 0$, denote the set of all integral elements of $K$ as $O_K$ which is called the ring of integers.
]

#pro(ovcount: false)[
  Let $x in K$, the following statements are equivalent:
  + $x$ is integral.
  + the minimal polynomial of $x$, $f_(x,QQ)$ is in $ZZ[X]$.
  + there exists a finitely generated subgroup $M subset K$ such that $x M subset M$.
]

#prf[
  - $1. => 2.$ By Gauss lemma.
  - $2. => 3.$ Let $f_(x, QQ) = T^n + a_(n-1) T^(n-1) + dots.c + a_0 in ZZ[T]$, consider $M = ZZ x + ZZ x^2 + dots.c + ZZ x^(n-1)$, we have that $x^n = x x^(n-1) = -a_(n-1) x^(n-1) - dots.c - a_0 in M$ then $x M subset M$.
  - $3. => 1.$ Consider $M = ZZ e_1 + dots.c + ZZ e_n$ with $e_i in K$, by hypothesis, we have that $forall i, x e_i in M$ thus there exists $a_(i, j) in ZZ, x e_i = a_(i, 1) e_1 + dots.c + a_(i, n) e_n$, we can write it in the following way $
      mat(a_(11), dots.c, a_(1 n); dots.v, dots.down, dots.v; a_(n 1), dots.c, a_(n n)) vec(e_1, dots.v, e_n) = x vec(e_1, dots.v, e_n) => (A - x 1_n) vec(e_1, dots.v, e_n) = 0
    $ thus $x$ is a root of characteristic polynomial of $A$, which is monic and has integer coefficients, thus $x$ is integral.
]

#pro(ovcount: false)[
  $O_K$ is a ring.
]

#prf[
  + Let $x, y in O_K$, we want to prove that $x y, x + y in O_K$, let $M = ZZ e_1 + dots.c + ZZ e_m$, $x M subset M$ and $N = ZZ f_1 + dots.c + ZZ f_n$, $y N subset N$. Take $L = sum_(i,j) ZZ e_i f_j$, we have that $(x y) (e_i f_j) = (x e_i) (y f_j) in L$ and thus $x y L subset L$ and $L$ is finitely generated thus $x y in O_K$.
]

Combined with Kummer-Dedekind, we can produce elements in the ring of integers: let $alpha in O_K => ZZ[alpha] subset O_K$, suppose that $frak(p) = (p, g(alpha))$ is singular ($f = g q + p s$, $q(alpha), s(alpha) in frak(p)$), we have that $1/p q(alpha)$ is in the multiplier ring of $frak(p)$: $
  1/p q(alpha) (p R + g(alpha) R) = q(alpha) R + s(alpha) R in frak(p)
$ but notice that $frak(p) = p R + g(alpha) R = alpha (ZZ + ZZ alpha + dots.c + ZZ alpha^(-1) + g(alpha) (ZZ + ZZ alpha + dots.c + ZZ alpha^(n-1)) subset frak(p)$

#exm[
  + Let $K = QQ(alpha)$, $alpha = root(3, 10)$, $f_(alpha) = X^3 - 10 => alpha in O_K => ZZ[alpha] subset O_K$. $Delta f_alpha = - 3^3 dot.c 2^2 dot.c 5^2$
    - $p = 2$: $f_alpha mod 2 = X^3 -> frak(p)_2 = (2, alpha)$ and $2^2 divides.not 10 => frak(p)_2$ is regular.
    - $p = 5$: $f_alpha mod 5 = X^3 -> frak(p)_5 = (5, alpha)$ which is regular since $5^2 divides.not 10$.
    - $p = 3$: $f_alpha mod 3 = (X - 1)^3 -> frak(p)_3 = (3, alpha - 1)$, $f_alpha (X) = X^3 - 10 = X^3 - 1 - 9 = (X-1)(X^2 + X + 1) - 9 => 3^2 | 9$ and thus $frak(p)_3$ is singular, from Kummer-Dedekind, we have that $beta = (alpha^2 + alpha + 1)/3 in O_K$, we can verify that by calculating the minimal polynomial $f_beta = X^3 - X^2 - 3 X - 3$.
    
    We can deduce from the formula $Delta f = [O_K:ZZ[alpha]]^2 Delta_K$, thus $[O_K:ZZ[alpha]]=3$ and $Delta_K = -3 dot.c 2^2 dot.c 5^2$, we deduce that $ZZ[alpha] subset.neq ZZ[alpha, beta] = O_K$, we claim that $O_K = ZZ[beta]$, by Kummer-Dedekind, we have that $(alpha - 1) beta = 3 => alpha = 3/beta + 1$, from the minimal polynomial of $beta$ we have that $beta (beta^2 - beta - 3) = beta^3 - beta^2 - 3 beta = 3 => beta/3 = beta^3 - beta^2 - 3 beta$ hence $alpha = beta^2 - beta - 2 in ZZ[beta]$.

    We expect that all rings of integers are of the form $ZZ[alpha]$, which is not the case, and we call those who happen to be of that form to be monogenic.
  + Let $K = QQ(alpha)$ with $f_alpha = X^3 - X + 8$, we have that $Delta f_alpha = - 2^2 dot.c 431$, we have that $ZZ[alpha subset O_K$, only possible singular prime is $2$, $f_alpha equiv X (X-1)^2 mod 2 -> frak(p)_2 = (2, alpha)$ and $frak(p)'_2 = (2, alpha - 1)$, $frak(p)_2$ is regular, $f_alpha = X^3 - X + 8 = (X-1) (X^2 + X) + 8$, $2^2 | 8$ then $frak(p)'_2$ is singular. From Kummer-Dedekind we have that $beta = (alpha^2 + alpha)/2 in O_K \\ ZZ[alpha]$ with $f_beta = X^3 - X^2 + 6 X - 8$, from the formula we have that $[O_K:ZZ[alpha]] = 2$ then $ZZ[alpha, beta] = O_K$, the question now is $ZZ[alpha, beta] = ZZ[beta]$ like before?
    - $p = 2$: $f_beta equiv X^2 (X-1) mod 2$, then in $ZZ[beta]$, $2$ primes $frak(q)_2 = (2, beta)$ and $frak(q)'_2 = (2, beta - 1)$, $frak(q)'_2$ is regular, and $frak(q)_2$ is singular, thus $ZZ[beta] != O_K$
  Suppose now that there is $gamma in O_K$ such that $O_K = ZZ[gamma]$, we have that $(alpha - 1) beta = -4 <=> (alpha - 1) beta = 0 in FF_2$, which gives $3$ ring homomorphisms, $(alpha, beta) |-> (1, 0), (alpha, beta) |-> (1, 1), (alpha, beta) |-> (0, 0)$, in fact all possibilities occur: $
    2 O_K = (2, alpha-1, beta) (2, alpha-1, beta-1) (2, alpha, beta)
  $ if by contradiction $O_K$ is monogenic, $O_K = ZZ[gamma]$, it has at most $2$ homomorphisms to $FF_2$ which is a contradiction.
]

#section[Trace And Norm]

#def(name: "Trace/Norm", ovcount: false)[
  Let $K$ a number field and $x in K$, define the map $m_x: K |-> K, alpha |-> x alpha$ which is a $QQ$-linear map.
  - Characteristic polynomial of $x$ is $"char"(m_x) in QQ[X]$.
  - Norm of $x$ is $det(m_x)$, denoted $N_(K\/Q) (x) in QQ$.
  - Trace of $x$ is $tr(m_x)$, denoted $"Tr"_(K\/Q) (x) in QQ$.
]

#pro(ovcount: false)[
  Let $K$ be a number field, let $x in K$ with a characteristic polynomial $"char"(m_x) = T^n + a_(m-1) T^(m-1) + dots.c + a_0$. We have that
  - $N_(K\/Q) (x) = (-1)^m a_0 in QQ$.
  - $"Tr"_(K\/Q) (x) = - a_(m-1) in QQ$.
  - $N_(K\/Q) (x y) = N_(K\/Q) (x) N_(K\/Q) (y)$.
  - $"Tr"(x + y) = "Tr"(x) + "Tr"(y)$.
]

#exm[
  - Let $K = QQ(sqrt(d))$, we have $N_(K\/Q) (a + b sqrt(d)) = a^2 - d b^2$. Lets verify that this agrees with the new definition, $X = a + b sqrt(d)$, consider the basis $(1, sqrt(d))$ then $x dot.c 1 = a + b sqrt(d)$ and $x sqrt(d) = d b + sqrt(d)$ then $m_x = mat(a, d b; b, a)$, which has norm $a^2 - d b^2$, and trace $2 a$.
  - Let $K = QQ(root(4, 2))$, and $x = sqrt(2)$, we have a basis $(1, alpha, alpha^2, alpha^3)$ with $alpha = root(4, 2)$, notice that $x = alpha^2$, we have $
    cases(
      alpha^2 dot.c 1 &= alpha^2,
      alpha^2 dot.c alpha &= alpha^3,
      alpha^2 dot.c alpha^2 &= 2,
      alpha^2 dot.c alpha^3 &= 2 alpha
    ) => m_x = mat(0, 0, 2, 0; 0, 0, 0, 2; 1, 0, 0, 0; 0, 1, 0, 0)
  $ we have that $"char"(x), "char"(m_x) = T^4 - 4 T^2 + 4 = (T^2 - 2)^2$, let now $L = QQ(sqrt(2))$, $x in L$, we have that $"char"(x) = T^2 - 2$.
]

#section[Embeddings]
Let $K$ be a number field, by the primitive root theorem, there exists a primitive element $alpha$ such that $K = QQ(alpha) = QQ[X]\/(f)$ with $f = f_alpha^QQ$. $K$ can be embedded in $CC$ $n=[K:QQ]$ different ways, the embeddings would be of the form $Phi_i: alpha - X mod f |-> alpha_i$ where $alpha_1, dots, alpha_n$ are the complex roots of $alpha$. The $Phi_i$ for which $Phi_i (K) subset RR$ are called real embeddings, and the number of those embeddings is denoted $r$, and the other embeddings such that $Phi_i (K) subset.not RR$ we call them complex embeddings, which come in pairs $Phi_i, overline(Phi_i)$, and we take $s$ the number of pairs of complex embeddings. $(r, s)$ is the signature of $K$.

We can consider all the embeddings at the same time, instead of looking to $QQ[X]\/(f)$, we look for $CC[X]\/(f)$, notice that $QQ[X]\/(f)$ is a field while $CC[X]\/(f)$ is a ring, but notice that in $CC[X]$ we have that $f = product (X - alpha_i)$, thus by the CRT we have that $CC[X]\/(f) tilde.equiv product_(i=1)^n CC[X]\/(X - alpha_i) tilde.equiv product_(i=1)^n CC$, thus the injective map from $QQ[X]\/(f) -> product_(i=1)^n CC$ gives $alpha = X mod f |-> (alpha_1, dots, alpha_n) = (phi_1 (alpha), dots, phi_n (alpha)$, denote this map $Phi$$
  Phi: QQ[X]\/(f) &-> product_(i=1)^n CC, quad quad alpha &|-> (Phi_1 (alpha), dots, Phi_n (alpha))
$

#thm(ovcount: false)[
  Let $K$ be a number field and $x in K$.
  - $N_(K\/QQ) (x) = product_(i=1)^n Phi_i (x)$.

  - $"Tr"_(K\/QQ) (x) = sum_(i=1)^n Phi_i (x)$.

  - $"char" (x) = (f_(K, QQ))^([K:QQ(x)])$.
]
