#import "../boxes.typ": *

= Class diagram e Object diagram UML

Il *Class Diagram* descrive la struttura statica di ciò che si sta modellando: classi, feature e relazioni. Le feature comprendono attributi e operazioni; le relazioni principali sono associazione, aggregazione, composizione, generalizzazione e dipendenza.

#yellow-box([La prospettiva cambia il significato])[
  In prospettiva concettuale una classe rappresenta un concetto del dominio e un'operazione una responsabilità. In prospettiva software la classe è un modulo implementabile e l'operazione è realizzata da uno o più metodi.
]

== Classi, attributi e operazioni

Una classe incapsula caratteristiche comuni a un insieme di oggetti. Gli attributi determinano lo stato; le operazioni descrivono il comportamento disponibile. Oggetti collegati collaborano scambiando messaggi, cioè invocando operazioni.

=== Notazione della classe

La rappresentazione completa usa tre comparti: nome, attributi e operazioni. I comparti non necessari possono essere soppressi per mantenere il diagramma leggibile.

#figure(
  [```pintora
classDiagram
  class ContoBancario {
    -Euro saldo
    -String titolare
    {static} int numeroConti
    +deposita(Euro)
    +preleva(Euro)
    +saldoAllaData(Data)
    {static} +create(Euro)
  }
```],
  caption: [Classe UML con i comparti di nome, attributi e operazioni.],
)

=== Attributi

La sintassi generale è:

`visibilità nome: tipo [molteplicità] = default {proprietà}`

#table(
  columns: (.7fr, 1fr, 2.3fr),
  inset: 5pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { rgb("#eaf2f8") },
  table.header([*Simbolo*], [*Visibilità*], [*Accesso*]),
  [`+`], [public], [Tutte le classi.],
  [`-`], [private], [Soltanto la classe proprietaria.],
  [`#`], [protected], [Classe e sottoclassi.],
  [`~`], [package], [Classi dello stesso package.],
)

Solo il nome è obbligatorio. Il tipo può essere primitivo, datatype o classe del modello. Default indica il valore iniziale; proprietà come `{readOnly}`, `{ordered}`, `{static}` o `{abstract}` aggiungono semantica.

Le regole di visibilità dei linguaggi non coincidono sempre con UML: in un design software conviene adottare convenzioni compatibili con il linguaggio target e spesso limitarsi a `+` e `-`.

=== Molteplicità

- `1`: esattamente uno, valore predefinito;
- `0..1`: opzionale;
- `*` o `0..*`: qualsiasi quantità, anche zero;
- `1..*`: almeno uno;
- `n..m`: intervallo limitato.

Un attributo multivalore è concettualmente un insieme; `{ordered}` specifica che l'ordine è significativo. Per valori con comportamento o semantica propri è spesso preferibile introdurre un datatype, per esempio `CifraTelefono`, invece di usare una stringa generica.

=== Operazioni

La sintassi è:

`visibilità nome(direzione parametro: tipo = default): tipoRitornato {proprietà}`

La direzione è `in`, `out` o `inout`; `in` è predefinita. Le operazioni *query* osservano senza side effect, mentre i modificatori cambiano lo stato. Getter e setter ovvi possono essere omessi.

Un'operazione è la dichiarazione astratta del servizio; il *metodo* è il corpo che la implementa. Una stessa operazione astratta può avere metodi differenti nelle sottoclassi.

=== Datatype, costruttori e membri statici

Un oggetto possiede identità: due persone con gli stessi dati possono essere entità diverse. Un datatype rappresenta invece valori: due istanze di `Euro` con valore 10 sono equivalenti. In UML si usa lo stereotipo `«datatype»`.

Attributi e operazioni statici appartengono alla classe e sono tradizionalmente sottolineati. I costruttori possono essere indicati come `create`, `make` o col nome della classe, secondo la convenzione adottata.

#figure(
  image("../fotodaaggiungere/aggiungiquestoesempioapagina58.png", width: 96%),
  caption: [Esempio di datatype e stereotipi UML.],
)

== Associazioni e molteplicità

Un'associazione rappresenta una relazione fisica o concettuale tra classi. Può avere nome, ruoli agli estremi, molteplicità e verso di navigazione.

#figure(
  [```pintora
classDiagram
  class Persona { -String nome }
  class Automobile { -String targa }
  class Dipartimento
  class Sede
  Persona "1" --> "1..*" Automobile : possiede
  Dipartimento "1..*" --> "1..*" Sede : situato in
```],
  caption: [Associazioni orientate con nomi e molteplicità.],
)

La freccia di navigabilità indica che, noto un oggetto all'origine, è possibile reperire quelli alla destinazione. Non coincide necessariamente con la direzione in cui si legge il nome dell'associazione.

#red-box([Attenzione alle molteplicità])[
  La molteplicità scritta accanto a una classe indica quanti oggetti di quella classe possono essere collegati a una singola istanza dell'altra estremità. Non va letta “dal proprio lato”.
]

=== Attributo o associazione?

La stessa informazione può talvolta essere espressa in entrambi i modi. Convenzionalmente si usano attributi per primitivi e datatype (`String`, `Date`, `boolean`) e associazioni quando il tipo è una classe con identità propria.

=== Associazioni riflessive

Una classe può essere associata a se stessa. Per esempio una cartella contiene altre cartelle o una persona svolge il ruolo di genitore rispetto ad altre persone. I nomi di ruolo sono essenziali per distinguere le estremità.

=== Associazioni bidirezionali

Una relazione navigabile in entrambe le direzioni richiede che entrambe le estremità siano mantenute coerenti. In una relazione `Man`–`Woman`, impostare `husband` deve aggiornare anche `wife`; un solo attributo non basta.

#yellow-box([Costo della libertà del modello])[
  Un design astratto e bidirezionale può sembrare semplice nel diagramma, ma trasferisce complessità alla codifica: sincronizzazione, collezioni inverse e vincoli devono essere implementati esplicitamente.
]

== Object diagram e classi associative

=== Object diagram

Il Class Diagram descrive tutte le configurazioni valide; l'Object Diagram mostra una configurazione concreta in un istante. Un oggetto è scritto `nome : Classe`, tradizionalmente sottolineato, e un link è un'istanza di un'associazione.

#figure(
  [```pintora
classDiagram
  class mario_Persona { String nome_Mario_Rossi }
  class a1_Automobile { String targa_AB123CD }
  class a2_Automobile { String targa_EF456GH }
  mario_Persona -- a1_Automobile : possiede
  mario_Persona -- a2_Automobile : possiede
```],
  caption: [Snapshot di oggetti e link coerente col precedente Class Diagram.],
)

Gli Object Diagram sono utili per spiegare class diagram complessi, verificare le molteplicità con esempi e discutere casi limite.

=== Classe associativa

Quando data, voto, quantità o altre proprietà appartengono alla relazione e non alle classi coinvolte, si usa una *association class*. In implementazione è spesso più chiaro trasformarla in una normale classe collegata alle due estremità.

#figure(
  [```pintora
classDiagram
  class Studente { -String matricola }
  class Esame { -String codice }
  class IscrizioneEsame {
    Data data
    int voto
    boolean lode
  }
  Studente "1" --> "0..*" IscrizioneEsame
  Esame "1" --> "0..*" IscrizioneEsame
```],
  caption: [Le proprietà dell'associazione sono modellate come classe implementabile.],
)

== Relazioni tutto-parte e generalizzazione

=== Aggregazione e composizione

L'aggregazione rappresenta una relazione tutto-parte debole. La composizione è la forma forte: la parte non esiste senza il tutto e può appartenere a un solo composto alla volta.

#figure(
  [```pintora
classDiagram
  Nazione "1" o-- "1..*" Regione : aggregazione
  Ordine "1" *-- "1..*" RigaOrdine : composizione
```],
  caption: [Diamante vuoto per aggregazione e pieno per composizione.],
)

La distinzione dell'aggregazione è spesso ambigua e a livello software si implementa come un'associazione. Conviene usarla soprattutto quando il significato concettuale tutto-parte è davvero informativo.

#figure(
  image("../fotodaaggiungere/aggiungiloallafinedipagina61.png", width: 82%),
  caption: [Esempi e note su aggregazione e composizione.],
)

=== Generalizzazione ed ereditarietà

La generalizzazione esprime una relazione concettuale “è un”: ogni istanza della sottoclasse è anche istanza della superclasse. L'ereditarietà è il meccanismo implementativo con cui la sottoclasse incorpora e specializza struttura e comportamento.

#figure(
  image("../fotodaaggiungere/aggiungipagina61.png", width: 90%),
  caption: [Esempio di generalizzazione tra classi.],
)

#figure(
  [```pintora
classDiagram
  class Persona {
    Data dataNascita
    +stampa()
  }
  class Studente {
    String matricola
    +mediaVoti()
    +stampa()
  }
  class Docente {
    String settore
    +stampa()
  }
  Persona <|-- Studente
  Persona <|-- Docente
```],
  caption: [Le sottoclassi ereditano feature e possono aggiungerle o ridefinirle.],
)

Un oggetto `Studente` può essere trattato come `Persona`; la sottoclasse aggiunge `matricola` e `mediaVoti()` e può ridefinire `stampa()` mediante overriding. Operazione e metodo non coincidono: l'operazione è il contratto invocabile, il metodo una sua implementazione concreta.

#figure(
  image("../fotodaaggiungere/aggiungipaginaa61.png", width: 90%),
  caption: [Esempio di ereditarietà e overriding.],
)

== Dipendenze e traduzione nel codice

Una classe Cliente dipende da un Fornitore quando una modifica all'interfaccia del fornitore può richiedere una modifica al cliente. La dipendenza è rappresentata da una freccia tratteggiata.

#figure(
  [```pintora
classDiagram
  class LineStorage {
    List~Line~ lines
    +addLine(Line)
    +size()
  }
  class Line { +length() }
  LineStorage ..> Line : use
```],
  caption: [`LineStorage` dipende da `Line` perché la usa come tipo e parametro.],
)

Cause comuni sono invocare operazioni, creare istanze o usare il fornitore come tipo di attributo, variabile locale, parametro o valore restituito. Nel diagramma vanno mostrate soltanto le dipendenze significative: troppe frecce nascondono la struttura che si voleva comunicare.

=== Dalle molteplicità alle strutture dati

#table(
  columns: (1fr, 2.6fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if x == 0 { rgb("#eaf2f8") },
  [`1`], [Riferimento o attributo singolo.],
  [`0..1`], [Riferimento opzionale.],
  [`0..*` / `1..*`], [Collezione tipizzata, per esempio `Set<T>`; il minimo deve essere validato.],
  [`{ordered} 0..*`], [Lista ordinata, per esempio `ArrayList<T>` o `LinkedList<T>`.],
)

Non esiste una traduzione unica. Le associazioni bidirezionali richiedono due strutture sincronizzate; aggregazione e composizione richiedono politiche di ciclo di vita; vincoli e invarianti devono essere implementati o verificati.

#red-box([Gestire le dipendenze])[
  Minimizzare dipendenze e cicli, specialmente tra package. Diagrammi troppo completi sono illeggibili; strumenti automatici possono aiutare a individuare dipendenze effettive nel codice.
]

#figure(
  image("../fotodaaggiungere/aggiungiapagina62.png", width: 96%),
  caption: [Consigli pratici per controllare le dipendenze.],
)

== Riepilogo

#table(
  columns: (1.2fr, 2.8fr),
  inset: (x: 6pt, y: 4pt),
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if calc.rem(y, 2) == 0 { rgb("#f6f9fb") },
  [*Classe*], [Nome, attributi e operazioni; i dettagli possono essere soppressi.],
  [*Associazione*], [Relazione con ruoli, navigabilità e molteplicità.],
  [*Object Diagram*], [Esempio concreto di oggetti e link.],
  [*Aggregazione*], [Relazione tutto-parte debole.],
  [*Composizione*], [Tutto-parte forte con ciclo di vita condiviso.],
  [*Generalizzazione*], [Relazione “è un” e base per l'ereditarietà.],
  [*Dipendenza*], [Il cliente può essere influenzato da modifiche al fornitore.],
)

#green-box([Regola finale])[
  Un buon Class Diagram non mostra tutto: seleziona classi, feature e relazioni necessarie alla domanda corrente, dichiara la prospettiva e usa esempi di oggetti per validare le decisioni più complesse.
]
