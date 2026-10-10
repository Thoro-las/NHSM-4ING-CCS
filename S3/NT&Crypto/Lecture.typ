#import "@preview/commute:0.3.0": arr, commutative-diagram, node

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Number Theory & Cryptography",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures given by Dr. ZAIMI.],
    comment: [Some contents were added as remainders and extras for the students.],
  ),
)

#let Id = math.op("Id")
#let Ker = math.op("Ker")
#let Im = math.op("Im")
#let Irr = math.op("Irr")
#let iso = $tilde.equiv$
#let char = math.op("Char")
#let card = math.op("#")
#let Aut = math.op("Aut")
#let order = math.op("ord")
#let disc = math.op("disc")

#chapter[Elliptic Curves][]

#section[Generalities]
- A plane curve is a continuous map $I -> RR^2, t |-> (x(t), y(t))$.
- A plane curve can be defined by an equation of the form $f(x, y) = 0$.
- The equation of the tangent line to the curve given by $f(x, y) = 0$ is #h(1fr) $
  (partial f)/(partial x) (x_0, y_0) (x - x_0) + (partial f)/(partial y) (x_0, y_0) (y - y_0) = 0
$
- A plane curve is said to be algebraic if $f$ is a polynomial.
- An algebraic curve is said to be smooth if it has a tangent line at any point.
- We can consider the field to be $K$ with zero characteristic or finite field with characteristic not $2$ or $3$.

#def(name: "Elliptic Curve")[
  An elliptic curve $E$ is defined as a graph of an algebraic smooth curve defined by $
    E: f(x, y) = (y^2 + a_1 x y + a_3) - (x^3 + a_2 x^2 + a_4 x + a_6) = 0
  $ with $a_1, a_2, a_3, a_4, a_6 in K$.
]

By making a change of variable, $Y = y + a_1\/2 x + a_3\/2$ we obtain $
  Y^2 = y^2 + (a_1/2 x + a_3/2)^2 + a_1 x y + a_3 y
$ then $(E)$ will change to $
  Y^2 = x^3 + b_2 x^3 + b_4 x + b_6
$ and setting $X = x + b_2\/3$ $
  X^3 = x^3 + b_2 x^2 + c x + d
$ replacing in $(E)$ we obtain $
  Y^2 = X^3 + a X + b
$ which is called the reduced Weiestrass form.

#pro[
  Let $E$ be the curve defined by $y^2 = x^3 + a x + b$, then $E$ is an elliptic curve $<->$ the cubic polynomial $x^3 + a x^2 + b x + c$ has no repeated root in $K$.
]

#prf[
  Set $P(x) = x^3 + a x^2 + b x + c$, then we can rewrite the equation as $f(x, y) = y^2 - P(x)$, and hence we reformulate the statement as: the curve $E$ is not smooth and only if $f(x, y)$ has repeated roots.

  $->$ Then $exists (x_0, y_0) in K^2, f(x_0, y_0) = 0$ and $nabla f (x_0, y_0) != 0$, $y_0^2 = P(x_0) -> 2 y_0 = 0$ and $P'(x_0) = 0$ hence $P$ has a repeated root.

  $<-$ Suppose $P$ has a repeated root in $K$, then $P(x_0) = P'(x_0) = 0$, set $y_0 = 0$, $(x_0, y_0) in E$ because $P(x_0) = 0 = y_0^2$, we obtain that the partial derivatives of $f$ are $0$ and hence $E$ is not a smooth curve.

]

#pro[
  Let $P(x) = x^3 + a x^2 + b x + c in K[X]$, then $P$ has a repeated root in $K$ $<->$ $P$ has a repeated root in $overline(K)$.
]

#prf[
  $->$ trivial.

  $<-$ Suppose that $P$ has a repeated root in $overline(K)$, say $x_0 in overline(K)$, $P(x_0) = P'(x_0) = 0$, then $x_0$ is a root of $P'(x) = 3 x^2 + 2 a x + b$, if $deg_K (x_0) = 1$, done. Otherwise, if $deg_K (x_0) = 2$, then $P'(x) = 3 Irr(x_0, K, x)$, write $P(x) = (x - x_0)^2 (x - x_1)$ in $overline(K)[X]$ then $P(x) = Irr (x_0, K, x) (x - x_2)$ with $x_1, x_2 in overline(K)$ then $x - x_0 in K[X] -> x_2 in K$, hence we obtain $
    P(x) &= (x - x_0) (x - x_0) (x - x_1)\
    &= (x - x_0) (x - tilde(x)_0) (x - x_0)
  $


]

#def(name: "Polynomial Descriminant")[
  Let $P(X) in R[X]$ monic, $P(X) = product_(i=1)^n (X - alpha_i)$, the discriminant of $P$ is defined as $
    disc(P) = product_(1 <= i < j <= n) (alpha_i - alpha_j)^2
  $
]

For $P(x) = x^3 + a x + b$, we have $disc(P) = - 4 a^3 - 27 b^2$. It follows that $P$ has no repeated root in $overline(K)$ $<->$ $disc(P) != 0$.

#cor[
  An algebraic curve $E: y^2 = x^3 + a x + b$ is an elliptic curve if and only if $4 a^3 + 27 b^2 != 0$.
]

#def(name: "Elliptic Curve Discriminant")[
  Let $E: y^2 = x^3 + a x + b$ be an elliptic curve, then the discriminant of $E$ is defined as $Delta(E) = 16 disc(x^3 + a x + b)$.
]

#def(name: "J-Invariant")[
  Let $E: y^2 = x^3 + a x + b$ be an elliptic curve, $a, b in K$, then the $J$-invariant of $E$ is given by $
    J(E) = 1728 (4 a^3)/(4 a^3 + 27 b^2)
  $
]

#pro[
  Consider the two following elliptic curves over $K$ $
    E_1: y^2 = x^3 + a_1 x + b_1 quad quad E_2: y^2 = x^3 + a_2 x + b_2
  $
  $J(E_1) = J(E_2)$ if and only if $exists mu in overline(K)^*, a_2 = mu^4 a_1$ and $b_2 = mu^6 b_1$.
]
