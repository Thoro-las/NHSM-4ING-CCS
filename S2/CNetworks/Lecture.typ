#import "@preview/lilaq:0.5.0" as lq

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Networks & Protocols",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [
      This course is based on the book "Computer Networks -- A Systems Approach". It may be far from the course, but the course is not helpful in any way. This document will try to summarize the ideas of the book.
    ],
    warning: [
      This is not a course that is given in the sessions, there was no course to be given except some AI slope anyway.
    ]
  )
)

#chapter[Foundation][
  Suppose you want to build a computer network, one that has the potential to grow to global proportions and to support applications as diverse as teleconferencing, video on demand, electronic commerce, distributed computing and digital libraries. What available technologies would serve as the underlying building blocks, and what kind of software architecture would you design to integrate these building blocks into an effective communication service?
]

Starting with the definition of what is a network. In the old times, a network is just a set of serial lines used to attach multiple terminals/computers, to a mainframe computer. Then it also considered the voice telephone network and cable TV network to share signals, which were optimized for their purpose. More recently, computer networks show up with an important characteristic, its generality, in that it can support a wide range of applications.

#section[Classes Of Applications]
