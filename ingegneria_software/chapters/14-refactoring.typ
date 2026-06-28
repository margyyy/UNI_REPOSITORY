#import "../boxes.typ": *

= Code Refactoring

Il *refactoring* è una riorganizzazione del codice esistente che modifica la struttura interna senza cambiare il comportamento osservabile. L'obiettivo non è introdurre nuove funzionalità, correggere bug o riscrivere il sistema in un'altra tecnologia, ma rendere il codice più semplice da capire, modificare, testare e mantenere.

#yellow-box([Definizione operativa])[
  Dopo un refactoring, a parità di input e stato iniziale, il programma deve produrre lo stesso comportamento di prima. Cambiano nomi, responsabilità, metodi, classi o dipendenze; non cambia la semantica esterna.
]

Il riferimento classico è Martin Fowler, *Refactoring: Improving the Design of Existing Code* (Addison-Wesley, 2000). L'idea di fondo è trattare il miglioramento del design come un'attività continua, fatta di passi piccoli e verificabili.

== Perché fare refactoring

=== Design decay

Durante l'evoluzione di un sistema, modifiche rapide, bug fix urgenti, requisiti nuovi e compromessi locali tendono a degradare gradualmente il design. Questo fenomeno è chiamato *design decay* o *design erosion*: il codice continua a funzionare, ma diventa più fragile, meno leggibile e più costoso da modificare.

Il refactoring serve a limitare questa erosione:

- aumenta leggibilità e comprensibilità;
- semplifica codice e responsabilità;
- rimuove duplicazioni e parti inutili;
- facilita il testing;
- riduce il costo della manutenzione futura.

#green-box([Investimento sulla manutenzione])[
  Il refactoring non produce valore perché "abbellisce" il codice, ma perché rende meno costose le prossime modifiche. Un design più pulito accorcia il tempo necessario per capire dove intervenire e riduce il rischio di introdurre difetti.
]

=== Quando farlo

Non conviene pianificare grandi finestre isolate, come "due settimane di refactoring ogni due mesi". Il refactoring funziona meglio quando accompagna lo sviluppo.

I momenti tipici sono:

- prima di aggiungere una nuova funzionalità, se il codice attuale la rende difficile;
- durante la correzione di un bug, quando il codice va chiarito per localizzare o rimuovere il fault;
- quando si riconosce un *code smell*;
- durante review e manutenzione ordinaria.

== Code smell

Un *code smell* è un indizio che qualcosa nel codice potrebbe non andare bene. Non è una prova automatica di errore: può essere un problema di stile, un ostacolo alla comprensione o il sintomo di un difetto più profondo.

#yellow-box([Indicatore, non sentenza])[
  Uno smell segnala "guarda meglio qui". La decisione di rifattorizzare richiede contesto: frequenza di modifica, rischio, copertura dei test, coesione, accoppiamento e impatto sul resto del sistema.
]

=== Metriche e strumenti

Strumenti di analisi come STAN4J possono evidenziare smell usando metriche e soglie configurabili, per esempio:

- `CC`: complessità ciclomatica;
- `ELOC`: righe effettive di codice;
- `LCOM`: mancanza di coesione tra i metodi di una classe.

Più alto è `LCOM`, peggiore tende a essere la coesione. Gli strumenti possono usare indicatori tipo semaforo: un metodo con poche righe è accettabile, uno molto lungo diventa sospetto, uno enormemente lungo segnala un problema quasi certo di comprensione e manutenzione.

=== Esempi di smell

#table(
  columns: (1fr, 1.45fr),
  inset: 6pt,
  stroke: .5pt + rgb("#b9c7cc"),
  fill: (_, y) => if y == 0 { rgb("#d9eef3") },
  [*Categoria*], [*Esempi*],
  [Troppo codice], [Long Method, Large Class, Duplicated Code, Dead Code, Long Parameter List.],
  [Troppo poco comportamento], [Classi quasi vuote, Data Class con soli campi e getter/setter, `catch` vuoti.],
  [Fuori dal codice], [Commenti eccessivi usati per compensare codice poco chiaro.],
)

Una *Data Class* contiene soprattutto dati e metodi di accesso. Il rischio è spostare la logica in molte classi esterne che leggono e manipolano quei dati, aumentando accoppiamento e duplicazione.

I *cloni software* sono porzioni di codice duplicate, identiche o leggermente modificate. Sono pericolosi perché un bug corretto in una copia può restare nelle altre: il difetto si propaga e la manutenzione richiede interventi ripetuti.

== Processo di refactoring

Il refactoring è fortemente legato al testing: ogni modifica deve essere abbastanza piccola da poter essere controllata rapidamente.

=== Il ritmo

Il ritmo essenziale è:

1. trovare o identificare un code smell;
2. scegliere un refactoring adatto;
3. applicare una modifica piccola seguendo una procedura precisa;
4. compilare;
5. eseguire i test.

#red-box([Passi piccoli])[
  Non fare il passo più lungo della gamba: un refactoring grande va decomposto in una sequenza di refactoring piccoli. Se qualcosa si rompe, deve essere facile capire quale passo lo ha causato.
]

Esistono mappe e cataloghi che collegano smell e refactoring possibili. Per esempio, una *God Class* può suggerire `Extract Class`, un metodo troppo lungo può suggerire `Extract Method`, una lista di parametri troppo estesa può suggerire `Replace Parameter with Method` o `Introduce Parameter Object`.

== Catalogo e strumenti

=== Refactoring semplici e complessi

Molti refactoring sono piccoli e locali:

- `Rename Method`;
- `Rename Class`;
- `Extract Method`;
- `Extract Interface`;
- `Move Method`;
- `Pull Up Method`;
- `Replace Temp with Query`.

Questi refactoring di basso livello sono spesso i mattoni per refactoring più complessi, per esempio quelli che introducono o rendono possibile un design pattern.

Esempi più strutturali sono:

- `Replace Inheritance with Delegation`;
- `Replace Conditional with Polymorphism`;
- `Separate Domain from Presentation`;
- refactoring che introducono pattern come State, Strategy o Template Method.

=== Manuale o automatico

Il refactoring può essere eseguito manualmente oppure con tool di supporto. Gli IDE moderni offrono refactoring automatici semplici; Eclipse, per esempio, propone operazioni possibili sulla selezione corrente tramite il menu `Refactor`.

Un tool è particolarmente utile quando l'operazione richiede molte modifiche coerenti. Rinominare una classe, per esempio, può coinvolgere:

- il nome della classe;
- il costruttore;
- il nome del file;
- tutti i riferimenti nelle altre classi.

Strumenti e plugin più specifici possono suggerire refactoring associati agli smell. JDeodorant, per Eclipse, può individuare smell come `God Class` e proporre `Extract Class`; ReSharper offre supporto analogo nell'ecosistema Visual Studio.

#green-box([Fidarsi, ma verificare])[
  Anche quando il refactoring è automatico, il controllo finale resta compilazione più testsuite. Il tool riduce il rischio meccanico, ma non dimostra da solo che il comportamento richiesto sia rimasto invariato.
]

== Refactoring frequenti

=== Extract Interface

Quando una classe espone operazioni che i client dovrebbero usare tramite un contratto astratto, si può estrarre un'interfaccia. L'operazione seleziona i metodi da includere e, dove possibile, sostituisce i riferimenti alla classe concreta con riferimenti all'interfaccia.

Questo riduce l'accoppiamento: i client dipendono dal contratto, non dalla specifica implementazione.

=== Pull Up

`Pull Up Method` o `Pull Up Field` sposta un metodo o un attributo da una sottoclasse alla superclasse quando l'elemento è comune a più sottoclassi.

Il risultato è eliminare duplicazione e rendere esplicita una responsabilità comune. Il rischio è anticipare troppo l'astrazione: se il comportamento non è davvero condiviso, la superclasse diventa artificiale.

=== Esplicitare inner class anonime

Un'inner class anonima viene definita e istanziata nello stesso punto, senza nome. Se il codice cresce o viene riusato, può essere utile trasformarla in una inner class con nome.

Il refactoring rende più chiaro il ruolo della classe e permette di richiamarla, testarla o modificarla con minore ambiguità.

=== Extract Method

`Extract Method` prende un blocco di istruzioni da un metodo, crea un nuovo metodo nella stessa classe e sostituisce il blocco originale con una chiamata.

È utile quando:

- un metodo è troppo lungo;
- un blocco ha un'intenzione riconoscibile;
- c'è codice duplicato;
- si vuole isolare un passo per renderlo nominabile.

Prima:

```java
void printReport() {
  printHeader();

  for (Order order : orders) {
    total += order.getAmount();
    printLine(order);
  }

  printFooter(total);
}
```

Dopo:

```java
void printReport() {
  printHeader();
  printOrderLines();
  printFooter(total);
}

private void printOrderLines() {
  for (Order order : orders) {
    total += order.getAmount();
    printLine(order);
  }
}
```

Il metodo estratto deve avere un nome che spiega l'intenzione. Se il nome è difficile da trovare, il blocco potrebbe non rappresentare una responsabilità chiara.

=== Move Method

`Move Method` sposta un metodo da una classe a un'altra. Si applica quando una classe ha troppo comportamento oppure quando un metodo usa più dati e operazioni di un'altra classe che della classe in cui si trova.

Il caso tipico è un metodo in `Class1` che accede continuamente a `Class2`: il comportamento sembra appartenere più a `Class2`.

```java
class Project {
  private Set<Person> participants;

  boolean participate(Person p) {
    return participants.contains(p);
  }
}
```

Se il comportamento riguarda soprattutto la persona, può diventare:

```java
class Person {
  boolean participatesIn(Project p) {
    return p.hasParticipant(this);
  }
}

class Project {
  boolean hasParticipant(Person p) {
    return participants.contains(p);
  }
}
```

In alcuni casi si lascia nella classe originale un metodo delegante per non rompere subito l'interfaccia pubblica.

=== Replace Temp with Query

Una variabile locale è visibile solo nel metodo in cui è dichiarata. Se il suo valore rappresenta una proprietà calcolabile dell'oggetto, trasformarla in un metodo query consente ad altri metodi della classe di riusarla e spesso abilita `Extract Method`.

Prima:

```java
double basePrice = _quantity * _itemPrice;
if (basePrice > 1000)
  return basePrice * 0.95;
else
  return basePrice * 0.98;
```

Dopo:

```java
double basePrice() {
  return _quantity * _itemPrice;
}

if (basePrice() > 1000)
  return basePrice() * 0.95;
else
  return basePrice() * 0.98;
```

=== Replace Parameter with Method

Una lista di parametri lunga rende un metodo più difficile da capire. Se un parametro è calcolabile direttamente dal ricevente, è preferibile farlo calcolare al metodo stesso.

Prima:

```java
int basePrice = _quantity * _itemPrice;
int discountLevel = getDiscountLevel();
double finalPrice = discountedPrice(basePrice, discountLevel);
```

Dopo:

```java
int basePrice = _quantity * _itemPrice;
double finalPrice = discountedPrice(basePrice);
```

Ora `discountedPrice()` recupera direttamente `discountLevel`. La chiamata espone meno dettagli e riduce il rischio di passare valori incoerenti.

=== Extract Class

`Extract Class` si applica quando una classe fa troppo: molti dati, molte responsabilità, bassa coesione. È il caso tipico della *God Class* o *Blob Class*.

Si crea una nuova classe e si spostano in essa attributi e operazioni correlate. Se non si vuole modificare immediatamente l'interfaccia della classe originale, si possono lasciare metodi deleganti.

```java
class Person {
  private String name;
  private String officeAreaCode;
  private String officeNumber;

  String getTelephoneNumber() {
    return "(" + officeAreaCode + ") " + officeNumber;
  }
}
```

Dopo l'estrazione:

```java
class Person {
  private String name;
  private TelephoneNumber officeTelephone;

  String getTelephoneNumber() {
    return officeTelephone.getTelephoneNumber();
  }
}

class TelephoneNumber {
  private String areaCode;
  private String number;

  String getTelephoneNumber() {
    return "(" + areaCode + ") " + number;
  }
}
```

== Refactoring più complessi

=== Replace Inheritance with Delegation

L'ereditarietà è problematica quando una sottoclasse usa solo una parte della superclasse e non vuole ereditare il resto. L'esempio classico è implementare `Stack` estendendo `Vector`: si ereditano operazioni come `insertElementAt()` che non hanno senso nell'astrazione stack.

Con la delega, `Stack` contiene un `Vector` privato e offre solo le operazioni coerenti con il proprio contratto.

```java
class Stack {
  private Vector _vector = new Vector();

  public Object pop() {
    Object result = _vector.removeElementAt(0);
    return result;
  }

  public void push(Object element) {
    _vector.insertElementAt(element, 0);
  }
}
```

In questo modo l'interfaccia di `Stack` resta controllata: il client non vede operazioni ereditate ma inappropriate.

=== Replace Conditional with Polymorphism

Quando una condizione sceglie comportamenti diversi in base al tipo o allo stato di una variabile, può essere sostituita con polimorfismo.

Il percorso tipico è:

1. estrarre una classe base che rappresenta il concetto variabile, per esempio `Shape`;
2. spostare in quella classe metodo e dati coinvolti;
3. creare una sottoclasse per ogni caso;
4. rendere astratto il metodo nella classe base;
5. implementare in ogni sottoclasse il comportamento specifico.

```java
abstract class Shape {
  abstract double calculateArea();
}

class Rectangle extends Shape {
  double width;
  double height;

  double calculateArea() {
    return width * height;
  }
}

class Circle extends Shape {
  double radius;

  double calculateArea() {
    return Math.PI * radius * radius;
  }
}
```

Questo refactoring è vicino a pattern come State e Strategy: la scelta del comportamento viene spostata dalla condizione al dispatch polimorfico.

=== Separate Domain from Presentation

Uno smell frequente nelle applicazioni con GUI è avere widget management e business logic nella stessa classe, per esempio una `OrderWindow` che gestisce sia l'interfaccia sia il calcolo del totale.

Il problema è l'assenza di *separation of concerns*: modifiche alla GUI e modifiche alle regole di dominio si intrecciano.

La separazione richiede più refactoring semplici combinati:

- `Extract Class`;
- `Move Field`;
- `Move Method`;
- `Extract Method`;
- eventuale introduzione di controller o servizi di dominio.

Il risultato atteso è una classe di presentazione che coordina i widget e una o più classi di dominio che contengono le regole applicative.

== Esercizio guidato

Consideriamo una classe `LineaOrdine` con attributi `_quantity` e `_itemPrice`. Il codice iniziale calcola prezzo base, livello di sconto e prezzo finale nello stesso metodo.

=== Codice iniziale

```java
public double getPrice() {
  int basePrice = _quantity * _itemPrice;
  int discountLevel;
  if (_quantity > 100) discountLevel = 2;
  else discountLevel = 1;
  double finalPrice = discountedPrice(basePrice, discountLevel);
  return finalPrice;
}

private double discountedPrice(int basePrice, int discountLevel) {
  if (discountLevel == 2) return basePrice * 0.1;
  else return basePrice * 0.5;
}
```

Gli smell principali sono un metodo che mescola più passi logici e un parametro (`discountLevel`) che può essere calcolato dalla classe stessa.

=== Primo passo: Extract Method

Si estrae il calcolo del livello di sconto.

```java
public double getPrice() {
  int basePrice = _quantity * _itemPrice;
  int discountLevel = getDiscountLevel();
  double finalPrice = discountedPrice(basePrice, discountLevel);
  return finalPrice;
}

private int getDiscountLevel() {
  if (_quantity > 100) return 2;
  else return 1;
}

private double discountedPrice(int basePrice, int discountLevel) {
  if (discountLevel == 2) return basePrice * 0.1;
  else return basePrice * 0.5;
}
```

=== Secondo passo: Replace Parameter with Method

`discountedPrice()` può recuperare direttamente il livello di sconto, quindi il parametro è eliminabile.

```java
public double getPrice() {
  int basePrice = _quantity * _itemPrice;
  int discountLevel = getDiscountLevel();
  double finalPrice = discountedPrice(basePrice);
  return finalPrice;
}

private int getDiscountLevel() {
  if (_quantity > 100) return 2;
  else return 1;
}

private double discountedPrice(int basePrice) {
  if (getDiscountLevel() == 2) return basePrice * 0.1;
  else return basePrice * 0.5;
}
```

A questo punto la variabile locale `discountLevel` in `getPrice()` è inutile e può essere rimossa.

=== Terzo passo: Replace Temp with Query

Il prezzo base diventa una query dell'oggetto.

```java
public double getPrice() {
  double finalPrice = discountedPrice(getBasePrice());
  return finalPrice;
}

private int getDiscountLevel() {
  if (_quantity > 100) return 2;
  else return 1;
}

private double discountedPrice(int basePrice) {
  if (getDiscountLevel() == 2) return basePrice * 0.1;
  else return basePrice * 0.5;
}

private double getBasePrice() {
  return _quantity * _itemPrice;
}
```

Anche `finalPrice` è ormai una variabile temporanea inutile: il metodo può restituire direttamente il risultato.

=== Quarto passo: forma finale

```java
public double getPrice() {
  return discountedPrice();
}

private int getDiscountLevel() {
  if (_quantity > 100) return 2;
  else return 1;
}

private double discountedPrice() {
  if (getDiscountLevel() == 2) return getBasePrice() * 0.1;
  else return getBasePrice() * 0.5;
}

private double getBasePrice() {
  return _quantity * _itemPrice;
}
```

Rispetto alla situazione iniziale abbiamo quattro metodi piccoli invece di due metodi di cui uno più complesso. Non ci sono parametri interni inutili e ogni metodo ha una responsabilità più chiara.

#green-box([Idea conclusiva])[
  Sistemi formati da molti metodi piccoli sono spesso più semplici da estendere e modificare, perché ogni metodo è più facile da capire e tende a contenere meno duplicazione.
]

== Riferimenti

- Martin Fowler, *Refactoring: Improving the Design of Existing Code*, Addison-Wesley, 2000.
- Martin Fowler, *Refactoring* catalog: `https://www.refactoring.com/catalog/`.
- David Gallardo, *Refactoring for everyone: How and why to use Eclipse's automated refactoring features*.
- `http://sourcemaking.com/refactoring`.

