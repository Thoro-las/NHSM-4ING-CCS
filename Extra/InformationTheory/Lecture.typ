#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Information Theory & Error Correcting Codes],
    writer: "HADIOUCHE Azouaou",
    hide-page: true,
  ),
)

#let card = math.op("#")
#let subset = $subset.eq$

#counter("title-counter").update(2)
#chapter([Channel Coding])[
  Coding has two parts, the source coding and channel coding, the first handles how to compress data to get the least redundancy possible while containing all information to get exactly the same message. Channel coding on the other hand, adds redundancy in way to make it more resilient to noise affecting the signal.
]

#section[What Is A Channel?]
Suppose you have a transmission medium, where given a stream of symbols $X^n$ from an alphabet $cal(X)$, it can transport it to a stream of symbols $Y^n$. The way it transmits can be affected by randomness. We will call the transmission medium a channel, as it takes information from an input and moves it to an output.

To formalize the idea of a channel, we can think of a simple example. Suppose you are typing on a keypad, you will represent the sender, the keypad would be the receiver, and your hand would be the channel. There is a non-zero chance that you will do a mistake and write an unwanted symbol, what we would like to know, is the probability of for example clicking $3$ by mistake when you wanted to type $6$. If we represent the wanted key as a random variable $X$ and the pressed key as $Y$, the question becomes really easy in this case, we just want to calculate the probability $P(Y = 3|X = 6)$. So, in general, when considering any channel, it is best to know what is the behavior of the conditional probability $P(Y|X)$.

#def(name: "Channel")[
  A channel is a conditional probability $P(y|x)$, describing the probability of receiving an output $y$ when sending an input $x$ called the transition probability.
]


#def(name: "Discrete Channel")[
  A channel is said to be discrete if the random variables describing the input and output both are discrete, that is, they have values in finite sets $cal(X) = {x_1, dots, x_n}$ and $cal(Y) = {y_1, dots, y_m}$ of symbols, in this case, the transition probability is a matrix of the following form $ Q = mat(
    P(y_1|x_1), P(y_2|x_1), dots.c, P(y_m|x_1);
    P(y_1|x_2), P(y_2|x_2), dots.c, P(y_m|x_2);
    dots.v, dots.v, dots.down, dots.v;
    P(y_1|x_n), P(y_2|x_n), dots.c, P(y_m|x_n);
  ) $ and we define the channel as the triplet $cal(C) = (cal(X), P(Y|X), cal(Y))$.
]

#def(name: "Discrete Memoryless Channel")[
  A discrete channel is said to be memoryless if for $x=(x_1, dots, x_n)$ and $y=(y_1, dots, y_n)$ we have $ P(y|x) = product_(i=1)^n P(y_i|x_i) $ that is, the distribution of the output only depends on the input and not previous channel inputs or outputs.
]


Most of the remaining of the course will focus mainly on discrete memoryless channels as in they are the simplest types of channels and are more enough for practical purposes in general.

#exm[
  - *Binary Noiseless Channel:* a noiseless channel is a channel where we have that $P(y=b|x=b) = 1$, that is, the transmission is perfect.
    #align(center)[
      #diagram(
        node((0, 0), $0$, name: "00"),
        node((3, 0), $0$, name: "01"),
        node((0, 0.7), $1$, name: "10"),
        node((3, 0.7), $1$, name: "11"),

        edge(label("00"), label("01"), "->", label: $1$),
        edge(label("10"), label("11"), "->", label: $1$),
      )
    ]
  - *Binary Useless Channel:* given any input, it returns $0$, it is useless as it can't pass information, which will reexplained later.
  - *Noisy Binary Channel:* given $0 <= p, q < 1$ and we have the following transition matrix $ Q = mat(1 - p, p; q, 1 - q) $ this channel represents a binary channel where $0$ has probability $1 - p$ of getting flipped to one, and $1$ has probability $1 - q$ of getting flipped to zero.
    #align(center)[
      #diagram(
        node((0, 0), $0$, name: "00"),
        node((3, 0), $0$, name: "01"),
        node((0, 1), $1$, name: "10"),
        node((3, 1), $1$, name: "11"),

        edge(label("00"), label("01"), "->", label: text(fill: green, $1-p$), stroke: green),
        edge(
          label("10"),
          label("01"),
          "->",
          label: text(fill: red, $q$),
          stroke: red,
          label-pos: 70%,
          label-sep: 0pt,
        ),
        edge(
          label("00"),
          label("11"),
          "->",
          label: text(fill: blue, $p$),
          stroke: blue,
          label-pos: 65%,
          label-sep: -15pt,
        ),
        edge(label("10"), label("11"), "->", label: text(fill: purple, $1-q$), stroke: purple, label-sep: -20pt),
      )
    ]

  - *Binary Symmetric Channel:* this channel represents the most intuitive idea of a noisy binary channel, where we consider just a noisy binary channel with $p = q$, that is, the probability of getting a flip for $1$ and $0$ is the same.
    #align(center)[
      #diagram(
        node((0, 0), $0$, name: "00"),
        node((3, 0), $0$, name: "01"),
        node((0, 1), $1$, name: "10"),
        node((3, 1), $1$, name: "11"),

        edge(label("00"), label("01"), "->", label: text(fill: green, $1-p$), stroke: green),
        edge(
          label("10"),
          label("01"),
          "->",
          label: text(fill: red, $p$),
          stroke: red,
          label-pos: 70%,
          label-sep: -2pt,
        ),
        edge(
          label("00"),
          label("11"),
          "->",
          label: text(fill: red, $p$),
          stroke: red,
          label-pos: 65%,
          label-sep: -15pt,
        ),
        edge(label("10"), label("11"), "->", label: text(fill: green, $1-p$), stroke: green, label-sep: -20pt),
      )
    ]
  - *Binary Erasure Channel:* this channel models the phenomenon of having an erasure or a corruption of data in the channel, where we have a way to recognize where the erasure has happened. We consider $cal(X) = {0, 1}$ and $cal(Y) = {0, 1, perp}$ where $perp$ denotes the erasure, and the following transition matrix.
    #align(center)[
      #grid(
        columns: (1fr, 1fr),
        align: center + horizon,
        $ Q = mat(1-p, p, 0; 0, p, 1-p) $,
        diagram(
          node((0, 0), $0$, name: "00"),
          node((3, 0), $0$, name: "01"),
          node((3, 0.3), $perp$, name: "p"),
          node((0, 0.6), $1$, name: "10"),
          node((3, 0.6), $1$, name: "11"),

          edge(label("00"), label("01"), "->", label: text(fill: green, $1-p$), stroke: green),
          edge(label("10"), label("p"), "->", stroke: red, label-pos: 80%, label-sep: -2pt),
          edge(
            label("00"),
            label("p"),
            "->",
            label: text(fill: red, $p$),
            stroke: red,
            label-pos: 50%,
            label-sep: -14pt,
          ),
          edge(label("10"), label("11"), "->", label: text(fill: green, $1-p$), stroke: green, label-sep: -20pt),
        ),
      )
    ]
]

#section[Noise & Redundancy]

We have seen some examples of channels, the question that comes to mind is how and when is a reliable communication establishable. Consider the binary symmetric channel with probability $p$ of flipping a bit. When sending a single bit $x$, there is a chance that the received bit would be $overline(x)$. To avoid such an error, we can think of sending the same bit multiple times and then do a majority vote to decide which bit has been sent. So the encoding function is $x |-> x^n$ for some fixed $n$, and the decoding function is $(y_1, dots, y_n) |-> 1$ if $card 1(y_i) > card 0(y_i)$ and $0$ otherwise. Notice now that when we have $1$ error and $n >= 3$, we can determine and correct the error just with those encoding and decoding functions. From Algebra & Coding lectures, we know that we can detect up to $n/2$ errors, and thus, the probability of actually making an error in a BSC is $ P_e (n) = sum_(k=ceil.l n\/2 ceil.r)^n binom(n, k) p^k (1-p)^(n-k). $
By taking $p = 0.1$ for example we get the following probabilities for $n$ errors.
#align(center)[
  #box(width: 80%, table(
    columns: (1fr,) * 6,
    $n$, $1$, $3$, $5$, $7$, $9$,
    $P_e (n)$, $0.1$, $0.0280$, $0.0085$, $0.0027$, $0.0008$,
  ))
]
All beautiful, $P_e$ is decreasing by Chernoff's bound and converges to $0$ when $n$ tends to infinity. But notice that we have a trade-off, to reduce the possibility for an error happening, we reduced in the rate of transmission, that is, to just receive one symbol, we need to send $n$ bits, thus giving us a rate of $1\/n$ bits per symbol. The problem with this scheme is that the more errors we want to fix, we lose rate. The question now is the following "If we take a rate $R$, how much can we reduce the probability of errors.", which is answered by Shannon's Channel Coding Theorem.

Before that, we formalize the ideas and the question we have until now with the following definitions. We start by defining a communication system using those channels, which will represent how a real communication system would look and interact like and how codes work in such a system.

#def(name: "Communication System")[
  Let $cal(C) = (cal(X), P(Y|X), cal(Y))$ be a discrete channel.
  - A message $W$ drawn from an index set $[|1, M|]$.
  - A sender sequence $X^n (W)$.
  - A receiver sequence $Y^n tilde P(Y^n|X^n)$.
  - A decoding function $hat(W) = g(Y^n)$.
  #align(center)[
    #diagram(
      edge-stroke: 0.3mm,
      node-corner-radius: 0pt,
      edge-corner-radius: 8pt,
      mark-scale: 70%,
      node-stroke: 0.2mm,

      node((0.3, 0), name: "2", [Encoder\ $X^n (M)$]),
      node((1.7, 0), name: "3", [Channel\ $cal(C)$]),
      node((2.9, 0), name: "4", [Decoder\ $g(Y^n)$]),

      edge((-1, 0), label("2"), "-|>", label: $W$),
      edge(label("2"), label("3"), "-|>", label: $X^n$),
      edge(label("3"), label("4"), "-|>", label: $Y^n$),
      edge(label("4"), (4, 0), "-|>", label: $hat(W)$),
    )
  ]

  An error happens when $hat(W) != W$.
]

#def(name: [$(M, n)$-Code])[
  Let $cal(C) = (cal(X), P(Y|X), cal(Y))$ be a discrete channel, an $(M, n)$-code consists of the following:
  - An index set $[|1, M|]$.
  - An encoding function $X^n: [|1, M|] -> cal(X)^n$, which gives codewords $x^n (1), x^n (2), dots, x^n (M)$, we call the set of codewords the codebook.
  - A decoding function $g: cal(Y)^n -> [|1, M|]$ which assigns a guess $hat(W)$ of what message was sent $W$.
  We define the rate of the code $R = log(M)\/n$.
]

The rate of an $(M, n)$ code represents how many bits of information are needed for a single message $M$ to be sent.

#exm[
  - Consider for example a set of messages with $M = 2$ and $n = 10$, what we mean is that for each message we need a block of $10$ symbols in the transmission to send $1$ bit, if we calculate the rate it would be $log(2)/10 = 1/10$ bit per transmission, so we take $9$ extra bits to counter the noise from the channel.
  - We take the previously stated example of repetition code, with $n = 3$, we have that $M = 2$ since we just send a bit, which has values $0$ or $1$, the encoding function would be as follows $x^3 (0) = 000$ and $x^3 (1) = 111$ and $g$ to be a majority vote decoder, the rate would be $log(2)/3 = 1/3$ bit per transmission which is indeed what we found before.
]

#def(name: "Conditional Probability Error")[
  Consider an $(M, n)$-code, we define the conditional probability error of index $i in [|1, M|]$ as $ lambda_i^((n)) = P(g(Y^n) != i|X^n = x^n (i)) $
]

The conditional probability is meant to represent the probability of getting an error on message $i$, which naturally gives us a way to define what is the most probable error we can get while decoding.

#def(name: "Maximal/Average Probability Of Error")[
  The maximal probability of error $lambda^((n))$ for an $(M, n)$-code is $ lambda^((n)) = max_(i in [|1, M|]) lambda_i^((n)) $ and the average probability of error $P_e (n)$ as $ P_e (n) = 1/M sum_(i=1)^M lambda_(i)^((n)) $
]

#def(name: "Achievable Rate")[
  A rate $R$ is said to be achievable if there exists a sequence of $(2^(n R), n)$-codes such that $lambda^((n)) -->_(n -> infinity) 0$.
]

#def(name: "Channel Rate Capacity")[
  The rate capacity of a channel is the supremum of all achievable rates.
]

Now we have all definitions needed, we can describe the problem in a formal way.

#align(center)[_ Which rates $R$ are achievable? _]


#section[Channel Information Capacity]
As we discussed before, the mutual information of two variables $X$ and $Y$ represents how much information is shared between the two variables $X$ and $Y$. Statistically speaking, this represents how much $Y$ correlates with $X$. If the channel is noiseless, we have that $I(X;Y) = H(X)$ which signifies that all the information has been passed without any noise, while $I(X;Y) = 0$ just means that $Y$ is independent of $X$ thus no information has been passed at all.

Notice that the more information that can be passed, the better the channel is. But given a channel, we can never change $P(y|x)$ since it comes from the physical implementation of the channel. So the only parameter we have to improve the mutual information in a channel is the distribution of $X$, since $I(X;Y)= H(X) - H(X|Y)$. Thus, we define the following bound.
#def(name: "Channel Information Capacity")[
  Let $cal(C)$ be a channel, $X, Y$ represent the random variables of input and output respectively. We define the channel capacity as the distribution of $X$ that maximizes the information that can be passed through it, that is,
  $
    C_(cal(C)) = max_(P(x)) I(X; Y)
  $
]

To appreciate this definition, we consider the following two examples. Start with the useless binary channel $cal(C)$, we have that $P(Y = 0|X = x) = 1$ for any $x$ and thus $I(X;Y) = 0$ since $X perp Y$, therefore $C_(cal(C)) = 0$, hence this channel is useless, since it indeed cannot send any information. Now suppose we have a noiseless channel $cal(C)'$, and a sender always sends $X = 0$, we will also have $I(X;Y) = 0$, which is a misuse of the channel. To get the best from the channel, we consider a distribution that maximizes the information.

#exm[
  - *Capacity Of Binary Symmetric Channel:* Consider a BSC $cal(C)$ with probability of a bit flip $p$, we have $ I(X; Y) & = H(Y) - H(Y|X) \
            & = H(Y) - sum_(x in X) P(x) H(Y|X=x) \
            & =^((a)) H(Y) - sum_(x in X) P(x) H(p) \
            & = H(Y) - H(p) <=^((b)) 1 - H(p) $
    where in $(a)$ we used the fact that $Y|X = x$ is a Bernoulli distribution and thus its entropy is $H(p) = - p log p - (1 - p) log (1-p)$ and $(b)$ the fact that $Y$ is a binary random variable thus $H(Y) <= 1$ which is attained only if $Y$ has a uniform distribution. And thus we get that $C_(cal(C)) = 1 - H(p)$.
  - *Capacity Of Binary Erasure Channel:* Consider a BEC $cal(C)$ with probability $p$ of having an erasure, we have $ I(X; Y) & = H(Y) - H(Y|X) \
            & = H(Y) - sum_(x in X) P(x) H(Y|X=x) \
            & = H(Y) - sum_(x in X) P(x) H(p) = H(Y) - H(p) $
    If we denote $pi = P(X = 1)$, we have that $H(Y) = H(p) + (1-p)H(pi)$, and hence $I(X; Y) = (1-p)H(pi) <= 1 - p$ with equality satisfied when $pi = 1/2$, so the capacity is $C_(cal(C)) = 1 - p$.
]

#pro[
  Let $cal(C) (X -> Y)$ be a channel and $C$ the capacity of $cal(C)$.
  - $0 <= C <= min(log card X, log card Y)$.
  - $I(X;Y)$ is continuous and concave function of $P(x)$.
  - The capacity is well defined since $I(X;Y)$ is upper bounded for $P(x)$ and a local maximum is global by the concavity.
]

#section[Typical Sequences & AEP]
To discuss the theorem, we have to define a type of sequences that come from the Asymptotic Equipartition Property, which are the typical sequences.

#def(name: "Typical Sequence")[
  Let $X_1, dots, X_n tilde P(x)$ be an i.i.d random variables with entropy $H(X)$, and let $epsilon > 0$ fixed. $ A_epsilon^((n)) = {x^n in cal(X)^n | abs(1/n log P(x^n) - H(X)) < epsilon}. $ A $epsilon$-typical sequence is an element $x^n in A_epsilon^((n))$.
]

#thm(name: "Asymptotic Equipartition Property")[
  Let a sequence of i.i.d random variables $X_1, dots, X_n tilde P(x)$ with entropy $H(X)$, $forall epsilon > 0$:
  - If $x_n in A_epsilon^((n))$ then $2^(-n(H(X) + epsilon)) <= P(x^n) <= 2^(-n(H(X) - epsilon))$.
  - $P(A_epsilon^((n))) -> 1$ as $n -> infinity$.
  - $(1-delta) 2^(n(H(X)-epsilon)) <= card A_epsilon^((n)) <= 2^(n(H(X)+epsilon))$ for large $n$ and any $delta > 0$.
]

#exm[
  When the sources generates a long sequence of symbols, the Law Of Large Numbers guarantees that it will almost surely be a typical sequence. A more intuitive way to think of it is to consider a coin toss, with $P(1) = 0.9, P(0) = 0.1$, and consider the two following sequences: $  s & = 11100111010000110010101100101011101010001000111001 \
  s' & = 11111111111011110001110111111111111111111111111111 $ notice that $s'$ is more likely to be generated by the distribution $P$ then $s$, this is what the idea a typical sequence tries to capture, sequence that are in essence resemble the distribution. If we calculate the number of typical sequences we get that the number of typical sequences for $n = 100$, we get approximately $2^(100 H(0.9)) = 2^(100 dot.c 0.46890...) tilde.eq 2^(46.89)$, while the number of actual sequences is $2^(100)$, notice that $2^(46.89) / 2^(100) = 2^(-53.1)$ thus we have that a really small set of sequences actually might be the outcome, while the others are extremely unlikely, asymptotically.
]

#section[Channel Coding Theorem]

From the Asymptotic Equipartition Property, we have that for each typical $n$-sequence generated with $X$, there are approximately $2^(n H(Y|X))$ possible $Y$ sequences which are all equiprobable with probability around $2^(-n H(Y|X))$, now if we consider the set of typical $n$-sequences generated with $Y$, we have that there are around $2^(n H(Y))$ typical sequences. In our encoding, we would like the set of sequences of $Y$ generated from the noise of the channel after sending a sequence in $X$ to be disjoint so we have no ambiguity in decoding the sequence to the original message, the total number of such disjoint sets is $2^(n H(Y))/2^(n H(Y|X)) = 2^(n I(X;Y))$, and hence we can send at most around $2^(n I(X; Y))$ distinct sequences. To maximize $2^(n I(X; Y))$ is to maximize $I(X; Y)$ which we know is exactly the information capacity of the channel. But also, notice that $2^(n I(X;Y))$ is really close to the form $2^(n R)$, indeed, if an $(M,n)$-code is being sent through the channel, then $M <= 2^(n I(X; Y))$ to be able to decode without confusion, and thus $ R = log(M) / n <= log(2^(n I(X;Y)))/n = I(X;Y) $, thus necessarily the rate would be at most the information sent through the channel. Conversely, if we take $R > C$ then $M = 2^(n R) > 2^(n C)$ codewords, and from our discussion before, we know that we can have at most $2^(n C)$ disjoint sets, so in this case we will indeed get two sets that are not disjoint and hence, not achieve the rate with errors going to $0$ since the element in the intersection of the codewords sent from two different $x$ vectors would always be confused.

#thm(name: "Channel Coding Theorem")[
  Let $cal(C)$ be a discrete memoryless channel. 
  - *Achievability:* any rate $R < C_(cal(C))$ where $C_(cal(C))$ is the information capacity of the channel $cal(C)$ is achievable, that is, there exists a sequence of $(2^(n R), n)$-codes with maximum probability error $lambda^((n)) -->_(n -> infinity) 0$. 
  - *Converse:* any sequence of $(2^(n R), n)$-codes satisfying $lambda^((n)) -->_(n -> infinity) 0$ must satisfy $R <= C$.
]
