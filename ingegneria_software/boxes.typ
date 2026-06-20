#import "@preview/showybox:2.0.4": showybox

#let themes = (
  green: (
    title: rgb("#245b3d"),
    body: rgb("#eef6f0"),
    border: rgb("#245b3d"),
    title-text: white,
    body-text: black,
  ),
  blue: (
    title: rgb("#1f4e79"),
    body: rgb("#eef6ff"),
    border: rgb("#1f4e79"),
    title-text: white,
    body-text: black,
  ),
  red: (
    title: rgb("#7a2525"),
    body: rgb("#fff0f0"),
    border: rgb("#7a2525"),
    title-text: white,
    body-text: black,
  ),
  yellow: (
    title: rgb("#8a6d1d"),
    body: rgb("#fff8dc"),
    border: rgb("#8a6d1d"),
    title-text: white,
    body-text: black,
  ),
  purple: (
    title: rgb("#51306f"),
    body: rgb("#f4edff"),
    border: rgb("#51306f"),
    title-text: white,
    body-text: black,
  ),
  gray: (
    title: rgb("#444444"),
    body: rgb("#f1f1f1"),
    border: rgb("#444444"),
    title-text: white,
    body-text: black,
  ),
)

#let note-box(title, kind: "green", body) = {
  let theme = themes.at(kind)

  showybox(
    title: title,
    width: 100%,
    frame: (
      title-color: theme.title,
      body-color: theme.body,
      border-color: theme.border,
      radius: 5pt,
      thickness: 0.8pt,
      title-inset: (x: 10pt, y: 3pt),
      body-inset: (x: 24pt, y: 8pt),
    ),
    title-style: (
      color: theme.title-text,
      weight: "bold",
      align: start,
    ),
    body-style: (
      color: theme.body-text,
      align: start,
    ),
    sep: (
      thickness: 0pt,
      gutter: 0pt,
    ),
    body,
  )
}

#let green-box(title, body) = note-box(title, kind: "green", body)
#let blue-box(title, body) = note-box(title, kind: "blue", body)
#let red-box(title, body) = note-box(title, kind: "red", body)
#let yellow-box(title, body) = note-box(title, kind: "yellow", body)
#let purple-box(title, body) = note-box(title, kind: "purple", body)
#let gray-box(title, body) = note-box(title, kind: "gray", body)