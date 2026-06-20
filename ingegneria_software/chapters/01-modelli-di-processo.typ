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

= Modelli di processo di sviluppo software

== Il processo di sviluppo

#green-box([Idea fondamentale])[
  L'ingegneria del software tratta il software come un prodotto industriale: non considera soltanto il codice finale, ma soprattutto il *processo* con cui esso viene concepito, costruito, verificato e mantenuto.
]

Un *processo di sviluppo software* è un insieme strutturato e organizzato di attività finalizzate alla produzione di un sistema software. Stabilisce:

- *quali attività* devono essere svolte;
- *in quale ordine* devono avvenire;
- quali *regole* e responsabilità governano il lavoro;
- quali risultati intermedi, detti *artefatti*, devono essere prodotti.

Modellare il processo dà ordine, controllo e ripetibilità a un'attività altrimenti difficile da pianificare. Secondo Barry Boehm, un modello determina l'ordine delle fasi, i criteri per passare da una fase alla successiva e aiuta a rispondere a due domande operative: *che cosa fare dopo?* e *per quanto tempo?*

#blue-box([Processo e prodotto])[
  Un processo migliore tende ad aumentare produttività e qualità, ma la relazione non è automatica: un buon processo riduce il rischio di errori sistematici, mentre la qualità finale dipende anche da persone, tecnologia, requisiti e contesto.
]

== Modelli di processo

Un *modello di processo* è una rappresentazione astratta del processo reale. Non descrive ogni dettaglio operativo: seleziona le attività e le relazioni più importanti per guidare e coordinare il team.

I modelli si collocano lungo uno spettro tra due estremi:

#table(
  columns: (1.2fr, 1fr, 2.8fr),
  inset: 6pt,
  stroke: 0.4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { pale-blue },
  table.header([*Modello*], [*Regole/pratiche*], [*Grado di prescrittività*]),
  [RUP], [oltre 120], [Molto prescrittivo e fortemente documentato],
  [XP], [13], [Adattivo, ma con pratiche ingegneristiche precise],
  [Scrum], [9], [Prescrive ruoli, eventi e iterazioni, non le tecniche di sviluppo],
  [Kanban], [3], [Poche regole e flusso continuo],
  [“Do whatever”], [0], [Nessuna struttura esplicita],
)

Scrum è meno prescrittivo di XP perché non impone specifiche pratiche ingegneristiche; è però più prescrittivo di Kanban, poiché definisce iterazioni, ruoli ed eventi.

#yellow-box([Attenzione alla terminologia])[
  Non esiste una nomenclatura universale: nomi diversi possono indicare lo stesso modello e lo stesso nome può assumere significati diversi secondo autore e contesto. Bisogna verificare sempre le pratiche concrete associate al termine.
]

La scelta del modello spetta tipicamente a manager e project manager e dipende dal prodotto, dai rischi, dalle competenze, dalla dimensione del team e dai vincoli organizzativi. Non esiste un modello migliore in assoluto.

== Prospettiva storica

#table(
  columns: (1fr, 3fr),
  inset: 6pt,
  stroke: 0.4pt + rgb("#d5dadd"),
  fill: (x, y) => if calc.rem(y, 2) == 0 { rgb("#f7f9fa") },
  [*Prima del 1965*], [Produzione artigianale e approccio Code & Fix.],
  [*1955–1960*], [Prime applicazioni pratiche di processi sequenziali in grandi progetti.],
  [*1965–1985*], [“Crisi del software”: costi, ritardi e qualità mostrano i limiti dello sviluppo non disciplinato.],
  [*1968*], [La conferenza NATO consacra il termine _software engineering_.],
  [*1970*], [Winston Royce descrive formalmente il processo sequenziale poi chiamato Waterfall.],
  [*Dal 1975*], [Si diffondono prototipazione e modelli evolutivi.],
  [*1986–1988*], [V-Model e modello a spirale di Barry Boehm.],
  [*Anni Novanta*], [Web engineering, CBSE, Unified Process ed Extreme Programming.],
  [*Dal 2000*], [Metodi agili, Model-Driven Development e, dal 2009 circa, DevOps.],
)

Fred Brooks, nel saggio _No Silver Bullet_, sostiene che non esiste una singola innovazione capace di eliminare rapidamente la complessità essenziale dello sviluppo software.

== Tipi di modelli di processo

I modelli seguenti rappresentano le principali strategie con cui organizzare lo sviluppo, dalla produzione non strutturata fino ai processi iterativi, guidati dal rischio, basati sul riuso o sui metodi formali.

=== Code & Fix

Code & Fix è l'approccio più elementare: si comprende il bisogno in modo informale, si scrive il codice, lo si esegue e si correggono gli errori fino alla consegna. Non esistono vere fasi di analisi e progettazione.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let node(pos, label, color) = content(pos, box(width: 27mm, inset: 5pt, radius: 4pt, fill: color, stroke: .7pt + blue, align(center, text(9pt, weight: "bold", label))))
    node((0, 0), [Comprendi], pale-blue)
    node((3.4, 0), [Scrivi codice], pale-blue)
    node((6.8, 0), [Esegui e testa], pale-blue)
    node((10.2, 0), [Consegna], pale-green)
    line((1.35, 0), (2.05, 0), mark: (end: ">"), stroke: .8pt + ink)
    line((4.75, 0), (5.45, 0), mark: (end: ">"), stroke: .8pt + ink)
    line((8.15, 0), (8.85, 0), mark: (end: ">"), stroke: .8pt + ink)
    line((6.8, -.5), (6.8, -1.15), (3.4, -1.15), (3.4, -.5), mark: (end: ">"), stroke: .8pt + red)
    content((5.1, -1.42), text(8pt, fill: red)[correggi gli errori])
  }),
  caption: [Flusso essenziale del Code & Fix.],
)

È accettabile soltanto per programmi molto piccoli, indicativamente sotto le 1500 righe di codice. Su progetti grandi o multi-sviluppatore, l'assenza di piano, documentazione e controlli rende difficile coordinare il lavoro e governare la qualità.

=== Modello a cascata (Waterfall)

Il modello a cascata è il primo modello storico strutturato. Fu impiegato in grandi progetti, anche nel settore della difesa statunitense, e formalizzato da Winston Royce nel 1970. Introduce una sequenza di fasi: l'artefatto prodotto da ciascuna fase diventa l'ingresso di quella successiva.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let labels = ([Analisi dei requisiti], [Progettazione], [Implementazione], [Verifica], [Manutenzione])
    let colors = (pale-blue, pale-blue, pale-green, pale-gold, rgb("#f3edf8"))
    for i in range(5) {
      let x = i * 2.15
      let y = i * -0.78
      content((x, y), box(width: 30mm, inset: 5pt, radius: 3pt, fill: colors.at(i), stroke: .7pt + blue, align(center, text(8.5pt, weight: "bold", labels.at(i)))))
      if i < 4 { line((x + 1.45, y), (x + 2.15 - 1.45, y - .78), mark: (end: ">"), stroke: .8pt + ink) }
    }
  }),
  caption: [Nel Waterfall il lavoro procede per fasi sequenziali e consegne documentali.],
)

Le fasi fondamentali sono:

1. *Analisi dei requisiti*: raccolta e documentazione delle necessità degli stakeholder.
2. *Progettazione*: definizione dell'architettura e delle soluzioni tecniche.
3. *Implementazione*: traduzione del progetto in codice.
4. *Verifica*: controllo del comportamento del sistema mediante test.
5. *Manutenzione*: correzioni e modifiche successive al rilascio.

==== Le indicazioni di Royce

Royce sottolinea cinque accorgimenti: progettare il programma prima della codifica, mantenere completa e aggiornata la documentazione, realizzare se possibile un prototipo preliminare (“fare il lavoro due volte”), pianificare e monitorare il testing fin dall'inizio e coinvolgere il cliente.

#table(
  columns: (1fr, 1fr),
  inset: 7pt,
  stroke: 0.4pt + rgb("#d5dadd"),
  table.header([*Punti di forza*], [*Limiti*]),
  [Disciplina, pianificazione ed enfasi su analisi e design.], [Rigidità e scarso parallelismo tra le fasi.],
  [Adatto a requisiti stabili e ben compresi.], [Il cliente vede tardi il prodotto funzionante.],
  [Artefatti e responsabilità chiaramente identificabili.], [Le modifiche tardive sono costose e la documentazione può diventare eccessiva.],
)

==== Studio di fattibilità

Prima dello sviluppo si valuta se il progetto sia conveniente e realizzabile. Lo studio considera costi, tempi, capacità tecniche, ritorno dell'investimento (*ROI*) e alternative come acquistare e personalizzare un prodotto esistente oppure svilupparlo da zero. Il risultato è una decisione *Go/No-go*.

==== Varianti

- *Cascata con prototipazione*: un prototipo “usa e getta” chiarisce requisiti e scelte prima del processo completo.
- *Cascata con feedback*: sono consentiti ritorni alle fasi precedenti quando emergono errori, attenuando la rigidità del modello puro.

#pagebreak(weak: true)
=== V-Model

Il V-Model è una variante del Waterfall che rende esplicita la relazione tra ogni attività di analisi/progettazione e il corrispondente livello di test. Il codice occupa il vertice inferiore della V: a sinistra si scompone il problema, a destra si integra e verifica la soluzione.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let node(pos, label, color, w: 34mm) = content(pos, box(width: w, inset: 5pt, radius: 4pt, fill: color, stroke: .7pt + blue, align(center, text(8.5pt, weight: "bold", label))))
    node((-5.4, 3), [Analisi dei requisiti], pale-blue)
    node((-3.6, 1.8), [High-level design], pale-blue)
    node((-1.8, .6), [Detailed design], pale-blue)
    node((0, -.7), [Coding], pale-green, w: 27mm)
    node((1.8, .6), [Unit & integration testing], pale-gold, w: 37mm)
    node((3.6, 1.8), [System testing], pale-gold)
    node((5.4, 3), [Acceptance testing], pale-gold)
    line((-5.4, 2.58), (-3.6, 2.22), mark: (end: ">"), stroke: .8pt + ink)
    line((-3.6, 1.38), (-1.8, 1.02), mark: (end: ">"), stroke: .8pt + ink)
    line((-1.8, .18), (0, -.28), mark: (end: ">"), stroke: .8pt + ink)
    line((0, -.28), (1.8, .18), mark: (end: ">"), stroke: .8pt + ink)
    line((1.8, 1.02), (3.6, 1.38), mark: (end: ">"), stroke: .8pt + ink)
    line((3.6, 2.22), (5.4, 2.58), mark: (end: ">"), stroke: .8pt + ink)
    line((-5.4, 3.48), (5.4, 3.48), stroke: (paint: red, thickness: .6pt, dash: "dashed"))
    line((-3.6, 2.28), (3.6, 2.28), stroke: (paint: red, thickness: .6pt, dash: "dashed"))
    line((-1.8, 1.08), (1.8, 1.08), stroke: (paint: red, thickness: .6pt, dash: "dashed"))
    content((0, 3.72), text(7pt, fill: red)[verifica i requisiti])
    content((0, 2.52), text(7pt, fill: red)[verifica il design])
    content((0, 1.32), text(7pt, fill: red)[guida i test di unità e integrazione])
  }),
  caption: [V-Model: ogni specifica preparata sul ramo sinistro è verificata dal test corrispondente sul ramo destro.],
)

#table(
  columns: (1fr, 1.4fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { pale-blue },
  table.header([*Analisi/design*], [*Test corrispondente*]),
  [Analisi dei requisiti], [Acceptance testing con il cliente],
  [High-level design], [System testing sul sistema completo],
  [Detailed design], [Unit e integration testing],
)

Le relazioni orizzontali hanno due direzioni concettuali. Le specifiche prodotte a sinistra *guidano* la preparazione dei test a destra; quando un test rivela un'incoerenza, il team può dover “mettere mano” alla specifica corrispondente. La preparazione dei test può quindi procedere in parallelo alle attività di analisi e design, anche se la loro esecuzione avviene dopo il coding.

Waterfall e V-Model soffrono quando i requisiti non possono essere congelati, quando il feedback arriva soltanto alla fine o quando errori iniziali si propagano fino alle fasi più costose.

=== Modelli evolutivi

#green-box([Idea di base])[
  Il prodotto non viene costruito in un'unica soluzione: si parte da un'implementazione parziale, la si espone agli utenti e la si raffina attraverso release successive.
]

I tre approcci principali sono prototipazione, sviluppo incrementale e sviluppo iterativo.

==== Prototipazione

Un prototipo è una versione anticipata del sistema, con meno funzionalità o qualità inferiore rispetto al prodotto finale. Può essere:

- *throwaway*: serve a ridurre l'incertezza e viene poi scartato;
- *evolutivo*: viene raffinato fino a diventare il prodotto finale.

Il ciclo tipico comprende requisiti, quick design, costruzione del prototipo, valutazione del cliente e raffinamento. Conviene prototipizzare soprattutto le parti caratterizzate da requisiti vaghi, rischi tecnici o forti dubbi di usabilità.

#table(
  columns: (1fr, 1fr),
  inset: 7pt,
  stroke: .4pt + rgb("#d5dadd"),
  table.header([*Vantaggi*], [*Rischi*]),
  [Chiarisce requisiti incompleti e migliora la comunicazione.], [Un prototipo da scartare ha un costo economico.],
  [Fa emergere presto errori e rischi.], [Cliente e team possono essere riluttanti a buttare codice funzionante.],
  [Consente di validare interazione e scelte tecniche.], [Scorciatoie e architettura debole possono finire nel prodotto.],
)

==== Sviluppo iterativo-incrementale

Ogni release è pianificata, analizzata, progettata, implementata, testata e valutata dagli utenti. Mentre gli utenti lavorano con una release, il team può costruire la successiva.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let feature(x, y, label, color) = content((x, y), box(width: 23mm, inset: 4pt, radius: 3pt, fill: color, stroke: .6pt + blue, align(center, text(7.5pt, label))))
    content((-1.7, 2.2), text(9pt, weight: "bold", fill: blue)[Incrementale])
    for i in range(3) {
      feature(i * 2.4, 1.35, [Testo], pale-blue)
      if i > 0 { feature(i * 2.4, .65, [Copia/incolla], pale-green) }
      if i > 1 { feature(i * 2.4, -.05, [Formattazione], pale-gold) }
      content((i * 2.4, -0.65), text(8pt)[Release #str(i + 1)])
    }
    line((-2.2, -1.15), (7, -1.15), stroke: .5pt + rgb("#aeb7bd"))
    content((-1.7, -1.65), text(9pt, weight: "bold", fill: blue)[Iterativo])
    for i in range(3) {
      let shades = (rgb("#f7e4e4"), pale-gold, pale-green)
      content((i * 2.4, -2.55), box(width: 25mm, height: 14mm, inset: 3pt, radius: 3pt, fill: shades.at(i), stroke: .6pt + blue, align(center, stack(dir: ttb, spacing: 1pt, text(7pt)[Tutte le funzioni], text(6.5pt)[qualità #str(i + 1)]))))
      content((i * 2.4, -3.35), text(8pt)[Release #str(i + 1)])
    }
  }),
  caption: [Incrementale: cresce l'insieme delle funzioni. Iterativo: cresce la qualità delle funzioni già presenti.],
)

Nel modello *incrementale* ogni release aggiunge funzionalità senza eliminare quelle precedenti. Nel modello *iterativo* tutte le funzionalità principali sono presenti fin dall'inizio, ma vengono progressivamente migliorate. I due principi sono spesso combinati nello stesso progetto.

Le release possono dare precedenza alle funzionalità a rischio più alto oppure a quelle di maggior valore per l'utente. I vantaggi sono risposta rapida al mercato, feedback continuo, stime più gestibili e scoperta precoce degli errori.

=== Modello a spirale

Il modello a spirale, proposto da Barry Boehm nel 1988, è pensato per sistemi grandi e complessi. È *risk-driven*: il contenuto di ogni ciclo dipende dai rischi più importanti da affrontare. È anche un meta-modello, perché nel quadrante di engineering può impiegare Waterfall, prototipazione o altri processi.

#red-box([Rischio])[
  Un rischio è una circostanza sfavorevole che può compromettere progetto o prodotto. La sua esposizione si valuta combinando *probabilità* e *gravità delle conseguenze*: $E(R) = P(R) times I(R)$.
]

Esempi sono tecnologie immature, componenti esterni inaffidabili e competenze insufficienti nel team.

#figure(
  cetz.canvas({
    import cetz.draw: *
    line((-4.4, 0), (4.4, 0), stroke: .5pt + rgb("#aeb7bd"))
    line((0, -3.2), (0, 3.2), stroke: .5pt + rgb("#aeb7bd"))
    let quadrant(pos, title, body, color, border) = content(pos, box(width: 47mm, height: 17mm, inset: 4pt, radius: 4pt, fill: color, stroke: .6pt + border, align(center, stack(dir: ttb, spacing: 1pt, text(8pt, weight: "bold", title), text(7pt, body)))))
    line((-1.3, .35), (-1.3, 1.35), (1.3, 1.35), (1.3, -.8), (-2.2, -.8), (-2.2, 2.05), (2.8, 2.05), (2.8, -1.55), (-3.2, -1.55), (-3.2, 2.75), (3.65, 2.75), mark: (end: ">"), stroke: 1pt + blue)
    quadrant((-2.55, 2.45), "1. Planning", "Obiettivi, alternative, vincoli", pale-blue, blue)
    quadrant((2.55, 2.45), "2. Risk analysis", "Rischi, mitigazioni, Go/No-go", rgb("#f7eaea"), red)
    quadrant((2.55, -2.45), "3. Engineering", "Sviluppo e verifica", pale-green, green)
    quadrant((-2.55, -2.45), "4. Customer evaluation", "Revisione e feedback", pale-gold, gold)
  }),
  caption: [Ogni giro attraversa i quattro quadranti e amplia il prodotto e l'impegno economico.],
)

Il modello affronta presto i problemi critici, ma richiede grande competenza nell'identificazione e nella stima dei rischi. Un rischio importante non riconosciuto può comunque compromettere il progetto.

=== Unified Process (UP/RUP)

Unified Process nasce dall'unificazione dei metodi di Grady Booch, James Rumbaugh e Ivar Jacobson, i “tre amigos” legati anche alla nascita di UML. La versione commerciale più nota è Rational Unified Process (RUP).

UP è orientato agli oggetti, guidato dai casi d'uso, basato su UML, iterativo e incrementale, attento ai rischi e fortemente plan-driven.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let phases = (([Inception], 0, 1.7, pale-blue), ([Elaboration], 1.7, 4.6, pale-gold), ([Construction], 4.6, 8.7, pale-green), ([Transition], 8.7, 11.2, rgb("#f3edf8")))
    for phase in phases {
      content(((phase.at(1) + phase.at(2)) / 2, 2.35), box(width: (phase.at(2) - phase.at(1)) * 10mm, inset: 4pt, fill: phase.at(3), stroke: .6pt + blue, align(center, text(8pt, weight: "bold", phase.at(0)))))
    }
    let rows = (([Requisiti], (1.4, 1.0, .35, .15)), ([Analisi], (1.0, 1.25, .5, .15)), ([Design], (.35, 1.1, 1.15, .35)), ([Codifica], (.1, .35, 1.5, .45)), ([Testing], (.1, .25, 1.1, 1.0)))
    for r in range(5) {
      content((-1.1, 1.45 - r * .65), text(7.5pt, weight: "bold", rows.at(r).at(0)), anchor: "east")
      let vals = rows.at(r).at(1)
      let xs = (.85, 3.15, 6.65, 9.95)
      for i in range(4) {
        let h = vals.at(i) * .36
        rect((xs.at(i) - .55, 1.25 - r * .65), (xs.at(i) + .55, 1.25 - r * .65 + h), fill: blue.transparentize(35%), stroke: none)
      }
    }
    line((0, -1.7), (11.2, -1.7), mark: (end: ">"), stroke: .8pt + ink)
    content((5.6, -2.05), text(8pt)[tempo e iterazioni])
    line((11.25, .25), (12.15, .25), mark: (end: ">"), stroke: .8pt + green)
    content((12.25, .25), text(7.5pt, weight: "bold", fill: green)[rilascio], anchor: "west")
  }),
  caption: [In UP tutte le discipline ricorrono, ma con intensità diversa nelle quattro fasi.],
)

Le quattro fasi sono:

1. *Inception*: fattibilità, requisiti essenziali e rischi principali — “il progetto ha senso?”.
2. *Elaboration*: dominio, casi d'uso e architettura — “sappiamo che cosa costruire e come?”.
3. *Construction*: design di dettaglio, codice e test — “il software funziona?”.
4. *Transition*: deployment, formazione e accettazione — “gli utenti riescono a usarlo?”.

Ogni fase contiene una o più *iterazioni* e termina con una milestone. In ogni iterazione ricorrono requisiti, analisi, design, codifica e testing, ma la loro intensità cambia nel tempo. Il completamento della Transition conduce al rilascio del prodotto agli utenti.

#pagebreak(weak: true)
=== Component-Based Software Engineering (CBSE)

CBSE costruisce sistemi componendo elementi software preesistenti e già testati. Il riuso può ridurre codice, costi e rischi, ma questi benefici dipendono dalla qualità dei componenti e dal costo d'integrazione.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let labels = ([Requisiti], [Analisi dei componenti], [Modifica dei requisiti], [Design con riuso], [Sviluppo e integrazione], [Validazione])
    for i in range(6) {
      let x = calc.rem(i, 3) * 3.7
      let y = if i < 3 { 1.2 } else { -.5 }
      content((x, y), box(width: 32mm, height: 13mm, inset: 4pt, radius: 4pt, fill: if i == 2 { pale-gold } else if i >= 4 { pale-green } else { pale-blue }, stroke: .7pt + blue, align(center, text(8pt, weight: "bold", labels.at(i)))))
      if i == 0 or i == 1 or i == 3 or i == 4 { line((x + 1.6, y), (x + 2.1, y), mark: (end: ">"), stroke: .8pt + ink) }
    }
    line((7.4, .55), (7.4, .15), (0, .15), (0, .15), (0, .15), (0, .15), (0, .15), (0, -.05), mark: (end: ">"), stroke: .8pt + ink)
  }),
  caption: [Nel CBSE anche i requisiti vengono negoziati in funzione dei componenti disponibili.],
)

Durante l'analisi si cercano anzitutto componenti già disponibili; se non sono sufficienti, se ne possono acquistare di nuovi oppure sviluppare le parti mancanti. Il passaggio cruciale è la *modifica dei requisiti*: ciò che il cliente desidera deve essere conciliato con ciò che i componenti offrono. I limiti principali sono compromessi funzionali, difficoltà d'integrazione e perdita di controllo sull'evoluzione delle dipendenze esterne.

=== Modello trasformazionale e metodi formali

Il modello trasformazionale usa notazioni matematiche, come il linguaggio Z, per passare da requisiti informali a specifiche sempre più vicine all'esecuzione. Ogni trasformazione dovrebbe preservare la correttezza.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let labels = ([Requisiti informali], [Specifiche formali], [Specifiche di basso livello], [Codice eseguibile])
    for i in range(4) {
      content((i * 3.6, 0), box(width: 30mm, height: 15mm, inset: 4pt, radius: 4pt, fill: if i == 3 { pale-green } else { pale-blue }, stroke: .7pt + blue, align(center, text(7.5pt, weight: "bold", labels.at(i)))))
      if i < 3 {
        line((i * 3.6 + 1.5, 0), (i * 3.6 + 2.1, 0), mark: (end: ">"), stroke: .8pt + ink)
        content((i * 3.6 + 1.8, .42), text(8pt, weight: "bold", fill: red, [T#sub(str(i + 1))]))
        content((i * 3.6 + 1.8, -.58), text(6.5pt, fill: red)[correttezza preservata])
      }
    }
  }),
  caption: [Catena di raffinamenti nel modello trasformazionale.],
)

Ogni trasformazione $T_i$ prende una specifica e ne produce una più concreta, senza alterarne il significato previsto. In teoria, prove matematiche sui passaggi possono garantire proprietà molto forti. Il costo e la competenza richiesti ne limitano però l'uso a domini critici. Questo approccio anticipa il moderno Model-Driven Development, in cui modelli formali o semi-formali generano automaticamente parte del codice.

== Approcci plan-driven e metodi agili

#table(
  columns: (1.2fr, 1fr, 1fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { pale-blue },
  table.header([*Aspetto*], [*Plan-driven*], [*Agile*]),
  [Pianificazione], [Prevalentemente anticipata], [Progressiva e adattiva],
  [Requisiti], [Stabili e documentati], [Evolvono col feedback],
  [Misura del progresso], [Piano e artefatti], [Software funzionante],
  [Cliente], [Coinvolto in momenti definiti], [Collaborazione frequente],
  [Documentazione], [Estesa e formale], [Quanto basta al prodotto e al team],
  [Esempi], [Waterfall, V-Model, Spirale, UP], [XP, Scrum],
)

Gli approcci plan-driven privilegiano processi definiti, documentazione e controllo formale. Gli approcci agili nascono per rispondere rapidamente al cambiamento e dare priorità a software funzionante e collaborazione col cliente.

=== Pratiche di Extreme Programming

- iterazioni brevi di due-quattro settimane;
- design semplice secondo il principio KISS;
- refactoring continuo senza cambiare il comportamento osservabile;
- brevi meeting giornalieri;
- conoscenza condivisa soprattutto attraverso il team;
- cliente disponibile e vicino al gruppo di sviluppo.

=== Limiti dei metodi agili

Sul piano gestionale richiedono persone competenti e motivate; turnover elevato può disperdere conoscenza tacita. Sul piano legale è difficile fissare contratti quando ambito e risultato evolvono. Sul piano della manutenzione, documentazione insufficiente e architettura cresciuta senza controllo possono generare debito tecnico.

== Come scegliere il modello

#table(
  columns: (1fr, 1fr),
  inset: 7pt,
  stroke: .4pt + rgb("#d5dadd"),
  table.header([*Preferire un approccio plan-driven quando…*], [*Preferire un approccio agile quando…*]),
  [Il sistema è grande, complesso o safety-critical.], [Il team è piccolo, esperto e co-locato.],
  [I requisiti sono stabili e verificabili in anticipo.], [I requisiti sono volatili o ancora da scoprire.],
  [Servono tracciabilità, certificazioni e documenti formali.], [Gli utenti possono offrire feedback frequente.],
  [Il lavoro coinvolge molti team distribuiti.], [È importante consegnare valore rapidamente.],
)

#yellow-box([Regola d'esame])[
  La scelta è contestuale: dimensione, criticità, volatilità dei requisiti, disponibilità del cliente, distribuzione del team e capacità di gestione del rischio contano più dell'etichetta del modello. Nella pratica sono comuni processi ibridi.
]

== Riepilogo

#table(
  columns: (1.2fr, 2fr),
  inset: (x: 6pt, y: 3.5pt),
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if calc.rem(y, 2) == 0 { rgb("#f7f9fa") },
  [*Primitivo*], [Code & Fix],
  [*Sequenziale*], [Waterfall, V-Model],
  [*Evolutivo*], [Prototipazione, incrementale, iterativo],
  [*Guidato dal rischio*], [Modello a spirale],
  [*Processo unificato*], [UP / RUP],
  [*Basato sul riuso*], [CBSE],
  [*Formale*], [Modello trasformazionale],
  [*Adattivo*], [XP, Scrum, Kanban],
)

Il filo conduttore è il compromesso tra pianificazione e adattamento. Più aumenta l'incertezza, più diventano importanti feedback e iterazioni; più aumentano criticità, scala e obblighi di conformità, più servono disciplina, tracciabilità e controllo esplicito.
