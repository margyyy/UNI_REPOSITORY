#import "@preview/showybox:2.0.4": showybox
#import "boxes.typ": *

#let appunti(body) = {
  set page(
    paper: "a4",
    margin: (x: 2.7cm, y: 2cm),
    numbering: "1",
    number-align: center,
  )

  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: "it",
  )

  set par(
    justify: true,
    leading: 0.6em,
    first-line-indent: 1.2em,
  )

  set heading(numbering: "1.1")

  
  body
  
}
