#let __color(hue, chroma, brightness) = color.oklch(brightness, chroma, hue * 20deg, 100%)

#let __cbox(hue, title, content) = {
  let fill-color = __color(hue, 10%, 96%)
  let border-color = __color(hue, 40%, 70%)
  let title-color = border-color.darken(20%)

  let colored-block = {
    align(center)[
      #block(
        width: 95%,
        inset: 3mm,
        fill: fill-color,
        stroke: (left: 1mm + border-color),
        align(left)[
          #text(weight: "bold", style: "normal", fill: title-color, title + ":")
          #text(style: "italic", content)
        ]
      )
    ]
  }

  colored-block
}

#let __ctbox(hue, title, subtitle, content, count: true, level: 1, ovcount: true, countval: -1) = {
  if (count) { counter("box-counter").step(level: level) }
  let ctitle = {
    title + if (count) {
      context {
        if (ovcount) {
          " " + counter("title-counter").display("1.")
      } else {
        " "
      } + counter("box-counter").display("1.1")}
    } + if subtitle != "" {" (" + subtitle + ")"}
  }
  __cbox(hue, ctitle, content)
}

#let def(name: "", count: true, ovcount: true, body)  = __ctbox( 7, count: count, ovcount: ovcount, "Definition", name, body)
#let thm(name: "", count: true, ovcount: true, body)  = __ctbox( 4, count: count, ovcount: ovcount, "Theorem", name, body)
#let pro(name: "", count: true, ovcount: true, body)  = __ctbox(16, count: count, ovcount: ovcount, "Proposition", name, body)
#let cor(name: "", count: true, ovcount: true, body)  = __ctbox( 0, count: count, ovcount: ovcount, "Corollary", name, body)
#let lem(name: "", count: true, ovcount: true, body)  = __ctbox( 3, count: count, ovcount: ovcount, "Lemma", name, body)
#let exr(name: "", count: true, ovcount: true, body)  = __ctbox(13, count: count, ovcount: ovcount, "Exercise", name, body)
#let qst(name: "", count: true, ovcount: true, body)  = __ctbox(16, count: count, ovcount: ovcount, "Question", name, body, level: 2)
#let alg(name: "", count: true, ovcount: true, body)  = __ctbox(13, count: count, ovcount: ovcount, "Algorithm", name, body, level: 2)

#let nte(name: "", count: false, ovcount: true, body) = __ctbox( 9, count: count, ovcount: ovcount, "Note", name, body)
#let ntt(name: "", count: false, ovcount: true, body) = __ctbox(12, count: count, ovcount: ovcount, "Notation", name, body)

#let exm(body, count: false) = [
  #if (count) {counter("box-counter").step()}
  * Example#context if (count) {" " + counter("title-counter").display("1.") + counter("box-counter").display("1.1")}: * #body
]


#let prf(body) = [
  #block(width: 100%, {
    [_Proof. _]
    body
    place(right + bottom, $square.filled$)
  })
]

#let prfout(name: "", body) = [
  #ooc[
    #text("Proof Outline:", weight: "bold", style: "normal")
    #text(style: "normal", body)
  ]
]
