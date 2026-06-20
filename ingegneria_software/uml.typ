#let uml-blue = rgb("#245b88")
#let uml-green = rgb("#327a50")
#let uml-amber = rgb("#b67d0c")
#let uml-pale-blue = rgb("#eaf2f8")
#let uml-pale-green = rgb("#edf7f1")
#let uml-pale-amber = rgb("#fff6dc")

#let uml-box(
  name,
  attributes: (),
  operations: (),
  width: 38mm,
  fill: uml-pale-blue,
  stroke: uml-blue,
  object: false,
) = box(
  width: width,
  radius: 2pt,
  fill: fill,
  stroke: .7pt + stroke,
  inset: 0pt,
  stack(
    dir: ttb,
    spacing: 0pt,
    block(
      width: 100%,
      inset: 5pt,
      stroke: if attributes.len() > 0 or operations.len() > 0 { (bottom: .5pt + stroke) },
      align(center, text(8pt, weight: "bold", if object { underline(name) } else { name })),
    ),
    if attributes.len() > 0 {
      block(
        width: 100%,
        inset: 5pt,
        stroke: if operations.len() > 0 { (bottom: .5pt + stroke) },
        stack(dir: ttb, spacing: 2pt, ..attributes.map(it => text(7pt, it))),
      )
    },
    if operations.len() > 0 {
      block(
        width: 100%,
        inset: 5pt,
        stack(dir: ttb, spacing: 2pt, ..operations.map(it => text(7pt, it))),
      )
    },
  ),
)

#let process-box(title, details, width: 62mm, fill: uml-pale-blue, stroke: uml-blue) = box(
  width: width,
  radius: 4pt,
  fill: fill,
  stroke: .7pt + stroke,
  inset: 6pt,
  align(center, stack(
    dir: ttb,
    spacing: 3pt,
    text(8pt, weight: "bold", title),
    text(7pt, details),
  )),
)
