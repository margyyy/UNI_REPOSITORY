#import "../boxes.typ": *
#import "@preview/cetz:0.5.1"

= Software Testing

Il *software testing* è una procedura sistematica che esegue un sistema software con l'intento di trovare comportamenti anomali. Non può dimostrare in generale l'assenza di difetti: seleziona una parte del dominio degli input e confronta i risultati osservati con quelli attesi.

#yellow-box([Obiettivo del capitolo])[
  Distinguere errore, fault e failure; comprendere testing e debugging; scegliere tra approcci black-box e white-box; riconoscere i livelli di test; automatizzare casi di test Java con JUnit 5.
]

== Terminologia attraverso un caso reale

=== La storia di InvestireOK

Un trader della società *InvestireOK* usa la nuova funzionalità “acquisto ciclico facile” di `EasyGuadagno 2.1` per comprare futures EuroStoxx. Durante l'operazione osserva un comportamento scorretto — un *failure* — che degenera nel crash del sistema.

Il trader contatta l'help desk, che segue un protocollo interno:

1. ascolta e annota il problema;
2. spiega una procedura di *recovery* per riavviare il sistema;
3. apre un ticket con priorità massima nel bug tracking system;
4. avverte project manager e senior software developer.

#red-box([Recovery non significa correzione])[
  Il recovery ripristina il servizio, ma il fault che ha prodotto il failure rimane nel sistema. Il trader può quindi non essere ancora in grado di usare la funzionalità coinvolta.
]

=== Debugging del “guru”

Lo sviluppatore esperto parte dalla descrizione e dagli stessi input del trader per riprodurre il failure. Grazie alla conoscenza del sistema individua dapprima il file o componente e poi la linea difettosa: è la *fault localization*. Rimuove il bug mediante una patch: è la *fault removal* o *bug fix*.

La patch passa quindi al senior software tester, che riesegue la testsuite per verificare che la modifica non abbia danneggiato altre funzionalità. È *testing di regressione*. Se tutto è corretto, il ticket viene chiuso, patch e documentazione entrano nel repository della futura versione 2.2 e l'assistenza distribuisce la correzione al cliente.

Il termine *bug* è precedente all'informatica, ma un episodio celebre risale al 1947: Grace Hopper e il suo gruppo trovarono una falena nei relè del computer Mark II e la conservarono nel registro come il primo caso “reale” di insetto trovato.

=== Quando l'esperto non è disponibile

Se il guru è in vacanza, il project manager nomina un sostituto che non conosce il sistema. Il vice-guru riesce a riprodurre il failure, ma decine di file e breakpoint non gli consentono di localizzare il difetto.

Può allora usare uno strumento di *fault localization* che analizza la descrizione e ordina i file sospetti mediante tecniche NLP o LLM. Non corregge il programma, ma restringe lo spazio di ricerca e facilita il bug fix.

== Errore, fault e failure

=== La catena causale

- *Errore umano*: azione o decisione sbagliata dello sviluppatore, per esempio un refuso o un fraintendimento concettuale.
- *Fault*, *defect* o *bug*: manifestazione statica dell'errore nel software, come un'istruzione scorretta.
- *Failure*: comportamento osservabile del sistema che diverge da quello atteso durante l'esecuzione.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let item(x, fill, title, body) = {
      rect((x - 1.25, -.65), (x + 1.25, .65), radius: 6pt, fill: fill, stroke: .8pt + rgb("#245b88"))
      content((x, .18), text(8pt, weight: "bold", title))
      content((x, -.22), text(7pt, body))
    }
    item(-3.4, rgb("#fff0df"), [Errore umano], [decisione sbagliata])
    item(0, rgb("#fff6dc"), [Fault], [difetto nel codice])
    item(3.4, rgb("#eaf2f8"), [Failure], [anomalia osservata])
    line((-2.15, 0), (-1.25, 0), mark: (end: ">"), stroke: 1pt + rgb("#a12a2a"))
    line((1.25, 0), (2.15, 0), mark: (end: ">"), stroke: 1pt + rgb("#a12a2a"))
    content((-1.7, .38), text(6.5pt)[può causare])
    content((1.7, .38), text(6.5pt)[può causare])
  }),
  caption: [Catena causale: un errore può introdurre un fault, che in determinate condizioni può produrre un failure.],
)

=== Esempio: `reDouble`

La funzione dovrebbe raddoppiare `x`, ma usa `x` al posto della costante `2`:

```c
int reDouble(int x) {
  int y;
  y = x * x;       // fault: dovrebbe essere 2 * x
  return y;
}
```

L'errore umano può essere un refuso oppure l'interpretazione errata di “raddoppiare”. Il fault è nell'assegnamento. Chiamando `reDouble(3)` si osserva il failure: il risultato è `9` anziché `6`.

#yellow-box([Il fault può restare latente])[
  Un fault può sopravvivere a lungo nel programma. Diventa osservabile soltanto quando un input esegue — e “sollecita” nelle condizioni opportune — l'istruzione che lo contiene. Non ogni esecuzione di codice difettoso produce necessariamente un failure visibile.
]

=== Causa indiretta

Il crash può dipendere indirettamente da una quantità insufficiente di testing o dall'applicazione non sistematica delle tecniche appropriate. Il testing è difficile, richiede competenze per scegliere input efficaci, è costoso e spesso arriva vicino al rilascio, quando tempo e risorse sono già esauriti.

== Testing e debugging

=== System Under Test e oracolo

Il software testing esegue il *System Under Test* (SUT) con input scelti da un sottoinsieme del dominio e verifica se l'output ottenuto coincide con quello atteso. Il meccanismo che stabilisce il risultato corretto è detto, in generale, *oracolo di test*.

#figure(
  cetz.canvas({
    import cetz.draw: *
    rect((-4.3, -.55), (-2.25, .55), radius: 5pt, fill: rgb("#edf7f1"), stroke: .8pt + rgb("#327a50"))
    content((-3.275, .14), text(8pt, weight: "bold")[Input scelti])
    content((-3.275, -.2), text(6.8pt)[I1, I2, …, In])
    rect((-.95, -.65), (.95, .65), radius: 5pt, fill: rgb("#d9eef3"), stroke: 1pt + rgb("#245b88"))
    content((0, 0), text(10pt, weight: "bold")[SUT])
    rect((2.25, -.75), (4.45, .75), radius: 5pt, fill: rgb("#fff6dc"), stroke: .8pt + rgb("#b67d0c"))
    content((3.35, .3), text(7.5pt, weight: "bold")[Oracolo])
    content((3.35, 0), text(6.8pt)[ottenuto = atteso?])
    content((3.35, -.32), text(6.8pt)[pass / fail])
    line((-2.25, 0), (-.95, 0), mark: (end: ">"), stroke: .9pt + rgb("#245b88"))
    line((.95, 0), (2.25, 0), mark: (end: ">"), stroke: .9pt + rgb("#245b88"))
  }),
  caption: [Anatomia essenziale di un test: input, esecuzione del SUT e confronto con il risultato atteso.],
)

=== Differenza dal debugging

Il testing *rivela failure*, cioè comportamenti anomali. Il debugging parte da un failure e cerca di trovare e rimuovere il fault associato. Comprende due attività:

1. *fault localization*: individuare componente, file e linea responsabili;
2. *fault removal*: modificare il software per eliminare il difetto.

Un test fallito è quindi un punto di partenza diagnostico, non contiene necessariamente la localizzazione del bug.

== Perché il testing è difficile

=== L'impossibilità del testing esaustivo

Per sommare due interi a 32 bit esistono tutte le combinazioni di due sequenze da 32 bit:

$ 2^32 dot 2^32 = 2^64 = 18.446.744.073.709.551.616 $

Con una sola esecuzione per millisecondo servirebbero circa *584.942.417 anni*. E questo esempio elementare trascura sequenze di operazioni, stato, concorrenza, ambiente e configurazioni.

#red-box([Conseguenza])[
  Nei sistemi realistici il testing esaustivo non è realizzabile. La difficoltà centrale consiste nel selezionare “buoni” input: pochi casi con alta probabilità di rivelare failure e fault.
]

=== White-box e black-box

#table(
  columns: (1fr, 1.55fr, 1.55fr),
  inset: 7pt,
  stroke: .5pt + rgb("#b9c7cc"),
  fill: (_, y) => if y == 0 { rgb("#d9eef3") },
  [*Aspetto*], [*White-box / strutturale*], [*Black-box / funzionale*],
  [Conoscenza], [Usa esplicitamente codice e struttura interna del SUT.], [Considera il SUT come una scatola nera.],
  [Origine dei test], [Flusso di controllo, istruzioni, rami, condizioni.], [Requisiti, specifiche e comportamento atteso.],
  [Esempio], [Statement coverage: eseguire ogni istruzione almeno una volta.], [Casi derivati dalle funzioni richieste e dai domini degli input.],
  [Punto di forza], [Misura ciò che è stato esercitato nel codice.], [Verifica il prodotto dal punto di vista esterno.],
)

Nessuno dei due approcci è universalmente migliore: efficacia e costo dipendono da SUT, tecnica e competenza del tester. Sono complementari. Le slide citano lo studio di Basili e Selby, *Comparing the Effectiveness of Software Testing Strategies* (IEEE TSE, 1987), secondo il quale tester esperti trovarono più difetti con il testing funzionale nel contesto sperimentale considerato; il risultato non trasforma però il black-box in una scelta sempre superiore.

== Test case e testsuite

=== Definizioni

Un *test case* comprende input, precondizioni di esecuzione e risultati attesi costruiti per uno scopo specifico, come esercitare un cammino o verificare un requisito. Una *testsuite* è una collezione organizzata di casi di test.

La definizione va istanziata nel contesto: un input può essere un valore, un file, una configurazione o un'intera sequenza di azioni.

=== Due esempi

#table(
  columns: (1fr, 1.3fr, 1.3fr),
  inset: 7pt,
  stroke: .5pt + rgb("#b9c7cc"),
  fill: (_, y) => if y == 0 { rgb("#d9eef3") },
  [*Test*], [*Input e precondizioni*], [*Output atteso*],
  [Desktop `Sort`], [`C`, `12`, `-29`, `32`, con `C` = ordine crescente.], [`-29, 12, 32`.],
  [Web app “Carrello”], [Login; apertura pagina acquisti; selezione di `X`; aggiunta al carrello.], [Il prodotto `X` compare nel carrello.],
)

Nel primo caso l'input è quasi soltanto un insieme di dati. Nel secondo è una sequenza di passi che prepara lo stato dell'applicazione, fornisce l'input e rende osservabile l'esito.

== Livelli di testing

=== Unità

Durante l'implementazione, lo sviluppatore testa una singola unità — funzione, procedura, classe o componente — isolandola il più possibile dal resto. Stub e mock object sostituiscono collaboratori reali e controllano le dipendenze. Il testing di unità usa spesso tecniche white-box.

=== Integrazione

Quando i moduli vengono assemblati, il testing di integrazione verifica come comunicano e quali informazioni si scambiano. Le interfacce sono fonti frequenti di difetti:

- ordine o tipo errato dei parametri;
- precondizioni non rispettate;
- formati o protocolli di comunicazione violati;
- assunzioni incompatibili tra componenti.

=== Sistema e accettazione

Sul sistema integrato, il testing group verifica i requisiti e i bisogni dell'utente. L'*acceptance testing* stabilisce se il prodotto è accettabile per cliente o utenti. L'approccio è di solito black-box e considera non soltanto correttezza funzionale, ma anche prestazioni, usabilità, sicurezza e altri requisiti di qualità.

=== Regressione

Ogni modifica può generare effetti collaterali anche in zone apparentemente non coinvolte. Il testing di regressione riesegue test già disponibili per verificare che funzionalità precedentemente corrette non siano regredite. Non è confinato a una sola fase: accompagna correzioni, evoluzione e manutenzione.

#figure(
  image("../fotodaaggiungere/sostyituisicongraficodi14.6.4.png", width: 82%),
  caption: [Relazione concettuale tra fasi di sviluppo e livelli di test; la regressione attraversa l'intero ciclo evolutivo.],
)

== Automazione e JUnit 5

=== Dal test manuale al test eseguibile

Nel testing automatizzato i tester scrivono *test script*, cioè codice eseguito da un framework che prepara il contesto, invoca il SUT, valuta gli esiti e riporta `pass` o `fail`. L'automazione rende ripetibile la verifica e rende economicamente sostenibile il testing di regressione.

JUnit è un framework per il testing di programmi Java, sviluppato originariamente da Erich Gamma e Kent Beck. Usa classi, convenzioni e annotazioni come `@Test`; gli IDE possono eseguirlo mediante integrazioni grafiche.

Con JUnit è possibile:

1. scrivere test class e test method in Java;
2. eseguire i casi e osservare l'esito;
3. raggrupparli in testsuite.

Una convenzione utile associa a ogni classe di produzione una classe di test, per esempio `Stack` e `StackTest`.

=== Perché non usare `main`

Un `main()` con stampe richiede che una persona conosca l'output corretto e lo confronti manualmente:

```java
public static void main(String[] args) {
  Stack<Integer> stack = new Stack<>();
  if (!stack.isEmpty())
    System.out.println("Stack should be empty!");

  stack.push(10);
  stack.push(-4);
  System.out.println("Last element: " + stack.pop());
  System.out.println("First element: " + stack.pop());
}
```

Un test JUnit documenta invece l'oracolo mediante asserzioni eseguibili.

== Primo caso di test JUnit

=== Classe e metodo di test

Il wizard dell'IDE può generare lo scheletro, ma gli elementi essenziali sono gli import statici delle asserzioni, l'annotazione `@Test`, la test class e uno o più test method.

```java
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class StackTest {
  @Test
  void testStack() {
    Stack<Integer> stack = new Stack<>();
    assertTrue(stack.isEmpty());

    stack.push(10);
    assertFalse(stack.isEmpty());
    stack.push(-4);

    assertEquals(-4, stack.pop());
    assertEquals(10, stack.pop());
  }
}
```

`assertEquals(expected, actual)` chiarisce quale valore sia previsto e quale venga prodotto dal SUT. Un messaggio opzionale, valutato in caso di fallimento, aggiunge contesto:

```java
assertTrue(stack.isEmpty(), "lo stack deve essere vuoto");
```

=== Esecuzione: verde e rosso

Il test runner esegue una test class o una testsuite. Se tutte le asserzioni sono vere il caso passa, tradizionalmente con indicatore verde. Se `pop()` restituisce sempre `-1`, un confronto fallisce e il runner mostra expected, actual, test e linea coinvolta con indicatore rosso.

=== Failure ed error nel test runner

- *Failure del test*: un'asserzione non è soddisfatta, per esempio `expected <-3> but was <-4>`.
- *Error*: il codice testato termina in modo anomalo, per esempio con `ArrayIndexOutOfBoundsException`.

In entrambi i casi il test non passa, ma la distinzione aiuta la diagnosi: nel primo il SUT restituisce un risultato osservabile scorretto, nel secondo l'esecuzione viene interrotta da un problema runtime.

== Progettare test coesi

=== Una cosa alla volta

Il primo `testStack()` verifica contemporaneamente stato vuoto e operazioni LIFO. È poco coeso: quando fallisce, il nome del test non identifica con precisione la responsabilità violata. È preferibile separare gli obiettivi.

```java
class StackTest {
  @Test
  void newStackIsEmpty() {
    Stack<Integer> stack = new Stack<>();
    assertTrue(stack.isEmpty());
    stack.push(10);
    assertFalse(stack.isEmpty());
  }

  @Test
  void popUsesLifoOrder() {
    Stack<Integer> stack = new Stack<>();
    stack.push(10);
    stack.push(-4);
    assertEquals(-4, stack.pop());
    assertEquals(10, stack.pop());
  }
}
```

#green-box([Separation of concerns nei test])[
  Ogni test dovrebbe esprimere un comportamento preciso. Nomi descrittivi, poche cause di fallimento e struttura Arrange–Act–Assert rendono la suite più leggibile e diagnostica.
]

=== Fixture: `@BeforeEach` e `@AfterEach`

La duplicazione dell'inizializzazione si elimina con una *test fixture*. `@BeforeEach` viene eseguito prima di ogni test method e ricrea uno stato noto; `@AfterEach` viene eseguito dopo ogni test e rilascia risorse. Ogni test deve rimanere indipendente dagli altri.

```java
class StackTest {
  private Stack<Integer> stack;
  @BeforeEach
  void setUp() {
    stack = new Stack<>();
  }
  @Test
  void newStackIsEmpty() {
    assertTrue(stack.isEmpty());
    stack.push(10);
    assertFalse(stack.isEmpty());
  }
  @Test
  void popUsesLifoOrder() {
    stack.push(10);
    stack.push(-4);
    assertEquals(-4, stack.pop());
    assertEquals(10, stack.pop());
  }
}
```

La stessa idea vale per oggetti più ricchi: una fixture di `ShoppingCart` può creare il carrello e due libri e aggiungerli prima di ogni test.

=== Ciclo di vita completo

- `@BeforeEach` e `@AfterEach`: prima e dopo *ogni* test method;
- `@BeforeAll` e `@AfterAll`: una sola volta prima e dopo *tutti* i test della classe.

In una classe con tre metodi, il primo modello produce `setUp → test1 → tearDown` per tre volte; il secondo produce `setUpAll → test1 → test2 → test3 → tearDownAll`. Le fixture condivise a livello di classe richiedono cautela perché lo stato mutabile può rendere i test dipendenti dall'ordine.

#figure(
  cetz.canvas({
    import cetz.draw: *
    let step(x, y, label, fill) = {
      rect((x - 1.15, y - .27), (x + 1.15, y + .27), radius: 4pt, fill: fill, stroke: .7pt + rgb("#245b88"))
      content((x, y), text(7pt, label))
    }
    content((-2.2, 2.05), text(8pt, weight: "bold")[\@BeforeEach / \@AfterEach])
    step(-2.2, 1.5, [setUp()], rgb("#eaf2f8"))
    step(-2.2, .9, [testMethod1()], rgb("#edf7f1"))
    step(-2.2, .3, [tearDown()], rgb("#fff6dc"))
    step(-2.2, -.3, [setUp()], rgb("#eaf2f8"))
    step(-2.2, -.9, [testMethod2()], rgb("#edf7f1"))
    step(-2.2, -1.5, [tearDown()], rgb("#fff6dc"))
    line((-2.2, 1.23), (-2.2, 1.17), mark: (end: ">"))
    line((-2.2, .63), (-2.2, .57), mark: (end: ">"))
    line((-2.2, .03), (-2.2, -.03), mark: (end: ">"))
    line((-2.2, -.57), (-2.2, -.63), mark: (end: ">"))
    line((-2.2, -1.17), (-2.2, -1.23), mark: (end: ">"))

    content((2.2, 2.05), text(8pt, weight: "bold")[\@BeforeAll / \@AfterAll])
    step(2.2, 1.5, [setUpAll()], rgb("#eaf2f8"))
    step(2.2, .8, [testMethod1()], rgb("#edf7f1"))
    step(2.2, .1, [testMethod2()], rgb("#edf7f1"))
    step(2.2, -.6, [testMethod3()], rgb("#edf7f1"))
    step(2.2, -1.3, [tearDownAll()], rgb("#fff6dc"))
    line((2.2, 1.23), (2.2, 1.07), mark: (end: ">"))
    line((2.2, .53), (2.2, .37), mark: (end: ">"))
    line((2.2, -.17), (2.2, -.33), mark: (end: ">"))
    line((2.2, -.87), (2.2, -1.03), mark: (end: ">"))
  }),
  caption: [Differenza fra fixture ricreata per ogni test e fixture condivisa per l'intera classe.],
)

== Asserzioni JUnit

=== Esecuzione e arresto

Le asserzioni sono affermazioni verificabili. Se un'asserzione è vera, il metodo continua; se è falsa, il test corrente fallisce immediatamente, la parte restante del metodo viene saltata e il messaggio opzionale viene riportato. Il caso passa soltanto se tutte le asserzioni eseguite risultano vere.

=== Operazioni principali

#table(
  columns: (1.25fr, 1.75fr),
  inset: 7pt,
  stroke: .5pt + rgb("#b9c7cc"),
  fill: (_, y) => if y == 0 { rgb("#d9eef3") },
  [*Asserzione*], [*Significato*],
  [`assertTrue(cond)` / `assertFalse(cond)`], [Verifica una condizione booleana.],
  [`assertEquals(expected, actual)`], [Confronta primitivi o oggetti; per gli oggetti usa `equals`.],
  [`assertArrayEquals(expected, actual)`], [Confronta il contenuto degli array, non il loro riferimento.],
  [`assertEquals(expected, actual, delta)`], [Confronta `float` o `double` usando una tolleranza.],
  [`assertSame(expected, actual)`], [Verifica che i riferimenti indichino lo stesso oggetto.],
  [`assertNotSame(expected, actual)`], [Verifica che i riferimenti siano differenti.],
  [`fail(message)`], [Fa fallire immediatamente il test.],
)

Il messaggio opzionale va posto come ultimo argomento in JUnit 5. Per i numeri floating-point è essenziale indicare una tolleranza coerente con il dominio.

== Test parametrici

Un test parametrico esegue lo stesso comportamento con più input, riducendo duplicazione e rendendo esplicito l'insieme dei casi.

```java
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class WordTest {
  @ParameterizedTest
  @ValueSource(strings = {"Hello", "JUnit"})
  void suppliedWordsAreNotNull(String word) {
    assertNotNull(word);
  }
}
```

Il runner crea due invocazioni distinte, una per `"Hello"` e una per `"JUnit"`, e ne mostra separatamente l'esito.

== Quadro riepilogativo

#table(
  columns: (1fr, 2.2fr),
  inset: 7pt,
  stroke: .5pt + rgb("#b9c7cc"),
  fill: (_, y) => if y == 0 { rgb("#d9eef3") },
  [*Concetto*], [*Idea da ricordare*],
  [Errore–fault–failure], [Una decisione umana può introdurre un difetto che, con input opportuni, produce un'anomalia osservabile.],
  [Testing], [Esegue il SUT per rivelare failure confrontando risultato ottenuto e atteso.],
  [Debugging], [Localizza e rimuove il fault che ha causato un failure.],
  [White/black box], [Struttura interna e specifiche esterne forniscono prospettive complementari.],
  [Livelli], [Unità, integrazione, sistema/accettazione e regressione rispondono a rischi differenti.],
  [JUnit], [Trasforma l'oracolo in asserzioni eseguibili e rende i test ripetibili.],
  [Buon test], [È focalizzato, indipendente, leggibile e prepara uno stato noto.],
)

#green-box([Collocazione nel corso])[
  Il testing completa il percorso che parte dal processo di sviluppo, attraversa requisiti, design, UML e pattern e arriva alla verifica del software. Nella valutazione del corso, i concetti teorici accompagnano il progetto e possono essere richiesti sia nelle domande preliminari sia nella discussione orale.
]
