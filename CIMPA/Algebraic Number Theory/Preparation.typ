#import "@THR/Document:1.0.0": *
#show: template.with(
  cover: (
    hide-page: true
  )
)

#exr(count: false)[
  Give the definitions of prime and irreducible, show that $4 + sqrt(-5)$ and $1 + 2 sqrt(-5)$ are irreducible in $cal(O) = ZZ[sqrt(-5)]$ but not prime.
]


- Definitions of prime and irreducible.
  #def(name: "Irreducible/Prime", count: false)[
    Let $R$ be a ring and a number $x in R$, we say
    - $x$ irreducible: $x = a b => a in R^star$ or $b in R^star$. 
    - $x$ prime: $x | a b => x | a "or" x | b$.
  ]
- Showing that $4 + sqrt(-5)$ and $1 + 2 sqrt(-5)$ are irreducible.

  We have $N(4 + sqrt(-5)) = (4 + sqrt(-5)) (4 - sqrt(-5)) = 21$, let $a, b in R$ such that $4 + sqrt(-5) = a b$, $21 = N(a b) = N(a) N(b)$, since $21 = 3 dot.c 7$ without loss of generality we have take that $N(a) = 3$ but $N(a) = x^2 + 5 y^2$ with $y = 0$ since $5 y^2 > 5$ otherwise, therefore there are no solutions. Same idea for $1 + 2 sqrt(-5)$ since $N(1 + 2 sqrt(-5)) = 21$.

- Showing that they are not primes.

  Notice that $(4 + sqrt(-5)) (4 - sqrt(-5)) = 21$ then $4 + sqrt(-5) | 21 = 3 dot.c 7$, we prove $4 + sqrt(-5) divides.not 3, 4 + sqrt(-5) divides.not 7$. $
    (4 + sqrt(-5)) (a + b sqrt(-5)) &= (4 a - 5 b) + (4 b + a) sqrt(-5)
  $ thus, $4 b + a = 0$ and $4 a - 5 b = 3$. Hence, $7b = -1$ which has no solution. A similar process for $7$ giving $3 b = -1$. And the same idea for $1 + 2 sqrt(-5)$.

#exr(count: false)[
  Find all integer solutions for $y^2 = x^3 - 4$.
]

We have $x^3 = y^2 + 4 = (y + 2i) (y - 2i)$, thus we consider it in $ZZ[i]$, which is a PID thus a UFD.

#exr(count: false)[
  Show that the sign of the discriminant of a monic separable polynomial $f in ZZ[X]$ having $s$ pairs of complex conjugate roots is $(-1)^s$.
]
