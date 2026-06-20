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

= Design architetturale

Il *design* è il processo che trasforma un problema in una soluzione. I requisiti definiscono il *cosa*; il design sceglie il *come* e struttura la soluzione; l'implementazione rende quella struttura eseguibile e utilizzabile.

L'analogia edilizia è utile: le richieste dei proprietari corrispondono ai requisiti, il progetto dell'architetto al design e i lavori di costruzione all'implementazione.

#green-box([Due livelli di raffinamento])[
  L'*architectural design* o high-level design identifica architettura, sottosistemi e comunicazioni. Il *component design* o low-level design dettaglia componenti, dati, algoritmi e tecnologie, passando eventualmente da una soluzione indipendente dalla piattaforma a una specifica per .NET, Jakarta EE o altri ambienti.
]

=== Creatività e riuso

Il design non è un'attività puramente creativa. Gran parte dei problemi viene risolta adattando conoscenza esistente:

#table(
  columns: (1fr, 3fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { pale-blue },
  [*Clonazione*], [Riuso quasi completo di design o codice, con modifiche limitate.],
  [*Design pattern*], [Soluzione generale a un problema ricorrente, applicabile in domini diversi.],
  [*Stile architetturale*], [Organizzazione generica di componenti e connettori, spesso ottimizzata per una famiglia di sistemi.],
)

Buoni progetti precedenti, sistemi simili, modelli di riferimento, principi, convenzioni e pattern alimentano le decisioni del progettista. Studiare esempi riusciti migliora quindi la capacità di design.

== Architettura software e attributi di qualità

Il *design architetturale* identifica le macro-componenti — moduli, sottosistemi, servizi o classi — e il framework di controllo e comunicazione che le collega. Il risultato è una descrizione dell'architettura software. Mary Shaw e David Garlan hanno contribuito a formalizzare questo campo negli anni Novanta.

=== Perché esplicitare l'architettura

- guida lo sviluppo e permette di affrontare componenti più semplici di un monolite;
- documenta responsabilità e dipendenze;
- supporta decisioni tecniche e manageriali;
- consente di analizzare proprietà come efficienza e manutenibilità;
- favorisce riuso su larga scala ed evoluzione controllata.

=== Componenti e connettori

Un diagramma architetturale a blocchi mostra un overview: i blocchi rappresentano componenti, mentre i connettori rappresentano invocazioni, pipe, eventi, scambio di messaggi o accesso a dati condivisi. UML offre il diagramma delle componenti; esistono anche Architecture Description Languages come Darwin e altri ADL.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let node(pos, label, color) = content(pos, box(width: 30mm, height: 14mm, radius: 4pt, fill: color, stroke: .7pt + blue, align(center + horizon, text(8pt, weight: "bold", label))))
    node((0, 2.2), [Interfaccia], pale-blue)
    node((-3.2, 0), [Servizio A], pale-green)
    node((3.2, 0), [Servizio B], pale-green)
    node((0, -2.2), [Repository], pale-gold)
    line((0, 1.5), (-2.55, .45), mark: (end: ">"), stroke: .8pt + ink)
    line((0, 1.5), (2.55, .45), mark: (end: ">"), stroke: .8pt + ink)
    line((-2.55, -.45), (-.65, -1.75), mark: (end: ">"), stroke: .8pt + ink)
    line((2.55, -.45), (.65, -1.75), mark: (end: ">"), stroke: .8pt + ink)
    line((-1.7, 0), (1.7, 0), mark: (end: ">"), stroke: (paint: blue, thickness: .7pt, dash: "dashed"))
    content((0, .3), text(7pt, fill: blue)[messaggi])
  }),
  caption: [Componenti e connettori descrivono struttura e interazioni principali del sistema.],
)

=== Impatto sugli attributi di qualità

#table(
  columns: (1.1fr, 2.9fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { pale-blue },
  table.header([*Proprietà*], [*Strategia architetturale tipica*]),
  [Performance], [Ridurre comunicazioni e usare componenti large-grain.],
  [Security], [Adottare livelli e collocare le risorse critiche negli strati interni.],
  [Safety], [Concentrare le funzionalità safety-critical in pochi sottosistemi controllabili.],
  [Availability], [Aggiungere ridondanza, replica e meccanismi di fault tolerance.],
  [Maintainability], [Preferire componenti fine-grain, coesi e sostituibili.],
)

#red-box([Trade-off inevitabili])[
  Componenti grandi riducono le comunicazioni ma sono più difficili da sostituire; la ridondanza aumenta la disponibilità ma complica safety e consistenza; i livelli migliorano isolamento e security ma aggiungono attraversamenti e latenza. Non esiste un'architettura che massimizzi simultaneamente ogni qualità.
]

== Stili architetturali strutturali

Uno *stile architetturale* definisce tipi di componenti, tipi di connettori e vincoli di composizione. È un modello generico da istanziare e personalizzare. I grandi sistemi reali sono spesso eterogenei e combinano più stili.

Gli stili *strutturali* evidenziano soprattutto chi comunica con chi; quelli *di controllo* mostrano anche chi determina l'ordine dell'esecuzione.

=== Layered architecture

Il sistema è organizzato in strati. Ogni livello offre servizi a quello superiore e usa normalmente soltanto il livello immediatamente inferiore, nascondendo i propri dettagli implementativi.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let layers = (([Applicazioni], pale-blue), ([Application framework], rgb("#dcecf6")), ([Librerie e runtime], pale-green), ([Hardware abstraction], pale-gold), ([Kernel / infrastruttura], rgb("#f3e5e5")))
    for i in range(5) {
      let y = 3.2 - i * 1.05
      content((0, y), box(width: 105mm, height: 9mm, radius: 3pt, fill: layers.at(i).at(1), stroke: .6pt + blue, align(center + horizon, text(8pt, weight: "bold", layers.at(i).at(0)))))
      if i < 4 { line((0, y - .45), (0, y - .6), mark: (end: ">"), stroke: .6pt + ink) }
    }
  }),
  caption: [Architettura layered: ogni strato astrae i servizi dello strato sottostante. Android è un esempio noto di organizzazione multilivello.],
)

#table(
  columns: (1fr, 1fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  table.header([*Vantaggi*], [*Svantaggi*]),
  [Cambiamenti locali e sostituzione di implementazioni dietro un'interfaccia stabile.], [La separazione può essere artificiale e generare molti attraversamenti.],
  [Information hiding e riuso dei livelli.], [Gli shortcut tra livelli migliorano talvolta le prestazioni ma rompono l'isolamento.],
)

=== Repository

I sottosistemi condividono un deposito dati centrale e non comunicano direttamente. È adatto quando più strumenti producono e consumano grandi quantità di informazioni comuni, come nei CASE tool.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0, 0), box(width: 45mm, height: 22mm, radius: 4pt, fill: pale-gold, stroke: .8pt + gold, align(center + horizon, text(9pt, weight: "bold")[Repository condiviso])))
    let names = ([Editor], [Analyzer], [Generator], [Reporter])
    let poses = ((-4.2, 2.1), (4.2, 2.1), (-4.2, -2.1), (4.2, -2.1))
    for i in range(4) {
      content(poses.at(i), box(width: 28mm, height: 12mm, radius: 3pt, fill: pale-blue, stroke: .6pt + blue, align(center + horizon, text(7.5pt, weight: "bold", names.at(i)))))
      line(poses.at(i), (if poses.at(i).at(0) < 0 { -1.1 } else { 1.1 }, if poses.at(i).at(1) < 0 { -.55 } else { .55 }), mark: (end: ">"), stroke: .7pt + ink)
    }
  }),
  caption: [Nel repository model il deposito centrale media ogni condivisione dei dati.],
)

#table(
  columns: (1fr, 1fr), inset: 6pt, stroke: .4pt + rgb("#d5dadd"),
  table.header([*Vantaggi*], [*Svantaggi*]),
  [Condivisione efficiente e gestione centralizzata di backup e sicurezza.], [Schema comune rigido, evoluzione costosa e distribuzione difficile.],
)

=== Client-server

I server offrono servizi specifici, i client li richiedono attraverso una rete e il protocollo segue tipicamente lo schema request/response.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0, 0), box(width: 90mm, height: 8mm, radius: 3pt, fill: pale-blue, stroke: .7pt + blue, align(center + horizon, text(8pt, weight: "bold")[Rete])))
    for i in range(4) {
      let x = -4.2 + i * 2.8
      content((x, 1.5), box(width: 23mm, height: 10mm, radius: 3pt, fill: pale-green, stroke: .6pt + green, align(center + horizon, text(7pt, weight: "bold")[Client #str(i + 1)])))
      line((x, 1), (x, .4), mark: (end: ">"), stroke: .6pt + ink)
    }
    let servers = ((-3.5, [Catalogo]), (0, [Media]), (3.5, [Web / API]))
    for s in servers {
      content((s.at(0), -1.5), box(width: 27mm, height: 11mm, radius: 3pt, fill: pale-gold, stroke: .6pt + gold, align(center + horizon, text(7pt, weight: "bold", s.at(1)))))
      line((s.at(0), -.4), (s.at(0), -1), mark: (end: ">"), stroke: .6pt + ink)
    }
  }),
  caption: [Client e server sono ruoli distinti collegati dalla rete.],
)

#table(
  columns: (1fr, 1fr), inset: 6pt, stroke: .4pt + rgb("#d5dadd"),
  table.header([*Vantaggi*], [*Svantaggi*]),
  [Server riusabili, scalabilità e possibilità di spostare computazione.], [Modelli dati eterogenei, gestione duplicata e dipendenza da organizzazioni diverse.],
)

==== Two-tier e three-tier

#table(
  columns: (1fr, 1fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  table.header([*Two-tier*], [*Three-tier*]),
  [Presentation e business logic sono ripartite tra client e server. Un thin client mostra soltanto la UI; un fat client esegue anche elaborazione.], [Client per la presentation, application server per la business logic e DB server per la data logic.],
  [Più semplice, ma il client può diventare pesante e difficile da distribuire.], [Separa chiaramente presentazione, logica e dati e consente di scalarli indipendentemente.],
)

=== Peer-to-peer (P2P)

Ogni peer è contemporaneamente client e server: offre servizi e ne richiede ad altri. I ruoli non sono fissi e i nodi si distinguono soprattutto per i dati o le capacità possedute.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let ps = ((0, 2.5), (-3, 1), (3, 1), (-2.2, -2), (2.2, -2))
    let edges = ((0,1), (0,2), (0,3), (0,4), (1,2), (1,3), (2,4), (3,4))
    for e in edges { line(ps.at(e.at(0)), ps.at(e.at(1)), stroke: .6pt + rgb("#71808a")) }
    for i in range(5) {
      circle(ps.at(i), radius: .55, fill: if i == 0 { pale-gold } else { pale-blue }, stroke: .8pt + blue)
      content(ps.at(i), text(7.5pt, weight: "bold")[P#str(i + 1)])
    }
  }),
  caption: [In una rete P2P i nodi collaborano senza una distinzione permanente tra client e server.],
)

Replica e assenza di un singolo server favoriscono scalabilità e fault tolerance: aggiungere un peer può aggiungere dati e capacità. BitTorrent, eMule e reti blockchain sono esempi noti; coordinamento, consistenza e sicurezza restano però complessi.

=== Pipe and filter

I *filtri* trasformano flussi di input in output; le *pipe* trasportano i dati al filtro successivo.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let labels = ([Data source], [Filtro 1], [Filtro 2], [Filtro 3], [Data sink])
    for i in range(5) {
      let x = i * 2.65
      content((x, 0), box(width: 25mm, height: 13mm, radius: 3pt, fill: if i == 0 or i == 4 { pale-gold } else { pale-blue }, stroke: .7pt + blue, align(center + horizon, text(7.5pt, weight: "bold", labels.at(i)))))
      if i < 4 { line((x + 1.25, 0), (x + 1.4, 0), mark: (end: ">"), stroke: 1pt + green) }
    }
  }),
  caption: [Pipeline di trasformazioni indipendenti collegate da flussi dati.],
)

L'esempio UNIX `cat input.txt | grep "Italy" | sort > output.txt` compone sorgente, filtri e destinazione. I filtri possono lavorare in parallelo quando producono e consumano il flusso progressivamente.

#table(
  columns: (1fr, 1fr), inset: 6pt, stroke: .4pt + rgb("#d5dadd"),
  table.header([*Vantaggi*], [*Svantaggi*]),
  [Riuso, composizione intuitiva, facile aggiunta di trasformazioni e concorrenza.], [Poco adatto all'interazione; spesso batch; parsing e serializzazione possono costare.],
)

== Stili architetturali di controllo

Gli stili di controllo descrivono come viene determinato l'ordine dell'esecuzione. Nel controllo *centralizzato* un sottosistema avvia e coordina gli altri; nel controllo *event-based* i componenti reagiscono a eventi senza conoscere direttamente i destinatari.

=== Call-return

Il programma principale, o *driver*, chiama routine e sottoroutine secondo una gerarchia top-down. Il controllo passa alla routine chiamata e ritorna al chiamante al termine; un solo ramo è attivo alla volta, perciò il modello è adatto soprattutto a sistemi sequenziali.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let node(pos, label, color: pale-blue) = content(pos, box(width: 28mm, height: 11mm, radius: 3pt, fill: color, stroke: .6pt + blue, align(center + horizon, text(7.5pt, weight: "bold", label))))
    node((0, 2.5), [Main / Driver], color: pale-gold)
    node((-3.2, .8), [Routine 1])
    node((0, .8), [Routine 2])
    node((3.2, .8), [Routine 3])
    node((-4.2, -1), [Routine 1.1], color: pale-green)
    node((-1.8, -1), [Routine 1.2], color: pale-green)
    node((2.1, -1), [Routine 3.1], color: pale-green)
    node((4.5, -1), [Routine 3.2], color: pale-green)
    for p in ((-3.2,.8), (0,.8), (3.2,.8)) { line((0,1.95), p, mark: (end: ">"), stroke: .7pt + ink) }
    line((-3.2,.25), (-4.2,-.45), mark: (end: ">"), stroke: .6pt + ink)
    line((-3.2,.25), (-1.8,-.45), mark: (end: ">"), stroke: .6pt + ink)
    line((3.2,.25), (2.1,-.45), mark: (end: ">"), stroke: .6pt + ink)
    line((3.2,.25), (4.5,-.45), mark: (end: ">"), stroke: .6pt + ink)
  }),
  caption: [Call-return: il controllo discende dalla radice e ritorna lungo la gerarchia di chiamate.],
)

=== Manager model

Un manager centrale avvia, termina e coordina processi che possono operare in parallelo. Interroga continuamente sensori, interfaccia e risultati di computazione, quindi attiva processi di calcolo e attuatori.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0, 0), box(width: 36mm, height: 17mm, radius: 4pt, fill: pale-gold, stroke: .8pt + gold, align(center + horizon, text(9pt, weight: "bold")[Manager])))
    let items = (((-4,2), [Sensori]), ((0,2.5), [Interfaccia]), ((4,2), [Fault handler]), ((-4,-2), [Computazione]), ((0,-2.5), [Attuatori]), ((4,-2), [Output]))
    for item in items {
      content(item.at(0), box(width: 29mm, height: 12mm, radius: 3pt, fill: if item.at(0).at(1) > 0 { pale-blue } else { pale-green }, stroke: .6pt + blue, align(center + horizon, text(7.5pt, weight: "bold", item.at(1)))))
      line((0, if item.at(0).at(1) > 0 { .85 } else { -.85 }), item.at(0), mark: (end: ">"), stroke: .65pt + ink)
    }
  }),
  caption: [Il manager coordina processi concorrenti e dispositivi del mondo esterno.],
)

È particolarmente adatto a sistemi real-time di controllo e guida. Un *attuatore* traduce un segnale di controllo in un'azione fisica.

#pagebreak(weak: true)
=== Broadcast / publish-subscribe

Un componente pubblica un evento su un event bus; tutti i componenti sono in ascolto e quelli registrati reagiscono. Il produttore non invoca direttamente il consumatore: si parla di *implicit invocation*.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0,0), box(width: 110mm, height: 9mm, radius: 3pt, fill: pale-gold, stroke: .7pt + gold, align(center + horizon, text(8pt, weight: "bold")[Event bus])))
    let comps = ((-4.2,[Publisher]), (-1.4,[Subscriber A]), (1.4,[Subscriber B]), (4.2,[Subscriber C]))
    for i in range(4) {
      content((comps.at(i).at(0),1.55), box(width: 25mm, height: 11mm, radius: 3pt, fill: if i == 0 { pale-green } else { pale-blue }, stroke: .6pt + blue, align(center + horizon, text(7pt, weight: "bold", comps.at(i).at(1)))))
      line((comps.at(i).at(0),1), (comps.at(i).at(0),.45), mark: (end: if i == 0 { ">" } else { "<" }), stroke: .7pt + ink)
    }
    content((-4.2,-.7), text(7pt, fill: green)[pubblica e1])
    content((1.4,-.7), text(7pt, fill: blue)[gestiscono e1])
  }),
  caption: [Nel publish-subscribe produttori e consumatori sono disaccoppiati dall'event bus.],
)

#table(
  columns: (1fr, 1fr), inset: 6pt, stroke: .4pt + rgb("#d5dadd"),
  table.header([*Vantaggi*], [*Svantaggi*]),
  [Componenti sostituibili, estendibili e riusabili con dipendenze ridotte.], [Gestione non deterministica, scambio dati complesso, performance e test più difficili.],
)

==== Decisioni progettuali negli eventi

Il disaccoppiamento non elimina la necessità di un contratto: produttori e consumatori devono condividere nome, significato e struttura dell'evento. Occorre inoltre decidere come gestire duplicati, perdita e ordine dei messaggi.

#table(
  columns: (1.1fr, 2.9fr),
  inset: (x: 6pt, y: 4pt),
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { pale-blue },
  [*Payload*], [I dati possono viaggiare con l'evento oppure essere recuperati da un repository mediante un identificatore.],
  [*Consegna*], [Il bus può garantire consegna al massimo una volta o almeno una volta; nel secondo caso i consumatori devono tollerare duplicati.],
  [*Ordinamento*], [Eventi concorrenti possono arrivare in ordine diverso da quello di pubblicazione.],
  [*Idempotenza*], [Elaborare più volte lo stesso evento non dovrebbe produrre effetti ulteriori indesiderati.],
  [*Osservabilità*], [Log, correlation ID e tracing aiutano a ricostruire flussi che attraversano componenti disaccoppiati.],
)

#blue-box([Esempio])[
  L'evento `OrdineConfermato` può attivare indipendentemente fatturazione, aggiornamento inventario e spedizione. Il servizio che conferma l'ordine non deve conoscere né invocare direttamente questi consumatori.
]

== Architetture eterogenee

I sistemi reali raramente seguono uno stile puro. Gli stili possono essere combinati gerarchicamente — una componente interna adotta uno stile diverso da quello globale — oppure all'interno della stessa componente.

=== Esempio: compilatore

Un compilatore combina una pipeline di trasformazioni con un repository condiviso. Lexer, parser, analisi semantica, ottimizzazione e generazione del codice formano un pipe-and-filter; la symbol table è consultata da più fasi come repository.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let labels = ([Lexer], [Parser], [Semantica], [Ottimizza], [Genera codice])
    for i in range(5) {
      let x = i * 2.45
      content((x,0), box(width: 23mm, height: 12mm, radius: 3pt, fill: pale-blue, stroke: .6pt + blue, align(center + horizon, text(7pt, weight: "bold", labels.at(i)))))
      if i < 4 { line((x+1.15,0), (x+1.3,0), mark:(end:">"), stroke:.8pt+green) }
      line((x,.6), (4.9,2), mark:(end:">"), stroke:(paint: gold, thickness:.5pt, dash:"dashed"))
    }
    content((4.9,2.4), box(width: 38mm, height: 12mm, radius:3pt, fill:pale-gold, stroke:.7pt+gold, align(center+horizon, text(8pt, weight:"bold")[Symbol table])))
  }),
  caption: [Architettura ibrida di un compilatore: pipeline di fasi e repository condiviso.],
)

#yellow-box([Criterio di scelta])[
  Lo stile è uno strumento di ragionamento, non un vincolo ideologico. Componenti diverse possono richiedere organizzazioni diverse in funzione di dati, controllo e attributi di qualità.
]

== Microservices

I microservizi evolvono le architetture service-oriented e contrastano il monolite, nel quale UI, business logic e accesso ai dati vengono distribuiti come un'unica applicazione.

=== Proprietà

- ogni servizio è indipendente e responsabile di una capacità di business coesa;
- servizi diversi possono usare tecnologie diverse;
- comunicano tramite API di rete, spesso HTTP/REST o messaggistica;
- possono essere distribuiti, scalati e aggiornati autonomamente.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let node(pos,label,color,w:30mm)=content(pos,box(width:w,height:13mm,radius:4pt,fill:color,stroke:.7pt+blue,align(center+horizon,text(7.5pt,weight:"bold",label))))
    node((-4.5,1.7),[Web client],pale-blue)
    node((-4.5,-.2),[Mobile client],pale-blue)
    node((-1, .75),[API Gateway],pale-gold,w:34mm)
    node((3,2.2),[Account service],pale-green,w:34mm)
    node((3,.75),[Inventory service],pale-green,w:34mm)
    node((3,-.7),[Shipping service],pale-green,w:34mm)
    node((6.3,2.2),[Account DB],rgb("#f3edf8"),w:28mm)
    node((6.3,.75),[Inventory DB],rgb("#f3edf8"),w:28mm)
    node((6.3,-.7),[Shipping DB],rgb("#f3edf8"),w:28mm)
    line((-3,1.7),(-2.7,1),mark:(end:">"),stroke:.7pt+ink)
    line((-3,-.2),(-2.7,.5),mark:(end:">"),stroke:.7pt+ink)
    for y in (2.2,.75,-.7) { line((.7,.75),(1.3,y),mark:(end:">"),stroke:.7pt+ink) }
    line((4.7,2.2),(4.9,2.2),mark:(end:">"),stroke:.7pt+ink)
    line((4.7,.75),(4.9,.75),mark:(end:">"),stroke:.7pt+ink)
    line((4.7,-.7),(4.9,-.7),mark:(end:">"),stroke:.7pt+ink)
  }),
  caption: [Il gateway espone un'interfaccia unificata e instrada le richieste verso servizi indipendenti.],
)

=== API Gateway e REST

L'API Gateway offre ai client un endpoint unico, chiama i servizi necessari e aggrega le risposte. Riduce la conoscenza dell'architettura interna da parte dei client, ma può diventare un collo di bottiglia o un punto critico.

REST usa le operazioni HTTP per manipolare risorse:

#table(
  columns:(1fr,1fr), inset:5pt, stroke:.4pt+rgb("#d5dadd"), fill:(x,y)=>if y==0{pale-blue},
  table.header([*CRUD*],[*Metodo HTTP*]),
  [Create],[`POST`], [Read],[`GET`], [Update],[`PUT` / `PATCH`], [Delete],[`DELETE`],
)

#table(
  columns:(1fr,1fr), inset:6pt, stroke:.4pt+rgb("#d5dadd"),
  table.header([*Vantaggi*],[*Svantaggi*]),
  [Scalabilità selettiva, deployment indipendente, fault isolation e libertà tecnologica.], [Complessità distribuita, latenza di rete, test end-to-end e osservabilità difficili.],
  [Team autonomi e servizi focalizzati su capacità specifiche.], [Richiede infrastrutture per orchestrazione, monitoring, discovery e gestione dei dati distribuiti.],
)

Docker e Kubernetes sono spesso usati per packaging e orchestrazione, ma non definiscono da soli un'architettura a microservizi.

== Riepilogo e scelta dello stile

#table(
  columns:(1.2fr,2.8fr), inset:(x:6pt,y:4pt), stroke:.4pt+rgb("#d5dadd"), fill:(x,y)=>if calc.rem(y,2)==0{rgb("#f6f9fb")},
  [*Layered*],[Separazione e information hiding tra livelli.],
  [*Repository*],[Condivisione attraverso un modello dati centrale.],
  [*Client-server*],[Ruoli stabili di fornitore e consumatore di servizi.],
  [*P2P*],[Peer simmetrici che offrono e richiedono servizi.],
  [*Pipe and filter*],[Trasformazioni indipendenti connesse da flussi.],
  [*Call-return*],[Controllo gerarchico e sequenziale.],
  [*Manager*],[Coordinamento centralizzato di processi concorrenti.],
  [*Broadcast*],[Reazione disaccoppiata a eventi pubblicati.],
  [*Microservices*],[Servizi distribuibili in modo indipendente attorno a capacità di business.],
)

#green-box([Sintesi])[
  Requisiti → design architetturale → architettura software → possibile conformità a uno o più stili. La scelta deve partire dagli attributi di qualità e dai trade-off, non dalla popolarità di una tecnologia.
]

Il high-level design definisce la struttura globale; il low-level design dettaglia i componenti. Poiché progettare significa soprattutto selezionare, combinare e adattare soluzioni note, i sistemi reali risultano quasi sempre un mix ragionato di stili.
