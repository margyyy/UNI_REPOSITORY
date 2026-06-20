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

= Ingegneria dei requisiti

Un *requisito* descrive una proprietà che il sistema deve possedere: una funzione da offrire, un comportamento osservabile oppure un vincolo da rispettare. Può essere espresso a livelli di astrazione molto diversi, da un obiettivo generale in linguaggio naturale fino a una specifica dettagliata e matematica.

#green-box([Principio fondamentale])[
  Un requisito descrive principalmente *che cosa* il sistema deve fare, non *come* realizzarlo. Le decisioni implementative appartengono al design, salvo quando tecnologia, piattaforma o standard costituiscono essi stessi un vincolo richiesto.
]

Per esempio, per un ATM:

- “Il sistema deve controllare la validità della carta inserita” descrive una funzione;
- “Il sistema non deve erogare più di 250 euro per carta in un periodo di 24 ore” esprime una regola operativa misurabile.

=== Perché i requisiti sono decisivi

Una parte rilevante dei progetti fallisce per problemi che precedono la codifica. I dati riportati negli appunti mostrano che incompletezza dei requisiti e scarso coinvolgimento degli utenti occupano i primi posti.

#table(
  columns: (3fr, 1fr),
  inset: (x: 6pt, y: 3.5pt),
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { blue } else if calc.rem(y, 2) == 0 { rgb("#f6f9fb") },
  table.header(text(fill: white, weight: "bold")[Motivo di fallimento], text(fill: white, weight: "bold")[Percentuale]),
  [Incompletezza dei requisiti], [13,1%],
  [Mancato coinvolgimento degli utenti], [12,4%],
  [Carenza di risorse], [10,6%],
  [Aspettative non realistiche], [9,9%],
  [Mancato supporto del management], [9,3%],
  [Cambiamento di requisiti e specifiche], [8,7%],
  [Carenza di pianificazione], [8,1%],
  [Cambiamento di obiettivi], [7,5%],
  [Carenza di gestione del settore IT], [6,2%],
  [Incompetenza tecnologica], [4,3%],
  [Altro], [9,9%],
)

#pagebreak(weak: true)
=== Costo della scoperta tardiva

Un difetto introdotto nei requisiti diventa più costoso da correggere quanto più tardi viene scoperto: occorre modificare non soltanto la specifica, ma anche design, codice, test, documentazione ed eventualmente il sistema già distribuito. Validare presto i requisiti è quindi una strategia concreta di riduzione del costo e del rischio, non un adempimento burocratico.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let data = (("Design", 1.0, green), ("Implementazione", 6.5, blue), ("Testing", 15.0, gold), ("Manutenzione", 100.0, red))
    line((0, 0), (10.6, 0), stroke: .8pt + ink)
    line((0, 0), (0, 4.4), mark: (end: ">"), stroke: .8pt + ink)
    for tick in (0, 20, 40, 60, 80, 100) {
      let y = tick / 25
      line((0, y), (10.3, y), stroke: .35pt + rgb("#d8dee2"))
      content((-.25, y), text(7pt, str(tick)), anchor: "east")
    }
    for i in range(4) {
      let item = data.at(i)
      let x = 1.4 + i * 2.6
      let h = item.at(1) / 25
      rect((x - .55, 0), (x + .55, h), fill: item.at(2).transparentize(12%), stroke: .6pt + item.at(2))
      content((x, h + .24), text(8pt, weight: "bold", str(item.at(1)).replace(".0", "")))
      content((x, -.42), text(7.5pt, item.at(0)))
    }
    content((0, 4.7), text(7.5pt, weight: "bold")[costo relativo], anchor: "west")
  }),
  caption: [Costo relativo della rimozione di un difetto originato nei requisiti: 1 nel design, 6,5 nell'implementazione, 15 nel testing e 100 in manutenzione.],
)

== Livelli di dettaglio e rappresentazione

La documentazione procede normalmente da una descrizione comprensibile agli stakeholder verso una specifica abbastanza precisa da guidare progettazione, implementazione e test.

=== Requisiti utente

I *requisiti utente* descrivono in linguaggio naturale le funzionalità offerte e i principali vincoli operativi. Sono scritti per e con il cliente, devono essere comprensibili senza conoscenze tecniche e possono contribuire alla definizione contrattuale del prodotto.

Esempio per un editor grafico di modelli:

#blue-box([Requisito utente])[
  L'editor deve consentire all'utente di aggiungere al modello un nodo appartenente a un tipo specificato.
]

#figure(
  cetz.canvas({
    import cetz.draw: *
    let node(pos, label, color: pale-blue) = content(pos, box(width: 27mm, height: 10mm, inset: 3pt, radius: 3pt, fill: color, stroke: .6pt + blue, align(center, text(7.5pt, weight: "bold", label))))
    node((-4.5, 2), [Animal])
    node((-4.5, .8), [Mammal])
    node((-4.5, -.4), [Eutherians], color: pale-gold)
    line((-4.5, -.05), (-4.5, .4), mark: (end: ">"), stroke: .7pt + blue)
    line((-4.5, 1.2), (-4.5, 1.6), mark: (end: ">"), stroke: .7pt + blue)
    line((-2.8, .8), (-1.5, .8), mark: (end: ">"), stroke: 1.1pt + red)
    content((-2.15, 1.12), text(7pt, weight: "bold", fill: red)[aggiungi nodo])
    node((1, 2), [Animal])
    node((1, .8), [Mammal])
    node((-.7, -.4), [Eutherians], color: pale-gold)
    node((2.7, -.4), [Marsupials], color: pale-green)
    line((-.7, 0), (.65, .45), mark: (end: ">"), stroke: .7pt + blue)
    line((2.7, 0), (1.35, .45), mark: (end: ">"), stroke: .7pt + blue)
    line((1, 1.2), (1, 1.6), mark: (end: ">"), stroke: .7pt + blue)
  }),
  caption: [Il requisito utente esprime l'effetto osservabile: aggiungere al design un nuovo nodo e collegarlo correttamente alla gerarchia.],
)

=== Requisiti di sistema

I *requisiti di sistema* traducono gli obiettivi utente in specifiche dettagliate e verificabili. Possono usare linguaggio naturale strutturato, modelli visuali o linguaggi formali. Nell'esempio precedente la funzione viene precisata così:

1. l'utente seleziona il tipo di nodo da aggiungere;
2. sposta il cursore nella posizione approssimativa del diagramma;
3. conferma l'inserimento del simbolo in quel punto.

#table(
  columns: (1.1fr, 3.2fr),
  inset: 5pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { pale-blue },
  [*Funzione*], [Aggiunta di un nodo],
  [*Descrizione*], [Aggiunge un nodo a un design esistente; l'utente ne sceglie tipo e posizione. Il nodo aggiunto diventa la selezione corrente.],
  [*Input*], [Tipo del nodo, posizione, identificatore del design.],
  [*Origine*], [Tipo e posizione dall'utente; identificatore dal database.],
  [*Output*], [Identificatore del design aggiornato.],
  [*Destinazione*], [Database dei design, aggiornato al completamento.],
  [*Richiede*], [Grafo del design associato all'identificatore ricevuto.],
  [*Precondizione*], [Il design è aperto e visualizzato.],
  [*Postcondizione*], [Il design è invariato salvo l'aggiunta del nodo specificato nella posizione scelta.],
  [*Effetti collaterali*], [Nessuno.],
)

#yellow-box([Dal requisito utente al requisito di sistema])[
  Il primo comunica l'obiettivo agli stakeholder; il secondo elimina progressivamente ambiguità e fornisce dettagli sufficienti per costruire casi di test. I due livelli non sono concorrenti: servono destinatari diversi.
]

=== Modi di rappresentazione

I requisiti possono essere rappresentati con strumenti diversi, scelti in base a precisione richiesta, destinatari e costo di formalizzazione.

#table(
  columns: (1.2fr, 2.8fr),
  inset: 5pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { pale-blue },
  table.header([*Forma*], [*Caratteristiche*]),
  [Nessuna specifica], [Si passa direttamente all'implementazione: rapido ma rischioso e adatto soltanto a casi minimi.],
  [Linguaggio naturale], [Accessibile, ma può risultare ambiguo, incompleto o incoerente.],
  [Testo strutturato], [Template con campi obbligatori, precondizioni, input, output e postcondizioni.],
  [Notazioni visuali], [Diagrammi UML e altri modelli che rendono evidenti struttura e relazioni.],
  [Use case], [Descrivono le interazioni tra attori e sistema per raggiungere un obiettivo.],
  [User story], [Esprimono sinteticamente bisogno, soggetto e valore atteso.],
  [Linguaggi formali], [Notazioni matematiche, come Z, precise ma costose e specialistiche.],
)

== Requisiti funzionali e non funzionali

La distinzione fondamentale riguarda ciò che il sistema offre e le qualità o i vincoli entro cui deve operare.

=== Requisiti funzionali

I requisiti funzionali descrivono *funzioni e servizi*: ciò che il sistema deve fare, quali input tratta, quali risultati produce e come reagisce a determinate condizioni. Dovrebbero essere indipendenti dalla particolare soluzione implementativa.

Esempi per un sistema bancario:

- consentire la consultazione del saldo;
- permettere prelievo e produzione dell'estratto conto;
- richiedere, per il prelievo, l'autenticazione tramite un codice segreto memorizzato sulla carta.

=== Requisiti non funzionali

I requisiti non funzionali definiscono proprietà di qualità e vincoli sul prodotto o sul suo processo di sviluppo: prestazioni, affidabilità, usabilità, piattaforme, standard, formati, aspetti etici e obblighi legislativi.

Esempi:

- rispondere a un'interrogazione entro 3 secondi;
- produrre documenti in formato PDF;
- essere accessibile a persone con disabilità;
- funzionare su una piattaforma stabilita dall'organizzazione;
- essere facilmente espandibile per esigenze future.

Nell'esempio ATM, offrire prelievo, saldo ed estratto conto e autenticare il prelievo mediante codice segreto sono requisiti *funzionali*. Accessibilità, tempo di risposta, piattaforma ed espandibilità sono invece requisiti *non funzionali*.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let node(pos, label, color: pale-blue, w: 35mm, h: 12mm) = content(pos, box(width: w, height: h, inset: 3pt, radius: 3pt, fill: color, stroke: .6pt + blue, align(center + horizon, label)))
    let title(label) = text(7pt, weight: "bold", label)
    let items(values) = stack(dir: ttb, spacing: 1.5pt, ..values.map(v => text(6.5pt, v)))
    node((0, 3.2), title[Requisiti non funzionali], color: pale-gold, w: 43mm)
    node((-4.3, 1.8), title[Di prodotto], color: pale-blue)
    node((0, 1.8), title[Organizzativi], color: pale-green)
    node((4.3, 1.8), title[Esterni], color: rgb("#f3edf8"))
    line((0, 2.6), (-4.2, 2.35), mark: (end: ">"), stroke: .7pt + ink)
    line((0, 2.6), (0, 2.35), mark: (end: ">"), stroke: .7pt + ink)
    line((0, 2.6), (4.2, 2.35), mark: (end: ">"), stroke: .7pt + ink)
    node((-4.3, -.05), items(("Usabilità", "Efficienza: prestazioni e spazio", "Affidabilità", "Portabilità")), color: pale-blue, w: 43mm, h: 23mm)
    node((0, -.05), items(("Consegna", "Implementazione", "Standard organizzativi")), color: pale-green, w: 43mm, h: 23mm)
    node((4.3, -.05), items(("Interoperabilità", "Aspetti etici", "Legislazione: privacy e safety")), color: rgb("#f3edf8"), w: 43mm, h: 23mm)
    line((-4.3, 1.22), (-4.3, .75), mark: (end: ">"), stroke: .6pt + ink)
    line((0, 1.22), (0, .75), mark: (end: ">"), stroke: .6pt + ink)
    line((4.3, 1.22), (4.3, .75), mark: (end: ">"), stroke: .6pt + ink)
  }),
  caption: [Tassonomia dei requisiti non funzionali: proprietà del prodotto, vincoli organizzativi e vincoli esterni.],
)

#table(
  columns: (1fr, 3fr),
  inset: (x: 5pt, y: 3pt),
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { pale-blue },
  [*Di prodotto*], [Qualità osservabili nel sistema: usabilità, efficienza, affidabilità e portabilità. L'efficienza comprende prestazioni e memoria occupata.],
  [*Organizzativi*], [Vincoli del processo e delle politiche aziendali: consegna, modalità d'implementazione, linguaggi, strumenti e standard.],
  [*Esterni*], [Vincoli del contesto: interoperabilità, principi etici, leggi, privacy e safety.],
)

== Qualità e verifica dei requisiti

Una checklist aiuta a controllare la specifica prima che gli errori si propaghino nelle fasi successive. Ogni requisito dovrebbe poter essere letto come un'affermazione controllabile, non come un'intenzione vaga.

=== Checklist essenziale

#table(
  columns: (1.1fr, 2.9fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if calc.rem(y, 2) == 1 { rgb("#f6f9fb") },
  [*Necessario*], [Risponde a un bisogno reale di uno stakeholder o a un vincolo effettivo?],
  [*Chiaro*], [Ha una sola interpretazione ragionevole e usa termini definiti?],
  [*Completo*], [Specifica condizioni, soggetti, comportamento e risultato necessari?],
  [*Coerente*], [Non contraddice altri requisiti o regole del dominio?],
  [*Fattibile*], [Può essere realizzato con tecnologia, tempo e risorse disponibili?],
  [*Verificabile*], [È possibile dimostrare con test, misura, ispezione o analisi che è soddisfatto?],
  [*Tracciabile*], [Sono identificabili origine, motivazione e artefatti che lo implementano?],
  [*Prioritizzato*], [Importanza e urgenza sono note agli stakeholder?],
  [*Indipendente dalla soluzione*], [Evita dettagli tecnici non richiesti come veri vincoli?],
)

#yellow-box([Regola d'esame])[
  Parole come “rapido”, “facile”, “adeguato” o “user-friendly” non rendono un requisito verificabile. Occorre sostituirle con criteri osservabili: per esempio “il 95% delle richieste deve ricevere risposta entro 3 secondi”.
]

=== Dalla specifica al test

Un requisito ben formulato anticipa il criterio con cui sarà accettato. Precondizioni, input, comportamento atteso, output e postcondizioni costituiscono quindi un ponte tra requirements engineering e testing.

#green-box([Sintesi])[
  I requisiti efficaci sono comprensibili agli stakeholder, sufficientemente precisi per gli sviluppatori e verificabili dai tester. La loro qualità determina la qualità delle decisioni prese in tutte le fasi successive.
]
