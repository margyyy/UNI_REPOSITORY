### Cos'è il Design?

Il design è il processo che **trasforma un problema in una soluzione**.

- I **requisiti** definiscono il *problema* (il **cosa**)
- Il **design** propone una *soluzione* (il **come**)

Analogia con la costruzione di una casa:
- Requisiti = richieste dei proprietari/utenti
- Design = progetto dell'architetto (schemi e documenti a diverso livello di dettaglio)
- Implementazione = esecuzione dei lavori (scelta dei materiali, ecc.)

> Il design definisce la **struttura** della soluzione; l'implementazione la realizza rendendola usabile.

---
### Livelli di Design

Il design si sviluppa per **raffinamento**, in due livelli principali:

1. **Architectural Design** (anche: *High-level design* o *System design*)
	- Mappa i requisiti su architettura SW e componenti/sottosistemi
	- Non siamo ancora a livello di strutture dati e algoritmi!

2. **Component Design** (anche: *Low-level design* o *Subsystem design*)
	- Fissa i dettagli dei componenti, specificando maggiormente la soluzione
	- Include scelte tecnologiche (es. platform-independent → platform-specific come .Net o J2EE)

---
### È un Processo Creativo?

Il design **non** è puramente creativo: la maggior parte del lavoro è **di routine**.

I problemi vengono risolti **riutilizzando e adattando** soluzioni a problemi simili. Esistono tre livelli di riuso:

1. **Clonazione**: si riutilizza interamente design/codice con piccoli aggiustamenti
2. **Design [[Pattern]]**: buona soluzione a un problema ricorrente (generici, usabili in domini diversi)
3. **Stili Architetturali**: architettura generica che suggerisce come decomporre il sistema (ottimizzati per un dominio specifico)

> Il design può essere migliorato studiando esempi di buon design!

![[Pasted image 20260320101347.png]]
---
### Design Architetturale

Il **design architetturale** è il processo di identificare:
- Le **(macro) componenti** di un sistema (classi, sottosistemi, moduli...)
- Il **framework per il controllo e la comunicazione** tra le componenti

Produce una descrizione dell'**architettura software**.

> Concetto introdotto da **Mary Shaw e David Garlan** nel 1996.

---
### Architettura Software

###### Vantaggi dell'avere un'architettura SW:
- **Guida lo sviluppo** e aiuta nella comprensione del sistema: realizzare componenti distinte è meno complesso che costruire un monolite
- **Supporta decisioni manageriali** (es. se rifattorizzare o meno)
- **Facilita l'analisi** di alcune proprietà (es. manutenibilità, efficienza)
- **Permette il riuso** a larga scala: l'architettura stessa può essere riutilizzata in più sistemi
- **Aiuta a ragionare sull'evoluzione** del sistema
- **Documenta il sistema** e le dipendenze tra componenti

###### Diagramma a Blocchi

Un'architettura SW è normalmente espressa mediante un **diagramma a blocchi** che mostra un *overview* della struttura del sistema:
- I **blocchi** = componenti (sottosistemi o moduli)
- I **connettori** = relazioni tra componenti (es. scambio di messaggi)

> Esistono anche linguaggi formali di specifica architetturale (es. Darwin, ADL). UML fornisce il **diagramma delle componenti**.

![[Pasted image 20260320101416.png | 1100x 600]]

---
### Architettura SW: Impatto sulle Proprietà del Sistema

L'architettura ha un **grosso impatto** sugli attributi di qualità del sistema:

| Proprietà                           | Strategia architetturale                                                  |
| ----------------------------------- | ------------------------------------------------------------------------- |
| **Performance** (tempo di risposta) | Minimizzare le comunicazioni; usare *componenti large-grain*              |
| **Security**                        | Usare architettura a livelli con risorse critiche nei livelli più interni |
| **Safety**                          | Localizzare le safety-critical features in pochi sottosistemi             |
| **Availability** (24/7)             | Includere componenti ridondanti e meccanismi di fault-tolerance           |
| **Maintainability**                 | Usare *componenti fine-grain* facilmente rimpiazzabili                    |

> ⚠️ **Trade-off inevitabili:**
> - *Large-grain* migliora performance ma riduce maintainability
> - Componenti ridondanti migliorano availability ma peggiorano safety
> - Architettura a livelli migliora security ma aumenta le comunicazioni e degrada performance

- **Large-grain**: componenti grandi che fanno molto → meno comunicazioni, meno facili da sostituire
- **Fine-grain**: componenti piccole e specifiche → più comunicazioni, più facili da sostituire

---
### Stile Architetturale

Uno **stile architetturale** è un modello generico con caratteristiche specifiche che può essere **istanziato/personalizzato**.

> Analogia: lo *chalet alpino* è un "stile architetturale" edilizio riconoscibile (legno, pietra, travi a vista, balconi...) — allo stesso modo, uno stile architetturale SW è un pattern riconoscibile e riusabile.

Uno stile è definito da:
- **Tipo di componenti** (es. procedure, filtri, livelli/strati, servizi, classi, package, sottosistemi)
- **Tipo di connettori** (es. invocazioni di procedure/metodi, pipe, eventi, scambio di messaggi)

> ⚠️ In realtà la maggioranza dei grandi sistemi reali sono **eterogenei** e non seguono un singolo stile.

![[Pasted image 20260320101531.png]]

###### Classificazione degli stili:
- **Strutturale**: contiene solo informazioni strutturali (chi parla con chi)
- **Di controllo**: contiene anche (o solo) informazioni di controllo (chi controlla chi)

---
### Stili Architetturali (panoramica)

Gli stili principali che vedremo:
- Layered (Stratificato)
- Repository
- Client/Server (Two-tier, Three-tier)
- Peer-to-Peer (P2P)
- Pipe and Filter
- Stili di controllo: Call-Return, Manager, Broadcast
- Microservices

---
### Layered (Stratificato)

Organizza il sistema in un **insieme di livelli (strati)**, ognuno dei quali fornisce un insieme di servizi.

- Un livello **usa solo i servizi del livello immediatamente inferiore**
- Ogni livello nasconde i dettagli ai livelli superiori (information hiding)

![[Pasted image 20260320101633.png]]

> Esempio classico: architettura di **Android** (Linux Kernel → Hardware Abstraction → Android Runtime → Framework → App)

![[Pasted image 20260320101641.png]]
###### Pro e Contro

| Vantaggi                                                                                 | Svantaggi                                                                                                               |
| ---------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Se cambia l'interfaccia di un livello, solo il livello adiacente ne è influenzato        | Spesso è **artificiale** strutturare il sistema in questo modo                                                          |
| **Supporta il riuso**: diverse implementazioni dello stesso livello sono intercambiabili | Può risultare **inefficiente** (pila di chiamate!) e porta a "shortcut" (si salta qualche livello, perdendo i vantaggi) |

---
### Repository Model

I **dati condivisi** sono mantenuti in un **database centrale (repository)** a cui hanno accesso tutti i sottosistemi.

- **Nessuna comunicazione diretta** tra sottosistemi (parlano tutti attraverso il repository)
- Adatto per applicazioni in cui i dati sono prodotti da un sottosistema e usati da un altro

> Esempio classico: **CASE tool** (Computer Aided Software Engineering) — tool che supportano lo sviluppo e la manutenzione del software. Usano un repository integrato per archiviare tutti gli artefatti del processo software.

![[Pasted image 20260320101703.png]]
###### Pro e Contro

| Vantaggi | Svantaggi |
|---|---|
| Modo **efficiente di condividere** grandi quantità di dati (non trasmessi esplicitamente) | I sottosistemi devono accordarsi su un **modello dei dati** unico → necessità di compromesso |
| **Gestione centralizzata** di backup, security, ecc. | **L'evoluzione dello schema** dei dati è difficile e costosa |
| | Difficile da **rendere distribuito** in modo efficiente |

---
### Client-Server Model

[[Modello]] di sistema distribuito in cui:
- I **server** forniscono servizi specifici (es. stampa, gestione file, catalogo prodotti...)
- I **client** utilizzano tali servizi
- Esiste una **rete** che permette ai client di accedere ai server

Protocollo di comunicazione: **request and response**.

![[Pasted image 20260320101735.png]]
###### Pro e Contro

| Vantaggi | Svantaggi |
|---|---|
| Possibile migliorare le performance spostando la computazione tra client e server | Mancanza di **modello dei dati condiviso** tra server → scambio dati inefficiente |
| **Supporta il riuso**: server riusabili in diverse applicazioni | **Operazioni di gestione ridondanti** nei vari server |
| **Scalabile**: si aggiungono server | I server potrebbero essere di proprietà di organizzazioni diverse (problema di gestione) |

###### Two-Tier (Due Livelli)

Tre componenti software distribuite su **due strati**:
- **Client** (chi richiede il servizio): presentation logic e/o business logic
- **Server** (chi fornisce il servizio): data logic e/o business logic

Due varianti:
- **Thin-client**: tutta la logica sul server, il client fa solo display
- **Fat-client**: logica distribuita, il client fa anche elaborazione

###### Three-Tier (Tre Livelli)

Evoluzione del Two-Tier. Gli strati di logica e gestione DB sono distribuiti su **più server**:
- **Client**: solo interfaccia utente (presentation)
- **Application server**: logica di business
- **DB server**: gestione dei dati

> ✅ Principio di buon design: separare nettamente presentazione, logica e dati.

---
### Peer-to-Peer (P2P) Model

Ogni componente (**peer**) esegue il proprio processo e gioca **allo stesso tempo** il ruolo di client e server.

- Ogni peer ha un'interfaccia che specifica i servizi **offerti** (server) e quelli **richiesti** (client)
- I peer comunicano richiedendo e offrendo servizi
- Simile a client-server, ma qui **i ruoli non sono fissi**

> Ciò che distingue un peer da un altro sono i **dati** che possiede: se un peer ha bisogno di un dato lo chiede a un altro peer.

Caratteristiche:
- I sistemi P2P **scalano bene** e sono **fault-tolerant**
- Aggiungere un peer = aggiungere nuove *capabilities* (nuovi dati)
- I dati sono **replicati** su più peer → se un nodo si disconnette non si perde (molta) informazione

> Esempi: **BitTorrent**, **eMule**, **Bitcoin**

![[Pasted image 20260320101758.png]]
---
### Pipe and Filter

- I **filtri** effettuano trasformazioni che elaborano il loro input per produrre output
- Le **pipe** sono connettori che trasmettono i dati da un filtro all'altro

```
DataSource → [Filter 1] → [Filter 2] → [Filter 3] → DataSink
```

> Esempio classico: comandi UNIX concatenati con `|`
> `cat input.txt | grep "Italy" | sort > output.txt`

![[Pasted image 20260320101838.png]]

![[Pasted image 20260320101850.png]]
![[Pasted image 20260320101904.png || 500]]


###### Pro e Contro

| Vantaggi                                                         | Svantaggi                                                                                       |
| ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| **Supporta il riuso** delle trasformazioni                       | **Non adatto per sistemi interattivi** (es. click del mouse, menu)                              |
| **Intuitivo**: si capisce il sistema come composizione di filtri | Di solito porta a sistemi **batch** — ogni filtro compie una trasformazione completa dell'input |
| **Aggiunta di nuove trasformazioni** è semplice                  | **Lavoro extra** per parsing/unparsing dei dati tra i filtri (può non essere efficiente)        |
| **Facilmente implementabile** anche con linguaggi OO             |                                                                                                 |
| **Supporta esecuzione concorrente/parallela**                    |                                                                                                 |

---
### Stili di Controllo

Esistono due categorie di stili di controllo:

1. **Controllo centralizzato**: un sottosistema ha la responsabilità generale del controllo e "avvia e ferma" gli altri
   - Call-Return Model
   - Manager Model

2. **Controllo basato su eventi**: non esiste un "controllore"; ogni sottosistema risponde ad eventi generati da altri sottosistemi
   - Broadcast Model

---
### Call-Return Model

Un sottosistema di controllo (**Main**) ha la responsabilità di gestire l'esecuzione degli altri sottosistemi.

- Il Main decide l'**ordine di esecuzione** dei sottosistemi
- Anche chiamato "*Main Program – Subroutine*"
- Il Main è il **Driver**, i sottosistemi sono le routine
[[- Modello]] **top-down**: il controllo parte dalla radice e si sposta verso il basso
- **Solo un sottosistema** (quello con il controllo) è in esecuzione alla volta
- Applicabile **solo a sistemi sequenziali**

![[Pasted image 20260320101919.png]]

---
### Manager Model

Simile al Call-Return, ma adatto a sistemi in cui i sottosistemi possono funzionare **in parallelo**.

- Una componente central detta **Manager** controlla l'avvio, la terminazione e il coordinamento degli altri processi
- Il Manager itera continuamente interrogando sensori, UI e output di processi per identificare eventi o cambi di stato
- Poi avvia i processi **attuatori** (che modificano il mondo esterno) e di computazione
- Applicabile a **sistemi concorrenti**


> Particolarmente adatto per sistemi **Real Time** (es. sistemi di controllo o guida autonoma)

> **Attuatore** = apparecchio che traduce un segnale elettrico in movimento meccanico

![[Pasted image 20260320101934.png]]

![[Pasted image 20260320101942.png]]

---
### Broadcast Model

Invece di invocare una procedura direttamente, un componente può **annunciare (broadcast) uno o più eventi**.

Come funziona:
- Un evento è inviato a **tutti i componenti** tramite un **Event Bus**
- Ogni componente **in grado di gestirlo** può farlo
- Tutti i componenti sono in ascolto; quelli interessati all'evento eseguono la procedura associata
- Un evento causa implicitamente **invocazioni di procedure in altri moduli**

> Anche conosciuto come **Event-Based** (*implicit invocation*) o **Publish-Subscribe**

> Esempio: `Sub1` invia evento `e1` → le procedure `P1` e `P3` (registrate per `e1`) vengono eseguite automaticamente

![[Pasted image 20260320101957.png]]
###### Pro e Contro

| Vantaggi | Svantaggi |
|---|---|
| **Semplice** aggiungere/togliere/sostituire componenti | I sottosistemi non sanno **se e quando** l'evento verrà gestito |
| **Semplice il riuso** di componenti (usabili in diversi sistemi) | Lo **scambio dei dati** può complicare le cose (dati passati con l'evento, o tramite un repository) |
| | Possono esserci **problemi di performance** |
| | Possono essere **difficili da testare** |

---
### Architetture Eterogenee

Nella realtà, i sistemi sono quasi sempre **eterogenei** (non seguono un unico stile architetturale puro).

Due modi di combinare stili:

1. **Modo gerarchico**: tutto il sistema segue uno stile, ma una propria componente interna adotta un altro stile
   - Es. sistema a *pipe and filter* in cui un filtro è internamente organizzato come sistema *layered*

2. **Componente mista**: una singola componente è un mix di stili
   - Es. una componente che accede a un repository ma allo stesso tempo interagisce tramite pipe con un'altra

> Esempio classico: il **compilatore** — unisce *pipe and filter* (le fasi di compilazione: lexical → syntax → semantic → code generation) con un *repository* (la symbol table condivisa tra le fasi).

![[Pasted image 20260320102017.png]]


---
### Microservices

Veloce panoramica di un moderno stile architetturale.

###### Cosa sono?

I microservizi sono un'evoluzione delle architetture **SOA** (*Service Oriented Architecture*).

Nati in contrapposizione alle applicazioni **monolite** (tutto in un unico blocco) o **multi-tier**:
- In un monolite, la divisione è per strato funzionale (UI → Business Logic → DB)
- Man mano che l'app cresce, il monolite diventa difficile da gestire

###### Proprietà di un Microservice:
- Ogni microservice è **indipendente** e si occupa di una singola funzionalità
- Ogni microservice può essere scritto in un **linguaggio di programmazione diverso**
- Comunicano tra loro tramite **API REST** (HTTP)

![[Pasted image 20260320102037.png]]
###### API Gateway

L'**API Gateway** espone un'interfaccia unificata verso i client:
- Il client chiama un unico endpoint (via internet)
- Il gateway realizza la richiesta chiamando gli `n` microservizi necessari
- Invia l'output aggregato al client

> Esempio: una richiesta di compilazione passa per un gateway che smista il lavoro a microservizi separati per Lexical Analysis, Syntax Analysis, Semantic Analysis, Code Generation

![[Pasted image 20260320102044.png]]

###### REST (Representational State Transfer)

Le applicazioni basate su REST usano **richieste HTTP** per:
- Inviare dati (creazione/aggiornamento)
- Effettuare query
- Modificare e cancellare dati

REST usa HTTP per tutte e quattro le operazioni **CRUD**:

| Operazione | HTTP Method |
|---|---|
| Create | `POST` |
| Read | `GET` |
| Update | `PUT` / `PATCH` |
| Delete | `DELETE` |

###### Pro dei Microservices:
- **Scalabilità**: si scala solo il microservice che ne ha bisogno, non l'intera app
- **Indipendenza di deployment**: ogni servizio si aggiorna/rilascia in modo autonomo
- **Fault isolation**: se un servizio cade, gli altri continuano a funzionare
- **Libertà tecnologica**: ogni team sceglie il linguaggio/framework più adatto
- Molto usati in pratica (Netflix, Amazon, Google...)

###### Contro dei Microservices:
- **Complessità distribuita**: gestire tanti servizi separati è complesso
- **Comunicazione di rete** aggiuntiva rispetto a un monolite
- **Difficile da testare** end-to-end
- **Orchestrazione e monitoring** richiedono infrastruttura dedicata (es. Docker, Kubernetes)

---
### Riepilogo

```
Requisiti → [Design Architetturale] → Architettura SW → può conformarsi a → Stile Architetturale
```

- Il design ci permette di passare dallo **spazio del problema** allo **spazio della soluzione**
- Progettare un design **non è un task puramente creativo** (è in gran parte riuso)
- High-level design → architettura e sottosistemi
- Low-level design → dettagli dei componenti
- I sistemi reali sono quasi sempre un **mix di stili architetturali**

