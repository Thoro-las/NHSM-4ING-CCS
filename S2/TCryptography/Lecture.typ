#import "@preview/commute:0.3.0": node, arr, commutative-diagram

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Theory Of Cryptography",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures given by Dr. OUDJIDA.],
  )
)

#let card = math.op("#")
#let iso = $tilde.equiv$
#let RSA = math.op("RSA")

#chapter[Introduction][
  Cryptography is the study of securing information so that the only parties that are authorized are able to access it. Multiple algorithms using difficult to solve problems from the theory of complexity to ensure data security in transmission. Here we will see the most known algorithms.
]

#ooc[
  #section[Secret & Public Key Cryptography]
  Imagine you and a friend would like to exchange objects on a daily basis, such that no one else can access it. So you think of two ideas:
  - First, you will both have a single chest, and both of you have the key for it, and you can access it anytime you want while others are not allowed to given they do not have the key.
  - Second, each of you will have their own chest and their own key that can be opened with it, while all the others have a key to close it. When you go to send an object to your friend, you put it in their chest and close it. No one except him can access the contents of the chest, and the same if he wants to send an object for you.
  Both of those ideas are ways to do cryptography, the first being a secret key cryptography, that is, all parties have a secret key they use to encrypt and decrypt data with it. While the second is public key cryptography, each user in the network has a private / public key pair, other users use the public key to encrypt the data while the private key is used to decrypt it.
]

#section[Mathematical Tools]
#thm(name: "Fermat's Little Theorem")[
  Let $p$ be a prime number and $a$ an integer such that $gcd(a, p) = 1$ then $a^(p-1) equiv 1 mod p$.
]
Notice that this can be used as a weak primality test, if a number $q$ does not satisfy this identity, that is, $exists a in NN, gcd(a, q) = 1 "and" a^(q-1) equiv.not 1 mod q$ then $q$ is not prime. If $a^(q-1) equiv 1 mod q$, we cannot conclude the primality of $q$, such numbers are called Carmichael numbers, and there exists infinitely many of them.

#def(name: "Euler Totient Function")[
  The Euler totient function is the function $Phi: NN -> NN$ defined as $
    Phi(n) = card {k in [|1, n|] | gcd(k, n) = 1} = card (ZZ_n^*)
  $
]

#ooc[
  #lem(count: false)[
    Let $r, m, p in NN$ where $p$ is prime, then $gcd(m, p^r) != 1 <=> p divides m$
  ]

  #prf[
    $=>$ let $d = gcd(m, p^r)$, since $d | p^r$ and $p$ is prime then $d = p^k$ for some $k in NN$, and $p^k = d | m$ thus $p | p^k$ and $p^k | m$ so $p | m$. $arrow.double.l$ suppose that $p | m$ and since $p | p^r$ too then $p | gcd(m, p^r)$ given $p > 1$ then $gcd(m, p^r) != 1$.
  ]

  #lem(count: false)[
    Let $m, n, k in ZZ$, $gcd(m, n) = 1$ then $ gcd(m n, k) = 1 <=> gcd(m, k) = 1 "and" gcd(n, k) = 1. $
  ]

  #prf[
    $=>$ Suppose that $gcd(m n, k) = 1$, if $gcd(m, k) != 1$ then there is a prime $p$ such that $p | k$ and $p | m$, thus $p | m n$ too, so $p | k$ and $p | m n$, therefore, $p | gcd(m n, k) => p = 1$, contradiction. $arrow.double.l$ Suppose that $gcd(m, k) = 1$ and $gcd(n, k) = 1$, by contradiction, assume that $gcd(m n, k) != 1$ then $exists p$ prime such that $p | m n$ and $p | k$, given that it is a prime then $p | m$ or $p | n$ which results in either $gcd(m, k) != 1$ or $gcd(n, k) != 1$, contradiction.
  ]
]

#pro[
  + If $p$ is prime, then $phi(p^r) = p^r (1 - 1/p)$.
  + If $a, b$ are coprime, $phi(a b) = phi(a) phi(b)$.
]

#ooc[
  #prf[
    + Let $p, r in NN$ with $p$ prime. From the lemma, we have that for $m in NN$, $gcd(p^r, m) = 1 <=> p divides.not m$, the numbers that are divisible by $p$ in $[|0, p^r - 1|]$ are of the form $k p$ where $k in [|0, p^(r-1) - 1|]$, so the number of numbers that are divisible by $p$ in $[|0, p^r - 1|]$ is $p^r - p^(r-1)$ so $phi(p^r)=p^r - p^(r-1)$.
    + $
      phi(a b) &= card {k in [|1, a b|] | gcd(k, a b) = 1} \ &= card {k in [| 1, a b |] | gcd(k, a) = 1 "and" gcd(k, b) = 1} \ &= card ({k in [|1, a b|] | gcd(k, a) = 1} inter {k in [|1, a b|] | gcd(k, b) = 1}) \ &= sum_(i=1\ gcd(i, a) = 1)^a sum_(j = 1\ gcd(j, b) = 1)^b 1 = phi(a) dot.c phi(b)
    $
  ]
]

#ooc[
  #lem[
    Let $n in NN$, $x in (ZZ\/n ZZ)^*$ (invertible) $<=>$ $gcd(x, n) = 1$.
  ]

  #prf[
    $=>$ Suppose that $x in (ZZ\/n ZZ)^*$, then $exists y in ZZ\/n ZZ$ such that $x y = 1 mod n$, then $x y = 1 + k n => x y - k n = 1$ by Bezout theorem we have $gcd(x, n) = 1$. $arrow.double.l$ Suppose that $gcd(x, n) = 1$, by Bezout theorem, $exists y, k in ZZ, x y + k n = 1$ and thus $x y + k n = 1 mod n => x y = 1 mod n$ so $x in (ZZ\/n ZZ)^*$.
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

  #lem[
    Let $a_1, dots, a_k, x in ZZ$ such that $forall i != j, gcd(a_i, a_j) = 1$, and $forall i in [|1, k|], a_i | x$ then $product_i a_i | x$.
  ]

  #prf[
    We prove it by induction on $k$.
    - $k = 2$: Since $a_1 | x$ then $x = a_1 m$ for some $m in ZZ$, then we have that $a_2 | x => a_2 | a_1 m$, given that $gcd(a_1, a_2) = 1$ then by Euclid's lemma we have that $a_2 | m$ so both $m = a_2 t$, replacing in $x$ we get that $x = a_1 m = a_1 (a_2 t) = (a_1 a_2) t$ thus $a_1 a_2 | x$.
    - Suppose it is true for $k$: we have then $a_(k+1)$ and $a_1 dots.c a_k$ are coprime, from the first case we have that $a_1 dots.c a_(k+1) | x$.
    Therefore, we deduce that $product_i a_i | x$.
  ]

  #thm(name: "Chinese Remainder Theorem")[
    Let $n_1, dots, n_k$ be pairwise coprime numbers and $N = n_1 dots.c n_k$ then $
      ZZ\/N ZZ iso ZZ\/n_1 ZZ times ZZ\/n_2 ZZ times dots.c times ZZ\/n_k ZZ
    $
  ]

  #prf[
    Consider the map $phi: ZZ -> product_i ZZ\/n_i ZZ, x |-> (x mod n_1, dots, x mod n_k)$, $phi$ is clearly a well-defined ring homomorphism. Let $x in ker phi$ then $forall i in [|1, k|], x equiv 0 mod n_i$, from our lemma, we deduce that $N | x$, equivalently, if $N | x$, then $forall i in [|1, k|], n_i | x$ so $ker phi = N ZZ$. To prove that $phi$ is surjective, consider $(a_1, dots, a_k) in ZZ\/n_1 ZZ times dots.c ZZ\/n_k ZZ$, define $N_i = N \/ n_i$, we have that $gcd(N_i, n_i) = 1$ thus $exists u_i, u_i N_i equiv 1 mod n_i$, by taking $x = sum_(i=1)^k a_i u_i N_i$ we obtain that $phi(x) = (a_1, dots, a_k)$ thus $phi$ is surjective. Using the first isomorphism theorem, we get that $ZZ\/N ZZ iso product_i ZZ\/n_i ZZ$.
  ]
]

#cor(name: [CRT / System Of Congruences])[
  Let $n_1, dots, n_k$ pairwise coprime integers, $N = n_1 dots.c n_k$, and $a_1, dots, a_k$ be integers, then $
    cases(
      x &= a_1 mod n_1,
      x &= a_2 mod n_2,
      & space dots.v,
      x &= a_k mod n_k,
    )
  $ has a unique solution for $x$ as follows $
    N_i = N\/n_i quad quad u_i N_i equiv 1 mod n_i \
    x = sum_(i=1)^k a_i u_i N_i mod N
  $
]

#chapter[RSA Cryptosystem][
  Here we introduce the most known cryptosystem, the RSA, which is an algorithm that depends on the difficulty of factorizing a number into its divisors.
]

#section[Mathematical Formulation Of RSA]
#thm[
  Let $p, q in NN$ be two primes, $n = p q$, $e in NN$ such that $gcd(e, phi(n)) = 1$ and $d in NN, e d equiv 1 mod phi(n)$. Then for any $m in NN$ we have that if $c equiv m^e mod n$ then $m equiv c^d mod n$.
]

#prf[
  Let $c equiv m^e mod n$, we have first that $e d equiv 1 mod phi(n)$ thus $e d = phi(n) k + 1$, then $c^d equiv (m^e)^d equiv m^(e d) equiv m^(phi(n) k + 1) equiv (m^(phi(n)))^k m equiv m mod n$, in the last equality we used Euler's theorem to have that $m^(phi(n)) equiv 1 mod n$.
]

Notice that we obtain the class of $m$ after the decryption, so to make this mapping unique, we consider the message space to be $[|0, n-1|]$ thus the mapping $f(m) = m^e mod n$ becomes a bijection.

#section[Algorithmic Implementation Of RSA]
#alg(count: false)[
  - *Key Generation:*
    + Generate $p, q$ prime numbers.
    + Calculate $n = p q$.
    + Calculate $phi(n) = (p-1)(q-1)$.
    + Generate $e$ such that $gcd(e, phi(n)) = 1$.
    + Calculate $d$ such that $e d equiv 1 mod phi(n)$.
    + Public Key: $e, n$, Private Key: $p, q, d$.

  - *Encryption:*
    + Let $m in NN$ be a message.
    + If $m > n$, divide it into parts that are.
    + Encrypt $RSA_(e, n) equiv m^e mod n$.

  - *Decryption:*
    + Let $c in NN$ an encrypted message.
    + Decrypt $RSA^(-1)_(d, n) equiv m^d mod n$.
]

The correctness of this algorithm comes from the previous theorem and the fact that we consider only message of length at most $n - 1$ to have uniqueness.

#subsection[Optimization Methods]
Notice that in both encryption and decryption, we use modular exponentiation, that is, we calculate $a^b mod n$ for some $a, b, n in NN$. We have the following proposition that makes this calculation easier.

#pro(count: false)[
  Let $a, b, n in NN$, and let $b = b_1 + dots.c + b_k$, then $
    a^b equiv (product_(i=1)^k (a^(b_k) mod n)) mod n
  $
]

#ooc[
  #prf[
    We start by proving that $a b equiv (a mod n) (b mod n) mod n$, indeed, we have that $a = n q_a + r_a$ and $b = n q_b + r_b$ with $0 <= r_a < q_a, 0 <= r_b < q_b$ by the Euclidean division, thus $a b = (n q_a + r_a) (n q_b + r_b) = n^2 q_a q_b + n (q_a r_b + q_b r_a) + r_a r_b$ and notice that $r_a = a mod n$ and $r_b = b mod n$ thus $a b equiv r_a r_b = (a mod n) (b mod n) mod n$. By induction we have that $(product_i a_i) mod n = (product_i (a_i mod n)) mod n$.

    We have $a^b = a^(b_1 + dots.c + b_k) = product_(i=1)^k a^(b_i)$, and by the previous point, we have that $a^b equiv (product_(i=1)^k a^(b_i)) equiv (product_(i=1)^k (a^(b_i) mod n)) mod n$.
  ]

  Notice that using this, if we consider an improved decomposition of $b$, we can get an optimization in the calculation of the modular exponentiation over the naive approach of just repeated multiplication $mod n$. We consider in this case the binary decomposition $b = sum_(i=0)^k b_i 2^i$ with $b_i in {0, 1}$. Thus, we get $
    a^b = a^(sum_(i=0)^k b_i 2^i) = product_(i=0)^k a^(b_i 2^i) = product_(i=0)^k (a^(2^i))^(b_i)
  $ and so we get $
    a^b equiv (product_(i=0)^k (a^(2^i))^(b_i) mod n) mod n
  $ so the only factors that matter is when $b_i = 1$, and we have $a^(2^(i+1)) = (a^2^i)^2$. Hence, we get the following algorithm for calculating the modular exponential.
]

```pcode
procedure SquareAndMultiply:
  input: 
    - base: a
    - exponent: b
    - modulus: n
  output:
    - c = a^b mod n

  algorithm:
    res = 1
    base = a % n

    while b > 0:
      if b % 2 = 1:
        res = (res * base) mod n

      base = (base * base) mod n
      b = b / 2

    return res
```

#ooc[
  As discussed before, base here refers to $a^(2^i)$ in each iteration it is squared, and we add it as a factor of the product of the result if and only if $b equiv 1 mod 2$ which is equivalent to saying $b_i = 1$. Now to prove the efficiency, let's calculate the complexity of each methods.
]

#pro(count: false)[
  The complexity of the algorithms is as follows:
  - Naive Exponentiation: $O(b)$.
  - Binary Exponentiation (Square-And-Multiply): $O(log(b))$.
]

#ooc[
  #prf[
    In the calculation of complexity, we consider that the multiplication of two arbitrary numbers is $O(1)$ which is a simplification.
    - We multiply $a$ by itself $b-1$ times, thus the loop has $O(b)$ steps.
    - When we turn a number $b$ into its binary representation, we have $log_2 (b)$ digits and given that we do $log_2 (b)$ iterations in the algorithm, and each iteration has at most 3 operations then it is of order $O(log_2 b)$.
  ]

  This is asymptotically optimal, since any algorithm would need to read $log_2 (b)$ digits at least thus binary exponentiation is optimized.
]

#ooc[
  Another optimization that we can do is in the decryption which is a computationally expansive procedure given that it will be a huge number to the power of another huge number, thus we use the Chinese Remainder Theorem to simplify the calculations by a divide-and-conquer algorithm.
]

#pro(count: false)[
  With the same context as Theorem 2.1.1, let $m_p equiv c^d mod p$ and $m_q equiv c^d mod q$, let $q' in ZZ$ such that $q' q equiv 1 mod p$ then we have $
    m equiv (m_q + q dot.c (q' (m_p - m_q) mod p)) mod n
  $
]

#ooc[
  #prf[
    We use the CRT to find $m$ that satisfies $m equiv m_p mod p$ and $m equiv m_q mod q$. We start from the first equation that $m = m_q + q dot.c k$, by replacing in the second equation we have that $m_q + q dot.c k equiv m_p mod p => q dot.c k equiv m_p - m_q mod p => k equiv q' (q k) equiv q' (m_p - m_q) mod p$, by replacing in the second equation $m = m_q + q dot.c (q' (m_p - m_q) mod p)$ and thus we get the class of $m$ being $m_q + q dot.c (q' (m_p - m_q) mod p) mod n$.
  ]
]

#exr(count: false)[
  Explain the deterministic nature of the RSA algorithm. Discuss whether this property is an advantage or a disadvantage.
]

RSA is clearly deterministic, which is disadvantageous given that sending repeated message or having a small message space results in the same ciphertexts thus giving information to the attacker. More specifically, we say that it is not semantically secure, which is defined as follows.

#def(name: "Semantic Security", count: false)[
  An encryption scheme is semantically secure if knowing the ciphertext does not give an attacker any information about the plaintext.
]

To solve this problem, we make a new method adding some randomness to the process of encryption, RSA-OAEP is an example of such a method. Another weakness that comes from the mathematical formulation of the RSA is the malleability, also called the multiplicative property, which comes from the fact that given two message $m_1, m_2$, we have $
  RSA_(e, n) (m_1) dot.c RSA_(e, n) (m_2) equiv RSA_(e, n) (m_1 m_2) mod n
$
