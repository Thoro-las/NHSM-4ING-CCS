#import "@preview/droplet:0.3.1": dropcap

#let ooc(body) = [
  #block(
    stroke: (left: 1mm + black),
    inset: (left: 4mm),
    outset: (y: 2mm, left: -1mm),
    width: 100%,
    body
  )
]

#let outlines() = [
  #v(1cm)
  #block(
    stroke: (left: 1mm + black),
    inset: (left: 7mm),
    outset: (y: 2mm, left: -1mm),
    [
      #set par(justify: false)
      #text("Contents", size: 1.9em)
      #v(3mm)
      #set par(justify: true)
      #outline()
    ]
  )
]

#let ctitle(title) = align(center)[
  #v(2mm)
  #text(size: 1.5em, title)
]

#let chapter(title, body, num: -1) = [
  #{
    pagebreak(weak: true)
    if (num < 0) { counter("title-counter").step() } 
    else { counter("title-counter").update(num) }

    counter("box-counter").update(0)
  }

  #block(inset: (y: 3mm), [
    #context counter("title-counter").display(i => [= #text(size: 1.3em, smallcaps[*Chapter #i*: #title])])
    #text(size: 2em, "Chapter " + context counter("title-counter").display())
    #v(-6mm)
    #text(size: 3em, title)
    #v(-3mm)
    #dropcap(gap: 3pt)[#body]
  ])
]

#let section(title, level: 2) = [
  #counter("title-counter").step(level: level)
  #context counter("title-counter").display((..i) => [== #i.pos().map(str).join("."). #title])
  #text(context counter("title-counter").display("1.") + " " + title, size: 1.6em, weight: "bold") \
  #v(1mm)
]

#let subsection(title, level: 3) = [
  #counter("title-counter").step(level: level)
  #context counter("title-counter").display((..i) => [=== #i.pos().map(str).join("."). #title])
  #text(context counter("title-counter").display("1.") + " " + title, size: 1.3em, weight: "bold") \
  #v(0mm)
]


#let follow-bar(message) = {
  grid(
    columns: (1fr, auto, 1fr),
    column-gutter: 1mm,
    align: center + horizon,
    line(length: 100%, stroke: (paint: gray, dash: "densely-dashed")),
    text(message, fill: gray),
    line(length: 100%, stroke: (paint: gray, dash: "densely-dashed")),
  )
}
