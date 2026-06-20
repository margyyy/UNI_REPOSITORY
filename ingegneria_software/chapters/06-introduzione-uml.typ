#import "../boxes.typ": *
#import "@preview/cetz:0.5.1"
#import "../uml.typ": *

= Introduzione a UML

UML (*Unified Modeling Language*) è una famiglia unificata di notazioni grafiche per descrivere, progettare e documentare sistemi. È particolarmente diffusa per sistemi object-oriented, ma può modellare anche hardware, organizzazioni e domini di business. Lo standard è mantenuto dall'OMG (*Object Management Group*).

#red-box([Che cosa UML non è])[
  UML non è una metodologia di sviluppo, non è normalmente un linguaggio di programmazione e non è vincolato allo Unified Process. Può essere usato in processi plan-driven, iterativi o agili.
]

== Modi d'uso e prospettive

=== Sketch, blueprint e linguaggio eseguibile

#table(
  columns: (1fr, 2.8fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { rgb("#eaf2f8") },
  [*Sketch*], [Diagramma parziale per comunicare, discutere e chiarire le decisioni più importanti. Si realizza anche su lavagna.],
  [*Blueprint*], [Modello dettagliato che dovrebbe guidare quasi meccanicamente l'implementazione; richiede strumenti di modellazione e manutenzione rigorosa.],
  [*Linguaggio eseguibile*], [Modello sufficientemente formale da essere trasformato o eseguito da strumenti specifici.],
)

Nella pratica lo sketch è l'uso più comune: seleziona l'informazione utile invece di rappresentare ogni dettaglio. Un blueprint completo può essere costoso, difficile da validare e rapidamente obsoleto.

=== Prospettiva concettuale e software

#table(
  columns: (1.1fr, 1.5fr, 1.5fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { rgb("#eaf2f8") },
  table.header([*Elemento*], [*Concettuale*], [*Software*]),
  [Classe], [Concetto significativo del dominio.], [Classe o modulo da implementare.],
  [Oggetto], [Entità concreta del mondo reale.], [Istanza a runtime.],
  [Operazione], [Responsabilità o azione del dominio.], [Servizio implementato da un metodo.],
  [Scopo], [Comprendere business e terminologia.], [Progettare e documentare il software.],
)

#yellow-box([Dichiarare sempre la prospettiva])[
  Lo stesso simbolo può avere significati diversi. Prima di leggere un diagramma bisogna sapere se rappresenta concetti del dominio oppure elementi implementativi.
]

#pagebreak(weak: true)
=== Modello di dominio

Un modello di dominio è un glossario visuale delle astrazioni rilevanti. Non rappresenta tutto il mondo reale: seleziona concetti, attributi e relazioni utili allo scopo, crea un vocabolario comune tra stakeholder e ispira successivamente nomi e strutture del design.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.8, 1.5), uml-box([Studente], width: 35mm))
    content((-3.8, -1.5), uml-box([Docente], width: 35mm))
    content((3.8, 0), uml-box([Corso], width: 35mm))
    line((-2.35, 1.5), (2.35, .25), mark: (end: ">"), stroke: .8pt + uml-blue)
    line((-2.35, -1.5), (2.35, -.25), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((0, 1.25), text(7pt)[frequenta])
    content((-2.05, 1.75), text(7pt, "0..*"))
    content((2.05, .7), text(7pt, "1..*"))
    content((0, -1.25), text(7pt)[insegna])
    content((-2.05, -1.75), text(7pt)[1])
    content((2.05, -.7), text(7pt, "0..*"))
  }),
  caption: [Modello concettuale del dominio universitario.],
)

== Notazione, meta-modello e viste

UML definisce sia una *notazione* sia un *meta-modello*. La notazione è la sintassi grafica — per esempio rettangoli, linee e molteplicità — mentre il meta-modello definisce i concetti del linguaggio, come Classe, Attributo, Operazione e Associazione.

Per uno sketch è spesso sufficiente conoscere bene la notazione; strumenti di modellazione, trasformazioni e profili richiedono invece maggiore attenzione alla semantica del meta-modello.

=== Viste e modello 4+1

Un sistema complesso viene descritto mediante più *viste*, ciascuna orientata alle esigenze di uno stakeholder. Un diagramma presenta una vista o una sua parte; un modello è l'insieme coordinato dei diagrammi.

#table(
  columns: (1fr, 1.2fr, 2fr),
  inset: 5pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { rgb("#eaf2f8") },
  table.header([*Vista*], [*Destinatario*], [*Domanda principale*]),
  [Logica], [Analista/progettista], [Quali funzionalità e astrazioni offre il sistema?],
  [Sviluppo], [Developer], [Come è organizzato il codice?],
  [Processi], [Integrator], [Come collaborano processi e thread?],
  [Fisica], [System engineer], [Dove sono distribuiti software e hardware?],
  [Scenari (+1)], [Stakeholder], [Come le viste realizzano casi d'uso significativi?],
)

Viste sovrapposte possono essere incoerenti; viste incomplete possono lasciare decisioni scoperte. Completezza e consistenza vanno bilanciate con la leggibilità.

== I diagrammi di UML 2.5

UML 2.5 comprende quattordici tipi di diagramma, divisi tra struttura e comportamento. I diagrammi di interazione sono un sottoinsieme di quelli comportamentali.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0, 3), process-box([Diagrammi UML 2.5], [14 tipi], width: 45mm))
    content((-3.8, 1.55), process-box([Strutturali], [7 diagrammi], width: 40mm, fill: uml-pale-green, stroke: uml-green))
    content((3.8, 1.55), process-box([Comportamentali], [7 diagrammi], width: 40mm, fill: uml-pale-amber, stroke: uml-amber))
    line((-.8, 2.65), (-3.1, 1.95), mark: (end: ">"), stroke: .8pt + uml-blue)
    line((.8, 2.65), (3.1, 1.95), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((-3.8, -.45), box(width: 47mm, inset: 6pt, radius: 3pt, fill: rgb("#f5faf7"), stroke: .6pt + uml-green, text(7pt)[Class\ Object\ Component\ Composite Structure\ Package\ Deployment\ Profile]))
    content((3.8, -.45), box(width: 47mm, inset: 6pt, radius: 3pt, fill: rgb("#fffbef"), stroke: .6pt + uml-amber, text(7pt)[Use Case\ Activity\ State Machine\ *Interazione:* Sequence, Communication,\ Interaction Overview, Timing]))
    line((-3.8, 1.15), (-3.8, .45), mark: (end: ">"), stroke: .8pt + uml-green)
    line((3.8, 1.15), (3.8, .45), mark: (end: ">"), stroke: .8pt + uml-amber)
  }),
  caption: [Famiglie dei quattordici diagrammi UML 2.5.],
)

=== Diagrammi principali nel corso

- *Use Case*: obiettivi funzionali osservati dagli attori.
- *Class e Object*: struttura statica e istanze concrete.
- *Sequence e Communication*: flusso dei messaggi tra oggetti.
- *Activity*: flussi di lavoro e algoritmi.
- *State Machine*: comportamento reattivo dipendente dallo stato.
- *Component e Deployment*: organizzazione software e distribuzione sull'hardware.

#green-box([Principio 80/20])[
  Non è necessario usare ogni diagramma. Un piccolo sottoinsieme ben compreso copre la maggior parte delle esigenze di comunicazione e design.
]

== UML nel processo di sviluppo

UML può accompagnare requisiti, architettura e design senza imporre un processo specifico.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0, 2), process-box([REQUISITI], [Use Case · Domain Model · Activity], width: 72mm))
    content((0, 0), process-box([ARCHITETTURA], [Component · Deployment], width: 72mm, fill: uml-pale-green, stroke: uml-green))
    content((0, -2), process-box([DESIGN], [Class · Object · Sequence · State Machine], width: 72mm, fill: uml-pale-amber, stroke: uml-amber))
    line((0, 1.55), (0, .45), mark: (end: ">"), stroke: .8pt + uml-blue)
    line((0, -.45), (0, -1.55), mark: (end: ">"), stroke: .8pt + uml-blue)
    content((1.25, 1), text(7pt, fill: uml-blue)[raffina])
    content((1.25, -1), text(7pt, fill: uml-blue)[dettaglia])
  }),
  caption: [Collocazione tipica dei principali diagrammi nel processo.],
)

I domain model chiariscono il vocabolario; i diagrammi dei componenti descrivono l'architettura; deployment collega nodi hardware e componenti software; class diagram e object diagram guidano il Low-Level Design; sequence e communication mostrano le collaborazioni; activity e state machine precisano algoritmi e comportamento dinamico.

== Profili, codice e uso pragmatico

=== Profili UML

Un profilo adatta UML a un dominio o a una tecnologia mediante:

- *stereotipi*, scritti come `«stereotype»` o rappresentati da icone;
- vincoli aggiuntivi sugli elementi ammessi;
- semantica specifica del dominio.

Profili possono descrivere applicazioni web, sistemi embedded, domini ferroviari o spaziali. Sono estensioni controllate, non nuovi linguaggi scollegati da UML.

=== UML e codice

Non esiste una corrispondenza universale e completa tra UML e ogni linguaggio di programmazione. Un diagramma è normalmente più astratto del codice: offre una buona approssimazione della struttura o del comportamento, ma non determina ogni dettaglio esecutivo.

=== Consigli pratici

1. Dichiarare uso e prospettiva: per esempio “sketch software”.
2. Ricordare che ogni informazione può essere soppressa: l'assenza non dimostra che qualcosa non esista.
3. Preferire un diagramma chiaro e leggermente convenzionale a uno formalmente perfetto ma illeggibile.
4. Usare soltanto il sottoinsieme di UML realmente compreso e utile.
5. Segnalare le convenzioni non normative.
6. Non esitare a usare diagrammi non UML quando comunicano meglio lo scopo.

#yellow-box([Regola fondamentale])[
  La completezza è nemica della chiarezza. Lo scopo primario del diagramma è far comprendere una decisione o una struttura; la conformità allo standard serve la comunicazione, non la sostituisce.
]

== Riepilogo

UML è una lingua franca visuale, non una metodologia. Può essere usato come sketch, blueprint o modello eseguibile e può assumere prospettiva concettuale o software. Un modello combina viste e diagrammi diversi; la loro scelta dipende dagli stakeholder, dalla fase del processo e dalla domanda a cui si vuole rispondere.
