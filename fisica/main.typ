#import "layout.typ": appunti
#import "boxes.typ": *
#import "@preview/cetz:0.5.1"

#show: appunti

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

La *fisica* è una scienza sperimentale: parte dall'osservazione della realtà, misura grandezze fisiche e cerca relazioni matematiche tra esse. Quando una relazione è ripetutamente confermata dagli esperimenti e ne riassume il comportamento, prende il nome di *legge fisica*.

#green-box([Idea guida])[La teoria non sostituisce l'esperimento: organizza i dati, permette di fare previsioni e deve poter essere smentita da nuove misure.]

Si distingue convenzionalmente tra:

- *fisica classica*, adeguata a corpi macroscopici, velocità molto minori di quella della luce e fenomeni non quantistici;
- *fisica moderna*, sviluppata soprattutto dal XX secolo, che comprende relatività e meccanica quantistica.

Nel modello classico usato in questa prima parte si assume uno spazio euclideo tridimensionale e un tempo che scorre uniformemente. I corpi vengono spesso idealizzati come particelle dotate di massa e quindi di inerzia.

La fisica classica adotta una descrizione *deterministica*: assegnato lo stato iniziale e note le leggi del moto, lo stato futuro è in linea di principio determinato. La fisica descrive grandezze su scale estremamente diverse, indicativamente da $10^(-45)$ a $10^45$, ma ogni affermazione resta legata a quantità osservabili e misurabili entro un preciso intervallo di validità sperimentale.

== Interazioni fondamentali e conservazione

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

== Leggi fisiche e osservatore

Una legge fisica è una relazione matematica tra oggetti dello stesso tipo: vettori con vettori, scalari con scalari. La sua forma non deve dipendere dalla scelta arbitraria dell'osservatore o del sistema di coordinate.

L'osservatore usa un riferimento $O x y z$ e strumenti per misurare posizione e tempo. Può cambiare origine, traslare nello spazio e nel tempo oppure ruotare gli assi: una legge fisica deve essere formulata con oggetti che si trasformano coerentemente sotto questi cambiamenti, cioè deve essere *covariante*.

#blue-box([Scalari e vettori])[
  Una grandezza *scalare* è descritta da un valore e da un'unità di misura (per esempio massa e temperatura). Una grandezza *vettoriale* possiede anche direzione e verso (per esempio spostamento, velocità e forza). Non ogni numero scritto in un calcolo è automaticamente uno scalare fisico: deve rappresentare una quantità invariata rispetto ai cambiamenti di coordinate considerati.
]

#yellow-box([Coerenza delle equazioni])[
  In un'equazione fisica i due membri devono avere lo stesso rango e le stesse dimensioni fisiche. Non ha senso uguagliare direttamente un vettore a un numero, né sommare una lunghezza a un tempo.
]

= Meccanica

La meccanica studia il moto dei corpi e si divide in due parti:

- la *cinematica* descrive come si muove un corpo, senza indagare la causa del moto;
- la *dinamica* collega il moto alle forze che lo producono.

In questa sezione consideriamo soltanto moti lungo una retta.

== Punto materiale e legge oraria

#green-box([Punto materiale])[
  Un corpo è trattato come *punto materiale* quando le sue dimensioni e i suoi moti interni sono irrilevanti per il problema. Conserva però la massa $m$.
]

Scelto un asse orientato $x$, il moto rettilineo è descritto dalla coppia

$ (t, x(t)), $

dove $t$ è il tempo e $x(t)$ è la posizione. La funzione $x(t)$ è detta *legge oraria*. Il suo grafico non rappresenta la traiettoria nello spazio: mostra come cambia la coordinata del corpo nel tempo.

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

La velocità media nell'intervallo $[t_1,t_2]$ è

$ v_("media") = (Delta x)/(Delta t) = (x(t_2)-x(t_1))/(t_2-t_1), $

e si misura in $"m"/"s"$. La velocità istantanea è il limite della velocità media per intervalli di tempo sempre più piccoli:

$ v(t) = (dif x(t))/(dif t). $

Geometricamente, $v(t)$ è il coefficiente angolare della retta tangente al grafico di $x(t)$. Il segno indica il verso del moto: $v>0$ se $x$ cresce, $v<0$ se $x$ diminuisce, $v=0$ in un punto stazionario.

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

Nel moto rettilineo uniforme la velocità è costante. La legge oraria non si assume: si ricava dalla definizione di velocità. Separando le variabili,

$ v=(dif x)/(dif t) quad arrow quad dif x=v dif t. $

Si integrano entrambi i membri tra lo stato iniziale $(t_0,x_0)$ e lo stato generico $(t,x(t))$:

$ integral_(x_0)^(x(t)) dif x=integral_(t_0)^t v dif tau. $

#yellow-box([Perché si può integrare così?])[
  In modo rigoroso, $v=(dif x)/(dif t)$ significa che $v(t)$ è la derivata della funzione posizione $x(t)$ rispetto al tempo:
  $ v(t)=x'(t). $

  Quindi la scrittura fisica $dif x=v dif t$ va letta come una forma abbreviata del differenziale
  $ dif x=x'(t) dif t=v(t) dif t, $
  non come una normale divisione algebrica tra numeri. E' una notazione molto usata in fisica: in analisi, lo stesso passaggio si giustifica integrando direttamente la derivata:
  $ integral_(t_0)^t x'(tau) dif tau=integral_(t_0)^t v(tau) dif tau. $

  Per il teorema fondamentale del calcolo, il primo membro vale $x(t)-x_0$. Dunque l'integrale della velocità nel tempo rappresenta lo spostamento totale: somma tutti i contributi infinitesimi $dif x$ ed equivale all'area sotto il grafico velocità-tempo.
]

Poiché $v$ è costante,

$ x(t)-x_0=v(t-t_0), $

da cui

$ x(t) = x_0 + v (t-t_0), $

dove $x_0=x(t_0)$. Se si sceglie $t_0=0$, la legge oraria diventa $x(t)=x_0+v t$.

#blue-box([Caso di quiete])[
  La quiete è il caso particolare $v=0$: la legge oraria diventa $x(t)=x_0$, quindi il grafico posizione-tempo è una retta orizzontale.
]

#red-box([Da ricordare])[
  Moto uniforme $arrow$ grafico $x(t)$ rettilineo $arrow$ pendenza costante. Il corpo può avere velocità costante non nulla anche se la risultante delle forze sarà, come vedremo, nulla.
]

== Accelerazione

L'accelerazione media è

$ a_("media") = (Delta v)/(Delta t), $

mentre l'accelerazione istantanea è

$ a(t) = (dif v(t))/(dif t) = (dif^2 x(t))/(dif t^2). $

La sua unità di misura è $"m"/"s"^2$. L'accelerazione descrive quanto rapidamente varia la velocità; non coincide necessariamente con una velocità elevata.

=== Moto uniformemente accelerato

Nel moto uniformemente accelerato $a$ è costante. Partendo da $a=(dif v)/(dif t)$,

$ dif v=a dif t, quad
  integral_(v_0)^(v(t)) dif v=integral_(t_0)^t a dif tau. $

L'integrazione fornisce

$ v(t)-v_0=a(t-t_0), quad arrow quad
  v(t)=v_0+a(t-t_0). $

Per ricavare la posizione si usa ora $v=(dif x)/(dif t)$ e si sostituisce la velocità appena trovata:

$ dif x=[v_0+a(t-t_0)] dif t, $

$ integral_(x_0)^(x(t)) dif x
  =integral_(t_0)^t [v_0+a(tau-t_0)] dif tau. $

Calcolando separatamente i due integrali,

$ x(t)-x_0=v_0(t-t_0)+1/2 a(t-t_0)^2. $

Si ottengono così le due leggi orarie:

#blue-box([Equazioni del moto uniformemente accelerato])[
  $ v(t) = v_0 + a(t-t_0) $

  $ x(t) = x_0 + v_0(t-t_0) + 1/2 a(t-t_0)^2 $

  Eliminando il tempo:

  $ v^2 = v_0^2 + 2a(x-x_0). $
]

=== Eliminazione del tempo

La relazione tra velocità e posizione si può dimostrare senza risolvere esplicitamente per $t$. Con la regola della catena,

$ a=(dif v)/(dif t)=(dif v)/(dif x)(dif x)/(dif t)
  =v (dif v)/(dif x). $

Quindi $v dif v=a dif x$. Integrando dallo stato iniziale $(x_0,v_0)$ allo stato $(x,v)$:

$ integral_(v_0)^v u dif u=integral_(x_0)^x a dif xi, $

$ 1/2(v^2-v_0^2)=a(x-x_0), $

e infine

$ v^2=v_0^2+2a(x-x_0). $

#yellow-box([Controllo dimensionale])[
  Ogni termine dell'ultima equazione ha dimensioni di velocità al quadrato:
  $[v^2]="m"^2/"s"^2$ e $[a Delta x]="m"^2/"s"^2$.
]

Con $t_0=0$, i grafici di $a(t)$, $v(t)$ e $x(t)$ sono rispettivamente una retta orizzontale, una retta e una parabola.

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

In una regione abbastanza piccola vicino alla superficie terrestre il campo gravitazionale può essere considerato uniforme. Trascurando la resistenza dell'aria, tutti i corpi hanno la stessa accelerazione verso il basso, indipendentemente dalla massa:

$ g approx 9.81 " m/s"^2. $

#align(center, graph-card([Approssimazione locale del campo gravitazionale], cetz.canvas({
  import cetz.draw: *
  // superficie terrestre vista localmente
  arc((3.5, -2.35), start: 42deg, stop: 138deg, radius: 4.3, stroke: 1.6pt + blue)
  // piccolo corpo sopra la superficie
  rect((2.85, 2.35), (4.15, 2.72), fill: rgb("#eef1f3"), stroke: 0.9pt + ink)
  circle((3.5, 2.54), radius: 0.08, fill: ink, stroke: none)
  line((3.5, 2.30), (3.5, 1.25), stroke: 1.4pt + red, mark: (end: ">"))
  line((3.5, 1.10), (3.5, 0.20), stroke: 1.2pt + green, mark: (end: ">"))
  axis-label((3.68, 1.75), [$vec(F)_g$], placement: "west")
  axis-label((3.68, 0.65), [$a_y=-g$], placement: "west")
  axis-label((4.3, 2.55), [$m$], placement: "west")
  axis-label((3.5, -0.05), [superficie terrestre], placement: "north")
})))

La curvatura della Terra è trascurabile nella regione studiata: localmente la superficie appare piana e $vec(g)$ può essere trattato come costante. La forza di gravità e l'accelerazione sono dirette verso il centro della Terra.

Se l'asse $y$ è orientato verso l'alto, l'accelerazione è $a_y=-g$. Le equazioni generali sono quindi

$ v(t)=v_0-g(t-t_0), $
$ y(t)=y_0+v_0(t-t_0)-1/2 g(t-t_0)^2, $
$ v^2=v_0^2-2g(y-y_0). $

Queste relazioni non sono nuove leggi: si ottengono dalle formule del moto uniformemente accelerato sostituendo $a=-g$.

#yellow-box([Attenzione ai segni])[
  Il simbolo $g$ indica il *modulo* positivo dell'accelerazione gravitazionale. Il segno della componente dipende dall'orientazione dell'asse: con $y$ verso l'alto si ha $a_y=-g$; con l'asse positivo verso il basso si avrebbe $a_y=+g$.
]

== Caduta libera da fermo

Un corpo lasciato da quota $h$ ha $y_0=h$ e $v_0=0$. Ponendo $t_0=0$:

$ v(t)=-g t, quad y(t)=h-1/2 g t^2. $

L'impatto con il suolo avviene quando $y(t_"cad")=0$. Pertanto

$ 0=h-1/2 g t_"cad"^2
  quad arrow quad t_"cad"^2=(2h)/g, $

e, scegliendo la radice positiva perché il tempo di caduta è successivo al rilascio,

$ t_"cad"=sqrt((2h)/g). $

La velocità d'impatto si ottiene sostituendo il tempo nella legge della velocità:

$ v_"cad"=-g t_"cad"
  =-g sqrt((2h)/g)=-sqrt(2g h). $

Il segno negativo della velocità indica che il corpo si muove verso il basso; il modulo della velocità d'impatto è $sqrt(2g h)$.

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

Sia $y_0=0$ e $v_0>0$. Il corpo sale rallentando, raggiunge la quota massima quando $v=0$, poi ricade accelerando verso il basso:

$ v(t)=v_0-g t, quad y(t)=v_0 t-1/2 g t^2. $

All'apice $v(t_"max")=0$, quindi

$ 0=v_0-g t_"max" quad arrow quad t_"max"=v_0/g. $

Sostituendo questo istante nella legge oraria,

$ h_"max"=v_0(v_0/g)-1/2 g(v_0/g)^2
  =v_0^2/(2g). $

Equivalentemente, dalla relazione senza tempo con $v=0$ e $y=h_"max"$:

$ 0=v_0^2-2g h_"max" quad arrow quad h_"max"=v_0^2/(2g). $

Riassumendo,

$ t_"max"=v_0/g, quad h_"max"=v_0^2/(2g). $

Se il corpo ritorna alla stessa quota di lancio, si impone $y(t)=0$:

$ 0=v_0 t-1/2 g t^2=t(v_0-1/2 g t). $

Le due soluzioni sono $t=0$, istante di lancio, e

$ t_"volo"=(2v_0)/g, $

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

Date le condizioni iniziali $t_0$, $x(t_0)=x_0$ e $v(t_0)=v_0$, valgono le relazioni generali

#purple-box([Catena cinematica])[
  $ v(t)=(dif x)/(dif t) quad arrow quad x(t)=x_0+integral_(t_0)^t v(tau) dif tau $

  $ a(t)=(dif v)/(dif t)=(dif^2 x)/(dif t^2) quad arrow quad v(t)=v_0+integral_(t_0)^t a(tau) dif tau $
]

La derivazione porta dalla posizione alla velocità e poi all'accelerazione; l'integrazione, insieme alle condizioni iniziali, consente di risalire nel verso opposto.

= Moto armonico semplice

Il moto armonico semplice è un moto rettilineo periodico descritto da

$ x(t)=A sin(omega t+phi), $

dove $A$ è l'ampiezza, $omega$ la pulsazione e $phi$ la fase iniziale. La fase $omega t+phi$ è adimensionale e si misura in radianti.

L'ampiezza impone $-A <= x(t) <= A$. Il valore di $phi$ stabilisce la posizione nel ciclo all'istante $t=0$; per questo è detto *fase iniziale*.

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

Derivando una prima volta la legge oraria si ottiene la velocità:

$ v(t)=(dif x)/(dif t)
  =A cos(omega t+phi) (dif)/(dif t)(omega t+phi)
  =A omega cos(omega t+phi). $

Derivando ancora,

$ a(t)=(dif v)/(dif t)
  =-A omega sin(omega t+phi) (dif)/(dif t)(omega t+phi)
  =-A omega^2 sin(omega t+phi). $

Poiché $x(t)=A sin(omega t+phi)$,

$ a(t)=-omega^2 x(t). $

I valori massimi dei moduli sono quindi

$ x_"max"=A, quad v_"max"=omega A, quad a_"max"=omega^2 A. $

Segue l'equazione differenziale caratteristica dell'oscillatore armonico:

#align(center, box(inset: 7pt, stroke: 1pt + gold, radius: 3pt)[
  $ (dif^2 x)/(dif t^2)+omega^2 x=0 $
])

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

#yellow-box([Relazioni di fase])[
  Seno e coseno sono in *quadratura di fase*, cioè sfasati di $pi/2$. Perciò posizione e velocità sono sfasate di $pi/2$: quando $abs(x)$ è massimo la velocità è nulla, mentre quando il corpo attraversa l'equilibrio la velocità ha modulo massimo. Accelerazione e posizione sono in opposizione di fase, cioè sfasate di $pi$: $a=-omega^2x$.
]

#gray-box([Confine di questa parte])[
  Fin qui il moto è stato descritto lungo una sola retta. Il passo successivo sarà introdurre posizione, spostamento, velocità e accelerazione come vettori per studiare la cinematica in due e tre dimensioni.
]

#pagebreak()

= Cinematica in due e tre dimensioni

Quando il punto materiale non è vincolato a una retta, la sua posizione è descritta dal *raggio vettore*

$ vec(r)(t)=x(t) hat(i)+y(t) hat(j)+z(t) hat(k). $

Le tre funzioni $x(t)$, $y(t)$ e $z(t)$ sono le coordinate cartesiane del punto. Al variare del tempo, l'estremo di $vec(r)(t)$ disegna nello spazio la *traiettoria*.

#align(center, graph-card([Posizione e spostamento nello spazio], cetz.canvas({
  import cetz.draw: *
  // assi cartesiani in proiezione obliqua
  line((0, 0), (5.2, 0), stroke: 0.9pt + ink, mark: (end: ">"))
  line((0, 0), (0, 3.7), stroke: 0.9pt + ink, mark: (end: ">"))
  line((0, 0), (-2.1, -1.45), stroke: 0.9pt + ink, mark: (end: ">"))
  axis-label((5.2, -0.17), [$x$], placement: "north")
  axis-label((-0.15, 3.7), [$y$], placement: "east")
  axis-label((-2.1, -1.55), [$z$], placement: "north")
  // traiettoria e due posizioni
  bezier((-1.15, 2.15), (-0.2, 3.25), (2.5, 1.65), (4.55, 2.85), stroke: 1.5pt + blue)
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

Tra gli istanti $t$ e $t+Delta t$, il *vettore spostamento* è

$ Delta vec(r)=vec(r)(t+Delta t)-vec(r)(t). $

Lo spostamento dipende soltanto dagli estremi, non dal percorso seguito; la sua norma è in generale minore o uguale alla lunghezza dell'arco di traiettoria percorso.

#blue-box([Vettori e coordinate])[
  Un vettore geometrico non dipende dal sistema di coordinate scelto, mentre cambiano le sue componenti. Le uguaglianze vettoriali restano valide dopo una rotazione o una traslazione degli assi.
]

== Velocità vettoriale

La velocità media e quella istantanea sono

$ vec(v)_"media"=(Delta vec(r))/(Delta t), quad vec(v)(t)=(dif vec(r))/(dif t). $

In coordinate cartesiane, con versori fissi,

$ vec(v)=v_x hat(i)+v_y hat(j)+v_z hat(k)
  =(dif x)/(dif t) hat(i)+(dif y)/(dif t) hat(j)+(dif z)/(dif t) hat(k). $

Il vettore velocità istantanea è *tangente alla traiettoria* e orientato nel verso del moto. Introducendo l'ascissa curvilinea $s$, cioè la distanza misurata lungo la traiettoria,

$ vec(v)=(dif s)/(dif t) hat(u)_T=v hat(u)_T, $

dove $v=norm(vec(v))=(dif s)/(dif t)$ è la velocità scalare e $hat(u)_T$ è il versore tangente.

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
  axis-label((2.85, 2.68), [$P$], placement: "east")
  axis-label((2.82, 1.25), [$R$], placement: "east")
  axis-label((5.18, 2.5), [$vec(v)$], placement: "west")
  axis-label((2.85, -0.15), [$O$], placement: "east")
})))

== Accelerazione vettoriale

L'accelerazione è la derivata della velocità vettoriale:

$ vec(a)(t)=(dif vec(v))/(dif t)=(dif^2 vec(r))/(dif t^2). $

Quindi una particella accelera sia quando cambia il modulo della velocità, sia quando ne cambia la direzione. Scrivendo $vec(v)=v hat(u)_T$ e derivando:

$ vec(a)=(dif)/(dif t)[v hat(u)_T]
  =(dif v)/(dif t) hat(u)_T+v (dif hat(u)_T)/(dif t). $

Per due tangenti separate da un piccolo angolo $dif theta$, la variazione del versore tangente è diretta lungo la normale e vale

$ dif hat(u)_T=hat(u)_N dif theta. $

Inoltre, dalla geometria dell'arco di raggio di curvatura $R$,

$ dif s=R dif theta quad arrow quad
  (dif theta)/(dif t)=1/R (dif s)/(dif t)=v/R. $

Di conseguenza

$ (dif hat(u)_T)/(dif t)
  =hat(u)_N (dif theta)/(dif t)=v/R hat(u)_N, $

e sostituendo nella derivata di $vec(v)$:

$ vec(a)=underbrace((dif v)/(dif t) hat(u)_T, vec(a)_T)
  +underbrace(v^2/R hat(u)_N, vec(a)_N). $

Qui $R$ è il raggio di curvatura locale e $hat(u)_N$ è diretto verso il centro di curvatura. Pertanto

$ vec(a)=vec(a)_T+vec(a)_N, quad
  a_T=(dif v)/(dif t), quad a_N=v^2/R. $

#grid(columns: (1fr, 1fr), gutter: 10pt,
  graph-card([Moto curvilineo generico], cetz.canvas({
    import cetz.draw: *
    // traiettoria concava verso l'alto; P è il punto comune dei vettori
    catmull((0.25, 0.25), (1.15, 0.48), (2.2, 1.0), (3.2, 1.38), (4.35, 1.52),
      tension: 0.55, stroke: 1.5pt + blue)
    circle((2.2, 1.0), radius: 0.08, fill: ink, stroke: none)
    // a_T tangente alla traiettoria
    line((2.2, 1.0), (3.3, 1.55), stroke: 1.4pt + green, mark: (end: ">"))
    // a_N normale, rivolta verso la concavità
    line((2.2, 1.0), (1.65, 2.1), stroke: 1.4pt + red, mark: (end: ">"))
    // risultante a = a_T + a_N e parallelogramma tratteggiato
    line((2.2, 1.0), (2.75, 2.65), stroke: 1.5pt + gold, mark: (end: ">"))
    line((3.3, 1.55), (2.75, 2.65), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
    line((1.65, 2.1), (2.75, 2.65), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
    axis-label((3.38, 1.52), [$vec(a)_T$], placement: "west")
    axis-label((1.55, 2.18), [$vec(a)_N$], placement: "east")
    axis-label((2.86, 2.72), [$vec(a)$], placement: "west")
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

Le relazioni integrali, valide componente per componente, generalizzano quelle della cinematica 1D:

$ vec(v)(t)=vec(v)(t_0)+integral_(t_0)^t vec(a)(tau) dif tau, $
$ vec(r)(t)=vec(r)(t_0)+integral_(t_0)^t vec(v)(tau) dif tau. $

= Moto parabolico

Consideriamo un proiettile lanciato con velocità iniziale $vec(v)_0$ in un campo gravitazionale uniforme, trascurando la resistenza dell'aria. Scelti $x$ orizzontale, $y$ verticale verso l'alto e $z$ perpendicolare al piano del moto,

$ vec(a)=(0,-g,0), quad vec(v)_0=(v_(0x),v_(0y),0). $

Il moto rimane nel piano $x y$. Le componenti evolvono indipendentemente:

#blue-box([Leggi orarie del moto parabolico])[
  $ v_x(t)=v_(0x), quad x(t)=x_0+v_(0x)t, $

  $ v_y(t)=v_(0y)-g t, quad y(t)=y_0+v_(0y)t-1/2 g t^2. $
]

Lungo $x$ il moto è uniforme; lungo $y$ è uniformemente accelerato. Eliminando $t=(x-x_0)/v_(0x)$ si ottiene la traiettoria:

$ y-y_0=v_(0y)t-1/2 g t^2, $

$ y-y_0=v_(0y)(x-x_0)/v_(0x)
  -1/2 g[(x-x_0)/v_(0x)]^2, $

$ y(x)=y_0+(v_(0y))/(v_(0x))(x-x_0)-g/(2v_(0x)^2)(x-x_0)^2. $

È una parabola con concavità verso il basso.

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

Se il lancio avviene dall'origine e il proiettile torna alla quota iniziale, ponendo
$v_(0x)=v_0 cos theta$ e $v_(0y)=v_0 sin theta$ si ricavano:

All'altezza massima $v_y=0$:

$ 0=v_0 sin theta-g t_"max"
  quad arrow quad t_"max"=(v_0 sin theta)/g. $

La quota massima segue sostituendo $t_"max"$ in $y(t)$:

$ h_"max"=v_0 sin theta (v_0 sin theta)/g
  -1/2 g (v_0 sin theta/g)^2
  =(v_0^2 sin^2 theta)/(2g). $

Per tornare a $y=0$:

$ 0=t(v_0 sin theta-1/2 g t), $

da cui, esclusa la soluzione iniziale $t=0$,

$ t_"volo"=(2v_0 sin theta)/g. $

La gittata è la posizione orizzontale a questo istante:

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

= Moto circolare uniforme

Nel moto circolare uniforme la traiettoria è una circonferenza di raggio $R$ e il modulo della velocità è costante. La velocità è tangente alla circonferenza, mentre l'accelerazione punta sempre verso il centro:

$ a_T=0, quad vec(a)=vec(a)_N, quad a_N=v^2/R. $

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

Se $theta$ è misurato in radianti, l'arco percorso è $s=R theta$. La velocità angolare è

$ omega=(dif theta)/(dif t)=1/R (dif s)/(dif t)=v/R. $

La sua unità di misura è il radiante al secondo, $"rad"/"s"$; il radiante è adimensionale. Il periodo $T$ si misura in secondi.

Nel moto circolare uniforme $omega$ è costante, quindi

$ theta(t)=theta_0+omega t, quad
  T=(2pi)/omega=(2pi R)/v, quad f=1/T. $

La legge angolare deriva dall'integrazione di $omega=(dif theta)/(dif t)$:

$ dif theta=omega dif t, quad
  integral_(theta_0)^(theta(t)) dif theta=integral_0^t omega dif tau, $

$ theta(t)-theta_0=omega t. $

Durante un periodo l'angolo aumenta di $2pi$; dunque $omega T=2pi$. Poiché in un giro si percorre $2pi R$ a velocità $v$, segue anche $T=2pi R/v$.

Le coordinate cartesiane sono

$ x(t)=R cos(omega t+theta_0), quad y(t)=R sin(omega t+theta_0). $

Ogni coordinata è dunque un moto armonico semplice: il moto circolare uniforme proiettato su un diametro produce un'oscillazione armonica.

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

$ vec(v)=vec(omega) times vec(R). $

Derivando nel caso più generale:

$ vec(a)=(dif vec(omega))/(dif t) times vec(R)+vec(omega) times vec(v)
  =vec(alpha) times vec(R)+vec(omega) times (vec(omega) times vec(R)), $

dove

$ vec(alpha)=(dif vec(omega))/(dif t) $

è l'accelerazione angolare. Il primo termine è tangenziale; il secondo è centripeto. Nel moto circolare uniforme $vec(alpha)=vec(0)$ e resta

$ vec(a)=vec(omega) times (vec(omega) times vec(R))=-omega^2 vec(R). $

L'ultima uguaglianza segue perché $vec(omega)$ è perpendicolare a $vec(R)$: il doppio prodotto vettoriale è antiparallelo a $vec(R)$ e ha modulo $omega^2R$. In forma scalare si ritrova

$ a_N=omega^2R=(omega R)^2/R=v^2/R. $

#pagebreak()

= Dinamica del punto materiale

La *dinamica* studia le cause del moto. Il sistema più semplice è il punto materiale; i risultati verranno poi estesi a sistemi di particelle e corpi rigidi.

== Forza

#green-box([Definizione operativa])[
  Una *forza* $vec(F)$ descrive un'interazione tra il punto materiale scelto come sistema e il suo ambiente. È una grandezza vettoriale: possiede modulo, direzione e verso.
]

Per analizzare una forza occorre quindi distinguere sempre:

- il corpo sul quale la forza agisce;
- il corpo dell'ambiente che esercita la forza;
- la direzione e il verso dell'interazione.

Il modello di punto materiale trascura dimensioni, rotazioni e moti interni. Quando queste caratteristiche sono rilevanti si deve usare il modello di corpo rigido.

== Prima legge di Newton: principio di inerzia

#blue-box([Prima legge di Newton])[
  In assenza di forze risultanti, un corpo mantiene il proprio stato di moto: resta in quiete oppure si muove di moto rettilineo uniforme.

  $ vec(F)_"tot"=vec(0) quad arrow quad vec(a)=vec(0) quad arrow quad vec(v)="costante". $
]

I sistemi di riferimento nei quali vale il principio di inerzia si chiamano *sistemi inerziali*. La quiete non è uno stato fisicamente privilegiato: è il caso particolare del moto uniforme con $vec(v)=vec(0)$.

== Massa inerziale

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

La massa definita attraverso questa risposta dinamica prende il nome di *massa inerziale*.

== Seconda legge di Newton

#red-box([Seconda legge di Newton])[
  In un sistema inerziale la risultante delle forze applicate a un punto materiale è uguale al prodotto della sua massa per l'accelerazione:

  $ vec(F)_"tot"=sum_i vec(F)_i=m vec(a). $
]

La relazione è vettoriale: $vec(F)_"tot"$ e $vec(a)$ hanno la stessa direzione e lo stesso verso. In coordinate cartesiane equivale alle tre equazioni scalari

$ F_x=m a_x, quad F_y=m a_y, quad F_z=m a_z. $

L'unità SI della forza è il newton:

$ 1 " N"=1 " kg" " m"/"s"^2. $

Per massa fissata, $a prop F$; per forza fissata, $a prop 1/m$.

=== Principio di sovrapposizione

Se più corpi dell'ambiente interagiscono con il sistema, ciascuno esercita la propria forza indipendentemente dalle altre. L'effetto complessivo è dato dalla somma vettoriale:

$ vec(F)_"tot"=vec(F)_1+vec(F)_2+...+vec(F)_n. $

#yellow-box([Risultante])[
  La risultante non è una forza aggiuntiva: è il vettore che rappresenta la somma di tutte le forze realmente esercitate sul corpo.
]

== Quantità di moto

La *quantità di moto* di una particella è

$ vec(p)=m vec(v), $

e si misura in $"kg m/s"$. La seconda legge può essere scritta nella forma più generale

$ vec(F)_"tot"=(dif vec(p))/(dif t). $

Se la massa è costante,

$ (dif vec(p))/(dif t)=(dif)/(dif t)(m vec(v))
  =m (dif vec(v))/(dif t)=m vec(a), $

e si ritrova $vec(F)_"tot"=m vec(a)$.

=== Impulso

Dalla forma $dif vec(p)=vec(F)_"tot" dif t$, integrando tra $t_0$ e $t$ si ottiene

$ integral_(vec(p)(t_0))^(vec(p)(t)) dif vec(p)
  =integral_(t_0)^t vec(F)_"tot"(tau) dif tau. $

Si definisce *impulso* della forza risultante

#purple-box([Teorema dell'impulso])[
  $ vec(J)=integral_(t_0)^t vec(F)_"tot"(tau) dif tau
    =Delta vec(p)=vec(p)(t)-vec(p)(t_0). $
]

Se la forza è costante nell'intervallo $Delta t=t-t_0$,

$ vec(J)=vec(F)_"tot" Delta t. $

Se $vec(F)_"tot"=vec(0)$, allora $dif vec(p)=vec(0)$ e la quantità di moto si conserva:

$ vec(p)="costante". $

== Terza legge di Newton: azione e reazione

Quando due corpi $A$ e $B$ interagiscono, indichiamo con $vec(F)_(A B)$ la forza esercitata da $B$ sul corpo $A$ e con $vec(F)_(B A)$ la forza esercitata da $A$ sul corpo $B$. Le due forze sono opposte:

#blue-box([Terza legge di Newton])[
  $ vec(F)_(A B)=-vec(F)_(B A). $

  Le due forze hanno stesso modulo e stessa direzione, ma verso opposto.
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

= Metodo di analisi dei problemi dinamici

Per impostare correttamente un problema:

1. identificare il corpo o sistema da analizzare;
2. identificare i corpi dell'ambiente che interagiscono con esso;
3. scegliere un sistema di riferimento inerziale;
4. isolare il sistema e disegnare il *diagramma delle forze*;
5. scegliere assi cartesiani convenienti $x,y,z$;
6. applicare la seconda legge di Newton a ogni corpo del sistema.

Si arriva così a un'equazione vettoriale

$ vec(R)=sum_i vec(F)_i=m vec(a), $

da proiettare sugli assi scelti. Le soluzioni principali sono:

- $vec(R)=vec(0)$: equilibrio statico oppure moto rettilineo uniforme;
- $vec(R)!=vec(0)$: moto accelerato.

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

Nel moto curvilineo l'equazione generale si può scomporre lungo tangente e normale:

$ vec(F)_"tot"=m vec(a)_T+m vec(a)_N. $

La componente tangenziale cambia il modulo della velocità; quella normale ne cambia la direzione.

= Forze agenti nella meccanica

== Forza peso

Vicino alla superficie terrestre il campo gravitazionale è approssimativamente uniforme, con

$ g approx 9.81 " m/s"^2. $

La forza peso esercitata dalla Terra su un corpo è

$ vec(F)_"peso"=m_g vec(g), $

dove $m_g$ è la *massa gravitazionale*, che misura l'intensità dell'interazione con il campo gravitazionale.

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

#yellow-box([Due ruoli della massa])[
  La massa gravitazionale determina la forza peso; la massa inerziale determina la risposta del corpo alla forza. La loro equivalenza spiega l'universalità della caduta libera.
]

== Forza elastica

Una molla ideale esercita una forza proporzionale e contraria allo spostamento dalla posizione di equilibrio:

#blue-box([Legge di Hooke])[
  $ vec(F)_"el"=-k x hat(u)_x, $

  dove $k>0$ è la *costante elastica*, misurata in $"N/m"$, e $x$ è lo spostamento dalla posizione di equilibrio $x=0$.
]

#align(center, graph-card([Forza elastica opposta allo spostamento], cetz.canvas({
  import cetz.draw: *
  // parete e asse x
  line((0.6, 0.15), (0.6, 2.15), stroke: 1.3pt + ink)
  for y in range(0, 6) { line((0.35, 0.25 + y*0.34), (0.6, 0.48 + y*0.34), stroke: 0.7pt + ink) }
  line((0.6, 1.15), (6.5, 1.15), stroke: 0.8pt + grid-color, mark: (end: ">"))
  // molla e punto materiale spostato a destra
  cetz.decorations.coil(line((0.6, 1.15), (3.65, 1.15)), amplitude: 0.18, start: 5%, stop: 95%, stroke: 1.4pt + blue)
  circle((3.65, 1.15), radius: 0.13, fill: ink, stroke: none)
  line((3.65, 1.15), (2.35, 1.15), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((6.5, 0.97), [$x$], placement: "north")
  axis-label((2.85, 1.43), [$vec(F)_"el"$], placement: "south")
  axis-label((3.65, 0.9), [$x>0$], placement: "north")
})))

Applicando la seconda legge lungo $x$:

$ m (dif^2 x)/(dif t^2)=-k x, $

quindi

$ (dif^2 x)/(dif t^2)+k/m x=0. $

È l'equazione del moto armonico semplice, con

$ omega=sqrt(k/m), quad T=(2pi)/omega=2pi sqrt(m/k). $

= Reazioni vincolari

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

$ m vec(g)+vec(N)=vec(0) quad arrow quad N=m g. $

#align(center, graph-card([Diagramma delle forze: appoggio orizzontale], cetz.canvas({
  import cetz.draw: *
  circle((2.4, 1.35), radius: 0.09, fill: ink, stroke: none)
  line((2.4, 1.35), (2.4, 2.75), stroke: 1.6pt + green, mark: (end: ">"))
  line((2.4, 1.35), (2.4, -0.05), stroke: 1.6pt + red, mark: (end: ">"))
  axis-label((2.62, 2.68), [$vec(N)$], placement: "west")
  axis-label((2.62, 0.05), [$m vec(g)$], placement: "west")
})))

Se una forza esterna $vec(F)$ spinge ulteriormente il corpo verso il basso,

$ m vec(g)+vec(F)+vec(N)=vec(0) quad arrow quad N=m g+F. $

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
  line((0.95, 1.72), (1.62, 2.08), stroke: 0.8pt + ink, mark: (end: ">"))
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

= Tensione della fune

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

$ -T_A cos 30 degree+T_B cos 45 degree=0, $
$ T_A sin 30 degree+T_B sin 45 degree-T_C=0. $

= Corpo tirato da una fune su superficie liscia

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

$ F cos theta=m a_x, $
$ N+F sin theta-m g=0. $

Quindi

$ a_x=(F cos theta)/m, quad N=m g-F sin theta. $

Se $F$ è costante, il moto lungo $x$ è uniformemente accelerato:

$ x(t)=x_0+v_0t+1/2 (F cos theta)/m t^2. $

Il blocco si stacca dalla superficie quando $N=0$; la soglia è

$ F sin theta=m g quad arrow quad F=(m g)/(sin theta). $

= Piano inclinato liscio

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

$ T-m g sin theta=0, quad N-m g cos theta=0, $

da cui

$ T=m g sin theta, quad N=m g cos theta. $

Se si taglia la fune, lungo il piano rimane soltanto la componente del peso:

$ m g sin theta=m a_x quad arrow quad a_x=g sin theta, $

mentre normalmente

$ N-m g cos theta=0 quad arrow quad N=m g cos theta. $

Il moto lungo $x$ è uniformemente accelerato:

$ x(t)=x_0+v_0t+1/2 g sin theta, t^2, $
$ v(t)=v_0+g sin theta, t. $

= Forza di attrito

L'attrito radente è la forza tangenziale che nasce al contatto tra due superfici e si oppone al moto relativo, oppure alla tendenza al moto relativo. La sua direzione è parallela alla superficie di contatto.

#blue-box([Attrito statico e dinamico])[
  - *Attrito statico*: il corpo resta fermo rispetto alla superficie, quindi $v=0$. Il modulo si adatta al valore necessario per mantenere l'equilibrio, fino a un massimo:
    $ F_"attr,s" <= mu_s N. $
  - *Attrito dinamico*: il corpo scivola, quindi $v != 0$. Il modulo è
    $ F_"attr,d" = mu_d N, $
    e il verso è opposto alla velocità relativa.

  In genere $mu_s > mu_d$: serve più forza per mettere in moto un corpo che per mantenerlo in scorrimento.
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

Lungo $y$ il corpo non accelera, quindi

$ N-m g=0 quad arrow quad N=m g. $

Lungo $x$, se il blocco è in quiete, l'attrito statico compensa la forza applicata: $F_"attr,s"=F$. Questa condizione può valere solo finché

$ F <= mu_s m g. $

Se il corpo scivola verso destra, l'attrito dinamico è verso sinistra. L'equazione lungo $x$ diventa

$ F-mu_d m g=m a quad arrow quad a=(F-mu_d m g)/m. $

== Forza inclinata e attrito

Se la forza applicata forma un angolo $theta$ sopra l'orizzontale, prima si scompone $vec(F)$ lungo gli assi scelti:

$ F_x=F cos theta, quad F_y=F sin theta. $

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

Lungo $x$, in quiete l'attrito statico deve equilibrare la componente orizzontale della forza:

$ F cos theta <= mu_s (m g-F sin theta). $

Se il corpo è in moto verso destra, l'attrito è dinamico e ha verso opposto al moto:

$ F cos theta-mu_d (m g-F sin theta)=m a_x, $

cioè

$ a_x=(F cos theta-mu_d (m g-F sin theta))/m. $

== Esempio: piano inclinato scabro

Consideriamo un blocco su un piano inclinato scabro di angolo $theta$. Scegliamo $x$ parallelo al piano verso valle e $y$ perpendicolare al piano verso l'esterno. Il peso si scompone in:

$ m g sin theta quad "lungo " x " verso valle", $
$ m g cos theta quad "lungo " y " verso il piano". $

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
  line((1.05, 1.3), (1.75, 1.68), stroke: 0.8pt + ink, mark: (end: ">"))
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
  line((7.15, 1.55), (8.05, 2.05), stroke: 0.8pt + ink, mark: (end: ">"))
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

Lungo $x$ bisogna distinguere quiete e moto.

Se il blocco resta fermo, l'attrito è statico e deve bilanciare la componente del peso lungo il piano:

$ m g sin theta-F_"attr,s"=0, quad F_"attr,s"=m g sin theta. $

Questo è possibile solo se

$ m g sin theta <= mu_s N=mu_s m g cos theta, $

cioè

$ tan theta <= mu_s. $

Se invece il blocco scivola verso valle, l'attrito è dinamico:

$ F_"attr,d"=mu_d N=mu_d m g cos theta. $

L'equazione lungo $x$ diventa

$ m g sin theta-mu_d m g cos theta=m a, $

quindi

$ a=g(sin theta-mu_d cos theta). $

= Sistemi con più corpi

Quando due corpi sono collegati da una fune ideale, la fune impone un vincolo cinematico: i moduli delle accelerazioni sono uguali. Per una fune ideale e una carrucola ideale anche il modulo della tensione è lo stesso in ogni tratto.

#yellow-box([Fune ideale])[
  Fune ideale significa massa trascurabile, inestensibilità e assenza di attrito nelle carrucole. In queste ipotesi:
  $ |a_1|=|a_2|=a, quad T_1=T_2=T. $
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

Sommando le due equazioni,

$ a=(m_2 g)/(m_1+m_2), quad T=(m_1 m_2 g)/(m_1+m_2). $

Il moto è uniformemente accelerato se le masse sono costanti e le forze esterne non cambiano.

== Macchina di Atwood

Due masse sospese alla stessa carrucola ideale accelerano in versi opposti. Se $m_1>m_2$, scegliamo positivo verso il basso per $m_1$ e verso l'alto per $m_2$.

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

Da cui

$ a=((m_1-m_2) g)/(m_1+m_2), quad T=(2m_1 m_2 g)/(m_1+m_2). $

== Piano inclinato con massa sospesa

Nel caso degli appunti, $m_1$ è su un piano liscio inclinato di $theta$ e $m_2$ è sospesa. Se $m_2$ scende, $m_1$ sale lungo il piano. Per $m_1$ conviene usare assi locali: $x$ parallelo al piano verso l'alto e $y$ perpendicolare al piano verso l'esterno.

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
  line((6.25, 1.55), (7.05, 2.05), stroke: 0.8pt + ink, mark: (end: ">"))
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

Lungo $y$ non c'è accelerazione, quindi $N=m_1 g cos theta$. Le equazioni lungo le direzioni di moto sono invece

$ T-m_1 g sin theta=m_1 a, $
$ m_2 g-T=m_2 a. $

Quindi

$ a=(m_2 g-m_1 g sin theta)/(m_1+m_2), $
$ T=m_1 g sin theta+m_1 a. $

= Dinamica del moto circolare uniforme

Nel moto circolare uniforme il modulo della velocità è costante, ma il vettore velocità cambia direzione. L'accelerazione è centripeta:

$ a_c=v^2/R. $

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

Scegliendo $x$ radiale verso il centro e $y$ verticale:

$ T sin theta=m v^2/R, $
$ T cos theta-m g=0. $

Da qui

$ T=(m g)/(cos theta), quad tan theta=v^2/(R g), $

e quindi

$ v=sqrt(R g tan theta). $

Poiché $T_"periodo"=(2 pi R)/v$,

$ T_"periodo"=2 pi sqrt(R/(g tan theta)). $

= Dinamometro statico

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

La misura della forza si ricava quindi da $F=k x$.

= Lavoro ed energia

Il lavoro misura quanta energia viene trasferita da una forza durante uno spostamento. Conta solo la componente della forza parallela allo spostamento.

#blue-box([Lavoro elementare])[
  Per uno spostamento infinitesimo $dif vec(s)$,

  $ dif L=vec(F) dot dif vec(s). $

  L'unità di misura è il joule:

  $ 1 "J"=1 "N" dot "m". $
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

Se la forza è costante lungo uno spostamento rettilineo da $A$ a $B$,

$ L=integral_A^B vec(F) dot dif vec(s). $

In particolare, se $vec(F)$ è parallela e concorde allo spostamento,

$ L=F s. $

== Esempio: blocco su piano inclinato liscio

Un blocco sale lungo un piano inclinato liscio per uno spostamento $s$, con velocità costante. Usiamo $x$ parallelo al piano verso l'alto e $y$ perpendicolare al piano verso l'esterno. Il peso si scompone in $m g sin theta$ lungo il piano verso il basso e $m g cos theta$ lungo la normale entrante.

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

Lungo $x$:

$ F-m g sin theta=0. $

Il lavoro della forza esterna è

$ L=F s=m g sin theta, s=m g h. $

== Lavoro della forza elastica

Per una molla ideale lungo l'asse $x$ vale

$ F_"el"(x)=-k x. $

Il lavoro tra due posizioni $x_A$ e $x_B$ è

$ L_"el"=integral_(x_A)^(x_B) (-k x) dif x
  =-1/2 k (x_B^2-x_A^2). $

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

Il segno dipende dal verso dello spostamento rispetto alla forza elastica: quando la molla riporta il corpo verso l'equilibrio, il lavoro è positivo.

== Lavoro della forza peso

La forza peso è $m vec(g)$ e, vicino alla superficie terrestre, è costante e verticale verso il basso. Se l'asse $y$ è verso l'alto,

$ vec(F)_p=-m g hat(u)_y. $

Per uno spostamento qualunque da $A$ a $B$:

$ L_p=integral_A^B vec(F)_p dot dif vec(s)
  =-m g (y_B-y_A)=m g (y_A-y_B). $

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

== Potenza

La potenza misura quanto rapidamente viene compiuto lavoro:

#blue-box([Potenza])[
  $ P=(dif L)/(dif t). $

  L'unità di misura è il watt:

  $ 1 "W"=1 "J/s". $
]

Se la forza è applicata a un punto che si muove con velocità $vec(v)$,

$ P=vec(F) dot (dif vec(s))/(dif t)=vec(F) dot vec(v). $

= Energia cinetica

L'energia cinetica è l'energia associata al moto:

#blue-box([Energia cinetica])[
  $ E_k=1/2 m v^2. $
]

Partendo dalla seconda legge, $vec(F)_"tot"=m dif vec(v)/dif t$, il lavoro elementare della risultante è

$ dif L=vec(F)_"tot" dot dif vec(s)
  =m (dif vec(v))/(dif t) dot dif vec(s)
  =m vec(v) dot dif vec(v). $

Integrando tra $A$ e $B$:

$ L_"tot"=integral_A^B dif L
  =1/2 m v_B^2-1/2 m v_A^2
  =Delta E_k. $

#yellow-box([Teorema dell'energia cinetica])[
  Il lavoro della risultante delle forze applicate a un punto materiale è uguale alla variazione della sua energia cinetica:

  $ L_"tot"=Delta E_k. $
]

== Esempio: caduta libera

Un corpo cade da fermo da un'altezza $h$, trascurando l'attrito dell'aria. Il solo lavoro è quello della forza peso:

$ L_p=m g h. $

Poiché $v_0=0$, l'energia cinetica iniziale è nulla. Dal teorema dell'energia cinetica:

$ m g h=1/2 m v_f^2, $

da cui

$ v_f=sqrt(2 g h). $

== Esempio: compressione di una molla

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

== Lavoro della forza di attrito

Per attrito dinamico su una superficie con normale costante,

$ F_"attr"=mu_d N $

e il verso è sempre opposto allo spostamento relativo. Se il corpo percorre una lunghezza $s$,

$ L_"attr"=-mu_d N s. $

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

Una forza è *conservativa* se il lavoro totale lungo ogni percorso chiuso è nullo:

$ integral_"ciclo" vec(F) dot dif vec(s)=0. $

Equivalentemente, il lavoro tra due punti $A$ e $B$ non dipende dal percorso scelto, ma solo dagli estremi:

$ integral_A^B vec(F) dot dif vec(s) quad "è lo stesso per ogni percorso da " A " a " B. $

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

== Energia potenziale

Per una forza conservativa esiste una funzione di stato, detta energia potenziale $E_p$, tale che

$ L_(A B)=-Delta E_p=E_p(A)-E_p(B). $

Le energie potenziali più usate in questi appunti sono:

$ E_(p,g)=m g y, quad E_(p,"el")=1/2 k x^2. $

La quota zero e la posizione $x=0$ sono scelte di riferimento: cambiare lo zero dell'energia potenziale non cambia la fisica, perché contano le variazioni.

== Energia meccanica

Definiamo l'energia meccanica come

$ E=E_k+E_p. $

Dal teorema dell'energia cinetica:

$ L_"tot"=Delta E_k. $

Se agiscono solo forze conservative, allora $L_"tot"=-Delta E_p$, quindi

$ Delta E_k+Delta E_p=0, $

cioè

$ E_k+E_p="costante". $

#green-box([Conservazione dell'energia meccanica])[
  Se le uniche forze che compiono lavoro sono conservative, l'energia meccanica si conserva:

  $ E_A=E_B. $
]

== Esempio: scambio tra energia potenziale e cinetica

In assenza di attrito, durante una discesa la perdita di energia potenziale gravitazionale diventa energia cinetica:

$ m g h=1/2 m v^2 quad arrow quad v=sqrt(2 g h). $

Per una molla su piano liscio, l'energia elastica può trasformarsi in energia cinetica:

$ 1/2 k x^2=1/2 m v^2. $

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

Se agiscono anche forze non conservative, separiamo il lavoro totale:

$ L_"tot"=L_"cons"+L_"non cons". $

Poiché $L_"tot"=Delta E_k$ e $L_"cons"=-Delta E_p$,

$ L_"non cons"=Delta E_k+Delta E_p=Delta E. $

#yellow-box([Bilancio dell'energia meccanica])[
  Il lavoro delle forze non conservative è uguale alla variazione dell'energia meccanica:

  $ L_"non cons"=Delta E_"meccanica". $
]

Per l'attrito dinamico su un tratto scabro orizzontale,

$ L_"attr"=-mu_d m g s, $

quindi l'energia meccanica diminuisce.

== Esempio: guida senza attrito e tratto scabro

Nel tratto senza attrito la gravità è conservativa, quindi l'energia meccanica resta costante. Se un corpo parte da $A$ con velocità nulla e quota $h_A$, allora in un punto $B$ di quota $h_B$:

$ m g h_A=1/2 m v_B^2+m g h_B. $

Se $h_B=h_A$, allora $v_B=0$; se il corpo arriva al fondo con quota zero,

$ v=sqrt(2 g h_A). $

Se invece la velocità iniziale in $A$ non è nulla,

$ 1/2 m v_A^2+m g h_A=m g h_B $

quando il corpo si ferma in $B$, e quindi

$ h_B=h_A+v_A^2/(2g). $

Su un tratto orizzontale scabro $P Q$ di lunghezza $s_(P Q)$:

$ Delta E= L_"attr"=-mu_d m g s_(P Q). $

Poiché su quel tratto non cambia l'energia potenziale,

$ 1/2 m v_Q^2-1/2 m v_P^2=-mu_d m g s_(P Q). $

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

Consideriamo un corpo che parte da fermo da quota $h$ e scende lungo un piano inclinato scabro di angolo $theta$. La lunghezza percorsa sul piano è

$ Delta s=h/sin theta. $

La normale vale $N=m g cos theta$, quindi il lavoro dell'attrito dinamico è

$ L_"attr"=-mu_d N Delta s=-mu_d m g cos theta h/sin theta=-mu_d m g h/tan theta. $

Il bilancio dell'energia meccanica diventa

$ L_"attr"=Delta E=1/2 m v_f^2-m g h. $

Sostituendo il lavoro dell'attrito:

$ -mu_d m g h/tan theta=1/2 m v_f^2-m g h, $

da cui

$ v_f^2=2 g h (1-mu_d/tan theta). $

#yellow-box([Condizione fisica])[
  La formula ha senso solo se il termine tra parentesi è non negativo e se il corpo riesce effettivamente a scivolare lungo il piano. L'attrito sottrae energia meccanica, quindi la velocità finale è minore del caso liscio $sqrt(2 g h)$.
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

Il *momento angolare* di una particella rispetto a un polo fisso $O$ è definito come

$ vec(ell)_O=vec(r) times vec(p)=vec(r) times m vec(v). $

Il vettore $vec(r)$ va dal polo $O$ alla particella. L'unità di misura è $"kg m"^2"/s"$, equivalente a $"N m s"$.

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

Per un sistema di particelle conta il momento totale delle forze esterne. Se la risultante dei momenti esterni è nulla,

$ sum vec(tau)_"ext"=vec(0) quad arrow quad vec(ell)_"tot"="costante". $

Analogamente, se la risultante delle forze esterne è nulla,

$ sum vec(F)_"ext"=vec(0) quad arrow quad vec(P)_"tot"="costante". $

== Momento dell'impulso

Il teorema dell'impulso già visto per la quantità di moto si scrive

$ vec(J)=integral_(t_1)^(t_2) vec(F) dif t=Delta vec(p). $

Per il momento angolare:

$ integral_(t_1)^(t_2) vec(tau)_O dif t=Delta vec(ell)_O. $

Se durante l'urto il vettore $vec(r)$ rispetto al polo può essere considerato costante,

$ integral_(t_1)^(t_2) (vec(r) times vec(F)) dif t
  =vec(r) times integral_(t_1)^(t_2) vec(F) dif t
  =vec(r) times vec(J). $

= Pendolo semplice

Un pendolo semplice è formato da una massa puntiforme $m$ appesa a un filo ideale di lunghezza $ell$. Le forze sono la tensione $vec(T)$ del filo e il peso $m vec(g)$.

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

Scomponiamo il moto lungo due direzioni locali:

- asse *radiale* $y$, lungo il filo verso il punto di sospensione;
- asse *tangenziale* $x$, lungo l'arco di traiettoria.

Le accelerazioni sono

$ a_y=v^2/ell, quad a_x=ell (dif^2 theta)/(dif t^2). $

Lungo la direzione radiale:

$ T-m g cos theta=m v^2/ell. $

Lungo la direzione tangenziale:

$ -m g sin theta=m ell (dif^2 theta)/(dif t^2). $

Dividendo per $m ell$ si ottiene l'equazione differenziale del pendolo:

$ (dif^2 theta)/(dif t^2)+g/ell sin theta=0. $

== Piccole oscillazioni

Per angoli piccoli, misurati in radianti,

$ sin theta approx theta. $

L'equazione del pendolo diventa quella di un oscillatore armonico:

$ (dif^2 theta)/(dif t^2)+g/ell theta=0. $

Confrontando con $theta''+omega^2 theta=0$:

$ omega^2=g/ell, quad omega=sqrt(g/ell). $

Il periodo delle piccole oscillazioni è

#green-box([Periodo del pendolo semplice])[
  $ T_"periodo"=2 pi/omega=2 pi sqrt(ell/g). $
]

La legge oraria può essere scritta nella forma

$ theta(t)=theta_0 sin(omega t+phi). $

#yellow-box([Isocronismo delle piccole oscillazioni])[
  Nel limite di piccoli angoli il periodo non dipende dall'ampiezza iniziale, ma solo da $ell$ e da $g$.
]

= Dinamica dei sistemi di punti materiali

Un sistema di punti materiali è un insieme di particelle considerate insieme. Le forze agenti su una particella del sistema si dividono in:

- *forze esterne*, dovute a corpi esterni al sistema;
- *forze interne*, dovute all'interazione con le altre particelle del sistema.

Le forze interne possono essere elastiche, gravitazionali, elettriche, magnetiche, dovute a deformazioni o attriti; possono quindi essere conservative oppure non conservative.

Per la particella $i$:

$ vec(F)_(i,"tot")=vec(F)_i^"ext"+vec(F)_i^"int"=m_i vec(a)_i. $

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

Per ogni coppia di particelle $i,j$ vale il principio di azione e reazione:

$ vec(F)_(i j)=-vec(F)_(j i). $

Le forze interne si cancellano a coppie nella somma su tutto il sistema, quindi

#green-box([Risultante interna nulla])[
  $ vec(R)^"int"=sum_i vec(F)_i^"int"=vec(0). $
]

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

Per ogni particella $i$ del sistema si definiscono:

$ vec(r)_i quad vec(v)_i quad vec(a)_i=(vec(F)_i)/(m_i). $

La quantità di moto, il momento angolare rispetto al polo $O$ e l'energia cinetica della particella sono:

$ vec(p)_i=m_i vec(v)_i, $

$ vec(ell)_i=vec(r)_i times m_i vec(v)_i, $

$ E_(k,i)=1/2 m_i v_i^2. $

Le corrispondenti grandezze del sistema sono le somme sulle particelle:

$ vec(P)=sum_i m_i vec(v)_i, quad
   vec(ell)=sum_i vec(r)_i times m_i vec(v)_i, quad
   E_k=sum_i 1/2 m_i v_i^2. $

== Centro di massa

La massa totale del sistema è

$ M=sum_i m_i. $

Il *centro di massa* è il punto geometrico definito da

#blue-box([Centro di massa])[
  $ vec(r)_"CM"=(sum_i m_i vec(r)_i)/(sum_i m_i)=(1/M) sum_i m_i vec(r)_i. $
]

Derivando rispetto al tempo:

$ vec(v)_"CM"=(dif vec(r)_"CM")/(dif t)
  =(1/M) sum_i m_i vec(v)_i
  =vec(P)/M. $

Quindi la quantità di moto totale del sistema può essere scritta come

$ vec(P)=M vec(v)_"CM". $

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

Derivando ancora:

$ vec(a)_"CM"=(1/M) sum_i m_i vec(a)_i
  =(1/M) sum_i (vec(F)_i^"int"+vec(F)_i^"ext"). $

Poiché $sum_i vec(F)_i^"int"=vec(0)$, resta solo la risultante delle forze esterne:

#purple-box([Moto del centro di massa])[
  $ M vec(a)_"CM"=vec(R)^"ext"=(dif vec(P))/(dif t). $
]

Il moto del centro di massa è determinato soltanto dalle forze esterne. Le forze interne possono cambiare il moto relativo delle parti, ma non il moto complessivo del centro di massa.

== Esempio: frammentazione in caduta

Se un corpo esplode o si frammenta mentre cade, i pezzi possono seguire traiettorie diverse per effetto delle forze interne. Tuttavia, se l'unica forza esterna è il peso totale,

$ M vec(a)_"CM"=sum_i m_i vec(g)=M vec(g), $

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

Se il sistema è isolato rispetto alle traslazioni, cioè se la risultante delle forze esterne è nulla,

$ vec(R)^"ext"=vec(0), $

allora

#green-box([Quantità di moto totale conservata])[
  $ (dif vec(P))/(dif t)=vec(0) quad arrow quad vec(P)="costante". $
]

Poiché $vec(P)=M vec(v)_"CM"$, per massa totale costante:

$ vec(v)_"CM"="costante", quad vec(a)_"CM"=vec(0). $

== Momento angolare del sistema

Rispetto a un polo $O$, il momento angolare totale del sistema è

$ vec(ell)_O=sum_i vec(r)_i times m_i vec(v)_i. $

Se il polo $O$ è fisso in un sistema inerziale, allora

$ (dif vec(ell)_O)/(dif t)=sum_i vec(r)_i times m_i vec(a)_i
  =sum_i vec(r)_i times (vec(F)_i^"ext"+vec(F)_i^"int"). $

Il momento totale delle forze interne è nullo quando le forze interne sono centrali, cioè dirette lungo la congiungente tra le due particelle. Infatti, per una coppia $i,j$:

$ vec(r)_i times vec(F)_(i j)+vec(r)_j times vec(F)_(j i)
  =(vec(r)_i-vec(r)_j) times vec(F)_(i j)=vec(0). $

Rimane quindi il momento delle sole forze esterne:

#purple-box([Momento angolare di un sistema, polo fisso])[
  $ (dif vec(ell)_O)/(dif t)=vec(tau)^"ext"_O. $
]

Se $vec(tau)^"ext"_O=vec(0)$, allora

$ vec(ell)_O="costante". $

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

Per la particella $i$ il lavoro elementare della forza totale è

$ dif L_i=vec(F)_i dot dif vec(r)_i
  =(vec(F)_i^"ext"+vec(F)_i^"int") dot dif vec(r)_i
  =dif L_i^"ext"+dif L_i^"int". $

Sommando su tutte le particelle del sistema:

$ L=sum_i L_i=L^"ext"+L^"int". $

Per ogni particella vale $vec(F)_i=m_i vec(a)_i$, quindi

$ integral vec(F)_i dot dif vec(r)_i
  =integral m_i vec(v)_i dot dif vec(v)_i
  =1/2 m_i v_(i,B)^2-1/2 m_i v_(i,A)^2. $

Sommando:

#purple-box([Energia cinetica di un sistema])[
  $ L^"ext"+L^"int"=Delta E_k, $

  con $E_k=sum_i 1/2 m_i v_i^2$.
]

Le forze interne hanno risultante nulla, ma il loro lavoro totale in generale non è nullo: possono cambiare le distanze mutue, deformare il sistema o trasformare energia cinetica in energia interna.

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

Se le forze che compiono lavoro sono conservative, il loro lavoro è l'opposto della variazione di energia potenziale:

$ L_"conserv"=Delta E_k=-Delta E_p. $

Di conseguenza l'energia meccanica totale del sistema si conserva:

$ E=E_k+E_p="costante". $

Se invece sono presenti forze non conservative,

#yellow-box([Bilancio energetico per sistemi])[
  $ L_"non conserv"=Delta E_"meccanica". $
]

Questa forma vale anche per sistemi di punti materiali: l'energia potenziale e l'energia cinetica sono quelle totali del sistema.

== Conservazioni e simmetrie

Nella fisica moderna le leggi di conservazione sono collegate alle simmetrie:

- $vec(P)$ costante: lo spazio è omogeneo, cioè non esiste un'origine privilegiata;
- $vec(ell)$ costante: lo spazio è isotropo, cioè non esiste una direzione privilegiata;
- $E$ costante: il tempo è omogeneo, cioè non esiste un istante privilegiato.

= Urti

Un urto è un'interazione molto breve tra corpi. Durante l'intervallo dell'urto le forze interne sono molto intense e impulsive:

$ vec(J)=integral_(Delta t) vec(F) dif t. $

Se le forze esterne sono trascurabili durante l'urto, la quantità di moto totale del sistema si conserva sempre:

#green-box([Quantità di moto negli urti])[
  $ vec(P)_"iniziale"=vec(P)_"finale". $
]

Per due masse:

$ m_1 vec(v)_1+m_2 vec(v)_2=m_1 vec(v)'_1+m_2 vec(v)'_2. $

Inoltre

$ vec(P)=(m_1+m_2) vec(v)_"CM", $

quindi, se il sistema è isolato durante l'urto, $vec(v)_"CM"$ resta costante.

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

La quantità di moto totale si conserva in entrambi i casi, se l'impulso esterno è trascurabile. La differenza riguarda l'energia cinetica:

#blue-box([Classificazione degli urti])[
  *Urto elastico*: $vec(P)$ si conserva ed $E_k$ si conserva.

  *Urto anelastico*: $vec(P)$ si conserva, ma $E_k$ non si conserva.
]

In generale non sappiamo se le forze interne dell'urto siano conservative; per questo l'energia meccanica può diminuire, trasformandosi in deformazione, calore, suono o energia interna.

Per un urto completamente anelastico i corpi restano attaccati dopo l'urto:

$ vec(v)'_1=vec(v)'_2=vec(v)'. $

La conservazione della quantità di moto dà

#purple-box([Urto completamente anelastico])[
  $ m_1 vec(v)_1+m_2 vec(v)_2=(m_1+m_2) vec(v)'. $
]

L'energia cinetica finale è minore di quella iniziale, salvo casi particolari:

$ E_(k,"fin")=1/2 (m_1+m_2) v'^2. $

La parte mancante è lavoro speso per deformare i corpi o energia interna.

== Energia cinetica e centro di massa

Per un sistema di due particelle si può separare l'energia cinetica in una parte legata al moto del centro di massa e una parte interna:

$ E_k=1/2 (m_1+m_2) v_"CM"^2+E'_k. $

Se il sistema è isolato, $v_"CM"$ è costante; durante un urto può cambiare solo la parte interna $E'_k$.

= Esempio: pendolo balistico

Nel pendolo balistico un proiettile di massa $m$ e velocità $v$ urta un blocco appeso di massa $M$ e rimane conficcato. L'urto è completamente anelastico.

Durante l'urto si conserva la quantità di moto orizzontale:

$ m v=(m+M) v', $

quindi

$ v'=m/(m+M) v. $

Dopo l'urto, il blocco con il proiettile sale fino a quota $h$. In questa fase, trascurando attriti, si conserva l'energia meccanica:

$ 1/2 (m+M) v'^2=(m+M) g h. $

Da cui

$ v'=sqrt(2 g h). $

Combinando le due relazioni:

#green-box([Velocità del proiettile nel pendolo balistico])[
  $ v=(m+M)/m sqrt(2 g h). $
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

Un corpo rigido è un caso particolare di sistema di punti materiali in cui le distanze mutue tra le particelle restano costanti:

#blue-box([Corpo rigido])[
  $ r_(i j)="costante" quad "per ogni coppia " i,j. $
]

Il moto generale di un corpo rigido si può pensare come somma di due moti:

- moto del centro di massa;
- moto rispetto al centro di massa, cioè moto interno di rotazione.

In un corpo rigido non ci sono deformazioni: i punti mantengono posizione reciproca fissa rispetto al corpo.

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

Poiché le distanze $r_(i j)$ restano costanti, il lavoro delle forze interne in un corpo rigido ideale è nullo:

$ L^"int"=0. $

Per il teorema dell'energia cinetica dei sistemi resta quindi

#green-box([Energia cinetica del corpo rigido])[
  $ Delta E_k=L^"ext". $
]

Le equazioni globali del moto restano quelle dei sistemi di punti materiali:

$ vec(R)^"ext"=M vec(a)_"CM"=(dif vec(P))/(dif t), $

$ vec(tau)^"ext"=(dif vec(ell))/(dif t). $

== Corpo rigido continuo e densità

Un corpo rigido può essere modellato come:

- insieme discreto di $N$ punti materiali;
- corpo continuo, diviso in elementi infinitesimi di volume $dif V$ e massa $dif m$.

Nel caso continuo si introduce la densità volumica

#blue-box([Densità])[
  $ rho=(dif m)/(dif V) quad ["kg"/"m"^3]. $
]

La massa totale è

$ M=integral_V rho dif V. $

Se la densità è costante,

$ M=rho V. $

Il centro di massa diventa

$ vec(r)_"CM"=(integral vec(r) dif m)/(integral dif m)
  =(1/M) integral_V rho vec(r) dif V. $

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

In una traslazione tutti i punti del corpo hanno la stessa velocità del centro di massa:

$ vec(v)_i=vec(v)_"CM" quad "per ogni " i. $

Allora

$ vec(P)=M vec(v)_"CM", quad
   E_k=1/2 M v_"CM"^2, quad
   vec(R)^"ext"=M vec(a)_"CM". $

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

In una rotazione rigida tutti i punti descrivono moti circolari attorno all'asse di rotazione con la stessa velocità angolare $omega$.

Per un punto a distanza $R_i$ dall'asse:

$ v_i=omega R_i. $

La direzione della velocità è tangente alla circonferenza descritta dal punto.

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

Consideriamo un corpo rigido che ruota attorno a un asse fisso $z$ con velocità angolare $omega$. Ogni punto descrive una circonferenza perpendicolare all'asse. Per la particella $i$:

$ v_i=omega R_i, $

dove $R_i$ è la distanza dall'asse. Il momento angolare della singola particella è

$ vec(ell)_i=vec(r)_i times m_i vec(v)_i. $

La componente utile per la rotazione attorno all'asse è la componente lungo $z$:

$ ell_(i,z)=ell_i cos phi=m_i R_i^2 omega. $

Sommando tutte le particelle:

$ ell_z=sum_i ell_(i,z)=omega sum_i m_i R_i^2. $

#align(center, graph-card([Rotazione attorno a un asse fisso: componente di $vec(ell)$], cetz.canvas({
  import cetz.draw: *
  line((1.10, 0.45), (1.10, 3.20), stroke: 1.25pt + ink, mark: (end: ">"))
  axis-label((1.25, 3.10), [$z$], placement: "west")
  circle((1.10, 0.90), radius: 0.08, fill: ink, stroke: none)
  line((1.10, 0.90), (3.25, 1.70), stroke: 1.1pt + blue, mark: (end: ">"))
  line((1.10, 1.70), (3.25, 1.70), stroke: 0.95pt + blue, mark: (end: ">"))
  circle((3.25, 1.70), radius: 0.10, fill: ink, stroke: none)
  line((3.25, 1.70), (2.78, 2.50), stroke: 1.15pt + green, mark: (end: ">"))
  line((3.25, 1.70), (2.45, 2.72), stroke: 1.15pt + gold, mark: (end: ">"))
  line((3.25, 1.70), (3.25, 2.82), stroke: 0.95pt + gold, mark: (end: ">"))
  arc((1.10, 1.70), start: 0deg, stop: 360deg, radius: 2.15, stroke: (paint: grid-color, thickness: 0.75pt, dash: "dashed"))
  arc((1.10, 2.92), start: 40deg, stop: 330deg, radius: 0.25, stroke: 1.0pt + red, mark: (end: ">"))
  axis-label((1.32, 2.92), [$vec(omega)$], placement: "west")
  axis-label((2.18, 1.52), [$R_i$], placement: "north")
  axis-label((2.25, 1.48), [$vec(r)_i$], placement: "south")
  axis-label((2.72, 2.58), [$m_i vec(v)_i$], placement: "east")
  axis-label((2.18, 2.78), [$vec(ell)_i$], placement: "east")
  axis-label((3.42, 2.70), [$ell_(i,z)$], placement: "west")
  axis-label((5.20, 2.25), [$ell_(i,z)=m_i R_i^2 omega$], placement: "west")
  axis-label((5.20, 1.48), [$ell_z=I_z omega$], placement: "west")
})))

== Momento d'inerzia

Consideriamo una rotazione attorno a un asse fisso $z$. Per la particella $i$, la componente del momento angolare lungo l'asse è proporzionale a $omega$:

$ ell_(i,z)=m_i R_i^2 omega. $

Sommando su tutte le particelle:

$ ell_z=sum_i ell_(i,z)=sum_i m_i R_i^2 omega. $

Si definisce il *momento d'inerzia* rispetto all'asse $z$:

#blue-box([Momento d'inerzia rispetto all'asse $z$])[
  $ I_z=sum_i m_i R_i^2. $
]

Quindi

$ ell_z=I_z omega. $

Per un corpo continuo:

$ I_z=integral R^2 dif m=integral_V rho R^2 dif V. $

Il momento d'inerzia misura quanto la massa è distribuita lontano dall'asse: a parità di massa, più la massa è distante dall'asse, maggiore è $I$.

== Esempio: asse di simmetria e asse non principale

Se l'asse di rotazione $z$ è un asse di simmetria del corpo, le componenti trasversali del momento angolare si cancellano a coppie. Rimane solo la componente lungo l'asse:

$ ell_perp=0, quad vec(ell) parallel vec(omega), quad vec(ell)=I_z vec(omega). $

Se invece il corpo ruota attorno a un asse che non è principale, in generale $vec(ell)$ non è parallelo a $vec(omega)$. In quel caso la relazione scalare $ell=I omega$ non descrive completamente il moto.

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

Se l'asse di rotazione è fisso e coincide con un asse di simmetria del corpo, il momento angolare è parallelo alla velocità angolare:

$ vec(ell)=I_z vec(omega). $

Derivando:

$ vec(tau)= (dif vec(ell))/(dif t)=I_z (dif vec(omega))/(dif t)=I_z vec(alpha). $

In forma scalare lungo l'asse:

#purple-box([Legge del moto rotatorio])[
  $ tau_z=I_z alpha. $
]

È l'analogo rotazionale di $F=m a$.

#yellow-box([Asse non simmetrico])[
  In generale $vec(ell)$ non è parallelo a $vec(omega)$. La relazione semplice $vec(ell)=I vec(omega)$ vale quando si ruota attorno a un asse principale di inerzia, per esempio un asse di simmetria.
]

== Energia cinetica rotazionale

Per rotazione attorno a un asse fisso:

$ E_k=sum_i 1/2 m_i v_i^2
  =sum_i 1/2 m_i omega^2 R_i^2
  =1/2 I_z omega^2. $

Usando $ell_z=I_z omega$, si può anche scrivere

$ E_k=ell_z^2/(2 I_z). $

#green-box([Energia di rotazione])[
  $ E_k=1/2 I_z omega^2. $
]

== Pendolo fisico

Un *pendolo fisico* o *pendolo composto* è un corpo rigido che oscilla attorno a un punto fisso non coincidente con il centro di massa.

La forza peso agisce sul centro di massa e genera un momento torcente di richiamo:

$ vec(tau)=vec(r) times vec(F), $

in modulo, rispetto al punto di sospensione:

$ tau=-M g d sin theta, $

dove $d$ è la distanza tra il punto di sospensione e il centro di massa.

Per piccoli angoli $sin theta approx theta$, quindi

$ I (dif^2 theta)/(dif t^2)=-M g d theta. $

Questa è l'equazione di un moto armonico:

$ omega^2=(M g d)/I. $

Il periodo è

#green-box([Periodo del pendolo fisico])[
  $ T=2 pi sqrt(I/(M g d)). $
]

Dal periodo misurato si può ricavare il momento d'inerzia del corpo rispetto all'asse di sospensione:

$ I=(T^2 M g d)/(4 pi^2). $

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

== Carica elettrica

Esistono due tipi di carica elettrica:

- cariche dello stesso segno si respingono;
- cariche di segno opposto si attraggono.

La carica si indica con $q$ e si misura in coulomb, $"C"$.

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
  In un sistema isolato la carica totale resta costante.
]

== Legge di Coulomb

Tra due cariche puntiformi $q_1$ e $q_2$ ferme agisce una forza centrale diretta lungo la congiungente tra le cariche. Il modulo è

$ abs(vec(F))=k abs(q_1 q_2)/r^2, $

dove

$ k=1/(4 pi epsilon_0). $

La costante $epsilon_0$ è la *permittività elettrica del vuoto*:

$ epsilon_0 approx 8.85 dot 10^(-12) " C"^2/("N" "m"^2). $

In forma vettoriale, la forza esercitata da $q_1$ su $q_2$ è

#purple-box([Legge di Coulomb])[
  $ vec(F)_(1 -> 2)= (q_1 q_2)/(4 pi epsilon_0 r_(1 2)^2) hat(r)_(1 2). $
]

Qui $vec(r)_(1 2)=vec(r)_2-vec(r)_1$ e $hat(r)_(1 2)=vec(r)_(1 2)/abs(vec(r)_(1 2))$. Vale il principio di azione e reazione:

$ vec(F)_(1 -> 2)=-vec(F)_(2 -> 1). $

Per più cariche vale il principio di sovrapposizione: la forza totale è la somma vettoriale delle forze prodotte dalle singole cariche.

#align(center, graph-card([Legge di Coulomb e sovrapposizione], cetz.canvas({
  import cetz.draw: *
  circle((1.00, 1.55), radius: 0.11, fill: ink, stroke: none)
  circle((3.30, 1.55), radius: 0.11, fill: ink, stroke: none)
  line((1.00, 1.55), (3.30, 1.55), stroke: 0.9pt + ink)
  line((0.90, 1.55), (0.25, 1.55), stroke: 1.2pt + red, mark: (end: ">"))
  line((3.40, 1.55), (4.05, 1.55), stroke: 1.2pt + red, mark: (end: ">"))
  axis-label((0.95, 1.85), [$q_1$], placement: "south")
  axis-label((3.30, 1.85), [$q_2$], placement: "south")
  axis-label((2.15, 1.32), [$r_(1 2)$], placement: "north")
  axis-label((0.42, 1.85), [$vec(F)_(2 -> 1)$], placement: "south")
  axis-label((3.82, 1.85), [$vec(F)_(1 -> 2)$], placement: "south")

  circle((5.30, 1.15), radius: 0.12, fill: ink, stroke: none)
  circle((4.80, 2.25), radius: 0.09, fill: ink, stroke: none)
  circle((6.05, 2.35), radius: 0.09, fill: ink, stroke: none)
  circle((6.25, 0.75), radius: 0.09, fill: ink, stroke: none)
  line((5.30, 1.15), (5.30, 2.05), stroke: 1.0pt + green, mark: (end: ">"))
  line((5.30, 1.15), (6.10, 1.85), stroke: 1.0pt + green, mark: (end: ">"))
  line((5.30, 1.15), (6.05, 0.80), stroke: 1.0pt + green, mark: (end: ">"))
  line((5.30, 1.15), (6.65, 1.35), stroke: 1.2pt + blue, mark: (end: ">"))
  axis-label((5.18, 0.84), [$q_0$], placement: "north")
  axis-label((6.70, 1.42), [$vec(F)_"tot"$], placement: "west")
})))

== Campo elettrostatico

Il campo elettrostatico descrive la proprietà dello spazio generata dalle cariche sorgenti. Si definisce mediante una carica di prova $q_0$:

#blue-box([Campo elettrico])[
  $ vec(E)(vec(r)_0)=vec(F)_"su " q_0/(q_0) quad ["N"/"C"]. $
]

La forza su una carica di prova è quindi

$ vec(F)=q_0 vec(E). $

Per una carica puntiforme $q$ posta nell'origine:

$ vec(E)(vec(r))=q/(4 pi epsilon_0 r^2) hat(r). $

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

Per una distribuzione discreta di cariche:

$ vec(E)(vec(r)_0)=sum_i q_i/(4 pi epsilon_0 r_(i 0)^2) hat(r)_(i 0), $

dove $vec(r)_(i 0)=vec(r)_0-vec(r)_i$.

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

Per distribuzioni continue si usa un elemento infinitesimo di carica $dif q$.

Le densità di carica più comuni sono:

$ dif q=lambda dif ell quad ["C"/"m"], $

$ dif q=sigma dif S quad ["C"/"m"^2], $

$ dif q=rho dif V quad ["C"/"m"^3]. $

Il campo si ottiene integrando i contributi elementari:

$ vec(E)(vec(r)_0)=1/(4 pi epsilon_0) integral (dif q)/r^2 hat(r). $

L'integrale diventa un integrale di linea, superficie o volume a seconda della distribuzione.

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

La forza elettrostatica di Coulomb è conservativa:

- il lavoro non dipende dal percorso;
- il lavoro lungo un percorso chiuso è nullo;
- esiste un'energia potenziale elettrostatica $U$.

Per due cariche puntiformi $Q$ e $q$:

$ vec(F)=Q q/(4 pi epsilon_0 r^2) hat(r). $

Il lavoro da $A$ a $B$ lungo un qualsiasi percorso è

$ L_(A B)=integral_A^B vec(F) dot dif vec(s)
  =integral_(r_A)^(r_B) Q q/(4 pi epsilon_0 r^2) dif r
  =Q q/(4 pi epsilon_0) (1/r_A-1/r_B). $

Poiché $L_(A B)=-Delta U$, l'energia potenziale può essere scelta come

#green-box([Energia potenziale elettrostatica])[
  $ U(r)=Q q/(4 pi epsilon_0 r)+C. $
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

L'energia potenziale $U$ dipende dalla carica di prova $q_0$. Per descrivere lo spazio indipendentemente dalla carica usata come sonda, si definisce il *potenziale elettrostatico*

#blue-box([Potenziale elettrostatico])[
  $ V(vec(r))=U(vec(r))/q_0 quad ["V"]. $
]

Il campo elettrico si misura in $"N"/"C"$, mentre il potenziale si misura in volt:

$ 1 " V"=1 " J"/"C". $

Poiché $L=-Delta U$, per una carica $q$ che si sposta tra $A$ e $B$:

$ L_(A B)=-q Delta V=-q (V_B-V_A). $

Per una carica unitaria positiva, la differenza di potenziale è il lavoro per unità di carica cambiato di segno.

#purple-box([Differenza di potenziale e campo])[
  $ V_B-V_A=-integral_A^B vec(E) dot dif vec(ell). $
]

#align(center, graph-card([Da forza ed energia a campo e potenziale], cetz.canvas({
  import cetz.draw: *
  axis-label((0.85, 2.35), [$vec(F)_"el"$], placement: "south")
  line((1.20, 2.20), (2.55, 2.20), stroke: 1.0pt + ink, mark: (end: ">"))
  axis-label((3.00, 2.35), [$U$], placement: "south")
  axis-label((1.75, 1.82), [dividi per $q_0$], placement: "north")
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

#green-box([Potenziale di una carica puntiforme])[
  $ V(r)=q/(4 pi epsilon_0 r) quad "con " V(infinity)=0. $
]

Il potenziale è positivo attorno a una carica positiva e negativo attorno a una carica negativa.

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

Il potenziale è una grandezza scalare, quindi la sovrapposizione è algebrica:

$ V(vec(r))=sum_i V_i(vec(r)). $

Per $N$ cariche puntiformi:

#purple-box([Potenziale di una distribuzione discreta])[
  $ V(vec(r))=1/(4 pi epsilon_0) sum_(i=1)^N q_i/abs(vec(r)-vec(r)_i). $
]

Per una distribuzione continua, sommando i contributi degli elementi di carica sorgente:

$ V(vec(r))=1/(4 pi epsilon_0) integral (dif q)/abs(vec(r)-vec(r)_"s"). $

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

Le linee di campo sono curve tangenti al vettore $vec(E)$ in ogni punto. Sono uno strumento grafico per rappresentare direzione e verso del campo:

- escono dalle cariche positive;
- entrano nelle cariche negative;
- non si incrociano;
- in elettrostatica sono linee aperte: partono da cariche positive e finiscono su cariche negative oppure all'infinito.

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

Le superfici equipotenziali sono insiemi di punti in cui

$ V(vec(r))="costante". $

Se una carica si sposta lungo una superficie equipotenziale, $Delta V=0$ e quindi

$ L=-q Delta V=0. $

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

Per misurare quante linee di campo attraversano una superficie orientata si introduce il *flusso* di $vec(E)$.

L'elemento di superficie si scrive come vettore

$ dif vec(S)=hat(n) dif S, $

dove $hat(n)$ è il versore normale alla superficie. Il flusso elementare è

#blue-box([Flusso elementare])[
  $ dif Phi(vec(E))=vec(E) dot dif vec(S)=E cos theta dif S. $
]

L'angolo $theta$ è l'angolo tra il campo $vec(E)$ e la normale $hat(n)$, non l'angolo tra il campo e la superficie. Per questo motivo conta solo la componente di $vec(E)$ perpendicolare alla superficie.

Il flusso attraverso una superficie estesa è la somma dei contributi elementari:

#purple-box([Flusso attraverso una superficie])[
  $ Phi(vec(E))=integral_S vec(E) dot dif vec(S). $
]

Se la superficie è chiusa, per convenzione $hat(n)$ è sempre la normale uscente.

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

Consideriamo una carica puntiforme $q$ e una superficie qualsiasi. Il campo prodotto dalla carica è

$ vec(E)=q/(4 pi epsilon_0 r^2) hat(r). $

Il flusso elementare attraverso $dif vec(S)$ è

$ dif Phi=vec(E) dot dif vec(S)
  =q/(4 pi epsilon_0 r^2) hat(r) dot dif vec(S). $

La quantità

$ dif Omega=(hat(r) dot dif vec(S))/r^2 $

è l'angolo solido sotto cui la carica vede l'elemento di superficie. Il termine $hat(r) dot dif vec(S)$ è la proiezione dell'elemento di superficie sul piano perpendicolare alla direzione radiale. Quindi

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

Perciò il flusso totale vale

#yellow-box([Flusso di una carica interna])[
  $ Phi=integral_S vec(E) dot dif vec(S)
    =q/(4 pi epsilon_0) integral dif Omega
    =q/epsilon_0. $
]

Se invece la carica è esterna alla superficie chiusa, ogni fascio di campo entra ed esce: il contributo entrante e quello uscente si compensano, quindi il flusso netto è nullo.

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

Il teorema di Gauss lega il flusso del campo elettrico attraverso una qualunque superficie chiusa alla carica totale contenuta al suo interno:

#blue-box([Teorema di Gauss])[
  $ Phi(vec(E))=integral_S vec(E) dot dif vec(S)=Q_"int"/epsilon_0. $
]

La superficie $S$ deve essere chiusa. La carica $Q_"int"$ è la somma algebrica delle cariche interne alla superficie; le cariche esterne possono modificare localmente il campo, ma non il flusso netto attraverso $S$.

Il teorema vale sempre, anche senza simmetria. La simmetria serve però per ricavare il modulo del campo dall'integrale: senza una superficie su cui $E$ è costante o nullo per tratti, l'integrale resta difficile da calcolare.

Il teorema è particolarmente utile per calcolare $vec(E)$ quando la distribuzione di carica ha simmetria. In questi casi si sceglie una *superficie gaussiana* su cui:

- $vec(E)$ ha modulo costante;
- $vec(E)$ è parallelo alla normale $hat(n)$ oppure tangente alla superficie;
- l'integrale di flusso si riduce a un prodotto semplice.

La superficie gaussiana non è una superficie fisica: è una superficie immaginaria scelta per sfruttare la simmetria.

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

Consideriamo una carica totale $Q>0$ distribuita uniformemente sulla superficie di una sfera di raggio $R$.

La densità superficiale è

$ sigma=Q/(4 pi R^2) quad ["C"/"m"^2]. $

Per simmetria sferica il campo è radiale:

$ vec(E)(vec(r))=E(r) hat(r). $

Scegliamo come superfici gaussiane sfere concentriche $S(r)$. Su $S(r)$ il campo ha modulo costante e $hat(r) dot hat(n)=1$, quindi

$ integral_(S(r)) vec(E) dot dif vec(S)=E(r) integral_(S(r)) dif S=E(r) 4 pi r^2=Q_"int"/epsilon_0. $

Il passaggio chiave è questo: su una sfera concentrica il campo è radiale come la normale uscente, quindi il prodotto scalare non introduce fattori angolari e il modulo $E(r)$ può uscire dall'integrale.

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

Questo risultato è il principio alla base della *gabbia di Faraday*: in una cavità interna a un conduttore sferico carico, se non ci sono cariche nella cavità, il campo elettrostatico è nullo.

#green-box([Campo di un guscio sferico carico])[
  $ vec(E)(r)=cases(
    0, & r<R,
    Q/(4 pi epsilon_0 r^2) hat(r), & r>R.
  ) $
]

Sulla superficie il valore esterno è

$ E(R)=Q/(4 pi epsilon_0 R^2)=sigma/epsilon_0. $

Nel modello ideale di carica concentrata esattamente sulla superficie, il campo ha un salto in $r=R$: appena dentro vale $0$, appena fuori vale $sigma/epsilon_0$.

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

$ E(r)=rho (4/3) pi r^3/(epsilon_0 4 pi r^2)=rho r/(3 epsilon_0). $

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

Un conduttore contiene cariche libere di muoversi. Se si applica un campo elettrico esterno, durante il transiente le cariche si spostano sotto l'azione della forza

$ vec(F)=q vec(E). $

Il moto delle cariche continua finché il campo totale all'interno del conduttore non diventa nullo. In equilibrio elettrostatico valgono alcune proprietà fondamentali.

#blue-box([Conduttore in equilibrio elettrostatico])[
  $ vec(E)_"int"=0, quad V="costante", quad Q_"int"=0. $
]

La condizione $vec(E)_"int"=0$ non significa che non ci siano cariche sul conduttore: significa che il campo prodotto dalle cariche ridistribuite annulla il campo applicato all'interno del materiale.

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

== Carica sui conduttori

La carica netta di un conduttore in equilibrio si dispone solo sulla superficie. Infatti, prendendo una superficie gaussiana tutta interna al materiale conduttore, si ha $vec(E)=0$ su tutta la superficie e quindi

$ integral_S vec(E) dot dif vec(S)=0 quad -> quad Q_"int"=0. $

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

In equilibrio:

- la carica $+Q_A$ del conduttore interno sta sulla superficie $R_1$;
- sulla superficie interna del guscio, a raggio $R_2$, compare $-Q_A$ per induzione;
- poiché il guscio esterno era neutro, sulla superficie esterna $R_3$ compare $+Q_A$.

Le densità superficiali sono

$ sigma_(R_1)=Q_A/(4 pi R_1^2) approx 8 dot 10^(-5) " C"/"m"^2, $

$ sigma_(R_2)=-Q_A/(4 pi R_2^2) approx -3.2 dot 10^(-6) " C"/"m"^2, $

$ sigma_(R_3)=Q_A/(4 pi R_3^2) approx 8 dot 10^(-7) " C"/"m"^2. $

#align(center, graph-card([Gusci sferici conduttori: cariche indotte], cetz.canvas({
  import cetz.draw: *
  circle((2.10, 1.80), radius: 0.42, stroke: 1.0pt + ink, fill: rgb("#f4f4f4"))
  circle((2.10, 1.80), radius: 1.00, stroke: 1.0pt + ink)
  circle((2.10, 1.80), radius: 1.42, stroke: 1.0pt + ink, fill: none)
  circle((2.10, 1.80), radius: 1.78, stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  for p in ((1.92, 2.08), (2.28, 2.06), (2.08, 1.48)) { axis-label(p, [$+$]) }
  for p in ((1.42, 2.35), (2.78, 2.35), (2.95, 1.42), (1.25, 1.38)) { axis-label(p, [$-$]) }
  for p in ((0.75, 2.52), (1.55, 3.18), (2.70, 3.05), (3.48, 2.10), (2.72, 0.55), (1.18, 0.72)) { axis-label(p, [$+$]) }
  line((2.10, 1.80), (2.52, 1.80), stroke: 0.8pt + ink, mark: (end: ">"))
  line((2.10, 1.80), (3.10, 1.80), stroke: 0.8pt + ink, mark: (end: ">"))
  line((2.10, 1.80), (3.52, 1.80), stroke: 0.8pt + ink, mark: (end: ">"))
  axis-label((2.36, 1.60), [$R_1$], placement: "north")
  axis-label((2.82, 1.58), [$R_2$], placement: "north")
  axis-label((3.42, 1.58), [$R_3$], placement: "north")
  axis-label((5.00, 2.58), [$+Q_A$ su $R_1$], placement: "west")
  axis-label((5.00, 1.78), [$-Q_A$ su $R_2$], placement: "west")
  axis-label((5.00, 0.98), [$+Q_A$ su $R_3$], placement: "west")
})))

Per calcolare il campo si usano sfere gaussiane concentriche. Per simmetria

$ integral_(S(r)) vec(E) dot dif vec(S)=E(r) 4 pi r^2=Q_"int"/epsilon_0. $

Quindi

#green-box([Campo nel sistema di gusci])[
  $ vec(E)(r)=cases(
    0, & r<R_1,
    Q_A/(4 pi epsilon_0 r^2) hat(r), & R_1<r<R_2,
    0, & R_2<r<R_3,
    Q_A/(4 pi epsilon_0 r^2) hat(r), & r>R_3.
  ) $
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

== Capacità elettrostatica

La *capacità elettrostatica* misura quanta carica deve essere fornita a un conduttore per portarlo a un certo potenziale. Per un conduttore isolato si definisce

$ C = Q/V, $

dove $V$ è il potenziale del conduttore rispetto al riferimento scelto, di solito l'infinito o la terra. L'unità di misura è il *farad*:

$ [C] = "F" = "C"/"V". $

#blue-box([Capacità])[
  La capacità non dipende da quanta carica si mette sul conduttore: dipende solo dalla geometria e dal mezzo che lo circonda.
]

Per un conduttore sferico isolato di raggio $R$ nel vuoto,

$ V(R)=Q/(4 pi epsilon_0 R), $

quindi

#green-box([Conduttore sferico isolato])[
  $ C = Q/V = 4 pi epsilon_0 R. $
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

Un *condensatore* è formato da due conduttori posti in *induzione completa*: le linee di campo che partono da un conduttore terminano sull'altro. I due conduttori portano cariche opposte $+Q$ e $-Q$.

La capacità di un condensatore si definisce usando la differenza di potenziale fra le armature:

#yellow-box([Capacità di un condensatore])[
  $ C = Q/(Delta V). $

  Per convenzione $Q$ è preso positivo, cioè si usa il modulo della carica presente su una delle due armature.
]

#align(center, graph-card([Condensatore e induzione completa], cetz.canvas({
  import cetz.draw: *
  // Due conduttori in induzione completa: tutte le linee partono dal + e terminano sul -.
  circle((1.85, 1.85), radius: 0.58, stroke: 1.0pt + ink, fill: rgb("#fbfcfd"))
  circle((1.85, 1.85), radius: 1.25, stroke: 1.0pt + ink, fill: none)
  circle((1.85, 1.85), radius: 1.46, stroke: (paint: rgb("#ccd4d8"), thickness: 0.7pt, dash: "dashed"))
  for p in ((1.52, 2.12), (1.85, 2.24), (2.18, 2.12), (1.54, 1.55), (2.16, 1.55)) {
    axis-label(p, [$+$])
  }
  for p in ((0.78, 2.35), (1.28, 2.82), (1.90, 3.05), (2.56, 2.72), (3.02, 2.02), (2.65, 0.92), (1.22, 0.86), (0.64, 1.50)) {
    axis-label(p, [$-$])
  }
  for a in ((1.85, 2.43), (2.35, 2.22), (2.43, 1.82), (2.00, 1.28), (1.33, 1.48), (1.28, 2.12)) {
    line((1.85, 1.85), a, stroke: 0.8pt + blue, mark: (end: ">"))
  }
  line((3.65, 0.55), (3.65, 3.08), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((1.85, 0.36), [conduttore interno: $+Q$], placement: "north")
  axis-label((1.85, 0.04), [conduttore esterno: $-Q$], placement: "north")

  axis-label((4.45, 2.72), [induzione completa], placement: "west")
  axis-label((4.45, 2.02), [ogni linea di campo del conduttore 1], placement: "west")
  axis-label((4.45, 1.66), [finisce sul conduttore 2], placement: "west")
  axis-label((4.45, 0.96), [$C=Q/(Delta V)$], placement: "west")
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

Per il condensatore sferico, con raggi $R_1$ e $R_2$ e cariche $+Q$ e $-Q$, nel vuoto:

$ V_1 - V_2 = Q/(4 pi epsilon_0) (1/R_1 - 1/R_2), $

e quindi

#green-box([Condensatore sferico])[
  $ C = Q/(Delta V) = (4 pi epsilon_0 R_1 R_2)/(R_2 - R_1). $
]

== Campo di un piano infinito carico

Per una lastra piana infinita con densità superficiale uniforme $sigma$, la simmetria impone che il campo sia perpendicolare al piano e abbia lo stesso modulo sui due lati. Si usa una superficie gaussiana cilindrica che attraversa il piano.

Il flusso passa solo dalle due basi:

$ integral_S vec(E) dot dif vec(S) = 2 E Sigma. $

La carica racchiusa è $Q_"int"=sigma Sigma$. Dal teorema di Gauss:

#yellow-box([Piano infinito uniformemente carico])[
  $ E = sigma/(2 epsilon_0). $

  Se $sigma>0$ il campo è uscente dai due lati; se $sigma<0$ è entrante.
]

#align(center, graph-card([Gauss per il piano infinito], cetz.canvas({
  import cetz.draw: *
  // piano carico
  line((0.55, 1.42), (4.55, 1.42), stroke: 1.0pt + ink)
  line((0.92, 1.72), (4.92, 1.72), stroke: 1.0pt + ink)
  line((0.55, 1.42), (0.92, 1.72), stroke: 1.0pt + ink)
  line((4.55, 1.42), (4.92, 1.72), stroke: 1.0pt + ink)
  for x in (1.10, 1.80, 2.50, 3.20, 3.90, 4.45) {
    axis-label((x, 1.83), [$+$])
  }
  // cilindro gaussiano
  arc((2.75, 2.20), radius: 0.38, start: 0deg, stop: 360deg, stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  arc((2.75, 0.90), radius: 0.38, start: 0deg, stop: 360deg, stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  line((2.37, 0.90), (2.37, 2.20), stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  line((3.13, 0.90), (3.13, 2.20), stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))
  for x in (1.20, 2.00, 3.50, 4.30) {
    line((x, 1.95), (x, 2.70), stroke: 0.95pt + blue, mark: (end: ">"))
    line((x, 1.15), (x, 0.42), stroke: 0.95pt + blue, mark: (end: ">"))
  }
  axis-label((5.35, 2.46), [$vec(E)$], placement: "west")
  axis-label((5.35, 0.68), [$vec(E)$], placement: "west")
  axis-label((5.35, 1.58), [$sigma$], placement: "west")
  axis-label((2.75, 0.18), [$2 E Sigma = sigma Sigma / epsilon_0$], placement: "north")
})))

== Condensatore piano

Un condensatore piano è formato da due lastre conduttrici parallele, molto estese rispetto alla distanza che le separa. Ciascuna lastra, presa da sola, genera un campo di modulo $sigma/(2 epsilon_0)$ su ciascun lato.

Per sovrapposizione:

- tra le armature i due campi hanno lo stesso verso e si sommano;
- all'esterno hanno verso opposto e si annullano.

Per un condensatore piano ideale nel vuoto:

#green-box([Condensatore piano ideale])[
  $ E_"interno" = sigma/epsilon_0, quad E_"esterno"=0. $
]

Se l'area delle armature è $A$, allora $sigma=Q/A$ e $Delta V=E d$. La capacità vale

#yellow-box([Capacità del condensatore piano])[
  $ C = Q/(Delta V) = (epsilon_0 A)/d. $
]

#align(center, graph-card([Condensatore piano: sovrapposizione dei campi], cetz.canvas({
  import cetz.draw: *
  // left: two plates field
  line((0.55, 2.45), (3.25, 2.45), stroke: 1.1pt + ink)
  line((0.55, 1.05), (3.25, 1.05), stroke: 1.1pt + ink)
  for x in (0.85, 1.35, 1.85, 2.35, 2.85) {
    axis-label((x, 2.63), [$+$])
    axis-label((x, 0.86), [$-$])
    line((x, 2.25), (x, 1.25), stroke: 1.0pt + blue, mark: (end: ">"))
  }
  axis-label((3.55, 1.75), [$E=sigma/epsilon_0$], placement: "west")
  axis-label((1.90, 0.35), [interno], placement: "north")
  axis-label((0.22, 2.98), [$E=0$], placement: "south")
  axis-label((0.22, 0.48), [$E=0$], placement: "north")

  // right: battery-like capacitor
  line((5.00, 2.28), (7.10, 2.28), stroke: 1.1pt + ink)
  line((5.00, 1.24), (7.10, 1.24), stroke: 1.1pt + ink)
  for x in (5.35, 5.80, 6.25, 6.70) {
    line((x, 2.08), (x, 1.44), stroke: 0.95pt + blue, mark: (end: ">"))
  }
  line((7.40, 2.28), (7.40, 1.24), stroke: 0.8pt + ink, mark: (start: "|", end: "|"))
  axis-label((7.62, 1.76), [$d$], placement: "west")
  axis-label((5.10, 2.52), [$+Q$], placement: "south")
  axis-label((5.10, 0.98), [$-Q$], placement: "north")
  axis-label((6.05, 0.42), [$C=epsilon_0 A/d$], placement: "north")
})))

== Elettrostatica nei dielettrici

Un *dielettrico* è un materiale isolante. Le cariche non sono libere di muoversi come in un conduttore, ma gli atomi o le molecole possono deformarsi leggermente sotto l'azione di un campo elettrico esterno.

Questo spostamento microscopico separa i centri delle cariche positive e negative: l'atomo o la molecola si *polarizza* e si comporta come un piccolo dipolo elettrico.

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

Consideriamo un condensatore piano inizialmente collegato a una batteria con differenza di potenziale $V_0$ e capacità $C_0$. Prima dell'inserimento del dielettrico:

$ Q_0=C_0 V_0, quad E_0=sigma_l/epsilon_0, $

dove $sigma_l$ è la densità superficiale di carica libera sulle armature.

Se si scollega la batteria, il sistema diventa isolato e la carica libera resta costante. Inserendo un dielettrico lineare con costante dielettrica $k>1$:

$ V = V_0/k < V_0, quad E = E_0/k < E_0, quad C = k C_0 > C_0. $

#green-box([Effetto del dielettrico nel condensatore isolato])[
  A carica libera fissata, il dielettrico riduce campo e differenza di potenziale, quindi aumenta la capacità.
]

Sulle superfici del dielettrico compaiono cariche di polarizzazione $sigma_p^+$ e $sigma_p^-$. Il campo totale interno è minore del campo che ci sarebbe nel vuoto:

$ E = (abs(sigma_l)-abs(sigma_p))/epsilon_0. $

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

Il *momento di dipolo elettrico* descrive una coppia di cariche opposte separate da una distanza $d$:

$ vec(p)=q vec(d). $

Il vettore $vec(d)$ è diretto dalla carica negativa alla carica positiva, quindi anche $vec(p)$ punta dal $-$ al $+$.

Nel materiale si introduce il campo di polarizzazione $vec(P)$, cioè il momento di dipolo per unità di volume:

#blue-box([Vettore di polarizzazione])[
  $ vec(P) = ("momento di dipolo")/("volume"). $

  Per un dielettrico lineare isotropo:
  $ vec(P)=epsilon_0 chi vec(E), quad k=1+chi. $
]

Qui $chi$ è la suscettività elettrica del materiale ed è positiva per i dielettrici ordinari.

Se la polarizzazione è uniforme, nel volume le cariche di polarizzazione si compensano; restano cariche sulla superficie. La densità superficiale di polarizzazione è

$ sigma_p = vec(P) dot hat(n), $

dove $hat(n)$ è la normale uscente alla superficie del dielettrico.

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

Nel vuoto il teorema di Gauss lega il flusso di $vec(E)$ alla carica totale racchiusa. In un dielettrico le cariche racchiuse possono essere di due tipi:

- cariche *libere*, cioè messe dall'esterno sulle armature o sui conduttori;
- cariche *di polarizzazione*, dovute alla risposta del materiale.

Per separare i due contributi si introduce il vettore spostamento elettrico:

#yellow-box([Spostamento elettrico])[
  $ vec(D)=epsilon_0 vec(E)+vec(P). $
]

Il vantaggio di $vec(D)$ è che il suo flusso dipende solo dalla carica libera:

#green-box([Teorema di Gauss nei dielettrici])[
  $ integral_(S_"chiusa") vec(D) dot dif vec(S) = Q_"libera". $
]

Per un dielettrico lineare:

$ vec(P)=epsilon_0 chi vec(E) quad -> quad vec(D)=epsilon_0 (1+chi) vec(E)=epsilon_0 k vec(E). $

Quindi, conoscendo $vec(D)$ con Gauss, si ricavano in ordine:

$ vec(D) -> vec(E) -> vec(P) -> sigma_p. $

== Esempio: sfera libera immersa in un dielettrico lineare

Una sfera conduttrice di raggio $R$ porta una carica libera $Q_"libera"$ ed è immersa in un dielettrico lineare, omogeneo e isotropo con costante dielettrica $k$.

Per simmetria $vec(D)$ è radiale. Su una superficie gaussiana sferica di raggio $r>R$:

$ integral_S vec(D) dot dif vec(S)=D 4 pi r^2=Q_"libera". $

Da cui

$ vec(D)=Q_"libera"/(4 pi r^2) hat(r). $

Poiché $vec(D)=epsilon_0 k vec(E)$,

#blue-box([Campo nel dielettrico intorno alla sfera])[
  $ vec(E)=vec(D)/(epsilon_0 k)=Q_"libera"/(4 pi epsilon_0 k r^2) hat(r). $
]

Il campo è quello che si avrebbe nel vuoto, ridotto di un fattore $k$.

La polarizzazione vale

$ vec(P)=epsilon_0 chi vec(E)=epsilon_0 (k-1) vec(E)= (k-1)/k Q_"libera"/(4 pi r^2) hat(r). $

Sulla superficie del dielettrico a contatto con la sfera compare una densità di carica di polarizzazione pari al modulo di $vec(P)$ sulla superficie:

#yellow-box([Carica di polarizzazione sulla superficie])[
  $ abs(sigma_p)=abs(vec(P)(R))=(k-1)/k Q_"libera"/(4 pi R^2)=(k-1)/k sigma_l. $
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

Un dipolo elettrico è formato da due cariche opposte $+q$ e $-q$ separate da un vettore $vec(d)$ diretto dalla carica negativa alla carica positiva. Il momento di dipolo è

$ vec(p)=q vec(d). $

Consideriamo un punto $P$ lontano dal dipolo. Indichiamo con $r_+$ la distanza di $P$ dalla carica positiva e con $r_-$ la distanza dalla carica negativa. Il potenziale è la somma dei potenziali delle due cariche:

$ V(P)=V_+ + V_- = 1/(4 pi epsilon_0) (q/r_+ - q/r_-). $

Portando a denominatore comune:

$ V(P)=q/(4 pi epsilon_0) (r_- - r_+)/(r_+ r_-). $

Se il punto è lontano rispetto alla distanza fra le cariche, cioè $r >> d$, si usano le approssimazioni

$ r_+ r_- approx r^2, quad r_- - r_+ approx d cos theta. $

Poiché $vec(p) dot vec(r)=p r cos theta=q d r cos theta$, risulta

#yellow-box([Potenziale di dipolo lontano])[
  $ V(vec(r))=1/(4 pi epsilon_0) (vec(p) dot vec(r))/r^3. $

  Il potenziale di dipolo decresce come $1/r^2$.
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

Le linee di campo di un dipolo escono dalla carica positiva e terminano sulla carica negativa. Il campo si può ricavare dal potenziale attraverso il teorema del gradiente:

$ Delta V = V - V_0 = - integral_0^P vec(E) dot dif vec(ell), $

e localmente

#blue-box([Campo dal potenziale])[
  $ vec(E) = - nabla V. $
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

In un campo elettrico esterno uniforme $vec(E)_"est"$, sulle cariche del dipolo agiscono forze opposte:

$ vec(F)_+ = q vec(E)_"est", quad vec(F)_- = -q vec(E)_"est". $

La risultante è nulla, ma le due forze formano una coppia che tende a ruotare il dipolo. Il momento meccanico della coppia è

#green-box([Momento meccanico sul dipolo])[
  $ vec(tau)=vec(p) times vec(E). $
]

Il verso della rotazione è tale da allineare $vec(p)$ al campo esterno. L'energia potenziale del dipolo nel campo è

#yellow-box([Energia del dipolo in campo esterno])[
  $ U = - vec(p) dot vec(E). $
]

Se $vec(p)$ e $vec(E)$ sono paralleli, $U$ è minima: equilibrio stabile. Se sono antiparalleli, $U$ è massima: equilibrio instabile.

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

La forza elettrostatica è conservativa. Per una carica $q$ che si sposta in un campo elettrico:

$ vec(F)=q vec(E). $

Il lavoro del campo elettrostatico è legato alla variazione di energia potenziale:

$ L_"campo" = - Delta U, $

e, usando il potenziale,

#blue-box([Lavoro e potenziale])[
  $ L = - q Delta V. $
]

Ponendo $U_infinity=0$, l'energia elettrostatica di un sistema è il lavoro totale esterno necessario per costruire il sistema portando le cariche dall'infinito. Equivalentemente,

$ U_"sistema" = - L_"campo". $

== Distribuzione discreta di cariche

Per costruire una distribuzione di $N$ cariche puntiformi, si porta una carica alla volta dall'infinito. La prima carica non richiede lavoro, perché non ci sono ancora altre cariche:

$ L_1=0. $

La seconda carica sente il potenziale prodotto dalla prima:

$ L_2 = q_2 V_1(vec(r)_2) = q_2 q_1/(4 pi epsilon_0 r_(1 2)). $

Continuando, ogni carica $q_i$ viene portata nel potenziale prodotto dalle cariche già presenti. L'energia totale si scrive

#green-box([Energia di cariche puntiformi])[
  $ U_"el" = 1/2 sum_(i=1)^N sum_(j!=i)^N (q_i q_j)/(4 pi epsilon_0 r_(i j))
  = 1/2 sum_(i=1)^N q_i V_i. $
]

Nel termine $V_i$ non si include il potenziale generato dalla carica $q_i$ stessa, ma solo quello prodotto dalle altre cariche. Il fattore $1/2$ evita di contare due volte ogni coppia.

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

Per passare a una distribuzione continua si sostituisce la somma con un integrale. Se la densità volumica è $rho(vec(r))$, allora

$ dif q = rho(vec(r)) dif tau. $

L'energia elettrostatica della distribuzione diventa

#yellow-box([Energia di una distribuzione continua])[
  $ U_"el" = 1/2 integral_"vol" rho(vec(r)) V(vec(r)) dif tau. $
]

Una forma equivalente, ottenuta esplicitando l'interazione fra coppie di elementi di volume, è

$ U_"el" = 1/2 integral_"vol" integral_"vol" (rho(vec(r)_1) rho(vec(r)_2) dif tau_1 dif tau_2)/(4 pi epsilon_0 r_(1 2)). $

La forma con $1/2 integral rho V dif tau$ è più compatta perché $V(vec(r))$ contiene il contributo del resto della distribuzione.

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

In un sistema di conduttori in equilibrio elettrostatico, ogni conduttore è equipotenziale. Se il conduttore $i$ ha potenziale $V_i$ costante e densità superficiale $sigma_i$, la sua carica è

$ Q_i = integral_"sup" sigma_i dif S. $

L'energia può essere scritta come somma dei contributi dei conduttori:

#green-box([Energia di un sistema di conduttori])[
  $ U_"el" = 1/2 sum_(i=1)^N Q_i V_i. $
]

Per un singolo conduttore di capacità $C$, usando $C=Q/V$, si ottengono le forme pratiche:

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

Poiché $Q=C Delta V$, si hanno le tre forme equivalenti:

#green-box([Energia immagazzinata in un condensatore])[
  $ U = 1/2 C (Delta V)^2 = 1/2 Q^2/C = 1/2 Q Delta V. $
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

Consideriamo una sfera conduttrice di raggio $R_1$ con carica $+Q$, circondata da un conduttore sferico cavo con raggio interno $R_2$ e raggio esterno $R_3$. Per induzione, sulla superficie interna del guscio compare carica $-Q$.

Se il guscio esterno è collegato a terra, la superficie esterna può scambiare carica con la Terra e il campo esterno si annulla. Il sistema rilevante è quindi il condensatore sferico tra $R_1$ e $R_2$:

$ C_"condensatore" = 4 pi epsilon_0 (R_1 R_2)/(R_2 - R_1). $

L'energia è

#yellow-box([Condensatore sferico con guscio a terra])[
  $ U = Q^2/(2 C_"condensatore")
    = Q^2/(8 pi epsilon_0) (1/R_1 - 1/R_2). $
]

Se il guscio non è collegato a terra, rimane anche il contributo energetico del conduttore esterno di raggio $R_3$:

#green-box([Caso non collegato a terra])[
  $ U = Q^2/(2 C_"condensatore") + Q^2/(2 C_"conduttore"), quad
  C_"conduttore" = 4 pi epsilon_0 R_3. $
]

#align(center, graph-card([Condensatore sferico: terra e caso isolato], cetz.canvas({
  import cetz.draw: *

  // Caso R3 scaricato a terra: conduttore centrale + guscio sferico collegato a terra.
  axis-label((2.05, 5.52), [guscio sferico, $R_3$ scaricato a terra], placement: "south")
  circle((2.05, 4.16), radius: 0.55, stroke: 1.15pt + ink, fill: rgb("#f7f7f7"))
  circle((2.05, 4.16), radius: 1.02, stroke: 1.15pt + ink, fill: none)
  circle((2.05, 4.16), radius: 1.38, stroke: 1.15pt + ink, fill: none)
  axis-label((2.05, 4.16), [$Q$])
  axis-label((1.26, 3.78), [$Q$], placement: "center")
  axis-label((2.78, 3.78), [$-Q$], placement: "center")
  axis-label((1.86, 4.78), [$R_1$], placement: "south")
  axis-label((3.00, 4.12), [$R_2$], placement: "west")
  axis-label((3.36, 4.72), [$R_3$], placement: "west")

  // Simbolo di terra.
  line((0.67, 4.16), (0.26, 4.16), stroke: 1.0pt + ink)
  line((0.26, 4.16), (0.26, 3.22), stroke: 1.0pt + ink)
  line((-0.05, 3.22), (0.57, 3.22), stroke: 1.0pt + ink)
  line((0.05, 3.02), (0.47, 3.02), stroke: 1.0pt + ink)
  line((0.15, 2.84), (0.37, 2.84), stroke: 1.0pt + ink)

  line((4.02, 2.78), (4.02, 5.44), stroke: 0.55pt + rgb("#ccd4d8"))
  axis-label((4.50, 4.90), [$U=Q^2/(2C)=Q Delta V/2$], placement: "west")
  axis-label((4.50, 4.12), [$=Q^2/(8 pi epsilon_0)(1/R_1-1/R_2)$], placement: "west")
  axis-label((4.50, 3.34), [conta solo il condensatore tra $R_1$ e $R_2$], placement: "west")

  axis-label((1.64, 2.34), [se non è scaricato a terra], placement: "south")
  axis-label((4.62, 2.34), [$U=Q^2/(2 C_"condensatore") + Q^2/(2 C_"conduttore")$], placement: "west")

  // Sistema non scaricato = condensatore + conduttore esterno.
  circle((1.02, 0.90), radius: 0.34, stroke: 1.05pt + ink, fill: rgb("#f7f7f7"))
  circle((1.02, 0.90), radius: 0.72, stroke: 1.05pt + ink, fill: none)
  circle((1.02, 0.90), radius: 0.96, stroke: 1.05pt + ink, fill: none)
  // Tratteggi solo nelle parti conduttrici: sfera interna e guscio esterno.
  for seg in (((0.84, 0.66), (1.06, 1.20)), ((1.02, 0.58), (1.22, 1.10)), ((0.72, 0.86), (0.90, 1.26))) {
    line(seg.at(0), seg.at(1), stroke: 0.44pt + rgb("#aeb5ba"))
  }
  for seg in (((0.30, 0.62), (0.55, 1.40)), ((0.48, 0.30), (0.74, 0.94)), ((0.68, 1.64), (0.98, 1.90)), ((1.42, 1.74), (1.74, 1.34)), ((1.56, 0.38), (1.82, 1.10))) {
    line(seg.at(0), seg.at(1), stroke: 0.44pt + rgb("#aeb5ba"))
  }
  circle((1.02, 0.90), radius: 0.34, stroke: 1.05pt + ink, fill: none)
  circle((1.02, 0.90), radius: 0.72, stroke: 1.05pt + ink, fill: none)
  circle((1.02, 0.90), radius: 0.96, stroke: 1.05pt + ink, fill: none)
  axis-label((1.02, 0.90), [$Q$])
  axis-label((0.60, 1.12), [$Q$], placement: "center")
  axis-label((1.48, 1.08), [$-Q$], placement: "center")
  axis-label((1.72, 1.70), [$Q$], placement: "center")

  axis-label((2.38, 0.90), [$=$], placement: "center")

  circle((3.58, 0.90), radius: 0.36, stroke: 1.05pt + ink, fill: rgb("#f7f7f7"))
  circle((3.58, 0.90), radius: 0.84, stroke: 1.05pt + ink, fill: none)
  for seg in (((3.38, 0.62), (3.62, 1.24)), ((3.58, 0.54), (3.80, 1.12)), ((3.26, 0.88), (3.46, 1.24))) {
    line(seg.at(0), seg.at(1), stroke: 0.44pt + rgb("#aeb5ba"))
  }
  circle((3.58, 0.90), radius: 0.36, stroke: 1.05pt + ink, fill: none)
  circle((3.58, 0.90), radius: 0.84, stroke: 1.05pt + ink, fill: none)
  axis-label((3.58, 0.90), [$Q$])
  axis-label((4.08, 0.54), [$-Q$], placement: "center")
  axis-label((3.28, 1.44), [$R_1$], placement: "south")
  axis-label((3.08, 1.78), [$R_2$], placement: "south")
  axis-label((3.58, -0.24), [condensatore], placement: "north")

  axis-label((4.86, 0.90), [$+$], placement: "center")

  circle((6.08, 0.90), radius: 0.84, stroke: 1.05pt + ink, fill: rgb("#f7f7f7"))
  // Solo metà del conduttore esterno è tratteggiata, come negli appunti.
  line((6.08, 0.06), (6.08, 1.74), stroke: 0.72pt + rgb("#aeb5ba"))
  for seg in (((5.54, 0.36), (5.94, 1.50)), ((5.74, 0.16), (6.08, 1.16)), ((5.96, 0.12), (6.08, 0.48)), ((5.44, 0.72), (5.72, 1.36))) {
    line(seg.at(0), seg.at(1), stroke: 0.44pt + rgb("#aeb5ba"))
  }
  circle((6.08, 0.90), radius: 0.84, stroke: 1.05pt + ink, fill: none)
  axis-label((5.72, 1.76), [$R_3$], placement: "south")
  axis-label((6.76, 1.56), [$Q$], placement: "west")
  axis-label((6.08, -0.24), [conduttore], placement: "north")
})))

== Esempio: condensatore piano

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

Il risultato del condensatore piano suggerisce una forma generale: l'energia elettrostatica può essere descritta come energia distribuita nello spazio in cui esiste il campo elettrico.

Se $dif tau$ è un elemento di volume, la densità di energia elettrostatica è

#yellow-box([Densità di energia del campo elettrico])[
  $ mu_e = epsilon_0/2 E^2, quad [mu_e] = "J"/"m"^3. $
]

L'energia totale del sistema è quindi

#green-box([Energia localizzata nel campo])[
  $ U_"sistema" = integral_"tutto lo spazio" mu_e dif tau
  = integral_"tutto lo spazio" epsilon_0/2 E^2 dif tau. $
]

Questa espressione è particolarmente utile perché non richiede di sommare direttamente l'interazione fra tutte le coppie di cariche: basta conoscere il campo elettrico nello spazio.

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

Per una carica puntiforme $Q$, il campo elettrico a distanza $r$ è radiale:

$ vec(E)(r) = Q/(4 pi epsilon_0 r^2) hat(r). $

La densità di energia associata al campo vale

#blue-box([Densità di energia di una carica puntiforme])[
  $ mu_e(r) = epsilon_0/2 E^2
  = epsilon_0/2 (Q/(4 pi epsilon_0 r^2))^2
  = Q^2/(32 pi^2 epsilon_0 r^4). $
]

La dipendenza $1/r^4$ mostra che l'energia del campo cresce molto vicino alla carica. Nel modello ideale di carica puntiforme, questo segnala una singolarità per $r -> 0$.

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

In elettrostatica le cariche sono ferme e il campo elettrico è conservativo. Le due relazioni fondamentali, già incontrate, sono

#blue-box([Equazioni elettrostatiche])[
  $ integral_S vec(E) dot dif vec(S) = Q_"int"/epsilon_0, quad
  integral_Gamma vec(E) dot dif vec(ell) = 0. $
]

La prima dice che le sorgenti del campo elettrico sono le cariche elettriche: vale sempre. La seconda dice che la circuitazione del campo elettrostatico è nulla: vale solo in elettrostatica, perché il campo elettrostatico è conservativo.

In elettrodinamica le cariche sono in moto. Se lungo un percorso chiuso si ha

$ integral_Gamma vec(E) dot dif vec(ell) != 0, $

allora il campo compie lavoro netto su una carica che percorre il circuito. In questo caso il campo elettrico non è conservativo e non si può descrivere tutto il fenomeno con il solo potenziale elettrostatico $V$.

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

La *forza elettromotrice* non è una forza meccanica: è il lavoro per unità di carica compiuto da forze non elettrostatiche per mantenere separate le cariche e alimentare il circuito. Si indica con $cal(E)$ e si misura in volt.

#green-box([Forza elettromotrice])[
  $ cal(E) = integral_-^+ vec(F)_"non el"/q dot dif vec(ell)
  = V^+ - V^-. $
]

Il generatore compie lavoro contro il campo elettrico interno: porta cariche positive dal polo negativo al polo positivo. Nel circuito esterno, invece, il campo elettrico guida le cariche positive dal potenziale maggiore al potenziale minore.

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

La corrente elettrica misura quanta carica attraversa una superficie in un intervallo di tempo. Se $dif q$ attraversa la sezione in un tempo $dif t$, l'intensità di corrente è

#blue-box([Intensità di corrente])[
  $ i = (dif q)/(dif t), quad [i] = "A". $
]

L'ampere è quindi un coulomb al secondo:

$ 1 " A" = 1 " C"/"s". $

Per convenzione il verso della corrente è il verso del moto delle cariche positive. In un metallo, però, le cariche mobili sono elettroni: gli elettroni si muovono in verso opposto alla corrente convenzionale.

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

La densità di corrente descrive la carica che attraversa una superficie unitaria nell'unità di tempo. È un vettore e si misura in ampere su metro quadrato.

#green-box([Densità di corrente])[
  $ i = integral_"sup" vec(J) dot dif vec(S), quad [J] = "A"/"m"^2. $
]

Il prodotto scalare conta solo la componente di $vec(J)$ ortogonale alla superficie. Se la superficie è perpendicolare al flusso di cariche, il flusso è massimo; se è parallela al moto, è nullo.

In condizioni stazionarie, la corrente è la stessa in ogni sezione di un conduttore: non si accumula carica dentro il filo.

#yellow-box([Corrente stazionaria])[
  $ i = "costante lungo il conduttore". $
]

Per un conduttore con due sezioni $S_1$ e $S_2$:

$ J_1 S_1 = J_2 S_2. $

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

In assenza di campo elettrico applicato, gli elettroni in un metallo hanno moto termico disordinato. La velocità media è nulla:

$ overline(vec(v)_T) = 0, $

anche se le velocità istantanee sono elevate, dell'ordine di $10^2 " m"/"s"$.

Quando si applica un campo elettrico, al moto termico si sovrappone un piccolo moto ordinato: la *velocità di deriva*. Per gli elettroni il verso della deriva è opposto al campo, ma la corrente convenzionale è nel verso di $vec(E)$.

#blue-box([Modello microscopico])[
  $ vec(J) = n q overline(vec(v)_d). $
]

Qui $n$ è la densità di portatori di carica, $q$ la carica del portatore e $overline(vec(v)_d)$ la velocità media di deriva.

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

In molti materiali ordinari, detti *ohmici*, si osserva sperimentalmente una relazione lineare tra differenza di potenziale e corrente:

#green-box([Legge di Ohm])[
  $ V = R i. $
]

La costante $R$ è la resistenza elettrica e si misura in ohm:

$ [R] = Omega. $

Per un conduttore filiforme omogeneo di lunghezza $ell$ e sezione $S$:

#yellow-box([Resistenza di un conduttore filiforme])[
  $ R = rho ell/S. $
]

La grandezza $rho$ è la resistività del materiale. A parità di materiale, un filo più lungo ha resistenza maggiore, mentre una sezione più grande riduce la resistenza.

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

Se una carica $dif q$ attraversa un elemento con differenza di potenziale $V$, il lavoro elettrico vale

$ dif L = V dif q. $

La potenza elettrica è il lavoro per unità di tempo:

#blue-box([Potenza elettrica])[
  $ P = (dif L)/(dif t) = V i quad ["W"]. $
]

Per un generatore ideale con fem $cal(E)$:

$ P_"erogata" = cal(E) i. $

Per un resistore ohmico, usando $V=R i$:

#yellow-box([Effetto Joule])[
  $ P_"dissipata" = R i^2 > 0. $
]

La potenza dissipata in un resistore si trasforma in calore: è l'effetto Joule.

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

Una rete di resistori vista da due morsetti può spesso essere sostituita da un unico resistore equivalente $R_"eq"$, scelto in modo che, a parità di tensione applicata, assorba la stessa corrente totale.

Per resistori in serie la corrente è la stessa in ogni elemento. Le cadute di tensione si sommano:

$ V_"tot" = sum_k V_k = sum_k R_k i = i sum_k R_k. $

Quindi

#blue-box([Resistori in serie])[
  $ R_"serie" = sum_k R_k. $
]

Per resistori in parallelo la tensione è la stessa su ogni ramo. Le correnti si sommano:

$ i_"tot" = sum_k i_k = sum_k V/R_k = V sum_k 1/R_k. $

Quindi

#blue-box([Resistori in parallelo])[
  $ 1/R_"parallelo" = sum_k 1/R_k,
  quad R_"parallelo" = (sum_k 1/R_k)^(-1). $
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

Le reti lineari si risolvono fissando una convenzione prima di scrivere le equazioni:

1. si sceglie un verso di percorrenza per ogni maglia;
2. si sceglie un verso per le correnti incognite;
3. si assegna il segno alle F.E.M. $cal(E)_k$;
4. si assegna il segno alle cadute ohmiche $R_k i_k$.

La prima legge è una forma della conservazione della carica: in un nodo non si accumula carica.

#green-box([Prima legge di Kirchhoff: nodi])[
  $ sum_k i_k = 0. $
]

La seconda legge è una forma della conservazione dell'energia lungo una maglia chiusa:

#green-box([Seconda legge di Kirchhoff: maglie])[
  $ sum_k cal(E)_k = sum_k R_k i_k. $
]

Con la convenzione usata negli appunti: attraversare un generatore dal polo $-$ al polo $+$ dà $+cal(E)$; attraversarlo da $+$ a $-$ dà $-cal(E)$. Per un resistore, se la corrente ha lo stesso verso della maglia si scrive $+R i$, altrimenti $-R i$.

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

Nel circuito degli appunti i due generatori reali hanno resistenze interne $r_1$ e $r_2$ e sono collegati tramite un resistore di carico $R$. I dati sono

$ r_1=20 Omega, quad r_2=30 Omega, quad R=50 Omega, quad cal(E)_1=50 " V", quad cal(E)_2=100 " V". $

Si fissa un verso positivo di maglia e si scrive l'unica equazione di Kirchhoff:

$ cal(E)_1 - cal(E)_2 = (r_1 + R + r_2) i. $

Da cui

#yellow-box([Corrente nella maglia])[
  $ i = (cal(E)_1 - cal(E)_2)/(R+r_1+r_2)
  = (50-100)/(50+20+30) " A" = -0.5 " A". $
]

Il segno meno dice che la corrente reale è opposta al verso scelto. In modulo vale $0.5 " A"$.

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

Il bilancio di potenza dice che la potenza erogata dai generatori è uguale alla potenza dissipata nei resistori:

#green-box([Bilancio di potenza nella maglia])[
  $ (cal(E)_2-cal(E)_1) i = (R+r_1+r_2) i^2. $
]

== Circuito RC: scarica del condensatore

Un circuito RC non è lineare nel tempo perché le grandezze non restano costanti: la carica del condensatore, la tensione e la corrente variano esponenzialmente.

Nella scarica il condensatore è inizialmente carico:

$ Q(t_0)=Q_0, quad V_0=Q_0/C. $

Chiudendo l'interruttore, la carica passa nel resistore. La corrente di scarica è legata alla diminuzione della carica:

$ i(t) = - (dif Q)/(dif t). $

Poiché $V_C(t)=Q(t)/C$ e $i(t)=V_R(t)/R$, dalla legge di maglia si ottiene

$ (dif Q)/(dif t) + Q/(R C) = 0. $

Integrando:

#blue-box([Scarica RC])[
  $ Q(t)=Q_0 e^(-t/tau), quad
    V(t)=V_0 e^(-t/tau), quad
    i(t)=i_0 e^(-t/tau), quad
    tau=R C. $
]

Il tempo $tau=R C$ è il *tempo caratteristico*: indica la scala temporale della scarica. Dopo un tempo molto grande il condensatore è praticamente scarico.

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

Integrando nel tempo si ottiene l'energia totale dissipata:

#yellow-box([Energia dissipata nella scarica])[
  $ L_"tot" = integral_0^infinity P(t) dif t
  = (C V_0^2)/2
  = Q_0^2/(2 C). $
]

Questa è proprio l'energia inizialmente immagazzinata nel condensatore.

== Circuito RC: carica del condensatore

Nella carica RC il condensatore parte scarico:

$ Q(0)=0. $

Il generatore di F.E.M. $cal(E)$ fornisce energia al circuito. La tensione finale sul condensatore è $V_"fin"=cal(E)$, quindi

$ Q_"fin" = C cal(E). $

La carica cresce verso il valore finale con legge esponenziale:

#blue-box([Carica RC])[
  $ Q(t)=Q_"fin" (1-e^(-t/tau)), quad
    V_C(t)=cal(E)(1-e^(-t/tau)), quad
    tau=R C. $
]

La corrente invece è massima all'inizio e poi decresce:

$ i(t)=cal(E)/R e^(-t/tau). $

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

Durante la carica, l'energia erogata dal generatore non finisce tutta nel condensatore: metà viene dissipata nel resistore e metà resta immagazzinata nel campo elettrico del condensatore.

#yellow-box([Bilancio energetico nella carica RC])[
  $ U_"erogata" = C cal(E)^2, quad
  U_R = 1/2 C cal(E)^2, quad
  U_C = 1/2 C cal(E)^2. $
]

= Principi della magnetostatica

La magnetostatica studia campi magnetici prodotti da correnti stazionarie. A differenza del campo elettrico, il campo magnetico non nasce da una singola "carica magnetica" isolata: non esiste il monopolo magnetico osservato negli esperimenti ordinari.

Un magnete ha sempre due poli, nord e sud. Se lo si divide, non si separa un polo nord da un polo sud: si ottengono magneti più piccoli, ciascuno con entrambi i poli.

#green-box([Assenza di monopoli magnetici])[
  Le linee del campo magnetico sono chiuse:
  $ integral_S vec(B) dot hat(n) dif S = 0, quad nabla dot vec(B)=0. $
]

Il vettore $vec(B)$ è il *campo magnetico*. Le sue linee non cominciano e non finiscono su sorgenti isolate: formano anelli chiusi.

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

Oersted osservò che una corrente elettrica devia un ago magnetico: le sorgenti del campo magnetico sono le cariche in moto, cioè le correnti.

#blue-box([Idea fondamentale])[
  Una corrente stazionaria genera un campo magnetico $vec(B)$ le cui linee circondano il filo.
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

Nel caso magnetostatico, cioè con correnti stazionarie, la circuitazione del campo magnetico lungo una linea chiusa $Gamma$ è proporzionale alla corrente concatenata con quella linea.

#green-box([Teorema di Ampère])[
  $ integral_Gamma vec(B) dot dif vec(ell) = mu_0 i_"conc". $
]

La costante $mu_0$ è la *permeabilità magnetica del vuoto*. Nel sistema SI vale

$ mu_0 = 4 pi dot 10^(-7) " N"/"A"^2. $

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

Il campo magnetico è prodotto da cariche in moto e agisce su cariche in moto. La forza magnetica su una carica $q$ che si muove con velocità $vec(v)$ è

#blue-box([Forza magnetica su una carica])[
  $ vec(F)_B = q vec(v) times vec(B). $
]

La forza è perpendicolare sia alla velocità sia al campo magnetico. Per questo motivo la potenza istantanea della forza magnetica è nulla:

$ P = vec(F)_B dot vec(v) = 0. $

Il campo magnetico può deviare la traiettoria, ma non cambia direttamente il modulo della velocità né l'energia cinetica della carica.

Se sono presenti sia campo elettrico sia campo magnetico, la forza totale è la forza di Lorentz:

#green-box([Forza di Lorentz])[
  $ vec(F) = q vec(E) + q vec(v) times vec(B). $
]

Su un tratto infinitesimo di filo percorso da corrente $i$ la forza magnetica è

#yellow-box([Forza su un filo percorso da corrente])[
  $ dif vec(F) = i dif vec(ell) times vec(B). $
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

Una spira elementare percorsa da corrente si comporta come un *dipolo magnetico*. Il suo momento di dipolo magnetico è

#green-box([Momento di dipolo magnetico])[
  $ vec(mu) = i vec(S). $
]

Il vettore $vec(S)$ è perpendicolare al piano della spira e ha modulo pari all'area della spira; il verso si sceglie con la regola della mano destra rispetto al verso della corrente.

In un campo magnetico esterno uniforme, i lati della spira paralleli al campo non subiscono forza. Gli altri lati subiscono forze opposte che formano una coppia: la spira ruota fino ad allineare $vec(mu)$ con $vec(B)$.

#blue-box([Coppia ed energia del dipolo magnetico])[
  $ vec(tau) = vec(mu) times vec(B), quad
    U = - vec(mu) dot vec(B). $
]

L'equilibrio stabile si ha per $vec(mu)$ parallelo a $vec(B)$; l'equilibrio instabile per $vec(mu)$ antiparallelo a $vec(B)$.

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

In elettrostatica il campo elettrico è conservativo e le sorgenti sono le cariche. In magnetostatica, invece, le sorgenti sono le correnti: non ci sono monopoli magnetici e le linee di $vec(B)$ sono chiuse.

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

Consideriamo un cilindro indefinito di raggio $R$, percorso da corrente stazionaria lungo il suo asse. Per simmetria cilindrica le linee di $vec(B)$ sono circonferenze centrate sull'asse del cilindro e il modulo dipende solo dalla distanza $r$ dall'asse.

Scegliendo come linea amperiana una circonferenza di raggio $r$:

$ integral_Gamma vec(B) dot dif vec(ell) = B(r) 2 pi r = mu_0 i_"conc". $

Se la corrente è distribuita uniformemente nel volume, con densità $J$:

$ i = J pi R^2. $

Per $r > R$ la corrente concatenata è tutta la corrente $i$, quindi

$ B(r)=mu_0 i/(2 pi r). $

Per $r < R$ è concatenata solo la corrente dentro il cerchio di raggio $r$:

$ i_"conc" = J pi r^2, quad
  B(r)=mu_0 J r / 2 = mu_0 i r/(2 pi R^2). $

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

Se invece la corrente scorre solo sulla superficie cilindrica, per $r<R$ non c'è corrente concatenata e il campo interno è nullo:

$ B(r)=0 quad (r<R). $

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

In un solenoide toroidale le spire sono avvolte attorno a una corona. Usando una circonferenza amperiana coassiale al toroide:

$ B(r) 2 pi r = mu_0 N i. $

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

Due fili rettilinei paralleli percorsi da corrente esercitano forze magnetiche reciproche. Il primo filo genera, alla distanza $d$, un campo

$ B_1(d)=mu_0 i_1/(2 pi d). $

Il secondo filo, percorso da corrente $i_2$, subisce la forza magnetica

$ dif vec(F) = i_2 dif vec(ell) times vec(B)_1. $

Per unità di lunghezza:

#green-box([Forza per unità di lunghezza tra fili paralleli])[
  $ F/ell = (mu_0 i_1 i_2)/(2 pi d). $
]

Correnti nello stesso verso si attraggono; correnti in verso opposto si respingono.

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

Finora abbiamo visto che una corrente genera un campo magnetico e che un campo magnetico esercita forze su cariche in moto. L'osservazione sperimentale successiva è che un campo magnetico variabile, oppure un circuito che si muove in un campo magnetico, può generare una F.E.M. e quindi una corrente indotta.

Il fenomeno si descrive con il *flusso magnetico* attraverso una superficie $S$:

#blue-box([Flusso magnetico])[
  $ Phi_B = integral_S vec(B) dot dif vec(S). $
]

Per un campo uniforme perpendicolare alla superficie, $Phi_B = B S$. In generale il flusso cambia se cambia il campo $vec(B)$, se cambia l'area della superficie, oppure se cambia l'orientazione della superficie rispetto al campo.

La legge di Faraday-Lenz afferma che una variazione del flusso magnetico genera una F.E.M. indotta:

#green-box([Legge di Faraday-Lenz])[
  $ cal(E)_"ind" = - (dif Phi_B)/(dif t). $
]

Il segno meno è la *legge di Lenz*: la corrente indotta ha verso tale da opporsi alla variazione di flusso che l'ha generata. Se il flusso aumenta, il campo indotto tende a ridurlo; se il flusso diminuisce, il campo indotto tende a mantenerlo.

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

Consideriamo una barretta conduttrice di lunghezza $a$ che scorre con velocità $v$ su due guide conduttrici, chiuse da un resistore $R$, in un campo magnetico uniforme perpendicolare al circuito.

Se la posizione della barretta è $x(t)$, l'area del circuito è $S=a x$, quindi

$ Phi_B = B a x. $

La F.E.M. indotta vale

$ cal(E)_"ind" = - (dif Phi_B)/(dif t) = - B a v. $

In modulo la corrente indotta è

#yellow-box([Corrente indotta nella barretta mobile])[
  $ i_"ind" = (B a v)/R. $
]

La forza magnetica sulla barretta è opposta al moto: agisce come un attrito elettromagnetico. In modulo

$ F = i a B = (B^2 a^2/R) v. $

Se si vuole mantenere la velocità costante, una forza esterna deve fornire la potenza meccanica

$ P_"mecc" = F v = (B^2 a^2 v^2)/R. $

Questa potenza coincide con la potenza dissipata per effetto Joule:

$ P_"Joule" = R i_"ind"^2 = (B^2 a^2 v^2)/R. $

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

Quando una corrente attraversa un circuito, genera un campo magnetico. Il flusso del campo prodotto dal circuito attraverso il circuito stesso si chiama *autoflusso*.

Per circuiti lineari l'autoflusso è proporzionale alla corrente:

#green-box([Induttanza])[
  $ Phi_B = L i. $
]

La costante $L$ è l'*induttanza* e si misura in henry:

$ [L] = "H". $

Se la corrente varia nel tempo, varia anche l'autoflusso e quindi nasce una F.E.M. autoindotta:

#blue-box([Autoinduzione])[
  $ cal(E)_L = - (dif Phi_B)/(dif t) = - L (dif i)/(dif t). $
]

Il segno meno indica che l'induttore si oppone alla variazione della corrente: si oppone all'aumento quando il circuito si accende e si oppone alla diminuzione quando il circuito si spegne.

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

In un circuito formato da un generatore ideale $V_0$, una resistenza $R$ e un'induttanza $L$, la legge di maglia durante l'accensione è

#yellow-box([Legge di Ohm generalizzata per RL])[
  $ V_0 - L (dif i)/(dif t) = R i. $
]

La corrente non passa istantaneamente da zero al valore di regime: cresce esponenzialmente con tempo caratteristico

$ tau = L/R. $

Durante l'accensione:

#blue-box([Accensione RL])[
  $ i(t)=V_0/R (1-e^(-t/tau)), quad tau=L/R. $
]

Durante lo spegnimento, l'energia accumulata nel campo magnetico dell'induttore viene restituita e dissipata nel resistore. La corrente decade:

#blue-box([Spegnimento RL])[
  $ i(t)=i_0 e^(-t/tau). $
]

La potenza associata all'induttore è

$ P_L = cal(E)_L i = - L i (dif i)/(dif t). $

Il segno dipende dal fatto che l'induttore stia assorbendo energia dal circuito oppure restituendola.

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

Se due circuiti sono vicini, una corrente variabile nel primo può modificare il flusso magnetico concatenato con il secondo. Si parla di *mutua induzione*.

Per circuiti lineari:

#green-box([Coefficiente di mutua induzione])[
  $ Phi_(1,2) = M i_1, quad Phi_(2,1) = M i_2. $
]

La costante $M$ misura quanto i due circuiti sono accoppiati magneticamente. Se la corrente in un circuito varia nel tempo, nell'altro può nascere una F.E.M. indotta.

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

Le equazioni di Maxwell riuniscono elettrostatica, magnetostatica e induzione. In regime stazionario non compaiono derivate temporali: i campi non cambiano nel tempo.

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

#green-box([Maxwell non stazionario])[
  $ integral_Gamma vec(E) dot dif vec(ell) = - (dif Phi_B)/(dif t), quad
    integral_Gamma vec(B) dot dif vec(ell) = mu_0 i + mu_0 epsilon_0 (dif Phi_E)/(dif t). $
]

In forma locale:

#blue-box([Maxwell in forma locale])[
  $ nabla times vec(E) = - partial_t vec(B), quad
    nabla times vec(B) = mu_0 vec(J) + mu_0 epsilon_0 partial_t vec(E), $
  $ nabla dot vec(E) = rho/epsilon_0, quad
    nabla dot vec(B)=0. $
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

Nel vuoto non ci sono cariche libere né correnti:

$ rho = 0, quad vec(J)=0. $

Le equazioni di Maxwell diventano

$ nabla dot vec(E)=0, quad nabla dot vec(B)=0, $

$ nabla times vec(E)=-partial_t vec(B), quad
  nabla times vec(B)=mu_0 epsilon_0 partial_t vec(E). $

Da queste equazioni segue che i campi $vec(E)$ e $vec(B)$ possono propagarsi come onde elettromagnetiche. La velocità di propagazione nel vuoto è

#purple-box([Velocità della luce])[
  $ c = 1/sqrt(epsilon_0 mu_0). $
]

Nel vuoto, per un'onda piana, i campi sono perpendicolari tra loro e alla direzione di propagazione. I moduli sono legati da

#blue-box([Relazione tra i campi nell'onda])[
  $ abs(vec(B)) = abs(vec(E))/c. $
]

La luce è un'onda elettromagnetica.

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
