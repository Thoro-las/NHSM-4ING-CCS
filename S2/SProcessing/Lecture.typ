#import "@preview/lilaq:0.5.0" as lq

#import "@THR/Wide:1.0.0": *
#show: template.with(
  title: "Signal Processing",
  writer: "HADIOUCHE Azouaou",
  disclaimer: [This document contains the lectures that were supposed to be given by Dr. HOCINE, but instead he chose to teach us about electricity, anyway, hope it helps.],
)

#let sgn = math.op("sgn")
#let rect = math.op("rect")

#chapter[Fundamental Concepts][
  Given the source for reading, the definitions can be somewhat improperly explained or vague as the nature of definition depends highly on context.
]

A signal is a physical representation of information that is sent from source to destination. We model signals mathematically in the following way.
#def(name: "Signal")[
  A signal is a real function of $1$ or more variables
]
// Noise is any interference happening in the process of reading or interpreting the signal.

#section[Fourier Transform]

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

We prove that the inverse Fourier transform is indeed an inverse function.

#thm(name: "Fourier Inversion")[
  
]


An example here will be given with using finite frequencies to explain what does this transform do.

#exm[
  Consider the following function 

  #table(
    columns: (2fr, 1fr),
    align: center + horizon,
    stroke: 0mm,
    lq.diagram(
      xlim: (-3.2, 3.2),
      ylim: (-0.7, 1.2),
      width: 100%,
      lq.plot((-3, -1, -1, 1, 1, 3), (0, 0, 1, 1, 0, 0))
    ),
    $
      x(t) = cases(
        1 &"if" |t| < 1,
        0 &"otherwise"
      )
    $
  )

  By calculating the Fourier transform we get $
    X(f) = integral_(-infinity)^infinity x(t) e^(-i 2 pi f t) dif t = integral_(-1)^1 e^(-i 2 pi f t) dif t
  $

  For $f = 0$ we get $2$, thus we consider $f != 0$ $
    X(f) &= integral_(-1)^1 e^(-i 2 pi f t) dif t = [e^(-i 2 pi f t) / (- i 2 pi f)]_(t=-1)^(t=1) = (e^(- (2 pi f) i) - e^((2 pi f) i))/(- 2 i pi f) = sin(2 pi f)/(pi f)
  $

  Now we plot this function for some values of $f$

  #lq.diagram(
    xlim: (-3.2, 3.2),
    ylim: (-1.2, 2.6),
    width: 100%,
    lq.plot(lq.linspace(-20, 20, num: 200), f => calc.sin(2*calc.pi*f) / (calc.pi * f), smooth: true, mark: none)
  )

  What the previous graph represents in this case is the strength of each frequency in the signal. For example, the frequency $0$ is the strongest frequency in the function $x(t)$ which is clearly true since most of the function is constant, the remaining frequencies come from the rising-edge and falling-edge at $-1$ and $1$.
]

A useful operator in the usage of Fourier transforms is the convolution.

#def(name: "Convolution")[
  Let $x, y: RR -> RR$ two integrable functions. We define the convolution of $x$ and $y$ as $x convolve y$ as follows $
    x convolve y : RR &-> RR\
      t &|-> integral_(-infinity)^infinity x(s) y(t - s) dif s
  $
]

And an important result we get in this case is the convolution theorem stating that $cal(F)(x convolve y) = cal(F)(x) dot.c cal(F)(y)$. More useful results will be explained later.

#colbreak()

#section[Some Useful Functions]
#align(center)[
  #table(
    columns: (auto, 1fr),
    align: left + horizon,
    [Sign function], $
      sgn(x) = cases(
        1 &"if" x > 0,
        -1 &"if" x < 0,
        0 &"if" x = 0
      ) = cases(
        x/(|x|) &"if" x != 0,
        x &"if" x = 0
      )
    $,
    [Jump/Echelon function], $
      epsilon(x) = (1 + sgn(x))/2 = cases(
        1 &"if" x > 0,
        0 &"if" x < 0,
        1\/2 &"if" x = 0
      )
    $,
    [Ramp function], $
      r(x) = integral_(-infinity)^x epsilon(t) dif t = x dot.c epsilon(x)
    $,
    [Rectangular function], $
      rect(x) = epsilon(x + 1/2) - epsilon(x - 1/2) = cases(
        1 &"if" |x| < 1/2,
        0 &"if" |x| > 1/2,
        1/2 &"if" |x| = 1/2
      )
    $
  )
]

#section[Operations On Signals]
Given a signal $x(t)$ we define the following quantities on an interval $[-T/2, T/2]$:
+ Average value: $
  overline(x)(T) = 1/T integral_(-T\/2)^(T\/2) x(t) dif t
$
+ Quadratic value (Normalized energy): $
  W_x (T) = integral_(-T\/2)^(T\/2) x^2 (t) dif t
$
+ Average quadratic value (Normalized power): $
  P_x (T) = 1/T integral_(-T\/2)^(T\/2) x^2(t) dif t
$
