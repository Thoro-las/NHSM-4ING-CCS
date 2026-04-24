#import "@preview/commute:0.3.0": arr, commutative-diagram, node
#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Elliptic Curves],
    writer: "HADIOUCHE Azouaou",
  ),
)

#let card = math.op("#")
#let iso = $tilde.equiv$
#let wp = "℘"

#chapter[Introduction To Elliptic Functions][
  Starting with an ellipse defined by the equation $(x\/a)^2 + (y\/b)^2 = 1$, a natural question of knowing what is the perimeter of the ellipse is. By consider the equation on the first quadrant, we have that it can be parameterized with the curve $ y = f(x) = b sqrt(1-x^2/a^2) $ using this, the symmetry of the ellipse and some changes of variables, we have that the formula for the ellipse perimeter is as follows $ L = 4 integral_0^a sqrt(1 + f'(x)) dif x = 4 integral_0^1 sqrt((1-k^2 t^2)/(1-t^2)) dif t $ notice that the integral is path dependent since $sqrt(dot.c)$ is double-valued, thus we make branch cuts in the values where both the nominator and denominator vanish so $z in {plus.minus 1, plus.minus 1\/k}$. By taking two copies of $PP_CC^1$ and identifying the branch cuts we get a torus. Thus study of the arc-length of an ellipse leads naturally to the study of integrals on a torus which is an elliptic curve.
]

#section[Lattices & Complex Tori]
#def(name: "Lattice")[
  Let $w_1, w_2 in CC$, the complex torus is defined as the set $Lambda = w_1 ZZ + w_2 ZZ$ where $Lambda times.o RR = CC$.
]

#nte[
  We define that $Lambda times.o R = w_1 R + w_2 R$.
]

#ooc[An equivalent definition we can get is to consider $w_1, w_2$ to be linearly independent on $CC$ as an $RR$-vector space.]


#def(name: "Fundamental Parallelogram")[
  Let $Lambda = chevron.l w_1, w_2 chevron.r$ be a lattice, the fundamental parallelogram for $Lambda$ is a set of the form $ D = {a + lambda_1 w_1 + lambda_2 w_2 | lambda_i in [0, 1)} $
]

#def(name: "Complex Torus", count: false)[
  Let $Lambda$ be a lattice, we define the complex torus associated with $Lambda$ as $T:=CC\/Lambda$. We can define the addition on the complex torus as $forall [z_1],[z_2] in T, [z_1] + [z_2] = [z_1 + z_2]$.
]

#nte[
  To simplify notation, we take that the elements of $T$ are just denoted simply as $z$ instead of $[z]$.
]

#pro[
  $(T, +)$ is a commutative group with neutral element $[0]$.
]

#def(name: "Torsion Element")[
  Let $z in Lambda$, $m in ZZ$, $z$ is said to be of $m$-torsion if $m dot.c z = 0$. The set of $m$-torsion elements is denoted $T[m]$.
]

#lem[
  $forall m in ZZ, T[m] iso ZZ\/m ZZ times ZZ\/m ZZ$.
]

#ooc[
  #prf[
    Let $Lambda = chevron.l w_1, w_2 chevron.r$, consider the following map $ phi: ZZ\/m ZZ times ZZ\/m ZZ -> T[m], (a, b) |-> a/m w_1 + b/m w_2 $ it is well-defined since $m ((a\/m) w_1 + (b\/m w_2) = a w_1 + b w_2 = 0$.
    - Let $(a, b), (a', b') in ZZ\/m ZZ times ZZ\/m ZZ$, $phi((a, b) + (a', b')) = (a + a') / m + (b + b') / m = (a + b) / m + (a' + b')/m = phi((a, b)) + phi((a', b'))$ so $phi$ is a morphism.

    - Let $(a, b), (a', b') in ZZ\/m ZZ times ZZ\/m ZZ$, $phi((a, b)) = phi((a', b')) => a / m w_1 + b / m w_2 = a' / m w_1 + b / m w_2 => a = a', b = b' => (a, b) = (a', b')$ so $phi$ is injective.

    - Let $Lambda = chevron.l w_1, w_2 chevron.r$, since $Lambda times.o RR = CC$ then $forall z in CC, z = a w_1 + b w_2$, then if $z in T[m]$, $m z = (m a) w_1 + (m b) w_2 in Lambda$ thus $m a, m b in ZZ$ hence we obtain $(a, b) = (a'\/m, b'\/m)$ with $a', b' in ZZ\/m ZZ$. The map $phi$ is surjective.
  ]
]

#section[Elliptic Functions]

#def(name: "Elliptic Function")[
  Let $f: CC -> CC$ be a meromorphic function, $f$ is said to be an elliptic function relative to $Lambda$ if $ forall z in Lambda, forall x in CC, f(x + z) = f(x). $
]

#def(name: "Order Of Vanishing/Residue")[
  If $f$ admits a Laurent expansion $sum_(n>=k) a_k (z - w)^k$ at $w$ then we define
  - the order of vanishing of $f$ at $w$ as $"ord"_w (f) = k$.
  - the residue of $f$ at $w$ as $"res"_w (f) = a_(-1)$.
]

#def(name: "Pole/Zero")[
  Let $f: CC -> CC$ be a meromorphic function and $sum_(n >= k) a_n (z - w)^n$ its Laurent expansion, then $w$ is called a pole if $k < 0$ and called a zero if $k > 0$.
]

#def(name: "Order Of Elliptic Functions")[
  Let $f: CC -> CC$ be an elliptic function relative to $Lambda$, and $D$ be a fundamental domain for $Lambda$. The order of $f$ is defined as the number of poles of $f$ inside of $D$, $ "ord"(f) = sum_("pole" w in D) "ord"_w (f) $
]

#thm[
  Let $T = CC\/Lambda$ a complex torus and $f$ an elliptic function relative to $Lambda$, the following statements are true:
  + If $f$ has no poles, then it is constant.
  + $sum_(w in T) "res"_w (f) = 0$
  + $sum_(w in T) "ord"_w (f) = 0$.
  + $sum_(w in T) "ord"_w (f) w in Lambda$.
  + If $f$ has no zeros, then it is constant.
  + A non-constant elliptic function has order at least $2$.
]

#nte[TODO: Proof of the theorem]

#def(name: "Function Field")[
  Let $Lambda$ be a lattice, we define the set of elliptic functions relative to $Lambda$ as $CC(Lambda)$, which we call the function field of $Lambda$
]

#section[Divisor Group Of Complex Tori]

#def(name: "Divisor Group")[
  Let $T$ be a complex torus, we define the divisor group of $T$ as the free abelian group generated by the points of $T$ $ "Div"(T) := plus.o.big_(w in T) ZZ dot (w) $
]

#def(name: "Degree Of Divisors")[
  Let $T$ be a complex torus and $D = sum n_w (w) in "Div"(T)$, then the degree of $D$ is $"deg" D = sum n_w$.
]

#def(name: "Degree Zero Divisors")[
  Let $T$ be a complex torus, we define the subgroup $"Div"^0$ of $"Div"$ as the set $ "Div"^0 (T) = {D in "Div"(T) | "deg" D = 0} $
]

#def(name: "Divisor Of Elliptic Functions")[
  Let $T = CC\/Lambda$ a torus and $f in CC(Lambda)^star$ be a non-zero elliptic function with respect to $Lambda$, we define the divisor of $f$ as $ "div" f = sum_(w in T) "ord"_w (f) dot.c (w) $
]

#lem[
  $"div": CC(Lambda)^star -> "Div"^0 (T), f |-> "div" f$ is a group morphism.
]

#ooc[
  #prf[
    The function is well-defined given that $"deg" "div" f = sum_(w in T) "ord"_w (f) = 0$ from the previous theorem, let $w in CC$, $f(z) = sum_(n >= k) a_n (z - w)^n$ and $g(z) = sum_(n >= k') b_n (z - w)^n$, $(f g) (z) = sum_(n >= k + k') sum_(j = 0)^n a_j b_(n - j) (z - w)^n$, $"ord"_w (f g) = k + k' = "ord"_w (f) + "ord"_w (g)$ hence $ "div" (f g) & = sum_(w in T) "ord"_w (f g) dot.c (w) \
                & = sum_(w in T) ("ord"_w (f) + "ord"_w (g)) dot.c (w) \
                & = sum_(w in T) "ord"_w (f) dot.c (w) + sum_(w in T) "ord"_w (g) dot.c (w) \
                & = "div" f + "div" g $
  ]
]

#def(name: "Summation Map")[
  Let $T = CC\/Lambda$ be a torus $ "sum": "Div"^0 (T) & -> T, quad sum n_w (w) & |-> sum n_w w mod Lambda. $
]

#pro[
  The summation map is a well-defined group morphism.
]

#ooc[
  #prf[
    It is clear that the summation map is well defined, consider the divisors $D = sum n_w (w), D' = sum m_w (w) in "Div"^0 (T)$, then we have $ "sum" (D + & D') = "sum" (sum (n_w + m_w) (w)) \
               & = sum (n_w + m_w) w mod Lambda \
               & = sum n_w w + sum m_w w mod Lambda \
               & = (sum n_w w mod Lambda) + (sum m_w w mod Lambda) \
               & = "sum" (D) + "sum" (D') $
    Therefore it is a group morphism.
  ]
]

#thm[
  The following sequence is exact.
  $
    1 --> CC^star --> CC(Lambda)^star -->^"div" "Div"^0 (T) -->^"sum" T --> 0
  $
]

#ooc[
  #prf[
    Consider the maps $1 -->^(i_1) CC^star -->^(i_2) CC(Lambda)^star$ where $i_j$ are the canonical injections since ${1} subset CC^star subset CC(Lambda)^star$ which are clearly morphisms (by abuse of notation we take $CC^star$ to be the set of constant elliptic functions)
    + $"Im" i_1 = { 1 } = "Ker" i_2$.
    + $"Ker" "div" = {f in CC(Lambda)^star | "div" f = 0} = {f in CC(Lambda)^star | forall w in T, "ord"_w (f) = 0} = CC^star = "Im" i_2$.
    + $"Ker" "sum" = {D in "Div"^0 (T) | "sum" D = 0} = {D in "Div"^0 (T) | sum n_w w in Lambda}$

    #nte[
      Unfinished
    ]
  ]
]

#section[The Weierstrass $wp$-Function]

#def(name: [$wp$-Function])[
  Let $Lambda$ be a lattice, the Weierstrass $wp$-function relative to $Lambda$ is defined by the series $ wp(z\; Lambda) = 1/(z^2) + sum_(w in Lambda \\{0}) (1/((z-w)^2) - 1/w^2) $
]

#pro[
  The first derivative of $wp$ is $ wp'(z\; Lambda) = -2 sum_(w in Lambda) 1/((z-w)^3) $
]

#ooc[
  #prf[
    $
      wp'(z\;Lambda) = -2/(z^3) + sum_(w in Lambda \\ {0}) - 2/((z-w)^3) = - 2 sum_(w in Lambda) 1/((z-w)^3).
    $
  ]
]


#def(name: "Eisenstein Series")[
  Let $Lambda in CC$ be a lattice, the Eisenstein series of weights $2 k$ related to $Lambda$ is defined as $ G_(k) (Lambda) = sum_(w in Lambda\\{0}) w^(-k) $
]

#lem[
  - The series $G_(2k+1)$ is $0$ for every $k in NN$.
  - The series $G_(2k) (Lambda)$ is absolutely convergent for $k > 1$.
]

// #prf[
//   The proofs are taken from "_Silverman: The Arithmetic Of Elliptic Curves_". Let $Lambda$ be a lattice, and $D$ is a fundamental parallelogram of $Lambda$, the area of $D$ is necessarily $|w_1||w_2|sin(hat(w_1 w_2))$, by considering the fact that each fundamental parallelogram
// ]

#pro[
  Let $Lambda$ be a lattice and $wp = wp(z\;Lambda)$ the associated Weierstrass $wp$-function, then we have:
  - $wp$ converges uniformly on every compact subset of $CC\\Lambda$.
  - $wp$ is an even elliptic function having a double pole with residue $0$ at $z = 0$ (by periodicity, this is true for every lattice point in $Lambda$) and no other poles.
  - $wp'$ is an odd elliptic curve.
]

#ooc[
  #prf[
    The proofs are taken from "_Silverman: The Arithmetic Of Elliptic Curves_".
    - Let $z in CC$, we have for any $w in Lambda$ with $|w| > 2|z|$ then #h(1fr) $ abs(1/((z-w)^2) - 1/(w^2)) = abs((z(2w - z))/(w^2(z-w)^2)) <= (abs(z) (2 abs(w) - abs(z)))/(abs(w)^2 (abs(w) - abs(z))^2) <= (10 abs(z))/(abs(w)^2) $

    #nte[Uncomplete, yet again]
  ]
]

#thm[
  Let $Lambda$ be a lattice and $wp = wp(z\; Lambda)$, then we have $ CC(Lambda) = CC(wp, wp'). $
]

#thm[
  - The Laurent series of $wp(z)$ at $0$ is given by #h(1fr) $ wp(z) = 1/(z^2) + sum_(n>=1) (2n + 1) G_(2n + 2) z^(2n) $
  - For all $z in CC \\ Lambda$, we have $ wp'(z)^2 = 4 wp(z)^3 - 60 G_4wp(z) - 140 G_6 $
]

#prf[
  - The Laurent expansion of $1/(1-z)$ at $1$ is $sum_(n>=0) z^n$. By differentiation we have that $ 1/((1-z)^2) = sum_(n>=1) n z^(n-1) => 1/((1-z)^2) - 1 = sum_(n>=1) (n+1) z^n $ $ wp(z) & = 1/(z^2) + sum_(w in Lambda \\ {0}) (1/((z-w)^2) - 1/w^2) \
          & = 1/(z^2) + sum_(w in Lambda \\ {0}) 1/(w^2) (1/((1-z/w)^2) - 1) \
          & = 1/(z^2) + sum_(w in Lambda \\ {0}) sum_(n>=1) (n+1) (z^n/w^(2+n)) \
          & = 1/z^2 + sum_(n>=1) (n+1) z^n sum_(w in Lambda \\ {0}) w^(-(2+n)) \
          & = 1/(z^2) + sum_(n >= 1) (n+1) z^n G_(n+2) \
          & = 1/(z^2) + sum_(n >= 1) (2n + 1) z^(2n) G_(2n + 2) $
  - Consider $f(z) = wp'(z)^2 - 4 wp(z)^3 + 60 G_4 wp(z) + 140 G_6$, $f(z)$ is necessarily elliptic since it is a combination of elliptic functions. By examining the first terms of the Laurent expansion, we notice that $f(z)$ vanishes at $0$. Hence, $f$ has no poles and we conclude that $f$ is constant, and since its constant term is $0$ then $f = 0$ so we get $wp'(z)^2 = 4 wp(z)^3 - 60 G_4wp(z) - 140 G_6$.
]

#cor[
  Let $Lambda$ be a lattice $chevron.l w_1, w_2 chevron.r$, set $w_3 = w_1 + w_2$, we have $  "div" wp & = -2 (0) + (w) + (- w) quad "for some" w in D \
  "div" wp' & = -3 (0) + (w_1\/2) + (w_2\/2) + (w_3\/3) $
]

Notice that the couple $(wp(z), wp'(z))$ satisfies the equation $f(x, y) = y^2 - 4 x^3 - g_2 x - g_3$ for any $z$ with $g_2 = -60 G_4, g_3 = -140 G_6$. By a simple change of variable, we can get the equation rewritten in the form $y^2 = x^3 - 4g_2 x - 16 g_3$.

#def(name: [Curve Of $Lambda$])[
  Let $Lambda$ be a lattice, we define the curve $E=E(Lambda) subset AA^2$ given by $ E(Lambda): y^2 = x^3 - 4 g_2 x - 16 g_3 subset AA^2(x, y) $ with the constants $g_2 = - 60 G_4(Lambda)$, $g_3 = - 140 G_6(Lambda)$. We define its projective closure with the same notation as the set $E(Lambda) subset PP^2$ with $ E(Lambda): y^2 z = x^3 - 4 g_2 x z^2 - 16 g_3 z^3 $
]

#lem[
  The curve $E(Lambda)$ is smooth.
]

#thm[
  Let $Lambda = chevron.l w_1, w_2 chevron.r$ be a lattice of $CC$, the following map $ phi: CC\/Lambda &-> E(Lambda)\ z &|-> (wp(z) : wp'(z)\/2 : 1) \ 0 &|-> (0 : 1 : 0) = O_E. $is an isomorphism of Riemann surfaces.
]

#chapter[Isogenies Of Complex Tori][]

#section[Isogenies]
#def(name: "Isogeny")[
  Let $T_1, T_2$ be two tori, a map $phi: T_1 -> T_2$ is said to be an isogeny if it is a morphism of Riemann surfaces and of groups. Denote the set of isogenies from $T_1$ to $T_2$ as $"Hom"(T_1, T_2)$.
]

#ooc[
  #def(count: false, name: "Covering Map/Covering Space")[
    Let $X, tilde(X)$ be topological spaces. A covering map is a continuous map $pi: tilde(X) -> X$ such that $forall x in X, exists U in cal(N)(x), exists {V_alpha}_(alpha in A)$ pairwise disjoint, $pi^(-1) (U) = union.sq.big_(alpha in A) V_alpha$ and $p|_(V_alpha): V_alpha -> U$ is a homeomorphism.
  ]

  This space formalizes the specific notion of covering a space $X$ with sheets which are parts of $tilde(X)$. That is, in a sense, $pi$ acts as a projection of $tilde(X)$ on $X$ sending multiple points of $tilde(X)$ on $X$ as sheets.

  #image("resources/coveringspace.svg", height: 20%)

  #thm(count: false, name: "Path Lifting")[
    Let $pi: tilde(X) -> X$ be a covering map.
  ]
]

#lem[
  Let $T_1$ and $T_2$ be two tori, $pi: CC -> T_i$ the canonical projections, $psi: T_1 -> T_2$ an isogeny, then there exists a unique map $phi: CC -> CC$ up to an additive constant $c in Lambda_2$ such that the following diagram commutes
  #align(center, commutative-diagram(
    node-padding: (2cm, 1.5cm),
    padding: 0.2cm,
    node((0, 0), $CC$, "C1"),
    node((0, 1), $CC$, "C2"),
    node((1, 0), $T_1$),
    node((1, 1), $T_2$),
    arr($T_1$, $T_2$, $psi$),
    arr("C1", "C2", $phi$),
    arr("C1", $T_1$, $pi_1$, label-pos: right),
    arr("C2", $T_2$, $pi_2$),
  ))

  which is equivalent to say that $pi_2 compose phi = psi compose pi_1$.
]

#prf[
  As $psi$ is an isogeny, then it is a group homomorphism so necessarily $psi(0) = 0$, define $phi(0) = 0$. Notice that $pi_2 compose phi (0) = 0 = psi compose pi_1 (0)$. Let $z in CC$ and $tilde(z) in T_1$ such that $pi_1 (z) = tilde(z)$, given that $CC$ is path-connected, we can take a continuous path $gamma: [0, 1] -> CC$ such that $gamma(0) = 0$ nad $gamma(1) = z$. Define the path $tilde(gamma): [0, 1] -> T_2, t = psi compose pi_1 compose gamma (t)$, since $pi_1: CC  -> T_1$ is a covering map then by the path lifting theorem we can lift $tilde(gamma)$ to a path $overline(gamma): [0, 1] -> CC$ such that $pi_2 compose overline(gamma) = tilde(gamma)$, we set $phi(z) = overline(gamma) (1)$.
]
