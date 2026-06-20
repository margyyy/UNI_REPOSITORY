### Introduzione ai Modelli di Processo

###### Cos'è un Processo di Sviluppo Software

> [! ] 
> L'idea di fondo dell'ingegneria del software è trattare il software come un qualsiasi altro prodotto industriale (un'automobile, un edificio, un chip elettronico), concentrandosi sul **processo di sviluppo**, in analogia con l'industria manifatturiera.

Un **processo** è definito come:

> Un insieme strutturato e organizzato di attività che si svolgono per ottenere un risultato.

In altre parole, il processo di sviluppo software descrive **quali attività** svolgere, **in che ordine** e **con quali regole**, per passare da un'idea iniziale a un prodotto software funzionante.

---

###### Perché modellare il processo

Modellare il processo di sviluppo serve a ==dare **ordine**, **controllo** e **ripetibilità**== a un'attività che altrimenti potrebbe diventare caotica e imprevedibile. Senza un modello, gli sviluppatori rischiano di procedere in modo disorganizzato, senza sapere cosa fare dopo o quanto tempo dedicare a ciascuna fase.

Come affermato da **Barry Boehm (1998)**, un modello di processo determina:
- L'**ordine delle fasi** (stages) di sviluppo
- I **criteri di transizione** da una fase all'altra
- Risponde alle domande fondamentali: *"Cosa fare dopo?"* e *"Per quanto tempo farlo?"*

I miglioramenti attesi dall'adozione di un modello di processo sono:
- Maggiore **produttività** degli sviluppatori
- Migliore **qualità** del software prodotto

Un principio fondamentale è: ==**Qualità del processo ⇒ Qualità del prodotto**==. Cioè, se il processo è ben organizzato, il prodotto finale sarà di qualità superiore.

---

### Modelli di Processo: Panoramica

###### Cos'è un modello di processo

> [! ]
> Un **modello di processo** è una visione *astratta* del processo di sviluppo. Non descrive ogni singolo dettaglio operativo, ma fornisce una struttura generale che guida il lavoro del team.

I modelli si collocano su uno spettro che va da:
- ==**Prescrittivi**== (molte regole, documenti e procedure obbligatorie)
- ==**Adattivi**== (poche regole, grande flessibilità)

###### Spettro Prescrittivo-Adattivo

I principali modelli si posizionano lungo questo spettro nel modo seguente (dal più prescrittivo al più adattivo):

| [[Modello]] | Regole/Pratiche |
|---|---|
| **RUP** (Rational Unified Process) | 120+ regole |
| **XP** (Extreme Programming) | 13 pratiche |
| **Scrum** | 9 regole |
| **Kanban** | 3 regole |
| **"Do Whatever"** | 0 regole |

**Scrum** è meno prescrittivo di **XP** perché non prescrive specifiche pratiche ingegneristiche, ma è più prescrittivo di **Kanban** perché prescrive l'uso di iterazioni e la composizione del team.

###### Attenzione alla terminologia

==Non esiste uno standard universale nella terminologia. Nomi diversi possono indicare lo **stesso modello**, e lo stesso nome può indicare **modelli diversi** a seconda dell'autore o del contesto. Occorre sempre verificare di cosa si sta parlando concretamente.==

###### Perché studiare i modelli di processo

È compito dei **manager** e dei **project manager** decidere quale modello di processo adottare, in base a:
- La **tipologia di software** da sviluppare
- Il **personale disponibile** (competenze e numero)

Si tratta di una decisione critica, con un forte impatto sulla riuscita del progetto. Richiede **esperienza** e una buona conoscenza dei diversi approcci.

---

### Prospettiva Storica

###### Evoluzione dei modelli nel tempo

L'ingegneria del software e i suoi modelli di processo hanno avuto una lunga evoluzione:

- **Prima del 1965**: Origini del software, produzione artigianale con l'approccio **Code & Fix** (scrivi codice e correggi errori)
- **1965-1985**: Periodo della cosiddetta **"crisi del software"**. Nel **1968**, alla conferenza NATO, nasce ufficialmente il termine *"Software Engineering"*
- **1955-60**: Uso pratico del modello **Waterfall** (a cascata), anche se non ancora formalizzato
- **1970**: **Winston Royce** pubblica la definizione formale del modello Waterfall
- **1975**: Cominciano a emergere i **modelli evolutivi** e la **prototipazione**
- **1985-89**: Fred Brooks pubblica *"No Silver Bullet"*, affermando che non esiste una soluzione magica ai problemi dello sviluppo software
- **1986**: Nasce il **V-Model**
- **1988**: Barry Boehm propone il **modello a Spirale**
- **Anni '90**: Emergono il **Web engineering**, il **CBSE** (Component Based Software Engineering), lo **Unified Process** (UP) e l'**Extreme Programming** (XP)
- **2000 - oggi**: Si diffondono i **metodi agili**, il **MDD** (Model Driven Development) e il **DevOps** (dal 2009)

---

### Code and Fix

>[!Descrizione ]
Il **Code and Fix** è l'approccio più primitivo allo sviluppo software. Si basa su un procedimento per tentativi, **senza** una fase di analisi o progettazione.

Il flusso di lavoro è molto semplice:
1. **Comprendi** (a grandi linee) i bisogni dell'utente
2. **Scrivi** il codice
3. **Esegui e testa** il programma
4. Se ci sono errori, **correggi** e torna al punto 3
5. **Consegna** il prodotto

###### Limiti

- È adatto solo a progetti **molto piccoli** (meno di 1500 righe di codice)
- Diventa **inadeguato** per progetti grandi o con più sviluppatori, perché senza un piano strutturato è impossibile coordinare il lavoro
- Non c'è documentazione, non c'è progettazione, non c'è controllo di qualità

---

### [[Modello]] a Cascata (Waterfall)

###### Descrizione

Il Modello a **cascata** (Waterfall) è il **primo modello storico** di processo di sviluppo software. Fu usato in pratica negli anni '50 per ==progetti di difesa negli USA==, e fu formalizzato da **Winston Royce nel 1970**.

Rappresenta il passaggio dalla produzione artigianale alla **produzione industriale** del software.

Il Modello prevede una sequenza rigida di fasi, ciascuna delle quali produce un output (un documento o artefatto) che diventa l'input della fase successiva:

1. ==**Analisi dei Requisiti**==: si raccolgono e documentano le esigenze dell'utente
2. ==**Progettazione**== (Design): si definisce l'architettura del sistema
3. ==**Implementazione**== (Codifica): si scrive il codice
4. ==**Verifica**== (Testing): si verifica che il software funzioni correttamente
5. ==**Manutenzione**==: si correggono bug e si apportano modifiche dopo il rilascio

###### Le cinque regole di Royce

Royce, nel suo articolo originale, stabilì cinque regole fondamentali:
1. **Progetta** il programma completo prima dell'analisi e della codifica
2. La **documentazione** deve essere sempre aggiornata e completa
3. Se possibile, **"fai il lavoro due volte"**: cioè realizza prima un prototipo per validare le idee
4. Il **testing** deve essere pianificato e monitorato fin dall'inizio
5. **Coinvolgi il cliente** nel processo

###### Pregi

- Pone grande enfasi sull'**analisi** e sulla **progettazione** prima di scrivere codice
- Introduce **disciplina** e **pianificazione** nel processo
- Funziona bene quando i **requisiti sono stabili** e ben definiti fin dall'inizio

###### Difetti

- È un modello **rigido** e ==**monolitico**==: non prevede parallelismo tra le fasi
- Prevede un'**unica consegna finale** al termine di tutto il processo, con il rischio che il software sia già obsoleto quando viene consegnato
- Se i requisiti cambiano durante lo sviluppo, è molto costoso tornare indietro
- Tende a produrre troppa **documentazione** (spesso poco chiara per il cliente)

---

### Studio di Fattibilità

###### Descrizione

==Lo **studio di fattibilità** è una fase preliminare che precede l'avvio vero e proprio del progetto. Il suo scopo è rispondere alla domanda: **"Conviene procedere?"** (decisione Go/No-go).==

Si valutano:
- I **costi** previsti per lo sviluppo
- ==Il **ROI** (Return on Investment)==, cioè il ritorno economico atteso
- La **convenienza** tra acquistare un prodotto già esistente (personalizzandolo) oppure svilupparne uno nuovo *"from scratch"* (da zero)

---

### Varianti del Waterfall

###### Cascata con prototipazione

In questa variante, prima di avviare il processo di sviluppo completo, si realizza un **prototipo "usa e getta"**. Il prototipo serve a comprendere meglio i requisiti e a validare le scelte con il cliente, dopodiché viene scartato e si procede con lo sviluppo regolare.

###### Cascata con feedback e iterazioni

In questa variante, [[3 - Il Modello]] a cascata viene reso meno rigido permettendo di **tornare indietro** a fasi precedenti quando si scoprono problemi. Ad esempio, se durante la codifica si scoprono problemi di progettazione, si torna alla fase di design per correggerli prima di proseguire.

---

### V-Model

###### Descrizione

Il **V-Model** è una variante del modello a cascata che ==pone grande enfasi sul **testing**==. Il suo nome deriva dalla forma a "V" del diagramma che lo rappresenta.

L'idea centrale è che ad ogni fase di analisi e progettazione corrisponde una fase di testing specifica:

| Fase di Analisi/Design                       | Fase di Testing corrispondente                                                      |
| -------------------------------------------- | ----------------------------------------------------------------------------------- |
| Analisi dei Requisiti                        | **Acceptance Testing** (test di accettazione con il cliente)                        |
| High Level Design (progetto ad alto livello) | **System Testing** (test del sistema completo)                                      |
| Detailed Design (progetto di dettaglio)      | **Unit & Integration Testing** (test delle singole unità e della loro integrazione) |
![[Pasted image 20260311142611.png]]

Al centro della "V" si trova la fase di **Coding** (implementazione).

Questo modello garantisce che ogni aspetto del progetto venga verificato *al livello appropriato*, collegando esplicitamente la pianificazione dei test alla fase di analisi/progettazione che li genera.

###### Problemi del Waterfall e del V-Model

- ==I requisiti reali raramente si possono **"congelare"**: cambiano durante lo sviluppo==
- ==Il cliente vede il prodotto **funzionante solo alla fine** del processo==
- Gli errori commessi nelle fasi iniziali possono avere **conseguenze disastrose** e costose
- Questi limiti hanno portato alla necessità di **modelli evolutivi** più flessibili

---

### Modelli Evolutivi

>[!Idea di base ]
I modelli evolutivi partono da un'idea fondamentale: anziché sviluppare tutto il software in un'unica soluzione, si procede per **approssimazioni successive**:
>
>1. Si parte da una **implementazione iniziale** (parziale)
>2. La si **espone agli utenti** per raccogliere feedback
>3. Si **raffina** il software in **release successive**, migliorandolo a ogni ciclo

I principali approcci evolutivi sono:
- **Prototipazione**
- **Approccio Incrementale**
- **Approccio Iterativo**

---

### Prototipazione

###### Descrizione

La **prototipazione** consiste nel realizzare un prototipo funzionante del software, che può essere di due tipi:
- **"Usa e getta"** (throwaway): il prototipo viene eliminato dopo essere servito a comprendere i requisiti
- **Evolutivo**: il prototipo viene progressivamente migliorato fino a diventare il prodotto finale

Il prototipo tipicamente ha:
- **Meno funzionalità** del prodotto finale (in quantità e/o qualità)
- È **meno efficiente** (prestazioni non ottimali)
- Viene spesso scritto in **linguaggi di alto livello** per velocizzare lo sviluppo

Il flusso del processo è:
1. Raccolta dei **Requisiti**
2. **Quick Design** (progettazione rapida)
3. **Sviluppo del prototipo**
4. **Valutazione** da parte del cliente
5. **Raffinamento** sulla base del feedback
6. Realizzazione del **prodotto finale**

###### Vantaggi

- Permette di **raffinare requisiti vaghi** o incompleti
- Aiuta a **rilevare errori precocemente**, prima di investire risorse nel prodotto definitivo
- Facilita la comunicazione con il cliente

###### Svantaggi

- **Problema economico**: può essere costoso sviluppare un prototipo per poi buttarlo
- **Problema psicologico**: il cliente potrebbe non accettare di "buttare" qualcosa che funziona, o il team potrebbe resistere a riscrivere codice già funzionante
- Rischio di **integrare scelte non ideali** fatte nel prototipo nel prodotto finale

###### Cosa prototipizzare?

Si dovrebbero prototipizzare le parti del sistema con **requisiti dubbi o vaghi**, dove l'incertezza è maggiore e il feedback del cliente è più necessario.

---

### Modelli Iterativi-Incrementali

>[! Descrizione]
I modelli **iterativi-incrementali** prevedono lo sviluppo del software in **varie release** successive. Ogni release viene rilasciata, usata e valutata dagli utenti, e il feedback ottenuto guida lo sviluppo della release successiva.

Il ciclo di lavoro per ogni release è:
1. **Pianificazione**
2. **Analisi** dei requisiti
3. **Progettazione**
4. **Implementazione**
5. **Testing**
6. **Rilascio** e **Valutazione** con gli utenti
7. Si riparte dal punto 1 per la release successiva

Un aspetto importante è che gli ==**sviluppatori costruiscono una nuova release**== mentre gli ==**utenti usano la release precedente**==, permettendo un flusso di lavoro parallelo.

---

### [[Modello]] Incrementale

###### Descrizione

Nel modello **incrementale**, ogni nuova release **aggiunge nuove funzionalità** a quelle già presenti. Le funzionalità delle release precedenti restano invariate, e se ne aggiungono di nuove.

###### Esempio: Word Processor

Per chiarire il concetto, immaginiamo di sviluppare un word processor con tre funzionalità:
1. Creazione del testo
2. Copia e incolla
3. Formattazione del testo

Con Il Modello incrementale:
- **Release 1**: Solo creazione del testo
- **Release 2**: Creazione del testo + Copia e incolla
- **Release 3**: Creazione del testo + Copia e incolla + Formattazione

Ogni release è un prodotto **utilizzabile**, anche se con funzionalità limitate.

---
### [[Modello]] Iterativo

###### Descrizione

Nel modello **iterativo**, **tutte le funzionalità** sono presenti fin dalla prima release, ma vengono **raffinate e migliorate** nel tempo. A differenza del modello incrementale, non si aggiungono nuove funzionalità, ma si perfezionano quelle esistenti.

###### Esempio: Word Processor

Con [[3 - Il Modello]] iterativo:
- **Release 1**: Tutte le funzionalità presenti, ma con un'interfaccia a riga di comando
- **Release 2**: Tutte le funzionalità con un'interfaccia grafica (ma ancora lenta e poco ottimizzata)
- **Release 3**: Sistema finale completamente ottimizzato, con interfaccia grafica fluida

###### Pianificazione delle release

Le strategie per decidere **cosa sviluppare** nella prossima iterazione sono:
1. Dare priorità alle funzionalità ad **alto rischio** (quelle più difficili o incerte)
2. Dare priorità alle funzionalità a **massimo valore** per l'utente (quelle che portano maggior beneficio)

###### Vantaggi dei modelli iterativi-incrementali

- **Risposta rapida al mercato**: le prime release possono essere consegnate velocemente
- **Feedback continuo** degli utenti, che permette di correggere la rotta
- **Previsione delle risorse** più semplice, perché ogni iterazione è piccola e più facile da stimare
- **Rilevamento errori precoce**: gli errori vengono scoperti prima, quando correggerli è meno costoso

---

### [[Modello]] a Spirale

###### Descrizione

Il **modello a spirale**, proposto da **Barry Boehm nel 1988**, è un approccio più realistico per lo sviluppo di **sistemi grandi e complessi**.

La caratteristica principale è che è un modello ==**"risk driven"** (guidato dal rischio)==: ogni decisione viene presa sulla base di un'attenta **analisi dei rischi**.

[[3 - Il Modello]] a spirale è anche un **meta-modello**, ovvero un modello che può essere *istanziato* utilizzando altri modelli (come il Waterfall o la prototipazione) nella sua fase di Engineering.

###### Definizione di rischio

==Un **rischio** è una circostanza sfavorevole che può pregiudicare lo sviluppo del progetto o la qualità del prodotto finale.==

Esempi di rischi:
- **Tecnologia non matura**: uso di strumenti o framework non ancora stabili
- **Componenti esterni difettosi**: dipendenza da librerie o servizi di terze parti non affidabili
- **Personale inadatto**: team con competenze insufficienti per il progetto

La **valutazione di un rischio** si calcola come:

> **Gravità delle conseguenze × Probabilità che il rischio si verifichi**

###### Le quattro fasi (quadranti) della Spirale

[[3 - Il Modello]] a spirale è organizzato in **quattro quadranti** che vengono percorsi ripetutamente (in senso orario, come una spirale che si allarga):

1. ==**Planning (Pianificazione)**:== Si definiscono gli obiettivi della corrente iterazione, le alternative possibili (ad esempio: comprare un componente vs. svilupparlo) e i vincoli (tempi, budget, risorse)

2. ==**Risk Analysis (Analisi dei Rischi)**:== Si identificano i rischi associati alle alternative e si cercano le soluzioni per mitigarli. In questa fase si prende la decisione **"Go/No-go"**: se i rischi sono troppo alti, il progetto può essere fermato

3. ==**Engineering (Sviluppo)**:== Si procede allo sviluppo effettivo del prodotto per il livello corrente, scegliendo [[3 - Il Modello]] di processo più adatto (Waterfall, prototipazione, ecc.)

4. ==**Customer Evaluation (Valutazione del Cliente)**:== I risultati vengono presentati al cliente per una revisione e un feedback

Ad ogni giro della spirale, il prodotto diventa più completo e maturo.

###### Vantaggi

- Particolarmente adatto a **sistemi complessi** e di grandi dimensioni
- L'approccio **focalizzato sul rischio** permette di affrontare i problemi più critici per primi

###### Svantaggi

- Richiede un'**alta competenza** nella stima e nella gestione dei rischi
- Non è una "panacea" (soluzione universale): **se un rischio importante sfugge** all'analisi, il progetto può comunque fallire

---

### Unified Process (UP)

###### Descrizione

Lo **Unified Process** (UP), conosciuto anche nella sua versione commerciale come **RUP** (Rational Unified Process), è un processo di sviluppo nato dall'unificazione dei metodi di **Grady Booch**, **James Rumbaugh** e **Ivar Jacobson** (i cosiddetti *"tres amigos"* che crearono UML).

Le caratteristiche principali di UP sono:
- È uno sviluppo **a oggetti** (Object-Oriented)
- È guidato dagli **[[Use Case]]** (casi d'uso)
- Utilizza la notazione **UML** (Unified Modeling Language)
- È ispirato al modello a spirale (fasi successive, gestione dei rischi)
- È un processo **"plan-driven"** per eccellenza (molto strutturato e documentato)

![[Pasted image 20260311150452.png]]
###### Le quattro fasi di UP

UP organizza lo sviluppo in **quattro fasi** principali, ciascuna delle quali contiene più **iterazioni**. Ogni iterazione termina con una **milestone** (punto di controllo):

1. ==**Inception (Avvio)**:== Studio di fattibilità, raccolta dei requisiti essenziali, analisi dei rischi principali. Si risponde alla domanda: *"Il progetto ha senso?"*

2. ==**Elaboration (Elaborazione)**:== Comprensione approfondita del dominio applicativo, definizione dettagliata degli [[Use Case]], definizione dell'architettura del sistema. Si risponde alla domanda: *"Sappiamo cosa costruire e come?"*

3. ==**Construction (Costruzione)**:== Design di dettaglio, codifica, testing. È la fase in cui si produce la maggior parte del codice. Si risponde alla domanda: *"Il software funziona?"*

4. ==**Transition (Transizione)**==: Deploy (rilascio in produzione), training degli utenti, test di accettazione. Si risponde alla domanda: *"Gli utenti riescono a usarlo?"*

###### Struttura delle iterazioni

Ogni iterazione all'interno di una fase comprende le seguenti attività:
- **R** – Requisiti
- **A** – Analisi
- **D** – Design
- **C** – Codifica
- **T** – Testing

L'intensità di ciascuna attività varia a seconda della fase in cui ci si trova. Ad esempio, nella fase di Inception si lavora molto sui requisiti e poco sulla codifica, mentre nella fase di Construction avviene il contrario.

---

### Sviluppo Basato sui Componenti (CBSE)

###### Descrizione

Il **Component-Based Software Engineering** (CBSE) si basa sull'idea di costruire software componendo **componenti preconfezionati** (già sviluppati e testati), come se fossero mattoncini LEGO. I componenti possono essere acquisiti da **marketplace** o store di componenti software.

![[Pasted image 20260311150621.png]]
###### Processo CBSE

Il flusso di lavoro è il seguente:d
1. **Raccolta dei Requisiti**
2. **Analisi dei componenti** disponibili (si cercano componenti già esistenti che possano soddisfare i requisiti)
3. **Modifica dei requisiti**: i requisiti vengono adattati per renderli compatibili con i componenti trovati (questo punto è cruciale)
4. **Design con riuso**: la progettazione tiene conto dei componenti scelti
5. **Sviluppo e Integrazione**: si sviluppano le parti mancanti e si integrano con i componenti
6. **Validazione**: si verifica che il sistema integrato funzioni correttamente

###### Vantaggi

- Si scrive **meno codice** (perché si riutilizzano componenti esistenti)
- Potenziale **riduzione dei costi** e dei **rischi** (i componenti sono già testati)

> ⚠️ **Nota**: questi vantaggi non sono sempre confermati dagli studi empirici.

###### Svantaggi

- Necessità di **compromessi sui requisiti**: bisogna adattare ciò che si vuole a ciò che è disponibile, e convincere il cliente ad accettare le modifiche
- L'**integrazione** di componenti diversi può essere difficile e problematica
- L'**evoluzione dei componenti** è fuori dal controllo del team: un componente esterno può cambiare, essere dismesso, o diventare incompatibile

---

### [[Modello]] Trasformazionale (Metodi Formali)

###### Descrizione

Il **modello trasformazionale** si basa sui **metodi formali**, cioè sull'uso di notazioni matematiche (come il linguaggio **Z**) per descrivere il software in modo rigoroso e non ambiguo.

Il processo segue una catena di trasformazioni formali:
1. **Requisiti informali** (in linguaggio naturale)
2. **Specifiche formali** (in notazione matematica)
3. **Specifiche di basso livello** (più vicine al codice)
4. **Codice** eseguibile

Ogni passaggio può essere dimostrato **matematicamente corretto**, garantendo (in teoria) l'assenza di errori.

![[Pasted image 20260311151555.png | 200]]


> 💡 [[3 - Il Modello]] trasformazionale è considerato l'**antenato** del moderno **MDD** (Model Driven Development), dove i modelli vengono utilizzati per generare automaticamente parte del codice.

---

### Plan-Driven vs. Metodi Agili

###### Approcci Plan-Driven (Prescrittivi)

Gli approcci **plan-driven** (guidati dal piano) rappresentano l'ingegneria classica del software. Si basano su **processi definiti**, con documentazione completa e controllo di qualità rigoroso.

Esempi: Waterfall, V-Model, Spirale, UP/RUP.

Caratteristiche:
- **Documentazione** completa e dettagliata
- Focus sulla **qualità del processo**
- Pianificazione anticipata di tutte le fasi
- Adatti a progetti con requisiti stabili e ben definiti

###### Approcci Agili (Adattativi)

Gli approcci **agili** nascono come reazione alla rigidità dei metodi plan-driven. Puntano sulla **velocità di risposta al cambiamento** e sulla **soddisfazione del cliente**.

Esempi: XP (Extreme Programming), Scrum.

Caratteristiche:
- Lo sviluppo software viene visto come un'attività in parte **"artigianale"** (arte)
- La **soddisfazione del cliente** è più importante del rispetto formale del contratto
- Si producono meno documenti, privilegiando il **software funzionante**
- Grande adattabilità ai cambiamenti dei requisiti

---

### Ingredienti dei Metodi Agili (XP)

###### Pratiche principali

L'**Extreme Programming** (XP) è uno dei metodi agili più noti e introduce una serie di pratiche specifiche:

- **Cicli rapidi**: iterazioni brevi di **2-4 settimane**, al termine delle quali si rilascia software funzionante
- **Progettazione semplice**: si segue il principio **KISS** (*Keep It Simple, Stupid*) — si progetta solo ciò che serve *adesso*, senza anticipare esigenze future
- **Refactoring**: si ristruttura continuamente il codice per migliorarne la qualità interna, senza modificarne il comportamento esterno
- **Meeting giornalieri**: brevi riunioni quotidiane (**Stand-up meeting**) per coordinare il lavoro del team
- **Conoscenza tacita**: la conoscenza del progetto risiede nel team, non nei documenti. Si produce meno documentazione formale
- **Co-location (Cliente on-site)**: il cliente lavora fisicamente nello stesso spazio del team di sviluppo, per fornire feedback immediato e continuo

### Problemi dei Metodi Agili

###### Limiti e criticità

Nonostante i vantaggi, i metodi agili presentano diversi problemi:

**Problemi gestionali**:
- Forte **dipendenza da sviluppatori bravi** e motivati: il metodo funziona bene con team esperti, ma soffre con team meno competenti
- Problemi in caso di **alto turnover** (ricambio del personale): la conoscenza tacita se ne va con le persone

**Problemi legali**:
- È difficile stipulare **contratti** senza un piano fisso e una definizione precisa dell'ambito del progetto
- Il cliente potrebbe avere difficoltà ad accettare un approccio dove il risultato finale non è predeterminato

**Problemi di manutenzione**:
- La **scarsa documentazione** rende difficile la manutenzione del software nel lungo periodo
- L'**architettura** tende ad evolversi in modo "casuale" e non strutturato (perché non viene progettata completamente in anticipo)

---

### Come Scegliere il [[Modello]] Giusto

###### Criteri di scelta

La scelta tra un approccio plan-driven e uno agile dipende da diversi fattori:

**Quando usare un approccio Plan-Driven**:
- Sistemi **grandi e complessi** con molti sviluppatori
- Sistemi **safety-critical** (dove la sicurezza è fondamentale, come una centrale nucleare o un sistema di controllo del traffico aereo)
- Requisiti **stabili** e ben definiti fin dall'inizio
- Team distribuiti geograficamente

**Quando usare un approccio Agile**:
- **Team piccoli** e co-locati (nello stesso ufficio)
- Requisiti **volatili** (che cambiano spesso)
- Utenti **disponibili** a dare feedback frequente e a collaborare attivamente
- Tempi di consegna **rapidi** (ad esempio, sviluppo di web app o app mobile)

---

### Riepilogo dei Modelli

###### Mappa concettuale

I principali modelli di processo di sviluppo software si possono raggruppare nelle seguenti categorie:

- **Approccio primitivo**: Code & Fix
- **Modelli sequenziali**: Cascata (Waterfall), V-Model
- **Modelli evolutivi**: Prototipazione, Incrementale, Iterativo
- **[[Modello]] risk-driven**: Spirale
- **Processo unificato**: UP / RUP
- **Sviluppo basato su componenti**: CBSE
- **Metodi formali**: [[Modello]] Trasformazionale
- **Metodi agili**: XP, Scrum, Kanban

Ogni modello ha i suoi punti di forza e di debolezza. **Non esiste un modello universalmente migliore**: la scelta dipende sempre dal contesto specifico del progetto, dal team e dai requisiti.
