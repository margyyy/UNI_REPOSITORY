#import "../boxes.typ": *
#import "@preview/cetz:0.5.1"
#import "../uml.typ": *

#let state-box(name, details: (), width: 36mm, fill: uml-pale-blue, stroke: uml-blue) = box(
  width: width,
  radius: 7pt,
  fill: fill,
  stroke: .8pt + stroke,
  inset: 0pt,
  stack(
    dir: ttb,
    spacing: 0pt,
    block(width: 100%, inset: 6pt, stroke: if details.len() > 0 { (bottom: .5pt + stroke) }, align(center, text(8pt, weight: "bold", name))),
    if details.len() > 0 { block(width: 100%, inset: 5pt, stack(dir: ttb, spacing: 2pt, ..details.map(it => text(6.8pt, it)))) },
  ),
)

= State Machine Diagram

Uno *State Machine Diagram* descrive il comportamento di un'entità come variazione del suo stato interno in risposta a eventi. L'entità può essere un sistema software o hardware, una classe, un singolo oggetto o un'entità del mondo reale.

#yellow-box([La domanda del diagramma])[
  Dato lo stato corrente e un evento ricevuto, quale transizione può scattare, quali azioni vengono eseguite e quale sarà il nuovo stato?
]

== Stato e comportamento

=== Modellazione statica e dinamica

Class e Object Diagram descrivono entità e relazioni, cioè la struttura statica. I diagrammi di interazione mostrano più oggetti che collaborano per un obiettivo; una macchina a stati segue invece un'entità durante il suo ciclo di vita.

Uno *stato* è una situazione durante la quale valgono determinate condizioni e possono essere eseguite attività. Non coincide con la combinazione completa dei valori dei campi: è un'astrazione che raggruppa configurazioni nelle quali l'entità reagisce nello stesso modo agli eventi.

#green-box([Esempio del distributore])[
  Premere “eroga” produce caffè se il credito è sufficiente, ma mostra un messaggio se è insufficiente. Lo stesso evento genera comportamenti diversi perché cambia lo stato interno.
]

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.2, 0), state-box([Credito insufficiente], width: 44mm, fill: uml-pale-amber, stroke: uml-amber))
    content((3.2, 0), state-box([Credito sufficiente], width: 44mm, fill: uml-pale-green, stroke: uml-green))
    line((-1.45, .3), (1.45, .3), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((0, .72), text(7pt)[inserisci(moneta) [totale ≥ prezzo]])
    line((3.2, -.5), (3.2, -1.3), (-3.2, -1.3), (-3.2, -.5), mark: (end: ">"), stroke: .8pt + uml-green)
    content((0, -1.65), text(7pt)[eroga / preparaCaffè(); azzeraCredito()])
  }),
  caption: [Il comportamento dipende sia dall'evento sia dallo stato corrente.],
)

== Notazione e semantica

=== Stati, transizioni e pseudo-stati

Graficamente una macchina a stati è un grafo: i nodi arrotondati sono stati e gli archi orientati sono transizioni. Il disco nero è lo pseudo-stato iniziale, unico nel diagramma o nello stato composito; il disco nero bordato è uno stato finale e può comparire più volte.

#figure(
  cetz.canvas({
    import cetz.draw: *
    circle((-4.3, 0), radius: .14, fill: uml-blue, stroke: uml-blue)
    content((-1.8, 0), state-box([Source], width: 31mm))
    content((2.7, 0), state-box([Target], width: 31mm, fill: uml-pale-green, stroke: uml-green))
    circle((5, 0), radius: .23, fill: white, stroke: 1pt + uml-blue)
    circle((5, 0), radius: .12, fill: uml-blue, stroke: uml-blue)
    line((-4.15, 0), (-3.05, 0), mark: (end: ">"), stroke: .8pt + uml-blue)
    line((-.55, 0), (1.45, 0), mark: (end: ">"), stroke: .8pt + uml-blue)
    line((3.95, 0), (4.77, 0), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((.45, .5), text(7pt, weight: "bold")[event [guard] / activity])
  }),
  caption: [Sintassi fondamentale di una transizione UML.],
)

La forma completa dell'etichetta è:

`evento [guardia] / attività`

- l'*evento* è il trigger che propone il passaggio;
- la *guardia* è una condizione booleana che deve risultare vera;
- l'*attività* è l'azione atomica eseguita durante la transizione.

Tutti e tre gli elementi sono opzionali. Senza attività si cambia soltanto stato; senza guardia l'evento abilita sempre la transizione; senza evento la transizione è di completamento e scatta immediatamente quando lo stato sorgente termina.

=== Eventi

Un evento può essere:

- la ricezione di un segnale o di una chiamata a operazione;
- un *change event*, scritto `when(condizione)`, quando la condizione passa da falsa a vera;
- un *time event*, come `after(2 min)` oppure `at(24:00)`.

Le azioni possono usare attributi, operazioni, link e parametri conosciuti dall'oggetto modellato. Riferirsi direttamente a elementi che l'oggetto non conosce rende il modello non implementabile.

=== Run-to-completion

Gli eventi ricevuti vengono accodati e processati uno alla volta. La semantica è *run-to-completion*: un nuovo evento viene estratto solo quando l'elaborazione del precedente è terminata. Se più transizioni sono contemporaneamente abilitate, ne viene scelta una sola; un modello con guardie sovrapposte può quindi essere non deterministico.

#red-box([Guardie mutuamente esclusive])[
  Da uno stesso stato, transizioni con lo stesso evento dovrebbero avere guardie disgiunte e possibilmente complete. Se due guardie sono vere, la scelta non è deterministica; se nessuna è vera, l'evento viene ignorato.
]

== Esempio: ciclo di vita di una copia di libro

La macchina seguente è associata a una singola `CopiaLibro`. Mostra una prospettiva software: eventi e azioni sono operazioni e modifiche dello stato dell'oggetto.

#figure(
  cetz.canvas({
    import cetz.draw: *
    circle((-5, 1.5), radius: .14, fill: uml-blue, stroke: uml-blue)
    content((-3, 1.5), state-box([Disponibile], width: 34mm, fill: uml-pale-green, stroke: uml-green))
    content((1.3, 1.5), state-box([In prestito], width: 34mm))
    content((1.3, -1.5), state-box([In manutenzione], width: 42mm, fill: uml-pale-amber, stroke: uml-amber))
    content((-3, -1.5), state-box([Alienata], width: 34mm, fill: rgb("#f6e9e9"), stroke: rgb("#a12a2a")))
    line((-4.85, 1.5), (-4.35, 1.5), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((-4.6, 1.85), text(6.8pt)[acquisto])
    line((-1.65, 1.5), (-.05, 1.5), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((-.85, 1.85), text(6.8pt)[prestito])
    line((-.05, 1.15), (-1.65, 1.15), mark: (end: ">"), stroke: .8pt + uml-green)
    content((-.85, .75), text(6.5pt)[restituzione [buona]])
    line((1.3, .95), (1.3, -.82), mark: (end: ">"), stroke: .8pt + uml-amber)
    content((2.65, 0), text(6.5pt)[restituzione [cattiva]])
    line((-.4, -1.5), (-1.65, -1.5), mark: (end: ">"), stroke: .8pt + uml-green)
    content((-.95, -1.15), text(6.8pt)[riparata])
    line((-3, .95), (-3, -.95), mark: (end: ">"), stroke: .8pt + rgb("#a12a2a"))
    content((-3.65, 0), text(6.8pt)[vendita])
  }),
  caption: [Macchina a stati semplificata di una copia di libro.],
)

La restituzione produce due transizioni alternative: una copia in buone condizioni torna disponibile; una copia danneggiata entra in manutenzione. L'azione associata alla vendita può aggiornare il libro collegato se quella alienata era l'ultima copia disponibile.

== Attività interne

=== Entry, exit, do e reazioni interne

Il secondo comparto di uno stato può contenere attività che non producono un cambiamento di stato:

- `entry / azione`: eseguita ogni volta che si entra;
- `exit / azione`: eseguita ogni volta che si esce;
- `do / attività`: eseguita mentre lo stato è attivo, può durare ed essere interrotta;
- `evento / azione`: reazione interna a un evento.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-2.7, 0), state-box([Installazione], details: ([entry / prepara()], [do / copiaFile()], [interrompi / annulla()], [exit / pulisci()]), width: 54mm, fill: uml-pale-amber, stroke: uml-amber))
    content((3.1, 0), state-box([Completata], width: 38mm, fill: uml-pale-green, stroke: uml-green))
    line((-.5, 0), (1.55, 0), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((.55, .4), text(7pt)[termine])
  }),
  caption: [Uno stato può dichiarare attività di ingresso, permanenza, uscita e reazioni interne.],
)

Una *self-transition* esce dallo stato e vi rientra, quindi esegue `exit` ed `entry`. Una reazione interna non abbandona lo stato e non le attiva: le due notazioni non sono equivalenti.

== Stati compositi e concorrenza

=== Stati compositi

Uno stato composito contiene una macchina a stati interna. Permette di nascondere dettagli e suddividere un comportamento complesso. Una transizione disegnata dal bordo del super-stato è disponibile da tutti i suoi sotto-stati; sono possibili anche transizioni da uno stato interno verso l'esterno.

Gli *entry point* e gli *exit point* consentono di entrare o uscire dal composito in punti nominati diversi. Una giunzione (*junction*) compatta ramificazioni e ricongiungimenti condizionali.

#figure(
  image("../fotodaaggiungere/aggiungiquestoesempiapagina72.png", width: 96%),
  caption: [Esempio di stato composito con transizioni interne e dal bordo.],
)

=== Regioni ortogonali

Un composito diviso in regioni ortogonali modella comportamenti concorrenti. L'entità si trova contemporaneamente in uno stato di ogni regione; l'uscita dal composito avviene normalmente quando tutte le regioni hanno raggiunto il proprio stato finale.

#figure(
  cetz.canvas({
    import cetz.draw: *
    rect((-5, -2.4), (5, 2.4), radius: 8pt, fill: rgb("#f8fafb"), stroke: .8pt + uml-blue)
    content((-4.25, 2), text(8pt, weight: "bold")[Ordine aperto])
    line((-5, 0), (5, 0), stroke: (dash: "dashed", paint: rgb("#9aa7af")))
    circle((-4.2, 1), radius: .12, fill: uml-blue, stroke: uml-blue)
    content((-1.8, 1), state-box([Controllo prodotti], width: 42mm))
    content((2.3, 1), state-box([Confezionamento], width: 39mm, fill: uml-pale-green, stroke: uml-green))
    line((-4.05, 1), (-3.5, 1), mark: (end: ">"), stroke: .8pt + uml-blue)
    line((-.1, 1), (.75, 1), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((.3, 1.35), text(6.5pt)[disponibili])
    circle((-4.2, -1.2), radius: .12, fill: uml-blue, stroke: uml-blue)
    content((-1.6, -1.2), state-box([Controllo pagamento], width: 46mm, fill: uml-pale-amber, stroke: uml-amber))
    circle((1.2, -1.2), radius: .22, fill: white, stroke: .9pt + uml-blue)
    circle((1.2, -1.2), radius: .11, fill: uml-blue, stroke: uml-blue)
    line((-4.05, -1.2), (-3.45, -1.2), mark: (end: ">"), stroke: .8pt + uml-blue)
    line((.25, -1.2), (.98, -1.2), mark: (end: ">"), stroke: .8pt + uml-blue)
  }),
  caption: [Due regioni ortogonali controllano prodotti e pagamento in concorrenza.],
)

#figure(
  image("../fotodaaggiungere/aggiungiapagina72comesempiodiregioniortogonali.png", width: 90%),
  caption: [Esempio di regioni ortogonali in uno stato composito.],
)

#yellow-box([Concorrenza, non necessariamente parallelismo])[
  Le regioni esprimono evoluzioni logicamente concorrenti. L'implementazione può usare thread diversi oppure interleaving su un singolo thread, purché rispetti la semantica del modello.
]

== Quando usare una State Machine

Le macchine a stati sono utili quando un'entità possiede una logica interna significativa e la validità delle operazioni dipende dalla sua storia. Esempi tipici sono controllori automatici, distributori, protocolli, workflow documentali, dispositivi medicali e interfacce grafiche.

Sono meno utili per classi prevalentemente passive, servizi stateless o oggetti il cui comportamento non cambia sensibilmente nel tempo.

=== Esempio: controllore di un forno

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.3, 0), state-box([Forno spento], width: 39mm))
    content((3.3, 0), state-box([Forno acceso], width: 39mm, fill: uml-pale-amber, stroke: uml-amber))
    line((-1.7, .35), (1.7, .35), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((0, .85), text(6.8pt)[when(temp < riferimento) / apriManopola()])
    line((1.7, -.35), (-1.7, -.35), mark: (end: ">"), stroke: .8pt + uml-amber)
    content((0, -.85), text(6.8pt)[when(temp > riferimento) / chiudiManopola()])
  }),
  caption: [Il controllore reagisce agli eventi di cambiamento della temperatura.],
)

=== Esempio: workflow documentale

Un documento può attraversare gli stati `In attesa di upload`, `In attesa di assegnazione`, `In revisione` e `In attesa di approvazione`. L'approvazione termina il flusso; il rifiuto lo riporta in revisione. Le azioni — upload, assegnazione, revisione e approvazione — appartengono alle transizioni.

Prima di costruire il diagramma conviene:

1. scegliere l'entità e la prospettiva;
2. individuare gli stati in cui cambia la risposta agli eventi;
3. elencare gli eventi significativi;
4. aggiungere transizioni e guardie;
5. completare con azioni, stati composti e concorrenza solo quando necessari;
6. verificare casi limite, eventi inattesi e raggiungibilità degli stati.

== Implementazione

Nei linguaggi che non supportano direttamente le macchine a stati si usano principalmente tre strategie.

=== Switch sullo stato corrente

Un attributo memorizza lo stato; ogni metodo-evento esegue uno `switch` e seleziona la transizione valida. È diretto e adatto a modelli piccoli, ma diventa laborioso quando aumentano stati, eventi e modifiche.

#block(width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
```java
void restituzione() {
  switch (statoCorrente) {
    case IN_PRESTITO:
      if (condizione == BUONA) statoCorrente = DISPONIBILE;
      else statoCorrente = IN_MANUTENZIONE;
      break;
    default:
      throw new TransizioneNonValida();
  }
}
```
]

=== Design Pattern State

Ogni stato è rappresentato da una classe che implementa una stessa interfaccia. Il contesto delega allo stato corrente e il polimorfismo seleziona il comportamento. La soluzione separa le responsabilità e rende più semplici le estensioni, ma introduce più oggetti e classi.

=== Tabelle di stato e generazione

Una tabella elenca sorgente, destinazione, evento, guardia e azione. È una rappresentazione regolare, verificabile e adatta alla generazione automatica del codice con strumenti model-driven.

#table(
  columns: (1.2fr, 1.2fr, 1.1fr, 1.1fr, 1fr),
  inset: 4pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { uml-pale-blue },
  table.header([*Sorgente*], [*Destinazione*], [*Evento*], [*Guardia*], [*Azione*]),
  [Disponibile], [In prestito], [prestito], [—], [registra],
  [In prestito], [Disponibile], [restituzione], [buona], [ricolloca],
  [In prestito], [Manutenzione], [restituzione], [cattiva], [segnala],
)

Strumenti come SMC trasformano la tabella in una descrizione formale e generano la logica della macchina, spesso secondo il pattern State. Lo sviluppatore implementa poi le azioni applicative ed espone gli eventi come metodi.

#v(6pt)
#text(12pt, weight: "bold", fill: uml-blue)[Riepilogo]
#v(4pt)

#table(
  columns: (1.25fr, 2.75fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if calc.rem(y, 2) == 0 { rgb("#f6f9fb") },
  [*Stato*], [Astrazione delle situazioni con uguale comportamento agli eventi.],
  [*Transizione*], [`evento [guardia] / attività`; ogni parte è opzionale.],
  [*Semantica*], [Eventi accodati ed elaborati uno alla volta, run-to-completion.],
  [*Attività interne*], [`entry`, `exit`, `do` e reazioni senza cambio di stato.],
  [*Stato composito*], [Raggruppa sotto-stati e può contenere regioni concorrenti.],
  [*Implementazione*], [Switch, pattern State oppure tabella con generazione automatica.],
)
