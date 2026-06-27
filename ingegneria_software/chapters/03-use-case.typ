#import "../boxes.typ": *
#import "@preview/cetz:0.5.1"

#let blue = rgb("#245b88")
#let green = rgb("#327a50")
#let red = rgb("#a12a2a")
#let gold = rgb("#b67d0c")
#let ink = rgb("#23262b")
#let pale-blue = rgb("#eaf2f8")
#let pale-green = rgb("#edf7f1")
#let pale-gold = rgb("#fff6dc")

= Use case

Gli *use case* (casi d'uso), proposti da Ivar Jacobson nel 1992, esprimono i requisiti funzionali dal punto di vista di chi usa il sistema. Descrivono una storia di interazione orientata a uno scopo, senza entrare nella struttura interna o nella tecnologia impiegata.

Il “sistema” può essere un'organizzazione complessa, un prodotto software/hardware, una componente o un sottosistema. In ogni caso viene osservato come una *black box*: interessano i messaggi scambiati con l'esterno e il risultato visibile, non il modo in cui è costruito.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let actor(x, label) = {
      circle((x, 1.7), radius: .22, fill: white, stroke: .7pt + ink)
      line((x, 1.48), (x, .75), stroke: .7pt + ink)
      line((x - .42, 1.2), (x + .42, 1.2), stroke: .7pt + ink)
      line((x, .75), (x - .42, .2), stroke: .7pt + ink)
      line((x, .75), (x + .42, .2), stroke: .7pt + ink)
      content((x, -.18), text(8pt, weight: "bold", label))
    }
    actor(-3.5, [Utente])
    content((3.5, 1), box(width: 38mm, height: 28mm, radius: 5pt, fill: ink, align(center + horizon, text(10pt, weight: "bold", fill: white)[Sistema])))
    line((-2.4, 1.35), (1.45, 1.35), mark: (end: ">"), stroke: 1pt + blue)
    line((1.45, .65), (-2.4, .65), mark: (end: ">"), stroke: 1pt + green)
    content((-.45, 1.62), text(7.5pt, fill: blue)[richiesta])
    content((-.45, .38), text(7.5pt, fill: green)[risposta])
  }),
  caption: [Un use case descrive l'interazione tra attori esterni e sistema attraverso uno scambio ordinato di messaggi.],
)

#green-box([Use case e diagramma UML])[
  Lo use case è prima di tutto una *tecnica testuale*, indipendente dall'orientamento agli oggetti e da UML. Lo *Use Case Diagram* è invece una rappresentazione visuale UML che riassume attori, casi d'uso, relazioni e confine del sistema; non sostituisce la descrizione testuale.
]

=== Utilità nel ciclo di sviluppo

Uno use case collega il bisogno degli stakeholder agli artefatti successivi:

#table(
  columns: (1.2fr, 2.8fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { pale-blue },
  [*Requisiti*], [Esprime un obiettivo funzionale dal punto di vista dell'utilizzatore.],
  [*Design*], [Offre un punto di partenza per individuare responsabilità e componenti, senza imporre direttamente le classi.],
  [*Testing*], [Genera scenari e condizioni da trasformare in casi di prova.],
  [*Planning*], [Aiuta a raggruppare funzionalità e pianificare unità di rilascio.],
)

== Elementi di un modello di use case

Un modello completo combina quattro elementi: attori, casi d'uso, associazioni e confine del sistema.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let actor(x, y, label) = {
      circle((x, y + .9), radius: .18, fill: white, stroke: .7pt + ink)
      line((x, y + .72), (x, y + .15), stroke: .7pt + ink)
      line((x - .32, y + .5), (x + .32, y + .5), stroke: .7pt + ink)
      line((x, y + .15), (x - .32, y - .3), stroke: .7pt + ink)
      line((x, y + .15), (x + .32, y - .3), stroke: .7pt + ink)
      content((x, y - .62), text(7.5pt, weight: "bold", label))
    }
    let uc(pos, label, color: pale-blue) = {
      circle(pos, radius: (1.65, .55), fill: color, stroke: .7pt + blue)
      content(pos, text(7.5pt, weight: "bold", label))
    }
    rect((-2.4, -2.1), (5.1, 3.3), radius: 4pt, stroke: .8pt + blue, fill: blue.transparentize(96%))
    content((1.35, 3.62), text(9pt, weight: "bold", fill: blue)[Sistema di vendita])
    actor(-4.2, 1.5, [Cliente])
    actor(-4.2, -1.1, [Agente])
    uc((1.1, 2.2), [Visualizza prodotti])
    uc((1.1, .65), [Ordina prodotto], color: pale-green)
    uc((1.1, -.9), [Esegue pagamento], color: pale-gold)
    uc((3.6, -1.35), [Calcola commissioni])
    line((-3.75, 1.7), (-.55, 2.2), stroke: .65pt + ink)
    line((-3.75, 1.45), (-.55, .65), stroke: .65pt + ink)
    line((-3.75, 1.2), (-.55, -.9), stroke: .65pt + ink)
    line((-3.75, -.9), (-.55, 2.2), stroke: .65pt + ink)
    line((-3.75, -1.1), (-.55, .65), stroke: .65pt + ink)
    line((-3.75, -1.3), (-.55, -.9), stroke: .65pt + ink)
    line((-3.75, -1.5), (1.95, -1.35), stroke: .65pt + ink)
  }),
  caption: [Esempio di Use Case Diagram: gli attori restano fuori dal confine, mentre i casi d'uso appartengono al sistema.],
)

=== Confine del sistema

Il rettangolo di sistema stabilisce che cosa deve essere costruito e che cosa esiste già nell'ambiente. Il suo posizionamento modifica direttamente i requisiti funzionali: una responsabilità esterna non va specificata come comportamento interno e viceversa.

#red-box([Errore frequente])[
  Un confine ambiguo produce sovrapposizioni, funzionalità mancanti e aspettative incompatibili. Prima di descrivere gli use case bisogna chiarire sistemi esterni, persone, dispositivi e responsabilità organizzative.
]

=== Attori e ruoli

Un *attore* è il ruolo assunto da un'entità esterna durante l'interazione. Può essere una persona, un altro sistema o un dispositivo hardware. Non coincide con l'entità concreta: la stessa persona può agire, in momenti diversi, come cliente e amministratore; molte persone possono ricoprire lo stesso ruolo.

#table(
  columns: (1fr, 3fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { pale-blue },
  [*Attore primario*], [Persegue un obiettivo e ottiene valore dal sistema; normalmente avvia il caso d'uso. Esempio: il cliente che ordina un prodotto.],
  [*Attore secondario*], [Fornisce al sistema un servizio necessario. Esempio: il servizio esterno che autorizza un pagamento.],
)

=== Associazioni

Una linea tra attore e caso d'uso indica *partecipazione*, non un flusso dati né necessariamente chi avvia l'interazione. Le associazioni rispondono alla domanda: “quali ruoli collaborano alla realizzazione di questo obiettivo?”.

== Scenari e descrizione testuale

Uno *scenario* è una sequenza ordinata di interazioni tra attori e sistema. Rappresenta una particolare esecuzione, cioè un singolo cammino, di uno use case.

#blue-box([Use case e scenario])[
  Uno use case raccoglie tutti gli scenari che condividono lo stesso obiettivo finale. Per “prelevare contante” esistono il percorso di successo e percorsi alternativi: PIN errato, fondi insufficienti, ATM senza contante, richiesta di ricevuta o annullamento.
]

#figure(
  cetz.canvas({
    import cetz.draw: *
    let step(pos, label, color) = content(pos, box(width: 27mm, height: 11mm, radius: 50%, fill: color, stroke: .6pt + blue, align(center + horizon, text(7pt, weight: "bold", label))))
    step((0, 3), [Autenticazione], pale-blue)
    step((0, 1.7), [Scelta importo], pale-blue)
    step((0, .4), [Verifica fondi], pale-blue)
    step((0, -.9), [Erogazione], pale-green)
    line((0, 2.45), (0, 2.25), mark: (end: ">"), stroke: .7pt + ink)
    line((0, 1.15), (0, .95), mark: (end: ">"), stroke: .7pt + ink)
    line((0, -.15), (0, -.35), mark: (end: ">"), stroke: .7pt + ink)
    step((4.2, 1.7), [PIN errato], rgb("#f8e8e8"))
    step((4.2, .4), [Fondi insufficienti], rgb("#f8e8e8"))
    step((4.2, -.9), [ATM senza contante], rgb("#f8e8e8"))
    line((1.35, 3), (2.85, 1.7), mark: (end: ">"), stroke: (paint: red, thickness: .6pt, dash: "dashed"))
    line((1.35, .4), (2.85, .4), mark: (end: ">"), stroke: (paint: red, thickness: .6pt, dash: "dashed"))
    line((1.35, -.9), (2.85, -.9), mark: (end: ">"), stroke: (paint: red, thickness: .6pt, dash: "dashed"))
    content((-2.5, 1), text(8pt, weight: "bold", fill: blue)[scenario principale])
    content((4.2, -1.65), text(8pt, weight: "bold", fill: red)[scenari alternativi])
  }),
  caption: [Uno use case comprende un percorso principale e più deviazioni o scenari alternativi.],
)

Gli scenari concreti sono utili per scoprire i requisiti e per progettare i test; generalizzando più scenari si ottiene la descrizione complessiva dello use case.

=== Template di uno use case

Gli use case sono normalmente scritti con un template, usando il vocabolario del dominio e un linguaggio comprensibile al cliente.

#table(
  columns: (1.1fr, 3fr),
  inset: (x: 6pt, y: 4pt),
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { pale-blue },
  [*Nome*], [Breve frase verbale attiva che esprime l'obiettivo, per esempio “Preleva contante”.],
  [*Identificatore*], [Codice univoco, spesso numerico e progressivo.],
  [*Breve descrizione*], [Paragrafo che fissa lo scopo e il risultato atteso.],
  [*Attori primari*], [Ruoli che perseguono l'obiettivo.],
  [*Attori secondari*], [Ruoli o sistemi che forniscono servizi.],
  [*Precondizioni*], [Proprietà che devono essere vere prima dell'avvio.],
  [*Scenario principale*], [Sequenza nominale di passi che conduce al successo.],
  [*Postcondizioni*], [Proprietà vere dopo il completamento corretto.],
  [*Scenari alternativi*], [Elenco delle deviazioni documentate separatamente.],
)

#pagebreak(weak: true)
=== Esempio: prelevare contante

#block(
  width: 100%,
  inset: 9pt,
  radius: 4pt,
  fill: rgb("#f7f9fa"),
  stroke: .5pt + rgb("#cbd4da"),
)[
  *Caso d'uso:* Preleva contante  
  *Attore primario:* Cliente  
  *Precondizioni:* collegamento bancario attivo; ATM disponibile e dotato di contante.

  *Scenario principale*

  1. Il cliente inserisce la carta.
  2. Il sistema legge la carta e chiede il PIN.
  3. Il cliente inserisce il PIN.
  4. Il sistema convalida il PIN e mostra le operazioni disponibili.
  5. Il cliente seleziona “Prelievo” e indica l'importo.
  6. Il sistema verifica fondi e limiti giornalieri.
  7. Il sistema autorizza l'operazione, aggiorna il conto ed eroga il contante.
  8. Il sistema restituisce la carta e, se richiesta, stampa la ricevuta.

  *Postcondizione:* il conto riflette il prelievo e la sessione è conclusa.
]

=== Regole per i passi

I passi devono essere concisi, numerati e ordinati temporalmente. Il formato consigliato è: “`<numero> Il <soggetto> <azione>`”. Ogni passo attribuisce un comportamento osservabile al sistema oppure a un attore.

#yellow-box([Livello corretto di dettaglio])[
  Scrivere “Il cliente preme il pulsante OK” congela una scelta di interfaccia. È preferibile “Il cliente conferma l'ordine” oppure “Il sistema chiede al cliente di confermare l'ordine”.
]

== Deviazioni, ripetizioni e scenari alternativi

Una *deviazione* si verifica quando l'esecuzione si allontana dal percorso principale.

=== Deviazioni semplici e complesse

- Una deviazione breve può essere espressa inline con *se/altrimenti*.
- Una deviazione articolata, tipicamente un errore o un caso particolare che non rientra subito nel percorso principale, va documentata come scenario alternativo separato.

#block(
  width: 100%,
  inset: 9pt,
  radius: 4pt,
  fill: rgb("#f7f9fa"),
  stroke: .5pt + rgb("#cbd4da"),
)[
  *Estratto: Trova libro*

  1. Il cliente seleziona “Trova libro”.
  2. Il sistema richiede i criteri di ricerca.
  3. Il cliente inserisce i criteri e conferma.
  4. Il sistema ricerca i libri corrispondenti.
  5. *Se* trova uno o più libri, mostra l'elenco.
  6. *Altrimenti*, comunica che non sono stati trovati risultati.
]

=== Ripetizioni

Le ripetizioni devono essere esplicite:

- *Per ogni* esprime un'iterazione su un insieme: per ogni libro trovato, il sistema mostra immagine, caratteristiche e prezzo.
- *Fintantoché* esprime un ciclo condizionato: fintantoché i criteri non sono validi, il sistema li richiede nuovamente e li convalida.

=== Template di uno scenario alternativo

Uno scenario alternativo possiede un identificatore derivato dallo use case principale (per esempio `9.1`), breve descrizione, attori, precondizioni, sequenza e postcondizioni. Il primo passo specifica il punto d'innesto:

- “inizia dopo il passo X” quando può attivarsi soltanto in un punto preciso;
- “inizia in qualunque momento” per eventi sempre disponibili, come l'annullamento.

Nel template principale si elencano soltanto i nomi delle alternative, per esempio `PINNonValido`, `FondiInsufficienti` e `Annulla`. Identificatore e punto d'innesto rendono esplicita la relazione con il flusso principale.

È possibile definire *gerarchie* tra attori tramite *generalizzazione/specializzazione*.

- Un attore “figlio” *eredita tutte le relazioni* dell'attore “genitore”.
- Utile per rappresentare ruoli più specifici senza duplicare le associazioni.

#block(
  width: 100%,
  inset: (left: 8pt, right: 0pt, top: 2pt, bottom: 2pt),
  stroke: (left: 1.4pt + rgb("#7a58a6")),
)[
  Es. `Cliente` e `Agente` sono specializzazioni di `Acquirente`: entrambi ereditano automaticamente tutte le relazioni di `Acquirente`.
]

== Relazioni nel diagramma UML

Le relazioni strutturano il modello e riducono duplicazioni. Devono essere usate quando migliorano la comprensione, non come decorazione.

=== Inclusione (`include`)

L'inclusione estrae un comportamento obbligatorio e spesso comune a più use case. Il caso principale trasferisce il controllo al caso incluso e lo riprende al termine, in modo simile a una chiamata di procedura.

#figure(
  cetz.canvas({
    import cetz.draw: *
    circle((-3.2, 1.1), radius: (1.75, .6), fill: pale-blue, stroke: .7pt + blue)
    circle((-3.2, -1.1), radius: (1.75, .6), fill: pale-blue, stroke: .7pt + blue)
    circle((2.2, 0), radius: (1.75, .6), fill: pale-gold, stroke: .7pt + gold)
    content((-3.2, 1.1), text(7.5pt, weight: "bold")[Modifica dipendente])
    content((-3.2, -1.1), text(7.5pt, weight: "bold")[Visualizza dipendente])
    content((2.2, 0), text(7.5pt, weight: "bold")[Trova dipendente])
    line((-1.45, 1), (.45, .25), mark: (end: ">"), stroke: (paint: red, thickness: .7pt, dash: "dashed"))
    line((-1.45, -1), (.45, -.25), mark: (end: ">"), stroke: (paint: red, thickness: .7pt, dash: "dashed"))
    content((-.25, .75), text(7pt, fill: red)[«include»])
    content((-.25, -.75), text(7pt, fill: red)[«include»])
  }),
  caption: [`Trova dipendente` è un comportamento comune incluso obbligatoriamente dai casi principali.],
)

#red-box([Semantica dell'include])[
  Il caso principale è incompleto senza il caso incluso. Il caso incluso può essere un obiettivo autonomo oppure soltanto un frammento riutilizzabile.
]

=== Estensione (`extend`)

L'estensione aggiunge un comportamento opzionale a un caso base. Il caso base dichiara uno o più *extension point*, ma resta completo e comprensibile anche senza conoscere le estensioni.

#figure(
  cetz.canvas({
    import cetz.draw: *
    circle((-2.8, 0), radius: (1.75, .62), fill: pale-blue, stroke: .7pt + blue)
    circle((2.8, 0), radius: (1.75, .62), fill: pale-gold, stroke: .7pt + gold)
    content((-2.8, 0), text(8pt, weight: "bold")[Restituisci libro])
    content((2.8, 0), text(8pt, weight: "bold")[Emetti multa])
    line((1.0, 0), (-1.0, 0), mark: (end: ">"), stroke: (paint: red, thickness: .8pt, dash: "dashed"))
    content((0, .35), text(7pt, fill: red)[«extend»])
    content((-2.8, -.95), text(7pt, fill: blue)[extension point: restituzione in ritardo])
  }),
  caption: [`Emetti multa` estende opzionalmente `Restituisci libro` quando la restituzione è in ritardo.],
)

#table(
  columns: (1fr, 1fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  table.header([*`include`*], [*`extend`*]),
  [Comportamento sempre richiesto.], [Comportamento condizionale o opzionale.],
  [Il principale dipende dall'incluso.], [Il caso base è completo da solo.],
  [La freccia punta al caso incluso.], [La freccia punta al caso base.],
)

#pagebreak(weak: true)
=== Generalizzazione di attori

Un attore specializzato eredita tutte le associazioni dell'attore generale. Per esempio `Cliente` e `Agente` possono specializzare `Acquirente`, evitando di ripetere le relazioni comuni.

=== Generalizzazione di use case

Un caso figlio rappresenta una variante più specifica del genitore: eredita il comportamento, può aggiungere passi e può ridefinire quelli ereditati.

#figure(
  cetz.canvas({
    import cetz.draw: *
    circle((0, 2), radius: (1.8, .6), fill: pale-blue, stroke: .7pt + blue)
    circle((-2.4, 0), radius: (1.65, .6), fill: pale-green, stroke: .7pt + green)
    circle((2.4, 0), radius: (1.65, .6), fill: pale-green, stroke: .7pt + green)
    content((0, 2), text(8pt, weight: "bold")[Trova prodotto])
    content((-2.4, 0), text(8pt, weight: "bold")[Trova libro])
    content((2.4, 0), text(8pt, weight: "bold")[Trova CD])
    line((-2.4, .6), (-.45, 1.5), mark: (end: "triangle"), stroke: .8pt + ink)
    line((2.4, .6), (.45, 1.5), mark: (end: "triangle"), stroke: .8pt + ink)
  }),
  caption: [I casi specializzati ereditano l'obiettivo e il comportamento comune del caso generale.],
)

#yellow-box([Cautela])[
  Le convenzioni per indicare passi ereditati, aggiunti e ridefiniti possono essere difficili per stakeholder non tecnici. Generalizzazione ed estensione vanno introdotte soltanto se rendono il modello più semplice.
]

== Mockup, qualità della scrittura e limiti

=== Screen mockup

Uno use case può essere accompagnato da uno *screen mockup*: uno schizzo dell'interfaccia in uno specifico passo dello scenario. È utile nella negoziazione col cliente, guida lo sviluppatore e chiarisce le decisioni di UI, ma richiede tempo per essere prodotto e mantenuto.

I risultati sperimentali riportati negli appunti attribuiscono ai mockup un miglioramento del 69% nella comprensione degli use case e dell'89% nell'efficienza dei task di comprensione. Possono essere realizzati su carta o con strumenti di prototipazione come Pencil, usando stencil grafici per widget desktop, web e mobile.

=== Regole di buona scrittura

- mantenere scenario principale e use case brevi e semplici, idealmente entro una pagina A4;
- scegliere un livello intermedio: né troppo astratto né legato a dettagli inutili;
- descrivere interazioni osservabili, non funzionalità interne o algoritmi;
- usare il vocabolario del dominio e frasi comprensibili agli stakeholder;
- distinguere sempre il *cosa* dal *come*;
- evitare la decomposizione funzionale in casi astratti privi di valore autonomo;
- usare `include`, `extend` e generalizzazione soltanto quando semplificano davvero.

#green-box([Principio guida])[
  Gli use case sono documenti destinati a esseri umani. Precisione e struttura devono migliorare la comprensione, non trasformare la specifica in un esercizio di notazione UML.
]

=== Punti di forza e limiti

#table(
  columns: (1fr, 1fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  table.header([*Punti di forza*], [*Limiti*]),
  [Esprimono requisiti funzionali in forma narrativa e verificabile.], [Catturano male requisiti non funzionali trasversali.],
  [Sono diffusi nei sistemi informativi e nello Unified Process.], [Sono meno efficaci in sistemi dominati da algoritmi o con interazione esterna limitata.],
  [Guidano design, pianificazione dei rilasci e testing.], [Diagrammi senza specifiche testuali restano superficiali.],
  [Template diversi mantengono una struttura sostanzialmente equivalente.], [Un livello di dettaglio errato produce testi vaghi o vincolati prematuramente alla UI.],
)

#yellow-box([Regola d'esame])[
  Uno use case non coincide con una funzione interna e non coincide con una singola schermata: descrive un obiettivo dell'attore realizzato attraverso più interazioni osservabili.
]

=== Riepilogo

Use case, scenari e diagrammi hanno ruoli complementari: il caso d'uso raccoglie i percorsi orientati a un obiettivo; lo scenario rappresenta un singolo percorso; il diagramma UML offre una mappa sintetica di attori, obiettivi e relazioni. La specifica testuale resta la fonte principale del comportamento richiesto.
