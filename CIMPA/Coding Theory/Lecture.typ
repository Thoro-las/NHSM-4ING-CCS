#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Coding Theory],
    writer: "HADIOUCHE Azouaou",
  ),
)

#let supp = math.op("supp")
#let wt = math.op("wt")
#let card = math.op("#")

#chapter[Introduction][
  Coding theory is part of the information theory, which studies the channel encoding to be able to correct and avoid both erasures and errors when being sent and received through the channel channel.
]

#exm[
  Consider the set of messages $M = {1, 0}$, and suppose that the message "Yes" which will be represented by $1$ is sent through a noisy channel. There is a chance that the answer that is received would be $0$. To avoid such noise to affect the message drastically, consider the channel encoding that maps ${0, 1} -> {0, 1}^3, i |-> i i i$, then by sending the encoded message, if there is a single bit flip then we can decode by taking the message to be the one that is repeated most.
]

#def(name: "Conditional Probability", count: false)[
  If $A, B$ two events, then the conditional probability of $A$ knowing $B$ is defined as $ P(A|B) = P(A inter B) / P(B) $
]

#def(name: "Channel", count: false)[
  A channel is the triple $(X, Y, P)$ where $X$ and $Y$ are non-empty finite sets, called the input and output alphabets and $P$ is a conditional probability function: $ P: Y times X & -> [0, 1], quad (y, x) & |-> P(y|x) $
]

For the rest of the course $X, Y$ be finite fields, specifically we take $X = Y = FF_q$.

- *$q$-ary Symmetric Channel:* for $x, y in FF_q$, $lambda in [0, 1]$ then $ P(y|x) = cases(
    1 - lambda & "if" y = x,
    lambda/(q-1) & "if" y != x
  ) $

  #nte[
    We assume that $lambda < 1\/2$ in the case that $q=2$ given that if $lambda >= 1\/2$ then by Shannon theorem which states that it is impossible to have a reliable communication with $lambda >= 1\/2$.
  ]

- *Erasure Channel:* by taking $X = FF_q$ and $Y = FF_q union {epsilon}$ where $epsilon$ is the empty word, then $ P(y|x) = cases(
    1 - lambda & "if" y = x,
    lambda & "if" y = epsilon,
    0 & "otherwise"
  ) $

#def(name: "Discrete Memoryless Channel", count: false)[
  Let $n in NN$, the discrete memoryless channel is $(FF_q^n, FF_q^n, P^n)$ such that $                       P^n: FF_q^n times FF_q^n & -> [0, 1] \
  (vec(x_1, dots.v, x_n), vec(y_1, dots.v, y_n)) & |-> P^n (y|x) = product_(i=1)^n P(y_i|x_i) $
]

#def(name: "Error Correcting Code / Code-Words", count: false)[
  An error-correcting code (ECC), $cal(C)$ over the alphabet $FF_q$ of length $n$ is a subset $cal(C) subset FF_q^n$, for which its elements are called code-words.
]

#def(name: "Hamming Distance/Support/Weight", count: false)[
  - The Hamming distance is a distance on $FF_q^n$ defined as $                       d_H: FF_q^n times FF_q^n & -> NN \
    (vec(x_1, dots.v, x_n), vec(y_1, dots.v, y_n)) & |-> card(i in [|1, n|] | x_i != y_i) $
  - The support of $x in FF_q^n$ is defined as $supp(x) = {i in [|1, n|] | x_i != 0}$
  - The weight of $x in FF_q^n$ is defined as $wt(x) = card supp(x) = d_H (x, overline(0))$.
]

#def(name: "Minimum Distance", count: false)[
  The minimum distance of $cal(C) subset FF_q^n$ is defined as $d(cal(C)) := min{d(x,y) | x,y in cal(C), x != y}$.
]

#def(name: [$(n, M, d)$-Codes], count: false)[
  An $(n, M, d)$-code is a code $cal(C)$ of length $n$, minimum distance $d$ and $card C = M$.
]

#exm[
  + The repetition code: $cal(C) = {(alpha)_(i=1)^n | alpha in FF_q} subset FF_q^n$, the minimum distance is $d(cal(C)) = n$ and $card C = q$. This is a $(n, q, n)$-code.
  + The parity-code: $cal(C) = {(x_1, dots, x_n) | x_n = - sum_(i=1)^(n-1) x_i} subset FF_q^n$, $d(cal(C)) = 2$, $card C = q^(n-1)$, which is a $(n, q^(n-1), 2)$-code.
]

#def(name: "", count: false)[
  Let $cal(C) subset FF_q^n$ be a code, a decoder for $cal(C)$ is a map $ D: FF_q^n & -> FF_q^n union.sq {perp} \
          x & |-> D(x) = cases(
                x & "if" x in C,
                perp & "otherwise"
              ) $ where we call $perp$ the failure symbol.
]

- *Maximal Likelihood Decoder (LD)*: #h(1fr)$ D_m: FF_q^n & -> C union.sq {perp} \
            y & |-> D_m (y) = cases(
                  x & "if" x in {x | P(y|x) "is maximal"},
                  perp & "otherwise"
                ) $
- *Nearest-Codeword Decoder (NC)*: $ D_(N_c): FF_q^n & -> C union.sq {perp} \
                y & |-> D_(N_c) = cases(
                      x & "if" x in {x | forall x' in C, d_H (x, y) <= d_H (x', y)},
                      perp & "otherwise"
                    ) $

#thm(count: false)[
  In $q$-ary symmetric channel, under the assumption of the uniform distribution of the transmitted code-word message. Then the LD decoder and NC decoder are equivalent.
]

#section[Linear Codes]
#def(name: "Linear Code", count: false)[
  A linear code $cal(C) subset FF_q^n$ is a vector subspace of $FF_q^n$, its length is $n$, and its dimension is $k$.
]

#def(name: "", count: false)[
  A generator matrix for $cal(C)$ is a $k times n$ matrix $G$ whose rows are a basis of $cal(C)$.
]

If $G$ is a generator matrix for $cal(C)$, an encoding function on the set of messages $cal(M)$ is $c: M -> FF_q^n, x |-> x G$.

#def(name: "Systematic Form", count: false)[
  A generator matrix $G$ is in systematic form if it is of the form $G = [I_k | A]$, $A$ is $k times (n - k)$, in this case $(x_1, dots, x_k) |-> (x_1, dots, x_k, x_(k+1), dots, x_n)$.
]

#pro(count: false)[
  If $cal(C)$ is linear, then $d_H (x, y) = d_H (x - y, 0) = "wt"(x - y)$ and the minimum distance of $cal(C)$ is the smallest weight of $x in cal(C) \\ {0}$.
]

#ntt[
  If a code $cal(C)$ is linear, we denote it as an $[n, k, d]$.
]

#exm[
  + Trivial codes: $FF_q^n$ and any $cal(C)$ with $M = 1$. If $cal(C)$ is linear then $cal(C) = {0}$.
  + Repetition codes: $cal(C) = {(a, a, dots, a) | a in FF_q}$ dim $1$, basis ${(1, dots, 1)}$.
  + Parity codes: $cal(C) = {(x_1, dots, x_n) in FF_q^n | x_n = - sum_(i=1)^(n-1) x_i}$ with dim $n-1$, minimum distance $2$, basis $(e_i - e_n)_(i=1)^n$.
]

#pro(count: false)[
  A linear code $cal(C)$ with $d(cal(C)) = d$ can detect up to $d-1$ errors, and can correct up to $floor.l (d-1)/2 floor.r$ errors in a nearest-codeword decoder.
]

#def(name: "Dot Product/Orthogonal", count: false)[
  $FF_q^n$ is equipped with a symmetric bilinear form $FF_q^n times FF_q^n -> FF_q$ called the dot product defined as
  $dot.c: FF_q^n times FF_q^n &-> FF_q, (x, y) &|-> x dot.c y = sum_(i=1)^n x_i y_i$, we say that $x, y$ are orthogonal if and only if $x dot.c y = 0$.
]

#pro(count: false)[
  - $(x + x') dot.c (y + y') = x dot.c y + x dot.c y' + x' dot.c y + x' dot.c y'$.
  - $lambda (x dot.c y) = (lambda x) dot.c y = x dot.c (lambda y)$
]

#def(name: "Orthogonal Code", count: false)[
  The orthogonal code of $cal(C)$ is $cal(C)^perp = {x in FF_q^n | forall y in cal(C), x dot.c y = 0}$.
]

#pro(count: false)[
  Let $cal(C)$ be a linear code, then $cal(C)^perp$ is also a linear code.
]

#def(name: "Self-Orthogonal/Self-Dual/Hull", count: false)[
  Let $cal(C)$ be a linear code.
  - if $cal(C) subset cal(C)^perp$ then $cal(C)$ is self-orthogonal.
  - if $cal(C) = cal(C)^perp$ then $cal(C)$ is self-dual.
  - $cal(C) inter cal(C)^perp$ is the hull of $cal(C)$.
]

#pro(count: false)[
  $G = [I_k | A]$ is the generator matrix of a $[n, k, d]$ code $cal(C)$. Then $cal(C)^perp$ has a generator matrix of the form $[-A^T | I_(n-k)]$.
]

#def(count: false, name: "Parity-Check Matrix")[
  The generator matrix $H$ of $cal(C)^perp$ is called the parity-check matrix of $cal(C)$.
]

#cor(count: false)[
  If $cal(C)$ is a $k$-dimensional code, then $cal(C)^perp$ is $(n-k)$-dimensional.
]

#cor(count: false)[
  $(cal(C)^perp)^(perp) = cal(C)$
]

#def(name: "Syndrome", count: false)[
  Let $H=(h_1 | dots.c | h_n)$ be the parity-check matrix of a $k$-dimensional code $cal(C)$. We define the syndrome application associated with $H$ the map $ sigma: FF_q^n & -> FF_q^(n-k) quad quad
                  x & |-> sigma(x) = x H^t = sum_(i=1)^n x_i h_i $
]

#pro(count: false)[
  If $H$ is the parity-check matrix of $cal(C)$, then $d(cal(C))$ is the smallest number of linearly dependent codewords of $H$.
]

We can use the syndromes to do decoding. Suppose that we transmit the word $c in cal(C)$ and receive $y = c + e$ here $e$ is some error, then by finding $e$ with the smallest hamming weight such that $y - e in cal(C)$, and deduce $y$ to $y-e$. We start by computing the syndrome $s = sigma(y)$ and look for the smallest $J subset [|1, n|]$ such that $exists lambda_i in FF_q^star, i in J$ and $s = sigma(y) = sum lambda_i h_i$.. Since $sigma(c) = 0$ then we have that $sigma(y) = sigma(e)$, therefore the closest code-word to $y$ is $c$. Moreover, if $|J| < d\/2$ where $d$ is the minimum distance of the code, we show that $c$ is the unique closest code-word to $y$. Hence, we decode $y$ to $c$.

In practice, we create a list of syndromes $S$ and a list of $e$ minimal weight vectors such that $forall s in S, exists e in E, sigma(e) = s$. When we receive $y$, we compute its syndrome, find $s in S$, then take the corresponding vector $e$ to decode to $c = y - e$.

#section[Bounds]

#thm(name: "Singleton Bound", count: false)[
  For a $[n, M, d]$-code $cal(C)$, we always have that $M <= q^(n-d+1)$, in the case where $cal(C)$ is linear of dimension $k$, $k <= n - d + 1$.
]

#prf[
  Let $phi: cal(C) -> FF_q^(n-d+1)$, with its last $d-1$ components deleted. Suppose that $phi$ is not injective, we have two different codewords $c_1$ and $c_2$ that only disagree in the last $d-1$ components, that is $d_H (c_1, c_2) <= d - 1$ which is a contradiction since the minimum distance is $d$. Thus, $phi$ is injective, hence, $card cal(C) <= card q^(n-d+1)$. If $cal(C)$ is linear, then $phi$ is linear, thus $dim(cal(C)) = k <= n - d + 1$.
]

The codes that achieve this bound are called Maximum Distance Separable.

#thm(name: "Asymptotic Gilbert-Varsheimov Bound (GV)", count: false)[
  For any rational number $kappa in [0, 1]$, there exist a family of linear codes indexed by length ${C_n}_(n=1)^infinity$ with $k/n=kappa$ such that the quantity $delta = liminf_(n -> infinity) d(C_n)/n$ satisfies $kappa >= 1 - h(delta)$ where $h$ is the entropy function which is in the case $q=2$ defined as $h(delta) = delta log_2 (1/delta) + (1 - delta) log_2 (1/(1-delta))$ and in general as $h(delta) = delta log_q ((q-1)/delta) + (1-delta) log_q (1/(1-delta))$.
]

In general, an infinite family of codes $C_n$ such that $k_n/n -> kappa$ will meet the bound with equality for large $n$ with probability $1$.

#section[Reed-Solomon Codes]
Let $k in NN_(>0)$ and consider the vector space $FF_q [X]_(< k) = {P in FF_q [X] | deg P < k}$, Let $x = {x_1, dots, x_n} subset FF_q$ with $i != j => x_i != x_j$.

#def(name: "Reed-Solomon Code", count: false)[
  Consider the evaluation function $ "ev": FF_Q [X]_(<k) & -> FF_q^n quad
                        P & |-> (P(x_1), dots, P(x_n)) $ Then we define the Reed-Solomon code as $"RS"_k (x) = "ev"(FF_q [X]_(<k))$.
]


#thm(count: false)[
  Let $k <= n$, then $"RS"_k (x)$ is a $[n, k, n+1-k]$-linear code. In particular, it is an MDS.
]

#prf[
  Linearity follows as $"RS"_k$ is the image of a vector space through a linear map. The length is clearly $n$, $dim FF_q [X]_(<k) = k$ which has basis ${1, X, dots, X^(k-1)}$. $"ev"(P) = (0, dots, 0) => P(x_1) = dots.c = P(x_n) = 0$, but since $n >= k$ then necessarily $P = 0$ so $"ev"$ is injective, thus we have that $"dim"_(FF_q) "RS"_k (x) = k$. Let $c in "RS"_k (x)$, then $c = "ev"(P)$ for some $P in FF_q [X]_(<k)$, $"wt"(c) = card {i | P(x_i) != 0} = n - card {i | P(x_i) = 0} >= n - (k - 1) = n - k + 1$ and by the Singleton bound, we have that $d = n + 1 - k$, so it is an MDS code.
]

#colbreak()
#pro(count: false)[
  Reed-Solomon code with generator matrix given by $ G = mat(
    1, 1, 1, dots.c, 1;
    x_1, x_2, x_3, dots.c, x_n;
    x_1^2, x_2^2, x_3^2, dots.c, x_n^2;
    dots.v, dots.v, dots.v, dots.down, dots.v;
    x_1^(k-1), x_2^(k-1), x_3^(k-1), dots, x_n^(k-1)
  ) in FF_q^(k times n) $
]

Let $X$ be an algebraic projective geometrically irreducible smooth curve of genus $g$ defined over $FF_q$.

Let $D = sum_(P in X) n_P dot.c (P) in "Div"(X)$. The space $ L(D) = {f in FF_q (X) \\{0} | forall P in X, "ord"_P (f) + n_P >= 0} union {0} $ in a finite field, we have $deg D = sum_(P in X) n_P deg P$. Riemann's inequality states that $l(D) >= "deg" P + 1 - g$. Consider $X(FF_q)$ be the set of rational points of $X$.

#def(count: false, name: "Algebraic Geometry Code")[
  Let $cal(P) = {P_1, dots, P_n} subset X(FF_q)$, let $D in "Div"(X)$, $cal(P) inter "Supp"(D) = emptyset$ and consider the evaluation $ "ev": L(D) & -> FF_q^n quad f & |-> (f(P_1), dots, f(P_n)) $ Then, the algebraic geometry code $"AG"(X, D, cal(P))$ is $"ev"(L(D))$.
]

#thm(count: false)[
  Let $"deg" D <= n$ then $"AG"(X, D, cal(P))$ is an $[n,k,d]$ with $k = l(D)$ and $d >= n - deg(D)$.
  We have that $n <= card X(FF_q) <= q + 1 + 2g sqrt(q)$.
]

#thm(count: false, name: "TVZ")[
  Let $q = p^(2m)$, $p$ prime, for any rate $kappa in [0, 1]$ there exists a sequence of $"AG"$ codes whose length goes to infinity and where $(kappa, delta)$ satisfy $kappa + delta >= 1 - 1/(p^m - 1)$ with $kappa = k/n, delta = d/n$.
]

#colbreak()
#exm[
  - Consider $FF_4 = FF_2 [X] \/ ((X^2 + X + 1)) = {0, 1, alpha, alpha + 1}$, $k = 2$ then we have $FF_q [X]_(< 2) = {beta_0 + beta_1 X | beta_0, beta_1 in FF_4} = chevron.l 1, X, chevron.r$, $"ev"(1) = (1, 1, 1, 1)$, $"ev"(X) = (0, 1, alpha, alpha+1)$, which would give a generator matrix $
      G = mat(1, 1, 1, 1; 0, 1, alpha, alpha + 1).
    $
  - Let $E: y^2 = x^3 + 3 x$ over $FF_5$, $card E(FF_5) = 10$, let $D = 5 (infinity) in "Div"(E)$. Let $L(D) = {f in FF_4 (E) | "ord"_p (f) >= 0, forall P != infinity, "ord"_p (f) >= -5} = chevron.l 1, x, x^2, y, x y chevron.r$. Take $cal(P) = E(FF_5)\\{infinity}$.
]
