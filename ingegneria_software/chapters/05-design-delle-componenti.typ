#import "../boxes.typ": *
#import "@preview/cetz:0.5.1"
#import "../uml.typ": *

#let blue = rgb("#245b88")
#let green = rgb("#327a50")
#let red = rgb("#a12a2a")
#let gold = rgb("#b67d0c")
#let ink = rgb("#23262b")
#let pale-blue = rgb("#eaf2f8")
#let pale-green = rgb("#edf7f1")
#let pale-gold = rgb("#fff6dc")

= Design delle componenti (Low-Level Design)

Il Low-Level Design raffina l'architettura fino a descrivere componenti implementabili: classi, interfacce, attributi, operazioni, strutture dati e algoritmi. Se il High-Level Design stabilisce *quali sottosistemi* esistono e come comunicano, il Low-Level Design precisa *come è costruito ciascun sottosistema*.

=== Fasi del processo di design

Il processo non è rigidamente sequenziale: le attività si sovrappongono e possono consultare direttamente i requisiti. Ogni passaggio produce però un artefatto più preciso.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let names = ([Requisiti], [Design architetturale], [Specifica astratta], [Design interfacce], [Design componenti], [Strutture dati], [Algoritmi])
    let outputs = ([Specifica requisiti], [Architettura SW], [Specifica software], [Specifica interfacce], [Specifica componenti], [Specifica dati], [Specifica algoritmi])
    for i in range(7) {
      let y = 5.8 - i * 1.15
      content((0,y), box(width:43mm,height:9mm,radius:3pt,fill:if i==0{pale-gold}else{pale-blue},stroke:.6pt+blue,align(center+horizon,text(7.3pt,weight:"bold",names.at(i)))))
      content((5.2,y), box(width:39mm,height:9mm,radius:3pt,fill:pale-green,stroke:.6pt+green,align(center+horizon,text(7pt,outputs.at(i)))))
      line((2.15,y),(3.25,y),mark:(end:">"),stroke:.6pt+green)
      if i < 6 { line((0, y - .45), (0, y - .7), mark: (end: ">"), stroke: .7pt + ink) }
    }
  }),
  caption: [Raffinamento dalle esigenze agli algoritmi e relativi artefatti di design.],
)

#table(
  columns:(1.2fr,2.8fr), inset:(x:6pt,y:4pt), stroke:.4pt+rgb("#d5dadd"), fill:(x,y)=>if x==0{pale-blue},
  [*Architettura*],[Componenti, sottosistemi e connettori.],
  [*Specifica astratta*],[Responsabilità di alto livello dei componenti.],
  [*Interfacce*],[Servizi esposti, operazioni e dati scambiati.],
  [*Componenti*],[Classi, attributi, metodi e collaborazioni interne.],
  [*Strutture dati*],[Rappresentazioni adatte ai dati del problema.],
  [*Algoritmi*],[Procedimenti che implementano le operazioni.],
)

Nel Weather Service, per esempio, l'architettura individua `WeatherService`, `LocalInformation`, `SocialNetwork` e `Subscriber`; il design delle interfacce definisce operazioni come `GetHistoricalTemperature`; il component/data design introduce attributi tipizzati; l'algorithm design seleziona ordinamenti e collezioni adeguate.

== Design by Contract

Il *Design by Contract* (Bertrand Meyer, Eiffel, 1988) specifica l'interfaccia di una componente prima della codifica mediante un accordo preciso tra chi offre un servizio e chi lo usa. L'obiettivo è rendere espliciti obblighi, garanzie e responsabilità.

#green-box([Metafora del contratto])[
  Il *cliente* o caller deve rispettare le condizioni richieste dal servizio. Il *fornitore* o supplier garantisce il risultato soltanto quando tali condizioni sono soddisfatte.
]

=== Precondizione, postcondizione e invariante

#table(
  columns:(1.1fr,2.9fr), inset:6pt, stroke:.4pt+rgb("#d5dadd"), fill:(x,y)=>if x==0{pale-blue},
  [*Precondizione*],[Proprietà booleana che deve valere prima dell'operazione; è responsabilità del chiamante.],
  [*Postcondizione*],[Proprietà garantita dopo l'operazione se la precondizione era valida.],
  [*Invariante*],[Proprietà che ogni oggetto deve rispettare negli stati osservabili, prima e dopo ogni operazione pubblica.],
)

Per una radice quadrata intera:

#block(width:100%,inset:8pt,radius:4pt,fill:rgb("#f7f9fa"),stroke:.5pt+rgb("#cbd4da"))[
  `sqrt(x)`  
  *pre:* $x >= 0$  
  *post:* $x = "result" times "result"$
]

Durante l'esecuzione interna di un metodo l'invariante può essere temporaneamente violato, ma deve essere ripristinato prima che il controllo torni al cliente.

=== Esempio: conto corrente

Per `withdraw(value)`:

#block(width:100%,inset:8pt,radius:4pt,fill:rgb("#f7f9fa"),stroke:.5pt+rgb("#cbd4da"))[
  *Precondition*  
  `value >= 0`  
  `value <= balance`

  *Postcondition*  
  `balance = balance@pre - value`

  *Class invariant*  
  `balance >= 0`  
  `balance = sum(deposits) - sum(withdrawals)`
]

`balance@pre` indica il saldo prima della chiamata. Il contratto garantisce che il prelievo modifichi esattamente il saldo e che l'oggetto resti coerente.

#figure(
  [```pintora
classDiagram
  class Account {
    -Euro balance
    -List deposits
    -List withdrawals
    +deposit(value)
    +withdraw(value)
    +mayWithdraw(value)
    +getBalance()
  }
  class WithdrawContract {
    pre_0_le_value_le_balance
    post_balance_eq_balancePre_minus_value
  }
  Account ..> WithdrawContract : specifica
```],
  caption: [Classe `Account` e contratto dell'operazione `withdraw`.],
)

=== Responsabilità del cliente e del fornitore

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((-3.6,0),box(width:38mm,height:22mm,radius:4pt,fill:pale-blue,stroke:.7pt+blue,align(center+horizon,stack(dir:ttb,spacing:2pt,text(9pt,weight:"bold")[Cliente],text(7pt)[garantisce pre + inv]))))
    content((3.6,0),box(width:38mm,height:22mm,radius:4pt,fill:pale-green,stroke:.7pt+green,align(center+horizon,stack(dir:ttb,spacing:2pt,text(9pt,weight:"bold")[Fornitore],text(7pt)[garantisce post + inv]))))
    line((-1.7,.35),(1.7,.35),mark:(end:">"),stroke:1pt+blue)
    line((1.7,-.35),(-1.7,-.35),mark:(end:">"),stroke:1pt+green)
    content((0,.7),text(7pt,fill:blue)[richiesta valida])
    content((0,-.7),text(7pt,fill:green)[risultato garantito])
  }),
  caption: [Il contratto distribuisce esplicitamente obblighi e garanzie.],
)

#table(
  columns:(1fr,1fr),inset:6pt,stroke:.4pt+rgb("#d5dadd"),
  table.header([*Violazione*],[*Responsabile*]),
  [Precondizione non valida],[Cliente/chiamante],
  [Postcondizione o invariante non validi, con pre valida],[Fornitore/implementazione],
)

Senza questa attribuzione si rischiano troppo pochi controlli — ciascuno li delega all'altro — oppure controlli duplicati e incoerenti tipici di un defensive programming indiscriminato.

=== Vantaggi

- guida codifica e design delle operazioni;
- documenta il comportamento meglio di commenti informali;
- genera test black-box dalle pre/postcondizioni;
- localizza più rapidamente la responsabilità di un failure;
- favorisce operazioni semplici con responsabilità circoscritte.

Eiffel integra nativamente i contratti; altri ecosistemi offrono `assert` o librerie come JML, `icontract`, `deal` e Code Contracts.

== Progettazione degli algoritmi

Il design degli algoritmi è la parte più vicina alla codifica. Si parte dalla descrizione della classe target, si riusa quando possibile un algoritmo noto e si progetta una soluzione nuova soltanto quando necessario.

Il percorso tipico è: selezione della notazione, raffinamento progressivo e — nei sistemi critici — prova formale della correttezza, per esempio mediante triple di Hoare.

=== Notazioni e PDL

Le notazioni visuali includono activity diagram, flowchart, box diagram, structured chart e decision table. Le notazioni testuali includono PDL e pseudocodice.

Il *Program Design Language* combina il vocabolario del linguaggio naturale con strutture di controllo simili a un linguaggio di programmazione. La narrativa consente di mantenere inizialmente un alto livello di astrazione.

#block(width:100%,inset:9pt,radius:4pt,fill:rgb("#f7f9fa"),stroke:.5pt+rgb("#cbd4da"))[
```text
SORT(TABLE, SIZE)
  IF SIZE > 1
    DO UNTIL NO ITEMS WERE INTERCHANGED
      FOR EACH ADJACENT PAIR IN TABLE
        IF FIRST ITEM > SECOND ITEM
          INTERCHANGE THE TWO ITEMS
```
]

=== Stepwise refinement

Lo stepwise refinement sostituisce progressivamente descrizioni narrative con istruzioni precise fino a ottenere una soluzione direttamente traducibile in codice.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let labels=([Problema narrativo],[Operazioni nominate],[Pseudocodice],[Codice implementabile])
    for i in range(4){
      let x=i*3.2
      content((x,0),box(width:31mm,height:15mm,radius:4pt,fill:if i==3{pale-green}else{pale-blue},stroke:.7pt+blue,align(center+horizon,text(7.5pt,weight:"bold",labels.at(i)))))
      if i < 3 { line((x+1.55,0),(x+1.65,0),mark:(end:">"),stroke:.8pt+ink) }
    }
  }),
  caption: [Ogni raffinamento riduce l'astrazione e aggiunge decisioni verificabili.],
)

Esempio: per calcolare la differenza tra massimo e minimo di tre interi si passa da “acquisisci A, B, C e calcola massimo e minimo” a chiamate `CALCOLA_MASSIMO`/`CALCOLA_MINIMO`, quindi si raffina ciascuna operazione con confronti e assegnamenti espliciti.

#yellow-box([Quando fermarsi])[
  Il raffinamento termina quando ogni passo è sufficientemente preciso da essere tradotto senza introdurre nuove decisioni sostanziali durante la codifica.
]

== Principi di progettazione

I principi di design orientano verso software manutenibile, comprensibile, testabile, riusabile, riparabile e portabile. Sono indipendenti dal paradigma OO.

Un *modulo* è qualsiasi entità software nominata che contiene e offre servizi: funzione, script, classe, package, programma o sottosistema. Un modulo può includerne o usarne altri, creando dipendenze.

=== Astrazione

L'astrazione consente di concentrarsi sulle proprietà rilevanti a un livello, ignorando temporaneamente i dettagli. Riduce la complessità e rende possibile descrivere il comportamento senza fissarne subito l'implementazione.

#table(
  columns:(1fr,2fr,1.4fr),inset:5pt,stroke:.4pt+rgb("#d5dadd"),fill:(x,y)=>if y==0{pale-blue},
  table.header([*Forma*],[*Che cosa astrae*],[*Esempio*]),
  [Funzionale],[Algoritmo che realizza un servizio.],[`sort(list)`],
  [Dati],[Struttura concreta dietro operazioni pubbliche.],[Stack: `push`/`pop`],
  [Controllo],[Meccanismo interno di coordinamento.],[Semaforo],
)

Nel Selection Sort si può passare da “ordina L” alla ricerca iterativa del minimo e infine ai cicli e scambi completi. Ogni livello risponde a domande diverse senza invalidare quelli più astratti.

=== Decomposizione

Risolvere sottoproblemi separati richiede in genere meno effort che affrontare l'intera complessità in una volta. Tuttavia, aumentando i moduli cresce anche il costo d'integrazione.

#figure(
  cetz.canvas({
    import cetz.draw: *
    line((0,0),(8,0),mark:(end:">"),stroke:.8pt+ink)
    line((0,0),(0,4.8),mark:(end:">"),stroke:.8pt+ink)
    hobby((.5,4.1),(2.5,2),(4,1),(5.5,2),(7.5,4.2),stroke:1.2pt+blue)
    line((4,0),(4,1),stroke:(paint:red,thickness:.7pt,dash:"dashed"))
    content((4,.65),text(8pt,weight:"bold",fill:red)[M])
    content((4,4.6),text(7.5pt,weight:"bold")[costo totale])
    content((4,-.45),text(7.5pt)[numero di moduli])
  }),
  caption: [Esiste un numero di moduli M che bilancia complessità interna e costo d'integrazione.],
)

Troppo pochi moduli concentrano la complessità; troppi moltiplicano interfacce, coordinamento e test d'integrazione. La decomposizione va quindi ottimizzata, non massimizzata.

=== Modularità e Separation of Concerns

La modularità aggiunge un criterio qualitativo alla decomposizione: ogni modulo dovrebbe occuparsi di un concern coerente e avere una sola ragione significativa per cambiare.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let labels=([Sistema di calcolo],[Dati da visualizzare],[Presentazione],[Display])
    for i in range(4) {
      let x = i * 3.2
      content((x,0),box(width:30mm,height:14mm,radius:4pt,fill:if i == 2 { pale-gold } else { pale-blue },stroke:.7pt+blue,align(center+horizon,text(7.2pt,weight:"bold",labels.at(i)))))
      if i < 3 { line((x+1.5,0),(x+1.7,0),mark:(end:">"),stroke:.8pt+ink) }
    }
  }),
  caption: [Separare calcolo e presentazione permette di sostituire la UI senza modificare la logica.],
)

La stessa idea porta ai livelli presentation, business e data logic e a pattern come MVC.

#blue-box([Criteri fondamentali])[
  Una buona modularizzazione *massimizza la coesione* interna e *minimizza l'accoppiamento* tra moduli. Moduli coesi e poco accoppiati sono più facili da comprendere, testare, modificare e riusare.
]

=== Information hiding

Ogni modulo espone l'interfaccia — ciò che offre — e nasconde le decisioni interne — come lo realizza. Finché il contratto pubblico rimane stabile, l'implementazione può cambiare senza effetti a cascata.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0,0),box(width:62mm,height:30mm,radius:5pt,fill:pale-blue,stroke:.8pt+blue,align(center+horizon,stack(dir:ttb,spacing:3pt,text(9pt,weight:"bold")[Interfaccia pubblica],box(width:44mm,inset:5pt,radius:3pt,fill:ink,align(center,text(8pt,fill:white)[Implementazione privata]))))))
    content((-4.3,0),text(8pt,weight:"bold")[Cliente])
    line((-3.2,0),(-1.6,0),mark:(end:">"),stroke:.9pt+green)
    content((4.4,0),text(7.5pt,fill:blue)[modificabile senza impatto])
  }),
  caption: [Il cliente dipende dall'interfaccia stabile, non dalle decisioni nascoste.],
)

In Java e C++ l'information hiding è supportato da `private`, `protected` e `public` e dall'incapsulamento. Il beneficio generale è la riduzione dell'accoppiamento, non il semplice uso di modificatori sintattici.

== Riepilogo

#table(
  columns:(1.2fr,2.8fr),inset:(x:6pt,y:4pt),stroke:.4pt+rgb("#d5dadd"),fill:(x,y)=>if calc.rem(y,2)==0{rgb("#f6f9fb")},
  [*Design by Contract*],[Precondizioni, postcondizioni e invarianti assegnano responsabilità a cliente e fornitore.],
  [*Algorithm design*],[PDL e stepwise refinement portano dalla narrativa al codice.],
  [*Astrazione*],[Mostra ciò che conta al livello corrente.],
  [*Decomposizione*],[Divide il problema bilanciando complessità e integrazione.],
  [*Modularità*],[Massimizza coesione e minimizza accoppiamento.],
  [*Information hiding*],[Protegge le decisioni interne dietro interfacce stabili.],
)

#green-box([Dal problema al codice])[
  Requisiti → High-Level Design (architettura e connettori) → Low-Level Design (classi, contratti, dati e algoritmi) → implementazione. Ogni raffinamento aggiunge precisione senza perdere la tracciabilità verso il problema originario.
]
