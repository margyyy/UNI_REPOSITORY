Proposti da Ivar Jacobson nel 1992, è una tenicna per:
- esprimere requisiti funzionali di un sistema
- descrivere dal punto di vista di chi lo usa (senza guardare come è fatto) un sistema

sono sistemi di vario genere, come:
- organizzativo complesso (es. porto o banca)
- quello software/hardware da sviluppare
- anche una componente/un sottosistema

> Totalmente indipendente dal mondo OO (e da UML)

> Tecnica non visuale! solo testo

> Use Case diagram (UML) invece è visuale

Gli Use Case esprimono i requisiti funzionali di un sistema dal punto di vista dell’utente

![[Pasted image 20260320075345.png]]

---
### Requisiti 

###### Requisiti (funzionale)
descrive una funzionalità, o aspetto di dettaglio di una funzionalità, richiesta dal committente o da altri stakeholder del sistema

==Punto di vista del sistema:==
- Es. Il sistema garantisce l’accesso al sistema se username e password fornite dall’utente sono corrette

==Caso d'uso (Punto di vista dell’utente):==
- “storia” che descrive una modalità di utilizzo del sistema da parte di un utilizzatore

![[Pasted image 20260320075532.png]]

---
### Composizione

1) ==Attori==: I ruoli assunti dalle entità (persone, sistemi hardware/software, dispositivi) che interagiscono con il sistema
2) ==Use case==: quello che gli attori possono fare con il sistema
3) ==Relazioni==: tra gli attori e gli use case (indica partecipazione!)
4) ==Confini del sistema==: un rettangolo disegnato intorno agli use case per indicare i confini del sistema

![[Pasted image 20260320075740.png | 200]] ![[Pasted image 20260320075910.png | 500]] 

---
### Limiti del sistema

Quando si vuole costruire un sistema la prima cosa da fare è stabilire i suoi limiti/confini:
- Cosa fa parte del sistema (dentro i confini) e cosa no (fuori dai confini)

Il posizionamento del confine ha un grosso impatto sui requisiti funzionali

Molti problemi a progetti sono sorti proprio a causa di un confine non ben definito:
- Bisogna chiarire ciò che già esiste all’esterno del sistema (ad esempio altri sistemi) e cosa deve essere svolto dal sistema che vogliamo sviluppare!!!

---
### Attori

Gli attori rappresentano chi/cosa interagisce con il sistema

> Un attore rappresenta un ruolo che un entità esterna “recita” interagendo con il sistema

Es. un utente, un congegno hardware (es. sensore) o un altro sistema

Un ruolo è come un cappello che una persona indossa in un contesto particolare:
- Non confondere un ruolo con la cosa stessa!!!
- Es. Attore utente: molte persone possono giocare quel ruolo (filippo, gianni, gigi) ma possono anche ricoprirne altri. Ad esempio filippo potrebbe essere anche amministratore del sistema

###### Categorie di Attori:

1) Primari:
	- chi ha delle mire sul sistema
	- chi guadagna qualcosa dal sistema
2) Secondari:
	- quelli su cui il sistema ha delle mire
	- chi produce qualcosa (o offre un servizio) per il sistema

![[Pasted image 20260320080313.png]]

---
### Scenario

Uno scenario è una sequenza ordinata di interazioni tra un sistema e gli attori:
- Sequenza ordinata di msg

>Rappresenta una particolare esecuzione di uno use case (istanza), e rappresenta un singolo cammino dello use case

Gli scenari sono utili poiché:
- È più facile partire con scenari (concreti) e poi generalizzare (e quindi definire lo use case)
- Sono usati per il testing

![[Pasted image 20260320080417.png]]

---
### Descrivere uno Use Case

Uno Use Case è un insieme di scenari che hanno in comune lo scopo finale dell’utente
- Esempio: prelevare contante
Relazione tra use case e scenario:
- Uno scenario rappresenta un singolo cammino attraverso lo use case

![[Pasted image 20260320080549.png]]

###### Struttura:

Gli use case in genere sono dati come testo strutturato:
- Form/Template

> I passi di uno use case sono testo facile da capire

Viene usato il vocabolario del dominio dell’applicazione:
- Il cliente deve essere in grado di comprenderli

Gli use case sono descrizioni chiare, precise, generali, e indipendenti dalle tecnologie

![[Pasted image 20260320080722.png | 500]]

###### Scenari di uno Use Case

![[Pasted image 20260320080809.png]]

---
### Use Case Template

![[Pasted image 20260320080835.png]]

---
### Passi di uno Scenario

Uno scenario è costituito da un elenco di passi che devono essere:
- **Concisi**
- **Numerati**
- **Ordinati temporalmente**

Il formato standard di un passo è:
```
<numero> Il <qualcosa/qualcuno> <qualche azione>
```

Ogni passo descrive un'azione compiuta dal sistema oppure da un attore.

---
### Deviazioni e Ripetizioni

Si ha una **deviazione** ogni volta che ci si allontana dallo scenario principale.

###### Deviazioni Semplici
Usare `se` / `altrimenti` all'interno della sequenza principale: bastano pochi passi condizionali inline.

###### Deviazioni Complesse
Si scrivono come **sequenze degli eventi alternative** separate (di solito rappresentano errori o casi particolari che non ritornano sullo scenario principale).

###### Ripetizioni all'interno di una sequenza
Si usano le parole chiave:
- `Per` — iterazione su un insieme (for-each)
- `Fintantochè` — iterazione condizionata (while)

###### Esempio — Uso del `Se-Altrimenti`

```
Caso d'uso: TrovaLibro
Id: 6
Breve descrizione: il cliente ricerca un libro nella biblioteca on-line
Attori primari: Cliente
Attori secondari: nessuno
Precondizioni: nessuna (o autenticazione effettuata)

Sequenza degli eventi principale:
1. Il cliente seleziona la funzionalità "trova libro"
2. Il sistema chiede al cliente i criteri di ricerca (cosa cercare)
3. Il cliente inserisce i criteri di ricerca e conferma
4. Il sistema ricerca i libri che corrispondono ai criteri di ricerca
5. Se il sistema trova uno o più libri
   5.1 Il sistema mostra l'elenco dei libri
6. Altrimenti
   6.1 Il sistema comunica che non sono stati trovati libri

Postcondizioni: nessuna
Sequenza degli eventi alternativa: nessuna
```

###### Esempio — Uso del `Per`

```
5. Se il sistema trova uno o più libri
   5.1 Per ogni libro trovato
       5.1.1 Il sistema mostra l'immagine del libro
       5.1.2 Il sistema mostra le caratteristiche del libro
       5.1.3 Il sistema mostra il prezzo
```

###### Esempio — Uso del `Fintantochè`

```
4. Fintantochè i criteri di ricerca non sono validi
   4.1 Il sistema chiede di ri-inserire i criteri
   4.2 Il cliente inserisce i criteri di ricerca
   4.3 Il sistema valida i criteri inseriti
```

---
### Scenari Alternativi

Gli scenari alternativi sono di solito documentati **a parte** per semplificare il use case principale.

Nel campo `Sequenza degli eventi alternativa` dello use case principale si elencano solo i **nomi** degli scenari alternativi (es. `IndirizzoPostaElettronicaNonValido`, `ParolaChiaveNonValida`, `Annulla`).

###### Struttura di uno Scenario Alternativo

Ogni scenario alternativo ha a sua volta un proprio **template** con:
- **Id**: derivato dall'Id del use case principale (es. `9.1`, `9.2`…)
- **Breve descrizione**
- **Attori primari / secondari**
- **Precondizioni**: specificano il punto da cui parte la deviazione
- **Sequenza degli eventi principale**: descrive cosa succede nella deviazione
- **Postcondizioni**

Il primo passo della sequenza alternativa specifica **dove** si innesta rispetto allo use case principale:
- *"La sequenza degli eventi alternativa inizia **dopo il passo X** della sequenza degli eventi principale"* — si attiva solo in quel punto
- *"La sequenza degli eventi alternativa inizia **in qualunque momento**"* — si attiva in qualsiasi istante (es. tasto "Annulla")

> Lo scenario alternativo specifica la sua "relazione" con lo use case principale tramite Id e il punto di innesto.

---
### Gerarchie di Attori

È possibile definire **gerarchie** tra attori tramite **generalizzazione/specializzazione**.

- Un attore "figlio" **eredita tutte le relazioni** dell'attore "genitore"
- Utile per rappresentare ruoli più specifici senza duplicare le associazioni

> Es. `Cliente` e `Agente` sono specializzazioni di `Acquirente`: entrambi ereditano automaticamente tutte le relazioni di `Acquirente`.

---
### Relazioni tra Use Case

Le relazioni tra use case permettono di strutturare e riutilizzare i casi d'uso. Ne esistono tre tipi:

#### 1. Inclusione (`<<include>>`)

Serve per:
- **Decomporre** uno use case complicato in parti più semplici
- Isolare **comportamento comune** a più use case

Come funziona:
- Lo use case **principale** esegue i propri passi fino al punto di inclusione, poi passa il controllo allo use case **incluso**
- Alla fine il controllo **ritorna** allo use case principale
- Assomiglia al concetto di **procedura/funzione/macro**

> **Importante:** Lo use case principale **senza** lo use case incluso risulta **incompleto**.
> Lo use case incluso può essere completo (e quindi istanziabile da solo) oppure essere solo un frammento.

![[Pasted image 20260320081500.png]]

![[Pasted image 20260320081511.png]]

#### 2. Estensione (`<<extend>>`)

Serve per **estendere il comportamento** di uno use case con comportamento **opzionale**.

Caratteristiche:
- Lo use case **base** definisce uno o più **extension point** ma non conosce il comportamento dell'estensione
- Lo use case base è **completo anche senza** l'estensione
- Lo use case di estensione è solitamente **incompleto** da solo (dipende dal base)
- I passi di estensione vengono "inseriti" nel punto di estensione (extension point) del base

> La differenza chiave con `include`: in `include` il principale **dipende sempre** dall'incluso; in `extend` il base è **indipendente** e l'estensione è opzionale.

![[Pasted image 20260320081521.png]]
#### 3. Generalizzazione / Specializzazione

Gli use case specializzati (**figli**) rappresentano varianti più specifiche dello use case generalizzato (**genitore**), da cui ereditano.

I figli possono:
- **Ereditare** i passi del genitore as-is (stessa numerazione, marcati con l'id originale tra parentesi)
- **Aggiungere** nuovi passi
- **Ridefinire (override)** i passi ereditati

> ⚠️ La rappresentazione dei passi modificati/aggiunti/ereditati usa convenzioni di numerazione (es. il passo `(o4.)` indica override del passo 4 del genitore). Questa notazione può risultare poco chiara per i non esperti (es. stakeholder).

![[Pasted image 20260320081611.png]]

---
### Screen Mockup

Spesso gli use case sono **completati da Screen Mockup** (sketch dell'interfaccia utente) per chiarirne il comportamento.

Sono utili:
- Durante la **negoziazione con il cliente**
- Per lo **sviluppatore**
- Per **specificare l'UI**

Sono disegni che mostrano l'interfaccia utente **a un certo passo** dello use case. Possono essere prodotti su carta o con tool specifici (**GUI prototyping tools**).

> ⚠️ A fronte di una migliore comprensione, c'è un effort nel produrli.

###### Risultati sperimentali
Usare screen mockup:
- Migliora la comprensione degli use case del **+69%**
- Migliora l'efficienza nell'esecuzione di task di comprensione del **+89%**

###### Tool consigliato: Pencil
**Pencil** (https://pencil.evolus.vn/) è uno strumento free e open-source per creare screen mockup, con stencil per Desktop, Web e Mobile.

> **Stencil** = rappresentazione grafica di un widget dell'interfaccia

---
### Consigli su Come Scrivere gli Use Case

- **Mantenere gli use case brevi e semplici**: lo scenario principale non deve superare una pagina A4
- **Non troppo astratti, non troppo dettagliati**
- **Non usarli per descrivere funzionalità interne** del sistema: gli use case descrivono l'interazione, non l'implementazione
- **Usare `extend` e `generalizzazione` solo quando semplificano** [[3 - Il Modello]], non per forza
- **Ricordarsi che gli use case sono letti da umani!**
- **Non confondere il "cosa" con il "come"**:
  - ❌ Sbagliato: `5. Il cliente preme il pulsante OK` (scelta di design!)
  - ✅ Giusto: `4. Il sistema chiede al cliente di confermare l'ordine`
- **Evitare la decomposizione funzionale**: non creare use case di alto livello solo per poi dividerli in livelli inferiori — i livelli alti risultano troppo astratti e non aggiungono valore. Solo i livelli più bassi sono significativi.

---
### Conclusioni

- Gli use case sono un **potente mezzo per esprimere i requisiti funzionali** di un sistema
- Sono **utilizzati in pratica** (in particolare per sistemi informativi/gestionali) e sono parte della metodologia **Unified Process (UP)**
- Diversi template disponibili (più o meno formali, ma pressoché equivalenti)

###### Usi degli Use Case nel ciclo di sviluppo:
- **Starting point** per il design
- **Aiuto** per pianificare i rilasci
- **Guida** per il software testing

###### Limiti:
- Sono **poco adatti** in sistemi dominati da **requisiti non funzionali**, sistemi con **algoritmi complessi** e poveri di interazione utente
- Es. sistemi embedded (no GUI → no use case)