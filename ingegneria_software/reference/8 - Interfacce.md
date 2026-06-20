Il termine interfaccia viene usato in due modi:
- ==è l'insieme delle operazioni visibili all'esterno== degli oggetti che sono istanze di quella classe
- ==è un entità “simile” ad una classe==, ma è priva di implementazione (ha solo operazioni pubbliche)

Una o piu classi possono *fornire* un'implementazione dell'interfaccia

![[Pasted image 20260415112748.png]]

- Una classe richiede un’interfaccia se necessita di una classe che l’implementa per funzionare
---
### Esempio interfaccia - LOLLIPOP

Impiegato e Bancomat forniscono l’interfaccia Cassiere
- Operazioni ritira e deposita contante

Due modi possibili di rappresentarlo in UML
- Relazione di implementazione (realizzazione) o lollipop

![[Pasted image 20260415112829.png]]

###### Lollipop

Una notazione molto utilizzata per le interfacce è quella a “Lollipop”:
- La ‘pallina’ (lollipop) rappresenta l’interfaccia esposta/fornita da una classe
- Il ‘semicerchio’ (socket) rappresenta l’interfaccia richiesta
	-  quindi è una dipendenza

![[Pasted image 20260415112933.png]]

Esempio:
- un motore di ricerca fornisce la possibilità di accedere al proprio servizio “Cerca” tramite un’interfaccia
- La classe visualizzatore utilizza il servizio “Cerca”

---
### Perchè usare le interfacce?

Per separare l’implementazione di una classe da quella che è l’interfaccia vera e propria

![[Pasted image 20260415113100.png]]

### Regole di vincolo

Un diagramma delle classi definisce dei vincoli:

![[Pasted image 20260415113123.png]]

- Associazioni, attributi, generalizzazione sono ==costrutti base per esprimere vincoli== ma non possono bastare a rappresentarli tutti!
- UML permette di specificare ulteriori vincoli ad un class diagram usando:
	- Linguaggio naturale (o linguaggio di programmazione)
	- ==OCL (Object Constraint Language)==
		- Fa parte di UML
		- Linguaggio di specifica formale
		- Basato su logica del primo ordine