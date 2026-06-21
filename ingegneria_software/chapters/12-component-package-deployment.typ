#import "../boxes.typ": *

= Component, Deployment e Package Diagram

Component, Deployment e Package Diagram sono viste strutturali usate per scopi differenti. Il primo descrive l'architettura software, il secondo collega software e hardware, il terzo organizza elementi UML e dipendenze.

#yellow-box([Tre viste complementari])[
  Il Component Diagram ragiona per unità software sostituibili; il Deployment Diagram mostra dove tali unità vengono eseguite o installate; il Package Diagram tiene sotto controllo la struttura logica del modello e del codice.
]

== Component Diagram

=== Concetto di componente

Il significato concreto di *componente* varia tra piattaforme e ambienti — Java, .NET, servizi web o microservizi — ma UML adotta una definizione generale: un'unità modulare con interfacce ben definite, sostituibile nel proprio ambiente.

Un componente è quindi una *scatola nera* il cui comportamento esterno è completamente definito dalle interfacce. Componenti compatibili possono essere rimpiazzati e composti, come mattoncini LEGO, mediante infrastruttura e *glue code*.

#green-box([Sviluppo basato sui componenti])[
  Componenti provenienti da marketplace o team differenti vengono collegati attraverso un composition framework. Il valore non è soltanto il riuso del codice, ma la possibilità di assemblare sistemi funzionanti a partire da contratti stabili.
]

=== Componenti e artefatti

I componenti sono entità *logiche*; gli artefatti sono entità *fisiche* che li realizzano. Esempi delle slide:

- un sottosistema realizzato da classi raccolte in un file JAR;
- un componente WebRatio realizzato mediante JAR;
- un servizio REST implementato con Jersey/JAX-RS;
- un microservizio Spring Boot;
- `EmailVerify` per .NET distribuito in un package `.msi`.

Un *sottosistema* è una parte del sistema eseguibile anche autonomamente e offre all'esterno una o più interfacce.

#figure(
  [```pintora
componentDiagram
  component "Sottosistema" {
    [Facade]
    [Classe1]
    [Classe2]
    [Classe3]
    () "ISubsystem" as ISubsystem
    ISubsystem -- [Facade]
    [Facade] --> [Classe1]
    [Facade] --> [Classe2]
    [Classe2] --> [Classe3]
  }
```],
  caption: [Un sottosistema espone un'interfaccia e nasconde la struttura interna.],
)

=== Perché componenti e non classi

Il Component Diagram mostra i componenti del sistema e le loro dipendenze ed è quindi adatto all'High-Level Design. Le classi hanno una granularità troppo fine per offrire una panoramica architetturale: guardando i singoli alberi si rischia di perdere di vista il bosco.

=== Notazione

Un componente è rappresentato da un rettangolo con nome e parola chiave `«component»`, oppure con la specifica icona UML. Stereotipi più precisi includono `«Web service»`, `«Microservice»` e `«Subsystem»`; il modello può introdurne altri.

#figure(
  [```pintora
componentDiagram
  [<<component>> CorsoIS2] as CorsoA
  [CorsoIS2] as CorsoB
  [<<Web service>> Catalogo] as Catalogo
  [<<Microservice>> Pagamenti] as Pagamenti
  [<<Subsystem>> GestioneStudenti] as Studenti
```],
  caption: [Notazione compatta e stereotipi specifici per i componenti.],
)

=== Interfacce fornite e richieste

Il lollipop indica un'interfaccia fornita; il socket indica un'interfaccia richiesta. Collegandoli si crea un *assembly connector*: il componente cliente usa il contratto implementato dal fornitore.

#figure(
  [```pintora
componentDiagram
  [Manager]
  [Corso]
  () "iCourseForMan" as ICourse
  [Manager] --> ICourse : richiede
  ICourse --> [Corso] : fornisce
```],
  caption: [`Manager` richiede l'interfaccia `iCourseForMan`, fornita da `Corso`.],
)

=== Porte e vista interna

Una *porta* raggruppa un insieme semanticamente coeso di interfacce ed è un punto preciso d'interazione tra esterno e interno. Può avere un nome, per esempio `p1`, `p2` o `p3`.

La vista interna specifica come il componente è realizzato ed è utile a chi deve implementarlo. I componenti possono essere costruiti ricorsivamente da altri componenti.

#figure(
  [```pintora
componentDiagram
  component "Student" {
    [Application] as App
    [GUI]
    [Domain]
    () "iGUI" as IGUI
    () "iCourseForStud" as ICourse
    IGUI -- [GUI]
    ICourse -- [App]
    [GUI] --> [App]
    [App] --> [Domain]
  }
  () "pStud1: iCourseForStud" as Port1
  Port1 --> ICourse : delegate
```],
  caption: [Vista interna ricorsiva con interfacce e porta delegata.],
)

Una descrizione molto prolissa può mostrare contemporaneamente parola chiave, icona, nome, interfacce richieste e fornite, struttura interna, realizzazioni e artefatti. Questa completezza è utile soltanto quando serve davvero all'implementazione.

=== Dipendenze tra componenti

La dipendenza mantiene il significato UML consueto: il cliente ha bisogno del fornitore per funzionare. Si usa spesso quando esistono più interfacce ma non interessa elencarle; altrimenti si preferiscono interfacce fornite e richieste.

#figure(
  [```pintora
componentDiagram
  [Manager] ..> [Office] : use
```],
  caption: [`Manager` dipende da `Office`.],
)

== Esempio: sistema di gestione ordini

Il sistema è organizzato in tre livelli concettuali, con la business logic ulteriormente divisa in dominio e servizi:

1. *Presentation logic*: `GUI`;
2. *Business logic — dominio*: `Cliente`, `Ordine`, `Prodotto`;
3. *Business logic — servizi*: `Conti` e le interfacce dei gestori;
4. *Utilities*: `java.sql`, `javax.swing` e `Java.util (global)`.

#figure(
  [```pintora
componentDiagram
  package "Presentation level" {
    [GUI]
  }
  package "Business logic - dominio" {
    [Cliente]
    [Ordine]
    [Prodotto]
  }
  package "Business logic - servizi" {
    [Conti]
    () "GestoreClienti" as IClienti
    () "GestoreOrdini" as IOrdini
    () "GestoreProdotti" as IProdotti
    () "GestoreConti" as IConti
  }
  package "Utilities level" {
    [<<library>> java.sql] as SQL
    [<<library>> javax.swing] as Swing
    [<<library>> Java.util (global)] as Util
  }
  [GUI] --> IClienti
  [GUI] --> IOrdini
  [GUI] --> IProdotti
  IClienti -- [Cliente]
  IOrdini -- [Ordine]
  IProdotti -- [Prodotto]
  [Ordine] --> IConti
  [Prodotto] --> IConti
  IConti -- [Conti]
  [GUI] ..> Swing
  [Cliente] ..> SQL
  [Ordine] ..> SQL
  [Prodotto] ..> SQL
  [Conti] ..> SQL
  [GUI] ..> Util
  [Cliente] ..> Util
  [Ordine] ..> Util
  [Prodotto] ..> Util
  [Conti] ..> Util
```],
  caption: [Architettura completa del sistema di gestione ordini.],
)

Le slide costruiscono progressivamente questo stesso diagramma:

- la GUI Swing inserisce, cancella, modifica e lista clienti, ordini e prodotti;
- opera tramite `GestoreClienti`, `GestoreOrdini` e `GestoreProdotti`;
- `Ordine` e `Prodotto` usano `GestoreConti`, per esempio `dollaroToEuro()`;
- `Cliente`, `Ordine`, `Prodotto` e `Conti` usano `java.sql` per la persistenza;
- `GestoreProdotti` può offrire `Prodotto getProdotto(int idProdotto)`, ricostruendo un oggetto dai dati del database;
- la libreria `Java.util` è globale perché viene usata da tutti.

== Deployment Diagram

Il Deployment Diagram è una vista fortemente implementativa che mostra la relazione tra hardware e software. È strettamente collegato al Component Diagram.

=== Nodi e connessioni

Un nodo è una risorsa capace di ospitare software:

- un dispositivo fisico, per esempio PC o server;
- un ambiente software di esecuzione, come browser, macchina virtuale, application server o container Docker.

Una connessione tra nodi rappresenta un canale di comunicazione e può indicarne il protocollo, per esempio `TCP/IP`.

#figure(
  [```pintora
componentDiagram
  node "<<device>> PC Client" {
    [<<executionEnvironment>> Browser]
  }
  node "<<device>> Server" {
    [<<executionEnvironment>> Application Server]
  }
  [<<executionEnvironment>> Browser] --> [<<executionEnvironment>> Application Server] : TCP/IP
```],
  caption: [Dispositivo, ambiente di esecuzione e canale di comunicazione.],
)

=== Artefatti e relazione manifest

Gli artefatti sono entità concrete: sorgenti, eseguibili, script, tabelle database e pagine HTML. Vengono dislocati sui nodi e possono dipendere da altri artefatti.

La relazione `manifest` non riguarda i manifest file: indica che un artefatto è la rappresentazione fisica di un componente logico. Per esempio, file distinti possono contenere il codice della classe e dell'interfaccia che costituiscono `Course`.

#figure(
  [```pintora
componentDiagram
  package "Entita fisiche" {
    [<<artifact>> CourseClassFile] as ClassFile
    [<<artifact>> CourseInterfaceFile] as InterfaceFile
  }
  package "Entita logica" {
    [<<component>> Course] as Course
  }
  ClassFile ..> Course : manifest
  InterfaceFile ..> Course : manifest
```],
  caption: [Due artefatti manifestano il componente logico `Course`.],
)

#pagebreak(weak: true)
=== Nodi annidati e tagged value

I nodi possono essere annidati: un browser viene eseguito in un PC; un EJB container in un application server. Tagged value come `{type = PC}`, `{OS = Linux}` o `{instances = 3}` aggiungono informazioni di deployment.

#figure(
  [```pintora-small
componentDiagram
  node "<<device>> Client {type=PC}" {
    node "<<executionEnvironment>> Browser" {
      [Student.jar]
    }
  }
  node "<<device>> Web Server {instances=3}" {
    [Student.war]
  }
  node "<<device>> Application Server {OS=Linux}" {
    node "<<executionEnvironment>> EJB Container" {
      [Student.jar]
      [Registration.xml]
      [CourseManagement.jar]
    }
  }
  database "<<device>> DB Server {OS=W95}" {
    [<<artifact>> Legacy Course System]
  }
  [Student.jar] --> [Student.war] : HTTP
  [Student.war] --> [CourseManagement.jar] : RMI
  [CourseManagement.jar] --> [<<artifact>> Legacy Course System] : message bus
```],
  caption: [Architettura legacy con dispositivi, execution environment, istanze e artefatti.],
)

== Esempio: officina meccanica

Si deve progettare l'architettura software e hardware di un sistema per officina. I meccanici scelgono un intervento, identificano operazioni e ricambi e inviano una richiesta. I magazzinieri controllano periodicamente le richieste, verificano la disponibilità, preparano e scaricano i ricambi e avvisano il meccanico; quando le scorte sono basse ordinano ai fornitori.

=== Requisiti degli utenti

- *Meccanico*: richiesta dei pezzi necessari a ogni intervento.
- *Magazziniere*: carico e scarico, evasione richieste e riordino delle scorte.

=== Possibile architettura hardware

#figure(
  [```pintora
componentDiagram
  node "Officina {type=PC}" {
    [Client Officina]
  }
  node "DBServer {type=PC}" {
    database "Database officina" {
      [Interventi]
      [Parti]
      [Magazzino]
    }
  }
  node "Magazzino {type=PC}" {
    [Client Magazzino]
  }
  [Client Officina] -- [Interventi] : TCP/LAN
  [Client Magazzino] -- [Magazzino] : TCP/LAN
  [Client Officina] -- [Client Magazzino] : TCP/LAN
```],
  caption: [Tre personal computer in rete: officina, database e magazzino.],
)

=== Possibile architettura software

#figure(
  [```pintora
componentDiagram
  package "Business logic + GUI" {
    [GestioneRichieste]
    [GestioneMagazzino]
    () "pipe: richieste pezzi" as PipeReq
    () "pipe: notifiche" as PipeNotify
  }
  package "Data logic - Gestore dati" {
    [DBInterventi]
    [DBParti]
    [DBMagazzino]
  }
  [GestioneRichieste] --> PipeReq
  PipeReq --> [GestioneMagazzino]
  [GestioneMagazzino] --> PipeNotify
  PipeNotify --> [GestioneRichieste]
  [GestioneRichieste] ..> [DBInterventi] : dataAccess
  [GestioneRichieste] ..> [DBParti] : dataAccess
  [GestioneMagazzino] ..> [DBParti] : dataAccess
  [GestioneMagazzino] ..> [DBMagazzino] : dataAccess
```],
  caption: [Component Diagram completo dell'officina meccanica.],
)

Il diagramma riassume tutte le annotazioni progressive delle slide:

- `GestioneRichieste` contiene GUI e business logic dei meccanici;
- invia le richieste a `GestioneMagazzino` e riceve notifiche;
- `GestioneMagazzino` gestisce GUI, carico e scarico;
- i tre componenti dati persistono e recuperano interventi, ricambi e quantità.

=== Integrazione Component e Deployment

#figure(
  [```pintora-tiny
componentDiagram
  node "Officina {type=PC}" {
    [<<artifact>> GestioneRichieste.jar]
    [GestioneRichieste]
  }
  node "Magazzino {type=PC}" {
    [<<artifact>> GestioneMagazzino.jar]
    [GestioneMagazzino]
  }
  node "DBServer {type=PC}" {
    [<<artifact>> DBInterventi.exe]
    [<<artifact>> DBParti.exe]
    [<<artifact>> DBMagazzino.exe]
    [DBInterventi]
    [DBParti]
    [DBMagazzino]
  }
  [<<artifact>> GestioneRichieste.jar] ..> [GestioneRichieste] : manifest
  [<<artifact>> GestioneMagazzino.jar] ..> [GestioneMagazzino] : manifest
  [GestioneRichieste] --> [GestioneMagazzino] : TCP/LAN
  [GestioneRichieste] ..> [DBInterventi]
  [GestioneRichieste] ..> [DBParti]
  [GestioneMagazzino] ..> [DBParti]
  [GestioneMagazzino] ..> [DBMagazzino]
```],
  caption: [Componenti, artefatti e nodi riuniti nello stesso diagramma.],
)

== Package Diagram

=== Package e namespace

Un package UML raggruppa un numero arbitrario di elementi — classi, Use Case, modelli e sotto-package — creando gerarchie. È simile ai package dei linguaggi come Java, ma più generale.

Ogni package definisce un *namespace* nel quale i nomi devono essere univoci. Un nome completamente qualificato elimina le ambiguità, per esempio `System::Data` o `MartinFowler::Util::Data`.

#figure(
  [```pintora
componentDiagram
  package "Library Domain" {
    [ + Catalog]
    [ + Patron]
    [ + Librarian]
    [ - Account]
  }
  package "System" {
    package "Util" {
      [Data]
    }
  }
```],
  caption: [Package, sotto-package, elementi pubblici e privati.],
)

=== Modi di rappresentazione e visibilità

Un package può essere mostrato vuoto, con l'elenco degli elementi oppure con un diagramma completo al suo interno. Sono equivalenti anche package annidati e nomi qualificati come `java::util::Date`.

#figure(
  [```pintora
componentDiagram
  [package util] as UtilSymbol
  package "util - contenuto" {
    [Date]
  }
  package "java" {
    package "util" {
      [Date class diagram]
    }
  }
  [java_util_Date]
```],
  caption: [Package vuoto, contenuto elencato, gerarchia annidata e nome qualificato.],
)

La visibilità degli elementi è `+` pubblica o `-` privata. Gli elementi pubblici costituiscono l'interfaccia del package verso i client.

=== Dipendenze tra package

Una dipendenza `Fish → Water` significa che almeno un elemento di `Fish` dipende da un elemento pubblico di `Water`. La dipendenza tra package riassume quindi quelle esistenti tra gli elementi contenuti.

#figure(
  [```pintora
componentDiagram
  package "Fish" {
    [Salmon]
    [Trout]
  }
  package "Water" {
    [River]
    [Lake]
  }
  [Salmon] ..> [River]
  [Trout] ..> [Lake]
```],
  caption: [Il package `Fish` dipende dal package `Water`.],
)

== Progettare i package

Suddividere le classi è difficile e richiede compromessi ed esperienza. Le linee guida principali sono:

- *high cohesion* e *low coupling*;
- *Common Reuse Principle*: classi riusate insieme dovrebbero stare nello stesso package;
- *Acyclic Dependency Principle*: il grafo delle dipendenze non deve contenere cicli.

=== Cicli e dipendenze entranti

Un ciclo propaga le modifiche a cascata e impedisce una direzione stabile delle dipendenze. Anche un package con moltissime dipendenze entranti è rischioso: una sua modifica può impattare gran parte del sistema.

#figure(
  [```pintora
componentDiagram
  package "naming" {
    [Core]
  }
  package "naming.directory" {
    [Directory]
  }
  package "naming.spi" {
    [SPI]
  }
  [Core] ..> [Directory]
  [Directory] ..> [SPI]
  [SPI] ..> [Core] : ciclo
```],
  caption: [Ciclo di package contrario all'Acyclic Dependency Principle.],
)

In un sistema medio-grande il Package Diagram è uno degli strumenti più utili per controllare la complessità strutturale del codice.

#pagebreak(weak: true)
=== Esempio di architettura A/B

#figure(
  [```pintora
componentDiagram
  package "Sistema A" {
    [A Presentation] as AP
    [A Business Logic] as AB
    [A DB Manager] as AD
  }
  package "Sistema B" {
    [B Presentation] as BP
    [B Business Logic] as BB
    [B DB Manager] as BD
  }
  database "database" {
    [Schema]
  }
  AP --> AB
  AB --> AD
  BP --> BB
  BB --> BD
  AP ..> BP : framework
  AB ..> BB
  AD --> [Schema]
  BD --> [Schema]
```],
  caption: [Due stack applicativi e dipendenze verso un database condiviso.],
)

=== Procedura pratica

1. Progettare seguendo i principi di buona progettazione.
2. Generare il Package Diagram dal codice mediante reverse engineering, per esempio con Stan4J.
3. Identificare cicli, package poco coesi e nodi con molte dipendenze entranti.
4. Rifattorizzare e rigenerare il diagramma.

=== Risoluzione dei cicli

Le strategie mostrate nelle slide sono:

- eliminare una o più dipendenze, scegliendo se possibile il percorso più breve suggerito dallo strumento;
- fondere i package coinvolti;
- separare le entità responsabili del ciclo in un nuovo package condiviso.

#figure(
  [```pintora
componentDiagram
  package "Prima: ciclo" {
    [Package A] ..> [Package B]
    [Package B] ..> [Package A]
  }
  package "Dopo: separazione" {
    [Package A2] ..> [Package C]
    [Package B2] ..> [Package C]
  }
```],
  caption: [Separazione delle entità condivise per eliminare il ciclo.],
)

=== Non soltanto classi

I package possono raggruppare qualsiasi elemento UML. Nel caso di un ATM, Use Case come `Withdraw cash`, `Deposit funds`, `Transfer funds` e `Check balance` possono essere raccolti nel package `Transaction`, mentre `Login` e `Problem` appartengono a `Maintenance`.

#figure(
  [```pintora
componentDiagram
  package "ATM System" {
    package "Transaction" {
      [Withdraw cash]
      [Deposit funds]
      [Transfer funds]
      [Check balance]
    }
    package "Maintenance" {
      [Login]
      [Problem]
    }
  }
```],
  caption: [Package Diagram applicato a gruppi di Use Case.],
)

#v(7pt)
#text(12pt, weight: "bold", fill: rgb("#245b88"))[Riepilogo]
#v(4pt)

#table(
  columns: (1.2fr, 1.4fr, 1.4fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { rgb("#eaf2f8") },
  table.header([*Diagramma*], [*Scopo*], [*Momento tipico*]),
  [Component], [Architettura software.], [Design architetturale.],
  [Deployment], [Relazione hardware–software.], [Implementazione e deployment.],
  [Package], [Raggruppamento di elementi UML.], [Dipende dagli elementi raggruppati.],
)
