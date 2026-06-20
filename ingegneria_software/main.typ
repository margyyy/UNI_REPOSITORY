#import "layout.typ": appunti
#import "boxes.typ": *
#import "@preview/cetz:0.5.1"

#show: appunti

#let blue = rgb("#245b88")
#let green = rgb("#327a50")
#let red = rgb("#a12a2a")
#let gold = rgb("#b67d0c")
#let ink = rgb("#23262b")
#let pale-blue = rgb("#eaf2f8")
#let pale-green = rgb("#edf7f1")
#let pale-gold = rgb("#fff6dc")

#align(center)[
  #text(27pt, weight: "bold", fill: ink)[Ingegneria del software]
  #v(5pt)
  #text(12pt, fill: rgb("#56616a"))[Appunti ragionati per la preparazione all'esame]
]

#v(14pt)
#outline(title: [Indice])
#pagebreak()

#include "chapters/01-modelli-di-processo.typ"

#pagebreak(weak: true)
#include "chapters/02-ingegneria-dei-requisiti.typ"

#pagebreak(weak: true)
#include "chapters/03-use-case.typ"

#pagebreak(weak: true)
#include "chapters/04-design-architetturale.typ"

#pagebreak(weak: true)
#include "chapters/05-design-delle-componenti.typ"

#pagebreak(weak: true)
#include "chapters/06-introduzione-uml.typ"

#pagebreak(weak: true)
#include "chapters/07-class-diagram-uml.typ"

#pagebreak(weak: true)
#include "chapters/08-interfacce.typ"

#pagebreak(weak: true)
#include "chapters/09-state-machine-diagram.typ"
