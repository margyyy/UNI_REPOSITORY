### Fasi del Processo di Design

Il processo di design si articola in una serie di **attività/fasi** sequenziali, ognuna delle quali produce un **artefatto** (documento o specifica).  Il Modello di riferimento (da Sommerville) è il seguente:

```
Requirements Specification
        │
        ▼
Architectural Design  →  System Architecture
        │
        ▼
Abstract Specification  →  Software Specification
        │
        ▼
Interface Design  →  Interface Specification
        │
        ▼
Component Design  →  Component Specification
        │
        ▼
Data Structure Design  →  Data Structure Specification
        │
        ▼
Algorithm Design  →  Algorithm Specification
```

> Le frecce indicano che ogni fase può ricevere input anche dalla specifica dei requisiti direttamente, non solo dalla fase precedente. Il processo non è strettamente sequenziale: spesso le fasi si sovrappongono.

###### Spiegazione delle varie attività

| Attività | Descrizione |
|---|---|
| **Design dell'architettura** | Definizione dei componenti (sottosistemi) software e dei connettori (come avviene la comunicazione) |
| **Specifica astratta** | Specifica di alto livello dei componenti |
| **Design dell'interfaccia** | Definizione e specifica delle interfacce dei componenti |
| **Design delle componenti** | Specifica dettagliata dei singoli componenti (es. classi OO) |
| **Design delle strutture dati** | Progettazione delle strutture dati per contenere i dati del problema |
| **Design degli algoritmi** | Scelta e progettazione degli algoritmi |

###### Esempio pratico: Weather Service System

Per un sistema di previsioni meteo, il processo di design produce:
- **Architectural design** → architettura con i servizi `WeatherService`, `LocalInformation`, `SocialNetwork`, `Subscriber`
- **Interface design** → interfaccia `WeatherForecast` con operazioni come:
  - `+GetHistoricalTemperature(date:Date, hour:Hour)`
  - `+GetTomorrowForecastRain(unitOfMeasure:Unit)`
- **Component/Data design** → classi OO con attributi tipizzati (es. `weather_id: BIGINT`, `temperature: INTEGER`...)
- **Algorithm design** → scelta tra QuickSort o BubbleSort, tra ArrayList, Vector o LinkedList (nel caso di design *platform-dependent*)

---

### High Level Design vs Low Level Design

Questi due livelli si distinguono per il grado di dettaglio:

- **High Level Design** ([[4 - Design Architetturale]]): partendo dai requisiti software, si identificano i **componenti** e si produce l'**architettura SW**. Si lavora a livello di sottosistemi.
- **Low Level Design** (design delle componenti): ogni componente dell'architettura viene **decomposto in classi OO** (o strutture equivalenti), specificando attributi, metodi e strutture dati interne.

> Il **Design by Contract** (Meyer) interviene tipicamente al livello del Low Level Design, specificando le interfacce delle classi prima della codifica.

---

### Design by Contract

> Concetto introdotto da **Bertrand Meyer** (creatore del linguaggio Eiffel, 1988).
> Il termine "contratto" riprende la metafora del contratto legale: *accordo tra fornitore e cliente*.

**Design by Contract** è un metodo di design per il software che ha come obiettivo **migliorarne la qualità**. Prescrive che il progettista definisca **specifiche precise delle interfacce delle classi/componenti software**, basandosi sulla metafora di un contratto legale.

L'idea centrale è che:
- Una componente software ha **obblighi** nei confronti delle altre componenti
- Un **"contratto"** viene creato per ogni componente del sistema **prima che sia codificata**

---

### Elementi di un Contratto (Classi OO)

Un contratto si compone di tre elementi:

###### 1. Pre-condizione

Espressione a valori booleani che rappresenta le **aspettative sullo stato del mondo** prima che venga eseguita un'operazione.

```
Es. radice quadrata:  int sqrt(int x)
    pre:  x ≥ 0
```

> ⚠️ Invocare `sqrt` con un numero negativo è un **errore**: le conseguenze sono indefinite (risultato errato, eccezione, comportamento non predicibile). La pre-condizione stabilisce esplicitamente che il chiamante è responsabile di garantire `x ≥ 0`.

###### 2. Post-condizione

Espressione a valori booleani riguardante lo **stato del mondo dopo l'esecuzione** di un'operazione.

```
Es. radice quadrata:  int sqrt(int x)
    pre:  x ≥ 0
    post: x = ris*ris
```

> La post-condizione garantisce cosa la funzione produce se la pre-condizione era soddisfatta.

###### 3. Invariante di classe

Condizione che ogni **oggetto della classe** deve soddisfare quando è **"in equilibrio"**, cioè in ogni momento in cui è possibile eseguire un'operazione (non "in mezzo" a una transizione).

> In pratica: l'invariante deve valere prima e dopo ogni operazione pubblica. Durante l'esecuzione interna di un metodo può essere temporaneamente violata.

---

### Esempio: Pre, Post e Invariante su Conto Corrente

```java
class Account {
  private int balance;
  private List<Integer> deposits;
  private List<Integer> withdraws;

  Account(int initialAmount){}

  public void deposit(int value){}
  public void withdraw(int value) {}   // ← operazione soggetta a contratto
  public boolean mayWithdraw(int value) {}
  public int getBalance() {}
}
```

**Contratto per `withdraw(int value)`** (in Object Constraint Language — OCL):

```
Precondition:
    value >= 0
    value <= balance
Postcondition:
    balance = balance@pre - value
```

> `balance@pre` indica il valore di `balance` **prima** dell'esecuzione dell'operazione. La post-condizione garantisce che il saldo sia stato decrementato esattamente del valore prelevato.

**Invariante della classe Account:**

```
Invariant:
    balance >= 0 and
    balance = (deposits.value --> sum()) - (withdraws.value --> sum())
```

> L'invariante garantisce che il saldo non sia mai negativo e che corrisponda sempre alla differenza tra somma dei depositi e somma dei prelievi. Questo è un vincolo di consistenza dell'oggetto.

---

### Le Pre-condizioni Sono Utili?

A prima vista potrebbe sembrare inutile definire una pre-condizione, dato che è sempre possibile inserire controlli nel codice della funzione stessa. **Il problema è: chi è responsabile dei controlli?**

Senza una dichiarazione esplicita di responsabilità si rischia:

1. **Troppi pochi controlli** → ognuno delega all'altro, nessuno verifica, il bug passa inosservato
2. **Troppi controlli** → entrambe le parti li eseguono (*defensive programming*): si duplica il codice, cresce la complessità, i controlli possono diventare inconsistenti

==La pre-condizione risolve il problema dichiarando esplicitamente chi deve fare cosa.==

---

### Il Contratto: Fornitore vs Cliente

Nel Design by Contract si distinguono due ruoli:

- **Cliente** (*caller*): la componente che usa il servizio
- **Fornitore** (*supplier*): la componente che offre il servizio (implementa l'operazione)

Il meccanismo funziona così:

- Il **fornitore garantisce** che se `pre & inv` valgono prima della chiamata di `op`, allora dopo l'esecuzione varrà `post (& inv)`
- Il **fornitore chiede** che valgano `pre & inv` (altrimenti non garantisce nulla!)

In sintesi:
- `Pre` = **richiesta** che il fornitore fa al chiamante/cliente
- `Post` = **assicurazione/garanzia** che il fornitore dà

> **La responsabilità dei controlli è esplicitata!**

###### Di chi è la responsabilità di un failure?

| Momento | Responsabile |
|---|---|
| **Prima** della chiamata (pre-condizione) | **Cliente** — es. è responsabilità di chi chiama `sqrt(X)` verificare che `X > 0` |
| **Durante** l'esecuzione (post-condizione, invariante) | **Fornitore** |

```
Pre non valida        ⟹  errore del chiamante!
Post o inv non valida ⟹  errore del fornitore! (se Pre era valida)
```

---

### Vantaggi del Design by Contract

- **Codifica**: guida lo sviluppatore durante la fase di codifica — deve seguire le specifiche del contratto
- **Qualità del software**: definisce quale componente è responsabile dei controlli; aiuta a scrivere operazioni semplici che soddisfino un contratto ben definito (evitando operazioni che tentano di gestire tutti i casi possibili)
- **Documentazione**: Pre, Post e Invarianti documentano in modo preciso cosa fa una componente/classe — meglio di qualunque commento informale
- **Testing**: guida la generazione di casi di test *black-box* (i test verificano pre/post senza conoscere l'implementazione)
- **Debugging**: se il contratto è implementato nel codice, permette di trovare "il colpevole" di un malfunzionamento — le eccezioni si sollevano quando il contratto è violato

> Esistono **framework** per diversi linguaggi che supportano Design by Contract:
> - Java: `assert`, JML, Contracts for Java
> - Python: `icontract`, `deal`
> - C#: `System.Diagnostics.Contracts`
> - Eiffel: nativamente integrato nel linguaggio

---

### Progettazione degli Algoritmi

Il **design degli algoritmi** è l'attività più vicina alla codifica. Spesso viene lasciata in parte o totalmente agli sviluppatori.

Di solito si seguono questi passi:

1. Si analizza la descrizione di design della classe "target"
2. Se è possibile **selezionare** un algoritmo già noto, lo si seleziona (es. Sort → Quick Sort)
3. Se invece occorre **definire** un nuovo algoritmo, si sceglie una notazione
4. Utilizzando la nozione di **stepwise refinement** si sviluppa l'algoritmo nella notazione scelta
5. Si usano i **metodi formali** per provare la correttezza dell'algoritmo (es. Triple di Hoare) — solo quando necessario, es. sistemi safety-critical

---

### Notazioni per gli Algoritmi

Le notazioni si dividono in:

- **Visuali**: Activity diagram UML, Diagrammi di flusso (flowchart), Box diagram, Structured Chart, Decision table, ...
- **Testuali**: **PDL** (Program Design Language) o **Pseudo-codice**

---

### PDL o PseudoCodice

Il **Program Design Language (PDL)** o pseudo-codice è un **linguaggio semplificato** che usa:
- Il **vocabolario** di un linguaggio naturale (es. Inglese o Italiano)
- La **sintassi** di un linguaggio di programmazione (es. Java)

La differenza rispetto a un vero linguaggio di programmazione è l'utilizzo di **"narrativa"** direttamente dentro i comandi PDL. Questo permette diversi livelli di astrazione e abilita lo **stepwise refinement**.

Esempio — Bubble Sort in PDL:
```
SORT (TABLE, SIZE OF TABLE)
  IF SIZE OF TABLE > 1
    DO UNTIL NO ITEMS WERE INTERCHANGED
      DO FOR EACH PAIR OF ITEMS IN TABLE (1-2, 2-3, 3-4, ETC.)
        IF FIRST ITEM OF PAIR > SECOND ITEM OF PAIR
          INTERCHANGE THE TWO ITEMS
```

> Le istruzioni in maiuscolo sono "strutture di controllo"; la parte in linguaggio naturale descrive cosa fare ad alto livello. Man mano che si raffina, la narrativa viene sostituita con istruzioni più precise.

---

### Stepwise Refinement

Lo **stepwise refinement** (raffinamento per passi successivi) è una tecnica per sviluppare un algoritmo partendo da una descrizione ad alto livello e raffinandola progressivamente fino a ottenere codice implementabile.

**Esempio**: dati tre numeri interi, calcolare la differenza tra il più grande e il più piccolo (es. 6, 2, 9 → 7).

**Passo 1 — descrizione ad alto livello (narrativa pura):**
```
1. "Acquisire dall'esterno valori A, B, C"
2. "Calcolare il più grande di A, B, C"
3. "Calcolare il più piccolo di A, B, C"
4. "Calcolare la differenza tra i risultati ottenuti in 2. e in 3."
5. "Rendere disponibile all'esterno il risultato"
```

**Passo 2 — primo raffinamento (PDL con variabili):**
```
Var A, B, C, BIG, SMALL, RESULT: Integer
1. "Acquisire dall'esterno valori A, B, C"
2. BIG <- CALCOLA_MASSIMO(A, B, C);
3. SMALL <- CALCOLA_MINIMO(A, B, C);
4. RESULT <- BIG – SMALL;
5. "Rendere disponibili all'esterno RESULT"
```

**Passo 3 — raffinamento di `CALCOLA_MASSIMO`:**
```
CALCOLA_MASSIMO(A, B, C)
Var BIG: Integer
1. "Se A è più grande di B allora metti in BIG il valore di A altrimenti quello di B"
2. "Se C è più grande di BIG allora metti in BIG il valore di C"
3. "restituisci BIG"
```

**Passo 4 — raffinamento completo:**
```
CALCOLA_MASSIMO(A, B, C)
Var BIG: Integer
If A > B then
    BIG <- A;
else
    BIG <- B;
endIf
If C > BIG then
    BIG <- C;
endIf
return BIG;
```

> A ogni passo la narrativa viene sostituita da istruzioni sempre più precise e formali. Il processo si interrompe quando il codice è direttamente traducibile in un linguaggio di programmazione.

---

### Principi di Progettazione

> I principi di progettazione guidano verso il raggiungimento degli obiettivi di **qualità** per il progetto.

Il design non è puramente creativo: si basa su esperienza, sistemi simili, modelli di riferimento, stili architetturali, design pattern, design convention e **design principles**.

Davis (1995) ne ha catalogati **201**; i principali che vedremo sono:
1. Astrazione
2. Decomposizione
3. Modularità (Separation of Concerns)
4. Information Hiding

Seguire questi principi porta a produrre software: ==**manutenibile**, **comprensibile**, **semplice da testare**, **riusabile**, **riparabile** e **portabile**==.

> Valgono e si possono applicare per tutti i sistemi, non solo OO.

---

### Il Modulo

Prima di entrare nei principi, è fondamentale definire il concetto di **modulo** (definizione molto generale).

Un **modulo** è un'entità SW, identificata da un **nome**, che **contiene e fornisce servizi** software:
- Contiene istruzioni, strutture dati, controllo
- **Può essere incluso** in un altro modulo
- **Può usare** un altro modulo o parte di esso → relazione **"dipende da"**

```
A --------→ B       A dipende da B
```

Esempi di moduli: una macro, un programma, un sottoprogramma, una funzione, uno script, un gruppo di programmi, un gruppo di sottoprogrammi, una **classe**, un metodo, un package, ...

> La parola "modulo" è volutamente generica per essere applicabile a qualsiasi paradigma di programmazione.

---

### 1. Astrazione

> Permette di concentrarsi su un problema ad un determinato livello di astrazione, senza perdersi in dettagli irrilevanti.

- **Riduce la complessità**
- Permette di descrivere il comportamento di un modulo senza preoccuparsi dei dettagli
- **Nasconde informazioni** che a quel livello non servono

**Esempio con Selection Sort** — tre livelli di astrazione crescente:

**Livello 1 (massima astrazione — narrativa pura):**
```
Sort L in nondecreasing order
```

**Livello 2 (raffinamento intermedio):**
```
DO WHILE I is between 1 and (length of L)-1
  Set LOW to index of smallest value in L(I),..., L(length of L)
  Interchange L(I) and L(LOW)
END DO
```

**Livello 3 (algoritmo completo):**
```
DO WHILE I is between 1 and (length of L)-1
    Set LOW to current value of I
    DO WHILE J is between I+1 and (length of L)
        IF L(LOW) is greater than L(J)
            THEN set LOW to current value of J
        ENDIF
    END DO
    Set TEMP to L(LOW)
    Set L(LOW) to L(I)
    Set L(I) to TEMP
END DO
```

###### Forme di Astrazione

| Forma | Descrizione | Esempio |
|---|---|---|
| **Funzionale** | Definizione di una funzionalità indipendentemente dall'algoritmo che la implementa | `Sort L in decreasing order` — non importa come, solo il risultato |
| **di Dati** | Definizione di un tipo di dato in base alle operazioni che su di esso possono essere fatte, senza definirne una struttura concreta | Stack (con `push`/`pop`), Coda (con `enqueue`/`dequeue`) |
| **di Controllo** | Definizione di un meccanismo di controllo senza indicarne i dettagli interni | Semafori per sincronizzare l'accesso a risorse condivise tra task |

> L'astrazione di dati è alla base dei **Tipi di Dati Astratti (ADT)** e della programmazione OO: si definisce *cosa* si può fare con un oggetto, non *come* è internamente strutturato.

---

### 2. Decomposizione

> Cercare di risolvere un problema in una volta sola è in genere più difficile che risolverlo per parti (scomponendolo).

**Formalizzazione:**
- `P` = problema
- `C(P)` = complessità di P
- `E(P)` = effort (sforzo) per la risoluzione software di P

Dati due problemi P1 e P2:
- Se `C(P1) > C(P2)` allora vale `E(P1) > E(P2)`
- `C(P1+P2) > C(P1) + C(P2)` ← vale empiricamente (la complessità combinata è maggiore della somma)

Componendo: ==`E(P1+P2) > E(P1) + E(P2)`== → conviene risolvere i sottoproblemi separatamente!

###### Ma non bisogna esagerare: la disequazione da sola è fuorviante

La formula precedente potrebbe suggerire che più si divide, meglio è — portando al limite (infiniti moduli) a effort nullo. Ma questo non tiene conto di un effetto collaterale:

**All'aumentare del numero di moduli, aumenta l'effort di integrazione.**

```
         Costo totale = Costo/modulo + Costo di integrazione
         
Cost
  ↑          \           /
  |           \    M    /   ← punto ottimale M
  |            \_______/
  |
  +------------------------→ Numero di moduli
```

> *In medio stat virtus*: esiste un **numero ottimale di moduli M** che minimizza il costo totale. Troppo pochi moduli = alta complessità interna. Troppi moduli = alta complessità di integrazione.

---

### 3. Modularità (Separation of Concerns)

La modularità è una conseguenza del principio di decomposizione, ma aggiunge un criterio qualitativo: **non basta dividere il SW in moduli, occorre farlo bene**.

> **Separation of Concerns**: teniamo separati gli aspetti "unrelated" (non correlati) di un software — ogni modulo si occupa di una sola "cosa".

Il principio di decomposizione ci dice *quanti* moduli creare; la modularità ci dice *come* dividerli.

###### Esempio: Separation of Concerns tra Dati e Presentazione

Una valida linea guida è tenere separato il SW di generazione **dati** dal SW necessario alla loro **presentazione**. Questo permette di cambiare la rappresentazione sullo schermo senza dover modificare il sistema di calcolo.

```
[Sistema di calcolo] → [Information to be displayed] → [Presentation Software] → [Display]
                                                              ↑
                                               Modulo separato (sostituibile!)
```

> Questo è alla base del pattern **Model-View-Controller (MVC)**: Model (dati), View (presentazione), Controller (logica).

###### Esempio: I Tre Livelli di una Applicazione

La struttura di un'applicazione software è spesso caratterizzata da tre livelli (separation of concerns a livello architetturale):

| Livello | Alias | Responsabilità |
|---|---|---|
| **Presentazione** | Presentation logic | Gestisce l'interazione con l'utente |
| **Logica Applicativa** | Business logic | Implementa le funzionalità e gestisce il flusso dei dati |
| **Dati e Risorse** | Data logic | Gestisce i dati che rappresentano le informazioni utilizzate |

> Questa separazione corrisponde all'architettura **Three-Tier** vista nel [[4 - Design Architetturale]].

###### Criteri per la Modularizzazione

In pratica, una buona modularizzazione si ottiene:

- ==**Massimizzare la coesione**==: ogni modulo esegue un singolo compito ben definito (**Single Responsibility Principle**)
- ==**Minimizzare l'accoppiamento**==: ridurre il numero e la complessità delle inter-connessioni fra moduli (*high coupling* = moduli difficili da modificare, testare e riusare)

**Moduli coesi e poco accoppiati sono:**
- Facili da comprendere
- Riusabili
- Semplici da modificare
- Semplici da testare

> **Analogia**: un coltellino svizzero ha tutte le funzioni in uno strumento solo → alta coesione locale ma molte interdipendenze. Il **Single Responsibility Principle** dice: ogni modulo dovrebbe avere una sola ragione per cambiare. "*Just because you can doesn't mean you should.*"

---

### 4. Information Hiding

> Ogni modulo dovrebbe **nascondere** le proprie decisioni di design interne alle altre componenti.

L'information hiding è strettamente legato all'astrazione: si espone solo l'**interfaccia** (cosa fa il modulo), nascondendo l'**implementazione** (come lo fa).

**Vantaggi:**
- Modificare l'implementazione di un modulo non impatta gli altri (finché l'interfaccia rimane la stessa)
- Riduce le dipendenze tra moduli → basso accoppiamento
- Permette di sostituire o aggiornare un modulo senza effetti a cascata

> In Java/C++, l'information hiding si realizza con modificatori di accesso (`private`, `protected`, `public`) e con il concetto di **incapsulamento** nelle classi OO.

---

### Riepilogo

```
Requirements
    │
    ▼
[High Level Design] → Architettura SW (componenti + connettori + stile)
    │
    ▼
[Low Level Design]  → Classi OO + Contratti (Design by Contract)
                    → Strutture dati + Algoritmi (PDL + stepwise refinement)
```

- Il processo di design si articola in 6 fasi, dall'architettura agli algoritmi
- Il **Design by Contract** (Meyer) specifica i contratti (pre, post, invariante) delle interfacce **prima della codifica**, assegnando responsabilità chiare a cliente e fornitore
- Gli algoritmi si progettano con notazioni come il **PDL** e si sviluppano per **stepwise refinement**
- I **principi di progettazione** (Astrazione, Decomposizione, Modularità, Information Hiding) guidano verso software di qualità: manutenibile, comprensibile, testabile, riusabile
