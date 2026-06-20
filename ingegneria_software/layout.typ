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

  // Evita titoli orfani a fondo pagina: se non c'è spazio per l'inizio
  // della sezione, il titolo viene spostato insieme al contenuto seguente.
  show heading: set block(sticky: true)

  // Testata di apertura: segnala chiaramente l'inizio di un nuovo capitolo
  // senza inserire pagine bianche tra un capitolo e il successivo.
  show heading.where(level: 1): it => block(
    width: 100%,
    inset: (x: 14pt, y: 10pt),
    above: 0pt,
    below: 1.2em,
    radius: 6pt,
    fill: rgb("#245b88"),
    sticky: true,
  )[
    #set text(fill: white, weight: "bold")
    #it
  ]

  // Dal secondo sottocapitolo in poi, ogni titolo di secondo livello inizia
  // su una nuova pagina. Il primo (x.1) resta invece insieme al titolo del
  // capitolo, evitando una pagina introduttiva quasi vuota.
  show heading.where(level: 2): it => context {
    let numbers = counter(heading).get()
    if numbers.len() >= 2 and numbers.at(1) > 1 {
      pagebreak(weak: true)
    }
    it
  }

  // I titoli di terzo livello identificano i singoli modelli o argomenti
  // principali: una fascia visiva li rende facili da ritrovare sfogliando.
  show heading.where(level: 3): it => block(
    width: 100%,
    inset: (x: 9pt, y: 3pt),
    above: 0.8em,
    below: 0.4em,
    radius: 4pt,
    fill: rgb("#eaf2f8"),
    stroke: (left: 2.5pt + rgb("#245b88")),
    sticky: true,
  )[
    #set text(fill: rgb("#1f4e79"), weight: "bold")
    #it
  ]

  
  body
  
}
