#import "../boxes.typ": *
#import "@preview/fletcher:0.5.8" as fletcher
#import fletcher.shapes: diamond, pill, circle

#let node = fletcher.node
#let edge = fletcher.edge
#let diagram(..args) = align(center, scale(
  x: 76%,
  y: 76%,
  reflow: true,
  fletcher.diagram(..args),
))
#let wide-diagram(..args) = align(center, scale(
  x: 60%,
  y: 60%,
  reflow: true,
  fletcher.diagram(..args),
))

#let flow-blue = rgb("#245b88")
#let flow-green = rgb("#327a50")
#let flow-gold = rgb("#b67d0c")
#let flow-red = rgb("#a12a2a")
#let flow-pale-blue = rgb("#eaf2f8")
#let flow-pale-green = rgb("#edf7f1")
#let flow-pale-gold = rgb("#fff6dc")

#let action(pos, body, width: 38mm, fill: flow-pale-blue, stroke: flow-blue, ..args) = node(
  pos, body, width: width, height: 9mm,
  corner-radius: 2pt, extrude: (0, 3),
  fill: fill, stroke: 1pt + stroke, inset: 4pt, ..args,
)
#let object-node(pos, body, width: 32mm, fill: white) = node(
  pos, body, width: width, height: 8mm,
  fill: fill, stroke: .7pt + flow-blue, inset: 3pt,
)
#let decision(pos) = node(
  pos, [], shape: diamond, width: 7mm, height: 7mm,
  fill: flow-pale-gold, stroke: .8pt + flow-gold,
)
#let initial(pos) = node(pos, [#text(13pt, fill: flow-blue)[●]], stroke: none, fill: none, inset: 0pt)
#let activity-final(pos) = node(pos, [#text(15pt, fill: flow-blue)[◉]], stroke: none, fill: none, inset: 0pt)
#let flow-final(pos) = node(pos, [#text(15pt, fill: flow-red)[⊗]], stroke: none, fill: none, inset: 0pt)
#let arrow(a, b, label: none, ..args) = if label == none {
  edge(a, b, "-|>", stroke: .8pt + flow-blue, ..args)
} else {
  edge(a, b, "-|>", label, stroke: .8pt + flow-blue, label-size: 7pt, ..args)
}

= Activity Diagram

Un *Activity Diagram* descrive come viene svolta un'attività: quali azioni avvengono, in quale ordine, quali dati attraversano il processo e quali flussi possono procedere in concorrenza. L'attività modellata può essere un'operazione, un caso d'uso, un processo di business, una procedura o un algoritmo.

#yellow-box([Diagrammi poliedrici])[
  Gli Activity Diagram si usano in analisi per workflow e Use Case, nel design come alternativa al pseudocodice e, nei profili UML eseguibili, persino come linguaggio di programmazione.
]

== Concetti fondamentali

=== Azioni, nodi e flussi

Un'attività è composta da *azioni*, unità di comportamento che costituiscono i suoi mattoni. Il testo dell'azione può essere informale, può indicare un'operazione o il richiamo a un'altra attività, oppure può contenere pseudocodice quando il diagramma è vicino all'implementazione.

#table(
  columns: (1.1fr, 1.3fr, 2fr),
  inset: 5pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { flow-pale-blue },
  table.header([*Categoria*], [*Elemento*], [*Funzione*]),
  [Azione], [Action node], [Esegue un comportamento atomico rispetto al diagramma.],
  [Dati], [Object node / pin], [Rappresenta input, output e oggetti che fluiscono.],
  [Controllo], [Initial/final], [Avvia o termina attività e flussi.],
  [Controllo], [Decision/merge], [Seleziona o riunisce alternative.],
  [Controllo], [Fork/join], [Avvia e sincronizza flussi concorrenti.],
)

Un piccolo simbolo a rastrello (*rake*) segnala che un'azione è dettagliata da un altro Activity Diagram. È un meccanismo di decomposizione: il diagramma corrente mostra il livello alto, quello richiamato descrive i passi interni.

#figure(
  diagram(
    spacing: 14mm,
    action((-3, 0), [Manda la fattura\ al cliente], width: 39mm),
    action((-1, 0), [Prepara fattura\ cliente ↘], width: 39mm, fill: flow-pale-green, stroke: flow-green),
    action((1, 0), [Fare fattura\ `Contabile::compila()`], width: 44mm, fill: flow-pale-gold, stroke: flow-gold),
    action((3, 0), [`FOR every Employee`\ `calculate salary`\ `ENDFOR`], width: 42mm),
  ),
  caption: [Azioni espresse in linguaggio naturale, tramite richiamo, operazione e pseudocodice.],
)

Nel secondo nodo il rastrello indica il richiamo a un'attività separata. Per esempio `Conferma ordine ↘` può essere dettagliata da un diagramma contenente `Fornisci dati di pagamento` e `Fornisci dati di spedizione`.

=== Semantica dei token

La semantica UML è basata su *token*, simili a pedine che percorrono gli archi:

- un'azione è abilitata quando possiede token su tutti gli ingressi richiesti;
- l'esecuzione consuma i token in entrata;
- al termine vengono prodotti token sugli archi in uscita;
- decision, fork, join e nodi finali trasformano o eliminano i token secondo regole precise.

== Esempio: gestione di un ordine

Quando l'azienda riceve un ordine, avvia due flussi concorrenti: prepara e spedisce il pacco; invia la fattura e attende il pagamento. L'ordine viene chiuso soltanto quando entrambi sono terminati.

#figure(
  wide-diagram(
    spacing: 13mm,
    initial((0, 0)),
    action((0, 1), [Ricevi ordine]),
    node((0, 2), [], width: 75mm, height: 2mm, fill: flow-blue, stroke: flow-blue),

    action((-2, 3), [Soddisfa cliente ↘], width: 39mm, fill: flow-pale-green, stroke: flow-green),
    decision((-2, 4)),
    action((-3, 5), [Spedizione espressa], width: 38mm),
    action((-1, 5), [Spedizione normale], width: 38mm),
    decision((-2, 6)),

    action((2, 3), [Invia conto / fattura], width: 43mm, fill: flow-pale-gold, stroke: flow-gold),
    action((2, 5), [Ricevi pagamento], width: 38mm, fill: flow-pale-gold, stroke: flow-gold),

    node((0, 7), [], width: 75mm, height: 2mm, fill: flow-blue, stroke: flow-blue),
    action((0, 8), [Chiudi ordine]),
    activity-final((0, 9)),

    arrow((0, 0), (0, 1)),
    arrow((0, 1), (0, 2)),
    arrow((0, 2), (-2, 3)),
    arrow((0, 2), (2, 3)),
    arrow((-2, 3), (-2, 4)),
    arrow((-2, 4), (-3, 5), label: [rapida]),
    arrow((-2, 4), (-1, 5), label: [normale]),
    arrow((-3, 5), (-2, 6)),
    arrow((-1, 5), (-2, 6)),
    arrow((-2, 6), (0, 7)),
    arrow((2, 3), (2, 5)),
    arrow((2, 5), (0, 7)),
    arrow((0, 7), (0, 8)),
    arrow((0, 8), (0, 9)),
  ),
  caption: [Fork e join coordinano i due rami concorrenti della gestione ordine.],
)

Il fork duplica il token ricevuto: un token entra nel ramo logistico e uno in quello amministrativo. Il join attende un token da entrambi; perciò `Chiudi ordine` non può iniziare finché pacco e pagamento non sono completati.

=== Evoluzione dei token, passo per passo

Le slide mostrano lo stesso diagramma in istanti successivi. La sequenza completa è:

#table(
  columns: (.45fr, 3.55fr),
  inset: (x: 5pt, y: 1pt),
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if calc.rem(y, 2) == 0 { rgb("#f6f9fb") },
  [*1*], [Il nodo iniziale abilita `Ricevi ordine`.],
  [*2*], [`Ricevi ordine` deposita il token sul fork.],
  [*3*], [Il fork duplica il token sui due rami.],
  [*4*], [`Soddisfa cliente` prepara il pacco mentre viene inviata la fattura.],
  [*5*], [Il decision sceglie spedizione espressa oppure normale.],
  [*6*], [Il merge riunisce le alternative di spedizione.],
  [*7*], [`Ricevi pagamento` attende il cliente.],
  [*8*], [Il join trattiene il primo token arrivato.],
  [*9*], [Con entrambi i token, il join abilita `Chiudi ordine`.],
  [*10*], [Il nodo finale termina l'attività e distrugge gli altri token.],
)

== Nodi di controllo

=== Inizio e terminazione

Il nodo iniziale genera il primo token. Quando un token raggiunge un *activity final*, termina l'intera attività e vengono eliminati anche i token ancora presenti negli altri rami. Un *flow final* termina invece soltanto il flusso che lo raggiunge.

#figure(
  diagram(
    spacing: 14mm,
    initial((-3, 0)),
    action((-1.5, 0), [Realizza progetto], width: 38mm),
    action((0, 0), [Supera test\ sbarramento], width: 38mm),
    action((1.5, 0), [Sostieni esame\ orale], width: 38mm),
    activity-final((3, 0)),
    arrow((-3, 0), (-1.5, 0)),
    arrow((-1.5, 0), (0, 0)),
    arrow((0, 0), (1.5, 0)),
    arrow((1.5, 0), (3, 0)),
  ),
  caption: [Il primo nodo finale raggiunto termina l'intera attività e tutti i suoi flussi.],
)

=== Decisione e fusione

Un nodo decisione ha un ingresso e più uscite dotate di guardie. Il token percorre una sola uscita la cui guardia è vera. Guardie sovrapposte producono una scelta non deterministica; se nessuna è vera, il flusso si blocca. Il merge ha più ingressi alternativi e un'unica uscita.

#figure(
  diagram(
    spacing: 14mm,
    initial((-3, 0)),
    action((-1.8, 0), [Action 1], width: 30mm),
    decision((-.7, 0)),
    action((.6, 0), [Action 2], width: 30mm, fill: flow-pale-green, stroke: flow-green),
    action((.6, 1.2), [Action 3], width: 30mm, fill: flow-pale-gold, stroke: flow-gold),
    decision((1.8, 0)),
    activity-final((3, 0)),
    arrow((-3, 0), (-1.8, 0)),
    arrow((-1.8, 0), (-.7, 0)),
    arrow((-.7, 0), (.6, 0), label: [[x = 0]]),
    arrow((-.7, 0), (.6, 1.2), label: [[x > 0]]),
    edge((-.7, 0), (-.7, -1), (1.8, -1), (1.8, 0), "-|>", [[x < 0]], stroke: .8pt + flow-blue, label-size: 7pt),
    arrow((.6, 0), (1.8, 0)),
    arrow((.6, 1.2), (1.8, 0)),
    arrow((1.8, 0), (3, 0)),
  ),
  caption: [Il decision instrada il token; il merge riunisce i percorsi alternativi.],
)

=== Fork e join

Un fork ha un ingresso e più uscite: duplica il token su tutti i rami. Un join ha più ingressi e una sola uscita: attende un token su ogni ingresso prima di procedere. Le attività nei rami sono concorrenti; non è necessario che siano implementate da thread distinti.

#figure(
  diagram(
    spacing: 14mm,
    initial((-3, 0)),
    node((-2, 0), [], width: 2mm, height: 35mm, fill: flow-blue, stroke: flow-blue),
    action((0, -.6), [Action 1], width: 30mm),
    action((0, .6), [Action 2], width: 30mm),
    node((2, 0), [], width: 2mm, height: 35mm, fill: flow-blue, stroke: flow-blue),
    activity-final((3, 0)),
    arrow((-3, 0), (-2, 0)),
    arrow((-2, 0), (0, -.6)),
    arrow((-2, 0), (0, .6)),
    arrow((0, -.6), (2, 0)),
    arrow((0, .6), (2, 0)),
    arrow((2, 0), (3, 0)),
  ),
  caption: [Il fork duplica il token; il join attende il completamento di entrambi i rami.],
)

=== Nodo finale di flusso

#figure(
  diagram(
    spacing: 14mm,
    initial((-3, 0)),
    node((-2, 0), [], width: 2mm, height: 48mm, fill: flow-blue, stroke: flow-blue),
    action((0, -.8), [Action 1], width: 30mm),
    action((0, 0), [Action 2], width: 30mm),
    action((0, .8), [Action 3], width: 30mm),
    node((2, -.4), [], width: 2mm, height: 35mm, fill: flow-blue, stroke: flow-blue),
    activity-final((3, -.4)),
    flow-final((2, .8)),
    arrow((-3, 0), (-2, 0)),
    arrow((-2, 0), (0, -.8)),
    arrow((-2, 0), (0, 0)),
    arrow((-2, 0), (0, .8)),
    arrow((0, -.8), (2, -.4)),
    arrow((0, 0), (2, -.4)),
    arrow((2, -.4), (3, -.4)),
    arrow((0, .8), (2, .8)),
  ),
  caption: [`Action 3` termina soltanto il proprio flusso; le altre due terminano l'attività tramite il join.],
)

== Oggetti, pin e stati

Gli *object node* modellano oggetti usati come input o prodotti come output. Possono apparire tra due azioni oppure come piccoli *pin* sul bordo dell'azione. In prospettiva concettuale rappresentano oggetti del dominio; in prospettiva software, istanze a runtime.

#figure(
  diagram(
    spacing: 16mm,
    action((-2, 0), [Crea progetto], width: 35mm),
    object-node((0, 0), [progetto], width: 27mm, fill: flow-pale-gold),
    action((2, 0), [Consegna progetto], width: 42mm, fill: flow-pale-green, stroke: flow-green),
    action((-2, 1.3), [Crea progetto], width: 35mm),
    object-node((-1.05, 1.3), [], width: 4mm, fill: flow-pale-gold),
    object-node((1.05, 1.3), [], width: 4mm, fill: flow-pale-gold),
    action((2, 1.3), [Consegna progetto], width: 42mm, fill: flow-pale-green, stroke: flow-green),
    arrow((-2, 0), (0, 0)),
    arrow((0, 0), (2, 0)),
    arrow((-1.05, 1.3), (1.05, 1.3), label: [progetto]),
  ),
  caption: [Un oggetto può essere mostrato come nodo autonomo oppure tramite pin sulle azioni.],
)

#figure(
  diagram(
    spacing: 15mm,
    initial((-2.5, 0)),
    action((-1.2, 0), [Crea progetto], width: 35mm),
    object-node((.3, 0), [Progetto\ [finito]], width: 30mm, fill: flow-pale-gold),
    action((1.8, 0), [Valuta progetto], width: 38mm, fill: flow-pale-green, stroke: flow-green),
    object-node((.3, 1.2), [Progetto\ [valutato]], width: 32mm, fill: flow-pale-green),
    activity-final((3, 0)),
    arrow((-2.5, 0), (-1.2, 0)),
    arrow((-1.2, 0), (.3, 0)),
    arrow((.3, 0), (1.8, 0)),
    arrow((1.8, 0), (.3, 1.2)),
    arrow((.3, 1.2), (3, 0)),
  ),
  caption: [Gli stati dell'oggetto rendono visibile la sua evoluzione durante l'attività.],
)

Gli stati tra parentesi quadre devono essere coerenti con l'eventuale State Machine dell'oggetto. In termini di pseudocodice, il primo flusso equivale a:

#block(breakable: false, width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
```java
Progetto progetto = creaProgetto();
consegnaProgetto(progetto);
```
]

I parametri di input e i valori restituiti di un'intera attività vengono rappresentati come object node sul bordo esterno dell'attività.

== Partizioni e responsabilità

Le *swimlane* specificano chi esegue ogni azione. Suddividono graficamente il flusso senza cambiarne la semantica; possono rappresentare persone, ruoli, reparti, componenti o classi.

#figure(
  diagram(
    spacing: 15mm,
    node((-1.5, -.7), [*Studente*], width: 63mm, fill: flow-pale-blue, stroke: flow-blue),
    node((1.5, -.7), [*Docente*], width: 63mm, fill: flow-pale-green, stroke: flow-green),
    initial((-1.5, 0)),
    action((-1.5, 1), [Realizza progetto], width: 38mm),
    object-node((0, 2), [Progetto\ [finito]], width: 28mm, fill: flow-pale-gold),
    action((1.5, 3), [Valuta progetto], width: 38mm, fill: flow-pale-green, stroke: flow-green),
    object-node((0, 4), [Progetto\ [valutato]], width: 30mm, fill: flow-pale-green),
    action((-1.5, 5), [Sostieni orale], width: 34mm),
    activity-final((-1.5, 6)),
    arrow((-1.5, 0), (-1.5, 1)),
    arrow((-1.5, 1), (0, 2)),
    arrow((0, 2), (1.5, 3)),
    arrow((1.5, 3), (0, 4)),
    arrow((0, 4), (-1.5, 5)),
    arrow((-1.5, 5), (-1.5, 6)),
  ),
  caption: [Il flusso attraversa le responsabilità di studente e docente.],
)

#yellow-box([Swimlane e concorrenza])[
  Due azioni in lane differenti non sono automaticamente parallele. La concorrenza nasce dalla struttura fork/join, non dalla disposizione nelle partizioni.
]

== Eventi e interruzioni

=== Invio e ricezione di eventi

UML offre azioni specializzate per inviare e ricevere segnali, compresi eventi temporali. L'invio è asincrono e non blocca; la ricezione sospende il flusso finché l'evento non si verifica. Un nodo di ricezione senza archi entranti rimane attivo per tutta la vita dell'attività.

#figure(
  diagram(
    spacing: 18mm,
    node((-2, 0), [Manda evento ▷], width: 42mm, fill: flow-pale-blue, stroke: .8pt + flow-blue),
    node((0, 0), [▷ Accetta evento], width: 42mm, fill: flow-pale-green, stroke: .8pt + flow-green),
    node((2, 0), [⌛ Evento temporale], width: 43mm, fill: flow-pale-gold, stroke: .8pt + flow-gold),
  ),
  caption: [Azioni specializzate per invio, ricezione e attesa temporale.],
)

#figure(
  diagram(
    spacing: 14mm,
    initial((0, 0)),
    node((0, 1), [], width: 65mm, height: 2mm, fill: flow-blue, stroke: flow-blue),
    action((-2, 2), [Segui lezioni], width: 34mm),
    action((0, 2), [Studia], width: 30mm),
    action((2, 2), [Ricevi specifiche], width: 38mm, fill: flow-pale-gold, stroke: flow-gold),
    action((2, 3), [Crea progetto], width: 34mm),
    action((2, 4), [Consegna progetto], width: 38mm),
    node((0, 5), [], width: 65mm, height: 2mm, fill: flow-blue, stroke: flow-blue),
    action((-1, 6), [Attendi data scritto], width: 39mm, fill: flow-pale-gold, stroke: flow-gold),
    action((-1, 7), [Sostieni scritto], width: 36mm),
    action((1, 7), [Sostieni orale], width: 34mm),
    activity-final((1, 8)),
    arrow((0, 0), (0, 1)),
    arrow((0, 1), (-2, 2)),
    arrow((0, 1), (0, 2)),
    arrow((0, 1), (2, 2)),
    arrow((2, 2), (2, 3)),
    arrow((2, 3), (2, 4)),
    arrow((-2, 2), (0, 5)),
    arrow((0, 2), (0, 5)),
    arrow((2, 4), (0, 5)),
    arrow((0, 5), (-1, 6)),
    arrow((-1, 6), (-1, 7), label: [7 maggio]),
    arrow((-1, 7), (1, 7)),
    arrow((1, 7), (1, 8)),
  ),
  caption: [Ricezione di specifiche ed evento temporale nel processo d'esame.],
)

#pagebreak(weak: true)
=== Regioni interrompibili

Una regione interrompibile delimita azioni che possono essere cancellate da un evento. Se un token si trova nella regione quando arriva il segnale di interruzione, i flussi interni vengono terminati e il controllo passa lungo l'arco di interruzione. Si usa per eccezioni, cancellazioni, timeout e condizioni di errore.

#figure(
  diagram(
    spacing: 14mm,
    initial((0, -.2)),
    action((0, .7), [Ricevi ordine], width: 34mm, name: <receive-order>),
    node((0, 1.5), [], width: 58mm, height: 2mm, fill: flow-blue, stroke: flow-blue, name: <fork-order>),
    action((-1.2, 2.5), [Prepara ordine], width: 37mm, name: <prepare-order>),
    action((1.2, 2.5), [Invia fattura], width: 34mm, fill: flow-pale-gold, stroke: flow-gold, name: <send-invoice>),
    action((-1.2, 3.7), [Spedisci ordine], width: 38mm, name: <ship-order>),
    action((1.2, 3.7), [Ricevi pagamento], width: 40mm, fill: flow-pale-gold, stroke: flow-gold, name: <receive-payment>),
    node((0, 4.7), [], width: 58mm, height: 2mm, fill: flow-blue, stroke: flow-blue, name: <join-order>),
    action((0, 5.7), [Chiudi ordine], width: 34mm),
    activity-final((0, 6.7)),
    node((2.7, 2.2), [▷ Annulla ordine], width: 42mm, fill: rgb("#f6e9e9"), stroke: .8pt + flow-red),
    action((2.7, 4.7), [Ordine cancellato], width: 40mm, fill: rgb("#f6e9e9"), stroke: flow-red),
    node([], enclose: (<receive-order>, <fork-order>, <prepare-order>, <send-invoice>, <ship-order>, <receive-payment>, <join-order>), outset: 8pt, fill: none, stroke: (paint: flow-red, dash: "dashed"), layer: 0),
    arrow((0, -.2), (0, .7)),
    arrow((0, .7), (0, 1.5)),
    arrow((0, 1.5), (-1.2, 2.5)),
    arrow((0, 1.5), (1.2, 2.5)),
    arrow((-1.2, 2.5), (-1.2, 3.7)),
    arrow((1.2, 2.5), (1.2, 3.7)),
    arrow((-1.2, 3.7), (0, 4.7)),
    arrow((1.2, 3.7), (0, 4.7)),
    arrow((0, 4.7), (0, 5.7)),
    arrow((0, 5.7), (0, 6.7)),
    arrow((2.7, 2.2), (2.7, 4.7), label: [interrompe]),
    arrow((2.7, 4.7), (0, 6.7)),
  ),
  caption: [La cancellazione interrompe i token nella regione, ma non è più ammessa dopo la spedizione.],
)

#red-box([Confine temporale])[
  Nel processo d'ordine la cancellazione può essere ammessa durante preparazione e pagamento, ma non dopo la consegna: il confine della regione rende esplicito fino a quando l'interruzione è valida.
]

#pagebreak(weak: true)
=== Parametri e valori di ritorno: fare il bucato

I parametri di input e i valori restituiti dell'intera attività sono object node posti sul bordo. Nell'esempio `dirtyClothes: Clothes` entra nell'attività e `cleanClothes: Clothes` ne costituisce il risultato.

#figure(
  diagram(
    spacing: 13mm,
    object-node((0, 0), [dirtyClothes: Clothes], width: 38mm, fill: flow-pale-gold),
    action((0, 1), [Separa vestiti], width: 34mm),
    object-node((-1.2, 2), [Bianchi [sporchi]], width: 34mm),
    object-node((1.2, 2), [Colorati [sporchi]], width: 34mm),
    action((-1.2, 3), [Lava bianchi], width: 34mm),
    action((1.2, 3), [Lava colorati], width: 34mm),
    object-node((-1.2, 4), [Bianchi\ [puliti, bagnati]], width: 38mm, fill: flow-pale-green),
    object-node((1.2, 4), [Colorati\ [puliti, bagnati]], width: 38mm, fill: flow-pale-green),
    action((-1.2, 5), [Asciuga bianchi], width: 36mm),
    action((1.2, 5), [Asciuga colorati], width: 36mm),
    action((0, 6), [Piega vestiti], width: 34mm),
    object-node((0, 7), [cleanClothes: Clothes], width: 40mm, fill: flow-pale-green),
    arrow((0, 0), (0, 1)),
    arrow((0, 1), (-1.2, 2)),
    arrow((0, 1), (1.2, 2)),
    arrow((-1.2, 2), (-1.2, 3)),
    arrow((1.2, 2), (1.2, 3)),
    arrow((-1.2, 3), (-1.2, 4)),
    arrow((1.2, 3), (1.2, 4)),
    arrow((-1.2, 4), (-1.2, 5)),
    arrow((1.2, 4), (1.2, 5)),
    arrow((-1.2, 5), (0, 6)),
    arrow((1.2, 5), (0, 6)),
    arrow((0, 6), (0, 7)),
  ),
  caption: [Parametri, object node e trasformazioni dell'attività `Fare bucato`.],
)

== Modellare Use Case e operazioni

=== Use Case ATM: prelevare contante

L'Activity Diagram rende espliciti il percorso principale e la ripetizione richiesta quando saldo o disponibilità dello sportello non sono sufficienti.

*Attore primario:* Cliente. Il sistema:

1. visualizza `20`, `40`, `60`, `100`, `200` e `cancel`;
2. riceve l'importo selezionato tramite tastiera;
3. se importo, saldo e contante nello sportello sono compatibili, addebita il conto, eroga le banconote e ricorda di ritirarle;
4. altrimenti mostra l'errore e torna al menu;
5. tratta `cancel` come scenario alternativo di annullamento.

#figure(
  diagram(
    spacing: 13mm,
    initial((0, 0)),
    action((1, 1), [Visualizza menu], width: 36mm),
    action((-1, 1), [Seleziona importo], width: 38mm),
    decision((0, 2)),
    action((-2.4, 3), [Imposta quantità\ = importo], width: 40mm),
    action((2.4, 3), [Visualizza messaggio\ di errore], width: 43mm, fill: rgb("#f6e9e9"), stroke: flow-red),
    action((-2.4, 4), [Ottieni saldo\ dal database], width: 40mm),
    decision((-2.4, 5)),
    action((-2.4, 6), [Verifica contante\ nello sportello], width: 42mm),
    decision((-2.4, 7)),
    action((-2.4, 8), [Addebita prelievo], width: 38mm, fill: flow-pale-green, stroke: flow-green),
    action((-2.4, 9), [Eroga contanti], width: 36mm, fill: flow-pale-green, stroke: flow-green),
    action((-2.4, 10), [Ricorda di prendere\ le banconote], width: 43mm),
    activity-final((-2.4, 11)),
    decision((0, 11)),
    arrow((0, 0), (1, 1)),
    arrow((0, 0), (-1, 1)),
    arrow((1, 1), (0, 2)),
    arrow((-1, 1), (0, 2)),
    arrow((0, 2), (-2.4, 3), label: [[importo]]),
    arrow((0, 2), (0, 11), label: [[cancel]]),
    arrow((-2.4, 3), (-2.4, 4)),
    arrow((-2.4, 4), (-2.4, 5)),
    arrow((-2.4, 5), (-2.4, 6), label: [[quantità ≤ saldo]]),
    arrow((-2.4, 5), (2.4, 3), label: [[else]]),
    arrow((-2.4, 6), (-2.4, 7)),
    arrow((-2.4, 7), (-2.4, 8), label: [[sufficiente]]),
    arrow((-2.4, 7), (2.4, 3), label: [[insufficiente]]),
    edge((2.4, 3), (3.4, 3), (3.4, 1), (1, 1), "-|>", [riprova], stroke: .8pt + flow-blue, label-size: 7pt),
    arrow((-2.4, 8), (-2.4, 9)),
    arrow((-2.4, 9), (-2.4, 10)),
    arrow((-2.4, 10), (-2.4, 11)),
    arrow((-2.4, 11), (0, 11)),
    activity-final((1, 11)),
    arrow((0, 11), (1, 11)),
  ),
  caption: [Use Case `Prelevare contante`: cancel, controllo del saldo e disponibilità dello sportello.],
)

#pagebreak(weak: true)
=== Operazione `authenticateUser`

L'esempio delle slide modella l'operazione del bancomat `authenticateUser(login: string, PWD: string): Answer`, dove `Answer` può assumere `invalidUser`, `incorrectPWD` oppure `ok`.

#figure(
  diagram(
    spacing: 14mm,
    object-node((-3, -.7), [login: string], width: 31mm, fill: flow-pale-gold),
    object-node((-3, .7), [PWD: string], width: 31mm, fill: flow-pale-gold),
    action((-1.7, 0), [Cerca login e PWD\ nel database], width: 48mm),
    decision((-.3, 0)),
    action((1.1, -1), [Imposta\ `invalidUser`], width: 37mm, fill: rgb("#f6e9e9"), stroke: flow-red),
    action((1.1, 0), [Imposta\ `incorrectPWD`], width: 39mm, fill: flow-pale-gold, stroke: flow-gold),
    action((1.1, 1), [Imposta `ok`], width: 34mm, fill: flow-pale-green, stroke: flow-green),
    decision((2.4, 0)),
    object-node((3.7, 0), [result:\ Answer], width: 31mm, fill: flow-pale-green),
    arrow((-3, -.7), (-1.7, 0)),
    arrow((-3, .7), (-1.7, 0)),
    arrow((-1.7, 0), (-.3, 0)),
    arrow((-.3, 0), (1.1, -1), label: [[utente assente]]),
    arrow((-.3, 0), (1.1, 0), label: [[PWD errata]]),
    arrow((-.3, 0), (1.1, 1), label: [[presente]]),
    arrow((1.1, -1), (2.4, 0)),
    arrow((1.1, 0), (2.4, 0)),
    arrow((1.1, 1), (2.4, 0)),
    arrow((2.4, 0), (3.7, 0)),
  ),
  caption: [Parametri e valore restituito dell'operazione `authenticateUser`.],
)

#table(
  columns: (1.2fr, 2.8fr),
  inset: 5pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { flow-pale-blue },
  [*Operazione*], [`authenticateUser(login: string, PWD: string): Answer`],
  [*Risultati*], [`invalidUser`, `incorrectPWD`, `ok`],
  [*Passo centrale*], [Ricerca di login e password nel database.],
)

== Modellare un algoritmo

=== Ricerca binaria

La ricerca binaria combina decision e merge per aggiornare gli estremi dell'intervallo finché il valore centrale coincide con il target oppure l'intervallo diventa vuoto.

#figure(
  diagram(
    spacing: 13mm,
    initial((0, 0)),
    action((0, 1), [`low = 0; high = n − 1`], width: 48mm),
    decision((0, 2)),
    action((0, 3), [`middle = (low + high) / 2`], width: 55mm),
    decision((0, 4)),
    action((-2.4, 5), [`high = middle − 1`], width: 43mm, fill: flow-pale-gold, stroke: flow-gold),
    action((2.4, 5), [`low = middle + 1`], width: 43mm, fill: flow-pale-gold, stroke: flow-gold),
    action((0, 6), [`return middle`], width: 38mm, fill: flow-pale-green, stroke: flow-green),
    action((-2.4, 6), [`return −1`], width: 32mm, fill: rgb("#f6e9e9"), stroke: flow-red),
    activity-final((0, 7)),
    arrow((0, 0), (0, 1)),
    arrow((0, 1), (0, 2)),
    arrow((0, 2), (0, 3), label: [[continua]]),
    arrow((0, 2), (-2.4, 6), label: [[vuoto]]),
    arrow((0, 3), (0, 4)),
    arrow((0, 4), (-2.4, 5), label: [[>]]),
    arrow((0, 4), (2.4, 5), label: [[<]]),
    arrow((0, 4), (0, 6), label: [[=]]),
    arrow((-2.4, 5), (0, 2)),
    arrow((2.4, 5), (0, 2)),
    arrow((-2.4, 6), (0, 7)),
    arrow((0, 6), (0, 7)),
  ),
  caption: [Activity Diagram dell'algoritmo di ricerca binaria.],
)

#block(breakable: false, width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
```java
int binarySearch(int[] a, int target) {
  int low = 0, high = a.length - 1;
  while (low <= high) {
    int middle = (low + high) / 2;
    if (a[middle] == target) return middle;
    if (a[middle] < target) low = middle + 1;
    else high = middle - 1;
  }
  return -1;
}
```
]

Nel caso mostrato nelle slide, con `target = 76`, l'intervallo si restringe così:

#table(
  columns: (.55fr, 1fr, 1fr, 1fr, 1.45fr),
  inset: 4pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { flow-pale-blue },
  table.header([*Passo*], [*low*], [*middle*], [*high*], [*Confronto*]),
  [1], [`2`], [`47`], [`94`], [`47 < 76`],
  [2], [`51`], [`77`], [`94`], [`77 > 76`],
  [3], [`51`], [`64`], [`76`], [`64 < 76`],
  [4], [`76`], [`76`], [`76`], [`76 = 76`],
)
