### Che cos'è un requisito?

- descrive qualosa he il sistema deve fare o un vincolo che deve sostenere
- diversi livelli di astrazione : puo variare da una descrizione astratta ed imprecisa del sistema, fino a una descrizione dettagliata e ==matematica dello stesso==

es: ATM
- il sistema atm dovrà controllare la validità della carta bancomat inserità
- il sistema atm nonn dovrà erogare non più di 250 euro per ognicarta in un unico periodo di 24 ore


> Il sistema dice cosa fare e non come

![[Pasted image 20260312104520.png | 500]]

###### Costo rimozione difetti

![[Pasted image 20260312104846.png | 500]]

---
### Diversi livelli del dettaglio

Requisiti utente:
- descrizione in linguaggio naturale delle funzionalità che il sistema dovrà fornire e dei vincoli operativi
- sono scritti per e con il cliente
- non servono conoscenze tecniche per comprenderli
- usati anche come forma di contratto

Requisiti di sistema:
- specifiche descritte in modo dettagliato
- Linguaggio formale

![[Pasted image 20260312105544.png]]
![[Pasted image 20260312105614.png]]

![[Pasted image 20260312105714.png]]

###### Diversi modi per rappresentarli:

- non scriverli, partire subito con la implementazione
- mendiante linguaggi formali (z)
- notazioni visuali (uml)
- testo strutturato (form/template)
- testo non strutturato (linguaggio naturale)
- use cases
- user stories

---
### Esempio completo dei requisiti
###### Requisiti funzionali vs non funzionali

###### Funzionali:
- descrivono funzionalita ed i servizi che saranno forniti dal sistema
- ciò che il sistema dovrà fare
- indipendenti dall'implementazione di una soluzione (non come ma cosa)
- esempio sistema bancario che dovra permettere la consultazione del saldo
###### Non funzionali:
- definiscono vincoli sul sitema e sullo sviluppo del sistema
- riguarda la scelta dei linguaggi, strutture, tecniche implementazione, prestazioni sistema, vincoli etnici
- esempio bancario: la risposta dell'interrogazione deve essere entro 3 secondi, i documenti devono essere registrati in formato pdf, i computer devono essere windows

![[Pasted image 20260312110740.png]]

Il primo e il terzo requisiti sono funzionali, il secondo e il quarto sono i non funzionali

==Sarà comodo avere una check-list==
![[Pasted image 20260312111111.png]]



