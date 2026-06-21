#import "../boxes.typ": *
#import "@preview/chronos:0.3.0"
#import "@preview/cetz:0.5.1"
#import "../uml.typ": *

= Sequence e Communication Diagram

I *diagrammi di interazione* descrivono come un gruppo di partecipanti collabora scambiandosi messaggi per raggiungere un obiettivo. Il Sequence Diagram privilegia l'ordine temporale; il Communication Diagram mette in evidenza i collegamenti tra gli oggetti.

#yellow-box([Messaggio e struttura])[
  In prospettiva software un messaggio rappresenta normalmente la chiamata di un'operazione. Affinché il mittente possa inviarlo deve poter raggiungere il destinatario tramite un attributo, un parametro, un link o un'altra dipendenza.
]

== Fondamenti dei Sequence Diagram

=== Partecipanti, lifeline e attivazioni

Ogni partecipante è disposto orizzontalmente nella parte alta. La linea verticale tratteggiata è la sua *lifeline* e il tempo scorre dall'alto verso il basso. Una barra di attivazione indica che il partecipante possiede il controllo o sta eseguendo un'operazione.

#figure(
  chronos.diagram({
    import chronos: *
    _par("Register", display-name: ": Register")
    _par("Sale", display-name: "s : Sale")
    _seq("Register", "Sale", comment: "doA()", enable-dst: true)
    _seq("Sale", "Sale", comment: "doB()", enable-dst: true)
    _seq("Sale", "Sale", comment: "return", dashed: true, disable-src: true)
    _seq("Sale", "Register", comment: "doD()", enable-dst: true)
    _seq("Register", "Sale", comment: "ok", dashed: true, disable-src: true)
    _seq("Sale", "Register", comment: "done", dashed: true, disable-src: true)
  }),
  caption: [Partecipanti anonimi, chiamata annidata, self-message e valori di ritorno.],
)

Un nome come `s : Sale` identifica l'oggetto e il suo tipo; `: Sale` indica un'istanza anonima. Nei diagrammi di design i partecipanti sono tipicamente oggetti, non classi.

=== Messaggi sincroni e asincroni

Con un messaggio *sincrono* il mittente attende il completamento dell'operazione. Con un messaggio *asincrono* continua invece l'esecuzione, rendendo possibile rappresentare concorrenza, code ed eventi. Il ritorno può essere mostrato con una freccia tratteggiata, ma viene spesso omesso quando è ovvio.

La sintassi più completa di un messaggio è:

`valore = messaggio(parametro: Tipo): TipoRitornato`

Sono valide anche forme più sintetiche, come `getProduct()`, `d = getProduct(id)` o `d = getProduct(id: ItemID): Product`. La precisione va scelta in base allo scopo del diagramma.

#pagebreak(weak: true)
==== Dal diagramma al codice

Le chiamate annidate del diagramma corrispondono direttamente alla struttura del seguente pseudocodice. I ritorni e i parametri non interessanti sono stati soppressi nel diagramma.

#block(breakable: false, width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
```java
class Register {
  private Sale s = new Sale();

  void doX() {
    s.doA();
    s.doB();
    s.doC(this);
  }

  void doD() { /* ... */ }
}

class Sale {
  void doA() { /* ... */ }
  void doB() { /* ... */ }
  void doC(Register register) {
    register.doD();
  }
}
```
]

== Ciclo di vita dei partecipanti

Un oggetto creato durante l'interazione compare all'altezza del messaggio di creazione, non all'inizio del diagramma. Una `X` termina la lifeline e rappresenta distruzione esplicita oppure il momento dal quale l'oggetto non serve più.

#figure(
  chronos.diagram({
    import chronos: *
    _par("Register", display-name: ": Register")
    _par("Sale", display-name: ": Sale")
    _par("Payment", display-name: "p : Payment")
    _seq("Register", "Sale", comment: "makePayment(cash)", enable-dst: true)
    _seq("Sale", "Payment", comment: "«create» Payment(cash)", create-dst: true)
    _seq("Sale", "Payment", comment: "authorize()", enable-dst: true)
    _seq("Payment", "Sale", comment: "approved", dashed: true, disable-src: true)
    _seq("Sale", "Payment", comment: "discard", destroy-dst: true)
    _seq("Sale", "Register", comment: "receipt", dashed: true, disable-src: true)
  }),
  caption: [Creazione, uso e fine della lifeline di un pagamento.],
)

Nei linguaggi con garbage collector la distruzione non equivale necessariamente alla liberazione immediata della memoria: segnala soprattutto la fine logica del ruolo dell'oggetto nell'interazione.

== Frame di interazione

I frame racchiudono una parte del diagramma e ne specificano la logica di controllo. L'operatore appare nell'angolo superiore; una guardia opzionale precisa la condizione.

=== Loop, opt e alt

- `loop`: ripete il frammento finché vale la guardia o per gli elementi di una collezione;
- `opt`: esegue il frammento soltanto se la guardia è vera;
- `alt`: sceglie una sola tra più alternative, come `if/else` o `case`.

#figure(
  chronos.diagram({
    import chronos: *
    _par("Order", display-name: "o : Order")
    _par("Line", display-name: "line : OrderLine")
    _par("Product", display-name: "p : Product")
    _loop("per ogni line in lines", {
      _seq("Order", "Line", comment: "getQuantity()", enable-dst: true)
      _seq("Line", "Order", comment: "quantity", dashed: true, disable-src: true)
      _seq("Order", "Line", comment: "getProduct()", enable-dst: true)
      _seq("Line", "Order", comment: "p", dashed: true, disable-src: true)
      _alt(
        "[prodotto disponibile]",
        { _seq("Order", "Product", comment: "getPrice()") },
        "[else]",
        { _seq("Order", "Product", comment: "reportUnavailable()", dashed: true) },
      )
    })
  }),
  caption: [Frame `loop` con un frame `alt` annidato.],
)

Lo stesso controllo può essere espresso più precisamente con pseudocodice. Il Sequence Diagram mette in risalto i destinatari delle chiamate; il codice rende più immediata la logica condizionale.

#block(breakable: false, width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
```java
for (OrderLine line : lines) {
  int quantity = line.getQuantity();
  Product product = line.getProduct();

  if (product.isAvailable(quantity))
    total += product.getPrice(quantity);
  else
    product.reportUnavailable();
}
```
]

#pagebreak(weak: true)
=== Par, ref e sd

`par` divide il frame in regioni eseguite concorrentemente. `ref` rimanda a un'interazione descritta altrove e permette di scomporre diagrammi troppo grandi; i parametri e i valori di ritorno esplicitano i dati scambiati. `sd` può racchiudere e nominare l'intero Sequence Diagram.

#table(
  columns: (.7fr, 1.3fr, 2fr),
  inset: 5pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { uml-pale-blue },
  table.header([*Operatore*], [*Equivalente*], [*Significato*]),
  [`alt`], [`if / else / case`], [Una sola regione la cui guardia è vera.],
  [`opt`], [`if` senza `else`], [Il frammento può non essere eseguito.],
  [`loop`], [`for / while`], [Ripetizione del frammento.],
  [`par`], [esecuzione concorrente], [Le regioni possono avanzare in parallelo.],
  [`ref`], [chiamata di procedura], [Riferimento a un'altra interazione.],
)

#red-box([Non trasformare il diagramma in codice grafico])[
  I Sequence Diagram rendono molto bene responsabilità e chiamate, ma non sono ideali per algoritmi ricchi di cicli e condizioni. Per logica complessa è spesso più leggibile affiancare pseudocodice o usare diagrammi separati per i diversi scenari.
]

== Sequence Diagram di sistema

Un *System Sequence Diagram* (SSD) tratta il sistema come una scatola nera. I partecipanti sono gli attori esterni e un unico oggetto `Sistema`; i messaggi rappresentano eventi di input e output osservabili in uno scenario di Use Case.

#figure(
  chronos.diagram({
    import chronos: *
    _par("Cliente", display-name: "Cliente")
    _par("Sistema", display-name: ": Sistema ATM")
    _seq("Sistema", "Cliente", comment: "mostraBenvenuto()")
    _seq("Sistema", "Cliente", comment: "richiediNumeroConto()")
    _seq("Cliente", "Sistema", comment: "inserisciConto(numero)", enable-dst: true)
    _seq("Sistema", "Cliente", comment: "richiediPIN()")
    _seq("Cliente", "Sistema", comment: "inserisciPIN(pin)")
    _seq("Sistema", "Sistema", comment: "autentica(numero, pin)", enable-dst: true)
    _seq("Sistema", "Sistema", comment: "esito", dashed: true, disable-src: true)
    _seq("Sistema", "Cliente", comment: "mostraMenu()", disable-src: true)
  }),
  caption: [SSD dello scenario principale di autenticazione presso un ATM.],
)

L'SSD serve a precisare operazioni di input, parametri e dati restituiti; aiuta a derivare test e contratti delle operazioni. Non mostra ancora gli oggetti interni che realizzano il comportamento: il passaggio da requisiti a design consiste proprio nell'assegnare queste responsabilità.

#yellow-box([SSD e Sequence Diagram di design])[
  Nell'SSD il sistema è un solo partecipante opaco. Nel design quel partecipante viene aperto e sostituito da controller, entità e servizi che collaborano per realizzare gli stessi eventi di sistema.
]

== Sequence Diagram nel design

Nel Low-Level Design il diagramma mostra quali oggetti realizzano un'operazione e in quale ordine collaborano. Deve essere coerente con il Class Diagram: ogni messaggio deve corrispondere a un'operazione disponibile e ogni collegamento deve essere strutturalmente possibile.

=== Esempio del registro di cassa

#figure(
  chronos.diagram({
    import chronos: *
    _par("Cashier", display-name: "Cassiere")
    _par("Register", display-name: ": Register")
    _par("Sale", display-name: "s : Sale")
    _par("Catalog", display-name: ": ProductCatalog")
    _seq("Cashier", "Register", comment: "enterItem(id, quantity)", enable-dst: true)
    _seq("Register", "Catalog", comment: "getProduct(id)", enable-dst: true)
    _seq("Catalog", "Register", comment: "description", dashed: true, disable-src: true)
    _seq("Register", "Sale", comment: "addLine(description, quantity)", enable-dst: true)
    _seq("Sale", "Register", comment: "subtotal", dashed: true, disable-src: true)
    _seq("Register", "Cashier", comment: "display(description, subtotal)", disable-src: true)
  }),
  caption: [Collaborazione interna che realizza l'evento di sistema `enterItem`.],
)

Il diagramma aiuta a distribuire responsabilità, ma non determina automaticamente il design. Più collaborazioni possono soddisfare lo stesso SSD; vanno confrontate per coesione, accoppiamento e comprensibilità.

== Esempio: prezzo di un ordine

Un ordine contiene linee con quantità e prodotto. Il prezzo totale scontato è la somma dei prezzi delle linee meno uno sconto globale dipendente dal cliente.

`prezzo = somma(quantità × prezzoUnitario) − scontoCliente`

=== Soluzione centralizzata

Nella prima soluzione `Ordine` coordina ogni dettaglio: legge quantità e prodotto dalle linee, interroga il prodotto, calcola importi, totale e sconto.

#figure(
  chronos.diagram({
    import chronos: *
    _par("Caller", display-name: "chiamante")
    _par("Order", display-name: "o : Ordine")
    _par("Line", display-name: "linea : Linea")
    _par("Product", display-name: "p : Prodotto")
    _par("Customer", display-name: "cliente : Cliente")
    _seq("Caller", "Order", comment: "calcolaPrezzo()", enable-dst: true)
    _loop("per ogni linea", {
      _seq("Order", "Line", comment: "getQuantità()")
      _seq("Order", "Line", comment: "getProdotto()")
      _seq("Order", "Product", comment: "getPrezzoUnitario()")
      _seq("Order", "Order", comment: "accumulaImporto()")
    })
    _seq("Order", "Customer", comment: "getPercSconto()")
    _seq("Order", "Order", comment: "applicaSconto()")
    _seq("Order", "Caller", comment: "prezzo", dashed: true, disable-src: true)
  }),
  caption: [Controllo centralizzato: `Ordine` contiene quasi tutta la logica.],
)

La soluzione funziona, ma rende `Ordine` poco coeso e molto dipendente dai dettagli delle altre classi. Con l'aumentare delle responsabilità può trasformarsi in una *God Class* o *Blob*. Il codice conferma ciò che emerge dal diagramma: `Ordine` estrae i dati dagli altri oggetti e svolge direttamente quasi tutta l'elaborazione.

==== Pseudocodice della soluzione centralizzata

#block(breakable: false, width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
```java
class Ordine {
  Set<Linea> linee;
  Cliente cliente;

  Euro calcolaPrezzo() {
    Euro totale = 0;
    for (Linea linea : linee) {
      int quantità = linea.getQuantità();
      Prodotto prodotto = linea.getProdotto();
      Euro unitario = prodotto.getPrezzoUnitario();
      linea.setImporto(quantità * unitario);
      totale += linea.getImporto();
    }
    int percentuale = cliente.getPercSconto();
    Euro sconto = totale * percentuale / 100;
    return totale - sconto;
  }
}
```
]

#pagebreak(weak: true)
=== Soluzione distribuita

Nella seconda soluzione ogni oggetto gestisce i dati che possiede: la linea calcola il proprio prezzo, il prodotto applica la politica relativa alla quantità e il cliente calcola il totale scontato.

#figure(
  chronos.diagram({
    import chronos: *
    _par("Caller", display-name: "chiamante")
    _par("Order", display-name: "o : Ordine")
    _par("Line", display-name: "linea : Linea")
    _par("Product", display-name: "p : Prodotto")
    _par("Customer", display-name: "cliente : Cliente")
    _seq("Caller", "Order", comment: "calcolaPrezzo()", enable-dst: true)
    _loop("per ogni linea", {
      _seq("Order", "Line", comment: "calcolaPrezzo()", enable-dst: true)
      _seq("Line", "Product", comment: "getPrezzo(quantità)", enable-dst: true)
      _seq("Product", "Line", comment: "prezzo", dashed: true, disable-src: true)
      _seq("Line", "Order", comment: "prezzo", dashed: true, disable-src: true)
    })
    _seq("Order", "Customer", comment: "getTotaleScontato(this)", enable-dst: true)
    _seq("Customer", "Order", comment: "getTotale()")
    _seq("Order", "Customer", comment: "totale", dashed: true)
    _seq("Customer", "Order", comment: "valoreScontato", dashed: true, disable-src: true)
    _seq("Order", "Caller", comment: "valoreScontato", dashed: true, disable-src: true)
  }),
  caption: [Controllo distribuito: dati e operazioni correlate restano nella stessa classe.],
)

La soluzione distribuita tende a essere preferibile perché aumenta la coesione, limita le dipendenze sui dati interni e riduce il rischio di classi onniscienti. Non significa però distribuire ogni singola operazione: serve un controller che coordini il caso d'uso senza assorbirne tutta la business logic.

#pagebreak(weak: true)
==== Pseudocodice della soluzione distribuita

#block(breakable: false, width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#f7f9fa"), stroke: .5pt + rgb("#cbd4da"))[
```java
class Ordine {
  Set<Linea> linee;
  Cliente cliente;
  Euro totale;

  Euro calcolaPrezzo() {
    totale = 0;
    for (Linea linea : linee)
      totale += linea.calcolaPrezzo();
    return cliente.getTotaleScontato(this);
  }

  Euro getTotale() { return totale; }
}

class Linea {
  Prodotto prodotto;
  int quantità;

  Euro calcolaPrezzo() {
    return prodotto.getPrezzo(quantità);
  }
}

class Cliente {
  int percentualeSconto;

  Euro getTotaleScontato(Ordine ordine) {
    Euro totale = ordine.getTotale();
    return totale - totale * percentualeSconto / 100;
  }
}
```
]

Ora ogni metodo opera principalmente sui dati della propria classe: `Linea` conosce quantità e prodotto, mentre `Cliente` conosce la politica di sconto.

== Communication Diagram

Un Communication Diagram rappresenta la stessa interazione come rete di oggetti collegati. La sequenza temporale non deriva dalla posizione verticale, ma dalla numerazione dei messaggi.

#figure(
  cetz.canvas({
    import cetz.draw: *
    content((0, 2), uml-box([o : Order], width: 36mm, object: true))
    content((-3.7, 0), uml-box([line : OrderLine], width: 42mm, object: true))
    content((3.7, 0), uml-box([p : Product], width: 36mm, object: true))
    content((0, -2), uml-box([c : Customer], width: 38mm, object: true))
    line((-.7, 1.55), (-2.7, .55), stroke: .8pt + uml-blue)
    line((.7, 1.55), (2.7, .55), stroke: .8pt + uml-blue)
    line((-.7, -1.55), (-2.7, -.55), stroke: .8pt + uml-blue)
    content((-2, 1.3), text(6.5pt)[1.1 getQuantity()])
    content((2.1, 1.3), text(6.5pt)[1.3 getPricingDetails()])
    content((-2.1, -1.25), text(6.5pt)[1.5.1 getDiscountInfo()])
    content((0, 2.65), text(7pt, weight: "bold")[1 calculatePrice()])
  }),
  caption: [Nel Communication Diagram la numerazione annidata ricostruisce le chiamate.],
)

La numerazione progressiva `1`, `1.1`, `1.2`, `1.5.1` mostra l'annidamento: `1.5.1` avviene dentro il messaggio `1.5`, a sua volta dentro `1`. Senza numerazione annidata si perde l'informazione sulla struttura delle chiamate.

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  inset: 6pt,
  stroke: .4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { uml-pale-blue },
  table.header([*Aspetto*], [*Sequence Diagram*], [*Communication Diagram*]),
  [Enfasi], [Ordine temporale.], [Struttura dei collegamenti.],
  [Ordine], [Posizione verticale.], [Numerazione dei messaggi.],
  [Punto forte], [Chiamate e attivazioni annidate.], [Rete delle collaborazioni.],
  [Limite], [Può diventare molto alto.], [Il tempo è meno immediato.],
)

=== Linee guida

1. Dichiarare se il diagramma è un SSD di requisiti o un diagramma di design.
2. Modellare uno scenario o una responsabilità precisa, non l'intero sistema.
3. Mantenere il diagramma coerente con operazioni e navigabilità del Class Diagram.
4. Mostrare ritorni, tipi e frame soltanto quando aggiungono informazione utile.
5. Usare pseudocodice per algoritmi complessi e diagrammi separati per alternative importanti.
6. Cercare responsabilità distribuite e coese, evitando controller che incorporano tutta la logica.

#green-box([Regola conclusiva])[
  Il valore di un Sequence Diagram non è mostrare ogni chiamata: è rendere evidente chi conosce chi, chi svolge ciascuna responsabilità e come uno scenario attraversa gli oggetti del design.
]
