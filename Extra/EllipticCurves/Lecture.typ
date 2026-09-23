#import "@preview/wrap-it:0.1.1": wrap-content
#import "@preview/commute:0.3.0": *

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Elliptic Curves],
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This course is presented by Pr. STEVENHAGEN Peter.]
  )
)

#let card = math.op("#")

#let quotient(a, b) = $frac(#a, #b, style: "skewed")$

#let wp = math.op("℘")

#chapter[Introduction][]
The fundamental theorem of calculus $integral_a^b f(t) dif t = F(b) - F(a)$ with $F' = f$ gave a really useful tool to compute integrations with anti-derivatives. In the 19th century, the computation of the arc-length of function graphs became a necessity in multiple fields, and it was being computed as $integral_a^b sqrt(1 + f'(t)^2) dif t$, which has no clear way to compute an anti-derivative. For example, computing the constant $pi$, you have that $pi$ is computed as the arc-length of $t |-> sqrt(1 - t^2) dif t$,  and we get $
  pi = integral_(-1)^1 (dif t)/(sqrt(1 - t^2))
$ using complex analysis, you can try to compute the integral as $z in CC |-> integral_0^z (dif t)/(1 - t^2)$, the integral would be path dependent by the existance of singularities at $plus.minus 1$. Another way to look at the problem, we define the Riemann surface defined as $C: X^2 + Y^2 = 1$, taking $P = (0, 1)$, a lifting of $0 in CC$ to $C$, we have $F(z) = integral_P^z (dif X)/Y$ hence we obtain a function $
  C &-> quotient(CC, 2 pi ZZ),\
  z &|-> F(z)\
  (sin z, cos z) &arrow.l.bar z
$ which is an isomorphism, $CC\/2 pi ZZ$ is a group, thus we get a group structure on the Riemann surface $C$, which is defined as $
  (sin x, cos x) plus.o &(sin y, cos y) = (sin(x + y),  cos(x + y))\
  &= (sin x cos y + sin y cos x, cos x cos y - sin x sin y)
$ by replacing the points $(sin x, cos x) = (a, b)$ and $(sin y, cos y) = (c, d)$ then we have the operation is defined as $
  (a, b) plus.o (c, d) = (a d + b c, b d - a c)
$ we have that $(dif X)/Y = (dif sin z)/(cos z) = dif z$. The same process can be done on the function $
  F(z) = integral_0^z (dif t)/(sqrt(1 - t^4))
$ which is called the lemniscate integral. The lemniscate is defined as given two points, $Q_1, Q_2$, the set of points for which the product of distnces with $Q_1$ and $Q_2$ is $1$, ${P | |P Q_1| dot.c |P Q_2| < 1}$. Similar to earlier, we can take the algebraic curve, $C: X^4 + Y^2 = 1$. Representing this set of points, you will get a shape that is topologically equivalent to a torus. Again, by the same process, we have that $F(z) = integral_(P)^z (dif X)/Y$ hence we try to compute $(dif X)/Y$ to obtain an algebraic representation of the Riemann surface $C$, we obtain that it is isomorphic to $
  C &-> quotient(CC, (omega_1 ZZ + omega_2 ZZ))\
  z &|-> integral_P^z (dif X)/Y\
  (P(z), P'(z)) & arrow.l.bar z
$ we have that $P^4 + (P')^2 = 1$, which are called elliptic functions.

#section[Complex Lattices]

Let $omega_1, omega_2 in CC$ linearly independent, Define a lattice $Lambda = ZZ omega_1 + ZZ omega_2$. Let $F$ be the fundamental domain, $F={ lambda_1 omega_1 + lambda_2 omega_2 | lambda_1, lambda_2 in [0, 1]}$. A complex meromorphic function $f$ cannot be analytic since it would become constant on the complex plane hence a constant function, if $f$ has a single singularity, then $integral_(partial F) f(z) dif z = 0$, hence you would have at least 2 singularities.

We construct the function as follows $
  wp_Lambda (z) = 1/(z^2) + sum_(lambda in Lambda \\ {0}) [1/((z-lambda)^2) - 1/(lambda^2)]
$ which has a double pole at every lattice point, and we obtain the definition of the Weiestrass $wp$ function, which converges uniformly. By computing the derivative, we obtain $
  wp'_Lambda (z) = -2 sum_(lambda in Lambda) 1/((z - lambda)^3)
$ which is periodic. Notice also that $wp_Lambda$ is an even function, and hence we can use the periodicity of the derivative to prove that $wp_Lambda$ is periodic. We obtain the following theorem, that $"m"_Lambda = CC(wp_Lambda, wp'_Lambda)$, meaning, any meromorphic function on $Lambda$ can be obtained algebraically with a polynomial expression of $wp_Lambda$ and $wp'_Lambda$. To prove that, we take $
  "m"^star_Lambda &-> "Div"(Lambda) = plus.o.big_(t in T) ZZ dot.c [t]\
  f &|-> "div"(f) = sum_(t in T) "ord"_t (f) dot.c [t]
$ where $T = CC\/Lambda$. For example we have $
  "div" (wp_Lambda) &= (a) + (-a) - 2 (0)\
  "div" (wp'_Lambda) &= (omega_1/2) + (omega_2/2) + ((omega_1 + omega_2)/2) - 3(0)
$ We get as a theorem that the following exact sequence $
  1 -> CC^* -> "m"(T)^* ->^"div" "Div"^0 (T) ->^! T -> 0
$ where $"div"$ is the divisor function, and $!$ turns the formal sum into an actual sum $sum_(t in T) n_t dot.c [t] |-> sum_(t in T) n_t t in T$. We have also a theorem stating that $(wp'_Lambda)^2 in CC(wp_Lambda)$ and after a computation, we have $
  (wp'_Lambda)^2 = 4 wp^3_Lambda - g_2 (Lambda) wp_Lambda - g_3 (Lambda)
$ Similar to the previous examples, we obtain a function $
  quotient(CC, Lambda) &->^tilde Y^2 Z = 4 X^3 - g_2 X Z^2 - g_3 Z^3 \
  z &|-> [wp_Lambda (z) : wp'_Lambda (z) : 1]\
  0 &|-> [0 : 1 : 0]
$ where we use the projective plane to define the values of the map.
