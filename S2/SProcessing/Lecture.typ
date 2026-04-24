#import "@preview/lilaq:0.5.0" as lq

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Signal Processing",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures that were supposed to be given by Dr. HOCINE, but instead he chose to teach us about electricity, anyway, hope it helps.],
    warning: [
      Given the source for reading, the definitions can be somewhat improperly explained or vague as the nature of definition depends highly on context.
    ]
  )
)

#let sgn = math.op("sgn")
#let rect = math.op("rect")
#let tri = math.op("tri")
#let ig = math.op("ig")
#let rep = math.op("rep")
#let Si = math.op("Si")

#chapter[Fundamental Concepts][
  Signals are a physical representation of information that is sent from source to destination. Signal processing is the discipline of measuring, storing, and interpreting the information transmitted by signals and how to process the signals themselves in order to achieve lower noise and better transmissions.
]

#def(name: "Signal")[
  A signal is a real function of one or more variables, that represents a transmission of information of a physical quantity over time, space, or independent variables.
]

To simplify notations, in general we consider signals to be smooth.

#def(name: "Noise")[
  A noise is any unwanted interference on the signal, random or not, that affects the values of the signal when transmitted.
]

Notice that in the definition of noise, there is nothing specific about a certain part of signal to be noise or not, it's all up to the observer to decide.

#def(name: "Fourier Transform")[
  Let $x: RR -> RR$ a function representing a signal dependent of time $t$. The Fourier transform of the function $x$ is a function of frequency $f$, $X(f)$ such that $
    cal(F)(x)(f) = X(f) = integral_(-infinity)^infinity x(t) e^(- i 2pi f t) dif t
  $
  where $i$ is the imaginary unit.
]

The Fourier transform is used to transform a function from the time domain to frequency/phase domain. This operation is not one way only, in many cases, we can go back to the time domain just from the frequency/phase domain, which is done by the Inverse Fourier Transform.

#def(name: "Inverse Fourier Transform")[
  Let $X: RR -> RR$ a function representing the strength of frequencies of a signal with parameter $f$. The inverse Fourier transform of the function $X$ is a function of time $x(t)$ such that $
    cal(F)^(-1)(X)(t) = x(t) = integral_(-infinity)^infinity X(f) e^(i 2 pi f t) dif f
  $
]

#section[Dirac $delta$ Function]

#ooc[
  A really useful "function" that is often used in signal processing is the Dirac $delta$ function. This is not really a function, it is called a distribution, which is a generalization of functions.

  #def(name: "Support", count: false)[
    Let $f: X -> Y$ be a function, $X, Y$ normed vector spaces, we define the support of $f$ as $"supp"(f) = overline({x in X | f(x) != 0})$.
  ]

  Let $D(RR) = cal(C)_c^infinity (RR)$ the set of all smooth functions (infinitely differentiable) on a compact support. We define the distributions as follows.

  #def(count: false, name: "Distribution")[
    A distribution is a linear operator $T$ from $D(RR)$ to $RR$, we denote for $phi in D(RR), chevron.l T, phi chevron.r = T(phi)$.
  ]

  It is quite easy to define associated a distribution for a locally integrable function for example, let $f$ be a locally integrable function, then define the distribution $T_f$ associated to $f$ as $chevron.l T_f, phi chevron.r = integral_RR f(x) phi(x) dif x$. Same can be done for Radon measures, so given a measure $mu$, we define the distribution $R_mu$ as follows $chevron.l R_u, phi chevron.r = integral_RR phi dif mu$.


]

#def(name: [Dirac $delta$])[
  The Dirac $delta$-function is a distribution defined as follows $delta: D(RR) -> RR$ such that $phi |-> chevron.l delta, phi chevron.r = phi(0)$.
]

We chose to define $delta$ as a limit of a sequence of functions, and thus we write $chevron.l delta, phi chevron.r = integral_RR phi(x) delta(x) dif x = phi(0)$, and by abuse of notation we write $forall x != 0, delta(x) = 0$ and $delta(0) = +infinity$. To generalize, define $delta_a: phi |-> chevron.l delta_a, phi chevron.r = phi(a)$.

#pro[
  Let $x(t)$ be a signal and $t_0 in RR$, then
  + $forall t in RR, x(t) dot.c delta(t - t_0) = x(t_0) dot.c delta(t - t_0)$.
  + $forall t in RR, x(t) convolve delta(t - t_0) = x(t - t_0)$.
  + $forall t in RR, forall a != 0, delta(a t) = |a|^(-1) delta(t)$.
]

#ooc[
  #prf[
    + Let $t in RR$. If $t != t_0$, $delta(t - t_0) = 0 => x(t) delta(t - t_0) = 0 = x(t_0) delta(t - t_0)$, else, $t = t_0 => delta(t - t_0) = 1 => x(t) = x(t_0)$ which is the since $t = t_0$.
    + We have $(x(t) convolve delta(t - t_0)) (s) = integral_RR x(r) delta(s - r - t_0) dif r = integral_RR x(r - t_0) delta(s - r) dif r = x(s - t_0)$, thus we get $x(t) convolve delta(t - t_0) = x(t - t_0)$.
    + We have that $integral_RR delta(a t) dif t = integral_RR delta(t) 1/abs(a) dif t = 1/abs(a) = integral_RR delta(t)/abs(a) dif t$ and hence we obtain $delta(a t) = |a|^(-1) delta(t)$.
  ]
]

#section[Functionals & Operations On Signals]
Let $x(t), y(t)$ two signals and let $T > 0$ a window, we define the follow operations:

#table(
  columns: (1fr, 2fr),
  align: horizon,

  [Scalar Product], $ chevron.l x, y chevron.r = integral_RR x(t) y(t) dif t. $,
  [Sampled Value], $ x(t_0) = chevron.l delta_(t_0), x chevron.r = integral_RR x(t) delta(t-t_0) dif . t $,
  [Convolution], $ (x(t) convolve y(t)) (s) = integral_RR x(t) y(s-t) dif t. $,
)

#section[Some Usual Functions]
#align(center)[
  #table(
    columns: (auto, 1fr),
    align: left + horizon,

    [Sign Function], $
      sgn(t) = cases(
        1 &"if" t > 0,
        -1 &"if" t < 0,
        0 &"if" t = 0
      ) = cases(
        t/(|t|) &"if" t != 0,
        0 &"if" t = 0
      )
    $,

    [Jump/Echelon Function], $
      epsilon(t) = (1 + sgn(t))/2 = cases(
        1 &"if" t > 0,
        0 &"if" t < 0,
        1/2 &"if" t = 0
      )
    $,

    [Ramp Function], $
      r(t) = integral_(-infinity)^t epsilon(t) dif t = t dot.c epsilon(t)
    $,

    [Rectangular Function], $
      rect(t) = epsilon(t + 1/2) - epsilon(t - 1/2) = cases(
        1 &"if" |t| < 1/2,
        0 &"if" |t| > 1/2,
        1/2 &"if" |t| = 1/2
      )
    $,

    [Triangular Function], $
      tri(t) = rect(t) convolve rect(t) = cases(
        1 - |t| &"if" |t| <= 1,
        0 &"if" |t| > 1,
      )
    $,

    [Gaussian Impulse], $
      ig(t) = e^(- pi t^2)
    $
  )
]

#section[Quantities Of Signals]
Let $x(t), y(t)$ two signals and $t_1, t_2 in RR$ such that $t_1 <= t_2$.
#table(
  columns: (1cm, 2fr, 3fr),
  align: (horizon + center, horizon + left, horizon + left),

  table.cell(rowspan: 4, rotate(90deg, reflow: true)[On Interval $[t_1, t_2]$]),

  [Average value], $ overline(x)(t_1, t_2) = 1/T integral_(t_1)^(t_2) x(t) dif t, $,
  [Quadratic value \ (Normalized energy)], $ W_x (t_1, t_2) = integral_(t_1)^(t_2) x^2 (t) dif t $,
  [Average quadratic value \ (Normalized power)], $ P_x (T) = 1/(t_2 - t_1) integral_(t_1)^(t_2) x^2(t) dif t $,
  [Effective Value Of Signal], [$ x_"eff" (T) = sqrt(P_x (T)) $],

  table.cell(rowspan: 4, rotate(90deg, reflow: true)[Globally]),
  [Running Average], $ overline(x)(t, T) = 1/T integral_(t-T)^t x(s) dif s $,
  [Average Value], $ overline(x) = lim_(T -> infinity) 1/T integral_(T\/2)^(T\/2) x(t) dif t $,
  [Quadratic value \ (Total energy)], $ W_x = integral_(-infinity)^(infinity) x^2 (t) dif t $,
  [Average quadratic value \ (Total power)], $ P_x = lim_(T -> infinity) 1/(T) integral_(T\/2)^(T\/2) x^2(t) dif t $,
)

#def(name: "Period Sequence Of Dirac Impulses")[
  Let $T > 0$, we define the sequence of Dirac impulses with period $T$ as $
    delta_T (t) = sum_(k = -infinity)^(infinity) delta(t - k T)
  $
]

If we multiply this sequence by a signal $x(t) delta_T (t) = x(t) sum_(k = -infinity)^(infinity) x(t) delta(t - k T) = sum_(k = -infinity)^infinity x(k T) delta(t - k T)$, sampling of the signal at each period $T$.

#def(name: "Repetition Operator")[
  Let $T > 0$ and $x(t)$ a signal, the operator $"rep"_T (x)$ takes a function and duplicates it all over the real line $RR$.
  $
    rep_T (x) (t) = sum_(k=-infinity)^infinity x(t - k T) = x(t) convolve delta_T (t)
  $
]

A useful function that will be used often later is the sinc function defined as follows $
  sinc (x) = (sin(pi x))/(pi x)
$ which has the following properties $
  integral_(-infinity)^infinity sinc (t) dif t = 1 quad quad integral_(-infinity)^infinity sinc^2 (t) dif t = 1
$ also, by abuse of notation $
  lim_(T -> infinity) T sinc (T t) = delta(t)
$ a function that comes from this is the sinus integral function defined as $
  Si(x) = integral_0^x sinc(t) dif t
$

#section[Signal Energy And Power]

#def(name: "Finite Energy Signal")[
  A signal is said to have finite energy if their energy is finite, that is $W_x < infinity$.
]

#def(name: "Finite Average Power Signal")[
  A signal is said to have a finite average power if the power is finite and non-zero $0 < P_x < infinity$.
]
