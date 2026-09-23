#import "@preview/finite:0.5.0" as finite: automaton
#import "@preview/wrap-it:0.1.1": wrap-content

#let card = math.op("#")
#let subset = $subset.eq$
#let Oh = math.op("O")
#let end = "#"
#let sp = $square.stroked$
#let st = $triangle.stroked.r$
#let rp = $attach(<=, br: p)$

#let DFA = [*DFA*]
#let NFA = [*NFA*]

#let PC = [*P*]
#let NPC = [*NP*]
#let NPCC = [*NPC*]

#let sp = $square.stroked$
#let stroke = 0.2mm + black

#let tmtape(w, size: 1cm) = {
  let width = w.len()

  table(
    columns: (size,)*width,
    rows: (size),
    align: center + horizon,
    ..(w.map(wi => [#wi]))
  )
}


#let get-color = (i, angle: 55deg, saturate: 1) => color.oklch(90%, saturate*20%, i*angle)
#let ntm(width, qis, size: 1cm, tape-cw: 2, tape-ch: 2, disp-machines: true, start-color: 0, current-only: false) = {

  let machines = range(width).map(i => {
    let qi = qis.find(qi => qi.at(2) == i)
    if (qi != none) { return [$M_#qi.at(0)$]}
    return []
  })

  let states = range(width).map(i => {
    let qi = qis.find(qi => qi.at(2) == i)
    if (qi != none) { return [#circle(radius: size/2*9/10, stroke: stroke, fill: get-color(qi.at(0) + start-color), $q_(#qi.at(1))$)]}
    return []
  })

  let arrows = range(width).map(i => {
    let qi = qis.find(qi => qi.at(2) == i)
    if (qi != none) { return [*$arrow.b$*]}
    return []
  })

  let words = range(width).map(i => {
    let values = qis.slice(0, count: (calc.min(4, qis.len()))).map(qi => [#qi.at(3).at(i)])
    let fill = (x, y) => if (x + 2*y < qis.len()) {
      let cur-machine = qis.slice(0, count: (calc.min(tape-cw*tape-ch, qis.len()))).at(x + y*tape-cw)
      if (current-only and cur-machine.at(2) != i) {return}
      get-color(cur-machine.at(0) + start-color)
    }

    return [
      #set text(size: size/(2.5*tape-cw))
      #table(
        columns: (1fr,)*tape-cw,
        rows: (1fr,)*tape-ch,
        fill: fill,
        ..values
      )
    ]
  })

  let fill = (x, y) => { 
    if (y != 3) { return black.transparentize(100%) }
    let qi = qis.find(qi => qi.at(2) == x)
    if (qi != none) { return get-color(qi.at(0) + start-color) }
    else { return black.opacify(-100%) }
  }

  table(
    columns: (size,)*width,
    rows: if (disp-machines) { (6mm, size, 4.2mm, size) } else { (size, 4.2mm, size) },
    align: center + horizon,
    inset: 0pt,
    column-gutter: 1mm,
    row-gutter: if (disp-machines) { (auto, -1mm, auto) } else { (-1mm, auto) },
    stroke: (c, r) => if (r == 3) {stroke} else {black.opacify(-100%)},
    ..(if (disp-machines) {machines} else {()}),
    ..states,
    ..arrows,
    ..words
  )
}


#let tm(qi, pos, w, size: 0.9cm, start-color: 0) = {
  let width = w.len()
  ntm(width, tape-cw: 1, tape-ch: 1, size: size, disp-machines: false, start-color: start-color, current-only: true,
    ( (1, qi, pos, w),))
}


#let rw(width, height, size, start, finish, steps, config: (), path: ()) = {
  let angle = 2deg
  let grids = ()

  let pat = tiling(size: (size, size))[
    #place(square(width: 100%, height: 100%, fill: blue.opacify(-60%)))
    #place(line(stroke: 0.2mm, start: (33%, 0%), end: (33%, 100%)))
    #place(line(stroke: 0.2mm, start: (66%, 0%), end: (66%, 100%)))
    #place(line(stroke: 0.2mm, start: (0%, 33%), end: (100%, 33%)))
    #place(line(stroke: 0.2mm, start: (0%, 66%), end: (100%, 66%)))
  ]

  let count = 1
  let machines = (((-1,)*width,)*height)
  machines.at(start.at(1)).at(start.at(0)) = 1
  for (x, y) in config {
    machines.at(y).at(x) = -2
  }

  let in-bounds(x, y) = {
    return (0 <= x) and (x < width) and (0 <= y) and (y < height) and (machines.at(y).at(x) != -2)
  }

  let update(machines, count) = {
    let prevmachines = machines

    for i in range(width) {
      for j in range(height) {
        if (prevmachines.at(j).at(i) < 0) {continue}

        if (in-bounds(i + 1, j)) {
          machines.at(j).at(i + 1) = count
          count = count + 1
        }

        if (in-bounds(i, j + 1)) {
          machines.at(j + 1).at(i) = count
          count = count + 1
        }

        if (in-bounds(i, j - 1)) {
          machines.at(j - 1).at(i) = count
          count = count + 1
        }

        if (in-bounds(i - 1, j)) {
          machines.at(j).at(i - 1) = count
          count = count + 1
        }
      }
    }

    return (machines, count)
  }

  for i in range(steps) {
    if (i != steps - 1) {(machines, count) = update(machines, count)}
    grids.push(
      grid(
        columns: (size,)*width,
        rows: (size,)*height,
        stroke: 0.25mm + black,
        fill: (x, y) => {
          if ((x, y) == start) { return get-color(13, saturate: 4, angle: angle) }
          if ((x, y) == finish) { return get-color(75, saturate: 4, angle: angle) }

          if (i == steps - 1) {
            if ((x, y) in path) { 
              let position = path.position(p => p.at(0) == x and p.at(1) == y)
              return gradient.linear(
                  get-color(13, saturate: 5, angle: angle),
                  get-color(75, saturate: 5, angle: angle)
                ).sample((position/(path.len() - 1)*100) * 1%)
            }

            let machine = machines.at(y).at(x)
            if (machine == -2) { return pat }
            if (machine >= 0) { return get-color(machine, angle: angle).opacify(-50%) }
          }

          let machine = machines.at(y).at(x)
          if (machine == -2) { return pat }
          if (machine >= 0) { return get-color(machine, angle: angle) }
        },
      )
    )
  }
  return grids
}
