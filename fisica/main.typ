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
  arc((1.15, 0.35), start: 0deg, stop: 28deg, radius: 0.6, stroke: 1pt + blue)
  axis-label((1.2, 0.58), [$theta$], placement: "south")
  axis-label((3.16, 0.55), [$m vec(g)$], placement: "west")
  axis-label((2.08, 3.2), [$vec(N)$], placement: "east")
  axis-label((1.8, 1.0), [$m g sin theta$], placement: "east")
  axis-label((3.85, 0.33), [$m g cos theta$], placement: "west")
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
  line((3.0, 1.2), (3.0, 2.55), stroke: 1.5pt + green, mark: (end: ">"))
  line((3.0, 1.2), (3.0, 0.05), stroke: 1.5pt + red, mark: (end: ">"))
  arc((3.75, 1.2), start: 0deg, stop: 35deg, radius: 0.75, stroke: 1pt + gold)
  axis-label((4.82, 2.5), [$vec(F)$], placement: "west")
  axis-label((3.18, 2.5), [$vec(N)$], placement: "west")
  axis-label((3.18, 0.12), [$m vec(g)$], placement: "west")
  axis-label((3.66, 1.47), [$theta$], placement: "south")
  axis-label((1.2, 0.25), [superficie liscia], placement: "north")
  // diagramma delle forze isolato, a destra
  circle((7.1, 1.25), radius: 0.09, fill: ink, stroke: none)
  line((7.1, 1.25), (8.55, 2.3), stroke: 1.6pt + blue, mark: (end: ">"))
  line((7.1, 1.25), (7.1, 2.65), stroke: 1.5pt + green, mark: (end: ">"))
  line((7.1, 1.25), (7.1, -0.05), stroke: 1.5pt + red, mark: (end: ">"))
  axis-label((8.62, 2.35), [$vec(F)$], placement: "west")
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

Nel caso orizzontale con una forza applicata $F$:

$ N-m g=0 quad arrow quad N=m g. $

Se il blocco è in quiete, l'attrito statico compensa la forza applicata finché

$ F <= mu_s m g. $

Se il corpo scivola verso destra, l'attrito dinamico è verso sinistra e

$ F-mu_d m g=m a quad arrow quad a=(F-mu_d m g)/m. $

== Forza inclinata e attrito

Se la forza applicata forma un angolo $theta$ sopra l'orizzontale, la componente verticale alleggerisce il contatto e quindi riduce l'attrito massimo.

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
  arc((3.55, 1.1), start: 0deg, stop: 34deg, radius: 0.62, stroke: 0.9pt + gold)
  axis-label((4.52, 2.2), [$vec(F)$], placement: "west")
  axis-label((1.58, 1.15), [$vec(F)_"attr"$], placement: "east")
  axis-label((3.1, 2.38), [$vec(N)$], placement: "west")
  axis-label((3.1, 0.0), [$m vec(g)$], placement: "west")
  axis-label((3.58, 1.34), [$theta$], placement: "south")
  // corpo libero
  circle((6.1, 1.15), radius: 0.08, fill: ink, stroke: none)
  line((6.1, 1.15), (7.25, 1.92), stroke: 1.45pt + blue, mark: (end: ">"))
  line((6.1, 1.15), (5.12, 1.15), stroke: 1.45pt + red, mark: (end: ">"))
  line((6.1, 1.15), (6.1, 2.35), stroke: 1.4pt + green, mark: (end: ">"))
  line((6.1, 1.15), (6.1, 0.0), stroke: 1.4pt + red, mark: (end: ">"))
  axis-label((7.3, 1.96), [$vec(F)$], placement: "west")
  axis-label((5.05, 1.2), [$vec(F)_"attr"$], placement: "east")
})))

Le equazioni sono

$ N+F sin theta-m g=0 quad arrow quad N=m g-F sin theta, $

e, in quiete,

$ F cos theta <= mu_s (m g-F sin theta). $

Se il corpo è in moto verso destra,

$ F cos theta-mu_d (m g-F sin theta)=m a_x, $

cioè

$ a_x=(F cos theta-mu_d (m g-F sin theta))/m. $

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

Nel caso degli appunti, $m_1$ è su un piano liscio inclinato di $theta$ e $m_2$ è sospesa. Se $m_2$ scende, $m_1$ sale lungo il piano.

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
  line((6.25, 1.55), (7.25, 2.2), stroke: 1.35pt + blue, mark: (end: ">"))
  line((6.25, 1.55), (5.6, 2.65), stroke: 1.35pt + green, mark: (end: ">"))
  line((6.25, 1.55), (6.25, 0.35), stroke: 1.35pt + red, mark: (end: ">"))
  circle((8.6, 1.55), radius: 0.08, fill: ink, stroke: none)
  line((8.6, 1.55), (8.6, 2.65), stroke: 1.35pt + blue, mark: (end: ">"))
  line((8.6, 1.55), (8.6, 0.35), stroke: 1.35pt + red, mark: (end: ">"))
})))

Le equazioni lungo le direzioni di moto sono

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
  line((6.0, 1.55), (6.75, 1.55), stroke: (paint: grid-color, thickness: 0.9pt, dash: "dashed"))
  line((6.75, 1.55), (6.75, 2.6), stroke: (paint: grid-color, thickness: 0.9pt, dash: "dashed"))
  axis-label((6.9, 2.78), [$vec(T)$], placement: "west")
  axis-label((6.18, 0.35), [$m vec(g)$], placement: "west")
  axis-label((6.72, 1.35), [$T sin theta$], placement: "north")
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

Un blocco sale lungo un piano inclinato liscio per uno spostamento $s$, con velocità costante. La risultante è nulla, quindi la forza esterna lungo il piano compensa la componente del peso.

#align(center, graph-card([Lavoro su piano inclinato liscio], cetz.canvas({
  import cetz.draw: *
  line((0.65, 0.45), (5.4, 2.95), stroke: 1.4pt + ink)
  line((0.65, 0.45), (5.4, 0.45), stroke: 0.9pt + grid-color)
  line((5.4, 2.95), (5.4, 0.45), stroke: 0.9pt + grid-color)
  rect((2.35, 1.25), (3.05, 1.82), fill: rgb("#edf3f8"), stroke: 0.9pt + ink)
  line((2.7, 1.54), (3.85, 2.15), stroke: 1.45pt + blue, mark: (end: ">"))
  line((2.7, 1.54), (2.05, 2.62), stroke: 1.35pt + green, mark: (end: ">"))
  line((2.7, 1.54), (2.7, 0.35), stroke: 1.35pt + red, mark: (end: ">"))
  line((2.0, 0.9), (4.35, 2.14), stroke: 1pt + gold, mark: (end: ">"))
  line((3.95, 0.45), (3.95, 2.22), stroke: (paint: grid-color, thickness: 0.8pt, dash: "dashed"))
  arc((1.05, 0.45), start: 0deg, stop: 28deg, radius: 0.6, stroke: 0.9pt + gold)
  axis-label((1.1, 0.68), [$theta$], placement: "south")
  axis-label((3.92, 2.2), [$vec(F)$], placement: "west")
  axis-label((1.95, 2.68), [$vec(N)$], placement: "east")
  axis-label((2.9, 0.45), [$m vec(g)$], placement: "west")
  axis-label((3.35, 1.35), [$s$], placement: "north")
  axis-label((4.1, 1.27), [$h=s sin theta$], placement: "west")
})))

Con $v$ costante, $sum vec(F)=vec(0)$:

$ N=m g cos theta, quad F-m g sin theta=0. $

Il lavoro della forza esterna è

$ L=F s=m g sin theta, s=m g h. $
