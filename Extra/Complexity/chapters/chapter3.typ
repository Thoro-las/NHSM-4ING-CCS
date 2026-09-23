#import "@THR/Base:1.0.0": *
#import "../resources/commands.typ": *

#chapter[Complexity & Algorithms][
  Computational complexity theory, or complexity theory in short, is a theory made for classifying algorithms and computational problems by their time, memory, or other resources usage throughout their runtime which allows a clear objective comparison between algorithms performance in general.
]

It is easy to notice that for different kind of machines, the same algorithm will lead to different running times, and even sometimes in the same machine. To be objective, we will start by making a model for a universal machine, the Turing machine, that allows us to compare algorithms independent of the hardware they run on, thus giving us an objective measure for efficiency of algorithms.
