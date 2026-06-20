# Regole per la conversione degli appunti in Typst

Trasforma gli appunti Markdown presenti in `reference/` in capitoli Typst destinati a un libro completo per lo studio dell'esame di Ingegneria del software.

## Struttura dei file

- Mantieni `main.typ` leggero e usa un file separato nella cartella `chapters/` per ciascun capitolo.
- Usa una gerarchia coerente: `=` per il capitolo, `==` per i capitoli principali, `===` per i sottocapitoli e `====` soltanto per suddivisioni interne realmente necessarie.
- Raggruppa i singoli modelli di sviluppo sotto un capitolo generale, ad esempio `Tipi di modelli di processo`, e presentali come sottocapitoli numerati.
- La gerarchia deve essere visibile anche nell'indice e non deve risultare inutilmente profonda.

## Impaginazione

- Ogni capitolo di secondo livello (`==`, per esempio `1.1`, `1.2`, `1.3`) deve iniziare sempre su una nuova pagina.
- Un titolo non deve mai comparire isolato o nelle ultime righe di una pagina. Deve rimanere unito a una quantità significativa del contenuto seguente.
- Evita che titolo e breve introduzione restino su una pagina mentre diagramma, tabella o spiegazione principale iniziano nella successiva.
- Usa interruzioni di pagina editoriali quando la gestione automatica non produce un risultato ordinato.
- Evita pagine finali contenenti soltanto poche righe: compatta moderatamente tabelle o spaziature senza ridurre la leggibilità.
- Dopo ogni modifica, compila il PDF e controlla visivamente tutte le pagine; la sola assenza di errori di compilazione non è sufficiente.

## Evidenza dei sottocapitoli

- I sottocapitoli che descrivono singoli modelli o argomenti principali devono essere facili da individuare sfogliando il PDF.
- Usa per i titoli di terzo livello una fascia chiara, un bordo laterale colorato, testo ben contrastato e una spaziatura compatta.
- Mantieni la numerazione automatica e impedisci che queste intestazioni rimangano orfane a fondo pagina.
- Conserva uno stile grafico uniforme in tutti i capitoli.

## Contenuto e materiali visivi

- Non effettuare una conversione meccanica: riorganizza e chiarisci il testo affinché sia adatto allo studio.
- Mantieni tutte le informazioni rilevanti degli appunti e aggiungi chiarimenti utili quando emergono dalle immagini.
- Analizza le immagini collegate nei Markdown, cercandole nelle cartelle `reference/images` e `reference/IMMAGINI`.
- Quando un'immagine contiene un diagramma, un grafico, una tabella o un processo, ricostruiscilo preferibilmente in CeTZ invece di incorporare il raster.
- Consulta la documentazione CeTZ disponibile in `doc_typ/cetz.pdf`.
- Tabelle e diagrammi devono essere leggibili, coerenti con la palette del libro e accompagnati da una didascalia informativa.
- Usa box colorati con moderazione per definizioni, idee fondamentali, rischi, avvertenze e regole d'esame.

## Verifica finale

- Compila sempre `main.typ` con Typst.
- Controlla numerazione, indice, gerarchia, interruzioni di pagina, sovrapposizioni e leggibilità dei diagrammi.
- Correggi titoli a fondo pagina, pagine quasi vuote e contenuti visivi compressi prima di considerare concluso il capitolo.
