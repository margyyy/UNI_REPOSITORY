#set page(
  paper: "a4",
  margin: (x: 2.7cm, y: 2cm),
  numbering: "1",
  number-align: center,
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "it",
)

#set par(
  justify: true,
  leading: 0.6em,
  first-line-indent: 1.2em,
)

#set heading(numbering: "1.1")

= Domande in preparazione all'esame di Ingegneria Del Software

\

== Modelli di processo e di sviluppo software

\

1) *Che cos'è un processo di sviluppo software?* $arrow$ pag 9 

2) *Modello Code & Fix* $arrow$ pag 11

3) *Modello a cascata (Waterfall) e le sue 2 varianti* $arrow$ pag 11

4) *Che cos'è uno studio di fattibilità?* $arrow$ pag 12

5) *Come funziona il V-MODEL?* $arrow$ pag 13

6) *Modelli evolutivi - Prototipazione* $arrow$ pag 13

7) *Modello Interattivo-Incrementale* $arrow$ pag 14

8) *Modello a spirale - Che cos'è un rischio?* $arrow$ pag 14

9) *Unified Process(UP)* $arrow$ pag 15

10) *Component-Based Software Engineering (CBSE)* $arrow$ pag 16

11) *Modello trasformazionale e metodi formali* $arrow$ pag 16

12) *Approcci plan-driven e metodi agili* $arrow$ pag 17

13) *Come scegliere un modello?* $arrow$ pag 19

\

== Ingegneria dei requisiti

\

1) *Che cos'è un requisito?* $arrow$ pag 20

2) *Requisiti utente e di sistema* $arrow$ pag 21

3) *Requisiti funzionali e non funzionali* $arrow$ pag 23

\

== Use case

\

1) *Che cos'è uno use case? - Da cosa è composto? * $arrow$ pag 25 

2) *Quali sono le limitazioni nella creazione di uno use case?* $arrow$ pag 26

3) *Che cos'è uno scenario?* $arrow$ pag 27

4) *Derivazioni, ripetizioni, scenari alternativi* $arrow$ pag 29

5) *Screen mockup* $arrow$ pag 32

6) *Punti di forza e di debolezza* $arrow$ pag 32

\

== Design architetturale

\

1) *Che cos'è il design e da quali livelli è composto? (livelli di raffinamento e di riuso)* $arrow$ pag 33 

2) *Da cosa è composta l'architettura software?* $arrow$ pag 33

3) *Layered architecture* $arrow$ pag 35

4) *Repository Model* $arrow$ pag 35

5) *Client-Server Model* $arrow$ pag 36

6) *Two-tier e three-tier* $arrow$ pag 36

7) *Peer-to-peer (P2P)* $arrow$ pag 36

8) *Pipe and filter* $arrow$ pag 37

9) *Stili di controllo : Call-return, Manager Model, Broadcast* $arrow$ pag 38

10) *Esempio di architettura eterogenea* $arrow$ pag 40

11) *Microservizi* $arrow$ pag 41

\

== Design delle componenti

\

1) *Che cos'è il lowlevel design e quali sono le sue componenti?* $arrow$ pag 43

2) *Che cos'è il design by contract?* $arrow$ pag 43

3) *Quali sono le responsabilità del cliente e quali del fornitore?* $arrow$ pag 44

4) *Che tipi di notazioni vengono fatte durante la progettazione di algoritmi?* \ $arrow$      pag 46

5) *Notazione e PDL - Stepwise refinement* $arrow$ pag 46

6) *Modulo - Astrazione - Decopomposizione* $arrow$ pag 47

7) *Che cos'è la modularità e Separation of Concerns?* $arrow $pag 47

8) *Information hiding* $arrow$ pag 48

\

== Introduzione a UML

\

1) *Che cos'è UML e cosa UML non è?* $arrow$ pag 50

2) *Sketch, blueprint e linguaggio eseguibile* $arrow$ pag 50

3) *Prospettiva concettuale e prospettiva software* $arrow$ pag 50

4) *Modello di dominio* $arrow$ pag 51

5) *Notazione, meta-modello e viste* $arrow$ pag 52

6) *Modello 4+1* $arrow$ pag 52

7) *Diagrammi di UML 2.5 e diagrammi principali nel corso* $arrow$ pag 53

8) *UML nel processo di sviluppo* $arrow$ pag 54

9) *Profili UML, codice e uso pragmatico* $arrow$ pag 55

\

== Class diagram e Object diagram UML

\

1) *Che cos'è un Class Diagram? Classi, feature e relazioni* $arrow$ pag 57

2) *Notazione della classe: nome, attributi e operazioni* $arrow$ pag 57

3) *Attributi: sintassi, visibilità e molteplicità* $arrow$ pag 57

4) *Operazioni, datatype, costruttori e membri statici* $arrow$ pag 58

5) *Associazioni e molteplicità: nomi, ruoli e navigabilità* $arrow$ pag 59

6) *Attributo o associazione? Associazioni riflessive e bidirezionali* $arrow$ pag 59

7) *Object Diagram* $arrow$ pag 60

8) *Classe associativa* $arrow$ pag 60

9) *Aggregazione e composizione* $arrow$ pag 61

10) *Generalizzazione ed ereditarietà* $arrow$ pag 61

11) *Dipendenze e traduzione nel codice* $arrow$ pag 62

12) *Dalle molteplicità alle strutture dati* $arrow$ pag 62

\

== Interfacce e vincoli UML

\

1) *Interfacce fornite e richieste* $arrow$ pag 64

2) *Realizzazione di un'interfaccia e interfaccia richiesta* $arrow$ pag 64

3) *Due notazioni equivalenti per le interfacce* $arrow$ pag 65

4) *Perché usare le interfacce?* $arrow$ pag 66

5) *Vincoli nei Class Diagram* $arrow$ pag 67

6) *Object Constraint Language (OCL)* $arrow$ pag 67

\

== State Machine Diagram

\

1) *Che cos'è uno State Machine Diagram? Stato e comportamento* $arrow$ pag 68

2) *Modellazione statica e dinamica* $arrow$ pag 68

3) *Stati, transizioni e pseudo-stati* $arrow$ pag 69

4) *Eventi e run-to-completion* $arrow$ pag 69

5) *Esempio: ciclo di vita di una copia di libro* $arrow$ pag 70

6) *Attività interne: entry, exit, do e reazioni interne* $arrow$ pag 71

7) *Stati compositi e regioni ortogonali* $arrow$ pag 72

8) *Quando usare una State Machine? Forno e workflow documentale* $arrow$ pag 73

9) *Implementazione: switch, Design Pattern State e tabelle di stato* $arrow$ pag 74

\

== Sequence e Communication Diagram

\

1) *Fondamenti dei Sequence Diagram: partecipanti, lifeline e attivazioni* $arrow$ pag 75

2) *Messaggi sincroni e asincroni* $arrow$ pag 75

3) *Dal diagramma al codice* $arrow$ pag 76

4) *Ciclo di vita dei partecipanti* $arrow$ pag 77

5) *Frame di interazione: loop, opt e alt* $arrow$ pag 78

6) *Frame di interazione: par, ref e sd* $arrow$ pag 79

7) *Sequence Diagram di sistema* $arrow$ pag 80

8) *Sequence Diagram nel design: esempio del registro di cassa* $arrow$ pag 81

9) *Esempio prezzo di un ordine: soluzione centralizzata* $arrow$ pag 82

10) *Pseudocodice della soluzione centralizzata* $arrow$ pag 83

11) *Esempio prezzo di un ordine: soluzione distribuita* $arrow$ pag 84

12) *Pseudocodice della soluzione distribuita* $arrow$ pag 85

13) *Communication Diagram e linee guida* $arrow$ pag 86

\

== Activity Diagram

\

1) *Concetti fondamentali: azioni, nodi e flussi* $arrow$ pag 87

2) *Semantica dei token* $arrow$ pag 87

3) *Esempio: gestione di un ordine ed evoluzione dei token* $arrow$ pag 88

4) *Nodi di controllo: inizio, terminazione, decisione, fusione, fork e join* $arrow$ pag 89

5) *Nodo finale di flusso* $arrow$ pag 90

6) *Oggetti, pin e stati* $arrow$ pag 91

7) *Partizioni e responsabilità* $arrow$ pag 92

8) *Eventi e interruzioni: invio, ricezione e regioni interrompibili* $arrow$ pag 93

9) *Parametri e valori di ritorno: fare il bucato* $arrow$ pag 95

10) *Modellare Use Case e operazioni: ATM e authenticateUser* $arrow$ pag 96

11) *Modellare un algoritmo: ricerca binaria* $arrow$ pag 98

\

== Component, Deployment e Package Diagram

\

1) *Component Diagram: concetto di componente* $arrow$ pag 99

2) *Componenti e artefatti* $arrow$ pag 99

3) *Perché componenti e non classi? Notazione dei componenti* $arrow$ pag 100

4) *Interfacce fornite/richieste, porte e vista interna* $arrow$ pag 100

5) *Dipendenze tra componenti* $arrow$ pag 101

6) *Esempio: sistema di gestione ordini* $arrow$ pag 102

7) *Deployment Diagram: nodi, connessioni, artefatti e manifest* $arrow$ pag 103

8) *Nodi annidati e tagged value* $arrow$ pag 104

9) *Esempio officina meccanica: requisiti, architettura hardware e software* $arrow$ pag 105

10) *Integrazione Component e Deployment* $arrow$ pag 106

11) *Package Diagram: package, namespace, visibilità e dipendenze* $arrow$ pag 107

12) *Progettare i package: cicli e dipendenze entranti* $arrow$ pag 108

13) *Architettura A/B, procedura pratica e risoluzione dei cicli* $arrow$ pag 109

14) *Package: non soltanto classi* $arrow$ pag 110

\

== Software Design Pattern

\

1) *Che cos'è un Software Design Pattern e perché usarlo?* $arrow$ pag 111

2) *Panorama del riuso: librerie, framework, componenti e pattern* $arrow$ pag 111

3) *GRASP e pattern classici* $arrow$ pag 112

4) *Come si descrive un pattern?* $arrow$ pag 113

5) *Abstract Factory: dalla creazione alla fabbrica e quando usarla* $arrow$ pag 114

6) *Abstract Factory: esempio GUI multipiattaforma e conseguenze* $arrow$ pag 114

7) *Abstract Factory: struttura d'implementazione* $arrow$ pag 115

8) *Adapter: problema, scopo ed esempio del cerchio* $arrow$ pag 116

9) *Object Adapter e Class Adapter* $arrow$ pag 116

10) *Facade: ingresso semplice a un sottosistema* $arrow$ pag 117

11) *Facade: esempi, conseguenze e confronto con Adapter* $arrow$ pag 117

12) *Template Method: scheletro, passi variabili e login riusabile* $arrow$ pag 118

13) *Template Method: inversione di controllo e conseguenze* $arrow$ pag 118

14) *Observer: problema, registrazione e notifica* $arrow$ pag 119

15) *Observer: conseguenze* $arrow$ pag 120

16) *State: comportamento dipendente dallo stato e distributore automatico* $arrow$ pag 121

17) *State: implementazione con il pattern* $arrow$ pag 121

18) *State: struttura generale e conseguenze* $arrow$ pag 122

\

== Software Testing

\

1) *Terminologia attraverso il caso InvestireOK* $arrow$ pag 124

2) *Recovery, fault localization, fault removal e testing di regressione* $arrow$ pag 124

3) *Errore, fault e failure* $arrow$ pag 125

4) *Esempio reDouble e fault latente* $arrow$ pag 125

5) *Testing e debugging: SUT, oracolo e differenze* $arrow$ pag 126

6) *Perché il testing è difficile? Testing esaustivo* $arrow$ pag 127

7) *White-box e black-box* $arrow$ pag 127

8) *Test case e testsuite* $arrow$ pag 128

9) *Livelli di testing: unità, integrazione, sistema, accettazione e regressione* $arrow$ pag 129

10) *Automazione e JUnit 5* $arrow$ pag 130

11) *Perché non usare main per i test?* $arrow$ pag 130

12) *Primo caso di test JUnit: classe, metodo e asserzioni* $arrow$ pag 131

13) *Esecuzione verde/rosso, failure ed error nel test runner* $arrow$ pag 131

14) *Progettare test coesi: una cosa alla volta* $arrow$ pag 132

15) *Fixture: BeforeEach e AfterEach* $arrow$ pag 132

16) *Ciclo di vita completo: BeforeAll e AfterAll* $arrow$ pag 133

17) *Asserzioni JUnit: esecuzione, arresto e operazioni principali* $arrow$ pag 134

18) *Test parametrici* $arrow$ pag 135

\
