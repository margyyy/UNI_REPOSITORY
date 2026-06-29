#import "layout.typ": appunti
#import "boxes.typ": *
#import "@preview/cetz:0.5.1"

#show: appunti

// Virgola decimale all'italiana: dentro la matematica la virgola è trattata
// come segno di punteggiatura e riceve uno spazio a destra (es. "9, 8").
// Questa regola la riclassifica come simbolo normale, così i numeri decimali
// risultano attaccati: "9,8". Vale ovunque (testo, frazioni, pedici).
#show math.equation: it => {
  show ",": math.class("normal", ",")
  it
}

#let red = rgb("#a12a2a")
#let blue = rgb("#245b88")
#let gold = rgb("#c28b16")
#let green = rgb("#327a50")
#let ink = rgb("#23262b")
#let grid-color = rgb("#dfe5e8")

// Notazione uniforme: ogni chiamata vec(x) applica una freccia vettoriale.
// Il nome locale sostituisce il costruttore di vettori/matrici predefinito.
#let vec = math.arrow

#let axis-label(pos, value, placement: "center") = {
  import cetz.draw: *
  content(pos, text(size: 9pt, weight: "bold", fill: ink, value), anchor: placement)
}

#let axes(xmax: 4.8, ymax: 3.0, xlabel: [$t$], ylabel: [$x$]) = {
  import cetz.draw: *
  line((0, 0), (xmax, 0), stroke: 0.9pt + ink, mark: (end: ">"))
  line((0, 0), (0, ymax), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((xmax, -0.18), xlabel, placement: "north")
  axis-label((-0.15, ymax), ylabel, placement: "east")
}

#let graph-card(title, drawing) = block(
  width: 100%,
  breakable: false,
  inset: 8pt,
  radius: 5pt,
  stroke: 0.6pt + rgb("#ccd4d8"),
  fill: rgb("#fbfcfd"),
  [
    #text(size: 9pt, weight: "bold", fill: blue, title)
    #v(4pt)
    #align(center, drawing)
  ],
)

#align(center)[
  #text(26pt, weight: "bold", fill: black)[Fondamenti di fisica ]
  #v(6pt)
  #text(12pt, fill: rgb("#56616a"))[Appunti ragionati per la preparazione all'esame]
]

#v(12pt)
#outline(title: [Indice])
#pagebreak()

= Che cos'è la fisica

#green-box([L'idea prima della definizione])[
  La fisica nasce da una domanda molto concreta: *come funziona il mondo, e possiamo prevederlo con i numeri?* Invece di accontentarsi di descrizioni a parole ("la pietra cade perché è pesante"), la fisica vuole misurare quanto velocemente cade, in quanto tempo, e scrivere una formula che lo predica per qualsiasi pietra. Il cuore del metodo è questo: si osserva, si misura, si trova una regola matematica, e poi si controlla se la regola regge a nuovi esperimenti. Se non regge, si butta via. Per questo si dice che la fisica è una *scienza sperimentale*: l'ultima parola ce l'ha sempre la misura, non l'opinione.
]

La *fisica* è una scienza sperimentale: parte dall'osservazione della realtà, misura grandezze fisiche e cerca relazioni matematiche tra esse. Quando una relazione è ripetutamente confermata dagli esperimenti e ne riassume il comportamento, prende il nome di *legge fisica*.

#green-box([Idea guida])[La teoria non sostituisce l'esperimento: organizza i dati, permette di fare previsioni e deve poter essere smentita da nuove misure.]

#yellow-box([Cosa significa "deve poter essere smentita"])[
  Una buona legge fisica si espone: dice in anticipo cosa succederà, in modo così preciso che, se l'esperimento desse un risultato diverso, la legge risulterebbe sbagliata. È una caratteristica di forza, non di debolezza: una teoria che "spiega tutto" e non potrebbe mai essere contraddetta da nessuna misura non è scienza, perché non rischia nulla. Esempio: la legge $x(t)=x_0+v t$ predice dove sarà un'auto a velocità costante fra $10$ secondi; se la misuri e trovi un valore diverso, sai che qualcosa non torna (l'auto non andava davvero a velocità costante).
]

Si distingue convenzionalmente tra:

- *fisica classica*, adeguata a corpi macroscopici, velocità molto minori di quella della luce e fenomeni non quantistici;
- *fisica moderna*, sviluppata soprattutto dal XX secolo, che comprende relatività e meccanica quantistica.

#yellow-box([Classica e moderna: dove sta il confine])[
  Non è che la fisica classica sia "sbagliata" e quella moderna "giusta". La fisica classica funziona benissimo nel mondo di tutti i giorni: automobili, palloni, ponti, pianeti. Smette di funzionare in due situazioni estreme: quando le velocità si avvicinano a quella della luce (entra in gioco la *relatività*) o quando si scende alla scala degli atomi (entra in gioco la *meccanica quantistica*). In questo corso restiamo nel regno della fisica classica, dove le intuizioni quotidiane sono quasi sempre buone guide.
]

Nel modello classico usato in questa prima parte si assume uno spazio euclideo tridimensionale e un tempo che scorre uniformemente. I corpi vengono spesso idealizzati come particelle dotate di massa e quindi di inerzia.

#blue-box([Spazio euclideo, tempo uniforme, inerzia: cosa vogliono dire])[
  - *Spazio euclideo tridimensionale*: lo spazio in cui ci muoviamo è quello della geometria che conosci dalle superiori (vale il teorema di Pitagora, le rette parallele non si incontrano mai), e servono tre numeri per individuare un punto (lunghezza, larghezza, altezza).
  - *Tempo che scorre uniformemente*: il tempo è lo stesso per tutti gli osservatori e avanza sempre allo stesso ritmo, come un unico grande orologio universale. (È proprio questa idea che la relatività metterà in discussione.)
  - *Inerzia*: la tendenza di un corpo a mantenere il proprio stato di moto. Più un corpo ha massa, più "fa resistenza" a cambiare velocità. La massa $m$ è la misura di questa inerzia.
]

La fisica classica adotta una descrizione *deterministica*: assegnato lo stato iniziale e note le leggi del moto, lo stato futuro è in linea di principio determinato. La fisica descrive grandezze su scale estremamente diverse, indicativamente da $10^(-45)$ a $10^45$, ma ogni affermazione resta legata a quantità osservabili e misurabili entro un preciso intervallo di validità sperimentale.

#green-box([Cosa vuol dire "deterministica"])[
  Immagina di conoscere con esattezza, in un dato istante, dove si trova un corpo e con che velocità si muove (questo è lo *stato iniziale*), e di conoscere le regole che governano il moto (le *leggi del moto*). Allora, in linea di principio, il futuro è già scritto: puoi calcolare dove sarà il corpo in qualsiasi istante successivo. È come avere la prima tessera del domino e conoscere la disposizione di tutte le altre: la sequenza è determinata. Questa è una proprietà tipica della fisica classica; la meccanica quantistica, invece, descrive solo probabilità.
]

== Interazioni fondamentali e conservazione

#green-box([L'idea prima della tabella])[
  Tutto ciò che vedi accadere — una mela che cade, un magnete che attira una graffetta, il Sole che brilla, un atomo radioattivo che decade — è, in fondo, una di quattro "spinte" fondamentali all'opera. La fisica ha scoperto che non servono mille forze diverse: bastano *quattro interazioni* per spiegare ogni fenomeno noto. Ognuna agisce su un certo tipo di "carica" (la massa per la gravità, la carica elettrica per l'elettromagnetismo) e domina su una certa scala di distanze.
]

Tutti i fenomeni fisici noti sono ricondotti a quattro interazioni fondamentali:

#table(
  columns: (1.2fr, 2.8fr),
  inset: 6pt,
  stroke: 0.4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { rgb("#eaf1f7") },
  table.header([*Interazione*], [*Ruolo essenziale*]),
  [Gravitazionale], [Agisce tra corpi dotati di massa-energia; domina su scala astronomica.],
  [Elettromagnetica], [Agisce tra cariche elettriche; spiega elettricità, magnetismo e gran parte dei fenomeni microscopici ordinari.],
  [Nucleare forte], [Lega quark e nucleoni; tiene uniti i nuclei atomici.],
  [Nucleare debole], [Interviene in alcuni decadimenti radioattivi e nelle trasformazioni delle particelle.],
)

Le forze descrivono le cause delle variazioni del moto. Un'altra famiglia di principi molto potenti è costituita dalle *leggi di conservazione*: in un sistema isolato alcune quantità, come energia, quantità di moto, momento angolare e carica rimangono costanti. Le leggi di conservazione sono legate alle simmetrie delle leggi fisiche.

#green-box([Cos'è una legge di conservazione (e perché è così utile)])[
  Una *legge di conservazione* dice che una certa quantità non cambia mai durante un fenomeno, qualunque cosa accada nei dettagli: il suo valore all'inizio è uguale al valore alla fine. "Sistema isolato" significa che il sistema non scambia nulla con l'esterno (nessuna forza esterna, nessuno scambio di materia). Pensa a una cassaforte ermetica: dentro le cose si rimescolano come vogliono, ma il totale di certe grandezze resta intatto. Queste leggi sono potentissime perché ti permettono di rispondere a una domanda ("quanto vale la velocità alla fine?") *senza* dover seguire tutto il moto istante per istante: basta confrontare inizio e fine.
]

#yellow-box([Simmetrie e conservazione: un'anticipazione])[
  C'è un legame profondo e sorprendente: ogni legge di conservazione nasce da una *simmetria* delle leggi fisiche. Per "simmetria" si intende che le leggi non cambiano se sposti l'esperimento. Esempi: le leggi della fisica sono le stesse oggi e domani (simmetria nel tempo) e da questo segue la conservazione dell'energia; sono le stesse qui e un metro più in là (simmetria nello spazio) e da questo segue la conservazione della quantità di moto. Per ora basta tenerlo a mente come idea: lo si dimostra più avanti.
]

== Leggi fisiche e osservatore

#green-box([L'idea prima della formula])[
  Una legge fisica vera deve valere *per chiunque la osservi*, indipendentemente da dove ha messo l'origine degli assi o da come li ha orientati. Se io e te misuriamo lo stesso fenomeno ma abbiamo disegnato i nostri assi in modo diverso, dobbiamo comunque trovarci d'accordo sulla fisica: la pietra cade allo stesso modo, anche se nei nostri due fogli i numeri delle coordinate sono diversi. La natura non sa nulla del sistema di riferimento che *noi* abbiamo scelto: gli assi sono un nostro strumento di comodo, non una proprietà del mondo. Per questo le leggi vanno scritte con oggetti (vettori, scalari) che "sanno comportarsi bene" quando cambi il punto di vista.
]

Una legge fisica è una relazione matematica tra oggetti dello stesso tipo: vettori con vettori, scalari con scalari. La sua forma non deve dipendere dalla scelta arbitraria dell'osservatore o del sistema di coordinate.

L'osservatore usa un riferimento $O x y z$ e strumenti per misurare posizione e tempo. Può cambiare origine, traslare nello spazio e nel tempo oppure ruotare gli assi: una legge fisica deve essere formulata con oggetti che si trasformano coerentemente sotto questi cambiamenti, cioè deve essere *covariante*.

#yellow-box([Cosa vuol dire "covariante" in parole povere])[
  *Covariante* significa che, quando cambi sistema di riferimento, i due membri di un'equazione cambiano *allo stesso modo*, così che l'uguaglianza resti vera in ogni sistema. È come un'equazione di traduzione che resta corretta in tutte le lingue: cambi la lingua (il riferimento), ma il significato (la fisica) non si altera. Se invece scrivessi un'equazione che è vera solo nel "tuo" particolare sistema di assi, non sarebbe una vera legge fisica, ma un risultato accidentale legato alla tua scelta arbitraria.
]

#blue-box([Scalari e vettori])[
  Una grandezza *scalare* è descritta da un valore e da un'unità di misura (per esempio massa e temperatura). Una grandezza *vettoriale* possiede anche direzione e verso (per esempio spostamento, velocità e forza). Non ogni numero scritto in un calcolo è automaticamente uno scalare fisico: deve rappresentare una quantità invariata rispetto ai cambiamenti di coordinate considerati.
]

#yellow-box([Coerenza delle equazioni])[
  In un'equazione fisica i due membri devono avere lo stesso rango e le stesse dimensioni fisiche. Non ha senso uguagliare direttamente un vettore a un numero, né sommare una lunghezza a un tempo.
]

#red-box([Attenzione: il controllo dimensionale è il tuo migliore alleato])[
  "Stesse dimensioni fisiche" significa che entrambi i membri devono misurarsi nella stessa unità. Non puoi scrivere $3 " m" = 5 " s"$: sono cose di natura diversa, come dire "3 mele = 5 minuti". Allo stesso modo non puoi *sommare* metri e secondi. Questa regola, chiamata *analisi dimensionale*, è un controllo rapidissimo per scoprire errori: ogni volta che ottieni una formula, verifica che le unità ai due lati combacino. Se non combaciano, hai sbagliato un passaggio di sicuro. Lo useremo spesso in questi appunti (vedi i "controlli dimensionali").
]

= Meccanica

#green-box([Dove siamo e dove andiamo])[
  La *meccanica* è la parte della fisica che studia il movimento. La affrontiamo in due tappe. Prima impariamo a *descrivere* il moto: dove si trova un corpo, quanto va veloce, come accelera, senza chiederci perché. Questa è la *cinematica*, ed è ciò di cui ci occupiamo ora. Solo dopo studieremo le *cause* del moto — le forze — passando alla *dinamica*. È come imparare prima a descrivere il percorso di un'auto guardando il navigatore (cinematica) e poi capire cosa fa muovere l'auto, cioè il motore e i freni (dinamica).
]

La meccanica studia il moto dei corpi e si divide in due parti:

- la *cinematica* descrive come si muove un corpo, senza indagare la causa del moto;
- la *dinamica* collega il moto alle forze che lo producono.

In questa sezione consideriamo soltanto moti lungo una retta.

#yellow-box([Perché iniziare da una retta (moto in 1D)])[
  Limitarci a un moto lungo una sola retta (in una dimensione) è una scelta didattica furba: tutta la fisica del problema c'è già, ma i conti restano semplici perché serve *un solo numero* per dire dove sta il corpo (la sua posizione $x$ sull'asse), invece di due o tre coordinate. Una volta capito bene il caso 1D, il salto a due o tre dimensioni sarà soprattutto "fare la stessa cosa per ogni asse separatamente".
]

== Punto materiale e legge oraria

#green-box([L'idea prima della definizione])[
  Un corpo reale è complicato: ha una forma, può ruotare, può deformarsi. Ma in moltissimi problemi tutto questo non conta. Se voglio sapere fra quanto la Terra arriva dall'altra parte del Sole, le montagne e gli oceani della Terra sono dettagli irrilevanti: posso trattarla come un puntino con tutta la sua massa concentrata lì. Questa idealizzazione si chiama *punto materiale* ed è la prima grande semplificazione della meccanica. Attenzione: non si butta via la massa! Il punto resta "materiale" proprio perché conserva la massa $m$; si butta via solo l'estensione, la forma e i movimenti interni.
]

#green-box([Punto materiale])[
  Un corpo è trattato come *punto materiale* quando le sue dimensioni e i suoi moti interni sono irrilevanti per il problema. Conserva però la massa $m$.
]

Scelto un asse orientato $x$, il moto rettilineo è descritto dalla coppia

$ (t, x(t)), $

dove $t$ è il tempo e $x(t)$ è la posizione. La funzione $x(t)$ è detta *legge oraria*. Il suo grafico non rappresenta la traiettoria nello spazio: mostra come cambia la coordinata del corpo nel tempo.

#blue-box([Cos'è la legge oraria, simbolo per simbolo])[
  - $t$ è il *tempo*, misurato in secondi ($"s"$). È la variabile "input": scelgo un istante.
  - $x(t)$ è la *posizione* del corpo a quell'istante, misurata in metri ($"m"$). È un numero con segno: ti dice a che punto dell'asse $x$ si trova il corpo. Positivo da una parte dell'origine, negativo dall'altra.
  - La coppia $(t, x(t))$ dice "all'istante $t$ il corpo è nel punto $x(t)$". Scorrendo tutti i valori di $t$ ottieni il "film" completo del moto.
  - La funzione $x(t)$, cioè la regola che a ogni istante associa la posizione, è la *legge oraria*: è l'oggetto centrale di tutta la cinematica. Conoscere $x(t)$ vuol dire sapere tutto sul moto.
]

#red-box([Attenzione: il grafico NON è la traiettoria])[
  È l'errore più comune all'inizio. Nel grafico della legge oraria l'asse orizzontale è il *tempo* e l'asse verticale è la *posizione*. Quindi una retta in salita non significa che il corpo "sale": significa che la sua posizione $x$ aumenta col passare del tempo, cioè che si muove nel verso positivo dell'asse. Il moto vero, qui, avviene tutto lungo una singola retta (l'asse $x$); il grafico è solo un modo di raccontare *quando* il corpo passa *dove*. Pensa al grafico come al tracciato di un sismografo o di un elettrocardiogramma: l'asse orizzontale è sempre il tempo che scorre.
]

#purple-box([Esempio numerico: leggere una legge oraria])[
  Sia $x(t) = 4 - 2t$ (metri, $t$ in secondi). Calcoliamo qualche posizione:
  - a $t = 0 " s"$: $x = 4 - 2(0) = 4 " m"$;
  - a $t = 1 " s"$: $x = 4 - 2(1) = 2 " m"$;
  - a $t = 2 " s"$: $x = 4 - 2(2) = 0 " m"$ (il corpo passa per l'origine);
  - a $t = 3 " s"$: $x = 4 - 2(3) = -2 " m"$ (ora è dall'altra parte dell'origine).

  La posizione *diminuisce* col tempo: il corpo si muove verso i valori negativi di $x$, cioè nel verso opposto all'asse. Il segno meno davanti a $t$ ce lo diceva già.
]

I tre grafici qui sotto sono i tre "tipi base" di legge oraria che incontreremo. Imparare a riconoscere la *forma* del grafico è già metà del lavoro: una retta orizzontale dice "fermo", una retta inclinata dice "velocità costante", una curva (parabola) dice "velocità che cambia, cioè c'è accelerazione". Sotto ciascun grafico trovi la formula corrispondente, che ricaveremo passo passo nelle prossime pagine.

#grid(columns: (1fr, 1fr, 1fr), gutter: 8pt,
  graph-card([Quiete], cetz.canvas({
    import cetz.draw: *
    axes(xmax: 3.5, ymax: 2.5)
    line((0, 1.25), (3.25, 1.25), stroke: 1.4pt + blue)
    axis-label((2.5, 1.48), [$x(t)=x_0$])
  })),
  graph-card([Moto uniforme], cetz.canvas({
    import cetz.draw: *
    axes(xmax: 3.5, ymax: 2.5)
    line((0, 0.45), (3.1, 2.15), stroke: 1.4pt + green)
    axis-label((2.35, 1.65), [$x=x_0+v t$])
  })),
  graph-card([Moto accelerato], cetz.canvas({
    import cetz.draw: *
    axes(xmax: 3.5, ymax: 2.5)
    bezier-through((0, 0.4), (1.9, 0.72), (3.15, 2.25), stroke: 1.4pt + red)
    axis-label((2.15, 1.25), [$x=x_0+v_0t+1/2 a t^2$])
  })),
)

== Velocità

#green-box([L'idea prima della formula])[
  La velocità risponde a una domanda semplice: *quanto spazio percorre il corpo in ogni secondo, e in che verso?* Se in $2$ secondi mi sposto di $10$ metri, intuitivamente "vado a $5$ metri al secondo". Questo rapporto fra spazio percorso e tempo impiegato è esattamente ciò che la formula traduce in simboli. Tutto il resto (limiti, derivate) serve solo a renderla precisa istante per istante.
]

La velocità media nell'intervallo $[t_1,t_2]$ è

$ v_("media") = (Delta x)/(Delta t) = (x(t_2)-x(t_1))/(t_2-t_1), $

e si misura in $"m"/"s"$. Il simbolo $Delta$ (delta) significa sempre "variazione di", cioè *valore finale meno valore iniziale*: $Delta x=x(t_2)-x(t_1)$ è lo spostamento, $Delta t=t_2-t_1$ è il tempo trascorso. La velocità media è dunque "spostamento diviso tempo".

#yellow-box([Perché "media" non basta])[
  La velocità media dice solo dove sei all'inizio e alla fine, non cosa è successo in mezzo. Un'auto che parte, accelera, frena al semaforo e riparte può avere la stessa velocità media di una che viaggia tranquilla a passo costante, se percorrono lo stesso tratto nello stesso tempo. Per sapere quanto va *in un preciso istante* (quello che legge il tachimetro) serve la velocità istantanea.
]

La velocità istantanea è il limite della velocità media quando l'intervallo di tempo si rimpicciolisce fino a diventare un singolo istante:

$ v(t) = lim_(Delta t -> 0) (Delta x)/(Delta t) = (dif x(t))/(dif t). $

#yellow-box([Cosa vuol dire questo limite])[
  Facciamo $Delta t$ sempre più piccolo: $1$ s, poi $0,1$ s, poi $0,001$ s... Man mano che la finestra temporale si stringe attorno all'istante $t$, la velocità media in quella finestra si avvicina a un valore ben preciso. Quel valore-limite è la velocità *in* quell'istante. La scrittura $(dif x)/(dif t)$ è proprio il nome che il calcolo differenziale dà a questo limite: la *derivata* di $x(t)$ rispetto al tempo.
]

Geometricamente, $v(t)$ è il coefficiente angolare (la pendenza) della retta tangente al grafico di $x(t)$: dove la curva sale ripida la velocità è grande, dove è quasi piatta la velocità è quasi nulla. Il segno indica il verso del moto: $v>0$ se $x$ cresce, $v<0$ se $x$ diminuisce, $v=0$ in un punto stazionario.

#purple-box([Esempio numerico])[
  Un ciclista percorre la legge oraria $x(t)=2+3t$ (metri, con $t$ in secondi). All'istante $t_1=1 " s"$ si trova in $x_1=2+3(1)=5 " m"$; a $t_2=4 " s"$ in $x_2=2+3(4)=14 " m"$. La velocità media è
  $ v_"media"=(14-5)/(4-1)=9/3=3 " m/s". $
  Poiché la legge è una retta, la pendenza è ovunque la stessa: la velocità istantanea vale anch'essa $v=(dif x)/(dif t)=3 " m/s"$ in ogni istante. Il "$3$" davanti a $t$ nella legge oraria *è* la velocità.
]

#align(center, graph-card([La velocità come pendenza], cetz.canvas({
  import cetz.draw: *
  axes(xmax: 6.3, ymax: 3.4)
  bezier-through((0, 0.35), (3.3, 1.35), (5.7, 2.75), stroke: 1.5pt + blue, name: "curve")
  // secante tra due istanti: velocità media
  circle((1.55, 0.72), radius: 0.06, fill: gold, stroke: none)
  circle((4.75, 2.15), radius: 0.06, fill: gold, stroke: none)
  line((1.55, 0.72), (4.75, 2.15), stroke: (paint: gold, thickness: 1pt, dash: "dashed"))
  line((1.55, 0.72), (4.75, 0.72), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  line((4.75, 0.72), (4.75, 2.15), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  axis-label((3.15, 0.52), [$Delta t$], placement: "north")
  axis-label((4.95, 1.42), [$Delta x$], placement: "west")
  axis-label((2.5, 1.32), [$v_"media"$], placement: "south")
  // tangente nel punto t_*
  line((1.35, 0.15), (5.1, 2.45), stroke: (paint: red, thickness: 1pt, dash: "dashed"))
  circle((3.3, 1.35), radius: 0.07, fill: red, stroke: none)
  axis-label((3.45, 1.08), [$t_*$], placement: "north")
  axis-label((4.95, 2.65), [$v(t_*)$], placement: "west")
})))

=== Moto uniforme

#green-box([L'idea prima della formula])[
  "Moto uniforme" è il moto più semplice di tutti: il corpo va sempre alla *stessa velocità*, né accelera né rallenta. Pensa a un'auto col cruise control su una strada dritta, o a un tapis roulant che scorre liscio. Se la velocità è costante, è intuitivo che in tempi uguali si percorrano spazi uguali: in ogni secondo avanzo della stessa quantità. L'obiettivo ora è trovare la *legge oraria* $x(t)$ di questo moto, cioè la formula che dice dove sono a ogni istante. La cosa elegante è che non la inventiamo né la "assumiamo": la *ricaviamo* a partire dalla sola definizione di velocità.
]

Nel moto rettilineo uniforme la velocità è costante. La legge oraria non si assume: si ricava dalla definizione di velocità. Separando le variabili,

$ v=(dif x)/(dif t) quad arrow quad dif x=v dif t. $

#yellow-box([Cos'è la "separazione delle variabili"])[
  Partiamo da $v=(dif x)/(dif t)$. Qui $(dif x)/(dif t)$ è una derivata, ma in fisica la trattiamo informalmente come un rapporto fra due quantità piccolissime: $dif x$ (un minuscolo spostamento) e $dif t$ (un minuscolo intervallo di tempo). "Separare le variabili" vuol dire raccogliere tutto ciò che riguarda $x$ da un lato e tutto ciò che riguarda $t$ dall'altro. Moltiplicando entrambi i membri per $dif t$:
  $ v dot dif t = (dif x)/(dif t) dot dif t = dif x, $
  cioè $dif x = v dif t$. In parole: un piccolo spostamento $dif x$ è uguale alla velocità moltiplicata per il piccolo tempo $dif t$ durante il quale ci si muove. È la versione "in piccolo" di spazio = velocità × tempo.
]

Si integrano entrambi i membri tra lo stato iniziale $(t_0,x_0)$ e lo stato generico $(t,x(t))$:

$ integral_(x_0)^(x(t)) dif x=integral_(t_0)^t v dif tau. $

#yellow-box([Perché gli estremi degli integrali sono quelli, e perché $tau$])[
  L'idea è sommare tutti i piccoli spostamenti $dif x$ man mano che il tempo va da $t_0$ a $t$. Mentre il tempo scorre da $t_0$ a $t$, la posizione passa da $x_0$ a $x(t)$: ecco perché a sinistra integriamo $x$ da $x_0$ a $x(t)$ e a destra il tempo da $t_0$ a $t$. La lettera $tau$ (tau) è solo una *variabile muta* di integrazione: serve per non confonderla con $t$, che è l'estremo superiore (l'istante a cui vogliamo arrivare). È come quando in una somma usi un indice $i$ diverso dal limite finale: il nome interno non conta, conta il risultato.
]

#yellow-box([Perché compare l'integrale?])[
  Matematicamente $v=(dif x)/(dif t)$ significa
  $ v(t)=x'(t). $

  Se conosco la derivata $x'(t)$ e voglio recuperare la funzione $x(t)$, devo usare l'operazione inversa della derivata: l'integrale.

  Per il teorema fondamentale del calcolo,
  $ integral_(t_0)^t x'(tau) dif tau = x(t)-x(t_0). $

  Poiché $x'(tau)=v(tau)$, segue
  $ x(t)-x_0 = integral_(t_0)^t v(tau) dif tau. $

  Quindi l'integrale della velocità nel tempo è lo *spostamento totale*. Non è un trucco: è il modo matematico per sommare tutti i piccoli spostamenti
  $ dif x approx v(t) dif t $
  accumulati tra $t_0$ e $t$.

  La scrittura fisica $dif x=v dif t$ è una scorciatoia comoda. In analisi, il passaggio rigoroso è integrare la derivata $x'(t)$ come sopra.
]

Poiché $v$ è costante,

$ x(t)-x_0=v(t-t_0), $

da cui

$ x(t) = x_0 + v (t-t_0), $

dove $x_0=x(t_0)$. Se si sceglie $t_0=0$, la legge oraria diventa $x(t)=x_0+v t$.

#yellow-box([Perché $v$ "esce" dall'integrale])[
  L'integrale a destra era $integral_(t_0)^t v dif tau$. Poiché qui $v$ è una *costante* (non dipende da $tau$), si può portare fuori dal segno di integrale: integrare una costante significa semplicemente moltiplicarla per la lunghezza dell'intervallo. Quindi
  $ integral_(t_0)^t v dif tau = v integral_(t_0)^t dif tau = v dot (t - t_0). $
  L'integrale a sinistra, $integral_(x_0)^(x(t)) dif x$, vale invece semplicemente $x(t) - x_0$ (è l'area di base $1$ e altezza, cioè la lunghezza dell'intervallo da $x_0$ a $x(t)$). Mettendo insieme i due lati si ottiene $x(t) - x_0 = v(t - t_0)$. Da qui basta portare $x_0$ a destra.
]

#blue-box([Legge oraria del moto uniforme])[
  $ x(t) = x_0 + v(t - t_0) $
  Significato dei simboli: $x_0$ è la posizione iniziale (dove si trova il corpo all'istante di partenza $t_0$), $v$ è la velocità costante, $t - t_0$ è il tempo trascorso dalla partenza. La formula dice: "parti da dove eri, e aggiungi quanto hai percorso = velocità × tempo trascorso". Con la scelta comoda $t_0 = 0$ diventa $x(t) = x_0 + v t$.
]

#purple-box([Esempio numerico])[
  Un treno parte dalla posizione $x_0 = 100 " m"$ all'istante $t_0 = 0$ e viaggia a velocità costante $v = 30 " m/s"$. Dove si trova dopo $t = 5 " s"$?
  $ x(5) = 100 + 30 dot 5 = 100 + 150 = 250 " m". $
  E dopo $10 " s"$? $ x(10) = 100 + 30 dot 10 = 400 " m". $
  Nota che tra $t=5 " s"$ e $t=10 " s"$ (altri $5$ secondi) ha percorso ancora $400 - 250 = 150 " m"$: in tempi uguali, spazi uguali. È esattamente la firma del moto uniforme. Controllo dimensionale: $v dot t$ ha unità $("m"/"s") dot "s" = "m"$, coerente con una posizione.
]

#blue-box([Caso di quiete])[
  La quiete è il caso particolare $v=0$: la legge oraria diventa $x(t)=x_0$, quindi il grafico posizione-tempo è una retta orizzontale.
]

#red-box([Da ricordare])[
  Moto uniforme $arrow$ grafico $x(t)$ rettilineo $arrow$ pendenza costante. Il corpo può avere velocità costante non nulla anche se la risultante delle forze sarà, come vedremo, nulla.
]

== Accelerazione

#green-box([L'idea prima della formula])[
  Se la velocità è "quanto cambia la posizione nel tempo", l'accelerazione è "quanto cambia la *velocità* nel tempo". È la sensazione che provi in auto: quando schiacci il gas vieni spinto indietro contro il sedile, quando freni vieni spinto in avanti. Quella spinta è il segnale che la velocità sta cambiando, cioè che c'è accelerazione. Notare bene: un corpo può andare velocissimo e avere accelerazione *nulla* (autostrada a velocità costante), oppure essere fermo un istante e avere accelerazione grande (la pallina lanciata in alto, nell'attimo in cui si ferma in cima).
]

L'accelerazione media è la variazione di velocità divisa per il tempo impiegato:

$ a_("media") = (Delta v)/(Delta t), $

mentre l'accelerazione istantanea è la sua versione "in un singolo istante", cioè la derivata della velocità:

$ a(t) = (dif v(t))/(dif t) = (dif^2 x(t))/(dif t^2). $

#yellow-box([Significato di $dif^2 x / dif t^2$])[
  La notazione $(dif^2 x)/(dif t^2)$ indica la derivata seconda della posizione rispetto al tempo. Infatti la velocità è la derivata prima della posizione, $v(t)=x'(t)$; l'accelerazione è la derivata della velocità, quindi
  $ a(t)=v'(t)=x''(t). $

  Per questo l'accelerazione misura quanto rapidamente cambia la velocità, non quanto è grande la posizione.
]

La sua unità di misura è $"m"/"s"^2$. L'accelerazione descrive quanto rapidamente varia la velocità; non coincide necessariamente con una velocità elevata.

=== Moto uniformemente accelerato

#green-box([L'idea prima della formula])[
  Adesso saliamo di un gradino: la velocità non è più costante, ma cambia in modo *regolare*, sempre dello stesso tanto a ogni secondo. Questo è il *moto uniformemente accelerato*: l'accelerazione $a$ è costante. L'esempio principe è la caduta dei corpi: un sasso lasciato cadere acquista circa $9,8 " m/s"$ di velocità in più ogni secondo, sempre uguale. La strategia per trovare le leggi orarie è la stessa di prima, applicata due volte: prima usiamo l'accelerazione (derivata della velocità) per ricavare $v(t)$; poi usiamo la velocità appena trovata (derivata della posizione) per ricavare $x(t)$. Si "sale la scala" al contrario: da $a$ a $v$, da $v$ a $x$, ogni volta con un'integrazione.
]

Nel moto uniformemente accelerato $a$ è costante. Partendo da $a=(dif v)/(dif t)$,

$ dif v=a dif t, quad
  integral_(v_0)^(v(t)) dif v=integral_(t_0)^t a dif tau. $

#yellow-box([Primo passaggio: da $a$ a $v(t)$])[
  Esattamente come nel moto uniforme, separiamo le variabili: da $a=(dif v)/(dif t)$, moltiplicando per $dif t$, otteniamo $dif v = a dif t$ (una piccola variazione di velocità è uguale all'accelerazione per il piccolo tempo trascorso). Poi sommiamo (integriamo) tutti questi pezzettini: mentre il tempo va da $t_0$ a $t$, la velocità passa da $v_0$ a $v(t)$, e questo fissa gli estremi degli integrali. A sinistra $integral_(v_0)^(v(t)) dif v = v(t) - v_0$. A destra, poiché $a$ è costante, esce dall'integrale: $integral_(t_0)^t a dif tau = a(t - t_0)$.
]

L'integrazione fornisce

$ v(t)-v_0=a(t-t_0), quad arrow quad
  v(t)=v_0+a(t-t_0). $

#blue-box([Velocità nel moto uniformemente accelerato])[
  $ v(t) = v_0 + a(t - t_0) $
  Si legge: la velocità a un certo istante è quella iniziale $v_0$, più l'accelerazione $a$ moltiplicata per il tempo trascorso. È una *retta* nel grafico $v$-$t$: parte da $v_0$ e cresce (o cala, se $a<0$) con pendenza costante $a$. Controllo dimensionale: $a dot t$ ha unità $("m"/"s"^2) dot "s" = "m"/"s"$, cioè una velocità: torna.
]

Per ricavare la posizione si usa ora $v=(dif x)/(dif t)$ e si sostituisce la velocità appena trovata:

$ dif x=[v_0+a(t-t_0)] dif t, $

$ integral_(x_0)^(x(t)) dif x
  =integral_(t_0)^t [v_0+a(tau-t_0)] dif tau. $

#yellow-box([Secondo passaggio: da $v(t)$ a $x(t)$])[
  Ora ripetiamo il gioco un piano più sotto. Da $v = (dif x)/(dif t)$ separiamo: $dif x = v dif t$. Ma stavolta $v$ non è costante: vale $v = v_0 + a(t - t_0)$, l'espressione appena trovata. La *sostituiamo* dentro $dif x = v dif t$ e otteniamo $dif x = [v_0 + a(t-t_0)] dif t$. Poi integriamo: mentre il tempo va da $t_0$ a $t$, la posizione va da $x_0$ a $x(t)$. (Dentro l'integrale di destra il tempo è la variabile muta $tau$, per non confonderlo con l'estremo $t$.)
]

Calcolando separatamente i due integrali,

$ x(t)-x_0=v_0(t-t_0)+1/2 a(t-t_0)^2. $

#yellow-box([Da dove sbuca il $1/2$])[
  L'integrale di destra si spezza nella somma di due pezzi:
  $ integral_(t_0)^t v_0 dif tau + integral_(t_0)^t a(tau - t_0) dif tau. $
  Il primo è facile: $v_0$ è costante, esce, e $integral_(t_0)^t dif tau = t - t_0$, quindi dà $v_0(t - t_0)$. Il secondo richiede di integrare qualcosa che cresce linearmente nel tempo: l'integrale di $(tau - t_0)$ è $1/2(tau - t_0)^2$ (regola: l'integrale di una potenza $s$ è $1/2 s^2$). Valutato tra $t_0$ e $t$, dà $1/2(t - t_0)^2$, e moltiplicato per la costante $a$ diventa $1/2 a(t - t_0)^2$. Ecco da dove nasce il famoso fattore $1/2$: non è una convenzione magica, è il risultato dell'integrazione di un termine che varia linearmente. Intuitivamente: la velocità è cresciuta gradualmente da $v_0$, quindi lo spazio extra dovuto all'accelerazione è la "media" di questa crescita, da cui il mezzo.
]

Si ottengono così le due leggi orarie:

#blue-box([Equazioni del moto uniformemente accelerato])[
  $ v(t) = v_0 + a(t-t_0) $

  $ x(t) = x_0 + v_0(t-t_0) + 1/2 a(t-t_0)^2 $

  Eliminando il tempo:

  $ v^2 = v_0^2 + 2a(x-x_0). $
]

#blue-box([A cosa serve ciascuna delle tre equazioni])[
  Sono tre forme della stessa fisica, ognuna utile in un contesto diverso:
  - $v(t) = v_0 + a(t-t_0)$: usala quando conosci il *tempo* e vuoi la velocità (o viceversa).
  - $x(t) = x_0 + v_0(t-t_0) + 1/2 a(t-t_0)^2$: usala quando conosci il *tempo* e vuoi la posizione.
  - $v^2 = v_0^2 + 2a(x-x_0)$: questa non contiene il tempo. È perfetta quando il tempo non ti interessa o non lo conosci, e vuoi collegare direttamente *velocità e posizione* (per esempio: "a che velocità arriva a terra un sasso caduto da $20 " m"$?").
]

#purple-box([Esempio numerico: un'auto che accelera])[
  Un'auto parte da ferma ($v_0 = 0$) nella posizione $x_0 = 0$, all'istante $t_0 = 0$, con accelerazione costante $a = 2 " m/s"^2$.

  *Velocità dopo $5 " s"$:*
  $ v(5) = 0 + 2 dot 5 = 10 " m/s". $

  *Spazio percorso in $5 " s"$:*
  $ x(5) = 0 + 0 dot 5 + 1/2 dot 2 dot 5^2 = 1/2 dot 2 dot 25 = 25 " m". $

  *Controllo con la terza equazione* (deve dare la stessa velocità senza usare il tempo):
  $ v^2 = 0 + 2 dot 2 dot (25 - 0) = 100 quad arrow quad v = 10 " m/s". $
  I due metodi concordano: ottimo segno che i conti sono giusti.
]

#red-box([Attenzione ai segni e a $v_0$])[
  Due trabocchetti frequenti. (1) *Il segno di $a$*: se il corpo sta rallentando, l'accelerazione è opposta alla velocità, quindi va messa con il segno *negativo* nelle formule. Non scrivere mai automaticamente $a$ positiva: guarda il verso fisico. (2) *Non dimenticare il termine $v_0(t-t_0)$*: la formula della posizione vale anche quando il corpo parte già in movimento. Solo se parte da fermo ($v_0=0$) quel termine sparisce e resta $x = x_0 + 1/2 a t^2$.
]

=== Eliminazione del tempo

#green-box([L'idea prima della formula])[
  Abbiamo già ottenuto la formula $v^2 = v_0^2 + 2a(x-x_0)$ "eliminando il tempo" tra le due leggi orarie. Qui vediamo un secondo modo di ricavarla, più elegante, che *non passa mai dal tempo*. È un metodo prezioso quando il tempo non ci interessa: vogliamo sapere come sono legate velocità e posizione, punto. Il trucco è un cambio di prospettiva: invece di vedere la velocità come funzione del tempo, la vediamo come funzione della posizione, e usiamo la *regola della catena* per riscrivere l'accelerazione.
]

La relazione tra velocità e posizione si può dimostrare senza risolvere esplicitamente per $t$. Con la regola della catena,

$ a=(dif v)/(dif t)=(dif v)/(dif x)(dif x)/(dif t)
  =v (dif v)/(dif x). $

#yellow-box([La regola della catena, passo per passo])[
  La *regola della catena* serve a derivare una funzione composta. Qui la velocità $v$ dipende dal tempo $t$, ma anche la posizione $x$ dipende dal tempo: possiamo allora pensare $v$ come funzione di $x$, e $x$ come funzione di $t$ ($v$ "passa attraverso" $x$). La regola dice che la derivata totale è il prodotto delle derivate dei passaggi intermedi:
  $ (dif v)/(dif t) = (dif v)/(dif x) dot (dif x)/(dif t). $
  È come moltiplicare due tassi di cambio: "quanto cambia $v$ per ogni metro" per "quanti metri al secondo". A questo punto riconosciamo che $(dif x)/(dif t)$ è proprio la velocità $v$. Sostituendola:
  $ a = (dif v)/(dif x) dot v = v (dif v)/(dif x). $
  Abbiamo riscritto l'accelerazione *senza il tempo*: ora compaiono solo $v$ e $x$.
]

Quindi $v dif v=a dif x$. Integrando dallo stato iniziale $(x_0,v_0)$ allo stato $(x,v)$:

$ integral_(v_0)^v u dif u=integral_(x_0)^x a dif xi, $

#yellow-box([Da $a = v (dif v)/(dif x)$ all'integrale])[
  Partiamo da $a = v (dif v)/(dif x)$. Separando le variabili (portiamo i $dif$ ai lati giusti), moltiplichiamo per $dif x$: $a dif x = v dif v$. Ora sommiamo (integriamo) entrambi i lati: mentre la posizione va da $x_0$ a $x$, la velocità va da $v_0$ a $v$, e questo fissa gli estremi. Le lettere $u$ e $xi$ (xi) sono solo *variabili mute*: $u$ rappresenta la velocità che scorre da $v_0$ a $v$, e $xi$ la posizione che scorre da $x_0$ a $x$. Servono per non confonderle con gli estremi $v$ e $x$.
]

$ 1/2(v^2-v_0^2)=a(x-x_0), $

#yellow-box([Calcolo dei due integrali])[
  A sinistra integriamo $u$: l'integrale di $u$ è $1/2 u^2$, valutato tra $v_0$ e $v$ dà $1/2 v^2 - 1/2 v_0^2 = 1/2(v^2 - v_0^2)$. A destra $a$ è costante, quindi esce dall'integrale e $integral_(x_0)^x dif xi = x - x_0$, dando $a(x - x_0)$. Eguagliando i due risultati e moltiplicando tutto per $2$ per togliere il mezzo, si arriva alla formula finale.
]

e infine

$ v^2=v_0^2+2a(x-x_0). $

#yellow-box([Controllo dimensionale])[
  Ogni termine dell'ultima equazione ha dimensioni di velocità al quadrato:
  $[v^2]="m"^2/"s"^2$ e $[a Delta x]="m"^2/"s"^2$.
]

#purple-box([Esempio numerico: senza usare il tempo])[
  Un sasso viene lasciato cadere da fermo ($v_0 = 0$) da un'altezza di $20 " m"$. Prendendo l'asse verso il basso, l'accelerazione di gravità vale $a = 9,8 " m/s"^2$. Con che velocità tocca terra? Qui non conosciamo il tempo di caduta, ma conosciamo lo spazio percorso $x - x_0 = 20 " m"$, quindi usiamo la formula senza tempo:
  $ v^2 = 0 + 2 dot 9,8 dot 20 = 392 " m"^2"/s"^2, $
  da cui $ v = sqrt(392) approx 19,8 " m/s". $
  Abbiamo trovato la velocità d'impatto senza mai calcolare quanto dura la caduta: è esattamente il vantaggio di questa equazione.
]

Con $t_0=0$, i grafici di $a(t)$, $v(t)$ e $x(t)$ sono rispettivamente una retta orizzontale, una retta e una parabola.

#gray-box([Riepilogo: i tre grafici del moto uniformemente accelerato])[
  I tre disegni qui sotto mostrano, affiancati, lo stesso moto raccontato da tre punti di vista. *Accelerazione* $a(t)$: una retta orizzontale, perché $a$ è costante. *Velocità* $v(t)$: una retta inclinata, perché cresce in modo uniforme (la sua pendenza è proprio $a$). *Posizione* $x(t)$: una parabola, per via del termine in $t^2$ nella legge oraria. Salendo da un grafico all'altro si *integra* (area sotto la curva), scendendo si *deriva* (pendenza): è la stessa scala $a arrow v arrow x$ che abbiamo percorso con i conti.
]

#align(center, cetz.canvas({
  import cetz.draw: *
  // accelerazione
  line((0, 0), (3.2, 0), stroke: 0.8pt + ink, mark: (end: ">"))
  line((0, 0), (0, 2.3), stroke: 0.8pt + ink, mark: (end: ">"))
  line((0, 1.35), (2.85, 1.35), stroke: 1.4pt + red)
  axis-label((-0.12, 2.3), [$a$], placement: "east")
  axis-label((3.2, -0.15), [$t$], placement: "north")
  // velocità
  line((4, 0), (7.2, 0), stroke: 0.8pt + ink, mark: (end: ">"))
  line((4, 0), (4, 2.3), stroke: 0.8pt + ink, mark: (end: ">"))
  line((4, 0.45), (6.85, 1.9), stroke: 1.4pt + green)
  axis-label((3.88, 2.3), [$v$], placement: "east")
  axis-label((7.2, -0.15), [$t$], placement: "north")
  // posizione
  line((8, 0), (11.2, 0), stroke: 0.8pt + ink, mark: (end: ">"))
  line((8, 0), (8, 2.3), stroke: 0.8pt + ink, mark: (end: ">"))
  bezier-through((8, 0.35), (9.55, 0.72), (10.85, 2.05), stroke: 1.4pt + blue)
  axis-label((7.88, 2.3), [$x$], placement: "east")
  axis-label((11.2, -0.15), [$t$], placement: "north")
}))

= Moto verticale nel campo gravitazionale

#green-box([L'idea prima della formula])[
  Quando lasci cadere un oggetto, la Terra lo "tira" verso il basso con una forza che gli imprime sempre la stessa accelerazione, qualunque cosa sia: una piuma e una palla di piombo, *nel vuoto*, cadono affiancate. Sembra incredibile, ma è ciò che mostrò Galileo. Questo significa che il moto verticale di un sasso è semplicemente il moto che già conosci — quello con accelerazione costante — applicato al caso particolare in cui l'accelerazione è quella di gravità. Non devi imparare formule nuove: devi solo riconoscere che $a$ vale $-g$.
]

In una regione abbastanza piccola vicino alla superficie terrestre il campo gravitazionale può essere considerato uniforme. Trascurando la resistenza dell'aria, tutti i corpi hanno la stessa accelerazione verso il basso, indipendentemente dalla massa:

$ g approx 9.81 " m/s"^2. $

#yellow-box([Che cos'è $g$ e perché non dipende dalla massa])[
  Il simbolo $g$ è l'*accelerazione di gravità*: dice di quanto aumenta la velocità di caduta ogni secondo. Il valore $9,81 " m/s"^2$ significa che, in caduta libera, dopo un secondo il corpo va a circa $9,81 " m/s"$, dopo due secondi a $19,62 " m/s"$, e così via.

  Perché non conta la massa? Un corpo più pesante viene attratto con una forza maggiore (forza $= m g$), ma è anche più "difficile da mettere in moto", cioè ha più inerzia. I due effetti si compensano esattamente: $a = F/m = (m g)/m = g$. La massa si semplifica e sparisce.
]

#align(center, graph-card([Approssimazione locale del campo gravitazionale], cetz.canvas({
  import cetz.draw: *
  // superficie terrestre vista localmente come piano tangente
  line((1.15, 0.30), (5.85, 0.30), stroke: 1.5pt + blue)
  for x in range(0, 10) {
    line((1.25 + x*0.45, 0.30), (1.47 + x*0.45, 0.05), stroke: 0.6pt + blue)
  }
  axis-label((3.5, 0.00), [superficie terrestre], placement: "north")
  // piccolo corpo e vettori centrati rispetto al piano
  rect((2.85, 2.40), (4.15, 2.77), fill: rgb("#eef1f3"), stroke: 0.9pt + ink)
  circle((3.5, 2.59), radius: 0.08, fill: ink, stroke: none)
  line((3.5, 2.35), (3.5, 1.45), stroke: 1.4pt + red, mark: (end: ">"))
  line((3.5, 1.25), (3.5, 0.55), stroke: 1.2pt + green, mark: (end: ">"))
  axis-label((3.68, 1.90), [$vec(F)_g$], placement: "west")
  axis-label((3.68, 0.90), [$a_y=-g$], placement: "west")
  axis-label((4.3, 2.60), [$m$], placement: "west")
})))

La curvatura della Terra è trascurabile nella regione studiata: localmente la superficie appare piana e $vec(g)$ può essere trattato come costante. La forza di gravità e l'accelerazione sono dirette verso il centro della Terra.

#green-box([Perché scegliamo un asse, e perché compare il segno meno])[
  Per descrivere un moto con i numeri dobbiamo prima decidere "da che parte è il positivo". È come scegliere il verso di un righello verticale: una volta deciso, ogni grandezza (posizione, velocità, accelerazione) avrà segno $+$ se punta nel verso scelto, segno $-$ se punta nel verso opposto.

  La scelta più comune è prendere l'asse $y$ rivolto verso l'*alto*. Ma la gravità tira verso il *basso*, cioè nel verso opposto a quello che abbiamo chiamato positivo. Ecco perché la componente dell'accelerazione risulta negativa: $a_y = -g$. Il numero $g$ resta positivo (è solo "quanto è forte" la gravità); il meno racconta soltanto la *direzione*.
]

Se l'asse $y$ è orientato verso l'alto, l'accelerazione è $a_y=-g$. Le equazioni generali sono quindi

$ v(t)=v_0-g(t-t_0), $
$ y(t)=y_0+v_0(t-t_0)-1/2 g(t-t_0)^2, $
$ v^2=v_0^2-2g(y-y_0). $

#blue-box([Come leggere le tre equazioni])[
  Sono tre fotografie diverse dello stesso moto. Indichiamo con $y_0$ la quota di partenza, $v_0$ la velocità di partenza e $t_0$ l'istante di partenza.
  - La prima, $v(t)=v_0-g(t-t_0)$, dice *come cambia la velocità nel tempo*: parte da $v_0$ e cala (o cambia segno) di $g$ ogni secondo.
  - La seconda, $y(t)=y_0+v_0(t-t_0)-1/2 g(t-t_0)^2$, dice *dove si trova il corpo* a ogni istante: il termine $v_0(t-t_0)$ è quanto salirebbe andando dritto, il termine $-1/2 g(t-t_0)^2$ è la "correzione" dovuta alla gravità che lo frena e lo riporta giù.
  - La terza, $v^2=v_0^2-2g(y-y_0)$, *non contiene il tempo*: collega direttamente velocità e quota. È comodissima quando vuoi sapere "con che velocità arriva a una certa altezza" senza calcolare l'istante.
]

#yellow-box([Da dove vengono questi segni?])[
  Si parte dalle formule generali del moto uniformemente accelerato:
  $ v(t)=v_0+a(t-t_0), $
  $ x(t)=x_0+v_0(t-t_0)+1/2 a(t-t_0)^2, $
  $ v^2=v_0^2+2a(x-x_0). $

  Per il moto verticale si sostituisce la coordinata $x$ con $y$. Inoltre, se l'asse $y$ è positivo verso l'alto, la gravità punta verso il basso: quindi la componente dell'accelerazione è $a_y=-g$, dove $g$ è il modulo positivo dell'accelerazione gravitazionale.

  Sostituendo $x arrow y$ e $a arrow -g$ si ottiene:
  $ v(t)=v_0-g(t-t_0), $
  $ y(t)=y_0+v_0(t-t_0)-1/2 g(t-t_0)^2, $
  $ v^2=v_0^2-2g(y-y_0). $
]

Queste relazioni non sono nuove leggi: si ottengono dalle formule del moto uniformemente accelerato sostituendo $a=-g$.

#yellow-box([Attenzione ai segni])[
  Il simbolo $g$ indica il *modulo* positivo dell'accelerazione gravitazionale. Il segno della componente dipende dall'orientazione dell'asse: con $y$ verso l'alto si ha $a_y=-g$; con l'asse positivo verso il basso si avrebbe $a_y=+g$.
]

== Caduta libera da fermo

#green-box([L'idea prima della formula])[
  "Da fermo" vuol dire che semplicemente *lasci andare* l'oggetto, senza spingerlo né verso l'alto né verso il basso: la sua velocità iniziale è zero ($v_0=0$). Da quel momento la sola gravità lo accelera verso il basso. Le due domande naturali sono: *quanto tempo ci mette ad arrivare a terra?* e *con che velocità arriva?* Vediamo come le formule generali, riempite con $v_0=0$, rispondono a entrambe.
]

Un corpo lasciato da quota $h$ ha $y_0=h$ e $v_0=0$. Ponendo $t_0=0$:

$ v(t)=-g t, quad y(t)=h-1/2 g t^2. $

#yellow-box([Come si semplificano le formule generali])[
  Partiamo dalle equazioni generali e inseriamo i valori di questo caso: $t_0=0$ (così $t-t_0$ diventa semplicemente $t$), $v_0=0$ (così il termine con $v_0$ sparisce) e $y_0=h$. La velocità $v(t)=v_0-g t$ diventa $v(t)=-g t$; la posizione $y(t)=y_0+v_0 t-1/2 g t^2$ diventa $y(t)=h-1/2 g t^2$. Niente di magico: abbiamo solo cancellato i pezzi che valgono zero.
]

L'impatto con il suolo avviene quando $y(t_"cad")=0$. Pertanto

$ 0=h-1/2 g t_"cad"^2
  quad arrow quad t_"cad"^2=(2h)/g, $

#yellow-box([Perché "$y=0$" e come si ricava $t_"cad"$])[
  "Toccare il suolo" significa avere quota nulla, cioè $y=0$: per questo poniamo $y(t_"cad")=0$. Da $0=h-1/2 g t_"cad"^2$ vogliamo isolare il tempo. Portiamo a sinistra il termine con $t^2$: $1/2 g t_"cad"^2 = h$. Moltiplichiamo entrambi i lati per $2$: $g t_"cad"^2 = 2h$. Dividiamo per $g$: $t_"cad"^2=(2h)/g$. Sono i normali passaggi per "girare" un'equazione e tirare fuori l'incognita.
]

e, scegliendo la radice positiva perché il tempo di caduta è successivo al rilascio,

$ t_"cad"=sqrt((2h)/g). $

#yellow-box([Perché solo la radice positiva])[
  L'equazione $t_"cad"^2=(2h)/g$ ha matematicamente due soluzioni: $+sqrt((2h)/g)$ e $-sqrt((2h)/g)$. La seconda corrisponderebbe a un istante *prima* del rilascio, che non ha senso fisico (il corpo non era ancora stato lasciato). Teniamo quindi solo la radice positiva.
]

La velocità d'impatto si ottiene sostituendo il tempo nella legge della velocità:

$ v_"cad"=-g t_"cad"
  =-g sqrt((2h)/g)=-sqrt(2g h). $

#yellow-box([Come si semplifica $-g sqrt((2h)/g)$])[
  Vogliamo portare il fattore $g$ dentro la radice. Ricorda che $g=sqrt(g^2)$, quindi
  $ g sqrt((2h)/g)=sqrt(g^2 dot (2h)/g)=sqrt((g^2 dot 2h)/g)=sqrt(g dot 2h)=sqrt(2 g h). $
  Una $g$ al numeratore si semplifica con quella al denominatore. Con il segno meno davanti si ottiene $v_"cad"=-sqrt(2 g h)$.
]

Il segno negativo della velocità indica che il corpo si muove verso il basso; il modulo della velocità d'impatto è $sqrt(2g h)$.

#purple-box([Esempio numerico: caduta da un balcone])[
  Lasci cadere una chiave da un balcone alto $h=5 " m"$ (con $v_0=0$). Usiamo $g=9,81 " m/s"^2$.

  *Tempo di caduta:*
  $ t_"cad"=sqrt((2h)/g)=sqrt((2 dot 5)/#[9,81])=sqrt(#[1,019] " s"^2) approx 1,01 " s". $

  *Velocità d'impatto (modulo):*
  $ abs(v_"cad")=sqrt(2 g h)=sqrt(2 dot #[9,81] dot 5)=sqrt(#[98,1]) approx 9,9 " m/s". $
  Cioè circa $35 " km/h"$: la chiave arriva a terra in poco più di un secondo, abbastanza veloce. Nota che $t_"cad"$ cresce con la radice di $h$: per raddoppiare il tempo di caduta serve un'altezza *quattro* volte maggiore.
]

#red-box([Attenzione: $h$ e $g$ non si invertono])[
  Un errore frequente è scrivere $t_"cad"=sqrt((2g)/h)$ scambiando $h$ e $g$. Un controllo veloce: con $h$ maggiore il corpo deve metterci *più* tempo, quindi $h$ deve stare al numeratore. Inoltre il controllo sulle unità conferma: $sqrt((2h)/g)$ ha unità $sqrt("m"/("m/s"^2))=sqrt("s"^2)="s"$, cioè un tempo, come deve essere.
]

#align(center, graph-card([Caduta libera: posizione nel tempo], cetz.canvas({
  import cetz.draw: *
  axes(xmax: 5.5, ymax: 3.7, xlabel: [$t$], ylabel: [$y$])
  axis-label((-0.18, 3.0), [$h$], placement: "east")
  line((0, 3), (0.5, 3), stroke: 1pt + ink)
  bezier-through((0, 3), (3.2, 2.45), (4.7, 0), stroke: 1.6pt + green)
  line((4.7, 0), (4.7, 2.95), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  axis-label((4.7, -0.2), [$t_"cad"$], placement: "north")
  line((5.05, 2.9), (5.05, 1.65), stroke: 1.2pt + red, mark: (end: ">"))
  axis-label((5.2, 2.25), [$vec(g)$], placement: "west")
})))

== Lancio verticale verso l'alto

#green-box([L'idea prima della formula])[
  Immagina di lanciare una pallina dritta verso l'alto. All'inizio va veloce, poi rallenta sempre di più: la gravità la frena. A un certo punto si ferma per un istante (è il punto più alto), poi ricomincia a scendere accelerando, fino a tornarti in mano alla stessa velocità con cui era partita, ma diretta verso il basso. La gravità agisce *sempre verso il basso*, sia mentre sale sia mentre scende: per questo prima la frena e poi la accelera. Le domande naturali sono: *quanto in alto arriva?* e *quanto tempo resta in aria?*
]

Sia $y_0=0$ e $v_0>0$. Il corpo sale rallentando, raggiunge la quota massima quando $v=0$, poi ricade accelerando verso il basso:

$ cases(
  v(t)=v_0-g t,
  y(t)=v_0 t-1/2 g t^2,
) $

Le due equazioni vanno lette insieme: la prima descrive come cambia la velocità nel tempo, la seconda descrive la posizione verticale nello stesso istante $t$.

#yellow-box([Perché nel punto più alto la velocità è zero])[
  Salendo, la pallina rallenta: la velocità (positiva, verso l'alto) diventa via via più piccola. Scendendo, la velocità è negativa (verso il basso). Per passare da un valore positivo a uno negativo *deve* attraversare lo zero: quell'istante è proprio il punto più alto. Quindi all'apice $v=0$. Attenzione: la velocità è nulla, ma l'*accelerazione* no — vale ancora $-g$, ed è proprio ciò che fa ripartire la pallina verso il basso.
]

All'apice $v(t_"max")=0$, quindi

$ 0=v_0-g t_"max" quad arrow quad t_"max"=v_0/g. $

#yellow-box([Come si ricava $t_"max"$])[
  Imponiamo $v=0$ nella legge della velocità $v(t)=v_0-g t$: otteniamo $0=v_0-g t_"max"$. Spostiamo $g t_"max"$ a sinistra ($g t_"max"=v_0$) e dividiamo per $g$, ottenendo $t_"max"=v_0/g$. È il tempo di salita.
]

Sostituendo questo istante nella legge oraria,

$ h_"max"=v_0(v_0/g)-1/2 g(v_0/g)^2
  =v_0^2/(2g). $

#yellow-box([Lo sviluppo passo passo dell'altezza massima])[
  Mettiamo $t=t_"max"=v_0/g$ dentro $y(t)=v_0 t-1/2 g t^2$. Calcoliamo i due pezzi:
  $ v_0 dot v_0/g = v_0^2/g, quad 1/2 g dot (v_0/g)^2 = 1/2 g dot v_0^2/g^2 = v_0^2/(2g). $
  Quindi $h_"max"=v_0^2/g - v_0^2/(2g)$. Mettendo a denominatore comune $2g$: $v_0^2/g = (2 v_0^2)/(2g)$, perciò
  $ h_"max"=(2v_0^2)/(2g)-v_0^2/(2g)=v_0^2/(2g). $
]

Equivalentemente, dalla relazione senza tempo con $v=0$ e $y=h_"max"$:

$ 0=v_0^2-2g h_"max" quad arrow quad h_"max"=v_0^2/(2g). $

#yellow-box([La scorciatoia senza il tempo])[
  Lo stesso risultato si ottiene molto più in fretta con la terza equazione, $v^2=v_0^2-2g(y-y_0)$, che non contiene $t$. Al punto più alto $v=0$, $y=h_"max"$ e $y_0=0$: resta $0=v_0^2-2g h_"max"$, da cui $h_"max"=v_0^2/(2g)$. Due strade diverse, stesso risultato: è un buon segno che i conti tornano.
]

Riassumendo,

$ t_"max"=v_0/g, quad h_"max"=v_0^2/(2g). $

#purple-box([Esempio numerico: pallina lanciata verso l'alto])[
  Lanci una pallina verso l'alto con $v_0=20 " m/s"$. Usiamo $g=9,81 " m/s"^2$.

  *Tempo di salita:*
  $ t_"max"=v_0/g=20/9,81 approx 2,04 " s". $

  *Altezza massima:*
  $ h_"max"=v_0^2/(2g)=(20^2)/(2 dot 9,81)=400/19,62 approx 20,4 " m". $

  *Tempo totale in aria* (vedi sotto): $t_"volo"=(2v_0)/g approx 4,08 " s"$, cioè esattamente il doppio del tempo di salita.
]

Se il corpo ritorna alla stessa quota di lancio, si impone $y(t)=0$:

$ 0=v_0 t-1/2 g t^2=t(v_0-1/2 g t). $

#yellow-box([Perché si raccoglie la $t$ e cosa significano le due soluzioni])[
  L'equazione $0=v_0 t-1/2 g t^2$ ha la $t$ in entrambi i termini: possiamo *raccoglierla a fattor comune*, scrivendo $t(v_0-1/2 g t)=0$. Un prodotto è zero quando uno dei fattori è zero, quindi o $t=0$ oppure $v_0-1/2 g t=0$.

  - $t=0$ è l'istante di partenza: in effetti al lancio il corpo è alla quota zero, è una soluzione vera ma "banale".
  - L'altra, $v_0-1/2 g t=0$, dà l'istante in cui *ritorna* a quota zero. Risolvendo: $1/2 g t=v_0 arrow.r t=(2v_0)/g$.
]

Le due soluzioni sono $t=0$, istante di lancio, e

$ t_"volo"=(2v_0)/g, $

#blue-box([La simmetria salita-discesa])[
  Nota che $t_"volo"=(2v_0)/g=2 t_"max"$: il tempo per *scendere* è uguale al tempo per *salire*. La pallina impiega lo stesso tempo all'andata e al ritorno, e ripassa per la quota di lancio con velocità $-v_0$, cioè stesso modulo della partenza ma diretta verso il basso. È come riavvolgere un film: la discesa è la salita vista al contrario. Questa simmetria vale solo nelle ipotesi di campo uniforme e resistenza dell'aria trascurabile.
]

e la velocità al ritorno è $-v_0$. Questa simmetria vale nelle ipotesi di campo uniforme e resistenza dell'aria trascurabile.

#align(center, graph-card([Lancio verticale: quota nel tempo], cetz.canvas({
  import cetz.draw: *
  axes(xmax: 6.4, ymax: 3.8, xlabel: [$t$], ylabel: [$y$])
  bezier-through((0, 0), (3.0, 3.3), (5.8, 0), stroke: 1.6pt + blue)
  line((3.0, 0), (3.0, 3.25), stroke: (paint: gold, thickness: 0.8pt, dash: "dashed"))
  axis-label((3.0, -0.2), [$t_"max"$], placement: "north")
  axis-label((-0.18, 3.28), [$h_"max"$], placement: "east")
  axis-label((5.8, -0.2), [$2v_0/g$], placement: "north")
  line((0.22, 0.15), (0.22, 1.25), stroke: 1.2pt + green, mark: (end: ">"))
  axis-label((0.35, 0.85), [$v_0$], placement: "west")
})))

= Riepilogo della cinematica 1D

#green-box([L'idea prima della formula])[
  Posizione, velocità e accelerazione sono tre "piani" collegati da una scala a due gradini. *Derivare* è scendere un gradino: dalla posizione ottieni la velocità (quanto cambia la posizione ogni istante), e dalla velocità ottieni l'accelerazione (quanto cambia la velocità ogni istante). *Integrare* è risalire i gradini nel verso opposto: se conosci l'accelerazione e parti da condizioni iniziali note, ricostruisci la velocità; da questa ricostruisci la posizione. Derivata e integrale sono operazioni inverse, esattamente come moltiplicare e dividere.
]

Date le condizioni iniziali $t_0$, $x(t_0)=x_0$ e $v(t_0)=v_0$, valgono le relazioni generali

#purple-box([Catena cinematica])[
  $ v(t)=(dif x)/(dif t) quad arrow quad x(t)=x_0+integral_(t_0)^t v(tau) dif tau $

  $ a(t)=(dif v)/(dif t)=(dif^2 x)/(dif t^2) quad arrow quad v(t)=v_0+integral_(t_0)^t a(tau) dif tau $
]

#yellow-box([Come leggere queste due righe])[
  La scrittura $(dif x)/(dif t)$ è la *derivata* di $x$ rispetto al tempo: misura la rapidità con cui $x$ cambia, ed è esattamente la velocità. Allo stesso modo $(dif v)/(dif t)$ è l'accelerazione; $(dif^2 x)/(dif t^2)$ significa "deriva due volte $x$", cioè deriva la posizione per ottenere la velocità e poi ancora per ottenere l'accelerazione.

  Le frecce $arrow$ vanno nel verso inverso, quello dell'*integrale*. Il simbolo $integral_(t_0)^t v(tau) dif tau$ somma tutti i piccoli spostamenti $v dot dif tau$ dall'istante iniziale $t_0$ fino a $t$: è "l'area sotto il grafico della velocità", e dà lo spostamento totale. A questo aggiungiamo la posizione di partenza $x_0$ per sapere *dove* si trova il corpo. La lettera $tau$ (tau) è solo un nome temporaneo per il tempo che scorre dentro l'integrale, per non confonderlo con l'estremo $t$.
]

La derivazione porta dalla posizione alla velocità e poi all'accelerazione; l'integrazione, insieme alle condizioni iniziali, consente di risalire nel verso opposto.

#yellow-box([Da dove arrivano le formule del moto uniformemente accelerato])[
  Se l'accelerazione è *costante*, $a(tau)=a$, l'integrale diventa facilissimo: $integral_(t_0)^t a dif tau = a(t-t_0)$, perché stiamo sommando un valore costante su un intervallo di durata $(t-t_0)$ — è l'area di un rettangolo, base per altezza. Quindi $v(t)=v_0+a(t-t_0)$. Integrando una seconda volta questa velocità si ottiene proprio $x(t)=x_0+v_0(t-t_0)+1/2 a(t-t_0)^2$. Ecco perché tutte le formule usate prima per la gravità non sono "regole da memorizzare": discendono da questa catena, con $a=-g$.
]

= Moto armonico semplice

#green-box([L'idea prima della formula])[
  Pensa a una massa attaccata a una molla che oscilla avanti e indietro, o a un'altalena che va e torna. È un moto che *si ripete identico* a intervalli regolari: questo lo rende "periodico". La cosa straordinaria è che la posizione, nel tempo, disegna esattamente una curva a forma di onda — un seno. Per questo si chiama "armonico": è il moto più semplice e "pulito" che si ripete, lo stesso che sta dietro al suono di una corda o al battito di un orologio.
]

Il moto armonico semplice è un moto rettilineo periodico descritto da

$ x(t)=A sin(omega t+phi), $

dove $A$ è l'ampiezza, $omega$ la pulsazione e $phi$ la fase iniziale. La fase $omega t+phi$ è adimensionale e si misura in radianti.

#blue-box([Che cosa significa ogni simbolo])[
  - *$A$ (ampiezza):* è la massima distanza dal centro, in metri. La molla oscilla tra $+A$ e $-A$: è "quanto è ampio" lo spostamento.
  - *$omega$ (pulsazione o frequenza angolare):* dice *quanto è veloce* l'oscillazione, in radianti al secondo ($"rad/s"$, ovvero $"s"^(-1)$). Più $omega$ è grande, più velocemente la massa va avanti e indietro.
  - *$phi$ (fase iniziale):* è un "anticipo o ritardo" dell'onda. Stabilisce *dov'è* la massa all'istante $t=0$. Si misura in radianti.
  - *$omega t+phi$ (la fase):* è l'angolo che entra nel seno. Cresce nel tempo e fa avanzare l'oscillazione lungo un ciclo completo (da $0$ a $2pi$). È un numero puro (adimensionale): le unità di $omega t$ sono $"s"^(-1) dot "s"=1$.
]

L'ampiezza impone $-A <= x(t) <= A$. Il valore di $phi$ stabilisce la posizione nel ciclo all'istante $t=0$; per questo è detto *fase iniziale*.

#yellow-box([Perché $-A <= x(t) <= A$])[
  Il seno di qualunque angolo è sempre compreso tra $-1$ e $+1$. Moltiplicando per $A$, il prodotto $A sin(...)$ resta tra $-A$ e $+A$. Ecco perché la massa non può mai allontanarsi dal centro più di $A$: l'ampiezza è il "muro" dell'oscillazione.
]

#green-box([Periodo e frequenza: l'idea])[
  Il *periodo* $T$ è il tempo che serve per compiere *un giro completo* di oscillazione e ritrovarsi nella stessa posizione muovendosi nello stesso verso (per esempio: dal punto più a destra, fino a tornarci). La *frequenza* è la domanda inversa: *quante* oscillazioni complete fa in un secondo. Se un'altalena impiega $2$ secondi per andata-e-ritorno ($T=2 " s"$), allora fa mezza oscillazione al secondo ($nu=0,5 " Hz"$).
]

#blue-box([Periodo e frequenza])[
  Il moto si ripete dopo un periodo $T$:

  $ x(t+T)=x(t), quad T=(2pi)/omega. $

  Infatti

  $ x(t+T)=A sin[omega t+phi+omega T]. $

  Affinché coincida con $x(t)$ per ogni $t$, l'incremento minimo positivo della fase deve essere $2pi$:

  $ omega T=2pi quad arrow quad T=(2pi)/omega. $

  La frequenza è il numero di oscillazioni al secondo:

  $ nu=1/T=omega/(2pi), $

  e si misura in hertz, $1 " Hz"=1 " s"^(-1)$.
]

#yellow-box([Perché compare proprio $2pi$])[
  Il seno è una funzione che si ripete ogni $2pi$ radianti: $sin(theta+2pi)=sin(theta)$ per ogni angolo $theta$. Per ritrovare la stessa posizione dobbiamo quindi far avanzare la fase di esattamente $2pi$. Nell'espressione $x(t+T)=A sin[omega t+phi+omega T]$ il pezzo aggiunto è $omega T$: imponendo che valga $2pi$ otteniamo $omega T=2pi$, da cui $T=(2pi)/omega$. In una parola: $T$ è il tempo che la fase impiega per "fare un giro" di $2pi$.
]

#purple-box([Esempio numerico: una molla oscillante])[
  Una massa oscilla con pulsazione $omega=4pi " rad/s"$. Allora il periodo è
  $ T=(2pi)/omega=(2pi)/(4pi)=0,5 " s", $
  e la frequenza
  $ nu=1/T=1/(0,5)=2 " Hz". $
  Significa che la massa compie $2$ oscillazioni complete ogni secondo, ciascuna lunga mezzo secondo.
]

Derivando una prima volta la legge oraria si ottiene la velocità:

$ v(t)=(dif x)/(dif t)
  =A cos(omega t+phi) (dif)/(dif t)(omega t+phi)
  =A omega cos(omega t+phi). $

#yellow-box([La regola della catena, passo per passo])[
  Per derivare $A sin(omega t+phi)$ usiamo la *regola della catena*: si deriva la funzione esterna (il seno diventa coseno) e si moltiplica per la derivata di ciò che sta dentro (l'argomento $omega t+phi$). La derivata del seno è il coseno, quindi compare $A cos(omega t+phi)$; poi si moltiplica per $(dif)/(dif t)(omega t+phi)$. Ma $phi$ è una costante (la sua derivata è $0$) e la derivata di $omega t$ è $omega$. Quindi quel fattore vale semplicemente $omega$, e raccogliendo si ottiene $v(t)=A omega cos(omega t+phi)$.
]

Derivando ancora,

$ a(t)=(dif v)/(dif t)
  =-A omega sin(omega t+phi) (dif)/(dif t)(omega t+phi)
  =-A omega^2 sin(omega t+phi). $

#yellow-box([Perché compare il segno meno e una seconda $omega$])[
  Ora deriviamo $v(t)=A omega cos(omega t+phi)$. Stessa regola della catena: la derivata del coseno è $-sin$ (ecco il segno meno!), per la derivata dell'argomento che vale ancora $omega$. Mettendo tutto insieme: $A omega dot (-sin(omega t+phi)) dot omega = -A omega^2 sin(omega t+phi)$. Le due derivazioni hanno fatto "scendere" due fattori $omega$, che si moltiplicano dando $omega^2$.
]

Poiché $x(t)=A sin(omega t+phi)$,

$ a(t)=-omega^2 x(t). $

#blue-box([Il significato profondo di $a=-omega^2 x$])[
  Questa relazione è il cuore del moto armonico. Dice che l'accelerazione è sempre *proporzionale e di segno opposto* alla posizione: se la massa è spostata a destra ($x>0$), l'accelerazione la spinge a sinistra; se è a sinistra ($x<0$), la spinge a destra. C'è sempre una "forza di richiamo" verso il centro, tanto più forte quanto più la massa è lontana. È esattamente ciò che fa una molla, ed è ciò che genera l'oscillazione.
]

I valori massimi dei moduli sono quindi

$ x_"max"=A, quad v_"max"=omega A, quad a_"max"=omega^2 A. $

#yellow-box([Da dove vengono i valori massimi])[
  Seno e coseno valgono al massimo $1$ in modulo. Quindi $abs(x)=A abs(sin(...))$ arriva al più ad $A$; $abs(v)=A omega abs(cos(...))$ al più ad $omega A$; $abs(a)=A omega^2 abs(sin(...))$ al più ad $omega^2 A$. Non capitano tutti nello stesso istante: quando la posizione è massima la velocità è nulla, e viceversa (lo vedremo tra poco con gli sfasamenti).
]

Segue l'equazione differenziale caratteristica dell'oscillatore armonico:

#align(center, box(inset: 7pt, stroke: 1pt + gold, radius: 3pt)[
  $ (dif^2 x)/(dif t^2)+omega^2 x=0 $
])

#yellow-box([Come si arriva a questa equazione e perché è "caratteristica"])[
  Avevamo trovato $a(t)=-omega^2 x(t)$. Ma $a$ è la derivata seconda della posizione, cioè $a=(dif^2 x)/(dif t^2)$. Sostituendo: $(dif^2 x)/(dif t^2)=-omega^2 x$, e portando tutto a sinistra otteniamo $(dif^2 x)/(dif t^2)+omega^2 x=0$. È un'*equazione differenziale*: lega la funzione $x(t)$ alla sua derivata seconda. Si dice "caratteristica" perché *ogni* moto la cui posizione soddisfa questa equazione è automaticamente un moto armonico: chi vuole riconoscere un'oscillazione armonica cerca proprio questa forma.
]

I tre grafici qui sotto mostrano, affiancati, posizione $x(t)$, velocità $v(t)$ e accelerazione $a(t)$: sono tutte onde della stessa "forma", ma traslate l'una rispetto all'altra. Confrontale guardando dove ciascuna passa per lo zero e dove tocca i massimi.

#align(center, cetz.canvas({
  import cetz.draw: *
  // x(t)
  line((0, 0), (3.4, 0), stroke: 0.8pt + ink, mark: (end: ">"))
  line((0, -1.35), (0, 1.45), stroke: 0.8pt + ink, mark: (end: ">"))
  catmull((0, 0), (0.45, 1), (0.9, 0), (1.35, -1), (1.8, 0), (2.25, 1), (2.7, 0), (3.15, -1), tension: 0.5, stroke: 1.3pt + blue)
  axis-label((-0.12, 1.45), [$x$], placement: "east")
  axis-label((3.4, -0.15), [$t$], placement: "north")
  // v(t)
  line((4.1, 0), (7.5, 0), stroke: 0.8pt + ink, mark: (end: ">"))
  line((4.1, -1.35), (4.1, 1.45), stroke: 0.8pt + ink, mark: (end: ">"))
  catmull((4.1, 1), (4.55, 0), (5, -1), (5.45, 0), (5.9, 1), (6.35, 0), (6.8, -1), (7.25, 0), tension: 0.5, stroke: 1.3pt + green)
  axis-label((3.98, 1.45), [$v$], placement: "east")
  axis-label((7.5, -0.15), [$t$], placement: "north")
  // a(t)
  line((8.2, 0), (11.6, 0), stroke: 0.8pt + ink, mark: (end: ">"))
  line((8.2, -1.35), (8.2, 1.45), stroke: 0.8pt + ink, mark: (end: ">"))
  catmull((8.2, 0), (8.65, -1), (9.1, 0), (9.55, 1), (10, 0), (10.45, -1), (10.9, 0), (11.35, 1), tension: 0.5, stroke: 1.3pt + red)
  axis-label((8.08, 1.45), [$a$], placement: "east")
  axis-label((11.6, -0.15), [$t$], placement: "north")
}))

#green-box([Cosa vuol dire "sfasati": l'idea prima della formula])[
  Due onde sono *sfasate* quando hanno la stessa forma ma una è "in anticipo" rispetto all'altra, come due altalene che dondolano con lo stesso ritmo ma non passano per il centro nello stesso momento. Lo "sfasamento" misura di quanto una è avanti rispetto all'altra. Nel moto armonico, posizione, velocità e accelerazione hanno tutte la stessa forma d'onda, ma sono sfasate fra loro in modo fisso: ecco perché i tre grafici sembrano "la stessa curva spostata".
]

#yellow-box([Relazioni di fase])[
  Seno e coseno sono in *quadratura di fase*, cioè sfasati di $pi/2$. Perciò posizione e velocità sono sfasate di $pi/2$: quando $abs(x)$ è massimo la velocità è nulla, mentre quando il corpo attraversa l'equilibrio la velocità ha modulo massimo. Accelerazione e posizione sono in opposizione di fase, cioè sfasate di $pi$: $a=-omega^2x$.
]

#yellow-box([Perché seno e coseno sono sfasati di $pi/2$])[
  Coseno e seno sono la stessa curva traslata: vale l'identità $cos(theta)=sin(theta+pi/2)$. Quindi la velocità $v=A omega cos(omega t+phi)$ è in anticipo di $pi/2$ rispetto alla posizione $x=A sin(omega t+phi)$. Concretamente: nel momento in cui la massa è all'estremo ($abs(x)=A$) si ferma per invertire la marcia, quindi $v=0$; mentre quando passa per il centro ($x=0$) sta sfrecciando alla velocità massima $omega A$. L'accelerazione, invece, è in *opposizione di fase* con la posizione (sfasamento $pi$): punta sempre nel verso opposto allo spostamento, come dice $a=-omega^2 x$.
]

#purple-box([Esempio numerico: leggere le tre grandezze in un istante])[
  Sia $A=0,10 " m"$, $omega=4pi " rad/s"$ e fase iniziale $phi=0$, quindi $x(t)=0,10 sin(4pi t)$.

  Nell'istante $t=0$: $sin(0)=0$ e $cos(0)=1$, perciò
  $ x=0 " m", quad v=A omega=0,10 dot 4pi approx 1,26 " m/s", quad a=-omega^2 x=0 " m/s"^2. $
  Al passaggio dal centro la massa va al massimo della velocità e ha accelerazione nulla.

  Un quarto di periodo dopo, cioè a $t=T/4=0,125 " s"$ (fase $=pi/2$): $sin(pi/2)=1$, $cos(pi/2)=0$, quindi
  $ x=A=0,10 " m", quad v=0 " m/s", quad a=-omega^2 A=-(4pi)^2 dot 0,10 approx -15,8 " m/s"^2. $
  All'estremo la massa è ferma per un istante e l'accelerazione è massima (in modulo) e rivolta verso il centro: i ruoli di $x$ e $v$ si sono scambiati, proprio per lo sfasamento di $pi/2$.
]

#gray-box([Confine di questa parte])[
  Fin qui il moto è stato descritto lungo una sola retta. Il passo successivo sarà introdurre posizione, spostamento, velocità e accelerazione come vettori per studiare la cinematica in due e tre dimensioni.
]

#pagebreak()

= Cinematica in due e tre dimensioni

#green-box([L'idea prima della formula])[
  In una dimensione bastava un solo numero, $x(t)$, per dire dove si trova il corpo: era su una retta, e l'unica cosa da sapere era "quanto a destra o a sinistra" si trovasse. In due o tre dimensioni questo non basta più: un punto su un foglio, o una mosca che vola in una stanza, può stare "un po' più a destra *e* un po' più in alto *e* un po' più in avanti". Servono quindi *più numeri insieme*, e lo strumento matematico che li tiene insieme è il *vettore*.

  Pensa al raggio vettore $vec(r)$ come a una *freccia che parte sempre dall'origine* $O$ e arriva fino al corpo. La freccia ti dice due cose in un colpo solo: *quanto è lontano* il corpo (la lunghezza della freccia) e *in che direzione* sta (dove punta). Spostarsi nello spazio significa far cambiare questa freccia istante per istante.
]

#blue-box([Che cosa sono i versori $hat(i)$, $hat(j)$, $hat(k)$])[
  I *versori* $hat(i)$, $hat(j)$, $hat(k)$ sono tre frecce speciali, di lunghezza esattamente $1$ (per questo sopra la lettera c'è il "cappello", il simbolo $hat(\ )$, che vuol dire proprio "versore", cioè vettore di modulo unitario). Ciascuno punta lungo uno dei tre assi: $hat(i)$ lungo $x$, $hat(j)$ lungo $y$, $hat(k)$ lungo $z$. Sono come tre "direzioni campione", i righelli unitari del nostro sistema di assi.

  Scrivere $x hat(i)$ significa "fai $x$ passi lunghi $1$ nella direzione di $x$". Allora la scrittura
  $ vec(r)=x hat(i)+y hat(j)+z hat(k) $
  va letta come una ricetta: "vai $x$ a destra, poi $y$ in alto, poi $z$ in avanti": sommando questi tre spostamenti elementari arrivi esattamente dove sta il corpo. I numeri $x$, $y$, $z$ si chiamano *componenti* del vettore e dicono "quanto" di ciascuna direzione serve.
]

Quando il punto materiale non è vincolato a una retta, la sua posizione è descritta dal *raggio vettore*

$ vec(r)(t)=x(t) hat(i)+y(t) hat(j)+z(t) hat(k). $

Le tre funzioni $x(t)$, $y(t)$ e $z(t)$ sono le coordinate cartesiane del punto: ognuna è la distanza con segno del corpo dall'origine lungo il rispettivo asse, e si misura in metri. Il fatto che dipendano dal tempo $t$ vuol dire che, mentre il corpo si muove, questi tre numeri cambiano. Al variare del tempo, l'estremo di $vec(r)(t)$ (la punta della freccia) disegna nello spazio la *traiettoria*, cioè la "scia" che il corpo lascia passando.

#align(center, graph-card([Posizione e spostamento nello spazio], cetz.canvas({
  import cetz.draw: *
  // assi cartesiani in proiezione obliqua
  line((0, 0), (5.2, 0), stroke: 0.9pt + ink, mark: (end: ">"))
  line((0, 0), (0, 3.7), stroke: 0.9pt + ink, mark: (end: ">"))
  line((0, 0), (-2.1, -1.45), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((5.2, -0.17), [$x$], placement: "north")
  axis-label((-0.15, 3.7), [$y$], placement: "east")
  axis-label((-2.1, -1.55), [$z$], placement: "north")
  // due posizioni del punto materiale
  circle((1.25, 2.28), radius: 0.08, fill: blue, stroke: none)
  circle((3.15, 2.18), radius: 0.08, fill: red, stroke: none)
  line((0, 0), (1.25, 2.28), stroke: 1.2pt + green, mark: (end: ">"))
  line((0, 0), (3.15, 2.18), stroke: 1.2pt + gold, mark: (end: ">"))
  line((1.25, 2.28), (3.15, 2.18), stroke: 1.3pt + red, mark: (end: ">"))
  axis-label((0.45, 1.35), [$vec(r)(t)$], placement: "east")
  axis-label((2.45, 1.35), [$vec(r)(t+Delta t)$], placement: "west")
  axis-label((2.18, 2.43), [$Delta vec(r)$], placement: "south")
  axis-label((1.05, 2.55), [$P(t)$], placement: "south")
  axis-label((3.45, 2.05), [$P(t+Delta t)$], placement: "west")
})))

Il punto $P(t)$ rappresenta la posizione occupata dal corpo all'istante $t$: geometricamente è l'estremo del vettore posizione $vec(r)(t)$. Allo stesso modo, $P(t+Delta t)$ è la posizione occupata a un istante successivo.

#green-box([L'idea prima della formula])[
  Lo *spostamento* risponde alla domanda: "rispetto a prima, di quanto e in che direzione mi sono mosso?". È la freccia che va dalla posizione vecchia a quella nuova. Se ero in $P(t)$ e ora sono in $P(t+Delta t)$, lo spostamento è la freccia diretta che unisce i due punti, *senza curve*: non importa che strada tortuosa abbia fatto in mezzo, conta solo dove ero e dove sono finito.
]

Tra gli istanti $t$ e $t+Delta t$, il *vettore spostamento* è

$ Delta vec(r)=vec(r)(t+Delta t)-vec(r)(t). $

#yellow-box([Perché si sottraggono i due vettori])[
  È la stessa logica del $Delta$ che già conosci in una dimensione: "variazione" significa sempre *valore finale meno valore iniziale*. Qui i "valori" sono due frecce, e si sottraggono componente per componente:
  $ Delta vec(r)=(x_2-x_1) hat(i)+(y_2-y_1) hat(j)+(z_2-z_1) hat(k), $
  dove $1$ indica l'istante $t$ e $2$ l'istante $t+Delta t$. Geometricamente "freccia di arrivo meno freccia di partenza" dà proprio la freccia che congiunge la punta della prima alla punta della seconda: è la regola del triangolo per la sottrazione di vettori.
]

Lo spostamento dipende soltanto dagli estremi, non dal percorso seguito; la sua norma (cioè la sua lunghezza, scritta $norm(Delta vec(r))$) è in generale minore o uguale alla lunghezza dell'arco di traiettoria effettivamente percorso. Il motivo intuitivo: la freccia "in linea retta" tra due punti è sempre la scorciatoia più corta, mentre la traiettoria reale può girare e allungarsi.

#blue-box([Vettori e coordinate])[
  Un vettore geometrico non dipende dal sistema di coordinate scelto, mentre cambiano le sue componenti. Le uguaglianze vettoriali restano valide dopo una rotazione o una traslazione degli assi.
]

== Velocità vettoriale

#green-box([L'idea prima della formula])[
  In una dimensione la velocità era "spazio percorso diviso tempo". Qui è esattamente lo stesso, ma lo "spazio percorso" è diventato una freccia (lo spostamento $Delta vec(r)$). Dividere una freccia per un numero positivo come $Delta t$ *non cambia la sua direzione*: la accorcia o la allunga soltanto. Perciò la velocità è una freccia che punta nello stesso verso dello spostamento, cioè *nel verso in cui il corpo si sta muovendo*. La velocità vettoriale, oltre a dire "quanto vado veloce", dice anche "verso dove vado".
]

La velocità media e quella istantanea sono

$ vec(v)_"media"=(Delta vec(r))/(Delta t), quad vec(v)(t)=(dif vec(r))/(dif t). $

#yellow-box([Dal media all'istantanea: cosa fa la derivata])[
  La velocità media usa un intervallo $Delta t$ "lungo": ti dà solo un valore mediato, una specie di riassunto. Per sapere la velocità *in un singolo istante* si fa diventare $Delta t$ piccolissimo, tendente a zero: questo è esattamente il significato della derivata $(dif vec(r))/(dif t)$. È lo stesso identico passaggio della cinematica 1D, solo che qui $vec(r)$ è un vettore: quando $Delta t arrow 0$, la freccia $Delta vec(r)$ si adagia sulla traiettoria e diventa tangente ad essa.
]

In coordinate cartesiane, con versori fissi,

$ vec(v)=v_x hat(i)+v_y hat(j)+v_z hat(k)
  =(dif x)/(dif t) hat(i)+(dif y)/(dif t) hat(j)+(dif z)/(dif t) hat(k). $

#yellow-box([Perché si deriva "una componente alla volta"])[
  I versori $hat(i)$, $hat(j)$, $hat(k)$ sono *fissi*: puntano sempre nelle stesse direzioni e non cambiano nel tempo. Allora, derivando $vec(r)=x hat(i)+y hat(j)+z hat(k)$, i versori si comportano come costanti e "escono" dalla derivata, mentre a cambiare sono solo i numeri $x(t)$, $y(t)$, $z(t)$. Il risultato è che ogni componente della velocità è la derivata della rispettiva coordinata:
  $ v_x=(dif x)/(dif t), quad v_y=(dif y)/(dif t), quad v_z=(dif z)/(dif t). $
  Questo è il cuore di tutto: *un moto in più dimensioni si studia come tanti moti in una dimensione che avvengono in parallelo*, uno per ogni asse, e poi si rimettono insieme. È la ragione per cui "si scompone il moto sugli assi".
]

Il vettore velocità istantanea è *tangente alla traiettoria* e orientato nel verso del moto.

#green-box([L'idea prima della formula: l'ascissa curvilinea $s$])[
  Immagina di camminare lungo un sentiero curvo e di avere un contachilometri che misura *quanta strada hai fatto seguendo il sentiero*, non in linea d'aria. Questo "contachilometri lungo la curva" è l'*ascissa curvilinea* $s$: la distanza percorsa misurata sulla traiettoria stessa. Allora $(dif s)/(dif t)$ è "quanti metri di sentiero copri ogni secondo", cioè quanto vai veloce *come numero*, senza preoccuparti della direzione.
]

Introducendo l'ascissa curvilinea $s$, cioè la distanza misurata lungo la traiettoria,

$ vec(v)=(dif s)/(dif t) hat(u)_T=v hat(u)_T, $

dove $v=norm(vec(v))=(dif s)/(dif t)$ è la velocità scalare e $hat(u)_T$ è il versore tangente. Questa scrittura *separa due informazioni*: il numero $v$ (quanto vai veloce) e il versore $hat(u)_T$ (in che direzione vai). È la stessa idea di prima, ma resa esplicita.

#yellow-box([Che cos'è $hat(u)_T$?])[
  Il simbolo $hat(u)_T$ indica il *versore tangente*: un vettore di modulo $1$ applicato nel punto della traiettoria occupato dal corpo. La lettera $T$ sta per "tangente".

  Esso non dice quanto è grande la velocità, ma solo in quale direzione punta. Per questo la velocità vettoriale si scrive
  $ vec(v)=v hat(u)_T: $
  il numero $v$ dà il modulo della velocità, mentre $hat(u)_T$ dà la direzione tangente e il verso del moto.
]

#align(center, graph-card([La velocità è tangente alla traiettoria], cetz.canvas({
  import cetz.draw: *
  // semicirconferenza di centro O e raggio R
  // In CeTZ `position` è il punto iniziale dell'arco: partendo da
  // (5.5, 0) con raggio 2.5, il centro geometrico è O = (3, 0).
  arc((5.5, 0), start: 0deg, stop: 180deg, radius: 2.5, stroke: 1.7pt + blue)
  circle((3, 0), radius: 0.07, fill: ink, stroke: none)
  // punto P nel punto superiore della semicirconferenza
  circle((3, 2.5), radius: 0.09, fill: ink, stroke: none)
  // raggio e velocità tangente, tra loro perpendicolari
  line((3, 0), (3, 2.5), stroke: 1.3pt + green, mark: (end: ">"))
  line((3, 2.5), (5.05, 2.5), stroke: 1.6pt + red, mark: (end: ">"))
  line((3, 2.18), (3.92, 2.18), stroke: 1.3pt + gold, mark: (end: ">"))
  axis-label((2.85, 2.68), [$P$], placement: "east")
  axis-label((2.82, 1.25), [$R$], placement: "east")
  axis-label((5.18, 2.5), [$vec(v)$], placement: "west")
  axis-label((4.02, 2.18), [$hat(u)_T$], placement: "west")
  axis-label((2.85, -0.15), [$O$], placement: "east")
})))

== Accelerazione vettoriale

#green-box([L'idea prima della formula])[
  L'accelerazione misura "quanto cambia la velocità". Ma attenzione: la velocità è una *freccia*, e una freccia può cambiare in due modi distinti. Può *allungarsi o accorciarsi* (vai più veloce o più lento, ma sempre dritto) oppure può *ruotare* (vai alla stessa velocità ma stai curvando). In entrambi i casi la freccia velocità è cambiata, quindi in entrambi i casi c'è accelerazione.

  Questo è il punto che spesso confonde: *anche andando a velocità costante in una curva, stai accelerando*, perché la direzione cambia. La derivata coglie tutti e due gli effetti insieme.
]

L'accelerazione è la derivata della velocità vettoriale:

$ vec(a)(t)=(dif vec(v))/(dif t)=(dif^2 vec(r))/(dif t^2). $

Quindi una particella accelera sia quando cambia il modulo della velocità, sia quando ne cambia la direzione. Per separare questi due effetti scriviamo la velocità come $vec(v)=v hat(u)_T$ (modulo $v$ per direzione $hat(u)_T$) e deriviamo.

#yellow-box([Perché compaiono due termini: la regola del prodotto])[
  $vec(v)=v hat(u)_T$ è un prodotto tra due cose che cambiano *entrambe* nel tempo: il numero $v$ (la velocità può aumentare) e il versore $hat(u)_T$ (la direzione tangente può ruotare). Quando si deriva un prodotto si applica la regola di Leibniz, "derivata del primo per il secondo, più il primo per la derivata del secondo":
  $ (dif)/(dif t)[v hat(u)_T]=underbrace((dif v)/(dif t) hat(u)_T, "cambia il modulo")+underbrace(v (dif hat(u)_T)/(dif t), "cambia la direzione"). $
  Ecco da dove vengono i due pezzi: il primo è l'effetto "vado più veloce", il secondo è l'effetto "sto curvando".
]

$ vec(a)=(dif)/(dif t)[v hat(u)_T]
  =(dif v)/(dif t) hat(u)_T+v (dif hat(u)_T)/(dif t). $

Resta da capire quanto vale $(dif hat(u)_T)/(dif t)$, cioè come cambia la direzione tangente quando si curva.

#yellow-box([Da dove esce $dif hat(u)_T = hat(u)_N dif theta$])[
  Il versore tangente $hat(u)_T$ ha sempre lunghezza $1$: non può allungarsi, può solo *ruotare*. Se in un piccolo intervallo di tempo la tangente ruota di un angolo minuscolo $dif theta$, la sua punta si sposta lungo un archetto di raggio $1$, e questo spostamento è lungo $1 dot dif theta=dif theta$. Inoltre punta in una direzione *perpendicolare* a $hat(u)_T$ (quando ruoti una freccia, la variazione è sempre di traverso ad essa): questa direzione perpendicolare, rivolta verso l'interno della curva, è il *versore normale* $hat(u)_N$. Mettendo insieme modulo e direzione della variazione:
  $ dif hat(u)_T=hat(u)_N dif theta. $
]

Per due tangenti separate da un piccolo angolo $dif theta$, la variazione del versore tangente è diretta lungo la normale e vale

$ dif hat(u)_T=hat(u)_N dif theta. $

#yellow-box([Da dove esce $dif s = R dif theta$ e quindi $(dif theta)/(dif t)=v/R$])[
  $R$ è il *raggio di curvatura*: localmente la traiettoria curva come se fosse un pezzetto di circonferenza di raggio $R$ (curva stretta $arrow$ $R$ piccolo; curva quasi dritta $arrow$ $R$ grande). Su una circonferenza, la lunghezza di un arco è "raggio per angolo (in radianti)": percorrendo un archetto lungo $dif s$ ci si sposta di un angolo $dif theta=dif s slash R$, cioè
  $ dif s=R dif theta. $
  Dividendo entrambi i membri per $dif t$:
  $ (dif theta)/(dif t)=1/R (dif s)/(dif t)=v/R, $
  perché $(dif s)/(dif t)=v$ è proprio la velocità scalare. In parole: più vai veloce e più stretta è la curva, più rapidamente la direzione del moto ruota.
]

Inoltre, dalla geometria dell'arco di raggio di curvatura $R$,

$ dif s=R dif theta quad arrow quad
  (dif theta)/(dif t)=1/R (dif s)/(dif t)=v/R. $

Di conseguenza

$ (dif hat(u)_T)/(dif t)
  =hat(u)_N (dif theta)/(dif t)=v/R hat(u)_N, $

e sostituendo nella derivata di $vec(v)$:

#yellow-box([Come si combina tutto e perché esce $v^2 slash R$])[
  Riprendiamo $vec(a)=(dif v)/(dif t) hat(u)_T+v (dif hat(u)_T)/(dif t)$ e mettiamo dentro $(dif hat(u)_T)/(dif t)=v/R hat(u)_N$:
  $ vec(a)=(dif v)/(dif t) hat(u)_T+v dot v/R hat(u)_N=(dif v)/(dif t) hat(u)_T+v^2/R hat(u)_N. $
  Nel secondo termine compare $v dot v=v^2$: ecco perché l'accelerazione "di curva" cresce con il *quadrato* della velocità. Raddoppiare la velocità in curva quadruplica l'accelerazione necessaria (motivo per cui in curva si frena molto).
]

$ vec(a)=underbrace((dif v)/(dif t) hat(u)_T, vec(a)_T)
  +underbrace(v^2/R hat(u)_N, vec(a)_N). $

Qui $R$ è il raggio di curvatura locale e $hat(u)_N$ è diretto verso il centro di curvatura. Pertanto

$ vec(a)=vec(a)_T+vec(a)_N, quad
  a_T=(dif v)/(dif t), quad a_N=v^2/R. $

#blue-box([Le due facce dell'accelerazione])[
  L'accelerazione si scompone *sempre* in due pezzi perpendicolari tra loro:
  - $vec(a)_T=(dif v)/(dif t) hat(u)_T$, *tangenziale*, lungo il moto: cambia *quanto vai veloce* (accelerare o frenare). È zero se la velocità scalare è costante.
  - $vec(a)_N=v^2/R hat(u)_N$, *normale* o *centripeta*, perpendicolare al moto e rivolta verso l'interno della curva: cambia *la direzione*. È zero solo se vai dritto ($R$ infinito).
]

#grid(columns: (1fr, 1fr), gutter: 10pt,
  graph-card([Moto curvilineo generico], cetz.canvas({
    import cetz.draw: *
    // traiettoria locale: in P la tangente ha la direzione di a_T
    // e la concavita' e' rivolta verso a_N
    catmull((0.1, 0.68), (1.23, 0.70), (2.2, 1.0), (3.03, 1.60), (3.71, 2.48),
      tension: 0.55, stroke: 1.5pt + blue)
    circle((2.2, 1.0), radius: 0.08, fill: ink, stroke: none)
    // a_T tangente alla traiettoria
    line((2.2, 1.0), (3.45, 1.63), stroke: 1.4pt + green, mark: (end: ">"))
    // a_N normale, rivolta verso la concavità
    line((2.2, 1.0), (1.55, 2.3), stroke: 1.4pt + red, mark: (end: ">"))
    // risultante a = a_T + a_N e parallelogramma tratteggiato
    line((2.2, 1.0), (2.8, 2.93), stroke: 1.5pt + gold, mark: (end: ">"))
    line((3.45, 1.63), (2.8, 2.93), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
    line((1.55, 2.3), (2.8, 2.93), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
    axis-label((3.52, 1.62), [$vec(a)_T$], placement: "west")
    axis-label((1.48, 2.38), [$vec(a)_N$], placement: "east")
    axis-label((2.9, 2.98), [$vec(a)$], placement: "west")
    axis-label((2.05, 0.88), [$P$], placement: "east")
  })),
  graph-card([Moto a velocità costante], cetz.canvas({
    import cetz.draw: *
    // arco di circonferenza con centro C=(2.3,0.2) e raggio R=1.5
    arc((3.8, 0.2), start: 0deg, stop: 180deg, radius: 1.5, stroke: 1.5pt + blue)
    circle((2.3, 0.2), radius: 0.06, fill: ink, stroke: none)
    circle((2.3, 1.7), radius: 0.08, fill: ink, stroke: none)
    // raggio, velocità tangente e accelerazione centripeta
    line((2.3, 0.2), (2.3, 1.7), stroke: 1pt + grid-color)
    line((2.3, 1.7), (3.75, 1.7), stroke: 1.4pt + green, mark: (end: ">"))
    line((2.3, 1.7), (2.3, 0.45), stroke: 1.4pt + red, mark: (end: ">"))
    axis-label((3.86, 1.7), [$vec(v)$], placement: "west")
    axis-label((2.48, 1.02), [$vec(a)=vec(a)_N$], placement: "west")
    axis-label((2.12, 0.08), [$C$], placement: "east")
    axis-label((2.12, 0.9), [$R$], placement: "east")
    axis-label((2.15, 1.88), [$P$], placement: "east")
    axis-label((4.05, 0.45), [$a_T=0$], placement: "west")
  })),
)

#yellow-box([Caso importante])[
  Se il modulo $v$ è costante, $a_T=0$, ma l'accelerazione può essere diversa da zero perché la velocità cambia direzione. In tal caso resta soltanto l'accelerazione normale o centripeta.
]

#gray-box([Dove siamo])[
  Finora abbiamo "derivato": dalla posizione abbiamo ricavato velocità e accelerazione. Ora facciamo il percorso inverso, "integrare": data l'accelerazione, ricostruire velocità e posizione. È utilissimo, perché di solito in fisica si conosce la forza (e quindi l'accelerazione) e si vuole prevedere il moto.
]

Le relazioni integrali, valide componente per componente, generalizzano quelle della cinematica 1D:

$ vec(v)(t)=vec(v)(t_0)+integral_(t_0)^t vec(a)(tau) dif tau, $
$ vec(r)(t)=vec(r)(t_0)+integral_(t_0)^t vec(v)(tau) dif tau. $

#yellow-box([Come leggere queste formule])[
  L'integrale è "la somma di tanti piccoli contributi". Sommando tutte le piccole variazioni di velocità $vec(a) dif tau$ accumulate da $t_0$ a $t$, si ottiene quanto è cambiata la velocità in totale; aggiungendola alla velocità di partenza $vec(v)(t_0)$ si ha la velocità all'istante $t$. Lo stesso vale per la posizione, sommando gli spostamentini $vec(v) dif tau$. La variabile $tau$ è solo un nome "muto" per il tempo che scorre dentro l'integrale, mentre $t$ è l'istante finale a cui guardiamo. *Valide componente per componente* significa: queste formule si applicano separatamente a $x$, $y$, $z$, di nuovo perché il moto si scompone sugli assi.
]

= Moto parabolico

#green-box([L'idea prima della formula])[
  È il moto di un sasso lanciato, di un pallone calciato, di un proiettile: parte con una certa velocità e poi la gravità lo tira giù. Il trucco geniale per studiarlo è quello visto sopra: *scomporre il moto sui due assi e trattarli separatamente*.

  - Lungo l'*orizzontale* ($x$) non agisce nessuna forza (trascuriamo l'aria): quindi orizzontalmente il corpo va a *velocità costante*, come se nulla lo disturbasse.
  - Lungo la *verticale* ($y$) agisce solo la gravità: quindi verticalmente è un *moto uniformemente accelerato*, esattamente come una caduta o un lancio verso l'alto.

  La cosa sorprendente è che questi due moti *non si influenzano a vicenda*: il tempo che il sasso impiega a cadere è lo stesso che impiegherebbe se lo lasciassi cadere da fermo, indipendentemente da quanto velocemente lo lanci in avanti. La curva parabolica che vediamo è solo il risultato di combinare "vado avanti a velocità costante" con "cado accelerando".
]

Consideriamo un proiettile lanciato con velocità iniziale $vec(v)_0$ in un campo gravitazionale uniforme, trascurando la resistenza dell'aria. Scelti $x$ orizzontale, $y$ verticale verso l'alto e $z$ perpendicolare al piano del moto,

$ vec(a)=(0,-g,0), quad vec(v)_0=(v_(0x),v_(0y),0). $

#yellow-box([Perché i segni e gli zeri sono così])[
  - $vec(a)=(0,-g,0)$: l'unica accelerazione è la gravità. È *zero* in orizzontale (niente forza lungo $x$) e lungo $z$; è $-g$ lungo $y$. Il segno *meno* c'è perché abbiamo scelto $y$ rivolto verso l'alto, mentre la gravità tira verso il *basso*: una grandezza che punta in verso opposto all'asse ha componente negativa. Qui $g approx 9,81 " m/s"^2$.
  - $vec(v)_0=(v_(0x),v_(0y),0)$: la velocità iniziale ha una parte orizzontale e una verticale, ma niente lungo $z$. Per questo il moto resta intrappolato nel piano $x y$: non c'è nulla che spinga il corpo "fuori dal foglio".
]

Il moto rimane nel piano $x y$. Le componenti evolvono indipendentemente:

#blue-box([Leggi orarie del moto parabolico])[
  $ v_x(t)=v_(0x), quad x(t)=x_0+v_(0x)t, $

  $ v_y(t)=v_(0y)-g t, quad y(t)=y_0+v_(0y)t-1/2 g t^2. $
]

Lungo $x$ il moto è uniforme; lungo $y$ è uniformemente accelerato.

#yellow-box([Perché "eliminare il tempo"])[
  Le leggi orarie ci dicono dove sta il corpo *istante per istante*: $x(t)$ e $y(t)$ separati. Ma se voglio disegnare la *forma* della traiettoria sul foglio, mi serve una relazione diretta tra $y$ e $x$, senza il tempo di mezzo. Il trucco: dalla legge $x=x_0+v_(0x)t$ ricavo il tempo,
  $ t=(x-x_0)/v_(0x), $
  e lo sostituisco dentro $y(t)$. Così il tempo "sparisce" e resta solo $y$ in funzione di $x$: la curva che vedo nello spazio.
]

Eliminando $t=(x-x_0)/v_(0x)$ si ottiene la traiettoria:

$ y-y_0=v_(0y)t-1/2 g t^2, $

$ y-y_0=v_(0y)(x-x_0)/v_(0x)
  -1/2 g[(x-x_0)/v_(0x)]^2, $

$ y(x)=y_0+(v_(0y))/(v_(0x))(x-x_0)-g/(2v_(0x)^2)(x-x_0)^2. $

È una parabola con concavità verso il basso.

#yellow-box([Perché concavità verso il basso?])[
  Guarda l'ultimo termine: $-g slash (2v_(0x)^2) (x-x_0)^2$. È un termine in $(x-x_0)^2$ con coefficiente *negativo* (per via del $-g$). In una parabola $y=a x^2+...$, se $a<0$ la curva è "a cupola", cioè con la concavità verso il basso. Fisicamente: la gravità tira sempre giù, quindi il proiettile sale, rallenta, si ferma in alto e ricade: la classica campana.
]

#align(center, graph-card([Scomposizione del moto di un proiettile], cetz.canvas({
  import cetz.draw: *
  // riferimento tridimensionale Oxyz; il moto avviene nel piano xy
  line((1, 0.5), (7.25, 0.5), stroke: 0.9pt + ink, mark: (end: ">"))
  line((1, 0.5), (1, 4.55), stroke: 0.9pt + ink, mark: (end: ">"))
  line((1, 0.5), (-0.15, -0.55), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((7.25, 0.32), [$x$], placement: "north")
  axis-label((0.85, 4.55), [$y$], placement: "east")
  axis-label((-0.18, -0.65), [$z$], placement: "north")
  axis-label((0.82, 0.3), [$O$], placement: "east")
  // traiettoria parabolica dal punto di lancio alla quota iniziale
  bezier-through((1, 0.5), (3.72, 3.18), (6.65, 0.5), stroke: 1.7pt + blue)
  // velocità iniziale e angolo di lancio
  line((1, 0.5), (2.15, 2.25), stroke: 1.5pt + green, mark: (end: ">"))
  arc((1.72, 0.5), start: 0deg, stop: 57deg, radius: 0.72, stroke: 1pt + gold)
  axis-label((1.63, 1.55), [$vec(v)_0$], placement: "east")
  axis-label((1.68, 0.82), [$theta$], placement: "south")
  // altezza massima
  line((1, 3.18), (4.6, 3.18), stroke: (paint: gold, thickness: 0.9pt, dash: "dashed"))
  line((3.72, 0.5), (3.72, 3.18), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  axis-label((1.2, 3.35), [$h_"max"$], placement: "west")
  // accelerazione gravitazionale costante
  line((5.35, 4.0), (5.35, 2.8), stroke: 1.4pt + red, mark: (end: ">"))
  axis-label((5.52, 3.4), [$vec(g)$], placement: "west")
})))

#yellow-box([Perché $v_(0x)=v_0 cos theta$ e $v_(0y)=v_0 sin theta$])[
  La velocità iniziale $vec(v)_0$ è una freccia di lunghezza $v_0$ inclinata di un angolo $theta$ rispetto all'orizzontale (l'angolo di lancio). Per scomporla sui due assi si usa la trigonometria del triangolo rettangolo che ha la freccia come ipotenusa:
  - la componente orizzontale è il *cateto adiacente* all'angolo: $v_(0x)=v_0 cos theta$;
  - la componente verticale è il *cateto opposto*: $v_(0y)=v_0 sin theta$.

  Controllo dei casi limite: se $theta=0$ (lancio orizzontale) allora $cos 0=1$ e $sin 0=0$, cioè tutta la velocità è orizzontale; se $theta=90 degree$ (lancio dritto verso l'alto) allora $cos 90 degree=0$ e $sin 90 degree=1$, tutta verticale. Tornano entrambi.
]

Se il lancio avviene dall'origine e il proiettile torna alla quota iniziale, ponendo
$v_(0x)=v_0 cos theta$ e $v_(0y)=v_0 sin theta$ si ricavano:

All'altezza massima $v_y=0$:

#yellow-box([Perché nel punto più alto $v_y=0$])[
  Nel punto più alto della traiettoria il corpo smette di salire e sta per ricominciare a scendere: in quell'istante la sua velocità *verticale* è esattamente zero (è il momento di inversione, come quando lanci una palla in alto e per un attimo "si ferma" prima di tornare giù). Attenzione: $v_x$ non è zero, il corpo continua ad avanzare in orizzontale. Imponendo $v_y=v_0 sin theta-g t=0$ e isolando $t$ si trova l'istante del culmine.
]

$ 0=v_0 sin theta-g t_"max"
  quad arrow quad t_"max"=(v_0 sin theta)/g. $

La quota massima segue sostituendo $t_"max"$ in $y(t)$:

#yellow-box([Il conto dell'altezza massima passo passo])[
  Si mette $t_"max"=(v_0 sin theta) slash g$ dentro $y(t)=v_0 sin theta dot t-1/2 g t^2$ (qui $y_0=0$). Chiamiamo per comodità $A=v_0 sin theta$, così $t_"max"=A slash g$:
  $ h_"max"=A dot A/g-1/2 g (A/g)^2=A^2/g-1/2 A^2/g=1/2 A^2/g. $
  Il primo termine vale $A^2 slash g$, il secondo è la sua metà, quindi la differenza è metà: resta $1/2 A^2 slash g$. Ripristinando $A=v_0 sin theta$:
  $ h_"max"=(v_0^2 sin^2 theta)/(2g). $
]

$ h_"max"=v_0 sin theta (v_0 sin theta)/g
  -1/2 g (v_0 sin theta/g)^2
  =(v_0^2 sin^2 theta)/(2g). $

Per tornare a $y=0$:

#yellow-box([Perché si raccoglie $t$ e si scarta $t=0$])[
  La condizione "il corpo è di nuovo a terra" è $y=0$. Con $y_0=0$:
  $ 0=v_0 sin theta dot t-1/2 g t^2. $
  Raccogliendo $t$ a fattor comune: $0=t(v_0 sin theta-1/2 g t)$. Un prodotto è zero quando uno dei due fattori è zero, quindi ci sono due soluzioni: $t=0$ (l'istante del lancio, quando ovviamente era a terra: la scartiamo perché è la partenza) e quella che annulla la parentesi, che è il momento dell'atterraggio.
]

$ 0=t(v_0 sin theta-1/2 g t), $

da cui, esclusa la soluzione iniziale $t=0$,

$ t_"volo"=(2v_0 sin theta)/g. $

La gittata è la posizione orizzontale a questo istante:

#yellow-box([Da dove esce $sin(2theta)$])[
  La *gittata* $L$ è quanto lontano è arrivato il corpo in orizzontale. Siccome in orizzontale va a velocità costante $v_0 cos theta$, basta moltiplicare per il tempo totale di volo: $L=v_0 cos theta dot t_"volo"$. Sostituendo $t_"volo"$:
  $ L=v_0 cos theta dot (2v_0 sin theta)/g=(2 v_0^2 sin theta cos theta)/g. $
  A questo punto si usa l'*identità di duplicazione* $2 sin theta cos theta=sin(2theta)$ (una formula trigonometrica nota), che rende il risultato più compatto:
  $ L=(v_0^2 sin(2theta))/g. $
]

$ L=v_0 cos theta t_"volo"
  =(2v_0^2 sin theta cos theta)/g
  =(v_0^2 sin(2theta))/g. $

#purple-box([Risultati del lancio obliquo])[
  $ t_"max"=(v_0 sin theta)/g, quad
    h_"max"=(v_0^2 sin^2 theta)/(2g), $

  $ t_"volo"=(2v_0 sin theta)/g, quad
    L=(v_0^2 sin(2theta))/g. $
]

La formula della gittata $L$ vale soltanto quando quota iniziale e finale coincidono. A parità di $v_0$, la gittata è massima per $theta=45 degree$.

#yellow-box([Perché proprio $45 degree$?])[
  Nella gittata $L=v_0^2 sin(2theta) slash g$, l'unico pezzo che dipende dall'angolo è $sin(2theta)$. Il seno è massimo (vale $1$) quando il suo argomento è $90 degree$. Quindi serve $2theta=90 degree$, cioè $theta=45 degree$. È un bel risultato: per tirare il più lontano possibile (a parità di forza nel lancio) conviene puntare a metà strada tra orizzontale e verticale. Nota anche la simmetria: $theta=30 degree$ e $theta=60 degree$ danno la stessa gittata, perché $sin(60 degree)=sin(120 degree)$.
]

#purple-box([Esempio numerico: un pallone calciato])[
  Un pallone parte da terra con $v_0=20 " m/s"$ a un angolo $theta=30 degree$. Usiamo $g=9,81 " m/s"^2$, $sin 30 degree=0,5$, $cos 30 degree approx 0,866$, $sin(60 degree) approx 0,866$.

  *Componenti della velocità iniziale:*
  $ v_(0x)=20 dot 0,866 approx 17,3 " m/s", quad
    v_(0y)=20 dot 0,5=10 " m/s". $

  *Tempo per arrivare al punto più alto:*
  $ t_"max"=(v_0 sin theta)/g=(10)/(9,81) approx 1,02 " s". $

  *Altezza massima:*
  $ h_"max"=(v_0^2 sin^2 theta)/(2g)
    =(20^2 dot 0,5^2)/(2 dot 9,81)
    =(100)/(19,62) approx 5,1 " m". $

  *Tempo totale di volo* (il doppio di $t_"max"$, per simmetria salita/discesa):
  $ t_"volo"=(2 v_0 sin theta)/g=(2 dot 10)/(9,81) approx 2,04 " s". $

  *Gittata:*
  $ L=(v_0^2 sin(2theta))/g=(20^2 dot 0,866)/(9,81)
    =(346,4)/(9,81) approx 35,3 " m". $

  Controllo di sanità: a $45 degree$ la gittata sarebbe $L=20^2 dot 1 slash 9,81 approx 40,8 " m"$, cioè di più, come ci aspettiamo dato che $45 degree$ è l'angolo ottimale.
]

= Moto circolare uniforme

#green-box([L'idea prima della formula])[
  È il moto di qualcosa che gira in tondo a velocità di rotazione costante: una giostra, la lancetta di un orologio, una pietra fatta roteare con una corda. "Uniforme" qui significa che il *modulo* della velocità non cambia (non rallenta né accelera come numero), ma la *direzione* sì, di continuo, perché si curva sempre.

  La conseguenza, già vista nella sezione sull'accelerazione, è importante e controintuitiva: anche se la velocità "in numero" è costante, *c'è comunque accelerazione*, perché la freccia velocità ruota. Questa accelerazione punta sempre verso il centro del cerchio e si chiama *centripeta* (dal latino "che cerca il centro").
]

#green-box([L'accelerazione centripeta spiegata a parole])[
  Perché un corpo che gira deve avere un'accelerazione verso il centro? Pensa alla pietra legata alla corda che fai roteare. Se la corda si spezzasse, la pietra schizzerebbe via *dritta*, in linea retta (per inerzia), lungo la tangente. Il fatto che invece continui a girare significa che qualcosa la *tira costantemente verso il centro*, costringendola a curvare invece di andare dritta: è la tensione della corda. Quel "tirare verso il centro" è proprio l'accelerazione centripeta.

  Detto altrimenti: andare dritto è il comportamento "naturale"; per curvare serve sempre un'accelerazione diretta verso l'interno della curva. Nel moto circolare la curva è sempre uguale, quindi questa accelerazione punta sempre verso lo stesso punto, il centro.
]

Nel moto circolare uniforme la traiettoria è una circonferenza di raggio $R$ e il modulo della velocità è costante. La velocità è tangente alla circonferenza, mentre l'accelerazione punta sempre verso il centro:

$ a_T=0, quad vec(a)=vec(a)_N, quad a_N=v^2/R. $

#yellow-box([Da dove vengono questi tre fatti])[
  Sono semplicemente la decomposizione $vec(a)=vec(a)_T+vec(a)_N$ applicata a questo caso particolare:
  - $a_T=(dif v)/(dif t)=0$ perché il modulo $v$ è costante (non cambia "quanto vai veloce");
  - quindi resta solo la parte normale: $vec(a)=vec(a)_N$;
  - e il suo valore è $a_N=v^2 slash R$, con $R$ ora costante (è il raggio fisso del cerchio, non più un raggio di curvatura che varia).
]

#align(center, graph-card([Geometria del moto circolare uniforme], cetz.canvas({
  import cetz.draw: *
  // circonferenza e riferimento cartesiano con origine nel centro O
  circle((3.1, 2.35), radius: 2.05, stroke: 1.5pt + blue)
  line((0.65, 2.35), (5.65, 2.35), stroke: 0.75pt + grid-color, mark: (end: ">"))
  line((3.1, 0), (3.1, 4.85), stroke: 0.75pt + grid-color, mark: (end: ">"))
  axis-label((5.65, 2.17), [$x$], placement: "north")
  axis-label((2.95, 4.85), [$y$], placement: "east")
  axis-label((2.95, 2.18), [$O$], placement: "east")
  // posizione iniziale P_0 sul semiasse x e vettori applicati in P_0
  circle((5.15, 2.35), radius: 0.09, fill: ink, stroke: none)
  line((3.1, 2.35), (5.15, 2.35), stroke: 1.25pt + gold)
  line((5.15, 2.35), (5.15, 4.05), stroke: 1.5pt + green, mark: (end: ">"))
  line((5.15, 2.35), (3.85, 2.35), stroke: 1.4pt + red, mark: (end: ">"))
  axis-label((4.05, 2.17), [$R$], placement: "north")
  axis-label((5.32, 3.3), [$vec(v)_0$], placement: "west")
  axis-label((4.45, 2.55), [$vec(a)_N$], placement: "south")
  axis-label((5.27, 2.58), [$P_0$], placement: "south")
  // posizione successiva P(t), angolo theta e arco percorso
  line((3.1, 2.35), (4.55, 3.8), stroke: 1.2pt + gold)
  circle((4.55, 3.8), radius: 0.08, fill: ink, stroke: none)
  arc((5.15, 2.35), start: 0deg, stop: 45deg, radius: 2.05,
    stroke: (paint: blue, thickness: 2.1pt), mark: (end: ">"))
  arc((3.8, 2.35), start: 0deg, stop: 45deg, radius: 0.7, stroke: 1pt + gold)
  axis-label((3.74, 2.62), [$theta$], placement: "south")
  axis-label((4.62, 3.98), [$P(t)$], placement: "south")
})))

== Descrizione angolare

#green-box([L'idea prima della formula])[
  Quando un corpo gira in tondo, invece di seguirne la posizione $x$, $y$ è molto più comodo seguire *l'angolo* $theta$ che il raggio forma con un asse di riferimento: un solo numero che dice "a che punto del giro siamo". È come descrivere la lancetta di un orologio dicendo "segna le tre" invece di dare le coordinate della sua punta. La *velocità angolare* $omega$ dirà allora quanto velocemente questo angolo cresce, cioè quanto rapidamente il corpo "fa il giro".
]

Se $theta$ è misurato in radianti, l'arco percorso è $s=R theta$. La velocità angolare è

#yellow-box([Perché usare i radianti?])[
  Il radiante misura un angolo confrontando l'arco $s$ con il raggio $R$:
  $ theta=s/R. $

  Per questo, se $theta$ è espresso in radianti, la relazione tra arco e angolo diventa semplicemente $s=R theta$. Un giro completo corrisponde a $2pi$ radianti, quindi
  $ 360 degree=2pi " rad", quad 180 degree=pi " rad". $

  Nelle formule con derivate e funzioni trigonometriche, come $omega=(dif theta)/(dif t)$ oppure $x=R cos theta$, gli angoli si intendono in radianti.
]

$ omega=(dif theta)/(dif t)=1/R (dif s)/(dif t)=v/R. $

#yellow-box([Da dove esce $omega=v slash R$])[
  Partiamo dalla definizione $omega=(dif theta)/(dif t)$ (variazione dell'angolo nel tempo). Siccome $s=R theta$ con $R$ costante, si ha $theta=s slash R$, e derivando si tira fuori il fattore costante $1 slash R$:
  $ omega=(dif theta)/(dif t)=1/R (dif s)/(dif t). $
  Ma $(dif s)/(dif t)=v$ è la velocità scalare (spazio percorso lungo il cerchio per unità di tempo), quindi $omega=v slash R$. Equivalentemente $v=omega R$: girare più in fretta (più $omega$) o su un cerchio più grande (più $R$) significa andare più veloci.
]

La sua unità di misura è il radiante al secondo, $"rad"/"s"$; il radiante è adimensionale (è un rapporto tra due lunghezze, arco diviso raggio, quindi le unità si cancellano). Il periodo $T$ si misura in secondi.

#blue-box([Periodo $T$ e frequenza $f$: che cosa sono])[
  Il *periodo* $T$ è il tempo che il corpo impiega a fare *un giro completo*: si misura in secondi. La *frequenza* $f=1 slash T$ è il numero di giri al secondo: si misura in hertz ($"Hz"=" s"^(-1)$). Sono due modi di dire la stessa cosa: se un giro dura $T=0,5 " s"$, allora in un secondo fai $f=2$ giri.
]

Nel moto circolare uniforme $omega$ è costante, quindi

$ theta(t)=theta_0+omega t, quad
  T=(2pi)/omega=(2pi R)/v, quad f=1/T. $

#yellow-box([Da dove escono $T=2pi slash omega$ e $T=2pi R slash v$])[
  In un giro completo l'angolo aumenta di $2pi$ radianti (un giro intero). Poiché $omega$ è costante, l'angolo cresce in modo uniforme: $"angolo"=omega dot "tempo"$. Imponendo che in un periodo $T$ l'angolo cresca esattamente di $2pi$:
  $ omega T=2pi quad arrow quad T=(2pi)/omega. $
  In alternativa, ragionando sulle lunghezze: in un giro si percorre tutta la circonferenza, lunga $2pi R$, alla velocità $v$; tempo = spazio diviso velocità, quindi $T=2pi R slash v$. Le due formule coincidono perché $v=omega R$.
]

La legge angolare deriva dall'integrazione di $omega=(dif theta)/(dif t)$:

$ dif theta=omega dif t, quad
  integral_(theta_0)^(theta(t)) dif theta=integral_0^t omega dif tau, $

$ theta(t)-theta_0=omega t. $

#yellow-box([Cosa succede in questa integrazione])[
  È l'analogo angolare di $x(t)=x_0+v t$ del moto uniforme. Si parte da $omega=(dif theta)/(dif t)$, si "moltiplica per $dif t$" per ottenere $dif theta=omega dif t$ (la piccola variazione di angolo in un piccolo tempo) e si sommano tutti questi contributi con l'integrale. A sinistra l'integrale di $dif theta$ da $theta_0$ a $theta(t)$ dà semplicemente $theta(t)-theta_0$; a destra, siccome $omega$ è costante, esce dall'integrale e $integral_0^t dif tau=t$, quindi resta $omega t$. Il risultato $theta(t)=theta_0+omega t$ dice che l'angolo cresce in modo perfettamente regolare nel tempo.
]

Durante un periodo l'angolo aumenta di $2pi$; dunque $omega T=2pi$. Poiché in un giro si percorre $2pi R$ a velocità $v$, segue anche $T=2pi R/v$.

Le coordinate cartesiane sono

$ cases(
  x(t)=R cos(omega t+theta_0),
  y(t)=R sin(omega t+theta_0),
) $

#yellow-box([Perché spuntano fuori coseno e seno])[
  Un punto su una circonferenza di raggio $R$, individuato dall'angolo $theta$, ha sempre coordinate $x=R cos theta$ e $y=R sin theta$: è la definizione stessa di seno e coseno sul cerchio (proiezioni del raggio sui due assi). Qui l'angolo cambia nel tempo secondo $theta(t)=theta_0+omega t$, quindi basta sostituirlo dentro coseno e seno. Il termine $theta_0$ è l'angolo di partenza, da dove inizia il giro.
]

Ogni coordinata è dunque un moto armonico semplice: il moto circolare uniforme proiettato su un diametro produce un'oscillazione armonica.

#green-box([Un'immagine per capire l'ultima frase])[
  Immagina di guardare una giostra che gira *di taglio*, con l'occhio all'altezza del suo piano. Non vedi più il giro: vedi un cavallino che va avanti e indietro, avanti e indietro, rallentando ai bordi e accelerando al centro. Quel "avanti e indietro" è proprio l'oscillazione armonica: è l'*ombra* del moto circolare proiettata su una linea. Per questo coseno e seno descrivono sia le rotazioni sia le oscillazioni.
]

#purple-box([Esempio numerico: una giostra])[
  Una giostra di raggio $R=4 " m"$ compie un giro ogni $T=8 " s"$.

  *Velocità angolare:*
  $ omega=(2pi)/T=(2pi)/(8) approx 0,785 " rad/s". $

  *Velocità (scalare) di un cavallino sul bordo:*
  $ v=omega R=0,785 dot 4 approx 3,14 " m/s". $

  *Accelerazione centripeta:*
  $ a_N=(v^2)/R=(3,14^2)/(4) approx 2,46 " m/s"^2, $
  oppure, in modo equivalente,
  $ a_N=omega^2 R=0,785^2 dot 4 approx 2,46 " m/s"^2. $

  *Frequenza:* $f=1 slash T=1 slash 8=0,125 " Hz"$ (un ottavo di giro al secondo). I due modi di calcolare $a_N$ danno lo stesso risultato: è un buon controllo che i conti tornino.
]

#red-box([Modulo dell'accelerazione centripeta])[
  Poiché $v=omega R$,

  $ a_N=v^2/R=omega^2 R. $

  L'accelerazione non è nulla anche se il modulo della velocità è costante, perché il vettore $vec(v)$ cambia continuamente direzione.
]

== Notazione vettoriale del moto circolare

Si introduce il vettore velocità angolare $vec(omega)$, perpendicolare al piano del moto e orientato secondo la regola della mano destra. Indicando qui con $vec(R)$ il raggio vettore dal centro alla particella, come negli appunti originali, si ha

#align(center, graph-card([Orientazione vettoriale del moto circolare], cetz.canvas({
  import cetz.draw: *
  // piano del moto in proiezione obliqua
  line((0.25, 0.15), (6.35, 0.15), (7.25, 3.45), (1.2, 3.45), close: true,
    stroke: 1.1pt + ink, fill: rgb("#f7f9fa"))
  // traiettoria circolare vista in prospettiva
  circle((3.75, 1.65), radius: (2.25, 0.95), stroke: 1.6pt + blue)
  circle((3.75, 1.65), radius: 0.07, fill: ink, stroke: none)
  circle((6, 1.65), radius: 0.09, fill: ink, stroke: none)
  // omega perpendicolare al piano, R radiale e v tangente
  line((3.75, 1.65), (3.75, 4.65), stroke: 1.5pt + gold, mark: (end: ">"))
  line((3.75, 1.65), (6, 1.65), stroke: 1.4pt + green, mark: (end: ">"))
  line((6, 1.65), (5.25, 3.05), stroke: 1.5pt + red, mark: (end: ">"))
  // verso di percorrenza lungo la traiettoria
  bezier((5.75, 1.15), (6.15, 1.35), (6.2, 1.8), (5.88, 2.05),
    stroke: 1.5pt + blue, mark: (end: ">"))
  axis-label((3.55, 4.72), [$vec(omega)$], placement: "east")
  axis-label((4.85, 1.47), [$vec(R)$], placement: "north")
  axis-label((5.12, 3.17), [$vec(v)$], placement: "south")
  axis-label((6.12, 1.55), [$P$], placement: "west")
  axis-label((3.58, 1.48), [$O$], placement: "east")
})))

#yellow-box([Perché $vec(omega)$ è perpendicolare al piano?])[
  La velocità angolare scalare $omega$ dice solo quanto rapidamente cambia l'angolo. Il vettore $vec(omega)$ aggiunge anche l'informazione sull'asse e sul verso della rotazione: per questo è perpendicolare al piano del moto. Il verso si sceglie con la regola della mano destra.

  Il prodotto vettoriale serve invece a costruire automaticamente la velocità tangenziale. Infatti $vec(v)$ deve essere tangente alla circonferenza, quindi perpendicolare al raggio $vec(R)$, e deve avere modulo $v=omega R$. Poiché $vec(omega)$ è perpendicolare a $vec(R)$,
  $ norm(vec(omega) times vec(R))=omega R. $

  Perciò
  $ vec(v)=vec(omega) times vec(R) $
  dà nello stesso momento modulo, direzione tangente e verso corretto del moto.
]

$ vec(v)=vec(omega) times vec(R). $

Derivando nel caso più generale:

#yellow-box([Perché la derivata di $vec(omega) times vec(R)$ dà due termini])[
  Anche il prodotto vettoriale $times$ obbedisce alla regola del prodotto: si deriva il primo fattore lasciando fermo il secondo, più il primo fattore per la derivata del secondo (mantenendo l'ordine, perché il prodotto vettoriale non è commutativo):
  $ (dif)/(dif t)(vec(omega) times vec(R))=(dif vec(omega))/(dif t) times vec(R)+vec(omega) times (dif vec(R))/(dif t). $
  Ora si riconoscono due pezzi: $(dif vec(omega))/(dif t)=vec(alpha)$ è l'accelerazione angolare, mentre $(dif vec(R))/(dif t)=vec(v)$ è la velocità. Quindi il secondo termine $vec(omega) times vec(v)$ si riscrive, usando $vec(v)=vec(omega) times vec(R)$, come $vec(omega) times (vec(omega) times vec(R))$.
]

$ vec(a)=(dif vec(omega))/(dif t) times vec(R)+vec(omega) times vec(v)
  =vec(alpha) times vec(R)+vec(omega) times (vec(omega) times vec(R)), $

dove

$ vec(alpha)=(dif vec(omega))/(dif t) $

è l'accelerazione angolare. Il primo termine è tangenziale (presente solo se la rotazione accelera o rallenta); il secondo è centripeto. Nel moto circolare uniforme $vec(alpha)=vec(0)$ (la velocità angolare non cambia) e resta

$ vec(a)=vec(omega) times (vec(omega) times vec(R))=-omega^2 vec(R). $

#yellow-box([Perché il doppio prodotto dà $-omega^2 vec(R)$])[
  Il *doppio prodotto vettoriale* $vec(omega) times (vec(omega) times vec(R))$ va guardato a strati. La parte interna $vec(omega) times vec(R)=vec(v)$ è la velocità tangenziale, di modulo $omega R$. Poi $vec(omega) times vec(v)$: siccome $vec(omega)$ è perpendicolare a $vec(v)$, il modulo è $omega dot (omega R)=omega^2 R$, e la direzione (regola della mano destra) risulta rivolta *verso il centro*, cioè in verso opposto a $vec(R)$ (che invece va dal centro verso la particella). Direzione lungo $vec(R)$ ma verso opposto e modulo $omega^2 R$: questo è esattamente $-omega^2 vec(R)$. Il segno meno è la traccia matematica del fatto che l'accelerazione è *centripeta*, cioè punta all'indietro rispetto al raggio.
]

L'ultima uguaglianza segue perché $vec(omega)$ è perpendicolare a $vec(R)$: il doppio prodotto vettoriale è antiparallelo a $vec(R)$ e ha modulo $omega^2R$. In forma scalare si ritrova

$ a_N=omega^2R=(omega R)^2/R=v^2/R. $

#blue-box([Tutto torna: le due formule dell'accelerazione centripeta])[
  Abbiamo ottenuto $a_N=omega^2 R$ e $a_N=v^2 slash R$: sono la stessa cosa scritta in due modi, collegati da $v=omega R$. Usa $omega^2 R$ se conosci la velocità angolare (giri al secondo), usa $v^2 slash R$ se conosci la velocità lineare. Il passaggio $omega^2 R=(omega R)^2 slash R=v^2 slash R$ lo dimostra: si moltiplica e divide per $R$ e si raccoglie $(omega R)^2=v^2$.
]

#pagebreak()

= Dinamica del punto materiale

#green-box([L'idea prima della formula])[
  Nella *cinematica* ci limitavamo a *descrivere* il moto: dove si trova il corpo, quanto corre, come accelera. Ma non ci chiedevamo mai *perché* si muova così. La *dinamica* risponde proprio a questa domanda: studia le *cause* del moto, cioè le forze. È il passaggio da "come si muove" a "perché si muove".
]

La *dinamica* studia le cause del moto. Il sistema più semplice è il punto materiale; i risultati verranno poi estesi a sistemi di particelle e corpi rigidi.

== Forza

#green-box([L'idea prima della formula])[
  Una *forza* è semplicemente una *spinta* o un *tiro*. Quando spingi un carrello, quando la Terra tira giù una mela, quando una molla respinge la tua mano: in tutti questi casi c'è un corpo (l'ambiente) che agisce su un altro corpo (il sistema). La forza è il modo che la fisica ha di mettere in numeri queste interazioni.

  È una grandezza *vettoriale* perché per descrivere una spinta non basta dire "quanto è forte" (il modulo): bisogna anche dire *in che direzione e verso* spinge. Spingere un'auto in avanti o di lato dà risultati completamente diversi, anche con la stessa intensità.
]

#blue-box([Definizione operativa])[
  Una *forza* $vec(F)$ descrive un'interazione tra il punto materiale scelto come sistema e il suo ambiente. È una grandezza vettoriale: possiede modulo, direzione e verso.
]

Per analizzare una forza occorre quindi distinguere sempre:

- il corpo sul quale la forza agisce;
- il corpo dell'ambiente che esercita la forza;
- la direzione e il verso dell'interazione.

Il modello di punto materiale trascura dimensioni, rotazioni e moti interni. Quando queste caratteristiche sono rilevanti si deve usare il modello di corpo rigido.

== Prima legge di Newton: principio di inerzia

#green-box([L'idea prima della formula])[
  Immagina di essere su un treno che viaggia liscio a velocità costante. Se nessuno tocca la tua valigia sul portabagagli, quella *resta lì*: continua a muoversi insieme al treno senza bisogno di alcuna spinta. Il punto controintuitivo è proprio questo: *per muoversi a velocità costante non serve nessuna forza*. La forza serve solo per *cambiare* il moto (accelerare, frenare, curvare).

  Nella vita quotidiana sembra il contrario: per tenere in moto un'auto devi premere l'acceleratore. Ma è perché l'attrito e l'aria la frenano di continuo: il motore serve solo a *compensare* quelle forze. Se l'attrito sparisse (come nello spazio), l'auto continuerebbe da sola per sempre. Questo è il *principio di inerzia*.
]

#blue-box([Prima legge di Newton])[
  In assenza di forze risultanti, un corpo mantiene il proprio stato di moto: resta in quiete oppure si muove di moto rettilineo uniforme.

  $ vec(F)_"tot"=vec(0) quad arrow quad vec(a)=vec(0) quad arrow quad vec(v)="costante". $
]

#yellow-box([Come si legge la catena di frecce])[
  La riga $vec(F)_"tot"=vec(0) quad arrow quad vec(a)=vec(0) quad arrow quad vec(v)="costante"$ va letta da sinistra a destra come un ragionamento a tre passi:
  - se la risultante delle forze è nulla ($vec(F)_"tot"=vec(0)$),
  - allora non c'è accelerazione ($vec(a)=vec(0)$): l'accelerazione è infatti "quanto cambia la velocità", e senza spinta nulla la cambia,
  - quindi la velocità *resta com'era* ($vec(v)="costante"$): stesso modulo, stessa direzione, stesso verso.

  Attenzione: $vec(v)="costante"$ è una condizione *vettoriale*. Significa che anche la *direzione* non cambia, per questo il moto è *rettilineo* (e non curvo) uniforme.
]

I sistemi di riferimento nei quali vale il principio di inerzia si chiamano *sistemi inerziali*. La quiete non è uno stato fisicamente privilegiato: è il caso particolare del moto uniforme con $vec(v)=vec(0)$.

#gray-box([Perché si insiste sui "sistemi inerziali"])[
  Il principio di inerzia non vale in *qualsiasi* sistema di riferimento. Se sei su un'auto che frena bruscamente, ti senti spingere in avanti pur senza che nessuno ti tocchi: in quel sistema di riferimento accelerato sembra agire una forza "fantasma". I sistemi in cui la prima legge vale davvero, senza forze inventate, sono detti *inerziali*. Tutta la dinamica di Newton è scritta per questi sistemi.
]

== Massa inerziale

#green-box([L'idea prima della formula])[
  La *massa* misura quanto un corpo è "testardo" nel cambiare velocità. Prova a spingere con la stessa forza un carrello della spesa vuoto e uno pieno di bottiglie d'acqua: quello vuoto schizza via, quello pieno si muove a fatica. Non è che il carrello pieno "pesi di più" nel senso del peso (anche nello spazio, senza gravità, sarebbe più difficile da spingere): semplicemente ha *più materia*, e quindi *più inerzia*, cioè più resistenza a cambiare il proprio stato di moto.

  Questa "resistenza al cambiamento" è esattamente ciò che misura la *massa inerziale*.
]

La massa si misura in kilogrammi, $"kg"$, e quantifica l'inerzia del corpo, cioè la sua resistenza a cambiare velocità. Applicando la stessa forza a due corpi si osserva che il corpo con massa maggiore acquista un'accelerazione minore.

#align(center, graph-card([Stessa forza, masse diverse], cetz.canvas({
  import cetz.draw: *
  // corpo di massa minore
  rect((0.4, 0.45), (1.75, 1.8), fill: rgb("#eef4f8"), stroke: 1pt + ink)
  circle((1.08, 1.12), radius: 0.06, fill: ink, stroke: none)
  line((1.08, 1.12), (2.65, 1.12), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((1.08, 0.28), [$m_1$], placement: "north")
  axis-label((2.72, 1.12), [$vec(F)$], placement: "west")
  axis-label((1.9, 1.36), [$vec(a)_1$], placement: "south")
  // corpo di massa maggiore
  rect((4.25, 0.2), (6.25, 2.05), fill: rgb("#eef4f8"), stroke: 1pt + ink)
  circle((5.25, 1.12), radius: 0.06, fill: ink, stroke: none)
  line((5.25, 1.12), (6.82, 1.12), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((5.25, 0.02), [$m_2$], placement: "north")
  axis-label((6.9, 1.12), [$vec(F)$], placement: "west")
  axis-label((6.0, 1.36), [$vec(a)_2$], placement: "south")
  axis-label((3.48, 0.35), [$m_1<m_2$], placement: "north")
  axis-label((3.48, 1.75), [$a_1>a_2$], placement: "south")
})))

A parità di forza l'accelerazione è inversamente proporzionale alla massa:

$ a prop 1/m, quad (m_2)/(m_1)=(a_1)/(a_2). $

#yellow-box([Da dove esce la proporzione $(m_2)/(m_1)=(a_1)/(a_2)$])[
  Se la stessa forza $F$ è applicata a due corpi, l'accelerazione di ciascuno è inversamente proporzionale alla sua massa: $a_1 prop 1\/m_1$ e $a_2 prop 1\/m_2$, con lo *stesso* fattore di proporzionalità (la forza è la stessa). Possiamo allora scrivere $a_1 m_1 = a_2 m_2$ (il prodotto massa per accelerazione vale $F$ in entrambi i casi). Dividendo si arriva a
  $ (m_2)/(m_1)=(a_1)/(a_2). $
  In parole: chi ha massa doppia prende accelerazione metà. Nota l'*incrocio* degli indici (massa 2 con accelerazione 1): è il segno tipico di una relazione *inversa*.
]

#purple-box([Esempio numerico])[
  Spingo con la stessa forza un corpo di massa $m_1=2 " kg"$ e uno di $m_2=6 " kg"$. Misuro che il primo accelera di $a_1=3 " m/s"^2$. Quanto accelera il secondo? Uso la proporzione:
  $ (m_2)/(m_1)=(a_1)/(a_2) quad arrow quad a_2=a_1 (m_1)/(m_2)=3 dot (2)/(6)=1 " m/s"^2. $
  Il corpo tre volte più pesante accelera tre volte di meno: coerente con l'inerzia maggiore.
]

#yellow-box([Il simbolo $prop$])[
  Il simbolo $prop$ si legge "è proporzionale a". Indica che due grandezze variano insieme secondo un fattore costante.

  Per esempio $a prop F$ significa che, a massa fissata, se la forza raddoppia allora raddoppia anche l'accelerazione: è una proporzionalità diretta.

  Invece $a prop 1/m$ significa che, a forza fissata, aumentando la massa l'accelerazione diminuisce: è una proporzionalità inversa.
]

La massa definita attraverso questa risposta dinamica prende il nome di *massa inerziale*.

== Seconda legge di Newton

#green-box([L'idea prima della formula])[
  Questa è *la* formula centrale della dinamica. Dice una cosa semplice: la forza totale che agisce su un corpo è ciò che lo fa *accelerare*, e quanto accelera dipende da quanto è pesante. Mette insieme le due osservazioni di prima:
  - più forza spingi $arrow.r$ più accelerazione ottieni (proporzionalità diretta con $F$);
  - più massa ha il corpo $arrow.r$ meno accelera con la stessa forza (proporzionalità inversa con $m$).

  Combinando le due, l'accelerazione è $vec(a)=vec(F)_"tot"\/m$. Moltiplicando entrambi i lati per $m$ si ottiene la forma classica $vec(F)_"tot"=m vec(a)$. È il "motore" con cui si risolvono praticamente tutti i problemi: nota tutte le forze, le sommi, dividi per la massa e ottieni l'accelerazione, da cui poi (con la cinematica) ricavi velocità e posizione.
]

#red-box([Seconda legge di Newton])[
  In un sistema inerziale la risultante delle forze applicate a un punto materiale è uguale al prodotto della sua massa per l'accelerazione:

  $ vec(F)_"tot"=sum_i vec(F)_i=m vec(a). $
]

#yellow-box([Cosa significa $sum_i vec(F)_i$])[
  Il simbolo $sum_i vec(F)_i$ vuol dire "somma vettoriale di tutte le forze $vec(F)_1, vec(F)_2, ...$ che agiscono sul corpo". Conta *solo* la loro somma (la *risultante*): se due forze uguali e opposte si annullano, il corpo non accelera, esattamente come se non ci fosse nessuna forza. È la risultante, non le singole forze, a determinare il moto.
]

La relazione è vettoriale: $vec(F)_"tot"$ e $vec(a)$ hanno la stessa direzione e lo stesso verso. In coordinate cartesiane equivale alle tre equazioni scalari

$ F_x=m a_x, quad F_y=m a_y, quad F_z=m a_z. $

#yellow-box([Perché un'equazione vettoriale diventa tre equazioni scalari])[
  Un'uguaglianza tra vettori è vera solo se è vera *componente per componente*: due frecce sono uguali se hanno uguale la parte lungo $x$, uguale quella lungo $y$ e uguale quella lungo $z$. Per questo l'unica equazione vettoriale $vec(F)_"tot"=m vec(a)$ si "spacchetta" automaticamente in tre equazioni numeriche, una per ogni asse. Questa è la chiave operativa: con i vettori non sappiamo fare i conti direttamente, ma con i numeri sì, quindi scomponiamo sempre lungo gli assi.
]

L'unità SI della forza è il newton:

$ 1 " N"=1 " kg" " m"/"s"^2. $

#yellow-box([Da dove esce $1 " N"=1 " kg" " m"/"s"^2$])[
  Non è una definizione arbitraria: discende direttamente da $F=m a$. Se moltiplico una massa (in $"kg"$) per un'accelerazione (in $"m/s"^2$), l'unità del risultato è $"kg" dot "m/s"^2$. A questa combinazione si dà il nome di newton ($"N"$). Quindi $1 " N"$ è la forza che imprime a $1 " kg"$ un'accelerazione di $1 " m/s"^2$. È un buon *controllo dimensionale*: ogni volta che scrivi una forza, le unità devono ridursi a $"kg" dot "m/s"^2$.
]

Per massa fissata, $a prop F$; per forza fissata, $a prop 1/m$.

#purple-box([Esempio numerico])[
  Su un blocco di massa $m=4 " kg"$ agiscono due forze orizzontali nello stesso verso: $F_1=10 " N"$ e $F_2=6 " N"$. La risultante è $F_"tot"=10+6=16 " N"$. L'accelerazione vale
  $ a=(F_"tot")/m=(16 " N")/(4 " kg")=4 " m/s"^2. $
  Controllo unità: $"N"\/"kg" = ("kg" dot "m/s"^2)\/"kg" = "m/s"^2$, giusto. Se invece le due forze fossero *opposte*, avremmo $F_"tot"=10-6=4 " N"$ e quindi $a=1 " m/s"^2$: la stessa formula, ma la somma è vettoriale.
]

=== Principio di sovrapposizione

#green-box([L'idea prima della formula])[
  Se sul corpo agiscono più forze (la gravità, una spinta, l'attrito...), ognuna "fa il suo lavoro" come se le altre non ci fossero, e poi i loro effetti si *sommano*. È come tirare un oggetto con due corde: il risultato è la combinazione dei due tiri, ottenuta sommandoli da vettori (regola del parallelogramma). Nessuna forza disturba l'azione delle altre: questo è il *principio di sovrapposizione*.
]

Se più corpi dell'ambiente interagiscono con il sistema, ciascuno esercita la propria forza indipendentemente dalle altre. L'effetto complessivo è dato dalla somma vettoriale:

$ vec(F)_"tot"=vec(F)_1+vec(F)_2+...+vec(F)_n. $

#yellow-box([Risultante])[
  La risultante non è una forza aggiuntiva: è il vettore che rappresenta la somma di tutte le forze realmente esercitate sul corpo.
]

== Quantità di moto

#green-box([L'idea prima della formula])[
  La *quantità di moto* misura "quanto moto" porta con sé un corpo, tenendo conto sia di quanto è veloce sia di quanto è massiccio. Un camion lento e una pallina velocissima possono avere la stessa quantità di moto: ciò che conta è il prodotto $m vec(v)$. Intuitivamente è la grandezza che misura "quanto è difficile fermare quel corpo". Un TIR a $10 " km/h"$ è difficilissimo da fermare nonostante la bassa velocità: tanta massa, tanta quantità di moto.

  È un vettore perché punta nel verso in cui il corpo si muove.
]

La *quantità di moto* di una particella è

$ vec(p)=m vec(v), $

e si misura in $"kg m/s"$. La seconda legge può essere scritta nella forma più generale

$ vec(F)_"tot"=(dif vec(p))/(dif t). $

#yellow-box([Perché questa forma è "più generale" di $F=m a$])[
  Questa scrittura dice: la forza è ciò che fa *variare nel tempo* la quantità di moto. È più generale perché funziona *anche se la massa cambia* (per esempio un razzo che brucia carburante e diventa più leggero), caso in cui $vec(F)=m vec(a)$ da sola non basterebbe. Storicamente è la forma in cui Newton scrisse davvero la sua legge.
]

Se la massa è costante,

$ (dif vec(p))/(dif t)=(dif)/(dif t)(m vec(v))
  =m (dif vec(v))/(dif t)=m vec(a), $

e si ritrova $vec(F)_"tot"=m vec(a)$.

#yellow-box([Spieghiamo i tre passaggi della derivata])[
  Partiamo da $vec(p)=m vec(v)$ e deriviamo rispetto al tempo:
  - $(dif)/(dif t)(m vec(v))$: dobbiamo derivare il prodotto di $m$ per $vec(v)$;
  - poiché $m$ è *costante* (così abbiamo supposto), esce dalla derivata come un qualsiasi numero fisso: $m (dif vec(v))/(dif t)$;
  - infine $(dif vec(v))/(dif t)$ è per definizione l'accelerazione $vec(a)$ (è "quanto cambia la velocità nel tempo").

  Risultato: $m vec(a)$. Abbiamo così dimostrato che la forma generale $vec(F)=(dif vec(p))/(dif t)$ contiene come caso particolare $vec(F)=m vec(a)$, valido quando la massa non cambia.
]

=== Impulso

#green-box([L'idea prima della formula])[
  L'*impulso* misura l'effetto complessivo di una forza che agisce *per un certo tempo*. Non conta solo quanto è forte la spinta, ma anche per quanto dura: una piccola forza applicata a lungo può cambiare il moto tanto quanto una grande forza data per un istante. È il motivo per cui, prendendo al volo una palla, si "accompagna" il colpo tirando indietro la mano: allungando il tempo dell'urto si riduce la forza necessaria a fermarla, a parità di variazione della quantità di moto.

  Il *teorema dell'impulso* dice esattamente questo: l'impulso ricevuto è uguale alla *variazione della quantità di moto*.
]

Dalla forma $dif vec(p)=vec(F)_"tot" dif t$, integrando tra $t_0$ e $t$ si ottiene

$ integral_(vec(p)(t_0))^(vec(p)(t)) dif vec(p)
  =integral_(t_0)^t vec(F)_"tot"(tau) dif tau. $

#yellow-box([Perché si integra, e cosa fanno gli estremi])[
  La relazione $dif vec(p)=vec(F)_"tot" dif t$ vale per un *intervallino infinitesimo* di tempo: in un istante minuscolo $dif t$, la forza produce una piccola variazione $dif vec(p)$. Per sapere la variazione *totale* tra l'istante iniziale $t_0$ e quello finale $t$, dobbiamo *sommare tutti questi contributi*: è proprio ciò che fa l'integrale.

  Da notare gli estremi: a sinistra integriamo in $dif vec(p)$ e gli estremi sono i *valori della quantità di moto* (da $vec(p)(t_0)$ a $vec(p)(t)$); a destra integriamo in $dif tau$ (il tempo) e gli estremi sono i *tempi* (da $t_0$ a $t$). La variabile $tau$ è solo un nome "muto" per il tempo che scorre dentro l'integrale, per non confonderlo con l'estremo $t$.

  L'integrale di sinistra è immediato: $integral dif vec(p) = vec(p)(t)-vec(p)(t_0) = Delta vec(p)$, cioè finale meno iniziale.
]

Si definisce *impulso* della forza risultante

#purple-box([Teorema dell'impulso])[
  $ vec(J)=integral_(t_0)^t vec(F)_"tot"(tau) dif tau
    =Delta vec(p)=vec(p)(t)-vec(p)(t_0). $
]

Se la forza è costante nell'intervallo $Delta t=t-t_0$,

$ vec(J)=vec(F)_"tot" Delta t. $

#yellow-box([Perché con forza costante l'integrale diventa una moltiplicazione])[
  Se $vec(F)_"tot"$ non cambia nel tempo, è un fattore costante e può uscire dall'integrale: $integral_(t_0)^t vec(F)_"tot" dif tau = vec(F)_"tot" integral_(t_0)^t dif tau = vec(F)_"tot" (t-t_0) = vec(F)_"tot" Delta t$. L'integrale si riduce a "forza per durata", proprio come l'area di un rettangolo (base $Delta t$, altezza $F$).
]

#purple-box([Esempio numerico])[
  Una palla di massa $m=0,2 " kg"$ arriva contro un muro a $v_0=8 " m/s"$ e rimbalza indietro a $v=6 " m/s"$ (verso opposto). Prendendo positivo il verso di rimbalzo, le quantità di moto sono $p_0=0,2 dot (-8)=-1,6 " kg m/s"$ e $p=0,2 dot 6=1,2 " kg m/s"$. L'impulso ricevuto dal muro è
  $ J=Delta p=p-p_0=1,2-(-1,6)=2,8 " kg m/s". $
  Se l'urto dura $Delta t=0,02 " s"$, la forza media è $F=J\/Delta t=2,8\/0,02=140 " N"$. Allungando il tempo d'urto, la forza diminuirebbe.
]

Se $vec(F)_"tot"=vec(0)$, allora $dif vec(p)=vec(0)$ e la quantità di moto si conserva:

$ vec(p)="costante". $

#gray-box([Cosa stiamo dicendo qui])[
  Questo è il *principio di conservazione della quantità di moto*: se sul corpo non agisce alcuna forza risultante, la sua quantità di moto non cambia mai. È solo la prima legge di Newton, riletta nel linguaggio di $vec(p)$: niente forza, niente variazione di moto.
]

== Terza legge di Newton: azione e reazione

#green-box([L'idea prima della formula])[
  Le forze non vengono mai "da sole": sono sempre *interazioni a due*. Se spingi un muro, il muro spinge te con la stessa intensità (per questo ti senti la mano premuta). Quando cammini, i tuoi piedi spingono indietro il pavimento e il pavimento spinge avanti te: è quella reazione che ti fa avanzare. Quando spari, il proiettile va avanti e il fucile rincula all'indietro.

  La regola è: *a ogni azione corrisponde una reazione uguale e contraria*. Il punto cruciale, che genera la maggior parte degli errori, è che le due forze agiscono su *corpi diversi* (una su di te, una sul muro). Per questo non si annullano mai a vicenda.
]

Quando due corpi $A$ e $B$ interagiscono, indichiamo con $vec(F)_(A B)$ la forza esercitata da $B$ sul corpo $A$ e con $vec(F)_(B A)$ la forza esercitata da $A$ sul corpo $B$. Le due forze sono opposte:

#blue-box([Terza legge di Newton])[
  $ vec(F)_(A B)=-vec(F)_(B A). $

  Le due forze hanno stesso modulo e stessa direzione, ma verso opposto.
]

#yellow-box([Come leggere i doppi pedici])[
  La notazione $vec(F)_(A B)$ va letta come "forza *su $A$ esercitata da $B$*": il primo indice è chi *subisce*, il secondo è chi *agisce*. Quindi $vec(F)_(B A)$ è la forza su $B$ da parte di $A$. Il segno meno nella formula dice che, scambiando i due ruoli, ottieni un vettore con lo stesso modulo e direzione ma verso ribaltato.
]

#align(center, graph-card([Coppia di azione e reazione], cetz.canvas({
  import cetz.draw: *
  circle((1.35, 1.15), radius: 0.16, fill: blue, stroke: none)
  circle((5.65, 1.15), radius: 0.16, fill: red, stroke: none)
  line((1.35, 1.15), (3.25, 1.15), stroke: 1.6pt + red, mark: (end: ">"))
  line((5.65, 1.15), (3.75, 1.15), stroke: 1.6pt + blue, mark: (end: ">"))
  axis-label((1.35, 0.78), [$A$], placement: "north")
  axis-label((5.65, 0.78), [$B$], placement: "north")
  axis-label((2.3, 1.42), [$vec(F)_(A B)$], placement: "south")
  axis-label((4.7, 1.42), [$vec(F)_(B A)$], placement: "south")
})))

#yellow-box([Errore da evitare])[
  Azione e reazione agiscono su *corpi diversi* e quindi non si cancellano nel diagramma delle forze di un singolo corpo. Due forze opposte applicate allo stesso oggetto non costituiscono una coppia di terza legge.
]

=== Esempio con tre corpi

Se $A$ interagisce con $B$ e $B$ interagisce con $C$, i diagrammi dei singoli corpi contengono forze diverse:

#align(center, graph-card([Interazioni tra tre corpi], cetz.canvas({
  import cetz.draw: *
  rect((0.35, 0.3), (1.55, 1.5), fill: rgb("#edf3f8"), stroke: 1pt + ink)
  rect((2.75, 0.15), (4.25, 1.65), fill: rgb("#edf3f8"), stroke: 1pt + ink)
  circle((5.75, 0.9), radius: 0.22, fill: rgb("#f2e9dc"), stroke: 1pt + ink)
  line((0.95, 0.9), (2.25, 0.9), stroke: 1.4pt + red, mark: (end: ">"))
  line((3.5, 0.9), (2.3, 0.9), stroke: 1.4pt + blue, mark: (end: ">"))
  line((3.5, 0.9), (4.85, 0.9), stroke: 1.4pt + green, mark: (end: ">"))
  line((5.75, 0.9), (4.55, 0.9), stroke: 1.4pt + gold, mark: (end: ">"))
  axis-label((0.95, 0.08), [$A$], placement: "north")
  axis-label((3.5, -0.05), [$B$], placement: "north")
  axis-label((5.75, 0.45), [$C$], placement: "north")
  axis-label((1.55, 1.18), [$vec(F)_(A B)$], placement: "south")
  axis-label((2.85, 1.18), [$vec(F)_(B A)$], placement: "south")
  axis-label((4.25, 1.18), [$vec(F)_(B C)$], placement: "south")
  axis-label((5.25, 1.18), [$vec(F)_(C B)$], placement: "south")
})))

Per esempio,

$ vec(F)_(A B)=m_A vec(a)_A, $

$ vec(F)_(B C)+vec(F)_(B A)=m_B vec(a)_B, $

con $vec(F)_(A B)=-vec(F)_(B A)$ e $vec(F)_(B C)=-vec(F)_(C B)$.

#yellow-box([Come si scrivono queste equazioni])[
  La regola è: si applica $vec(F)_"tot"=m vec(a)$ a *un corpo per volta*, mettendo nel diagramma di quel corpo *solo le forze che agiscono su di lui*.
  - Sul corpo $A$ agisce solo $B$ (è all'estremità), quindi la sua unica forza è $vec(F)_(A B)$, da cui $vec(F)_(A B)=m_A vec(a)_A$.
  - Sul corpo $B$ (in mezzo) agiscono *due* corpi, $A$ e $C$: le forze sono $vec(F)_(B A)$ e $vec(F)_(B C)$, la cui somma dà $m_B vec(a)_B$.

  Le relazioni $vec(F)_(A B)=-vec(F)_(B A)$ e $vec(F)_(B C)=-vec(F)_(C B)$ sono la *terza legge*: ogni coppia di forze tra due corpi è uguale e contraria. Sono proprio queste relazioni che "agganciano" tra loro le equazioni dei diversi corpi e permettono di risolvere il sistema. È il punto chiave: azione e reazione compaiono in diagrammi *diversi*, mai nello stesso.
]

= Metodo di analisi dei problemi dinamici

#green-box([L'idea prima della formula])[
  Quasi tutti i problemi di dinamica si risolvono con la *stessa ricetta*. L'idea è: disegna il corpo "da solo", segna tutte le frecce delle forze che lo toccano, scegli due assi comodi, e scrivi $F=m a$ separatamente lungo ogni asse. Una volta imparato lo schema, cambiano solo le forze in gioco (peso, normale, tensione, attrito...), ma la procedura è sempre questa.
]

Per impostare correttamente un problema:

1. identificare il corpo o sistema da analizzare;
2. identificare i corpi dell'ambiente che interagiscono con esso;
3. scegliere un sistema di riferimento inerziale;
4. isolare il sistema e disegnare il *diagramma delle forze*;
5. scegliere assi cartesiani convenienti $x,y,z$;
6. applicare la seconda legge di Newton a ogni corpo del sistema.

#blue-box([Che cos'è il diagramma di corpo libero])[
  Il *diagramma di corpo libero* (o *diagramma delle forze*) è il disegno in cui rappresenti il corpo isolato dal resto del mondo — di solito come un puntino o un rettangolino — e ci disegni sopra *solo le forze che agiscono su di esso*, ciascuna come una freccia che parte dal corpo. Niente forze che il corpo esercita su *altri* (quelle non servono per il suo moto), niente disegni del contesto: solo il corpo e le sue frecce.

  Serve a non dimenticare nessuna forza e a non aggiungerne di inventate. Nei disegni che seguono vedrai spesso, accanto alla scena reale, proprio questo diagramma isolato: il puntino con le frecce $vec(N)$, $m vec(g)$, $vec(T)$, eccetera.
]

#yellow-box([Perché si scompongono le forze sugli assi])[
  Le forze sono vettori, e i vettori non si possono "sommare a occhio". Il trucco è scegliere due assi perpendicolari ($x$ e $y$) e *proiettare* ogni forza su di essi, cioè trovare quanto vale la sua "ombra" lungo $x$ e quanto lungo $y$. Una volta fatto questo, lungo ciascun asse abbiamo solo *numeri* (positivi o negativi a seconda del verso), e i numeri si sommano facilmente.

  Così l'unica equazione vettoriale $vec(R)=m vec(a)$ si trasforma in due (o tre) equazioni scalari indipendenti, una per asse, che sappiamo risolvere. *Scegliere bene gli assi* è metà del lavoro: conviene orientarli in modo che il maggior numero possibile di forze cada lungo gli assi, lasciando da scomporre solo le poche oblique (lo vedremo bene nel piano inclinato).
]

Si arriva così a un'equazione vettoriale

$ vec(R)=sum_i vec(F)_i=m vec(a), $

da proiettare sugli assi scelti. Le soluzioni principali sono:

- $vec(R)=vec(0)$: equilibrio statico oppure moto rettilineo uniforme;
- $vec(R)!=vec(0)$: moto accelerato.

#yellow-box([Come si scompone in pratica una forza obliqua])[
  Se una forza $vec(F)$ ha modulo $F$ e forma un angolo $theta$ con l'asse $x$, le sue componenti sono
  $ F_x=F cos theta, quad F_y=F sin theta. $
  Regola pratica per non sbagliare coseno/seno: la componente *adiacente* all'angolo (quella "lungo" il lato da cui si misura $theta$) prende il *coseno*; quella *opposta* prende il *seno*. Controllo coi casi limite: se $theta=0$ la forza è tutta orizzontale, e infatti $F_x=F cos 0=F$, $F_y=F sin 0=0$; se $theta=90 degree$ è tutta verticale, $F_x=0$, $F_y=F$. Tornano.
]

#gray-box([Ipotesi di modellizzazione])[
  Prima di risolvere occorre dichiarare le idealizzazioni: punti materiali, corpi rigidi, vincoli ideali, funi inestensibili o prive di massa. Le equazioni dipendono da queste ipotesi.
]

= Collegamento tra cinematica e dinamica

#table(
  columns: (1.4fr, 1.6fr, 1.6fr),
  inset: 6pt,
  stroke: 0.4pt + rgb("#d5dadd"),
  fill: (x, y) => if y == 0 { rgb("#eaf1f7") },
  table.header([*Cinematica*], [*Accelerazione*], [*Dinamica*]),
  [Moto rettilineo uniforme], [$vec(a)=vec(0)$], [$vec(F)_"tot"=vec(0)$],
  [Moto uniformemente accelerato], [$vec(a)="costante"$], [$vec(F)_"tot"="costante"$],
  [Moto vario], [$vec(a)$ variabile], [$vec(F)_"tot"=m vec(a)$ variabile],
)

#gray-box([Come leggere la tabella])[
  La tabella mette in fila lo *stesso* fenomeno visto dai due lati. A sinistra c'è la descrizione cinematica del moto, al centro com'è l'accelerazione, a destra cosa dice la dinamica sulle forze. La logica è sempre $vec(F)_"tot"=m vec(a)$: se l'accelerazione è zero, anche la forza risultante è zero; se è costante, la forza è costante; se varia, la forza varia. Conoscere uno qualsiasi dei tre lati ti dà gli altri due.
]

Nel moto curvilineo l'equazione generale si può scomporre lungo tangente e normale:

$ vec(F)_"tot"=m vec(a)_T+m vec(a)_N. $

La componente tangenziale cambia il modulo della velocità; quella normale ne cambia la direzione.

#yellow-box([Tangente e normale: due lavori diversi])[
  In un moto curvo conviene scomporre la forza non lungo $x,y$ fissi, ma lungo due direzioni che "seguono" il corpo: la *tangente* (nel verso del moto) e la *normale* (perpendicolare, verso l'interno della curva). Il motivo è che ognuna fa un mestiere ben distinto:
  - la componente *tangenziale* $m vec(a)_T$ è parallela alla velocità: la accelera o la frena, cioè cambia *quanto va veloce* il corpo;
  - la componente *normale* $m vec(a)_N$ è perpendicolare alla velocità: non cambia il modulo, ma *piega* la traiettoria, cioè cambia la *direzione*. È questa la forza che ti tiene in curva.

  Se la componente normale fosse nulla, il corpo andrebbe dritto (prima legge). Se fosse nulla quella tangenziale, andrebbe a velocità costante in modulo, ma potrebbe comunque curvare.
]

= Forze agenti nella meccanica

#gray-box([Dove siamo])[
  Finora abbiamo parlato di forze "in generale". Adesso passiamo in rassegna le forze *concrete* che incontrerai nei problemi: il peso, la forza elastica della molla, la reazione dei vincoli, la tensione delle funi. Per ciascuna serve sapere modulo, direzione e verso, così da poterla disegnare nel diagramma di corpo libero.
]

== Forza peso

#green-box([L'idea prima della formula])[
  Il *peso* è semplicemente la forza con cui la Terra tira ogni corpo verso il basso. È la forza che senti quando reggi una borsa pesante, ed è la stessa che fa cadere una mela. Vicino alla superficie terrestre questa attrazione è praticamente la *stessa ovunque* (in modulo e direzione): per questo si dice che il campo gravitazionale è "uniforme". Il valore $g approx 9,81 " m/s"^2$ è l'accelerazione che la gravità imprime: ogni secondo di caduta, la velocità verso il basso aumenta di circa $9,81 " m/s"$.
]

Vicino alla superficie terrestre il campo gravitazionale è approssimativamente uniforme, con

$ g approx 9.81 " m/s"^2. $

La forza peso esercitata dalla Terra su un corpo è

$ vec(F)_"peso"=m_g vec(g), $

dove $m_g$ è la *massa gravitazionale*, che misura l'intensità dell'interazione con il campo gravitazionale.

#purple-box([Esempio numerico])[
  Quanto pesa, in newton, un corpo di massa $m=3 " kg"$? Il modulo del peso è
  $ F_"peso"=m g=3 " kg" dot 9,81 " m/s"^2 approx 29,4 " N". $
  Attenzione alla differenza tra *massa* e *peso*: la massa è $3 " kg"$ (è la stessa sulla Terra, sulla Luna o nello spazio), mentre il peso è $29,4 " N"$ ed è specifico della gravità terrestre. Sulla Luna, dove $g approx 1,6 " m/s"^2$, lo stesso corpo peserebbe solo $3 dot 1,6 approx 4,8 " N"$, pur avendo sempre massa $3 " kg"$.
]

#red-box([Attenzione: massa $eq.not$ peso])[
  In italiano "pesare" si usa per entrambe, ma in fisica sono cose diverse e con unità diverse: la *massa* si misura in $"kg"$, il *peso* (essendo una forza) si misura in $"N"$. La bilancia in cucina è tarata per mostrarti i $"kg"$, ma in realtà misura una forza: funziona solo perché $g$ è noto.
]

#align(center, graph-card([Campo gravitazionale terrestre e forza peso], cetz.canvas({
  import cetz.draw: *
  // superficie terrestre: semicirconferenza di centro C=(3.5,0)
  arc((6.5, 0), start: 0deg, stop: 180deg, radius: 3, stroke: 1.7pt + blue)
  // linee del campo locale, tutte dirette radialmente verso il centro
  line((6.10, 1.50), (5.66, 1.25), stroke: 1.1pt + green, mark: (end: ">"))
  line((5.00, 2.60), (4.75, 2.16), stroke: 1.1pt + green, mark: (end: ">"))
  line((2.00, 2.60), (2.25, 2.16), stroke: 1.1pt + green, mark: (end: ">"))
  line((0.90, 1.50), (1.34, 1.25), stroke: 1.1pt + green, mark: (end: ">"))
  // corpo e forza peso applicata al corpo
  circle((3.5, 3.55), radius: 0.1, fill: ink, stroke: none)
  line((3.5, 3.48), (3.5, 2.18), stroke: 1.7pt + red, mark: (end: ">"))
  axis-label((3.72, 2.72), [$vec(F)_"peso"$], placement: "west")
  axis-label((5.12, 2.32), [$vec(g)$], placement: "west")
  axis-label((3.35, 3.65), [$m$], placement: "east")
  axis-label((3.5, -0.12), [Terra], placement: "north")
})))

Applicando la seconda legge,

$ vec(F)_"peso"=m_i vec(a), $

dove $m_i$ è la *massa inerziale*. Sperimentalmente massa gravitazionale e massa inerziale risultano equivalenti:

$ m_g=m_i=m. $

Di conseguenza

$ m vec(g)=m vec(a) quad arrow quad vec(a)=vec(g), $

e tutti i corpi in caduta libera hanno la stessa accelerazione, indipendentemente dalla massa, se si trascura la resistenza dell'aria.

#yellow-box([Perché la massa si semplifica, e perché è sorprendente])[
  Per un corpo in caduta libera l'unica forza è il peso, quindi la seconda legge dà $m_g vec(g)=m_i vec(a)$. A sinistra la massa che compare è quella *gravitazionale* (quanto la gravità ti tira); a destra è quella *inerziale* (quanto resisti ad accelerare). A priori sarebbero due grandezze diverse. Ma poiché l'esperimento dice $m_g=m_i=m$, possiamo *dividere entrambi i lati per $m$*, e la massa sparisce:
  $ m vec(g)=m vec(a) quad arrow quad vec(a)=vec(g). $
  La conseguenza è la famosa scoperta di Galileo: *una piuma e un sasso cadono insieme* (nel vuoto), perché l'accelerazione di caduta $vec(a)=vec(g)$ non dipende dalla massa. Il sasso è tirato più forte, ma è anche proporzionalmente più "pigro" da accelerare: i due effetti si bilanciano esattamente.
]

#yellow-box([Due ruoli della massa])[
  La massa gravitazionale determina la forza peso; la massa inerziale determina la risposta del corpo alla forza. La loro equivalenza spiega l'universalità della caduta libera.
]

== Forza elastica

#green-box([L'idea prima della formula])[
  Una molla "vuole sempre tornare a casa". Se la tiri, ti tira indietro; se la comprimi, ti spinge in fuori. In entrambi i casi cerca di riportare il corpo nella sua *posizione di equilibrio* (quella naturale, a riposo). E più la deformi, più reagisce con forza: tirare una molla del doppio richiede il doppio della forza. Questa è la *legge di Hooke*.

  Il segno meno nella formula è tutta l'intuizione: significa che la forza punta sempre nel verso *opposto* allo spostamento, cioè "verso casa".
]

Una molla ideale esercita una forza proporzionale e contraria allo spostamento dalla posizione di equilibrio:

#blue-box([Legge di Hooke])[
  $ vec(F)_"el"=-k x hat(u)_x, $

  dove $k>0$ è la *costante elastica*, misurata in $"N/m"$, e $x$ è lo spostamento dalla posizione di equilibrio $x=0$.

  Il simbolo $hat(u)_x$ è il versore dell'asse $x$: ha modulo $1$ e indica la direzione positiva dell'asse della molla. Il segno meno mostra che la forza elastica è sempre opposta allo spostamento: se $x>0$ la forza punta verso $-x$, se $x<0$ punta verso $+x$.
]

#yellow-box([Cosa rappresenta la costante elastica $k$])[
  La costante $k$ misura quanto è "dura" la molla: una molla rigida (grande $k$) reagisce con forza anche a piccole deformazioni, una molla morbida (piccolo $k$) si lascia allungare facilmente. L'unità $"N/m"$ si legge proprio così: quanti newton di forza servono per allungare la molla di un metro. Per esempio $k=200 " N/m"$ vuol dire che per ogni metro di allungamento la molla risponde con $200 " N"$.
]

#purple-box([Esempio numerico])[
  Una molla con $k=150 " N/m"$ viene allungata di $x=0,2 " m"$ dalla posizione di equilibrio. Il modulo della forza di richiamo è
  $ F_"el"=k x=150 " N/m" dot 0,2 " m"=30 " N", $
  diretta verso la posizione di equilibrio (cioè verso $-x$, perché lo spostamento è positivo). Controllo unità: $"N/m" dot "m"="N"$, una forza, giusto.
]

#align(center, graph-card([Forza elastica opposta allo spostamento], cetz.canvas({
  import cetz.draw: *
  // parete e asse x
  line((0.6, 0.15), (0.6, 2.15), stroke: 1.3pt + ink)
  for y in range(0, 6) { line((0.35, 0.25 + y*0.34), (0.6, 0.48 + y*0.34), stroke: 0.7pt + ink) }
  line((0.6, 1.15), (6.5, 1.15), stroke: 0.8pt + grid-color, mark: (end: ">"))
  // molla e punto materiale spostato a destra
  line((0.6, 1.15), (0.92, 1.15), stroke: 1.25pt + blue)
  line((0.92, 1.15), (1.08, 1.38), (1.32, 0.92), (1.56, 1.38), (1.80, 0.92), (2.04, 1.38), (2.28, 0.92), (2.52, 1.38), (2.76, 0.92), (3.00, 1.38), (3.24, 0.92), (3.40, 1.15), stroke: 1.25pt + blue)
  line((3.40, 1.15), (3.70, 1.15), stroke: 1.25pt + blue)
  circle((3.70, 1.15), radius: 0.13, fill: ink, stroke: none)
  line((3.70, 1.52), (2.45, 1.52), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((6.5, 0.97), [$x$], placement: "north")
  axis-label((3.08, 1.82), [$vec(F)_"el"$], placement: "south")
  axis-label((3.70, 0.88), [$x>0$], placement: "north")
})))

Applicando la seconda legge lungo $x$:

$ m (dif^2 x)/(dif t^2)=-k x, $

quindi

$ (dif^2 x)/(dif t^2)+k/m x=0. $

#yellow-box([I passaggi: da $F=m a$ all'equazione del moto])[
  - L'unica forza lungo $x$ è quella elastica, di componente $-k x$. La seconda legge $F_x=m a_x$ diventa quindi $m a_x = -k x$.
  - L'accelerazione è la *derivata seconda* della posizione rispetto al tempo: $a_x=(dif^2 x)/(dif t^2)$. Sostituendo si ottiene $m (dif^2 x)/(dif t^2)=-k x$.
  - Portando tutto a sinistra e dividendo per $m$ (lecito, $m eq.not 0$): $(dif^2 x)/(dif t^2)+k/m x=0$.

  Questa si chiama *equazione differenziale* del moto: lega la posizione alla sua derivata seconda. La sua soluzione è un'oscillazione del tipo coseno/seno, che è proprio il moto armonico semplice.
]

È l'equazione del moto armonico semplice, con

$ omega=sqrt(k/m), quad T=(2pi)/omega=2pi sqrt(m/k). $

Qui $omega$ è la *pulsazione* dell'oscillazione, cioè la rapidità angolare del ciclo misurata in $"rad"/"s"$. Il simbolo $T$ è invece il *periodo*, cioè il tempo necessario per compiere un'oscillazione completa.

#yellow-box([Le formule di $omega$ e $T$ hanno senso "a occhio"?])[
  Guarda $omega=sqrt(k\/m)$: la pulsazione cresce con $k$ (molla più dura $arrow.r$ oscillazione più rapida) e cala con $m$ (massa più grande $arrow.r$ oscillazione più lenta). È esattamente l'intuizione: una molla rigida con un pesino fa "din-din" velocissimo, una molla morbida con un mattone dondola piano. Il periodo $T=2pi\/omega$ è l'inverso: più $omega$ è grande, più $T$ è piccolo (oscilla in fretta, ci mette poco a fare un giro completo).
]

#purple-box([Esempio numerico])[
  Una massa $m=0,5 " kg"$ attaccata a una molla con $k=8 " N/m"$ oscilla. La pulsazione è
  $ omega=sqrt(k/m)=sqrt((8)/(#[0,5]))=sqrt(16)=4 " rad/s", $
  e il periodo
  $ T=(2pi)/omega=(2pi)/4 approx 1,57 " s". $
  Ogni oscillazione completa dura circa $1,57 " s"$.
]

= Reazioni vincolari

#green-box([L'idea prima della formula])[
  Perché un libro appoggiato sul tavolo *non cade*, anche se la gravità lo tira giù? Perché il tavolo lo *sostiene*: spinge il libro verso l'alto con una forza che bilancia esattamente il peso. Questa forza che il tavolo (o qualsiasi superficie) esercita per impedire al corpo di compenetrarlo si chiama *reazione normale* $vec(N)$.

  Due cose da ricordare:
  - "*normale*" qui è un termine tecnico e significa *perpendicolare alla superficie*, non "ordinaria";
  - la superficie può solo *spingere*, mai *tirare*: per questo $N>=0$. Appena il corpo si stacca, la reazione svanisce. Un tavolo non può "tenere incollato" un corpo che sta volando via.
]

Un *vincolo* impedisce alcuni movimenti del corpo e reagisce esercitando una forza. La reazione normale $vec(N)$ è perpendicolare alla superficie di contatto e può esistere soltanto finché il contatto è mantenuto: $N>=0$.

#align(center, graph-card([Corpo libero e corpo appoggiato], cetz.canvas({
  import cetz.draw: *
  // sinistra: corpo libero sopra la Terra
  circle((1.35, 2.65), radius: 0.1, fill: ink, stroke: none)
  line((1.35, 2.55), (1.35, 1.55), stroke: 1.4pt + red, mark: (end: ">"))
  arc((3.1, -0.3), start: 0deg, stop: 180deg, radius: 1.75, stroke: 1.3pt + blue)
  axis-label((0.98, 2.7), [$m$], placement: "east")
  axis-label((1.52, 2.0), [$m vec(g)$], placement: "west")
  // destra: corpo su appoggio orizzontale
  line((3.95, 0.95), (7.0, 0.95), stroke: 1.3pt + ink)
  for x in range(0, 8) { line((4.0 + x*0.38, 0.95), (4.18 + x*0.38, 0.72), stroke: 0.6pt + ink) }
  rect((5.05, 0.95), (5.85, 1.65), fill: rgb("#edf3f8"), stroke: 1pt + ink)
  line((5.45, 1.3), (5.45, 2.35), stroke: 1.5pt + green, mark: (end: ">"))
  line((5.45, 1.3), (5.45, 0.2), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((5.62, 2.28), [$vec(N)$], placement: "west")
  axis-label((5.62, 0.3), [$m vec(g)$], placement: "west")
})))

Se il corpo è in equilibrio verticale,

$ m vec(g)+vec(N)=vec(0). $

Proiettando sull'asse verticale positivo verso l'alto si ottiene l'equazione scalare

$ N-m g=0 quad arrow quad N=m g. $

Qui $N$ e $m g$ sono i moduli delle due forze: la forma vettoriale tiene conto dei versi, mentre la forma scalare usa i segni delle componenti lungo l'asse scelto.

#yellow-box([Da dove esce il segno meno in $N-m g=0$])[
  Partiamo dall'equazione vettoriale $m vec(g)+vec(N)=vec(0)$ (equilibrio: la somma delle forze è nulla) e la proiettiamo sull'asse verticale, scelto *positivo verso l'alto*. Allora:
  - la reazione $vec(N)$ punta in *alto*, quindi la sua componente è $+N$;
  - il peso $m vec(g)$ punta in *basso*, quindi la sua componente è $-m g$ (segno negativo perché va contro il verso positivo dell'asse).

  Sommando le componenti e ponendole uguali a zero: $N-m g=0$, da cui $N=m g$. Il segno meno *non* è un errore né dice che il peso è negativo: registra solo che peso e normale puntano in versi opposti. È il vantaggio di passare alle componenti scalari: i versi diventano semplici segni $+$ e $-$.
]

#purple-box([Esempio numerico])[
  Un libro di massa $m=1,5 " kg"$ è appoggiato fermo su un tavolo orizzontale. La reazione normale che il tavolo esercita è
  $ N=m g=1,5 dot 9,81 approx 14,7 " N", $
  diretta verso l'alto, uguale e contraria al peso. Per la terza legge, il libro spinge il tavolo verso il basso con la stessa intensità ($14,7 " N"$).
]

#align(center, graph-card([Diagramma delle forze: appoggio orizzontale], cetz.canvas({
  import cetz.draw: *
  circle((2.4, 1.35), radius: 0.09, fill: ink, stroke: none)
  line((2.4, 1.35), (2.4, 2.75), stroke: 1.6pt + green, mark: (end: ">"))
  line((2.4, 1.35), (2.4, -0.05), stroke: 1.6pt + red, mark: (end: ">"))
  axis-label((2.62, 2.68), [$vec(N)$], placement: "west")
  axis-label((2.62, 0.05), [$m vec(g)$], placement: "west")
})))

Se una forza esterna $vec(F)$ spinge ulteriormente il corpo verso il basso,

$ m vec(g)+vec(F)+vec(N)=vec(0). $

Con asse verticale positivo verso l'alto, il peso e la forza esterna hanno componente negativa, mentre la normale ha componente positiva:

$ N-m g-F=0 quad arrow quad N=m g+F. $

#yellow-box([Perché ora la normale è più grande del peso])[
  Stesso ragionamento di prima, ma ora c'è una forza in più verso il basso: sia il peso ($-m g$) sia la forza esterna ($-F$) hanno componente negativa, mentre la normale resta positiva ($+N$). L'equilibrio dà $N-m g-F=0$, cioè $N=m g+F$. Ha senso: se premi sul corpo, il tavolo deve spingere *più forte* per reggerlo. La normale si "adatta" alle altre forze; non è una costante fissa pari al peso.
]

#align(center, graph-card([Appoggio con forza esterna verso il basso], cetz.canvas({
  import cetz.draw: *
  line((0.7, 0.55), (6.3, 0.55), stroke: 1.3pt + ink)
  for x in range(0, 12) { line((0.75 + x*0.46, 0.55), (0.95 + x*0.46, 0.32), stroke: 0.55pt + ink) }
  rect((2.65, 0.55), (3.85, 1.55), fill: rgb("#edf3f8"), stroke: 1pt + ink)
  circle((3.25, 1.05), radius: 0.06, fill: ink, stroke: none)
  line((3.25, 1.05), (3.25, 2.45), stroke: 1.5pt + green, mark: (end: ">"))
  line((3.25, 1.05), (3.25, -0.05), stroke: 1.5pt + red, mark: (end: ">"))
  line((2.75, 2.55), (2.75, 1.55), stroke: 1.5pt + blue, mark: (end: ">"))
  axis-label((3.43, 2.38), [$vec(N)$], placement: "west")
  axis-label((3.43, 0.03), [$m vec(g)$], placement: "west")
  axis-label((2.58, 2.35), [$vec(F)$], placement: "east")
  // diagramma di corpo libero separato
  circle((5.35, 1.2), radius: 0.08, fill: ink, stroke: none)
  line((5.35, 1.2), (5.35, 2.55), stroke: 1.5pt + green, mark: (end: ">"))
  line((5.35, 1.2), (5.35, 0.15), stroke: 1.5pt + red, mark: (end: ">"))
  line((4.92, 1.2), (4.92, 0.35), stroke: 1.5pt + blue, mark: (end: ">"))
  axis-label((5.55, 2.48), [$vec(N)$], placement: "west")
  axis-label((5.55, 0.25), [$m vec(g)$], placement: "west")
  axis-label((4.72, 0.43), [$vec(F)$], placement: "east")
})))

#yellow-box([La normale non è sempre $m g$])[
  Il valore di $N$ si ricava dalla seconda legge lungo la direzione normale al vincolo. Dipende da tutte le altre forze con componente normale.
]

== Appoggio su un piano inclinato

#green-box([L'idea prima della formula])[
  Su un piano inclinato la cosa furba è *inclinare anche gli assi*: si prende $x$ *parallelo* al piano (la direzione lungo cui il corpo scivolerebbe) e $y$ *perpendicolare* al piano (la direzione della reazione normale). In questo modo la normale $vec(N)$ è già tutta lungo $y$ e non va scomposta. L'unica forza "obliqua" rispetto ai nuovi assi resta il peso, che va spezzato nelle sue due componenti:
  - una lungo il piano ($m g sin theta$), che spinge il corpo verso valle;
  - una contro il piano ($m g cos theta$), che lo schiaccia sulla superficie.

  Il diagramma seguente mostra questa scomposizione del peso (le frecce tratteggiate) e il diagramma di corpo libero isolato a destra.
]

#align(center, graph-card([Reazione normale su un piano inclinato], cetz.canvas({
  import cetz.draw: *
  // piano inclinato di angolo theta
  line((0.55, 0.35), (5.75, 3.15), stroke: 1.5pt + ink)
  line((0.55, 0.35), (5.75, 0.35), stroke: 0.8pt + grid-color)
  // corpo schematizzato nel punto P
  circle((3.0, 1.67), radius: 0.1, fill: ink, stroke: none)
  // peso verticale e normale perpendicolare al piano
  line((3.0, 1.67), (3.0, 0.35), stroke: 1.5pt + red, mark: (end: ">"))
  line((3.0, 1.67), (2.2, 3.15), stroke: 1.5pt + green, mark: (end: ">"))
  // componenti del peso parallela e normale
  line((3.0, 1.67), (1.9, 1.08), stroke: (paint: gold, thickness: 1.2pt, dash: "dashed"), mark: (end: ">"))
  line((3.0, 1.67), (3.7, 0.37), stroke: (paint: gold, thickness: 1.2pt, dash: "dashed"), mark: (end: ">"))
  line((1.62, 2.08), (0.95, 1.72), stroke: 0.8pt + ink, mark: (end: ">"))
  line((0.95, 1.72), (0.60, 2.38), stroke: 0.8pt + ink, mark: (end: ">"))
  arc((1.15, 0.35), start: 0deg, stop: 28deg, radius: 0.6, stroke: 1pt + blue)
  axis-label((1.2, 0.58), [$theta$], placement: "south")
  axis-label((1.66, 2.10), [$x$], placement: "west")
  axis-label((0.55, 2.42), [$y$], placement: "east")
  axis-label((3.16, 0.55), [$m vec(g)$], placement: "west")
  axis-label((2.08, 3.2), [$vec(N)$], placement: "east")
  axis-label((1.65, 1.28), [$m g sin theta$], placement: "east")
  axis-label((4.05, 0.55), [$m g cos theta$], placement: "west")
  // diagramma di corpo libero isolato
  circle((7.2, 1.55), radius: 0.09, fill: ink, stroke: none)
  line((7.2, 1.55), (6.35, 3.05), stroke: 1.5pt + green, mark: (end: ">"))
  line((7.2, 1.55), (7.2, 0.1), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((6.22, 3.1), [$vec(N)$], placement: "east")
  axis-label((7.42, 0.2), [$m vec(g)$], placement: "west")
})))

In assenza di accelerazione normale al piano,

$ N-m g cos theta=0 quad arrow quad N=m g cos theta. $

Anche qui l'equazione è scalare: è la proiezione della seconda legge lungo l'asse perpendicolare al piano. La componente del peso lungo quell'asse punta verso il piano, quindi entra con segno negativo rispetto a $vec(N)$.

#yellow-box([Perché compare il coseno (e non il seno)])[
  La componente del peso *perpendicolare* al piano è quella che "schiaccia" il corpo sulla superficie, ed è $m g cos theta$. Il modo più sicuro per ricordarlo è coi *casi limite*:
  - se $theta=0$ (piano orizzontale, nessuna pendenza), la normale deve reggere tutto il peso: $N=m g cos 0=m g$. Corretto.
  - se $theta=90 degree$ (piano verticale, una parete), il corpo non preme affatto sulla parete: $N=m g cos 90 degree=0$. Corretto.

  Il coseno fa esattamente questo lavoro: vale $1$ per piano piatto e $0$ per parete verticale. La componente *lungo* il piano (che fa scivolare) è invece $m g sin theta$, che cresce da $0$ a $m g$ man mano che il piano si fa più ripido.
]

#purple-box([Esempio numerico])[
  Un blocco di massa $m=2 " kg"$ è appoggiato su un piano inclinato di $theta=30 degree$. La reazione normale vale
  $ N=m g cos theta=2 dot 9,81 dot cos 30 degree=2 dot 9,81 dot 0,866 approx 17,0 " N", $
  mentre la componente del peso che lo tira verso valle è
  $ m g sin theta=2 dot 9,81 dot 0,5=9,81 " N". $
  Nota che $N approx 17,0 " N"$ è *minore* del peso pieno $m g approx 19,6 " N"$: parte del peso è "deviata" lungo il piano e non grava più sulla superficie.
]

= Tensione della fune

#green-box([L'idea prima della formula])[
  Una fune (o un filo, una corda) può solo *tirare*, mai spingere — prova a "spingere" qualcosa con una corda: si affloscia. La forza con cui la fune tira il corpo a cui è attaccata si chiama *tensione* $vec(T)$, ed è sempre diretta *lungo la fune*, verso il punto a cui la fune è agganciata (verso "chi tira").

  "Fune ideale" significa due semplificazioni che useremo sempre: *massa nulla* (la corda non pesa) e *inestensibile* (non si allunga). La conseguenza più utile è che la tensione è la *stessa in ogni punto* della fune: se da un lato c'è $10 " N"$ di tensione, dall'altro lato c'è $10 " N"$.
]

Una fune ideale ha massa nulla ed è inestensibile. La forza esercitata dalla fune è la *tensione* $vec(T)$, diretta lungo la fune e rivolta verso il punto di sospensione.

#grid(columns: (1fr, 1fr), gutter: 10pt,
  graph-card([Massa sospesa], cetz.canvas({
    import cetz.draw: *
    line((0.8, 2.85), (3.8, 2.85), stroke: 1.1pt + ink)
    for x in range(0, 7) { line((0.9 + x*0.42, 2.85), (1.08 + x*0.42, 3.08), stroke: 0.6pt + ink) }
    line((2.3, 2.85), (2.3, 1.55), stroke: 1.2pt + ink)
    rect((1.85, 0.75), (2.75, 1.55), fill: rgb("#edf3f8"), stroke: 1pt + ink)
    line((2.3, 1.15), (2.3, 2.25), stroke: 1.4pt + green, mark: (end: ">"))
    line((2.3, 1.15), (2.3, 0.1), stroke: 1.4pt + red, mark: (end: ">"))
    axis-label((2.5, 2.15), [$vec(T)$], placement: "west")
    axis-label((2.5, 0.2), [$m vec(g)$], placement: "west")
  })),
  graph-card([Carrucola e piano inclinato], cetz.canvas({
    import cetz.draw: *
    // carrucola con due masse
    circle((2.2, 2.35), radius: 0.48, stroke: 1.1pt + ink)
    arc((1.72, 2.35), start: 180deg, stop: 0deg, radius: 0.48, stroke: 1pt + blue)
    line((1.72, 2.35), (1.72, 0.7), stroke: 1.1pt + blue)
    line((2.68, 2.35), (2.68, 1.0), stroke: 1.1pt + blue)
    rect((1.4, 0.25), (2.04, 0.7), fill: rgb("#edf3f8"), stroke: 0.8pt + ink)
    rect((2.36, 0.55), (3.0, 1.0), fill: rgb("#edf3f8"), stroke: 0.8pt + ink)
    axis-label((1.72, 0.05), [$m_1$], placement: "north")
    axis-label((2.68, 0.35), [$m_2$], placement: "north")
    axis-label((2.2, 2.35), [$O$])
  })),
)

Per una massa sospesa in equilibrio:

$ vec(T)+m vec(g)=vec(0) quad arrow quad T=m g. $

#yellow-box([Perché $T=m g$ in questo caso])[
  La massa appesa è ferma, quindi la somma delle forze è nulla: $vec(T)+m vec(g)=vec(0)$. Sull'asse verticale (positivo verso l'alto) la tensione tira su ($+T$) e il peso tira giù ($-m g$): $T-m g=0$, da cui $T=m g$. La fune deve "fare la forza giusta" per reggere tutto il peso. Attenzione: questo vale *solo* quando la massa è in equilibrio sotto sole tensione e peso verticali. Se la massa accelerasse, o se la fune fosse inclinata, $T$ non sarebbe più semplicemente $m g$ (lo si vede subito nei due esempi che seguono).
]

#align(center, graph-card([Diagramma delle forze: massa sospesa], cetz.canvas({
  import cetz.draw: *
  circle((2.4, 1.35), radius: 0.09, fill: ink, stroke: none)
  line((2.4, 1.35), (2.4, 2.75), stroke: 1.6pt + green, mark: (end: ">"))
  line((2.4, 1.35), (2.4, -0.05), stroke: 1.6pt + red, mark: (end: ">"))
  axis-label((2.62, 2.68), [$vec(T)$], placement: "west")
  axis-label((2.62, 0.05), [$m vec(g)$], placement: "west")
})))

In una stessa fune ideale, in assenza di carrucole massive o attriti, il modulo della tensione è uguale in ogni tratto.

== Nodo sostenuto da tre funi

#green-box([L'idea prima della formula])[
  Qui il "corpo" da studiare è il *nodo* dove si incontrano le tre funi: un punto su cui agiscono tre tensioni. Poiché il nodo è fermo, le tre forze devono *bilanciarsi*: la loro somma vettoriale è zero. Ma le tensioni $vec(T)_A$ e $vec(T)_B$ sono *oblique* (formano $30 degree$ e $45 degree$ con l'orizzontale), quindi non possiamo sommarle a occhio: dobbiamo scomporle lungo $x$ (orizzontale) e $y$ (verticale) e imporre l'equilibrio separatamente sui due assi. È l'applicazione diretta del metodo del diagramma di corpo libero.
]

Nel disegno degli appunti due funi sostengono il nodo formando $30 degree$ e $45 degree$ con l'orizzontale; la terza sostiene verticalmente una massa $m$.

#align(center, graph-card([Nodo e diagrammi delle forze], cetz.canvas({
  import cetz.draw: *
  // configurazione reale, a sinistra
  line((0.35, 3.2), (3.1, 1.55), stroke: 1.4pt + ink)
  line((5.25, 3.2), (3.1, 1.55), stroke: 1.4pt + ink)
  line((3.1, 1.55), (3.1, 0.35), stroke: 1.4pt + ink)
  circle((3.1, 1.55), radius: 0.09, fill: ink, stroke: none)
  rect((2.72, -0.15), (3.48, 0.35), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  axis-label((0.55, 2.95), [$A$], placement: "west")
  axis-label((5.05, 2.95), [$B$], placement: "east")
  axis-label((3.28, 0.82), [$C$], placement: "west")
  axis-label((1.3, 2.63), [$30 degree$], placement: "south")
  axis-label((4.55, 2.75), [$45 degree$], placement: "south")
  // diagramma del nodo, a destra
  circle((7.35, 1.65), radius: 0.09, fill: ink, stroke: none)
  line((7.35, 1.65), (6.05, 2.95), stroke: 1.5pt + red, mark: (end: ">"))
  line((7.35, 1.65), (8.65, 2.95), stroke: 1.5pt + green, mark: (end: ">"))
  line((7.35, 1.65), (7.35, 0.25), stroke: 1.5pt + gold, mark: (end: ">"))
  axis-label((5.95, 3.05), [$vec(T)_A$], placement: "east")
  axis-label((8.75, 3.05), [$vec(T)_B$], placement: "west")
  axis-label((7.55, 0.35), [$vec(T)_C$], placement: "west")
})))

Per la massa sospesa, $T_C=m g$. L'equilibrio del nodo richiede

$ vec(T)_A+vec(T)_B+vec(T)_C=vec(0). $

Con $x$ orizzontale verso destra e $y$ verticale verso l'alto:

$ cases(
  -T_A cos 30 degree+T_B cos 45 degree=0,
  T_A sin 30 degree+T_B sin 45 degree-T_C=0,
) $

#yellow-box([Da dove escono queste due equazioni])[
  Scomponiamo ogni tensione lungo $x$ e $y$ (guarda il diagramma del nodo: $vec(T)_A$ tira in alto a sinistra, $vec(T)_B$ in alto a destra, $vec(T)_C$ dritta in basso).

  *Asse $x$ (orizzontale):* $vec(T)_A$ tira verso *sinistra*, quindi la sua componente è $-T_A cos 30 degree$ (negativa); $vec(T)_B$ tira verso *destra*, componente $+T_B cos 45 degree$; $vec(T)_C$ è verticale, quindi non ha componente orizzontale. L'equilibrio lungo $x$ dà la prima equazione: $-T_A cos 30 degree+T_B cos 45 degree=0$.

  *Asse $y$ (verticale):* $vec(T)_A$ e $vec(T)_B$ tirano entrambe verso *l'alto*, con componenti $+T_A sin 30 degree$ e $+T_B sin 45 degree$; $vec(T)_C$ tira verso il *basso* (regge la massa), componente $-T_C$. L'equilibrio lungo $y$ dà la seconda equazione.

  Usiamo il *coseno* per le componenti orizzontali e il *seno* per quelle verticali perché gli angoli $30 degree$ e $45 degree$ sono misurati *dall'orizzontale*: il lato adiacente all'angolo è quello orizzontale.
]

#purple-box([Esempio numerico])[
  Supponiamo $m=10 " kg"$, così $T_C=m g=10 dot 9,81=98,1 " N"$. Dalla prima equazione ricaviamo $T_A$ in funzione di $T_B$:
  $ T_A=T_B (cos 45 degree)/(cos 30 degree)=T_B (0,707)/(0,866)=0,816 thick T_B. $
  Sostituendo nella seconda equazione ($sin 30 degree=0,5$, $sin 45 degree=0,707$):
  $ 0,816 thick T_B dot 0,5+T_B dot 0,707=98,1 quad arrow quad (0,408+0,707) thick T_B=98,1, $
  $ T_B=(98,1)/(1,115) approx 88,0 " N", quad T_A=0,816 dot 88,0 approx 71,8 " N". $
  Le due funi reggono tensioni diverse pur sostenendo lo stesso nodo: quella più verticale (a $45 degree$) lavora di più.
]

= Corpo tirato da una fune su superficie liscia

#green-box([L'idea prima della formula])[
  Immagina di tirare una valigia con le rotelle usando una cinghia inclinata verso l'alto. La forza $vec(F)$ che applichi fa due cose contemporaneamente:
  - una parte ($F cos theta$, orizzontale) *trascina* in avanti la valigia;
  - una parte ($F sin theta$, verticale) la *solleva* un po', alleggerendo la pressione sul pavimento.

  Per questo il problema si scompone in due equazioni: lungo $x$ governa il movimento (la valigia accelera), lungo $y$ governa l'equilibrio verticale (la valigia resta a terra, finché non la sollevi del tutto). "Superficie liscia" significa *senza attrito*: lungo $x$ l'unica forza è $F cos theta$.
]

Una forza $vec(F)$ tira un blocco di massa $m$ formando un angolo $theta$ con una superficie orizzontale priva di attrito.

#align(center, graph-card([Blocco tirato da una fune], cetz.canvas({
  import cetz.draw: *
  line((0.5, 0.65), (6.5, 0.65), stroke: 1.4pt + ink)
  for x in range(0, 13) { line((0.55 + x*0.45, 0.65), (0.75 + x*0.45, 0.42), stroke: 0.55pt + ink) }
  rect((2.35, 0.65), (3.65, 1.75), fill: rgb("#edf3f8"), stroke: 1pt + ink)
  circle((3.0, 1.2), radius: 0.06, fill: ink, stroke: none)
  line((3.0, 1.2), (4.75, 2.45), stroke: 1.6pt + blue, mark: (end: ">"))
  line((3.0, 1.2), (4.45, 1.2), stroke: (paint: blue, thickness: 1.05pt, dash: "dashed"), mark: (end: ">"))
  line((4.45, 1.2), (4.45, 2.23), stroke: (paint: blue, thickness: 1.05pt, dash: "dashed"), mark: (end: ">"))
  line((3.0, 1.2), (3.0, 2.55), stroke: 1.5pt + green, mark: (end: ">"))
  line((3.0, 1.2), (3.0, 0.05), stroke: 1.5pt + red, mark: (end: ">"))
  arc((3.75, 1.2), start: 0deg, stop: 35deg, radius: 0.75, stroke: 1pt + gold)
  axis-label((4.82, 2.5), [$vec(F)$], placement: "west")
  axis-label((3.78, 1.02), [$F cos theta$], placement: "north")
  axis-label((4.60, 1.75), [$F sin theta$], placement: "west")
  axis-label((3.18, 2.5), [$vec(N)$], placement: "west")
  axis-label((3.18, 0.12), [$m vec(g)$], placement: "west")
  axis-label((3.66, 1.47), [$theta$], placement: "south")
  axis-label((1.2, 0.25), [superficie liscia], placement: "north")
  // diagramma delle forze isolato, a destra
  circle((7.1, 1.25), radius: 0.09, fill: ink, stroke: none)
  line((7.1, 1.25), (8.55, 2.3), stroke: 1.6pt + blue, mark: (end: ">"))
  line((7.1, 1.25), (8.28, 1.25), stroke: (paint: blue, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((8.28, 1.25), (8.28, 2.1), stroke: (paint: blue, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((7.1, 1.25), (7.1, 2.65), stroke: 1.5pt + green, mark: (end: ">"))
  line((7.1, 1.25), (7.1, -0.05), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((8.62, 2.35), [$vec(F)$], placement: "west")
  axis-label((7.78, 1.05), [$F_x$], placement: "north")
  axis-label((8.43, 1.72), [$F_y$], placement: "west")
  axis-label((6.9, 2.58), [$vec(N)$], placement: "east")
  axis-label((7.3, 0.05), [$m vec(g)$], placement: "west")
})))

La seconda legge, proiettata sugli assi, dà

$ cases(
  F cos theta=m a_x,
  N+F sin theta-m g=0,
) $

#yellow-box([Leggiamo le due righe del sistema])[
  *Lungo $x$ (orizzontale):* l'unica forza orizzontale è la componente $F cos theta$ (niente attrito, il peso e la normale sono verticali). Il blocco si muove, quindi a destra c'è $m a_x$: ecco $F cos theta=m a_x$.

  *Lungo $y$ (verticale):* il blocco *non si solleva* (resta sul piano), quindi $a_y=0$ e le forze verticali si bilanciano. Verso l'alto: normale $+N$ e tiro verticale $+F sin theta$; verso il basso: peso $-m g$. Sommando e ponendo uguale a zero: $N+F sin theta-m g=0$. Nota la differenza con il caso "forza verso il basso" visto prima: qui il tiro è verso l'*alto*, quindi *aiuta* a reggere il peso e *riduce* la normale.
]

Quindi

$ cases(
  a_x=(F cos theta)/m,
  N=m g-F sin theta,
) $

#yellow-box([Come si è isolato ogni risultato])[
  Dalla prima riga, dividendo per $m$: $a_x=(F cos theta)\/m$. Dalla seconda, portando $N$ da solo a sinistra: $N=m g-F sin theta$. Si vede subito che *più tiri verso l'alto* (più grande $F sin theta$), *meno il blocco preme* sul piano: la normale cala.
]

Se $F$ è costante, il moto lungo $x$ è uniformemente accelerato:

$ x(t)=x_0+v_0t+1/2 (F cos theta)/m t^2. $

#yellow-box([Perché ricompare la formula della cinematica])[
  Se $F$ e $theta$ sono costanti, anche $a_x=(F cos theta)\/m$ è costante: siamo nel caso del moto *uniformemente accelerato*, di cui conosciamo già la legge oraria $x(t)=x_0+v_0 t+1/2 a_x t^2$. Basta sostituire $a_x=(F cos theta)\/m$ al posto dell'accelerazione. È il punto in cui *dinamica e cinematica si saldano*: la dinamica fornisce $a_x$, la cinematica ti dà posizione e velocità nel tempo.
]

Il blocco si stacca dalla superficie quando $N=0$; la soglia è

$ F sin theta=m g quad arrow quad F=(m g)/(sin theta). $

#yellow-box([Perché la condizione di distacco è $N=0$])[
  La normale può solo spingere ($N>=0$), e si annulla nell'istante in cui il blocco sta per *staccarsi* da terra. Imponendo $N=0$ nella formula $N=m g-F sin theta$ si ottiene $m g-F sin theta=0$, cioè $F sin theta=m g$: la componente verticale del tiro pareggia esattamente il peso. Risolvendo per $F$: $F=(m g)\/(sin theta)$. Per $F$ maggiore di questo valore, il blocco si solleva.
]

#purple-box([Esempio numerico])[
  Un blocco di $m=5 " kg"$ è tirato con $F=20 " N"$ a un angolo $theta=30 degree$ su un piano liscio. Allora:
  $ a_x=(F cos theta)/m=(20 dot 0,866)/(5)=(17,3)/(5)approx 3,46 " m/s"^2, $
  $ N=m g-F sin theta=5 dot 9,81-20 dot 0,5=49,05-10=39,1 " N". $
  La normale ($39,1 " N"$) è minore del peso pieno ($49,05 " N"$) proprio perché il tiro solleva un po' il blocco. Il distacco avverrebbe per $F=(m g)\/(sin theta)=49,05\/0,5=98,1 " N"$: molto più dei $20 " N"$ applicati, quindi il blocco resta a terra.
]

= Piano inclinato liscio

#green-box([L'idea prima della formula])[
  Questo è il problema "classico" che raccoglie tutto: peso, normale e tensione su un piano inclinato. La strategia vincente è sempre la stessa del piano inclinato visto prima: *assi ruotati*, con $x$ lungo il piano (verso valle) e $y$ perpendicolare al piano. Così normale e tensione cadono già lungo gli assi, e l'unico vettore da scomporre è il peso, che dà $m g sin theta$ lungo il piano e $m g cos theta$ contro il piano.

  Studieremo due situazioni: prima il blocco *trattenuto da una fune* (sta fermo, equilibrio statico), poi cosa succede *tagliando la fune* (il blocco scivola, moto accelerato). Confrontarle fa capire bene il ruolo di ogni forza.
]

Consideriamo un blocco su un piano inclinato di angolo $theta$, senza attrito. Scegliamo $x$ parallelo al piano verso valle e $y$ normale al piano verso l'esterno.

#align(center, graph-card([Piano inclinato: prima e dopo il taglio della fune], cetz.canvas({
  import cetz.draw: *
  // situazione con fune, a sinistra
  line((0.45, 0.35), (4.8, 2.85), stroke: 1.5pt + ink)
  line((4.8, 2.85), (4.8, 0.35), stroke: 1.1pt + ink)
  line((0.45, 0.35), (4.8, 0.35), stroke: 1.1pt + ink)
  rect((2.15, 1.2), (2.85, 1.75), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.5, 1.48), (3.55, 2.08), stroke: 1.4pt + blue, mark: (end: ">"))
  line((2.5, 1.48), (1.85, 2.62), stroke: 1.4pt + green, mark: (end: ">"))
  line((2.5, 1.48), (2.5, 0.25), stroke: 1.4pt + red, mark: (end: ">"))
  axis-label((3.6, 2.15), [$vec(T)$], placement: "west")
  axis-label((1.72, 2.65), [$vec(N)$], placement: "east")
  axis-label((2.68, 0.3), [$m vec(g)$], placement: "west")
  axis-label((1.05, 0.62), [$theta$], placement: "south")
  // diagramma delle forze prima del taglio, al centro
  circle((7.15, 1.5), radius: 0.08, fill: ink, stroke: none)
  line((7.15, 1.5), (6.4, 2.75), stroke: 1.5pt + green, mark: (end: ">"))
  line((7.15, 1.5), (7.15, 0.2), stroke: 1.5pt + red, mark: (end: ">"))
  line((7.15, 1.5), (8.35, 2.18), stroke: 1.5pt + blue, mark: (end: ">"))
  axis-label((6.3, 2.82), [$vec(N)$], placement: "east")
  axis-label((7.35, 0.3), [$m vec(g)$], placement: "west")
  axis-label((8.42, 2.2), [$vec(T)$], placement: "west")
  // diagramma dopo il taglio della fune, a destra
  circle((10.25, 1.5), radius: 0.08, fill: ink, stroke: none)
  line((10.25, 1.5), (9.5, 2.75), stroke: 1.5pt + green, mark: (end: ">"))
  line((10.25, 1.5), (10.25, 0.2), stroke: 1.5pt + red, mark: (end: ">"))
  line((10.25, 1.5), (9.15, 0.87), stroke: (paint: gold, thickness: 1.2pt, dash: "dashed"), mark: (end: ">"))
  axis-label((9.4, 2.82), [$vec(N)$], placement: "east")
  axis-label((10.45, 0.3), [$m vec(g)$], placement: "west")
  axis-label((9.05, 0.78), [$m g sin theta$], placement: "east")
  axis-label((7.15, -0.05), [prima], placement: "north")
  axis-label((10.25, -0.05), [dopo], placement: "north")
})))

Con la fune e in equilibrio statico:

$ cases(
  m g sin theta-T=0,
  N-m g cos theta=0,
) $

#yellow-box([Il sistema con la fune, riga per riga])[
  Il blocco è fermo, quindi $a_x=0$ e $a_y=0$: tutte le forze si bilanciano su entrambi gli assi.

  *Lungo $x$ (giù per il piano positivo):* la componente del peso $m g sin theta$ tira verso valle ($+$), la tensione $T$ tira verso monte trattenendo il blocco ($-$). Equilibrio: $m g sin theta-T=0$.

  *Lungo $y$ (perpendicolare al piano, verso l'esterno positivo):* la normale $N$ spinge fuori ($+$), la componente del peso $m g cos theta$ schiaccia sul piano ($-$). Equilibrio: $N-m g cos theta=0$.
]

da cui

$ cases(
  T=m g sin theta,
  N=m g cos theta,
) $

#yellow-box([Cosa ci dicono questi risultati])[
  La fune deve fare una tensione $T=m g sin theta$, cioè *solo* quanto serve a contrastare la parte del peso che spinge giù per il piano (non tutto il peso!). La normale $N=m g cos theta$ regge invece la parte che schiaccia. Più il piano è ripido (grande $theta$), più $T$ aumenta (sin cresce) e più $N$ diminuisce (cos cala): coerente con l'intuizione che su un pendio molto ripido la fune fatica di più e il corpo "preme" meno sulla superficie.
]

Se si taglia la fune, lungo il piano rimane soltanto la componente del peso:

$ cases(
  m g sin theta=m a_x,
  N-m g cos theta=0,
) quad arrow quad
cases(
  a_x=g sin theta,
  N=m g cos theta,
) $

#yellow-box([Cosa cambia tagliando la fune])[
  Sparisce $T$. Lungo $y$ non cambia nulla (il blocco resta a contatto, $N=m g cos theta$ invariata). Ma lungo $x$ ora non c'è più niente a trattenere: resta solo $m g sin theta$, che non è più bilanciata. Quindi il blocco *accelera* verso valle: $m g sin theta=m a_x$. La massa $m$ si semplifica a destra e a sinistra:
  $ a_x=g sin theta. $
  Notevole: l'accelerazione *non dipende dalla massa* (come per la caduta libera), ma solo dall'inclinazione. Casi limite: per $theta=0$ (piano piatto) $a_x=g sin 0=0$ (il blocco non parte); per $theta=90 degree$ (parete verticale) $a_x=g sin 90 degree=g$ (caduta libera). Entrambi tornano.
]

Il moto lungo $x$ è uniformemente accelerato:

$ cases(
  x(t)=x_0+v_0t+1/2 g (sin theta) t^2,
  v(t)=v_0+g (sin theta) t,
) $

#yellow-box([Da $a_x$ alle leggi orarie])[
  Poiché $a_x=g sin theta$ è costante, vale di nuovo la cinematica del moto uniformemente accelerato: si sostituisce $a_x=g sin theta$ nelle formule $x(t)=x_0+v_0 t+1/2 a_x t^2$ e $v(t)=v_0+a_x t$. La dinamica ci ha dato l'accelerazione, la cinematica completa il quadro con posizione e velocità.
]

#purple-box([Esempio numerico])[
  Un blocco di $m=2 " kg"$ è su un piano liscio inclinato di $theta=30 degree$, trattenuto da una fune.
  - Con la fune: $T=m g sin theta=2 dot 9,81 dot 0,5=9,81 " N"$ e $N=m g cos theta=2 dot 9,81 dot 0,866 approx 17,0 " N"$.
  - Tagliata la fune: $a_x=g sin theta=9,81 dot 0,5=4,905 " m/s"^2$. Partendo da fermo ($v_0=0$, $x_0=0$), dopo $t=2 " s"$ il blocco ha percorso $x=1/2 dot 4,905 dot 2^2=9,81 " m"$ e viaggia a $v=4,905 dot 2=9,81 " m/s"$.
]

= Forza di attrito

#green-box([L'idea prima della formula])[
  Immagina di spingere un armadio pesante sul pavimento. All'inizio spingi piano e l'armadio non si muove: c'è "qualcosa" che si oppone esattamente alla tua spinta. Quel qualcosa è l'*attrito*. Se spingi più forte, l'armadio continua a non muoversi: l'attrito è cresciuto insieme alla tua spinta per tenerlo fermo. A un certo punto, però, spingendo abbastanza, l'armadio "si stacca" di colpo e comincia a scivolare. Da quel momento l'attrito non cresce più: è diventato un valore fisso che cerca di frenare lo scorrimento.

  Il messaggio chiave: l'attrito non è sempre lo stesso. Finché il corpo è fermo si chiama *statico* e si adatta (entro un limite) a quello che serve per non farlo muovere; quando il corpo scivola si chiama *dinamico* e ha un valore preciso che frena il moto.
]

L'attrito radente è la forza tangenziale che nasce al contatto tra due superfici e si oppone al moto relativo, oppure alla tendenza al moto relativo. La sua direzione è parallela alla superficie di contatto.

#yellow-box([Cosa significano i simboli])[
  - $N$ è il modulo della *forza normale*, cioè la forza con cui la superficie spinge il corpo perpendicolarmente al contatto. Si misura in newton ($"N"$). Più il corpo "preme" sul piano, più $N$ è grande, e più attrito può svilupparsi.
  - $mu_s$ (mu statico) e $mu_d$ (mu dinamico) sono i *coefficienti di attrito*. Sono numeri puri (senza unità di misura) che dipendono solo dai due materiali a contatto: legno su legno, gomma su asfalto, ghiaccio su acciaio... Più sono grandi, più le superfici "fanno presa".
]

#blue-box([Attrito statico e dinamico])[
  - *Attrito statico*: il corpo resta fermo rispetto alla superficie, quindi $v=0$. Il modulo si adatta al valore necessario per mantenere l'equilibrio, fino a un massimo:
    $ F_"attr,s" <= mu_s N. $
  - *Attrito dinamico*: il corpo scivola, quindi $v != 0$. Il modulo è
    $ F_"attr,d" = mu_d N, $
    e il verso è opposto alla velocità relativa.

  In genere $mu_s > mu_d$: serve più forza per mettere in moto un corpo che per mantenerlo in scorrimento.
]

#yellow-box([Perché c'è $<=$ nello statico e $=$ nel dinamico])[
  Nello statico compare il segno di *minore o uguale* perché l'attrito statico non ha un valore fisso: vale esattamente quanto serve per tenere fermo il corpo. Se spingo con $3 " N"$ e il corpo non si muove, l'attrito statico vale $3 " N"$; se spingo con $5 " N"$ e ancora non si muove, vale $5 " N"$. Cresce con me, ma non all'infinito: può arrivare al massimo fino a $mu_s N$. Superato quel limite, il corpo parte.

  Nel dinamico, invece, c'è il segno di *uguale*: una volta che il corpo scivola, l'attrito ha un valore ben preciso, $mu_d N$, e non si adatta più.
]

#green-box([Perché $mu_s > mu_d$])[
  Pensa di nuovo all'armadio fermo: le due superfici hanno avuto tempo di "incastrarsi" microscopicamente, le piccole asperità si annidano una nell'altra e creano molti micro-agganci. Per spezzare tutti questi agganci in un colpo solo serve una spinta grande. Una volta che l'armadio scorre, però, le superfici scivolano via veloci e non fanno in tempo a riagganciarsi bene: gli agganci sono meno saldi, quindi serve meno forza per mantenerlo in movimento. Ecco perché il coefficiente statico è (quasi sempre) più grande di quello dinamico, e perché senti che il primo strappo per muovere un mobile è il più faticoso.
]

#align(center, graph-card([Attrito radente su superficie orizzontale], cetz.canvas({
  import cetz.draw: *
  // caso statico
  line((0.45, 2.45), (4.55, 2.45), stroke: 1.2pt + ink)
  for x in range(0, 9) { line((0.5 + x*0.45, 2.45), (0.7 + x*0.45, 2.25), stroke: 0.55pt + ink) }
  rect((1.55, 2.45), (2.35, 3.15), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  circle((1.95, 2.8), radius: 0.06, fill: ink, stroke: none)
  line((1.95, 2.8), (3.35, 2.8), stroke: 1.4pt + blue, mark: (end: ">"))
  line((1.95, 2.8), (0.8, 2.8), stroke: 1.4pt + red, mark: (end: ">"))
  line((1.95, 2.8), (1.95, 3.85), stroke: 1.3pt + green, mark: (end: ">"))
  line((1.95, 2.8), (1.95, 1.75), stroke: 1.3pt + red, mark: (end: ">"))
  axis-label((3.42, 2.85), [$vec(F)$], placement: "west")
  axis-label((0.72, 2.85), [$vec(F)_"attr"$], placement: "east")
  axis-label((2.15, 3.78), [$vec(N)$], placement: "west")
  axis-label((2.15, 1.85), [$m vec(g)$], placement: "west")
  // caso dinamico
  line((5.15, 2.45), (9.25, 2.45), stroke: 1.2pt + ink)
  for x in range(0, 9) { line((5.2 + x*0.45, 2.45), (5.4 + x*0.45, 2.25), stroke: 0.55pt + ink) }
  rect((6.25, 2.45), (7.05, 3.15), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  circle((6.65, 2.8), radius: 0.06, fill: ink, stroke: none)
  line((6.65, 2.8), (8.05, 2.8), stroke: 1.4pt + blue, mark: (end: ">"))
  line((6.65, 3.18), (7.65, 3.18), stroke: 1.1pt + ink, mark: (end: ">"))
  line((6.65, 2.8), (5.5, 2.8), stroke: 1.4pt + red, mark: (end: ">"))
  line((6.65, 2.8), (6.65, 3.85), stroke: 1.3pt + green, mark: (end: ">"))
  line((6.65, 2.8), (6.65, 1.75), stroke: 1.3pt + red, mark: (end: ">"))
  axis-label((8.12, 2.85), [$vec(F)$], placement: "west")
  axis-label((7.72, 3.24), [$vec(v)$], placement: "west")
  axis-label((5.42, 2.85), [$vec(F)_"attr,d"$], placement: "east")
  axis-label((6.85, 3.78), [$vec(N)$], placement: "west")
  axis-label((6.85, 1.85), [$m vec(g)$], placement: "west")
})))

Nel caso orizzontale scegliamo $x$ parallelo al piano verso destra e $y$ verticale verso l'alto. La forza applicata $vec(F)$ e l'attrito sono lungo $x$; peso e normale sono lungo $y$.

#gray-box([Il metodo, in tre mosse])[
  Per ogni problema di dinamica con attrito conviene procedere sempre allo stesso modo: (1) scelgo gli assi $x$ e $y$; (2) scrivo la seconda legge di Newton lungo $y$, che di solito mi dà la normale $N$; (3) scrivo la seconda legge lungo $x$, dove compare l'attrito (che dipende da $N$). L'asse perpendicolare serve a calcolare $N$, l'asse parallelo a studiare il moto vero e proprio.
]

Lungo $y$ il corpo non accelera (non sprofonda nel pavimento né si solleva), quindi la somma delle forze verticali è zero. Le forze verticali sono la normale $N$ (verso l'alto) e il peso $m g$ (verso il basso):

$ N-m g=0 quad arrow quad N=m g. $

Lungo $x$, se il blocco è in quiete, l'attrito statico compensa la forza applicata. Le condizioni sono

$ cases(
  N-m g=0,
  F_"attr,s"=F,
  F_"attr,s" <= mu_s N,
) quad arrow quad F <= mu_s m g. $

#yellow-box([Da dove esce $F <= mu_s m g$])[
  La seconda riga dice che, finché il corpo è fermo, l'attrito statico vale esattamente quanto la forza applicata: $F_"attr,s"=F$. La terza riga dice che l'attrito statico non può superare $mu_s N$. Mettendo insieme le due cose: $F = F_"attr,s" <= mu_s N$. Infine sostituisco $N=m g$ trovato dalla prima riga e ottengo $F <= mu_s m g$. Questa è la condizione perché il corpo resti fermo: se la mia spinta $F$ supera $mu_s m g$, il corpo parte.
]

Se il corpo scivola verso destra, l'attrito dinamico è verso sinistra. L'equazione lungo $x$ diventa

$ cases(
  N-m g=0,
  F-mu_d N=m a,
) quad arrow quad a=(F-mu_d m g)/m. $

#yellow-box([Da dove esce l'accelerazione])[
  Adesso il corpo si muove, quindi a destra dell'uguale c'è $m a$ (massa per accelerazione) e non zero. Le forze lungo $x$ sono la spinta $F$ (verso destra, positiva) e l'attrito dinamico $mu_d N$ (verso sinistra, negativo): la loro somma è $F - mu_d N$. Sostituisco $N = m g$, ottengo $F - mu_d m g = m a$, e isolo $a$ dividendo tutto per $m$.
]

#purple-box([Esempio numerico])[
  Spingo orizzontalmente una cassa di $m = 20 " kg"$ con una forza $F = 80 " N"$. I coefficienti sono $mu_s = 0,5$ e $mu_d = 0,3$. Uso $g = 9,8 " m/s"^2$.

  Prima domanda: la cassa parte? La spinta massima che l'attrito statico può reggere è
  $ mu_s m g = 0,5 dot 20 dot 9,8 = 98 " N". $
  Siccome $F = 80 " N" < 98 " N"$, la mia spinta non basta: la cassa resta ferma e l'attrito statico vale $80 " N"$ (proprio quanto la spinta).

  Se invece spingo con $F = 120 " N" > 98 " N"$, la cassa parte. Ora agisce l'attrito dinamico e l'accelerazione è
  $ a = (F - mu_d m g)/m = (120 - 0,3 dot 20 dot 9,8)/20 = (120 - 58,8)/20 = 3,06 " m/s"^2. $
]

== Forza inclinata e attrito

#green-box([L'idea prima della formula])[
  Immagina di tirare una valigia con il trolley: non spingi orizzontale, ma con la maniglia inclinata verso l'alto. Una parte della tua forza serve davvero a far avanzare la valigia (la parte orizzontale), ma un'altra parte la tira un po' su, come se la sollevasse. Questo "sollevamento parziale" fa premere meno la valigia sul pavimento, quindi diminuisce l'attrito. Ecco il punto sottile: tirare in obliquo ti fa sprecare una parte di forza, ma in cambio riduce l'attrito da vincere. Per questo a volte conviene tirare inclinato invece che orizzontale.
]

Se la forza applicata forma un angolo $theta$ sopra l'orizzontale, prima si scompone $vec(F)$ lungo gli assi scelti:

$ F_x=F cos theta, quad F_y=F sin theta. $

#yellow-box([Perché coseno per l'orizzontale e seno per il verticale])[
  Quando un vettore di modulo $F$ forma un angolo $theta$ con l'orizzontale, la sua "ombra" sull'asse orizzontale è $F cos theta$ e quella sull'asse verticale è $F sin theta$. La regola pratica: la componente *vicina* all'angolo (quella che si "appoggia" sul lato da cui misuri l'angolo) prende il coseno, quella *lontana* prende il seno. Controllo coi casi limite: se $theta = 0$ (forza orizzontale) allora $cos 0 = 1$ e $sin 0 = 0$, quindi $F_x = F$ e $F_y = 0$, tutta la forza è orizzontale, giusto. Se $theta = 90 degree$ (forza verticale) allora $F_x = 0$ e $F_y = F$, tutta verticale, giusto.
]

La componente $F_y$ è verso l'alto, quindi alleggerisce il contatto e riduce la normale; di conseguenza riduce anche l'attrito massimo.

#align(center, graph-card([Forza inclinata con attrito], cetz.canvas({
  import cetz.draw: *
  line((0.55, 0.65), (7.15, 0.65), stroke: 1.3pt + ink)
  for x in range(0, 14) { line((0.6 + x*0.46, 0.65), (0.82 + x*0.46, 0.43), stroke: 0.55pt + ink) }
  rect((2.35, 0.65), (3.45, 1.55), fill: rgb("#edf3f8"), stroke: 1pt + ink)
  circle((2.9, 1.1), radius: 0.07, fill: ink, stroke: none)
  line((2.9, 1.1), (4.45, 2.15), stroke: 1.5pt + blue, mark: (end: ">"))
  line((2.9, 1.1), (1.65, 1.1), stroke: 1.5pt + red, mark: (end: ">"))
  line((2.9, 1.1), (2.9, 2.45), stroke: 1.45pt + green, mark: (end: ">"))
  line((2.9, 1.1), (2.9, -0.1), stroke: 1.45pt + red, mark: (end: ">"))
  line((2.9, 1.1), (4.05, 1.1), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  line((4.05, 1.1), (4.05, 1.88), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  line((2.9, 1.1), (4.05, 1.1), stroke: (paint: blue, thickness: 1.05pt, dash: "dashed"), mark: (end: ">"))
  line((4.05, 1.1), (4.05, 1.88), stroke: (paint: blue, thickness: 1.05pt, dash: "dashed"), mark: (end: ">"))
  arc((3.55, 1.1), start: 0deg, stop: 34deg, radius: 0.62, stroke: 0.9pt + gold)
  axis-label((4.52, 2.2), [$vec(F)$], placement: "west")
  axis-label((1.58, 1.15), [$vec(F)_"attr"$], placement: "east")
  axis-label((3.1, 2.38), [$vec(N)$], placement: "west")
  axis-label((3.1, 0.0), [$m vec(g)$], placement: "west")
  axis-label((3.58, 1.34), [$theta$], placement: "south")
  // corpo libero
  circle((6.1, 1.15), radius: 0.08, fill: ink, stroke: none)
  line((6.1, 1.15), (7.25, 1.92), stroke: 1.45pt + blue, mark: (end: ">"))
  line((6.1, 1.15), (7.02, 1.15), stroke: (paint: blue, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((7.02, 1.15), (7.02, 1.77), stroke: (paint: blue, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((6.1, 1.15), (5.12, 1.15), stroke: 1.45pt + red, mark: (end: ">"))
  line((6.1, 1.15), (6.1, 2.35), stroke: 1.4pt + green, mark: (end: ">"))
  line((6.1, 1.15), (6.1, 0.0), stroke: 1.4pt + red, mark: (end: ">"))
  axis-label((7.3, 1.96), [$vec(F)$], placement: "west")
  axis-label((6.56, 0.88), [$F_x$], placement: "north")
  axis-label((7.18, 1.62), [$F_y$], placement: "west")
  axis-label((5.05, 1.2), [$vec(F)_"attr"$], placement: "east")
})))

Con $x$ orizzontale verso destra e $y$ verticale verso l'alto, lungo $y$ non c'è accelerazione:

$ N+F sin theta-m g=0 quad arrow quad N=m g-F sin theta, $

#yellow-box([Perché la normale è più piccola del peso])[
  Stavolta lungo $y$ ci sono *tre* forze: la normale $N$ verso l'alto, la componente verticale della spinta $F sin theta$ verso l'alto, e il peso $m g$ verso il basso. La somma deve fare zero perché il corpo non si stacca dal piano: $N + F sin theta - m g = 0$. Isolando $N$ ottengo $N = m g - F sin theta$. Nota il segno *meno*: la spinta verso l'alto "aiuta" a sostenere il corpo, così il piano deve spingere di meno. Per questo $N$ è più piccola del semplice peso $m g$, ed è proprio quello che intuivamo con la valigia.
]

Lungo $x$, in quiete l'attrito statico deve equilibrare la componente orizzontale della forza:

$ F cos theta <= mu_s (m g-F sin theta). $

#yellow-box([Come si arriva a questa disuguaglianza])[
  Per stare ferma, la componente orizzontale della spinta, $F cos theta$, deve essere bilanciata dall'attrito statico. Ma l'attrito statico ha un tetto massimo $mu_s N$. Quindi serve $F cos theta <= mu_s N$. Sostituisco la $N$ appena trovata, $N = m g - F sin theta$, e ottengo la formula. Da notare: la $N$ ridotta rende anche più piccolo il tetto dell'attrito.
]

Se il corpo è in moto verso destra, l'attrito è dinamico e ha verso opposto al moto:

$ F cos theta-mu_d (m g-F sin theta)=m a_x, $

cioè

$ a_x=(F cos theta-mu_d (m g-F sin theta))/m. $

#purple-box([Esempio numerico])[
  Tiro una cassa di $m = 10 " kg"$ con $F = 60 " N"$ inclinata di $theta = 30 degree$ sopra l'orizzontale, con $mu_d = 0,25$ e $g = 9,8 " m/s"^2$. Ricordo che $cos 30 degree approx 0,87$ e $sin 30 degree = 0,5$.

  Prima la normale:
  $ N = m g - F sin theta = 10 dot 9,8 - 60 dot 0,5 = 98 - 30 = 68 " N". $
  La spinta verticale ha "tolto" $30 " N"$ al contatto. Ora l'accelerazione:
  $ a_x = (F cos theta - mu_d N)/m = (60 dot 0,87 - 0,25 dot 68)/10 = (52,2 - 17)/10 = 3,52 " m/s"^2. $
]

== Esempio: piano inclinato scabro

#green-box([L'idea prima della formula])[
  "Scabro" vuol dire semplicemente *con attrito* (il contrario di "liscio"). Pensa a un libro appoggiato su uno scivolo: se lo scivolo è poco inclinato, il libro resta lì fermo, perché l'attrito ce la fa a trattenerlo. Se inclini sempre di più lo scivolo, a un certo punto il libro comincia a scendere: la componente del peso che lo tira giù è diventata troppo grande perché l'attrito la regga. Tutta questa sezione serve a capire *qual è* l'angolo critico oltre il quale il corpo parte, e *quanto* accelera quando scende.

  Il trucco fondamentale: su un piano inclinato conviene ruotare gli assi e metterli paralleli e perpendicolari al piano, non orizzontale/verticale. Così l'accelerazione (che è lungo il piano) cade tutta su un solo asse, e i conti si semplificano. Il prezzo da pagare è che ora è il *peso* a dover essere scomposto.
]

Consideriamo un blocco su un piano inclinato scabro di angolo $theta$. Scegliamo $x$ parallelo al piano verso valle e $y$ perpendicolare al piano verso l'esterno. Il peso si scompone in:

$ m g sin theta quad "lungo " x " verso valle", $
$ m g cos theta quad "lungo " y " verso il piano". $

#yellow-box([Perché il peso si scompone così])[
  Il peso $m vec(g)$ punta sempre verso il basso (verso il centro della Terra), ma i nostri assi sono ruotati di $theta$. Si dimostra con la geometria che l'angolo fra il peso e l'asse $y$ (perpendicolare al piano) è proprio $theta$. Quindi: la componente *lungo il piano* (che fa scivolare giù il blocco) è $m g sin theta$, e quella *che schiaccia* il blocco contro il piano è $m g cos theta$. Controllo coi casi limite: se $theta = 0$ (piano orizzontale) allora $sin 0 = 0$, niente tira giù il blocco, e $cos 0 = 1$, tutto il peso schiaccia: corretto. Se $theta = 90 degree$ (parete verticale) allora $sin 90 degree = 1$, tutto il peso tira giù, e $cos 90 degree = 0$, nessuna pressione sul piano: corretto.
]

L'attrito è parallelo al piano e si oppone alla tendenza al moto. Se il blocco tende a scendere, l'attrito è verso monte.

#align(center, graph-card([Piano inclinato scabro: componenti e attrito], cetz.canvas({
  import cetz.draw: *
  line((0.55, 0.45), (5.25, 3.0), stroke: 1.45pt + ink)
  line((0.55, 0.45), (5.25, 0.45), stroke: 0.9pt + grid-color)
  for s in range(0, 9) {
    line((0.75 + s*0.45, 0.56 + s*0.245), (0.98 + s*0.45, 0.38 + s*0.245), stroke: 0.5pt + ink)
  }
  rect((2.35, 1.35), (3.05, 1.95), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  circle((2.7, 1.65), radius: 0.07, fill: ink, stroke: none)
  line((2.7, 1.65), (3.75, 2.22), stroke: 1.35pt + red, mark: (end: ">"))
  line((2.7, 1.65), (2.05, 2.75), stroke: 1.35pt + green, mark: (end: ">"))
  line((2.7, 1.65), (2.7, 0.4), stroke: 1.35pt + red, mark: (end: ">"))
  line((2.7, 1.65), (1.62, 1.06), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((2.7, 1.65), (3.32, 0.55), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((1.75, 1.68), (1.05, 1.3), stroke: 0.8pt + ink, mark: (end: ">"))
  line((1.05, 1.3), (0.66, 1.98), stroke: 0.8pt + ink, mark: (end: ">"))
  arc((1.02, 0.45), start: 0deg, stop: 28deg, radius: 0.58, stroke: 0.9pt + gold)
  axis-label((1.05, 0.68), [$theta$], placement: "south")
  axis-label((1.78, 1.7), [$x$], placement: "west")
  axis-label((0.62, 2.0), [$y$], placement: "east")
  axis-label((3.82, 2.25), [$vec(F)_"attr"$], placement: "west")
  axis-label((1.95, 2.78), [$vec(N)$], placement: "east")
  axis-label((2.92, 0.5), [$m vec(g)$], placement: "west")
  axis-label((1.52, 1.02), [$m g sin theta$], placement: "east")
  axis-label((3.42, 0.58), [$m g cos theta$], placement: "west")
  // corpo libero
  circle((7.15, 1.55), radius: 0.08, fill: ink, stroke: none)
  line((8.05, 2.05), (7.15, 1.55), stroke: 0.8pt + ink, mark: (end: ">"))
  line((7.15, 1.55), (6.65, 2.38), stroke: 0.8pt + ink, mark: (end: ">"))
  line((7.15, 1.55), (8.18, 2.1), stroke: 1.35pt + red, mark: (end: ">"))
  line((7.15, 1.55), (6.48, 2.65), stroke: 1.35pt + green, mark: (end: ">"))
  line((7.15, 1.55), (7.15, 0.35), stroke: 1.35pt + red, mark: (end: ">"))
  line((7.15, 1.55), (6.12, 0.98), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((7.15, 1.55), (7.78, 0.5), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  axis-label((8.2, 2.12), [$vec(F)_"attr"$], placement: "west")
  axis-label((6.38, 2.68), [$vec(N)$], placement: "east")
  axis-label((7.35, 0.45), [$m vec(g)$], placement: "west")
  axis-label((6.0, 0.92), [$m g sin theta$], placement: "east")
  axis-label((7.9, 0.5), [$m g cos theta$], placement: "west")
})))

Lungo $y$ il blocco non si stacca dal piano:

$ N-m g cos theta=0 quad arrow quad N=m g cos theta. $

#yellow-box([Attenzione: qui la normale NON è $m g$])[
  Su un piano inclinato la normale vale $m g cos theta$, *non* $m g$. Il motivo: solo la parte del peso perpendicolare al piano, cioè $m g cos theta$, schiaccia il blocco contro la superficie, e la normale deve solo equilibrare quella. Siccome $cos theta < 1$ per $theta > 0$, la normale è più piccola del peso totale. Questo è un errore frequentissimo: ricordati sempre il $cos theta$.
]

Lungo $x$ bisogna distinguere quiete e moto.

Se il blocco resta fermo, l'attrito è statico e deve bilanciare la componente del peso lungo il piano:

$ m g sin theta-F_"attr,s"=0, quad F_"attr,s"=m g sin theta. $

Questo è possibile solo se

$ m g sin theta <= mu_s N=mu_s m g cos theta, $

cioè

$ tan theta <= mu_s. $

#yellow-box([Come spunta la tangente: il passaggio chiave])[
  Partiamo da $m g sin theta <= mu_s m g cos theta$. Tutti i termini hanno il fattore $m g$, che è positivo, quindi posso *dividerlo via* da entrambi i lati senza cambiare il verso della disuguaglianza:
  $ sin theta <= mu_s cos theta. $
  Adesso divido entrambi i lati per $cos theta$ (positivo per $0 < theta < 90 degree$):
  $ (sin theta)/(cos theta) <= mu_s. $
  Ma $(sin theta)/(cos theta)$ è per definizione la tangente, quindi $tan theta <= mu_s$.

  Questo risultato è notevolissimo: l'angolo critico oltre il quale il blocco parte *non dipende dalla massa*! Dipende solo dal coefficiente di attrito. Anzi, è proprio così che si misura $mu_s$ in laboratorio: si inclina il piano finché il corpo scivola, si legge l'angolo limite $theta_("max")$, e $mu_s = tan theta_("max")$.
]

Se invece il blocco scivola verso valle, l'attrito è dinamico:

$ F_"attr,d"=mu_d N=mu_d m g cos theta. $

L'equazione lungo $x$ diventa

$ m g sin theta-mu_d m g cos theta=m a, $

quindi

$ a=g(sin theta-mu_d cos theta). $

#yellow-box([Da dove esce l'accelerazione])[
  Lungo $x$ (verso valle) ci sono due forze: la componente del peso $m g sin theta$ che spinge giù (positiva) e l'attrito dinamico $mu_d m g cos theta$ che frena (negativo). La loro somma è $m a$:
  $ m g sin theta - mu_d m g cos theta = m a. $
  Raccolgo $m g$ a sinistra e poi divido tutto per $m$ (la massa si semplifica): $a = g(sin theta - mu_d cos theta)$. Anche qui la massa sparisce: due blocchi di materiale uguale ma peso diverso scendono con la stessa accelerazione.
]

#purple-box([Esempio numerico])[
  Un blocco è su un piano inclinato di $theta = 30 degree$, con $mu_s = 0,7$ e $mu_d = 0,4$. Prendo $g = 9,8 " m/s"^2$ e $sin 30 degree = 0,5$, $cos 30 degree approx 0,87$, $tan 30 degree approx 0,58$.

  Il blocco resta fermo? La condizione è $tan theta <= mu_s$, cioè $0,58 <= 0,7$: vero, quindi *resta fermo*.

  Adesso lo stesso blocco con $mu_s = 0,4$ (superficie più scivolosa): ora $tan 30 degree = 0,58 > 0,4$, quindi il blocco *parte* e scivola. Con $mu_d = 0,4$ l'accelerazione è
  $ a = g(sin theta - mu_d cos theta) = 9,8 dot (0,5 - 0,4 dot 0,87) = 9,8 dot (0,5 - 0,348) = 9,8 dot 0,152 approx 1,49 " m/s"^2. $
]

= Sistemi con più corpi

#green-box([L'idea prima della formula])[
  Finora abbiamo studiato un corpo solo. Ora ne colleghiamo due con una fune (per esempio una cassa sul tavolo legata a un secchio che pende dal bordo). La domanda è: come si muovono insieme? La fune fa da "messaggero": tira un corpo da una parte e l'altro dall'altra, con la stessa intensità.

  Due idee guida che useremo sempre:
  - I due corpi sono *legati*, quindi quando uno avanza di un tratto, l'altro avanza dello stesso tratto. Si muovono in coppia: hanno lo stesso modulo di velocità e di accelerazione. Questo si chiama *vincolo*.
  - La fune ideale "trasmette" la forza senza perdite: la tensione $T$ è la stessa ai due capi.

  Il metodo per risolverli è sempre questo: isolo *ogni* corpo, gli disegno le forze, scrivo la seconda legge di Newton per ciascuno, e poi metto a sistema le equazioni sfruttando il fatto che $a$ e $T$ sono in comune.
]

Quando due corpi sono collegati da una fune ideale, la fune impone un vincolo cinematico: i moduli delle accelerazioni sono uguali. Per una fune ideale e una carrucola ideale anche il modulo della tensione è lo stesso in ogni tratto.

#yellow-box([Cos'è la tensione $T$])[
  La *tensione* è la forza con cui una fune tira ciò a cui è attaccata. È sempre diretta lungo la fune e "tira verso l'esterno" del corpo (la fune non può spingere, solo tirare). Si misura in newton. Quando isolo i due corpi, su ciascuno la tensione tira verso la fune.
]

#yellow-box([Fune ideale])[
  Fune ideale significa massa trascurabile, inestensibilità e assenza di attrito nelle carrucole. In queste ipotesi:
  $ |a_1|=|a_2|=a, quad T_1=T_2=T. $
  Massa trascurabile $arrow$ la fune non "ruba" forza per accelerare se stessa, quindi la tensione resta uguale ai due capi. Inestensibile $arrow$ non si allunga, quindi se un capo si sposta di tot, l'altro si sposta di altrettanto: stessa velocità e stessa accelerazione in modulo.
]

== Massa su piano liscio e massa sospesa

#align(center, graph-card([Due corpi collegati: piano liscio e massa sospesa], cetz.canvas({
  import cetz.draw: *
  line((0.5, 1.55), (4.25, 1.55), stroke: 1.3pt + ink)
  for x in range(0, 8) { line((0.6 + x*0.43, 1.55), (0.8 + x*0.43, 1.35), stroke: 0.55pt + ink) }
  rect((1.05, 1.55), (2.05, 2.35), fill: rgb("#edf3f8"), stroke: 1pt + ink)
  circle((4.25, 1.55), radius: 0.34, stroke: 1pt + ink)
  line((2.05, 1.95), (3.91, 1.95), stroke: 1.1pt + blue)
  line((4.59, 1.55), (4.59, 0.45), stroke: 1.1pt + blue)
  rect((4.22, -0.25), (4.96, 0.45), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((1.55, 1.95), (2.65, 1.95), stroke: 1.35pt + blue, mark: (end: ">"))
  line((1.55, 1.95), (1.55, 2.9), stroke: 1.25pt + green, mark: (end: ">"))
  line((1.55, 1.95), (1.55, 0.95), stroke: 1.25pt + red, mark: (end: ">"))
  line((4.59, 0.1), (4.59, 0.95), stroke: 1.35pt + blue, mark: (end: ">"))
  line((4.59, 0.1), (4.59, -0.9), stroke: 1.35pt + red, mark: (end: ">"))
  axis-label((1.55, 1.18), [$m_1$], placement: "south")
  axis-label((4.88, 0.1), [$m_2$], placement: "west")
  axis-label((2.7, 2.0), [$vec(T)$], placement: "west")
  axis-label((1.72, 2.82), [$vec(N)$], placement: "west")
  axis-label((1.72, 1.02), [$m_1 vec(g)$], placement: "west")
  axis-label((4.78, 0.85), [$vec(T)$], placement: "west")
  axis-label((4.78, -0.78), [$m_2 vec(g)$], placement: "west")
  axis-label((0.72, 0.95), [superficie liscia], placement: "north")
  // diagrammi isolati
  circle((6.45, 1.55), radius: 0.08, fill: ink, stroke: none)
  line((6.45, 1.55), (7.45, 1.55), stroke: 1.35pt + blue, mark: (end: ">"))
  line((6.45, 1.55), (6.45, 2.55), stroke: 1.25pt + green, mark: (end: ">"))
  line((6.45, 1.55), (6.45, 0.55), stroke: 1.25pt + red, mark: (end: ">"))
  circle((8.75, 1.55), radius: 0.08, fill: ink, stroke: none)
  line((8.75, 1.55), (8.75, 2.55), stroke: 1.35pt + blue, mark: (end: ">"))
  line((8.75, 1.55), (8.75, 0.45), stroke: 1.35pt + red, mark: (end: ">"))
  axis-label((7.5, 1.6), [$vec(T)$], placement: "west")
  axis-label((8.95, 2.48), [$vec(T)$], placement: "west")
  axis-label((8.95, 0.55), [$m_2 vec(g)$], placement: "west")
})))

Con $x$ verso destra per $m_1$ e verso il basso per $m_2$:

$ T=m_1 a, $
$ m_2 g-T=m_2 a. $

#yellow-box([Da dove escono queste due equazioni])[
  Isolo i due corpi e applico $F = m a$ a ciascuno.

  *Corpo $m_1$ (sul piano liscio)*: lungo l'orizzontale c'è solo la tensione $T$ che lo tira verso la carrucola. Il piano è liscio (niente attrito), peso e normale sono verticali e si annullano. Quindi $T = m_1 a$.

  *Corpo $m_2$ (appeso)*: su di esso agiscono il peso $m_2 g$ (verso il basso) e la tensione $T$ (verso l'alto). Siccome scende, scelgo positivo il verso basso, e la somma delle forze è $m_2 g - T$, uguale a $m_2 a$. Quindi $m_2 g - T = m_2 a$.

  Nota che ho usato la *stessa* $a$ e la *stessa* $T$ in entrambe le equazioni: è proprio il vincolo della fune che me lo permette.
]

Sommando le due equazioni,

$ a=(m_2 g)/(m_1+m_2), quad T=(m_1 m_2 g)/(m_1+m_2). $

#yellow-box([Perché sommare conviene, e i conti per esteso])[
  Ho due equazioni con due incognite ($a$ e $T$). Il trucco di *sommarle* è comodo perché la $T$ compare con segno $+$ in una e $-$ nell'altra, quindi sparisce:
  $ T + (m_2 g - T) = m_1 a + m_2 a quad arrow quad m_2 g = (m_1 + m_2) a. $
  Da qui isolo $a$ dividendo per $(m_1 + m_2)$. Poi ritorno alla prima equazione $T = m_1 a$ e sostituisco l'$a$ appena trovata, ottenendo $T = (m_1 m_2 g)/(m_1 + m_2)$.

  Controllo di sanità: il fattore $(m_1 + m_2)$ a denominatore ha senso, perché la stessa forza-motrice $m_2 g$ deve mettere in moto la *massa totale* $m_1 + m_2$ del sistema.
]

#purple-box([Esempio numerico])[
  Sul tavolo liscio $m_1 = 3 " kg"$, appeso $m_2 = 2 " kg"$, con $g = 9,8 " m/s"^2$. Allora
  $ a = (m_2 g)/(m_1 + m_2) = (2 dot 9,8)/(3 + 2) = 19,6/5 = 3,92 " m/s"^2, $
  $ T = (m_1 m_2 g)/(m_1 + m_2) = (3 dot 2 dot 9,8)/5 = 58,8/5 = 11,76 " N". $
  Nota che $T = 11,76 " N"$ è minore del peso di $m_2$ ($2 dot 9,8 = 19,6 " N"$): è giusto, perché se la tensione fosse uguale al peso, $m_2$ resterebbe in equilibrio e non accelererebbe verso il basso.
]

Il moto è uniformemente accelerato se le masse sono costanti e le forze esterne non cambiano.

== Macchina di Atwood

#green-box([L'idea prima della formula])[
  La macchina di Atwood sono due pesi appesi ai due capi di una stessa fune che passa su una carrucola, come una bilancia a carrucola. Se i due pesi fossero uguali, resterebbero fermi (equilibrio). Se uno è più pesante, quello scende e l'altro sale, ma piano: il peso che sale fa da "contrappeso" e rallenta tutto. È un modo ingegnoso per ottenere un'accelerazione piccola e misurabile, molto più piccola di $g$, da cui storicamente si studiava la caduta dei gravi "al rallentatore".
]

Due masse sospese alla stessa carrucola ideale accelerano in versi opposti. Se $m_1>m_2$, scegliamo positivo verso il basso per $m_1$ e verso l'alto per $m_2$.

#yellow-box([Perché scegliere versi positivi diversi per i due corpi])[
  Siccome $m_1$ scende mentre $m_2$ sale, conviene scegliere "positivo" il verso in cui ciascuno effettivamente si muove: verso il basso per $m_1$, verso l'alto per $m_2$. Così la stessa $a$ (positiva) descrive il moto di entrambi, ed evito segni meno fastidiosi. È solo una scelta furba di convenzione, non una nuova fisica.
]

#align(center, graph-card([Macchina di Atwood], cetz.canvas({
  import cetz.draw: *
  circle((2.55, 2.95), radius: 0.5, stroke: 1.1pt + ink)
  arc((2.05, 2.95), start: 180deg, stop: 0deg, radius: 0.5, stroke: 1.1pt + blue)
  line((2.05, 2.95), (2.05, 1.25), stroke: 1.1pt + blue)
  line((3.05, 2.95), (3.05, 1.55), stroke: 1.1pt + blue)
  rect((1.68, 0.55), (2.42, 1.25), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  rect((2.68, 0.85), (3.42, 1.55), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.05, 0.9), (2.05, 1.85), stroke: 1.4pt + blue, mark: (end: ">"))
  line((2.05, 0.9), (2.05, -0.15), stroke: 1.4pt + red, mark: (end: ">"))
  line((3.05, 1.2), (3.05, 2.15), stroke: 1.4pt + blue, mark: (end: ">"))
  line((3.05, 1.2), (3.05, 0.15), stroke: 1.4pt + red, mark: (end: ">"))
  axis-label((1.4, 0.9), [$m_1$], placement: "east")
  axis-label((3.7, 1.2), [$m_2$], placement: "west")
  axis-label((2.24, 1.78), [$vec(T)$], placement: "west")
  axis-label((2.24, -0.05), [$m_1 vec(g)$], placement: "west")
  axis-label((3.24, 2.08), [$vec(T)$], placement: "west")
  axis-label((3.24, 0.25), [$m_2 vec(g)$], placement: "west")
  // diagrammi isolati
  circle((5.65, 1.65), radius: 0.08, fill: ink, stroke: none)
  line((5.65, 1.65), (5.65, 2.75), stroke: 1.4pt + blue, mark: (end: ">"))
  line((5.65, 1.65), (5.65, 0.55), stroke: 1.4pt + red, mark: (end: ">"))
  circle((7.45, 1.65), radius: 0.08, fill: ink, stroke: none)
  line((7.45, 1.65), (7.45, 2.75), stroke: 1.4pt + blue, mark: (end: ">"))
  line((7.45, 1.65), (7.45, 0.55), stroke: 1.4pt + red, mark: (end: ">"))
  axis-label((5.85, 2.68), [$vec(T)$], placement: "west")
  axis-label((5.85, 0.65), [$m_1 vec(g)$], placement: "west")
  axis-label((7.65, 2.68), [$vec(T)$], placement: "west")
  axis-label((7.65, 0.65), [$m_2 vec(g)$], placement: "west")
})))

Le equazioni scalari sono

$ m_1 g-T=m_1 a, $
$ T-m_2 g=m_2 a. $

#yellow-box([Da dove escono queste due equazioni])[
  *Corpo $m_1$ (scende)*: forze peso $m_1 g$ (giù, verso positivo) e tensione $T$ (su). La somma nel verso positivo (il basso) è $m_1 g - T$, uguale a $m_1 a$.

  *Corpo $m_2$ (sale)*: forze tensione $T$ (su, verso positivo) e peso $m_2 g$ (giù). La somma nel verso positivo (l'alto) è $T - m_2 g$, uguale a $m_2 a$.
]

Da cui

$ a=((m_1-m_2) g)/(m_1+m_2), quad T=(2m_1 m_2 g)/(m_1+m_2). $

#yellow-box([I conti per esteso])[
  Sommo le due equazioni (la $T$ sparisce di nuovo):
  $ (m_1 g - T) + (T - m_2 g) = m_1 a + m_2 a quad arrow quad (m_1 - m_2) g = (m_1 + m_2) a, $
  da cui $a = ((m_1 - m_2) g)/(m_1 + m_2)$. Per la tensione, ricavo $T$ dalla prima equazione, $T = m_1 g - m_1 a = m_1(g - a)$, e sostituisco l'$a$ trovata; con un po' di algebra si arriva a $T = (2 m_1 m_2 g)/(m_1 + m_2)$.

  Controlli di sanità: se $m_1 = m_2$, allora $a = 0$ (sistema in equilibrio, come ci aspettavamo) e $T = m_1 g$ (la fune regge esattamente il peso). Se invece $m_2 = 0$, allora $a = g$: $m_1$ cade liberamente, giusto, perché non c'è più nessun contrappeso.
]

#purple-box([Esempio numerico])[
  Atwood con $m_1 = 5 " kg"$ e $m_2 = 3 " kg"$, $g = 9,8 " m/s"^2$:
  $ a = ((m_1 - m_2) g)/(m_1 + m_2) = ((5 - 3) dot 9,8)/(5 + 3) = (2 dot 9,8)/8 = 2,45 " m/s"^2, $
  $ T = (2 m_1 m_2 g)/(m_1 + m_2) = (2 dot 5 dot 3 dot 9,8)/8 = 294/8 = 36,75 " N". $
  Come previsto, $a = 2,45 " m/s"^2$ è ben più piccola di $g$: la macchina "rallenta" la caduta.
]

== Piano inclinato con massa sospesa

#green-box([L'idea prima della formula])[
  Questo è il "mix" dei casi precedenti: un blocco $m_1$ su uno scivolo (liscio) inclinato, collegato da una fune (sopra una carrucola in cima allo scivolo) a un peso $m_2$ che pende nel vuoto. Chi vince? Dipende dal confronto fra due "tiri": il peso $m_2 g$ che vuole far scendere $m_2$ (e quindi tirare su $m_1$ lungo il piano), contro la componente $m_1 g sin theta$ del peso di $m_1$ che vuole farlo scendere lungo lo scivolo. Vince il più forte, e quello determina il verso del moto.
]

Nel caso degli appunti, $m_1$ è su un piano liscio inclinato di $theta$ e $m_2$ è sospesa. Usiamo per $m_1$ assi locali con $x$ parallelo al piano verso valle e $y$ perpendicolare al piano verso l'esterno, come negli altri piani inclinati.

#align(center, graph-card([Piano inclinato e massa sospesa], cetz.canvas({
  import cetz.draw: *
  line((0.45, 0.4), (3.95, 2.65), stroke: 1.3pt + ink)
  line((3.95, 2.65), (3.95, 0.4), stroke: 1.1pt + ink)
  line((0.45, 0.4), (3.95, 0.4), stroke: 1.1pt + ink)
  circle((3.95, 2.65), radius: 0.28, fill: white, stroke: 1pt + ink)
  rect((1.85, 1.18), (2.55, 1.78), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.2, 1.48), (3.72, 2.46), stroke: 1.1pt + blue)
  line((4.23, 2.65), (4.23, 1.28), stroke: 1.1pt + blue)
  rect((3.9, 0.62), (4.56, 1.28), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.2, 1.48), (3.25, 2.15), stroke: 1.35pt + blue, mark: (end: ">"))
  line((2.2, 1.48), (1.55, 2.55), stroke: 1.35pt + green, mark: (end: ">"))
  line((2.2, 1.48), (2.2, 0.25), stroke: 1.35pt + red, mark: (end: ">"))
  line((4.23, 0.95), (4.23, 1.85), stroke: 1.35pt + blue, mark: (end: ">"))
  line((4.23, 0.95), (4.23, -0.05), stroke: 1.35pt + red, mark: (end: ">"))
  arc((0.85, 0.4), start: 0deg, stop: 33deg, radius: 0.55, stroke: 0.9pt + gold)
  axis-label((0.9, 0.62), [$theta$], placement: "south")
  axis-label((3.3, 2.2), [$vec(T)$], placement: "west")
  axis-label((1.42, 2.6), [$vec(N)$], placement: "east")
  axis-label((2.38, 0.35), [$m_1 vec(g)$], placement: "west")
  axis-label((4.42, 1.78), [$vec(T)$], placement: "west")
  axis-label((4.42, 0.05), [$m_2 vec(g)$], placement: "west")
  // diagrammi isolati
  circle((6.25, 1.55), radius: 0.08, fill: ink, stroke: none)
  line((7.05, 2.05), (6.25, 1.55), stroke: 0.8pt + ink, mark: (end: ">"))
  line((6.25, 1.55), (5.75, 2.35), stroke: 0.8pt + ink, mark: (end: ">"))
  line((6.25, 1.55), (7.25, 2.2), stroke: 1.35pt + blue, mark: (end: ">"))
  line((6.25, 1.55), (5.6, 2.65), stroke: 1.35pt + green, mark: (end: ">"))
  line((6.25, 1.55), (6.25, 0.35), stroke: 1.35pt + red, mark: (end: ">"))
  line((6.25, 1.55), (5.35, 0.98), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((6.25, 1.55), (6.88, 0.52), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  axis-label((7.1, 2.08), [$x$], placement: "west")
  axis-label((5.68, 2.38), [$y$], placement: "east")
  axis-label((5.85, 0.86), [$m_1 g sin theta$], placement: "north")
  axis-label((7.05, 0.62), [$m_1 g cos theta$], placement: "west")
  circle((8.6, 1.55), radius: 0.08, fill: ink, stroke: none)
  line((8.6, 1.55), (8.6, 2.65), stroke: 1.35pt + blue, mark: (end: ">"))
  line((8.6, 1.55), (8.6, 0.35), stroke: 1.35pt + red, mark: (end: ">"))
})))

Per $m_1$ il peso si scompone in:

$ m_1 g sin theta quad "lungo il piano verso valle", $
$ m_1 g cos theta quad "perpendicolare al piano verso l'interno". $

Lungo $y$ non c'è accelerazione, quindi $N=m_1 g cos theta$. Se $m_2$ scende, $m_1$ sale lungo il piano: il verso dell'accelerazione di $m_1$ è quindi opposto all'asse $x$ scelto. Indicando con $a>0$ il modulo dell'accelerazione,

$ cases(
  m_1 g sin theta-T=-m_1 a,
  m_2 g-T=m_2 a,
) $

#yellow-box([Perché compare $-m_1 a$: attenzione al segno])[
  Qui c'è il passaggio più delicato di tutta la sezione. Per $m_1$ avevamo scelto l'asse $x$ *verso valle* (verso il basso del piano). Ma se $m_2$ scende, $m_1$ è trascinato a *salire* lungo il piano, cioè si muove nel verso *opposto* a $x$. Quindi la sua accelerazione, letta sull'asse $x$, è negativa: $-a$ (con $a > 0$ modulo). Ecco perché a destra dell'uguale scrivo $-m_1 a$ e non $+m_1 a$.

  La prima riga è la seconda legge per $m_1$ lungo $x$: le forze lungo il piano sono $m_1 g sin theta$ (verso valle, $+$) e la tensione $T$ (verso monte, perché la fune tira $m_1$ verso la carrucola in alto, $-$). Somma $= m_1 g sin theta - T$, uguale a $-m_1 a$. La seconda riga è la solita equazione per $m_2$ che scende: $m_2 g - T = m_2 a$.
]

Quindi

$ a=(m_2 g-m_1 g sin theta)/(m_1+m_2), $
$ T=m_1 g sin theta+m_1 a. $

#yellow-box([I conti per esteso])[
  Riscrivo la prima equazione spostando il segno: $m_1 g sin theta - T = -m_1 a$ diventa $T - m_1 g sin theta = m_1 a$. Sommo a questa la seconda, $m_2 g - T = m_2 a$:
  $ (T - m_1 g sin theta) + (m_2 g - T) = m_1 a + m_2 a, $
  la $T$ si elide e resta $m_2 g - m_1 g sin theta = (m_1 + m_2) a$, da cui $a = (m_2 g - m_1 g sin theta)/(m_1 + m_2)$. La tensione si ricava poi da $T = m_1 g sin theta + m_1 a$.

  Controllo del segno: se $m_2 g > m_1 g sin theta$ il "tiro" di $m_2$ vince, $a > 0$ e $m_1$ sale, come avevamo supposto. Se invece $m_2 g < m_1 g sin theta$, viene $a < 0$: significa che in realtà è $m_1$ a scendere e $m_2$ a salire, il moto è all'opposto di come l'avevamo immaginato.
]

#purple-box([Esempio numerico])[
  $m_1 = 4 " kg"$ sul piano liscio inclinato di $theta = 30 degree$, $m_2 = 3 " kg"$ appesa, $g = 9,8 " m/s"^2$, $sin 30 degree = 0,5$.
  $ a = (m_2 g - m_1 g sin theta)/(m_1 + m_2) = (3 dot 9,8 - 4 dot 9,8 dot 0,5)/(4 + 3) = (29,4 - 19,6)/7 = 9,8/7 = 1,4 " m/s"^2. $
  Siccome $a > 0$, $m_2$ scende e $m_1$ sale lungo il piano. La tensione:
  $ T = m_1 g sin theta + m_1 a = 4 dot 9,8 dot 0,5 + 4 dot 1,4 = 19,6 + 5,6 = 25,2 " N". $
]

= Dinamica del moto circolare uniforme

#green-box([L'idea prima della formula])[
  Fai roteare un sasso legato a uno spago sopra la testa: il sasso gira con velocità costante, ma il suo verso cambia di continuo. Cambiare verso *è* un'accelerazione, anche se la "rapidità" non cambia! E un'accelerazione richiede una forza (seconda legge di Newton). Questa forza punta sempre verso il centro del cerchio (è lo spago che tira il sasso verso la mano) e si chiama *centripeta*, cioè "che cerca il centro". Se lasci lo spago, la forza sparisce e il sasso vola via in linea retta: prova della necessità di una forza per "curvare".
]

Nel moto circolare uniforme il modulo della velocità è costante, ma il vettore velocità cambia direzione. L'accelerazione è centripeta:

$ a_c=v^2/R. $

#yellow-box([Cosa dice questa formula])[
  $a_c$ è l'accelerazione centripeta (in $"m/s"^2$), $v$ il modulo della velocità (in $"m/s"$) e $R$ il raggio della circonferenza (in $"m"$). La formula dice che curvi più "bruscamente" (accelerazione grande) se vai veloce o se il cerchio è stretto. Il $v$ è al quadrato: raddoppiare la velocità *quadruplica* l'accelerazione centripeta, ecco perché le curve in auto vanno prese piano.
]

Per la seconda legge di Newton, la risultante delle forze lungo il raggio deve essere diretta verso il centro:

$ |vec(R)|=|sum vec(F)|=m a_c=(m v^2)/R. $

#align(center, graph-card([Risultante centripeta nel moto circolare uniforme], cetz.canvas({
  import cetz.draw: *
  circle((2.5, 2.05), radius: 1.45, stroke: 1.2pt + ink)
  circle((3.55, 1.05), radius: 0.09, fill: ink, stroke: none)
  line((3.55, 1.05), (2.5, 2.05), stroke: 1.6pt + red, mark: (end: ">"))
  line((3.55, 1.05), (4.55, 2.1), stroke: 1.5pt + green, mark: (end: ">"))
  axis-label((3.05, 1.75), [$vec(a)_c$], placement: "south")
  axis-label((4.62, 2.16), [$vec(v)$], placement: "west")
  axis-label((2.32, 2.22), [$O$])
  axis-label((3.22, 1.58), [$R$], placement: "north")
  circle((7.0, 1.6), radius: 0.08, fill: ink, stroke: none)
  line((7.0, 1.6), (5.95, 2.25), stroke: 1.6pt + red, mark: (end: ">"))
  line((7.0, 1.6), (8.05, 2.25), stroke: 1.4pt + green, mark: (end: ">"))
  axis-label((5.88, 2.3), [$sum vec(F)$], placement: "east")
  axis-label((8.12, 2.3), [$vec(v)$], placement: "west")
})))

#yellow-box([Attenzione])[
  La forza centripeta non è una nuova forza: è il nome della risultante radiale delle forze reali. Può essere fornita da tensione, attrito, normale, gravità o da una combinazione di queste.
]

== Pendolo conico

#green-box([L'idea prima della formula])[
  Il pendolo conico è una pallina appesa a un filo che, invece di oscillare avanti e indietro, gira in tondo: il filo spazza nello spazio un cono (da qui il nome), mentre la pallina percorre una circonferenza orizzontale. Le uniche due forze vere sono il peso (giù) e la tensione del filo (lungo il filo, in obliquo verso l'alto). Il trucco di tutto il problema: la tensione, essendo inclinata, fa *due lavori contemporaneamente*. La sua parte verticale regge il peso (impedisce alla pallina di cadere), e la sua parte orizzontale fa da forza centripeta (la costringe a girare). Una sola forza, due ruoli, perché è obliqua.
]

Nel pendolo conico una massa ruota con velocità costante su una circonferenza orizzontale. La tensione della fune ha una componente verticale che equilibra il peso e una componente orizzontale centripeta.

#align(center, graph-card([Pendolo conico], cetz.canvas({
  import cetz.draw: *
  line((0.9, 3.3), (4.3, 3.3), stroke: 1.2pt + ink)
  line((2.6, 3.3), (1.5, 1.35), stroke: 1.4pt + ink)
  line((2.6, 3.3), (2.6, 1.35), stroke: (paint: grid-color, thickness: 0.9pt, dash: "dashed"))
  line(
    (1.5, 1.35), (1.75, 1.58), (2.15, 1.72), (2.6, 1.75),
    (3.05, 1.72), (3.45, 1.58), (3.7, 1.35),
    (3.45, 1.12), (3.05, 0.98), (2.6, 0.95),
    (2.15, 0.98), (1.75, 1.12), (1.5, 1.35),
    stroke: 1pt + blue,
  )
  circle((1.5, 1.35), radius: 0.1, fill: ink, stroke: none)
  line((1.5, 1.35), (2.6, 1.35), stroke: 1.1pt + gold)
  line((1.5, 1.35), (1.05, 0.35), stroke: 1.3pt + green, mark: (end: ">"))
  arc((2.35, 2.85), start: 240deg, stop: 270deg, radius: 0.55, stroke: 0.9pt + gold)
  axis-label((1.0, 2.25), [$ell$], placement: "east")
  axis-label((2.34, 2.5), [$theta$], placement: "east")
  axis-label((2.05, 1.18), [$R$], placement: "north")
  axis-label((0.98, 0.42), [$vec(v)$], placement: "east")
  // diagramma delle forze
  circle((6.0, 1.55), radius: 0.08, fill: ink, stroke: none)
  line((6.0, 1.55), (6.85, 2.75), stroke: 1.5pt + blue, mark: (end: ">"))
  line((6.0, 1.55), (6.0, 0.25), stroke: 1.5pt + red, mark: (end: ">"))
  line((6.0, 1.55), (6.75, 1.55), stroke: (paint: blue, thickness: 1.05pt, dash: "dashed"), mark: (end: ">"))
  line((6.75, 1.55), (6.75, 2.6), stroke: (paint: blue, thickness: 1.05pt, dash: "dashed"), mark: (end: ">"))
  line((5.85, 1.55), (7.05, 1.55), stroke: 0.75pt + ink, mark: (end: ">"))
  line((6.0, 1.35), (6.0, 2.75), stroke: 0.75pt + ink, mark: (end: ">"))
  axis-label((6.9, 2.78), [$vec(T)$], placement: "west")
  axis-label((6.18, 0.35), [$m vec(g)$], placement: "west")
  axis-label((6.72, 1.35), [$T sin theta$], placement: "north")
  axis-label((6.92, 2.08), [$T cos theta$], placement: "west")
  axis-label((7.08, 1.55), [$x$], placement: "west")
  axis-label((6.0, 2.82), [$y$], placement: "south")
})))

La massa descrive una circonferenza orizzontale di raggio

$ R=ell sin theta, $

#yellow-box([Da dove esce $R = ell sin theta$])[
  Guarda il filo come l'ipotenusa di un triangolo rettangolo: parte dal punto di sospensione in alto e arriva alla pallina. Il raggio $R$ della circonferenza è il cateto *orizzontale* di questo triangolo. Siccome $theta$ è l'angolo che il filo forma con la verticale, il cateto orizzontale (opposto a $theta$) vale $ell sin theta$. Caso limite: se $theta = 0$ il filo è verticale, $R = 0$, la pallina non gira: corretto. Più apri l'angolo, più larga è la circonferenza.
]

dove $ell$ è la lunghezza della fune e $theta$ è l'angolo rispetto alla verticale. Le forze reali sulla massa sono soltanto la tensione $vec(T)$ e il peso $m vec(g)$.

Scegliamo due assi locali:
- $x$ orizzontale, radiale e diretto verso il centro della circonferenza;
- $y$ verticale verso l'alto.

Lungo $y$ la massa non accelera, perché resta sempre alla stessa quota. Lungo $x$ invece serve l'accelerazione centripeta $a_c=v^2/R$. La seconda legge diventa quindi

$ cases(
  T sin theta=m v^2/R,
  T cos theta-m g=0,
) $

#yellow-box([Le due equazioni, spiegate])[
  La tensione obliqua si scompone così: componente orizzontale (verso il centro) $T sin theta$, componente verticale (verso l'alto) $T cos theta$. Attenzione, qui $theta$ è misurato dalla verticale, quindi la parte verticale prende il coseno e la parte orizzontale il seno.

  - *Asse $x$ (orizzontale, verso il centro)*: l'unica forza è $T sin theta$, e deve fornire esattamente la forza centripeta $m a_c = m v^2/R$. Quindi $T sin theta = m v^2/R$.
  - *Asse $y$ (verticale)*: la pallina non sale né scende, quindi le forze verticali si annullano: $T cos theta - m g = 0$.
]

La seconda equazione dà la tensione:

$ T cos theta=m g quad arrow quad T=(m g)/(cos theta). $

Per eliminare $T$ e trovare la velocità, si divide la prima equazione per la seconda:

$ (T sin theta)/(T cos theta)=((m v^2)/R)/(m g). $

#yellow-box([Perché dividere le due equazioni])[
  Il problema è che $T$ è un'incognita scomoda. Dividere membro a membro la prima equazione per la seconda è un trucco potente: a sinistra $T$ si semplifica (compare sopra e sotto), e a destra anche $m$ si semplifica. Così facciamo sparire in un colpo solo *due* incognite ($T$ e $m$) e resta una relazione pulita tra le grandezze geometriche. È lecito perché stiamo dividendo due quantità uguali per due quantità uguali.
]

Semplificando $T$ e $m$:

$ tan theta=v^2/(R g). $

#yellow-box([Come si arriva alla tangente])[
  A sinistra $(T sin theta)/(T cos theta)$: la $T$ si elide e resta $(sin theta)/(cos theta) = tan theta$. A destra $((m v^2)/R)/(m g)$: la $m$ si elide e resta $(v^2/R)/g = v^2/(R g)$. Uguagliando i due lati: $tan theta = v^2/(R g)$. Da qui isolo $v^2 = R g tan theta$ e prendo la radice.
]

Quindi

$ v=sqrt(R g tan theta). $

Il periodo è il tempo necessario per compiere un giro completo. Poiché in un giro la massa percorre una circonferenza di lunghezza $2 pi R$,

$ T_"periodo"=(2 pi R)/v. $

Sostituendo la velocità appena trovata:

$ T_"periodo"=2 pi sqrt(R/(g tan theta)). $

#purple-box([Esempio numerico])[
  Un pendolo conico ha filo lungo $ell = 1 " m"$ e ruota con il filo inclinato di $theta = 30 degree$ rispetto alla verticale. Uso $g = 9,8 " m/s"^2$, $sin 30 degree = 0,5$, $cos 30 degree approx 0,87$, $tan 30 degree approx 0,58$.

  Il raggio: $R = ell sin theta = 1 dot 0,5 = 0,5 " m"$.

  La velocità: $v = sqrt(R g tan theta) = sqrt(#[0,5] dot #[9,8] dot #[0,58]) = sqrt(#[2,84]) approx 1,69 " m/s"$.

  Il periodo: $T_"periodo" = (2 pi R)/v = (2 dot 3,14 dot 0,5)/1,69 approx 3,14/1,69 approx 1,86 " s"$. Ogni giro completo dura circa $1,9$ secondi.
]

= Dinamometro statico

#green-box([L'idea prima della formula])[
  Il dinamometro è quello strumento (come la bilancia a molla per pesare la valigia) fatto di una molla con una scala graduata. L'idea è semplice: più tiri o appendi un peso, più la molla si allunga, e l'allungamento è proporzionale alla forza. Misurando *quanto* si allunga, risali alla forza. Funziona perché in equilibrio la molla "risponde" con una forza elastica che pareggia esattamente quella applicata.
]

#yellow-box([La legge di Hooke: $F_"el" = k x$])[
  La forza elastica della molla è $F_"el" = k x$, dove $x$ è l'allungamento (in metri) e $k$ è la *costante elastica* della molla (in $"N/m"$), un numero che dice quanto la molla è "dura". Una molla rigida ha $k$ grande (si allunga poco anche con tanta forza); una molla morbida ha $k$ piccolo. La forza elastica si oppone sempre all'allungamento, cioè cerca di riportare la molla alla lunghezza di riposo.
]

Un dinamometro statico misura una forza tramite l'allungamento di una molla. In equilibrio, la forza elastica compensa la forza applicata.

#align(center, graph-card([Dinamometro: equilibrio statico della molla], cetz.canvas({
  import cetz.draw: *
  line((0.75, 3.25), (5.05, 3.25), stroke: 1.2pt + ink)
  for x in range(0, 10) { line((0.82 + x*0.42, 3.25), (1.02 + x*0.42, 3.45), stroke: 0.55pt + ink) }
  // molla non allungata
  line((1.75, 3.25), (1.75, 2.85), stroke: 1.1pt + blue)
  line(
    (1.75, 2.85), (1.75, 2.65),
    (1.55, 2.55), (1.95, 2.35), (1.55, 2.15), (1.95, 1.95),
    (1.55, 1.75), (1.95, 1.55), (1.75, 1.45), (1.75, 1.25),
    stroke: 1.2pt + blue,
  )
  line((1.35, 1.25), (2.15, 1.25), stroke: (paint: grid-color, thickness: 0.9pt, dash: "dashed"))
  // molla allungata con massa
  line((3.85, 3.25), (3.85, 2.9), stroke: 1.1pt + blue)
  line(
    (3.85, 2.9), (3.85, 2.65),
    (3.65, 2.52), (4.05, 2.28), (3.65, 2.04), (4.05, 1.80),
    (3.65, 1.56), (4.05, 1.32), (3.85, 1.18), (3.85, 0.9),
    stroke: 1.2pt + blue,
  )
  rect((3.48, 0.45), (4.22, 0.9), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.25, 1.25), (4.9, 1.25), stroke: (paint: grid-color, thickness: 0.9pt, dash: "dashed"))
  line((4.65, 1.25), (4.65, 0.9), stroke: 0.9pt + gold, mark: (end: ">"))
  axis-label((4.82, 1.08), [$x$], placement: "west")
  axis-label((4.35, 0.6), [$m$], placement: "west")
  // corpo libero
  circle((6.7, 1.35), radius: 0.08, fill: ink, stroke: none)
  line((6.7, 1.35), (6.7, 2.5), stroke: 1.45pt + blue, mark: (end: ">"))
  line((6.7, 1.35), (6.7, 0.25), stroke: 1.45pt + red, mark: (end: ">"))
  axis-label((6.9, 2.42), [$vec(F)_"el"$], placement: "west")
  axis-label((6.9, 0.35), [$m vec(g)$], placement: "west")
})))

Per una massa appesa:

$ m g-k x=0 quad arrow quad x=(m g)/k. $

#yellow-box([Da dove esce l'equazione])[
  Appendo una massa $m$ alla molla e aspetto che si fermi (equilibrio): l'accelerazione è zero, quindi la somma delle forze verticali è zero. Le forze sono il peso $m g$ (verso il basso) e la forza elastica $k x$ (verso l'alto, perché la molla, allungata, tira su il corpo). Quindi $m g - k x = 0$. Isolando $x$ ottengo $x = (m g)/k$: l'allungamento è proporzionale alla massa appesa, ed è proprio questo che permette di tarare la scala del dinamometro.
]

La misura della forza si ricava quindi da $F=k x$.

#purple-box([Esempio numerico])[
  Appendo una massa $m = 0,5 " kg"$ a una molla con costante $k = 100 " N/m"$ ($g = 9,8 " m/s"^2$). L'allungamento all'equilibrio è
  $ x = (m g)/k = (0,5 dot 9,8)/100 = 4,9/100 = 0,049 " m" approx 4,9 " cm". $
  La molla si allunga di circa $5 " cm"$, e leggendo questo valore sulla scala il dinamometro mi dice che la forza-peso applicata è $F = k x = 100 dot 0,049 = 4,9 " N"$ (proprio il peso della massa).
]

= Lavoro ed energia

#green-box([L'idea prima della formula])[
  Immagina di spingere una cassa per un tratto di pavimento. Se spingi *nella direzione in cui la cassa si muove*, la stai aiutando: stai "versando energia" dentro al suo moto. Se invece spingi *di lato*, perpendicolarmente al movimento, la cassa avanza lo stesso ma il tuo sforzo non le dà velocità in avanti: in quella direzione non stai trasferendo energia utile al moto. E se tiri *all'indietro* (come fa l'attrito), stai togliendo energia al moto.

  Il *lavoro* è proprio il numero che misura questo trasferimento di energia: quanto una forza, agendo lungo uno spostamento, "carica" o "scarica" il moto del corpo. Per questo conta solo la parte di forza *parallela allo spostamento*: la componente di lato non sposta niente nella direzione del moto, quindi non lavora.
]

Il lavoro misura quanta energia viene trasferita da una forza durante uno spostamento. Conta solo la componente della forza parallela allo spostamento.

#green-box([Perché un prodotto scalare?])[
  Il prodotto scalare $vec(F) dot dif vec(s)$ è esattamente lo strumento matematico che "tiene solo la parte parallela". Per definizione
  $ vec(F) dot dif vec(s)=F dot dif s dot cos alpha, $
  dove $alpha$ è l'angolo tra forza e spostamento. Il fattore $cos alpha$ è il filtro:
  - se forza e spostamento sono *concordi* ($alpha=0$), $cos 0=1$ e il lavoro è massimo e positivo;
  - se sono *perpendicolari* ($alpha=90°$), $cos 90°=0$ e il lavoro è nullo (la forza non aiuta né ostacola il moto);
  - se sono *opposti* ($alpha=180°$), $cos 180°=-1$ e il lavoro è massimo ma negativo (la forza frena).

  In altre parole, $F cos alpha$ è la *componente della forza lungo lo spostamento*, ed è proprio quella che moltiplichiamo per la distanza percorsa.
]

#blue-box([Lavoro elementare])[
  Per uno spostamento infinitesimo $dif vec(s)$,

  $ dif L=vec(F) dot dif vec(s). $

  L'unità di misura è il joule:

  $ 1 "J"=1 "N" dot "m". $
]

#yellow-box([Perché "elementare" e infinitesimo?])[
  Lungo un percorso curvo la forza può cambiare direzione e intensità punto per punto. Allora non possiamo usare un solo prodotto $vec(F) dot vec(s)$ per tutto il tragitto. Il trucco è spezzare il cammino in tantissimi pezzettini così piccoli ($dif vec(s)$) che su ognuno forza e direzione restano praticamente costanti: su ogni pezzettino calcoliamo il piccolo lavoro $dif L$, e poi li sommiamo tutti con un integrale. È la stessa logica con cui si calcola un'area dividendola in striscioline sottili.
]

#align(center, graph-card([Segno del lavoro], cetz.canvas({
  import cetz.draw: *
  // lavoro positivo
  line((0.5, 0.65), (3.2, 0.65), stroke: 1.1pt + ink)
  rect((1.15, 0.65), (1.9, 1.25), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((1.52, 0.95), (2.65, 0.95), stroke: 1.35pt + blue, mark: (end: ">"))
  line((1.15, 0.35), (1.9, 0.35), stroke: 1pt + gold)
  axis-label((2.7, 1.0), [$vec(F)$], placement: "west")
  axis-label((1.5, 0.18), [$Delta s$], placement: "north")
  axis-label((1.85, 1.55), [$L>0$], placement: "south")
  // lavoro nullo
  line((4.0, 0.65), (6.7, 0.65), stroke: 1.1pt + ink)
  rect((4.65, 0.65), (5.4, 1.25), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((5.02, 0.95), (5.02, 2.05), stroke: 1.35pt + blue, mark: (end: ">"))
  line((4.65, 0.35), (5.4, 0.35), stroke: 1pt + gold)
  axis-label((5.18, 2.0), [$vec(F)$], placement: "west")
  axis-label((5.0, 0.18), [$Delta s$], placement: "north")
  axis-label((5.35, 1.55), [$L=0$], placement: "south")
  // lavoro negativo
  line((7.5, 0.65), (10.2, 0.65), stroke: 1.1pt + ink)
  rect((8.15, 0.65), (8.9, 1.25), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((8.52, 0.95), (7.55, 0.95), stroke: 1.35pt + blue, mark: (end: ">"))
  line((8.15, 0.35), (8.9, 0.35), stroke: 1pt + gold)
  axis-label((7.48, 1.0), [$vec(F)$], placement: "east")
  axis-label((8.5, 0.18), [$Delta s$], placement: "north")
  axis-label((8.85, 1.55), [$L<0$], placement: "south")
})))

Il disegno qui sopra riassume i tre casi: a sinistra la forza spinge nel verso dello spostamento ($L>0$, energia immessa nel moto); al centro la forza è verticale mentre lo spostamento è orizzontale, perpendicolari, quindi $L=0$; a destra la forza punta in senso opposto allo spostamento e il lavoro è negativo ($L<0$, energia sottratta).

Se la forza è costante lungo uno spostamento rettilineo da $A$ a $B$,

$ L=integral_A^B vec(F) dot dif vec(s). $

In particolare, se $vec(F)$ è parallela e concorde allo spostamento,

$ L=F s. $

#yellow-box([Da dove esce $L=F s$])[
  Partiamo dal caso generale $L=integral_A^B vec(F) dot dif vec(s)$. Se la forza è *costante*, possiamo portarla fuori dall'integrale (una costante non cambia lungo il cammino). Se inoltre è *parallela e concorde* allo spostamento, l'angolo è $alpha=0$, quindi $cos alpha=1$ e ogni $vec(F) dot dif vec(s)$ diventa semplicemente $F dif s$. Resta
  $ L=F integral_A^B dif s=F s, $
  perché sommare tutti i pezzettini di lunghezza $dif s$ dà la lunghezza totale $s$ del percorso. È la forma più semplice del lavoro: forza per spostamento, quando "tirano" nella stessa direzione.
]

#purple-box([Esempio numerico])[
  Spingo una cassa con una forza costante di $F=20 " N"$ parallela e concorde al pavimento, per uno spostamento $s=3 " m"$. Il lavoro è
  $ L=F s=20 dot 3=60 " J". $
  Se invece spingessi con la stessa forza ma inclinata di $alpha=60°$ rispetto al moto, conterebbe solo la componente parallela:
  $ L=F s cos alpha=20 dot 3 dot cos 60°=60 dot 0,5=30 " J". $
  Stessa forza, stesso spostamento, ma metà del lavoro: perché solo metà della forza "tira in avanti".
]

== Esempio: blocco su piano inclinato liscio

#green-box([L'idea prima della formula])[
  Vogliamo capire quanto lavoro serve per far salire un blocco lungo un piano inclinato liscio (senza attrito), tenendolo a velocità costante. L'intuizione che scopriremo è sorprendente: per sollevare il blocco fino a una certa altezza $h$, il lavoro che serve è lo stesso che servirebbe a sollevarlo verticalmente, $m g h$. La rampa non ti fa risparmiare energia: ti fa solo applicare una forza più piccola, ma su una distanza più lunga. È il principio della "scala più dolce".
]

Un blocco sale lungo un piano inclinato liscio per uno spostamento $s$, con velocità costante. Usiamo $x$ parallelo al piano verso valle e $y$ perpendicolare al piano verso l'esterno. Il peso si scompone in $m g sin theta$ lungo $+x$ e $m g cos theta$ lungo la normale entrante.

#yellow-box([Perché il peso si scompone così])[
  Il peso $m vec(g)$ punta sempre verticalmente verso il basso. Ma su un piano inclinato è comodo lavorare con assi *ruotati*: uno lungo il piano ($x$) e uno perpendicolare al piano ($y$). Proiettando il peso su questi due assi con la trigonometria del triangolo rettangolo, la componente *lungo il piano* (quella che fa scivolare il blocco) vale $m g sin theta$, e quella *che schiaccia il blocco contro il piano* vale $m g cos theta$. Controllo dei casi limite: se $theta=0$ (piano orizzontale) allora $sin 0=0$, niente spinta lungo il piano (giusto, non scivola), e $cos 0=1$, tutto il peso schiaccia verso il basso. Se $theta=90°$ (parete verticale) è il contrario: $sin 90°=1$ tutto il peso tira verso il basso lungo il "piano", $cos 90°=0$ niente schiacciamento.
]

Poiché $v$ è costante, la risultante è nulla: la forza esterna lungo il piano compensa la componente tangenziale del peso.

#align(center, graph-card([Lavoro su piano inclinato liscio], cetz.canvas({
  import cetz.draw: *
  line((0.65, 0.45), (5.4, 2.95), stroke: 1.4pt + ink)
  line((0.65, 0.45), (5.4, 0.45), stroke: 0.9pt + grid-color)
  line((5.4, 2.95), (5.4, 0.45), stroke: 0.9pt + grid-color)
  rect((2.35, 1.25), (3.05, 1.82), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.7, 1.54), (3.85, 2.15), stroke: 1.45pt + blue, mark: (end: ">"))
  line((2.7, 1.54), (2.05, 2.62), stroke: 1.35pt + green, mark: (end: ">"))
  line((2.7, 1.54), (2.7, 0.35), stroke: 1.35pt + red, mark: (end: ">"))
  line((2.7, 1.54), (1.8, 1.05), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((2.7, 1.54), (3.28, 0.46), stroke: (paint: gold, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((2.0, 0.9), (4.35, 2.14), stroke: 1pt + gold, mark: (end: ">"))
  line((3.95, 0.45), (3.95, 2.22), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  arc((1.05, 0.45), start: 0deg, stop: 28deg, radius: 0.6, stroke: 0.9pt + gold)
  axis-label((1.1, 0.68), [$theta$], placement: "south")
  axis-label((3.92, 2.2), [$vec(F)$], placement: "west")
  axis-label((1.95, 2.68), [$vec(N)$], placement: "east")
  axis-label((2.86, 0.20), [$m vec(g)$], placement: "west")
  axis-label((1.65, 1.10), [$m g sin theta$], placement: "east")
  axis-label((3.55, 0.72), [$m g cos theta$], placement: "west")
  axis-label((3.35, 1.35), [$s$], placement: "north")
  axis-label((4.1, 1.27), [$h=s sin theta$], placement: "west")
})))

Con $v$ costante, $sum vec(F)=vec(0)$. Lungo $y$:

$ N-m g cos theta=0. $

Lungo $x$ la forza esterna è diretta verso monte, quindi ha componente negativa rispetto all'asse scelto:

$ m g sin theta-F=0. $

#yellow-box([Perché la risultante è nulla])[
  Velocità costante significa accelerazione nulla. Per la seconda legge di Newton $vec(F)_"tot"=m vec(a)$, se $vec(a)=vec(0)$ allora anche la somma di tutte le forze è zero. Lo applichiamo separatamente ai due assi: lungo $y$ la normale $N$ deve bilanciare la componente del peso che schiaccia ($m g cos theta$), da cui $N=m g cos theta$; lungo $x$ la forza esterna $F$ (che spinge verso monte) deve bilanciare la componente del peso che tira verso valle ($m g sin theta$), da cui $F=m g sin theta$.
]

Il lavoro della forza esterna è

$ L=F s=(m g sin theta) s=m g h. $

#yellow-box([L'ultimo passaggio: $ (m g sin theta) s = m g h $])[
  Guarda il triangolo nel disegno: salendo lungo il piano per una distanza $s$, il blocco guadagna un'altezza verticale $h=s sin theta$ (è il cateto verticale del triangolo). Quindi $s sin theta$ è proprio $h$. Sostituendolo, $L=m g (s sin theta)=m g h$. Conferma dell'intuizione iniziale: il lavoro dipende solo dal dislivello $h$, non dall'inclinazione né dalla lunghezza della rampa.
]

#purple-box([Esempio numerico])[
  Un blocco di massa $m=4 " kg"$ sale a velocità costante lungo un piano inclinato di $theta=30°$, percorrendo $s=2 " m"$ lungo il piano. Usiamo $g=9,8 " m/s"^2$.

  Forza necessaria lungo il piano:
  $ F=m g sin theta=4 dot 9,8 dot sin 30°=4 dot 9,8 dot 0,5=19,6 " N". $
  Altezza guadagnata: $h=s sin theta=2 dot 0,5=1 " m"$.
  Lavoro:
  $ L=F s=19,6 dot 2=39,2 " J", $
  e in effetti $m g h=4 dot 9,8 dot 1=39,2 " J"$: i due conti coincidono, come previsto.
]

== Lavoro della forza elastica

#green-box([L'idea prima della formula])[
  Una molla "non ama" essere allontanata dal suo punto di riposo: più la tiri (o la comprimi), più forte ti spinge indietro. Quindi qui la forza *non è costante*: cambia man mano che ti muovi. Questa è la differenza chiave rispetto al peso. Per calcolare il lavoro non basta "forza per spostamento": dobbiamo sommare tanti piccoli contributi lungo il cammino, e per farlo serve un integrale.
]

Per una molla ideale lungo l'asse $x$ vale

$ F_"el"(x)=-k x. $

#yellow-box([Cosa dicono i simboli])[
  $x$ è lo spostamento *dal punto di equilibrio* (la posizione di riposo della molla), misurato in metri. $k$ è la *costante elastica*, in $"N/m"$: quanto è "rigida" la molla. Il segno *meno* è cruciale: dice che la forza punta sempre *verso l'equilibrio*, cioè in verso opposto allo spostamento. Se tiri la molla a destra ($x>0$), lei tira a sinistra ($F<0$); se la comprimi a sinistra ($x<0$), lei spinge a destra ($F>0$). È una forza di richiamo.
]

Il lavoro tra due posizioni $x_A$ e $x_B$ è

$ L_"el"=integral_(x_A)^(x_B) (-k x) dif x
  =-1/2 k (x_B^2-x_A^2). $

#yellow-box([Come si risolve l'integrale])[
  Dobbiamo calcolare $integral_(x_A)^(x_B) (-k x) dif x$. La costante $-k$ esce dall'integrale, e resta $integral x dif x$. Ricordando che la primitiva di $x$ è $x^2 \/ 2$ (la regola inversa della derivata: derivando $x^2\/2$ si ottiene $x$), abbiamo
  $ L_"el"=-k [x^2/2]_(x_A)^(x_B)=-k (x_B^2/2-x_A^2/2)=-1/2 k (x_B^2-x_A^2). $
  Notare che compaiono i *quadrati* delle posizioni: il lavoro elastico dipende solo da dove parti e dove arrivi, non da come ci arrivi.
]

#align(center, graph-card([Lavoro della forza elastica], cetz.canvas({
  import cetz.draw: *
  // compressione da 0 a x
  line((0.55, 1.15), (0.55, 2.45), stroke: 1.2pt + ink)
  for y in range(0, 4) { line((0.34, 1.18 + y*0.31), (0.55, 1.38 + y*0.31), stroke: 0.55pt + ink) }
  line(
    (0.55, 1.8), (0.82, 1.8),
    (0.95, 2.03), (1.2, 1.57), (1.45, 2.03), (1.7, 1.57),
    (1.95, 2.03), (2.2, 1.57), (2.45, 2.03), (2.65, 1.8),
    stroke: 1.2pt + blue,
  )
  rect((2.65, 1.45), (3.25, 2.15), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((3.25, 1.8), (2.25, 1.8), stroke: 1.35pt + red, mark: (end: ">"))
  line((0.55, 1.02), (3.25, 1.02), stroke: 0.8pt + grid-color, mark: (end: ">"))
  axis-label((3.32, 1.04), [$x$], placement: "west")
  axis-label((2.2, 2.24), [$vec(F)_"el"$], placement: "south")
  axis-label((2.05, 0.82), [da $0$ a $x$: $L_"el"<0$], placement: "north")
  // ritorno verso equilibrio
  line((4.65, 1.15), (4.65, 2.45), stroke: 1.2pt + ink)
  for y in range(0, 4) { line((4.44, 1.18 + y*0.31), (4.65, 1.38 + y*0.31), stroke: 0.55pt + ink) }
  line(
    (4.65, 1.8), (4.92, 1.8),
    (5.05, 2.03), (5.3, 1.57), (5.55, 2.03), (5.8, 1.57),
    (6.05, 2.03), (6.3, 1.57), (6.55, 2.03), (6.75, 1.8),
    stroke: 1.2pt + blue,
  )
  rect((6.75, 1.45), (7.35, 2.15), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((7.05, 1.8), (6.0, 1.8), stroke: 1.35pt + red, mark: (end: ">"))
  line((7.05, 2.3), (6.05, 2.3), stroke: 1.05pt + green, mark: (end: ">"))
  axis-label((6.02, 2.36), [$vec(v)$], placement: "east")
  axis-label((5.98, 1.55), [$vec(F)_"el"$], placement: "east")
  axis-label((6.25, 0.82), [da $x$ a $0$: $L_"el">0$], placement: "north")
})))

In particolare:

$ L_(0 arrow x)=-1/2 k x^2, quad L_(x arrow 0)=+1/2 k x^2. $

#yellow-box([Da dove vengono questi due casi])[
  Sono semplicemente la formula generale con valori particolari degli estremi. Per $L_(0 arrow x)$ poniamo $x_A=0$ e $x_B=x$: $L=-1/2 k (x^2-0^2)=-1/2 k x^2$ (negativo, perché stai allontanando la molla dall'equilibrio: tu fai lavoro contro di lei, lei lo fa contro il moto). Per $L_(x arrow 0)$ poniamo $x_A=x$ e $x_B=0$: $L=-1/2 k (0^2-x^2)=+1/2 k x^2$ (positivo, perché ora la molla riporta il corpo verso casa, spingendolo nel verso del moto).
]

Il segno dipende dal verso dello spostamento rispetto alla forza elastica: quando la molla riporta il corpo verso l'equilibrio, il lavoro è positivo.

#purple-box([Esempio numerico])[
  Una molla con $k=200 " N/m"$ viene compressa di $x=0,1 " m"=10 " cm"$. Il lavoro fatto *dalla molla* mentre la comprimi (da $0$ a $x$) è
  $ L_(0 arrow x)=-1/2 k x^2=-1/2 dot 200 dot (0,1)^2=-1/2 dot 200 dot 0,01=-1 " J". $
  È negativo: la molla si oppone alla compressione. Quando poi la rilasci e torna all'equilibrio, restituisce esattamente $+1 " J"$ di lavoro, spingendo via il corpo. Questa energia "immagazzinata" è l'energia potenziale elastica.
]

== Lavoro della forza peso

#green-box([L'idea prima della formula])[
  La gravità tira sempre verso il basso, con la stessa intensità (vicino alla superficie terrestre). Allora quando un corpo *scende* la gravità "spinge nel verso del moto" e compie lavoro positivo; quando *sale*, lo frena e compie lavoro negativo. Il punto chiave: alla gravità interessa *solo di quanto sali o scendi* (la differenza di quota), non se vai dritto, in diagonale o per una strada tortuosa. Spostamenti orizzontali non costano niente alla gravità, perché lì la forza è perpendicolare al moto.
]

La forza peso è $m vec(g)$ e, vicino alla superficie terrestre, è costante e verticale verso il basso. Se l'asse $y$ è verso l'alto,

$ vec(F)_p=-m g hat(u)_y. $

#yellow-box([Perché quel segno meno])[
  $hat(u)_y$ è il versore (freccia di lunghezza $1$) che punta *verso l'alto*. Ma il peso punta verso il *basso*, cioè nel verso opposto: per questo scriviamo $-m g hat(u)_y$. Il segno meno è solo il modo di dire "in giù" quando l'asse positivo è "in su".
]

Per uno spostamento qualunque da $A$ a $B$:

$ L_p=integral_A^B vec(F)_p dot dif vec(s)
  =-m g (y_B-y_A)=m g (y_A-y_B). $

#yellow-box([Perché conta solo la quota])[
  Nel prodotto scalare $vec(F)_p dot dif vec(s)$, il peso ha solo componente verticale ($-m g$ lungo $y$). Quindi del piccolo spostamento $dif vec(s)$ sopravvive *solo la sua parte verticale* $dif y$; le parti orizzontali si moltiplicano per zero (forza perpendicolare). Resta $integral_A^B (-m g) dif y$. La $-m g$ è costante ed esce dall'integrale, e $integral_A^B dif y$ è semplicemente la variazione di quota $y_B-y_A$. Quindi $L_p=-m g (y_B-y_A)$. L'ultimo passaggio, $-m g(y_B-y_A)=m g(y_A-y_B)$, è solo riscrivere distribuendo il meno: è comodo perché $y_A-y_B$ è la *discesa* (positiva se il corpo scende).
]

#align(center, graph-card([Il lavoro del peso dipende solo dalla quota], cetz.canvas({
  import cetz.draw: *
  line((0.65, 0.45), (0.65, 3.2), stroke: 0.8pt + ink, mark: (end: ">"))
  axis-label((0.45, 3.18), [$y$], placement: "east")
  circle((1.55, 2.65), radius: 0.08, fill: ink, stroke: none)
  circle((5.2, 1.05), radius: 0.08, fill: ink, stroke: none)
  catmull((1.55, 2.65), (2.0, 1.95), (3.25, 1.75), (4.15, 1.15), (5.2, 1.05), stroke: 1.2pt + blue)
  line((1.55, 2.65), (1.55, 1.95), stroke: 1.2pt + red, mark: (end: ">"))
  line((3.25, 1.75), (3.25, 1.05), stroke: 1.2pt + red, mark: (end: ">"))
  line((5.2, 1.05), (5.2, 0.35), stroke: 1.2pt + red, mark: (end: ">"))
  line((1.1, 2.65), (5.5, 2.65), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  line((1.1, 1.05), (5.5, 1.05), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  axis-label((1.42, 2.82), [$A$], placement: "south")
  axis-label((5.35, 1.16), [$B$], placement: "south")
  axis-label((3.45, 2.85), [$y_A$], placement: "south")
  axis-label((3.45, 1.25), [$y_B$], placement: "south")
  axis-label((3.55, 1.7), [$m vec(g)$], placement: "west")
})))

Se il corpo scende, $y_B<y_A$ e il peso compie lavoro positivo; se sale, il lavoro del peso è negativo. Peso e forza elastica sono esempi di forze il cui lavoro non dipende dal percorso, ma solo dagli estremi.

#purple-box([Esempio numerico])[
  Un libro di massa $m=1,5 " kg"$ cade da un tavolo alto $y_A=0,8 " m"$ fino al pavimento ($y_B=0$). Il lavoro del peso è
  $ L_p=m g (y_A-y_B)=1,5 dot 9,8 dot (0,8-0)=11,76 " J". $
  È positivo perché il libro scende, e la gravità lo aiuta. Se lo riportassi sul tavolo, il lavoro del peso sarebbe $-11,76 " J"$: stesso valore, segno opposto.
]

== Potenza

#green-box([L'idea prima della formula])[
  Due gru sollevano lo stesso carico alla stessa altezza: fanno lo stesso *lavoro*. Ma se una ci mette $2$ secondi e l'altra $20$, la prima è molto più "potente". La *potenza* non misura quanto lavoro fai, ma quanto *velocemente* lo fai: lavoro diviso il tempo impiegato.
]

La potenza misura quanto rapidamente viene compiuto lavoro:

#blue-box([Potenza])[
  $ P=(dif L)/(dif t). $

  L'unità di misura è il watt:

  $ 1 "W"=1 "J/s". $
]

Se la forza è applicata a un punto che si muove con velocità $vec(v)$,

$ P=vec(F) dot (dif vec(s))/(dif t)=vec(F) dot vec(v). $

#yellow-box([Da $L\/t$ a $vec(F) dot vec(v)$])[
  Partiamo da $P=dif L \/ dif t$ e ricordiamo che $dif L=vec(F) dot dif vec(s)$. Allora $P=vec(F) dot dif vec(s) \/ dif t$. Ma $dif vec(s) \/ dif t$ è proprio la *velocità* $vec(v)$ (spostamento diviso tempo). Quindi $P=vec(F) dot vec(v)$. Comoda: per la potenza istantanea basta moltiplicare (scalarmente) forza e velocità.
]

#purple-box([Esempio numerico])[
  Un motore esercita una forza di trazione $F=500 " N"$ su un'auto che procede a $vec(v)$ parallela alla forza, a $v=20 " m/s"$ ($72 " km/h"$). La potenza erogata è
  $ P=F v=500 dot 20=10000 " W"=10 " kW". $
  Se la stessa forza agisse a velocità doppia, la potenza raddoppierebbe: per andare più veloce serve più potenza, anche a parità di spinta.
]

= Energia cinetica

#green-box([L'idea prima della formula])[
  L'energia cinetica è l'energia "contenuta nel movimento" di un corpo: quanto lavoro quel corpo può fare *grazie al fatto che si sta muovendo*, prima di fermarsi. Un camion lanciato ha tantissima energia cinetica (è difficile fermarlo e fa danni se colpisce qualcosa); una pallina lenta ne ha pochissima. Due cose la fanno crescere: la *massa* (un corpo più pesante alla stessa velocità ha più energia) e soprattutto la *velocità*, che entra al *quadrato*: raddoppiando la velocità, l'energia cinetica diventa *quattro volte* più grande. Per questo a $100$ km/h un'auto è molto più pericolosa che a $50$, non solo il doppio.
]

L'energia cinetica è l'energia associata al moto:

#blue-box([Energia cinetica])[
  $ E_k=1/2 m v^2. $
]

#green-box([L'idea prima della formula: il teorema dell'energia cinetica])[
  Stiamo per dimostrare uno dei risultati più utili della meccanica: *il lavoro totale fatto su un corpo è uguale a quanto cambia la sua energia cinetica*. In parole povere: se fai lavoro positivo su un corpo, lo acceleri (più energia di moto); se fai lavoro negativo, lo rallenti. È il "libretto contabile" che lega forze e velocità senza dover risolvere il moto istante per istante.
]

Partendo dalla seconda legge, $vec(F)_"tot"=m dif vec(v)/dif t$, il lavoro elementare della risultante è

$ dif L=vec(F)_"tot" dot dif vec(s)
  =m (dif vec(v))/(dif t) dot dif vec(s)
  =m vec(v) dot dif vec(v). $

#yellow-box([Il trucco $ (dif vec(v))/(dif t) dot dif vec(s)=vec(v) dot dif vec(v) $])[
  Sostituiamo $vec(F)_"tot"=m (dif vec(v))\/(dif t)$ (seconda legge) dentro $dif L=vec(F)_"tot" dot dif vec(s)$. Ora c'è un trucco molto usato: riordiniamo i differenziali. Scriviamo
  $ (dif vec(v))/(dif t) dot dif vec(s)=dif vec(v) dot (dif vec(s))/(dif t)=dif vec(v) dot vec(v), $
  perché $(dif vec(s))\/(dif t)=vec(v)$. In pratica abbiamo "spostato" il $dif t$ dal denominatore della derivata della velocità a fianco dello spostamento, trasformandolo nella velocità. Resta $dif L=m vec(v) dot dif vec(v)$.
]

Integrando tra $A$ e $B$:

$ L_"tot"=integral_A^B dif L
  =1/2 m v_B^2-1/2 m v_A^2
  =Delta E_k. $

#yellow-box([Come si integra $ m vec(v) dot dif vec(v) $])[
  Qui serve l'identità chiave: $vec(v) dot dif vec(v)=dif(1/2 v^2)$. Perché? Se deriviamo $1/2 v^2=1/2 (vec(v) dot vec(v))$ rispetto al tempo, per la regola del prodotto otteniamo $vec(v) dot dif vec(v)\/dif t$: quindi $vec(v) dot dif vec(v)$ è proprio il differenziale di $1/2 v^2$. Allora
  $ integral_A^B m vec(v) dot dif vec(v)=m [1/2 v^2]_A^B=1/2 m v_B^2-1/2 m v_A^2. $
  E questa è esattamente la differenza tra energia cinetica finale e iniziale, $Delta E_k$.
]

#yellow-box([Teorema dell'energia cinetica])[
  Il lavoro della risultante delle forze applicate a un punto materiale è uguale alla variazione della sua energia cinetica:

  $ L_"tot"=Delta E_k. $
]

== Esempio: caduta libera

#green-box([L'idea prima della formula])[
  Lasciamo cadere un corpo da fermo. Mentre scende, la gravità lavora su di lui e quel lavoro si trasforma tutto in energia di moto: arriva in basso con una certa velocità. Il teorema dell'energia cinetica ci permette di trovare quella velocità *senza* studiare il moto secondo per secondo: basta uguagliare il lavoro del peso all'aumento di energia cinetica.
]

Un corpo cade da fermo da un'altezza $h$, trascurando l'attrito dell'aria. Il solo lavoro è quello della forza peso:

$ L_p=m g h. $

Poiché $v_0=0$, l'energia cinetica iniziale è nulla. Dal teorema dell'energia cinetica:

$ m g h=1/2 m v_f^2, $

da cui

$ v_f=sqrt(2 g h). $

#yellow-box([Come si isola $v_f$])[
  Da $m g h=1/2 m v_f^2$ semplifichiamo la massa $m$ (compare a sinistra e a destra): $g h=1/2 v_f^2$. Moltiplichiamo per $2$: $v_f^2=2 g h$. Estraiamo la radice quadrata: $v_f=sqrt(2 g h)$. Nota interessante: *la massa è sparita*, una piuma e un sasso (senza aria) arrivano in basso alla stessa velocità.
]

#purple-box([Esempio numerico])[
  Un sasso cade da $h=5 " m"$. Con $g=9,8 " m/s"^2$:
  $ v_f=sqrt(2 dot #[9,8] dot 5)=sqrt(98) approx 9,9 " m/s". $
  Circa $35 " km/h"$ all'impatto, partendo da fermo da appena cinque metri.
]

== Esempio: compressione di una molla

#green-box([L'idea prima della formula])[
  Un blocco lanciato colpisce una molla e la comprime. La molla rallenta il blocco fino a fermarlo del tutto (alla massima compressione $v=0$). Tutta l'energia di moto del blocco si è "travasata" nella molla. Vogliamo sapere *quanto* si comprime: tanto più il blocco era veloce (o pesante), tanto più affonda; tanto più la molla è rigida, tanto meno cede.
]

Un blocco di massa $m$ arriva con velocità $v$ contro una molla ideale di costante elastica $k$ su un piano liscio. Alla massima compressione la velocità è nulla.

#align(center, graph-card([Compressione massima di una molla], cetz.canvas({
  import cetz.draw: *
  line((0.6, 0.65), (6.7, 0.65), stroke: 1.2pt + ink)
  for x in range(0, 13) { line((0.65 + x*0.46, 0.65), (0.85 + x*0.46, 0.45), stroke: 0.5pt + ink) }
  line((5.15, 0.65), (5.15, 2.25), stroke: 1.2pt + ink)
  for y in range(0, 5) { line((5.15, 0.75 + y*0.28), (5.38, 0.93 + y*0.28), stroke: 0.5pt + ink) }
  rect((1.1, 0.65), (1.85, 1.35), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((1.85, 1.0), (3.0, 1.0), stroke: 1.25pt + green, mark: (end: ">"))
  line(
    (4.05, 1.0), (4.28, 1.0),
    (4.38, 1.18), (4.56, 0.82), (4.74, 1.18), (4.92, 0.82),
    (5.1, 1.0),
    stroke: 1.2pt + blue,
  )
  rect((3.45, 0.65), (4.05, 1.35), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((3.75, 1.0), (2.85, 1.0), stroke: 1.25pt + red, mark: (end: ">"))
  line((3.45, 0.4), (5.15, 0.4), stroke: 0.9pt + gold)
  axis-label((3.05, 1.05), [$vec(v)$], placement: "west")
  axis-label((2.8, 1.05), [$vec(F)_"el"$], placement: "east")
  axis-label((4.3, 0.22), [$x_"max"$], placement: "north")
  axis-label((1.45, 1.55), [$v$], placement: "south")
  axis-label((3.82, 1.55), [$v=0$], placement: "south")
})))

Il lavoro della molla è

$ L_"el"=-1/2 k x_"max"^2. $

Per il teorema dell'energia cinetica,

$ -1/2 k x_"max"^2=0-1/2 m v^2, $

quindi

$ x_"max"=v sqrt(m/k). $

#yellow-box([Passaggi e isolamento di $x_"max"$])[
  Il teorema dice $L_"tot"=Delta E_k=E_(k,"fin")-E_(k,"in")$. Qui la sola forza che lavora è la molla, l'energia finale è $0$ (il blocco si ferma) e quella iniziale è $1/2 m v^2$. Quindi $-1/2 k x_"max"^2=0-1/2 m v^2$. Il lavoro della molla è negativo (rallenta il blocco): coerente, perché a destra abbiamo un numero negativo. Ora isoliamo: i due segni meno e i due fattori $1/2$ si cancellano, lasciando $k x_"max"^2=m v^2$, cioè $x_"max"^2=m v^2 \/ k$. Radice quadrata: $x_"max"=v sqrt(m\/k)$.
]

#purple-box([Esempio numerico])[
  Un blocco di $m=2 " kg"$ arriva a $v=3 " m/s"$ contro una molla con $k=800 " N/m"$. La compressione massima è
  $ x_"max"=v sqrt(m/k)=3 dot sqrt(2/800)=3 dot sqrt(#[0,0025])=3 dot 0,05=0,15 " m". $
  Cioè $15 " cm"$. Controllo di sanità: se la molla fosse il quadruplo più rigida ($k=3200$), $sqrt$ dimezza e la compressione sarebbe la metà, $7,5 " cm"$. Sensato: una molla più dura cede meno.
]

== Lavoro della forza di attrito

#green-box([L'idea prima della formula])[
  L'attrito è il "guastafeste" dell'energia: si oppone *sempre* al movimento, qualunque direzione tu prenda. Per questo il suo lavoro è *sempre negativo* (sottrae energia di moto, che si disperde come calore). E, a differenza di peso e molla, dipende da *quanta strada fai*: più lungo è il percorso, più energia ti porta via. Fare un giro lungo e tornare al punto di partenza ti costa attrito; con la gravità invece torneresti "in pari".
]

Per attrito dinamico su una superficie con normale costante,

$ F_"attr"=mu_d N $

e il verso è sempre opposto allo spostamento relativo. Se $hat(u)_v$ è il versore tangente al moto, cioè orientato come la velocità e lo spostamento infinitesimo, allora

$ vec(F)_"attr"=-mu_d N hat(u)_v, quad dif vec(s)=hat(u)_v dif s. $

#yellow-box([Cosa dicono i simboli])[
  $mu_d$ è il *coefficiente di attrito dinamico* (un numero puro, senza unità, di solito tra $0$ e $1$): dice quanto "ruvida" è la coppia di superfici. $N$ è la *normale*, la forza con cui la superficie preme contro il corpo. $hat(u)_v$ è il versore che punta nel verso del moto. Il segno *meno* in $vec(F)_"attr"=-mu_d N hat(u)_v$ dice che l'attrito punta *al contrario* del moto. E $dif vec(s)=hat(u)_v dif s$ dice solo che lo spostamento avviene nel verso del moto, con lunghezza $dif s$.
]

Il lavoro lungo il percorso da $A$ a $B$ si calcola con l'integrale di linea:

$ L_"attr"=integral_A^B vec(F)_"attr" dot dif vec(s). $

Sostituendo:

$ L_"attr"=integral_A^B (-mu_d N hat(u)_v) dot (hat(u)_v dif s). $

Poiché $hat(u)_v dot hat(u)_v=1$,

$ L_"attr"=-integral_A^B mu_d N dif s. $

#yellow-box([Perché $ hat(u)_v dot hat(u)_v=1 $])[
  Il prodotto scalare di un versore con sé stesso vale $|hat(u)_v|^2 cos 0=1 dot 1 dot 1=1$, perché un versore ha lunghezza $1$ ed è "parallelo a sé stesso" (angolo zero). Questo è il motivo profondo per cui l'attrito lavora sempre *negativamente*: forza e spostamento sono perfettamente allineati ma in versi opposti, e il segno meno della forza resta lì in bella vista nel risultato.
]

Se $mu_d$ e $N$ sono costanti lungo il tratto, si possono portare fuori dall'integrale:

$ L_"attr"=-mu_d N integral_A^B dif s=-mu_d N s<0. $

#yellow-box([Da dove esce $ -mu_d N s $])[
  Se $mu_d$ e $N$ non cambiano lungo il percorso, sono costanti: escono dall'integrale come avevamo già fatto per il peso e per la molla. Resta $integral_A^B dif s=s$, la lunghezza totale del percorso. Quindi $L_"attr"=-mu_d N s$. È negativo (c'è il meno davanti, e tutto il resto è positivo): l'attrito toglie sempre energia.
]

#purple-box([Esempio numerico])[
  Una cassa di $m=10 " kg"$ scivola su un pavimento orizzontale per $s=4 " m"$, con coefficiente $mu_d=0,3$. Su piano orizzontale la normale bilancia il peso, $N=m g=10 dot 9,8=98 " N"$. Allora
  $ L_"attr"=-mu_d N s=-0,3 dot 98 dot 4=-117,6 " J". $
  L'attrito ha sottratto circa $118 " J"$ al moto, dispersi in calore.
]

#yellow-box([Attrito e percorso])[
  Il lavoro dell'attrito dipende dalla lunghezza del percorso seguito. Per questo l'attrito non è una forza conservativa.
]

#align(center, graph-card([Lavoro negativo dell'attrito], cetz.canvas({
  import cetz.draw: *
  line((0.75, 0.75), (6.4, 0.75), stroke: 1.2pt + ink)
  for x in range(0, 12) { line((0.8 + x*0.45, 0.75), (1.0 + x*0.45, 0.55), stroke: 0.5pt + ink) }
  rect((2.25, 0.75), (3.05, 1.45), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.65, 1.1), (3.75, 1.1), stroke: 1.3pt + green, mark: (end: ">"))
  line((2.65, 1.1), (1.55, 1.1), stroke: 1.3pt + red, mark: (end: ">"))
  line((2.65, 1.1), (2.65, 2.05), stroke: 1.2pt + green, mark: (end: ">"))
  line((2.65, 1.1), (2.65, 0.1), stroke: 1.2pt + red, mark: (end: ">"))
  axis-label((3.82, 1.15), [$vec(v)$], placement: "west")
  axis-label((1.48, 1.15), [$vec(F)_"attr"$], placement: "east")
  axis-label((2.85, 1.98), [$vec(N)$], placement: "west")
  axis-label((2.85, 0.2), [$m vec(g)$], placement: "west")
  line((3.15, 0.38), (5.6, 0.38), stroke: 0.9pt + gold, mark: (end: ">"))
  axis-label((4.4, 0.18), [$s$], placement: "north")
})))

= Forze conservative

#green-box([L'idea prima della formula])[
  Una forza è *conservativa* quando "non ti fa pagare il viaggio, solo la destinazione". Pensa alla gravità: se sali una collina e poi torni giù allo stesso punto, alla fine la gravità non ti ha né dato né tolto energia in totale (quello che hai "speso" salendo lo riprendi scendendo). Non importa quale sentiero hai scelto. Una forza così *conserva* l'energia meccanica: ecco perché si chiama conservativa.

  L'attrito è l'opposto: ogni metro che percorri ti costa, e tornare al punto di partenza non ti restituisce niente. Per questo *non* è conservativo.
]

Una forza è *conservativa* se il lavoro totale lungo ogni percorso chiuso è nullo:

$ integral_"ciclo" vec(F) dot dif vec(s)=0. $

Equivalentemente, il lavoro tra due punti $A$ e $B$ non dipende dal percorso scelto, ma solo dagli estremi:

$ integral_A^B vec(F) dot dif vec(s) quad "è lo stesso per ogni percorso da " A " a " B. $

#yellow-box([Perché le due condizioni sono la stessa cosa])[
  Immagina due percorsi diversi dal punto $A$ al punto $B$. Vai da $A$ a $B$ lungo il primo, e *torni* da $B$ ad $A$ lungo il secondo: hai fatto un *giro chiuso* (un ciclo). Se il lavoro su ogni ciclo è zero, allora "lavoro all'andata $-$ lavoro al ritorno $=0$" (al ritorno il segno si inverte perché percorri il cammino al contrario). Quindi il lavoro lungo il primo percorso è uguale a quello lungo il secondo: il lavoro tra $A$ e $B$ non dipende dalla strada. Le due frasi dicono davvero la stessa cosa.
]

#align(center, graph-card([Forza conservativa: ciclo nullo e percorsi equivalenti], cetz.canvas({
  import cetz.draw: *
  // ciclo
  circle((1.6, 2.0), radius: 0.95, stroke: 1.2pt + ink)
  arc((1.6, 2.0), start: 220deg, stop: 30deg, radius: 0.95, stroke: 1.3pt + blue, mark: (end: ">"))
  axis-label((1.6, 0.72), [$L_"ciclo"=0$], placement: "north")
  // due percorsi
  circle((4.1, 1.15), radius: 0.07, fill: ink, stroke: none)
  circle((7.15, 1.15), radius: 0.07, fill: ink, stroke: none)
  catmull((4.1, 1.15), (4.8, 2.25), (6.0, 2.4), (7.15, 1.15), stroke: 1.2pt + green, mark: (end: ">"))
  catmull((4.1, 1.15), (5.0, 0.75), (6.0, 0.65), (7.15, 1.15), stroke: 1.2pt + gold, mark: (end: ">"))
  axis-label((3.95, 1.0), [$A$], placement: "east")
  axis-label((7.3, 1.0), [$B$], placement: "west")
  axis-label((5.65, 2.55), [percorso 1], placement: "south")
  axis-label((5.65, 0.55), [percorso 2], placement: "north")
})))

La forza peso e la forza elastica sono conservative. L'attrito dinamico non lo è.

#yellow-box([Verifica con i conti già fatti])[
  Non è un caso: lo abbiamo già dimostrato. Il lavoro del peso ($m g(y_A-y_B)$) e quello della molla ($-1/2 k(x_B^2-x_A^2)$) dipendono *solo* dagli estremi $A$ e $B$, mai dal percorso. Quello dell'attrito ($-mu_d N s$) dipende invece dalla lunghezza $s$ della strada. Ecco perché i primi due sono conservativi e il terzo no.
]

== Energia potenziale

#green-box([L'idea prima della formula])[
  Quando una forza è conservativa, possiamo associare a ogni *posizione* un numero, l'*energia potenziale*, che rappresenta "l'energia immagazzinata e pronta a trasformarsi in moto". Un sasso in cima a una collina ha tanta energia potenziale gravitazionale: è "energia in attesa", che diventerà energia cinetica se lo lasci cadere. Una molla compressa ha energia potenziale elastica, pronta a scattare. È un modo geniale di tenere i conti: invece di calcolare ogni volta l'integrale del lavoro, basta guardare l'energia potenziale di partenza e di arrivo.
]

Per una forza conservativa esiste una funzione di stato, detta energia potenziale $E_p$, tale che

$ L_(A B)=-Delta E_p=E_p(A)-E_p(B). $

#yellow-box([Perché c'è quel segno meno])[
  Il segno meno traduce uno scambio: quando la forza fa lavoro *positivo* sul corpo (gli dà energia di moto), quell'energia deve venire *da qualche parte*, e viene "prelevata" dal serbatoio dell'energia potenziale, che quindi *diminuisce*. Lavoro positivo $arrow.l.r$ energia potenziale che cala: ecco il $-Delta E_p$. Esempio: un sasso che cade guadagna velocità (lavoro positivo del peso) e contemporaneamente perde quota, cioè perde energia potenziale.
]

Le energie potenziali più usate in questi appunti sono:

$ E_(p,g)=m g y, quad E_(p,"el")=1/2 k x^2. $

#yellow-box([Da dove arrivano queste due formule])[
  Non sono inventate: si ricavano dalla relazione $L=-Delta E_p$ confrontandola con i lavori già calcolati. Per il peso avevamo $L_p=m g(y_A-y_B)=-(m g y_B - m g y_A)$, che ha la forma $-Delta E_p$ con $E_(p,g)=m g y$. Per la molla avevamo $L_"el"=-1/2 k(x_B^2-x_A^2)=-(1/2 k x_B^2-1/2 k x_A^2)$, da cui $E_(p,"el")=1/2 k x^2$. La struttura è sempre "$-Delta$ di qualcosa", e quel qualcosa è l'energia potenziale.
]

La quota zero e la posizione $x=0$ sono scelte di riferimento: cambiare lo zero dell'energia potenziale non cambia la fisica, perché contano le variazioni.

#yellow-box([Perché lo zero è una scelta libera])[
  L'energia potenziale conta solo nelle sue *differenze*. Se misuro la quota dal pavimento o dal soffitto, l'altezza assoluta cambia, ma la *differenza* di quota tra due punti (e quindi il lavoro, e quindi la fisica) resta identica. È come misurare la temperatura: posso scegliere uno zero diverso, ma le differenze di temperatura non cambiano.
]

== Energia meccanica

#green-box([L'idea prima della formula])[
  L'energia meccanica è la *somma* di due salvadanai: l'energia di moto ($E_k$) e l'energia immagazzinata nella posizione ($E_p$). L'idea potente è questa: se agiscono *solo* forze conservative, l'energia può *travasarsi* da un salvadanaio all'altro (il sasso che cade trasforma potenziale in cinetica), ma la *somma totale resta sempre la stessa*. Niente si perde. È la legge di conservazione dell'energia meccanica, e permette di risolvere problemi con un solo "prima $=$ dopo".
]

Definiamo l'energia meccanica come

$ E=E_k+E_p. $

Dal teorema dell'energia cinetica:

$ L_"tot"=Delta E_k. $

Se agiscono solo forze conservative, allora $L_"tot"=-Delta E_p$, quindi

$ Delta E_k+Delta E_p=0, $

cioè

$ E_k+E_p="costante". $

#yellow-box([La catena di passaggi, spiegata])[
  Mettiamo insieme due fatti che già conosciamo. (1) Il teorema dell'energia cinetica: il lavoro *totale* aumenta l'energia cinetica, $L_"tot"=Delta E_k$. (2) Se tutte le forze sono conservative, il loro lavoro totale è $L_"tot"=-Delta E_p$ (definizione di energia potenziale). Uguagliando le due espressioni dello stesso $L_"tot"$: $Delta E_k=-Delta E_p$, cioè $Delta E_k+Delta E_p=0$. Ma "la variazione della somma è zero" significa esattamente "la somma non cambia": $E_k+E_p="costante"$. Fine.
]

#green-box([Conservazione dell'energia meccanica])[
  Se le uniche forze che compiono lavoro sono conservative, l'energia meccanica si conserva:

  $ E_A=E_B. $
]

== Esempio: scambio tra energia potenziale e cinetica

#green-box([L'idea prima della formula])[
  Questi esempi mostrano i due salvadanai in azione. In discesa il "salvadanaio quota" si svuota e quello "velocità" si riempie. Con la molla il "salvadanaio molla" si scarica nel "salvadanaio velocità". In entrambi i casi scriviamo semplicemente "energia all'inizio $=$ energia alla fine".
]

In assenza di attrito, durante una discesa la perdita di energia potenziale gravitazionale diventa energia cinetica:

$ m g h=1/2 m v^2 quad arrow quad v=sqrt(2 g h). $

#yellow-box([Da dove viene questa uguaglianza])[
  È la conservazione $E_k+E_p="costante"$ applicata tra cima e fondo. In cima il corpo è fermo ($E_k=0$) e ha energia potenziale $m g h$; in fondo ha quota zero ($E_p=0$) e tutta l'energia è diventata cinetica $1/2 m v^2$. Uguagliando il totale prima e dopo: $m g h=1/2 m v^2$. Isolando $v$ (semplifico $m$, moltiplico per $2$, faccio la radice) ritrovo $v=sqrt(2 g h)$ — lo stesso risultato della caduta libera, ottenuto in modo ancora più diretto.
]

Per una molla su piano liscio, l'energia elastica può trasformarsi in energia cinetica:

$ 1/2 k x^2=1/2 m v^2. $

#purple-box([Esempio numerico])[
  Una molla con $k=500 " N/m"$, compressa di $x=0,2 " m"$, lancia un blocco di $m=1 " kg"$ su piano liscio. Tutta l'energia elastica diventa cinetica:
  $ 1/2 dot 500 dot (0,2)^2=1/2 dot 1 dot v^2 quad arrow quad 10=0,5 v^2 quad arrow quad v^2=20, $
  da cui $v=sqrt(20)approx 4,5 " m/s"$. Il blocco parte a circa $4,5 " m/s"$.
]

#align(center, graph-card([Scambio tra $E_p$ ed $E_k$], cetz.canvas({
  import cetz.draw: *
  // gravità
  line(
    (0.75, 0.55), (0.90, 1.17), (1.05, 1.68), (1.20, 2.07),
    (1.35, 2.35), (1.50, 2.52), (1.65, 2.58), (1.80, 2.52),
    (1.95, 2.35), (2.10, 2.07), (2.25, 1.68), (2.40, 1.17),
    (2.55, 0.55),
    stroke: 1.25pt + ink,
  )
  circle((1.65, 2.58), radius: 0.09, fill: ink, stroke: none)
  circle((2.14, 1.96), radius: 0.09, fill: ink, stroke: none)
  circle((2.55, 0.55), radius: 0.09, fill: ink, stroke: none)
  axis-label((1.56, 2.86), [$E_p$ max, $E_k=0$], placement: "south")
  axis-label((2.30, 2.02), [$E_p+E_k$], placement: "west")
  axis-label((2.72, 0.68), [$E_p=0$], placement: "west")
  // molla
  line((5.05, 0.55), (5.05, 2.7), stroke: 1.1pt + ink)
  for y in range(0, 6) { line((4.82, 0.65 + y*0.32), (5.05, 0.85 + y*0.32), stroke: 0.5pt + ink) }
  line(
    (5.05, 1.55), (5.28, 1.55),
    (5.4, 1.75), (5.62, 1.35), (5.84, 1.75), (6.06, 1.35),
    (6.28, 1.75), (6.5, 1.35), (6.72, 1.55),
    stroke: 1.2pt + blue,
  )
  rect((6.72, 1.2), (7.35, 1.9), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((7.35, 1.55), (8.15, 1.55), stroke: 1.25pt + green, mark: (end: ">"))
  axis-label((6.55, 0.88), [$1/2 k x^2$], placement: "north")
  axis-label((8.2, 1.6), [$vec(v)$], placement: "west")
})))

= Forze non conservative

#green-box([L'idea prima della formula])[
  Quando entra in gioco l'attrito (o un'altra forza non conservativa), l'energia meccanica *non si conserva più*: una parte se ne va, dispersa in calore. La buona notizia è che possiamo ancora tenere i conti, ma con una piccola modifica: la *variazione* dell'energia meccanica è esattamente uguale al lavoro fatto dalle forze non conservative. Se l'attrito toglie $50 " J"$, l'energia meccanica cala di $50 " J"$. È il "bilancio con le perdite".
]

Se agiscono anche forze non conservative, separiamo il lavoro totale:

$ L_"tot"=L_"cons"+L_"non cons". $

Poiché $L_"tot"=Delta E_k$ e $L_"cons"=-Delta E_p$,

$ L_"non cons"=Delta E_k+Delta E_p=Delta E. $

#yellow-box([I passaggi del bilancio])[
  Spezziamo il lavoro totale in due gruppi: quello delle forze conservative ($L_"cons"$) e quello delle altre ($L_"non cons"$). Sappiamo che $L_"tot"=Delta E_k$ (teorema) e che $L_"cons"=-Delta E_p$ (energia potenziale). Sostituiamo nella somma $L_"tot"=L_"cons"+L_"non cons"$:
  $ Delta E_k=-Delta E_p+L_"non cons". $
  Spostiamo $-Delta E_p$ a sinistra: $L_"non cons"=Delta E_k+Delta E_p$. E $Delta E_k+Delta E_p$ è proprio la variazione dell'energia meccanica $Delta E$. Se non ci sono forze non conservative ($L_"non cons"=0$) ritroviamo $Delta E=0$, la conservazione di prima: tutto torna.
]

#yellow-box([Bilancio dell'energia meccanica])[
  Il lavoro delle forze non conservative è uguale alla variazione dell'energia meccanica:

  $ L_"non cons"=Delta E_"meccanica". $
]

Per l'attrito dinamico su un tratto scabro orizzontale,

$ L_"attr"=-mu_d m g s, $

quindi l'energia meccanica diminuisce.

#yellow-box([Perché qui $ N=m g $])[
  Su un tratto *orizzontale* nessuna componente del peso "scappa di lato": tutto il peso preme verticalmente sul piano, e la normale lo bilancia esattamente, $N=m g$. Sostituendo in $L_"attr"=-mu_d N s$ si ottiene $L_"attr"=-mu_d m g s$. Attenzione: questo vale *solo* su piano orizzontale; su un piano inclinato $N=m g cos theta$, come vedremo tra poco.
]

== Esempio: guida senza attrito e tratto scabro

#green-box([L'idea prima della formula])[
  Mettiamo insieme tutto: un corpo scivola su una guida liscia (energia meccanica conservata) e poi attraversa un tratto ruvido (energia meccanica che cala). La strategia è "a zone": nei tratti lisci uso "energia prima $=$ energia dopo"; nel tratto ruvido uso "variazione di energia $=$ lavoro dell'attrito".
]

Nel tratto senza attrito la gravità è conservativa, quindi l'energia meccanica resta costante. Se un corpo parte da $A$ con velocità nulla e quota $h_A$, allora in un punto $B$ di quota $h_B$:

$ m g h_A=1/2 m v_B^2+m g h_B. $

#yellow-box([Lettura dell'equazione])[
  È il bilancio "totale prima $=$ totale dopo". A sinistra l'energia in $A$: solo potenziale $m g h_A$ (parte fermo, $E_k=0$). A destra l'energia in $B$: cinetica $1/2 m v_B^2$ più potenziale $m g h_B$. Niente attrito, quindi i due totali sono uguali.
]

Se $h_B=h_A$, allora $v_B=0$; se il corpo arriva al fondo con quota zero,

$ v=sqrt(2 g h_A). $

#yellow-box([I due casi limite])[
  Se $B$ è alla *stessa quota* di $A$ ($h_B=h_A$), i termini $m g h$ si cancellano e resta $0=1/2 m v_B^2$, cioè $v_B=0$: il corpo risale fino alla quota di partenza e lì si ferma (come un pendolo che torna alla stessa altezza). Se invece $B$ è *al fondo* ($h_B=0$), tutta la potenziale è diventata cinetica: $m g h_A=1/2 m v^2$, da cui $v=sqrt(2 g h_A)$.
]

Se invece la velocità iniziale in $A$ non è nulla,

$ 1/2 m v_A^2+m g h_A=m g h_B $

quando il corpo si ferma in $B$, e quindi

$ h_B=h_A+v_A^2/(2g). $

#yellow-box([Come si isola $h_B$])[
  Qui in $B$ il corpo è fermo ($E_k=0$), quindi a destra c'è solo $m g h_B$. A sinistra l'energia in $A$ è cinetica più potenziale. Semplifichiamo la massa ovunque: $1/2 v_A^2+g h_A=g h_B$. Dividiamo per $g$ e ordiniamo: $h_B=h_A+v_A^2\/(2 g)$. Ha senso: avendo una *spinta iniziale* (velocità in $A$), il corpo riesce a salire *più in alto* della sola quota $h_A$, e il sovrappiù $v_A^2\/(2g)$ è proprio l'energia cinetica iniziale convertita in altezza.
]

Su un tratto orizzontale scabro $P Q$ di lunghezza $s_(P Q)$:

$ Delta E= L_"attr"=-mu_d m g s_(P Q). $

Poiché su quel tratto non cambia l'energia potenziale,

$ 1/2 m v_Q^2-1/2 m v_P^2=-mu_d m g s_(P Q). $

#yellow-box([Perché sparisce l'energia potenziale])[
  Sul tratto orizzontale la quota non cambia: $E_p$ resta la stessa in $P$ e in $Q$, quindi $Delta E_p=0$. Allora la variazione di energia meccanica $Delta E=Delta E_k+Delta E_p$ si riduce alla sola $Delta E_k=1/2 m v_Q^2-1/2 m v_P^2$. Uguagliandola al lavoro dell'attrito $-mu_d m g s_(P Q)$ otteniamo la relazione finale: il corpo arriva in $Q$ più lento che in $P$, e la perdita di energia cinetica è esattamente quella mangiata dall'attrito.
]

#purple-box([Esempio numerico])[
  Un corpo arriva in $P$ a $v_P=6 " m/s"$ e attraversa un tratto scabro $P Q$ lungo $s_(P Q)=3 " m"$, con $mu_d=0,4$. Quanto vale $v_Q$? Semplifichiamo $m$ nella relazione:
  $ 1/2 v_Q^2-1/2 v_P^2=-mu_d g s_(P Q). $
  $ 1/2 v_Q^2=1/2 (6)^2-0,4 dot 9,8 dot 3=18-11,76=6,24, $
  quindi $v_Q^2=12,48$ e $v_Q approx 3,5 " m/s"$. Il corpo esce dal tratto ruvido molto più lento.
]

#align(center, graph-card([Energia meccanica con e senza attrito], cetz.canvas({
  import cetz.draw: *
  // guida liscia
  line((0.55, 2.8), (2.8, 0.75), stroke: 1.3pt + ink)
  line((2.8, 0.75), (4.4, 0.75), stroke: 1.3pt + ink)
  for x in range(0, 5) { line((2.92 + x*0.30, 0.75), (3.08 + x*0.30, 0.55), stroke: 0.5pt + ink) }
  line((4.4, 0.75), (5.35, 2.65), stroke: 1.3pt + ink)
  circle((0.85, 2.52), radius: 0.1, fill: ink, stroke: none)
  circle((2.8, 0.75), radius: 0.08, fill: ink, stroke: none)
  circle((4.4, 0.75), radius: 0.08, fill: ink, stroke: none)
  circle((5.1, 2.35), radius: 0.1, fill: ink, stroke: none)
  line((0.85, 2.52), (0.85, 0.75), stroke: 0.9pt + gold, mark: (end: ">"))
  axis-label((0.68, 2.75), [$A$], placement: "east")
  axis-label((2.8, 0.55), [$P$], placement: "north")
  axis-label((4.4, 0.55), [$Q$], placement: "north")
  axis-label((5.25, 2.55), [$B$], placement: "west")
  axis-label((1.05, 1.72), [$h_A$], placement: "west")
  axis-label((1.75, 1.85), [liscio], placement: "south")
  axis-label((3.6, 0.48), [scabro], placement: "north")
  // tratto scabro
  line((6.4, 0.75), (9.2, 0.75), stroke: 1.3pt + ink)
  for x in range(0, 7) { line((6.45 + x*0.4, 0.75), (6.63 + x*0.4, 0.55), stroke: 0.5pt + ink) }
  circle((6.75, 0.75), radius: 0.08, fill: ink, stroke: none)
  circle((8.95, 0.75), radius: 0.08, fill: ink, stroke: none)
  line((6.75, 0.45), (8.95, 0.45), stroke: 0.9pt + gold, mark: (end: ">"))
  line((7.75, 1.05), (6.65, 1.05), stroke: 1.25pt + red, mark: (end: ">"))
  axis-label((6.7, 0.35), [$P$], placement: "north")
  axis-label((8.95, 0.35), [$Q$], placement: "north")
  axis-label((7.85, 0.25), [$s_(P Q)$], placement: "north")
  axis-label((6.55, 1.1), [$vec(F)_"attr"$], placement: "east")
  axis-label((7.8, 1.45), [$Delta E<0$], placement: "south")
})))

== Esempio: piano inclinato scabro con energia

#green-box([L'idea prima della formula])[
  È l'esempio più completo: un corpo scende un piano inclinato *ruvido*. La gravità lo accelera, ma l'attrito gli ruba energia lungo tutta la discesa. Vogliamo la velocità finale, e ci aspettiamo che sia *minore* di quella del piano liscio ($sqrt(2 g h)$), perché parte dell'energia se n'è andata in calore. Mettiamo tutto nel bilancio energetico.
]

Consideriamo un corpo che parte da fermo da quota $h$ e scende lungo un piano inclinato scabro di angolo $theta$. La lunghezza percorsa sul piano è

$ Delta s=h/sin theta. $

#yellow-box([Da dove esce $ Delta s=h\/sin theta $])[
  Nel triangolo del piano inclinato, $h$ è il cateto verticale e $Delta s$ è l'ipotenusa (il tratto percorso lungo il piano). La trigonometria dice $sin theta=h\/Delta s$ (seno $=$ cateto opposto su ipotenusa). Isolando $Delta s$: $Delta s=h\/sin theta$. Più il piano è dolce (angolo piccolo), più $sin theta$ è piccolo e più lungo è il tragitto per scendere della stessa quota $h$: ha senso.
]

La normale vale $N=m g cos theta$, quindi il lavoro dell'attrito dinamico è

$ L_"attr"=-mu_d N Delta s=-mu_d m g cos theta h/sin theta=-mu_d m g h/tan theta. $

#yellow-box([La semplificazione $ cos theta\/sin theta=1\/tan theta $])[
  Sostituiamo $N=m g cos theta$ e $Delta s=h\/sin theta$ in $L_"attr"=-mu_d N Delta s$: otteniamo $-mu_d m g cos theta dot (h\/sin theta)$. Ora usiamo l'identità trigonometrica $tan theta=sin theta\/cos theta$, quindi $cos theta\/sin theta=1\/tan theta$. Raggruppando, $L_"attr"=-mu_d m g h\/tan theta$. È una forma compatta del lavoro dell'attrito sulla discesa.
]

Il bilancio dell'energia meccanica diventa

$ L_"attr"=Delta E=1/2 m v_f^2-m g h. $

#yellow-box([Lettura del bilancio])[
  $Delta E=E_"fin"-E_"in"$. All'inizio: corpo fermo a quota $h$, energia $m g h$. Alla fine: corpo a quota zero con velocità $v_f$, energia $1/2 m v_f^2$. Quindi $Delta E=1/2 m v_f^2-m g h$, e questa variazione (negativa) è uguale al lavoro dell'attrito (anch'esso negativo): tutto coerente.
]

Sostituendo il lavoro dell'attrito:

$ -mu_d m g h/tan theta=1/2 m v_f^2-m g h, $

da cui

$ v_f^2=2 g h (1-mu_d/tan theta). $

#yellow-box([I passaggi algebrici fino a $v_f^2$])[
  Partiamo da $-mu_d m g h\/tan theta=1/2 m v_f^2-m g h$. Portiamo $-m g h$ a sinistra (diventa $+m g h$):
  $ m g h-mu_d m g h/tan theta=1/2 m v_f^2. $
  Semplifichiamo $m$ ovunque e moltiplichiamo per $2$:
  $ 2 g h-2 mu_d g h/tan theta=v_f^2. $
  Raccogliamo $2 g h$ a fattor comune:
  $ v_f^2=2 g h (1-mu_d/tan theta). $
  Il termine $sqrt(2 g h)$ è la velocità del piano liscio; il fattore $(1-mu_d\/tan theta)$, minore di $1$, è la "tassa" che l'attrito impone.
]

#purple-box([Esempio numerico])[
  Un corpo scende da $h=2 " m"$ su un piano a $theta=45°$ con $mu_d=0,2$. Poiché $tan 45°=1$:
  $ v_f^2=2 dot 9,8 dot 2 dot (1-0,2/1)=39,2 dot 0,8=31,36, $
  quindi $v_f=sqrt(#[3#[1,3]6])approx 5,6 " m/s"$. Senza attrito sarebbe stato $sqrt(2 dot #[9,8] dot 2)=sqrt(#[39,2])approx 6,3 " m/s"$: l'attrito ha "rubato" circa $0,7 " m/s"$.
]

#yellow-box([Condizione fisica])[
  La formula ha senso solo se il termine tra parentesi è non negativo e se il corpo riesce effettivamente a scivolare lungo il piano. L'attrito sottrae energia meccanica, quindi la velocità finale è minore del caso liscio $sqrt(2 g h)$.
]

#red-box([Attenzione: errori tipici con l'energia])[
  - *Non* scrivere $L_"attr"=+mu_d N s$: l'attrito frena, il suo lavoro è *sempre negativo*. Il segno meno deve esserci.
  - Sul piano inclinato la normale è $N=m g cos theta$, *non* $m g$. Quel $cos theta$ è facile da dimenticare.
  - Quando c'è attrito *non* puoi scrivere $E_A=E_B$ (l'energia meccanica non si conserva). Usa invece $Delta E=L_"non cons"$.
  - Nell'energia cinetica la velocità è *al quadrato*: $1/2 m v^2$, non $1/2 m v$. E il fattore $1/2$ non va dimenticato.
]

#align(center, graph-card([Piano inclinato scabro: energia e forze], cetz.canvas({
  import cetz.draw: *
  line((0.65, 0.55), (7.55, 0.55), stroke: 1pt + ink)
  line((1.05, 0.55), (6.20, 3.55), stroke: 1.35pt + ink)
  for i in range(0, 15) {
    line((1.16 + i*0.32, 0.64 + i*0.19), (1.36 + i*0.32, 0.37 + i*0.19), stroke: 0.45pt + ink)
  }
  line((6.20, 3.55), (6.20, 0.55), stroke: 0.85pt + gold, mark: (end: ">"))
  axis-label((6.42, 2.10), [$h$], placement: "west")
  arc((1.05, 0.55), start: 0deg, stop: 30deg, radius: 0.92, stroke: 0.8pt + ink)
  axis-label((1.95, 0.83), [$theta$], placement: "west")
  circle((3.65, 2.05), radius: 0.14, fill: ink, stroke: none)

  // Assi locali e forze reali
  line((3.65, 2.05), (5.02, 2.85), stroke: 1.25pt + green, mark: (end: ">"))
  line((3.65, 2.05), (2.46, 1.36), stroke: 1.25pt + red, mark: (end: ">"))
  line((3.65, 2.05), (2.83, 3.46), stroke: 1.25pt + blue, mark: (end: ">"))
  line((3.65, 2.05), (3.65, 0.50), stroke: 1.25pt + red, mark: (end: ">"))

  // Componenti del peso, separate dalle etichette principali
  line((3.65, 2.05), (4.45, 0.67), stroke: 0.95pt + red, mark: (end: ">"))
  line((3.65, 2.05), (2.52, 1.39), stroke: 0.95pt + red, mark: (end: ">"))
  line((4.45, 0.67), (3.33, 0.02), stroke: 0.55pt + rgb("#b7c0c6"))
  line((2.52, 1.39), (3.33, 0.02), stroke: 0.55pt + rgb("#b7c0c6"))

  axis-label((5.14, 2.93), [$vec(v)$], placement: "west")
  axis-label((2.30, 1.28), [$vec(F)_"attr"$], placement: "east")
  axis-label((2.70, 3.62), [$vec(N)$], placement: "south")
  axis-label((3.86, 0.55), [$m vec(g)$], placement: "west")
  axis-label((4.85, 0.80), [$m g cos theta$], placement: "west")
  axis-label((2.26, 1.62), [$m g sin theta$], placement: "east")
  line((1.22, 0.25), (6.02, 3.05), stroke: 0.8pt + gold, mark: (end: ">"))
  axis-label((3.95, 3.32), [$Delta s=h/sin theta$], placement: "south")
})))

= Momento angolare

#gray-box([Dove siamo, e dove andiamo])[
  Finora abbiamo studiato lavoro ed energia: strumenti per i *moti lineari* (avanti e indietro, su e giù). Ora cambiamo punto di vista e guardiamo le *rotazioni* attorno a un punto. Nasce una nuova grandezza, il *momento angolare*, che per le rotazioni gioca lo stesso ruolo che la quantità di moto gioca per i moti lineari: misura "quanta rotazione" sta avvenendo ed è soggetta a una sua legge di conservazione.
]

#green-box([L'idea prima della formula])[
  Pensa a una pattinatrice che gira: ha un "moto di rotazione" attorno a sé stessa. Il *momento angolare* misura proprio questo "girare attorno a un punto $O$". Dipende da tre cose: quanta materia c'è (la massa), quanto velocemente si muove ($vec(v)$) e quanto è *lontana* dal centro di rotazione ($vec(r)$). Stessa pattinatrice: se allarga le braccia (aumenta $r$) o le chiude cambia il suo modo di ruotare. Il prodotto vettoriale $vec(r) times vec(p)$ cattura esattamente "quanto" e "attorno a quale asse" sta girando.
]

Il *momento angolare* di una particella rispetto a un polo fisso $O$ è definito come

$ vec(ell)_O=vec(r) times vec(p)=vec(r) times m vec(v). $

Il vettore $vec(r)$ va dal polo $O$ alla particella. L'unità di misura è $"kg m"^2"/s"$, equivalente a $"N m s"$.

#yellow-box([Perché un prodotto *vettoriale* e non scalare?])[
  Per il lavoro usavamo il prodotto *scalare*, perché ci interessava la parte di forza *parallela* allo spostamento. Qui è il contrario: una rotazione è efficace quando la velocità è *perpendicolare* al raggio $vec(r)$ (pensa a una giostra: ti muovi di traverso rispetto al filo che ti tiene al centro). Il prodotto *vettoriale* $vec(r) times vec(p)$ misura proprio la parte perpendicolare, ed è massimo quando $vec(r)$ e $vec(p)$ formano un angolo retto, nullo quando sono allineati (in quel caso non c'è "giro", solo allontanamento o avvicinamento).
]

#align(center, graph-card([Momento angolare rispetto a $O$], cetz.canvas({
  import cetz.draw: *
  circle((1.0, 0.8), radius: 0.07, fill: ink, stroke: none)
  axis-label((0.85, 0.62), [$O$], placement: "east")
  circle((3.25, 2.0), radius: 0.13, fill: ink, stroke: none)
  line((1.0, 0.8), (3.25, 2.0), stroke: 1.2pt + blue, mark: (end: ">"))
  line((3.25, 2.0), (4.55, 2.55), stroke: 1.2pt + green, mark: (end: ">"))
  axis-label((2.05, 1.55), [$vec(r)$], placement: "south")
  axis-label((4.62, 2.62), [$vec(p)=m vec(v)$], placement: "west")
  axis-label((2.65, 0.72), [$vec(ell)_O=vec(r) times vec(p)$], placement: "north")
})))

== Momento delle forze

#green-box([L'idea prima della formula])[
  Per far ruotare qualcosa non basta una forza: conta *dove* la applichi. Apri una porta spingendo vicino alla maniglia (lontano dai cardini): è facile. Prova a spingere vicino ai cardini: quasi impossibile, anche con la stessa forza. Il *momento della forza* (o "torcente") misura proprio questa efficacia rotatoria: cresce con l'intensità della forza *e* con la distanza dal perno $O$. È ciò che fa girare le cose.
]

Il *momento della forza* rispetto allo stesso polo è

$ vec(tau)_O=vec(r) times vec(F). $

Misura l'efficacia della forza nel produrre una rotazione intorno a $O$ e si misura in newton per metro.

#align(center, graph-card([Momento di una forza], cetz.canvas({
  import cetz.draw: *
  circle((1.0, 0.75), radius: 0.07, fill: ink, stroke: none)
  axis-label((0.85, 0.58), [$O$], placement: "east")
  circle((3.25, 1.75), radius: 0.12, fill: ink, stroke: none)
  line((1.0, 0.75), (3.25, 1.75), stroke: 1.2pt + blue, mark: (end: ">"))
  line((3.25, 1.75), (4.05, 2.85), stroke: 1.2pt + red, mark: (end: ">"))
  axis-label((2.06, 1.40), [$vec(r)$], placement: "south")
  axis-label((4.12, 2.92), [$vec(F)$], placement: "west")
  axis-label((2.75, 0.62), [$vec(tau)_O=vec(r) times vec(F)$], placement: "north")
})))

== Teorema del momento angolare

#green-box([L'idea prima della formula])[
  C'è un parallelo perfetto con i moti lineari. Lì la legge è "la forza fa cambiare la quantità di moto" ($vec(F)=dif vec(p)\/dif t$). Per le rotazioni vale la versione "ruotata": *il momento della forza fa cambiare il momento angolare*. Se nessun momento agisce, il momento angolare resta costante: ecco perché la pattinatrice che chiude le braccia *gira più veloce* (per mantenere costante il suo momento angolare).
]

Per una particella osservata da un polo fisso in un sistema inerziale:

#purple-box([Teorema del momento angolare])[
  $ (dif vec(ell)_O)/(dif t)=vec(tau)_O. $
]

Infatti

$ (dif vec(ell)_O)/(dif t)
  =(dif vec(r))/(dif t) times vec(p)+vec(r) times (dif vec(p))/(dif t)
  =vec(v) times m vec(v)+vec(r) times vec(F)
  =vec(tau)_O, $

perché $vec(v) times m vec(v)=vec(0)$.

#yellow-box([Spiegazione della derivata, passo per passo])[
  Deriviamo $vec(ell)_O=vec(r) times vec(p)$ rispetto al tempo. Come per una normale moltiplicazione, la *regola del prodotto* si applica anche al prodotto vettoriale: si deriva prima un fattore poi l'altro, $ (dif vec(r))/(dif t) times vec(p)+vec(r) times (dif vec(p))/(dif t)$. Ora interpretiamo i pezzi: $dif vec(r)\/dif t=vec(v)$ (la derivata della posizione è la velocità) e $dif vec(p)\/dif t=vec(F)$ (la seconda legge di Newton). Quindi il primo termine è $vec(v) times m vec(v)$ e il secondo è $vec(r) times vec(F)=vec(tau)_O$. Infine $vec(v) times m vec(v)=vec(0)$, perché *il prodotto vettoriale di un vettore con sé stesso è sempre zero* (sono paralleli, niente parte perpendicolare). Resta solo $vec(tau)_O$.
]

Per un sistema di particelle conta il momento totale delle forze esterne. Se la risultante dei momenti esterni è nulla,

$ sum vec(tau)_"ext"=vec(0) quad arrow quad vec(ell)_"tot"="costante". $

Analogamente, se la risultante delle forze esterne è nulla,

$ sum vec(F)_"ext"=vec(0) quad arrow quad vec(P)_"tot"="costante". $

#yellow-box([Le due conservazioni in parallelo])[
  Sono lo stesso ragionamento, una per le rotazioni e una per i moti lineari. Se la "causa del cambiamento" è zero, la grandezza non cambia: momento totale dei momenti nullo $arrow$ momento angolare costante (la pattinatrice); risultante delle forze nulla $arrow$ quantità di moto costante (un urto fra due corpi isolati). Sono due delle leggi di conservazione più importanti della fisica.
]

== Momento dell'impulso

#green-box([L'idea prima della formula])[
  L'*impulso* è il "lavoro nel tempo" di una forza: misura l'effetto complessivo di una forza che agisce per un certo intervallo, ed è ciò che fa cambiare la quantità di moto (utile soprattutto negli urti, dove forze grandi agiscono per tempi brevissimi). Esiste la versione rotatoria: integrando il momento della forza nel tempo si ottiene la variazione del momento angolare. Stessa logica, applicata alle rotazioni.
]

Il teorema dell'impulso già visto per la quantità di moto si scrive

$ vec(J)=integral_(t_1)^(t_2) vec(F) dif t=Delta vec(p). $

Per il momento angolare:

$ integral_(t_1)^(t_2) vec(tau)_O dif t=Delta vec(ell)_O. $

Se durante l'urto il vettore $vec(r)$ rispetto al polo può essere considerato costante,

$ integral_(t_1)^(t_2) (vec(r) times vec(F)) dif t
  =vec(r) times integral_(t_1)^(t_2) vec(F) dif t
  =vec(r) times vec(J). $

#yellow-box([Perché $vec(r)$ può uscire dall'integrale])[
  Durante un urto, che dura un tempo brevissimo, il corpo praticamente non si sposta: il vettore $vec(r)$ rispetto al polo resta (quasi) lo stesso. Una grandezza costante può uscire da un integrale, come una costante moltiplicativa. Qui esce dal prodotto vettoriale: $integral (vec(r) times vec(F)) dif t=vec(r) times integral vec(F) dif t$. Ma $integral_(t_1)^(t_2) vec(F) dif t$ è proprio l'impulso $vec(J)$. Quindi la variazione di momento angolare nell'urto è $vec(r) times vec(J)$: l'impulso "applicato a distanza $vec(r)$ dal polo" produce un cambiamento di rotazione.
]

= Pendolo semplice

#green-box([L'idea prima della formula])[
  Pensa all'altalena di un parco. La spingi di lato e poi la lasci andare: torna indietro, supera il punto più basso, sale dall'altra parte, e ricomincia. Va avanti e indietro con un ritmo regolare, sempre lo stesso. Un pendolo semplice è la versione "pulita" di questa situazione: una pallina pesante appesa a un filo che oscilla. Tutto quello che faremo qui serve a rispondere a due domande: *perché oscilla?* e *quanto tempo impiega a fare un'oscillazione completa?* L'idea chiave è che, quando la pallina è spostata di lato, la gravità la "tira giù", e questo la riporta verso il basso: è una forza di richiamo, come una molla nascosta.
]

Un pendolo semplice è formato da una massa puntiforme $m$ appesa a un filo ideale di lunghezza $ell$. Le forze sono la tensione $vec(T)$ del filo e il peso $m vec(g)$.

Il simbolo $ell$ è la lunghezza del filo (in metri); $m$ è la massa della pallina (in kg); $theta$ (theta) è l'angolo, misurato in radianti, tra il filo e la verticale. Quando $theta=0$ la pallina è nel punto più basso. "Filo ideale" significa che non ha massa e non si allunga: è solo un vincolo che tiene la pallina a distanza fissa $ell$ dal punto di sospensione.

#green-box([Perché solo due forze])[
  Sulla pallina agiscono soltanto due cose: il peso $m vec(g)$, che punta sempre verso il basso (la gravità), e la tensione $vec(T)$, cioè il "tiro" del filo, che è sempre diretto lungo il filo verso il punto da cui pende. Non c'è bisogno di inventare altre forze: il filo si limita a tirare, non spinge mai.
]

#align(center, graph-card([Pendolo semplice: forze e componenti], cetz.canvas({
  import cetz.draw: *
  // Pendolo reale: solo forze vere, senza componenti.
  line((0.55, 3.95), (2.75, 3.95), stroke: 1.1pt + ink)
  for i in range(0, 5) {
    line((0.75 + i*0.42, 4.05), (1.05 + i*0.42, 4.25), stroke: 0.75pt + ink)
  }
  circle((1.65, 3.95), radius: 0.07, fill: ink, stroke: none)
  line((1.65, 3.95), (1.65, 1.05), stroke: (paint: ink, thickness: 0.75pt, dash: "dashed"))
  line((1.65, 3.95), (3.03, 1.20), stroke: 1.2pt + ink)
  arc((1.65, 3.95), start: 270deg, stop: 297deg, radius: 0.72, stroke: 0.8pt + ink)
  arc((1.65, 1.05), start: 252deg, stop: 318deg, radius: 1.54, stroke: (paint: gold, thickness: 0.95pt, dash: "dashed"))
  circle((3.03, 1.20), radius: 0.17, fill: ink, stroke: none)
  line((3.03, 1.20), (2.42, 2.42), stroke: 1.25pt + blue, mark: (end: ">"))
  line((3.03, 1.20), (3.03, 0.25), stroke: 1.25pt + red, mark: (end: ">"))
  axis-label((1.90, 3.22), [$theta$], placement: "west")
  axis-label((2.45, 2.72), [$ell$], placement: "west")
  axis-label((2.32, 2.55), [$vec(T)$], placement: "east")
  axis-label((3.22, 0.34), [$m vec(g)$], placement: "west")

  // Diagramma delle forze: la massa è isolata dal filo.
  axis-label((6.55, 4.00), [diagramma forze], placement: "south")
  circle((6.65, 2.35), radius: 0.11, fill: ink, stroke: none)
  line((6.65, 2.35), (5.78, 3.45), stroke: 1.35pt + blue, mark: (end: ">"))
  line((6.65, 2.35), (6.65, 1.02), stroke: 1.35pt + red, mark: (end: ">"))
  axis-label((5.72, 3.52), [$vec(T)$], placement: "east")
  axis-label((6.85, 1.12), [$m vec(g)$], placement: "west")

  // Scomposizione del peso sugli assi locali.
  circle((2.15, -0.72), radius: 0.13, fill: ink, stroke: none)
  arc((1.10, -0.12), start: 215deg, stop: 320deg, radius: 1.18, stroke: (paint: ink, thickness: 0.85pt, dash: "dashed"))
  line((2.15, -0.72), (1.38, 0.33), stroke: 0.95pt + ink, mark: (end: ">"))
  line((2.15, -0.72), (3.10, 0.00), stroke: 0.95pt + ink, mark: (end: ">"))
  line((2.15, -0.72), (2.15, -1.82), stroke: 1.15pt + red, mark: (end: ">"))
  line((2.15, -0.72), (1.24, -1.42), stroke: 1.05pt + red, mark: (end: ">"))
  line((2.15, -0.72), (2.82, -1.62), stroke: 1.05pt + red, mark: (end: ">"))
  arc((2.15, -1.26), start: 270deg, stop: 306deg, radius: 0.28, stroke: 0.7pt + ink)
  axis-label((1.30, 0.40), [$y$ radiale], placement: "east")
  axis-label((3.18, 0.05), [$x$ tangenziale], placement: "west")
  axis-label((2.34, -1.78), [$m vec(g)$], placement: "west")
  axis-label((0.98, -1.42), [$m g sin theta$], placement: "east")
  axis-label((2.92, -1.60), [$m g cos theta$], placement: "west")
  axis-label((2.36, -1.34), [$theta$], placement: "west")
})))

#green-box([Perché scomponiamo in radiale e tangenziale])[
  La pallina si muove lungo un arco di cerchio, non in linea retta. Conviene allora guardare il moto da due punti di vista "locali", che cambiano insieme alla pallina: una direzione *lungo il filo* (radiale) e una direzione *lungo l'arco*, perpendicolare al filo (tangenziale). Perché proprio queste? Perché lungo il filo la pallina non può allontanarsi né avvicinarsi (il filo la blocca), mentre lungo l'arco è libera di muoversi: è lì che avviene l'oscillazione. Separando le due direzioni, possiamo studiare il moto vero (tangenziale) senza farci confondere dalla tensione del filo (radiale).
]

Scomponiamo il moto lungo due direzioni locali:

- asse *radiale* $y$, lungo il filo verso il punto di sospensione;
- asse *tangenziale* $x$, lungo l'arco di traiettoria.

Le accelerazioni sono

$ a_y=v^2/ell, quad a_x=ell (dif^2 theta)/(dif t^2). $

#yellow-box([Da dove vengono queste due accelerazioni])[
  - $a_y=v^2\/ell$ è l'*accelerazione centripeta*: ogni corpo che gira lungo un cerchio di raggio $ell$ con velocità $v$ ha un'accelerazione $v^2\/ell$ diretta verso il centro. È la stessa formula del moto circolare. Non c'è bisogno che il moto sia uniforme: a ogni istante, la parte di accelerazione "che curva la traiettoria" vale $v^2\/ell$.
  - $a_x=ell (dif^2 theta)\/(dif t^2)$ è l'accelerazione lungo l'arco. Vale così perché la posizione lungo l'arco è $s=ell theta$ (lunghezza dell'arco = raggio × angolo). Derivando due volte rispetto al tempo, e ricordando che $ell$ è costante, la lunghezza dell'arco accelera come $ell$ moltiplicato per l'accelerazione angolare $(dif^2 theta)\/(dif t^2)$.
]

Lungo la direzione radiale (cioè lungo il filo) usiamo la seconda legge di Newton, $F=m a$, prendendo come accelerazione quella centripeta $v^2\/ell$. Le forze in questa direzione sono la tensione $T$ (che tira verso l'alto, verso il centro) e la componente del peso lungo il filo, $m g cos theta$ (che tira verso il basso, via dal centro):

$ T-m g cos theta=m v^2/ell. $

#yellow-box([Perché compare $cos theta$ e non $sin theta$])[
  Il peso $m vec(g)$ punta dritto verso il basso, ma il filo è inclinato di un angolo $theta$. Per sapere "quanta parte" del peso va lungo il filo, lo proiettiamo su quella direzione. La proiezione lungo il filo (radiale) è $m g cos theta$, mentre quella lungo l'arco (tangenziale) è $m g sin theta$. Controllo veloce con $theta=0$ (pallina in basso, filo verticale): $cos 0=1$ quindi tutto il peso è lungo il filo ($m g$), e $sin 0=0$ quindi non c'è spinta lungo l'arco. Tutto torna: in fondo alla traiettoria il peso tira solo il filo e non spinge di lato.
]

Lungo la direzione tangenziale (lungo l'arco) la tensione non conta (è perpendicolare), e l'unica spinta è la componente del peso $m g sin theta$. Questa è la *forza di richiamo*: la riportiamo con il segno meno perché tende sempre a riportare la pallina verso il basso, cioè verso $theta=0$, opponendosi allo spostamento:

$ -m g sin theta=m ell (dif^2 theta)/(dif t^2). $

#yellow-box([Perché il segno meno])[
  Se la pallina è spostata a destra ($theta>0$), la gravità la spinge verso sinistra, cioè verso angoli più piccoli. Forza e spostamento hanno verso opposto: ecco il segno meno. È esattamente il comportamento di una molla, che richiama sempre verso il punto di equilibrio. Questo segno meno è ciò che farà oscillare il pendolo invece di farlo scappare via.
]

Dividendo entrambi i membri per $m ell$ (operazione lecita perché $m ell eq.not 0$) il termine di sinistra diventa $-(g\/ell) sin theta$ e quello di destra $(dif^2 theta)\/(dif t^2)$. Portando tutto a sinistra si ottiene l'equazione differenziale del pendolo:

$ (dif^2 theta)/(dif t^2)+g/ell sin theta=0. $

#blue-box([Cosa ci dice questa equazione])[
  È una legge che lega l'accelerazione angolare (come cambia la rapidità di rotazione) all'angolo $theta$ in quel momento. Non si risolve con formule elementari così com'è, a causa del $sin theta$: per questo nel prossimo paragrafo faremo un'approssimazione per angoli piccoli, che la trasforma in qualcosa di familiare e risolvibile.
]

== Piccole oscillazioni

#green-box([L'idea prima della formula])[
  L'equazione del pendolo è "scomoda" per via del $sin theta$. Ma c'è un trucco: se la pallina oscilla poco (angoli piccoli, diciamo entro 10-15 gradi), allora $sin theta$ è quasi uguale a $theta$ stesso. È come dire che, vicino al punto più basso, l'arco e la sua proiezione si confondono. Con questa semplificazione l'equazione diventa identica a quella di una *molla* (oscillatore armonico), che sappiamo già risolvere. Da qui ricaviamo il ritmo regolare dell'oscillazione.
]

Per angoli piccoli, misurati in radianti,

$ sin theta approx theta. $

#yellow-box([Perché $sin theta approx theta$ (e perché in radianti)])[
  Per angoli piccoli, in radianti, il seno di un angolo è quasi uguale all'angolo stesso. Qualche numero concreto: $sin(#[0,1])=0,0998...$ contro $theta=0,1$ (errore dello 0,2%); $sin(#[0,2])=0,1987...$ contro $0,2$ (errore dello 0,7%). L'accordo è ottimo finché $theta$ resta piccolo. *Attenzione*: vale solo se $theta$ è in radianti, non in gradi. È per questo che in fisica gli angoli si misurano sempre in radianti: solo così questa approssimazione (e tante altre formule) funziona.
]

Sostituendo $sin theta approx theta$ nell'equazione del pendolo, il termine $(g\/ell) sin theta$ diventa $(g\/ell) theta$, e l'equazione del pendolo diventa quella di un oscillatore armonico:

$ (dif^2 theta)/(dif t^2)+g/ell theta=0. $

#yellow-box([Perché il confronto con $theta''+omega^2 theta=0$])[
  L'oscillatore armonico è un "modello standard" che descrive tutto ciò che oscilla con ritmo costante (molle, pendoli, vibrazioni). La sua equazione tipo è $theta''+omega^2 theta=0$, dove $theta''$ è una scrittura abbreviata per $(dif^2 theta)\/(dif t^2)$ (la derivata seconda nel tempo). La nostra equazione ha esattamente questa forma, con il ruolo di $omega^2$ giocato dal coefficiente $g\/ell$. Quindi basta confrontare i due coefficienti per leggere subito la pulsazione, senza rifare alcun calcolo.
]

Confrontando con $theta''+omega^2 theta=0$ (basta uguagliare il coefficiente che moltiplica $theta$):

$ omega^2=g/ell, quad omega=sqrt(g/ell). $

#blue-box([Significato di $omega$ e controllo dimensionale])[
  $omega$ (omega) si chiama *pulsazione* e si misura in $"rad"\/"s"$. Dice quanto velocemente avanza l'oscillazione. Controllo delle unità: $g$ è in $"m"\/"s"^2$ ed $ell$ in $"m"$, quindi $g\/ell$ è in $1\/"s"^2$, e la radice quadrata dà $1\/"s"$, cioè $"rad"\/"s"$ (i radianti sono adimensionali). Tutto coerente. Nota che $omega$ dipende solo da $g$ ed $ell$: la massa $m$ è sparita! Una pallina pesante e una leggera, appese a fili uguali, oscillano con lo stesso ritmo.
]

Qui $omega$ è la *pulsazione* delle piccole oscillazioni: misura quanto rapidamente procede l'oscillazione nel tempo e si esprime in $"rad"/"s"$. Non è la velocità angolare di un moto circolare della massa, ma il parametro dell'oscillazione armonica approssimata.

Il periodo delle piccole oscillazioni è

#green-box([Periodo del pendolo semplice])[
  $ T_"periodo"=2 pi/omega=2 pi sqrt(ell/g). $
]

#yellow-box([Perché $T=2 pi\/omega$])[
  Un'oscillazione completa corrisponde a percorrere un giro intero della "ruota" dell'oscillazione, cioè un angolo di fase pari a $2 pi$ radianti. Siccome $omega$ dice quanti radianti di fase si accumulano ogni secondo, il tempo per accumularne $2 pi$ è $T=2 pi\/omega$. Sostituendo $omega=sqrt(g\/ell)$ e ricordando che dividere per una radice equivale a moltiplicare per la radice "rovesciata", si ottiene $T=2 pi sqrt(ell\/g)$. Il periodo $T$ si misura in secondi.
]

#purple-box([Esempio numerico])[
  Un pendolo lungo $ell=1 " m"$, sulla Terra dove $g=9,8 " m/s"^2$. Il periodo delle piccole oscillazioni è
  $ T=2 pi sqrt(ell/g)=2 pi sqrt((1)/(#[9,8]))=2 pi dot 0,319 approx 2,0 " s". $
  Quindi questo pendolo impiega circa $2$ secondi per andare e tornare. Per dimezzare il periodo (renderlo più "veloce") non basta cambiare la massa: bisogna accorciare il filo. Dato che $T$ dipende da $sqrt(ell)$, per dimezzare il periodo dovremmo dividere la lunghezza per $4$, cioè usare $ell=0,25 " m"$.
]

La legge oraria può essere scritta nella forma

$ theta(t)=theta_0 sin(omega t+phi). $

#yellow-box([Come leggere la legge oraria])[
  Questa formula dice dove si trova l'angolo $theta$ a ogni istante $t$. Il valore $theta_0$ è l'*ampiezza*, cioè l'angolo massimo raggiunto (di quanto si scosta al massimo dalla verticale). Il termine $omega t+phi$ è la *fase*: cresce nel tempo e fa oscillare il seno tra $-1$ e $+1$, quindi $theta$ oscilla tra $-theta_0$ e $+theta_0$. La costante $phi$ (fase iniziale) serve solo a "sincronizzare" la formula con l'istante in cui hai iniziato a cronometrare.
]

#yellow-box([Isocronismo delle piccole oscillazioni])[
  Nel limite di piccoli angoli il periodo non dipende dall'ampiezza iniziale, ma solo da $ell$ e da $g$. In pratica: se sposti il pendolo di $5$ gradi o di $10$ gradi, impiega comunque lo stesso tempo per oscillare. Questa proprietà sorprendente (scoperta da Galileo) è ciò che ha reso il pendolo il cuore degli orologi per secoli.
]

#red-box([Attenzione: vale solo per piccoli angoli])[
  L'isocronismo e la formula $T=2 pi sqrt(ell\/g)$ valgono solo finché l'angolo resta piccolo. Se lanci il pendolo con un'ampiezza grande (per esempio $60$ gradi), $sin theta$ non è più vicino a $theta$, il periodo aumenta un po', e dipende dall'ampiezza. Non applicare queste formule a oscillazioni ampie.
]

= Dinamica dei sistemi di punti materiali

#green-box([L'idea prima della formula])[
  Finora abbiamo studiato un corpo solo. Ma il mondo è fatto di tanti corpi che interagiscono: due palle da biliardo, i frammenti di un fuoco d'artificio, il Sole con i pianeti, le molecole di un gas. Studiarli uno per uno sarebbe un incubo. L'idea geniale è: invece di seguire ogni singolo pezzo, troviamo poche grandezze "complessive" del gruppo intero (la quantità di moto totale, il centro di massa, l'energia totale) che obbediscono a regole semplici. La scoperta più bella sarà che le forze che i pezzi si scambiano tra loro (forze interne) *si cancellano a vicenda* e non influenzano affatto il movimento globale del gruppo. Solo le forze che arrivano da fuori contano per il moto d'insieme.
]

Un sistema di punti materiali è un insieme di particelle considerate insieme. Le forze agenti su una particella del sistema si dividono in:

- *forze esterne*, dovute a corpi esterni al sistema;
- *forze interne*, dovute all'interazione con le altre particelle del sistema.

#green-box([Interne vs esterne: come distinguerle])[
  La distinzione dipende da come *tu* disegni il confine del sistema. Tutto quello che è dentro il confine è "il sistema"; le forze tra due pezzi interni sono *interne*, le forze che arrivano da fuori il confine sono *esterne*. Esempio: se il sistema sono due pattinatori che si spingono a vicenda, la spinta tra loro è interna; la gravità della Terra e l'attrito del ghiaccio sono esterne. Cambiando il confine (per esempio includendo anche la Terra) la stessa forza può diventare interna. È una scelta di comodo, non una proprietà fisica fissa.
]

Le forze interne possono essere elastiche, gravitazionali, elettriche, magnetiche, dovute a deformazioni o attriti; possono quindi essere conservative oppure non conservative.

Per la particella $i$ vale la seconda legge di Newton: la somma di tutte le forze su quella particella (la parte esterna più la parte interna) è uguale a massa per accelerazione:

$ vec(F)_(i,"tot")=vec(F)_i^"ext"+vec(F)_i^"int"=m_i vec(a)_i. $

Qui l'indice $i$ è un'etichetta che numera le particelle ($i=1, 2, 3, ...$): $m_i$ è la massa della particella $i$-esima, $vec(a)_i$ la sua accelerazione, e così via. La freccia sopra il simbolo, come in $vec(r)$, ricorda che sono vettori (hanno direzione e verso, non solo un valore).

#align(center, graph-card([Sistema di punti materiali], cetz.canvas({
  import cetz.draw: *
  circle((2.0, 1.65), radius: 1.2, stroke: 1.15pt + ink)
  axis-label((1.02, 2.85), [sistema], placement: "south")
  circle((1.45, 1.35), radius: 0.08, fill: ink, stroke: none)
  circle((2.15, 2.05), radius: 0.08, fill: ink, stroke: none)
  circle((2.62, 1.42), radius: 0.08, fill: ink, stroke: none)
  circle((1.85, 1.05), radius: 0.11, fill: ink, stroke: none)
  axis-label((1.98, 1.16), [$m_i$], placement: "west")
  line((1.85, 1.05), (1.35, 1.62), stroke: 1.1pt + green, mark: (end: ">"))
  line((1.85, 1.05), (2.35, 1.74), stroke: 1.1pt + green, mark: (end: ">"))
  line((1.85, 1.05), (1.70, 0.30), stroke: 1.15pt + red, mark: (end: ">"))
  axis-label((1.22, 1.70), [$vec(F)^"int"$], placement: "east")
  axis-label((2.44, 1.84), [$vec(F)^"int"$], placement: "west")
  axis-label((1.62, 0.25), [$vec(F)^"ext"$], placement: "east")
  axis-label((5.25, 2.50), [interne: tra punti del sistema], placement: "west")
  axis-label((5.25, 1.90), [esterne: dall'ambiente], placement: "west")
  axis-label((5.25, 1.30), [$vec(F)_(i,"tot")=vec(F)_i^"ext"+vec(F)_i^"int"$], placement: "west")
})))

== Risultante delle forze interne

#green-box([L'idea prima della formula])[
  Immagina due persone in piedi su un carrello, che si spingono mano contro mano. La prima spinge la seconda, ma per la terza legge di Newton la seconda spinge la prima con la stessa forza nel verso opposto. Le due spinte sono uguali e contrarie: se le sommi, fanno zero. Questo vale per *ogni* coppia di pezzi del sistema. Quindi, sommando tutte le forze interne dell'intero sistema, ogni spinta trova la sua "controspinta" e tutto si annulla. È per questo che non puoi sollevarti tirandoti per i capelli: le forze interne non spostano il gruppo.
]

Per ogni coppia di particelle $i,j$ vale il principio di azione e reazione (terza legge di Newton): la forza che $i$ esercita su $j$ è uguale e opposta a quella che $j$ esercita su $i$:

$ vec(F)_(i j)=-vec(F)_(j i). $

Qui $vec(F)_(i j)$ va letta come "forza esercitata su $i$ da parte di $j$". Il segno meno dice che le due forze hanno stesso modulo ma verso opposto.

Le forze interne si cancellano a coppie nella somma su tutto il sistema, quindi

#green-box([Risultante interna nulla])[
  $ vec(R)^"int"=sum_i vec(F)_i^"int"=vec(0). $
]

Il simbolo $sum_i$ (sigma) significa "somma su tutte le particelle". $vec(R)^"int"$ è la *risultante*, cioè il vettore somma di tutte le forze interne; il risultato $vec(0)$ è il vettore nullo (lunghezza zero).

Questo non significa che le forze interne non esistano: possono deformare il sistema, produrre attrito interno o cambiare l'energia interna. Significa solo che non accelerano il centro di massa del sistema nel suo insieme.

#align(center, graph-card([Forze interne: cancellazione a coppie], cetz.canvas({
  import cetz.draw: *
  circle((1.55, 1.35), radius: 0.13, fill: ink, stroke: none)
  circle((4.55, 1.35), radius: 0.13, fill: ink, stroke: none)
  line((1.55, 1.35), (2.95, 1.35), stroke: 1.2pt + green, mark: (end: ">"))
  line((4.55, 1.35), (3.15, 1.35), stroke: 1.2pt + green, mark: (end: ">"))
  axis-label((1.42, 1.08), [$m_i$], placement: "north")
  axis-label((4.68, 1.08), [$m_j$], placement: "north")
  axis-label((2.28, 1.58), [$vec(F)_(j i)$], placement: "south")
  axis-label((3.82, 1.58), [$vec(F)_(i j)$], placement: "south")
  axis-label((3.05, 0.65), [$vec(F)_(i j)=-vec(F)_(j i)$], placement: "north")
})))

== Grandezze della singola particella

Per ogni particella $i$ del sistema si definiscono la sua posizione $vec(r)_i$, la sua velocità $vec(v)_i$ e la sua accelerazione $vec(a)_i$ (data dalla forza diviso la massa, cioè la seconda legge di Newton riscritta):

$ vec(r)_i quad vec(v)_i quad vec(a)_i=(vec(F)_i)/(m_i). $

La quantità di moto, il momento angolare rispetto al polo $O$ e l'energia cinetica della particella sono:

$ vec(p)_i=m_i vec(v)_i, $

$ vec(ell)_i=vec(r)_i times m_i vec(v)_i, $

$ E_(k,i)=1/2 m_i v_i^2. $

#green-box([La quantità di moto: cos'è davvero])[
  La quantità di moto $vec(p)=m vec(v)$ è "quanto moto" porta con sé un corpo: combina quanto è pesante (massa) e quanto va veloce (velocità). Un camion lento e una pallina veloce possono avere la stessa quantità di moto. È la grandezza giusta per descrivere gli urti, perché misura "lo slancio" che un corpo trasmette quando colpisce qualcosa. Si misura in $"kg" dot "m"\/"s"$.
]

#green-box([Il momento angolare: perché $vec(r) times m vec(v)$])[
  Il *momento angolare* misura "quanto un corpo sta girando attorno a un punto $O$ scelto da noi (il polo)". È l'analogo della quantità di moto, ma per le rotazioni. Perché c'è un prodotto vettoriale $vec(r) times m vec(v)$? Pensa a una giostra: per metterla in rotazione conta sia *quanto velocemente* va il corpo ($m vec(v)$, la sua quantità di moto), sia *quanto è lontano dal centro* ($vec(r)$, il braccio). Un bambino lontano dal centro di una giostra contribuisce di più alla rotazione di uno vicino al perno, anche andando alla stessa velocità.

  Il prodotto vettoriale "$times$" cattura esattamente questo: il suo modulo vale $r dot m v dot sin alpha$, dove $alpha$ è l'angolo tra $vec(r)$ e $vec(v)$. Conta solo la parte di velocità *perpendicolare* al raggio (quella che fa girare davvero); la parte di velocità diretta verso $O$ o via da $O$ non fa ruotare nulla, e infatti viene azzerata dal $sin alpha$ (se $vec(v)$ è parallela a $vec(r)$, $alpha=0$ e $sin 0 = 0$). La *direzione* del vettore risultante è perpendicolare al piano della rotazione (regola della mano destra) e indica l'asse attorno a cui il corpo gira. Si misura in $"kg" dot "m"^2\/"s"$.
]

#yellow-box([Perché il momento angolare dipende dal polo $O$])[
  A differenza della quantità di moto, il momento angolare cambia se cambi il punto $O$ rispetto a cui lo calcoli, perché $vec(r)_i$ è la posizione *misurata da $O$*. Quindi va sempre dichiarato rispetto a quale polo. È come chiedere "quanto gira?": la risposta dipende da rispetto a quale centro lo guardi. Un'auto che va dritta non gira attorno a un punto sulla sua traiettoria, ma "gira" (ha momento angolare) rispetto a un punto fuori dalla strada.
]

Le corrispondenti grandezze del sistema sono le somme sulle particelle (si sommano i contributi di tutti i pezzi):

$ vec(P)=sum_i m_i vec(v)_i, quad
   vec(ell)=sum_i vec(r)_i times m_i vec(v)_i, quad
   E_k=sum_i 1/2 m_i v_i^2. $

Le lettere maiuscole ($vec(P)$, $vec(ell)$, $E_k$ senza indice) indicano le grandezze *totali* del sistema, ottenute sommando quelle delle singole particelle.

== Centro di massa

#green-box([L'idea prima della formula])[
  Il *centro di massa* è il "punto di equilibrio" del sistema: il punto in cui potresti pensare concentrata tutta la massa. Per un righello uniforme è il centro; per un martello, sta vicino alla testa pesante (non al centro geometrico). È il punto su cui il sistema resta in equilibrio se lo appoggi su un dito. La cosa straordinaria è che questo punto si muove come se fosse una singola particella di massa $M$ su cui agiscono solo le forze esterne: il caos interno dei singoli pezzi non lo riguarda. È il "rappresentante ufficiale" dell'intero sistema.
]

La massa totale del sistema è la somma di tutte le masse:

$ M=sum_i m_i. $

Il *centro di massa* è il punto geometrico definito da

#blue-box([Centro di massa])[
  $ vec(r)_"CM"=(sum_i m_i vec(r)_i)/(sum_i m_i)=(1/M) sum_i m_i vec(r)_i. $
]

#yellow-box([Come leggere questa formula: è una media pesata])[
  È semplicemente la *media delle posizioni*, ma pesata sulla massa. Ogni particella "vota" per la posizione del centro di massa con un peso proporzionale alla propria massa: i pezzi pesanti tirano il centro di massa verso di sé più di quelli leggeri. Il numeratore $sum_i m_i vec(r)_i$ somma le posizioni moltiplicate per le rispettive masse, e dividere per la massa totale $M$ è ciò che la rende una media (se tutte le masse fossero uguali, sarebbe la media geometrica normale delle posizioni).
]

#purple-box([Esempio numerico: due masse su una retta])[
  Due masse su un asse $x$: $m_1=2 " kg"$ in $x_1=0 " m"$ e $m_2=6 " kg"$ in $x_2=4 " m"$. Il centro di massa è
  $ x_"CM"=(m_1 x_1+m_2 x_2)/(m_1+m_2)=(2 dot 0+6 dot 4)/(2+6)=(24)/(8)=3 " m". $
  Nota che il centro di massa ($3 " m"$) è molto più vicino alla massa grande ($6 " kg"$ in $4 " m"$) che a quella piccola: la massa pesante lo "tira" verso di sé, come previsto. Non sta nel mezzo geometrico ($2 " m"$), ma spostato verso il corpo più massiccio.
]

Per trovare la velocità con cui si muove il centro di massa, deriviamo la sua posizione rispetto al tempo. Siccome le masse $m_i$ sono costanti, la derivata "entra" nella somma e agisce solo sulle posizioni $vec(r)_i$, trasformandole nelle velocità $vec(v)_i$:

$ vec(v)_"CM"=(dif vec(r)_"CM")/(dif t)
  =(1/M) sum_i m_i vec(v)_i
  =vec(P)/M. $

#yellow-box([Perché spunta $vec(P)$])[
  Nell'ultimo passaggio abbiamo riconosciuto che $sum_i m_i vec(v)_i$ è esattamente la definizione della quantità di moto totale $vec(P)$ vista prima. Quindi $vec(v)_"CM"=vec(P)\/M$: la velocità del centro di massa è la quantità di moto totale divisa per la massa totale.
]

Quindi la quantità di moto totale del sistema può essere scritta come

$ vec(P)=M vec(v)_"CM". $

#blue-box([Un risultato chiave])[
  Tutto il sistema, per quanto riguarda la quantità di moto, si comporta come *un'unica particella* di massa $M$ posta nel centro di massa e che si muove con velocità $vec(v)_"CM"$. Questa è la frase che useremo in continuazione da qui in poi.
]

#align(center, graph-card([Centro di massa e velocità del sistema], cetz.canvas({
  import cetz.draw: *
  circle((2.25, 1.65), radius: 1.25, stroke: 1.1pt + ink)
  for p in ((1.60, 1.30), (1.95, 2.25), (2.45, 1.95), (2.80, 1.20), (1.45, 1.80), (2.22, 0.95)) {
    circle(p, radius: 0.07, fill: ink, stroke: none)
  }
  circle((2.20, 1.58), radius: 0.11, fill: red, stroke: none)
  line((2.20, 1.58), (3.45, 1.58), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((2.02, 1.38), [CM], placement: "north")
  axis-label((3.52, 1.63), [$vec(v)_"CM"$], placement: "west")
  axis-label((5.45, 2.25), [$vec(r)_"CM"=(1/M) sum_i m_i vec(r)_i$], placement: "west")
  axis-label((5.45, 1.45), [$vec(P)=M vec(v)_"CM"$], placement: "west")
})))

== Teorema del moto del centro di massa

Deriviamo ancora una volta rispetto al tempo: dalla velocità del centro di massa passiamo alla sua accelerazione. Di nuovo la derivata entra nella somma, trasformando le velocità $vec(v)_i$ in accelerazioni $vec(a)_i$; poi usiamo $m_i vec(a)_i=vec(F)_i^"int"+vec(F)_i^"ext"$ (Newton applicato a ogni particella):

$ vec(a)_"CM"=(1/M) sum_i m_i vec(a)_i
  =(1/M) sum_i (vec(F)_i^"int"+vec(F)_i^"ext"). $

Poiché la somma delle forze interne è nulla, $sum_i vec(F)_i^"int"=vec(0)$ (lo abbiamo dimostrato prima con azione e reazione), quel pezzo sparisce e resta solo la risultante delle forze esterne:

#purple-box([Moto del centro di massa])[
  $ M vec(a)_"CM"=vec(R)^"ext"=(dif vec(P))/(dif t). $
]

#green-box([Il senso profondo di questo teorema])[
  Questa è una delle equazioni più importanti della meccanica. Dice: il centro di massa di qualunque sistema, per quanto complicato, si muove esattamente come una singola particella di massa $M$ spinta solo dalle forze esterne. Tutta la complicazione interna (urti tra i pezzi, deformazioni, esplosioni) non sposta di un millimetro la traiettoria del centro di massa. È la formula $vec(F)=M vec(a)$ promossa dal singolo corpo all'intero sistema.
]

Il moto del centro di massa è determinato soltanto dalle forze esterne. Le forze interne possono cambiare il moto relativo delle parti, ma non il moto complessivo del centro di massa.

== Esempio: frammentazione in caduta

#green-box([L'idea prima della formula])[
  Pensa a un fuoco d'artificio che esplode in cielo, oppure a una granata che scoppia mentre vola. I frammenti schizzano in tutte le direzioni: ma l'esplosione è fatta di *forze interne*. Quindi, per il teorema appena visto, il centro di massa se ne infischia dell'esplosione e continua a cadere lungo la stessa identica parabola che avrebbe seguito il corpo intero. Se potessi calcolare in ogni istante il punto medio (pesato) di tutti i frammenti, lo vedresti tracciare tranquillamente la parabola del proiettile originale.
]

Se un corpo esplode o si frammenta mentre cade, i pezzi possono seguire traiettorie diverse per effetto delle forze interne. Tuttavia, se l'unica forza esterna è il peso totale, mettiamo $vec(F)_i^"ext"=m_i vec(g)$ per ogni pezzo nel teorema del centro di massa:

$ M vec(a)_"CM"=sum_i m_i vec(g)=M vec(g), $

#yellow-box([Perché $sum_i m_i vec(g)=M vec(g)$])[
  La gravità $vec(g)$ è la stessa per tutti i frammenti, quindi possiamo raccoglierla a fattor comune fuori dalla somma: $sum_i m_i vec(g)=(sum_i m_i) vec(g)=M vec(g)$. Dividendo poi entrambi i membri per $M$ si ottiene $vec(a)_"CM"=vec(g)$: il centro di massa accelera verso il basso esattamente come un sasso in caduta libera, indipendentemente dall'esplosione.
]

quindi il centro di massa segue la stessa traiettoria che avrebbe seguito il corpo se non si fosse frammentato.

#align(center, graph-card([Il centro di massa segue il moto imposto dalle forze esterne], cetz.canvas({
  import cetz.draw: *
  line((0.75, 3.00), (1.25, 2.55), (1.80, 2.12), (2.45, 1.72), (3.25, 1.35), (4.10, 1.08), stroke: (paint: ink, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  line((1.25, 2.55), (1.65, 2.90), (2.25, 3.02), (2.95, 2.86), stroke: 1.0pt + green, mark: (end: ">"))
  line((1.25, 2.55), (1.35, 2.00), (1.80, 1.38), (2.50, 0.92), stroke: 1.0pt + green, mark: (end: ">"))
  line((1.25, 2.55), (1.95, 2.45), (2.78, 2.18), (3.55, 1.78), stroke: 1.0pt + green, mark: (end: ">"))
  circle((1.25, 2.55), radius: 0.09, fill: ink, stroke: none)
  circle((2.45, 1.72), radius: 0.09, fill: red, stroke: none)
  line((3.85, 2.95), (3.85, 2.15), stroke: 1.2pt + red, mark: (end: ">"))
  axis-label((2.62, 1.82), [CM], placement: "west")
  axis-label((3.95, 2.22), [$M vec(g)$], placement: "west")
  axis-label((2.25, 0.58), [traiettorie dei frammenti], placement: "north")
  axis-label((4.55, 1.05), [traiettoria del CM], placement: "west")
})))

== Conservazione della quantità di moto

#green-box([L'idea prima della formula])[
  Dal teorema del centro di massa sappiamo che $dif vec(P)\/dif t=vec(R)^"ext"$: la quantità di moto totale cambia solo se c'è una spinta da *fuori*. Allora la conseguenza è immediata: se non arriva nessuna spinta esterna (o se le spinte esterne si bilanciano), la quantità di moto totale *non può cambiare*. Resta congelata. Questo è il motivo per cui, quando due pattinatori fermi si spingono, partono in direzioni opposte in modo che gli "slanci" si compensino: prima la quantità di moto totale era zero, e zero deve restare.
]

Se il sistema è isolato rispetto alle traslazioni, cioè se la risultante delle forze esterne è nulla,

$ vec(R)^"ext"=vec(0), $

allora, sostituendo nel teorema del centro di massa $dif vec(P)\/dif t=vec(R)^"ext"=vec(0)$, otteniamo che la quantità di moto totale non varia nel tempo:

#green-box([Quantità di moto totale conservata])[
  $ (dif vec(P))/(dif t)=vec(0) quad arrow quad vec(P)="costante". $
]

#blue-box([Cosa vuol dire "costante" per un vettore])[
  $vec(P)="costante"$ significa che il vettore non cambia né in modulo né in direzione: tre numeri (le componenti $P_x$, $P_y$, $P_z$) restano fissi durante tutto il processo. In pratica negli esercizi si scrive $vec(P)_"prima"=vec(P)_"dopo"$ e si lavora componente per componente. È lo strumento numero uno per risolvere gli urti.
]

Poiché $vec(P)=M vec(v)_"CM"$, se anche la massa totale è costante allora la velocità del centro di massa è costante e la sua accelerazione è nulla:

$ vec(v)_"CM"="costante", quad vec(a)_"CM"=vec(0). $

Il centro di massa di un sistema isolato si muove in linea retta a velocità costante (o resta fermo), qualunque cosa accada internamente.

== Momento angolare del sistema

#green-box([L'idea prima della formula])[
  Per le rotazioni esiste una storia parallela a quella della quantità di moto. Là, la quantità di moto cambiava solo per effetto di forze esterne; qui, il momento angolare (quanto il sistema gira) cambia solo per effetto del *momento delle forze esterne*. E come prima, le forze interne si annullano: non possono mettere in rotazione il sistema da sole. Risultato: se nessun momento esterno agisce, il sistema conserva il suo momento angolare. È il principio per cui una pattinatrice che chiude le braccia gira più veloce: non c'è momento esterno, quindi il momento angolare resta costante.
]

Rispetto a un polo $O$, il momento angolare totale del sistema è la somma dei momenti angolari delle singole particelle:

$ vec(ell)_O=sum_i vec(r)_i times m_i vec(v)_i. $

Per vedere come cambia nel tempo, lo deriviamo. Se il polo $O$ è fisso in un sistema inerziale, la derivata produce $sum_i vec(r)_i times m_i vec(a)_i$, e poi sostituiamo $m_i vec(a)_i=vec(F)_i^"ext"+vec(F)_i^"int"$ (Newton):

$ (dif vec(ell)_O)/(dif t)=sum_i vec(r)_i times m_i vec(a)_i
  =sum_i vec(r)_i times (vec(F)_i^"ext"+vec(F)_i^"int"). $

#yellow-box([Perché derivando sparisce un termine])[
  Derivando $vec(ell)_O=sum_i vec(r)_i times m_i vec(v)_i$ con la regola del prodotto si otterrebbero due pezzi: $(dif vec(r)_i\/dif t) times m_i vec(v)_i$ e $vec(r)_i times m_i vec(a)_i$. Ma $dif vec(r)_i\/dif t=vec(v)_i$, e il prodotto vettoriale di un vettore *con sé stesso* (qui $vec(v)_i times vec(v)_i$, perché sono paralleli) è zero. Quindi il primo pezzo svanisce e resta solo $sum_i vec(r)_i times m_i vec(a)_i$. Questo è il motivo per cui la formula è così pulita.
]

#green-box([Il momento di una forza: perché $vec(r) times vec(F)$])[
  Il termine $vec(r)_i times vec(F)_i$ si chiama *momento della forza* (o torque, $vec(tau)$): misura la capacità di una forza di *far ruotare* qualcosa attorno al polo. Perché di nuovo un prodotto vettoriale? Pensa a una porta: per aprirla, spingere lontano dai cardini (braccio $vec(r)$ grande) è molto più efficace che spingere vicino. E spingere *perpendicolarmente* alla porta funziona, mentre spingere *verso* i cardini non la apre affatto. Il momento $vec(r) times vec(F)$ ha modulo $r dot F dot sin alpha$: cattura sia il braccio $r$, sia la sola componente di forza perpendicolare (tramite $sin alpha$). Se spingi lungo la direzione del braccio ($alpha=0$), $sin 0=0$ e non ruoti nulla, esattamente come spingere una porta verso i cardini. È lo stesso schema visto per il momento angolare, applicato alle forze.
]

Il momento totale delle forze interne è nullo quando le forze interne sono *centrali*, cioè dirette lungo la congiungente tra le due particelle. Infatti, per una coppia $i,j$, usando $vec(F)_(j i)=-vec(F)_(i j)$ e raccogliendo:

$ vec(r)_i times vec(F)_(i j)+vec(r)_j times vec(F)_(j i)
  =(vec(r)_i-vec(r)_j) times vec(F)_(i j)=vec(0). $

#yellow-box([Perché questo prodotto vettoriale è zero])[
  Il vettore $vec(r)_i-vec(r)_j$ è la congiungente tra le due particelle (va da $j$ a $i$). Se la forza interna $vec(F)_(i j)$ è *centrale*, cioè diretta proprio lungo questa congiungente, allora i due vettori sono *paralleli*. E il prodotto vettoriale di due vettori paralleli è sempre nullo (l'angolo tra loro è $0$, e $sin 0=0$). Conclusione: coppie di forze interne centrali non producono alcun momento totale. Proprio come la risultante interna era nulla, anche il momento interno totale è nullo.
]

Rimane quindi il momento delle sole forze esterne, indicato con $vec(tau)^"ext"_O$:

#purple-box([Momento angolare di un sistema, polo fisso])[
  $ (dif vec(ell)_O)/(dif t)=vec(tau)^"ext"_O. $
]

Questa è la "seconda legge di Newton delle rotazioni": il momento esterno è ciò che fa variare il momento angolare. Se $vec(tau)^"ext"_O=vec(0)$ (nessun momento esterno), allora il momento angolare si conserva:

$ vec(ell)_O="costante". $

#purple-box([Esempio: la pattinatrice])[
  Una pattinatrice gira su sé stessa con le braccia aperte. La gravità e la reazione del ghiaccio passano (idealmente) per l'asse di rotazione, quindi il loro momento è nullo: $vec(tau)^"ext"=vec(0)$ e $vec(ell)$ si conserva. Quando chiude le braccia, avvicina la massa all'asse: i raggi $r$ diminuiscono. Perché $vec(ell)=sum_i vec(r)_i times m_i vec(v)_i$ resti costante con $r$ più piccoli, la velocità deve aumentare: ecco perché gira più in fretta. Non ha "speso" energia muscolare per accelerare la rotazione, ha solo ridistribuito la massa.
]

#align(center, graph-card([Momento angolare rispetto a un polo fisso], cetz.canvas({
  import cetz.draw: *
  // Sistema visto da un polo fisso esterno, come nella reference.
  line((0.75, 0.35), (1.35, 0.35), stroke: 1.0pt + ink, mark: (end: ">"))
  line((0.75, 0.35), (0.75, 0.95), stroke: 1.0pt + ink, mark: (end: ">"))
  circle((0.75, 0.35), radius: 0.08, fill: ink, stroke: none)
  axis-label((0.52, 0.12), [$O$], placement: "east")

  circle((3.65, 2.25), radius: 1.62, stroke: (paint: ink, thickness: 1.25pt, dash: "dashed"))
  circle((2.70, 2.08), radius: 0.10, fill: ink, stroke: none)
  axis-label((2.88, 2.25), [$P_1$], placement: "west")
  line((0.75, 0.35), (2.70, 2.08), stroke: 1.35pt + ink, mark: (end: ">"))
  axis-label((1.55, 1.35), [$vec(r)_1$], placement: "east")

  circle((4.10, 1.70), radius: 0.08, fill: ink, stroke: none)
  axis-label((4.28, 1.50), [CM], placement: "west")
  line((4.10, 1.70), (4.10, 2.90), stroke: 1.2pt + green, mark: (end: ">"))
  line((4.10, 1.70), (4.82, 1.08), stroke: 1.2pt + green, mark: (end: ">"))
  line((4.10, 1.70), (3.40, 1.05), stroke: 1.2pt + green, mark: (end: ">"))
  axis-label((3.45, 2.92), [$vec(F)^"int"$], placement: "east")

  // Indicazione del polo fisso esterno al sistema.
  line((4.45, 0.62), (0.92, 0.40), stroke: 0.85pt + gold, mark: (end: ">"))
  axis-label((4.55, 0.62), [polo fisso], placement: "west")

  // Azione esterna sul sistema: risultante e momento rispetto al polo fisso.
  line((0.15, 2.25), (1.55, 2.25), stroke: 1.35pt + red, mark: (end: ">"))
  axis-label((0.02, 2.65), [$vec(F)^"ext"$], placement: "west")
  axis-label((0.02, 1.88), [$vec(tau)^"ext"$], placement: "west")

  // Relazioni fondamentali dell'appunto.
  axis-label((6.15, 2.95), [$(dif vec(P))/(dif t)=M vec(a)_"CM"=vec(R)^"ext"$], placement: "west")
  axis-label((6.15, 1.70), [$(dif vec(ell))/(dif t)=vec(tau)^"ext"$], placement: "west")
})))

#yellow-box([Attenzione al polo])[
  La forma $dif vec(ell)_O/dif t=vec(tau)^"ext"_O$ è quella pulita quando il polo è fisso in un sistema inerziale. Se il polo si muove, compare un termine aggiuntivo legato alla velocità del polo.
]

== Teorema dell'energia cinetica per sistemi

#green-box([L'idea prima della formula])[
  Il *lavoro* di una forza è l'energia che essa trasferisce quando sposta un corpo. Il teorema dell'energia cinetica dice che il lavoro totale fatto su un corpo è uguale a quanto cambia la sua energia di movimento. Per un sistema di tanti corpi vale la stessa idea, con una sorpresa: stavolta anche le forze *interne* contano. Anche se le forze interne si annullano come *vettori* (risultante nulla), il loro *lavoro* non si annulla, perché punti diversi del sistema si spostano diversamente. È così che un'esplosione interna o una molla compressa possono aumentare l'energia cinetica del sistema.
]

Per la particella $i$ il lavoro elementare della forza totale ($dif L_i$, una piccola quantità di lavoro) è dato dalla forza per lo spostamento, tramite il prodotto scalare:

$ dif L_i=vec(F)_i dot dif vec(r)_i
  =(vec(F)_i^"ext"+vec(F)_i^"int") dot dif vec(r)_i
  =dif L_i^"ext"+dif L_i^"int". $

#yellow-box([Cos'è il prodotto scalare "$dot$" nel lavoro])[
  Il prodotto scalare $vec(F) dot dif vec(r)$ vale $F dot dif r dot cos beta$, dove $beta$ è l'angolo tra forza e spostamento. Conta solo la parte di forza *nella direzione del movimento*: una forza perpendicolare allo spostamento non compie lavoro (come la tensione del filo del pendolo, sempre perpendicolare al moto). Nell'ultimo passaggio abbiamo solo separato il lavoro in parte esterna e parte interna, distribuendo il prodotto scalare sulla somma delle due forze.
]

Sommando su tutte le particelle del sistema, il lavoro totale si divide in lavoro delle forze esterne e lavoro delle forze interne:

$ L=sum_i L_i=L^"ext"+L^"int". $

Per ogni particella vale $vec(F)_i=m_i vec(a)_i$, quindi calcolando il lavoro lungo il percorso (da una posizione iniziale $A$ a una finale $B$):

$ integral vec(F)_i dot dif vec(r)_i
  =integral m_i vec(v)_i dot dif vec(v)_i
  =1/2 m_i v_(i,B)^2-1/2 m_i v_(i,A)^2. $

#yellow-box([Perché l'integrale dà la differenza di energia cinetica])[
  Il trucco è riscrivere $vec(a)_i dot dif vec(r)_i$. Poiché $vec(a)_i=dif vec(v)_i\/dif t$ e $dif vec(r)_i=vec(v)_i dif t$, il prodotto diventa $vec(v)_i dot dif vec(v)_i$. E $vec(v) dot dif vec(v)$ è esattamente $dif(1/2 v^2)$: integrando, si ottiene la differenza tra il valore finale e iniziale di $1/2 m_i v_i^2$, cioè la variazione di energia cinetica della particella. È lo stesso teorema dell'energia cinetica del singolo corpo, riapplicato qui.
]

Sommando su tutte le particelle, il lavoro totale (esterno più interno) è uguale alla variazione dell'energia cinetica totale:

#purple-box([Energia cinetica di un sistema])[
  $ L^"ext"+L^"int"=Delta E_k, $

  con $E_k=sum_i 1/2 m_i v_i^2$.
]

Il simbolo $Delta$ significa sempre "variazione di", cioè valore finale meno valore iniziale: $Delta E_k=E_(k,"fin")-E_(k,"in")$.

Le forze interne hanno risultante nulla, ma il loro lavoro totale in generale non è nullo: possono cambiare le distanze mutue, deformare il sistema o trasformare energia cinetica in energia interna.

#red-box([Attenzione: risultante nulla NON vuol dire lavoro nullo])[
  È l'errore più comune. La risultante delle forze interne è un *vettore* nullo, ma il *lavoro* è un numero (scalare) e non è nullo. Esempio: una molla compressa tra due blocchi spinge i due blocchi in versi opposti (risultante zero), ma quando la lasci andare li allontana entrambi, aumentando la loro energia cinetica. Il lavoro interno ha "creato" energia di movimento attingendo all'energia elastica immagazzinata. Quindi non cancellare mai $L^"int"$ a cuor leggero negli esercizi.
]

#align(center, graph-card([Lavoro delle forze interne], cetz.canvas({
  import cetz.draw: *
  circle((1.10, 1.35), radius: 0.09, fill: ink, stroke: none)
  circle((3.25, 1.35), radius: 0.09, fill: ink, stroke: none)
  line((1.10, 1.35), (3.25, 1.35), stroke: 0.9pt + ink)
  line((1.10, 1.35), (0.35, 1.35), stroke: 1.15pt + green, mark: (end: ">"))
  line((3.25, 1.35), (4.00, 1.35), stroke: 1.15pt + green, mark: (end: ">"))
  line((0.55, 0.40), (1.10, 1.35), stroke: 1.0pt + blue, mark: (end: ">"))
  line((0.55, 0.40), (3.25, 1.35), stroke: 1.0pt + blue, mark: (end: ">"))
  line((1.10, 0.95), (3.25, 0.95), stroke: 0.9pt + gold, mark: (end: ">"))
  axis-label((1.00, 1.60), [$i$], placement: "south")
  axis-label((3.35, 1.60), [$j$], placement: "south")
  axis-label((0.40, 1.58), [$vec(F)_(j i)$], placement: "south")
  axis-label((3.95, 1.58), [$vec(F)_(i j)$], placement: "south")
  axis-label((1.85, 0.77), [$vec(r)_(i j)=vec(r)_i-vec(r)_j$], placement: "north")
  axis-label((5.20, 1.65), [$vec(F)_(i j)=-vec(F)_(j i)$], placement: "west")
  axis-label((5.20, 0.95), [$L^"int"$ può essere diverso da zero], placement: "west")
})))

== Energia meccanica di un sistema

#green-box([L'idea prima della formula])[
  Alcune forze (gravità, molle) sono "conservative": l'energia che spendono non si perde, viene messa da parte come *energia potenziale* e può essere recuperata. Altre forze (attrito, urti che deformano) sono "non conservative": dissipano energia in calore, suono, deformazione, e non te la restituiscono. La regola è semplice: se agiscono solo forze conservative, l'energia meccanica totale (cinetica più potenziale) resta costante; se agiscono anche forze non conservative, l'energia meccanica cambia esattamente del lavoro che esse fanno.
]

Se le forze che compiono lavoro sono conservative, il loro lavoro è l'opposto della variazione di energia potenziale:

$ L_"conserv"=Delta E_k=-Delta E_p. $

#yellow-box([Perché compare il segno meno e cosa si ottiene])[
  Per definizione, una forza conservativa che compie lavoro *positivo* (per esempio la gravità mentre un corpo scende) fa *diminuire* l'energia potenziale: per questo $L_"conserv"=-Delta E_p$. Ma per il teorema dell'energia cinetica quello stesso lavoro è anche $Delta E_k$. Uguagliando i due, $Delta E_k=-Delta E_p$, cioè $Delta E_k+Delta E_p=0$: l'energia che la cinetica guadagna è esattamente quella che la potenziale perde, e viceversa. La somma non cambia.
]

Di conseguenza l'energia meccanica totale del sistema (cinetica più potenziale) si conserva:

$ E=E_k+E_p="costante". $

Se invece sono presenti forze non conservative,

#yellow-box([Bilancio energetico per sistemi])[
  $ L_"non conserv"=Delta E_"meccanica". $
]

In parole: il lavoro delle forze non conservative misura *quanta* energia meccanica viene persa (se negativo, come l'attrito) o aggiunta (se positivo). Questa forma vale anche per sistemi di punti materiali: l'energia potenziale e l'energia cinetica sono quelle totali del sistema.

== Conservazioni e simmetrie

#green-box([L'idea prima della formula])[
  C'è un legame profondo e bellissimo: ogni legge di conservazione nasce da una *simmetria* dello spazio o del tempo, cioè da qualcosa che "non cambia se sposti il punto di vista". Questa è una delle idee più eleganti della fisica (è il teorema di Noether). Non ti serve dimostrarla qui, ma è utile averla in mente come "perché" ultimo delle tre conservazioni viste finora.
]

Nella fisica moderna le leggi di conservazione sono collegate alle simmetrie:

- $vec(P)$ costante: lo spazio è omogeneo, cioè non esiste un'origine privilegiata (le leggi della fisica sono uguali qui e un metro più in là);
- $vec(ell)$ costante: lo spazio è isotropo, cioè non esiste una direzione privilegiata (le leggi sono uguali se ruoti il laboratorio);
- $E$ costante: il tempo è omogeneo, cioè non esiste un istante privilegiato (le leggi sono uguali oggi e domani).

= Urti

#green-box([L'idea prima della formula])[
  Un urto è uno scontro rapidissimo: due palle da biliardo che si toccano, una pallina che rimbalza, un proiettile che si conficca. Dura una frazione di secondo, durante la quale i corpi si spingono con forze enormi. La domanda chiave è: *dopo l'urto, con che velocità ripartono?* Il trucco geniale è che durante quell'istante brevissimo le forze esterne (gravità, attrito) non fanno in tempo a influire: contano solo le forze interne tra i corpi, che si annullano a coppie. Quindi la quantità di moto totale prima dell'urto è uguale a quella dopo. Questo da solo basta a risolvere moltissimi problemi.
]

Un urto è un'interazione molto breve tra corpi. Durante l'intervallo dell'urto le forze interne sono molto intense e impulsive. L'*impulso* $vec(J)$ è l'integrale della forza nel tempo, e misura quanto "spinge complessivamente" la forza durante l'urto:

$ vec(J)=integral_(Delta t) vec(F) dif t. $

#yellow-box([Cos'è l'impulso e perché un integrale])[
  Una forza grandissima che agisce per un tempo brevissimo può comunque produrre un effetto modesto, e una forza piccola applicata a lungo può produrne uno grande: ciò che conta è il prodotto "forza × tempo" accumulato. L'integrale $integral vec(F) dif t$ somma proprio tutti questi piccoli contributi $vec(F) dif t$ istante per istante. L'impulso è importante perché è uguale alla variazione di quantità di moto: $vec(J)=Delta vec(p)$. Durante un urto non conosciamo la forza istante per istante (è complicatissima), ma conosciamo il suo effetto totale tramite la quantità di moto.
]

#green-box([Perché negli urti si conserva la quantità di moto])[
  Ecco il cuore di tutto. Le forze tra i due corpi sono interne al sistema "$1+2$": per la terza legge di Newton, quella che $1$ fa su $2$ è uguale e opposta a quella che $2$ fa su $1$. Quindi gli impulsi che si scambiano sono uguali e opposti: ciò che $1$ guadagna in quantità di moto, $2$ lo perde. La somma resta invariata. Le forze esterne (gravità, attrito) ci sono, ma agiscono per un tempo $Delta t$ così breve che il loro impulso $vec(F)^"ext" Delta t$ è trascurabile rispetto a quelli enormi dell'urto. Per questo, e *solo* per la brevità dell'urto, possiamo dire che $vec(P)$ si conserva.
]

Se le forze esterne sono trascurabili durante l'urto, la quantità di moto totale del sistema si conserva sempre:

#green-box([Quantità di moto negli urti])[
  $ vec(P)_"iniziale"=vec(P)_"finale". $
]

Per due masse (gli apici $'$ indicano le velocità *dopo* l'urto):

$ m_1 vec(v)_1+m_2 vec(v)_2=m_1 vec(v)'_1+m_2 vec(v)'_2. $

Inoltre, ricordando che $vec(P)=(m_1+m_2) vec(v)_"CM"$,

$ vec(P)=(m_1+m_2) vec(v)_"CM", $

quindi, se il sistema è isolato durante l'urto, $vec(v)_"CM"$ resta costante: il centro di massa dei due corpi continua a muoversi senza accorgersi dell'urto.

#align(center, graph-card([Urto e impulso interno], cetz.canvas({
  import cetz.draw: *
  circle((1.00, 1.75), radius: 0.16, fill: ink, stroke: none)
  circle((4.20, 0.75), radius: 0.16, fill: ink, stroke: none)
  circle((2.55, 1.20), radius: 0.18, stroke: (paint: ink, thickness: 0.9pt, dash: "dashed"))
  line((1.00, 1.75), (2.20, 1.30), stroke: 1.2pt + blue, mark: (end: ">"))
  line((4.20, 0.75), (2.90, 1.10), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((0.85, 1.43), [$m_1$], placement: "north")
  axis-label((4.30, 0.45), [$m_2$], placement: "north")
  axis-label((1.70, 1.65), [$vec(v)_1$], placement: "south")
  axis-label((3.45, 1.08), [$vec(v)_2$], placement: "south")
  axis-label((2.55, 0.78), [zona d'urto], placement: "north")
  axis-label((6.05, 1.55), [$Delta vec(p)_1=vec(J)_(2 -> 1)$], placement: "west")
  axis-label((6.05, 0.95), [$Delta vec(p)_2=vec(J)_(1 -> 2)$], placement: "west")
})))

== Urto elastico e anelastico

#green-box([L'idea prima della formula])[
  La quantità di moto si conserva *sempre* (negli urti brevi). La differenza tra i tipi di urto sta nell'*energia cinetica*. In un urto *elastico* i corpi rimbalzano perfettamente, come due palle da biliardo o due palline di gomma dura: nessuna energia di movimento va persa. In un urto *anelastico* parte dell'energia cinetica si trasforma in deformazione, calore, suono: i corpi escono dallo scontro con meno "vivacità". Il caso estremo è l'urto *completamente anelastico*, in cui i corpi restano appiccicati e si perde il massimo di energia possibile (pensa a due palline di plastilina che si fondono).
]

La quantità di moto totale si conserva in entrambi i casi, se l'impulso esterno è trascurabile. La differenza riguarda l'energia cinetica:

#blue-box([Classificazione degli urti])[
  *Urto elastico*: $vec(P)$ si conserva ed $E_k$ si conserva.

  *Urto anelastico*: $vec(P)$ si conserva, ma $E_k$ non si conserva.
]

#red-box([Attenzione: non confondere le due conservazioni])[
  La quantità di moto $vec(P)$ si conserva in *tutti* gli urti (è la terza legge di Newton). L'energia cinetica $E_k$ si conserva *solo* in quelli elastici. Negli esercizi: usa sempre la conservazione di $vec(P)$; aggiungi la conservazione di $E_k$ *solo* se l'urto è dichiarato elastico. Se lo applicassi a un urto anelastico, otterresti un risultato sbagliato, perché lì un po' di energia se ne va.
]

In generale non sappiamo se le forze interne dell'urto siano conservative; per questo l'energia meccanica può diminuire, trasformandosi in deformazione, calore, suono o energia interna. Non può però *aumentare* in un urto ordinario: non c'è energia che spunti dal nulla.

Per un urto completamente anelastico i corpi restano attaccati dopo l'urto e quindi ripartono con la stessa velocità:

$ vec(v)'_1=vec(v)'_2=vec(v)'. $

La conservazione della quantità di moto dà allora un'unica incognita $vec(v)'$, e basta una sola equazione per trovarla:

#purple-box([Urto completamente anelastico])[
  $ m_1 vec(v)_1+m_2 vec(v)_2=(m_1+m_2) vec(v)'. $
]

#yellow-box([Perché qui serve solo la quantità di moto])[
  Siccome i corpi escono incollati, c'è una sola velocità finale $vec(v)'$ da trovare: la conservazione della quantità di moto basta da sola. Non puoi usare la conservazione dell'energia cinetica, perché in questo tipo di urto l'energia *non* si conserva (anzi, qui se ne perde la quantità massima). Risolvendo: $vec(v)'=(m_1 vec(v)_1+m_2 vec(v)_2)\/(m_1+m_2)$, che è proprio la velocità del centro di massa.
]

#purple-box([Esempio numerico: vagoni che si agganciano])[
  Un vagone di $m_1=2000 " kg"$ viaggia a $v_1=3 " m/s"$ e tampona un vagone fermo $m_2=4000 " kg"$ ($v_2=0$); si agganciano. La velocità comune dopo l'urto:
  $ v'=(m_1 v_1+m_2 v_2)/(m_1+m_2)=(2000 dot 3+4000 dot 0)/(2000+4000)=(6000)/(6000)=1 " m/s". $
  I due vagoni agganciati proseguono a $1 " m/s"$. Verifica dell'energia: prima $E_k=1/2 dot 2000 dot 3^2=9000 " J"$; dopo $E_k=1/2 dot 6000 dot 1^2=3000 " J"$. Mancano $6000 " J"$: sono diventati calore e deformazione nell'aggancio. La quantità di moto invece torna ($6000 " kg·m/s"$ prima e dopo).
]

L'energia cinetica finale è minore di quella iniziale, salvo casi particolari:

$ E_(k,"fin")=1/2 (m_1+m_2) v'^2. $

La parte mancante è lavoro speso per deformare i corpi o energia interna.

== Energia cinetica e centro di massa

#green-box([L'idea prima della formula])[
  L'energia cinetica di un sistema si può sempre vedere come somma di due pezzi: l'energia del *moto d'insieme* (come se tutta la massa viaggiasse insieme al centro di massa) più l'energia del *moto interno* (i pezzi che si muovono gli uni rispetto agli altri). È come una squadra in autobus: c'è l'energia dell'autobus che avanza, più l'energia delle persone che si muovono dentro. In un urto l'autobus (centro di massa) prosegue indisturbato, ma il movimento interno può cambiare: è lì che si nasconde l'energia persa.
]

Per un sistema di due particelle si può separare l'energia cinetica in una parte legata al moto del centro di massa e una parte interna $E'_k$:

$ E_k=1/2 (m_1+m_2) v_"CM"^2+E'_k. $

#yellow-box([Cosa significano i due termini])[
  Il primo termine, $1/2 (m_1+m_2) v_"CM"^2$, è l'energia cinetica che avrebbe il sistema se fosse un blocco unico di massa $m_1+m_2$ che si muove alla velocità del centro di massa: è l'energia "del traslare insieme". Il secondo, $E'_k$, è l'energia del moto *relativo* al centro di massa: i corpi che si avvicinano o si allontanano. In un urto isolato $v_"CM"$ non cambia, quindi il primo termine è fisso: tutta l'energia eventualmente persa esce dal secondo termine $E'_k$. Ecco perché in un urto completamente anelastico, dove i corpi restano fermi l'uno rispetto all'altro, $E'_k$ finale è zero: si è persa tutta l'energia interna possibile, ma non quella del centro di massa.
]

Se il sistema è isolato, $v_"CM"$ è costante; durante un urto può cambiare solo la parte interna $E'_k$.

= Esempio: pendolo balistico

#green-box([L'idea prima della formula])[
  Il pendolo balistico è un ingegnoso modo per misurare la velocità di un proiettile *velocissimo* senza strumenti elettronici: spari il proiettile in un blocco di legno appeso, il proiettile si conficca, e il blocco (con dentro il proiettile) si solleva di un'altezza $h$ che puoi misurare facilmente con un righello. Da quell'altezza si risale alla velocità del proiettile. Il segreto è che il problema si spezza in *due fasi diverse*, ognuna con la sua legge di conservazione, e bisogna stare attenti a non mischiarle.
]

Nel pendolo balistico un proiettile di massa $m$ e velocità $v$ urta un blocco appeso di massa $M$ e rimane conficcato. L'urto è completamente anelastico.

#red-box([Attenzione: due fasi, due leggi diverse])[
  L'errore tipico è applicare la conservazione dell'energia all'intero processo. *Sbagliato*: durante l'urto (fase 1) l'energia cinetica NON si conserva, perché il proiettile si conficca (urto anelastico) e parte dell'energia diventa calore e deformazione. Si conserva la *quantità di moto*. Durante la salita (fase 2), invece, NON c'è più urto: si conserva l'*energia meccanica*. Quindi: fase 1 → quantità di moto; fase 2 → energia. Mai usare l'energia nella fase 1.
]

*Fase 1 — l'urto.* Durante l'urto, brevissimo, si conserva la quantità di moto orizzontale. Prima dell'urto si muove solo il proiettile; subito dopo, proiettile e blocco si muovono insieme (massa $m+M$) alla velocità $v'$:

$ m v=(m+M) v', $

quindi, risolvendo per $v'$:

$ v'=m/(m+M) v. $

*Fase 2 — la salita.* Dopo l'urto, il blocco con il proiettile sale fino a quota $h$. In questa fase, trascurando attriti, si conserva l'energia meccanica: l'energia cinetica con cui parte si trasforma tutta in energia potenziale all'altezza massima (dove si ferma un istante):

$ 1/2 (m+M) v'^2=(m+M) g h. $

#yellow-box([Da dove esce $v'=sqrt(2 g h)$])[
  Nell'equazione dell'energia il fattore $(m+M)$ compare in entrambi i membri, quindi si semplifica: resta $1/2 v'^2=g h$. Moltiplicando per $2$ si ha $v'^2=2 g h$, e prendendo la radice quadrata $v'=sqrt(2 g h)$. È la stessa formula della velocità di caduta da un'altezza $h$, letta al contrario: la velocità che serve per salire fino a $h$ è quella che si acquisterebbe cadendo da $h$.
]

Da cui

$ v'=sqrt(2 g h). $

Ora abbiamo due espressioni per la stessa $v'$ (una dalla fase 1, una dalla fase 2). Combinandole, cioè ponendo $m/(m+M) v=sqrt(2 g h)$ e isolando $v$:

#green-box([Velocità del proiettile nel pendolo balistico])[
  $ v=(m+M)/m sqrt(2 g h). $
]

#purple-box([Esempio numerico])[
  Un proiettile di $m=0,01 " kg"$ (10 grammi) si conficca in un blocco di $M=2 " kg"$. Il blocco si solleva di $h=0,05 " m"$ (5 cm). Con $g=9,8 " m/s"^2$:
  $ v=(0,01+2)/(0,01) sqrt(2 dot #[9,8] dot #[0,05])=201 dot sqrt(#[0,98])=201 dot 0,99 approx 199 " m/s". $
  Il proiettile viaggiava a circa $199 " m/s"$ (quasi $720 " km/h"$). Nota come una piccola altezza di pochi centimetri corrisponda a una velocità enorme: è proprio perché l'urto anelastico "butta via" quasi tutta l'energia cinetica del proiettile (il rapporto $m\/(m+M)$ è piccolissimo), e solo una briciola resta a sollevare il blocco.
]

#align(center, graph-card([Pendolo balistico], cetz.canvas({
  import cetz.draw: *
  line((0.40, 3.45), (8.80, 3.45), stroke: 1.0pt + ink)
  for i in range(0, 12) {
    line((0.65 + i*0.64, 3.57), (0.95 + i*0.64, 3.80), stroke: 0.6pt + ink)
  }

  // Prima dell'urto.
  line((2.05, 3.45), (2.05, 1.35), stroke: 1.0pt + ink)
  circle((2.05, 1.35), radius: 0.24, fill: ink, stroke: none)
  circle((0.65, 1.35), radius: 0.11, fill: ink, stroke: none)
  line((0.78, 1.35), (1.55, 1.35), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((1.35, 2.72), [prima], placement: "south")
  axis-label((0.58, 0.98), [$m$], placement: "north")
  axis-label((1.18, 1.63), [$vec(v)$], placement: "south")
  axis-label((1.95, 0.92), [$M$], placement: "north")

  // Subito dopo l'urto.
  line((4.65, 3.45), (4.65, 1.35), stroke: 1.0pt + ink)
  circle((4.65, 1.35), radius: 0.27, fill: ink, stroke: none)
  circle((4.41, 1.35), radius: 0.065, fill: green, stroke: none)
  line((4.96, 1.35), (5.76, 1.35), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((4.75, 2.72), [dopo l'urto], placement: "south")
  axis-label((4.45, 0.88), [$m+M$], placement: "north")
  axis-label((5.78, 1.63), [$vec(v)'$], placement: "south")

  // Quota massima dopo la salita.
  line((7.30, 3.45), (7.95, 2.05), stroke: 1.0pt + ink)
  circle((7.95, 2.05), radius: 0.27, fill: ink, stroke: none)
  circle((7.72, 1.93), radius: 0.065, fill: green, stroke: none)
  line((7.95, 1.35), (7.95, 2.05), stroke: 0.9pt + gold, mark: (end: ">"))
  line((7.24, 1.35), (8.42, 1.35), stroke: 0.7pt + ink)
  axis-label((8.18, 1.70), [$h$], placement: "west")
  axis-label((7.35, 2.35), [$E_k=0$], placement: "east")
  axis-label((7.70, 2.72), [quota massima], placement: "south")
})))

= Dinamica del corpo rigido

#green-box([L'idea prima della formula])[
  Fino ad ora abbiamo studiato il *punto materiale*: un corpo così piccolo che possiamo immaginarlo concentrato in un solo punto, senza forma né dimensioni. Ma una porta, una ruota, un'asta di ferro, una trottola non sono punti: hanno forma, occupano spazio, e soprattutto possono *ruotare* su sé stessi.

  Un *corpo rigido* è il modello più semplice per descrivere questi oggetti estesi. L'idea chiave è una sola: è un corpo che *non si deforma mai*. Pensa a un mattone o a una chiave inglese: per quanto lo spingi, lo lanci o lo fai girare, le distanze tra i suoi punti non cambiano. Due puntini disegnati sulla chiave restano sempre alla stessa distanza tra loro. Non si piega, non si allunga, non si schiaccia.

  Questa ipotesi sembra una limitazione, ma in realtà è una grande semplificazione: ci permette di descrivere il moto di un oggetto fatto di infiniti punti usando poche grandezze (la posizione del centro di massa e l'angolo di rotazione), invece di seguire ogni singolo punto uno per uno.
]

Un corpo rigido è un caso particolare di sistema di punti materiali in cui le distanze mutue tra le particelle restano costanti:

#blue-box([Corpo rigido])[
  $ r_(i j)="costante" quad "per ogni coppia " i,j. $
]

#yellow-box([Cosa dice questa formula in parole])[
  Il simbolo $r_(i j)$ indica la distanza tra la particella $i$ e la particella $j$ del corpo (gli indici $i$ e $j$ sono semplicemente etichette: "particella numero $i$", "particella numero $j$"). Dire che $r_(i j)$ è costante "per ogni coppia $i,j$" significa: *prendi due punti qualsiasi del corpo, la loro distanza non cambia mai nel tempo*. Questa è la traduzione matematica esatta di "il corpo non si deforma". È l'unica vera ipotesi su cui si costruisce tutta la dinamica del corpo rigido.
]

Il moto generale di un corpo rigido si può pensare come somma di due moti:

- moto del centro di massa;
- moto rispetto al centro di massa, cioè moto interno di rotazione.

In un corpo rigido non ci sono deformazioni: i punti mantengono posizione reciproca fissa rispetto al corpo.

#green-box([Scomporre il moto: traslazione + rotazione])[
  Un teorema importante (teorema di Chasles) dice che *qualunque* movimento di un corpo rigido, per quanto complicato, si può sempre vedere come la somma di due movimenti semplici:

  + una *traslazione*: tutto il corpo si sposta in blocco, come se seguisse il suo centro di massa (CM). È il moto del "punto materiale" che già conosci.
  + una *rotazione* attorno al centro di massa: il corpo gira su sé stesso.

  Immagine quotidiana: una palla da bowling che rotola sulla pista. Il suo centro avanza lungo la pista (traslazione) e contemporaneamente la palla gira su sé stessa (rotazione). Studiando questi due pezzi separatamente, e poi sommandoli, descriviamo il moto completo.
]

#align(center, graph-card([Corpo rigido: moto del CM e rotazione interna], cetz.canvas({
  import cetz.draw: *
  line((0.65, 0.45), (1.25, 0.45), stroke: 0.85pt + ink, mark: (end: ">"))
  line((0.65, 0.45), (0.65, 1.05), stroke: 0.85pt + ink, mark: (end: ">"))
  axis-label((0.42, 0.24), [$O x y z$ inerziale], placement: "east")
  circle((3.10, 1.85), radius: 0.95, stroke: (paint: ink, thickness: 1.0pt, dash: "dashed"), fill: rgb("#edf8ef"))
  circle((3.10, 1.85), radius: 0.08, fill: red, stroke: none)
  circle((2.72, 2.18), radius: 0.07, fill: ink, stroke: none)
  circle((3.65, 2.08), radius: 0.07, fill: ink, stroke: none)
  circle((3.25, 1.25), radius: 0.07, fill: ink, stroke: none)
  line((0.65, 0.45), (3.10, 1.85), stroke: 1.1pt + blue, mark: (end: ">"))
  line((3.10, 1.85), (4.15, 1.85), stroke: 1.2pt + green, mark: (end: ">"))
  arc((3.10, 1.85), start: 20deg, stop: 315deg, radius: 0.55, stroke: 1.0pt + gold, mark: (end: ">"))
  axis-label((2.70, 1.62), [CM], placement: "north")
  axis-label((1.90, 1.42), [$vec(r)_"CM"$], placement: "south")
  axis-label((4.22, 1.90), [moto del CM], placement: "west")
  axis-label((3.60, 2.62), [rotazione rispetto al CM], placement: "south")
  axis-label((5.62, 1.62), [$r_(i j)="costante"$], placement: "west")
})))

== Conseguenze della rigidità

#green-box([L'idea prima della formula])[
  Le forze che tengono insieme il corpo (le forze *interne*: i legami tra atomi, che impediscono ai punti di allontanarsi o avvicinarsi) ci sono, sono fortissime, ma c'è una buona notizia: *non fanno lavoro*. Il motivo intuitivo è che il lavoro è "forza per spostamento nella direzione della forza"; ma in un corpo rigido i punti non si avvicinano né si allontanano mai (le distanze sono costanti), quindi lungo la direzione di queste forze interne non c'è nessuno spostamento. Niente spostamento $arrow$ niente lavoro.

  La conseguenza è enorme per i calcoli di energia: possiamo ignorare completamente le forze interne e guardare solo a ciò che spinge il corpo *dall'esterno*.
]

Poiché le distanze $r_(i j)$ restano costanti, il lavoro delle forze interne in un corpo rigido ideale è nullo:

$ L^"int"=0. $

Per il teorema dell'energia cinetica dei sistemi resta quindi

#green-box([Energia cinetica del corpo rigido])[
  $ Delta E_k=L^"ext". $
]

#yellow-box([Da dove esce $Delta E_k=L^"ext"$])[
  Il teorema dell'energia cinetica per un sistema di punti dice in generale: $Delta E_k = L^"ext" + L^"int"$, cioè la variazione di energia cinetica è dovuta sia al lavoro delle forze esterne sia a quello delle forze interne. Ma abbiamo appena visto che per un corpo rigido $L^"int"=0$. Sostituendo, il termine sparisce e resta solo $Delta E_k = L^"ext"$. In parole: *l'energia cinetica del corpo cambia solo per effetto delle forze esterne*.
]

Le equazioni globali del moto restano quelle dei sistemi di punti materiali:

$ vec(R)^"ext"=M vec(a)_"CM"=(dif vec(P))/(dif t), $

$ vec(tau)^"ext"=(dif vec(ell))/(dif t). $

#blue-box([Le due equazioni cardinali, in parole])[
  Queste due righe sono il cuore della dinamica del corpo rigido. La prima ($vec(R)^"ext"=M vec(a)_"CM"$) governa la *traslazione*: la risultante $vec(R)^"ext"$ di tutte le forze esterne fa accelerare il centro di massa, esattamente come $vec(F)=m vec(a)$ per un punto. La seconda ($vec(tau)^"ext"=(dif vec(ell))/(dif t)$) governa la *rotazione*: il momento risultante $vec(tau)^"ext"$ delle forze esterne fa variare il momento angolare $vec(ell)$.

  Significato dei simboli: $vec(R)^"ext"$ è la somma (risultante) delle forze esterne, $M$ la massa totale, $vec(a)_"CM"$ l'accelerazione del centro di massa, $vec(P)$ la quantità di moto totale, $vec(tau)^"ext"$ il momento risultante delle forze esterne (detto anche "momento torcente"), $vec(ell)$ il momento angolare totale. Tutto il resto della sezione serve a rendere *concreta* la seconda equazione nel caso più semplice: la rotazione attorno a un asse fisso.
]

== Corpo rigido continuo e densità

#green-box([L'idea prima della formula])[
  Un oggetto vero (un cilindro di ferro, un disco di legno) non è fatto di pochi punti separati: è materia "piena", continua. Come facciamo a trattarne la massa? Lo immaginiamo tagliato in *tantissimi pezzettini piccolissimi*, ognuno di volume $dif V$ così minuscolo da essere praticamente un punto. Ogni pezzettino ha una sua massa $dif m$.

  La *densità* risponde alla domanda: "quanta massa è stipata in ogni unità di volume?". Un pezzo di piombo è più denso di un pezzo di sughero della stessa dimensione perché contiene più massa nello stesso spazio. Sommare (cioè integrare) le masse di tutti i pezzettini ci ridà la massa totale del corpo.
]

Un corpo rigido può essere modellato come:

- insieme discreto di $N$ punti materiali;
- corpo continuo, diviso in elementi infinitesimi di volume $dif V$ e massa $dif m$.

Nel caso continuo si introduce la densità volumica

#blue-box([Densità])[
  $ rho=(dif m)/(dif V) quad ["kg"/"m"^3]. $
]

La massa totale è

$ M=integral_V rho(vec(r)) dif V. $

#yellow-box([Perché l'integrale e cosa significa])[
  L'integrale $integral_V$ non è altro che una *somma* di infiniti contributi piccolissimi, estesa a tutto il volume $V$ del corpo (la $V$ sotto il segno indica "su tutto il volume"). Riscriviamo il passaggio al contrario per capirlo: dalla definizione $rho=(dif m)/(dif V)$ ricaviamo la massa del singolo pezzettino, $dif m=rho dif V$. Per avere la massa totale sommiamo i $dif m$ di tutti i pezzettini: $M=integral dif m=integral_V rho dif V$. È esattamente lo stesso ragionamento di "sommo la massa di ogni mattoncino per ottenere la massa del muro", solo che qui i mattoncini sono infinitamente piccoli.
]

Se la densità è costante,

$ M=rho V. $

#yellow-box([Perché in questo caso l'integrale sparisce])[
  Se la densità $rho$ è la *stessa* in ogni punto (corpo *omogeneo*), è un numero fisso e può "uscire" dall'integrale: $M=integral_V rho dif V=rho integral_V dif V$. Ma $integral_V dif V$ vuol dire "somma di tutti i volumetti", cioè semplicemente il volume totale $V$. Resta $M=rho V$, la formula che usi sempre: massa uguale densità per volume.
]

#purple-box([Esempio numerico: massa di un disco])[
  Un disco di alluminio omogeneo ha densità $rho=2700 " kg/m"^3$, raggio $R=0,10 " m"$ e spessore $h=0,02 " m"$. Il volume è quello di un cilindro:
  $ V=pi R^2 h=pi dot (0,10)^2 dot 0,02 approx 6,28 dot 10^(-4) " m"^3. $
  La massa è quindi
  $ M=rho V=2700 dot 6,28 dot 10^(-4) approx 1,70 " kg". $
]

Il centro di massa diventa

$ vec(r)_"CM"=(integral vec(r) dif m)/(integral dif m)
  =(1/M) integral_V rho(vec(r)) vec(r) dif V. $

#yellow-box([Il centro di massa è una "media pesata" delle posizioni])[
  Per un sistema di punti il centro di massa è $vec(r)_"CM"=(sum_i m_i vec(r)_i)/(sum_i m_i)$: la posizione media dei punti, dove ogni posizione $vec(r)_i$ conta in proporzione alla sua massa $m_i$. Passando al continuo, la somma $sum_i$ diventa un integrale e la massa $m_i$ diventa $dif m$: ecco $vec(r)_"CM"=(integral vec(r) dif m)/(integral dif m)$. Al denominatore $integral dif m$ è semplicemente la massa totale $M$. Sostituendo poi $dif m=rho(vec(r)) dif V$ si arriva all'ultima forma. È sempre la stessa idea: il centro di massa è il "baricentro", il punto di equilibrio in cui si bilancia tutta la massa.
]

#yellow-box([Perché compare $vec(r)$ nella densità?])[
  Nel caso continuo la massa non è concentrata in particelle isolate, ma distribuita nello spazio. Il vettore $vec(r)$ indica la posizione del piccolo elemento di volume $dif V$ rispetto all'origine scelta.

  Se la densità non è uniforme, può cambiare da punto a punto: per questo si scrive $rho(vec(r))$. La massa dell'elemento è quindi $dif m=rho(vec(r)) dif V$.

  Nell'integrale del centro di massa, $vec(r) rho(vec(r)) dif V$ pesa la posizione di ogni pezzettino di corpo con la massa contenuta in quel punto.
]

Se $rho$ è costante:

$ vec(r)_"CM"=1/V integral_V vec(r) dif V. $

#align(center, graph-card([Corpo continuo: elemento di massa], cetz.canvas({
  import cetz.draw: *
  catmull((1.25, 1.25), (1.55, 2.25), (2.65, 2.65), (3.65, 2.20), (3.90, 1.25), (3.05, 0.55), (1.75, 0.65), (1.25, 1.25), stroke: 1.1pt + ink, fill: rgb("#edf8ef"))
  rect((2.45, 1.38), (2.90, 1.83), stroke: 0.9pt + ink, fill: rgb("#fbfcfd"))
  circle((2.58, 1.55), radius: 0.035, fill: ink, stroke: none)
  line((0.65, 0.45), (2.58, 1.55), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((1.48, 1.14), [$vec(r)$], placement: "south")
  axis-label((2.95, 1.84), [$dif V$], placement: "west")
  axis-label((2.98, 1.42), [$dif m$], placement: "west")
  axis-label((5.25, 1.85), [$dif m=rho dif V$], placement: "west")
  axis-label((5.25, 1.15), [$M=integral_V rho dif V$], placement: "west")
})))

== Traslazione pura

#green-box([L'idea prima della formula])[
  Traslazione pura significa: il corpo si muove "tutto insieme", senza girare. Pensa a una scatola che fai scivolare sul tavolo tenendola dritta, oppure a una cabina dell'ascensore: ogni punto si sposta esattamente nello stesso modo, con la stessa velocità e nella stessa direzione. Se conosci come si muove un punto (il centro di massa), li conosci tutti. È il caso più semplice in assoluto, perché di fatto il corpo esteso si comporta come un *unico punto materiale* di massa $M$.
]

In una traslazione tutti i punti del corpo hanno la stessa velocità del centro di massa:

$ vec(v)_i=vec(v)_"CM" quad "per ogni " i. $

Allora

$ vec(P)=M vec(v)_"CM", quad
   E_k=1/2 M v_"CM"^2, quad
   vec(R)^"ext"=M vec(a)_"CM". $

#yellow-box([Perché valgono queste tre formule])[
  Tutte e tre nascono dal fatto che ogni punto ha la stessa velocità $vec(v)_"CM"$. La quantità di moto totale è $vec(P)=sum_i m_i vec(v)_i=sum_i m_i vec(v)_"CM"=(sum_i m_i) vec(v)_"CM"=M vec(v)_"CM"$ (la velocità è comune, esce dalla somma, e $sum_i m_i=M$). L'energia cinetica è $E_k=sum_i 1/2 m_i v_i^2=sum_i 1/2 m_i v_"CM"^2=1/2 M v_"CM"^2$ con lo stesso ragionamento. La terza è la prima equazione cardinale applicata a questo caso. In pratica, nella traslazione pura, il corpo rigido si tratta *identicamente* a un punto materiale di massa $M$.
]

Rispetto al centro di massa, se gli assi restano paralleli a quelli inerziali, non c'è rotazione interna.

#align(center, graph-card([Traslazione: stessa velocità per tutti i punti], cetz.canvas({
  import cetz.draw: *
  circle((1.75, 1.60), radius: 0.85, stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  for p in ((1.35, 1.35), (1.85, 1.95), (2.22, 1.42)) {
    circle(p, radius: 0.06, fill: ink, stroke: none)
    line(p, (p.at(0) + 0.85, p.at(1)), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  circle((1.75, 1.60), radius: 0.08, fill: red, stroke: none)
  axis-label((1.55, 1.38), [CM], placement: "north")
  axis-label((3.25, 2.35), [$vec(v)_i=vec(v)_"CM"$], placement: "west")
  axis-label((3.25, 1.70), [$E_k=1/2 M v_"CM"^2$], placement: "west")
  axis-label((3.25, 1.05), [$vec(R)^"ext"=M vec(a)_"CM"$], placement: "west")
})))

== Rotazione rigida

#green-box([L'idea prima della formula])[
  Adesso il caso opposto: il corpo *gira* attorno a un asse, come una giostra, un tornello o le lancette di un orologio. La caratteristica della rotazione rigida è che *tutti i punti girano insieme con lo stesso ritmo angolare $omega$*. Pensa alla giostra: il bambino vicino al centro e quello sul bordo compiono lo stesso giro completo nello stesso tempo, quindi hanno la stessa velocità angolare $omega$ (quanti radianti al secondo spazzano).

  Ma c'è una differenza fondamentale: il bambino sul bordo *va più veloce* (in m/s) di quello vicino al centro, perché in un giro percorre una circonferenza più grande. Più sei lontano dall'asse, maggiore è la tua velocità lineare. È proprio quello che dice la formula $v_i=omega R_i$.
]

In una rotazione rigida tutti i punti descrivono moti circolari attorno all'asse di rotazione con la stessa velocità angolare $omega$.

Per un punto a distanza $R_i$ dall'asse:

$ v_i=omega R_i. $

#yellow-box([Significato dei simboli e controllo delle unità])[
  $omega$ (omega) è la *velocità angolare*, comune a tutti i punti, e si misura in radianti al secondo, cioè $"s"^(-1)$ (il radiante è un numero puro). $R_i$ è la distanza del punto $i$ *dall'asse* (non dall'origine!), in metri. $v_i$ è la velocità lineare del punto, in m/s. Controllo dimensionale: $["s"^(-1)] dot ["m"] = ["m/s"]$, torna. La formula dice anche che se $R_i=0$ (punto proprio sull'asse) allora $v_i=0$: i punti sull'asse stanno fermi, come ti aspetti dal centro di una giostra.
]

La direzione della velocità è tangente alla circonferenza descritta dal punto.

#purple-box([Esempio numerico: la giostra])[
  Una giostra ruota facendo un giro completo ($2pi$ radianti) ogni $4 " s"$. La velocità angolare è
  $ omega=(2 pi)/(4)approx 1,57 " s"^(-1). $
  Un bambino seduto a $R=1,5 " m"$ dal centro ha velocità lineare
  $ v=omega R=1,57 dot 1,5 approx 2,36 " m/s", $
  mentre uno a $R=3 " m"$ dal centro va al doppio: $v=1,57 dot 3 approx 4,71 " m/s"$. Stessa $omega$, ma velocità lineare diversa.
]

#align(center, graph-card([Rotazione rigida attorno a un asse], cetz.canvas({
  import cetz.draw: *
  line((2.10, 0.35), (2.10, 3.05), stroke: 1.2pt + ink, mark: (end: ">"))
  line(
    (0.75, 1.55), (0.95, 1.80), (1.45, 1.98), (2.10, 2.07),
    (2.75, 1.98), (3.25, 1.80), (3.45, 1.55),
    (3.25, 1.30), (2.75, 1.12), (2.10, 1.03),
    (1.45, 1.12), (0.95, 1.30), (0.75, 1.55),
    stroke: (paint: ink, thickness: 0.9pt, dash: "dashed"),
  )
  circle((3.45, 1.55), radius: 0.09, fill: ink, stroke: none)
  line((2.10, 1.55), (3.45, 1.55), stroke: 1.0pt + blue, mark: (end: ">"))
  line((3.45, 1.55), (3.75, 2.35), stroke: 1.1pt + green, mark: (end: ">"))
  arc((2.10, 2.65), start: 30deg, stop: 330deg, radius: 0.25, stroke: 1.0pt + gold, mark: (end: ">"))
  axis-label((2.26, 3.02), [$vec(omega)$], placement: "west")
  axis-label((2.75, 1.38), [$R_i$], placement: "north")
  axis-label((3.82, 2.32), [$vec(v)_i$], placement: "west")
  axis-label((5.05, 2.00), [$v_i=omega R_i$], placement: "west")
  axis-label((5.05, 1.35), [stessa $omega$ per tutti i punti], placement: "west")
})))

In generale l'asse di rotazione non deve essere fisso. Nel caso importante di rotazione attorno a un asse fisso, la dinamica diventa particolarmente semplice.

== Esempio: rotazione rigida attorno a un asse fisso

#green-box([L'idea prima della formula])[
  "Asse fisso" vuol dire che l'asse attorno a cui il corpo gira non si sposta e non si inclina nel tempo: è inchiodato lì, come il perno di una porta o l'asse di un mulino. È il caso più semplice e più comune, e tutto ciò che segue serve a un solo scopo: trovare il *momento angolare* del corpo che gira, perché è quello che ci dirà come la rotazione risponde ai momenti delle forze (la seconda equazione cardinale). Faremo così: calcoliamo il momento angolare di un singolo pezzettino e poi sommiamo su tutto il corpo.
]

Consideriamo un corpo rigido che ruota attorno a un asse fisso $z$ con velocità angolare $omega$. Ogni punto descrive una circonferenza perpendicolare all'asse. Per la particella $i$:

$ v_i=omega R_i, $

dove $R_i$ è la distanza dall'asse. Il momento angolare della singola particella è

$ vec(ell)_i=vec(r)_i times m_i vec(v)_i. $

#yellow-box([Cos'è il momento angolare e quel "$times$"])[
  Il momento angolare $vec(ell)_i$ misura "quanta rotazione" possiede la particella: dipende da quanto è lontana dal polo ($vec(r)_i$) e da quanta quantità di moto $m_i vec(v)_i$ ha. Il simbolo $times$ è il *prodotto vettoriale*: combina due vettori e ne produce un terzo, perpendicolare a entrambi, il cui modulo è $r_i dot (m_i v_i) dot sin("angolo")$. Geometricamente seleziona la parte di moto "che fa girare" attorno al polo. Questa è la stessa definizione di momento angolare che hai già visto per il punto materiale: qui la applichiamo a ogni pezzettino del corpo.
]

Qui $vec(r)_i$ è il vettore posizione rispetto al polo scelto, mentre $R_i$ è solo la distanza perpendicolare dall'asse di rotazione. Per una rotazione attorno all'asse $z$, la componente utile del momento angolare è quella lungo $z$:

$ ell_(i,z)=vec(ell)_i dot hat(k)
  =(vec(r)_i times m_i vec(v)_i) dot hat(k). $

#yellow-box([Perché ci interessa solo la componente lungo $z$])[
  L'asse di rotazione è $z$. È lungo questo asse che il moto "gira davvero", quindi è la componente $ell_(i,z)$ del momento angolare (la sua proiezione sull'asse) quella che conta per descrivere la rotazione. Il simbolo $hat(k)$ è il *versore* dell'asse $z$ (un vettore di lunghezza $1$ che punta nel verso di $z$): fare il prodotto scalare $vec(ell)_i dot hat(k)$ è il modo matematico di "estrarre" proprio la componente lungo $z$ di un vettore.
]

Poiché $vec(v)_i$ è tangente alla circonferenza descritta dalla particella e $v_i=omega R_i$, la componente lungo l'asse vale

$ ell_(i,z)=m_i R_i v_i=m_i R_i^2 omega. $

#yellow-box([Come si arriva a $m_i R_i^2 omega$])[
  La velocità $vec(v)_i$ è perpendicolare sia a $R_i$ (è tangente al cerchio) sia all'asse, quindi quando si fa il conto del prodotto vettoriale e si proietta su $z$, il seno dell'angolo vale $1$ e resta semplicemente "braccio per quantità di moto": $ell_(i,z)=R_i dot (m_i v_i)=m_i R_i v_i$. A questo punto sostituiamo $v_i=omega R_i$ (la relazione di prima): $ell_(i,z)=m_i R_i dot (omega R_i)=m_i R_i^2 omega$. Nota la comparsa di $R_i^2$: la distanza dall'asse entra *al quadrato*. Questo dettaglio sarà la chiave del momento d'inerzia.
]

Sommando tutte le particelle:

$ ell_z=sum_i ell_(i,z)=omega sum_i m_i R_i^2. $

#yellow-box([Perché $omega$ esce dalla somma])[
  La velocità angolare $omega$ è *la stessa per tutti i punti* (è la definizione di rotazione rigida), quindi è un fattore comune che possiamo raccogliere e portare fuori dalla somma: $sum_i m_i R_i^2 omega=omega sum_i m_i R_i^2$. Ciò che resta dentro la somma, $sum_i m_i R_i^2$, dipende solo da *come è fatto il corpo* (masse e distanze dall'asse), non da quanto velocemente gira. Tra poco gli daremo un nome: momento d'inerzia.
]

#align(center, graph-card([Rotazione attorno a un asse fisso: componente di $vec(ell)$], cetz.canvas({
  import cetz.draw: *
  // asse fisso z e verso della velocita' angolare
  line((1.25, 0.40), (1.25, 3.35), stroke: 1.25pt + ink, mark: (end: ">"))
  axis-label((1.40, 3.25), [$z$], placement: "west")
  arc((1.25, 3.02), start: 45deg, stop: 330deg, radius: 0.28, stroke: 1.0pt + red, mark: (end: ">"))
  axis-label((1.48, 3.05), [$vec(omega)$], placement: "west")

  // polo O, piano della circonferenza e particella i
  circle((1.25, 0.70), radius: 0.07, fill: ink, stroke: none)
  axis-label((1.05, 0.62), [$O$], placement: "east")
  circle((1.25, 1.70), radius: (2.15, 0.58), stroke: (paint: grid-color, thickness: 0.75pt, dash: "dashed"))
  circle((3.40, 1.70), radius: 0.10, fill: ink, stroke: none)
  axis-label((3.52, 1.52), [$m_i$], placement: "north")

  // vettore posizione e distanza dall'asse
  line((1.25, 0.70), (3.40, 1.70), stroke: 1.1pt + blue, mark: (end: ">"))
  line((1.25, 1.70), (3.40, 1.70), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((2.30, 1.03), [$vec(r)_i$], placement: "south")
  axis-label((2.33, 1.55), [$R_i$], placement: "north")

  // quantita' di moto tangente alla traiettoria
  line((3.40, 1.70), (3.40, 2.55), stroke: 1.2pt + green, mark: (end: ">"))
  axis-label((3.55, 2.45), [$m_i vec(v)_i$], placement: "west")

  // momento angolare e sua componente assiale
  line((3.40, 1.70), (2.60, 2.78), stroke: 1.15pt + gold, mark: (end: ">"))
  line((3.40, 1.70), (3.40, 2.78), stroke: 1.0pt + gold, mark: (end: ">"))
  line((2.60, 2.78), (3.40, 2.78), stroke: (paint: grid-color, thickness: 0.7pt, dash: "dashed"))
  axis-label((2.48, 2.86), [$vec(ell)_i$], placement: "east")
  axis-label((3.55, 2.70), [$ell_(i,z)$], placement: "west")

  axis-label((5.20, 2.25), [$ell_(i,z)=m_i R_i^2 omega$], placement: "west")
  axis-label((5.20, 1.48), [$ell_z=I_z omega$], placement: "west")
})))

== Momento d'inerzia

#green-box([L'idea prima della formula: la "massa per la rotazione"])[
  Sai già che la *massa* misura quanto un corpo è "pigro" a partire o fermarsi quando lo spingi: più massa, più fatica per accelerarlo. Il *momento d'inerzia* $I$ è la stessa identica idea, ma per la *rotazione*: misura quanto un corpo è "pigro" a iniziare o smettere di girare. È la "massa della rotazione".

  C'è però una novità cruciale: per girare, non conta solo *quanta* massa c'è, ma anche *dove* è messa rispetto all'asse. La massa lontana dall'asse "pesa" molto di più di quella vicina, e per giunta al quadrato.

  Prova quotidiana: tieni le braccia distese lungo i fianchi e fatti girare su una sedia da ufficio; poi allarga le braccia con due pesi in mano. Con le braccia larghe è molto più difficile cominciare a girare e fai più fatica a fermarti: hai aumentato il momento d'inerzia spostando massa lontano dall'asse, *senza* cambiare la tua massa totale. È lo stesso trucco con cui i pattinatori sul ghiaccio rallentano la trottola allargando le braccia.
]

Consideriamo una rotazione attorno a un asse fisso $z$. Per la particella $i$, la componente del momento angolare lungo l'asse è proporzionale a $omega$:

$ ell_(i,z)=m_i R_i^2 omega. $

Sommando su tutte le particelle:

$ ell_z=sum_i ell_(i,z)=sum_i m_i R_i^2 omega. $

Si definisce il *momento d'inerzia* rispetto all'asse $z$:

#blue-box([Momento d'inerzia rispetto all'asse $z$])[
  $ I_z=sum_i m_i R_i^2. $
]

#yellow-box([Leggere la formula: perché $R^2$ e non $R$])[
  $I_z=sum_i m_i R_i^2$ dice: prendi ogni pezzettino di massa $m_i$, moltiplicalo per il *quadrato* della sua distanza dall'asse $R_i^2$, e somma tutto. Il quadrato è la chiave: una massa a distanza doppia dall'asse contribuisce *quattro volte* tanto ($2^2=4$), una a distanza tripla *nove volte* tanto. Per questo "allontanare la massa dall'asse" fa crescere $I$ così in fretta. Unità di misura: $["kg"] dot ["m"]^2=["kg m"^2]$. Attenzione: $I$ non è una proprietà del corpo da solo, ma del corpo *rispetto a un certo asse*; cambi asse, cambia $I$.
]

Quindi

$ ell_z=I_z omega. $

#blue-box([La relazione chiave: $ell_z = I_z omega$])[
  Confrontala con la quantità di moto della traslazione, $p=m v$: lì la massa $m$ lega velocità $v$ e quantità di moto $p$. Qui il momento d'inerzia $I_z$ lega velocità angolare $omega$ e momento angolare $ell_z$, *con la stessa struttura*. Questo conferma che $I_z$ gioca per la rotazione esattamente il ruolo che la massa gioca per la traslazione.
]

Per un corpo continuo:

$ I_z=integral R^2 dif m=integral_V rho R^2 dif V. $

#yellow-box([Dal discreto al continuo])[
  Per un oggetto pieno la somma sui pezzettini diventa un integrale, esattamente come abbiamo fatto per la massa: $sum_i m_i R_i^2 arrow integral R^2 dif m$. Sostituendo $dif m=rho dif V$ si ottiene la forma con l'integrale di volume. In pratica: invece di sommare $m_i R_i^2$ su punti separati, "spalmiamo" la massa con continuità e integriamo $R^2$ pesato con la densità.
]

Il momento d'inerzia misura quanto la massa è distribuita lontano dall'asse: a parità di massa, più la massa è distante dall'asse, maggiore è $I$.

#purple-box([Esempio numerico: due manubri sull'asta])[
  Un'asta leggera (di massa trascurabile) porta due masse uguali $m=2 " kg"$ ciascuna. Ruota attorno a un asse al centro.

  *Masse vicine all'asse*, a $R=0,3 " m"$:
  $ I=m R^2+m R^2=2 dot (2 dot 0,3^2)=2 dot 0,18=0,36 " kg m"^2. $

  *Masse lontane*, a $R=0,6 " m"$ (distanza raddoppiata):
  $ I=2 dot (2 dot 0,6^2)=2 dot 0,72=1,44 " kg m"^2. $

  Stessa massa totale ($4 " kg"$), ma il momento d'inerzia è diventato *quattro volte* più grande solo raddoppiando la distanza. Ecco l'effetto del quadrato di $R$.
]

#blue-box([Momenti d'inerzia notevoli (da ricordare)])[
  Per i corpi omogenei più comuni, rispetto all'asse indicato, l'integrale dà questi risultati (tutti della forma "$M R^2$ moltiplicato per un numero puro"):
  - anello/cilindro cavo sottile, asse centrale: $I=M R^2$ (tutta la massa è sul bordo);
  - disco/cilindro pieno, asse centrale: $I=1/2 M R^2$;
  - sfera piena, asse per il centro: $I=2/5 M R^2$;
  - asta sottile di lunghezza $L$, asse al centro perpendicolare: $I=1/12 M L^2$.

  Confronto utile: a parità di $M$ e $R$, l'anello ha $I$ maggiore del disco, perché nell'anello *tutta* la massa è lontana dall'asse, mentre nel disco una parte è vicina al centro.
]

== Esempio: asse di simmetria e asse non principale

#green-box([L'idea prima della formula])[
  Fin qui abbiamo usato solo la componente $ell_z$ del momento angolare lungo l'asse. Ma il vettore $vec(ell)$ completo potrebbe puntare in una direzione diversa dall'asse di rotazione $vec(omega)$. Quando succede questo? Dipende da quanto il corpo è "bilanciato" rispetto all'asse.

  Se l'asse è un *asse di simmetria* (ad esempio l'asse centrale di un cilindro o di una ruota), per ogni pezzettino da un lato ce n'è uno uguale dall'altro: i loro contributi "storti" si annullano a vicenda e $vec(ell)$ risulta perfettamente allineato con $vec(omega)$. È il caso bello e semplice. Se invece l'asse è "storto" rispetto al corpo (asse non principale), i contributi non si bilanciano e $vec(ell)$ punta da un'altra parte: è il fenomeno che fa "ballare" una ruota d'auto non equilibrata.
]

Se l'asse di rotazione $z$ è un asse di simmetria del corpo, le componenti trasversali del momento angolare si cancellano a coppie. Rimane solo la componente lungo l'asse:

$ ell_perp=0, quad vec(ell) parallel vec(omega), quad vec(ell)=I_z vec(omega). $

#yellow-box([Cosa dicono questi tre pezzi])[
  $ell_perp=0$: la componente *perpendicolare* (trasversale) all'asse del momento angolare è nulla, perché si è cancellata a coppie. $vec(ell) parallel vec(omega)$: di conseguenza il vettore momento angolare è *parallelo* alla velocità angolare (puntano nella stessa direzione, quella dell'asse). $vec(ell)=I_z vec(omega)$: la relazione scalare $ell_z=I_z omega$ diventa allora una vera *uguaglianza tra vettori*, valida direzione compresa. È questa la condizione che ci permette, nella prossima sezione, di derivare la legge del moto rotatorio.
]

Se invece il corpo ruota attorno a un asse che non è principale, in generale $vec(ell)$ non è parallelo a $vec(omega)$. In quel caso la relazione scalare $ell=I omega$ non descrive completamente il moto.

#red-box([Attenzione: $vec(ell)=I vec(omega)$ non vale sempre])[
  La comoda formula $vec(ell)=I vec(omega)$ (vettore uguale vettore) è valida *solo* quando si ruota attorno a un asse principale, in particolare un asse di simmetria. Se l'asse è "storto", $vec(ell)$ e $vec(omega)$ non sono paralleli e non puoi più legarli con un singolo numero $I$. Negli esercizi di questo corso lavoreremo quasi sempre attorno ad assi di simmetria, quindi potrai usare $vec(ell)=I_z vec(omega)$: ma è bene sapere che è un caso particolare, non una legge universale.
]

#align(center, graph-card([Quando $vec(ell)$ è parallelo a $vec(omega)$], cetz.canvas({
  import cetz.draw: *
  // asse di simmetria
  axis-label((1.45, 3.28), [asse di simmetria], placement: "south")
  line((1.45, 0.55), (1.45, 2.88), stroke: 1.15pt + ink, mark: (end: ">"))
  circle((1.45, 1.70), radius: 0.62, stroke: 1.0pt + ink)
  line((0.65, 1.70), (2.25, 1.70), stroke: 0.85pt + ink)
  line((1.45, 1.70), (1.45, 2.62), stroke: 1.2pt + red, mark: (end: ">"))
  line((1.45, 1.70), (1.45, 2.28), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((1.82, 2.62), [$vec(omega)$], placement: "west")
  axis-label((0.78, 2.28), [$vec(ell)$], placement: "east")
  axis-label((1.45, 0.30), [$vec(ell)=I_z vec(omega)$], placement: "north")
  axis-label((0.58, 1.08), [$ell_perp=0$], placement: "north")

  // asse non principale
  axis-label((4.95, 3.28), [asse non principale], placement: "south")
  line((4.60, 0.55), (4.60, 2.88), stroke: 1.0pt + ink, mark: (end: ">"))
  catmull((4.05, 2.55), (4.95, 2.42), (5.08, 1.75), (4.75, 0.98), (3.95, 1.02), (3.72, 1.72), (4.05, 2.55), stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  line((4.60, 1.60), (4.60, 2.52), stroke: 1.2pt + red, mark: (end: ">"))
  line((4.60, 1.60), (5.35, 2.34), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((4.15, 2.52), [$vec(omega)$], placement: "east")
  axis-label((5.48, 2.38), [$vec(ell)$], placement: "west")
  axis-label((4.95, 0.30), [$vec(ell) != lambda vec(omega)$], placement: "north")
})))

== Legge del moto rotatorio

#green-box([L'idea prima della formula])[
  Siamo arrivati al risultato più importante di tutta la sezione. Per la traslazione tu sai che una forza fa accelerare un corpo: $F=m a$. Per la rotazione vale una legge che ha *esattamente la stessa forma*: un *momento torcente* $tau$ (la "forza che fa girare") fa accelerare angolarmente il corpo, e il momento d'inerzia $I$ prende il posto della massa: $tau=I alpha$.

  Cos'è il momento torcente $tau$? È la tendenza di una forza a far ruotare qualcosa. Quando apri una porta, non spingi a caso: spingi *lontano dai cardini* e *perpendicolarmente*. Quella stessa forza applicata vicino ai cardini non basterebbe ad aprirla. Il momento $tau$ tiene conto sia della forza sia di "quanto braccio" ha per far leva. L'accelerazione angolare $alpha$ (alfa) dice quanto rapidamente cambia la velocità angolare $omega$, cioè quanto in fretta il corpo "prende giri".
]

Se l'asse di rotazione è fisso e coincide con un asse di simmetria del corpo, il momento angolare è parallelo alla velocità angolare:

$ vec(ell)=I_z vec(omega). $

Derivando:

$ vec(tau)= (dif vec(ell))/(dif t)=I_z (dif vec(omega))/(dif t)=I_z vec(alpha). $

#yellow-box([Perché si deriva, e perché $I_z$ resta fuori])[
  La seconda equazione cardinale dice $vec(tau)=(dif vec(ell))/(dif t)$: il momento delle forze è la *rapidità con cui cambia* il momento angolare (la derivata rispetto al tempo). Partiamo da $vec(ell)=I_z vec(omega)$ e deriviamo entrambi i membri rispetto al tempo. Il momento d'inerzia $I_z$ è una *costante* (dipende solo da come è fatto il corpo e dall'asse, fissi nel tempo), quindi esce dalla derivata come un numero qualsiasi: $(dif)/(dif t)(I_z vec(omega))=I_z (dif vec(omega))/(dif t)$. Infine, per definizione la derivata della velocità angolare è l'*accelerazione angolare*: $(dif vec(omega))/(dif t)=vec(alpha)$. Mettendo insieme: $vec(tau)=I_z vec(alpha)$.
]

In forma scalare lungo l'asse:

#purple-box([Legge del moto rotatorio])[
  $ tau_z=I_z alpha. $
]

È l'analogo rotazionale di $F=m a$.

#green-box([L'analogia traslazione $arrow.l.r$ rotazione (da memorizzare)])[
  Ogni grandezza del moto lineare ha la sua "gemella" rotazionale. Capita l'analogia, hai capito metà del capitolo:

  #table(
    columns: (auto, auto),
    inset: 6pt,
    align: left,
    [*Traslazione (lineare)*], [*Rotazione (angolare)*],
    [posizione $x$], [angolo $theta$],
    [velocità $v$], [velocità angolare $omega$],
    [accelerazione $a$], [accelerazione angolare $alpha$],
    [massa $m$ (inerzia)], [momento d'inerzia $I$ (inerzia alla rotazione)],
    [forza $F$], [momento $tau$ (momento torcente)],
    [quantità di moto $p=m v$], [momento angolare $ell=I omega$],
    [$F=m a$], [$tau=I alpha$],
    [energia $E_k=1/2 m v^2$], [energia $E_k=1/2 I omega^2$],
  )

  Regola pratica: prendi una formula lineare che conosci e sostituisci ogni simbolo con la sua gemella della colonna destra. Ottieni la formula rotazionale corrispondente.
]

#purple-box([Esempio numerico: far girare un disco])[
  Un disco di momento d'inerzia $I=0,5 " kg m"^2$ è inizialmente fermo. Gli applichiamo un momento torcente costante $tau=2 " N m"$. L'accelerazione angolare è
  $ alpha=tau/I=(2)/(0,5)=4 " s"^(-2). $
  (È l'analogo di $a=F/m$.) Partendo da fermo, dopo $t=3 " s"$ la velocità angolare è
  $ omega=alpha t=4 dot 3=12 " s"^(-1), $
  esattamente come $v=a t$ nel moto rettilineo.
]

#yellow-box([Asse non simmetrico])[
  In generale $vec(ell)$ non è parallelo a $vec(omega)$. La relazione semplice $vec(ell)=I vec(omega)$ vale quando si ruota attorno a un asse principale di inerzia, per esempio un asse di simmetria.
]

== Energia cinetica rotazionale

#green-box([L'idea prima della formula])[
  Anche un corpo che gira sul posto, senza spostare il suo centro, possiede energia di movimento: pensa a un volano o a una mola che ruota velocissima, può fare lavoro e perfino far male. Questa è l'*energia cinetica di rotazione*. Per analogia con $E_k=1/2 m v^2$ della traslazione, ti aspetti $E_k=1/2 I omega^2$: massa $arrow$ momento d'inerzia, velocità $arrow$ velocità angolare. Ed è proprio così. Vediamo perché.
]

Per rotazione attorno a un asse fisso:

$ E_k=sum_i 1/2 m_i v_i^2
  =sum_i 1/2 m_i omega^2 R_i^2
  =1/2 I_z omega^2. $

#yellow-box([I tre passaggi spiegati])[
  *Primo* $=$: l'energia cinetica totale è la somma delle energie cinetiche $1/2 m_i v_i^2$ di tutti i pezzettini (l'energia è additiva).
  *Secondo* $=$: sostituiamo la velocità di ciascun pezzo con $v_i=omega R_i$, quindi $v_i^2=omega^2 R_i^2$. Otteniamo $sum_i 1/2 m_i omega^2 R_i^2$.
  *Terzo* $=$: $1/2$ e $omega^2$ sono comuni a tutti i termini (la $omega$ è la stessa per tutti), li raccogliamo fuori dalla somma: $1/2 omega^2 sum_i m_i R_i^2$. Ma $sum_i m_i R_i^2$ è proprio la definizione di $I_z$! Resta $1/2 I_z omega^2$.
]

Usando $ell_z=I_z omega$, si può anche scrivere

$ E_k=ell_z^2/(2 I_z). $

#yellow-box([Come si ottiene questa forma alternativa])[
  È solo un modo diverso di scrivere la stessa energia, comodo quando conosci il momento angolare invece della velocità angolare. Da $ell_z=I_z omega$ ricavi $omega=ell_z\/I_z$. Sostituisci in $E_k=1/2 I_z omega^2$: $E_k=1/2 I_z (ell_z\/I_z)^2=1/2 I_z ell_z^2\/I_z^2=ell_z^2\/(2 I_z)$. È l'analogo di $E_k=p^2\/(2m)$ per la traslazione.
]

#green-box([Energia di rotazione])[
  $ E_k=1/2 I_z omega^2. $
]

#purple-box([Esempio numerico: energia di un volano])[
  Un volano (disco pieno) ha $I_z=4 " kg m"^2$ e gira a $omega=20 " s"^(-1)$. La sua energia cinetica di rotazione è
  $ E_k=1/2 I_z omega^2=1/2 dot 4 dot 20^2=1/2 dot 4 dot 400=800 " J". $
  Sono $800$ joule immagazzinati solo nel girare: ecco perché i volani si usano per accumulare energia.
]

== Pendolo fisico

#green-box([L'idea prima della formula])[
  Questo è l'esempio finale, e mette insieme tutto: applica la legge del moto rotatorio $tau=I alpha$ a un corpo rigido che dondola. Il pendolo "fisico" non è la solita pallina appesa a un filo (quello è il pendolo *semplice*, dove tutta la massa è in un punto): è un *oggetto esteso* (un'asta, una tavola, una racchetta) appeso a un perno e libero di oscillare, come l'altalena del pendolo di un vecchio orologio a muro.

  L'idea fisica: quando lo sposti dalla verticale, la gravità tira giù il suo centro di massa e tende a riportarlo nella posizione di riposo. Ma per inerzia il corpo supera la posizione di equilibrio, e così oscilla avanti e indietro. Scriveremo l'equazione di questo moto e, per piccole oscillazioni, scopriremo che è il moto armonico già noto: da lì leggeremo il periodo.
]

Un *pendolo fisico* o *pendolo composto* è un corpo rigido che oscilla attorno a un punto fisso non coincidente con il centro di massa.

Indichiamo con:
- $O$ il punto di sospensione;
- $"CM"$ il centro di massa;
- $d$ la distanza tra $O$ e $"CM"$;
- $I$ il momento d'inerzia del corpo rispetto all'asse di rotazione passante per $O$.

Quando il corpo viene spostato di un angolo $theta$ dalla verticale, la forza peso $M vec(g)$ agisce sul centro di massa. La tensione o reazione del vincolo passa per il punto $O$, quindi non produce momento rispetto a $O$. Il momento torcente responsabile dell'oscillazione è quindi quello del peso:

$ vec(tau)=vec(r) times vec(F), $

dove $vec(r)$ va dal punto di sospensione al centro di massa. Il braccio del peso rispetto a $O$ vale $d sin theta$, quindi il modulo del momento del peso è $M g d sin theta$.

#yellow-box([Perché la reazione del perno "non conta" e da dove esce $d sin theta$])[
  La reazione del vincolo (la forza con cui il perno sostiene il corpo) è applicata *proprio in $O$*: il suo braccio rispetto a $O$ è zero, quindi il suo momento è zero ($tau=$ forza $times$ braccio $=0$). Per questo l'unica forza che fa girare il pendolo è il peso. Il *braccio* del peso è la distanza perpendicolare tra la retta lungo cui agisce il peso (verticale, passante per il CM) e il polo $O$. Con un po' di trigonometria sul triangolo formato da $O$, dal CM e dalla verticale, questa distanza vale $d sin theta$. Quindi il modulo del momento è (peso) $times$ (braccio) $= M g dot d sin theta$.
]

Il segno è negativo perché il momento è di richiamo: se $theta>0$, tende a riportare il corpo verso $theta=0$:

$ tau=-M g d sin theta, $

#yellow-box([Perché il segno meno è essenziale])[
  Scegliamo positivi gli angoli $theta$ in un verso. Il momento del peso tende sempre a riportare il corpo *verso* la verticale, cioè a *ridurre* $theta$: agisce nel verso opposto allo spostamento. Quando una "forza" punta sempre contro lo spostamento, nella formula compare un segno meno. È lo stesso meno della forza elastica $F=-k x$ della molla: senza quel meno non avresti oscillazioni ma un allontanamento, e tutta la fisica del pendolo crollerebbe.
]

La legge del moto rotatorio attorno all'asse fisso è

$ tau=I alpha=I (dif^2 theta)/(dif t^2). $

#yellow-box([Perché $alpha=(dif^2 theta)/(dif t^2)$])[
  L'accelerazione angolare $alpha$ è la derivata della velocità angolare, che a sua volta è la derivata dell'angolo: quindi $alpha$ è la *derivata seconda* dell'angolo rispetto al tempo, $alpha=(dif^2 theta)/(dif t^2)$. È l'esatto analogo rotazionale di $a=(dif^2 x)/(dif t^2)$ per il moto lineare. Applicando $tau=I alpha$ otteniamo $tau=I (dif^2 theta)/(dif t^2)$.
]

Quindi l'equazione esatta del pendolo fisico è

$ I (dif^2 theta)/(dif t^2)=-M g d sin theta. $

#yellow-box([Come si è formata questa equazione])[
  Abbiamo due espressioni per lo stesso momento $tau$: una "fisica" (il momento del peso, $-M g d sin theta$) e una "dinamica" (la legge del moto rotatorio, $I (dif^2 theta)/(dif t^2)$). Le uguagliamo, perché descrivono la stessa cosa: $I (dif^2 theta)/(dif t^2)=-M g d sin theta$. Questa è l'equazione del moto del pendolo, *esatta* (vale per qualunque ampiezza). Il problema è quel $sin theta$: rende l'equazione difficile da risolvere esattamente.
]

Per piccoli angoli, misurati in radianti, $sin theta approx theta$. L'equazione diventa

$ I (dif^2 theta)/(dif t^2)=-M g d theta. $

#yellow-box([L'approssimazione delle piccole oscillazioni])[
  Per angoli piccoli (in radianti) il seno di un angolo è quasi uguale all'angolo stesso: $sin theta approx theta$. Per esempio $sin(#[0,1]) approx 0,0998$, praticamente $0,1$. Sostituendo $sin theta$ con $theta$ l'equazione diventa *lineare* e quindi risolvibile in modo semplice. È un'ottima approssimazione finché le oscillazioni restano piccole (diciamo entro $10$-$15$ gradi).
]

Portando tutto al primo membro:

$ (dif^2 theta)/(dif t^2)+(M g d)/I theta=0. $

#yellow-box([Solo riarrangiamento algebrico])[
  Qui non succede niente di nuovo: dividiamo entrambi i membri per $I$ e portiamo il termine $-(M g d)/I theta$ a sinistra (cambiando segno diventa $+$). Lo scopo è mettere l'equazione nella forma "pulita" del moto armonico, in modo da riconoscerla a colpo d'occhio.
]

Questa ha la stessa forma dell'equazione del moto armonico,

$ theta''+omega^2 theta=0, $

perciò

$ omega^2=(M g d)/I. $

#yellow-box([Il confronto che dà la pulsazione])[
  L'equazione del moto armonico $theta''+omega^2 theta=0$ è quella che produce oscillazioni sinusoidali con pulsazione $omega$. Confrontandola *termine a termine* con la nostra $(dif^2 theta)/(dif t^2)+(M g d)/I theta=0$, il coefficiente di $theta$ deve coincidere: $omega^2=(M g d)/I$. Da qui $omega=sqrt((M g d)/I)$. Riconoscere la "forma" dell'equazione ci dà gratis la frequenza di oscillazione senza risolverla daccapo.
]

Qui $omega$ è la pulsazione delle piccole oscillazioni del pendolo fisico.

#red-box([Attenzione: due $omega$ diversi!])[
  In questa sezione il simbolo $omega$ ha cambiato significato. Nelle sezioni precedenti $omega$ era la *velocità angolare* di rotazione (quanto gira il corpo). Qui $omega=sqrt((M g d)/I)$ è la *pulsazione* dell'oscillazione (legata a quanto è rapido il dondolio: $omega=2pi\/T$). Sono due cose diverse che, per tradizione, si scrivono con la stessa lettera. Guarda sempre il contesto per capire quale dei due è.
]

Il periodo è

#green-box([Periodo del pendolo fisico])[
  $ T=2 pi sqrt(I/(M g d)). $
]

#yellow-box([Da $omega^2$ al periodo $T$])[
  Il periodo $T$ è il tempo di una oscillazione completa, legato alla pulsazione da $T=2pi\/omega$. Avendo $omega^2=(M g d)/I$, allora $omega=sqrt((M g d)/I)$ e quindi $T=2pi\/sqrt((M g d)/I)=2pi sqrt(I/(M g d))$ (l'inverso di una radice è la radice dell'inverso). Osserva il significato fisico: $I$ grande (corpo "pigro" a girare) $arrow$ $T$ grande, oscillazioni lente; $M g d$ grande (forza di richiamo più decisa) $arrow$ $T$ piccolo, oscillazioni rapide. Tutto coerente con l'intuizione.
]

#purple-box([Esempio numerico: asta che oscilla])[
  Un'asta omogenea di massa $M=0,5 " kg"$ e lunghezza $L=1 " m"$ è appesa per un estremo e oscilla. Il momento d'inerzia rispetto all'estremo è $I=1/3 M L^2=1/3 dot 0,5 dot 1^2 approx 0,167 " kg m"^2$. Il centro di massa è a metà asta, quindi $d=L\/2=0,5 " m"$. Con $g=9,81 " m/s"^2$:
  $ T=2pi sqrt(I/(M g d))=2pi sqrt((#[0,167])/(#[0,5] dot #[9,81] dot #[0,5])) approx 2pi sqrt(#[0,068]) approx 1,64 " s". $
]

#yellow-box([Confronto con il pendolo semplice])[
  Nel pendolo semplice la massa è concentrata a distanza $ell$ dal punto di sospensione, quindi $I=m ell^2$ e $d=ell$. Sostituendo nella formula del pendolo fisico:
  $ T=2 pi sqrt((m ell^2)/(m g ell))=2 pi sqrt(ell/g). $

  Quindi il pendolo semplice è un caso particolare del pendolo fisico.
]

Dal periodo misurato si può ricavare il momento d'inerzia del corpo rispetto all'asse di sospensione:

$ I=(T^2 M g d)/(4 pi^2). $

#yellow-box([Una formula utile in laboratorio])[
  Questa è solo la formula del periodo "girata" per ricavare $I$. Partendo da $T=2pi sqrt(I/(M g d))$, eleviamo al quadrato: $T^2=4pi^2 dot I/(M g d)$. Isolando $I$: $I=(T^2 M g d)/(4pi^2)$. È molto comoda nella pratica: misurare un *tempo* (il periodo $T$, cronometrando le oscillazioni) è facile e preciso, mentre calcolare $I$ con l'integrale per un oggetto di forma complicata sarebbe difficilissimo. Così facciamo oscillare il corpo, misuriamo $T$, e ricaviamo $I$ sperimentalmente.
]

#align(center, graph-card([Pendolo fisico], cetz.canvas({
  import cetz.draw: *
  // equilibrio
  line((1.10, 3.15), (1.10, 0.65), stroke: 0.9pt + ink)
  catmull((0.82, 2.70), (1.35, 2.55), (1.58, 1.85), (1.28, 1.00), (0.70, 0.78), (0.48, 1.62), (0.62, 2.42), (0.82, 2.70), stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  circle((1.10, 2.42), radius: 0.07, fill: ink, stroke: none)
  circle((1.10, 1.72), radius: 0.07, fill: red, stroke: none)
  axis-label((0.55, 1.66), [CM], placement: "east")
  line((1.10, 2.42), (1.10, 1.72), stroke: 0.85pt + gold, mark: (end: ">"))
  axis-label((1.22, 2.10), [$d$], placement: "west")
  axis-label((0.98, 0.48), [equilibrio], placement: "north")

  // spostato
  line((3.25, 3.15), (3.25, 0.65), stroke: 0.75pt + ink)
  line((3.25, 3.15), (4.30, 1.20), stroke: 1.0pt + ink)
  catmull((3.78, 2.55), (4.35, 2.35), (4.75, 1.65), (4.42, 0.90), (3.82, 0.92), (3.58, 1.72), (3.55, 2.35), (3.78, 2.55), stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  circle((3.25, 3.15), radius: 0.07, fill: ink, stroke: none)
  circle((4.05, 1.58), radius: 0.07, fill: red, stroke: none)
  line((3.25, 3.15), (4.05, 1.58), stroke: 0.9pt + blue, mark: (end: ">"))
  line((4.05, 1.58), (4.05, 0.62), stroke: 1.15pt + red, mark: (end: ">"))
  arc((3.25, 3.15), start: 270deg, stop: 300deg, radius: 0.55, stroke: 0.8pt + ink)
  axis-label((3.48, 2.45), [$theta$], placement: "west")
  axis-label((4.20, 0.72), [$M vec(g)$], placement: "west")
  axis-label((4.22, 1.62), [CM], placement: "west")
  axis-label((5.65, 2.20), [$tau=-M g d sin theta$], placement: "west")
  axis-label((5.65, 1.45), [$T=2 pi sqrt(I/(M g d))$], placement: "west")
})))

= Elettromagnetismo

L'elettromagnetismo studia i fenomeni dovuti alla carica elettrica e ai campi elettrici e magnetici. Iniziamo dal caso elettrostatico, cioè cariche ferme.

L'idea di base è questa: le cariche generano un campo elettrico nello spazio, e il campo elettrico esercita una forza sulle altre cariche. Per questo conviene distinguere sempre tra *cariche sorgenti*, che producono il campo, e *cariche di prova*, usate per misurarlo.

#green-box([L'idea prima di tutto: a cosa serve il "campo"])[
  Immagina di voler descrivere l'effetto di una carica su tutto lo spazio intorno a sé. Potresti dire: "se metto qui un'altra carica, sente questa forza; se la metto là, ne sente un'altra...". Ma è scomodo: la forza cambia se cambio la seconda carica. Allora si fa un trucco geniale: si separa *chi crea l'effetto* (la carica sorgente) da *chi lo subisce* (la carica di prova).

  La carica sorgente "tinge" tutto lo spazio di una proprietà invisibile, il *campo elettrico*, che esiste anche se nessuno è lì a sentirlo. Poi, quando arriva una carica di prova, basta moltiplicare il campo per la sua carica e ottieni la forza. È come avere una mappa del vento pronta: il vento c'è anche senza barche, ma se metti una vela sai subito quanta spinta riceve.

  Tieni a mente questa coppia di concetti per tutto il capitolo: il *campo* dice "come è fatto lo spazio", la *forza* dice "cosa succede a una carica messa lì dentro".
]

== Carica elettrica

Esistono due tipi di carica elettrica:

- cariche dello stesso segno si respingono;
- cariche di segno opposto si attraggono.

La carica si indica con $q$ e si misura in coulomb, $"C"$. La carica è semplicemente una proprietà della materia, come la massa: alcune particelle ne hanno, e questa proprietà è ciò che fa nascere le forze elettriche.

Per convenzione il protone ha carica positiva e l'elettrone ha carica negativa:

$ q_p=+e, quad q_e=-e, quad e approx 1.60 dot 10^(-19) " C". $

#yellow-box([Cosa significano questi simboli])[
  Il simbolo $e$ è la *carica elementare*: è la più piccola quantità di carica che si trova libera in natura. Vale circa $1,60 dot 10^(-19) " C"$, un numero piccolissimo. Questo ci dice che il coulomb è un'unità *enorme*: un solo coulomb corrisponde a circa $6 dot 10^(18)$ elettroni. Per questo nelle situazioni reali vedrai spesso microcoulomb ($mu"C"=10^(-6) " C"$) o nanocoulomb ($"nC"=10^(-9) " C"$).

  I segni $+$ ed $e -$ non indicano "più o meno carica", ma due *tipi opposti* di carica: è una pura convenzione storica aver chiamato positivo il protone. L'importante è il comportamento: uguali si respingono, opposti si attraggono.
]

#blue-box([Segno della forza elettrica])[
  Due cariche positive o due cariche negative generano una forza repulsiva. Una carica positiva e una negativa generano una forza attrattiva.
]

#align(center, graph-card([Attrazione e repulsione tra cariche], cetz.canvas({
  import cetz.draw: *
  circle((1.30, 2.10), radius: 0.22, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  circle((2.65, 2.10), radius: 0.22, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  axis-label((1.30, 2.10), [$+$])
  axis-label((2.65, 2.10), [$+$])
  line((1.10, 2.10), (0.45, 2.10), stroke: 1.15pt + red, mark: (end: ">"))
  line((2.85, 2.10), (3.50, 2.10), stroke: 1.15pt + red, mark: (end: ">"))
  axis-label((1.98, 2.55), [repulsione], placement: "south")

  circle((5.05, 2.10), radius: 0.22, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  circle((6.40, 2.10), radius: 0.22, stroke: 1.0pt + ink, fill: rgb("#edf3f8"))
  axis-label((5.05, 2.10), [$+$])
  axis-label((6.40, 2.10), [$-$])
  line((4.82, 2.10), (5.63, 2.10), stroke: 1.15pt + green, mark: (end: ">"))
  line((6.63, 2.10), (5.82, 2.10), stroke: 1.15pt + green, mark: (end: ">"))
  axis-label((5.72, 2.55), [attrazione], placement: "south")
})))

== Modi per elettrizzare un corpo

Un corpo può essere elettrizzato in tre modi principali.

*Strofinio.* Alcuni elettroni vengono trasferiti da un materiale all'altro: è una separazione meccanica di carica.

*Induzione.* Una carica esterna ridistribuisce le cariche in un corpo senza contatto diretto. Il corpo resta globalmente neutro se isolato, ma le cariche si separano spazialmente.

*Contatto.* Un corpo carico tocca un conduttore e trasferisce parte della propria carica.

Nei solidi ordinari sono soprattutto gli elettroni a spostarsi o trasferirsi: i protoni restano legati ai nuclei. Per questo un corpo diventa negativo se acquista elettroni e positivo se ne perde.

#align(center, graph-card([Elettrizzazione: strofinio, induzione, contatto], cetz.canvas({
  import cetz.draw: *
  // strofinio
  line((0.65, 1.00), (1.25, 1.55), stroke: 1.0pt + ink)
  rect((0.52, 0.85), (1.20, 1.15), stroke: 0.9pt + ink, fill: rgb("#fff4f4"))
  axis-label((0.86, 1.00), [$+$])
  catmull((1.45, 0.82), (1.85, 1.48), (2.25, 1.30), (2.38, 0.82), (1.86, 0.55), (1.45, 0.82), stroke: 1.0pt + ink, fill: rgb("#edf3f8"))
  axis-label((2.15, 1.05), [$-$])
  axis-label((1.45, 0.28), [strofinio], placement: "north")

  // induzione
  rect((3.05, 1.55), (3.55, 2.00), stroke: 0.9pt + ink, fill: rgb("#fff4f4"))
  axis-label((3.30, 1.78), [$+$])
  circle((4.45, 1.20), radius: 0.55, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  axis-label((4.05, 1.22), [$-$])
  axis-label((4.85, 1.22), [$+$])
  axis-label((4.20, 0.28), [induzione], placement: "north")

  // contatto
  rect((6.15, 1.55), (6.65, 2.00), stroke: 0.9pt + ink, fill: rgb("#fff4f4"))
  axis-label((6.40, 1.78), [$+$])
  circle((7.05, 1.20), radius: 0.55, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  for p in ((6.85, 1.20), (7.05, 1.42), (7.25, 1.04)) {
    axis-label(p, [$+$])
  }
  axis-label((6.78, 0.28), [contatto], placement: "north")
})))

== Atomo neutro e conservazione della carica

In un atomo neutro la carica positiva dei protoni bilancia la carica negativa degli elettroni:

$ abs(q_p)=abs(q_e). $

La carica totale di un sistema isolato si conserva. Questo significa che l'elettrizzazione non crea carica dal nulla: redistribuisce o trasferisce cariche già presenti nei costituenti elementari.

#green-box([Conservazione della carica])[
  In un sistema isolato la carica totale resta costante:
  $ Q_"tot"=sum_i q_i="costante". $
]

== Legge di Coulomb

#green-box([L'idea prima della formula])[
  La legge di Coulomb risponde a una domanda concreta: *quanto forte si attraggono o si respingono due cariche, e da cosa dipende?* L'esperienza dice due cose intuitive. Primo: più le cariche sono grandi, più la forza è intensa (raddoppio una carica, raddoppia la forza). Secondo: più le cariche sono lontane, più la forza si indebolisce, e si indebolisce *molto* in fretta. La struttura della formula traduce esattamente questo: prodotto delle cariche al numeratore, distanza al quadrato al denominatore.

  Il "quadrato" della distanza non è arbitrario: è la stessa legge della gravità di Newton. Vale perché l'effetto della carica si "spalma" su sfere sempre più grandi man mano che ci si allontana, e la superficie di una sfera cresce come $r^2$. Vedremo questa idea tornare con il teorema di Gauss.
]

Tra due cariche puntiformi $q_1$ e $q_2$ ferme agisce una forza centrale diretta lungo la congiungente tra le cariche. Il modulo è

$ abs(vec(F))=k abs(q_1 q_2)/r^2, $

dove

$ k=1/(4 pi epsilon_0). $

Qui $r$ è la distanza tra le due cariche (in metri) e le barrette $abs(...)$ indicano il valore assoluto: nel *modulo* della forza usiamo i valori senza segno, perché il modulo è sempre positivo. Il segno (cioè se è attrazione o repulsione) lo recupereremo dalla forma vettoriale qui sotto.

La costante $k$ vale numericamente

$ k=1/(4 pi epsilon_0) approx 9 dot 10^9 " N" "m"^2/"C"^2, $

ed è comoda quando si vogliono fare i conti rapidamente. La costante $epsilon_0$ è la *permittività elettrica del vuoto*:

$ epsilon_0 approx 8.85 dot 10^(-12) " C"^2/("N" "m"^2). $

#yellow-box([Perché compare proprio $4 pi epsilon_0$])[
  Sembra una complicazione inutile scrivere $1/(4 pi epsilon_0)$ invece di una singola lettera $k$. Il motivo è pratico: quel $4 pi$ è la stessa quantità che compare nell'area di una sfera ($4 pi r^2$). Mettendolo qui, sparisce nelle formule più importanti che incontreremo dopo (in particolare nel teorema di Gauss, dove resta solo $epsilon_0$). È un investimento: una formula leggermente più brutta ora, in cambio di molte formule più pulite dopo.
]

#purple-box([Esempio numerico: due cariche puntiformi])[
  Due cariche $q_1=2 dot 10^(-6) " C"$ e $q_2=3 dot 10^(-6) " C"$ (cioè $2 mu"C"$ e $3 mu"C"$) sono a distanza $r=0,1 " m"$. Quanto vale la forza?

  $ abs(vec(F))=k abs(q_1 q_2)/r^2=9 dot 10^9 dot (2 dot 10^(-6) dot 3 dot 10^(-6))/(0,1)^2. $

  Calcolo il numeratore: $2 dot 3=6$, e $10^(-6) dot 10^(-6)=10^(-12)$, quindi $q_1 q_2=6 dot 10^(-12)$. Il denominatore è $(0,1)^2=0,01=10^(-2)$. Allora

  $ abs(vec(F))=9 dot 10^9 dot (6 dot 10^(-12))/(10^(-2))=9 dot 6 dot 10^(9-12+2)=54 dot 10^(-1)=5,4 " N". $

  Una forza di circa $5,4 " N"$: l'equivalente del peso di una mela tenuta in mano. Entrambe le cariche sono positive, quindi è *repulsiva*.
]

In forma vettoriale, la forza esercitata da $q_1$ su $q_2$ è

#purple-box([Legge di Coulomb])[
  $ vec(F)_(1 -> 2)= (q_1 q_2)/(4 pi epsilon_0 r_(1 2)^2) hat(r)_(1 2). $
]

Qui $vec(r)_(1 2)=vec(r)_2-vec(r)_1$ e $hat(r)_(1 2)=vec(r)_(1 2)/abs(vec(r)_(1 2))$. Vale il principio di azione e reazione:

$ vec(F)_(1 -> 2)=-vec(F)_(2 -> 1). $

#yellow-box([Come leggere la forma vettoriale])[
  Il simbolo $hat(r)_(1 2)$ è un *versore*: una freccia lunga esattamente $1$, che serve solo a indicare una *direzione*, quella che va da $q_1$ verso $q_2$. Si ottiene prendendo il vettore $vec(r)_(1 2)$ (che congiunge le due cariche) e dividendolo per la sua lunghezza $abs(vec(r)_(1 2))$: così si butta via l'informazione sulla lunghezza e si tiene solo il "dove punta".

  Tutta la parte $(q_1 q_2)/(4 pi epsilon_0 r_(1 2)^2)$ è un *numero* (con segno!) che dà l'intensità; il versore $hat(r)_(1 2)$ ci attacca la direzione. Il colpo di genio è che il segno del numero gestisce automaticamente attrazione e repulsione, senza dover ricordare casi a memoria.
]

Il segno del prodotto $q_1 q_2$ decide il verso della forza nella formula vettoriale: se $q_1 q_2>0$ la forza su $q_2$ ha il verso di $hat(r)_(1 2)$, quindi è repulsiva; se $q_1 q_2<0$ ha verso opposto, quindi è attrattiva.

#red-box([Attenzione: modulo e segno non vanno mescolati])[
  Nella formula del *modulo* $abs(vec(F))=k abs(q_1 q_2)/r^2$ devi mettere i valori assoluti delle cariche: il modulo è sempre positivo. Se ci infili i segni rischi di ottenere una forza "negativa", che non ha senso come modulo. I segni servono solo nella formula *vettoriale*, dove decidono il verso. Regola pratica: prima calcola quanto è grande la forza (con i moduli), poi guarda i segni delle cariche per decidere se è attrazione o repulsione.
]

Per più cariche vale il principio di sovrapposizione: la forza totale è la somma vettoriale delle forze prodotte dalle singole cariche.

$ vec(F)_"tot su " q_0=sum_i vec(F)_(i -> 0). $

#yellow-box([Cosa vuol dire "sovrapposizione"])[
  Il principio di sovrapposizione dice una cosa potente e per niente ovvia: ogni carica spinge la nostra carica $q_0$ *come se le altre non esistessero*. Non c'è interferenza, nessuna carica "disturba" l'azione delle altre. Quindi per trovare la forza totale basta calcolare le forze una alla volta e poi *sommarle come frecce* (somma vettoriale: testa-coda, oppure per componenti $x$, $y$, $z$). Attenzione: è una somma di vettori, non di numeri; due forze uguali e opposte si annullano, due forze ad angolo retto si combinano con il teorema di Pitagora.
]

#align(center, graph-card([Legge di Coulomb: vettore relativo e forze], cetz.canvas({
  import cetz.draw: *
  // riferimento e posizioni delle due cariche
  line((0.75, 0.65), (2.05, 0.65), stroke: 0.85pt + ink, mark: (end: ">"))
  line((0.75, 0.65), (0.75, 1.85), stroke: 0.85pt + ink, mark: (end: ">"))
  line((0.75, 0.65), (0.20, 0.28), stroke: 0.85pt + ink, mark: (end: ">"))
  axis-label((0.60, 0.52), [$O$], placement: "east")
  axis-label((2.08, 0.50), [$y$], placement: "north")
  axis-label((0.58, 1.90), [$z$], placement: "east")
  axis-label((0.15, 0.18), [$x$], placement: "north")

  circle((3.15, 2.35), radius: 0.12, fill: ink, stroke: none)
  circle((5.85, 1.30), radius: 0.12, fill: ink, stroke: none)
  axis-label((3.05, 2.68), [$q_1$], placement: "south")
  axis-label((5.92, 1.58), [$q_2$], placement: "south")

  line((0.75, 0.65), (3.15, 2.35), stroke: 1.15pt + blue, mark: (end: ">"))
  line((0.75, 0.65), (5.85, 1.30), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((1.92, 1.70), [$vec(r)_1$], placement: "south")
  axis-label((3.33, 0.92), [$vec(r)_2$], placement: "north")

  // vettore relativo da q_1 a q_2
  line((3.15, 2.35), (5.85, 1.30), stroke: 1.15pt + gold, mark: (end: ">"))
  axis-label((4.70, 2.04), [$vec(r)_(1 2)=vec(r)_2-vec(r)_1$], placement: "south")

  // forze elettriche: esempio repulsivo per q_1 q_2 > 0
  line((5.85, 1.30), (7.00, 0.85), stroke: 1.35pt + red, mark: (end: ">"))
  line((3.15, 2.35), (2.00, 2.80), stroke: 1.35pt + red, mark: (end: ">"))
  axis-label((7.05, 0.88), [$vec(F)_(1 -> 2)$], placement: "west")
  axis-label((1.95, 2.82), [$vec(F)_(2 -> 1)$], placement: "east")

  axis-label((6.45, 2.70), [$vec(F)_(1 -> 2)= (q_1 q_2)/(4 pi epsilon_0 r_(1 2)^2) hat(r)_(1 2)$], placement: "west")
  axis-label((6.45, 2.02), [$vec(F)_(2 -> 1)=-vec(F)_(1 -> 2)$], placement: "west")
})))

== Campo elettrostatico

#green-box([L'idea prima della formula: il campo è una "collina"])[
  Ecco l'immagine mentale più utile di tutto il capitolo. Pensa a un paesaggio collinare. Il *campo elettrico* in un punto è come la *pendenza* del terreno lì: ti dice in che direzione "rotola" una pallina e quanto forte. Più la collina è ripida, più forte è il campo. La direzione del campo è la direzione di massima discesa.

  Una carica positiva è come la *cima* di una collina: lo spazio intorno "pende verso l'esterno", e una pallina (carica positiva di prova) viene spinta via, rotola in discesa allontanandosi. Una carica negativa è invece una *conca, un imbuto*: tutto pende verso il centro, e una pallina positiva ci rotola dentro, attratta.

  Tieni questa analogia: campo = pendenza (quanto e dove pende), e tra poco vedremo che il *potenziale* è la *quota* (l'altezza). Pendenza e altezza sono due facce della stessa collina.
]

Il campo elettrostatico descrive l'effetto prodotto nello spazio dalle cariche sorgenti. Per definirlo si immagina di mettere nel punto osservato una piccola carica di prova positiva $q_0$, così piccola da non modificare la distribuzione delle cariche sorgenti.

#blue-box([Campo elettrico])[
  $ vec(E)(vec(r)_0)=vec(F)_0/q_0 quad ["N"/"C"]. $
]

#yellow-box([Perché si divide per $q_0$])[
  La forza dipende sia dalla sorgente sia dalla carica di prova: se raddoppio $q_0$, la forza raddoppia. Ma io voglio una grandezza che descriva *solo lo spazio*, indipendente da quale carichino ci metto. Allora divido la forza per la carica di prova: il risultato è "forza per ogni coulomb di carica", e non dipende più da $q_0$. È come misurare la pendenza di una collina indipendentemente da quanto pesa la pallina che ci metti: la pendenza è una proprietà del terreno, non della pallina.

  La carica di prova deve essere "piccola" perché altrimenti il suo stesso campo sposterebbe le cariche sorgenti, falsando la misura: vogliamo *guardare* il campo, non disturbarlo.
]

Dove $vec(F)_0$ è la forza elettrica esercitata dalle cariche sorgenti sulla carica di prova posta in $vec(r)_0$. Quindi il campo elettrico è forza per unità di carica positiva.

#yellow-box([Come si legge il campo elettrico])[
  Il campo $vec(E)(vec(r)_0)$ non è una forza: è una grandezza vettoriale associata al punto $vec(r)_0$ dello spazio. Dice quale forza subirebbe una carica positiva unitaria posta in quel punto.

  Una volta noto il campo, la forza su una carica qualunque $q$ posta in quel punto è
  $ vec(F)=q vec(E). $
  Se $q>0$, la forza ha lo stesso verso del campo; se $q<0$, ha verso opposto.
]

La forza su una carica $q_0$ è quindi

$ vec(F)=q_0 vec(E). $

Questa è semplicemente la definizione del campo "letta al contrario": se conosco il campo in un punto, la forza su una carica qualunque $q_0$ messa lì si ottiene moltiplicando. È la formula che useremo sempre per passare dal campo alla forza.

Per una carica puntiforme $q$ posta nell'origine:

$ vec(E)(vec(r))=q/(4 pi epsilon_0 r^2) hat(r). $

#yellow-box([Da dove viene questa formula])[
  Non è una formula nuova: è la legge di Coulomb divisa per la carica di prova. La forza di Coulomb su $q_0$ è $vec(F)=(q q_0)/(4 pi epsilon_0 r^2) hat(r)$; dividendo per $q_0$ (per definizione di campo) la $q_0$ se ne va e resta proprio $vec(E)=q/(4 pi epsilon_0 r^2) hat(r)$. È il campo di una singola carica puntiforme: punta radialmente in fuori se $q>0$, verso il centro se $q<0$, e si indebolisce come $1/r^2$.
]

#purple-box([Esempio numerico: campo di una carica puntiforme])[
  Quanto vale il campo a $r=0,3 " m"$ da una carica $q=5 dot 10^(-9) " C"$ ($5 "nC"$)?

  $ E=k q/r^2=9 dot 10^9 dot (5 dot 10^(-9))/(0,3)^2. $

  Numeratore: $9 dot 10^9 dot 5 dot 10^(-9)=45$. Denominatore: $(0,3)^2=0,09$. Quindi

  $ E=45/(0,09)=500 " N"/"C". $

  Verso: radiale uscente, perché $q>0$. Se ora mettessi lì una carica $q_0=2 dot 10^(-9) " C"$, sentirebbe una forza $F=q_0 E=2 dot 10^(-9) dot 500=10^(-6) " N"$.
]

#align(center, graph-card([Campo di una carica puntiforme], cetz.canvas({
  import cetz.draw: *
  line((0.75, 0.65), (1.35, 0.65), stroke: 0.8pt + ink, mark: (end: ">"))
  line((0.75, 0.65), (0.75, 1.25), stroke: 0.8pt + ink, mark: (end: ">"))
  circle((1.45, 1.30), radius: 0.13, fill: ink, stroke: none)
  axis-label((1.45, 1.02), [$q$], placement: "north")
  circle((4.10, 2.10), radius: 0.07, fill: red, stroke: none)
  line((1.45, 1.30), (4.10, 2.10), stroke: (paint: ink, thickness: 0.9pt, dash: "dashed"), mark: (end: ">"))
  line((4.10, 2.10), (5.10, 2.48), stroke: 1.25pt + blue, mark: (end: ">"))
  axis-label((2.72, 1.95), [$vec(r)$], placement: "south")
  axis-label((5.18, 2.52), [$vec(E)(vec(r))$], placement: "west")
  axis-label((3.20, 0.78), [$vec(E)(vec(r))=q/(4 pi epsilon_0 r^2) hat(r)$], placement: "north")
})))

Per una distribuzione discreta di cariche sorgenti vale di nuovo la sovrapposizione: ogni carica crea il suo campo come se le altre non ci fossero, e i campi si sommano come frecce.

$ vec(E)(vec(r)_0)=sum_i q_i/(4 pi epsilon_0 r_(i 0)^2) hat(r)_(i 0), $

dove $vec(r)_(i 0)=vec(r)_0-vec(r)_i$ va dalla carica sorgente $q_i$ al punto di osservazione e $hat(r)_(i 0)=vec(r)_(i 0)/r_(i 0)$.

#yellow-box([Attenzione: questa è una somma di vettori])[
  Il simbolo $sum_i$ qui significa: calcola il vettore campo prodotto da $q_1$, poi quello di $q_2$, e così via, e *sommali come frecce*. In pratica, conviene scomporre ogni campo nelle sue componenti ($E_x$, $E_y$) e sommare separatamente le $x$ con le $x$ e le $y$ con le $y$. Non si sommano i moduli! Due campi uguali e opposti danno campo nullo anche se ognuno preso da solo è intenso (per esempio, esattamente a metà tra due cariche positive uguali il campo è zero).
]

#align(center, graph-card([Campo elettrico di sorgenti discrete], cetz.canvas({
  import cetz.draw: *
  circle((1.15, 1.10), radius: 0.09, fill: ink, stroke: none)
  axis-label((1.00, 0.86), [$q_1$], placement: "north")
  circle((1.90, 2.20), radius: 0.09, fill: ink, stroke: none)
  axis-label((1.78, 2.44), [$q_2$], placement: "south")
  circle((2.65, 0.85), radius: 0.09, fill: ink, stroke: none)
  axis-label((2.78, 0.62), [$q_i$], placement: "north")
  circle((3.70, 1.45), radius: 0.11, fill: red, stroke: none)
  axis-label((3.82, 1.24), [$vec(r)_0$], placement: "north")
  line((1.15, 1.10), (3.70, 1.45), stroke: 0.75pt + grid-color)
  line((1.90, 2.20), (3.70, 1.45), stroke: 0.75pt + grid-color)
  line((2.65, 0.85), (3.70, 1.45), stroke: 0.75pt + grid-color)
  line((3.70, 1.45), (4.35, 2.20), stroke: 1.0pt + green, mark: (end: ">"))
  line((3.70, 1.45), (4.55, 1.42), stroke: 1.0pt + green, mark: (end: ">"))
  line((3.70, 1.45), (4.20, 0.72), stroke: 1.0pt + green, mark: (end: ">"))
  line((3.70, 1.45), (5.10, 1.55), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((5.18, 1.62), [$vec(E)(vec(r)_0)$], placement: "west")
})))

== Distribuzioni continue di carica

#green-box([L'idea prima della formula])[
  Spesso la carica non è in pochi punti, ma spalmata su un filo, una piastra o un blocco di materiale. Sarebbe impossibile sommare miliardi di cariche una a una. Il trucco del calcolo infinitesimale: taglio l'oggetto in *infiniti pezzettini piccolissimi*, ognuno dei quali ha una carica minuscola $dif q$ e si comporta come una carica puntiforme. Sommo tutti i contributi. Quando i pezzi diventano infinitamente piccoli e infinitamente tanti, la somma $sum$ si trasforma in un *integrale* $integral$. È esattamente lo stesso passaggio che si fa per calcolare l'area sotto una curva.
]

Per distribuzioni continue si usa un elemento infinitesimo di carica $dif q$.

L'idea è sostituire una somma su tante cariche puntiformi con un integrale su una distribuzione continua. Ogni pezzettino di linea, superficie o volume contiene una piccola carica $dif q$ e produce un piccolo contributo $dif vec(E)$ al campo.

Le densità di carica più comuni sono:

$ dif q=lambda dif ell quad ["C"/"m"], $

$ dif q=sigma dif S quad ["C"/"m"^2], $

$ dif q=rho dif V quad ["C"/"m"^3]. $

#yellow-box([Cosa sono $lambda$, $sigma$, $rho$ e le loro unità])[
  Sono *densità di carica*: dicono quanta carica c'è per ogni unità di lunghezza, di superficie o di volume. Sono l'analogo della densità di massa.
  - $lambda$ (lambda): densità *lineare*, carica per metro di lunghezza, in $"C"/"m"$. Si usa per fili e bacchette. Per avere la carica di un pezzetto lungo $dif ell$, moltiplico: $dif q=lambda dif ell$.
  - $sigma$ (sigma): densità *superficiale*, carica per metro quadro, in $"C"/"m"^2$. Per piastre e superfici. Pezzetto di area $dif S$: $dif q=sigma dif S$.
  - $rho$ (rho): densità *volumica*, carica per metro cubo, in $"C"/"m"^3$. Per oggetti pieni. Pezzetto di volume $dif V$: $dif q=rho dif V$.

  La logica è sempre la stessa: densità $times$ "quanto pezzo prendo" $=$ carica del pezzo.
]

Il campo si ottiene integrando i contributi elementari. Se $vec(r)$ è il vettore dal piccolo elemento sorgente $dif q$ al punto di osservazione,

$ vec(E)(vec(r)_0)=1/(4 pi epsilon_0) integral (dif q)/r^2 hat(r). $

L'integrale diventa un integrale di linea, superficie o volume a seconda della distribuzione. In pratica si esprime $dif q$ tramite la densità giusta ($lambda dif ell$, $sigma dif S$ o $rho dif V$), si scrivono $r$ e $hat(r)$ in funzione della posizione del pezzetto, e si integra su tutta la distribuzione.

#align(center, graph-card([Campo prodotto da distribuzioni continue], cetz.canvas({
  import cetz.draw: *
  // distribuzione discreta
  axis-label((1.65, 2.75), [discreta], placement: "south")
  for p in ((0.80, 1.45), (1.20, 2.15), (1.75, 1.80), (2.20, 2.35), (2.35, 1.25), (1.50, 1.05)) {
    circle(p, radius: 0.055, fill: ink, stroke: none)
  }
  circle((3.10, 1.70), radius: 0.08, fill: red, stroke: none)
  line((1.20, 2.15), (3.10, 1.70), stroke: 0.75pt + grid-color, mark: (end: ">"))
  line((3.10, 1.70), (3.88, 2.25), stroke: 1.1pt + blue, mark: (end: ">"))
  axis-label((1.85, 2.02), [$vec(r)_(i 0)$], placement: "south")
  axis-label((3.92, 2.30), [$vec(E)(vec(r)_0)$], placement: "west")

  // distribuzione volumica
  axis-label((5.95, 2.75), [continua volumica], placement: "south")
  catmull((4.85, 1.15), (5.15, 2.25), (6.35, 2.50), (7.15, 1.85), (6.85, 0.95), (5.45, 0.75), (4.85, 1.15), stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  rect((5.75, 1.55), (6.10, 1.90), stroke: 0.85pt + ink, fill: rgb("#fbfcfd"))
  circle((7.75, 1.55), radius: 0.08, fill: red, stroke: none)
  line((5.93, 1.72), (7.75, 1.55), stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"), mark: (end: ">"))
  line((7.75, 1.55), (8.42, 2.08), stroke: 1.1pt + blue, mark: (end: ">"))
  axis-label((5.95, 2.02), [$dif q$], placement: "south")
  axis-label((6.78, 1.82), [$vec(r)$], placement: "south")
  axis-label((8.50, 2.12), [$vec(E)$], placement: "west")
})))

#align(center, graph-card([Densità lineare, superficiale e volumica], cetz.canvas({
  import cetz.draw: *
  // linea
  catmull((0.65, 1.65), (1.10, 1.90), (1.65, 1.72), (2.25, 2.05), stroke: 1.1pt + ink)
  line((1.22, 1.82), (1.70, 1.76), stroke: 1.7pt + gold)
  axis-label((1.48, 2.10), [$dif ell$], placement: "south")
  axis-label((1.42, 1.08), [$dif q=lambda dif ell$], placement: "north")
  axis-label((1.42, 0.65), [$lambda: "C"/"m"$], placement: "north")

  // superficie
  catmull((3.40, 1.35), (4.10, 1.95), (5.25, 1.82), (5.55, 1.25), (4.78, 0.95), (3.65, 1.05), (3.40, 1.35), stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  rect((4.35, 1.35), (4.70, 1.62), stroke: 0.85pt + ink, fill: rgb("#fbfcfd"))
  axis-label((4.52, 1.83), [$dif S$], placement: "south")
  axis-label((4.52, 0.65), [$dif q=sigma dif S$], placement: "north")
  axis-label((4.52, 0.25), [$sigma: "C"/"m"^2$], placement: "north")

  // volume
  catmull((6.55, 1.18), (6.95, 2.10), (7.95, 2.20), (8.62, 1.62), (8.38, 0.92), (7.15, 0.78), (6.55, 1.18), stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  rect((7.45, 1.42), (7.78, 1.75), stroke: 0.85pt + ink, fill: rgb("#fbfcfd"))
  axis-label((7.62, 1.95), [$dif V$], placement: "south")
  axis-label((7.62, 0.65), [$dif q=rho dif V$], placement: "north")
  axis-label((7.62, 0.25), [$rho: "C"/"m"^3$], placement: "north")
})))

== Forza elettrostatica conservativa

#green-box([L'idea prima della formula: tornare alla collina])[
  Riprendi l'immagine della collina. Se spingi una pallina su per un sentiero e poi la riporti giù allo stesso punto, alla fine non hai "guadagnato" né "perso" energia: tanta ne hai spesa salendo, tanta te ne restituisce scendendo. Questo è ciò che significa *forza conservativa*: il lavoro per andare da $A$ a $B$ dipende solo da *dove* parti e dove arrivi (cioè dalle quote), non dal *sentiero* scelto. E se torni al punto di partenza (percorso chiuso), il bilancio è zero.

  Da qui nasce l'idea di *energia potenziale* $U$: a ogni punto si può assegnare un numero (l'"altezza energetica") tale che il lavoro fatto dalla forza è la *discesa* di questo numero. Questo è prezioso: invece di calcolare integrali lungo percorsi complicati, basta guardare il valore di $U$ all'inizio e alla fine.
]

La forza elettrostatica di Coulomb è conservativa:

- il lavoro non dipende dal percorso;
- il lavoro lungo un percorso chiuso è nullo;
- esiste un'energia potenziale elettrostatica $U$.

Per due cariche puntiformi $Q$ e $q$:

$ vec(F)=Q q/(4 pi epsilon_0 r^2) hat(r). $

Nel lavoro compare il prodotto scalare $vec(F) dot dif vec(s)$. Poiché la forza di Coulomb è radiale, conta solo la parte dello spostamento nella direzione di $hat(r)$:

$ dif vec(s)=dif r hat(r)+"parte tangenziale"
  quad -> quad
  vec(F) dot dif vec(s)=F(r) dif r. $

La parte tangenziale dello spostamento non cambia la distanza $r$ dalla carica sorgente, quindi non contribuisce al lavoro. Per questo l'integrale lungo il percorso può essere riscritto come integrale tra le distanze $r_A$ e $r_B$.

#yellow-box([Perché solo la parte radiale conta])[
  Lo spostamento $dif vec(s)$ si può sempre scomporre in due pezzi: uno *radiale* (avvicinarsi o allontanarsi dalla carica, lungo $hat(r)$) e uno *tangenziale* (girarci intorno restando alla stessa distanza). Il prodotto scalare $vec(F) dot dif vec(s)$ prende solo la componente dello spostamento *parallela* alla forza. Ma la forza di Coulomb è puramente radiale (punta lungo $hat(r)$): è perpendicolare alla parte tangenziale, e una forza perpendicolare allo spostamento non compie lavoro. Risultato: solo lo spostamento radiale $dif r$ conta, e l'integrale lungo qualunque percorso curvo si riduce a un semplice integrale nella sola variabile $r$, da $r_A$ a $r_B$. È proprio *questo* il motivo per cui la forza è conservativa.
]

Il lavoro da $A$ a $B$ lungo un qualsiasi percorso è

$ L_(A B)=integral_A^B vec(F) dot dif vec(s)
  =integral_(r_A)^(r_B) Q q/(4 pi epsilon_0 r^2) dif r
  =Q q/(4 pi epsilon_0) (1/r_A-1/r_B). $

#yellow-box([Come si risolve quell'integrale])[
  L'integrale $integral 1/r^2 dif r$ è un classico: si scrive $1/r^2=r^(-2)$ e si applica la regola della potenza per integrare, che dà $r^(-1)/(-1)=-1/r$. Valutando tra $r_A$ e $r_B$:
  $ integral_(r_A)^(r_B) 1/r^2 dif r=[-1/r]_(r_A)^(r_B)=-1/r_B-(-1/r_A)=1/r_A-1/r_B. $
  Ecco perché compare $(1/r_A-1/r_B)$: è il "valore finale meno valore iniziale" della primitiva $-1/r$. La costante $Q q/(4 pi epsilon_0)$ è solo un fattore moltiplicativo che è uscito dall'integrale.
]

Poiché $L_(A B)=-Delta U$, l'energia potenziale può essere scelta come

#green-box([Energia potenziale elettrostatica])[
  $ U(r)=Q q/(4 pi epsilon_0 r)+C. $
]

#yellow-box([Perché $L=-Delta U$ e da dove spunta la costante $C$])[
  Per definizione, il lavoro di una forza conservativa è *meno* la variazione di energia potenziale: $L=-Delta U=-(U_B-U_A)=U_A-U_B$. Il segno meno ha senso fisico: se la forza compie lavoro positivo (spinge la carica nel verso "in discesa"), l'energia potenziale *cala*. Confrontando con il risultato dell'integrale, $L=Q q/(4 pi epsilon_0)(1/r_A-1/r_B)$, si vede che funziona prendendo $U(r)=Q q/(4 pi epsilon_0 r)$.

  La costante $C$ compare perché conta solo la *differenza* di potenziale, non il valore assoluto: posso scegliere dove mettere lo "zero" dell'energia, come decido da dove misurare le altezze (dal livello del mare? dal pavimento?). La scelta standard è mettere lo zero *all'infinito*: $U(infinity)=0$. Questo fa sparire $C$ ($C=0$) e lascia la formula pulita.
]

Se si sceglie $U(infinity)=0$, allora

$ U(r)=Q q/(4 pi epsilon_0 r). $

#align(center, graph-card([Lavoro della forza elettrostatica], cetz.canvas({
  import cetz.draw: *
  circle((0.90, 0.85), radius: 0.11, fill: ink, stroke: none)
  axis-label((0.72, 0.62), [$Q$], placement: "east")
  line((0.90, 0.85), (2.65, 2.05), stroke: 1.0pt + blue, mark: (end: ">"))
  line((0.90, 0.85), (4.55, 0.95), stroke: 1.0pt + blue, mark: (end: ">"))
  circle((2.65, 2.05), radius: 0.08, fill: ink, stroke: none)
  circle((4.55, 0.95), radius: 0.08, fill: ink, stroke: none)
  catmull((2.65, 2.05), (3.25, 1.55), (3.75, 1.25), (4.55, 0.95), stroke: 1.1pt + ink, mark: (end: ">"))
  line((2.65, 2.05), (3.35, 2.48), stroke: 1.15pt + red, mark: (end: ">"))
  axis-label((2.45, 2.25), [$A$], placement: "south")
  axis-label((4.70, 1.10), [$B$], placement: "west")
  axis-label((1.75, 1.68), [$r_A$], placement: "south")
  axis-label((2.72, 0.78), [$r_B$], placement: "north")
  axis-label((3.42, 2.55), [$vec(F)$], placement: "west")
  axis-label((5.55, 1.88), [$L_(A B)=-Delta U$], placement: "west")
  axis-label((5.55, 1.18), [$U(r)=Q q/(4 pi epsilon_0 r)$], placement: "west")
})))

== Significato del potenziale elettrostatico

Con la scelta $U(infinity)=0$, il valore

$ U(r)=Q q/(4 pi epsilon_0 r) $

misura il lavoro che la forza elettrostatica può compiere portando le cariche da distanza $r$ all'infinito, oppure l'opposto del lavoro esterno necessario per costruire il sistema portando le cariche dall'infinito a distanza $r$.

Se $Q q>0$, allora $U>0$: cariche dello stesso segno tendono ad allontanarsi.

Se $Q q<0$, allora $U<0$: cariche di segno opposto sono legate da un'interazione attrattiva.

== Potenziale elettrostatico

#green-box([L'idea prima della formula: il potenziale è la "quota"])[
  Torniamo alla collina, ma stavolta guardiamo l'*altezza* invece della pendenza. Il *potenziale* $V$ in un punto è come la *quota* di quel punto sulla collina: un numero (non una freccia!) che dice "quanto in alto sei energeticamente". Una carica positiva crea attorno a sé una "montagna" di potenziale (quota alta vicino, che cala allontanandosi); una carica negativa crea un "pozzo" di potenziale (quota bassa, una conca).

  Il legame con il campo è lo stesso che c'è tra altezza e pendenza: il *campo punta sempre nel verso in cui il potenziale scende più ripidamente*, cioè "in discesa". Una carica positiva libera rotola verso quote basse (potenziali bassi), una negativa "sale" verso quote alte. Capire questa coppia campo-potenziale (pendenza-quota) è la chiave di tutto il capitolo.
]

L'energia potenziale $U$ dipende dalla carica di prova $q_0$. Per descrivere lo spazio indipendentemente dalla carica usata come sonda, si definisce il *potenziale elettrostatico*

#blue-box([Potenziale elettrostatico])[
  $ V(vec(r))=U(vec(r))/q_0 quad ["V"]. $
]

#yellow-box([Stessa idea del campo: si divide per la carica di prova])[
  È esattamente la mossa che abbiamo fatto per il campo. L'energia potenziale $U$ dipende da *quale* carica di prova metto. Per ottenere una grandezza che descriva solo lo spazio, divido per $q_0$: ottengo l'energia potenziale "per ogni coulomb". Riassumendo la simmetria: il campo $vec(E)=vec(F)/q_0$ sta alla forza come il potenziale $V=U/q_0$ sta all'energia. Il campo è un vettore (è una pendenza, ha direzione), il potenziale è un numero (è una quota, basta un valore).
]

Il campo elettrico si misura in $"N"/"C"$, mentre il potenziale si misura in volt:

$ 1 " V"=1 " J"/"C". $

Il volt è quindi "joule per coulomb": se sposto $1$ coulomb attraverso una differenza di potenziale di $1$ volt, in gioco c'è $1$ joule di energia. È la stessa idea della pila da $9$ volt: ogni coulomb che la attraversa guadagna $9$ joule.

Poiché $L=-Delta U$, per una carica $q$ che si sposta tra $A$ e $B$:

$ L_(A B)=-q Delta V=-q (V_B-V_A). $

#yellow-box([Da $U$ a $V$ in un passaggio])[
  Questa formula viene direttamente da $U=q V$ (la definizione $V=U/q$ letta al contrario). Allora $Delta U=q Delta V$, e siccome $L=-Delta U$ si ottiene $L=-q Delta V$. In parole: il lavoro fatto dalla forza elettrica su una carica è la carica per la *caduta* di potenziale. Una carica positiva che "scende" da potenziale alto a basso ($V_B<V_A$) riceve lavoro positivo: come una pallina che rotola in discesa.
]

Per una carica unitaria positiva, la differenza di potenziale è il lavoro per unità di carica cambiato di segno.

#purple-box([Differenza di potenziale e campo])[
  $ V_B-V_A=-integral_A^B vec(E) dot dif vec(ell). $

  Qui $dif vec(ell)$ indica un piccolo spostamento vettoriale lungo il percorso da $A$ a $B$. Il prodotto scalare $vec(E) dot dif vec(ell)$ prende solo la componente del campo nella direzione dello spostamento.
]

#yellow-box([Cos'è questa formula e perché il segno meno])[
  È il legame quantitativo tra pendenza (campo) e quota (potenziale): per sapere quanto cambia l'altezza spostandomi da $A$ a $B$, sommo (integro) la pendenza lungo il cammino. Il segno meno c'è perché *muovendomi nel verso del campo, il potenziale scende*: il campo punta "in discesa", quindi seguirlo abbassa la quota. Se faccio il percorso al contrario (salendo controcorrente al campo) il potenziale aumenta.

  Da questa formula viene anche un controllo sulle unità: $E$ in $"N"/"C"$ per una lunghezza in $"m"$ dà $"N" "m"/"C"="J"/"C"="V"$, coerente. Per questo il campo si può anche misurare in volt al metro: $"N"/"C"="V"/"m"$.
]

Questa formula dice che il potenziale diminuisce nel verso del campo elettrico. Una carica positiva lasciata libera tende quindi a muoversi verso potenziali più bassi; una carica negativa tende invece nel verso opposto.

#align(center, graph-card([Da forza ed energia a campo e potenziale], cetz.canvas({
  import cetz.draw: *
  axis-label((0.85, 2.35), [$vec(F)_"el"$], placement: "south")
  line((1.20, 2.20), (2.55, 2.20), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((3.00, 2.35), [$U$], placement: "south")
  axis-label((1.82, 0.78), [dividi per $q_0$], placement: "north")
  line((1.20, 1.15), (2.55, 1.15), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((0.85, 1.30), [$vec(E)=vec(F)/q_0$], placement: "south")
  axis-label((3.00, 1.30), [$V=U/q_0$], placement: "south")

  axis-label((5.05, 2.15), [$L=integral vec(F) dot dif vec(ell)=-Delta U$], placement: "west")
  axis-label((5.05, 1.25), [$Delta V=Delta U/q$], placement: "west")
  axis-label((5.05, 0.62), [$L=-q Delta V$], placement: "west")
})))

== Potenziale di una carica puntiforme

Per una carica puntiforme $q$, il campo è radiale:

$ vec(E)=q/(4 pi epsilon_0 r^2) hat(r). $

Il potenziale rispetto a un riferimento $r_"rif"$ si ottiene integrando il campo:

$ V(r)-V(r_"rif")=-integral_(r_"rif")^r vec(E) dot dif vec(ell). $

Se il sistema è finito e si può scegliere il riferimento all'infinito,

$ r_"rif"=infinity, quad V(infinity)=0. $

Allora

$ V(r)=-integral_infinity^r q/(4 pi epsilon_0 r^2) dif r
  =q/(4 pi epsilon_0 r). $

#yellow-box([Conto dell'integrale passo passo])[
  Come prima, $integral 1/r^2 dif r=-1/r$. Quindi, portando fuori la costante $q/(4 pi epsilon_0)$:
  $ V(r)=-q/(4 pi epsilon_0)[-1/r]_infinity^r=-q/(4 pi epsilon_0)((-1/r)-(-1/infinity)). $
  Ma $1/infinity=0$ (siamo infinitamente lontani: il termine svanisce, ed è proprio per questo che lo zero all'infinito è una scelta comoda). Resta $-q/(4 pi epsilon_0)(-1/r)=q/(4 pi epsilon_0 r)$. I due segni meno si cancellano e si ottiene un potenziale positivo per $q>0$, come ci aspettiamo da una "montagna" di potenziale.
]

#green-box([Potenziale di una carica puntiforme])[
  $ V(r)=q/(4 pi epsilon_0 r) quad "con " V(infinity)=0. $
]

#red-box([Attenzione: il potenziale va come $1/r$, il campo come $1/r^2$])[
  Errore frequentissimo: confondere le due dipendenze dalla distanza. Il *campo* di una carica puntiforme va come $1/r^2$ (cala in fretta), il *potenziale* va come $1/r$ (cala più dolcemente). Se raddoppi la distanza, il campo diventa $1/4$ ma il potenziale diventa solo la metà. Un trucco per ricordarlo: il potenziale si ottiene *integrando* il campo, e integrare $1/r^2$ abbassa l'esponente, dando $1/r$.
]

#purple-box([Esempio numerico: potenziale di una carica puntiforme])[
  Qual è il potenziale a $r=0,2 " m"$ da una carica $q=4 dot 10^(-9) " C"$?
  $ V=k q/r=9 dot 10^9 dot (4 dot 10^(-9))/(0,2). $
  Numeratore: $9 dot 10^9 dot 4 dot 10^(-9)=36$. Quindi $V=36/(0,2)=180 " V"$. Se ci mettessi una carica $q_0=10^(-9) " C"$, la sua energia potenziale sarebbe $U=q_0 V=10^(-9) dot 180=1,8 dot 10^(-7) " J"$.
]

Il potenziale è positivo attorno a una carica positiva e negativo attorno a una carica negativa.

Il valore di $V$ non è una forza: descrive quanta energia potenziale avrebbe ogni coulomb di carica positiva messo in quel punto. La forza si ottiene solo dopo aver introdotto una carica di prova, tramite $vec(F)=q_0 vec(E)$.

#align(center, graph-card([Potenziale di una carica puntiforme], cetz.canvas({
  import cetz.draw: *
  line((0.85, 0.65), (1.45, 0.65), stroke: 0.8pt + ink, mark: (end: ">"))
  line((0.85, 0.65), (0.85, 1.25), stroke: 0.8pt + ink, mark: (end: ">"))
  circle((1.45, 1.10), radius: 0.13, fill: ink, stroke: none)
  axis-label((1.45, 0.82), [$q$], placement: "north")
  circle((3.55, 2.05), radius: 0.07, fill: red, stroke: none)
  line((1.45, 1.10), (3.55, 2.05), stroke: 1.0pt + blue, mark: (end: ">"))
  line((3.55, 2.05), (4.25, 2.38), stroke: 1.1pt + green, mark: (end: ">"))
  axis-label((2.48, 1.78), [$vec(r)$], placement: "south")
  axis-label((4.32, 2.42), [$vec(E)(vec(r))$], placement: "west")
  axis-label((5.35, 2.05), [$V(r)=q/(4 pi epsilon_0 r)$], placement: "west")
  axis-label((5.35, 1.25), [$V(infinity)=0$], placement: "west")
})))

== Potenziale di più cariche

#green-box([L'idea prima della formula: sommare quote è più facile])[
  Qui c'è un vantaggio enorme del potenziale rispetto al campo. Il campo è un vettore: per sommare i campi di più cariche devi fare somme di frecce, con angoli e componenti, faticoso. Il potenziale invece è un *numero*: per sommare i potenziali di più cariche basta sommare numeri con segno, come sommare quote. Per questo, quando un problema chiede il potenziale, conviene spesso calcolarlo direttamente con questa somma algebrica, ed eventualmente ricavare il campo dopo.
]

Il potenziale è una grandezza scalare, quindi la sovrapposizione è algebrica:

$ V(vec(r))=sum_i V_i(vec(r)). $

Qui non si sommano frecce, ma numeri con segno. Le cariche positive danno contributi positivi al potenziale, le cariche negative contributi negativi.

Per $N$ cariche puntiformi:

#purple-box([Potenziale di una distribuzione discreta])[
  $ V(vec(r))=1/(4 pi epsilon_0) sum_(i=1)^N q_i/abs(vec(r)-vec(r)_i). $
]

#purple-box([Esempio numerico: due cariche, somma algebrica])[
  Due cariche, $q_1=+3 dot 10^(-9) " C"$ a distanza $r_1=0,3 " m"$ dal punto $P$, e $q_2=-2 dot 10^(-9) " C"$ a distanza $r_2=0,2 " m"$ da $P$. Qual è il potenziale in $P$?

  Calcolo i due contributi:
  $ V_1=k q_1/r_1=9 dot 10^9 dot (3 dot 10^(-9))/(0,3)=27/(0,3)=90 " V", $
  $ V_2=k q_2/r_2=9 dot 10^9 dot (-2 dot 10^(-9))/(0,2)=(-18)/(0,2)=-90 " V". $

  Sommo *con i segni* (è una somma di numeri, non di vettori):
  $ V=V_1+V_2=90+(-90)=0 " V". $

  Il potenziale è zero in $P$, anche se nessuna delle due cariche è zero: i due contributi si cancellano. Nota però che il *campo* in $P$ non è zero, perché lì i vettori non si cancellano. Potenziale e campo rispondono a domande diverse.
]

Per una distribuzione continua, sommando i contributi degli elementi di carica sorgente:

$ V(vec(r))=1/(4 pi epsilon_0) integral (dif q)/abs(vec(r)-vec(r)_"s"). $

Il punto $vec(r)$ è il punto in cui si misura il potenziale; $vec(r)_"s"$ indica invece dove si trova il pezzetto di carica sorgente. Il denominatore è quindi la distanza tra sorgente e punto di osservazione.

Nel caso volumico, con $dif q=rho(vec(r)_"s") dif V_"s"$:

$ V(vec(r))=1/(4 pi epsilon_0) integral_V (rho(vec(r)_"s") dif V_"s")/abs(vec(r)-vec(r)_"s"). $

#align(center, graph-card([Sovrapposizione del potenziale], cetz.canvas({
  import cetz.draw: *
  // discrete
  axis-label((1.65, 2.80), [cariche puntiformi], placement: "south")
  for p in ((0.75, 1.15), (1.10, 2.10), (1.75, 1.75), (2.25, 2.28), (2.45, 1.05)) {
    circle(p, radius: 0.06, fill: ink, stroke: none)
  }
  circle((3.10, 1.65), radius: 0.08, fill: red, stroke: none)
  line((1.10, 2.10), (3.10, 1.65), stroke: 0.8pt + grid-color, mark: (end: ">"))
  axis-label((1.92, 2.06), [$vec(r)-vec(r)_i$], placement: "south")
  axis-label((3.30, 1.80), [$vec(r)$], placement: "west")
  axis-label((0.85, 0.55), [$V=sum_i V_i$], placement: "north")

  // continuous
  axis-label((5.95, 2.80), [distribuzione continua], placement: "south")
  catmull((4.85, 1.15), (5.20, 2.20), (6.30, 2.42), (7.10, 1.80), (6.82, 0.92), (5.38, 0.78), (4.85, 1.15), stroke: 1.0pt + ink, fill: rgb("#edf8ef"))
  rect((5.72, 1.55), (6.05, 1.88), stroke: 0.85pt + ink, fill: rgb("#fbfcfd"))
  circle((7.72, 1.45), radius: 0.08, fill: red, stroke: none)
  line((5.88, 1.72), (7.72, 1.45), stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"), mark: (end: ">"))
  axis-label((5.92, 2.04), [$dif q$], placement: "south")
  axis-label((6.80, 1.78), [$abs(vec(r)-vec(r)_"s")$], placement: "south")
  axis-label((7.86, 1.25), [$vec(r)$], placement: "north")
})))

== Linee di campo elettrico

#green-box([L'idea prima della formula])[
  Il campo è un vettore in *ogni* punto dello spazio: disegnarli tutti sarebbe un disastro di frecce. Le linee di campo sono un modo furbo per visualizzarlo: invece di mille frecce, traccio delle curve che "seguono" il campo, come i fili di lana che mostrano la direzione del vento o come la limatura di ferro attorno a un magnete. In ogni punto, la linea è tangente alla freccia del campo, e le frecce sulla linea ne danno il verso.
]

Le linee di campo sono curve tangenti al vettore $vec(E)$ in ogni punto. Sono uno strumento grafico per rappresentare direzione e verso del campo:

- escono dalle cariche positive;
- entrano nelle cariche negative;
- non si incrociano;
- in elettrostatica sono linee aperte: partono da cariche positive e finiscono su cariche negative oppure all'infinito.

La densità delle linee dà un'indicazione qualitativa del modulo del campo: dove le linee sono più fitte, il campo è più intenso. Non bisogna però contare le linee come oggetti fisici: sono una rappresentazione grafica.

#yellow-box([Perché "fitte" significa "campo forte"])[
  Pensa alle linee come ai fascetti di campo che escono dalle cariche. Vicino alla carica si accalcano in poco spazio: tante linee per centimetro, quindi campo intenso. Lontano, le stesse linee si distribuiscono su una superficie più grande e si diradano: poche per centimetro, campo debole. È la stessa idea del $1/r^2$: lo stesso "numero di linee" si spalma su una sfera di area $4 pi r^2$, quindi la densità (e il campo) cala come $1/r^2$.

  Le due regole "non si incrociano mai" e "tangenti al campo" vanno insieme: in ogni punto il campo ha *una sola* direzione, quindi non possono passarci due linee con direzioni diverse. Un incrocio significherebbe due campi in un punto, impossibile.
]

Per una carica puntiforme positiva le linee sono radiali uscenti. Per una carica negativa sono radiali entranti.

#align(center, graph-card([Linee di campo di cariche puntiformi], cetz.canvas({
  import cetz.draw: *
  circle((1.75, 1.70), radius: 0.20, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  axis-label((1.75, 1.70), [$+$])
  for a in (0deg, 45deg, 90deg, 135deg, 180deg, 225deg, 270deg, 315deg) {
    line((1.75, 1.70), (1.75 + 1.15 * calc.cos(a), 1.70 + 1.15 * calc.sin(a)), stroke: 1.0pt + red, mark: (end: ">"))
  }
  axis-label((1.75, 0.28), [radiali uscenti], placement: "north")

  circle((5.75, 1.70), radius: 0.20, stroke: 1.0pt + ink, fill: rgb("#edf3f8"))
  axis-label((5.75, 1.70), [$-$])
  for a in (0deg, 45deg, 90deg, 135deg, 180deg, 225deg, 270deg, 315deg) {
    line((5.75 + 1.15 * calc.cos(a), 1.70 + 1.15 * calc.sin(a)), (5.75, 1.70), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  axis-label((5.75, 0.28), [radiali entranti], placement: "north")
})))

== Superfici equipotenziali

#green-box([L'idea prima della formula: le curve di livello])[
  Ancora la collina. Su una cartina geografica le *curve di livello* uniscono i punti alla stessa quota: cammini lungo una di esse senza salire né scendere. Le superfici equipotenziali sono esattamente questo per il potenziale: insiemi di punti tutti alla stessa "quota energetica" $V$. Muoversi lungo una di esse non costa né rende lavoro, perché la quota non cambia. E proprio come sulla cartina la pendenza è sempre *perpendicolare* alle curve di livello (la massima salita è ortogonale al sentiero pianeggiante), il campo elettrico è sempre perpendicolare alle superfici equipotenziali.
]

Le superfici equipotenziali sono insiemi di punti in cui

$ V(vec(r))="costante". $

Se una carica si sposta lungo una superficie equipotenziale, $Delta V=0$ e quindi

$ L=-q Delta V=0. $

Muoversi lungo un'equipotenziale significa cambiare posizione senza cambiare energia potenziale elettrica. Per questo il campo non può avere una componente tangente alla superficie: altrimenti compirebbe lavoro lungo di essa.

Poiché $L=integral q vec(E) dot dif vec(s)$, il campo elettrico è perpendicolare alle superfici equipotenziali.

#yellow-box([Campo e superfici equipotenziali])[
  Le linee di campo elettrico sono sempre perpendicolari alle superfici equipotenziali.
]

Per una carica puntiforme, le superfici equipotenziali sono sfere concentriche; nel disegno piano diventano circonferenze concentriche.

#align(center, graph-card([Superfici equipotenziali di una carica puntiforme], cetz.canvas({
  import cetz.draw: *
  circle((3.20, 1.85), radius: 0.28, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  axis-label((3.20, 1.85), [$+$])
  circle((3.20, 1.85), radius: 0.72, stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  circle((3.20, 1.85), radius: 1.10, stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  circle((3.20, 1.85), radius: 1.48, stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  for a in (0deg, 45deg, 90deg, 135deg, 180deg, 225deg, 270deg, 315deg) {
    line((3.20, 1.85), (3.20 + 1.70 * calc.cos(a), 1.85 + 1.70 * calc.sin(a)), stroke: 0.95pt + red, mark: (end: ">"))
  }
  axis-label((4.20, 2.55), [$V_1$], placement: "south")
  axis-label((4.55, 2.88), [$V_2$], placement: "south")
  axis-label((4.95, 3.18), [$V_3$], placement: "south")
  axis-label((5.35, 1.85), [$vec(E)$], placement: "west")
  axis-label((3.20, 0.05), [equipotenziali $perp$ linee di campo], placement: "north")
})))

== Flusso del campo elettrico

#green-box([L'idea prima della formula: il flusso conta le linee])[
  Immagina che il campo elettrico sia un fluido in movimento (come acqua o vento) e che le linee di campo siano le sue correnti. Il *flusso* attraverso una superficie risponde a una domanda concreta: *quanta "roba" attraversa quella superficie al secondo?* È come tenere una retina nell'acqua di un fiume e chiedersi quanta acqua ci passa attraverso.

  Tre cose contano:
  - quanto è *intenso* il campo (corrente forte $arrow$ più passa);
  - quanto è *grande* la superficie (retina larga $arrow$ più passa);
  - come è *orientata* la superficie. E questo è il punto più importante: se tieni la retina di piatto, perpendicolare alla corrente, raccogli il massimo; se la giri di taglio, parallela alla corrente, l'acqua le scorre accanto senza attraversarla, flusso zero.

  In sintesi: il flusso è il "conteggio delle linee di campo che bucano la superficie". Tieni questa immagine: ci servirà per capire il teorema di Gauss.
]

Per misurare quante linee di campo attraversano una superficie orientata si introduce il *flusso* di $vec(E)$.

L'elemento di superficie si scrive come vettore

$ dif vec(S)=hat(n) dif S, $

dove $hat(n)$ è il versore normale alla superficie. Il flusso elementare è

#yellow-box([Perché la superficie diventa un vettore])[
  Strano: una superficie è un'area, un numero, perché farla diventare una freccia? Perché di una superficie, per il flusso, conta anche *come è orientata nello spazio*. Allora la si rappresenta con un vettore $dif vec(S)$ che ha per *lunghezza* l'area $dif S$ e per *direzione* la normale $hat(n)$, cioè la freccia perpendicolare alla superficie (la direzione in cui la retina "guarda"). Così, con un solo oggetto, racchiudo sia "quanto è grande" sia "verso dove è girata".
]

#blue-box([Flusso elementare])[
  $ dif Phi(vec(E))=vec(E) dot dif vec(S)=E cos theta dif S. $
]

#yellow-box([Da dove esce quel $cos theta$])[
  Il prodotto scalare $vec(E) dot dif vec(S)$ è, per definizione, $E dot dif S dot cos theta$, dove $theta$ è l'angolo *tra le due frecce*: il campo $vec(E)$ e la normale $hat(n)$. Il coseno è proprio ciò che "premia" l'orientamento giusto:
  - se la superficie è perpendicolare al campo, la normale è parallela a $vec(E)$, $theta=0$, $cos 0=1$: flusso massimo (la retina di piatto contro la corrente);
  - se la superficie è parallela al campo, la normale è perpendicolare a $vec(E)$, $theta=90 degree$, $cos 90 degree=0$: flusso nullo (la retina di taglio).

  Il $cos theta$ estrae la *componente del campo perpendicolare alla superficie*: solo quella la attraversa davvero, la componente che scorre lungo la superficie non la buca.
]

L'angolo $theta$ è l'angolo tra il campo $vec(E)$ e la normale $hat(n)$, non l'angolo tra il campo e la superficie. Per questo motivo conta solo la componente di $vec(E)$ perpendicolare alla superficie.

Il flusso attraverso una superficie estesa è la somma dei contributi elementari:

#purple-box([Flusso attraverso una superficie])[
  $ Phi(vec(E))=integral_S vec(E) dot dif vec(S). $
]

Se la superficie è chiusa, per convenzione $hat(n)$ è sempre la normale uscente.

Con una superficie chiusa il flusso è un bilancio: le linee che escono danno contributo positivo, quelle che entrano danno contributo negativo. Il flusso netto misura quindi quanto campo esce complessivamente dalla superficie, non quanto campo passa in totale ignorando il verso.

#yellow-box([Il flusso netto è un bilancio di entrate e uscite])[
  Su una superficie chiusa (immagina un palloncino) la normale punta sempre verso fuori. Allora una linea che *esce* è concorde con la normale ($cos theta>0$) e conta $+$; una linea che *entra* è discorde ($cos theta<0$) e conta $-$. Il flusso netto è la differenza "linee uscite meno linee entrate". È come un tornello che conta chi esce meno chi entra da una stanza: se il conteggio è positivo, dentro c'è una *sorgente* che produce linee; se è negativo, c'è un *pozzo* che le assorbe; se è zero, tutto ciò che entra esce. Questa intuizione è il cuore del teorema di Gauss.
]

L'unità di misura del flusso è $"N" "m"^2/"C"$, equivalente a $"V" "m"$.

#align(center, graph-card([Elemento di superficie e flusso], cetz.canvas({
  import cetz.draw: *
  // elemento orientato
  catmull((0.55, 1.20), (1.05, 1.70), (1.85, 1.88), (2.45, 1.42), (2.02, 0.95), (1.15, 0.85), (0.55, 1.20), stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  for x in (0.92, 1.20, 1.48, 1.76, 2.04) {
    line((x - 0.18, 1.10), (x + 0.18, 1.75), stroke: 0.55pt + red)
  }
  line((2.35, 1.42), (3.05, 1.42), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((3.15, 1.48), [$dif vec(S)=hat(n) dif S$], placement: "west")
  axis-label((1.50, 0.55), [elemento orientato], placement: "north")

  // superficie estesa
  catmull((4.25, 1.12), (4.65, 1.82), (5.25, 1.65), (5.70, 1.88), (6.38, 1.55), (6.12, 0.95), (5.48, 1.06), (4.85, 0.80), (4.25, 1.12), stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  for x in (4.62, 4.94, 5.26, 5.58, 5.90) {
    line((x - 0.18, 1.05), (x + 0.18, 1.66), stroke: 0.55pt + red)
  }
  axis-label((5.28, 2.30), [$dif Phi=vec(E) dot dif vec(S)$], placement: "south")
  axis-label((5.28, 0.55), [$Phi=integral_S vec(E) dot dif vec(S)$], placement: "north")
})))

== Casi geometrici del flusso

Il flusso dipende dall'angolo tra il campo e la normale alla superficie:

- è massimo se $vec(E)$ è parallelo a $hat(n)$;
- vale $E cos theta dif S$ se la superficie è inclinata;
- è nullo se $vec(E)$ è tangente alla superficie.

Il caso di flusso nullo non significa necessariamente che il campo sia nullo: significa che il campo scorre lungo la superficie e non la attraversa.

#align(center, graph-card([Flusso massimo, obliquo e nullo], cetz.canvas({
  import cetz.draw: *
  // massimo
  axis-label((1.10, 2.60), [flusso massimo], placement: "south")
  for y in (1.40, 1.78, 2.16) {
    line((0.35, y), (1.05, y), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  catmull((1.28, 1.25), (1.62, 1.45), (1.62, 2.30), (1.28, 2.48), (1.28, 1.25), stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  for y in (1.45, 1.78, 2.11) {
    line((1.32, y), (1.58, y + 0.18), stroke: 0.55pt + red)
  }
  line((1.60, 1.86), (2.25, 1.86), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((0.35, 2.45), [$vec(E)$], placement: "west")
  axis-label((2.32, 1.92), [$hat(n)$], placement: "west")
  axis-label((1.28, 0.72), [$dif Phi=E dif S$], placement: "north")

  // obliquo
  axis-label((4.05, 2.60), [flusso obliquo], placement: "south")
  for y in (1.40, 1.78, 2.16) {
    line((3.00, y), (3.70, y), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  line((4.10, 1.20), (4.60, 2.35), stroke: 1.0pt + ink)
  line((4.60, 2.35), (5.05, 2.08), stroke: 1.0pt + ink)
  line((5.05, 2.08), (4.55, 0.95), stroke: 1.0pt + ink)
  line((4.55, 0.95), (4.10, 1.20), stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  line((4.58, 1.78), (5.20, 2.18), stroke: 1.05pt + ink, mark: (end: ">"))
  line((4.58, 1.78), (5.25, 1.78), stroke: 0.9pt + blue, mark: (end: ">"))
  arc((4.58, 1.78), radius: 0.28, start: 0deg, stop: 32deg, stroke: 0.75pt + ink)
  axis-label((5.28, 2.23), [$hat(n)$], placement: "west")
  axis-label((5.32, 1.78), [$vec(E)$], placement: "west")
  axis-label((4.88, 2.02), [$theta$], placement: "south")
  axis-label((4.12, 0.52), [$dif Phi=E cos theta dif S$], placement: "north")

  // nullo
  axis-label((7.10, 2.60), [flusso nullo], placement: "south")
  for y in (1.40, 1.78, 2.16) {
    line((6.05, y), (6.75, y), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  line((6.95, 1.32), (8.05, 1.32), stroke: 1.0pt + ink)
  line((8.05, 1.32), (8.32, 1.75), stroke: 1.0pt + ink)
  line((8.32, 1.75), (7.20, 1.75), stroke: 1.0pt + ink)
  line((7.20, 1.75), (6.95, 1.32), stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  line((7.60, 1.53), (7.60, 2.25), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((7.72, 2.28), [$hat(n)$], placement: "west")
  axis-label((8.00, 0.72), [$dif Phi=0$], placement: "north")
})))

Per una superficie chiusa il segno del flusso indica il verso di attraversamento:

- $Phi>0$ se il campo è uscente;
- $Phi<0$ se il campo è entrante.

#align(center, graph-card([Segno del flusso su superficie chiusa], cetz.canvas({
  import cetz.draw: *
  catmull((1.40, 0.75), (1.05, 1.25), (1.35, 1.92), (1.85, 2.20), (2.18, 1.68), (2.05, 1.05), (1.40, 0.75), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  line((1.68, 1.48), (0.85, 1.48), stroke: 1.05pt + blue, mark: (end: ">"))
  line((1.68, 1.48), (1.12, 2.04), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((0.78, 1.48), [$vec(E)$], placement: "east")
  axis-label((1.02, 2.12), [$hat(n)$], placement: "east")
  axis-label((1.58, 0.32), [$Phi>0$ uscente], placement: "north")

  catmull((5.15, 0.75), (4.80, 1.25), (5.10, 1.92), (5.60, 2.20), (5.93, 1.68), (5.80, 1.05), (5.15, 0.75), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  line((4.28, 1.48), (5.25, 1.48), stroke: 1.05pt + blue, mark: (end: ">"))
  line((5.43, 1.48), (4.88, 2.04), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((4.22, 1.48), [$vec(E)$], placement: "east")
  axis-label((4.78, 2.12), [$hat(n)$], placement: "east")
  axis-label((5.38, 0.32), [$Phi<0$ entrante], placement: "north")
})))

== Flusso generato da una carica puntiforme

#green-box([L'idea prima della formula])[
  Vogliamo dimostrare un fatto sorprendente: il flusso del campo di una carica attraverso una superficie chiusa *non dipende* dalla forma della superficie, ma solo dalla carica racchiusa. Sembra magia, ma c'è una ragione precisa: andando più lontano il campo si indebolisce come $1/r^2$, ma la superficie attraversata cresce come $r^2$. I due effetti si compensano *esattamente*. È come dire: una lampadina vista da lontano è più debole, ma riempie un'area più grande del tuo campo visivo; la luce totale che ti raggiunge è la stessa. Lo strumento per formalizzare questo "campo visivo" è l'*angolo solido*.
]

Consideriamo una carica puntiforme $q$ e una superficie qualsiasi. Il campo prodotto dalla carica è

$ vec(E)=q/(4 pi epsilon_0 r^2) hat(r). $

Il flusso elementare attraverso $dif vec(S)$ è

$ dif Phi=vec(E) dot dif vec(S)
  =q/(4 pi epsilon_0 r^2) hat(r) dot dif vec(S). $

La quantità

$ dif Omega=(hat(r) dot dif vec(S))/r^2 $

è l'angolo solido sotto cui la carica vede l'elemento di superficie. Il termine $hat(r) dot dif vec(S)$ è la proiezione dell'elemento di superficie sul piano perpendicolare alla direzione radiale. Quindi

L'angolo solido è l'analogo tridimensionale dell'angolo piano: misura quanto una superficie appare "aperta" vista dalla carica. A parità di carica, il flusso dipende da questa apertura apparente.

#green-box([Flusso e angolo solido])[
  $ dif Phi=q/(4 pi epsilon_0) dif Omega. $
]

#align(center, graph-card([Flusso di una carica puntiforme e angolo solido], cetz.canvas({
  import cetz.draw: *
  circle((0.85, 1.10), radius: 0.10, fill: ink, stroke: none)
  axis-label((0.72, 0.86), [$q$], placement: "north")
  line((0.85, 1.10), (4.42, 2.38), stroke: 0.85pt + ink)
  line((0.85, 1.10), (4.20, 0.82), stroke: 0.85pt + ink)
  line((0.85, 1.10), (3.95, 1.62), stroke: 1.05pt + blue, mark: (end: ">"))
  axis-label((2.40, 1.58), [$r$], placement: "south")
  catmull((4.12, 0.82), (4.55, 1.20), (4.62, 2.05), (4.38, 2.45), stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  for y in (1.08, 1.40, 1.72, 2.04) {
    line((4.18, y), (4.48, y + 0.20), stroke: 0.55pt + red)
  }
  line((4.36, 1.62), (5.05, 1.82), stroke: 1.05pt + ink, mark: (end: ">"))
  line((4.36, 1.62), (5.10, 1.62), stroke: 1.05pt + blue, mark: (end: ">"))
  axis-label((5.12, 1.86), [$hat(n)$], placement: "west")
  axis-label((5.18, 1.62), [$vec(E)$], placement: "west")
  axis-label((4.68, 0.58), [$dif vec(S)$], placement: "north")
  axis-label((2.65, 0.58), [$dif Omega$], placement: "north")
  axis-label((6.05, 1.78), [$dif Phi=q/(4 pi epsilon_0) dif Omega$], placement: "west")
})))

Su una superficie chiusa che contiene la carica, la somma degli angoli solidi è

$ integral dif Omega=4 pi. $

#yellow-box([Perché esce proprio $4 pi$])[
  L'angolo solido totale di "tutto ciò che mi circonda" è $4 pi$ steradianti, esattamente come l'angolo piano di un giro completo è $2 pi$ radianti. Da dove viene? L'angolo solido è l'area vista divisa per $r^2$; una sfera di raggio $r$ ha area $4 pi r^2$, quindi guardando dal centro tutta la sfera si sottende un angolo solido $(4 pi r^2)/r^2=4 pi$. Una superficie chiusa qualunque che contiene la carica copre comunque tutte le direzioni una volta sola, quindi dà sempre $4 pi$, indipendentemente dalla forma. È qui che la magia diventa conto.
]

Perciò il flusso totale vale

#yellow-box([Flusso di una carica interna])[
  $ Phi=integral_S vec(E) dot dif vec(S)
    =q/(4 pi epsilon_0) integral dif Omega
    =q/epsilon_0. $
]

#blue-box([Risultato chiave: il flusso dipende solo dalla carica])[
  Guarda l'ultimo passaggio: $integral dif Omega=4 pi$ si semplifica con il $4 pi$ al denominatore, e resta solo $q/epsilon_0$. Sparisce ogni traccia della distanza, della forma della superficie, di tutto. Il flusso di una carica racchiusa vale *sempre* $q/epsilon_0$. Ecco perché conveniva tenere il $4 pi$ nella costante di Coulomb: qui si cancella e lascia una formula pulitissima. Questo risultato, generalizzato, è il teorema di Gauss.
]

Se invece la carica è esterna alla superficie chiusa, ogni fascio di campo entra ed esce: il contributo entrante e quello uscente si compensano, quindi il flusso netto è nullo.

#yellow-box([Perché una carica esterna dà flusso nullo])[
  Se la carica sta fuori dalla superficie chiusa, ogni linea di campo che entra da un lato deve per forza uscire dall'altro: la superficie non racchiude la sorgente, quindi non c'è nessuna sorgente "interna" che produca linee. Nel bilancio del tornello, entrate e uscite si pareggiano esattamente: $Phi=0$. Attenzione: questo *non* vuol dire che il campo sia nullo sulla superficie (la carica esterna un campo lo fa eccome), ma solo che il suo *flusso netto* è zero.
]

#align(center, graph-card([Carica interna ed esterna a una superficie chiusa], cetz.canvas({
  import cetz.draw: *
  // carica interna
  axis-label((1.72, 2.95), [carica interna], placement: "south")
  catmull((0.72, 0.82), (0.55, 1.72), (1.05, 2.55), (2.10, 2.60), (2.78, 1.88), (2.55, 0.85), (1.55, 0.55), (0.72, 0.82), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  circle((1.55, 1.55), radius: 0.10, fill: ink, stroke: none)
  axis-label((1.40, 1.30), [$q$], placement: "north")
  for p in ((1.55, 2.45), (2.35, 1.92), (2.25, 0.95), (0.92, 0.95), (0.82, 1.95)) {
    line((1.55, 1.55), p, stroke: 0.95pt + blue, mark: (end: ">"))
  }
  axis-label((1.72, 0.22), [$Phi=q/epsilon_0$], placement: "north")

  // carica esterna
  axis-label((6.00, 2.95), [carica esterna], placement: "south")
  circle((4.10, 1.55), radius: 0.10, fill: ink, stroke: none)
  axis-label((3.92, 1.30), [$q$], placement: "north")
  catmull((5.58, 0.82), (5.35, 1.70), (5.90, 2.45), (6.75, 2.35), (7.12, 1.62), (6.82, 0.82), (5.58, 0.82), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  line((4.10, 1.55), (5.55, 1.20), stroke: 0.95pt + blue, mark: (end: ">"))
  line((5.55, 1.20), (6.95, 0.88), stroke: 0.95pt + blue, mark: (end: ">"))
  line((4.10, 1.55), (5.55, 1.88), stroke: 0.95pt + blue, mark: (end: ">"))
  line((5.55, 1.88), (6.95, 2.18), stroke: 0.95pt + blue, mark: (end: ">"))
  axis-label((5.42, 1.02), [entra], placement: "north")
  axis-label((6.92, 0.65), [esce], placement: "north")
  axis-label((6.05, 0.22), [$Phi=0$], placement: "north")
})))

== Teorema di Gauss

#green-box([L'idea prima della formula])[
  Il teorema di Gauss generalizza il risultato appena trovato a una situazione qualunque, e dice una cosa profonda: *il flusso netto di campo elettrico uscente da una superficie chiusa dipende solo dalla carica racchiusa dentro*. Tornando al tornello: il bilancio netto di linee che escono ti dice esattamente quante "sorgenti di linee" (cioè quanta carica) c'è dentro, niente di più, niente di meno. Le cariche fuori producono campo, ma per ognuna ogni linea che entra poi esce: contributo netto zero.

  È potentissimo perché capovolge il problema: di solito è difficile calcolare il campo a partire dalle cariche (integrali complicati). Gauss, quando c'è simmetria, ti permette di fare il contrario: conosci la carica dentro, e da quella ricavi il campo con un conto facile.
]

Il teorema di Gauss lega il flusso del campo elettrico attraverso una qualunque superficie chiusa alla carica totale contenuta al suo interno:

#blue-box([Teorema di Gauss])[
  $ Phi(vec(E))=integral_S vec(E) dot dif vec(S)=Q_"int"/epsilon_0. $
]

La superficie $S$ deve essere chiusa. La carica $Q_"int"$ è la somma algebrica delle cariche interne alla superficie; le cariche esterne possono modificare localmente il campo, ma non il flusso netto attraverso $S$.

Attenzione: nell'integrale compare il campo totale $vec(E)$, prodotto sia da cariche interne sia da cariche esterne. Nel secondo membro, invece, compare solo la carica interna. Le cariche esterne fanno entrare e uscire linee di campo dalla superficie, quindi il loro contributo netto al flusso è nullo.

Il teorema vale sempre, anche senza simmetria. La simmetria serve però per ricavare il modulo del campo dall'integrale: senza una superficie su cui $E$ è costante o nullo per tratti, l'integrale resta difficile da calcolare.

Il teorema è particolarmente utile per calcolare $vec(E)$ quando la distribuzione di carica ha simmetria. In questi casi si sceglie una *superficie gaussiana* su cui:

- $vec(E)$ ha modulo costante;
- $vec(E)$ è parallelo alla normale $hat(n)$ oppure tangente alla superficie;
- l'integrale di flusso si riduce a un prodotto semplice.

La superficie gaussiana non è una superficie fisica: è una superficie immaginaria scelta per sfruttare la simmetria.

#blue-box([Come si usa Gauss in pratica: la ricetta in 5 passi])[
  Questo è il metodo che userai in *ogni* esercizio con simmetria. Imparalo come una ricetta:

  + *Guarda la simmetria* della distribuzione di carica (sferica, cilindrica o piana) e deduci la direzione del campo. Per simmetria, il campo non può che essere radiale (sfere e cilindri) o perpendicolare (piani), e il suo modulo $E$ può dipendere solo dalla distanza.
  + *Scegli la superficie gaussiana giusta*: una superficie immaginaria che "copia" la simmetria, in modo che su di essa $E$ sia costante e parallelo (o perpendicolare) alla normale. Sfera per simmetria sferica, cilindro per quella cilindrica, scatoletta/pillbox per quella piana.
  + *Calcola il flusso* sfruttando la scelta: dove $vec(E)$ è parallelo a $hat(n)$ e costante, l'integrale diventa semplicemente $E times ("area")$. Dove $vec(E)$ è tangente, quel pezzo dà flusso nullo e si scarta.
  + *Calcola la carica interna* $Q_"int"$, cioè solo la carica racchiusa dalla superficie che hai scelto (non tutta la carica del problema!).
  + *Eguaglia e ricava $E$*: poni flusso $=Q_"int"/epsilon_0$ e isola $E$.
]

#align(center, graph-card([Teorema di Gauss e superfici gaussiane], cetz.canvas({
  import cetz.draw: *
  axis-label((4.30, 2.80), [$integral_S vec(E) dot dif vec(S)=Q_"int"/epsilon_0$], placement: "south")
  catmull((0.85, 0.85), (0.68, 1.70), (1.20, 2.45), (2.25, 2.42), (2.85, 1.74), (2.62, 0.85), (1.62, 0.55), (0.85, 0.85), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  circle((1.55, 1.55), radius: 0.11, fill: ink, stroke: none)
  circle((2.18, 1.88), radius: 0.08, fill: red, stroke: none)
  circle((3.35, 1.35), radius: 0.08, fill: green, stroke: none)
  axis-label((1.40, 1.30), [$q_1$], placement: "north")
  axis-label((2.30, 2.10), [$q_2$], placement: "south")
  axis-label((3.55, 1.25), [esterna], placement: "west")
  for p in ((1.55, 2.38), (2.48, 1.85), (2.24, 0.88), (0.95, 1.06), (0.88, 1.95)) {
    line((1.55, 1.55), p, stroke: 0.85pt + blue, mark: (end: ">"))
  }
  axis-label((1.82, 0.20), [$S$ chiusa], placement: "north")
  axis-label((5.25, 1.95), [$Q_"int"=sum q_i$ interni], placement: "west")
  axis-label((5.25, 1.20), [le cariche esterne danno flusso netto nullo], placement: "west")
})))

== Simmetrie utili

La scelta della superficie gaussiana dipende dalla simmetria della distribuzione di carica:

- *simmetria sferica*: cariche distribuite su sfere, nel volume di una sfera o su gusci sferici;
- *simmetria cilindrica*: filo carico indefinito o cilindro indefinito;
- *simmetria piana*: piano carico infinito o coppie di piani paralleli.

Negli esercizi degli appunti consideriamo densità costanti: densità superficiale $sigma$ per cariche su superfici e densità volumica $rho$ per cariche distribuite in un volume.

Il metodo pratico è sempre lo stesso: si sceglie una superficie gaussiana coerente con la simmetria, si calcola $Q_"int"$, poi si semplifica l'integrale di flusso.

#yellow-box([Come la simmetria semplifica l'integrale])[
  Senza simmetria, $integral_S vec(E) dot dif vec(S)$ è un integrale difficilissimo: $E$ cambia da punto a punto sia come intensità sia come direzione. La simmetria è esattamente ciò che lo rende risolvibile. Se la superficie gaussiana è scelta bene:
  - su tutta la "superficie utile" il modulo $E$ è lo stesso (per simmetria, punti alla stessa distanza hanno lo stesso campo), quindi $E$ esce dall'integrale come costante;
  - $vec(E)$ è parallelo alla normale, quindi $cos theta=1$ e il prodotto scalare diventa solo $E dif S$;
  - resta $E integral dif S = E times "area"$, un prodotto banale.

  Per questo si dice $Phi=E dot "area utile"$. È tutto il senso del metodo: trasformare un integrale spaventoso in una moltiplicazione.
]

#purple-box([Schema d'uso di Gauss])[
  $ cases(
    Phi=integral_S vec(E) dot dif vec(S),
    Phi=Q_"int"/epsilon_0,
    "simmetria" -> Phi=E dot "area utile".
  ) $
]

Nel caso sferico, i casi tipici sono:

- carica distribuita nel volume della sfera;
- carica distribuita solo sulla superficie sferica;
- gusci sferici, come modello ideale di conduttori o condensatori sferici.

#align(center, graph-card([Simmetria sferica], cetz.canvas({
  import cetz.draw: *
  circle((1.55, 1.90), radius: 0.20, fill: ink, stroke: none)
  axis-label((1.55, 1.54), [$q$], placement: "north")
  for p in ((1.55, 3.02), (2.34, 2.70), (2.67, 1.90), (2.34, 1.10), (1.55, 0.78), (0.76, 1.10), (0.43, 1.90), (0.76, 2.70)) {
    line((1.55, 1.90), p, stroke: 1.0pt + blue, mark: (end: ">"))
  }
  circle((1.55, 1.90), radius: 1.12, stroke: (paint: ink, thickness: 0.9pt, dash: "dashed"))
  axis-label((2.55, 0.70), [$S(r)$], placement: "north")
  axis-label((4.10, 2.42), [superficie gaussiana: sfera concentrica], placement: "west")
  axis-label((4.10, 1.75), [$vec(E)=E(r) hat(r)$], placement: "west")
  axis-label((4.10, 1.12), [$E$ costante su $S(r)$], placement: "west")
})))

#align(center, graph-card([Simmetria cilindrica], cetz.canvas({
  import cetz.draw: *
  // Superficie gaussiana cilindrica coassiale al filo carico.
  circle((2.05, 3.05), radius: (1.15, 0.30), stroke: 1.05pt + ink, fill: rgb("#fbfcfd"))
  circle((2.05, 0.95), radius: (1.15, 0.30), stroke: 1.05pt + ink, fill: rgb("#fbfcfd"))
  line((0.90, 3.05), (0.90, 0.95), stroke: 1.05pt + ink)
  line((3.20, 3.05), (3.20, 0.95), stroke: 1.05pt + ink)
  circle((2.05, 3.05), radius: (0.22, 0.06), stroke: 0.8pt + red, fill: rgb("#fff4f4"))
  circle((2.05, 0.95), radius: (0.22, 0.06), stroke: 0.8pt + red, fill: rgb("#fff4f4"))

  // Filo indefinito sull'asse.
  line((2.05, 0.35), (2.05, 3.65), stroke: (paint: red, thickness: 1.25pt, dash: "dashed"))
  for y in (0.62, 1.05, 1.48, 1.91, 2.34, 2.77, 3.20, 3.50) {
    circle((2.05, y), radius: 0.045, fill: red, stroke: none)
  }
  axis-label((1.25, 3.58), [filo carico], placement: "south")
  axis-label((2.05, 0.20), [asse del cilindro], placement: "north")
  axis-label((2.05, 0.54), [cilindro gaussiano], placement: "north")

  // Raggio e campo sulla superficie laterale.
  line((2.05, 2.00), (3.20, 2.00), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((2.62, 2.24), [$r$], placement: "south")
  line((3.20, 2.00), (4.12, 2.00), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((4.28, 2.20), [$vec(E)$], placement: "west")
  for y in (1.28, 1.68, 2.32, 2.72) {
    line((3.20, y), (4.02, y), stroke: 0.85pt + blue, mark: (end: ">"))
    line((0.90, y), (0.08, y), stroke: 0.85pt + blue, mark: (end: ">"))
  }

  line((4.78, 0.62), (4.78, 3.42), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((5.28, 3.08), [$vec(E)=E(r) hat(r)$], placement: "west")
  axis-label((5.28, 2.42), [$E$ costante sulla superficie laterale], placement: "west")
  axis-label((5.28, 1.72), [flusso nullo sulle basi], placement: "west")
  axis-label((5.28, 1.04), [superficie utile: cilindro coassiale], placement: "west")
})))

#align(center, graph-card([Simmetria piana], cetz.canvas({
  import cetz.draw: *
  line((1.10, 1.30), (3.25, 1.70), stroke: 1.05pt + ink)
  line((3.25, 1.70), (3.88, 2.62), stroke: 1.05pt + ink)
  line((3.88, 2.62), (1.72, 2.22), stroke: 1.05pt + ink)
  line((1.72, 2.22), (1.10, 1.30), stroke: 1.05pt + ink, fill: rgb("#fff4f4"))
  for x in (1.65, 2.25, 2.85, 3.45) {
    line((x, 0.70), (x, 3.20), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  axis-label((2.55, 0.30), [piano carico infinito], placement: "north")
  axis-label((5.10, 2.45), [$vec(E)$ perpendicolare al piano], placement: "west")
  axis-label((5.10, 1.78), [stesso modulo a pari distanza], placement: "west")
  axis-label((5.10, 1.10), [superficie utile: cilindro o pillbox], placement: "west")
})))

#align(center, graph-card([Distribuzioni sferiche tipiche], cetz.canvas({
  import cetz.draw: *
  // volume
  axis-label((1.35, 2.80), [volume], placement: "south")
  for rr in (0.18, 0.34, 0.50, 0.66, 0.82) {
    circle((1.35, 1.55), radius: rr, stroke: 0.65pt + ink)
  }
  line((1.35, 1.55), (2.02, 0.98), stroke: 0.8pt + ink, mark: (end: ">"))
  axis-label((1.88, 1.12), [$R$], placement: "north")
  axis-label((1.35, 0.36), [$rho="costante"$], placement: "north")

  // superficie
  axis-label((4.20, 2.80), [superficie], placement: "south")
  circle((4.20, 1.55), radius: 0.82, stroke: 1.2pt + ink)
  circle((4.20, 1.55), radius: 0.72, stroke: 0.55pt + grid-color)
  line((4.20, 1.55), (4.88, 0.98), stroke: 0.8pt + ink, mark: (end: ">"))
  axis-label((4.74, 1.12), [$R$], placement: "north")
  axis-label((4.20, 0.36), [$sigma=Q/(4 pi R^2)$], placement: "north")

  // guscio
  axis-label((7.05, 2.80), [guscio], placement: "south")
  circle((7.05, 1.55), radius: 0.92, stroke: 1.0pt + ink)
  circle((7.05, 1.55), radius: 0.55, stroke: 1.0pt + ink)
  for rr in (0.60, 0.70, 0.80) {
    circle((7.05, 1.55), radius: rr, stroke: 0.55pt + grid-color)
  }
  line((7.05, 1.55), (7.75, 0.92), stroke: 0.8pt + ink, mark: (end: ">"))
  axis-label((7.62, 1.06), [$R$], placement: "north")
  axis-label((7.05, 0.36), [conduttore ideale], placement: "north")
})))

== Esempio: carica sulla superficie di una sfera

#gray-box([Dove siamo: il primo uso completo di Gauss])[
  Questo è il primo esercizio in cui applichiamo la ricetta dei 5 passi dall'inizio alla fine. Segui come la simmetria sferica, la scelta della sfera gaussiana e il conteggio della carica interna portano al campo senza nessun integrale difficile.
]

Consideriamo una carica totale $Q>0$ distribuita uniformemente sulla superficie di una sfera di raggio $R$.

La densità superficiale è

$ sigma=Q/(4 pi R^2) quad ["C"/"m"^2]. $

Per simmetria sferica il campo è radiale:

$ vec(E)(vec(r))=E(r) hat(r). $

Scegliamo come superfici gaussiane sfere concentriche $S(r)$. Su $S(r)$ il campo ha modulo costante e $hat(r) dot hat(n)=1$, quindi

$ integral_(S(r)) vec(E) dot dif vec(S)=E(r) integral_(S(r)) dif S=E(r) 4 pi r^2=Q_"int"/epsilon_0. $

Il passaggio chiave è questo: su una sfera concentrica il campo è radiale come la normale uscente, quindi il prodotto scalare non introduce fattori angolari e il modulo $E(r)$ può uscire dall'integrale.

#yellow-box([Perché compare $4 pi r^2$])[
  Una volta uscito $E(r)$ dall'integrale, resta $integral_(S(r)) dif S$, cioè semplicemente l'*area totale* della sfera gaussiana di raggio $r$. L'area di una sfera è $4 pi r^2$. Quindi il flusso è $E(r) dot 4 pi r^2$: il campo (costante) per l'area della superficie su cui agisce. È esattamente il passo "flusso $=E times$ area utile" della ricetta.
]

#align(center, graph-card([Sfera carica in superficie: superfici gaussiane], cetz.canvas({
  import cetz.draw: *
  // esterno
  axis-label((1.85, 3.00), [$r>R$], placement: "south")
  circle((1.85, 1.62), radius: 0.82, stroke: 1.0pt + ink)
  circle((1.85, 1.62), radius: 1.12, stroke: (paint: blue, thickness: 0.9pt, dash: "dashed"))
  line((1.85, 1.62), (2.36, 2.24), stroke: 0.9pt + ink, mark: (end: ">"))
  line((1.85, 1.62), (2.86, 2.08), stroke: 0.9pt + blue, mark: (end: ">"))
  axis-label((2.22, 2.06), [$R$], placement: "south")
  axis-label((2.76, 2.28), [$r$], placement: "south")
  axis-label((2.78, 0.70), [$S(r)$], placement: "north")

  // interno
  axis-label((5.70, 3.00), [$r<R$], placement: "south")
  circle((5.70, 1.62), radius: 1.02, stroke: 1.0pt + ink)
  circle((5.70, 1.62), radius: 0.62, stroke: (paint: blue, thickness: 0.9pt, dash: "dashed"))
  line((5.70, 1.62), (6.48, 0.95), stroke: 0.9pt + ink, mark: (end: ">"))
  line((5.70, 1.62), (6.10, 1.95), stroke: 0.9pt + blue, mark: (end: ">"))
  axis-label((6.28, 1.10), [$R$], placement: "north")
  axis-label((6.08, 1.72), [$r$], placement: "south")
  axis-label((5.70, 0.32), [cavità: $Q_"int"=0$], placement: "north")
})))

Se $r>R$, la superficie gaussiana contiene tutta la carica:

$ Q_"int"=Q quad -> quad E(r)=Q/(4 pi epsilon_0 r^2). $

Se $r<R$, la superficie gaussiana non contiene carica:

$ Q_"int"=0 quad -> quad E(r)=0. $

#yellow-box([Perché dentro il campo è nullo])[
  Per $r<R$ la sfera gaussiana sta *dentro* il guscio carico: tutta la carica è sul guscio esterno, quindi dentro la sfera gaussiana non è racchiusa nessuna carica, $Q_"int"=0$. Allora il flusso è zero, e siccome il flusso è $E(r) dot 4 pi r^2$, deve essere $E(r)=0$. Risultato controintuitivo ma vero: dentro un guscio sferico carico il campo è esattamente nullo, ovunque, non solo al centro. I contributi delle varie parti del guscio si cancellano perfettamente.
]

Questo risultato è il principio alla base della *gabbia di Faraday*: in una cavità interna a un conduttore sferico carico, se non ci sono cariche nella cavità, il campo elettrostatico è nullo.

#green-box([Campo di un guscio sferico carico])[
  $ vec(E)(r)=cases(
    0, & r<R,
    Q/(4 pi epsilon_0 r^2) hat(r), & r>R.
  ) $
]

Sulla superficie il valore esterno è

$ E(R)=Q/(4 pi epsilon_0 R^2)=sigma/epsilon_0. $

#yellow-box([Da dove esce $sigma/epsilon_0$])[
  Basta sostituire $sigma=Q/(4 pi R^2)$ (la densità superficiale) dentro l'espressione $E(R)=Q/(4 pi epsilon_0 R^2)$. Riscrivendo: $E(R)=1/epsilon_0 dot Q/(4 pi R^2)=sigma/epsilon_0$. È un risultato che ritroveremo identico per la superficie di un conduttore: appena fuori da una superficie carica il campo vale $sigma/epsilon_0$.
]

Nel modello ideale di carica concentrata esattamente sulla superficie, il campo ha un salto in $r=R$: appena dentro vale $0$, appena fuori vale $sigma/epsilon_0$.

#purple-box([Esempio numerico: guscio sferico carico])[
  Un guscio sferico di raggio $R=0,1 " m"$ porta carica $Q=2 dot 10^(-8) " C"$. Quanto vale il campo appena fuori, a $r=0,1 " m"$, e a $r=0,5 " m"$?

  Appena fuori ($r=R=0,1 " m"$):
  $ E=k Q/R^2=9 dot 10^9 dot (2 dot 10^(-8))/(0,1)^2=9 dot 10^9 dot (2 dot 10^(-8))/(10^(-2))=180/(10^(-2))=1,8 dot 10^4 " N"/"C". $

  A $r=0,5 " m"$, cioè a distanza $5$ volte maggiore, il campo cala come $1/r^2$, quindi di un fattore $25$:
  $ E=9 dot 10^9 dot (2 dot 10^(-8))/(0,5)^2=180/(0,25)=720 " N"/"C". $

  Dentro il guscio ($r<0,1 " m"$): $E=0$.
]

Per $Q>0$ le linee di campo sono radiali uscenti; per $Q<0$ sarebbero radiali entranti. Le formule vettoriali mantengono il segno della carica.

#align(center, graph-card([Andamento del campo di un guscio sferico], cetz.canvas({
  import cetz.draw: *
  line((0.75, 0.55), (6.60, 0.55), stroke: 0.95pt + ink, mark: (end: ">"))
  line((0.75, 0.55), (0.75, 3.05), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((6.70, 0.55), [$r$], placement: "west")
  axis-label((0.62, 3.10), [$E(r)$], placement: "east")
  line((0.75, 0.55), (3.00, 0.55), stroke: 1.4pt + ink)
  line((3.00, 0.55), (3.00, 2.15), stroke: (paint: ink, thickness: 0.9pt, dash: "dashed"))
  catmull((3.00, 2.15), (3.70, 1.45), (4.50, 1.03), (5.35, 0.78), (6.20, 0.68), stroke: 1.35pt + ink)
  line((0.75, 2.15), (3.00, 2.15), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  circle((3.00, 2.15), radius: 0.06, fill: ink, stroke: none)
  axis-label((3.00, 0.30), [$R$], placement: "north")
  axis-label((0.36, 2.15), [$sigma/epsilon_0$], placement: "east")
  axis-label((4.82, 1.55), [andamento $1/r^2$], placement: "south")
  axis-label((1.65, 0.88), [$E=0$], placement: "south")
})))

== Esempio: distribuzione sferica di volume

Consideriamo ora una sfera di raggio $R$ con carica totale $Q>0$ distribuita uniformemente nel volume.

La densità volumica costante è

$ rho=Q/((4/3) pi R^3) quad ["C"/"m"^3]. $

Anche in questo caso la simmetria è sferica:

$ vec(E)(vec(r))=E(r) hat(r). $

Scegliendo una superficie gaussiana sferica $S(r)$,

$ E(r) 4 pi r^2=Q_"int"/epsilon_0. $

Per $r>R$ tutta la carica è interna:

$ Q_"int"=Q quad -> quad E(r)=Q/(4 pi epsilon_0 r^2). $

Per $r<R$ la carica interna è quella contenuta nella sfera di raggio $r$:

$ Q_"int"(r)=rho (4/3) pi r^3. $

Qui non si usa tutta la carica $Q$, ma solo la frazione contenuta nella superficie gaussiana scelta. Quindi

#red-box([Trabocchetto: dentro non c'è tutta la carica])[
  L'errore più comune in questi esercizi è usare la carica *totale* $Q$ anche quando la sfera gaussiana è dentro la distribuzione. Ricorda: in Gauss conta solo $Q_"int"$, la carica *racchiusa dalla superficie che hai scelto*. Per $r<R$ la sfera gaussiana è dentro la sfera carica, quindi racchiude solo il volume $(4/3) pi r^3$ (non $(4/3) pi R^3$), e la carica racchiusa è $rho times$ quel volume, cioè una frazione di $Q$. È proprio questo che fa crescere il campo man mano che ci si allontana dal centro.
]

$ E(r)=rho (4/3) pi r^3/(epsilon_0 4 pi r^2)=rho r/(3 epsilon_0). $

#yellow-box([Come si semplifica quella frazione])[
  Partiamo da $E(r) 4 pi r^2=Q_"int"/epsilon_0$ con $Q_"int"=rho (4/3) pi r^3$, quindi $E(r)=(rho (4/3) pi r^3)/(epsilon_0 dot 4 pi r^2)$. Ora semplifichiamo: il $pi$ si elide sopra e sotto; $r^3/r^2=r$; e $(4/3)/4=1/3$. Resta $E(r)=rho r/(3 epsilon_0)$. Il campo cresce *linearmente* con $r$ dentro la sfera: al centro è zero, sul bordo è massimo.
]

Usando $rho=Q/((4/3) pi R^3)$, la stessa espressione interna diventa

$ E(r)=Q r/(4 pi epsilon_0 R^3). $

#yellow-box([Campo di una sfera uniformemente carica])[
  $ vec(E)(r)=cases(
    rho r/(3 epsilon_0) hat(r), & r<R,
    Q/(4 pi epsilon_0 r^2) hat(r), & r>R.
  ) $
]

Nel punto $r=R$ le due espressioni coincidono:

$ E(R)=rho R/(3 epsilon_0)=Q/(4 pi epsilon_0 R^2). $

#yellow-box([Controllo di continuità: le due formule combaciano])[
  È sempre buona pratica verificare che le due espressioni (interna ed esterna) diano lo stesso valore al confine $r=R$, dove devono raccordarsi. Interna in $r=R$: $E=rho R/(3 epsilon_0)$. Esterna in $r=R$: $E=Q/(4 pi epsilon_0 R^2)$. Sostituendo $rho=Q/((4/3) pi R^3)$ nella prima si ottiene proprio la seconda. Se nel tuo esercizio le due non combaciano, hai sbagliato un conto: questo è un ottimo controllo di sanità.
]

A differenza del guscio superficiale, qui il campo è continuo: cresce linearmente all'interno perché la carica racchiusa cresce come $r^3$, poi decresce come $1/r^2$ all'esterno.

Anche qui, se $Q>0$ il campo è radiale uscente; se $Q<0$ il verso è radiale entrante.

#align(center, graph-card([Sfera uniformemente carica: interno ed esterno], cetz.canvas({
  import cetz.draw: *
  // sfera con superficie gaussiana esterna
  axis-label((1.65, 3.00), [gaussiana esterna], placement: "south")
  for rr in (0.18, 0.36, 0.54, 0.72, 0.90) {
    circle((1.65, 1.62), radius: rr, stroke: 0.8pt + ink)
  }
  circle((1.65, 1.62), radius: 1.18, stroke: (paint: blue, thickness: 0.9pt, dash: "dashed"))
  line((1.65, 1.62), (2.48, 2.44), stroke: 0.95pt + blue, mark: (end: ">"))
  axis-label((2.36, 2.50), [$r>R$], placement: "west")

  // sfera con superficie gaussiana interna
  axis-label((5.25, 3.00), [gaussiana interna], placement: "south")
  for rr in (0.18, 0.36, 0.54, 0.72, 0.90) {
    circle((5.25, 1.62), radius: rr, stroke: 0.8pt + ink)
  }
  circle((5.25, 1.62), radius: 0.55, stroke: (paint: blue, thickness: 0.9pt, dash: "dashed"))
  line((5.25, 1.62), (5.75, 2.02), stroke: 0.95pt + blue, mark: (end: ">"))
  axis-label((5.80, 2.05), [$r<R$], placement: "west")
  axis-label((5.25, 0.36), [$Q_"int"(r)=rho (4/3) pi r^3$], placement: "north")
})))

#align(center, graph-card([Andamento del campo di una sfera piena], cetz.canvas({
  import cetz.draw: *
  line((0.75, 0.55), (6.65, 0.55), stroke: 0.95pt + ink, mark: (end: ">"))
  line((0.75, 0.55), (0.75, 3.12), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((6.75, 0.55), [$r$], placement: "west")
  axis-label((0.60, 3.16), [$E(r)$], placement: "east")
  line((0.75, 0.55), (3.15, 2.25), stroke: 1.35pt + ink)
  circle((3.15, 2.25), radius: 0.065, fill: ink, stroke: none)
  line((3.15, 0.55), (3.15, 2.25), stroke: (paint: ink, thickness: 0.85pt, dash: "dashed"))
  catmull((3.15, 2.25), (3.80, 1.52), (4.65, 1.03), (5.50, 0.78), (6.28, 0.68), stroke: 1.35pt + ink)
  axis-label((3.15, 0.30), [$R$], placement: "north")
  axis-label((1.95, 1.55), [andamento $r$], placement: "south")
  axis-label((4.95, 1.44), [andamento $1/r^2$], placement: "south")
  axis-label((3.72, 2.28), [$E(R)$], placement: "west")
})))

== Elettrostatica con conduttori

#green-box([L'idea prima della formula])[
  Un conduttore (un metallo) ha al suo interno cariche *libere di muoversi* (gli elettroni di conduzione). Questa libertà ha una conseguenza fortissima: se ci fosse anche un minimo campo elettrico dentro il metallo, le cariche libere sentirebbero una forza e si metterebbero a correre. Quindi, finché c'è campo interno, le cariche si muovono; e si muovono *proprio in modo da spegnere quel campo*. L'unica situazione in cui tutto si ferma (equilibrio) è quando il campo interno è diventato esattamente zero. È come una pallina in una ciotola: rotola finché non trova il fondo, e si ferma solo dove non c'è più pendenza.
]

Un conduttore contiene cariche libere di muoversi. Se si applica un campo elettrico esterno, durante il transiente le cariche si spostano sotto l'azione della forza

$ vec(F)=q vec(E). $

Il moto delle cariche continua finché il campo totale all'interno del conduttore non diventa nullo. In equilibrio elettrostatico valgono alcune proprietà fondamentali.

#blue-box([Conduttore in equilibrio elettrostatico])[
  $ vec(E)_"int"=0, quad V="costante", quad Q_"int"=0. $
]

La condizione $vec(E)_"int"=0$ non significa che non ci siano cariche sul conduttore: significa che il campo prodotto dalle cariche ridistribuite annulla il campo applicato all'interno del materiale.

La parola "equilibrio" è importante: durante lo spostamento iniziale delle cariche può esserci campo interno; quando il moto si ferma, il campo interno deve essere nullo, altrimenti le cariche libere continuerebbero ad accelerare.

#align(center, graph-card([Ridistribuzione delle cariche in un conduttore], cetz.canvas({
  import cetz.draw: *
  // transiente
  axis-label((1.55, 3.10), [transiente], placement: "south")
  catmull((0.55, 1.15), (0.85, 2.20), (1.75, 2.32), (2.55, 1.86), (2.30, 0.95), (1.25, 0.78), (0.55, 1.15), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  for x in (0.52, 1.30, 2.08) {
    line((x, 0.55), (x, 2.65), stroke: 0.95pt + blue, mark: (end: ">"))
  }
  circle((1.10, 1.55), radius: 0.13, stroke: 0.9pt + ink, fill: rgb("#fff4f4"))
  axis-label((1.10, 1.55), [$+$])
  circle((1.95, 1.55), radius: 0.13, stroke: 0.9pt + ink, fill: rgb("#edf3f8"))
  axis-label((1.95, 1.55), [$-$])
  line((1.10, 1.55), (1.10, 2.20), stroke: 1.0pt + ink, mark: (end: ">"))
  line((1.95, 1.55), (1.95, 0.90), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((2.55, 2.55), [$vec(E)_"esterno"$], placement: "west")

  // equilibrio
  axis-label((5.40, 3.10), [equilibrio], placement: "south")
  circle((5.40, 1.55), radius: 0.92, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  for p in ((4.70, 2.05), (5.05, 2.32), (5.55, 2.43), (6.05, 2.15), (4.78, 0.92), (5.30, 0.68), (5.92, 0.86)) {
    axis-label(p, [$+$])
  }
  for p in ((4.62, 1.62), (6.20, 1.50), (5.20, 1.10), (5.72, 1.95)) {
    axis-label(p, [$-$])
  }
  axis-label((5.40, 1.55), [$vec(E)_"tot"=0$])
  for x in (4.20, 6.60) {
    line((x, 0.45), (x, 2.65), stroke: 0.9pt + blue, mark: (end: ">"))
  }
})))

Poiché $vec(E)=0$ in ogni punto interno, il potenziale è costante nel conduttore:

$ Delta V=-integral_1^2 vec(E) dot dif vec(ell)=0. $

Questo vale tra due punti qualsiasi del conduttore in equilibrio.

#yellow-box([Campo nullo $arrow$ potenziale costante])[
  Usiamo la solita relazione tra campo e potenziale: $Delta V=-integral vec(E) dot dif vec(ell)$. Se $vec(E)=0$ ovunque dentro il metallo, l'integrale è zero qualunque cammino io scelga tra due punti $1$ e $2$ del conduttore. Quindi $V_2-V_1=0$, cioè $V_1=V_2$: tutti i punti del conduttore sono allo stesso potenziale. Nel linguaggio della collina: un conduttore in equilibrio è una zona perfettamente *pianeggiante*, una superficie equipotenziale a tutti gli effetti. Tutto il conduttore (interno e superficie) è un unico "blocco" alla stessa quota.
]

== Carica sui conduttori

#green-box([L'idea prima della formula])[
  Se metti carica in eccesso su un metallo, dove va a finire? La risposta è netta: *tutta sulla superficie*, mai nel volume interno. Il motivo intuitivo è la repulsione: cariche dello stesso segno si respingono e cercano di allontanarsi il più possibile l'una dall'altra. Il modo per stare il più lontane possibile è spalmarsi sulla superficie esterna. Ma il modo rigoroso per dimostrarlo è ancora Gauss, applicato a una superficie immaginaria dentro il metallo.
]

La carica netta di un conduttore in equilibrio si dispone solo sulla superficie. Infatti, prendendo una superficie gaussiana tutta interna al materiale conduttore, si ha $vec(E)=0$ su tutta la superficie e quindi

$ integral_S vec(E) dot dif vec(S)=0 quad -> quad Q_"int"=0. $

#yellow-box([Il ragionamento con Gauss])[
  Disegno una superficie gaussiana chiusa tutta dentro il metallo, appena sotto la pelle del conduttore. Dentro il metallo $vec(E)=0$ (equilibrio), quindi il flusso attraverso questa superficie è zero. Per Gauss, $Phi=Q_"int"/epsilon_0$, quindi $Q_"int"=0$: nessuna carica racchiusa. Questo vale per *qualunque* superficie interna io disegni, quindi il volume del conduttore è scarico ovunque. L'unica regione rimasta dove la carica può stare è la superficie.
]

Se il conduttore possedesse carica nel volume, una superficie gaussiana interna la racchiuderebbe, in contraddizione con $Q_"int"=0$.

#green-box([Carica superficiale])[
  In equilibrio elettrostatico la carica in eccesso di un conduttore risiede sulla superficie:
  $ Q=integral_"superficie" sigma dif S. $
]

Il campo appena fuori dalla superficie di un conduttore è perpendicolare alla superficie. Se avesse una componente tangenziale, le cariche libere si muoverebbero ancora lungo la superficie e non saremmo in equilibrio.

Applicando Gauss a un piccolo cilindro che attraversa la superficie del conduttore, si ottiene

#yellow-box([Campo sulla superficie di un conduttore])[
  $ vec(E)_"sup"=sigma/epsilon_0 hat(n). $
]

Qui $hat(n)$ è la normale uscente. Se $sigma>0$ il campo esce dal conduttore; se $sigma<0$ entra nel conduttore.

#yellow-box([Da dove esce il "pillbox" e il $sigma/epsilon_0$])[
  Si usa una superficie gaussiana a forma di scatoletta piatta (in inglese *pillbox*, come una pastiglia) che attraversa la superficie del conduttore: metà dentro il metallo, metà fuori. Sulla faccia *interna* il campo è zero, quindi quel pezzo non dà flusso. Sulla faccia *laterale* il campo è tangente (parallelo alla superficie), flusso nullo anche lì. Resta solo la faccia *esterna*, dove il campo è $E$ ed esce perpendicolare: flusso $E dot S$, con $S$ l'area della faccia. La carica racchiusa è $sigma S$. Gauss dà $E dot S=(sigma S)/epsilon_0$, da cui $E=sigma/epsilon_0$. Lo stesso $sigma/epsilon_0$ del guscio sferico: non è un caso, è la stessa fisica.
]

#align(center, graph-card([Proprietà di un conduttore in equilibrio], cetz.canvas({
  import cetz.draw: *
  // potenziale costante
  catmull((0.65, 1.12), (0.95, 2.18), (2.15, 2.28), (2.82, 1.62), (2.42, 0.78), (1.20, 0.72), (0.65, 1.12), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  circle((1.18, 1.70), radius: 0.07, fill: ink, stroke: none)
  circle((2.25, 1.50), radius: 0.07, fill: ink, stroke: none)
  axis-label((1.12, 1.94), [$1$], placement: "south")
  axis-label((2.35, 1.72), [$2$], placement: "south")
  axis-label((1.70, 1.28), [$vec(E)=0$])
  axis-label((1.72, 0.34), [$Delta V=0$], placement: "north")

  // carica superficiale
  catmull((4.10, 1.05), (4.35, 2.14), (5.42, 2.35), (6.18, 1.72), (5.82, 0.78), (4.60, 0.78), (4.10, 1.05), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  for p in ((4.38, 1.92), (4.95, 2.20), (5.62, 2.02), (5.92, 1.35), (5.15, 0.82), (4.42, 1.12)) {
    axis-label(p, [$+$])
  }
  line((5.95, 1.74), (6.55, 2.10), stroke: 1.05pt + blue, mark: (end: ">"))
  line((5.95, 1.74), (6.30, 1.15), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((6.62, 2.16), [$vec(E)_"sup"$], placement: "west")
  axis-label((6.38, 1.08), [$hat(n)$], placement: "west")
  axis-label((5.12, 0.34), [$vec(E)_"sup"=sigma/epsilon_0 hat(n)$], placement: "north")
})))

== Cavità in un conduttore

Consideriamo un conduttore con una cavità interna. Se nella cavità non ci sono cariche, la superficie della cavità resta scarica e il campo nella cavità è nullo:

$ sigma_"cavità"=0, quad vec(E)_"cavità"=0. $

Questa è la base dello *schermo elettrostatico* o *gabbia di Faraday*: il conduttore isola la cavità dai campi elettrostatici esterni.

#align(center, graph-card([Cavità scarica e schermatura elettrostatica], cetz.canvas({
  import cetz.draw: *
  circle((1.70, 1.65), radius: 1.10, stroke: 1.0pt + ink, fill: rgb("#f4f4f4"))
  circle((1.70, 1.65), radius: 0.58, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  for x in (0.55, 0.80, 2.60, 2.85) {
    line((x, 0.55), (x, 2.75), stroke: 0.95pt + blue, mark: (end: ">"))
  }
  axis-label((1.70, 1.65), [$vec(E)=0$])
  axis-label((1.70, 0.12), [cavità scarica], placement: "north")
  axis-label((3.55, 2.18), [$sigma_"cavità"=0$], placement: "west")
  axis-label((3.55, 1.46), [$vec(E)_"cavità"=0$], placement: "west")
  axis-label((3.55, 0.78), [schermo elettrostatico], placement: "west")
})))

Se invece nella cavità è presente una carica $Q$, per induzione compare carica $-Q$ sulla superficie interna della cavità. Se il conduttore era inizialmente neutro, sulla superficie esterna compare $+Q$ per conservazione della carica totale.

#yellow-box([Perché compaiono $-Q$ dentro e $+Q$ fuori])[
  Ragiona sempre con Gauss e la conservazione. Disegno una superficie gaussiana nel metallo, tutto intorno alla cavità: lì $vec(E)=0$, quindi $Q_"int"=0$. Ma dentro questa superficie c'è la carica $Q$ della cavità *più* la carica indotta sulla parete interna $Q_"sup,int"$. Perché la somma faccia zero deve essere $Q_"sup,int"=-Q$: la carica nella cavità "richiama" carica opposta sulla parete. A questo punto, se il conduttore era neutro, quella carica $-Q$ deve essere venuta da qualche parte: si è "scoperta" una carica $+Q$ che, respinta, finisce sulla superficie *esterna*. Conservazione: $0=(-Q)+(+Q)$, tutto torna.
]

#purple-box([Cavità con carica interna])[
  Carica nella cavità: $Q$.

  Superficie interna della cavità: $-Q$.

  Superficie esterna del conduttore neutro: $+Q$.
]

#align(center, graph-card([Carica in una cavità conduttrice], cetz.canvas({
  import cetz.draw: *
  circle((1.85, 1.65), radius: 1.15, stroke: 1.0pt + ink, fill: rgb("#f4f4f4"))
  circle((1.85, 1.65), radius: 0.62, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  circle((1.85, 1.65), radius: 0.08, fill: ink, stroke: none)
  axis-label((1.85, 1.38), [$Q$], placement: "north")
  for p in ((1.40, 1.65), (1.62, 2.05), (2.18, 2.00), (2.32, 1.48), (1.72, 1.18)) {
    axis-label(p, [$-$])
  }
  for p in ((0.82, 2.25), (1.45, 2.78), (2.30, 2.70), (2.90, 1.80), (2.45, 0.72), (1.05, 0.82)) {
    axis-label(p, [$+$])
  }
  circle((1.85, 1.65), radius: 0.78, stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  axis-label((3.58, 2.22), [Gauss nel metallo: $vec(E)=0$], placement: "west")
  axis-label((3.58, 1.52), [$Q_"int"=Q+Q_"sup,int"=0$], placement: "west")
  axis-label((3.58, 0.82), [$Q_"sup,int"=-Q$], placement: "west")
})))

== Esempio: sistema di gusci sferici conduttori

Consideriamo un conduttore sferico interno di raggio $R_1$ con carica $Q_A>0$, circondato da un guscio conduttore neutro compreso tra i raggi $R_2$ e $R_3$.

I dati degli appunti sono

$ R_1=0.1 " cm"=10^(-3) " m", quad R_2=0.5 " cm"=5 dot 10^(-3) " m", quad R_3=1 " cm"=10^(-2) " m", $

$ Q_A=+10^(-9) " C". $

#gray-box([Dove siamo: l'esercizio che mette insieme tutto])[
  Questo esempio combina tutte le idee del capitolo: cariche indotte per induzione, conduttore con $vec(E)=0$ all'interno, Gauss applicato a sfere concentriche. La strategia è importante: *prima* si trovano le cariche su ogni superficie (usando $vec(E)=0$ nel metallo e la conservazione), e *solo dopo* si calcola il campo regione per regione. Non si parte dal campo.
]

Conviene leggere l'esempio a passaggi, perché stiamo determinando prima le cariche indotte e solo dopo il campo.

#gray-box([Step 1: separo le superfici])[
  Le superfici da distinguere sono tre:

  - $R_1$: superficie del conduttore interno;
  - $R_2$: superficie interna del guscio esterno;
  - $R_3$: superficie esterna del guscio esterno.

  Sul conduttore interno è già presente la carica assegnata:

  $ Q_(R_1)=+Q_A. $
]

#gray-box([Step 2: uso Gauss nel metallo])[
  In equilibrio elettrostatico, dentro il materiale conduttore il campo è nullo.

  Scelgo allora una superficie gaussiana nel metallo del guscio, cioè con $R_2<r<R_3$. Poiché lì $vec(E)=vec(0)$, il flusso è nullo e quindi anche la carica racchiusa deve essere nulla:

  $ Q_"int"=0. $

  Questa superficie racchiude il conduttore interno e la superficie interna del guscio:

  $ Q_A+Q_(R_2)=0. $

  Quindi

  $ Q_(R_2)=-Q_A. $
]

#gray-box([Step 3: sulla superficie $R_3$ aggiungo la carica mancante])[
  Il guscio esterno era neutro. Questo significa che la somma delle cariche sulle sue due superfici deve restare zero:

  $ Q_(R_2)+Q_(R_3)=0. $

  Siccome su $R_2$ si è indotta $-Q_A$, sulla superficie esterna $R_3$ deve comparire $+Q_A$:

  $ -Q_A+Q_(R_3)=0 quad -> quad Q_(R_3)=+Q_A. $
]

#purple-box([Cariche sulle superfici])[
  $ cases(
    Q_(R_1)=+Q_A,
    Q_(R_2)=-Q_A,
    Q_(R_3)=+Q_A.
  ) $
]

Le densità superficiali sono

$ sigma_(R_1)=Q_A/(4 pi R_1^2) approx 8 dot 10^(-5) " C"/"m"^2, $

$ sigma_(R_2)=-Q_A/(4 pi R_2^2) approx -3.2 dot 10^(-6) " C"/"m"^2, $

$ sigma_(R_3)=Q_A/(4 pi R_3^2) approx 8 dot 10^(-7) " C"/"m"^2. $

#purple-box([Verifica numerica della prima densità])[
  Controlliamo $sigma_(R_1)$, con $Q_A=10^(-9) " C"$ e $R_1=10^(-3) " m"$:
  $ sigma_(R_1)=Q_A/(4 pi R_1^2)=(10^(-9))/(4 pi (10^(-3))^2)=(10^(-9))/(4 pi dot 10^(-6)). $
  Il denominatore è $4 pi dot 10^(-6) approx 12,6 dot 10^(-6)=1,26 dot 10^(-5)$. Quindi
  $ sigma_(R_1)=(10^(-9))/(1,26 dot 10^(-5)) approx 8 dot 10^(-5) " C"/"m"^2. $
  Nota che a parità di carica, raggio più piccolo significa densità più alta: la stessa carica spalmata su una sfera piccola si "concentra" di più. Per questo $sigma_(R_1)>sigma_(R_3)$ pur portando $R_1$ e $R_3$ la stessa carica $+Q_A$.
]

#align(center, graph-card([Gusci sferici conduttori: cariche indotte], cetz.canvas({
  import cetz.draw: *
  // Sezione dei conduttori: sfera piena interna e guscio conduttore.
  let O = (4.05, 2.95)
  circle(O, radius: 2.45, stroke: 1.15pt + ink, fill: rgb("#f2f4f5"))
  circle(O, radius: 1.55, stroke: 1.15pt + ink, fill: rgb("#fbfcfd"))
  circle(O, radius: 0.70, stroke: 1.15pt + ink, fill: rgb("#e7e9eb"))
  circle(O, radius: 2.00, stroke: (paint: blue, thickness: 0.95pt, dash: "dashed"), fill: none)

  // Cariche sulle tre superfici.
  for p in ((4.05, 3.67), (3.57, 2.95), (4.53, 2.95), (4.05, 2.23)) {
    axis-label(p, text(fill: red, weight: "bold")[$+$])
  }
  for p in ((2.58, 3.76), (2.54, 1.76), (4.05, 1.40), (5.56, 1.76), (5.56, 3.72)) {
    axis-label(p, text(fill: blue, weight: "bold")[$-$])
  }
  for p in ((1.70, 4.02), (2.22, 4.94), (4.05, 5.40), (5.88, 4.94), (6.40, 4.02), (6.66, 1.84), (4.05, 0.48), (1.44, 1.84)) {
    axis-label(p, text(fill: red, weight: "bold")[$+$])
  }

  // Raggi ben separati.
  line(O, (4.75, 2.95), stroke: 0.9pt + ink, mark: (end: ">"))
  line(O, (5.60, 2.95), stroke: 0.9pt + ink, mark: (end: ">"))
  line(O, (6.50, 2.95), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((4.40, 2.58), [$R_1$], placement: "north")
  axis-label((5.08, 2.48), [$R_2$], placement: "north")
  axis-label((6.08, 2.48), [$R_3$], placement: "north")

  // Etichette esterne, collegate alle superfici.
  line((4.05, 3.67), (4.05, 4.48), stroke: 0.8pt + red)
  axis-label((4.05, 4.64), [$Q_(R_1)=+Q_A$], placement: "south")
  line((2.58, 3.76), (1.58, 4.42), stroke: 0.8pt + blue)
  axis-label((1.42, 4.48), [$Q_(R_2)=-Q_A$], placement: "east")
  line((6.40, 4.02), (7.26, 4.55), stroke: 0.8pt + red)
  axis-label((7.40, 4.60), [$Q_(R_3)=+Q_A$], placement: "west")

  axis-label((4.05, 5.92), [sezione: conduttore interno + guscio conduttore neutro], placement: "south")
  axis-label((4.05, -0.22), [linea blu tratteggiata: superficie gaussiana nel metallo, dove $vec(E)=0$], placement: "north")
})))

Per calcolare il campo si usano di nuovo sfere gaussiane concentriche. Per simmetria

$ integral_(S(r)) vec(E) dot dif vec(S)=E(r) 4 pi r^2=Q_"int"/epsilon_0. $

Quindi, in ogni regione, basta guardare quanta carica è racchiusa dalla sfera gaussiana scelta.

#green-box([Campo nel sistema di gusci])[
  Il campo è definito a tratti:

  #align(center)[
    $ vec(E)(r)=vec(0) quad "per " r<R_1 $
    #v(3pt)
    $ vec(E)(r)=Q_A/(4 pi epsilon_0 r^2) hat(r) quad "per " R_1<r<R_2 $
    #v(3pt)
    $ vec(E)(r)=vec(0) quad "per " R_2<r<R_3 $
    #v(3pt)
    $ vec(E)(r)=Q_A/(4 pi epsilon_0 r^2) hat(r) quad "per " r>R_3 $
  ]
]

#yellow-box([Come leggere il campo a tratti])[
  Per ogni regione applichi sempre $E(r) 4 pi r^2=Q_"int"/epsilon_0$ e ti chiedi solo: *quanta carica racchiude la mia sfera gaussiana di raggio $r$?*
  - $r<R_1$: sono dentro il conduttore pieno, $Q_"int"=0$, campo nullo.
  - $R_1<r<R_2$: la sfera racchiude solo $+Q_A$ (la carica su $R_1$), campo $Q_A/(4 pi epsilon_0 r^2)$.
  - $R_2<r<R_3$: sono nel metallo del guscio; la sfera racchiude $+Q_A$ su $R_1$ e $-Q_A$ su $R_2$, somma zero, campo nullo (coerente con $vec(E)=0$ nei conduttori).
  - $r>R_3$: la sfera racchiude tutto, $+Q_A-Q_A+Q_A=+Q_A$, campo di nuovo $Q_A/(4 pi epsilon_0 r^2)$.
  Tutto si riduce a sommare le cariche racchiuse: è la potenza del metodo di Gauss.
]

Nei tratti conduttori il campo è nullo. Nelle regioni vuote il campo è radiale uscente perché la carica racchiusa è positiva.

#align(center, graph-card([Andamento di $E(r)$ nei gusci conduttori], cetz.canvas({
  import cetz.draw: *
  line((0.72, 0.55), (6.75, 0.55), stroke: 0.95pt + ink, mark: (end: ">"))
  line((0.72, 0.55), (0.72, 3.05), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((6.85, 0.55), [$r$], placement: "west")
  axis-label((0.58, 3.08), [$E$], placement: "east")
  // regioni nulle
  line((0.72, 0.55), (1.65, 0.55), stroke: 1.2pt + green)
  line((3.15, 0.55), (4.05, 0.55), stroke: 1.2pt + green)
  // salti e andamenti 1/r2
  line((1.65, 0.55), (1.65, 2.45), stroke: 0.9pt + ink)
  catmull((1.65, 2.45), (2.05, 1.80), (2.55, 1.36), (3.15, 1.05), stroke: 1.25pt + ink)
  line((3.15, 1.05), (3.15, 0.55), stroke: 0.9pt + ink)
  line((4.05, 0.55), (4.05, 1.55), stroke: 0.9pt + ink)
  catmull((4.05, 1.55), (4.65, 1.12), (5.35, 0.82), (6.35, 0.66), stroke: 1.25pt + ink)
  for x in (1.65, 3.15, 4.05) {
    line((x, 0.40), (x, 0.70), stroke: 0.85pt + ink)
  }
  axis-label((1.65, 0.28), [$R_1$], placement: "north")
  axis-label((3.15, 0.28), [$R_2$], placement: "north")
  axis-label((4.05, 0.28), [$R_3$], placement: "north")
  axis-label((2.25, 2.12), [$1/r^2$], placement: "south")
  axis-label((4.92, 1.35), [$1/r^2$], placement: "south")
  axis-label((1.08, 0.88), [$E=0$], placement: "south")
  axis-label((3.58, 0.88), [$E=0$], placement: "south")
})))

Se si aggiunge sulla superficie esterna $R_3$ una carica

$ Q_B=-2 dot 10^(-9) " C", $

la distribuzione interna non cambia: $+Q_A$ resta su $R_1$ e $-Q_A$ resta su $R_2$. Cambia solo la carica totale sulla superficie esterna:

$ Q_(R_3)=Q_A+Q_B=10^(-9)-2 dot 10^(-9)=-10^(-9) " C". $

Di conseguenza, per $r>R_3$ il campo è radiale entrante:

#yellow-box([Campo esterno dopo aver aggiunto $Q_B$])[
  $ vec(E)(r)=(Q_A+Q_B)/(4 pi epsilon_0 r^2) hat(r), quad r>R_3. $
]

Poiché $Q_A+Q_B<0$, il verso effettivo è opposto a $hat(r)$.

#yellow-box([Perché la parte interna non cambia])[
  Aggiungere carica fuori non tocca la configurazione interna: la carica $+Q_A$ sul conduttore centrale resta dov'è, e per induzione resta $-Q_A$ su $R_2$. Cambia solo la carica totale sulla superficie esterna $R_3$, che ora è $Q_A+Q_B$. Il segno della formula vettoriale fa il resto: se questa somma è negativa, il fattore davanti a $hat(r)$ è negativo, quindi il campo punta *verso l'interno* (entrante), anche se nella scrittura compare $+hat(r)$. È l'esempio perfetto di come il segno della carica gestisca automaticamente il verso, senza bisogno di ribaltare a mano le frecce.
]

== Capacità elettrostatica

#green-box([L'idea prima della formula])[
  Immagina di "riempire d'acqua" un conduttore caricandolo: ogni volta che aggiungi carica, il suo potenziale $V$ sale (è come il livello dell'acqua in un recipiente). La domanda chiave è: *quanta carica riesco a mettere prima che il potenziale salga di un volt?* Un recipiente largo accoglie tanta acqua alzando poco il livello; un recipiente stretto si riempie subito. La *capacità* è esattamente questo: dice *quanta carica accumula il conduttore per ogni volt di potenziale*. Più è grande la capacità, più carica entra a parità di "sforzo" (cioè di potenziale raggiunto).
]

La *capacità elettrostatica* misura quanta carica deve essere fornita a un conduttore per portarlo a un certo potenziale. Per un conduttore isolato si definisce

$ C = Q/V, $

dove $V$ è il potenziale del conduttore rispetto al riferimento scelto, di solito l'infinito o la terra. L'unità di misura è il *farad*:

$ [C] = "F" = "C"/"V". $

#yellow-box([Cosa dicono i simboli])[
  - $Q$ è la carica accumulata sul conduttore, in coulomb ($"C"$).
  - $V$ è il potenziale a cui si porta il conduttore, in volt ($"V"$).
  - $C$ è la capacità, in farad ($"F"$). Un farad è un'unità enorme: significa $1$ coulomb per ogni volt. Nella pratica si usano sottomultipli come il microfarad ($1 mu"F"=10^(-6) " F"$) o il picofarad ($1 "pF"=10^(-12) " F"$).
]

Dire che un conduttore ha capacità grande significa che può accumulare molta carica aumentando poco il proprio potenziale.

#blue-box([Capacità])[
  La capacità non dipende da quanta carica si mette sul conduttore: dipende solo dalla geometria e dal mezzo che lo circonda.
]

#yellow-box([Perché $C$ non dipende da $Q$, se nella formula c'è $Q$?])[
  Sembra una contraddizione: come fa $C=Q/V$ a non dipendere da $Q$? Il punto è che $V$ è *proporzionale* a $Q$. Se raddoppi la carica, raddoppi il potenziale: il rapporto $Q/V$ resta identico. È come dire che la pendenza di una salita non dipende da quanti passi fai: il rapporto fra dislivello e distanza è sempre lo stesso. Negli esempi che seguono vedrai infatti che $Q$ "si semplifica" sempre, lasciando solo geometria e mezzo.
]

=== Esempio: calcolo della capacità

Il procedimento è sempre lo stesso:

1. si calcola il potenziale del conduttore, oppure la differenza di potenziale tra due conduttori;
2. si sostituisce nella definizione di capacità.

Per un *conduttore sferico isolato* di raggio $R$ nel vuoto, con riferimento $V(infinity)=0$,

$ V(R)=Q/(4 pi epsilon_0 R), $

quindi

#yellow-box([Perché questo passaggio])[
  Il potenziale sulla superficie di una sfera carica è esattamente quello di una carica puntiforme $Q$ posta nel centro, valutato alla distanza $R$: cioè $V=Q/(4 pi epsilon_0 r)$ con $r=R$. Da fuori, una sfera uniformemente carica "si comporta" come se tutta la carica fosse concentrata al centro (è una conseguenza del teorema di Gauss). Ora basta inserire questo $V$ nella definizione $C=Q/V$ e dividere: la $Q$ al numeratore di $C$ e la $Q$ dentro $V$ si annullano.
]

#green-box([Conduttore sferico isolato])[
  $ C = Q/V = Q/(Q/(4 pi epsilon_0 R)) = 4 pi epsilon_0 R. $
]

La carica $Q$ si semplifica: resta solo la geometria, cioè il raggio $R$, e il mezzo, cioè $epsilon_0$ nel vuoto. Nota che *più grande è la sfera, più grande è la capacità*: una sfera grande "incassa" più carica senza alzare troppo il potenziale, esattamente come un recipiente largo.

#purple-box([Esempio numerico: quanto è grande un farad?])[
  Quanto dovrebbe essere grande una sfera per avere capacità $C=1 " F"$? Da $C=4 pi epsilon_0 R$ ricaviamo $R=C/(4 pi epsilon_0)$. Con $epsilon_0 = 8,85 dot 10^(-12) " F/m"$ e ricordando che $1/(4 pi epsilon_0) approx 9 dot 10^9 " m/F"$:
  $ R = C dot 1/(4 pi epsilon_0) = 1 dot 9 dot 10^9 approx 9 dot 10^9 " m". $
  Sono $9$ milioni di chilometri, cioè circa $1400$ volte il raggio della Terra! Ecco perché il farad è un'unità gigantesca e nei circuiti reali si usano micro e picofarad. Per confronto, l'intera Terra (raggio $R approx 6,4 dot 10^6 " m"$) ha capacità
  $ C_"Terra" = 4 pi epsilon_0 R = R/(9 dot 10^9) approx 7 dot 10^(-4) " F" approx 700 " "mu"F". $
]

#align(center, graph-card([Conduttore isolato e capacità], cetz.canvas({
  import cetz.draw: *
  circle((1.55, 1.60), radius: 0.82, stroke: 1.0pt + ink, fill: rgb("#f5f5f5"))
  for x in (-0.36, -0.12, 0.12, 0.36) {
    line((1.55 + x, 1.00), (1.55 + x + 0.46, 1.92), stroke: 0.7pt + rgb("#aeb5ba"))
  }
  line((1.55, 1.60), (2.14, 1.02), stroke: 0.85pt + ink, mark: (end: ">"))
  axis-label((2.18, 0.92), [$R$], placement: "north")
  axis-label((0.78, 2.48), [$Q$], placement: "south")
  axis-label((0.74, 0.62), [$V$], placement: "north")
  axis-label((4.50, 2.20), [$C=Q/V$], placement: "west")
  axis-label((4.50, 1.45), [$V(R)=Q/(4 pi epsilon_0 R)$], placement: "west")
  axis-label((4.50, 0.70), [$C=4 pi epsilon_0 R$], placement: "west")
})))

Se il conduttore non è isolato ma è vicino ad altri conduttori o alla terra, la situazione è più generale: la sua carica e il suo potenziale sono influenzati dall'induzione elettrostatica con l'ambiente.

== Condensatori

#green-box([L'idea prima della formula])[
  Un conduttore isolato non è un buon "magazzino" di carica: per metterci tanta carica devi portarlo a potenziali altissimi. L'idea geniale del condensatore è mettere *vicino* al conduttore carico un secondo conduttore con carica opposta. Le due cariche opposte si "tengono" a vicenda e abbassano molto il potenziale necessario: così a parità di potenziale ci sta molta più carica. In altre parole, avvicinare la carica negativa "fa spazio" a più carica positiva. Per questo un condensatore ha capacità molto maggiore di un conduttore isolato delle stesse dimensioni.
]

Un *condensatore* è formato da due conduttori posti in *induzione completa*: le linee di campo che partono da un conduttore terminano sull'altro. I due conduttori portano cariche opposte $+Q$ e $-Q$.

Il condensatore non serve solo ad accumulare carica: serve soprattutto ad accumulare energia nel campo elettrico creato tra le armature.

La capacità di un condensatore si definisce usando la differenza di potenziale fra le armature:

#yellow-box([Capacità di un condensatore])[
  $ C = Q/(Delta V). $

  Si sceglie $Delta V = V_+ - V_- > 0$, cioè la differenza di potenziale è presa positiva.

  Attenzione alla differenza con il conduttore isolato: lì usavamo il potenziale $V$ del singolo conduttore; qui usiamo la *differenza* di potenziale $Delta V$ fra le due armature. La $Q$ è la carica di una sola armatura (l'altra ha $-Q$), non la somma delle due, che sarebbe zero.
]

#align(center, graph-card([Condensatore e induzione completa], cetz.canvas({
  import cetz.draw: *
  // Condensatore sferico come negli appunti: due conduttori concentrici.
  // L'induzione è completa perché tutte le linee partono dal conduttore 1
  // e terminano sulla superficie interna del conduttore 2.
  let O = (2.05, 1.85)
  circle(O, radius: 1.46, stroke: 1.15pt + ink, fill: rgb("#e9edf0"))
  circle(O, radius: 1.08, stroke: 1.05pt + ink, fill: rgb("#fbfcfd"))
  circle(O, radius: 0.58, stroke: 1.05pt + ink, fill: rgb("#e9edf0"))

  for p in ((2.05, 2.22), (1.72, 1.85), (2.38, 1.85), (2.05, 1.48)) {
    axis-label(p, text(size: 10pt, weight: "bold", fill: red)[$+$])
  }
  for p in ((2.05, 2.94), (2.80, 2.60), (2.80, 1.10), (2.05, 0.76), (1.30, 1.10), (1.30, 2.60)) {
    axis-label(p, text(size: 10pt, weight: "bold", fill: blue)[$-$])
  }

  line((2.05, 2.46), (2.05, 2.82), stroke: 0.95pt + blue, mark: (end: ">"))
  line((2.48, 2.28), (2.72, 2.52), stroke: 0.95pt + blue, mark: (end: ">"))
  line((2.66, 1.85), (3.02, 1.85), stroke: 0.95pt + blue, mark: (end: ">"))
  line((2.48, 1.42), (2.72, 1.18), stroke: 0.95pt + blue, mark: (end: ">"))
  line((2.05, 1.24), (2.05, 0.88), stroke: 0.95pt + blue, mark: (end: ">"))
  line((1.62, 1.42), (1.38, 1.18), stroke: 0.95pt + blue, mark: (end: ">"))
  line((1.44, 1.85), (1.08, 1.85), stroke: 0.95pt + blue, mark: (end: ">"))
  line((1.62, 2.28), (1.38, 2.52), stroke: 0.95pt + blue, mark: (end: ">"))

  axis-label((2.05, 3.54), [conduttore 2: $-Q$], placement: "south")
  axis-label((2.05, 1.86), [$+Q$], placement: "center")
  axis-label((0.94, 3.03), [$V_-$], placement: "south")
  axis-label((2.84, 0.62), [$V_+$], placement: "north")

  line((0.59, 0.78), (0.28, 0.78), stroke: 0.9pt + ink)
  line((0.28, 0.78), (0.28, 0.34), stroke: 0.9pt + ink)
  line((0.04, 0.34), (0.52, 0.34), stroke: 0.9pt + ink)
  line((0.10, 0.20), (0.46, 0.20), stroke: 0.9pt + ink)
  line((0.17, 0.08), (0.39, 0.08), stroke: 0.9pt + ink)

  line((3.90, 0.48), (3.90, 3.42), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((4.30, 2.92), [condensatore $=$ due conduttori], placement: "west")
  axis-label((4.30, 2.56), [in induzione completa], placement: "west")
  axis-label((4.30, 1.98), [tutte le linee di campo], placement: "west")
  axis-label((4.30, 1.64), [del conduttore $1$ finiscono nel $2$], placement: "west")
  axis-label((4.30, 0.98), [$C := Q/(Delta V) quad [F]$], placement: "west")
  axis-label((5.96, 0.58), text(fill: rgb("#c77898"))[$Delta V>0$], placement: "west")
})))

Nella pratica si usano geometrie semplici perché permettono di calcolare il campo e quindi la differenza di potenziale. Gli appunti distinguono tre casi fondamentali:

- *condensatore sferico*, ideale per simmetria sferica;
- *condensatore cilindrico*, approssimato bene quando la lunghezza è molto maggiore della separazione fra le armature;
- *condensatore piano*, approssimato bene quando la distanza fra le piastre è molto minore della loro area caratteristica.

#grid(columns: (1fr, 1fr, 1fr), gutter: 8pt,
  graph-card([Sferico], cetz.canvas({
    import cetz.draw: *
    circle((1.45, 1.45), radius: 0.54, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
    circle((1.45, 1.45), radius: 1.02, stroke: 1.0pt + ink, fill: none)
    line((0.35, 0.35), (0.35, 0.82), stroke: 0.8pt + ink)
    line((0.15, 0.35), (0.55, 0.35), stroke: 0.8pt + ink)
    line((0.22, 0.25), (0.48, 0.25), stroke: 0.8pt + ink)
    line((0.29, 0.15), (0.41, 0.15), stroke: 0.8pt + ink)
    axis-label((1.45, 0.18), [geometria semplice], placement: "north")
  })),
  graph-card([Cilindrico], cetz.canvas({
    import cetz.draw: *
    // Cilindro coassiale: ellissi alle estremità e generatrici verticali.
    circle((1.48, 2.20), radius: (0.78, 0.22), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
    circle((1.48, 0.82), radius: (0.78, 0.22), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
    line((0.70, 2.20), (0.70, 0.82), stroke: 1.0pt + ink)
    line((2.26, 2.20), (2.26, 0.82), stroke: 1.0pt + ink)
    circle((1.48, 2.20), radius: (0.32, 0.10), stroke: 0.9pt + blue, fill: rgb("#edf3f8"))
    circle((1.48, 0.82), radius: (0.32, 0.10), stroke: 0.9pt + blue, fill: rgb("#edf3f8"))
    line((1.16, 2.20), (1.16, 0.82), stroke: 0.9pt + blue)
    line((1.80, 2.20), (1.80, 0.82), stroke: 0.9pt + blue)
    for y in (1.12, 1.50, 1.88) {
      line((1.80, y), (2.23, y), stroke: 0.75pt + blue, mark: (end: ">"))
      line((1.16, y), (0.73, y), stroke: 0.75pt + blue, mark: (end: ">"))
    }
    line((0.46, 0.42), (0.46, 0.78), stroke: 0.8pt + ink)
    line((0.28, 0.42), (0.64, 0.42), stroke: 0.8pt + ink)
    line((0.34, 0.33), (0.58, 0.33), stroke: 0.8pt + ink)
    line((0.40, 0.24), (0.52, 0.24), stroke: 0.8pt + ink)
    axis-label((1.48, 0.04), [$s << ell$], placement: "north")
  })),
  graph-card([Piano], cetz.canvas({
    import cetz.draw: *
    line((0.55, 1.90), (2.35, 1.90), stroke: 1.1pt + ink)
    line((0.55, 1.15), (2.35, 1.15), stroke: 1.1pt + ink)
    for x in (0.78, 1.12, 1.46, 1.80, 2.14) {
      line((x, 1.80), (x, 1.25), stroke: 0.9pt + blue, mark: (end: ">"))
    }
    axis-label((2.62, 1.52), [$h << "area"$], placement: "west")
    axis-label((1.45, 0.42), [geometria semplice], placement: "north")
  })),
)

=== Esempio: condensatore sferico

Per il *condensatore sferico*, con raggi $R_1$ e $R_2$ e cariche $+Q$ e $-Q$, si calcola prima la differenza di potenziale tra le armature. Seguiamo i due passi del procedimento: prima il $Delta V$, poi $C=Q/(Delta V)$.

Tra le due superfici il campo è radiale e vale

$ E(r)=Q/(4 pi epsilon_0 r^2). $

#yellow-box([Perché solo la sfera interna conta per il campo])[
  Nello spazio fra le armature ($R_1 < r < R_2$) una superficie gaussiana sferica racchiude solo la carica $+Q$ dell'armatura interna; la carica $-Q$ è più esterna e non viene racchiusa. Quindi il campo è quello di una carica puntiforme $Q$: $E(r)=Q/(4 pi epsilon_0 r^2)$, diretto radialmente.
]

Poiché $R_2>R_1$, scegliamo positiva la differenza

$ Delta V = V_1 - V_2 = integral_(R_1)^(R_2) E(r) dif r = Q/(4 pi epsilon_0) (1/R_1 - 1/R_2). $

#yellow-box([Perché questo passaggio: l'integrale])[
  La differenza di potenziale fra due punti è $V_1 - V_2 = integral_(R_1)^(R_2) E dif r$: si "accumula" il campo lungo il cammino dall'armatura interna a quella esterna. Calcoliamo l'integrale passo passo. Portando fuori le costanti:
  $ integral_(R_1)^(R_2) Q/(4 pi epsilon_0 r^2) dif r = Q/(4 pi epsilon_0) integral_(R_1)^(R_2) r^(-2) dif r. $
  La primitiva di $r^(-2)$ è $-r^(-1)=-1/r$, quindi
  $ integral_(R_1)^(R_2) r^(-2) dif r = [-1/r]_(R_1)^(R_2) = -1/R_2 + 1/R_1 = 1/R_1 - 1/R_2. $
  Mettendo insieme si ottiene proprio il risultato scritto sopra. Il segno è positivo perché $R_1 < R_2$, quindi $1/R_1 > 1/R_2$: $Delta V>0$ come previsto.
]

Ora si usa la definizione $C=Q/(Delta V)$:

#yellow-box([Come si arriva al risultato finale])[
  Sostituiamo $Delta V$ in $C=Q/(Delta V)$. La $Q$ si semplifica subito:
  $ C = Q/(Q/(4 pi epsilon_0) (1/R_1 - 1/R_2)) = (4 pi epsilon_0)/(1/R_1 - 1/R_2). $
  Ora sistemiamo la frazione al denominatore: $1/R_1 - 1/R_2 = (R_2 - R_1)/(R_1 R_2)$. Dividere per questa frazione equivale a moltiplicare per il suo reciproco $(R_1 R_2)/(R_2 - R_1)$, da cui il risultato.
]

#green-box([Condensatore sferico])[
  $ C = Q/(Delta V) = (4 pi epsilon_0 R_1 R_2)/(R_2 - R_1). $
]

Anche qui $Q$ si semplifica: la capacità dipende solo da $R_1$, $R_2$ e dal mezzo tra le armature.

#yellow-box([Controllo del caso limite])[
  Se le due sfere sono molto vicine, cioè $R_2 = R_1 + d$ con $d$ piccolissimo, allora $R_2 - R_1 = d$ e $R_1 R_2 approx R_1^2 = A/(4 pi)$ (dove $A=4 pi R_1^2$ è l'area della sfera). Sostituendo: $C approx (4 pi epsilon_0 dot A/(4 pi))/d = (epsilon_0 A)/d$. Ritroviamo esattamente la formula del condensatore *piano*! Questo ha senso: due sfere vicinissime, viste da vicino, sembrano due lastre piane parallele.
]

#purple-box([Esempio numerico])[
  Sfere concentriche con $R_1 = 5 " cm" = 0,05 " m"$ e $R_2 = 6 " cm" = 0,06 " m"$, nel vuoto. Usando $4 pi epsilon_0 = 1/(9 dot 10^9) " F/m"$:
  $ C = (4 pi epsilon_0 R_1 R_2)/(R_2 - R_1) = (0,05 dot 0,06)/(9 dot 10^9 dot (0,06 - 0,05)) = (0,003)/(9 dot 10^9 dot 0,01). $
  $ C = (0,003)/(9 dot 10^7) approx 3,3 dot 10^(-11) " F" = 33 " pF". $
]

== Campo di un piano infinito carico

#green-box([L'idea prima della formula])[
  Questo risultato è il "mattone" con cui costruiremo il condensatore piano, quindi vale la pena capirlo bene. Immagina di stare di fronte a una parete infinita carica positivamente. In qualsiasi punto ti trovi, la parete ti appare uguale in tutte le direzioni lungo il piano: non c'è motivo per cui il campo punti "a destra" piuttosto che "a sinistra". L'unica direzione "speciale" è quella *perpendicolare* alla parete. Quindi il campo è perpendicolare al piano, esce dritto da entrambe le facce, e — sorpresa — *non si indebolisce allontanandosi*: una lastra infinita è così grande che spostandoti non cambia nulla.
]

Per una lastra piana infinita con densità superficiale uniforme $sigma$, la simmetria impone che il campo sia perpendicolare al piano e abbia lo stesso modulo sui due lati. Si usa una superficie gaussiana cilindrica che attraversa il piano.

#yellow-box([Cosa sono i simboli e cos'è la "superficie gaussiana"])[
  - $sigma$ (sigma) è la *densità superficiale di carica*: carica per unità di area, in $"C"/"m"^2$.
  - $Sigma$ (sigma maiuscola) è l'area di *una* base del cilindretto immaginario, in $"m"^2$.
  - La superficie gaussiana è una superficie chiusa fittizia, scelta da noi solo per applicare il teorema di Gauss. Qui scegliamo un cilindro con l'asse perpendicolare al piano e le due basi simmetriche rispetto ad esso.
]

La superficie laterale del cilindro non contribuisce al flusso perché lì il campo è parallelo alla superficie, quindi perpendicolare alla normale laterale.

#yellow-box([Perché la parete laterale non conta])[
  Il flusso misura quanto campo "buca" una superficie: dipende da $vec(E) dot dif vec(S)$, cioè dalla componente di $vec(E)$ *perpendicolare* alla superficie. Sulla parete laterale del cilindro la normale punta verso l'esterno radiale, mentre $vec(E)$ è perpendicolare al piano (cioè parallelo all'asse): i due sono ortogonali, il prodotto scalare è zero. Il campo "scivola lungo" la parete laterale senza bucarla, quindi non dà flusso.
]

Il flusso passa solo dalle due basi:

$ integral_S vec(E) dot dif vec(S) = 2 E Sigma. $

#yellow-box([Da dove esce il fattore 2])[
  Le basi sono *due* (una da ogni lato del piano). Su ciascuna il campo è perpendicolare e uscente, quindi ciascuna dà flusso $E Sigma$. Sommando le due basi: $E Sigma + E Sigma = 2 E Sigma$. Il $2$ viene dalle due facce, non da altro.
]

La carica racchiusa è $Q_"int"=sigma Sigma$. Dal teorema di Gauss:

#yellow-box([Come si chiude il conto])[
  Il teorema di Gauss dice flusso $= Q_"int"/epsilon_0$. Eguagliando le due espressioni:
  $ 2 E Sigma = (sigma Sigma)/epsilon_0. $
  L'area $Sigma$ si semplifica (compare in entrambi i membri) e resta $2 E = sigma/epsilon_0$, da cui $E=sigma/(2 epsilon_0)$. Il fatto che $Sigma$ sparisca conferma che il campo *non dipende* da quanto è grande il cilindro né da quanto sei lontano dal piano.
]

#yellow-box([Piano infinito uniformemente carico])[
  $ E = sigma/(2 epsilon_0). $

  Se $sigma>0$ il campo è uscente dai due lati; se $sigma<0$ è entrante.
]

#red-box([Attenzione: questo $1/2$ scompare nel condensatore])[
  Il campo di *un solo* piano è $sigma/(2 epsilon_0)$, con il $2$ al denominatore. Nel condensatore piano avremo *due* piani affiancati e i loro campi si sommeranno fra le armature, facendo sparire il $2$: il campo diventerà $sigma/epsilon_0$. Non confondere i due risultati: dipende da quanti piani ci sono.
]

#align(center, graph-card([Gauss per il piano infinito], image("reference/images/piano_indefinito.png", width: 92%)))

== Condensatore piano

#green-box([L'idea prima della formula])[
  Mettiamo due delle lastre infinite di prima, una positiva e una negativa, parallele e vicine. Il trucco è il *principio di sovrapposizione*: il campo totale è la somma dei campi dei due piani presi separatamente. Fra le armature i due campi puntano nello stesso verso (dalla lastra $+$ verso la lastra $-$) e si rinforzano; all'esterno puntano in versi opposti e si cancellano. Il risultato è un campo uniforme "intrappolato" fra le armature e quasi nulla all'esterno: esattamente quello che serve per accumulare energia in modo controllato.
]

Un condensatore piano è formato da due lastre conduttrici parallele, molto estese rispetto alla distanza che le separa. Ciascuna lastra, presa da sola, genera un campo di modulo $sigma/(2 epsilon_0)$ su ciascun lato.

Per sovrapposizione:

- tra le armature i due campi hanno lo stesso verso e si sommano;
- all'esterno hanno verso opposto e si annullano.

#yellow-box([I conti della sovrapposizione])[
  Tra le armature i due contributi si sommano: $sigma/(2 epsilon_0) + sigma/(2 epsilon_0) = sigma/epsilon_0$. Ecco perché qui il $2$ sparisce. All'esterno i due campi hanno modulo uguale ma verso opposto: $sigma/(2 epsilon_0) - sigma/(2 epsilon_0) = 0$.
]

Per un condensatore piano ideale nel vuoto:

#green-box([Condensatore piano ideale])[
  $ E_"interno" = sigma/epsilon_0, quad E_"esterno"=0. $
]

Se l'area delle armature è $A$, allora $sigma=Q/A$ e $Delta V=E d$. La capacità vale

#yellow-box([Perché questo passaggio: da $E$ a $C$])[
  Mettiamo insieme tre fatti.
  1. La densità di carica è $sigma=Q/A$ (carica $Q$ spalmata sull'area $A$).
  2. Il campo fra le armature è uniforme, quindi la differenza di potenziale è semplicemente "campo per distanza": $Delta V = E d$. (Vale solo perché $E$ è costante: per un campo uniforme l'integrale $integral E dif r$ si riduce a $E d$.)
  3. Sostituendo $E=sigma/epsilon_0=Q/(epsilon_0 A)$, otteniamo $Delta V = (Q d)/(epsilon_0 A)$.

  Infine in $C=Q/(Delta V)$ la $Q$ si semplifica:
  $ C = Q/((Q d)/(epsilon_0 A)) = (epsilon_0 A)/d. $
]

#yellow-box([Capacità del condensatore piano])[
  $ C = Q/(Delta V) = (epsilon_0 A)/d. $
]

#green-box([Cosa ci dice la formula])[
  La capacità *cresce* con l'area $A$ (piastre più grandi accolgono più carica) e *diminuisce* con la distanza $d$ (piastre più lontane si "aiutano" meno). Questo spiega i condensatori reali: per fare tanta capacità in poco spazio si usano grandi superfici arrotolate o impilate, tenute pochissimo distanti.
]

#purple-box([Esempio numerico])[
  Due piastre di area $A = 100 " cm"^2 = 10^(-2) " m"^2$ separate da $d = 1 " mm" = 10^(-3) " m"$, nel vuoto:
  $ C = (epsilon_0 A)/d = (8,85 dot 10^(-12) dot 10^(-2))/(10^(-3)) = 8,85 dot 10^(-11) " F" approx 88 " pF". $
  Se ora collego le piastre a una batteria da $Delta V = 12 " V"$, la carica accumulata è
  $ Q = C Delta V = 8,85 dot 10^(-11) dot 12 approx 1,1 dot 10^(-9) " C" = 1,1 " nC". $
]

#align(center, graph-card([Condensatore piano: sovrapposizione dei campi], image("reference/images/piani_affiancati.png", width: 92%)))

== Elettrostatica nei dielettrici

#green-box([L'idea prima della formula])[
  Cosa succede se infili un pezzo di plastica o di vetro fra le armature di un condensatore? Questi materiali sono *isolanti*: le cariche non possono scappare via come in un metallo. Però gli atomi non sono rigidi. Sotto un campo elettrico, dentro ogni atomo il nucleo positivo viene spinto da una parte e la nuvola di elettroni dall'altra: l'atomo si "allunga" e diventa un piccolissimo dipolo. Miliardi di questi dipolini allineati creano, sulle superfici del materiale, uno strato di carica che *si oppone* al campo originario e lo indebolisce. Indebolendo il campo si abbassa il $Delta V$, e — visto che $C=Q/(Delta V)$ — la capacità *aumenta*. Ecco perché i condensatori veri sono riempiti di dielettrico.
]

Un *dielettrico* è un materiale isolante. Le cariche non sono libere di muoversi come in un conduttore, ma gli atomi o le molecole possono deformarsi leggermente sotto l'azione di un campo elettrico esterno.

Questo spostamento microscopico separa i centri delle cariche positive e negative: l'atomo o la molecola si *polarizza* e si comporta come un piccolo dipolo elettrico.

La differenza rispetto a un conduttore è fondamentale: nel conduttore le cariche libere si spostano macroscopicamente; nel dielettrico le cariche restano legate, ma si separano leggermente dentro atomi o molecole.

#blue-box([Polarizzazione])[
  La polarizzazione è la comparsa di dipoli elettrici microscopici orientati dal campo esterno. Non produce cariche libere nel volume: produce cariche di polarizzazione, soprattutto sulle superfici del dielettrico.
]

#align(center, graph-card([Polarizzazione microscopica del dielettrico], cetz.canvas({
  import cetz.draw: *
  // neutral atom
  circle((0.85, 1.65), radius: 0.46, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  axis-label((0.85, 1.65), [$+$])
  for p in ((0.55, 1.90), (1.14, 1.90), (0.55, 1.40), (1.14, 1.40)) {
    axis-label(p, [$-$])
  }
  axis-label((0.85, 0.72), [neutro], placement: "north")

  // external field atom
  circle((3.35, 1.65), radius: 0.46, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  line((2.68, 1.65), (4.13, 1.65), stroke: 1.0pt + blue, mark: (end: ">"))
  circle((3.18, 1.65), radius: 0.12, stroke: 0.8pt + ink, fill: rgb("#edf3f8"))
  axis-label((3.18, 1.65), [$-$])
  circle((3.55, 1.65), radius: 0.12, stroke: 0.8pt + ink, fill: rgb("#fff4f4"))
  axis-label((3.55, 1.65), [$+$])
  axis-label((4.22, 1.92), [$vec(E)_"esterno"$], placement: "west")
  axis-label((3.35, 0.72), [polarizzato], placement: "north")

  // macroscopic sample
  catmull((5.25, 0.88), (5.50, 2.35), (6.80, 2.55), (7.55, 1.85), (7.25, 0.70), (6.00, 0.58), (5.25, 0.88), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  for y in (1.02, 1.42, 1.82, 2.22) {
    line((5.48, y), (7.22, y), stroke: 0.85pt + blue, mark: (end: ">"))
  }
  for p in ((5.75, 2.18), (6.35, 2.18), (6.95, 2.18), (5.75, 1.62), (6.35, 1.62), (6.95, 1.62), (5.75, 1.06), (6.35, 1.06)) {
    line((p.at(0) - 0.10, p.at(1)), (p.at(0) + 0.10, p.at(1)), stroke: 0.8pt + ink)
    axis-label((p.at(0) - 0.16, p.at(1)), [$-$], placement: "east")
    axis-label((p.at(0) + 0.18, p.at(1)), [$+$], placement: "west")
  }
  axis-label((6.45, 0.24), [$vec(E)_"int"=vec(E)_"esterno"+vec(E)_"indotto"$], placement: "north")
})))

== Condensatore riempito di dielettrico

#green-box([Attenzione alla situazione: batteria scollegata])[
  C'è un dettaglio cruciale per capire cosa cambia e cosa resta uguale. Qui *prima* carichiamo il condensatore con la batteria, *poi* la scolleghiamo, e solo *dopo* inseriamo il dielettrico. Una volta scollegata la batteria, la carica $Q$ sulle armature è "intrappolata": non può né entrare né uscire. Quindi $Q$ resta fissa, e a variare saranno il campo e il potenziale. (Se invece la batteria restasse collegata, sarebbe $Delta V$ a restare fisso e a variare la carica: caso diverso!)
]

Consideriamo un condensatore piano inizialmente collegato a una batteria con differenza di potenziale $V_0$ e capacità $C_0$. Prima dell'inserimento del dielettrico:

$ Q_0=C_0 V_0, quad E_0=sigma_l/epsilon_0, $

dove $sigma_l$ è la densità superficiale di carica libera sulle armature. Il pedice $l$ sta per "libera": è la carica vera che abbiamo messo sulle armature, quella che possiamo controllare dall'esterno.

Se si scollega la batteria, il sistema diventa isolato e la carica libera resta costante. Inserendo un dielettrico lineare con costante dielettrica $k>1$:

$ V = V_0/k < V_0, quad E = E_0/k < E_0, quad C = k C_0 > C_0. $

#yellow-box([Perché compare proprio il fattore $k$])[
  La *costante dielettrica* $k$ (a volte indicata $epsilon_r$, "relativa") è un numero $>1$ che misura quanto il materiale è bravo a polarizzarsi. Il dielettrico riduce il campo esattamente di un fattore $k$: $E = E_0/k$. Poiché $Delta V = E d$ e la distanza $d$ non cambia, anche il potenziale si riduce dello stesso fattore: $V = V_0/k$. Infine, la carica $Q$ è rimasta uguale (batteria scollegata!), quindi
  $ C = Q/V = Q/(V_0 slash k) = k dot Q/V_0 = k C_0. $
  Il campo si divide per $k$, ma la capacità si moltiplica per $k$: sono effetti coerenti, perché capacità grande significa proprio "poco potenziale per la stessa carica". Valori tipici: aria $k approx 1$, carta $k approx 3$, acqua $k approx 80$.
]

Qui la carica libera sulle armature non cambia perché non c'è più un collegamento con l'esterno. Cambiano invece campo e potenziale perché il dielettrico polarizzato genera un campo indotto opposto al campo originario.

#green-box([Effetto del dielettrico nel condensatore isolato])[
  A carica libera fissata, il dielettrico riduce campo e differenza di potenziale, quindi aumenta la capacità.
]

Sulle superfici del dielettrico compaiono cariche di polarizzazione $sigma_p^+$ e $sigma_p^-$. Il campo totale interno è minore del campo che ci sarebbe nel vuoto:

$ E = (abs(sigma_l)-abs(sigma_p))/epsilon_0. $

#yellow-box([Da dove viene questa formula])[
  Il dielettrico polarizzato ha sulla faccia vicina all'armatura $+$ uno strato di carica negativa $sigma_p$, e viceversa: in pratica due strati di carica che fanno il loro mini-condensatore, con campo *opposto* a quello delle armature. Quindi la carica "efficace" che crea il campo non è tutta $sigma_l$, ma $sigma_l$ parzialmente cancellata da $sigma_p$. Mettendo questa carica netta $abs(sigma_l)-abs(sigma_p)$ nella formula del piano $E=sigma/epsilon_0$ si ottiene il campo ridotto. È il campo indotto dai dipoli che "mangia" parte del campo originario.
]

#purple-box([Esempio numerico])[
  Un condensatore ha $C_0 = 100 " pF"$ ed è caricato a $V_0 = 50 " V"$ (carica $Q = C_0 V_0 = 5 dot 10^(-9) " C"$). Scolleghiamo la batteria e inseriamo un dielettrico con $k = 4$. Allora:
  $ C = k C_0 = 400 " pF", quad V = V_0/k = 50/4 = 12,5 " V". $
  La carica è rimasta $Q = 5 " nC"$; lo verifichiamo: $Q = C V = 400 dot 10^(-12) dot 12,5 = 5 dot 10^(-9) " C"$. Tutto torna.
]

#align(center, graph-card([Condensatore piano con dielettrico], cetz.canvas({
  import cetz.draw: *
  axis-label((1.75, 4.05), [prima], placement: "south")
  axis-label((5.95, 4.05), [dopo], placement: "south")
  line((3.70, 0.45), (3.70, 3.80), stroke: 0.55pt + rgb("#ccd4d8"))

  // Prima: condensatore nel vuoto collegato alla batteria.
  circle((0.72, 2.65), radius: 0.30, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  axis-label((0.72, 2.65), [$V_0$])
  line((1.02, 2.65), (1.38, 2.65), stroke: 0.9pt + ink)
  line((1.02, 2.65), (1.02, 1.30), stroke: 0.9pt + ink)
  line((1.02, 1.30), (1.38, 1.30), stroke: 0.9pt + ink)
  line((1.55, 3.35), (1.55, 1.00), stroke: 1.05pt + ink)
  line((2.15, 3.35), (2.15, 1.00), stroke: 1.05pt + ink)
  for y in (1.42, 1.92, 2.42, 2.92) {
    line((1.68, y), (2.02, y), stroke: 0.9pt + blue, mark: (end: ">"))
  }
  axis-label((1.55, 3.58), [$+$], placement: "south")
  axis-label((2.15, 3.58), [$-$], placement: "south")
  line((2.38, 3.35), (2.38, 1.00), stroke: 0.8pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.60, 2.18), [$d$], placement: "west")
  axis-label((1.85, 0.55), [$C_0$, $Q_0=C_0 V_0$], placement: "north")
  axis-label((2.85, 2.85), [$E_0=sigma_l/epsilon_0$], placement: "west")
  axis-label((2.85, 1.70), [vuoto], placement: "west")

  // Dopo: batteria scollegata, carica libera costante, dielettrico inserito.
  line((4.60, 3.35), (7.05, 3.35), stroke: 1.05pt + ink)
  line((4.60, 1.00), (7.05, 1.00), stroke: 1.05pt + ink)
  rect((4.90, 1.30), (6.75, 3.05), stroke: 0.85pt + green, fill: rgb("#edf8f4"))
  for x in (4.95, 5.35, 5.75, 6.15, 6.55) {
    axis-label((x, 3.57), [$+$], placement: "south")
    axis-label((x, 0.78), [$-$], placement: "north")
  }
  for x in (5.15, 5.55, 5.95, 6.35) {
    axis-label((x, 2.83), [$-$])
    axis-label((x, 1.52), [$+$])
    line((x, 2.48), (x, 1.86), stroke: 0.85pt + blue, mark: (end: ">"))
  }
  line((7.35, 3.35), (7.35, 1.00), stroke: 0.8pt + ink, mark: (start: "|", end: "|"))
  axis-label((7.56, 2.18), [$d$], placement: "west")
  axis-label((5.82, 0.42), [dielettrico $k>1$], placement: "north")
  axis-label((7.80, 2.92), [$sigma_p^-$], placement: "west")
  axis-label((7.80, 1.46), [$sigma_p^+$], placement: "west")
})))

== Momento di dipolo e vettore di polarizzazione

#green-box([L'idea prima della formula])[
  Come quantifichiamo "quanto è polarizzato" un dipolo o un materiale? Per un singolo dipolo serve un numero che dica due cose: *quanta carica* è separata e *di quanto*. Una carica grande spostata di poco, o una carica piccola spostata di tanto, possono avere lo stesso effetto a distanza: per questo si moltiplicano fra loro. Questo è il momento di dipolo. Per un intero materiale, invece, conviene una grandezza "spalmata": il momento di dipolo *per unità di volume*, che ci dice quanto è densamente polarizzato il pezzo, indipendentemente da quanto è grande.
]

Il *momento di dipolo elettrico* descrive una coppia di cariche opposte separate da una distanza $d$:

$ vec(p)=q vec(d). $

Il vettore $vec(d)$ è diretto dalla carica negativa alla carica positiva, quindi anche $vec(p)$ punta dal $-$ al $+$. La sua unità di misura è $"C" dot "m"$ (coulomb per metro): carica per distanza.

Nel materiale si introduce il campo di polarizzazione $vec(P)$, cioè il momento di dipolo per unità di volume:

Quindi $vec(P)$ descrive l'effetto medio di moltissimi dipoli microscopici: non è il momento di un singolo dipolo, ma una grandezza macroscopica del materiale. La sua unità è $("C" dot "m")/"m"^3 = "C"/"m"^2$: la stessa di una densità superficiale di carica, e non è un caso, come vedremo subito.

#blue-box([Vettore di polarizzazione])[
  $ vec(P) = ("momento di dipolo")/("volume"). $

  Per un dielettrico lineare isotropo:
  $ vec(P)=epsilon_0 chi vec(E), quad k=1+chi. $
]

Qui $chi$ (chi) è la *suscettività elettrica* del materiale ed è positiva per i dielettrici ordinari.

#yellow-box([Cosa significano "lineare" e "$k=1+chi$"])[
  - *Lineare* significa che la polarizzazione è proporzionale al campo: più campo, più dipoli allineati, in modo direttamente proporzionale. La costante di proporzionalità (a meno di $epsilon_0$) è la suscettività $chi$.
  - *Isotropo* significa che il materiale risponde uguale in tutte le direzioni.
  - La relazione $k=1+chi$ collega i due numeri che descrivono il materiale: $k$ (costante dielettrica, già vista) e $chi$ (suscettività). Un materiale poco polarizzabile ha $chi approx 0$ e quindi $k approx 1$ (come il vuoto). Più $chi$ è grande, più $k$ è grande e più forte è l'effetto del dielettrico.
]

Se la polarizzazione è uniforme, nel volume le cariche di polarizzazione si compensano; restano cariche sulla superficie. La densità superficiale di polarizzazione è

$ sigma_p = vec(P) dot hat(n), $

dove $hat(n)$ è la normale uscente alla superficie del dielettrico.

#yellow-box([Perché solo sulla superficie, e perché il prodotto scalare])[
  Immagina i dipoli tutti allineati dentro al materiale: il $+$ di uno si appoggia al $-$ del vicino, e dentro al volume le cariche si annullano a vicenda. Ma ai *bordi* del materiale i dipoli non hanno un vicino che li compensa: restano cariche "scoperte" sulle facce. Quanta carica scopre una faccia dipende da *come è orientata* rispetto a $vec(P)$: una faccia perpendicolare a $vec(P)$ ne scopre tanta, una faccia parallela non ne scopre nessuna. Il prodotto scalare $vec(P) dot hat(n) = P cos theta$ cattura proprio questo: vale il massimo quando la normale è allineata a $vec(P)$ ($theta=0$) e si annulla quando sono perpendicolari ($theta=90 degree$).
]

#align(center, graph-card([Dipolo, polarizzazione e cariche superficiali], cetz.canvas({
  import cetz.draw: *
  // dipole
  circle((0.85, 2.25), radius: 0.15, stroke: 0.9pt + ink, fill: rgb("#edf3f8"))
  axis-label((0.85, 2.25), [$-$])
  circle((1.85, 2.25), radius: 0.15, stroke: 0.9pt + ink, fill: rgb("#fff4f4"))
  axis-label((1.85, 2.25), [$+$])
  line((1.00, 2.25), (1.70, 2.25), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((1.35, 2.46), [$vec(d)$], placement: "south")
  line((2.22, 2.25), (2.98, 2.25), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((3.12, 2.25), [$vec(p)=q vec(d)$], placement: "west")

  // volume element
  rect((4.45, 1.70), (5.55, 2.65), stroke: 0.9pt + ink, fill: rgb("#fbfcfd"))
  line((4.45, 2.65), (4.75, 2.95), stroke: 0.9pt + ink)
  line((5.55, 2.65), (5.85, 2.95), stroke: 0.9pt + ink)
  line((5.85, 2.95), (4.75, 2.95), stroke: 0.9pt + ink)
  for p in ((4.75, 1.90), (5.10, 2.18), (5.32, 2.45)) {
    line((p.at(0)-0.08, p.at(1)-0.08), (p.at(0)+0.10, p.at(1)+0.10), stroke: 0.85pt + ink, mark: (end: ">"))
  }
  axis-label((6.05, 2.36), [$dif "vol"$], placement: "west")
  axis-label((6.05, 1.78), [$vec(P)$], placement: "west")

  // slab surface charges
  rect((1.70, 0.35), (5.85, 1.10), stroke: 0.95pt + ink, fill: rgb("#edf8f4"))
  for x in (1.95, 2.35, 2.75, 3.15, 3.55, 3.95, 4.35, 4.75, 5.15, 5.55) {
    axis-label((x, 1.22), [$-$])
    axis-label((x, 0.22), [$+$])
  }
  line((0.95, 0.72), (1.48, 0.72), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((0.82, 0.72), [$vec(P)$], placement: "east")
  line((5.85, 1.10), (6.36, 1.42), stroke: 0.8pt + ink, mark: (end: ">"))
  axis-label((6.42, 1.46), [$hat(n)$], placement: "west")
  axis-label((4.25, 0.00), [$sigma_p=vec(P) dot hat(n)$], placement: "north")
})))

== Teorema di Gauss nei dielettrici

#green-box([L'idea prima della formula])[
  Il teorema di Gauss nel vuoto è comodo perché lega il flusso di $vec(E)$ a *tutta* la carica racchiusa. Ma in un dielettrico questo diventa scomodo: la carica racchiusa include sia quella che abbiamo messo noi (libera), sia quella di polarizzazione che il materiale crea da solo — e questa seconda non la conosciamo in anticipo, perché dipende dal campo, che è quello che stiamo cercando! È un cane che si morde la coda. La soluzione è inventare un nuovo vettore, $vec(D)$, costruito apposta perché il suo flusso "veda" *solo* la carica libera, quella che conosciamo. Così possiamo applicare Gauss come prima, ma senza l'incognita fastidiosa.
]

Nel vuoto il teorema di Gauss lega il flusso di $vec(E)$ alla carica totale racchiusa. In un dielettrico le cariche racchiuse possono essere di due tipi:

- cariche *libere*, cioè messe dall'esterno sulle armature o sui conduttori;
- cariche *di polarizzazione*, dovute alla risposta del materiale.

Per separare i due contributi si introduce il vettore spostamento elettrico:

Il campo $vec(D)$ è utile perché "assorbe" nella sua definizione l'effetto medio della polarizzazione. In questo modo, nel teorema di Gauss resta solo la carica libera.

#yellow-box([Spostamento elettrico])[
  $ vec(D)=epsilon_0 vec(E)+vec(P). $
]

Il vantaggio di $vec(D)$ è che il suo flusso dipende solo dalla carica libera:

#green-box([Teorema di Gauss nei dielettrici])[
  $ integral_(S_"chiusa") vec(D) dot dif vec(S) = Q_"libera". $
]

Per un dielettrico lineare:

$ vec(P)=epsilon_0 chi vec(E) quad -> quad vec(D)=epsilon_0 (1+chi) vec(E)=epsilon_0 k vec(E). $

#yellow-box([Perché questo passaggio])[
  Partiamo dalla definizione $vec(D)=epsilon_0 vec(E)+vec(P)$ e sostituiamo $vec(P)=epsilon_0 chi vec(E)$:
  $ vec(D)=epsilon_0 vec(E)+epsilon_0 chi vec(E) = epsilon_0 vec(E)(1+chi). $
  Abbiamo solo raccolto $epsilon_0 vec(E)$. Ma $1+chi$ è proprio $k$! Quindi $vec(D)=epsilon_0 k vec(E)$: nel dielettrico lineare $vec(D)$ ed $vec(E)$ sono semplicemente proporzionali, e il fattore è $epsilon_0 k$. Questa è la relazione che useremo per passare da $vec(D)$ (che troviamo con Gauss) a $vec(E)$.
]

Quindi, conoscendo $vec(D)$ con Gauss, si ricavano in ordine:

$ vec(D) -> vec(E) -> vec(P) -> sigma_p. $

#blue-box([La "catena" da ricordare])[
  Questo è il metodo standard per risolvere i problemi con dielettrici:
  1. *Gauss su $vec(D)$* usando solo la carica libera $-> $ trovi $vec(D)$.
  2. *$vec(E)=vec(D)/(epsilon_0 k)$* $-> $ trovi il campo vero.
  3. *$vec(P)=epsilon_0 (k-1) vec(E)$* $-> $ trovi la polarizzazione.
  4. *$sigma_p = vec(P) dot hat(n)$* $-> $ trovi la carica di polarizzazione sulle superfici.

  Il prossimo esempio percorre esattamente questa catena.
]

== Esempio: sfera libera immersa in un dielettrico lineare

Una sfera conduttrice di raggio $R$ porta una carica libera $Q_"libera"$ ed è immersa in un dielettrico lineare, omogeneo e isotropo con costante dielettrica $k$.

Per simmetria $vec(D)$ è radiale. Su una superficie gaussiana sferica di raggio $r>R$:

$ integral_S vec(D) dot dif vec(S)=D 4 pi r^2=Q_"libera". $

#yellow-box([Perché il flusso è $D dot 4 pi r^2$])[
  Per simmetria sferica $D$ ha lo stesso modulo in ogni punto della sfera gaussiana ed è perpendicolare ad essa. Quindi il flusso è semplicemente $D$ per l'area della sfera, e l'area di una sfera di raggio $r$ è $4 pi r^2$. È lo stesso conto del campo di una carica puntiforme, ma fatto su $vec(D)$ invece che su $vec(E)$: il vantaggio è che a destra compare solo $Q_"libera"$, non la carica di polarizzazione.
]

Da cui

$ vec(D)=Q_"libera"/(4 pi r^2) hat(r). $

Poiché $vec(D)=epsilon_0 k vec(E)$,

#blue-box([Campo nel dielettrico intorno alla sfera])[
  $ vec(E)=vec(D)/(epsilon_0 k)=Q_"libera"/(4 pi epsilon_0 k r^2) hat(r). $
]

Il campo è quello che si avrebbe nel vuoto, ridotto di un fattore $k$. È lo stesso effetto visto nel condensatore: il dielettrico smorza il campo. Qui lo abbiamo ricavato in modo pulito grazie a $vec(D)$.

La polarizzazione vale

$ vec(P)=epsilon_0 chi vec(E)=epsilon_0 (k-1) vec(E)= (k-1)/k Q_"libera"/(4 pi r^2) hat(r). $

#yellow-box([Perché $chi$ diventa $(k-1)$ e dove va $epsilon_0 k$])[
  Da $k=1+chi$ ricaviamo $chi=k-1$: ecco perché $epsilon_0 chi=epsilon_0 (k-1)$. Poi sostituiamo $vec(E)=vec(D)/(epsilon_0 k)$:
  $ vec(P)=epsilon_0 (k-1) dot vec(D)/(epsilon_0 k) = (k-1)/k vec(D). $
  L'$epsilon_0$ si semplifica e resta il fattore $(k-1)/k$ che moltiplica $vec(D)=Q_"libera"/(4 pi r^2) hat(r)$. Nota che $(k-1)/k$ è un numero fra $0$ e $1$: la polarizzazione è una *frazione* della carica libera, come deve essere (i dipoli scoprono solo parte della carica).
]

Sulla superficie del dielettrico a contatto con la sfera compare una densità di carica di polarizzazione pari al modulo di $vec(P)$ sulla superficie:

#yellow-box([Carica di polarizzazione sulla superficie])[
  $ abs(sigma_p)=abs(vec(P)(R))=(k-1)/k Q_"libera"/(4 pi R^2)=(k-1)/k sigma_l. $
]

#yellow-box([Ultimo passaggio: perché compare $sigma_l$])[
  Valutiamo $abs(vec(P))$ proprio sulla superficie del dielettrico ($r=R$): basta porre $r=R$ nella formula di $vec(P)$. Poi riconosciamo che $Q_"libera"/(4 pi R^2)$ è la carica libera divisa per l'area della sfera, cioè la densità superficiale di carica libera $sigma_l$. Quindi $abs(sigma_p)=(k-1)/k sigma_l$: la carica di polarizzazione è una frazione di quella libera, e svanisce se $k=1$ (nessun dielettrico, nessuna polarizzazione).
]

#purple-box([Esempio numerico])[
  Una sfera con $sigma_l = 2 dot 10^(-6) " C/m"^2$ è immersa in un dielettrico con $k = 5$. La densità di carica di polarizzazione vale
  $ abs(sigma_p) = (k-1)/k sigma_l = (5-1)/5 dot 2 dot 10^(-6) = 0,8 dot 2 dot 10^(-6) = 1,6 dot 10^(-6) " C/m"^2. $
  Cioè l'$80%$ della carica libera viene "schermato" dalla polarizzazione del materiale.
]

#align(center, graph-card([Sfera carica in un dielettrico lineare], cetz.canvas({
  import cetz.draw: *
  // Sfera conduttrice e superficie gaussiana nel dielettrico.
  circle((3.25, 2.35), radius: 1.05, stroke: 1.15pt + ink, fill: rgb("#fbfcfd"))
  circle((3.25, 2.35), radius: 2.10, stroke: (paint: blue, thickness: 0.9pt, dash: "dashed"))
  axis-label((1.55, 4.12), [dielettrico lineare $k$], placement: "south")
  axis-label((4.92, 0.52), [$S$ gaussiana], placement: "north")

  for p in ((2.78, 2.80), (3.28, 3.05), (3.78, 2.78), (2.76, 1.90), (3.54, 1.72)) {
    axis-label(p, [$+$])
  }

  // Dipoli indotti nel dielettrico circostante.
  for p in ((1.88, 3.92), (3.25, 4.35), (4.62, 3.80), (5.32, 2.42), (4.42, 0.92), (2.12, 0.92), (1.15, 2.52)) {
    rect((p.at(0)-0.14, p.at(1)-0.22), (p.at(0)+0.14, p.at(1)+0.22), stroke: 0.75pt + ink, fill: rgb("#edf8f4"))
    axis-label((p.at(0)-0.03, p.at(1)+0.04), [$-$])
    axis-label((p.at(0)+0.04, p.at(1)-0.08), [$+$])
  }

  // Campo radiale e raggio della sfera.
  for p in ((3.25, 4.72), (5.12, 3.82), (5.32, 1.12), (3.82, 0.10), (1.02, 1.05), (0.92, 3.65)) {
    line((3.25, 2.35), p, stroke: 1.0pt + blue, mark: (end: ">"))
  }
  line((3.25, 2.35), (4.30, 2.35), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((3.82, 2.06), [$R$], placement: "north")
  axis-label((5.48, 2.58), [$vec(E), vec(D), vec(P)$ radiali], placement: "west")
  axis-label((5.48, 1.88), [$vec(D)$ racchiude solo $Q_"libera"$], placement: "west")
  axis-label((5.48, 1.18), [$abs(sigma_p)=(k-1)/k sigma_l$], placement: "west")
})))

== Dipolo elettrico: potenziale lontano

#green-box([L'idea prima della formula])[
  Vogliamo il potenziale di un dipolo visto *da lontano*. C'è un fatto chiave: la carica totale del dipolo è zero ($+q$ e $-q$). Da molto lontano, le due cariche sembrano sovrapporsi e i loro effetti quasi si cancellano. Quasi, non del tutto: resta un piccolo residuo che dipende dalla *direzione* in cui guardi. Se ti metti sull'asse del dipolo, dalla parte del $+$, vedi il $+$ leggermente più vicino del $-$, quindi un potenziale positivo; di lato vedi i due alla stessa distanza e il potenziale è nullo. Questa dipendenza dalla direzione è racchiusa nel prodotto scalare $vec(p) dot vec(r)$, cioè nell'angolo $theta$ fra il dipolo e la direzione di osservazione.
]

Un dipolo elettrico è formato da due cariche opposte $+q$ e $-q$ separate da un vettore $vec(d)$ diretto dalla carica negativa alla carica positiva. Il momento di dipolo è

$ vec(p)=q vec(d). $

Consideriamo un punto $P$ lontano dal dipolo. Indichiamo con $r_+$ la distanza di $P$ dalla carica positiva e con $r_-$ la distanza dalla carica negativa. Il potenziale è la somma dei potenziali delle due cariche:

$ V(P)=V_+ + V_- = 1/(4 pi epsilon_0) (q/r_+ - q/r_-). $

Il dipolo ha carica totale nulla, quindi da lontano i contributi delle due cariche si compensano quasi del tutto. Rimane solo un effetto direzionale, descritto dal prodotto scalare con $vec(p)$.

Portando a denominatore comune:

$ V(P)=q/(4 pi epsilon_0) (r_- - r_+)/(r_+ r_-). $

#yellow-box([Perché questo passaggio: il denominatore comune])[
  Stiamo solo sommando due frazioni. Il denominatore comune di $1/r_+$ e $1/r_-$ è $r_+ r_-$:
  $ q/r_+ - q/r_- = q (r_-)/(r_+ r_-) - q (r_+)/(r_+ r_-) = q (r_- - r_+)/(r_+ r_-). $
  Niente di magico: è la solita somma di frazioni. Il vantaggio è che ora compare la *differenza* $r_- - r_+$, che è proprio la quantità piccola (quasi zero) responsabile del residuo di cui parlavamo.
]

Se il punto è lontano rispetto alla distanza fra le cariche, cioè $r >> d$, si usano le approssimazioni

$ r_+ r_- approx r^2, quad r_- - r_+ approx d cos theta. $

#yellow-box([Da dove vengono le due approssimazioni])[
  Quando $r >> d$, le distanze $r_+$ e $r_-$ sono entrambe quasi uguali a $r$ (la distanza dal centro del dipolo). Quindi nel *prodotto* $r_+ r_- approx r dot r = r^2$: l'errore è trascurabile perché lì le piccole differenze non contano.
  Nella *differenza* $r_- - r_+$, invece, le piccole differenze sono tutto. Geometricamente, $r_- - r_+$ è quanto è "più lontana" la carica $-$ rispetto alla $+$: proiettando la separazione $d$ sulla direzione di osservazione si ottiene $d cos theta$. (Pensa alle due rette quasi parallele che vanno da $P$ alle due cariche: lo sfasamento fra di esse è la proiezione di $vec(d)$, cioè $d cos theta$.) Qui *non* possiamo approssimare $r_- - r_+ approx 0$, altrimenti butteremmo via proprio il termine che ci interessa.
]

Poiché $vec(p) dot vec(r)=p r cos theta=q d r cos theta$, risulta

#yellow-box([L'ultimo passaggio])[
  Sostituiamo le approssimazioni: $V approx q/(4 pi epsilon_0) (d cos theta)/r^2$. Ora moltiplichiamo e dividiamo per $r$ così da far comparire il prodotto scalare: $q d cos theta = (q d) cos theta$ e $vec(p) dot vec(r) = p r cos theta = q d r cos theta$. Quindi $q d cos theta = (vec(p) dot vec(r))/r$, e
  $ V approx 1/(4 pi epsilon_0) ((vec(p) dot vec(r))slash r)/r^2 = 1/(4 pi epsilon_0) (vec(p) dot vec(r))/r^3. $
]

#yellow-box([Potenziale di dipolo lontano])[
  $ V(vec(r))=1/(4 pi epsilon_0) (vec(p) dot vec(r))/r^3. $

  Il potenziale di dipolo decresce come $1/r^2$.
]

#red-box([Attenzione: $1/r^3$ o $1/r^2$?])[
  Nella formula compare $r^3$ al denominatore, ma si dice che il potenziale "va come $1/r^2$". Non è un errore: $vec(p) dot vec(r) = p r cos theta$ contiene già una $r$ al numeratore, che semplifica una delle tre al denominatore. Quindi resta $V prop (cos theta)/r^2$. Il potenziale di dipolo cala come $1/r^2$, più rapidamente di quello di una carica singola ($1/r$): è logico, perché le due cariche opposte si schermano a vicenda.
]

#align(center, graph-card([Geometria del potenziale di dipolo], cetz.canvas({
  import cetz.draw: *
  // dipolo
  circle((1.10, 1.05), radius: 0.13, stroke: 0.9pt + ink, fill: rgb("#edf3f8"))
  axis-label((1.10, 1.05), [$-$])
  circle((1.10, 3.05), radius: 0.13, stroke: 0.9pt + ink, fill: rgb("#fff4f4"))
  axis-label((1.10, 3.05), [$+$])
  line((1.10, 1.18), (1.10, 2.92), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((0.72, 2.05), [$vec(d)$], placement: "east")
  line((1.10, 1.05), (1.10, 3.05), stroke: 0.75pt + rgb("#aeb5ba"))
  line((0.66, 1.05), (0.66, 3.05), stroke: 0.75pt + ink, mark: (start: "|", end: "|"))
  axis-label((0.40, 2.05), [$d$], placement: "east")

  // punto lontano
  circle((6.35, 2.35), radius: 0.07, fill: ink, stroke: none)
  axis-label((6.54, 2.50), [$P$], placement: "west")
  line((1.10, 3.05), (6.35, 2.35), stroke: 0.85pt + rgb("#7d858a"), mark: (end: ">"))
  line((1.10, 1.05), (6.35, 2.35), stroke: 0.85pt + rgb("#7d858a"), mark: (end: ">"))
  line((1.10, 2.05), (6.35, 2.35), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((3.80, 2.45), [$vec(r)$], placement: "south")
  axis-label((3.90, 2.95), [$vec(r)_+$], placement: "south")
  axis-label((3.95, 1.48), [$vec(r)_-$], placement: "north")
  arc((1.10, 2.05), radius: 0.72, start: 0deg, stop: 34deg, stroke: 0.75pt + ink)
  axis-label((1.86, 2.28), [$theta$], placement: "west")

  line((4.75, 0.58), (4.75, 3.82), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((5.05, 1.42), [$V(P)=1/(4 pi epsilon_0)(q/r_+ - q/r_-)$], placement: "west")
  axis-label((5.05, 0.82), [$V(vec(r))=1/(4 pi epsilon_0)(vec(p) dot vec(r))/r^3$], placement: "west")
})))

== Linee di campo e campo del dipolo

#green-box([L'idea prima della formula])[
  Abbiamo trovato il potenziale $V$ del dipolo. Ma spesso ci interessa il *campo* $vec(E)$. Buona notizia: il campo è "nascosto" nel potenziale. Pensa al potenziale come all'altitudine di un paesaggio collinare: il campo elettrico punta sempre nella direzione di *massima discesa* ed è tanto più intenso quanto più ripida è la pendenza. L'operazione matematica che, da una mappa di altitudini, estrae la direzione e la ripidità della salita è il *gradiente* $nabla$. Il campo è meno il gradiente: il segno meno dice "verso la discesa", cioè dai potenziali alti verso quelli bassi.
]

Le linee di campo di un dipolo escono dalla carica positiva e terminano sulla carica negativa. Il campo si può ricavare dal potenziale attraverso il teorema del gradiente:

$ Delta V = V - V_0 = - integral_0^P vec(E) dot dif vec(ell), $

e localmente

#blue-box([Campo dal potenziale])[
  $ vec(E) = - nabla V. $
]

#yellow-box([Dall'integrale al gradiente])[
  Le due scritture dicono la stessa cosa in due modi. La prima è "globale": sommando (integrando) il campo lungo un cammino si ottiene la differenza di potenziale fra gli estremi. La seconda è "locale": è l'operazione inversa. Se per accumulare $V$ devi integrare $vec(E)$, allora per recuperare $vec(E)$ da $V$ devi fare l'operazione opposta dell'integrale, cioè *derivare* nello spazio — ed è esattamente ciò che fa il gradiente $nabla$. Il segno meno è lo stesso che compare nell'integrale.
]

Il dipolo è quindi un esempio importante in cui il potenziale fornisce il campo tramite derivazione spaziale.

#align(center, graph-card([Linee di campo di un dipolo], cetz.canvas({
  import cetz.draw: *
  // Disegna prima le linee: le cariche verranno messe sopra come maschere piene.
  catmull((2.82, 3.00), (2.18, 2.78), (1.55, 2.30), (1.55, 1.62), (2.18, 1.16), (2.82, 1.00), stroke: 1.05pt + blue, mark: (end: ">"))
  catmull((3.18, 3.00), (3.82, 2.78), (4.45, 2.30), (4.45, 1.62), (3.82, 1.16), (3.18, 1.00), stroke: 1.05pt + blue, mark: (end: ">"))
  catmull((2.78, 3.22), (1.86, 3.56), (0.86, 2.90), (0.78, 1.92), (1.86, 0.58), (2.78, 0.78), stroke: 1.05pt + blue, mark: (end: ">"))
  catmull((3.22, 3.22), (4.14, 3.56), (5.14, 2.90), (5.22, 1.92), (4.14, 0.58), (3.22, 0.78), stroke: 1.05pt + blue, mark: (end: ">"))
  catmull((2.70, 3.34), (1.42, 4.12), (0.42, 3.20), (0.40, 1.90), (1.42, -0.12), (2.70, 0.66), stroke: 1.0pt + blue, mark: (end: ">"))
  catmull((3.30, 3.34), (4.58, 4.12), (5.58, 3.20), (5.60, 1.90), (4.58, -0.12), (3.30, 0.66), stroke: 1.0pt + blue, mark: (end: ">"))
  // Campo sull'asse del dipolo: esce dal +, tra le cariche va verso il -, sotto il - entra nel -.
  line((3.00, 3.36), (3.00, 4.16), stroke: 1.05pt + blue, mark: (end: ">"))
  line((3.00, 2.72), (3.00, 1.28), stroke: 1.05pt + blue, mark: (end: ">"))
  line((3.00, -0.10), (3.00, 0.64), stroke: 1.05pt + blue, mark: (end: ">"))

  // Momento di dipolo: spostato a lato per non confonderlo con una linea di campo.
  line((3.55, 1.20), (3.55, 2.80), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((3.80, 2.00), [$vec(p)$], placement: "west")

  // Maschere e simboli in primo piano: rendono + e - sempre leggibili.
  circle((3.00, 3.08), radius: 0.31, stroke: 1.2pt + red, fill: rgb("#fffdfd"))
  circle((3.00, 0.92), radius: 0.31, stroke: 1.2pt + blue, fill: rgb("#fdfefe"))
  circle((3.00, 3.08), radius: 0.21, stroke: 0.9pt + red, fill: rgb("#fff4f4"))
  circle((3.00, 0.92), radius: 0.21, stroke: 0.9pt + blue, fill: rgb("#edf3f8"))
  axis-label((3.00, 3.08), text(size: 12pt, weight: "bold", fill: red)[$+$])
  axis-label((3.00, 0.92), text(size: 12pt, weight: "bold", fill: blue)[$-$])

  axis-label((0.72, 0.28), [linee: dal $+$ al $-$], placement: "north")
  axis-label((5.22, 3.70), [$vec(E)=-nabla V$], placement: "west")
})))

== Dipolo in un campo elettrico esterno

#green-box([L'idea prima della formula])[
  Mettiamo ora un dipolo *dentro* a un campo esterno uniforme (per esempio fra le armature di un condensatore). Sul $+$ il campo spinge in un verso, sul $-$ nel verso opposto: le due spinte hanno la stessa intensità ma versi contrari. Risultato: il dipolo *non viene trascinato* da nessuna parte (forza totale nulla), ma viene *fatto ruotare*, come quando giri un volante afferrandolo con due mani che spingono in versi opposti. Questa coppia di forze cerca sempre di allineare il dipolo al campo, come l'ago di una bussola si allinea al campo magnetico terrestre.
]

In un campo elettrico esterno uniforme $vec(E)_"est"$, sulle cariche del dipolo agiscono forze opposte:

$ vec(F)_+ = q vec(E)_"est", quad vec(F)_- = -q vec(E)_"est". $

La risultante è nulla, ma le due forze formano una coppia che tende a ruotare il dipolo. Il momento meccanico della coppia è

#green-box([Momento meccanico sul dipolo])[
  $ vec(tau)=vec(p) times vec(E). $
]

#yellow-box([Perché un prodotto vettoriale, e cosa dice $sin theta$])[
  Il momento torcente di una coppia dipende da *quanto* il dipolo è disallineato dal campo: massimo quando $vec(p)$ è perpendicolare a $vec(E)$ ($theta=90 degree$), nullo quando sono già allineati ($theta=0$). Il prodotto vettoriale $vec(p) times vec(E)$ ha modulo $p E sin theta$, che fa esattamente questo: vale il massimo a $90 degree$ e si annulla a $0$. La sua direzione (l'asse di rotazione) e il suo verso indicano come ruota il dipolo. Quando $theta=0$ il dipolo è già allineato: nessuna torsione, niente rotazione.
]

Il verso della rotazione è tale da allineare $vec(p)$ al campo esterno. L'energia potenziale del dipolo nel campo è

#yellow-box([Energia del dipolo in campo esterno])[
  $ U = - vec(p) dot vec(E). $
]

#yellow-box([Perché c'è il segno meno e cosa significa])[
  Il prodotto scalare $vec(p) dot vec(E) = p E cos theta$ è massimo quando il dipolo è allineato al campo ($theta=0$, $cos theta=1$). Il segno meno davanti fa sì che in quella configurazione l'energia $U$ sia *minima* (la più negativa). Questo è coerente con la fisica: i sistemi tendono spontaneamente verso l'energia minima, e infatti il dipolo tende ad allinearsi al campo. La posizione allineata è quella "comoda", a bassa energia; quella anti-allineata è "scomoda", ad alta energia.
]

Se $vec(p)$ e $vec(E)$ sono paralleli, $U$ è minima: equilibrio stabile. Se sono antiparalleli, $U$ è massima: equilibrio instabile.

#yellow-box([Stabile e instabile: la verifica con i casi limite])[
  - *Allineato* ($theta=0$): $U=-p E$, il minimo. Se lo sposti un po', tende a tornare indietro: equilibrio *stabile* (come una pallina in fondo a una valle).
  - *Anti-allineato* ($theta=180 degree$): $U=+p E$, il massimo. Basta una minima perturbazione e il dipolo "scatta" verso l'allineamento: equilibrio *instabile* (come una pallina in cima a una collina).
]

#purple-box([Esempio numerico])[
  Una molecola d'acqua ha momento di dipolo $p approx 6,2 dot 10^(-30) " C" dot "m"$. In un campo $E = 1 dot 10^5 " V/m"$, la differenza di energia fra la posizione allineata e quella anti-allineata è
  $ Delta U = U_"max" - U_"min" = p E - (-p E) = 2 p E = 2 dot 6,2 dot 10^(-30) dot 10^5 approx 1,2 dot 10^(-24) " J". $
  È un'energia piccolissima: ecco perché a temperatura ambiente l'agitazione termica riesce a disorientare i dipoli, e l'allineamento è solo parziale.
]

#align(center, graph-card([Dipolo in campo esterno: coppia di forze], cetz.canvas({
  import cetz.draw: *
  // Campo esterno uniforme.
  for x in (0.55, 1.20, 1.85, 2.50) {
    line((x, 0.55), (x + 1.04, 3.40), stroke: 0.92pt + blue, mark: (end: ">"))
  }
  axis-label((0.48, 3.28), [$vec(E)_"est"$], placement: "south")

  // Dipolo inclinato.
  circle((2.18, 1.18), radius: 0.25, stroke: 1.1pt + blue, fill: rgb("#edf3f8"))
  circle((3.02, 2.58), radius: 0.25, stroke: 1.1pt + red, fill: rgb("#fff4f4"))
  axis-label((2.18, 1.18), text(size: 12pt, weight: "bold", fill: blue)[$-$])
  axis-label((3.02, 2.58), text(size: 12pt, weight: "bold", fill: red)[$+$])
  line((2.18, 1.18), (3.02, 2.58), stroke: 1.15pt + ink, mark: (end: ">"))
  axis-label((2.78, 1.75), [$vec(p)$], placement: "east")

  // Forze sulle cariche: uguali e opposte, risultante nulla.
  line((3.02, 2.58), (3.48, 3.80), stroke: 1.35pt + red, mark: (end: ">"))
  line((2.18, 1.18), (1.72, -0.04), stroke: 1.35pt + red, mark: (end: ">"))
  axis-label((3.62, 3.62), [$vec(F)_+$], placement: "west")
  axis-label((1.64, 0.18), [$vec(F)_-$], placement: "east")

  // Momento torcente: arco nero come nella reference.
  arc((2.20, 1.02), radius: 1.18, start: 245deg, stop: 15deg, stroke: 1.15pt + ink, mark: (end: ">"))
  axis-label((2.58, 0.30), [$vec(tau)$], placement: "north")

  line((4.35, 0.50), (4.35, 3.72), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((4.72, 3.02), [$vec(F)_+=q vec(E)_"est"$], placement: "west")
  axis-label((4.72, 2.38), [$vec(F)_-=-q vec(E)_"est"$], placement: "west")
  axis-label((4.72, 1.66), [coppia di forze: il dipolo ruota], placement: "west")
  axis-label((4.72, 0.98), [$vec(tau)=vec(p) times vec(E)$], placement: "west")
})))

#align(center, graph-card([Energia del dipolo in campo esterno], cetz.canvas({
  import cetz.draw: *
  axis-label((2.15, 3.55), [equilibrio stabile], placement: "south")
  line((0.95, 2.92), (2.40, 2.92), stroke: 1.1pt + blue, mark: (end: ">"))
  line((0.95, 2.36), (2.40, 2.36), stroke: 1.1pt + ink, mark: (end: ">"))
  axis-label((2.60, 2.92), [$vec(E)$], placement: "west")
  axis-label((2.60, 2.36), [$vec(p)$], placement: "west")
  axis-label((1.65, 1.78), [paralleli], placement: "south")
  axis-label((1.65, 1.28), [$U=U_"min"$], placement: "south")

  line((4.00, 0.55), (4.00, 3.50), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.95, 3.55), [equilibrio instabile], placement: "south")
  line((4.80, 2.92), (6.25, 2.92), stroke: 1.1pt + blue, mark: (end: ">"))
  line((6.25, 2.36), (4.80, 2.36), stroke: 1.1pt + ink, mark: (end: ">"))
  axis-label((6.45, 2.92), [$vec(E)$], placement: "west")
  axis-label((4.60, 2.36), [$vec(p)$], placement: "east")
  axis-label((5.52, 1.78), [antiparalleli], placement: "south")
  axis-label((5.52, 1.28), [$U=U_"max"$], placement: "south")

  axis-label((2.10, 0.36), [$U=-vec(p) dot vec(E)$], placement: "north")
  axis-label((5.95, 0.36), [il dipolo tende ad allinearsi al campo], placement: "north")
})))

== Energia elettrostatica

#green-box([L'idea prima della formula])[
  Dove "sta" l'energia di un condensatore carico? L'idea di fondo è questa: caricare un sistema costa fatica, e quella fatica non sparisce, viene immagazzinata. Per avvicinare due cariche che si respingono devi spingere, cioè fare lavoro: quel lavoro resta "depositato" nel sistema come energia potenziale, pronto a essere restituito se le lasci andare. *Costruire una configurazione di cariche* è come caricare una molla: l'energia che ci metti è l'energia elettrostatica del sistema. La convenzione standard è partire da cariche infinitamente lontane (dove non interagiscono, energia zero) e portarle nella posizione finale, contando il lavoro fatto.
]

La forza elettrostatica è conservativa. Per una carica $q$ che si sposta in un campo elettrico:

$ vec(F)=q vec(E). $

#yellow-box([Cosa significa "conservativa" qui])[
  Una forza è *conservativa* se il lavoro che fa dipende solo dai punti di partenza e arrivo, non dal cammino percorso. Questo è ciò che permette di definire un'*energia potenziale*: se il lavoro dipendesse dal percorso, non potremmo assegnare a ogni configurazione un singolo valore di energia. Per la forza elettrostatica vale, ed è il motivo per cui tutto questo discorso sull'energia ha senso.
]

Il lavoro del campo elettrostatico è legato alla variazione di energia potenziale:

$ L_"campo" = - Delta U, $

e, usando il potenziale,

#blue-box([Lavoro e potenziale])[
  $ L = - q Delta V. $
]

#yellow-box([Perché tutti questi segni meno])[
  - $L_"campo" = -Delta U$: se il campo fa lavoro *positivo* (aiuta il moto), l'energia potenziale *diminuisce* ($Delta U <0$). È come un sasso che cade: la gravità fa lavoro positivo e l'energia potenziale gravitazionale cala. Il lavoro del campo "consuma" energia potenziale.
  - $L = -q Delta V$: ricordando che $Delta U = q Delta V$ (l'energia di una carica è carica per potenziale), sostituendo nella riga sopra si ottiene proprio $L_"campo"=-q Delta V$.
]

Ponendo $U_infinity=0$, l'energia elettrostatica di un sistema è il lavoro totale esterno necessario per costruire il sistema portando le cariche dall'infinito. Equivalentemente,

$ U_"sistema" = - L_"campo". $

Se le cariche si respingono, il lavoro esterno per avvicinarle è positivo e l'energia del sistema aumenta. Se si attraggono, il campo aiuta l'avvicinamento e l'energia può risultare negativa rispetto al riferimento all'infinito.

#yellow-box([Lavoro esterno vs lavoro del campo: occhio al segno])[
  Per costruire il sistema *noi* (l'agente esterno) facciamo un lavoro $L_"esterno"$; il campo fa il lavoro opposto $L_"campo"=-L_"esterno"$. L'energia immagazzinata è il lavoro che *abbiamo dovuto fare noi*: $U_"sistema"=L_"esterno"=-L_"campo"$. Cariche che si respingono $-> $ dobbiamo spingere $-> L_"esterno">0$, $U>0$. Cariche che si attraggono $-> $ vengono da sole, anzi dobbiamo frenarle $-> L_"esterno"<0$, $U<0$.
]

== Distribuzione discreta di cariche

#green-box([L'idea prima della formula])[
  Mettiamo in pratica l'idea "costruire il sistema dall'infinito" con poche cariche puntiformi. Le portiamo una alla volta. La prima arriva gratis: non c'è ancora nessuno con cui interagire. La seconda invece deve farsi strada nel campo che la prima ha già creato, e questo costa lavoro. La terza paga per le prime due, e così via. L'energia totale è la somma di tutti questi "costi di ingresso". Il risultato finale conterà ogni *coppia* di cariche una volta sola.
]

Per costruire una distribuzione di $N$ cariche puntiformi, si porta una carica alla volta dall'infinito. La prima carica non richiede lavoro, perché non ci sono ancora altre cariche:

$ L_1=0. $

La seconda carica sente il potenziale prodotto dalla prima:

$ L_2 = q_2 V_1(vec(r)_2) = q_2 q_1/(4 pi epsilon_0 r_(1 2)). $

#yellow-box([Perché questo passaggio])[
  Per portare una carica $q_2$ in un punto dove c'è già un potenziale $V_1$ serve un lavoro pari a $q_2 V_1$ (è la definizione stessa di energia potenziale: carica per potenziale del posto in cui la metti). Il potenziale che la prima carica crea dove arriva la seconda è $V_1 = q_1/(4 pi epsilon_0 r_(1 2))$, dove $r_(1 2)$ è la distanza fra le due. Sostituendo si ottiene la formula. È l'energia di interazione di *una coppia*.
]

Continuando, ogni carica $q_i$ viene portata nel potenziale prodotto dalle cariche già presenti. L'energia totale si scrive

#green-box([Energia di cariche puntiformi])[
  $ U_"el" = 1/2 sum_(i=1)^N sum_(j!=i)^N (q_i q_j)/(4 pi epsilon_0 r_(i j))
  = 1/2 sum_(i=1)^N q_i V_i. $
]

Nel termine $V_i$ non si include il potenziale generato dalla carica $q_i$ stessa, ma solo quello prodotto dalle altre cariche. Il fattore $1/2$ evita di contare due volte ogni coppia.

#yellow-box([Da dove sbuca il fattore $1/2$, e cos'è la doppia somma])[
  La doppia somma $sum_i sum_(j!=i)$ scorre su tutte le coppie ordinate: conta sia la coppia $(1,2)$ sia la $(2,1)$. Ma l'energia della coppia formata da carica $1$ e carica $2$ è *una sola*! Sommando su entrambi gli ordini la conti due volte, quindi dividi per $2$ per rimediare. La condizione $j != i$ esclude il termine in cui una carica interagisce con se stessa (che darebbe distanza zero e un infinito senza senso). La seconda forma $1/2 sum_i q_i V_i$ raggruppa: $V_i$ è il potenziale di *tutte le altre* cariche nel punto dove sta $q_i$, e $q_i V_i$ è l'energia di $q_i$ in quel potenziale.
]

#purple-box([Esempio numerico])[
  Tre cariche uguali $q = 1 dot 10^(-9) " C"$ ai vertici di un triangolo equilatero di lato $L = 0,1 " m"$. Ci sono $3$ coppie, tutte alla stessa distanza $L$. L'energia di una coppia è
  $ U_"coppia" = q^2/(4 pi epsilon_0 L) = (9 dot 10^9 dot (10^(-9))^2)/(0,1) = (9 dot 10^9 dot 10^(-18))/(0,1) = 9 dot 10^(-8) " J". $
  Con $3$ coppie: $U_"el" = 3 dot 9 dot 10^(-8) = 2,7 dot 10^(-7) " J"$. Positiva, come deve essere: le cariche sono tutte dello stesso segno e si respingono, quindi assemblarle è costato lavoro.
]

#align(center, graph-card([Costruzione di una distribuzione discreta], cetz.canvas({
  import cetz.draw: *
  // traiettorie dall'infinito
  for y in (0.80, 1.65, 2.50) {
    catmull((0.20, y), (0.82, y + 0.30), (1.35, y + 0.08), (1.88, y + 0.36), stroke: (paint: blue, thickness: 0.85pt, dash: "dashed"), mark: (end: ">"))
  }
  axis-label((0.20, 2.98), [$infinity$], placement: "south")
  circle((2.25, 2.72), radius: 0.09, fill: ink, stroke: none)
  circle((2.70, 1.72), radius: 0.09, fill: ink, stroke: none)
  circle((3.22, 2.22), radius: 0.09, fill: ink, stroke: none)
  axis-label((2.25, 2.96), [$q_1$], placement: "south")
  axis-label((2.70, 1.44), [$q_2$], placement: "north")
  axis-label((3.22, 2.46), [$q_i$], placement: "south")
  line((2.25, 2.72), (2.70, 1.72), stroke: 0.75pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.28, 2.08), [$r_(1 2)$], placement: "east")
  line((4.20, 0.58), (4.20, 3.18), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((4.70, 2.65), [$U_"el"=1/2 sum_i sum_(j!=i) (q_i q_j)/(4 pi epsilon_0 r_(i j))$], placement: "west")
  axis-label((4.70, 1.75), [$=1/2 sum_i q_i V_i$], placement: "west")
  axis-label((4.70, 0.90), [$V_i$: potenziale delle altre particelle], placement: "west")
})))

== Distribuzione continua di carica

#green-box([L'idea prima della formula])[
  E se la carica non è fatta di pochi puntini, ma è "spalmata" con continuità in un volume (come in un materiale carico)? L'idea è sempre la stessa, solo con infiniti pezzettini infinitamente piccoli. Tagliamo il volume in tanti elementini, ognuno con una microcarica $dif q$. Ogni elementino è come una "carica puntiforme", e la somma su tutti diventa un *integrale*. Il passaggio mentale è: somma su tante cariche $-> $ integrale su tutto il volume.
]

Per passare a una distribuzione continua si sostituisce la somma con un integrale. Se la densità volumica è $rho(vec(r))$, allora

$ dif q = rho(vec(r)) dif tau. $

#yellow-box([Cosa dice $dif q = rho dif tau$])[
  $rho$ (rho) è la *densità di carica per unità di volume*, in $"C"/"m"^3$: dice quanta carica è impacchettata per ogni metro cubo. Moltiplicandola per un volumetto $dif tau$ ottieni la carica contenuta in quel volumetto, $dif q$. È come passare da "densità di popolazione" (abitanti per km²) al numero di abitanti di un quartiere: densità per area.
]

Il simbolo $dif tau$ indica un piccolo elemento di volume. Ha lo stesso ruolo di $dif V$, ma qui si evita la lettera $V$ per non confonderla con il potenziale.

L'energia elettrostatica della distribuzione diventa

#yellow-box([Energia di una distribuzione continua])[
  $ U_"el" = 1/2 integral_"vol" rho(vec(r)) V(vec(r)) dif tau. $
]

#yellow-box([Da $sum q_i V_i$ a $integral rho V dif tau$])[
  È la traduzione "continua" della formula discreta $U=1/2 sum_i q_i V_i$. Ogni carica $q_i$ diventa l'elementino $dif q = rho dif tau$, il potenziale $V_i$ diventa $V(vec(r))$ nel punto dell'elementino, e la somma $sum$ diventa l'integrale $integral$. Il fattore $1/2$ sopravvive per lo stesso motivo di prima: evita di contare due volte l'interazione fra ogni coppia di elementi.
]

Una forma equivalente, ottenuta esplicitando l'interazione fra coppie di elementi di volume, è

$ U_"el" = 1/2 integral_"vol" integral_"vol" (rho(vec(r)_1) rho(vec(r)_2) dif tau_1 dif tau_2)/(4 pi epsilon_0 r_(1 2)). $

La forma con $1/2 integral rho V dif tau$ è più compatta perché $V(vec(r))$ contiene il contributo del resto della distribuzione.

#yellow-box([Perché due integrali nella seconda forma])[
  È l'analogo continuo della doppia somma $sum_i sum_j$. Il doppio integrale considera *ogni coppia* di elementini ($dif tau_1$ e $dif tau_2$) e calcola la loro interazione $rho_1 rho_2 slash (4 pi epsilon_0 r_(1 2))$. La forma compatta $1/2 integral rho V dif tau$ è equivalente ma più maneggevole, perché uno dei due integrali è già "nascosto" dentro $V(vec(r))$: il potenziale in un punto è già la somma dei contributi di tutto il resto della distribuzione.
]

#align(center, graph-card([Distribuzione continua: elementi di volume], cetz.canvas({
  import cetz.draw: *
  catmull((1.10, 1.00), (1.34, 2.85), (3.10, 3.24), (4.40, 2.70), (4.25, 1.20), (2.80, 0.52), (1.10, 1.00), stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  rect((1.70, 2.28), (2.04, 2.62), stroke: 0.9pt + ink, fill: rgb("#edf3f8"))
  rect((3.18, 1.72), (3.52, 2.06), stroke: 0.9pt + ink, fill: rgb("#edf3f8"))
  axis-label((1.86, 2.86), [$dif tau_1$], placement: "south")
  axis-label((3.35, 2.28), [$dif tau_2$], placement: "south")
  line((1.86, 2.45), (3.35, 1.89), stroke: 0.85pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.64, 2.36), [$r_(1 2)$], placement: "south")
  line((0.42, 0.36), (1.86, 2.45), stroke: 0.85pt + ink, mark: (end: ">"))
  line((0.42, 0.36), (3.35, 1.89), stroke: 0.85pt + ink, mark: (end: ">"))
  axis-label((0.30, 0.22), [$O$], placement: "north")
  axis-label((1.06, 1.50), [$vec(r)_1$], placement: "east")
  axis-label((2.20, 1.08), [$vec(r)_2$], placement: "north")
  axis-label((3.96, 0.52), [volume carico], placement: "north")

  line((4.92, 0.70), (4.92, 3.12), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((5.38, 2.60), [$dif q=rho dif tau$], placement: "west")
  axis-label((5.38, 1.82), [$sum -> integral_"vol"$], placement: "west")
  axis-label((5.38, 1.04), [$U_"el"=1/2 integral rho V dif tau$], placement: "west")
})))

== Sistema di conduttori

#green-box([L'idea prima della formula])[
  Per i conduttori c'è una semplificazione bellissima. In un conduttore all'equilibrio *tutto il corpo è allo stesso potenziale* (è "equipotenziale"): le cariche libere si dispongono proprio per rendere $V$ costante ovunque. Quindi nell'integrale $1/2 integral rho V dif tau$ il potenziale $V_i$ è una costante e si può portare fuori dall'integrale: ciò che resta dell'integrale è semplicemente la carica totale $Q_i$ del conduttore. L'energia diventa una semplice somma $1/2 sum Q_i V_i$, senza più integrali.
]

In un sistema di conduttori in equilibrio elettrostatico, ogni conduttore è equipotenziale. Se il conduttore $i$ ha potenziale $V_i$ costante e densità superficiale $sigma_i$, la sua carica è

$ Q_i = integral_"sup" sigma_i dif S. $

L'energia può essere scritta come somma dei contributi dei conduttori:

#green-box([Energia di un sistema di conduttori])[
  $ U_"el" = 1/2 sum_(i=1)^N Q_i V_i. $
]

Per un singolo conduttore di capacità $C$, usando $C=Q/V$, si ottengono le forme pratiche:

#yellow-box([Come si ottengono le tre forme])[
  Partiamo da $U=1/2 Q V$ (un solo conduttore). Usando $C=Q/V$, cioè $V=Q/C$ oppure $Q=C V$, possiamo riscrivere $V$ o $Q$:
  - sostituendo $V=Q/C$: $U = 1/2 Q dot Q/C = 1/2 Q^2/C$;
  - sostituendo $Q=C V$: $U = 1/2 (C V) V = 1/2 C V^2$.
  Sono la stessa energia scritta in tre modi: usi quello più comodo a seconda di cosa conosci (carica, potenziale o capacità).
]

#yellow-box([Energia di un singolo conduttore])[
  $ U = 1/2 Q V = 1/2 C V^2 = 1/2 Q^2/C. $
]

#align(center, graph-card([Energia nei conduttori], cetz.canvas({
  import cetz.draw: *
  // sistema
  axis-label((1.65, 3.45), [sistema di conduttori], placement: "south")
  for item in (((1.05, 2.42), 0.45, [$Q_1$], [$V_1$]), ((2.58, 2.05), 0.40, [$Q_2$], [$V_2$]), ((1.65, 1.02), 0.42, [$Q_N$], [$V_N$])) {
    let c = item.at(0)
    let rr = item.at(1)
    circle(c, radius: rr, stroke: 1.0pt + ink, fill: rgb("#f4f4f4"))
    axis-label((c.at(0) - 0.55, c.at(1) + 0.42), item.at(2), placement: "east")
    axis-label((c.at(0) - 0.55, c.at(1) - 0.05), item.at(3), placement: "east")
  }
  axis-label((3.44, 2.60), [$V_i$ costante], placement: "west")
  axis-label((3.44, 2.02), [$Q_i=integral sigma_i dif S$], placement: "west")
  axis-label((3.44, 1.42), [$U_"el"=1/2 sum_i Q_i V_i$], placement: "west")

  line((5.10, 0.62), (5.10, 3.18), stroke: 0.55pt + rgb("#ccd4d8"))

  // singolo conduttore
  axis-label((6.56, 3.45), [singolo conduttore], placement: "south")
  circle((6.40, 2.20), radius: 0.50, stroke: 1.0pt + ink, fill: rgb("#f4f4f4"))
  for x in (-0.18, 0.10, 0.34) {
    line((6.18 + x, 1.84), (6.60 + x, 2.50), stroke: 0.65pt + rgb("#aeb5ba"))
  }
  axis-label((5.82, 2.84), [$Q$], placement: "south")
  axis-label((5.82, 1.50), [$V$], placement: "north")
  axis-label((7.15, 2.72), [$C=Q/V$], placement: "west")
  axis-label((7.15, 2.06), [$U=1/2 Q V$], placement: "west")
  axis-label((7.15, 1.40), [$=1/2 C V^2$], placement: "west")
  axis-label((7.15, 0.82), [$=1/2 Q^2/C$], placement: "west")
})))

== Energia di un condensatore

#green-box([L'idea prima della formula])[
  Ora applichiamo la formula dei conduttori al caso più importante: il condensatore. Caricare un condensatore significa spostare carica da un'armatura all'altra, lasciando una $+Q$ e l'altra $-Q$. All'inizio costa poco (potenziale basso), ma man mano che la carica si accumula il potenziale cresce e ogni nuova "goccia" di carica costa di più. Il risultato è che l'energia non è $Q Delta V$, ma *la metà*: $U=1/2 Q Delta V$. Quel fattore $1/2$ viene dal fatto che il potenziale è cresciuto gradualmente da $0$ al valore finale, quindi conta il valore *medio*.
]

Un condensatore è formato da due conduttori in induzione completa: tutta la carica positiva su un'armatura è collegata, tramite le linee di campo, alla carica negativa dell'altra armatura. Se le due armature hanno potenziali $V_1$ e $V_2$, si definisce

$ Delta V = V_1 - V_2. $

Le cariche sulle armature sono opposte:

$ Q_1=Q, quad Q_2=-Q, $

e la capacità del condensatore è

#blue-box([Capacità di un condensatore])[
  $ C = Q/(Delta V). $
]

In forma più esplicita:

$ Q_1 = C (V_1 - V_2), quad Q_2 = - C (V_1 - V_2). $

L'energia elettrostatica del sistema si ottiene dalla formula generale per i conduttori:

$ U = 1/2 (Q_1 V_1 + Q_2 V_2). $

Sostituendo $Q_1=Q$ e $Q_2=-Q$:

$ U = 1/2 Q (V_1 - V_2) = 1/2 Q Delta V. $

#yellow-box([Perché questo passaggio])[
  Mettiamo $Q_1=Q$ e $Q_2=-Q$ nella somma:
  $ U = 1/2 (Q V_1 + (-Q) V_2) = 1/2 Q (V_1 - V_2). $
  Abbiamo solo raccolto $Q$. E $V_1 - V_2$ è proprio $Delta V$, da cui $U=1/2 Q Delta V$. Nota come le due cariche opposte facciano comparire naturalmente la *differenza* di potenziale.
]

Poiché $Q=C Delta V$, si hanno le tre forme equivalenti:

#green-box([Energia immagazzinata in un condensatore])[
  $ U = 1/2 C (Delta V)^2 = 1/2 Q^2/C = 1/2 Q Delta V. $
]

#red-box([Attenzione: non dimenticare il fattore $1/2$])[
  L'errore più comune è scrivere $U = Q Delta V$ o $U = C (Delta V)^2$ senza l'$1/2$. Sbagliato! L'$1/2$ c'è sempre, perché il potenziale è cresciuto da zero al valore finale mentre caricavi: l'energia dipende dal potenziale *medio*, che è metà di quello finale. Stesso $1/2$ dell'energia di una molla $1/2 k x^2$ o dell'energia cinetica $1/2 m v^2$: sono tutte energie "accumulate gradualmente".
]

#purple-box([Esempio numerico])[
  Un condensatore $C = 200 " "mu"F" = 2 dot 10^(-4) " F"$ caricato a $Delta V = 12 " V"$ immagazzina
  $ U = 1/2 C (Delta V)^2 = 1/2 dot 2 dot 10^(-4) dot 12^2 = 1/2 dot 2 dot 10^(-4) dot 144 = 1,44 dot 10^(-2) " J". $
  Circa $14$ millijoule. La carica accumulata è $Q=C Delta V = 2 dot 10^(-4) dot 12 = 2,4 dot 10^(-3) " C"$. Verifica con un'altra forma: $U = 1/2 Q Delta V = 1/2 dot 2,4 dot 10^(-3) dot 12 = 1,44 dot 10^(-2) " J"$. Stesso risultato, come deve essere.
]

#align(center, graph-card([Condensatore: cariche, potenziali ed energia], cetz.canvas({
  import cetz.draw: *

  rect((0.78, 0.78), (1.08, 3.36), stroke: 1.15pt + ink, fill: rgb("#f7f9fa"))
  rect((3.05, 0.78), (3.35, 3.36), stroke: 1.15pt + ink, fill: rgb("#f7f9fa"))
  for y in (1.10, 1.55, 2.00, 2.45, 2.90) {
    axis-label((0.93, y), text(size: 11pt, weight: "bold", fill: red)[$+$])
    axis-label((3.20, y), text(size: 11pt, weight: "bold", fill: blue)[$-$])
    line((1.28, y), (2.86, y), stroke: 0.9pt + blue, mark: (end: ">"))
  }
  axis-label((0.92, 3.70), [$V_1, Q_1=Q$], placement: "south")
  axis-label((3.20, 3.70), [$V_2, Q_2=-Q$], placement: "south")
  line((1.08, 0.48), (3.05, 0.48), stroke: 0.85pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.06, 0.28), [$Delta V=V_1-V_2$], placement: "north")
  axis-label((2.08, 3.26), [linee di campo tra le armature], placement: "south")

  line((4.20, 0.58), (4.20, 3.78), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((4.66, 3.30), [$C=Q/(Delta V)$], placement: "west")
  axis-label((4.66, 2.55), [$U=1/2 (Q_1 V_1+Q_2 V_2)$], placement: "west")
  axis-label((4.66, 1.80), [$U=1/2 Q Delta V$], placement: "west")
  axis-label((4.66, 1.05), [$=1/2 C (Delta V)^2 = 1/2 Q^2/C$], placement: "west")
})))

== Esempio: condensatore sferico e conduttore esterno

#green-box([L'idea prima dei conti])[
  Questo esempio mostra come il fatto di collegare o no un conduttore a terra cambi l'energia immagazzinata. Collegare a terra significa dare una "via di fuga" alle cariche verso un serbatoio infinito (la Terra): la superficie esterna del guscio si scarica e fuori non resta campo. Senza messa a terra, invece, anche la regione esterna ha campo e quindi anche lì c'è energia immagazzinata. Più regioni con campo $-> $ più energia.
]

Consideriamo una sfera conduttrice di raggio $R_1$ con carica $+Q$, circondata da un conduttore sferico cavo con raggio interno $R_2$ e raggio esterno $R_3$. Per induzione, sulla superficie interna del guscio compare carica $-Q$.

Se il guscio esterno è collegato a terra, la superficie esterna può scambiare carica con la Terra e il campo esterno si annulla. Il sistema rilevante è quindi il condensatore sferico tra $R_1$ e $R_2$:

$ C_"condensatore" = 4 pi epsilon_0 (R_1 R_2)/(R_2 - R_1). $

L'energia è

#yellow-box([Come si ottiene l'energia])[
  Usiamo la forma $U=Q^2/(2C)$ con la capacità del condensatore sferico appena scritta:
  $ U = Q^2/(2 dot 4 pi epsilon_0 (R_1 R_2)/(R_2 - R_1)) = Q^2 (R_2 - R_1)/(8 pi epsilon_0 R_1 R_2). $
  Ora "spezziamo" la frazione $(R_2 - R_1)/(R_1 R_2) = R_2/(R_1 R_2) - R_1/(R_1 R_2) = 1/R_1 - 1/R_2$. Ecco da dove esce la forma finale con la parentesi.
]

#yellow-box([Condensatore sferico con guscio a terra])[
  $ U = Q^2/(2 C_"condensatore")
    = Q^2/(8 pi epsilon_0) (1/R_1 - 1/R_2). $
]

Se il guscio non è collegato a terra, rimane anche il contributo energetico del conduttore esterno di raggio $R_3$:

#green-box([Caso non collegato a terra])[
  $ U = Q^2/(2 C_"condensatore") + Q^2/(2 C_"conduttore"), quad
  C_"conduttore" = 4 pi epsilon_0 R_3. $
]

#yellow-box([Perché si sommano due energie])[
  Senza messa a terra, sulla superficie esterna del guscio (raggio $R_3$) resta carica $+Q$, che crea campo all'esterno: quella regione contiene energia. Quel campo esterno è identico a quello di una sfera isolata di raggio $R_3$, la cui capacità è $C_"conduttore"=4 pi epsilon_0 R_3$. L'energia totale è la somma dell'energia "interna" (fra $R_1$ e $R_2$, il condensatore vero e proprio) e di quella "esterna" (oltre $R_3$). La messa a terra elimina il secondo pezzo perché azzera il campo esterno.
]

#align(center, graph-card([Condensatore sferico: terra e caso isolato], image("reference/images/condensatore_sferico_a_terra.png", width: 92%)))

== Esempio: condensatore piano

#green-box([L'idea prima dei conti])[
  Questo esempio porta a una rivelazione importante: l'energia di un condensatore può essere riscritta in termini del *campo elettrico* e del *volume* che esso occupa, senza più nominare cariche o potenziali. Questo suggerisce un cambio di prospettiva: l'energia non sta "sulle cariche", ma è *spalmata nello spazio dove c'è campo*. È il primo passo verso il concetto di densità di energia.
]

Per un condensatore piano ideale con armature di area $A$ separate da una distanza $h$, la carica sulle armature è

$ Q = sigma A, $

dove $sigma$ è la densità superficiale. Il campo tra le armature è uniforme:

$ E = sigma/epsilon_0. $

La differenza di potenziale tra armatura positiva e armatura negativa vale

$ Delta V = V_+ - V_- = sigma h/epsilon_0. $

Quindi la capacità è

#blue-box([Capacità del condensatore piano])[
  $ C_"piano" = Q/(Delta V) = epsilon_0 A/h. $
]

L'energia immagazzinata è

$ U = Q^2/(2 C) = 1/2 (Q^2 h)/(epsilon_0 A). $

Usando $Q=sigma A$ ed $E=sigma/epsilon_0$, si ottiene

#yellow-box([Perché questo passaggio: da $U=Q^2/(2C)$ a $U=epsilon_0/2 E^2 A h$])[
  Partiamo da $U = 1/2 (Q^2 h)/(epsilon_0 A)$ e sostituiamo $Q=sigma A$:
  $ U = 1/2 ((sigma A)^2 h)/(epsilon_0 A) = 1/2 (sigma^2 A^2 h)/(epsilon_0 A) = 1/2 (sigma^2 A h)/(epsilon_0). $
  (Abbiamo semplificato una $A$.) Ora notiamo che $sigma = epsilon_0 E$ (da $E=sigma/epsilon_0$), quindi $sigma^2 = epsilon_0^2 E^2$:
  $ U = 1/2 (epsilon_0^2 E^2 A h)/(epsilon_0) = epsilon_0/2 E^2 A h. $
  Una $epsilon_0$ si semplifica e resta la forma elegante con $E^2$ e il volume $A h$.
]

#green-box([Energia come energia del campo])[
  $ U = epsilon_0/2 E^2 A h. $
]

Il fattore $A h$ è il volume compreso tra le armature: l'energia non va pensata come localizzata sulle cariche, ma nel campo elettrico presente tra le armature.

#align(center, graph-card([Condensatore piano: campo, potenziale ed energia], cetz.canvas({
  import cetz.draw: *

  rect((0.84, 0.92), (1.12, 3.50), stroke: 1.1pt + ink, fill: rgb("#f7f9fa"))
  rect((3.48, 0.92), (3.76, 3.50), stroke: 1.1pt + ink, fill: rgb("#f7f9fa"))
  for y in (1.20, 1.65, 2.10, 2.55, 3.00) {
    axis-label((0.98, y), text(size: 11pt, weight: "bold", fill: red)[$+$])
    axis-label((3.62, y), text(size: 11pt, weight: "bold", fill: blue)[$-$])
    line((1.30, y), (3.28, y), stroke: 0.9pt + blue, mark: (end: ">"))
  }
  axis-label((2.28, 3.82), [$vec(E)=sigma/epsilon_0$], placement: "south")
  line((1.12, 0.58), (3.48, 0.58), stroke: 0.8pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.30, 0.36), [$h$], placement: "north")
  line((0.48, 0.92), (0.48, 3.50), stroke: 0.8pt + ink, mark: (start: "|", end: "|"))
  axis-label((0.28, 2.22), [$A$], placement: "east")
  axis-label((0.98, 0.48), [$V_+$], placement: "north")
  axis-label((3.62, 0.48), [$V_-$], placement: "north")

  line((4.55, 0.62), (4.55, 3.72), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((5.00, 3.18), [$Delta V=sigma h/epsilon_0$], placement: "west")
  axis-label((5.00, 2.45), [$C=epsilon_0 A/h$], placement: "west")
  axis-label((5.00, 1.72), [$U=Q^2/(2C)$], placement: "west")
  axis-label((5.00, 1.00), [$U=epsilon_0/2 E^2 (A h)$], placement: "west")
})))

== Densità di energia elettrostatica

#green-box([L'idea prima della formula])[
  Nel condensatore piano abbiamo trovato $U = epsilon_0/2 E^2 dot (A h)$, cioè energia $=$ (qualcosa) $times$ volume. Quel "qualcosa", $epsilon_0/2 E^2$, è quindi *energia per unità di volume*: la chiamiamo *densità di energia*. La grande idea è che vale ovunque, non solo nel condensatore: in ogni punto dello spazio in cui c'è un campo $E$, c'è energia accumulata con densità $epsilon_0/2 E^2$. Il campo elettrico non è un'astrazione contabile: è un vero serbatoio di energia distribuito nello spazio. Per avere l'energia totale basta sommare (integrare) questa densità su tutto lo spazio.
]

Il risultato del condensatore piano suggerisce una forma generale: l'energia elettrostatica può essere descritta come energia distribuita nello spazio in cui esiste il campo elettrico.

Questa è una lettura più fisica: non si guarda solo alle cariche, ma allo spazio attorno ad esse, dove il campo contiene energia.

Se $dif tau$ è un elemento di volume, la densità di energia elettrostatica è

#yellow-box([Densità di energia del campo elettrico])[
  $ mu_e = epsilon_0/2 E^2, quad [mu_e] = "J"/"m"^3. $
]

#yellow-box([Controllo dimensionale])[
  Verifichiamo che $mu_e$ sia davvero un'energia per volume. $epsilon_0$ si misura in $"F"/"m"$ e $E$ in $"V"/"m"$, quindi
  $ [epsilon_0 E^2] = "F"/"m" dot ("V"/"m")^2 = ("F" dot "V"^2)/"m"^3. $
  Ma $"F" dot "V"^2 = ("C"/"V") dot "V"^2 = "C" dot "V" = "J"$ (carica per potenziale è energia). Resta $"J"/"m"^3$, esattamente una densità di energia. Tutto coerente.
]

L'energia totale del sistema è quindi

#green-box([Energia localizzata nel campo])[
  $ U_"sistema" = integral_"tutto lo spazio" mu_e dif tau
  = integral_"tutto lo spazio" epsilon_0/2 E^2 dif tau. $
]

Questa espressione è particolarmente utile perché non richiede di sommare direttamente l'interazione fra tutte le coppie di cariche: basta conoscere il campo elettrico nello spazio.

#purple-box([Esempio numerico: energia nel condensatore visto come campo])[
  Riprendiamo il condensatore da $C=88 " pF"$ con $A=10^(-2) " m"^2$, $d=10^(-3) " m"$ caricato a $Delta V = 12 " V"$. Il campo è $E = Delta V slash d = 12 slash 10^(-3) = 1,2 dot 10^4 " V/m"$. La densità di energia vale
  $ mu_e = epsilon_0/2 E^2 = (8,85 dot 10^(-12))/2 dot (1,2 dot 10^4)^2 approx 4,43 dot 10^(-12) dot 1,44 dot 10^8 approx 6,4 dot 10^(-4) " J/m"^3. $
  Moltiplicando per il volume $A d = 10^(-2) dot 10^(-3) = 10^(-5) " m"^3$:
  $ U = mu_e dot A d approx 6,4 dot 10^(-4) dot 10^(-5) approx 6,4 dot 10^(-9) " J". $
  È lo stesso che si ottiene da $U=1/2 C (Delta V)^2 = 1/2 dot 88 dot 10^(-12) dot 144 approx 6,3 dot 10^(-9) " J"$ (la piccola differenza è solo arrotondamento). Le due strade danno lo stesso risultato.
]

#align(center, graph-card([Densità di energia del campo], cetz.canvas({
  import cetz.draw: *

  // Poche frecce: il campo esiste nello spazio, ma non deve coprire il volume elementare.
  for y in (1.05, 2.05, 3.05) {
    line((0.78, y), (2.02, y), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  axis-label((0.82, 3.42), [$vec(E)$], placement: "south")

  // Elemento di volume d tau.
  rect((2.64, 1.32), (3.68, 2.36), stroke: 1.1pt + ink, fill: rgb("#fbfcfd"))
  line((3.68, 1.32), (4.10, 1.70), stroke: 0.9pt + ink)
  line((3.68, 2.36), (4.10, 2.74), stroke: 0.9pt + ink)
  line((2.64, 2.36), (3.06, 2.74), stroke: 0.9pt + ink)
  line((3.06, 2.74), (4.10, 2.74), stroke: 0.9pt + ink)
  line((4.10, 1.70), (4.10, 2.74), stroke: 0.9pt + ink)
  axis-label((3.36, 3.05), [$dif tau$], placement: "south")

  line((4.68, 0.72), (4.68, 3.50), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((5.10, 2.76), [$mu_e=epsilon_0/2 E^2$], placement: "west")
  axis-label((5.10, 1.92), [$dif U=mu_e dif tau$], placement: "west")
  axis-label((5.10, 1.08), [$U=integral mu_e dif tau$], placement: "west")
})))

== Esempio: densità di energia di una carica puntiforme

#green-box([L'idea prima dei conti])[
  Applichiamo la densità di energia al caso più semplice: una singola carica puntiforme. Il suo campo è fortissimo vicino alla carica e debole lontano, quindi anche l'energia sarà concentratissima vicino alla carica. Vediamo *quanto* concentrata, e scopriremo un problema interessante del modello "carica puntiforme".
]

Per una carica puntiforme $Q$, il campo elettrico a distanza $r$ è radiale:

$ vec(E)(r) = Q/(4 pi epsilon_0 r^2) hat(r). $

La densità di energia associata al campo vale

#yellow-box([Come si svolge il quadrato])[
  Inseriamo $E=Q/(4 pi epsilon_0 r^2)$ in $mu_e=epsilon_0/2 E^2$ ed eleviamo al quadrato numeratore e denominatore:
  $ mu_e = epsilon_0/2 dot Q^2/((4 pi epsilon_0 r^2)^2) = epsilon_0/2 dot Q^2/(16 pi^2 epsilon_0^2 r^4). $
  Ora semplifichiamo: una $epsilon_0$ al numeratore con una delle due al denominatore, e $2 dot 16 = 32$:
  $ mu_e = Q^2/(2 dot 16 pi^2 epsilon_0 r^4) = Q^2/(32 pi^2 epsilon_0 r^4). $
]

#blue-box([Densità di energia di una carica puntiforme])[
  $ mu_e(r) = epsilon_0/2 E^2
  = epsilon_0/2 (Q/(4 pi epsilon_0 r^2))^2
  = Q^2/(32 pi^2 epsilon_0 r^4). $
]

La dipendenza $1/r^4$ mostra che l'energia del campo cresce molto vicino alla carica. Nel modello ideale di carica puntiforme, questo segnala una singolarità per $r -> 0$.

#red-box([Attenzione: l'energia "infinita" della carica puntiforme])[
  Se provi a integrare $mu_e$ fino a $r=0$, l'energia totale diverge (diventa infinita), perché $1/r^4$ esplode troppo rapidamente vicino all'origine. Non è un errore di calcolo: è un limite del *modello* di carica puntiforme. Una vera particella non è un punto matematico, e in elettromagnetismo classico questa "auto-energia infinita" si aggira considerando solo l'energia di *interazione* fra cariche diverse, non l'energia di una carica con se stessa (è infatti il termine $j != i$ che escludevamo nella somma discreta).
]

#align(center, graph-card([Campo e densità di energia di una carica puntiforme], cetz.canvas({
  import cetz.draw: *

  circle((2.10, 2.12), radius: 0.18, stroke: 1.0pt + red, fill: rgb("#fff4f4"))
  axis-label((2.10, 2.12), text(size: 10pt, weight: "bold", fill: red)[$Q$])
  for endpoint in ((2.10, 3.62), (3.34, 3.12), (3.78, 2.12), (3.32, 1.10), (2.10, 0.62), (0.88, 1.10), (0.42, 2.12), (0.88, 3.12)) {
    line((2.10, 2.12), endpoint, stroke: 0.85pt + blue, mark: (end: ">"))
  }
  circle((2.10, 2.12), radius: 1.46, stroke: (paint: rgb("#9fa9af"), thickness: 0.72pt, dash: "dashed"), fill: none)
  line((2.10, 2.12), (3.54, 2.12), stroke: 0.82pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.88, 2.38), [$r$], placement: "south")
  axis-label((3.82, 3.14), [$vec(E)=Q/(4 pi epsilon_0 r^2) hat(r)$], placement: "west")

  line((4.78, 0.62), (4.78, 3.62), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((5.18, 2.75), [$mu_e=epsilon_0/2 E^2$], placement: "west")
  axis-label((5.18, 1.92), [$=Q^2/(32 pi^2 epsilon_0 r^4)$], placement: "west")
  axis-label((5.18, 1.08), [cresce rapidamente per $r -> 0$], placement: "west")
})))

== Elettrodinamica: conduzione elettrica

#green-box([L'idea prima della formula])[
  Fino ad ora abbiamo studiato cariche *ferme* (elettrostatica). Adesso le mettiamo in *movimento*: questo è il mondo dei circuiti, delle pile, delle correnti.

  Un'immagine che useremo spesso: pensa alla corrente elettrica come *acqua che scorre nei tubi*. Le cariche sono le molecole d'acqua, il filo è il tubo, la differenza di potenziale è il dislivello (come una cascata) che mette in moto l'acqua, e il generatore (la pila) è la *pompa* che continua a sollevare l'acqua per tenerla in circolo. Senza pompa l'acqua si fermerebbe quando il dislivello si annulla; con la pompa il flusso continua per sempre. Tieni a mente questa analogia: tornerà utile per quasi tutto.
]

In elettrostatica le cariche sono ferme e il campo elettrico è conservativo. Le due relazioni fondamentali, già incontrate, sono

#blue-box([Equazioni elettrostatiche])[
  $ integral_S vec(E) dot dif vec(S) = Q_"int"/epsilon_0, quad
  integral_Gamma vec(E) dot dif vec(ell) = 0. $
]

#yellow-box([Come si leggono questi simboli])[
  - $integral_S vec(E) dot dif vec(S)$ è il *flusso* del campo $vec(E)$ attraverso la superficie chiusa $S$: conta quante "linee di campo" escono dalla superficie. $vec(S)$ è il vettore area, orientato verso l'esterno; il pallino $dot$ è il prodotto scalare.
  - $Q_"int"$ è la carica *racchiusa* dentro la superficie; $epsilon_0$ è la costante dielettrica del vuoto.
  - $integral_Gamma vec(E) dot dif vec(ell)$ è la *circuitazione*: si percorre un cammino chiuso $Gamma$ e si sommano i contributi $vec(E) dot dif vec(ell)$ lungo il giro. Fisicamente è il lavoro fatto dal campo (per unità di carica) lungo un giro completo.
]

La prima dice che le sorgenti del campo elettrico sono le cariche elettriche: vale sempre. La seconda dice che la circuitazione del campo elettrostatico è nulla: vale solo in elettrostatica, perché il campo elettrostatico è conservativo.

#yellow-box([Perché la circuitazione nulla significa "conservativo"])[
  "Conservativo" vuol dire che il lavoro per portare una carica da un punto $A$ a un punto $B$ *non dipende dal percorso*, ma solo dai due estremi. Se è così, allora andare da $A$ a $B$ e poi tornare indietro lungo un'altra strada (cioè fare un *giro chiuso*) dà lavoro totale zero: tutto ciò che hai "guadagnato" all'andata lo "perdi" al ritorno. Per questo $integral_Gamma vec(E) dot dif vec(ell) = 0$ è un altro modo di dire "il campo è conservativo, esiste un potenziale $V$".
]

In elettrodinamica le cariche sono in moto. Se lungo un percorso chiuso si ha

$ integral_Gamma vec(E) dot dif vec(ell) != 0, $

allora il campo compie lavoro netto su una carica che percorre il circuito. In questo caso il campo elettrico non è conservativo e non si può descrivere tutto il fenomeno con il solo potenziale elettrostatico $V$.

La differenza concettuale è questa: in elettrostatica il potenziale basta perché il lavoro dipende solo dagli estremi; in un circuito con generatore conta invece il giro completo, perché il generatore reinserisce energia nel sistema.

#green-box([L'analogia dell'acqua, di nuovo])[
  Immagina di lasciare cadere una pallina in una conca: arriva in fondo e si ferma, perché tutto il dislivello è stato "consumato". Per avere un moto *continuo* e ripetuto serve qualcuno che riporti la pallina in alto a ogni giro. Quel "qualcuno" è il generatore. Quando la circuitazione è diversa da zero, è proprio il segno che lungo il giro c'è un agente (il generatore) che inietta energia e fa girare le cariche all'infinito, esattamente come una pompa fa risalire l'acqua per tenerla in circolo.
]

#yellow-box([Idea chiave])[
  In un circuito percorso da corrente serve un agente non elettrostatico, come un generatore, capace di mantenere il moto delle cariche contro il campo elettrostatico.
]

#align(center, graph-card([Campo elettrostatico: circuitazione nulla], cetz.canvas({
  import cetz.draw: *

  axis-label((1.22, 3.40), [$integral_Gamma vec(E) dot dif vec(ell)=0$], placement: "south")
  circle((1.35, 1.85), radius: 0.98, stroke: 1.25pt + ink, fill: none)
  circle((0.68, 1.22), radius: 0.13, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  axis-label((0.68, 1.22), [$q^+$])
  line((0.68, 1.22), (0.68, 2.15), stroke: 1.25pt + blue, mark: (end: ">"))
  axis-label((1.10, 1.95), [$Gamma$], placement: "center")
  axis-label((1.35, 0.46), [$L_"chiuso"=0$], placement: "north")

  line((3.05, 0.55), (3.05, 3.38), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((3.55, 2.78), [Il campo elettrostatico è conservativo.], placement: "west")
  axis-label((3.55, 2.05), [Su un giro chiuso il lavoro totale è nullo.], placement: "west")
  axis-label((3.55, 1.18), [$V$ elettrostatico ben definito], placement: "west")
})))

#align(center, graph-card([Campo elettromotore: circuitazione non nulla], cetz.canvas({
  import cetz.draw: *

  axis-label((1.36, 3.42), [$integral_Gamma vec(E) dot dif vec(ell) != 0$], placement: "south")
  circle((1.42, 1.86), radius: 1.02, stroke: 1.25pt + ink, fill: none)
  circle((0.68, 1.18), radius: 0.13, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  axis-label((0.68, 1.18), [$q^+$])
  line((0.68, 1.18), (1.48, 1.98), stroke: 1.30pt + red, mark: (end: ">"))
  axis-label((1.74, 2.08), [$vec(F)=q vec(E)$], placement: "west")
  axis-label((1.08, 1.82), [$Gamma$], placement: "center")
  axis-label((1.42, 0.42), [$L_"chiuso" != 0$], placement: "north")

  line((3.18, 0.55), (3.18, 3.42), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((3.68, 2.72), [Il campo non è conservativo.], placement: "west")
  axis-label((3.68, 1.96), [Serve lavoro per mantenere le cariche in moto.], placement: "west")
  axis-label((3.68, 1.12), [Un generatore fornisce la F.E.M.], placement: "west")
})))

== Forza elettromotrice

#green-box([L'idea prima della formula])[
  La forza elettromotrice (in breve *fem*) è il "cuore" della pompa di cui parlavamo. La pila non crea cariche dal nulla: dentro di sé *separa* le cariche, accumulando i positivi su un polo (il $+$) e i negativi sull'altro (il $-$). Per fare questa separazione deve spingere le cariche positive *all'insù*, cioè contro la loro tendenza naturale (i $+$ vorrebbero scappare verso il $-$). Spingere contro questa tendenza costa energia: la fem misura proprio *quanta energia la pila spende per ogni coulomb di carica che sposta*. È come l'altezza della cascata che la pompa è capace di creare: più è alta, più "spinta" potrà dare al circuito.
]

La *forza elettromotrice* non è una forza meccanica: è il lavoro per unità di carica compiuto da forze non elettrostatiche per mantenere separate le cariche e alimentare il circuito. Si indica con $cal(E)$ e si misura in volt.

#red-box([Attenzione: non è una forza!])[
  Il nome "forza elettromotrice" è storico e fa cadere in trappola tutti gli studenti: $cal(E)$ *non* è una forza, non si misura in newton. È un *lavoro per unità di carica*, quindi si misura in volt ($1 " V" = 1 " J"/"C"$), esattamente come una differenza di potenziale. Leggi sempre "fem" pensando "spinta energetica per coulomb", mai "forza".
]

#green-box([Forza elettromotrice])[
  $ cal(E) = integral_-^+ vec(F)_"non el"/q dot dif vec(ell)
  = V^+ - V^-. $
]

#yellow-box([Leggere la formula pezzo per pezzo])[
  - $vec(F)_"non el"$ è la forza *non elettrostatica* (chimica, nella pila) che spinge le cariche. Dividendola per la carica $q$ ottieni la forza per unità di carica, cioè un "campo elettromotore".
  - L'integrale $integral_-^+ dots dif vec(ell)$ somma il lavoro fatto da questa forza mentre la carica viaggia *dentro il generatore*, dal polo $-$ al polo $+$.
  - Il risultato $V^+ - V^-$ è proprio la differenza di potenziale ai morsetti (per un generatore ideale): l'energia spesa per separare le cariche si ritrova come dislivello di potenziale tra i due poli.
]

Il generatore compie lavoro contro il campo elettrico interno: porta cariche positive dal polo negativo al polo positivo. Nel circuito esterno, invece, il campo elettrico guida le cariche positive dal potenziale maggiore al potenziale minore.

#green-box([Due regioni, due "spinte" opposte])[
  È utile distinguere bene le due zone del giro:
  - *Dentro la pila*: la spinta chimica $vec(F)_"non el"$ porta i $+$ "in salita", dal $-$ al $+$. È la pompa che fa risalire l'acqua.
  - *Nel circuito esterno* (fili, resistori): non c'è la pompa, quindi i $+$ scendono spontaneamente dal $+$ verso il $-$, come l'acqua che ridiscende lungo i tubi. È in questa discesa che la corrente compie lavoro utile (accende lampadine, scalda resistori).

  Il giro si chiude: la pila risolleva, il circuito fa ridiscendere, e così per sempre finché la pila ha energia.
]

Quando si include il campo elettromotore $vec(E)^*$, la circuitazione lungo il circuito chiuso non è più nulla:

#yellow-box([Campo elettromotore])[
  $ integral_Gamma vec(E)^* dot dif vec(ell) = cal(E) = V^+ - V^- quad ["V"]. $
]

#align(center, graph-card([Generatore: separazione di carica e F.E.M.], cetz.canvas({
  import cetz.draw: *

  // Armature più grandi e ben distanziate.
  circle((1.35, 2.34), radius: 0.58, stroke: 1.15pt + ink, fill: rgb("#f7f7f7"))
  circle((4.04, 2.34), radius: 0.58, stroke: 1.15pt + ink, fill: rgb("#f7f7f7"))
  for x in (1.08, 1.34, 1.60, 3.78, 4.04, 4.30) {
    line((x - 0.12, 1.92), (x + 0.20, 2.74), stroke: 0.48pt + rgb("#aeb5ba"))
  }
  circle((1.35, 2.34), radius: 0.58, stroke: 1.15pt + ink, fill: none)
  circle((4.04, 2.34), radius: 0.58, stroke: 1.15pt + ink, fill: none)
  axis-label((0.62, 2.34), [$V^+$], placement: "east")
  axis-label((4.76, 2.34), [$V^-$], placement: "west")
  line((1.95, 2.34), (3.42, 2.34), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((2.70, 2.78), [$vec(E)$], placement: "south")

  // Moto delle cariche tra le armature.
  circle((2.20, 3.48), radius: 0.14, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  axis-label((2.20, 3.48), [$+$])
  line((2.36, 3.48), (3.18, 3.48), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((2.78, 3.82), [$vec(v)$], placement: "south")
  circle((3.20, 3.02), radius: 0.14, stroke: 1.0pt + ink, fill: rgb("#edf3f8"))
  axis-label((3.20, 3.02), [$-$])
  line((3.04, 3.02), (2.22, 3.02), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((2.62, 2.70), [$vec(v)$], placement: "north")

  // Arco F.E.M. sotto, separato dal resto.
  arc((2.70, 1.90), radius: 1.32, start: 205deg, stop: 335deg, stroke: (paint: ink, thickness: 1.0pt, dash: "dashed"), mark: (end: ">"))
  axis-label((2.70, 0.70), [F.E.M.: lavoro contro il campo elettrico], placement: "north")

  line((5.36, 0.54), (5.36, 3.82), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((5.86, 2.92), [$cal(E)=V^+ - V^-$], placement: "west")
  axis-label((5.86, 2.16), [per unità di carica], placement: "west")
  axis-label((5.86, 1.40), [mantiene separate le cariche], placement: "west")
})))

#align(center, graph-card([Generatore: circuito e campo elettromotore], cetz.canvas({
  import cetz.draw: *

  // Circuito reale: il generatore mantiene V+ e V-.
  line((0.50, 4.12), (3.54, 4.12), stroke: 1.30pt + ink)
  line((0.50, 4.12), (0.50, 1.34), stroke: 1.30pt + ink)
  line((3.54, 4.12), (3.54, 1.34), stroke: 1.30pt + ink)
  line((0.50, 1.34), (1.70, 1.34), stroke: 1.30pt + ink)
  line((2.42, 1.34), (3.54, 1.34), stroke: 1.30pt + ink)
  circle((0.50, 4.12), radius: 0.08, stroke: none, fill: ink)
  circle((3.54, 4.12), radius: 0.08, stroke: none, fill: ink)
  axis-label((0.18, 4.48), [$V^+$], placement: "south")
  axis-label((3.86, 4.48), [$V^-$], placement: "south")

  line((1.70, 0.78), (1.70, 1.92), stroke: 1.55pt + ink)
  line((2.42, 0.98), (2.42, 1.72), stroke: 1.55pt + ink)
  axis-label((1.62, 0.50), [$+$], placement: "north")
  axis-label((2.50, 0.50), [$-$], placement: "north")
  circle((2.06, 1.32), radius: (0.76, 1.10), stroke: (paint: ink, thickness: 0.75pt, dash: "dashed"), fill: none)
  axis-label((2.98, 0.70), [generatore], placement: "west")
  arc((0.18, 2.52), radius: 0.54, start: 230deg, stop: 120deg, stroke: 1.08pt + green, mark: (end: ">"))
  axis-label((0.08, 2.58), [$i$], placement: "east")

  line((4.18, 2.74), (5.40, 2.74), stroke: 1.25pt + ink, mark: (end: ">"))

  // Schema equivalente: E nel circuito esterno, E* dentro il generatore.
  line((6.08, 4.12), (11.20, 4.12), stroke: 1.30pt + ink)
  line((6.08, 4.12), (6.08, 1.34), stroke: 1.30pt + ink)
  line((11.20, 4.12), (11.20, 1.34), stroke: 1.30pt + ink)
  line((6.08, 1.34), (7.02, 1.34), stroke: 1.30pt + ink)
  line((8.50, 1.34), (11.20, 1.34), stroke: 1.30pt + ink)
  axis-label((5.86, 4.48), [$+$], placement: "south")
  axis-label((11.42, 4.48), [$-$], placement: "south")

  rect((7.02, 0.78), (7.22, 2.18), stroke: 1.08pt + ink, fill: rgb("#d7d7d7"))
  rect((8.30, 1.02), (8.50, 1.94), stroke: 1.08pt + ink, fill: rgb("#d7d7d7"))
  axis-label((7.12, 0.46), [$+$], placement: "north")
  axis-label((8.40, 0.70), [$-$], placement: "north")

  line((6.42, 4.12), (9.86, 4.12), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((8.14, 4.50), [$vec(E)$], placement: "south")
  line((6.08, 1.74), (6.08, 3.46), stroke: 1.08pt + blue, mark: (end: ">"))
  axis-label((6.42, 2.60), [$vec(E)$], placement: "west")
  line((11.20, 3.44), (11.20, 1.74), stroke: 1.08pt + blue, mark: (end: ">"))
  axis-label((11.54, 2.60), [$vec(E)$], placement: "west")

  line((7.34, 1.72), (8.16, 1.72), stroke: 1.12pt + blue, mark: (end: ">"))
  axis-label((7.75, 2.08), [$vec(E)$], placement: "south")
  line((8.16, 1.18), (7.34, 1.18), stroke: 1.20pt + red, mark: (end: ">"))
  axis-label((7.75, 0.82), [$vec(E)^*$], placement: "north")
})))

== Intensità di corrente

#green-box([L'idea prima della formula])[
  Riprendiamo l'acqua nei tubi. Se ti mettessi accanto a un fiume con un cronometro e contassi *quanti litri d'acqua passano davanti a te ogni secondo*, otterresti la "portata" del fiume. L'intensità di corrente $i$ è esattamente la stessa cosa, ma con la carica al posto dell'acqua: *quanti coulomb di carica attraversano una sezione del filo ogni secondo*. Un'intensità grande non vuol dire cariche veloci, vuol dire *molta carica che passa nell'unità di tempo* — un fiume largo e lento può avere più portata di un ruscello veloce.
]

La corrente elettrica misura quanta carica attraversa una superficie in un intervallo di tempo. Se $dif q$ attraversa la sezione in un tempo $dif t$, l'intensità di corrente è

#blue-box([Intensità di corrente])[
  $ i = (dif q)/(dif t), quad [i] = "A". $
]

L'ampere è quindi un coulomb al secondo:

$ 1 " A" = 1 " C"/"s". $

#purple-box([Esempio numerico])[
  In un filo passa una carica di $q = 6 " C"$ in un tempo $t = 3 " s"$, in modo costante. L'intensità di corrente è
  $ i = q/t = (6 " C")/(3 " s") = 2 " A". $
  Vuol dire che ogni secondo attraversano la sezione $2$ coulomb di carica. Ricordando che un singolo elettrone ha carica $1,6 dot 10^(-19) " C"$, in un secondo passano circa $(2)/(1,6 dot 10^(-19)) approx 1,25 dot 10^(19)$ elettroni: tantissimi, e nessuno di loro va veloce.
]

Per convenzione il verso della corrente è il verso del moto delle cariche positive. In un metallo, però, le cariche mobili sono elettroni: gli elettroni si muovono in verso opposto alla corrente convenzionale.

#red-box([Il trabocchetto del verso])[
  Storicamente si è scelto di chiamare "verso della corrente" il verso in cui si muoverebbero le cariche *positive*. Ma nei metalli a muoversi sono gli *elettroni*, che sono negativi. Risultato: gli elettroni vanno *al contrario* rispetto alla freccia della corrente convenzionale. Non è un errore né un'incoerenza: una carica $-q$ che va a sinistra produce lo stesso trasporto di carica di una carica $+q$ che va a destra. Per tutti i conti useremo sempre il verso convenzionale (cariche positive), quindi non devi preoccupartene; ricordalo solo per non confonderti quando si parla di elettroni.
]

#align(center, graph-card([Verso convenzionale della corrente], cetz.canvas({
  import cetz.draw: *

  circle((0.78, 2.88), radius: 0.18, stroke: 1.0pt + ink, fill: rgb("#fff4f4"))
  axis-label((0.78, 2.88), [$+$])
  line((1.02, 2.88), (2.10, 2.88), stroke: 1.1pt + ink, mark: (end: ">"))
  axis-label((1.56, 3.20), [$vec(v)$], placement: "south")

  circle((1.56, 2.12), radius: 0.18, stroke: 1.0pt + ink, fill: rgb("#edf3f8"))
  axis-label((1.56, 2.12), [$-$])
  line((1.32, 2.12), (0.26, 2.12), stroke: 1.1pt + ink, mark: (end: ">"))
  axis-label((0.78, 1.78), [$vec(v)$], placement: "north")

  line((2.42, 2.12), (3.66, 2.12), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((3.04, 2.46), [$i$], placement: "south")
  axis-label((1.72, 1.18), [moto di cariche positive], placement: "north")

  line((4.18, 0.66), (4.18, 3.42), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.82, 3.30), [attraversamento di una superficie], placement: "south")
  for y in (2.62, 2.22, 1.82) {
    line((4.78, y), (5.48, y), stroke: 0.95pt + blue, mark: (end: ">"))
  }
  circle((5.82, 2.22), radius: (0.12, 0.58), stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  line((5.82, 2.22), (6.50, 2.22), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((6.62, 2.22), [$hat(n)$], placement: "west")
  axis-label((5.82, 1.34), [$i$ massimo], placement: "north")

  axis-label((7.18, 2.82), [$i=(dif q)/(dif t)$], placement: "west")
  axis-label((7.18, 2.14), [$1 " A"=1 " C"/"s"$], placement: "west")
  axis-label((7.18, 1.38), [nei metalli: elettroni in verso opposto], placement: "west")
})))

== Densità di corrente

#green-box([L'idea prima della formula])[
  L'intensità $i$ ti dice quanta carica passa *in tutto* attraverso una sezione, ma non *come è distribuita* sulla sezione. La densità di corrente $vec(J)$ è una versione "locale" e dettagliata: ti dice quanta corrente passa *per ogni metro quadrato* di superficie, e in *che direzione* scorre lì. Tornando all'acqua: $i$ è la portata totale del fiume, $vec(J)$ è "la velocità e direzione del flusso in un singolo punto" — al centro magari forte, vicino alle sponde più debole. Per questo $vec(J)$ è un *vettore* (ha direzione e verso), mentre $i$ è un semplice numero.
]

La densità di corrente descrive la carica che attraversa una superficie unitaria nell'unità di tempo. È un vettore e si misura in ampere su metro quadrato.

Il verso di $vec(J)$ è il verso della corrente convenzionale locale. Il modulo dice quanto intensa è la corrente per unità di area.

#green-box([Densità di corrente])[
  $ i = integral_"sup" vec(J) dot dif vec(S), quad [J] = "A"/"m"^2. $
]

#yellow-box([Perché c'è un prodotto scalare, e perché si integra])[
  L'integrale $integral_"sup" vec(J) dot dif vec(S)$ "somma" il contributo di tutti i pezzettini di superficie $dif vec(S)$. Il prodotto scalare $vec(J) dot dif vec(S)$ tiene conto solo della parte di $vec(J)$ *perpendicolare* alla superficie: solo quella attraversa davvero, mentre la parte che "scivola lungo" la superficie non la buca. È come misurare la pioggia con un secchio: se lo tieni dritto raccogli il massimo, se lo inclini ne raccogli meno, se lo metti di taglio (parallelo alla pioggia) non raccogli nulla. Casi limite: superficie perpendicolare al flusso $arrow$ flusso *massimo*; superficie parallela al moto $arrow$ flusso *nullo*.
]

In condizioni stazionarie, la corrente è la stessa in ogni sezione di un conduttore: non si accumula carica dentro il filo.

#yellow-box([Corrente stazionaria])[
  $ i = "costante lungo il conduttore". $
]

Per un conduttore con due sezioni $S_1$ e $S_2$:

$ J_1 S_1 = J_2 S_2. $

#green-box([Perché si stringe, va più forte])[
  Questa formula è l'identica regola dell'acqua nel tubo che si restringe. Poiché la stessa corrente $i = J S$ deve passare in entrambe le sezioni (la carica non si accumula né sparisce), se $S$ diminuisce allora $J$ deve aumentare per compensare. È il motivo per cui, schiacciando il beccuccio di una canna dell'acqua, lo zampillo esce più veloce: stessa portata, sezione più piccola, velocità maggiore. Nel filo: dove è più sottile, la densità di corrente è più alta.
]

#align(center, graph-card([Densità di corrente e sezioni], cetz.canvas({
  import cetz.draw: *

  // Tre orientazioni della superficie come nella reference.
  for y in (3.12, 2.08, 1.04) {
    line((0.48, y), (1.18, y), stroke: 0.95pt + blue, mark: (end: ">"))
    line((0.48, y - 0.24), (1.18, y - 0.24), stroke: 0.95pt + blue, mark: (end: ">"))
    axis-label((0.28, y + 0.08), [$q^+$], placement: "east")
  }
  circle((1.62, 3.00), radius: (0.10, 0.50), stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  line((1.62, 3.00), (2.08, 3.00), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((2.20, 3.00), [$hat(n)$], placement: "west")
  axis-label((3.00, 3.00), [$i_"max"$], placement: "west")

  circle((1.62, 1.96), radius: (0.16, 0.48), stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  line((1.62, 1.96), (2.04, 1.56), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((2.16, 1.56), [$hat(n)$], placement: "west")
  axis-label((3.00, 1.96), [$i$], placement: "west")

  circle((1.62, 0.92), radius: (0.50, 0.12), stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  line((1.62, 0.92), (1.62, 1.44), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((1.82, 1.44), [$hat(n)$], placement: "west")
  axis-label((3.00, 0.92), [$i=0$], placement: "west")

  line((3.82, 0.56), (3.82, 3.54), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.96, 3.54), [corrente stazionaria nel conduttore], placement: "south")
  catmull((4.34, 2.36), (5.00, 2.08), (6.96, 1.94), (7.64, 2.12), stroke: 1.0pt + ink)
  catmull((4.34, 1.18), (5.00, 1.44), (6.96, 1.58), (7.64, 1.36), stroke: 1.0pt + ink)
  circle((4.62, 1.76), radius: (0.13, 0.62), stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  circle((7.20, 1.74), radius: (0.09, 0.28), stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  line((4.16, 1.74), (7.70, 1.74), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((5.92, 2.18), [$i$], placement: "south")
  axis-label((4.54, 1.02), [$S_1$], placement: "north")
  axis-label((7.20, 1.20), [$S_2$], placement: "north")
  axis-label((5.96, 0.62), [$J_1 S_1 = J_2 S_2$], placement: "north")
})))

== Esempio: corrente nel volume di un cavo

Se la densità di corrente è costante su tutta la sezione di un filo, la corrente si ottiene moltiplicando $J$ per l'area della sezione:

$ i = J S. $

#yellow-box([Perché l'integrale diventa una moltiplicazione])[
  In generale $i = integral_"sup" vec(J) dot dif vec(S)$. Ma se $vec(J)$ è *uguale in ogni punto* della sezione (costante) ed è perpendicolare ad essa, allora sommare lo stesso valore su tutta l'area equivale semplicemente a moltiplicarlo per l'area totale: l'integrale si riduce a $i = J S$. È lo stesso motivo per cui, se in ogni metro quadrato cadono $3$ gocce, su $10 " m"^2$ ne cadono $3 times 10 = 30$: basta una moltiplicazione quando il "tasso" è uniforme.
]

Per un filo circolare di raggio $R_"filo"$:

$ S = pi R_"filo"^2. $

Con

$ J_"cost" = 3 " mA"/"m"^2 = 3 dot 10^(-3) " A"/"m"^2, quad R_"filo" = 5 " mm" = 5 dot 10^(-3) " m", $

si ha

#yellow-box([Corrente in un cavo cilindrico])[
  $ i = J pi R_"filo"^2
  = 3 dot 10^(-3) dot pi dot (5 dot 10^(-3))^2 " A"
  approx 2.36 dot 10^(-7) " A". $
]

#purple-box([Il calcolo passo per passo])[
  Partiamo dai dati convertiti in unità SI: $J = 3 dot 10^(-3) " A/m"^2$ e $R_"filo" = 5 dot 10^(-3) " m"$.
  + Eleviamo al quadrato il raggio: $(5 dot 10^(-3))^2 = 25 dot 10^(-6) " m"^2 = 2,5 dot 10^(-5) " m"^2$.
  + Moltiplichiamo per $pi$ per avere l'area: $S = pi dot 2,5 dot 10^(-5) approx 7,85 dot 10^(-5) " m"^2$.
  + Moltiplichiamo per $J$: $i = 3 dot 10^(-3) dot 7,85 dot 10^(-5) approx 2,36 dot 10^(-7) " A"$.

  Controllo delle unità: $["A/m"^2] dot ["m"^2] = ["A"]$, e infatti il risultato è in ampere. Il valore è piccolissimo (frazioni di microampere) perché qui la densità di corrente è davvero modesta.
]

#align(center, graph-card([Esempio: corrente attraverso la sezione del cavo], cetz.canvas({
  import cetz.draw: *

  line((1.18, 0.72), (1.18, 3.28), stroke: 1.0pt + ink)
  line((3.10, 0.72), (3.10, 3.28), stroke: 1.0pt + ink)
  circle((2.14, 2.00), radius: (0.94, 0.36), stroke: 1.05pt + ink, fill: rgb("#f7f7f7"))
  line((2.14, 2.00), (2.98, 2.00), stroke: 0.85pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.60, 2.28), [$R_"filo"$], placement: "south")
  for x in (1.62, 2.02, 2.42) {
    line((x, 3.20), (x, 2.45), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  axis-label((1.42, 3.30), [$vec(J)$], placement: "south")
  axis-label((2.16, 1.34), [$S=pi R_"filo"^2$], placement: "north")

  line((4.08, 0.74), (4.08, 3.26), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((4.54, 2.80), [$J_"cost"=3 " mA"/"m"^2$], placement: "west")
  axis-label((4.54, 2.12), [$R_"filo"=5 " mm"$], placement: "west")
  axis-label((4.54, 1.44), [$i=J pi R_"filo"^2$], placement: "west")
  axis-label((4.54, 0.82), [$i approx 2.36 dot 10^(-7) " A"$], placement: "west")
})))

== Moto di deriva nei conduttori

#green-box([L'idea prima della formula])[
  Domanda spontanea: se gli elettroni sono carichi e il campo li spinge, perché la corrente non è fulminea? La risposta è che gli elettroni dentro un metallo *non* volano dritti: sfrecciano in tutte le direzioni a velocità altissime per via del calore (moto termico), urtando continuamente gli atomi, come api impazzite in uno sciame. In media non vanno da nessuna parte. Quando accendiamo il campo, a questo caos sovrapponiamo una *minuscola* tendenza ordinata in una direzione: è come uno sciame di api che, pur continuando a frullare a caso, viene lentamente trascinato dal vento. Questo lentissimo trascinamento ordinato si chiama *velocità di deriva*, ed è lui — non la velocità termica — a produrre la corrente.
]

In assenza di campo elettrico applicato, gli elettroni in un metallo hanno moto termico disordinato. La velocità media è nulla:

$ overline(vec(v)_T) = 0, $

anche se le velocità istantanee sono elevate, dell'ordine di $10^2 " m"/"s"$.

#yellow-box([Perché la media è zero anche se vanno velocissimi])[
  Il segno di media $overline(dots)$ con la freccia sopra significa media *vettoriale*: si sommano le velocità con il loro verso. Poiché gli elettroni vanno in tutte le direzioni in modo simmetrico, per ogni elettrone che va a destra ce n'è uno che va a sinistra: i contributi si cancellano e la somma vettoriale è nulla. Attenzione: questo *non* vuol dire che stanno fermi (il modulo delle singole velocità è grande), vuol dire solo che, mediando le direzioni, non c'è uno spostamento netto.
]

Quando si applica un campo elettrico, al moto termico si sovrappone un piccolo moto ordinato: la *velocità di deriva*. Per gli elettroni il verso della deriva è opposto al campo, ma la corrente convenzionale è nel verso di $vec(E)$.

La corrente non richiede che gli elettroni viaggino velocemente lungo tutto il filo: basta una piccola velocità media ordinata sovrapposta al moto termico disordinato.

#blue-box([Modello microscopico])[
  $ vec(J) = n q overline(vec(v)_d). $
]

Qui $n$ è la densità di portatori di carica, $q$ la carica del portatore e $overline(vec(v)_d)$ la velocità media di deriva.

#yellow-box([Da dove viene questa formula])[
  Pensa a un tubicino di sezione $S$ e prendi un tratto lungo $v_d dot dif t$ (lo spazio percorso dai portatori in un tempo $dif t$). In quel tratto ci sono $n times (S dot v_d dif t)$ portatori, ognuno con carica $q$: la carica totale che attraversa la sezione in $dif t$ è $dif Q = n q S v_d dif t$. Dividendo per $dif t$ si ottiene la corrente $i = n q S v_d$, e dividendo per l'area $S$ si ottiene la densità $J = n q v_d$. In forma vettoriale: $vec(J) = n q overline(vec(v)_d)$. Più portatori ($n$), più carica per portatore ($q$) o più velocità di trascinamento ($v_d$): più corrente. Tutto torna con l'intuizione.
]

#align(center, graph-card([Moto termico e moto di deriva], cetz.canvas({
  import cetz.draw: *

  // Circuito con generatore e volume del filo evidenziato.
  rect((0.54, 0.88), (3.32, 3.02), stroke: 1.05pt + ink, fill: none)
  line((1.48, 0.58), (1.48, 1.54), stroke: 1.25pt + ink)
  line((2.28, 0.82), (2.28, 1.30), stroke: 1.25pt + ink)
  axis-label((1.46, 0.32), [$+$], placement: "north")
  axis-label((2.30, 0.32), [$-$], placement: "north")
  axis-label((1.90, 0.06), [F.E.M.], placement: "north")
  rect((0.92, 2.32), (2.94, 2.78), stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"), fill: none)
  for item in (((1.16, 2.44), (1.46, 2.72)), ((1.58, 2.64), (1.86, 2.38)), ((2.06, 2.42), (2.36, 2.68)), ((2.54, 2.50), (2.82, 2.50))) {
    axis-label(item.at(0), [$e^-$])
    line(item.at(0), item.at(1), stroke: 0.85pt + ink, mark: (end: ">"))
  }
  line((1.00, 3.22), (2.88, 3.22), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((1.94, 3.50), [$i$], placement: "south")
  axis-label((1.94, 2.08), [volume del filo], placement: "north")

  line((3.94, 0.56), (3.94, 3.54), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((4.42, 3.20), [agitazione termica], placement: "west")
  axis-label((4.42, 2.62), [$overline(vec(v)_T)=0$], placement: "west")
  axis-label((4.42, 2.02), [urti e moto disordinato], placement: "west")
  axis-label((4.42, 1.28), [corrente: moto ordinato], placement: "west")
  axis-label((4.42, 0.70), [$overline(vec(v)_d) != 0$], placement: "west")
  axis-label((6.40, 0.70), [$vec(J)=n q overline(vec(v)_d)$], placement: "west")
})))

== Legge di Ohm sperimentale

#green-box([L'idea prima della formula])[
  Ancora l'acqua. Se aumenti il dislivello (la differenza di potenziale $V$), scorre più acqua (più corrente $i$): è ragionevole che siano proporzionali. Ma il tubo *oppone resistenza* al flusso: un tubo stretto, lungo o rugoso lascia passare meno acqua a parità di dislivello. La *resistenza* $R$ è proprio questa "difficoltà a far passare la corrente". La legge di Ohm mette in formula questa intuizione: $V = R i$ dice che, a parità di resistenza, per avere più corrente serve più spinta, e che a parità di spinta una resistenza maggiore fa passare meno corrente.
]

In molti materiali ordinari, detti *ohmici*, si osserva sperimentalmente una relazione lineare tra differenza di potenziale e corrente:

#green-box([Legge di Ohm])[
  $ V = R i. $
]

#yellow-box([I tre modi di riscriverla])[
  La stessa relazione si può girare a seconda di cosa cerchi:
  $ V = R i, quad i = V/R, quad R = V/i. $
  Se conosci due delle tre grandezze, la terza viene da sé. La forma $i = V/R$ rende ovvia l'intuizione: più tensione $arrow$ più corrente; più resistenza $arrow$ meno corrente.
]

La legge di Ohm non è una legge universale come Coulomb o Gauss: è un modello sperimentale valido per materiali e condizioni in cui il rapporto $V/i$ resta costante.

La costante $R$ è la resistenza elettrica e si misura in ohm:

$ [R] = Omega. $

Per un conduttore filiforme omogeneo di lunghezza $ell$ e sezione $S$:

#yellow-box([Resistenza di un conduttore filiforme])[
  $ R = rho ell/S. $
]

La grandezza $rho$ è la resistività del materiale. A parità di materiale, un filo più lungo ha resistenza maggiore, mentre una sezione più grande riduce la resistenza.

#yellow-box([Perché proprio $ell$ sopra e $S$ sotto])[
  Di nuovo il tubo dell'acqua spiega tutto:
  - Un tubo *più lungo* ($ell$ grande) oppone più attrito al passaggio: la resistenza cresce con $ell$, quindi $ell$ sta al numeratore.
  - Un tubo *più largo* ($S$ grande) lascia passare più facilmente: la resistenza diminuisce all'aumentare di $S$, quindi $S$ sta al denominatore.
  - $rho$ (resistività) dipende solo *dal materiale*: il rame ha $rho$ piccola (conduce bene), la gomma enorme (isolante). È la "rugosità intrinseca" del materiale.
]

#purple-box([Esempio numerico: filo di rame])[
  Rame: $rho approx 1,7 dot 10^(-8) " "Omega dot "m"$. Filo lungo $ell = 2 " m"$, sezione $S = 1 " mm"^2 = 1 dot 10^(-6) " m"^2$.
  $ R = rho ell/S = (1,7 dot 10^(-8) dot 2)/(1 dot 10^(-6)) " "Omega = 3,4 dot 10^(-2) " "Omega approx 0,034 " "Omega. $
  Una resistenza minuscola: ecco perché i fili di collegamento si considerano quasi sempre "ideali" (resistenza trascurabile). Se prendessimo lo stesso filo lungo il doppio ($ell = 4 " m"$), la resistenza raddoppierebbe a circa $0,068 " "Omega$.
]

#align(center, graph-card([Ohm, resistenza e conduttore filiforme], cetz.canvas({
  import cetz.draw: *

  axis-label((1.42, 3.42), [resistore], placement: "south")
  line((0.35, 2.36), (0.95, 2.36), stroke: 1.0pt + ink)
  line((0.95, 2.36), (1.15, 2.78), stroke: 1.0pt + ink)
  line((1.15, 2.78), (1.38, 1.94), stroke: 1.0pt + ink)
  line((1.38, 1.94), (1.62, 2.78), stroke: 1.0pt + ink)
  line((1.62, 2.78), (1.86, 1.94), stroke: 1.0pt + ink)
  line((1.86, 1.94), (2.10, 2.36), stroke: 1.0pt + ink)
  line((2.10, 2.36), (2.70, 2.36), stroke: 1.0pt + ink)
  axis-label((1.52, 1.60), [$R$], placement: "north")
  axis-label((1.52, 0.96), [$V=R i$], placement: "north")

  line((3.24, 0.70), (3.24, 3.30), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.86, 3.42), [conduttore filiforme], placement: "south")
  circle((4.55, 2.20), radius: (0.15, 0.36), stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  line((4.55, 2.56), (7.10, 2.56), stroke: 1.0pt + ink)
  line((4.55, 1.84), (7.10, 1.84), stroke: 1.0pt + ink)
  circle((7.10, 2.20), radius: (0.15, 0.36), stroke: 1.0pt + ink, fill: none)
  line((4.55, 1.38), (7.10, 1.38), stroke: 0.85pt + ink, mark: (start: "|", end: "|"))
  axis-label((5.82, 1.16), [$ell$], placement: "north")
  axis-label((7.48, 2.20), [$S$], placement: "west")
  axis-label((5.82, 0.70), [$R=rho ell/S$], placement: "north")
})))

== Potenza elettrica ed effetto Joule

#green-box([L'idea prima della formula])[
  La *potenza* è "energia al secondo": quanto in fretta un dispositivo consuma o produce energia. Una lampadina da $100 " W"$ consuma il doppio dell'energia al secondo di una da $50 " W"$. Nei circuiti la potenza dipende da due cose che già conosciamo: *quanta carica passa al secondo* (la corrente $i$) e *quanta energia perde ogni carica nel passare* (la tensione $V$, che è energia per unità di carica). Moltiplicandole otteniamo l'energia totale al secondo, cioè $P = V i$. È come dire: se ogni litro d'acqua cade da $V$ metri e cadono $i$ litri al secondo, l'energia liberata al secondo è il prodotto dei due.
]

Se una carica $dif q$ attraversa un elemento con differenza di potenziale $V$, il lavoro elettrico vale

$ dif L = V dif q. $

#yellow-box([Perché $dif L = V dif q$])[
  Il potenziale $V$ è, per definizione, l'energia per unità di carica. Quindi se una carica $dif q$ "cade" attraverso una differenza di potenziale $V$, l'energia che cede (il lavoro) è semplicemente $V$ moltiplicato per quanta carica è passata: $dif L = V dif q$. È la stessa logica di "energia per litro" $times$ "numero di litri" $=$ "energia totale".
]

Il segno della potenza dipende dalla convenzione scelta per corrente e tensione. Nei resistori si usa di solito la potenza assorbita, che risulta positiva.

La potenza elettrica è il lavoro per unità di tempo:

#blue-box([Potenza elettrica])[
  $ P = (dif L)/(dif t) = V i quad ["W"]. $
]

#yellow-box([Il passaggio da $dif L$ a $P = V i$])[
  Partendo da $dif L = V dif q$, dividiamo entrambi i membri per $dif t$:
  $ P = (dif L)/(dif t) = V (dif q)/(dif t). $
  Ma $(dif q)/(dif t)$ è esattamente l'intensità di corrente $i$ (lo abbiamo definito così)! Sostituendo: $P = V i$. La potenza si misura in watt: $1 " W" = 1 " V" dot 1 " A" = 1 " J/s"$.
]

Per un generatore ideale con fem $cal(E)$:

$ P_"erogata" = cal(E) i. $

Per un resistore ohmico, usando $V=R i$:

#yellow-box([Effetto Joule])[
  $ P_"dissipata" = R i^2 > 0. $
]

#yellow-box([Come si ottiene $P = R i^2$])[
  Si parte da $P = V i$ e si usa la legge di Ohm $V = R i$ per sostituire la $V$:
  $ P = V i = (R i) dot i = R i^2. $
  Lo stesso risultato si può scrivere anche come $P = V^2/R$ usando $i = V/R$. Nota che $i^2$ è sempre positivo: un resistore *dissipa* sempre energia, non la restituisce mai. Per questo si parla di potenza "dissipata".
]

La potenza dissipata in un resistore si trasforma in calore: è l'effetto Joule.

#green-box([Effetto Joule nella vita quotidiana])[
  L'effetto Joule è ovunque: è il calore che scalda l'acqua nel bollitore, fa diventare incandescente il filamento di una vecchia lampadina, riscalda il phon e la stufetta elettrica. È anche il motivo per cui i caricabatterie si scaldano. Microscopicamente: gli elettroni che derivano urtano gli atomi del metallo e cedono loro energia, facendoli vibrare di più, cioè scaldando il materiale.
]

#purple-box([Esempio numerico: una stufetta])[
  Una resistenza $R = 50 " "Omega$ è attraversata da una corrente $i = 4 " A"$. La potenza dissipata è
  $ P = R i^2 = 50 dot 4^2 " W" = 50 dot 16 " W" = 800 " W". $
  In un'ora di funzionamento ($t = 3600 " s"$) l'energia dissipata in calore è
  $ E = P dot t = 800 dot 3600 " J" = 2,88 dot 10^6 " J" approx 2,88 " MJ". $
  Controllo unità: $["W"] dot ["s"] = ["J"]$, corretto.
]

#align(center, graph-card([Potenza elettrica ed effetto Joule], cetz.canvas({
  import cetz.draw: *

  axis-label((1.22, 3.42), [generatore], placement: "south")
  line((0.42, 2.40), (0.92, 2.40), stroke: 1.0pt + ink)
  line((0.92, 2.00), (0.92, 2.80), stroke: 1.2pt + ink)
  line((1.32, 2.16), (1.32, 2.64), stroke: 1.2pt + ink)
  line((1.32, 2.40), (1.90, 2.40), stroke: 1.0pt + ink)
  axis-label((1.10, 1.70), [$cal(E)$], placement: "north")
  axis-label((1.10, 0.98), [$P=cal(E) i$ erogata], placement: "north")

  line((2.76, 0.70), (2.76, 3.30), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((4.25, 3.42), [resistore ohmico], placement: "south")
  line((3.35, 2.40), (3.82, 2.40), stroke: 1.0pt + ink)
  line((3.82, 2.40), (4.00, 2.76), stroke: 1.0pt + ink)
  line((4.00, 2.76), (4.20, 2.04), stroke: 1.0pt + ink)
  line((4.20, 2.04), (4.40, 2.76), stroke: 1.0pt + ink)
  line((4.40, 2.76), (4.60, 2.04), stroke: 1.0pt + ink)
  line((4.60, 2.04), (4.80, 2.40), stroke: 1.0pt + ink)
  line((4.80, 2.40), (5.30, 2.40), stroke: 1.0pt + ink)
  axis-label((4.32, 1.70), [$V=R i$], placement: "north")
  axis-label((4.32, 0.98), [$P=R i^2$ dissipata], placement: "north")

  line((5.86, 0.70), (5.86, 3.30), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((7.08, 3.42), [bilancio], placement: "south")
  rect((6.42, 1.18), (7.92, 2.72), stroke: 1.0pt + ink, fill: none)
  line((6.42, 2.72), (6.90, 2.72), stroke: 1.0pt + ink)
  line((7.44, 2.72), (7.92, 2.72), stroke: 1.0pt + ink)
  line((6.90, 2.72), (7.02, 3.02), stroke: 1.0pt + ink)
  line((7.02, 3.02), (7.16, 2.42), stroke: 1.0pt + ink)
  line((7.16, 2.42), (7.30, 3.02), stroke: 1.0pt + ink)
  line((7.30, 3.02), (7.44, 2.72), stroke: 1.0pt + ink)
  line((6.86, 1.18), (6.86, 1.88), stroke: 1.15pt + ink)
  line((7.24, 1.34), (7.24, 1.72), stroke: 1.15pt + ink)
  line((6.48, 1.78), (6.48, 2.40), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((6.30, 2.08), [$i$], placement: "east")
  axis-label((7.08, 0.82), [$cal(E) i = R i^2$], placement: "north")
})))

== Bilancio energetico nelle reti lineari

#green-box([L'idea prima della formula])[
  L'energia non si crea né si distrugge: in un circuito, tutto ciò che il generatore *fornisce* deve essere *consumato* da qualche parte. È un bilancio come quello di un conto in banca: i versamenti (i generatori) devono pareggiare i prelievi (i resistori che dissipano). Questa idea, banale ma potentissima, ci dà un'equazione "gratis" per controllare i conti o per trovare grandezze incognite.
]

Per un generico bipolo attraversato da corrente $i$, la potenza elettrica è

$ P_"elettrica" = V i. $

Nei circuiti lineari si distinguono elementi che erogano energia e elementi che la assorbono o dissipano:

- un generatore ideale eroga potenza $P_"erogata"=cal(E) i$;
- un resistore dissipa potenza $P_"dissipata"=R i^2$;
- altri elementi, come gli induttori, possono immagazzinare o restituire energia.

Nel caso semplice di un generatore collegato a un resistore, il bilancio energetico è

#green-box([Bilancio generatore-resistore])[
  $ P_"erogata" = P_"dissipata", quad cal(E) i = R i^2. $
]

Per resistori in serie la corrente è la stessa:

$ i_1=i_2. $

Per resistori in parallelo la differenza di potenziale è la stessa:

$ V_1=V_2. $

Queste due frasi sono spesso il criterio pratico più rapido: stessa corrente significa serie; stessa tensione significa parallelo.

#green-box([Serie e parallelo con l'acqua])[
  - *Serie*: i resistori sono uno dopo l'altro, come tratti di tubo messi in fila lungo un'unica strada. L'acqua che esce dal primo è esattamente quella che entra nel secondo: non ha alternative. Per questo la *corrente è la stessa* in tutti ($i_1 = i_2 = dots$). Quello che cambia è la pressione, che cala un po' a ogni tratto.
  - *Parallelo*: i resistori sono rami diversi che partono dallo stesso punto e arrivano allo stesso punto, come più tubi affiancati tra le stesse due vasche. Tutti vedono lo *stesso dislivello* ai loro capi, quindi la *tensione è la stessa* ($V_1 = V_2 = dots$). Quello che cambia è quanta acqua scorre in ciascun ramo: i tubi più larghi (resistenza minore) ne portano di più.
]

#align(center, graph-card([Reti lineari: serie e parallelo], cetz.canvas({
  import cetz.draw: *

  axis-label((1.95, 3.58), [serie], placement: "south")
  line((0.40, 2.55), (1.00, 2.55), stroke: 1.0pt + ink)
  line((1.00, 2.55), (1.18, 2.88), stroke: 1.0pt + ink)
  line((1.18, 2.88), (1.38, 2.22), stroke: 1.0pt + ink)
  line((1.38, 2.22), (1.58, 2.88), stroke: 1.0pt + ink)
  line((1.58, 2.88), (1.78, 2.22), stroke: 1.0pt + ink)
  line((1.78, 2.22), (1.96, 2.55), stroke: 1.0pt + ink)
  line((1.96, 2.55), (2.52, 2.55), stroke: 1.0pt + ink)
  line((2.52, 2.55), (2.70, 2.88), stroke: 1.0pt + ink)
  line((2.70, 2.88), (2.90, 2.22), stroke: 1.0pt + ink)
  line((2.90, 2.22), (3.10, 2.88), stroke: 1.0pt + ink)
  line((3.10, 2.88), (3.30, 2.22), stroke: 1.0pt + ink)
  line((3.30, 2.22), (3.48, 2.55), stroke: 1.0pt + ink)
  line((3.48, 2.55), (4.08, 2.55), stroke: 1.0pt + ink)
  line((2.18, 2.90), (2.86, 2.90), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((1.46, 1.94), [$R_1$], placement: "north")
  axis-label((3.00, 1.94), [$R_2$], placement: "north")
  axis-label((2.50, 3.20), [$i$], placement: "south")
  axis-label((2.18, 1.34), [$i_1=i_2$], placement: "north")

  line((4.72, 0.62), (4.72, 3.42), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((6.60, 3.58), [parallelo], placement: "south")
  line((5.25, 2.98), (5.25, 1.34), stroke: 1.0pt + ink)
  line((7.95, 2.98), (7.95, 1.34), stroke: 1.0pt + ink)
  rect((5.25, 2.46), (7.95, 2.92), stroke: 1.0pt + ink, fill: none)
  rect((5.25, 1.40), (7.95, 1.86), stroke: 1.0pt + ink, fill: none)
  // Resistori sui due rami.
  line((6.10, 2.69), (6.30, 2.92), stroke: 1.0pt + ink)
  line((6.30, 2.92), (6.50, 2.46), stroke: 1.0pt + ink)
  line((6.50, 2.46), (6.70, 2.92), stroke: 1.0pt + ink)
  line((6.70, 2.92), (6.90, 2.46), stroke: 1.0pt + ink)
  line((6.90, 2.46), (7.10, 2.69), stroke: 1.0pt + ink)
  line((6.10, 1.63), (6.30, 1.86), stroke: 1.0pt + ink)
  line((6.30, 1.86), (6.50, 1.40), stroke: 1.0pt + ink)
  line((6.50, 1.40), (6.70, 1.86), stroke: 1.0pt + ink)
  line((6.70, 1.86), (6.90, 1.40), stroke: 1.0pt + ink)
  line((6.90, 1.40), (7.10, 1.63), stroke: 1.0pt + ink)
  axis-label((6.62, 3.18), [$i_1$], placement: "south")
  axis-label((6.62, 2.12), [$i_2$], placement: "south")
  axis-label((6.62, 0.88), [$V_1=V_2$], placement: "north")
})))

== Resistenza equivalente

#green-box([L'idea prima della formula])[
  Spesso un circuito ha tanti resistori, ma a noi interessa solo come si comporta "visto da fuori", dai due morsetti. La *resistenza equivalente* è il singolo resistore che potrei mettere al posto di tutto il groviglio senza che il resto del circuito se ne accorga: stessa tensione applicata $arrow$ stessa corrente totale. È un trucco per semplificare: riduco un gruppo di resistori a uno solo e i conti diventano facili.
]

Una rete di resistori vista da due morsetti può spesso essere sostituita da un unico resistore equivalente $R_"eq"$, scelto in modo che, a parità di tensione applicata, assorba la stessa corrente totale.

La resistenza equivalente non dice che il circuito interno è sparito fisicamente: dice solo che, guardato dai morsetti esterni, il comportamento corrente-tensione è lo stesso.

Per resistori in serie la corrente è la stessa in ogni elemento. Le cadute di tensione si sommano:

$ V_"tot" = sum_k V_k = sum_k R_k i = i sum_k R_k. $

#yellow-box([Perché si sommano, passaggio per passaggio])[
  In serie la corrente $i$ è identica in ogni resistore. La tensione totale ai capi del gruppo è la somma delle cadute su ciascun resistore (come scendere una scala: il dislivello totale è la somma dei gradini):
  $ V_"tot" = V_1 + V_2 + dots = sum_k V_k. $
  Per ogni resistore vale Ohm: $V_k = R_k i$. Sostituendo e raccogliendo $i$ (che è la stessa per tutti, quindi esce dalla somma):
  $ V_"tot" = sum_k R_k i = i sum_k R_k. $
  Confrontando con $V_"tot" = R_"serie" i$, si vede che $R_"serie" = sum_k R_k$.
]

Quindi

#blue-box([Resistori in serie])[
  $ R_"serie" = sum_k R_k. $
]

#green-box([Intuizione: la serie aumenta sempre la resistenza])[
  Mettere resistori in serie è come allungare il tubo: più tratti uno dopo l'altro, più attrito complessivo. Per questo $R_"serie"$ è *più grande* di ognuno dei singoli resistori. Regola rapida: in serie le resistenze *si sommano e basta*.
]

Per resistori in parallelo la tensione è la stessa su ogni ramo. Le correnti si sommano:

$ i_"tot" = sum_k i_k = sum_k V/R_k = V sum_k 1/R_k. $

#yellow-box([Perché si sommano i reciproci, passaggio per passaggio])[
  In parallelo tutti i rami hanno la stessa tensione $V$ ai capi (partono e arrivano agli stessi due punti). La corrente totale che entra si divide fra i rami e poi si riunisce, quindi è la somma delle correnti di ramo:
  $ i_"tot" = i_1 + i_2 + dots = sum_k i_k. $
  Per ogni ramo Ohm dà $i_k = V/R_k$. Sostituendo e raccogliendo $V$ (uguale per tutti):
  $ i_"tot" = sum_k V/R_k = V sum_k 1/R_k. $
  Confrontando con $i_"tot" = V/R_"parallelo"$ (cioè $i_"tot" = V dot 1/R_"parallelo"$), si vede che $1/R_"parallelo" = sum_k 1/R_k$.
]

Quindi

#blue-box([Resistori in parallelo])[
  $ 1/R_"parallelo" = sum_k 1/R_k,
  quad R_"parallelo" = (sum_k 1/R_k)^(-1). $
]

#green-box([Intuizione: il parallelo abbassa sempre la resistenza])[
  Aggiungere un ramo in parallelo è come aprire una *corsia in più* per il traffico: dai alle cariche una strada alternativa, quindi nel complesso passano *più* facilmente. Per questo $R_"parallelo"$ è *più piccola* di ognuna delle singole resistenze. Per due soli resistori la formula si semplifica in un prodotto-su-somma comodo da ricordare:
  $ R_"parallelo" = (R_1 R_2)/(R_1 + R_2). $
]

#red-box([Attenzione: non dimenticare l'ultimo passo])[
  L'errore più comune del parallelo è fermarsi a $1/R_"parallelo"$ scrivendolo come se fosse $R_"parallelo"$. La formula ti dà *l'inverso* della resistenza: devi fare il reciproco alla fine! Controllo di sanità: il risultato deve venire *più piccolo* del più piccolo dei resistori. Se ti viene più grande, hai sbagliato.
]

#purple-box([Esempio numerico: serie e parallelo a confronto])[
  Prendiamo $R_1 = 3 " "Omega$ e $R_2 = 6 " "Omega$.
  - *In serie*: $R_"serie" = R_1 + R_2 = 3 + 6 = 9 " "Omega$ (più grande di entrambi, come previsto).
  - *In parallelo*: $1/R_"parallelo" = 1/3 + 1/6 = 2/6 + 1/6 = 3/6 = 1/2$, quindi $R_"parallelo" = 2 " "Omega$ (più piccola di $3 " "Omega$, come previsto).

  Con la formula rapida per due resistori il parallelo si ritrova subito: $R_"parallelo" = (3 dot 6)/(3+6) = 18/9 = 2 " "Omega$. Tutto coerente.
]

#align(center, graph-card([Resistenza equivalente: serie e parallelo], cetz.canvas({
  import cetz.draw: *

  axis-label((2.72, 4.02), [serie: stessa corrente], placement: "south")
  line((0.50, 2.92), (1.18, 2.92), stroke: 1.0pt + ink)
  line((1.18, 2.92), (1.36, 3.22), stroke: 1.0pt + ink)
  line((1.36, 3.22), (1.56, 2.62), stroke: 1.0pt + ink)
  line((1.56, 2.62), (1.76, 3.22), stroke: 1.0pt + ink)
  line((1.76, 3.22), (1.96, 2.62), stroke: 1.0pt + ink)
  line((1.96, 2.62), (2.16, 2.92), stroke: 1.0pt + ink)
  line((2.16, 2.92), (2.84, 2.92), stroke: 1.0pt + ink)
  line((2.84, 2.92), (3.02, 3.22), stroke: 1.0pt + ink)
  line((3.02, 3.22), (3.22, 2.62), stroke: 1.0pt + ink)
  line((3.22, 2.62), (3.42, 3.22), stroke: 1.0pt + ink)
  line((3.42, 3.22), (3.62, 2.62), stroke: 1.0pt + ink)
  line((3.62, 2.62), (3.82, 2.92), stroke: 1.0pt + ink)
  line((3.82, 2.92), (4.88, 2.92), stroke: 1.0pt + ink)
  line((1.00, 3.42), (4.30, 3.42), stroke: 0.9pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.64, 3.68), [$V_"tot"$], placement: "south")
  line((2.28, 3.18), (3.44, 3.18), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((2.86, 3.48), [$i$], placement: "south")
  axis-label((1.66, 2.34), [$R_1$], placement: "north")
  axis-label((3.34, 2.34), [$R_N$], placement: "north")

  line((5.42, 0.56), (5.42, 4.08), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((8.30, 3.82), [parallelo: stessa tensione], placement: "south")
  line((6.20, 3.18), (6.20, 1.34), stroke: 1.0pt + ink)
  line((10.14, 3.18), (10.14, 1.34), stroke: 1.0pt + ink)
  line((5.62, 2.26), (6.20, 2.26), stroke: 1.0pt + ink)
  line((10.14, 2.26), (10.76, 2.26), stroke: 1.0pt + ink)
  for y in (3.02, 2.26, 1.50) {
    line((6.20, y), (7.08, y), stroke: 1.0pt + ink)
    line((7.08, y), (7.24, y + 0.25), stroke: 1.0pt + ink)
    line((7.24, y + 0.25), (7.42, y - 0.25), stroke: 1.0pt + ink)
    line((7.42, y - 0.25), (7.60, y + 0.25), stroke: 1.0pt + ink)
    line((7.60, y + 0.25), (7.78, y - 0.25), stroke: 1.0pt + ink)
    line((7.78, y - 0.25), (7.96, y), stroke: 1.0pt + ink)
    line((7.96, y), (10.14, y), stroke: 1.0pt + ink)
  }
  axis-label((8.12, 3.34), [$R_1$], placement: "south")
  axis-label((8.12, 2.58), [$dots$], placement: "south")
  axis-label((8.12, 1.82), [$R_N$], placement: "south")
  line((5.78, 2.58), (5.78, 1.90), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((5.48, 2.22), [$i_"tot"$], placement: "east")
  line((6.42, 0.94), (9.92, 0.94), stroke: 0.9pt + ink, mark: (start: "|", end: "|"))
  axis-label((8.18, 0.70), [$V$], placement: "north")
})))

== Leggi di Kirchhoff

#green-box([L'idea prima della formula])[
  Quando un circuito è troppo complicato per ridursi a semplici serie e paralleli, servono le *leggi di Kirchhoff*. Sono solo due, e dicono cose di puro buon senso:
  - *Prima legge (nodi)*: in un incrocio, tutta la corrente che entra deve uscire. È come un incrocio stradale: nessuna macchina sparisce o si materializza. Conservazione della *carica*.
  - *Seconda legge (maglie)*: se percorri un anello chiuso del circuito e torni al punto di partenza, la somma di tutti i "salti" e "discese" di potenziale deve fare zero (sei tornato dove eri, allo stesso potenziale). È come una passeggiata in montagna ad anello: alla fine sei tornato alla stessa quota, quindi le salite pareggiano le discese. Conservazione dell'*energia*.
]

Le reti lineari si risolvono fissando una convenzione prima di scrivere le equazioni:

1. si sceglie un verso di percorrenza per ogni maglia;
2. si sceglie un verso per le correnti incognite;
3. si assegna il segno alle F.E.M. $cal(E)_k$;
4. si assegna il segno alle cadute ohmiche $R_k i_k$.

Se alla fine una corrente viene negativa, non è un errore: significa solo che il verso reale è opposto a quello scelto come positivo.

#green-box([Il punto che spaventa tutti: i versi si scelgono "a caso"])[
  Una delle cose più disorientanti è che *non sai in anticipo da che parte gira la corrente*: la scegli tu, arbitrariamente, e poi i conti ti diranno se hai indovinato. Se trovi un valore *positivo*, hai scelto giusto; se trovi un valore *negativo*, la corrente reale va al contrario, ma il *modulo* è giusto comunque. Quindi non avere paura di sbagliare il verso: è impossibile sbagliarlo, basta interpretare bene il segno alla fine.
]

La prima legge è una forma della conservazione della carica: in un nodo non si accumula carica.

#green-box([Prima legge di Kirchhoff: nodi])[
  $ sum_k i_k = 0. $
]

#yellow-box([Come si usa ai nodi])[
  Si conta come $+$ le correnti che *entrano* nel nodo e come $-$ quelle che *escono* (oppure il contrario: l'importante è essere coerenti). La somma con i segni deve fare zero. Esempio: se in un nodo entrano $i_1 = 3 " A"$ e $i_2 = 2 " A"$, ed esce una sola corrente $i_3$, allora $i_1 + i_2 - i_3 = 0$, da cui $i_3 = 5 " A"$. Tutta la corrente entrata esce.
]

La seconda legge è una forma della conservazione dell'energia lungo una maglia chiusa:

#green-box([Seconda legge di Kirchhoff: maglie])[
  $ sum_k cal(E)_k = sum_k R_k i_k. $
]

Con la convenzione usata negli appunti: attraversare un generatore dal polo $-$ al polo $+$ dà $+cal(E)$; attraversarlo da $+$ a $-$ dà $-cal(E)$. Per un resistore, se la corrente ha lo stesso verso della maglia si scrive $+R i$, altrimenti $-R i$.

#yellow-box([La ricetta passo passo per una maglia])[
  + *Scegli un verso di percorrenza* della maglia (orario o antiorario, decidi tu) e disegnalo con una freccia.
  + *Parti da un punto* e percorri la maglia in quel verso, sommando i contributi mano a mano.
  + *Generatore*: se lo attraversi entrando dal $-$ e uscendo dal $+$ (cioè "in salita"), conta $+cal(E)$; se lo attraversi da $+$ a $-$, conta $-cal(E)$.
  + *Resistore*: se la corrente che lo attraversa ha *lo stesso verso* della tua percorrenza, la sua caduta vale $-R i$ (scendi di potenziale); messa dall'altro lato dell'uguale come negli appunti, diventa il termine $+R i$. La regola pratica è quella scritta nel box dei segni.
  + *Chiudi l'anello* e poni la somma totale uguale a zero (o, riordinando, "somma delle fem = somma delle cadute $R i$").
]

#red-box([Errori tipici con i segni])[
  - Cambiare verso di percorrenza a metà maglia: scegline *uno solo* e tienilo per tutto il giro.
  - Confondere il segno del generatore: conta solo *come lo attraversi tu* ($-$ verso $+$ o viceversa), non come "ti sembra" orientato.
  - Dimenticare che una corrente negativa non va "raddrizzata" nei conti: lasciala col suo segno fino alla fine, altrimenti sbagli il bilancio.
]

#align(center, graph-card([Kirchhoff: nodo, maglia e segni], cetz.canvas({
  import cetz.draw: *

  axis-label((1.70, 3.84), [nodo], placement: "south")
  circle((1.70, 2.76), radius: 0.08, fill: ink, stroke: none)
  line((1.70, 1.56), (1.70, 2.68), stroke: 1.1pt + ink, mark: (end: ">"))
  line((1.64, 2.82), (0.82, 3.60), stroke: 1.1pt + ink, mark: (end: ">"))
  line((1.76, 2.82), (2.58, 3.60), stroke: 1.1pt + ink, mark: (end: ">"))
  axis-label((1.96, 1.92), [$-i_1$], placement: "west")
  axis-label((0.72, 3.70), [$+i_2$], placement: "east")
  axis-label((2.68, 3.70), [$+i_3$], placement: "west")
  axis-label((1.70, 0.88), [$sum i_k=0$], placement: "north")

  line((3.42, 0.70), (3.42, 4.02), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.52, 3.84), [maglia], placement: "south")
  rect((4.35, 1.42), (6.68, 3.26), stroke: 1.05pt + ink, fill: none)
  line((5.04, 3.26), (5.04, 2.70), stroke: 1.30pt + ink)
  line((5.54, 3.26), (5.54, 2.84), stroke: 1.30pt + ink)
  axis-label((4.90, 2.52), [$-$], placement: "north")
  axis-label((5.66, 2.60), [$+$], placement: "north")
  axis-label((5.30, 2.38), [$+cal(E)$], placement: "north")
  line((5.04, 1.42), (5.22, 1.72), stroke: 1.0pt + ink)
  line((5.22, 1.72), (5.42, 1.12), stroke: 1.0pt + ink)
  line((5.42, 1.12), (5.62, 1.72), stroke: 1.0pt + ink)
  line((5.62, 1.72), (5.82, 1.12), stroke: 1.0pt + ink)
  line((5.82, 1.12), (6.00, 1.42), stroke: 1.0pt + ink)
  arc((6.30, 2.36), radius: 0.46, start: 250deg, stop: 70deg, stroke: 1.05pt + green, mark: (end: ">"))
  axis-label((6.74, 2.46), [verso maglia], placement: "west")

  line((7.30, 0.70), (7.30, 4.02), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((8.78, 3.78), [segni su un ramo], placement: "south")
  line((7.76, 2.92), (8.26, 2.92), stroke: 1.0pt + ink)
  line((8.26, 2.92), (8.44, 3.20), stroke: 1.0pt + ink)
  line((8.44, 3.20), (8.64, 2.64), stroke: 1.0pt + ink)
  line((8.64, 2.64), (8.84, 3.20), stroke: 1.0pt + ink)
  line((8.84, 3.20), (9.04, 2.64), stroke: 1.0pt + ink)
  line((9.04, 2.64), (9.22, 2.92), stroke: 1.0pt + ink)
  line((9.22, 2.92), (9.72, 2.92), stroke: 1.0pt + ink)
  line((7.92, 3.34), (9.54, 3.34), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((8.72, 3.66), [$+i$], placement: "south")
  axis-label((8.72, 2.34), [$+R i$ se segue la maglia], placement: "north")

  line((8.10, 1.28), (8.10, 2.02), stroke: 1.30pt + ink)
  line((8.56, 1.42), (8.56, 1.88), stroke: 1.30pt + ink)
  axis-label((7.92, 1.02), [$-$], placement: "north")
  axis-label((8.74, 1.02), [$+$], placement: "north")
  axis-label((9.36, 1.52), [$+cal(E)$], placement: "west")
})))

== Esempio: due generatori reali in una maglia

#green-box([L'idea prima dell'esempio])[
  Un generatore *reale* non è perfetto: dentro di sé ha sempre un po' di resistenza, chiamata *resistenza interna* $r$. È come una pompa che spreca un po' di energia per attrito interno. Qui abbiamo due pile reali messe nello stesso anello e un resistore di carico $R$. Le due fem possono "tirare" in versi opposti: il risultato dipende da chi è più forte. Applicheremo la ricetta di Kirchhoff per trovare la corrente.
]

Nel circuito degli appunti i due generatori reali hanno resistenze interne $r_1$ e $r_2$ e sono collegati tramite un resistore di carico $R$. I dati sono

$ r_1=20 Omega, quad r_2=30 Omega, quad R=50 Omega, quad cal(E)_1=50 " V", quad cal(E)_2=100 " V". $

Si fissa un verso positivo di maglia e si scrive l'unica equazione di Kirchhoff:

$ cal(E)_1 - cal(E)_2 = (r_1 + R + r_2) i. $

#yellow-box([Da dove esce questa equazione])[
  Seguiamo la maglia nel verso scelto. Le due fem sono orientate in modo opposto rispetto alla percorrenza: percorrendo, $cal(E)_1$ viene attraversata "in salita" (contributo $+cal(E)_1$), $cal(E)_2$ "in discesa" (contributo $-cal(E)_2$). A destra dell'uguale mettiamo *tutte* le cadute ohmiche del giro: c'è un solo anello, quindi la stessa corrente $i$ attraversa in serie il resistore di carico $R$ e le due resistenze interne $r_1$ e $r_2$. Le resistenze in serie si sommano, dando $(r_1 + R + r_2) i$. Risultato: $cal(E)_1 - cal(E)_2 = (r_1 + R + r_2) i$.
]

Da cui

#yellow-box([Corrente nella maglia])[
  $ i = (cal(E)_1 - cal(E)_2)/(R+r_1+r_2)
  = (50-100)/(50+20+30) " A" = -0.5 " A". $
]

#purple-box([Il calcolo passo per passo])[
  + Isoliamo $i$ dividendo entrambi i membri per $(R + r_1 + r_2)$: $i = (cal(E)_1 - cal(E)_2)/(R + r_1 + r_2)$.
  + Numeratore: $cal(E)_1 - cal(E)_2 = 50 - 100 = -50 " V"$.
  + Denominatore: $R + r_1 + r_2 = 50 + 20 + 30 = 100 " "Omega$.
  + Rapporto: $i = (-50 " V")/(100 " "Omega) = -0,5 " A"$.

  Controllo unità: $["V"]/["Omega"] = ["A"]$, corretto.
]

Il segno meno dice che la corrente reale è opposta al verso scelto. In modulo vale $0.5 " A"$.

#green-box([Cosa ci dice il segno meno (fisicamente)])[
  Avevamo scelto come "positivo" un verso, ma è uscito $i = -0,5 " A"$: la corrente *gira al contrario* di come avevamo immaginato. Ha senso! La pila più forte è $cal(E)_2 = 100 " V"$, quindi è lei a "comandare" il verso della corrente, vincendo sulla più debole $cal(E)_1 = 50 " V"$. Il modulo $0,5 " A"$ è corretto e definitivo: la scelta iniziale del verso non cambia il risultato fisico, cambia solo il segno con cui lo leggiamo.
]

#align(center, graph-card([Esempio di Kirchhoff: due generatori reali], cetz.canvas({
  import cetz.draw: *

  line((0.94, 0.78), (0.94, 3.46), stroke: 1.10pt + ink)
  line((0.94, 3.46), (2.34, 3.46), stroke: 1.10pt + ink)
  line((2.34, 3.46), (2.52, 3.74), stroke: 1.0pt + ink)
  line((2.52, 3.74), (2.72, 3.18), stroke: 1.0pt + ink)
  line((2.72, 3.18), (2.92, 3.74), stroke: 1.0pt + ink)
  line((2.92, 3.74), (3.12, 3.18), stroke: 1.0pt + ink)
  line((3.12, 3.18), (3.30, 3.46), stroke: 1.0pt + ink)
  line((3.30, 3.46), (4.72, 3.46), stroke: 1.10pt + ink)
  line((4.72, 3.46), (4.72, 0.78), stroke: 1.10pt + ink)
  line((4.72, 0.78), (0.94, 0.78), stroke: 1.10pt + ink)
  axis-label((0.78, 0.58), [$A$], placement: "north")
  axis-label((0.78, 3.66), [$B$], placement: "south")
  axis-label((4.88, 3.66), [$C$], placement: "south")
  axis-label((4.88, 0.58), [$D$], placement: "north")
  axis-label((2.84, 3.02), [$R$], placement: "north")

  // Generatore reale sinistro: r1 e fem.
  line((0.94, 2.92), (1.22, 2.74), stroke: 1.0pt + ink)
  line((1.22, 2.74), (0.66, 2.54), stroke: 1.0pt + ink)
  line((0.66, 2.54), (1.22, 2.34), stroke: 1.0pt + ink)
  line((1.22, 2.34), (0.66, 2.14), stroke: 1.0pt + ink)
  line((0.66, 2.14), (0.94, 1.94), stroke: 1.0pt + ink)
  axis-label((1.36, 2.42), [$r_1$], placement: "west")
  line((0.62, 1.58), (1.26, 1.58), stroke: 1.25pt + ink)
  line((0.76, 1.20), (1.12, 1.20), stroke: 1.25pt + ink)
  axis-label((0.44, 1.58), [$+$], placement: "east")
  axis-label((0.44, 1.20), [$-$], placement: "east")
  axis-label((1.36, 1.36), [$cal(E)_1$], placement: "west")

  // Generatore reale destro: r2 e fem.
  line((4.72, 2.92), (5.00, 2.74), stroke: 1.0pt + ink)
  line((5.00, 2.74), (4.44, 2.54), stroke: 1.0pt + ink)
  line((4.44, 2.54), (5.00, 2.34), stroke: 1.0pt + ink)
  line((5.00, 2.34), (4.44, 2.14), stroke: 1.0pt + ink)
  line((4.44, 2.14), (4.72, 1.94), stroke: 1.0pt + ink)
  axis-label((4.20, 2.42), [$r_2$], placement: "east")
  line((4.40, 1.58), (5.04, 1.58), stroke: 1.25pt + ink)
  line((4.54, 1.20), (4.90, 1.20), stroke: 1.25pt + ink)
  axis-label((5.22, 1.58), [$+$], placement: "west")
  axis-label((5.22, 1.20), [$-$], placement: "west")
  axis-label((4.16, 1.36), [$cal(E)_2$], placement: "east")

  arc((1.48, 2.48), radius: 0.52, start: 215deg, stop: 35deg, stroke: 1.0pt + green, mark: (end: ">"))
  axis-label((1.24, 3.08), [$+i$], placement: "south")
  arc((3.90, 2.48), radius: 0.52, start: 35deg, stop: 215deg, stroke: 1.0pt + red, mark: (end: ">"))
  axis-label((3.78, 2.02), [$i_"reale"$], placement: "south")

  line((5.76, 0.68), (5.76, 3.72), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((6.20, 3.18), [$cal(E)_1-cal(E)_2=(r_1+R+r_2)i$], placement: "west")
  axis-label((6.20, 2.38), [$i=-0.5 " A"$], placement: "west")
  axis-label((6.20, 1.58), [segno meno: verso opposto], placement: "west")
})))

Le tensioni sui tratti si calcolano seguendo il verso scelto e i segni dei generatori:

$ V_B - V_C = -R i, quad
  V_A - V_B = -cal(E)_1 - r_1 i, quad
  V_C - V_D = +cal(E)_2 - r_2 i. $

#yellow-box([Come leggere queste differenze di tensione])[
  Ogni espressione è la variazione di potenziale tra due punti, percorrendo il tratto che li separa: si sommano i contributi degli elementi attraversati, col loro segno (caduta ohmica $-R i$ quando "scendi", $plus.minus cal(E)$ a seconda di come attraversi il generatore). Una volta nota la corrente $i = -0,5 " A"$, queste formule danno i numeri concreti. Ad esempio $V_B - V_C = -R i = -50 dot (-0,5) = +25 " V"$: tra $B$ e $C$ c'è un dislivello di $25 " V"$. Sono utili per sapere il potenziale punto per punto nel circuito.
]

Il bilancio di potenza dice che la potenza erogata dai generatori è uguale alla potenza dissipata nei resistori:

#green-box([Bilancio di potenza nella maglia])[
  $ (cal(E)_2-cal(E)_1) i = (R+r_1+r_2) i^2. $
]

#yellow-box([Perché compare $i^2$ e perché torna])[
  A sinistra c'è la potenza *netta* erogata dai generatori ($"fem" times i$); a destra la potenza *dissipata* in tutte le resistenze (effetto Joule, $R i^2$ per ciascuna, sommate). È esattamente il bilancio energetico "versamenti = prelievi" applicato a questa maglia. Verifichiamolo coi numeri (usando il modulo $i = 0,5 " A"$): a destra $(50 + 20 + 30) dot 0,5^2 = 100 dot 0,25 = 25 " W"$; a sinistra $(100 - 50) dot 0,5 = 50 dot 0,5 = 25 " W"$. I due lati coincidono: il bilancio è rispettato.
]

== Circuito RC: scarica del condensatore

#green-box([L'idea prima della formula])[
  Un *condensatore* è come un piccolo serbatoio che immagazzina carica (e quindi energia). Un circuito *RC* è un condensatore collegato a un resistore. Nella *scarica*, il condensatore parte pieno e si svuota attraverso il resistore, come un secchio bucato che perde acqua. La cosa importante: *più è pieno, più velocemente perde* (la pressione è maggiore); man mano che si svuota, rallenta. Questo "rallentare progressivamente" è esattamente ciò che produce la curva *esponenziale*: una discesa rapida all'inizio che diventa sempre più dolce, senza mai toccare davvero lo zero.
]

Nella scarica il condensatore è inizialmente carico:

$ Q(t_0)=Q_0, quad V_0=Q_0/C. $

#yellow-box([Cosa significano questi simboli])[
  $Q_0$ è la carica iniziale immagazzinata; $C$ è la *capacità* del condensatore (quanta carica riesce a contenere per ogni volt, misurata in farad); $V_0 = Q_0/C$ è la tensione iniziale ai suoi capi. La relazione $V = Q/C$ è la definizione stessa di capacità: a parità di carica, un condensatore "grande" (C grande) sviluppa poca tensione, uno "piccolo" molta.
]

Chiudendo l'interruttore, la carica passa nel resistore. La corrente di scarica è legata alla diminuzione della carica:

$ i(t) = - (dif Q)/(dif t). $

#yellow-box([Perché c'è il segno meno])[
  Durante la scarica la carica $Q$ *diminuisce* nel tempo, quindi la sua derivata $(dif Q)/(dif t)$ è *negativa*. Ma la corrente è una grandezza che vogliamo *positiva* (sta fluendo davvero). Il segno meno davanti aggiusta proprio questo: prendendo $-(dif Q)/(dif t)$, "meno per meno" dà un numero positivo. In breve: la corrente esiste perché il condensatore perde carica, e il meno serve a renderla positiva.
]

Poiché $V_C(t)=Q(t)/C$ e $i(t)=V_R(t)/R$, dalla legge di maglia si ottiene

$ (dif Q)/(dif t) + Q/(R C) = 0. $

#yellow-box([Come si arriva a questa equazione])[
  Nella maglia c'è solo il condensatore e il resistore, quindi la tensione del condensatore deve uguagliare la tensione sul resistore: $V_C = V_R$, cioè $Q/C = R i$. Sostituendo $i = -(dif Q)/(dif t)$:
  $ Q/C = R (-(dif Q)/(dif t)) quad arrow quad R (dif Q)/(dif t) = -Q/C. $
  Dividendo tutto per $R$ e portando tutto a sinistra si ottiene proprio $(dif Q)/(dif t) + Q/(R C) = 0$. Questa è un'*equazione differenziale*: lega la funzione $Q(t)$ alla sua derivata. Dice "la velocità con cui cala la carica è proporzionale alla carica presente": tanta carica $arrow$ scarica veloce; poca carica $arrow$ scarica lenta. È la firma matematica di tutti i fenomeni esponenziali.
]

Integrando:

#blue-box([Scarica RC])[
  $ Q(t)=Q_0 e^(-t/tau), quad
    V(t)=V_0 e^(-t/tau), quad
    i(t)=i_0 e^(-t/tau), quad
    tau=R C. $
]

#yellow-box([Perché la soluzione è un'esponenziale])[
  L'equazione $(dif Q)/(dif t) = -Q/(R C)$ chiede: "quale funzione, derivata, dà sé stessa cambiata di segno e scalata?" La risposta è l'*esponenziale* $e^(-t/tau)$, perché derivare un'esponenziale restituisce ancora la stessa esponenziale (moltiplicata per una costante). Imponendo che a $t=0$ valga $Q_0$ (la carica iniziale), si fissa la costante davanti e si ottiene $Q(t) = Q_0 e^(-t/tau)$. Poiché $V = Q/C$ e $i$ sono proporzionali a $Q$, anch'esse seguono la stessa identica esponenziale decrescente.
]

Il tempo $tau=R C$ è il *tempo caratteristico*: indica la scala temporale della scarica. Dopo un tempo molto grande il condensatore è praticamente scarico.

#green-box([Cos'è davvero la costante di tempo $tau$])[
  $tau = R C$ è il "cronometro naturale" del circuito: dice *quanto è veloce* la scarica. È un tempo (controllo: $["Omega"] dot ["F"] = ["s"]$, gli ohm per i farad danno secondi). Intuizione:
  - $R$ grande $arrow$ scarica lenta (il resistore "strozza" il flusso), $tau$ grande.
  - $C$ grande $arrow$ tanta carica da smaltire, scarica lenta, $tau$ grande.

  La regola pratica: dopo *un* $tau$ è passato "un battito" del fenomeno; dopo *cinque* $tau$ è praticamente tutto finito.
]

Più precisamente, dopo un tempo $tau$ resta una frazione $e^(-1) approx 0.37$ del valore iniziale; dopo alcuni multipli di $tau$ la scarica è quasi completa.

#purple-box([Esempio numerico: tabella della scarica])[
  Prendiamo $R = 2 " k"Omega = 2000 " "Omega$ e $C = 500 " "mu"F" = 500 dot 10^(-6) " F"$. La costante di tempo è
  $ tau = R C = 2000 dot 500 dot 10^(-6) " s" = 1 " s". $
  Se la tensione iniziale è $V_0 = 10 " V"$, ecco quanto resta col passare del tempo (ogni $tau$ resta il $37%$ circa del valore precedente):
  - dopo $1 tau = 1 " s"$: $V = 10 dot e^(-1) approx 10 dot 0,37 = 3,7 " V"$;
  - dopo $2 tau = 2 " s"$: $V = 10 dot e^(-2) approx 10 dot 0,135 = 1,35 " V"$;
  - dopo $3 tau = 3 " s"$: $V = 10 dot e^(-3) approx 10 dot 0,050 = 0,50 " V"$;
  - dopo $5 tau = 5 " s"$: $V approx 10 dot 0,0067 = 0,067 " V"$, ormai quasi zero.

  Nota: in teoria non arriva *mai* esattamente a zero, ma dopo $5 tau$ è sotto l'$1%$ e si considera scarico.
]

#align(center, graph-card([Scarica RC: circuito e andamenti], cetz.canvas({
  import cetz.draw: *

  axis-label((1.38, 3.90), [circuito di scarica], placement: "south")
  line((0.50, 1.00), (0.50, 3.30), stroke: 1.05pt + ink)
  line((0.50, 3.30), (1.26, 3.30), stroke: 1.05pt + ink)
  line((1.26, 2.82), (1.26, 3.78), stroke: 1.25pt + ink)
  line((1.72, 2.96), (1.72, 3.64), stroke: 1.25pt + ink)
  line((1.72, 3.30), (2.72, 3.30), stroke: 1.05pt + ink)
  line((2.72, 3.30), (2.72, 1.00), stroke: 1.05pt + ink)
  line((2.72, 2.62), (3.00, 2.44), stroke: 1.0pt + ink)
  line((3.00, 2.44), (2.44, 2.24), stroke: 1.0pt + ink)
  line((2.44, 2.24), (3.00, 2.04), stroke: 1.0pt + ink)
  line((3.00, 2.04), (2.44, 1.84), stroke: 1.0pt + ink)
  line((2.44, 1.84), (2.72, 1.64), stroke: 1.0pt + ink)
  line((2.72, 1.00), (0.50, 1.00), stroke: 1.05pt + ink)
  line((1.12, 1.00), (1.60, 1.40), stroke: 1.05pt + ink)
  circle((1.74, 1.52), radius: 0.06, fill: ink, stroke: none)
  axis-label((1.50, 3.92), [$C$], placement: "south")
  axis-label((3.18, 2.16), [$R$], placement: "west")
  axis-label((2.36, 3.12), [$Q(t), V(t)$], placement: "west")
  line((2.18, 3.02), (2.18, 2.34), stroke: 1.0pt + blue, mark: (end: ">"))
  axis-label((2.38, 2.68), [$i(t)$], placement: "west")

  line((3.88, 0.64), (3.88, 3.92), stroke: 0.55pt + rgb("#ccd4d8"))

  line((4.32, 1.00), (7.12, 1.00), stroke: 0.9pt + ink, mark: (end: ">"))
  line((4.32, 1.00), (4.32, 3.30), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((7.24, 0.92), [$t$], placement: "north")
  axis-label((4.00, 3.30), [$Q,V$], placement: "east")
  catmull((4.32, 3.02), (4.82, 2.36), (5.44, 1.82), (6.24, 1.42), (7.06, 1.20), stroke: 1.25pt + blue)
  axis-label((4.12, 3.04), [$Q_0,V_0$], placement: "east")
  axis-label((5.82, 2.18), [$e^(-t/tau)$], placement: "west")

  line((7.32, 0.64), (7.32, 3.92), stroke: 0.55pt + rgb("#ccd4d8"))

  line((7.76, 1.00), (10.54, 1.00), stroke: 0.9pt + ink, mark: (end: ">"))
  line((7.76, 1.00), (7.76, 3.30), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((10.66, 0.92), [$t$], placement: "north")
  axis-label((7.52, 3.30), [$i$], placement: "east")
  catmull((7.76, 3.02), (8.32, 2.14), (9.10, 1.54), (9.92, 1.18), (10.48, 1.06), stroke: 1.25pt + red)
  axis-label((8.00, 3.08), [$i_0$], placement: "east")
  axis-label((9.32, 2.02), [$i_0 e^(-t/tau)$], placement: "west")
})))

La potenza dissipata nel resistore durante la scarica è istantanea:

$ P(t)=R i^2(t)=V_0^2/R e^(-2t/(R C)). $

#yellow-box([Perché compare $e^(-2t/(R C))$ e non $e^(-t/(R C))$])[
  La corrente vale $i(t) = i_0 e^(-t/tau)$. Nella potenza $P = R i^2$ la corrente è *al quadrato*: elevare al quadrato $e^(-t/tau)$ dà $e^(-2t/tau)$ (l'esponente raddoppia). Per questo la potenza decade *due volte più in fretta* della corrente. Inoltre $i_0 = V_0/R$, quindi $R i_0^2 = R (V_0/R)^2 = V_0^2/R$: ecco il fattore davanti.
]

Integrando nel tempo si ottiene l'energia totale dissipata:

#yellow-box([Energia dissipata nella scarica])[
  $ L_"tot" = integral_0^infinity P(t) dif t
  = (C V_0^2)/2
  = Q_0^2/(2 C). $
]

#yellow-box([Cosa fa qui l'integrale])[
  La potenza è "energia al secondo", ma cambia istante per istante. Per avere l'energia *totale* dissipata bisogna sommare tutti i contributi $P(t) dif t$ dal momento iniziale fino a $infinity$ (quando tutto è finito): questo è esattamente ciò che fa l'integrale $integral_0^infinity P(t) dif t$. Il risultato, $(C V_0^2)/2$, non dipende affatto da $R$: il resistore decide *quanto in fretta* si dissipa l'energia, ma *quanta* energia c'è è fissata solo da condensatore e tensione iniziale.
]

Questa è proprio l'energia inizialmente immagazzinata nel condensatore.

#green-box([Il senso fisico del risultato])[
  Tutta l'energia che il condensatore aveva accumulato, $(C V_0^2)/2$, finisce *interamente* scaldando il resistore (effetto Joule). Niente si perde: l'energia elettrica immagazzinata si trasforma tutta in calore. È il bilancio energetico ancora una volta: ciò che c'era all'inizio nel condensatore esce tutto dal resistore.
]

== Circuito RC: carica del condensatore

#green-box([L'idea prima della formula])[
  Ora il gioco è all'inverso: il condensatore parte *vuoto* e una pila lo *riempie* attraverso il resistore. È come riempire un secchio con un tubo che ha una strozzatura. All'inizio, secchio vuoto, l'acqua entra a tutta forza (corrente massima). Man mano che si riempie, la "controspinta" del condensatore cresce e l'ingresso rallenta, finché il secchio è pieno e non entra più nulla. La carica quindi *sale* verso un valore finale, ma sempre più lentamente: è di nuovo una curva esponenziale, stavolta *crescente* e con un tetto.
]

Nella carica RC il condensatore parte scarico:

$ Q(0)=0. $

Il generatore di F.E.M. $cal(E)$ fornisce energia al circuito. La tensione finale sul condensatore è $V_"fin"=cal(E)$, quindi

$ Q_"fin" = C cal(E). $

#yellow-box([Perché alla fine $V_"fin" = cal(E)$])[
  A regime (dopo tanto tempo) la carica smette di muoversi, quindi la corrente è zero. Ma se non scorre corrente, non c'è caduta sul resistore ($V_R = R i = 0$). Allora tutta la tensione della pila si ritrova ai capi del condensatore: $V_C = cal(E)$. Da $Q = C V$ segue subito la carica finale $Q_"fin" = C cal(E)$.
]

La carica cresce verso il valore finale con legge esponenziale:

#blue-box([Carica RC])[
  $ Q(t)=Q_"fin" (1-e^(-t/tau)), quad
    V_C(t)=cal(E)(1-e^(-t/tau)), quad
    tau=R C. $
]

#yellow-box([Come leggere il fattore $(1 - e^(-t/tau))$])[
  Questo fattore parte da $0$ e sale verso $1$:
  - a $t = 0$: $e^0 = 1$, quindi $1 - 1 = 0$ $arrow$ carica nulla (parte scarico, giusto).
  - a $t arrow infinity$: $e^(-infinity) = 0$, quindi $1 - 0 = 1$ $arrow$ carica al valore massimo $Q_"fin"$.

  È specularmente l'opposto della scarica: dove la scarica fa $e^(-t/tau)$ (scende da $1$ a $0$), la carica fa $1 - e^(-t/tau)$ (sale da $0$ a $1$). Dopo un tempo $tau$ è arrivata al $63%$ circa del valore finale (cioè $1 - 0,37$); dopo $5 tau$ è praticamente piena.
]

La corrente invece è massima all'inizio e poi decresce:

$ i(t)=cal(E)/R e^(-t/tau). $

#yellow-box([Perché la corrente fa il contrario della carica])[
  La corrente è la "velocità di riempimento". All'inizio, condensatore vuoto, niente lo frena: la corrente è massima, $i_0 = cal(E)/R$ (tutta la tensione cade sul resistore). Man mano che si riempie, la controspinta cresce e la corrente cala esponenzialmente fino a zero. Quindi mentre la *carica sale*, la *corrente scende*: sono due facce dello stesso processo.
]

All'inizio il condensatore scarico si comporta quasi come un corto circuito; a regime, quando è carico, si comporta come un circuito aperto per la corrente continua.

#green-box([Due comportamenti da ricordare a memoria])[
  Sono due fatti che tornano spessissimo:
  - *Condensatore scarico (istante iniziale)*: si comporta come un *filo* (corto circuito), perché non oppone ancora nessuna tensione $arrow$ corrente massima.
  - *Condensatore carico (regime)*: si comporta come un *interruttore aperto*, perché blocca completamente la corrente continua $arrow$ corrente nulla.
]

#purple-box([Esempio numerico: carica passo passo])[
  Sia $cal(E) = 12 " V"$, $R = 1 " k"Omega = 1000 " "Omega$, $C = 1000 " "mu"F" = 1 dot 10^(-3) " F"$.
  - Costante di tempo: $tau = R C = 1000 dot 1 dot 10^(-3) = 1 " s"$.
  - Carica finale: $Q_"fin" = C cal(E) = 1 dot 10^(-3) dot 12 = 1,2 dot 10^(-2) " C" = 12 " mC"$.
  - Corrente iniziale: $i_0 = cal(E)/R = 12/1000 = 0,012 " A" = 12 " mA"$.
  - Tensione dopo $1 " s"$ ($= 1 tau$): $V_C = 12 dot (1 - e^(-1)) approx 12 dot 0,63 = 7,6 " V"$.
  - Tensione dopo $3 " s"$ ($= 3 tau$): $V_C = 12 dot (1 - e^(-3)) approx 12 dot 0,95 = 11,4 " V"$, quasi al massimo.
]

#align(center, graph-card([Carica RC: circuito e grafici], cetz.canvas({
  import cetz.draw: *

  axis-label((1.40, 3.82), [circuito di carica], placement: "south")
  line((0.50, 1.00), (0.50, 3.30), stroke: 1.05pt + ink)
  line((0.50, 3.30), (1.20, 3.30), stroke: 1.05pt + ink)
  line((1.20, 2.84), (1.20, 3.76), stroke: 1.25pt + ink)
  line((1.68, 2.98), (1.68, 3.62), stroke: 1.25pt + ink)
  line((1.68, 3.30), (2.78, 3.30), stroke: 1.05pt + ink)
  line((2.78, 3.30), (2.78, 1.00), stroke: 1.05pt + ink)
  line((2.78, 2.62), (3.06, 2.44), stroke: 1.0pt + ink)
  line((3.06, 2.44), (2.50, 2.24), stroke: 1.0pt + ink)
  line((2.50, 2.24), (3.06, 2.04), stroke: 1.0pt + ink)
  line((3.06, 2.04), (2.50, 1.84), stroke: 1.0pt + ink)
  line((2.50, 1.84), (2.78, 1.64), stroke: 1.0pt + ink)
  line((2.78, 1.00), (1.76, 1.00), stroke: 1.05pt + ink)
  line((1.20, 0.58), (1.20, 1.42), stroke: 1.30pt + ink)
  line((1.72, 0.76), (1.72, 1.24), stroke: 1.30pt + ink)
  axis-label((1.04, 0.36), [$+$], placement: "north")
  axis-label((1.88, 0.36), [$-$], placement: "north")
  axis-label((1.46, 0.10), [$cal(E)$], placement: "north")
  line((0.50, 1.00), (1.20, 1.00), stroke: 1.05pt + ink)
  line((1.72, 1.00), (1.76, 1.00), stroke: 1.05pt + ink)
  line((0.24, 1.30), (0.24, 2.20), stroke: 1.0pt + green, mark: (end: ">"))
  axis-label((0.10, 1.74), [$i$], placement: "east")

  line((3.88, 0.64), (3.88, 3.92), stroke: 0.55pt + rgb("#ccd4d8"))

  line((4.32, 1.00), (7.12, 1.00), stroke: 0.9pt + ink, mark: (end: ">"))
  line((4.32, 1.00), (4.32, 3.30), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((7.24, 0.92), [$t$], placement: "north")
  axis-label((4.04, 3.30), [$Q,V_C$], placement: "east")
  line((4.32, 2.92), (7.02, 2.92), stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"))
  axis-label((4.12, 2.92), [$Q_"fin"$], placement: "east")
  catmull((4.32, 1.00), (4.86, 1.62), (5.58, 2.20), (6.34, 2.62), (7.02, 2.82), stroke: 1.25pt + blue)
  axis-label((5.56, 2.06), [$1-e^(-t/tau)$], placement: "west")

  line((7.66, 0.64), (7.66, 3.92), stroke: 0.55pt + rgb("#ccd4d8"))

  line((8.10, 1.00), (10.82, 1.00), stroke: 0.9pt + ink, mark: (end: ">"))
  line((8.10, 1.00), (8.10, 3.30), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((10.94, 0.92), [$t$], placement: "north")
  axis-label((7.86, 3.30), [$i$], placement: "east")
  catmull((8.10, 3.02), (8.62, 2.26), (9.26, 1.64), (10.10, 1.20), (10.76, 1.06), stroke: 1.25pt + red)
  axis-label((8.34, 3.08), [$cal(E)/R$], placement: "east")
})))

#green-box([Il fatto sorprendente del 50-50])[
  Durante la carica succede una cosa controintuitiva: il generatore spende una certa energia, ma solo *metà* finisce davvero immagazzinata nel condensatore. L'altra metà viene *bruciata* nel resistore come calore, e questo *indipendentemente* da quanto è grande $R$! Anche con un resistore piccolissimo, esattamente la metà dell'energia se ne va in calore. È un risultato classico che vale la pena ricordare.
]

Durante la carica, l'energia erogata dal generatore non finisce tutta nel condensatore: metà viene dissipata nel resistore e metà resta immagazzinata nel campo elettrico del condensatore.

#yellow-box([Bilancio energetico nella carica RC])[
  $ U_"erogata" = C cal(E)^2, quad
  U_R = 1/2 C cal(E)^2, quad
  U_C = 1/2 C cal(E)^2. $
]

#yellow-box([Leggere il bilancio])[
  - $U_"erogata" = C cal(E)^2$ è l'energia totale spinta dal generatore durante tutta la carica (è la fem $cal(E)$ moltiplicata per la carica totale $Q_"fin" = C cal(E)$ che è passata).
  - $U_C = 1/2 C cal(E)^2$ è l'energia che resta dentro il condensatore (è la formula dell'energia di un condensatore alla tensione finale $cal(E)$).
  - $U_R = 1/2 C cal(E)^2$ è l'energia dissipata in calore nel resistore.

  Verifica del bilancio: $U_R + U_C = 1/2 C cal(E)^2 + 1/2 C cal(E)^2 = C cal(E)^2 = U_"erogata"$. Tutto torna: ciò che il generatore eroga si ritrova metà nel condensatore e metà come calore.
]

= Principi della magnetostatica

#green-box([L'idea prima della formula])[
  Immagina due "mondi" che fino a fine Ottocento sembravano separati: l'elettricità (cariche, fulmini, scintille) e il magnetismo (calamite, bussole). La magnetostatica è il primo ponte fra i due: scopriremo che *il magnetismo non è altro che elettricità in movimento*. Una carica ferma produce solo campo elettrico; una carica che si muove (cioè una corrente) produce anche campo magnetico. "Statico" vuol dire che la corrente è costante nel tempo: scorre sempre uguale, come l'acqua in un tubo a portata fissa.
]

La magnetostatica studia campi magnetici prodotti da correnti stazionarie. A differenza del campo elettrico, il campo magnetico non nasce da una singola "carica magnetica" isolata: non esiste il monopolo magnetico osservato negli esperimenti ordinari.

Un magnete ha sempre due poli, nord e sud. Se lo si divide, non si separa un polo nord da un polo sud: si ottengono magneti più piccoli, ciascuno con entrambi i poli.

#green-box([L'idea prima della formula])[
  Pensa a una calamita come a una sbarretta con due estremità "diverse": il nord e il sud. La domanda naturale è: se la spezzo a metà, ottengo un pezzo "tutto nord" e un pezzo "tutto sud"? La risposta sperimentale è *no*: ogni frammento, per quanto piccolo, ha sempre il suo nord e il suo sud. È come tagliare una calamita-magnete e ritrovarsi ogni volta una calamita completa. Questo significa che non esistono "poli magnetici isolati" (i monopoli). La conseguenza matematica è che le linee di $vec(B)$ non possono mai partire da un punto e basta: devono sempre richiudersi su sé stesse formando anelli.
]

#blue-box([Assenza di monopoli magnetici])[
  Le linee del campo magnetico sono chiuse:
  $ integral_S vec(B) dot hat(n) dif S = 0, quad nabla dot vec(B)=0. $
]

#yellow-box([Come leggere queste due formule])[
  La prima scrittura è il *flusso* di $vec(B)$ attraverso una qualsiasi superficie chiusa $S$: immagina di contare quante linee di campo "entrano" e quante "escono" da una superficie che racchiude completamente una regione (come la buccia di una palla). Siccome ogni linea che entra deve anche uscire (le linee sono anelli senza inizio né fine), entrate e uscite si compensano sempre: il bilancio netto è $0$. Il simbolo $hat(n)$ è il *versore normale*, cioè una freccia di lunghezza $1$ che punta verso l'esterno della superficie, e serve a stabilire cosa conta come "uscita" (positivo) e cosa come "entrata" (negativo).

  La seconda scrittura, $nabla dot vec(B)=0$, è la stessa identica idea ma "punto per punto": la *divergenza* $nabla dot vec(B)$ misura quanto un punto si comporta da "sorgente" (da cui partono linee) o da "pozzo" (in cui finiscono). Per il campo magnetico vale $0$ ovunque: nessun punto crea o distrugge linee di campo. Per il campo elettrico, invece, la divergenza è diversa da zero dove c'è carica.
]

Il vettore $vec(B)$ è il *campo magnetico*. Le sue linee non cominciano e non finiscono su sorgenti isolate: formano anelli chiusi.

Questo è il primo grande contrasto con il campo elettrico: le linee di $vec(E)$ possono partire o finire su cariche, mentre le linee di $vec(B)$ non hanno estremi.

#align(center, graph-card([Magneti, poli e linee chiuse di campo], cetz.canvas({
  import cetz.draw: *

  rect((0.45, 2.48), (0.98, 3.44), stroke: 1.05pt + ink, fill: rgb("#fbfcfd"))
  line((0.45, 2.96), (0.98, 2.96), stroke: 0.8pt + ink)
  axis-label((0.72, 3.20), [$N$])
  axis-label((0.72, 2.72), [$S$])
  for y in (3.28, 3.08, 2.84, 2.64) {
    line((1.18, y), (1.66, y), stroke: 0.9pt + ink, mark: (end: ">"))
  }
  rect((1.86, 3.10), (2.12, 3.42), stroke: 0.9pt + ink, fill: rgb("#fbfcfd"))
  rect((1.86, 2.62), (2.12, 2.94), stroke: 0.9pt + ink, fill: rgb("#fbfcfd"))
  axis-label((2.36, 3.24), [ogni pezzo ha $N$ e $S$], placement: "west")

  line((3.16, 0.68), (3.16, 3.82), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((4.76, 3.62), [non monopolo], placement: "south")
  circle((4.10, 2.52), radius: 0.10, fill: ink, stroke: none)
  for a in (0deg, 45deg, 90deg, 135deg, 180deg, 225deg, 270deg, 315deg) {
    line((4.10, 2.52), (4.10 + calc.cos(a) * 0.90, 2.52 + calc.sin(a) * 0.90), stroke: 1.0pt + rgb("#9aa2a8"))
  }
  axis-label((4.10, 1.32), [NO], placement: "north")

  axis-label((7.16, 3.62), [linee chiuse], placement: "south")
  circle((7.18, 2.52), radius: (0.95, 0.58), stroke: 1.20pt + blue, fill: none, mark: (end: ">"))
  axis-label((8.28, 2.62), [$vec(B)$], placement: "west")
  axis-label((6.38, 1.30), [$integral_S vec(B) dot hat(n) dif S = 0$], placement: "north")
})))

La bussola è un piccolo ago magnetico: tende ad allinearsi al campo magnetico terrestre. Questo mostra che $vec(B)$ ha direzione e verso locali, come un campo vettoriale.

#align(center, graph-card([Ago magnetico e campo terrestre], cetz.canvas({
  import cetz.draw: *

  circle((2.30, 2.10), radius: (1.35, 1.02), stroke: 1.05pt + ink, fill: rgb("#f7f7f7"))
  catmull((1.10, 2.80), (1.70, 3.22), (2.80, 3.14), (3.54, 2.58), stroke: 1.05pt + green, mark: (end: ">"))
  catmull((3.46, 1.48), (2.78, 0.92), (1.66, 0.94), (1.08, 1.42), stroke: 1.05pt + green, mark: (end: ">"))
  line((1.42, 1.40), (3.08, 2.80), stroke: 1.10pt + ink)
  axis-label((3.22, 2.92), [$N$], placement: "west")
  axis-label((1.28, 1.26), [$S$], placement: "east")

  line((4.32, 0.70), (4.32, 3.52), stroke: 0.55pt + rgb("#ccd4d8"))

  catmull((5.20, 1.52), (5.52, 2.16), (6.28, 2.52), (6.88, 2.20), (6.52, 1.58), (5.78, 1.24), (5.20, 1.52), stroke: 1.05pt + ink, fill: rgb("#fbfcfd"))
  line((5.66, 1.62), (6.48, 2.22), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((6.62, 2.28), [$N$], placement: "west")
  axis-label((5.50, 1.50), [$S$], placement: "east")
  axis-label((5.96, 0.92), [l'ago si allinea a $vec(B)$], placement: "north")
})))

== Esperienza di Oersted

#green-box([L'idea prima della formula])[
  Nel 1820 Oersted stava facendo una lezione con una pila e un filo. Vicino al filo c'era per caso una bussola. Quando faceva passare corrente nel filo, l'ago della bussola *girava*. Questo è uno dei momenti più importanti della fisica: dimostra che una corrente elettrica si comporta come una calamita, cioè *produce un campo magnetico*. L'immagine mentale giusta: avvolgi la mano destra attorno al filo con il pollice nel verso della corrente; le dita che si chiudono indicano il verso del campo magnetico, che gira *attorno* al filo come tanti anelli concentrici.
]

Oersted osservò che una corrente elettrica devia un ago magnetico: le sorgenti del campo magnetico sono le cariche in moto, cioè le correnti.

Questa osservazione collega elettricità e magnetismo: una carica ferma genera solo campo elettrico, mentre una carica in moto contribuisce anche al campo magnetico.

#blue-box([Idea fondamentale])[
  Una corrente stazionaria genera un campo magnetico $vec(B)$ le cui linee circondano il filo.
]

#yellow-box([Una sottigliezza importante sulle linee di campo])[
  Nota la differenza con il campo elettrico di una carica puntiforme: lì le linee *escono raggianti* dalla carica (come gli aculei di un riccio). Qui invece le linee di $vec(B)$ *avvolgono* il filo come cerchi: non partono dal filo, gli girano intorno. È coerente con quanto detto prima: le linee magnetiche sono sempre chiuse.
]

#align(center, graph-card([Oersted: campo attorno a un filo percorso da corrente], cetz.canvas({
  import cetz.draw: *

  // Piano e filo.
  line((0.85, 1.04), (3.90, 1.04), stroke: 1.05pt + ink)
  line((0.85, 1.04), (1.72, 2.74), stroke: 1.05pt + ink)
  line((3.90, 1.04), (4.78, 2.74), stroke: 1.05pt + ink)
  line((1.72, 2.74), (4.78, 2.74), stroke: 1.05pt + ink)
  line((2.82, 0.50), (2.82, 3.42), stroke: 1.25pt + ink, mark: (end: ">"))
  axis-label((3.04, 3.32), [$i$], placement: "west")
  circle((2.82, 1.90), radius: (0.82, 0.36), stroke: 1.20pt + blue, fill: none, mark: (end: ">"))
  circle((2.82, 1.90), radius: (1.22, 0.54), stroke: 1.05pt + blue, fill: none, mark: (end: ">"))
  axis-label((4.30, 2.06), [$vec(B)$], placement: "west")

  line((5.42, 0.68), (5.42, 3.60), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.96, 2.86), [le sorgenti di $vec(B)$ sono], placement: "west")
  axis-label((5.96, 2.22), [le cariche in moto], placement: "west")
  line((7.34, 1.28), (9.18, 1.84), stroke: 1.15pt + ink, mark: (end: ">"))
  circle((7.70, 1.44), radius: 0.08, fill: ink, stroke: none)
  axis-label((7.56, 1.20), [$q$], placement: "north")
  line((7.70, 1.44), (8.38, 1.86), stroke: 1.05pt + green, mark: (end: ">"))
  axis-label((8.48, 1.92), [$vec(v)$], placement: "west")
  line((8.32, 1.58), (9.24, 1.58), stroke: 1.05pt + blue, mark: (end: ">"))
  axis-label((9.34, 1.58), [$i$], placement: "west")
})))

== Teorema di Ampère

#green-box([L'idea prima della formula])[
  Il teorema di Ampère è il "fratello magnetico" del teorema di Gauss. In elettrostatica, Gauss diceva: *se cammino lungo una superficie chiusa e sommo il flusso di $vec(E)$, ottengo la carica racchiusa*. Ampère dice una cosa analoga ma con un percorso (non una superficie) e con la corrente (non la carica): *se cammino lungo un anello chiuso $Gamma$ e sommo, passo passo, quanto $vec(B)$ è "allineato" al mio cammino, ottengo (a meno di una costante) la corrente che fora l'anello*. La parola chiave è "circuitazione": è la somma di tante piccole quantità $vec(B) dot dif vec(ell)$, cioè la componente di $vec(B)$ nella direzione in cui sto camminando, moltiplicata per il tratto percorso.
]

Nel caso magnetostatico, cioè con correnti stazionarie, la circuitazione del campo magnetico lungo una linea chiusa $Gamma$ è proporzionale alla corrente concatenata con quella linea.

La parola "concatenata" significa che la corrente attraversa una superficie che ha $Gamma$ come bordo. Non basta che una corrente sia vicina alla linea: deve bucare la superficie scelta.

#green-box([Teorema di Ampère])[
  $ integral_Gamma vec(B) dot dif vec(ell) = mu_0 i_"conc". $
]

#yellow-box([Significato dei simboli])[
  - $integral_Gamma$: integrale lungo *tutto* il giro dell'anello chiuso $Gamma$ (la lettera greca maiuscola gamma); l'anello deve richiudersi dove è partito.
  - $dif vec(ell)$: un pezzettino del cammino, visto come vettore tangente al percorso; ha la direzione in cui ci muoviamo lungo $Gamma$.
  - $vec(B) dot dif vec(ell)$: prodotto scalare, cioè $B dif ell cos theta$. Conta solo la parte di $vec(B)$ parallela al cammino. Dove $vec(B)$ è perpendicolare al cammino, questo contributo è zero.
  - $mu_0$: la permeabilità del vuoto, una costante della natura.
  - $i_"conc"$: la corrente "concatenata", cioè quella che buca la superficie appoggiata su $Gamma$.

  L'analogia: è come voler sapere quanta acqua passa dentro un cerchio di filo immerso in un fiume. Quello che conta è solo l'acqua che *attraversa* il cerchio, non quella che gli scorre accanto senza passarci dentro.
]

La costante $mu_0$ è la *permeabilità magnetica del vuoto*. Nei calcoli di base si usa

$ mu_0 approx 4 pi dot 10^(-7) " N"/"A"^2. $

Dopo la ridefinizione del SI del 2019 questo valore non è più esatto per definizione, ma l'approssimazione è quella usata normalmente negli esercizi.

#red-box([Attenzione: cosa NON dice il teorema])[
  Il teorema dice solo quanto vale la *circuitazione totale* su tutto l'anello, non quanto vale $vec(B)$ in un singolo punto. Diventa utile per calcolare $B$ solo quando c'è abbastanza simmetria da poter dire in anticipo che $B$ è costante in modulo lungo la curva scelta (così esce dall'integrale). Senza simmetria, il teorema resta vero ma non basta per ricavare $B$. È lo stesso identico limite del teorema di Gauss in elettrostatica.
]

La corrente concatenata $i_"conc"$ è la corrente totale che attraversa una qualsiasi superficie avente bordo $Gamma$, contando il segno rispetto all'orientazione scelta. In forma locale il teorema diventa

#blue-box([Forma locale di Ampère])[
  $ nabla times vec(B) = mu_0 vec(J). $
]

Il teorema di Ampère è particolarmente utile quando la simmetria permette di sapere in anticipo la direzione di $vec(B)$ e di scegliere una linea amperiana su cui il modulo di $B$ è costante.

#align(center, graph-card([Teorema di Ampère e corrente concatenata], cetz.canvas({
  import cetz.draw: *

  axis-label((1.62, 3.72), [corrente e linee di $vec(B)$], placement: "south")
  line((1.18, 0.58), (1.18, 3.26), stroke: 1.20pt + ink, mark: (end: ">"))
  axis-label((1.38, 3.16), [$i$], placement: "west")
  circle((1.18, 1.84), radius: (0.90, 0.34), stroke: 1.20pt + blue, fill: none, mark: (end: ">"))
  circle((1.18, 1.84), radius: (1.30, 0.50), stroke: 1.05pt + blue, fill: none, mark: (end: ">"))
  axis-label((2.72, 2.02), [$vec(B)$], placement: "west")

  line((3.30, 0.62), (3.30, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.42, 3.72), [linea amperiana $Gamma$], placement: "south")
  circle((5.42, 2.14), radius: (1.18, 0.52), stroke: 1.15pt + ink, fill: none, mark: (end: ">"))
  catmull((4.72, 0.98), (5.04, 1.74), (5.92, 2.36), (6.30, 3.16), stroke: 1.05pt + red, mark: (end: ">"))
  axis-label((4.42, 2.88), [$+i_"conc"$], placement: "east")
  catmull((6.10, 0.94), (5.76, 1.62), (4.92, 2.18), (4.50, 3.02), stroke: 1.05pt + red, mark: (end: ">"))
  axis-label((6.42, 2.80), [$-i_"conc"$], placement: "west")
  axis-label((5.44, 0.66), [$integral_Gamma vec(B) dot dif vec(ell)=mu_0 i_"conc"$], placement: "north")

  line((7.72, 0.62), (7.72, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((8.16, 3.18), [sorgenti di $vec(B)$:], placement: "west")
  axis-label((8.16, 2.52), [cariche in moto], placement: "west")
  axis-label((8.16, 1.86), [correnti $i$ o densità $vec(J)$], placement: "west")
  axis-label((8.16, 1.12), [$nabla times vec(B)=mu_0 vec(J)$], placement: "west")
})))

== Forza magnetica e forza di Lorentz

#green-box([L'idea prima della formula])[
  Abbiamo visto che le correnti *creano* campo magnetico. Ora guardiamo il rovescio della medaglia: il campo magnetico *spinge* le cariche in moto. Ma con una regola sorprendente: la spinta non è nella direzione del campo (come accadeva per il campo elettrico), ed è nemmeno nella direzione del moto. È *perpendicolare a tutti e due*. Pensa a una carica come a una pallina lanciata: il campo magnetico non la accelera né la frena, la fa solo *curvare di lato*, come una mano che spinge sempre di traverso. Per questo le particelle cariche in un campo magnetico percorrono cerchi o spirali invece di linee dritte.
]

Il campo magnetico è prodotto da cariche in moto e agisce su cariche in moto. La forza magnetica su una carica $q$ che si muove con velocità $vec(v)$ è

#blue-box([Forza magnetica su una carica])[
  $ vec(F)_B = q vec(v) times vec(B). $
]

#yellow-box([Perché un prodotto vettoriale, e perché è perpendicolare a tutto])[
  Il simbolo $times$ è il *prodotto vettoriale* (cross product). Per costruzione, il risultato di $vec(v) times vec(B)$ è sempre un vettore *perpendicolare* sia a $vec(v)$ sia a $vec(B)$. Questa non è una coincidenza scelta a mano: è proprio la matematica giusta per descrivere ciò che si osserva in laboratorio, cioè che la forza è di traverso. Il prodotto vettoriale ha tre caratteristiche:
  - *Modulo*: $|vec(F)_B| = |q| v B sin theta$, dove $theta$ è l'angolo fra $vec(v)$ e $vec(B)$. Notare il $sin theta$: la forza è massima quando carica e campo sono perpendicolari ($theta=90°$, $sin theta=1$) ed è nulla quando la carica viaggia *parallela* al campo ($theta=0$, $sin theta=0$). Una carica che si muove lungo le linee di $vec(B)$ non sente alcuna forza.
  - *Direzione*: perpendicolare al piano individuato da $vec(v)$ e $vec(B)$.
  - *Verso*: dato dalla regola della mano destra (dita da $vec(v)$ verso $vec(B)$, pollice = verso del prodotto), poi invertito se la carica è negativa.
]

#yellow-box([Controllo di sanità: i casi limite])[
  - Se $theta = 0$ (carica parallela a $vec(B)$): $sin 0 = 0$, quindi $F_B = 0$. Giusto: la carica prosegue dritta.
  - Se $theta = 90°$ (carica perpendicolare a $vec(B)$): $sin 90° = 1$, forza massima $F_B = |q| v B$. La carica curva al massimo e descrive un cerchio.
  - Se $v = 0$ (carica ferma): $F_B = 0$. Una carica immobile *non* sente il campo magnetico: il magnetismo agisce solo su ciò che si muove.
]

La forza è perpendicolare sia alla velocità sia al campo magnetico. Per questo motivo la potenza istantanea della forza magnetica è nulla:

$ P = vec(F)_B dot vec(v) = 0. $

#yellow-box([Perché la potenza è esattamente zero, e cosa comporta])[
  La potenza è $P = vec(F)_B dot vec(v)$, prodotto scalare fra forza e velocità. Ma $vec(F)_B$ è perpendicolare a $vec(v)$ (lo abbiamo appena visto): il prodotto scalare di due vettori perpendicolari è $0$. Quindi $P=0$ *sempre*, in ogni istante. La conseguenza fisica è enorme: una forza che non compie lavoro non può cambiare l'energia cinetica della carica. Il campo magnetico *non accelera né frena* la particella: ne cambia solo la direzione. La velocità conserva il suo modulo, gira soltanto.
]

Il prodotto vettoriale serve proprio a codificare questa geometria: modulo $q v B sin theta$, direzione perpendicolare al piano formato da $vec(v)$ e $vec(B)$, verso dato dalla regola della mano destra e dal segno di $q$.

Il campo magnetico può deviare la traiettoria, ma non cambia direttamente il modulo della velocità né l'energia cinetica della carica.

#purple-box([Esempio numerico: protone in un campo magnetico])[
  Un protone (carica $q = 1,6 dot 10^(-19) " C"$) viaggia a $v = 2 dot 10^6 " m/s"$ perpendicolarmente a un campo $B = 0,5 " T"$ (tesla). La forza magnetica vale:
  $ F_B = |q| v B sin 90° = (1,6 dot 10^(-19)) dot (2 dot 10^6) dot 0,5 dot 1 = 1,6 dot 10^(-13) " N". $
  Sembra una forza minuscola, ma agisce su una particella leggerissima, quindi la curva tantissimo. La forza è perpendicolare alla velocità, perciò il protone descrive un cerchio. Uguagliando $F_B$ alla forza centripeta $m v^2 / r$ si ricava il raggio dell'orbita:
  $ r = (m v)/(|q| B). $
  Con $m = 1,67 dot 10^(-27) " kg"$:
  $ r = ((1,67 dot 10^(-27)) dot (2 dot 10^6))/((1,6 dot 10^(-19)) dot 0,5) approx 4,2 dot 10^(-2) " m" approx 4 " cm". $
  Questo è esattamente il principio dei *ciclotroni* e dei magneti che curvano i fasci di particelle.
]

Se sono presenti sia campo elettrico sia campo magnetico, la forza totale è la forza di Lorentz:

#green-box([Forza di Lorentz])[
  $ vec(F) = q vec(E) + q vec(v) times vec(B). $
]

#yellow-box([Come leggere la forza di Lorentz])[
  È semplicemente la *somma* dei due effetti che già conosciamo:
  - $q vec(E)$: la forza elettrica, *parallela* al campo $vec(E)$ (o antiparallela se $q<0$). Questa parte compie lavoro e cambia l'energia.
  - $q vec(v) times vec(B)$: la forza magnetica, *perpendicolare* alla velocità. Questa parte non compie lavoro.
  Insieme descrivono qualsiasi forza su una carica nel caso più generale. È una delle equazioni più importanti dell'elettromagnetismo: lega il moto delle cariche ai campi.
]

Su un tratto infinitesimo di filo percorso da corrente $i$ la forza magnetica è

#yellow-box([Forza su un filo percorso da corrente])[
  $ dif vec(F) = i dif vec(ell) times vec(B). $
]

#yellow-box([Da dove arriva questa formula])[
  Un filo percorso da corrente è semplicemente *tante cariche in movimento tutte insieme*. Se sommiamo la forza di Lorentz magnetica $q vec(v) times vec(B)$ su tutte le cariche contenute in un tratto $dif vec(ell)$, e usiamo il fatto che la corrente è $i = $ (cariche per unità di lunghezza) $times$ velocità, il risultato compatto è $dif vec(F) = i dif vec(ell) times vec(B)$. Qui $dif vec(ell)$ è un pezzettino di filo orientato nel verso della corrente. Valgono le stesse regole di prima: la forza è perpendicolare al filo e al campo, ed è massima quando il filo è perpendicolare a $vec(B)$. Per un tratto rettilineo di lunghezza $L$ perpendicolare al campo, in modulo: $F = i L B$.
]

#purple-box([Esempio numerico: forza su un filo])[
  Un filo rettilineo lungo $L = 0,2 " m"$, percorso da corrente $i = 3 " A"$, è immerso perpendicolarmente in un campo $B = 0,4 " T"$. La forza vale:
  $ F = i L B = 3 dot 0,2 dot 0,4 = 0,24 " N". $
  Controllo dimensionale: $["A"] dot ["m"] dot ["T"] = "A" dot "m" dot ("N"/("A" dot "m")) = "N"$, perché $1 " T" = 1 " N"/("A" dot "m")$. Le unità tornano: il risultato è una forza in newton.
]

#align(center, graph-card([Forza di Lorentz e forza su un filo], cetz.canvas({
  import cetz.draw: *

  axis-label((1.70, 3.72), [carica in moto], placement: "south")
  circle((1.18, 1.62), radius: 0.12, fill: ink, stroke: none)
  axis-label((0.96, 1.34), [$q$], placement: "east")
  line((1.18, 1.62), (2.10, 2.44), stroke: 1.15pt + green, mark: (end: ">"))
  axis-label((2.22, 2.50), [$vec(v)$], placement: "west")
  line((1.18, 1.62), (2.18, 1.62), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((2.30, 1.62), [$vec(B)$], placement: "west")
  line((1.18, 1.62), (0.40, 0.82), stroke: 1.15pt + red, mark: (end: ">"))
  axis-label((0.30, 0.76), [$vec(F)_B$], placement: "east")
  axis-label((1.72, 0.52), [$vec(F)_B$ perpendicolare a $vec(v)$ e $vec(B)$], placement: "north")

  line((3.40, 0.60), (3.40, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.64, 3.72), [filo in campo magnetico], placement: "south")
  catmull((4.24, 0.96), (4.88, 1.80), (5.58, 2.52), (6.42, 3.12), stroke: 1.20pt + ink)
  line((4.86, 1.78), (5.54, 2.50), stroke: 1.20pt + green, mark: (end: ">"))
  axis-label((5.72, 2.54), [$i dif vec(ell)$], placement: "west")
  line((5.18, 2.10), (6.18, 2.10), stroke: 1.05pt + blue, mark: (end: ">"))
  axis-label((6.30, 2.10), [$vec(B)$], placement: "west")
  line((5.18, 2.10), (4.52, 1.36), stroke: 1.10pt + red, mark: (end: ">"))
  axis-label((4.40, 1.30), [$dif vec(F)$], placement: "east")
  axis-label((5.46, 0.62), [$dif vec(F)=i dif vec(ell) times vec(B)$], placement: "north")

  line((7.40, 0.60), (7.40, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((7.86, 3.02), [$vec(F)_B dot vec(v)=0$], placement: "west")
  axis-label((7.86, 2.22), [lavoro magnetico nullo], placement: "west")
  axis-label((7.86, 1.42), [devia la traiettoria], placement: "west")
})))

== Dipolo magnetico e spira in campo esterno

#green-box([L'idea prima della formula])[
  Una *spira* è semplicemente un anello di filo percorso da corrente. Vista da lontano, una spira si comporta esattamente come una piccola calamita: ha un "nord" da un lato e un "sud" dall'altro. Questo oggetto si chiama *dipolo magnetico*. L'immagine mentale: l'ago di una bussola è di fatto un dipolo magnetico, e infatti dentro una bussola e dentro una spira di corrente succede la stessa cosa quando le metti in un campo esterno: tendono a girare per allinearsi. Il "momento di dipolo" $vec(mu)$ è una freccia che riassume *quanto è forte* questa calamitina e *da che parte punta il suo nord*.
]

Una spira elementare percorsa da corrente si comporta come un *dipolo magnetico*. Il suo momento di dipolo magnetico è

#green-box([Momento di dipolo magnetico])[
  $ vec(mu) = i vec(S). $
]

Il vettore $vec(S)$ è perpendicolare al piano della spira e ha modulo pari all'area della spira; il verso si sceglie con la regola della mano destra rispetto al verso della corrente.

#yellow-box([Come si trova il verso di $vec(S)$ (e quindi di $vec(mu)$)])[
  Avvolgi la mano destra attorno alla spira con le dita che seguono il verso della corrente: il pollice indica il verso di $vec(S)$, cioè il "nord" del dipolo. Il modulo è $mu = i S$, quindi maggiore è la corrente o l'area della spira, più "forte" è la calamitina. Unità di misura: $[mu] = "A" dot "m"^2$.
]

Il momento $vec(mu)$ riassume l'effetto magnetico della spira: invece di seguire ogni tratto di filo, si descrive la spira come un piccolo dipolo magnetico.

In un campo magnetico esterno uniforme, i lati della spira paralleli al campo non subiscono forza. Gli altri lati subiscono forze opposte che formano una coppia: la spira ruota fino ad allineare $vec(mu)$ con $vec(B)$.

#blue-box([Coppia ed energia del dipolo magnetico])[
  $ vec(tau) = vec(mu) times vec(B), quad
    U = - vec(mu) dot vec(B). $
]

#yellow-box([Cosa raccontano queste due formule])[
  - $vec(tau) = vec(mu) times vec(B)$ è il *momento torcente* (la "coppia" che fa girare). È un prodotto vettoriale, quindi in modulo $tau = mu B sin theta$, con $theta$ angolo fra $vec(mu)$ e $vec(B)$. La coppia è massima quando la spira è "di taglio" rispetto al campo ($theta = 90°$) e si annulla quando $vec(mu)$ è già allineato a $vec(B)$ ($theta=0$): a quel punto non c'è più nulla da raddrizzare. È lo stesso motivo per cui l'ago della bussola, una volta puntato a nord, smette di girare.
  - $U = -vec(mu) dot vec(B)$ è l'*energia potenziale* del dipolo. Il prodotto scalare dà $U = -mu B cos theta$. Il segno meno è importante: l'energia è *minima* (quindi più "comoda", configurazione preferita) quando $vec(mu)$ punta come $vec(B)$ ($theta=0$, $cos theta = 1$, $U = -mu B$), ed è *massima* quando punta al contrario ($theta=180°$, $U = +mu B$). I sistemi in natura cercano sempre l'energia minima: ecco perché la spira ruota fino ad allinearsi.
]

L'equilibrio stabile si ha per $vec(mu)$ parallelo a $vec(B)$; l'equilibrio instabile per $vec(mu)$ antiparallelo a $vec(B)$.

#green-box([Il filo conduttore: ecco come funziona un motore elettrico])[
  Questo è il principio del motore elettrico. Una spira percorsa da corrente in un campo magnetico viene fatta girare dalla coppia $vec(tau)$. Se ogni mezzo giro si inverte il verso della corrente (lo fa un componente chiamato collettore), la spira continua a girare sempre nello stesso senso: l'energia elettrica è diventata movimento.
]

#align(center, graph-card([Spira e dipolo magnetico in campo esterno], cetz.canvas({
  import cetz.draw: *

  axis-label((1.68, 3.82), [dipolo magnetico], placement: "south")
  circle((1.48, 2.18), radius: (0.78, 0.32), stroke: 1.10pt + ink, fill: rgb("#f7f7f7"))
  for x in (1.12, 1.34, 1.56) {
    line((x, 1.90), (x + 0.30, 2.44), stroke: 0.48pt + rgb("#aeb5ba"))
  }
  circle((1.48, 2.18), radius: (0.78, 0.32), stroke: 1.10pt + ink, fill: none, mark: (end: ">"))
  line((1.48, 2.18), (1.48, 3.34), stroke: 1.15pt + green, mark: (end: ">"))
  axis-label((1.68, 3.30), [$vec(mu)$], placement: "west")
  axis-label((1.46, 1.62), [$vec(mu)=i vec(S)$], placement: "north")

  line((3.08, 0.58), (3.08, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.18, 3.82), [spira in $vec(B)$ uniforme], placement: "south")
  line((4.00, 1.72), (5.96, 1.72), stroke: 1.0pt + ink)
  line((4.00, 2.82), (5.96, 2.82), stroke: 1.0pt + ink)
  line((4.00, 1.72), (4.00, 2.82), stroke: 1.0pt + ink)
  line((5.96, 1.72), (5.96, 2.82), stroke: 1.0pt + ink)
  line((4.10, 2.82), (5.00, 2.82), stroke: 1.0pt + green, mark: (end: ">"))
  line((5.86, 1.72), (4.96, 1.72), stroke: 1.0pt + green, mark: (end: ">"))
  line((4.00, 2.20), (3.48, 1.58), stroke: 1.10pt + red, mark: (end: ">"))
  line((5.96, 2.34), (6.48, 2.96), stroke: 1.10pt + red, mark: (end: ">"))
  line((4.40, 1.22), (6.18, 1.22), stroke: 1.05pt + blue, mark: (end: ">"))
  axis-label((5.28, 0.94), [$vec(B)$], placement: "north")
  line((4.98, 2.22), (5.82, 3.06), stroke: 1.10pt + green, mark: (end: ">"))
  axis-label((5.92, 3.12), [$vec(mu)$], placement: "west")
  arc((4.94, 2.16), radius: 0.60, start: 210deg, stop: 320deg, stroke: 1.0pt + red, mark: (end: ">"))
  axis-label((4.74, 1.36), [$vec(tau)$], placement: "north")

  line((7.00, 0.58), (7.00, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((7.46, 3.18), [$vec(tau)=vec(mu) times vec(B)$], placement: "west")
  axis-label((7.46, 2.42), [$U=-vec(mu) dot vec(B)$], placement: "west")
  axis-label((7.46, 1.60), [stabile: $vec(mu) parallel vec(B)$], placement: "west")
  axis-label((7.46, 0.88), [instabile: versi opposti], placement: "west")
})))

== Confronto elettrostatica e magnetostatica

#green-box([L'idea prima della formula])[
  Mettiamo i due campi uno accanto all'altro, come due colonne di una tabella. Si scopre una bella simmetria con una differenza-chiave. Per il campo elettrico: le linee *nascono e muoiono* sulle cariche (sorgenti puntuali), ma il campo "non gira" (è conservativo, la sua circuitazione è nulla). Per il campo magnetico è l'opposto: le linee *non nascono mai* da nessun punto (flusso nullo, niente monopoli), ma il campo "gira" attorno alle correnti (circuitazione non nulla). In una frase: $vec(E)$ ha sorgenti ma non vortici; $vec(B)$ ha vortici ma non sorgenti.
]

In elettrostatica il campo elettrico è conservativo e le sorgenti sono le cariche. In magnetostatica, invece, le sorgenti sono le correnti: non ci sono monopoli magnetici e le linee di $vec(B)$ sono chiuse.

Quindi le equazioni si leggono a coppie: il flusso di $vec(E)$ misura carica racchiusa, mentre il flusso di $vec(B)$ è sempre nullo; la circuitazione di $vec(E)$ è nulla in elettrostatica, mentre quella di $vec(B)$ misura corrente concatenata.

#blue-box([La tabella di confronto da ricordare])[
  - *Flusso* (chiusura su una superficie): $integral_S vec(E) dot dif vec(S) = Q_"int"/epsilon_0$ (misura la carica racchiusa) contro $integral_S vec(B) dot dif vec(S) = 0$ (sempre nullo: niente cariche magnetiche).
  - *Circuitazione* (giro lungo una linea): $integral_Gamma vec(E) dot dif vec(ell) = 0$ ($vec(E)$ è conservativo) contro $integral_Gamma vec(B) dot dif vec(ell) = mu_0 i_"conc"$ (misura la corrente concatenata).
  - *Forza sulla carica*: $vec(F) = q vec(E)$ (parallela al campo, compie lavoro) contro $vec(F) = q vec(v) times vec(B)$ (perpendicolare, non compie lavoro).
]

#align(center, graph-card([Equazioni integrali utili: $vec(E)$ e $vec(B)$], cetz.canvas({
  import cetz.draw: *

  axis-label((1.90, 3.72), [elettrostatica], placement: "south")
  circle((1.18, 2.58), radius: 0.62, stroke: 1.0pt + ink, fill: rgb("#f7f7f7"))
  for p in ((0.98, 2.72), (1.22, 2.92), (1.42, 2.54), (1.10, 2.30)) {
    circle(p, radius: 0.04, fill: ink, stroke: none)
  }
  axis-label((1.18, 1.68), [$integral_S vec(E) dot dif vec(S)=Q_"int"/epsilon_0$], placement: "north")
  axis-label((1.18, 0.96), [$integral_Gamma vec(E) dot dif vec(ell)=0$], placement: "north")

  line((3.72, 0.62), (3.72, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.92, 3.72), [magnetostatica], placement: "south")
  circle((5.20, 2.52), radius: (0.72, 0.30), stroke: 1.10pt + blue, fill: none, mark: (end: ">"))
  line((5.20, 1.72), (5.20, 3.20), stroke: 1.10pt + ink, mark: (end: ">"))
  axis-label((5.42, 3.12), [$i_"conc"$], placement: "west")
  axis-label((5.18, 1.34), [$integral_Gamma vec(B) dot dif vec(ell)=mu_0 i_"conc"$], placement: "north")
  axis-label((5.18, 0.66), [$integral_S vec(B) dot dif vec(S)=0$], placement: "north")

  line((7.86, 0.62), (7.86, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((8.30, 3.02), [$vec(F)=q vec(E)$], placement: "west")
  axis-label((8.30, 2.22), [$vec(F)=q vec(v) times vec(B)$], placement: "west")
  axis-label((8.30, 1.42), [$dif vec(F)=i dif vec(ell) times vec(B)$], placement: "west")
})))

== Esempio: campo magnetico di un filo/cilindro indefinito

#green-box([L'idea prima della formula])[
  Questo è il caso più importante da saper fare a memoria: il campo attorno a un filo (o cilindro) percorso da corrente. La strategia è sempre la stessa del teorema di Gauss in elettrostatica, solo tradotta in linguaggio magnetico:
  + Guardo la *simmetria* e indovino come sono fatte le linee di $vec(B)$ (qui: cerchi attorno all'asse).
  + Scelgo una linea amperiana che *segue* quei cerchi, così su di essa $B$ ha sempre lo stesso modulo.
  + Calcolo la circuitazione (facile, perché $B$ è costante) e la eguaglio a $mu_0 i_"conc"$.
  + Ricavo $B$.
]

Consideriamo un cilindro indefinito di raggio $R$, percorso da corrente stazionaria lungo il suo asse. Per simmetria cilindrica le linee di $vec(B)$ sono circonferenze centrate sull'asse del cilindro e il modulo dipende solo dalla distanza $r$ dall'asse.

La scelta della linea amperiana è analoga alla scelta della superficie gaussiana: si sceglie una curva che segue la simmetria, così $B$ è costante lungo la curva e può uscire dall'integrale.

Scegliendo come linea amperiana una circonferenza di raggio $r$:

$ integral_Gamma vec(B) dot dif vec(ell) = B(r) 2 pi r = mu_0 i_"conc". $

#yellow-box([Perché l'integrale diventa $B(r) dot 2 pi r$])[
  Lungo la circonferenza, $vec(B)$ punta sempre nella stessa direzione del cammino $dif vec(ell)$ (entrambi tangenti al cerchio): quindi $vec(B) dot dif vec(ell) = B dif ell$, senza coseni che complicano. Inoltre $B$ ha lo stesso valore in ogni punto del cerchio (per simmetria), quindi esce dall'integrale come una costante. Resta $B integral_Gamma dif ell$, e $integral_Gamma dif ell$ è semplicemente la *lunghezza* del cerchio, cioè $2 pi r$. Ecco perché otteniamo $B(r) dot 2 pi r$. È lo stesso trucco con cui in Gauss l'area della sfera $4 pi r^2$ usciva dall'integrale.
]

Se la corrente è distribuita uniformemente nel volume, con densità $J$:

$ i = J pi R^2. $

#yellow-box([Da dove arriva $i = J pi R^2$])[
  $J$ è la *densità di corrente*: quanti ampere passano per ogni metro quadrato di sezione, misurata in $"A"/"m"^2$. Se la corrente è spalmata in modo uniforme sulla sezione del cilindro (un cerchio di area $pi R^2$), la corrente totale è densità $times$ area, cioè $i = J pi R^2$. È come dire: se ogni mattonella porta lo stesso numero di persone, il totale è (persone per mattonella) $times$ (numero di mattonelle).
]

Per $r > R$ la corrente concatenata è tutta la corrente $i$, quindi

$ B(r)=mu_0 i/(2 pi r). $

#yellow-box([Il passaggio: da $B(r) 2 pi r = mu_0 i$ a $B(r)$])[
  Fuori dal cilindro ($r>R$) la circonferenza amperiana racchiude *tutta* la corrente, quindi $i_"conc" = i$. Dall'uguaglianza $B(r) dot 2 pi r = mu_0 i$ basta dividere entrambi i membri per $2 pi r$ e si ottiene $B(r) = mu_0 i / (2 pi r)$. Nota che da fuori il cilindro produce lo stesso campo di un filo sottile: il campo diminuisce come $1/r$ man mano che ci si allontana.
]

Per $r < R$ è concatenata solo la corrente dentro il cerchio di raggio $r$:

$ i_"conc" = J pi r^2, quad
  B(r)=mu_0 J r / 2 = mu_0 i r/(2 pi R^2). $

#yellow-box([Cosa cambia dentro il cilindro ($r<R$)])[
  Stavolta la circonferenza di raggio $r$ è *dentro* il materiale: non racchiude tutta la corrente, ma solo quella che passa nel cerchietto interno di raggio $r$, cioè $i_"conc" = J pi r^2$. Sostituendo in $B(r) dot 2 pi r = mu_0 J pi r^2$ e dividendo per $2 pi r$ si semplifica una $r$:
  $ B(r) = (mu_0 J pi r^2)/(2 pi r) = (mu_0 J r)/2. $
  Infine, usando $J = i/(pi R^2)$, si riscrive come $B(r) = mu_0 i r/(2 pi R^2)$. Risultato: *dentro* il campo cresce linearmente con $r$ (parte da $0$ sull'asse), *fuori* decresce come $1/r$. Il massimo è proprio sulla superficie, a $r=R$.
]

#align(center, graph-card([Ampère su un cilindro indefinito: corrente volumica], cetz.canvas({
  import cetz.draw: *

  axis-label((1.68, 3.78), [cilindro indefinito], placement: "south")
  line((1.12, 0.72), (1.12, 3.10), stroke: 1.10pt + ink)
  line((2.10, 0.72), (2.10, 3.10), stroke: 1.10pt + ink)
  circle((1.61, 2.22), radius: (0.48, 0.18), stroke: 1.05pt + ink, fill: rgb("#edf8ef"))
  line((1.61, 2.22), (2.04, 2.22), stroke: 0.85pt + ink, mark: (start: "|", end: "|"))
  axis-label((1.86, 2.50), [$R$], placement: "south")
  for x in (1.32, 1.58, 1.84) {
    line((x, 2.04), (x, 2.64), stroke: 1.0pt + green, mark: (end: ">"))
  }
  axis-label((1.62, 3.30), [$i$], placement: "south")
  axis-label((1.62, 0.34), [corrente volumica $J$], placement: "north")

  line((3.06, 0.62), (3.06, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.02, 3.78), [linea amperiana], placement: "south")
  circle((4.98, 2.20), radius: (1.06, 0.44), stroke: 1.15pt + ink, fill: none, mark: (end: ">"))
  line((4.98, 2.20), (5.82, 2.20), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((5.42, 2.48), [$r$], placement: "south")
  line((4.98, 1.20), (4.98, 3.08), stroke: 1.05pt + ink)
  line((4.74, 1.72), (5.22, 1.72), stroke: 1.05pt + ink)
  line((4.74, 2.70), (5.22, 2.70), stroke: 1.05pt + ink)
  axis-label((6.26, 2.20), [$B(r) 2 pi r = mu_0 i_"conc"$], placement: "west")

  line((7.18, 0.62), (7.18, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  line((7.72, 0.92), (10.22, 0.92), stroke: 0.9pt + ink, mark: (end: ">"))
  line((7.72, 0.92), (7.72, 3.42), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((10.34, 0.84), [$r$], placement: "north")
  axis-label((7.48, 3.42), [$abs(B)$], placement: "east")
  line((7.72, 0.92), (8.86, 2.96), stroke: 1.20pt + blue)
  catmull((8.86, 2.96), (9.18, 2.26), (9.66, 1.72), (10.16, 1.42), stroke: 1.20pt + blue)
  line((8.86, 0.92), (8.86, 3.12), stroke: (paint: ink, thickness: 0.75pt, dash: "dashed"))
  axis-label((8.86, 0.66), [$R$], placement: "north")
  axis-label((8.20, 2.12), [~ $r$], placement: "west")
  axis-label((9.82, 2.08), [~ $1/r$], placement: "west")
})))

#purple-box([Esempio numerico: campo attorno a un filo])[
  Un filo conduttore lungo è percorso da $i = 10 " A"$. Quanto vale $B$ a $r = 5 " cm" = 0,05 " m"$ dal filo?
  $ B = (mu_0 i)/(2 pi r) = ((4 pi dot 10^(-7)) dot 10)/(2 pi dot 0,05). $
  Semplifichiamo $pi$ sopra e sotto: $B = (4 dot 10^(-7) dot 10)/(2 dot 0,05) = (4 dot 10^(-6))/(0,1) = 4 dot 10^(-5) " T"$.
  Cioè $B = 0,04 " mT"$ (millitesla). Per confronto, il campo magnetico terrestre è circa $5 dot 10^(-5) " T"$: il nostro filo, a $5$ cm, produce un campo dello stesso ordine di grandezza di quello terrestre. Ecco perché un filo con corrente fa muovere visibilmente l'ago di una bussola vicina, proprio come nell'esperienza di Oersted.
]

Se invece la corrente scorre solo sulla superficie cilindrica, per $r<R$ non c'è corrente concatenata e il campo interno è nullo:

$ B(r)=0 quad (r<R). $

#yellow-box([Perché stavolta dentro il campo è zero])[
  Se la corrente è tutta sulla buccia esterna del cilindro, una circonferenza amperiana interna ($r<R$) *non racchiude alcuna corrente*: $i_"conc" = 0$. Quindi $B(r) dot 2 pi r = 0$, da cui $B = 0$ ovunque all'interno. È l'analogo magnetico del fatto che dentro un conduttore cavo carico il campo elettrico è nullo: ciò che conta è solo quanta corrente (o carica) sta *dentro* la curva, non quella sulla superficie esterna.
]

Per $r>R$ la linea amperiana concatena tutta la corrente:

$ B(r)=mu_0 i/(2 pi r). $

#align(center, graph-card([Corrente superficiale su cilindro: campo interno nullo], cetz.canvas({
  import cetz.draw: *

  axis-label((1.64, 3.48), [corrente solo sulla superficie], placement: "south")
  line((0.88, 1.18), (0.88, 2.96), stroke: 1.10pt + ink)
  line((2.10, 1.18), (2.10, 2.96), stroke: 1.10pt + ink)
  circle((1.49, 2.08), radius: (0.62, 0.22), stroke: 1.05pt + ink, fill: none)
  line((0.88, 2.20), (0.88, 2.86), stroke: 1.0pt + green, mark: (end: ">"))
  line((2.10, 2.20), (2.10, 2.86), stroke: 1.0pt + green, mark: (end: ">"))
  axis-label((1.48, 1.38), [$B=0$ interno], placement: "north")

  line((3.18, 0.64), (3.18, 3.64), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((3.68, 2.82), [$r<R:$], placement: "west")
  axis-label((4.72, 2.82), [$i_"conc"=0$], placement: "west")
  axis-label((4.72, 2.22), [$B=0$], placement: "west")
  axis-label((3.68, 1.42), [$r>R:$], placement: "west")
  axis-label((4.72, 1.42), [$B=mu_0 i/(2 pi r)$], placement: "west")

  line((7.00, 0.64), (7.00, 3.64), stroke: 0.55pt + rgb("#ccd4d8"))

  line((7.48, 0.92), (10.00, 0.92), stroke: 0.9pt + ink, mark: (end: ">"))
  line((7.48, 0.92), (7.48, 3.16), stroke: 0.9pt + ink, mark: (end: ">"))
  line((7.48, 0.92), (8.50, 0.92), stroke: 1.2pt + blue)
  line((8.50, 2.72), (8.50, 0.92), stroke: 1.2pt + blue)
  catmull((8.50, 2.72), (8.86, 2.10), (9.34, 1.60), (9.92, 1.30), stroke: 1.2pt + blue)
  axis-label((8.50, 0.66), [$R$], placement: "north")
  axis-label((9.36, 2.26), [~ $1/r$], placement: "west")
})))

== Solenoide toroidale e solenoide rettilineo

#green-box([L'idea prima della formula])[
  Un *solenoide* è un filo avvolto a molla, tante spire una dopo l'altra. Ogni spira è una piccola calamita: messe in fila, i loro campi si sommano e all'interno del solenoide si crea un campo magnetico forte e uniforme, mentre fuori quasi si annulla. È il modo pratico di costruire una calamita "a comando" (elettromagnete). Il *toroide* è la stessa idea ma con il solenoide chiuso ad anello, come una ciambella: in questo modo il campo resta intrappolato dentro la ciambella e fuori è praticamente nullo.
]

In un solenoide toroidale le spire sono avvolte attorno a una corona. Usando una circonferenza amperiana coassiale al toroide:

$ B(r) 2 pi r = mu_0 N i. $

Ogni spira attraversa la superficie delimitata dalla linea amperiana: per questo la corrente concatenata totale è $N i$.

#yellow-box([Perché compare $N i$ e non solo $i$])[
  $N$ è il numero totale di spire. La circonferenza amperiana, fatta dentro la ciambella, viene "bucata" da *ogni* spira: ognuna porta la corrente $i$, e ce ne sono $N$. Quindi la corrente concatenata totale è $N times i = N i$. È come contare quante volte il filo attraversa la superficie appoggiata sulla curva: ogni attraversamento aggiunge una $i$.
]

Nel materiale attraversato dalle spire, cioè per $R<r<R+ell$:

#blue-box([Campo nel solenoide toroidale])[
  $ B(r)= (mu_0 N i)/(2 pi r). $
]

Nel foro interno $r<R$ e all'esterno $r>R+ell$ la corrente concatenata complessiva è nulla, quindi idealmente $B=0$.

Per un solenoide rettilineo lungo, lontano dai bordi, il campo è quasi uniforme all'interno e quasi nullo all'esterno:

#blue-box([Campo nel solenoide rettilineo lungo])[
  $ B_"int" = mu_0 n i, quad B_"est" approx 0. $
]

Qui $n=N/L$ è il numero di spire per unità di lunghezza.

#yellow-box([Significato di $n$ e perché il campo non dipende dal raggio])[
  $n = N/L$ si misura in $"spire"/"m"$, cioè quanto sono "fitte" le spire. La formula $B_"int" = mu_0 n i$ dice una cosa notevole: dentro un solenoide lungo, il campo dipende solo da *quanto fitte* sono le spire e dalla corrente, *non* dalla distanza dall'asse né dal diametro. Il campo è uniforme: stesso valore in ogni punto interno. Più spire per metro o più corrente $arrow$ campo più forte.
]

#purple-box([Esempio numerico: campo dentro un solenoide])[
  Un solenoide lungo $L = 0,3 " m"$ ha $N = 600$ spire e porta corrente $i = 2 " A"$. Quanto vale il campo all'interno?
  Prima la densità di spire: $n = N/L = 600/0,3 = 2000 " spire/m"$. Poi:
  $ B_"int" = mu_0 n i = (4 pi dot 10^(-7)) dot 2000 dot 2 approx 1,26 dot 10^(-6) dot 2000 dot 2 approx 5,0 dot 10^(-3) " T". $
  Cioè $B approx 5 " mT"$, circa $100$ volte il campo terrestre. Per fare un campo più forte: avvolgi più spire fitte, o aumenta la corrente.
]

#align(center, graph-card([Solenoide toroidale e solenoide rettilineo], cetz.canvas({
  import cetz.draw: *

  axis-label((2.46, 3.82), [solenoide toroidale], placement: "south")
  circle((2.28, 2.18), radius: 1.18, stroke: 1.10pt + ink, fill: none)
  circle((2.28, 2.18), radius: 0.58, stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"), fill: none)
  circle((2.28, 2.18), radius: 1.64, stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"), fill: none)
  for a in (30deg, 70deg, 110deg, 150deg) {
    line((2.28 + calc.cos(a) * 0.86, 2.18 + calc.sin(a) * 0.86), (2.28 + calc.cos(a) * 1.42, 2.18 + calc.sin(a) * 1.42), stroke: 1.05pt + green, mark: (end: ">"))
  }
  line((2.28, 2.18), (3.34, 2.18), stroke: 0.95pt + ink, mark: (end: ">"))
  axis-label((2.92, 2.46), [$r$], placement: "south")
  axis-label((2.28, 0.64), [$R<r<R+ell$], placement: "north")

  line((4.82, 0.62), (4.82, 3.92), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((6.18, 3.82), [andamento], placement: "south")
  line((5.28, 0.92), (7.62, 0.92), stroke: 0.9pt + ink, mark: (end: ">"))
  line((5.28, 0.92), (5.28, 3.20), stroke: 0.9pt + ink, mark: (end: ">"))
  line((5.90, 0.92), (5.90, 2.90), stroke: 1.1pt + blue)
  catmull((5.90, 2.90), (6.18, 2.42), (6.62, 2.10), (6.94, 1.92), stroke: 1.1pt + blue)
  line((6.94, 1.92), (6.94, 0.92), stroke: 1.1pt + blue)
  axis-label((5.90, 0.66), [$R$], placement: "north")
  axis-label((6.94, 0.66), [$R+ell$], placement: "north")
  axis-label((6.48, 2.58), [~ $1/r$], placement: "west")

  line((8.10, 0.62), (8.10, 3.92), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((9.46, 3.82), [solenoide rettilineo], placement: "south")
  line((8.88, 1.02), (8.88, 3.18), stroke: 1.05pt + ink)
  line((10.00, 1.02), (10.00, 3.18), stroke: 1.05pt + ink)
  for y in (1.28, 1.64, 2.00, 2.36, 2.72, 3.08) {
    circle((9.44, y), radius: (0.56, 0.15), stroke: 1.0pt + ink, fill: none)
  }
  line((9.44, 1.20), (9.44, 3.00), stroke: 1.15pt + blue, mark: (end: ">"))
  axis-label((9.74, 2.14), [$B_"int"$], placement: "west")
  axis-label((10.30, 2.76), [$B_"est" approx 0$], placement: "west")
  axis-label((9.44, 0.62), [$B_"int"=mu_0 n i$], placement: "north")
})))

== Azione meccanica tra fili percorsi da corrente

#green-box([L'idea prima della formula])[
  Due fili vicini, entrambi percorsi da corrente, si sentono a vicenda. Il meccanismo è in due passi, mettendo insieme due cose che già sappiamo: (1) il primo filo *crea* un campo magnetico attorno a sé (Oersted); (2) il secondo filo, trovandosi immerso in quel campo, *subisce una forza* (forza su un filo). Risultato: i due fili si spingono o si tirano. Curiosità storica: proprio questa forza è stata usata fino al 2019 per *definire* l'ampere.
]

Due fili rettilinei paralleli percorsi da corrente esercitano forze magnetiche reciproche. Il primo filo genera, alla distanza $d$, un campo

$ B_1(d)=mu_0 i_1/(2 pi d). $

Il secondo filo, percorso da corrente $i_2$, subisce la forza magnetica

$ dif vec(F) = i_2 dif vec(ell) times vec(B)_1. $

Per unità di lunghezza:

#green-box([Forza per unità di lunghezza tra fili paralleli])[
  $ F/ell = (mu_0 i_1 i_2)/(2 pi d). $
]

#yellow-box([Come si arriva alla formula finale])[
  Mettiamo insieme i due pezzi. Il campo del primo filo a distanza $d$ è $B_1 = mu_0 i_1/(2 pi d)$. La forza sul secondo filo (perpendicolare a $vec(B)_1$) in modulo per unità di lunghezza è $F/ell = i_2 B_1$. Sostituendo $B_1$:
  $ F/ell = i_2 dot (mu_0 i_1)/(2 pi d) = (mu_0 i_1 i_2)/(2 pi d). $
  La forza cresce con il prodotto delle due correnti e diminuisce con la distanza $d$ (come $1/d$).
]

Correnti nello stesso verso si attraggono; correnti in verso opposto si respingono.

#red-box([Attenzione: è il contrario delle cariche])[
  Occhio a non confondere con l'elettrostatica! Per le *cariche* vale "uguali si respingono, opposte si attraggono". Per le *correnti parallele* è il contrario: correnti nello *stesso* verso si *attraggono*, correnti in verso opposto si respingono. Conviene ricordarselo come un'eccezione da non scambiare con la regola elettrica.
]

#purple-box([Esempio numerico: forza tra due fili])[
  Due fili paralleli distano $d = 2 " cm" = 0,02 " m"$ e portano $i_1 = i_2 = 5 " A"$ nello stesso verso. La forza per metro di filo è:
  $ F/ell = (mu_0 i_1 i_2)/(2 pi d) = ((4 pi dot 10^(-7)) dot 5 dot 5)/(2 pi dot 0,02). $
  Semplifico $pi$: $F/ell = (4 dot 10^(-7) dot 25)/(2 dot 0,02) = (10^(-5))/(0,04) = 2,5 dot 10^(-4) " N/m"$.
  È una forza piccola ($0,25$ millinewton per ogni metro), ed è *attrattiva* perché le correnti hanno lo stesso verso: i due fili tendono ad avvicinarsi.
]

#align(center, graph-card([Forza magnetica tra due fili paralleli], cetz.canvas({
  import cetz.draw: *

  axis-label((2.48, 3.82), [due fili paralleli], placement: "south")
  line((1.28, 0.72), (1.28, 3.24), stroke: 1.20pt + ink, mark: (end: ">"))
  line((3.70, 0.72), (3.70, 3.24), stroke: 1.20pt + ink, mark: (end: ">"))
  axis-label((1.08, 3.12), [$i_1$], placement: "east")
  axis-label((3.90, 3.12), [$i_2$], placement: "west")
  line((1.28, 3.50), (3.70, 3.50), stroke: 0.9pt + ink, mark: (start: "|", end: "|"))
  axis-label((2.48, 3.74), [$d$], placement: "south")
  circle((1.28, 1.60), radius: (0.70, 0.28), stroke: 1.0pt + blue, fill: none, mark: (end: ">"))
  circle((3.70, 1.40), radius: (0.70, 0.28), stroke: 1.0pt + blue, fill: none, mark: (end: ">"))
  line((3.70, 2.20), (2.90, 2.20), stroke: 1.15pt + red, mark: (end: ">"))
  line((1.28, 2.20), (2.08, 2.20), stroke: 1.15pt + red, mark: (end: ">"))
  axis-label((2.48, 1.78), [stesso verso: attrazione], placement: "north")

  line((5.12, 0.62), (5.12, 3.90), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.58, 2.92), [$B_1(d)=mu_0 i_1/(2 pi d)$], placement: "west")
  axis-label((5.58, 2.14), [$F/ell=i_2 B_1(d)$], placement: "west")
  axis-label((5.58, 1.36), [$F/ell=mu_0 i_1 i_2/(2 pi d)$], placement: "west")
})))

== Induzione elettromagnetica

#green-box([L'idea prima della formula])[
  Fin qui: la corrente fa il campo magnetico. Ora arriva il colpo di scena, scoperto da Faraday: *anche il magnetismo può fare elettricità*, ma a una condizione precisa: il campo deve *cambiare*. Se avvicini o allontani una calamita da una spira, nella spira *si accende una corrente*, anche se non c'è nessuna pila. Se lasci la calamita ferma, niente. È la base di tutto: dinamo, alternatori, le centrali elettriche, i caricabatterie wireless. Tutta l'elettricità che usi a casa nasce da un magnete che gira vicino a delle bobine. La parola chiave è *variazione*: conta il cambiamento, non il valore.
]

Finora abbiamo visto che una corrente genera un campo magnetico e che un campo magnetico esercita forze su cariche in moto. L'osservazione sperimentale successiva è che un campo magnetico variabile, oppure un circuito che si muove in un campo magnetico, può generare una F.E.M. e quindi una corrente indotta.

#yellow-box([Cos'è la "F.E.M."])[
  F.E.M. sta per *forza elettromotrice*. Nonostante il nome, non è una forza: è una *tensione* (si misura in volt) che spinge le cariche lungo il circuito, come farebbe una pila. È, in pratica, la "pila virtuale" che l'induzione accende dentro il circuito. La indichiamo con $cal(E)$.
]

Il fenomeno si descrive con il *flusso magnetico* attraverso una superficie $S$:

#blue-box([Flusso magnetico])[
  $ Phi_B = integral_S vec(B) dot dif vec(S). $
]

#yellow-box([Cos'è il flusso, in parole semplici])[
  Il flusso $Phi_B$ misura *quante linee di campo passano attraverso la superficie* delimitata dal circuito. Immagina la spira come una racchetta da tennis e le linee di $vec(B)$ come pioggia che cade: il flusso è quanta pioggia passa attraverso la racchetta. Se la tieni di faccia alla pioggia (superficie perpendicolare al campo), il flusso è massimo; se la giri di taglio, la pioggia ci scivola accanto e il flusso è zero. Il prodotto scalare $vec(B) dot dif vec(S)$ tiene conto proprio di questa inclinazione. Unità di misura: il weber, $1 " Wb" = 1 " T" dot "m"^2$.
]

Non è il valore del flusso in sé a produrre corrente, ma la sua variazione nel tempo.

Per un campo uniforme perpendicolare alla superficie, $Phi_B = B S$. In generale il flusso cambia se cambia il campo $vec(B)$, se cambia l'area della superficie, oppure se cambia l'orientazione della superficie rispetto al campo.

#green-box([Tre modi per far cambiare il flusso (e quindi indurre corrente)])[
  + *Cambio il campo*: avvicino/allontano una calamita, o accendo/spengo una corrente vicina. $arrow$ varia $B$.
  + *Cambio l'area*: allargo o restringo il circuito (è il caso della barretta mobile più avanti). $arrow$ varia $S$.
  + *Cambio l'orientazione*: faccio ruotare la spira nel campo (è il principio dell'alternatore). $arrow$ varia l'angolo.
  In tutti e tre i casi cambia $Phi_B$, e quindi nasce una F.E.M.
]

La legge di Faraday-Lenz afferma che una variazione del flusso magnetico genera una F.E.M. indotta:

#green-box([Legge di Faraday-Lenz])[
  $ cal(E)_"ind" = - (dif Phi_B)/(dif t). $
]

#yellow-box([Come leggere la formula pezzo per pezzo])[
  - $(dif Phi_B)/(dif t)$ è la *rapidità con cui cambia il flusso*. Se il flusso cambia in fretta, la F.E.M. è grande; se cambia piano, è piccola; se non cambia, è zero. È questo il cuore del fenomeno.
  - Il *segno meno* è la legge di Lenz (vedi sotto): dice solo in quale *verso* va la corrente indotta. Sul *modulo* della F.E.M. non incide: in modulo $|cal(E)_"ind"| = |dif Phi_B / dif t|$.
]

Il segno meno è la *legge di Lenz*: la corrente indotta ha verso tale da opporsi alla variazione di flusso che l'ha generata. Se il flusso aumenta, il campo indotto tende a ridurlo; se il flusso diminuisce, il campo indotto tende a mantenerlo.

#green-box([Perché c'è il segno meno: la legge di Lenz spiegata bene])[
  La natura è "pigra e conservatrice": reagisce sempre per *opporsi* al cambiamento. Se avvicini il polo nord di una calamita alla spira, il flusso aumenta; la spira reagisce facendo nascere una corrente che crea un campo *opposto*, cioè mostra alla calamita la sua "faccia nord" per respingerla. Se invece allontani la calamita, il flusso cala e la corrente gira al contrario, per *trattenere* la calamita (le mostra la faccia sud, che la attira). Morale: la corrente indotta lavora sempre *contro* chi ha causato la variazione. Il segno meno è la traduzione matematica di questo "no, fermati".
]

#red-box([Attenzione: cosa NON dice Lenz])[
  La corrente indotta non si oppone al *flusso*, ma alla sua *variazione*. Se il flusso è grande ma costante, non succede nulla (nessuna corrente). È un errore comune pensare "tanto flusso = tanta corrente": no, è "tanto *cambiamento* di flusso = tanta corrente".
]

Questa opposizione non è una regola arbitraria: esprime la conservazione dell'energia. Se la corrente indotta aiutasse la variazione, il sistema amplificherebbe spontaneamente il moto o il campo.

#yellow-box([Perché Lenz è davvero conservazione dell'energia])[
  Immagina che la corrente indotta *aiutasse* il movimento della calamita invece di ostacolarlo: la calamita verrebbe risucchiata sempre più veloce, generando sempre più corrente, generando sempre più spinta... avresti energia gratis e infinita dal nulla. Impossibile. Per questo la natura sceglie l'opposizione: devi *fare fatica* (spendere energia meccanica) per muovere la calamita, e quella fatica è esattamente l'energia elettrica che ottieni. È un baratto onesto, non un pasto gratis.
]

#purple-box([Esempio numerico: spira e campo che cambia])[
  Una spira quadrata di lato $0,1 " m"$ (area $S = 0,01 " m"^2$) è immersa in un campo perpendicolare che cresce uniformemente da $0,2 " T"$ a $0,6 " T"$ in $0,5 " s"$. Quanto vale la F.E.M. indotta?
  La variazione di flusso: $Delta Phi_B = S dot Delta B = 0,01 dot (0,6 - 0,2) = 0,01 dot 0,4 = 4 dot 10^(-3) " Wb"$.
  In modulo:
  $ |cal(E)_"ind"| = (Delta Phi_B)/(Delta t) = (4 dot 10^(-3))/(0,5) = 8 dot 10^(-3) " V" = 8 " mV". $
  Se la spira ha resistenza $R = 2 " ohm"$, la corrente indotta è $i = cal(E)\/R = 8 dot 10^(-3) \/ 2 = 4 " mA"$.
]

#align(center, graph-card([Induzione: variazione del flusso magnetico], cetz.canvas({
  import cetz.draw: *

  axis-label((1.50, 3.72), [campo variabile], placement: "south")
  rect((0.64, 1.30), (2.36, 2.38), stroke: 1.05pt + ink, fill: rgb("#fbfcfd"))
  for x in (0.95, 1.35, 1.75, 2.15) {
    line((x, 1.42), (x, 2.26), stroke: 1.05pt + blue, mark: (end: ">"))
  }
  axis-label((1.50, 2.72), [$B(t)$], placement: "south")
  axis-label((1.50, 0.82), [$dif Phi_B/dif t != 0$], placement: "north")

  line((3.04, 0.64), (3.04, 3.88), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((4.68, 3.72), [area variabile], placement: "south")
  rect((3.74, 1.40), (5.20, 2.30), stroke: 1.05pt + ink, fill: rgb("#fbfcfd"))
  rect((4.12, 1.18), (5.90, 2.52), stroke: 0.90pt + ink, fill: none)
  line((5.26, 1.84), (5.88, 1.84), stroke: 1.05pt + green, mark: (end: ">"))
  axis-label((4.74, 0.82), [$S(t)$ cambia], placement: "north")

  line((6.44, 0.64), (6.44, 3.88), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((8.34, 3.72), [orientazione variabile], placement: "south")
  line((7.28, 1.22), (8.62, 1.72), stroke: 1.05pt + ink)
  line((8.62, 1.72), (9.42, 2.52), stroke: 1.05pt + ink)
  line((9.42, 2.52), (8.02, 2.02), stroke: 1.05pt + ink)
  line((8.02, 2.02), (7.28, 1.22), stroke: 1.05pt + ink)
  for y in (1.36, 1.74, 2.12) {
    line((7.00, y), (9.58, y), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  line((8.34, 1.86), (8.34, 2.82), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((8.50, 2.78), [$hat(n)$], placement: "west")
  axis-label((8.34, 0.82), [$vec(B) dot dif vec(S)$ cambia], placement: "north")
})))

== Esempio: circuito mobile di Faraday

#green-box([L'idea prima della formula])[
  Questo è l'esperimento "da manuale" dell'induzione, e mostra il caso in cui *cambia l'area*. Immagina due binari paralleli, su cui scorre una barretta metallica, come un cancello scorrevole. Tutto è immerso in un campo magnetico. Mentre la barretta scivola, l'area racchiusa dal circuito (binari + barretta + resistore) cresce o diminuisce: il flusso cambia, e quindi nasce una corrente. La cosa elegante è che si può tracciare tutto il bilancio energetico: la fatica che fai per spingere la barretta diventa, esattamente, calore nel resistore.
]

Consideriamo una barretta conduttrice di lunghezza $a$ che scorre con velocità $v$ su due guide conduttrici, chiuse da un resistore $R$, in un campo magnetico uniforme perpendicolare al circuito.

Se la posizione della barretta è $x(t)$, l'area del circuito è $S=a x$, quindi

$ Phi_B = B a x. $

Qui l'induzione nasce dal moto: il campo $B$ è costante, ma cambia l'area del circuito e quindi cambia il flusso.

La F.E.M. indotta vale

$ cal(E)_"ind" = - (dif Phi_B)/(dif t) = - B a v. $

#yellow-box([Il passaggio: come si deriva $Phi_B = B a x$])[
  Faraday dice di derivare il flusso rispetto al tempo. Qui $B$ e $a$ sono *costanti*: l'unica cosa che cambia nel tempo è la posizione $x(t)$ della barretta. Quindi:
  $ (dif Phi_B)/(dif t) = (dif)/(dif t)(B a x) = B a (dif x)/(dif t) = B a v. $
  L'ultimo passaggio usa $(dif x)/(dif t) = v$, cioè la velocità è la derivata della posizione. Mettendo il segno meno di Faraday: $cal(E)_"ind" = -B a v$. Il segno meno dice solo il verso; in modulo la F.E.M. vale $B a v$.
]

In modulo la corrente indotta è

#yellow-box([Corrente indotta nella barretta mobile])[
  $ i_"ind" = (B a v)/R. $
]

#yellow-box([Da $cal(E)$ a $i$: la solita legge di Ohm])[
  Una volta che conosciamo la F.E.M., la corrente nel circuito si trova con la legge di Ohm $i = cal(E)\/R$. In modulo: $i_"ind" = (B a v)/R$. È esattamente come se la barretta fosse una pila di tensione $B a v$ collegata al resistore $R$.
]

La forza magnetica sulla barretta è opposta al moto: agisce come un attrito elettromagnetico. In modulo

$ F = i a B = (B^2 a^2/R) v. $

#yellow-box([Da dove esce questa forza e perché frena])[
  Ora la barretta è percorsa dalla corrente $i_"ind"$ ed è immersa nel campo $B$: quindi subisce la forza su un filo $F = i_"ind" a B$ (la solita $i L B$, con $L = a$). Per la legge di Lenz, questa forza è *opposta al moto*: si comporta come un freno. Sostituendo $i_"ind" = (B a v)/R$:
  $ F = (B a v)/R dot a B = (B^2 a^2)/R v. $
  Più veloce vai, più forte freni: per questo se lasci la barretta libera, rallenta e si ferma. È lo stesso principio dei *freni magnetici* di treni e montagne russe.
]

Se si vuole mantenere la velocità costante, una forza esterna deve fornire la potenza meccanica

$ P_"mecc" = F v = (B^2 a^2 v^2)/R. $

Questa potenza coincide con la potenza dissipata per effetto Joule:

$ P_"Joule" = R i_"ind"^2 = (B^2 a^2 v^2)/R. $

#green-box([Il bilancio energetico torna: niente energia gratis])[
  Per tenere la barretta a velocità costante devi spingere con forza $F$, fornendo la potenza meccanica $P_"mecc" = F v = (B^2 a^2 v^2)/R$. Dall'altra parte, la corrente che scorre nel resistore lo scalda per effetto Joule, dissipando $P_"Joule" = R i_"ind"^2 = R ((B a v)/R)^2 = (B^2 a^2 v^2)/R$. *Sono identiche*: ogni joule di lavoro meccanico che spendi spingendo diventa un joule di calore nel resistore. È la conservazione dell'energia in azione, e conferma perché Lenz deve avere quel segno meno.
]

#purple-box([Esempio numerico: la barretta mobile])[
  Dati: $B = 0,5 " T"$, lunghezza barretta $a = 0,4 " m"$, velocità $v = 3 " m/s"$, resistenza $R = 2 " ohm"$.
  - F.E.M.: $|cal(E)| = B a v = 0,5 dot 0,4 dot 3 = 0,6 " V"$.
  - Corrente: $i = cal(E)\/R = 0,6 \/ 2 = 0,3 " A"$.
  - Forza frenante: $F = i a B = 0,3 dot 0,4 dot 0,5 = 0,06 " N"$.
  - Potenza: $P = F v = 0,06 dot 3 = 0,18 " W"$. Verifica con Joule: $R i^2 = 2 dot 0,3^2 = 2 dot 0,09 = 0,18 " W"$. Coincidono, come deve essere.
]

#align(center, graph-card([Circuito mobile di Faraday], cetz.canvas({
  import cetz.draw: *

  axis-label((2.38, 3.74), [barretta mobile], placement: "south")
  line((0.58, 2.80), (4.18, 2.80), stroke: 1.15pt + ink)
  line((0.58, 1.20), (4.18, 1.20), stroke: 1.15pt + ink)
  line((0.58, 1.20), (0.58, 2.80), stroke: 1.15pt + ink)
  // resistore a sinistra
  line((0.58, 2.20), (0.36, 2.04), stroke: 1.0pt + ink)
  line((0.36, 2.04), (0.80, 1.84), stroke: 1.0pt + ink)
  line((0.80, 1.84), (0.36, 1.64), stroke: 1.0pt + ink)
  line((0.36, 1.64), (0.58, 1.48), stroke: 1.0pt + ink)
  axis-label((0.18, 1.86), [$R$], placement: "east")
  // barretta
  line((3.10, 1.12), (3.10, 2.88), stroke: 2.0pt + ink)
  line((3.10, 2.00), (4.00, 2.00), stroke: 1.15pt + green, mark: (end: ">"))
  axis-label((4.12, 2.00), [$v$], placement: "west")
  line((0.58, 0.78), (3.10, 0.78), stroke: 0.9pt + ink, mark: (start: "|", end: "|"))
  axis-label((1.84, 0.54), [$x$], placement: "north")
  line((3.34, 1.20), (3.34, 2.80), stroke: 0.9pt + ink, mark: (start: "|", end: "|"))
  axis-label((3.56, 2.00), [$a$], placement: "west")
  for p in ((1.20, 1.64), (1.82, 2.16), (2.42, 1.58), (2.80, 2.34)) {
    circle(p, radius: 0.06, stroke: 1.0pt + blue, fill: none)
  }
  axis-label((2.22, 3.18), [$vec(B)$ uscente], placement: "south")
  line((3.10, 2.42), (2.58, 2.42), stroke: 1.15pt + red, mark: (end: ">"))
  axis-label((2.48, 2.42), [$vec(F)$], placement: "east")
  arc((1.58, 1.98), radius: 0.42, start: 40deg, stop: 300deg, stroke: 1.0pt + green, mark: (end: ">"))
  axis-label((1.38, 1.40), [$i_"ind"$], placement: "north")

  line((4.74, 0.62), (4.74, 3.86), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.20, 3.16), [$Phi_B=B a x$], placement: "west")
  axis-label((5.20, 2.42), [$cal(E)_"ind"=-B a v$], placement: "west")
  axis-label((5.20, 1.68), [$i_"ind"=B a v/R$], placement: "west")
  axis-label((5.20, 0.94), [$F=(B^2 a^2/R)v$], placement: "west")
})))

== Autoflusso, induttanza e autoinduzione

#green-box([L'idea prima della formula])[
  Fin qui l'induzione era causata da un campo "esterno". Ma c'è un caso più sottile: un circuito *induce qualcosa su sé stesso*. Il ragionamento: la corrente nel circuito crea un campo magnetico, questo campo ha un flusso attraverso il circuito stesso (l'*autoflusso*), e se la corrente cambia anche questo flusso cambia, generando una F.E.M. che... agisce sul circuito stesso! È come se il circuito avesse un'"inerzia elettrica": proprio come una massa pesante resiste a cambiare velocità, un induttore resiste a far cambiare la corrente. Si oppone sia a quando vuoi accenderla, sia a quando vuoi spegnerla.
]

Quando una corrente attraversa un circuito, genera un campo magnetico. Il flusso del campo prodotto dal circuito attraverso il circuito stesso si chiama *autoflusso*.

Per circuiti lineari l'autoflusso è proporzionale alla corrente:

#green-box([Induttanza])[
  $ Phi_B = L i. $
]

#yellow-box([Perché $Phi_B$ è proporzionale a $i$])[
  Più corrente fai passare, più forte è il campo magnetico che crei (lo abbiamo visto: $B prop i$ ovunque), e quindi più grande è il flusso attraverso il circuito. Il flusso è semplicemente proporzionale alla corrente, e la costante di proporzionalità si chiama $L$: questo è il significato di $Phi_B = L i$. $L$ dipende solo dalla *forma geometrica* del circuito (quante spire, quanto grandi, ecc.), non dalla corrente.
]

L'induttanza è per il campo magnetico ciò che la capacità è per il campo elettrico: misura quanto facilmente il circuito accumula energia nel campo, ma ora attraverso la corrente.

La costante $L$ è l'*induttanza* e si misura in henry:

$ [L] = "H". $

Se la corrente varia nel tempo, varia anche l'autoflusso e quindi nasce una F.E.M. autoindotta:

#blue-box([Autoinduzione])[
  $ cal(E)_L = - (dif Phi_B)/(dif t) = - L (dif i)/(dif t). $
]

#yellow-box([Il passaggio da $Phi_B$ a $i$])[
  Applichiamo Faraday all'autoflusso $Phi_B = L i$. Derivando rispetto al tempo, e tenendo conto che $L$ è costante (geometria fissa):
  $ cal(E)_L = -(dif Phi_B)/(dif t) = -(dif)/(dif t)(L i) = -L (dif i)/(dif t). $
  Quindi la F.E.M. autoindotta è proporzionale a *quanto velocemente cambia la corrente*. Se la corrente è costante ($dif i\/dif t = 0$), l'induttore non fa nulla; è solo quando *cambi* la corrente che reagisce.
]

Il segno meno indica che l'induttore si oppone alla variazione della corrente: si oppone all'aumento quando il circuito si accende e si oppone alla diminuzione quando il circuito si spegne.

#green-box([L'analogia con l'inerzia: l'induttore è una "massa" elettrica])[
  Un buon modo di sentire l'induttanza: $L$ è alla corrente ciò che la massa $m$ è alla velocità. $L (dif i)/(dif t)$ assomiglia a $m (dif v)/(dif t)$. Una grande massa è difficile da accelerare *e* da fermare; una grande induttanza rende difficile far partire la corrente *e* farla cessare. Per questo, se provi a interrompere bruscamente la corrente in un grosso induttore, lui "non vuole" fermarsi e può generare una scintilla pur di continuare a far scorrere corrente.
]

#align(center, graph-card([Autoflusso e autoinduzione], cetz.canvas({
  import cetz.draw: *

  axis-label((1.92, 3.72), [autoflusso], placement: "south")
  circle((1.62, 2.08), radius: (1.00, 0.42), stroke: 1.10pt + ink, fill: none, mark: (end: ">"))
  for x in (1.18, 1.56, 1.94) {
    catmull((x, 1.82), (x - 0.10, 2.24), (x + 0.10, 2.72), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  line((1.62, 2.08), (1.62, 3.20), stroke: 1.05pt + ink, mark: (end: ">"))
  axis-label((1.82, 3.16), [$hat(n)$], placement: "west")
  axis-label((1.60, 1.18), [$Phi_B=L i$], placement: "north")

  line((3.40, 0.62), (3.40, 3.86), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((4.00, 3.02), [se $i(t)$ varia], placement: "west")
  line((4.16, 2.24), (4.16, 3.22), stroke: 1.15pt + green, mark: (end: ">"))
  axis-label((4.34, 3.14), [$i$], placement: "west")
  circle((4.16, 2.24), radius: (0.55, 0.24), stroke: 1.0pt + blue, fill: none, mark: (end: ">"))
  axis-label((4.82, 2.24), [$vec(B)$], placement: "west")
  axis-label((3.92, 1.36), [$cal(E)_L=-L dif i/dif t$], placement: "north")

  line((6.16, 0.62), (6.16, 3.86), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((6.62, 2.80), [si oppone a], placement: "west")
  axis-label((6.62, 2.16), [aumenti e diminuzioni di corrente], placement: "west")
  axis-label((6.62, 1.36), [effetto di Lenz sul circuito stesso], placement: "west")
})))

== Circuito RL

#green-box([L'idea prima della formula])[
  Un circuito RL ha una pila, una resistenza e un induttore. La cosa interessante è il *comportamento nel tempo*: per via dell'inerzia dell'induttore (vista sopra), la corrente *non* salta subito al suo valore finale quando accendi, e *non* sparisce subito quando spegni. Sale e scende dolcemente, come un'auto pesante che non può accelerare o frenare di colpo. Il "tempo caratteristico" $tau$ dice quanto è lenta questa salita o discesa. È lo stesso tipo di curva esponenziale del circuito RC che hai già visto con i condensatori, solo che qui il protagonista è l'induttore.
]

In un circuito formato da un generatore ideale $V_0$, una resistenza $R$ e un'induttanza $L$, la legge di maglia durante l'accensione è

#yellow-box([Legge di Ohm generalizzata per RL])[
  $ V_0 - L (dif i)/(dif t) = R i. $
]

#yellow-box([Da dove arriva questa equazione (legge di maglia)])[
  Facciamo il giro del circuito sommando le tensioni (legge di Kirchhoff): la pila *fornisce* $V_0$, l'induttore *toglie* $L (dif i)/(dif t)$ (la sua F.E.M. autoindotta, col segno meno perché si oppone), e ciò che resta deve cadere sul resistore, cioè $R i$. In formula: $V_0 - L (dif i)/(dif t) = R i$. È un'equazione differenziale: lega la corrente $i$ alla sua derivata $(dif i)/(dif t)$. La sua soluzione è proprio l'esponenziale qui sotto.
]

La corrente non passa istantaneamente da zero al valore di regime: cresce esponenzialmente con tempo caratteristico

$ tau = L/R. $

#yellow-box([Cosa significa $tau = L/R$ e perché ha le unità giuste])[
  $tau$ (tau) è il *tempo caratteristico*: dopo un tempo $tau$ la corrente ha già fatto circa il $63%$ del suo cammino verso il valore finale; dopo $5 tau$ è praticamente arrivata. Più grande è $L$ (più inerzia), più lento il processo; più grande è $R$, più veloce. Controllo dimensionale: $["H"]\/["ohm"] = "s"$, cioè henry diviso ohm dà secondi, come deve essere per un tempo.
]

Il motivo fisico è l'autoinduzione: quando la corrente cambia rapidamente, l'induttore genera una F.E.M. che si oppone a quel cambiamento.

Durante l'accensione:

#blue-box([Accensione RL])[
  $ i(t)=V_0/R (1-e^(-t/tau)), quad tau=L/R. $
]

#yellow-box([Come leggere la curva di accensione])[
  - All'inizio ($t=0$): $e^0 = 1$, quindi $1 - 1 = 0$ e $i(0) = 0$. Giusto: appena accendi, l'induttore "blocca" la corrente, che parte da zero.
  - Alla fine ($t arrow infinity$): $e^(-infinity) = 0$, quindi $1 - 0 = 1$ e $i = V_0/R$. È il valore di regime: a corrente costante l'induttore non fa più nulla e resta solo la legge di Ohm $i = V_0/R$.
  - In mezzo, la corrente sale dolcemente con la forma $1 - e^(-t/tau)$.
]

Durante lo spegnimento, l'energia accumulata nel campo magnetico dell'induttore viene restituita e dissipata nel resistore. La corrente decade:

#blue-box([Spegnimento RL])[
  $ i(t)=i_0 e^(-t/tau). $
]

#yellow-box([La curva di spegnimento, al contrario])[
  Stacchi la pila e l'induttore restituisce l'energia che aveva immagazzinato nel campo magnetico, mantenendo la corrente ancora per un po'. La corrente parte da $i_0$ (il valore che aveva) e decade: a $t=0$ vale $i_0 e^0 = i_0$; a $t arrow infinity$ vale $i_0 e^(-infinity) = 0$. Dopo $tau$ è scesa al $37%$ circa. È la stessa esponenziale, ma in discesa.
]

La potenza associata all'induttore è

$ P_L = cal(E)_L i = - L i (dif i)/(dif t). $

Il segno dipende dal fatto che l'induttore stia assorbendo energia dal circuito oppure restituendola.

#purple-box([Esempio numerico: tempo caratteristico RL])[
  Sia $V_0 = 12 " V"$, $R = 4 " ohm"$, $L = 0,2 " H"$.
  - Corrente di regime (finale): $i_oo = V_0/R = 12/4 = 3 " A"$.
  - Tempo caratteristico: $tau = L/R = 0,2/4 = 0,05 " s" = 50 " ms"$.
  - Dopo un tempo $tau$: $i(tau) = 3 dot (1 - e^(-1)) = 3 dot (1 - 0,37) approx 3 dot 0,63 approx 1,9 " A"$.
  - Dopo $5 tau = 0,25 " s"$ la corrente è praticamente arrivata a $3 " A"$.
]

#align(center, graph-card([Circuito RL: accensione e spegnimento], cetz.canvas({
  import cetz.draw: *

  axis-label((1.56, 3.74), [circuito RL], placement: "south")
  rect((0.56, 1.02), (2.80, 3.12), stroke: 1.05pt + ink, fill: none)
  line((1.00, 0.66), (1.00, 1.38), stroke: 1.25pt + ink)
  line((1.44, 0.84), (1.44, 1.20), stroke: 1.25pt + ink)
  axis-label((0.84, 0.44), [$+$], placement: "north")
  axis-label((1.60, 0.44), [$-$], placement: "north")
  axis-label((1.22, 0.16), [$V_0$], placement: "north")
  line((0.56, 2.24), (0.76, 2.08), stroke: 1.0pt + ink)
  line((0.76, 2.08), (0.36, 1.88), stroke: 1.0pt + ink)
  line((0.36, 1.88), (0.76, 1.68), stroke: 1.0pt + ink)
  line((0.76, 1.68), (0.56, 1.52), stroke: 1.0pt + ink)
  axis-label((0.18, 1.88), [$R$], placement: "east")
  for x in (1.42, 1.64, 1.86, 2.08) {
    circle((x, 3.12), radius: (0.13, 0.20), stroke: 1.0pt + ink, fill: none)
  }
  axis-label((1.76, 3.44), [$L$], placement: "south")
  line((2.16, 1.02), (2.48, 1.34), stroke: 1.05pt + ink)
  circle((2.56, 1.40), radius: 0.05, fill: ink, stroke: none)

  line((3.42, 0.62), (3.42, 3.88), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((4.96, 3.70), [accensione], placement: "south")
  line((3.96, 1.00), (6.06, 1.00), stroke: 0.9pt + ink, mark: (end: ">"))
  line((3.96, 1.00), (3.96, 3.10), stroke: 0.9pt + ink, mark: (end: ">"))
  line((3.96, 2.68), (5.90, 2.68), stroke: (paint: ink, thickness: 0.75pt, dash: "dashed"))
  catmull((3.96, 1.00), (4.34, 1.64), (4.90, 2.16), (5.52, 2.50), (5.94, 2.62), stroke: 1.25pt + blue)
  axis-label((5.86, 2.92), [$V_0/R$], placement: "south")
  axis-label((4.92, 1.76), [$1-e^(-t/tau)$], placement: "west")

  line((6.64, 0.62), (6.64, 3.88), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((8.10, 3.70), [spegnimento], placement: "south")
  line((7.08, 1.00), (9.18, 1.00), stroke: 0.9pt + ink, mark: (end: ">"))
  line((7.08, 1.00), (7.08, 3.10), stroke: 0.9pt + ink, mark: (end: ">"))
  catmull((7.08, 2.76), (7.48, 2.10), (8.10, 1.56), (8.78, 1.18), (9.12, 1.06), stroke: 1.25pt + red)
  axis-label((7.28, 2.90), [$i_0$], placement: "south")
  axis-label((8.20, 1.72), [$e^(-t/tau)$], placement: "west")
})))

== Mutua induzione

#green-box([L'idea prima della formula])[
  L'autoinduzione era un circuito che agiva su sé stesso. La *mutua induzione* è la stessa idea fra *due* circuiti vicini: se cambio la corrente nel primo, cambia il campo magnetico che esso produce, e quindi cambia il flusso anche attraverso il secondo circuito, che reagisce con una F.E.M. indotta. I due circuiti "parlano" tra loro a distanza, senza fili che li colleghino, solo tramite il campo magnetico. Questo è il principio del *trasformatore* (quello che cambia tensione) e della *ricarica wireless* del telefono: due bobine che si scambiano energia attraverso il campo.
]

Se due circuiti sono vicini, una corrente variabile nel primo può modificare il flusso magnetico concatenato con il secondo. Si parla di *mutua induzione*.

Per circuiti lineari:

#green-box([Coefficiente di mutua induzione])[
  $ Phi_(1,2) = M i_1, quad Phi_(2,1) = M i_2. $
]

#yellow-box([Come leggere i pedici e perché $M$ è uno solo])[
  $Phi_(1,2)$ è il flusso che il circuito 1 manda *dentro* il circuito 2. Proprio come prima, questo flusso è proporzionale alla corrente che lo genera: $Phi_(1,2) = M i_1$. La costante $M$ è il *coefficiente di mutua induzione* (in henry). Una cosa sorprendente, dimostrabile, è che $M$ è lo *stesso* nei due versi: l'effetto di 1 su 2 è uguale all'effetto di 2 su 1. Per questo basta un solo numero $M$ per descrivere l'accoppiamento.
]

La costante $M$ misura quanto i due circuiti sono accoppiati magneticamente. Se la corrente in un circuito varia nel tempo, nell'altro può nascere una F.E.M. indotta. Se i circuiti sono lontani o orientati male, il flusso concatenato è piccolo e anche $M$ è piccolo.

#yellow-box([La F.E.M. indotta nel secondo circuito])[
  Applicando Faraday al secondo circuito: $cal(E)_2 = -(dif Phi_(1,2))/(dif t) = -M (dif i_1)/(dif t)$. Cioè, se nel circuito 1 cambio la corrente, nel circuito 2 nasce una tensione proporzionale a $M$ e a quanto velocemente cambia $i_1$. Per i trasformatori si usano correnti alternate proprio perché cambiano in continuazione: così l'accoppiamento è sempre attivo.
]

#align(center, graph-card([Mutua induzione tra due circuiti], cetz.canvas({
  import cetz.draw: *

  circle((1.62, 2.08), radius: (0.92, 0.42), stroke: 1.10pt + ink, fill: none, mark: (end: ">"))
  axis-label((1.62, 1.42), [$Gamma_1$], placement: "north")
  line((1.62, 2.08), (2.38, 2.84), stroke: 1.10pt + green, mark: (end: ">"))
  axis-label((2.50, 2.88), [$i_1(t)$], placement: "west")
  catmull((2.28, 2.74), (3.00, 3.28), (3.88, 3.06), (4.40, 2.46), stroke: 1.05pt + blue, mark: (end: ">"))
  axis-label((3.36, 3.38), [$vec(B)_1$], placement: "south")
  circle((4.62, 2.08), radius: (0.92, 0.42), stroke: 1.10pt + ink, fill: none, mark: (end: ">"))
  axis-label((4.62, 1.42), [$Gamma_2$], placement: "north")
  axis-label((3.04, 0.72), [$Phi_(1,2)=M i_1$], placement: "north")

  line((5.90, 0.62), (5.90, 3.68), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((6.40, 2.76), [variazione di corrente], placement: "west")
  axis-label((6.40, 2.12), [$dif i_1/dif t != 0$], placement: "west")
  axis-label((6.40, 1.40), [F.E.M. indotta nel circuito 2], placement: "west")
})))

== Equazioni di Maxwell

#green-box([L'idea prima della formula])[
  Le quattro equazioni di Maxwell sono il "gran finale": riassumono *tutto* l'elettromagnetismo in quattro righe. Sono talmente potenti che descrivono i fulmini, le calamite, la luce, il wifi, i raggi X... tutto. Non c'è una quinta legge da imparare: queste quattro bastano. L'idea geniale di Maxwell fu accorgersi che le leggi che avevamo (Gauss, Ampère, Faraday) erano *incomplete*, e aggiungere il pezzo mancante. Da quel pezzo mancante è uscita, come per magia, la previsione che la luce è un'onda elettromagnetica.
]

Le equazioni di Maxwell riuniscono elettrostatica, magnetostatica e induzione. In regime stazionario non compaiono derivate temporali: i campi non cambiano nel tempo.

Il loro valore non è solo riassuntivo: mostrano quali sorgenti producono divergenza e quali producono circuitazione dei campi.

#blue-box([Le 4 equazioni, una per una, in parole])[
  + *Gauss per $vec(E)$*: $integral_S vec(E) dot dif vec(S) = Q_"int"/epsilon_0$ (locale: $nabla dot vec(E) = rho/epsilon_0$). "Le cariche elettriche sono le sorgenti del campo elettrico." Le linee di $vec(E)$ partono dalle cariche positive e arrivano sulle negative.
  + *Gauss per $vec(B)$*: $integral_S vec(B) dot dif vec(S) = 0$ (locale: $nabla dot vec(B) = 0$). "Non esistono cariche magnetiche." Le linee di $vec(B)$ non hanno né inizio né fine: sono sempre chiuse.
  + *Ampère*: $integral_Gamma vec(B) dot dif vec(ell) = mu_0 i$ (locale: $nabla times vec(B) = mu_0 vec(J)$). "Le correnti sono sorgenti di campo magnetico che gira." Il campo $vec(B)$ avvolge le correnti.
  + *Faraday*: in regime stazionario $integral_Gamma vec(E) dot dif vec(ell) = 0$ (locale: $nabla times vec(E) = 0$). "Senza variazioni nel tempo, il campo elettrico non gira": è conservativo.

  Schema da ricordare: le due "Gauss" (flussi) dicono *chi crea i campi*; le altre due (circuitazioni) dicono *cosa li fa girare*.
]

#align(center, graph-card([Equazioni di Maxwell stazionarie], cetz.canvas({
  import cetz.draw: *

  axis-label((2.18, 3.50), [forma integrale], placement: "south")
  axis-label((0.62, 2.72), [$integral_Gamma vec(E) dot dif vec(ell)=0$], placement: "west")
  axis-label((0.62, 2.02), [$integral_S vec(E) dot dif vec(S)=Q_"int"/epsilon_0$], placement: "west")
  axis-label((0.62, 1.32), [$integral_Gamma vec(B) dot dif vec(ell)=mu_0 i$], placement: "west")
  axis-label((0.62, 0.62), [$integral_S vec(B) dot dif vec(S)=0$], placement: "west")

  line((4.96, 0.50), (4.96, 3.68), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((7.00, 3.50), [forma locale], placement: "south")
  axis-label((5.46, 2.72), [$nabla times vec(E)=0$], placement: "west")
  axis-label((5.46, 2.02), [$nabla dot vec(E)=rho/epsilon_0$], placement: "west")
  axis-label((5.46, 1.32), [$nabla times vec(B)=mu_0 vec(J)$], placement: "west")
  axis-label((5.46, 0.62), [$nabla dot vec(B)=0$], placement: "west")
})))

Quando i campi variano nel tempo, le equazioni cambiano in due punti essenziali:

- Faraday sostituisce la circuitazione nulla di $vec(E)$;
- Ampère deve essere corretto con la *corrente di spostamento*.

La correzione di Maxwell dice che anche un campo elettrico variabile produce campo magnetico, perfino dove non c'è corrente di conduzione.

#green-box([Il pezzo mancante: la corrente di spostamento])[
  Maxwell notò che il vecchio teorema di Ampère "non chiudeva i conti" quando i campi cambiano nel tempo (per esempio tra le armature di un condensatore che si carica, dove la corrente non passa fisicamente ma il campo elettrico cresce). La sua intuizione: *anche un campo elettrico che cambia nel tempo si comporta come una corrente* e crea campo magnetico. Questo termine in più, $mu_0 epsilon_0 (dif Phi_E)/(dif t)$, si chiama *corrente di spostamento*. Con questa aggiunta, le equazioni diventano simmetriche: un $vec(B)$ che cambia genera $vec(E)$ (Faraday), e un $vec(E)$ che cambia genera $vec(B)$ (Maxwell). È proprio questa simmetria a far esistere le onde elettromagnetiche.
]

#green-box([Maxwell non stazionario])[
  $ integral_Gamma vec(E) dot dif vec(ell) = - (dif Phi_B)/(dif t), quad
    integral_Gamma vec(B) dot dif vec(ell) = mu_0 i + mu_0 epsilon_0 (dif Phi_E)/(dif t). $
]

#yellow-box([Cosa è cambiato rispetto al caso stazionario])[
  - A sinistra: la circuitazione di $vec(E)$ *non è più zero*. Ora vale $-(dif Phi_B)/(dif t)$: un campo magnetico che cambia *fa girare* il campo elettrico. Questo è esattamente Faraday scritto in forma di circuitazione.
  - A destra: compare il termine in più $mu_0 epsilon_0 (dif Phi_E)/(dif t)$, la corrente di spostamento. Se i campi sono costanti nel tempo, queste due derivate sono zero e si ritorna alle equazioni stazionarie di prima.
]

In forma locale:

#blue-box([Maxwell in forma locale])[
  $ nabla times vec(E) = - partial_t vec(B), quad
    nabla times vec(B) = mu_0 vec(J) + mu_0 epsilon_0 partial_t vec(E), $
  $ nabla dot vec(E) = rho/epsilon_0, quad
    nabla dot vec(B)=0. $
]

#yellow-box([La forma locale tradotta])[
  Il simbolo $partial_t$ è la derivata rispetto al tempo. Riga per riga: $nabla times vec(E) = -partial_t vec(B)$ (un campo magnetico variabile fa "vorticare" $vec(E)$); $nabla times vec(B) = mu_0 vec(J) + mu_0 epsilon_0 partial_t vec(E)$ (correnti *e* campi elettrici variabili fanno vorticare $vec(B)$); $nabla dot vec(E) = rho/epsilon_0$ (le cariche, con densità $rho$, sono sorgenti di $vec(E)$); $nabla dot vec(B) = 0$ (nessuna sorgente per $vec(B)$). Sono le stesse quattro idee della tabella, scritte "punto per punto" invece che "su tutta una curva o superficie".
]

#align(center, graph-card([Maxwell non stazionario e corrente di spostamento], cetz.canvas({
  import cetz.draw: *

  axis-label((1.90, 3.48), [Faraday], placement: "south")
  circle((1.40, 2.28), radius: (0.92, 0.38), stroke: 1.10pt + ink, fill: none, mark: (end: ">"))
  for x in (1.06, 1.38, 1.70) {
    line((x, 1.74), (x, 2.86), stroke: 1.05pt + blue, mark: (end: ">"))
  }
  axis-label((1.40, 1.14), [$dif Phi_B/dif t -> vec(E)_"ind"$], placement: "north")

  line((3.42, 0.58), (3.42, 3.66), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((5.10, 3.48), [corrente di spostamento], placement: "south")
  line((4.46, 1.18), (4.46, 2.82), stroke: 1.10pt + ink)
  line((5.56, 1.18), (5.56, 2.82), stroke: 1.10pt + ink)
  for y in (1.48, 1.86, 2.24, 2.62) {
    line((4.62, y), (5.40, y), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  circle((5.00, 2.00), radius: (0.86, 0.32), stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"), fill: none)
  axis-label((5.00, 0.92), [$epsilon_0 dif Phi_E/dif t$], placement: "north")

  line((6.78, 0.58), (6.78, 3.66), stroke: 0.55pt + rgb("#ccd4d8"))

  axis-label((7.18, 2.80), [$vec(E)$ variabile genera $vec(B)$], placement: "west")
  axis-label((7.18, 2.04), [$vec(B)$ variabile genera $vec(E)$], placement: "west")
  axis-label((7.18, 1.28), [i campi si accoppiano], placement: "west")
})))

== Onde elettromagnetiche nel vuoto

#green-box([L'idea prima della formula])[
  Ecco il premio finale di tutto il corso. Abbiamo detto che un $vec(E)$ che cambia crea $vec(B)$, e un $vec(B)$ che cambia crea $vec(E)$. Ma allora possono *tenersi in vita a vicenda*: $vec(E)$ genera $vec(B)$, che generando si rigenera $vec(E)$, e così via, in un'onda che si autoalimenta e viaggia nello spazio *anche senza nessuna materia attorno*. Questo "ballo" tra campo elettrico e magnetico è la *luce*. La cosa incredibile è che Maxwell, solo con la matematica, calcolò la velocità di questo ballo e ottenne un numero già noto: la velocità della luce. Fu così che si capì che la luce *è* un'onda elettromagnetica.
]

Nel vuoto non ci sono cariche libere né correnti:

$ rho = 0, quad vec(J)=0. $

Le equazioni di Maxwell diventano

$ nabla dot vec(E)=0, quad nabla dot vec(B)=0, $

$ nabla times vec(E)=-partial_t vec(B), quad
  nabla times vec(B)=mu_0 epsilon_0 partial_t vec(E). $

#yellow-box([Perché le equazioni si semplificano così])[
  Nel vuoto non ci sono cariche ($rho = 0$) né correnti di conduzione ($vec(J) = 0$): quindi nei membri di destra spariscono i termini con $rho$ e con $vec(J)$. Restano solo i termini con le derivate temporali, cioè proprio quelli che legano $vec(E)$ e $vec(B)$ tra loro. Sono le equazioni di due campi che si "intrecciano": è da qui che la matematica fa uscire un'onda.
]

Da queste equazioni segue che i campi $vec(E)$ e $vec(B)$ possono propagarsi come onde elettromagnetiche. La velocità di propagazione nel vuoto è

#purple-box([Velocità della luce])[
  $ c = 1/sqrt(epsilon_0 mu_0). $
]

#purple-box([Verifica numerica: la velocità della luce])[
  Sostituiamo i valori delle costanti: $epsilon_0 approx 8,85 dot 10^(-12) " F/m"$ e $mu_0 approx 4 pi dot 10^(-7) approx 1,26 dot 10^(-6) " N/A"^2$.
  $ epsilon_0 mu_0 approx (8,85 dot 10^(-12)) dot (1,26 dot 10^(-6)) approx 1,11 dot 10^(-17). $
  $ c = 1/sqrt(#[1,11] dot 10^(-17)) approx 1/(3,34 dot 10^(-9)) approx 3,0 dot 10^8 " m/s". $
  Cioè circa $300 thin 000 " km/s"$: esattamente la velocità della luce misurata sperimentalmente. Questo "miracolo numerico" fu la prova che la luce è un'onda elettromagnetica.
]

Il punto concettuale è che i campi si sostengono a vicenda: un $vec(E)$ variabile genera $vec(B)$ e un $vec(B)$ variabile genera $vec(E)$. Per questo l'onda può propagarsi anche nel vuoto.

Nel vuoto, per un'onda piana, i campi sono perpendicolari tra loro e alla direzione di propagazione. I moduli sono legati da

#blue-box([Relazione tra i campi nell'onda])[
  $ abs(vec(B)) = abs(vec(E))/c. $
]

#yellow-box([Come leggere questa relazione])[
  Il modulo di $vec(B)$ è quello di $vec(E)$ diviso per $c$, un numero grandissimo ($3 dot 10^8$). Quindi nell'onda il campo magnetico è *numericamente* molto più piccolo del campo elettrico (in queste unità): non perché sia "meno importante", ma è una conseguenza delle unità di misura del SI. I due campi sono partner alla pari nel sostenere l'onda.
]

Inoltre $vec(E)$ e $vec(B)$ oscillano in fase: quando uno è massimo, anche l'altro è massimo. La luce è un'onda elettromagnetica; onde radio, microonde, infrarosso, ultravioletto, raggi X e raggi gamma sono lo stesso tipo di fenomeno, ma con frequenze e lunghezze d'onda diverse.

#green-box([Lo spettro elettromagnetico: è tutta la stessa cosa])[
  Onde radio, microonde (il forno!), infrarosso (il calore), luce visibile (i colori dell'arcobaleno), ultravioletto (l'abbronzatura), raggi X (le lastre), raggi gamma: sono *tutte* onde elettromagnetiche, identiche nella natura, che differiscono solo per la *frequenza* (quante oscillazioni al secondo) e la *lunghezza d'onda* corrispondente. Dalle radio (onde lunghe metri o chilometri) ai raggi gamma (onde piccolissime, molto energetiche), è un unico continuo. La luce che vedi con gli occhi è solo una sottilissima finestra di questo enorme spettro.
]

#align(center, graph-card([Onda elettromagnetica nel vuoto], cetz.canvas({
  import cetz.draw: *

  line((0.70, 1.10), (8.90, 1.10), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((9.02, 1.10), [propagazione $v=c$], placement: "west")
  line((1.20, 1.10), (1.20, 3.40), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((1.02, 3.40), [$vec(E)$], placement: "east")
  line((1.20, 1.10), (0.54, 0.28), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((0.44, 0.20), [$vec(B)$], placement: "east")

  // Onda E: sinusoide verticale lungo la direzione di propagazione.
  catmull(
    (1.20, 1.10),
    (1.72, 2.20),
    (2.24, 1.10),
    (2.76, 0.10),
    (3.28, 1.10),
    (3.80, 2.20),
    (4.32, 1.10),
    (4.84, 0.10),
    (5.36, 1.10),
    (5.88, 2.20),
    (6.40, 1.10),
    (6.92, 0.10),
    (7.44, 1.10),
    (7.96, 2.20),
    (8.48, 1.10),
    stroke: 1.25pt + blue,
  )
  // Onda B: sinusoide inclinata nel piano perpendicolare a E.
  catmull(
    (1.20, 1.10),
    (1.72, 0.46),
    (2.24, 1.10),
    (2.76, 1.76),
    (3.28, 1.10),
    (3.80, 0.46),
    (4.32, 1.10),
    (4.84, 1.76),
    (5.36, 1.10),
    (5.88, 0.46),
    (6.40, 1.10),
    (6.92, 1.76),
    (7.44, 1.10),
    (7.96, 0.46),
    (8.48, 1.10),
    stroke: 1.25pt + green,
  )
  axis-label((6.76, 2.36), [$vec(E)$], placement: "south")
  axis-label((6.88, 0.34), [$vec(B)$], placement: "north")

  line((0.68, -0.18), (8.92, -0.18), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((1.10, -0.58), [$rho=0, quad vec(J)=0$], placement: "west")
  axis-label((4.12, -0.58), [$c=1/sqrt(epsilon_0 mu_0)$], placement: "west")
  axis-label((7.02, -0.58), [$abs(vec(B))=abs(vec(E))/c$], placement: "west")
})))

#align(center)[
  #text(22pt, weight: "bold", fill: red)[Fine corso]
]
