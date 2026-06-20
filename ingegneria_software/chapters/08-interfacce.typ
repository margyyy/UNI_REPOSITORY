#import "../boxes.typ": *
#import "@preview/cetz:0.5.1"
#import "../uml.typ": *

= Interfacce e vincoli UML

Il termine *interfaccia* indica sia l'insieme delle operazioni pubblicamente visibili di una classe, sia un classificatore UML simile a una classe ma privo di implementazione. Un'interfaccia dichiara un contratto; una o più classi possono fornirne realizzazioni differenti.

#yellow-box([Idea fondamentale])[
  Chi usa un'interfaccia dipende dal contratto, non dalla classe concreta che in quel momento lo implementa. Questo riduce l'accoppiamento e rende le implementazioni sostituibili.
]

== Interfacce fornite e richieste

=== Realizzazione di un'interfaccia

Una classe *fornisce* un'interfaccia quando implementa tutte le operazioni che essa dichiara. UML rappresenta la realizzazione con una linea tratteggiata e un triangolo vuoto rivolto verso l'interfaccia. Lo stereotipo `«interface»` distingue l'interfaccia da una classe ordinaria.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0, 2), uml-box([«interface»\ List], operations: ([+ equals(Object)], [+ add(Object)], [+ get(index)]), width: 43mm, fill: uml-pale-amber, stroke: uml-amber))
    content((-3.2, -1.3), uml-box([ArrayList], width: 38mm))
    content((3.2, -1.3), uml-box([LinkedList], width: 38mm))
    line((-2.3, -.85), (-.4, 1.2), stroke: (dash: "dashed", paint: uml-blue))
    line((2.3, -.85), (.4, 1.2), stroke: (dash: "dashed", paint: uml-blue))
    polygon((0, 1.35), 3, angle: 90deg, radius: .5, fill: white, stroke: .8pt + uml-blue)
  }),
  caption: [`ArrayList` e `LinkedList` realizzano la stessa interfaccia `List`.],
)

In Java questa relazione corrisponde a `implements List`. Una classe può realizzare più interfacce; un'interfaccia può inoltre specializzarne altre.

=== Interfaccia richiesta

Una classe *richiede* un'interfaccia quando ha bisogno di un oggetto che la implementi per svolgere il proprio compito. Non richiede necessariamente una particolare classe concreta: qualunque realizzazione compatibile può soddisfare la dipendenza.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.6, 0), uml-box([Visualizzatore], width: 42mm))
    content((3.6, 0), uml-box([Motore di ricerca], width: 42mm, fill: uml-pale-green, stroke: uml-green))
    // Socket richiesto e lollipop fornito.
    line((-1.9, 0), (-.75, 0), stroke: .9pt + uml-blue)
    circle((-.5, 0), radius: .25, fill: white, stroke: .9pt + uml-blue)
    line((1.9, 0), (.25, 0), stroke: .9pt + uml-green)
    circle((0, 0), radius: .25, fill: white, stroke: .9pt + uml-green)
    content((0, .55), text(7pt, weight: "bold")[Cerca])
    content((-3.6, -.65), text(7pt, fill: uml-blue)[richiede])
    content((3.6, -.65), text(7pt, fill: uml-green)[fornisce])
  }),
  caption: [Il visualizzatore richiede il servizio `Cerca`, fornito dal motore di ricerca.],
)

Il cerchio, detto *lollipop*, indica un'interfaccia fornita; il semicerchio o *socket* indica un'interfaccia richiesta. Quando socket e lollipop sono collegati, il componente cliente usa il servizio del fornitore.

== Due notazioni equivalenti

La stessa relazione può essere espressa con la notazione estesa — rettangolo `«interface»` e realizzazione tratteggiata — oppure con il lollipop. La prima mostra comodamente le operazioni; la seconda è più compatta nei diagrammi architetturali.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.6, 1.4), uml-box([«interface»\ Cassiere], operations: ([+ ritira()], [+ deposita()]), width: 40mm, fill: uml-pale-amber, stroke: uml-amber))
    content((-3.6, -1.5), uml-box([Impiegato], width: 36mm))
    line((-3.6, -.95), (-3.6, .65), stroke: (dash: "dashed", paint: uml-blue))
    polygon((-3.6, .8), 3, angle: 90deg, radius: .45, fill: white, stroke: .8pt + uml-blue)
    content((1.8, 0), uml-box([Bancomat], width: 36mm, fill: uml-pale-green, stroke: uml-green))
    line((3.25, 0), (4.3, 0), stroke: .9pt + uml-green)
    circle((4.55, 0), radius: .25, fill: white, stroke: .9pt + uml-green)
    content((4.55, .55), text(7pt, weight: "bold")[Cassiere])
    content((0, 0), text(15pt, weight: "bold", fill: uml-blue)[≡])
  }),
  caption: [Notazione estesa e lollipop esprimono una realizzazione d'interfaccia.],
)

#green-box([Come scegliere la notazione])[
  Usare il rettangolo quando interessano operazioni, generalizzazioni o dettagli del contratto; usare lollipop e socket quando interessa soprattutto mostrare come componenti e servizi sono collegati.
]

== Perché usare le interfacce

Senza interfaccia, un cliente dipende direttamente da una classe concreta. Introducendo un contratto intermedio, sia il cliente sia le implementazioni dipendono da un'astrazione stabile.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.8, 1.2), uml-box([Cliente A], width: 32mm))
    content((-3.8, -1.2), uml-box([Cliente B], width: 32mm))
    content((0, 0), uml-box([«interface»\ Servizio], operations: ([+ esegui()],), width: 38mm, fill: uml-pale-amber, stroke: uml-amber))
    content((3.8, 1.2), uml-box([Implementazione 1], width: 40mm, fill: uml-pale-green, stroke: uml-green))
    content((3.8, -1.2), uml-box([Implementazione 2], width: 40mm, fill: uml-pale-green, stroke: uml-green))
    line((-2.5, 1), (-1.5, .35), mark: (end: ">"), stroke: (dash: "dashed", paint: uml-blue))
    line((-2.5, -1), (-1.5, -.35), mark: (end: ">"), stroke: (dash: "dashed", paint: uml-blue))
    line((2.5, 1), (1.5, .35), stroke: (dash: "dashed", paint: uml-green))
    line((2.5, -1), (1.5, -.35), stroke: (dash: "dashed", paint: uml-green))
  }),
  caption: [Clienti e implementazioni sono disaccoppiati da un contratto comune.],
)

I principali vantaggi sono:

- *sostituibilità*: una realizzazione può essere rimpiazzata senza cambiare il cliente;
- *testabilità*: un test può fornire un'implementazione fittizia (*mock* o *stub*);
- *sviluppo parallelo*: team diversi lavorano contro un contratto concordato;
- *riduzione delle dipendenze*: il cliente conosce solo le operazioni necessarie;
- *polimorfismo*: oggetti di classi diverse sono usati uniformemente.

#red-box([Interfacce troppo grandi])[
  Un'interfaccia che raccoglie servizi non correlati costringe i clienti a dipendere da operazioni inutili. È preferibile definire contratti piccoli e coesi, orientati alle esigenze dei client.
]

== Vincoli nei Class Diagram

Un Class Diagram non descrive soltanto elementi strutturali: associazioni, attributi, molteplicità e generalizzazioni impongono già vincoli sulle configurazioni ammesse. Per esempio, la molteplicità `1` accanto a `Persona` stabilisce che ogni automobile abbia esattamente un proprietario.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.2, 0), uml-box([Persona], width: 36mm))
    content((3.2, 0), uml-box([Automobile], width: 36mm))
    line((-1.75, 0), (1.75, 0), stroke: .8pt + uml-blue)
    content((0, .35), text(7pt)[possiede])
    content((-1.55, .35), text(7pt)[1])
    content((1.55, .35), text(7pt, "1..*"))
  }),
  caption: [La molteplicità esprime il vincolo: ogni automobile appartiene a una sola persona.],
)

I costrutti grafici non sono però sufficienti per ogni regola di business. UML consente di aggiungere vincoli mediante linguaggio naturale, codice o *OCL* (*Object Constraint Language*).

=== Object Constraint Language

OCL è il linguaggio formale di specifica associato a UML, basato sulla logica del primo ordine. Può esprimere invarianti, precondizioni, postcondizioni e interrogazioni senza descrivere come implementarle.

#block(width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
  *Esempio di invariante OCL*

  `context Automobile inv UnSoloProprietario:`  
  `self.proprietario->size() = 1`
]

#yellow-box([Vincolo dichiarativo])[
  OCL specifica ciò che deve essere vero, non l'algoritmo con cui ottenerlo. Il modello resta quindi indipendente dall'implementazione, ma può essere verificato con strumenti automatici.
]

#v(6pt)
#text(12pt, weight: "bold", fill: uml-blue)[Riepilogo]
#v(4pt)

#table(
  columns: (1.2fr, 2.8fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if calc.rem(y, 2) == 0 { rgb("#f6f9fb") },
  [*Interfaccia*], [Contratto pubblico privo di implementazione concreta.],
  [*Realizzazione*], [Una classe fornisce le operazioni dichiarate dall'interfaccia.],
  [*Interfaccia richiesta*], [Il cliente necessita di una realizzazione del contratto.],
  [*Lollipop/socket*], [Notazione compatta per servizi forniti e richiesti.],
  [*Vincolo*], [Regola che limita le configurazioni ammesse dal modello.],
  [*OCL*], [Linguaggio formale e dichiarativo per vincoli UML.],
)
