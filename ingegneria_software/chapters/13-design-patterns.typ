#import "../boxes.typ": *
#import "@preview/chronos:0.3.0"
#import "@preview/cetz:0.5.1"

= Software Design Pattern

Un *design pattern* è una soluzione elegante, dotata di un nome, a un problema ricorrente di progettazione o programmazione orientata agli oggetti. Non è codice da copiare, ma una coppia problema–soluzione riutilizzabile: descrive ruoli, responsabilità e collaborazioni lasciando al progettista l'adattamento al contesto.

#yellow-box([Idea fondamentale])[
  Un pattern raccoglie esperienza progettuale consolidata. Non è necessariamente la soluzione che verrebbe in mente per prima, non dipende da un linguaggio specifico e costituisce un'unità di riuso a un livello più astratto del codice.
]

L'idea viene fatta risalire a Kent Beck e fu resa autorevole e popolare nel 1995 dal catalogo della *Gang of Four* — Erich Gamma, Richard Helm, Ralph Johnson e John Vlissides. Oggi esistono cataloghi per domini e tecnologie differenti, dalle applicazioni enterprise alla programmazione di videogiochi.

== Progettazione, riuso e cataloghi

=== Perché usare i pattern

La progettazione non è un atto creativo privo di riferimenti: si alimenta di esperienza, sistemi simili, modelli di riferimento, principi, convenzioni, stili architetturali e pattern. Questi ultimi aiutano a:

- applicare principi di buona progettazione OO, come *alta coesione* e *basso accoppiamento*;
- creare progetti di qualità sia durante la modellazione sia durante la scrittura del codice;
- comunicare rapidamente una struttura complessa usando un vocabolario condiviso.

Dire «qui serve una Facade» comunica più di una lunga descrizione informale: il nome richiama immediatamente problema, struttura e conseguenze note.

=== Il panorama del riuso

Il riuso è una pratica fondamentale, ma non riguarda soltanto i pattern. Può avvenire mediante:

- *librerie* di funzioni o classi;
- componenti riusabili e COTS (*Commercial Off-The-Shelf*), acquistabili con interfaccia e implementazione;
- *framework* applicativi;
- famiglie o linee di prodotti con un nucleo comune;
- modelli di dominio, requisiti e design;
- sistemi legacy, generatori di programmi, servizi e software aspect-oriented.

=== Libreria e framework

Un *framework* è un insieme di classi e interfacce cooperanti che realizza un design riusabile e personalizzabile per uno specifico dominio applicativo. Esempi Java citati nelle slide sono Struts 2, Spring e Hibernate.

#figure(
  [```pintora
classDiagram
  class Applicazione {
    +main()
    +codiceSpecifico()
  }
  class Libreria {
    +operazioneA()
    +operazioneB()
  }
  Applicazione --> Libreria : chiama
```],
  caption: [Con una libreria, il codice dell'applicazione conserva il controllo e chiama i servizi necessari.],
)

#figure(
  [```pintora
classDiagram
  class Framework {
    +main()
    +templateMethod()
  }
  class EstensioneApplicativa {
    +hookA()
    +hookB()
  }
  Framework --> EstensioneApplicativa : chiama gli hook
```],
  caption: [In un framework il flusso di controllo è invertito: è il framework a chiamare il codice scritto dallo sviluppatore.],
)

La libreria offre servizi che l'applicazione invoca; il framework possiede il *main* e chiama i punti di estensione implementati dall'applicazione. La personalizzazione avviene spesso creando sottoclassi specifiche: «riusa il corpo principale e scrivi il codice che esso chiamerà».

Un pattern è più astratto, piccolo e generale di un framework: non è utilizzabile *as is*, descrive pochi elementi architetturali e può essere applicato in domini e tecnologie differenti. Un framework è invece software concreto per una famiglia di applicazioni.

=== GRASP e pattern classici

I pattern *GRASP* (*General Responsibility Assignment Software Patterns*) guidano l'assegnazione delle responsabilità nel software e costituiscono il fondamento della progettazione OO. Fra essi rientrano Creator, Information Expert, Controller, Low Coupling, High Cohesion, Polymorphism, Pure Fabrication, Indirection e Protected Variations.

Il catalogo GoF comprende 23 pattern, suddivisi in tre categorie:

#table(
  columns: (1fr, 1fr, 1.35fr),
  inset: 7pt,
  stroke: .5pt + rgb("#b9c7cc"),
  fill: (_, y) => if y == 0 { rgb("#d9eef3") },
  [*Creazionali*], [*Strutturali*], [*Comportamentali*],
  [Factory Method\ Abstract Factory\ Builder\ Prototype\ Singleton],
  [Adapter\ Bridge\ Composite\ Decorator\ Facade\ Flyweight\ Proxy],
  [Interpreter\ Template Method\ Chain of Responsibility\ Command\ Iterator\ Mediator\ Memento\ Observer\ State\ Strategy\ Visitor],
)

=== Come si descrive un pattern

Una scheda di pattern contiene almeno:

- *nome*: significativo e descrittivo, suggerisce lo scopo;
- *problema*: quando applicarlo e quali precondizioni devono valere;
- *soluzione*: uno schema astratto, non una ricetta completa, con elementi, relazioni e responsabilità;
- *conseguenze*: vantaggi, costi e compromessi prodotti dall'applicazione.

#green-box([Pattern come schema])[
  La soluzione non è mai completamente precisa: l'adattamento e le eventuali trasformazioni dei parametri restano responsabilità di chi implementa il pattern.
]

== Abstract Factory

=== Dalla creazione alla fabbrica

I pattern creazionali controllano la creazione delle istanze. GRASP *Creator* assegna a una classe `B` la responsabilità di creare `A` quando `B` contiene, aggrega, registra, usa strettamente `A` o possiede i dati necessari a inizializzarla. In casi più complessi conviene però separare questa responsabilità.

Una *Factory* nasconde una logica di creazione potenzialmente complessa, la separa dalla logica applicativa e rende possibili strategie come caching, riciclaggio e gestione della memoria.

*Abstract Factory* fornisce un'interfaccia per creare *famiglie di prodotti correlati o dipendenti* senza specificarne nel client le classi concrete.

=== Quando usarla

È indicata quando:

- il sistema deve essere indipendente da come i prodotti vengono creati, composti e rappresentati;
- il sistema deve poter essere configurato con una fra più famiglie disponibili;
- i prodotti di una stessa famiglia devono essere usati insieme e il vincolo va garantito.

=== Esempio: GUI multipiattaforma

Supponiamo di costruire una GUI per due piattaforme. La famiglia 1 contiene `Window1` e `ScrollBar1`; la famiglia 2 contiene `Window2` e `ScrollBar2`. La GUI non deve conoscere le classi concrete né accoppiare per errore `Window1` con `ScrollBar2`.

#figure(
  [```pintora-micro
classDiagram
  class GUI
  class AbstractFactory {
    <<interface>>
    +createWindow() Window
    +createScrollBar() ScrollBar
  }
  class Factory1 {
    +createWindow() Window1
    +createScrollBar() ScrollBar1
  }
  class Factory2 {
    +createWindow() Window2
    +createScrollBar() ScrollBar2
  }
  class Window { <<interface>> }
  class Window1
  class Window2
  class ScrollBar { <<interface>> }
  class ScrollBar1
  class ScrollBar2
  GUI --> AbstractFactory : usa
  AbstractFactory <|.. Factory1
  AbstractFactory <|.. Factory2
  Window <|.. Window1
  Window <|.. Window2
  ScrollBar <|.. ScrollBar1
  ScrollBar <|.. ScrollBar2
  Factory1 ..> Window1 : crea
  Factory1 ..> ScrollBar1 : crea
  Factory2 ..> Window2 : crea
  Factory2 ..> ScrollBar2 : crea
```],
  caption: [Una factory concreta crea sempre prodotti appartenenti alla medesima famiglia.],
)

Senza fabbrica, il client incorpora la scelta della piattaforma:

```java
Window w = new Window1();
ScrollBar s = new ScrollBar1();
```

Con la fabbrica astratta, la scelta è concentrata in una sola riga:

```java
AbstractFactory f = new Factory1();
Window w = f.createWindow();
ScrollBar s = f.createScrollBar();
```

Il client chiede una famiglia e poi i prodotti; è la factory a garantirne l'accoppiamento corretto. La responsabilità della creazione viene disaccoppiata dalla responsabilità dell'uso.

=== Conseguenze

- isola le classi concrete: il client conosce soltanto astrazioni;
- rende semplice cambiare l'intera famiglia sostituendo una sola concrete factory;
- favorisce la consistenza tra prodotti correlati;
- rende invece costoso aggiungere un *nuovo tipo di prodotto*: occorre modificare l'interfaccia della factory e tutte le sue implementazioni.

=== Struttura d'implementazione

La factory astratta dichiara un'operazione per ciascun tipo di prodotto; ogni factory concreta costruisce una variante coerente di tutti quei tipi.

```java
interface GUIFactory {
  Window createWindow();
  ScrollBar createScrollBar();
}

class Platform1Factory implements GUIFactory {
  Window createWindow()       { return new Window1(); }
  ScrollBar createScrollBar() { return new ScrollBar1(); }
}

class Application {
  private final GUIFactory factory;
  Application(GUIFactory factory) { this.factory = factory; }

  void buildUI() {
    Window window = factory.createWindow();
    ScrollBar bar = factory.createScrollBar();
  }
}
```

#yellow-box([Abstract Factory o Factory Method?])[
  *Factory Method* delega alle sottoclassi la creazione di un prodotto attraverso una singola operazione sovrascrivibile. *Abstract Factory* espone invece più operazioni coordinate per creare un'intera famiglia. Una concrete factory può comunque implementare ciascuna operazione usando un Factory Method.
]

== Adapter

=== Problema e scopo

*Adapter* converte l'interfaccia di una classe in un'altra interfaccia attesa dal client. Permette a classi già esistenti di collaborare anche quando le loro interfacce sono incompatibili, senza modificare il codice sorgente della classe adattata.

=== Esempio: aggiungere il cerchio

Un'applicazione gestisce figure mediante l'interfaccia `Figura`, che espone `display()` e `riempi()`. `Punto`, `Linea` e `Quadrato` la implementano già. Vogliamo riusare una classe esterna `Circle`, non modificabile, che offre invece `displayIt()`, `fill(Color)` e `setCenter()`.

#figure(
  [```pintora-tiny
classDiagram
  class Figura {
    <<interface>>
    +display()
    +riempi()
    +setPosizione()
    +getPosizione()
    +setColore()
  }
  class Punto
  class Linea
  class Quadrato
  class Cerchio {
    -circle Circle
    +display()
    +riempi()
  }
  class Circle {
    +displayIt()
    +fill(c Color)
    +setCenter()
  }
  Figura <|.. Punto
  Figura <|.. Linea
  Figura <|.. Quadrato
  Figura <|.. Cerchio
  Cerchio *-- Circle : adatta
```],
  caption: [`Cerchio` presenta al client l'interfaccia `Figura` e delega il lavoro a `Circle`.],
)

```java
class Cerchio implements Figura {
  private Circle circle;

  void display() { circle.displayIt(); }
  void riempi()  { circle.fill(colore); }
}
```

L'adapter non si limita necessariamente a rinominare le operazioni: può tradurre parametri, risultati e convenzioni.

=== Object Adapter e Class Adapter

L'*Object Adapter* usa composizione e delega; l'adapter possiede un riferimento all'adattato e sa come invocarlo. Il *Class Adapter* usa ereditarietà: eredita sia dall'interfaccia attesa sia dalla classe adattata e richiede quindi ereditarietà multipla o un linguaggio che consenta una combinazione equivalente tra classe e interfaccia.

#figure(
  [```pintora-small
classDiagram
  class Client
  class Target {
    <<interface>>
    +m()
  }
  class ObjectAdapter {
    -adaptee Adaptee
    +m()
  }
  class Adaptee {
    +mPrime()
  }
  Client --> Target
  Target <|.. ObjectAdapter
  ObjectAdapter o-- Adaptee : delega
```],
  caption: [Struttura generale dell'Object Adapter: `m()` converte la richiesta e invoca `mPrime()`.],
)

== Facade

=== Un ingresso semplice a un sottosistema

*Facade* fornisce un'interfaccia unificata e più semplice a un insieme di interfacce complesse di un sottosistema. Il client chiama un solo metodo di alto livello, mentre la facciata coordina le classi interne necessarie.

#figure(
  [```pintora-small
classDiagram
  class Client
  class Facade {
    +operazioneSemplice()
  }
  class Classe1 { +metodo1() }
  class Classe2 { +metodo2() }
  class Classe3 { +metodo3() }
  Client --> Facade
  Facade --> Classe1
  Facade --> Classe2
  Facade --> Classe3
  Classe1 --> Classe2
```],
  caption: [La Facade nasconde la rete di collaborazioni necessaria a realizzare un compito.],
)

=== Esempi delle slide

Per compilare un programma, un client potrebbe coordinare direttamente `LexicalAnalyzer`, `SyntaxAnalyzer`, `SemanticAnalyzer` e `CodeGenerator`. Una classe `Compiler` espone invece `compile()` e orchestra internamente tutte le fasi.

Analogamente, per spostare un oggetto un robot deve usare `Camera` per identificarlo, `Arm` per muoversi e `Pliers` per afferrarlo. La classe `Robot` può offrire una singola operazione `moveObject()`.

```java
class Facade {
  void doSomething() {
    Class1 c1 = new Class1();
    Class2 c2 = new Class2();
    Class3 c3 = new Class3();
    c1.doStuff();
    c3.set(c1.getX());
    return c3.getZ();
  }
}
```

=== Conseguenze e confronto con Adapter

- promuove accoppiamento debole fra client e sottosistema;
- riduce le dipendenze e nasconde componenti complessi;
- non vieta al client esperto di usare direttamente le classi interne quando necessario.

Facade e Adapter sono entrambi *wrapper*, ma risolvono problemi differenti: Facade *semplifica* un'interfaccia o un insieme di interfacce; Adapter *converte* un'interfaccia incompatibile in quella richiesta.

== Template Method

=== Scheletro e passi variabili

*Template Method* definisce lo scheletro di un algoritmo in un metodo, rimandando la definizione di alcuni passi alle sottoclassi. La parte invariante viene implementata una sola volta; le parti variabili vengono ridefinite senza alterare la sequenza generale.

#figure(
  [```pintora-tiny
classDiagram
  class AbstractClass {
    +templateMethod()
    +primitiveOperation1()
    +primitiveOperation2()
  }
  class ConcreteClass {
    +primitiveOperation1()
    +primitiveOperation2()
  }
  AbstractClass <|-- ConcreteClass
```],
  caption: [`templateMethod()` chiama nell'ordine previsto le operazioni primitive ridefinite dalla sottoclasse.],
)

```java
abstract class AbstractClass {
  final void templateMethod() {
    primitiveOperation1();
    primitiveOperation2();
  }
  protected abstract void primitiveOperation1();
  protected abstract void primitiveOperation2();
}
```

=== Esempio: login riusabile

Il login dell'applicazione segue cinque passi:

1. richiede identificativo e password;
2. autentica l'utente e produce un oggetto con le informazioni ottenute;
3. mostra un'animazione durante l'autenticazione;
4. notifica il completamento e rende disponibile il risultato;
5. esegue eventuale logica dipendente dall'applicazione.

I passi 1, 3 e 4 sono invarianti; autenticazione e notifica applicativa possono cambiare.

#figure(
  [```pintora-tiny
classDiagram
  class AbstractLogon {
    +logon()
    +authenticate(userID String, passwd String) Object
    +notifyAuth(authToken Object)
  }
  class Logon {
    +authenticate(userID String, passwd String) Object
    +notifyAuth(authToken Object)
  }
  AbstractLogon <|-- Logon
```],
  caption: [`AbstractLogon.logon()` contiene la sequenza comune; `Logon` fornisce soltanto i passi variabili.],
)

=== Inversione di controllo e conseguenze

Template Method realizza il cosiddetto *Hollywood principle*: «non chiamarci, ti chiameremo noi». Normalmente una sottoclasse chiama metodi ereditati; qui è il metodo della superclasse a richiamare operazioni ridefinite nelle sottoclassi.

- è una tecnica fondamentale di riuso, molto usata in librerie e framework;
- realizza inversione del flusso di controllo;
- consente molte sottoclassi concrete, ciascuna con passi variabili differenti;
- richiede di distinguere chiaramente operazioni obbligatorie e *hook* opzionali.

== Observer

=== Problema: mantenere viste consistenti

Vogliamo associare più viste o osservatori a un modello e mantenerli coerenti quando il suo stato cambia. Rendere pubblico lo stato viola l'incapsulamento; interrogare continuamente l'oggetto con polling fa scoprire tardi le variazioni, spreca risorse e scala male con molti osservatori.

*Observer* definisce una dipendenza lasca uno-a-molti: quando il *Subject* cambia stato, tutti gli oggetti dipendenti vengono avvertiti e possono aggiornarsi.

#yellow-box([Alla base di MVC])[
  In Model–View–Controller, tabelle, grafici e altre viste osservano lo stesso modello. La notifica garantisce che rappresentazioni differenti rimangano consistenti con i dati.
]

=== Registrazione e notifica

Gli osservatori si registrano dinamicamente presso l'osservato mediante `attach()` e possono rimuoversi con `detach()`. Quando cambia stato, il Subject esegue `notify()`, che invoca `update()` su tutti i registrati. Ogni Observer può non fare nulla oppure chiedere lo stato corrente con `getState()`.

#figure(
  [```pintora-small
classDiagram
  class Subject {
    <<interface>>
    +attach(o Observer)
    +detach(o Observer)
    +notify()
  }
  class ConcreteSubject {
    -subjectState
    +getState()
    +setState()
  }
  class Observer {
    <<interface>>
    +update()
  }
  class ConcreteObserver {
    -observerState
    -subject ConcreteSubject
    +update()
  }
  Subject <|.. ConcreteSubject
  Observer <|.. ConcreteObserver
  Subject "1" o-- "0..*" Observer : observers
  ConcreteObserver --> ConcreteSubject : legge lo stato
```],
  caption: [Struttura del pattern Observer: il Subject conosce una collezione di Observer soltanto attraverso l'interfaccia.],
)

#figure(
  chronos.diagram({
    import chronos: *
    _par("Client", display-name: ": Client")
    _par("Subject", display-name: "s : ConcreteSubject")
    _par("O1", display-name: "o1 : ConcreteObserver")
    _par("O2", display-name: "o2 : ConcreteObserver")
    _seq("Client", "Subject", comment: "attach(o1)", enable-dst: true)
    _seq("Subject", "O1", comment: "registra", dashed: true)
    _seq("Client", "Subject", comment: "attach(o2)")
    _seq("Subject", "O2", comment: "registra", dashed: true)
    _seq("Client", "Subject", comment: "setState(x)")
    _seq("Subject", "Subject", comment: "notify()")
    _seq("Subject", "O1", comment: "update()", enable-dst: true)
    _seq("O1", "Subject", comment: "getState()")
    _seq("Subject", "O1", comment: "x", dashed: true, disable-src: true)
    _seq("Subject", "O2", comment: "update()", enable-dst: true)
    _seq("O2", "Subject", comment: "getState()")
    _seq("Subject", "O2", comment: "x", dashed: true, disable-src: true)
    _seq("Subject", "Client", comment: "done", dashed: true, disable-src: true)
  }),
  caption: [Sequence Diagram completo: registrazione, cambiamento di stato, broadcast e recupero dello stato.],
)

=== Conseguenze

- accoppiamento lasco: il Subject sa che esiste una lista dinamica di Observer, ma non ne conosce la struttura;
- Observer e Subject possono appartenere a strati di astrazione differenti;
- supporto naturale alla comunicazione broadcast e al modello publish/subscribe;
- una modifica innocente può provocare una cascata di aggiornamenti, anche costosi o inattesi.

== State

=== Comportamento dipendente dallo stato

*State* consente a un oggetto di cambiare comportamento a runtime al variare del proprio stato interno. È un modo pulito per implementare macchine a stati in linguaggi che non le supportano nativamente: la rappresentazione dello stato viene estratta in una gerarchia e il polimorfismo seleziona il comportamento.

=== Esempio: distributore automatico

La vending machine attraversa tre stati:

#figure(
  cetz.canvas({
    import cetz.draw: *
    let state(pos, name) = {
      rect((pos.at(0) - 1.05, pos.at(1) - .38), (pos.at(0) + 1.05, pos.at(1) + .38),
        radius: 5pt, fill: rgb("#eaf2f8"), stroke: .8pt + rgb("#245b88"))
      content(pos, text(8pt, weight: "bold", name))
    }
    circle((-4.1, 1.15), radius: .13, fill: rgb("#245b88"), stroke: rgb("#245b88"))
    state((-2.15, 1.15), [READY])
    state((2.15, 1.15), [PAID])
    state((0, -1.1), [CHOSEN])
    line((-3.97, 1.15), (-3.2, 1.15), mark: (end: ">"), stroke: .8pt + rgb("#245b88"))
    line((-1.1, 1.15), (1.1, 1.15), mark: (end: ">"), stroke: .8pt + rgb("#245b88"))
    content((0, 1.55), text(7pt)[pay() / denaro sufficiente])
    line((2.15, .77), (2.15, -.25), (.75, -.9), mark: (end: ">"), stroke: .8pt + rgb("#245b88"))
    content((2.45, -.05), text(7pt)[choose()])
    line((-.75, -.9), (-2.15, -.25), (-2.15, .77), mark: (end: ">"), stroke: .8pt + rgb("#245b88"))
    content((-2.55, -.05), text(7pt)[dispense()])
  }),
  caption: [Macchina a stati del distributore: pagamento, scelta ed erogazione.],
)

Con una soluzione diretta, `VendingMachine` conserva un campo `state` e ogni evento contiene un `if` o uno `switch`:

```java
void pay(Money money) {
  switch (state) {
    case READY:
      totale += money;
      if (totale >= prezzo) {
        msg("money ok");
        state = PAID;
      } else {
        msg("insert more money");
      }
      break;
    default:
      msg("Operation not possible");
  }
}
```

Questa strategia genera molti controlli distribuiti. Aggiungere uno stato richiede modifiche in numerosi metodi — tipicamente un ramo per ogni evento — e il codice diventa difficile da comprendere e mantenere.

=== Implementazione con il pattern

Ogni stato diventa una sottoclasse di `VendingState`; ogni sottoclasse ridefinisce le operazioni significative in quello stato. Le implementazioni ereditate delle transizioni non ammesse producono invece un errore. Il contesto delega tutti gli eventi allo stato corrente.

#figure(
  [```pintora-tiny
classDiagram
  class VendingMachine {
    -state VendingState
    +pay()
    +choose()
    +dispense()
    +setState(v VendingState)
  }
  class VendingState {
    +pay()
    +choose()
    +dispense()
  }
  class Ready { +pay() }
  class Paid { +choose() }
  class Chosen { +dispense() }
  VendingMachine "1" o-- "1" VendingState : state
  VendingState <|-- Ready
  VendingState <|-- Paid
  VendingState <|-- Chosen
  VendingState --> VendingMachine : vm
```],
  caption: [Le classi `Ready`, `Paid` e `Chosen` incapsulano le sole operazioni valide nei rispettivi stati.],
)

```java
class VendingMachine {
  private VendingState state;
  void pay(Money m) { state.pay(m); }
  void choose(Product p) { state.choose(p); }
  void dispense() { state.dispense(); }
  void setState(VendingState v) { state = v; }
}

class Ready extends VendingState {
  void pay(Money m) {
    // aggiorna il totale e comunica l'esito
    vm.setState(new Paid(vm));
  }
}
```

=== Struttura generale e conseguenze

#figure(
  [```pintora-small
classDiagram
  class Contesto {
    -stato Stato
    +richiesta()
  }
  class Stato {
    <<abstract>>
    +richiesta()
  }
  class StatoConcretoA { +richiesta() }
  class StatoConcretoB { +richiesta() }
  Contesto o-- Stato : stato
  Stato <|-- StatoConcretoA
  Stato <|-- StatoConcretoB
```],
  caption: [`Contesto.richiesta()` delega a `stato.richiesta()`; il dispatch dinamico sceglie il comportamento.],
)

Se `richiesta()` è astratta, ogni stato concreto deve implementare anche gli eventi che rappresentano transizioni non ammesse, normalmente sollevando un errore.

- incapsula comportamento e transizioni in oggetti, eliminando un grande `switch`;
- il comportamento di ciascuno stato dipende da una sola classe;
- semplifica la modifica di uno stato e l'aggiunta di nuovi stati;
- aumenta il numero complessivo delle classi.

== Quadro riepilogativo

#table(
  columns: (1fr, 1.35fr, 1.5fr),
  inset: 7pt,
  stroke: .5pt + rgb("#b9c7cc"),
  fill: (_, y) => if y == 0 { rgb("#d9eef3") },
  [*Pattern*], [*Problema risolto*], [*Idea della soluzione*],
  [Abstract Factory], [Creare famiglie coerenti senza dipendere dalle classi concrete.], [Delegare la creazione a factory intercambiabili.],
  [Adapter], [Far collaborare interfacce incompatibili.], [Convertire e delegare mediante un wrapper.],
  [Facade], [Ridurre la complessità percepita di un sottosistema.], [Offrire un unico ingresso di alto livello.],
  [Template Method], [Riutilizzare un algoritmo con alcuni passi variabili.], [Fissare lo scheletro e ridefinire operazioni primitive.],
  [Observer], [Sincronizzare molti dipendenti con un oggetto.], [Registrazione e notifica broadcast lasca.],
  [State], [Cambiare comportamento al cambiare dello stato.], [Rappresentare gli stati come oggetti polimorfici.],
)

#green-box([Lettura trasversale])[
  Abstract Factory controlla la *creazione*; Adapter e Facade riorganizzano la *struttura*; Template Method, Observer e State governano il *comportamento*. In ogni caso il valore del pattern non è il diagramma in sé, ma la distribuzione consapevole delle responsabilità e la conoscenza dei compromessi introdotti.
]
