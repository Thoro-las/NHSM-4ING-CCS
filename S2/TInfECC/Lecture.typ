#import "@preview/commute:0.3.0": arr, commutative-diagram, node
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Information Theory & Error Correcting Codes",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures given by Dr. Seffah.],
  ),
)

#let Z(m) = $ZZ \/ #m ZZ$
#let card = math.op("#")
#let argmax = math.op("argmax")
#let argmin = math.op("argmin")

#set enum(tight: false)

#chapter("Remainders", num: 0)[]
#section(level: 1)[Congruences & $bold(ZZ\/m ZZ)$ Arithmetic]
#def(name: "Congruence Of Integers / Congruence Class")[
  Let $a, b, m in ZZ$ with $m > 0$, we say that $a$ is congruent to $b$ modulo $m$ and we write $a equiv b mod m$ if $m divides a - b$ which gives an equivalence relation. The class of $a$ in the congruence relation by $m$ is called the congruence class of $a$ modulo $m$, which is $overline(a) = a + m ZZ$.
]

#thm[
  Let $a, b, c, d in ZZ$ and $m in NN$, with $a equiv b mod m$ and $c equiv d mod m$ then we have the following statements are true:
  + $a + c equiv b + d mod m$.
  + $a - c equiv b - d mod m$.
  + $a c equiv b d mod m$.
]

We denote $ZZ\/m ZZ$, the set of all congruence classes modulo $m$.

#section(level: 1)[Euler $phi$ Function]
#def(name: [$phi$ Function])[
  The Euler $phi$ function is defined as $phi: ZZ -> NN$, where $phi(n) = card { x in [|0, m-1|] | gcd(x, m) = 1}$.
]

#ooc[
  #lem(ovcount: false)[
    Let $r, m, p in NN$ where $p$ is prime, then $gcd(m, p^r) != 1 <=> p divides m$
  ]

  #prf[
    $=>$ let $d = gcd(m, p^r)$, since $d | p^r$ and $p$ is prime then $d = p^k$ for some $k in NN$, and $p^k = d | m$ thus $p | p^k$ and $p^k | m$ so $p | m$. $arrow.double.l$ suppose that $p | m$ and since $p | p^r$ too then $p | gcd(m, p^r)$ given $p > 1$ then $gcd(m, p^r) != 1$.
  ]
]

#pro[
  Let $p$ be a prime number, then $phi(p) = p - 1$ and $phi(p^r) = p^r - p^(r-1) = p^r (1 - 1/p)$.
]

#ooc[
  #prf[
    Let $p, r in NN$ with $p$ prime. From the lemma, we have that for $m in NN$, $gcd(p^r, m) = 1 <=> p divides.not m$, the numbers that are divisible by $p$ in $[|0, p^r - 1|]$ are of the form $k p$ where $k in [|0, p^(r-1) - 1|]$, so the number of numbers that are divisible by $p$ in $[|0, p^r - 1|]$ is $p^r - p^(r-1)$ so $phi(p^r)=p^r - p^(r-1)$.
  ]
]

#thm(name: "Lagrange")[
  Let $G$ be a finite group and $H$ a subgroup of $G$, then $card H divides card G$.
]

This theorem is already done multiple times in algebra so no need to prove it here.

#ooc[
  #lem[
    Let $n in NN$, $x in (ZZ\/n ZZ)^*$ (invertible) $<=>$ $gcd(x, n) = 1$.
  ]

  #prf[
    $=>$ Suppose that $x in (ZZ\/n ZZ)^*$, then $exists y in ZZ\/n ZZ$ such that $x y = 1 mod n$, then $x y = 1 + k n => x y - k n = 1$ by Bezout theorem we have $gcd(x, n) = 1$. $arrow.double.l$ SUppose that $gcd(x, n) = 1$, by Bezout theorem, $exists y, k in ZZ, x y + k n = 1$ and thus $x y + k n = 1 mod n => x y = 1 mod n$ so $x in (ZZ\/n ZZ)^*$.
  ]

  We need this lemma since $phi(n) = card (ZZ\/n ZZ)^*$.
]

#thm(name: "Euler")[
  Let $m$ be a positive integer modulo $a$ be an integer relatively prime to $m$ then $a^(phi(m)) equiv 1 mod m$.
]

#ooc[
  #prf[
    Let $a$ relatively prime to $m$, then $gcd(a, m) = 1 => a in (ZZ\/m ZZ)^*$, $a$ has finite order thus $exists k in NN, a^k = 1 mod m$, $chevron.l a chevron.r$ is a subgroup of $(ZZ\/m ZZ)^*$ so $k | card(ZZ\/m ZZ)^* = phi(m)$ and thus $phi(m) = k b$, thus $a^(phi(m)) = a^(k b) = (a^k)^b = 1^b = 1 mod m$, which completes the proof.
  ]
]

#cor(name: "Fermat")[
  Let $p$ be a prime, if the integer $a$ is not divisible by $p$ then $a^p equiv a mod p$.
]

#ooc[
  #prf[
    Just take $m = p$ in Euler's theorem, then $phi(m) = p - 1$ so $a^(phi(m)) = a^(p-1) = 1 mod m$, so $a^p = a mod m$.
  ]
]


#section(level: 1)[Quadratic Residues]
#def(name: "Quadratic Residue")[
  Let $p$ be an odd prime and $a$ an integer not divisible by $p$, we say that $a$ is a quadratic residue modulo $p$ if there exists $x in ZZ$, such that $x^2 equiv a mod p$.
]

#thm[
  An integer $a$ is a quadratic residue modulo $p$ if and only if $gcd(a, p) = 1$ and $a$ has a square rest modulo $p$.
]

#prf[
  $=>$ Suppose that $a$ is a quadratic residue modulo $p$, that is, there exists $x in ZZ$ such that $x^2 equiv a mod p$. If $gcd(a, p) != 1$ then $p | a$ so $a equiv 0 mod p$ thus $x = 0$, so necessarily $gcd(a, p) = 1$ and $a$ has $x^2$ remainder when divided by $p$ thus the rest is a perfect square. $arrow.double.l$ Suppose now that $gcd(a, p) = 1$ and $a$ has a square rest modulo $p$, then $a equiv.not 0 mod p$ and $a equiv x^2 mod p$ thus $a$ is quadratic residue.
]

#def(name: "Legendre Symbol")[
  Let $p$ be an odd prime, define the Legendre symbol as:
  $
    (a/p) =
    cases(
      1 & "if" gcd(a, p) = 1 "and" a "is a quadratic residue" mod p,
      -1 & "if" gcd(a, p) = 1 "and" a "is not a quadratic residue",
      0 & "if" p "divides" a
    )
  $
]

#thm[
  Let $p$ be an odd prime, for every integer $a$
  $
    (a/p) = a^((p-1)/2) mod p
  $
]

#ooc[
  #prf[
    We treat by cases
    + $p | a$: then $a = 0 mod p => a^((p-1)/2) = 0^((p-1)/2) = 0 mod p$.
    + $p divides.not a$: then $gcd(a, p) = 1$, by Fermat's little theorem we have that $a^(p-1) equiv 1 mod p$, the square roots of $1$ are $-1$ and $1$ only thus $a^((p-1)/2) equiv 1 "or" -1 mod p$.
      + If $a$ is a quadratic residue then $exists x in ZZ, x^2 equiv a mod p => a^((p-1)/2) equiv x^(2(p-1)/2) equiv x^(p-1) equiv 1 mod p$.
      + If $a^((p-1)/2) equiv 1 mod p$, we have that $ZZ_p$ is a finite field thus there exists a generator $g$ of $(ZZ_p)^*$ (primitive element theorem in finite fields), then $a equiv g^k mod p$, we have then $a^((p-1)/2) equiv g^(k (p-1)/2) equiv 1 mod p$. Given that the generator $g$ has order $p-1$ then $k (p-1)/2 equiv 0 mod p - 1$ thus $k (p-1)/2 = m(p-1) => k = 2m$ so $k$ is even, thus $a equiv g^(2m) = (g^m)^2 mod p$ so $a$ is a quadratic residue modulo $p$.
    Given that $a$ is a quadratic residue modulo $p$ if and only if $a^((p-1)/2) equiv 1 mod p$ and $a^((p-1)/2) equiv 1 "or" -1 mod p$ then necessarily if $a$ is not a quadratic residue, $a equiv -1 mod p$.
  ]
]

#exr[
  + Decompose into partial fractions in $RR[x]$ the rational function $ x/(x^4 + x^2 + 1) $
  + Let $K$ be a commutative field, and let $p: x^2 + lambda x + mu$ be a monic polynomial of degree $2$, show that $p$ is reducible over $K$ if and only if it has a root in $K$.
  + Let $K = ZZ\/5 ZZ$ be the field of residue classes, factor the polynomial $(x^2 + 4)(x^2 + 3)$ into irreducible factors over $K$.
  + Still with $K = ZZ\/5 ZZ$, decompose into partial fractions the rational function $ (x - overline(2))/((x^2 + overline(4))(x^2 + overline(3))) $
]

+ Decomposing into partial fractions: we have that the denominator decomposes into the following two irreducible polynomials $ x^4 + x^2 + 1 & = x^4 + 2 x^2 + 1 - x^2 \
                & = (x^2 + 1)^2 - x^2 \
                & = (x^2 + x + 1)(x^2 - x + 1) $ and thus we have that the fraction decomposes as follows $ x/(x^4 + x^2 + 1) & = (a x + b)/(x^2 + x + 1) + (c x + d)/(x^2 - x + 1) \ $ by multiplying both sides by $x^4 + x^2 + 1$ we get $ x & = (a x + b)(x^2 - x + 1) + (c x + d)(x^2 + x + 1) \
  0 & = a x^3 - a x^2 + a x + b x^2 - b x + b + c x^3 + c x^2 + c x + d x^2 + d x + d - x \
  0 & = (a + c) x^3 + (- a + b + c + d) x^2 + (a - b + c + d - 1) x + (b + d) \
    & #h(1.5cm) => cases(
        a + c & = 0,
        - a + b + c + d & = 0,
        a - b + c + d - 1 & = 0,
        b + d & = 0
      ) quad => quad cases(
        a = 0,
        b = -1\/2,
        c = 0,
        d = 1\/2
      ) $ thus we get $ x/(x^4 + x^2 + 1) = 1/(2(x^2 - x + 1)) - 1/(2(x^2 + x + 1)) $
+ Let $K$ be a commutative field and let $P(x) = x^2 + lambda x + mu$. $=>$ Suppose that $P(x)$ is reducible, then $P(x) = Q(x) dot.c R(x)$ with $deg(Q) != 0$ and $deg(R) != 0$ and since $deg(Q) + deg(R) = deg(P)$ then necessarily $deg(Q) = deg(R) = 1$, so $Q(x) = a x + b$ and $R(x) = c x + d$ and since $a, b in K$ then $-a/b in K$ which is a root of $Q$ and thus a root of $P$ so $P$ has a root in $K$. $arrow.double.l$ Suppose that $P(x)$ has a root $alpha$, then $(x - alpha)$ divides $P$ and thus we get that $P$ is reducible.
+ Let $K = ZZ\/5ZZ$, factor $(x^2 + 4)(x^2 + 3)$ into irreducible factors over $K$, $-3=2 mod 5$ is not a quadratic residue since $2^((5-1)/2) = 4 = -1 mod 5$ thus $x^2 + 3$ is irreducible given it has no roots. While $-4=1$ is a quadratic residue with roots $-1$ and $1$ so $(x^2 + 4)(x^2 + 3) = (x^2 - 1)(x^2 + 3) = (x - 1)(x + 1)(x^2 + 3)$.
+ Decomposing now the partial fraction in $ZZ\/5ZZ$, $ (x-2)/((x^2 + 4)(x^2 + 3)) & = (x-2)/((x + 4)(x + 1)(x^2 + 3)) \
                             & = a/(x + 4) + b/(x + 1) + (c x + d)/(x^2 + 3) $ by multiplying all parts by $(x^2 + 4)(x^2 + 3)$ we get $ x - 2 = a(x+1)(x^2 + 3) + b(x+4)(x^2 + 3) + (c x + d)(x + 4)(x + 1) $ we set the following values for $x$
  - $x = -1$: $-3 = b(-1 + 4)(1 + 3) = 12 b = 2 b => b = 3*(-3) = -9 = 1$.
  - $x = +1$: $-1 = a(1 + 1)(1 + 3) = 8 a = 3 a => a = 2*(-1) = -2 = 3$.

#exr[
  + Decompose $561$ into prime factors.
  + Let $a$ be an indeterminate, for any integer $n >= 1$, justify the formula $ a^n - 1 = (a - 1) (a^(n-1) + a^(n - 2) + dots.c + a + 1) $
  + Justify for any integer $m >= 1$ and any integer $n >= 1$ the formula $ a^(m n) - 1 = (a^m - 1) (a^((n-1)m) + a^((n-2)m) + dots.c + a^m + 1) $
  + Let $a in ZZ$ be an integer, prove $a^(561) - a = a (a^(2 dot.c 280) - 1) = a (a^2 - 1) m$ for some integer $m$.
  + For any $a in ZZ$, show that $a (a - 1) (a + 1)$ is divisible by $3$.
  + Show that $a^(561) - a$ is a multiple of $3$.
  + Show that $a^(561) - a$ is a multiple of $17$.
  + Show that $a^(561) - a$ is a multiple of $11$.
  + Show that $a^(561) equiv a mod 561$.
]

+ The prime decomposition of $561$ is $3 dot.c 11 dot.c 17$.
+ Let $a$ be a formal variable, we have $ (a - 1)sum_(i = 0)^(n-1) a^i = sum_(i=0)^(n-1) a^(i+1) - a^i & = sum_(i = 1)^n a^i - sum_(i=0)^(n-1) a^i = a^n - 1 $
+ By taking $a = a^m$ in the previous inequality we get the result.
+ Clearly $561 = 2 dot.c 280 + 1$ thus $a^561 - a = a(a^560 - 1) = a(a^(2 dot.c 280) - 1)$ and we have from the previous question by taking $m = 2$ and $n = 280$ that $a^(561) - a = a (a^2 - 1)(sum_(i=1)^(279) a^(2i)) = a (a^2 - 1) m$.
+ Let $a in ZZ$, we have that $a = 3 q + r$ with $0 <= r < 2$ from the Euclidean division algorithm, then $a (a - 1) (a + 1) = (3 q + r) (3 q + (r - 1)) (3 (q + 1) + (r - 2))$ and since $0 <= r < 2$ then necessarily either $r$, $r-1$ or $r-2$ is $0$, and thus it has one of the factors divisible by $3$.
+ $a^(561) - a$ is divisible by $3$ since $a^(561) - a = a (a + 1) (a - 1) m$ which is divisible by $3$ from the previous question.
+ $a^16 = 1 mod 17$ by Fermat little theorem, then $a^(560) = a^(16 dot.c 35) = 1 mod 17$ thus, $a^(561) = a mod 17 => 17 | a^561 - a$.
+ Same here, $a^10 = 1 mod 11$ by Fermat little theorem, then $a^(560) = a^(10 dot.c 56) = 1 mod 11$ thus, $a^(561) = a mod 11 => 11 | a^561 - a$.
+ Given that all the divisors of $561$ divide $a^561 - a$ then it is divisible by their product so $561 | a^561 - a => a^561 equiv a mod 561$.

#counter("title-counter").update(0)
#chapter[Introduction To Information Theory][
  The digital revolution has transformed how we communicate, store and process information. This chapter introduces the fundamental concepts of information theory, a discipline at the intersection of mathematics, computer science and telecommunication.
]

#align(center)[
  #set text(fill: white)
  #diagram(
    edge-stroke: 1pt,
    node-corner-radius: 5pt,
    edge-corner-radius: 8pt,
    mark-scale: 80%,

    node((0, 0), name: "1", width: 2.5cm, [Source], fill: maroon),
    node((0.85, 0), name: "2", [Transmit], fill: eastern),
    node((1.7, 0), name: "3", [Channel], fill: eastern),
    node((2.65, 0), name: "4", [Receive], fill: eastern),
    node((3.75, 0), name: "5", [Destination], fill: olive, shape: fletcher.shapes.hexagon),

    edge(label("1"), label("2"), "-|>"),
    edge(label("2"), label("3"), "-|>"),
    edge(label("3"), label("4"), "-|>"),
    edge(label("4"), label("5"), "-|>"),
  )
]

This diagram present the general structure of any communication system. The communication process begins with an information source. We start by thinking what a message could be. In general, we can consider a message to be constructed by a set of symbols $cal(X) = {x_1, dots, x_n}$ and given a context, has a distribution of which of those symbols are sent. Thus, we consider a message consecutive realizations of a random variable $X$ defined in $cal(X)$.

Now the goal is to quantify information, thus given $X tilde P_X (x)$, we define the amount of information for some symbol $x$ to be $I(x) = - log_2 (P_X (x))$ (justifications for these definitions will be in the next chapter). Then, we can define an average amount of information from a source $X$, which is called the entropy $H(X) = EE[I(X)]$. Such a quantity is important given Shannon's first theorem, which gives a lower bound for any data compression.

After being able to measure the amount of information, we can measure efficiency of some encodings both for source and channel by how much redundancy is added to how much is actually needed.

#colbreak()
#section[The Communication System Model]
Shannon's groundbreaking contribution was a formal model that describes communication between two entities, whether machine or humans. This model highlights the essential components:
- Source: the originator of the information.
- Channel: The medium through which information is transmitted.
- Recipient: The receiver of the information.

#subsection[Source \& Message]
The sources generate a message composed of symbols from a specific alphabet.
- Discrete data: text, numbers, symbols.
- Digitized analog data: image, voice, video converted to digital form.

#subsection[Transmitter Processing]
The transmitter performs three crucial operations.
+ Source Coding: data compression to minimize message size.
+ Channel Coding: adding redundancy for error correction.
+ Modulation: converting digital messages to physical signal.

#subsection[Receiver Processing]
The receiver performs these receiver operations.
+ Demodulation: converting physical signal into a digital message.
+ Channel Decoding: error detection and correction.
+ Source Decoding: reconstruction of the original message.

#chapter[Information \& Entropy][
  Information theory is a theory founded by Claude Shannon, providing a mathematical framework for quantifying information, studying its transmission, processing, and storage. This chapter focuses on the fundamental concepts of information measurement through entropy and related measures.
]


#section[Quantifying Information]

#ooc(ntt[
  Let $Sigma$ be a set:
  - $Sigma^n = Sigma times dots.c times Sigma$ is the set of words of length $n$. We take that $Sigma^0 = {epsilon}$ where $epsilon$ is the empty word.
  - $Sigma^* = union_(i >= 0) Sigma^n$ the set of all possible words over $Sigma$.
  - $Sigma^+ = union_(i >= 1) Sigma^n$ the set of all possible non-empty words over $Sigma$.
  - For $x in Sigma^*$, we define $|x| = min {n in NN|x in Sigma^n}$.
  - The set of binary letters as $BB = {0, 1}$.
  - For $x = x_1 dots x_n, y = y_1 dots y_m in Sigma^*, x y = x_1 dots x_n y_1 dots y_m in Sigma^*$.
])

#def(name: "Symbol/Message", ovcount: false)[
  Let $cal(X)={x_1, dots, x_m}$ be a finite set of alphabets. An element of $cal(X)$ is called a symbol, and elements of $cal(X)^+$ are called a message with alphabet $cal(X)$.
]

#ooc[
  To model information that was given from a message, we consider the fact that a message contains more information the more unpredictable it is. For example, consider a sender that keeps sending the message "Hello!" over and over again, at each iteration, it becomes predictable what the next message would be, thus there is no more information that is passed. Uncertainty is a property of a random process, thus a good way to model a message is to consider it as a random variable $X$ that has values in $cal(X)$. From the previous example too, we can think that the information in a message is related to how uncertain it is, that is, how less probable it would be sent. Also, notice that the information from independent events should be additive, that is, if even $p$ and $q$ happen that are independent, then the amount of information gained from the even $p q$ happening is the sum of information gained from both the events $p$ and $q$.

  #ntt[
    For the sake of simplifying notation, we will denote $P(X = x)$ as $P(x)$, same for other random variables, like $P(Y = y)$ as $P(y)$. Same for all the remaining notations like $P(y|x)$ which is $P(Y = y|X = x)$.
  ]
]

To define a measure for information $I: cal(X) -> RR$, we start by considering some random variable $X$ that represents a source of symbols $cal(X)$. As discussed before, the information will be a function of probability, thus we take $I(x) = phi(P(x))$ from our previous discussion it would satisfy the following postulates:

- Postulate 1: Information depends only on probability $I(A) = phi(P(A))$.
- Postulate 2: Certain events provide no information $phi(1) = 0$.
- Postulate 3: Information decreases with increasing probability, $phi$ is decreasing.
- Postulate 4: Impossible events provide infinite information $P(0) = infinity$.
- Postulate 5: Information from independent events $phi(p q) = phi(p) + phi(q)$.

Also, clearly $phi$ would be continuous since a tiny difference in probability would result in a tiny difference in the amount of information that it would result in.

#ooc[
  We will briefly prove that $phi equiv - log_b$ for any base $b$. By induction we have that $phi(a^n) = n f(a)$ and since $phi(a) = phi(a^(q\/q)) = q phi(a^q)$ then necessarily $phi(a^(p\/q)) = (p\/q) phi(a)$. By continuity, we have $forall x in RR, phi(a^x) = x phi(a)$. Now take $t = log_a x$, then $phi(x) = phi(a^t) = t phi(a) = phi(a) log_a x$, thus $phi(x) = phi(a) log_a (x)$, by taking $x -> 0$, we have that $phi(a) log_a (x) -> +infinity$ so $phi(a) < 0$. Therefore, $phi equiv - log_b$ for some $b$.
]

#def(name: "Measure Of Information", ovcount: false)[
  Let $X$ be a random variable that represents the probability that a message $x$ is sent as $P(X = x) = P(x)$, we define the measure of information of the message $x$ as $ I(x) = - log_2 P(x) $
]

#ooc[
  $log_2$ is taken for the usual reason that information is represented in binary, and that if it is represented in any other base, it would have just a linear factor added. In practice, transmission lines tend to cause irregularities in the signal, that is, it alters the contents of the message with some noise. Thus, in transmission lines we are interested in the distribution of the message $y$ that are received, given some sent message $x$, which will be measured by $P(y|x)$.
]

#section[Measures Of Entropy]
#ooc[
  After we defined a measure of information, which we discussed to be a measure of uncertainty, we need a way to quantify the average amount of uncertainty for all the values of $X$. Thus, we define the entropy as follows.
]

#def(name: "Entropy", ovcount: false)[
  Let $X$ be a random variable with values in $cal(X)$, we define the entropy $H(X)$ as the average amount of information, that is $ H(X) = EE[I(X)] = - sum_(x in X) P(x) dot.c log_2 P(x) $
]


Notice that the information of some message $x$ depends only on its unpredictability, that is, its probability of occurrence $P(x)$ not its value.

#pro(ovcount: false)[
  Let $X, Y$ with symbols in $cal(X), cal(Y)$ be two sources.
  + Non-negativity: $H(X) >= 0$.
  + Maximum Entropy: $H(X) <= log_2 card cal(X)$.
  + Independent Additivity: $X perp Y$ $=>$ $H(X Y) = H(X) + H(Y)$.
]

#ooc[
  #prf[
    + $forall x in cal(X), I(x) >= 0$, then $H(X) = EE[I(X)] >= 0$
    + Here, we optimize on the distribution of $X$, $max_(P) H(X) = - min_P sum_(x in X) P(x) dot.c log_2 P(x),$ hence for $I$ a finite set $min_({y_i in [0, 1]}_(i in I)) sum_(i in I) y_i log_2 (y_i)$ with $sum_(i in I) y_i = 1$. Notice that all the terms have the same sign so $min sum_(i in I) dots = sum_(i in I) min dots$. $y_i$ all having the same range would mean that we just need to find $c$ such that $y_i = c$ and satisfies the second inequality, which is clearly $c = 1/(card I)$.

    So $X$ would be a uniform distribution over $cal(X)$, $H_u (X) = EE[I(X)] = - sum_(x in X) 1\/(card cal(X)) log_2 (1\/(card cal(X))) = log_2 card cal(X) >= H(X)$.
    + Let $X, Y$ be two independent variables, then $H(X Y) = EE[I(X Y)] = EE[I(X) + I(Y)] = EE[I(X)] + EE[I(Y)] = H(X) + H(Y)$.
  ]
]

#exm[
  Let $cal(X) = {0, 1}$, and $X$ a discrete random variable with values in $cal(X)$, which has the distribution $ P(x) = cases(
    0.9 & "if" x = 0,
    0.1 & "if" x = 1
  )
  quad quad => quad quad
  I(x) = cases(
    0.152 & "if" x = 0,
    3.321 & "if" x = 1
  ) $ And the measure of average amount of information is $H(X) = 0.4689$.
]

#exm[
  DNA sequences provide an excellent example of entropy application. Let's consider:
  - Primate DNA: $P(A) = P(G) = P(C) = P(T) = 1\/4$. $H(X) = 2$
  - Bacterial DNA: $P(G) = P(C) = 0.38$, $P(A) = P(T) = 0.12$. $H(X) = 1.795$.
  The entropy of bacterial DNA indicates more predictable sequences compared to the primate DNA.
]

#subsection[Joint Entropy]

#def(name: "Joint Entropy", ovcount: false)[
  Let $X$, $Y$ be two random variables with joint distribution $P(x,y)$, the joint entropy is $ H(X, Y) = - sum_((x, y) in X times Y) P(x, y) log_2 P(x, y) = - EE[log_2 P(X, Y)] $
]

#pro(ovcount: false)[
  Let $X, Y$ be two sources.
  + Symmetry: $H(X, Y) = H(Y, X)$.
  + Non-Negativity: $H(X, Y) >= 0$.
  + Upperbound: $H(X, Y) <= H(X) + H(Y)$.
  + Lowerbound: $H(X, Y) >= max(H(X), H(Y))$.
]

#ooc[
  #prf[
    + trivial by $P(x, y) = P(X = x, Y = y) = P(Y = y, X = x) = P(y, x)$.
    + $forall x in X, forall y in Y, 0 <= P(x, y) <= 1 => log_2 P(x, y) <= 0$ so we have $P(x, y) log_2 P(x, y) <= 0$. Hence, $ H(X, Y) = - sum_(x in X) sum_(y in Y) P(x, y) log_2 P(x, y) >= 0 $
    + We have $H(X, Y) - H(X) - H(Y) = sum_(x in X) P(x) log_2 P(x) + sum_(y in Y) P(y) log_2 P(y) - sum_((x, y) in X times Y) P(x, y) log_2 P(x, y)$, by using the fact that $P(x) = sum_(y in Y) P(x, y)$, we can transform all the sums to be indexed with $X times Y$ as follows: $ sum_(x in X) P(x) log_2 P(x) & = sum_((x, y) in X times Y) P(x, y) log_2 P(x) \
      sum_(y in Y) P(x) log_2 P(y) & = sum_((x, y) in X times Y) P(x, y) log_2 P(y) $ Thus we obtain the writing $ H(X, Y) - H(X) - H(Y) = sum_((x,y) in X times Y) P(x, y) log_2 ((P(x) P(y))/(P(x, y))) $ We have that $forall t >= 0, log_2 (t) <= t - 1$ thus $ H(X, Y) - H(X) - H(Y) & = sum_((x, y) in X times Y) P(x, y) log_2 ((P(x) P(y))/(P(x, y))) \
                            & <= sum_((x, y) in X times Y) P(x, y) ((P(x) P(y))/(P(x,y)) - 1) \
                            & <= sum_((x, y) in X times Y) P(x) P(y) - P(x, y) \
                            & <= sum_((x, y) in X times Y) P(x) P(y) - sum_((x, y) in X times Y) P(x, y) \
                            & <= 1 - 1 = 0 $ Therefore $ H(X, Y) <= H(X) + H(Y) $
    + Without loss of generality, we prove that $H(X, Y) >= H(X)$, we have from before that $P(x) = sum_(y in Y) P(x,y)$ and since $forall (x, y) in X times Y, P(x, y) >= 0$ then $forall (x, y) in X times Y, P(x, y) <= P(x)$.
    $ H(X, Y) & = - sum_((x, y) in X times Y) P(x, y) log_2 P(x, y) \
            & >= - sum_((x, y) in X times Y) P(x) log_2 P(x) = H(X) $ and same to prove that $H(X, Y) >= H(Y)$ and hence we obtain the inequality $H(X, Y) >= max(H(X), H(Y))$.
  ]
]

#subsection[Conditional Entropy]
#ooc[
  The other useful measure of entropy is the conditional entropy, which measures the amount of information remaining in a random variable knowing another.
]

#def(name: "Conditional Entropy", ovcount: false)[
  Let $X, Y$ be two random variables with joint distribution $P(x, y)$, the conditional entropy is $ H(X|Y) = - sum_((x, y) in X times Y) P(x, y) log_2 P(x|y) = - EE[log_2 P(X|Y)] $
]

#pro(ovcount: false)[
  Let $X, Y$ be two sources.
  + Non-Negativity: $H(X|Y) >= 0$.
  + Chain Rule: $H(X, Y) = H(X) + H(Y|X)$.
  + Reduction Of Uncertainty: $H(X|Y) <= H(X)$.
]

#ooc[
  #prf[
    + $forall (x, y) in X times Y, 0 < P(x|y) <= 1 => log_2 P(x|y) <= 0 => H(X|Y) = -sum_((x, y) in X times Y) P(x, y) log_2 P(x|y) >= 0$.
    + We have #h(1fr) $ H(X, Y) & = - sum_((x, y) in X times Y) P(x, y) log_2 P(x, y) \
              & = - sum_((x, y) in X times Y) P(x, y) log_2 (P(x) P(y|x) $
      $
        & = - sum_((x, y) in X times Y) P(x, y) log_2 P(x) - sum_((x, y) in X times Y) P(x, y) log_2 P(y|x) \
        & = - sum_(x in X) (sum_(y in Y) P(x, y)) log_2 P(x) - sum_((x, y) in X times Y) P(x, y) log_2 P(y|x) \
        & = - sum_(x in X) P(x) log_2 P(x) - sum_((x, y) in X times Y) P(x, y) log_2 P(y|x) \
        & = H(X) + H(Y|X)
      $
    + $H(X|Y) =^a H(X, Y) - H(Y) <=^b H(X) + H(Y) - H(Y) = H(X)$, where $a$ comes from the chain rule and $b$ from the subadditivity of joint entropy.
  ]
]

#subsection[Mutual Information]
#ooc[
  Conditional entropy measures the amount of information is remaining in a random variable knowing another, it is easy to see that by subtracting the amount of information a variable has with the amount of remaining information knowing another we get the information that is "shared" between them.
]

#def(ovcount: false, name: "Mutual Information")[
  Let $X, Y$ be two sources, we define the mutual information as $ I(X; Y) = EE[log((P(X, Y))/(P(X) P(Y)))] = sum_((x, y)) P(x, y) log_2 ((P(x, y))/(P(x) P(y))) $
]

#pro(ovcount: false)[
  Let $X, Y$ be two sources.
  + Equivalent Formulas: #h(1fr) $ I(X;Y) & = H(X) - H(X|Y) \
           & = H(Y) - H(Y|X) \
           & = H(X) + H(Y) - H(X, Y) \
           & = H(X, Y) - H(X|Y) - H(Y|X) \ $
  + Symmetry: $I(X;Y) = I(Y;X)$.
  + Non-Negativity: $I(X; Y) >= 0$.
  + Upperbound: $I(X;Y) <= min(H(X), H(Y))$.
  + Self-Information: $I(X;X) = H(X)$.
]

#ooc[
  #prf[
    + Trivial, just write the formulas.
    + Direct consequence of the first two formulas of $1$.
    + We have from the reduction of uncertainty that $H(X|Y) <= H(X)$ thus $I(X;Y) = H(X) - H(X|Y) >= 0$.
    + We have from the lowerbound of joint entropy that $H(X, Y) >= max(H(X), H(Y))$ then #h(1fr) $ & I(X;Y) = H(X) + H(Y) - H(X, Y) \
      & <= H(X) + H(Y) - max(H(X), H(Y)) = min(H(X), H(Y)). $
    + $I(X;X) = H(X) - H(X|X) = H(X)$.
  ]
]

#subsection[Data-Processing Inequality]

#ooc[
  Another important property is the data processing inequality, stating informally that, given some information, one cannot process it to obtain more information. So, we start with defining what is "data-processing".

  #def(ovcount: false, name: "Markov Chain")[
    Let $X, Y, Z$ be three random variables, we say that they form a Markov chain in that order, and we denote it $X -> Y -> Z$ if the conditional probability of $Z$ depends only on $Y$ and not on $X$, which can be written as $ P(z|x, y) = P(z|y) $
  ]

  This definition is natural, since in our case, we take that we have the two random variables $X$ and $Y$, and we produce $Z$ with some processing on $Y$ without knowing anything about $X$, the process can be deterministic or not.

  To prove the data-processing inequality, we need the following lemma.
  #lem(count: false)[
    $I(X;Y,Z) = I(X;Y) + I(X;Z|Y)$ where
    - $I(X; Y, Z) = EE[P(X, Y, Z)\/(P(X) P(Y, Z))]$.
    - $I(X; Z|Y) = EE[P(X, Z|Y)\/(P(X|Y) P(Z|Y))]$.
  ]

  It is left for the reader to prove, it is mainly algebraic manipulation.
]

#thm(name: "Data-Processing Inequality", ovcount: false)[
  Let $X, Y, Z$ be three sources such that $X -> Y -> Z$, we have that $ I(X; Y) >= I(X; Z). $
]

#ooc[#prf[
  Since $X -> Y -> Z$ then there is no extra information given from $Z$ knowing $Y$ thus $I(X; Z|Y) = 0$ we have $
    I(X; Y, Z) &= I(X;Y) + I(X; Z|Y)\
    I(X; Y, Z) &= I(X;Z) + I(X; Y|Z)
  $ hence $
    I(X;Y) + I(X;Z|Y) = I(X;Z) + I(X;Y|Z)\
    => I(X;Y) = I(X;Z) + I(X;Y|Z)
  $ since $I(X;Y|Z) >= 0$ then $I(X;Y) >= I(X;Z)$.
]]

#chapter[Source Coding][
  Source coding is a fundamental part of communication that deals with representing data to be sent in the most compressible manner to get an efficient communication. From Shannon's theorem, we will see that the amount of data compression is bounded, and thus we will see algorithms that acheive an average length $1$ bit away from the bound.
]


#section[Source Coding]
The most important part of coding theory is achieving the most efficient reliable and secure coding. The first part is the focus of this section, by assigning a code from each symbol in $cal(X)$, we try to achieve the minimum bound possible of letters to send to transmit our message.



#def(name: "Coding Function", ovcount: false)[
  Let $c: cal(X) -> DD^+$, we call it a coding function, which takes characters of our set of symbols, and represent it as a string in $DD^+$ which is the set of words with $d$ alphabets.
]

To measure the efficiency of our coding function, we define the average code length, the less the average, the more efficient the transmission will be.

#def(name: "Average Code Length", ovcount: false)[
  Let $c: cal(X) -> DD^+$, a coding function, and consider the function $
    overline(L): {c: cal(X) -> DD^+} &-> RR quad c &|-> overline(L)_c = sum_(x in cal(X)) p(x) dot.c |c(x)|
  $
]

#ooc[
  #exm[
    Take a horse race with $8$ horses, we want to send a message in binary that indicates which horse has won. And suppose that the probabilities of winning for each horse is as follows
    #table(
      columns: 9,
      inset: (x: 2mm, y: 3mm),
      align: center + horizon,
      [Horse], ..range(1, 9).map(x => $#x$),
      [Probability Of Winning], ..($1/2$, $1/4$, $1/8$, $1/64$, $1/64$, $1/64$, $1/64$, $1/64$).map(x => $display(#x)$)
    )

    If we just send the index of the winner horse, we get the following coding function

    #table(
      columns: 9,
      align: center + horizon,
      [Horse $i$], ..range(1, 9).map(x => $#x$),
      [$c_1 (i)$], $000$, $001$, $010$, $011$, $100$, $101$, $110$, $111$
    )

    If we do it just blindly, we will need $3$ bits to describe all the possible winner horses from $000, 001, 010, dots.c, 110, 111$, calculating the average of description length we get $
      overline(L)_(c_1) = sum_(x in X) 3 dot.c p(x) = 3 "bits/sym"
    $

    Giving us an average of $3$ bits for the transmission to give exactly who horse is the winner. An aspect that we did not use in the previous part is how likely do horses win in this case, which we can use to improve the amount of bits that would be sent on the channel.

    Notice that if we assign a smaller message for the horses that are more probable to win, and longer message to horses that are less likely to win, then we can reduce some of the data that will be used to specify the winner. We take the following encoding

    #table(
      columns: 9,
      inset: (x: 2mm, y: 3mm),
      align: center + horizon,
      [Horse $i$], ..range(1, 9).map(x => $#x$),
      [$c_2(i)$], $0$, $10$, $110$, $1110$, $111100$, $111101$, $1111110$, $111111$
    )

    Now, we recalculate the average description length to get $   overline(L)_(c_2) = sum_(x in X) |c(x)| dot.c p(x) = 2 "bits/sym"
    $
    we have reduced the average description length by $1$ bit. If we calculate the entropy in this case we get $H(X) = - sum_(x in X) P(x) dot.c log_2 P(x) = 1.83475$, we see that the reduced average code length is more than the entropy.
  ]
]

#def(name: "Properties Of Codes", ovcount: false)[
  Let $c: cal(X) -> DD^+$ be a coding function. We say that it is:
  - Non-Singular: if $forall x, y in cal(X), c(x) != c(y)$.
  - Uniquely Decodable: if $forall y_1, dots, y_n in DD^+, exists ! x_1, dots, x_m, y_1 y_2 dots y_n = c(x_1) c(x_2) dots c(x_n)$, that is, any sequence $y_1, dots, y_n$ of $DD^+$ can be uniquely decoded into a sequence $x_1, dots, x_m$ of $cal(X)$.
  - Instantaneous/Prefix-Free: if $forall x, y in cal(X), exists.not m in DD^+, x = y m$, that is, no code-word is a prefix of another code-word.
]



// #section[Shannon Theorems]
// #ooc[
//   To prove Shannon theorems, we need the following statements.
//
//   #def(name: "Prefix Code", ovcount: false)[
//     A coding function $c: cal(X) -> BB^+$ is said to have the prefix property if $forall x, y in cal(X), forall u in BB^*, c(x) != c(y) u$.
//   ]
//
//   That is, no code is a prefix of another. An example of a prefix code is ${0, 10}$ while a non-prefix code is ${1, 10}$ since $1$ is a prefix of $10$. These codes are also called instantaneous codes, that is because given a binary string, even incomplete, one can know if it maps to a symbol or not. The proof of such statement is left for the reader.
//
//   #def(name: "Uniquely Decodable Code", ovcount: false)[
//     A coding function $c: cal(X) -> BB^+$ is said to be uniquely decodable if $c$ is injective, that is, each coding is unique to the symbol.
//   ]
//
//   #pro(ovcount: false)[
//     A uniquely decodable code $c$ can be turned into a prefix code $c'$ such that $forall i in [|1, n|], |c(x_i)| = |c'(x_i)|$.
//   ]
//
//   // #prf[
//   //   Let $c = {c_1, dots, c_m}$ be a uniquely Without loss of generality, consider 
//   // ]
//
//
//   #lem(name: "Kraft Inequality", ovcount: false)[
//     Let $X$ be a random variable with values in $cal(X)$, $c: cal(X) -> BB^+$ a coding function and $l(x) = |c(x)|$, then we have that $
//       sum_(i=1)^n 2^(- l(x_i)) <= 1
//     $
//   ]
//
// ]
//
// #thm(name: "Shannon's First Theorem", ovcount: false)[
//   Let $X$ be a random variable with values in $cal(X)$, for any coding function $c: cal(X) -> BB^+$ we have $
//     overline(L)_c >= H(X)
//   $
// ]
//
// Huffman's algorithm provides a systematic way to construct an optimal prefix code, where symbols with higher probability should have shorter code words, and achieves a lower bound of average coding weight.
//
// #alg(name: "Huffman", ovcount: false)[
//   + Sort symbols by probability in descending order.
//   + Combine the two smallest probabilities.
//   + Repeat until one node remains.
//   + Build the tree.
//   + Assign 0 and 1 to branches.
//   + Read codewords.
//   + Compute the average code length.
// ]
//
// #exm[
// ]
//
// The closer this value is to the entropy, the more efficient the compression is, using Huffman coding, the message is compressed, meaning that fewer bits are needed on average per symbol compared to a fixed length code such code is called optimal code which is a code that minimizes average code length. In source coding, our goal was to remove redundancy in order to compress the message. Now, we move to a different problem, what happens when the channel is noisy?
//
// #subsection[Noise And Errors]
// To reduce the probability of error, we need to make the sent message more robust to disturbances through channel coding.
//
//
// #thm(name: "Shannon's Second Theorem", ovcount: false)[
//   For any noisy channel, there exists a code that allows reliable transmission if the rate is less than the channel capacity.
// ]
