#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Advanced Graph Theory",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures given by Dr. MEHDAOUI.],
  )
)

#let card = math.op("#")

#chapter("Fundamental Concepts")[]

#section[Definitions & Notations]
#subsection[Types Of Graphs]
#def(name: "Undirected Graph")[
  An undirected graph $G$ is an ordered pair $G=(V, E)$ where $V$ is a finite set called the vertex set (vertices) and $E subset {{u, v} | u, v in V}$ called the set of edges.
]

#def(name: "Directed Graph")[
  A directed graph $G$ is an ordered pair $G=(V, A)$ where $V$ is the set of vertices and $A subset V times V$ called the set of arcs or directed edges.
]

#def(name: "Unweighted Graph")[
  An unweighted graph $G$ is a graph is a graph where all edges are considered equal.
]

#def(name: "Weighted Graph")[
  A weighted graph $G=(V, E)$ is a graph where there is a function $w: E -> RR$ where for each edge $e in E$, the weight of $e$ is $w(e)$.
]

#subsection("Concepts On Vertices & Edges")
#def(name: "Adjacent/Incident/Isolated")[
  Let $G = (V, E)$ a graph:
  + Two vertices $u, v in V$ are adjacent or neighbors if ${u, v} in E$.
  + A vertex $v$ is called incident to an edge $e$ if $v$ is an endpoint of $e$.
  + A vertex with no incident edges is called isolated.
  + The order of $G$ is $card V$.
  + The size of $G$ is $card E$.
  + The open neighborhood of $v in V$ is $cal(N)(v) = {u in V | {u, v} in E}$.
  + The closed neighborhood of $v in V$ is $[v] = cal(N)(v) union {v}$.
  + A degree of a vertex $v$ denoted $d(v)$ or $deg(v)$ is the number of edges incident to $v$, that is $deg(v) = card N(v)$.
  + If $G$ is directed then we define the following:
    + The out neighborhood of $v in V$ is $cal(N)^+ (v) = {u in V | (v, u) in A}$.
    + The in neighborhood of $v in V$ is $cal(N)^- (v) = {u in V | (u, v) in A)$.
    + The in/out degree are $deg^- (v) = card cal(N)^- (v), deg^+ (v) = card cal(N)^+ (v)$.
  + The number of edges incident to $v$ with maximum degree of $G$, $Delta (G) = max_(v in V) d(v)$ and minimum degree is $delta (G) = min_(v in V) d(v)$.
]

#lem(name: "Handshake")[
  For an undirected graph $G=(V, E)$ then $
    sum_(v in V) deg(v) = 2 card E
  $
]

#prf[
  Every edge ${u, v} in E$ contributes exactly $1$ to $deg(u)$ and $1$ to $deg(v)$ thus adding $2$ to $sum_(v in V) deg(v)$, so all edges counted twice in the sum of all edges.
]

#thm[
  The number of vertices with odd degree is even.
]

#prf[
  Let $V_o = {v in V | d(v) "odd"}$ and $V_e = {v in V | d(v) "even"}$, by the handshake lemma we have $
    2 card E = sum_(v in V) deg(v) &= sum_(v in V_o) deg(v) + sum_(v in V_e) deg(v)
  $ given that $2 card E$ is even and $sum_(v in V_e) deg(V)$ is even then necessarily $sum_(v in V_o) deg(v)$ is even, and since the sum of odd numbers is even if and only if the number of odd numbers is even then $card V_o$ is even so there is an even number of odd degree vertices.
]

#subsection[Simple & Multigraphs]
#def(name: "Simple/Multi Graph")[
  A graph $G$ is said to be simple if it has no loops and no multiple edges. A multigraph is a graph that may have loops and have multiple edges.
]

#thm[
  In any simple graph $G$ with order $n >= 2$, there exists at least two vertices with same degree.
]

#prf[
  The possible degrees in a simple graph is ${0, dots, n-1}$, however a graph cannot have a vertex with degree $0$ and $n-1$ at the same time, so either it has vertices of degree ${1, dots, n-1}$ or ${0, dots, n-2}$, and since there are $n$ vertices and $n-1$ choices for degrees, then by the pigeonhole principle, there are at least two vertices with the same degrees.
]

#pro[
  There are $binom(n, 2)$ maximum edges in a simple graph.
]

#def(name: "Walk/Trail")[
  Let $G=(V, E)$ be a graph
  + A walk of length $k$ is a sequence $v_1, e_2, v_2, dots, e_k, v_k$ with $e_i = {v_(i-1), v_i} in E$.
  + A trail is a walk with no repeated edges.
  + A path is a walk with no repeated vertices.
  + A walk is closed if $v_0 = v_k$.
]

#thm[
  If there is a walk from vertex $u$ to $v$ then there is also a path from $u$ to $v$.
]

#prf[
  By induction on the length of the walk $n$. For $n = 1$, it is trivial since any $1$-walk is a path, now consider a walk of length $n$, $v_1, e_1, v_2, dots, v_(n-1), e_n, v_n$ , if $forall i, j in [|1, n|], i != j => v_i != v_j$ then it is a path, otherwise there exists $i, j$ such that $v_i, v_j$, we consider the new walk $v_1, e_1, v_2, dots, e_i, v_i, e_j, dots, e_n, v_n$, this walk has a strictly less length then the original, and thus by induction hypothesis, there is a walk from $v_1$ to $v_n$.
]

#def(name: "Circuit/Cycle")[
  + A circuit is a closed trail.
  + A cycle is a closed path.
  + A cycle of length $k$ is denoted $C_k$, unless otherwise specified.
  + The length of the cycle is the number of edges in it.
  + A graph $G$ is connected if for every pair of vertices $u, v in V$ there exists a path from $u$ to $v$, otherwise it is disconnected.
  + A subgraph $H$ of $G$ is a graph such that $V(H) subset V(G)$ and $E(H) subset E(G)$.
  + A connected component of $G$ is a maximum connected subgraph of $G$.
  + A spanning subgraph $H$ of $G$ is a subgraph such that $V(H) = V(G)$.
]

#thm[
  In a connected graph, any two longest paths share at least one vertex.
]

#prf[
  Suppose that there is a graph where two longest paths do not share a vertex, denote them $v_1, e_1, dots, e_(n-1), v_n$ and $v'_1, e'_1, dots, e'_(n-1), v'_n$, given that the graph is connected, then there is a path from some $v_i$ to $v'_j$ that does not intersect with the previous paths. Consider the path that goes through the furthest endpoint $v_1$ or $v_n$ from $v_i$, the path until $v_i$, then the path from $v_i$ to $v'_j$ and lastly to the furthest endpoint $v'_1$ or $v'_n$ from $v'_j$.
]

#def(name: "Induced/Complement Graph")[
  + An induced subgraph $G'$ is a subset $S subset V$ and all edges from $G$ that have both endpoints in $S$.
  + A complement graph $overline(G)$ of a graph $G$ has the same vertex set $V$, and $u v in E(overline(G)) <=> u v in.not E(G)$.
]

+ $card E(G) + card E(overline(G)) = binom(n, 2)$.
+ The number of simple graphs of order $n$ is $2^binom(n, 2)$.
+ The number of spanning subgraphs of $K_n$ with $m$ edges is $binom(binom(n, 2), m)$.
+ In a graph with $n$ vertices and $m$ edges, the number of induced subgraphs of $2^n$ and the number of spanning subgraphs is $2^m$.

#section[Graph Representations]
There are several ways to represent graphs in computer memory, each with different advantages for various algorithms and applications. We represent it efficiently in memory so that it does the basic operations like edge lookup and neighborhood efficiently and minimize space complexity.

We assume throughout the course that $card V(G) = n$ vertices and $card E(G) = m$ edges, vertices are labeled from $1$ to $n$. Graphs may be directed or undirected.

#subsection[Adjacency Matrix]
Let $G=(V, E)$ be a graph with $V = {v_1, dots, v_n}$, the adjacency matrix of $G$ is an $n times n$ matrix $A = (a_(i j))$ where $
  a_(i j) = cases(
    1 &"if" v_i v_j in E(G),
    0 &"otherwise"
  )
$

#exm[
  Here is a simple graph with its adjacency matrix
  #align(center,
    grid(
      columns: 2,
      column-gutter: 1cm,
      align: center + horizon,
      diagram({
        node((0cm, 0cm), $1$, stroke: 0.5pt, name: "1", radius: 0.4cm)
        node((2cm, 0cm), $2$, stroke: 0.5pt, name: "2", radius: 0.4cm)
        node((4cm, 0cm), $3$, stroke: 0.5pt, name: "3", radius: 0.4cm)
        node((2cm, -2cm), $4$, stroke: 0.5pt, name: "4", radius: 0.4cm)

        edge(label("1"), label("2"))
        edge(label("2"), label("3"))
        edge(label("2"), label("4"))
        edge(label("3"), label("4"))
      }),
      $A = mat(0, 1, 0, 0; 1, 0, 1, 1; 0, 1, 0, 1; 0, 1, 1, 0)$
    )
  )
]
For weighted graphs we take the adjacency matrix would be $
  a_(i j) = cases(
    w(v_i v_j) &"if" v_i v_j in E,
    "None" &"otherwise"
  )
$
If no edge exists, None, $infinity$ or $0$ can be assigned depending on the application.

+ Space complexity the adjacency matrix is $O(n^2)$.
+ Time to check if an edge exists is $O(1)$.
+ Time to find all neighbors of a vertex is $O(n)$.

#subsection[Adjacency List]
For a graph $G=(V, E)$ the adjacency list representation consists of an array Adj of $card V$ lists, one for each vertex in $V$. For each $u in V$, the adjacency list Adj[$u$] consists of all the vertices $v$ such that $u v in E$.

+ Space complexity $O(n + m)$.
+ Time to check if edge exists: $O(d)$ where $d$ is the degree of the vertex.
+ Time to find all neighbors of a vertex: $O(d)$.

For a weighted graph, we just add a couple $(v_j, w)$ if $v_i v_j in E$ with $w = w(v_i v_j)$.

#def(name: "Sparse/Dense Graph")[
  Let $G=(V, E)$ a graph, we say that $G$ is a sparse graph if $card E << card V^2$ and we call it dense if $card E approx Theta(card V^2)$.
]

In sparse graphs the adjacency list is preferred, while in dense graphs the adjacency matrix is preferred.

#subsection[Incidence Matrix]
Given a graph $G=(V, E)$, the incidence matrix $M$ is defined as follows $
  M_(i j) = cases(
    1 &"if" v_i "is incident to" e_j,
    0 &"otherwise"
  )
$
#align(center,
  grid(
    columns: 2,
    column-gutter: 1cm,
    align: center + horizon,
    diagram({
      node((0cm, 0cm), $1$, stroke: 0.5pt, name: "1", radius: 0.4cm)
      node((2cm, 0cm), $2$, stroke: 0.5pt, name: "2", radius: 0.4cm)
      node((4cm, 0cm), $3$, stroke: 0.5pt, name: "3", radius: 0.4cm)
      node((2cm, -2cm), $4$, stroke: 0.5pt, name: "4", radius: 0.4cm)

      edge(label("1"), label("2"), $e_1$)
      edge(label("2"), label("3"), $e_2$)
      edge(label("3"), label("4"), $e_3$, bend: 30deg)
      edge(label("2"), label("4"), $e_4$)
      edge(label("1"), label("4"), $e_5$, bend: -30deg)
    }),
    $M = mat(1, 0, 0, 0, 1; 1, 1, 0, 1, 0; 0, 1, 1, 0, 0; 0, 0, 1, 1, 1)$
  )
)

For a directed graph, we define the following representation $
  M_(i j) = cases(
    +1 &"if" e_j "enters the vertex" v_i,
    -1 &"if" e_j "leaves the vertex" v_i,
    0 &"otherwise"
  )
$
#colbreak()
#exm[
  Consider the following graph
  #v(5mm)
  #align(center)[
    #diagram({
      node((0cm, 2cm), $1$, stroke: 0.5pt, name: "1", radius: 0.4cm)
      node((0cm, 0cm), $2$, stroke: 0.5pt, name: "2", radius: 0.4cm)
      node((2cm, 2cm), $3$, stroke: 0.5pt, name: "3", radius: 0.4cm)
      node((2cm, 0cm), $4$, stroke: 0.5pt, name: "4", radius: 0.4cm)
      node((4cm, 2cm), $6$, stroke: 0.5pt, name: "6", radius: 0.4cm)
      node((4cm, 0cm), $5$, stroke: 0.5pt, name: "5", radius: 0.4cm)
      node((6cm, 4cm), $7$, stroke: 0.5pt, name: "7", radius: 0.4cm)

      edge(label("1"), label("3"), "-|>")
      edge(label("6"), label("3"), "-|>")
      edge(label("1"), label("2"), "-|>")
      edge(label("2"), label("4"), "-|>")
      edge(label("1"), label("4"), "-|>")
      edge(label("3"), label("4"), "-|>")
      edge(label("4"), label("6"), "-|>")
      edge(label("4"), label("5"), "-|>")
      edge(label("6"), label("5"), "-|>")
      edge(label("3"), label("7"), "-|>", bend: 30deg)
      edge(label("5"), label("7"), "-|>", bend: -30deg)
    })
  ]

  We have the following representations
  #grid(
    columns: (1fr, 1fr),
    [Adjacency matrix: $
      A = mat(
        0, 1, 1, 1, 0, 0, 0;
        0, 0, 0, 1, 0, 0, 0;
        0, 0, 0, 1, 0, 0, 1;
        0, 0, 0, 0, 1, 1, 0;
        0, 0, 0, 0, 0, 0, 1;
        0, 0, 1, 0, 1, 0, 0;
        0, 0, 0, 0, 0, 0, 0;
      )
    $],
    [Adjacency list: $
      &"Adj" = [\
        &quad 1 -> {2, 3, 4}, 2 -> {4}, 3 -> {4, 7},\
        &quad 4 -> {5, 6}, 5 -> {7}, 6 -> {5}, 7 -> {}\
      &]
    $]
  )

  #align(center)[
    #table(
      columns: 4,
      table.header([Operation], [Adjacency Matrix], [Adjacency List], [Incidence Matrix]),
      [Space], $O(n^2)$, $O(n + m)$, $O(n dot.c m)$,
      [Check if edge exists], $O(1)$, $O(d(v))$, $O(m)$,
      [Find all neighbors], $O(n)$, $O(d(v))$, $O(m)$,
      [Add Edge], $O(1)$, $O(1)$, $O(n)$
    )
  ]
]

#colbreak()
#section[Graph Traversal Algorithms]
Graph traversal algorithms systematically explores the vertices of the graph. They are fundamental building blocks for many other graph algorithms.

#subsection[Breadth-First Search]
Fundamental graph traversal algorithm explores a graph layer by layer, starting from a source vertex, it visits all its directed neighbors (vertices at distance 1) before moving on to the neighbors of those neighbors, (vertices at distance 2) and so on. BFS uses a Queue data structure (First-In First-Out) to manage the order of exploration. The goal of BFS is to discover all vertices reachable from source $s$ and compute the shortest path distance $s$ to each reachable vertex.

#let c(body) = [#h(1cm) #text(fill: gray)[$<-$ #body]]

#alg(ovcount: false)[
  Procedure BFS(G, s):
  + Create a queue $Q$ and a set visited. #c($O(1)$)
  + Create a map distance with all values initialized to $infinity$. #c($O(n)$)
  + visited.add(s) #c($O(1)$)
  + distance[s] $<-$ 0 #c($O(1)$)
  + Q.enqueue(s) #c($O(1)$)
  + while $Q$ is not empty #c($O(n)$)
    + v $<-$ Q.dequeue() #c($O(1)$)
    + Process vertex v. #c($O(1)$)
    + for each neighbor w of v #c($O(m)$)
      + if w is not visited then
        + visited.add(w) #c($O(1)$)
        + distance[w] = distance[v] + 1 #c($O(1)$)
        + Q.enqueue(w) #c($O(1)$)
      + endif
    + endfor
  return distance
]

Global complexity with adjacency list is $O(n+m)$, and space complexity is $O(n)$.

#colbreak()
#exm[
  Let us apply BFS to the following graph $G=(V, E)$
  $ 
    V &= {A, B, C, D, E, F, G, H}\
    E &= {(A, B), (A, C), (B, D), (B, E), (C, F)\
      & quad (D, G), (E, G), (E, H), (F, H), (G, H)}
  $

  #align(center)[
    #diagram(
      mark-scale: 130%,
      {
      node((0cm, -1cm), $A$, stroke: 0.5pt, name: "A", radius: 0.4cm)
      node((-2cm, -2cm), $B$, stroke: 0.5pt, name: "B", radius: 0.4cm)
      node((2cm, -2cm), $C$, stroke: 0.5pt, name: "C", radius: 0.4cm)
      node((-3cm, -4cm), $D$, stroke: 0.5pt, name: "D", radius: 0.4cm)
      node((-1cm, -4cm), $E$, stroke: 0.5pt, name: "E", radius: 0.4cm)
      node((2cm, -4cm), $F$, stroke: 0.5pt, name: "F", radius: 0.4cm)
      node((-2cm, -6cm), $G$, stroke: 0.5pt, name: "G", radius: 0.4cm)
      node((1cm, -6cm), $H$, stroke: 0.5pt, name: "H", radius: 0.4cm)


      edge(label("A"), label("B"), "-|>")
      edge(label("B"), label("D"), "-|>")
      edge(label("B"), label("E"), "-|>")
      edge(label("D"), label("G"), "-|>")
      edge(label("E"), label("G"), "-|>")
      edge(label("E"), label("H"), "-|>")
      edge(label("G"), label("H"), "-|>")
      edge(label("A"), label("C"), "-|>")
      edge(label("C"), label("F"), "-|>")
      edge(label("F"), label("H"), "-|>")
    })
  ]
  Starting from vertex $A$ we have
  #columns(2)[
    + Initialization:
      - $Q = [A]$
      - $d[B] = dots.c = d[H] = infinity$
      - $P[A] = dots.c = P[G] = "None"$
    + Step 1: Dequeue $A$
      - Neighbors $B, C$
      - $"visited" = {A, B, C}$
      - $d[B] = d[C] = 1$
      - $P[B] = P[C] = A$
      - $Q = [B, C]$
    + Step 2: Dequeue $B$
      - Neighbors $D, E$
      - $"visited" = {A, B, C, D, E}$
      - $d[D] = d[E] = 2$
      - $P[D] = P[E] = B$
      - $Q = [C, D, E]$
    + Step 3: Dequeue $C$
      - Neighbors $F$
      - $"visited" = {A, B, C, D, E, F}$
      - $d[F] = 2$
      - $P[F] = C$
      - $Q = [D, E, F]$
    + Step 4: Dequeue $D$
      - Neighbors $G$
      - $"visited" = {A, B, C, D, E, F, G}$
      - $d[G] = 3$
      - $P[G] = D$
      - $Q = [E, F, G]$
    + Step 5: Dequeue $E$
      - Neighbors $G, H$
      - $G$ already visited
      - $"visited" = {A, B, C, D, E, F, G, H}$
      - $d[H] = 3$
      - $P[H] = E$
      - $Q = [F, G, H]$
    + Step 6: Dequeue $F$
      - Neighbors $H$
      - $H$ already visited
      - $Q = [G, H]$
    + Step 7: Dequeue $G$
      - Neighbors $H$
      - $H$ already visited
      - $Q = [H]$
    + Step 8: Dequeue $H$
      - No neighbors
      - $Q = []$
  ]
  $Q$ is empty, algorithm stops. Which gives us the following results
  #table(
    columns: (1.3cm,)*9,
    $v$, $A$, $B$, $C$, $D$, $E$, $F$, $G$, $H$,
    $d(v)$, $0$, $1$, $1$, $2$, $2$, $2$, $3$, $3$,
    $P[v]$, "None", $A$, $A$, $B$, $B$, $C$, $D$, $E$
  )
]

#exr(count: false)[
  Rewrite the BFS algorithm assuming the graph $G=(V, E)$ is represented by its adjacency matrix $A$ and provide its complexity.
]

#lem(ovcount: false)[
  Let $G=(V, E)$ be a directed or undirected graph, and let $s in V$ be a fixed source point. For every edge $(u, v) in E$, we have $
    delta(s, v) <= delta(s, u) + 1
  $ where $delta(s, x)$ denotes the length of the shortest path.
]

#prf[
  If $u$ is reachable from $s$, then there exists a shortest path from $s$ to $u$ of length $delta(s, u)$, appending the edge $(u, v)$ gives a path from $s$ to $v$ of length $delta(s, u) + 1$. Since $delta(s, v)$ is defined as the minimum length then necessarily $delta(s, v) <= delta(s, u) + 1$. If $u$ is not reachable from $s$, then trivially $delta(s, u) + 1 = infinity$
]

#lem(ovcount: false)[
  Suppose that during the execution of BFS on a graph $G=(V, E)$, the queue $Q$ contains the vertices $[v_1, dots, v_r]$ where $v_1$ is the head of $Q$ and $v_r$ is the tail of $Q$. Then the following holds:
  + $d(v_r) <= d(v_1) + 1$.
  + $forall i in [|1, dots, r-1|], d(v_i) <= d(v_(i+1))$.
]

#prf[
  By induction on the number of queue operations.
  - Base case: initially, the queue contains the source vertex $s$, the lemma is trivial.
  - Assume the lemma holds before queue operations, we must show that it continues to hold after a dequeue.
    - Dequeue operation: if the head $v_1$ is dequeued then $v_2$ becomes the new head (unless the queue becomes empty, in which case the statement remains true), by induction hypothesis we have that $d(v_1) <= d(v_2)$ since $d(v_r) <= d(v_1) + 1$ we obtain that $d(v_r) <= d(v_2) + 1$ and all the other inequalities remain.
    - Enqueue operation: suppose a vertex $v$ is discovered while scanning the adjacency list of some vertex, hence $d(v) = d(u) + 1$ and enqueue $v$ at the tail of the queue. At the moment, $u$ has already been dequeued. By the induction hypothesis the current head $v_1$ satisfies $d(u) <= d(v_1)$. Therefore, $d(v) = d(u) + 1 <= d(v_1) + 1$. Furthermore, the previous tail $d(v_r) <= d(u) + 1 = d(v)$. Therefore, the lemma holds for all queue operations.
  Which proves this lemma.
]

#thm(ovcount: false)[
  Let $G=(V, E)$ be an unweighted graph for any vertex $v in V$ reachable from the source $s$, the distance $d[v]$ assigned by the BFS algorithm is equal to the shortest path distance $delta(s, v)$.
]

#prf[
  Using induction on the shortest path $delta(s, v) = k$, because for $k = 0$ the only vertex $v$ such that $delta(s, v) = 0$ is $s$ itself. BFS initialize $d[s] = 0$ thus $d[s] = delta(s, s) = 0$. By induction, assume that forall vertices $u$ with $delta(s, u) = k$, BFS assign correctly $d[u] = k$, consider a vertex $v$ such that $delta(s, v) = k + 1$. By definition of shortest distance there exists a vertex $x$ such that $(u, v) in E$ and $delta(s, u) = k$. By inductive step $d[u]=k$. When $x$ is dequeued, the algorithm examines all neighbors of $v$ is undiscovered. BFS sets $d[v] = d[u] + 1$. Since BFS explores vertices in non-decreasing order of distance, $v$ cannot have been discovered at a distance smaller than $k + 1$ (otherwise a shortest path to $v$ would be contradicting $delta(s, v) = k + 1$. Thus, the first time $v$ is reached, it is assigned $d[v] = k + 1$.
]

#exr(count: false)[
  The diameter of a tree $T=(V, E)$ is defined as $
    max_(u, v in V) delta(u, v)
  $ that is the longest of all shortest path distances in the tree. Give an efficient algorithm to compute the diameter of a tree and analyze its complexity.
]

The algorithm is as follows: \
- *Algorithm:* BFS-Modified(T, s)
  + create a queue $Q$, and distances $d$
  + initialize $d$ for all vertices to $0$
  + d[s] $<-$ 0
  + $Q$.enqueue(s)
  + while $Q$ is not empty do
    + v $<-$ $Q$.dequeue()
    + for each neighbor $w$ of $v$ do
      + if d[w] = $infinity$ then
        + d[w] $<-$ d[v] = 1
        + $Q$.enqueue(w)
      + endif
    + endfor
  + endwhile
  + let $x$ be a vertex maximizing d[$x$]
  + return $(x, "d"[x])$
- *Algorithm:* Tree-Diameter(T)
  + chose an arbitrary vertex $v in V$
  + (u, \_) $<-$ BFS-Modified(T, s)
  + (v,  d) $<-$ BFS-Modified(T, u)
  + return d
The complexity of the pseudocode $O(n)$.

The BFS builds a BFS-Tree as it searches the graph. The tree corresponds to the $p$ attributes. For a graph $G=(V, E)$ with sources. Let $G_p = (V_p, E_p)$ where $V_p = {v in V | p(v) != "Nil"} union {s}$ and $E_p = {(p(v),v) | v in V_p \\ {s}}$. The predecessor subgraph $G_q$ is a BFS tree if $V_p$ consists of the vertices reachable from $s$ and for all $v in V_p$, the subgraph $G_p$ contains a unique simple path from $s$ to $v$, that is the shortest path from $s$ to $v$ in $G$. A BFS-Tree is in fact a tree, since it is connected by construction and $|E_p| = |V_p| - 1$.

#exr(count: false)[
  Show that if a graph is connected and it has $n-1$ edges then the graph is a tree.
]

#exr(count: false)[
  Run the BFS algorithm on the following graph and give the BFS tree starting from vertex $A$.

  #align(center, diagram({
    node((0cm,  0cm), $A$, stroke: 0.5pt, name: "A", radius: 0.4cm)
    node((2cm,  0cm), $B$, stroke: 0.5pt, name: "B", radius: 0.4cm)
    node((4cm,  0cm), $C$, stroke: 0.5pt, name: "C", radius: 0.4cm)
    node((6cm,  0cm), $D$, stroke: 0.5pt, name: "D", radius: 0.4cm)
    node((0cm, -1.5cm), $E$, stroke: 0.5pt, name: "E", radius: 0.4cm)
    node((2cm, -1.5cm), $F$, stroke: 0.5pt, name: "F", radius: 0.4cm)
    node((4cm, -1.5cm), $G$, stroke: 0.5pt, name: "G", radius: 0.4cm)
    node((6cm, -1.5cm), $H$, stroke: 0.5pt, name: "H", radius: 0.4cm)

    edge(label("A"), label("B"))
    edge(label("A"), label("E"))
    edge(label("B"), label("F"))
    edge(label("F"), label("G"))
    edge(label("F"), label("C"))
    edge(label("G"), label("C"))
    edge(label("C"), label("D"))
    edge(label("G"), label("D"))
    edge(label("D"), label("H"))
  }))
]

Going through the same procedure as the previous example to get
#align(center, diagram({
  node((0cm,  0cm), $A$, stroke: 0.5pt, name: "A", radius: 0.4cm)
  node((2cm,  0cm), $B$, stroke: 0.5pt, name: "B", radius: 0.4cm)
  node((4cm,  0cm), $C$, stroke: 0.5pt, name: "C", radius: 0.4cm)
  node((6cm,  0cm), $D$, stroke: 0.5pt, name: "D", radius: 0.4cm)
  node((0cm, -1.5cm), $E$, stroke: 0.5pt, name: "E", radius: 0.4cm)
  node((2cm, -1.5cm), $F$, stroke: 0.5pt, name: "F", radius: 0.4cm)
  node((4cm, -1.5cm), $G$, stroke: 0.5pt, name: "G", radius: 0.4cm)
  node((6cm, -1.5cm), $H$, stroke: 0.5pt, name: "H", radius: 0.4cm)

  edge(label("A"), label("B"))
  edge(label("A"), label("E"))
  edge(label("B"), label("F"))
  edge(label("F"), label("G"))
  edge(label("F"), label("C"))
  edge(label("C"), label("D"))
  edge(label("D"), label("H"))
}))
#exr(count: false)[
  The square of a directed graph $G=(V, E)$ is the graph $G^2 = (V, E^2)$ with $E^2$ defined as, $u v in E^2 <=> u v in E "or" exists w in V, u w, w v in E$. Write an efficient algorithm for computing $G^2$ from $G$ for both adjacency list and adjacency matrix representations of $G$. Analyze the complexity of the algorithm.
]

#exr(count: false)[
  The transpose of a directed graph $G=(V, E)$ is the graph $G^T=(V, E^T)$ where $E^T = {u v | u, v in V, v u in E}$. Write an efficient algorithm for computing $G^T$ for both representations. Analyze its complexity.
]

#follow-bar[Big Gap Here]
#subsection[Kruskal's Algorithm]
Kruskals algorithm process the edges in increasing weight order and greedily includes each edges in the MST as long as it does not form a cycle with edges already selected.

```pcode
T = ∅
!=
for v in V do
  makeset(v)
end

sort E in non-decreasing order of weight

for edge (u, v) in E do
  if findset(u) ≠ findset(v) then
    T = T ∪ {(u, v)}
    union(u, v)
  endif
end
```

#section[Binary Search Tree]

#def(name: "Binary Tree", ovcount: false)[
  Binary tree node $x$ stores a key $x."key"$ and three attributes, $x."left"$, $x."right"$ (children) and $x."parent"$, if any of the values is NIL indicates their absence.
]

The unique node with $x."parent" = "NIL"$ is the root. A node with $x."left" = x."right" = "NIL"$ is a leaf. The height of the tree is the length of the longest root to leaf path.

#def(name: "BST Property", ovcount: false)[
  A binary tree is said to satisfy the BST property if for every node $x$, then for all $y$ in the left subtree of $x$, $y."key" <= x."key"$ and for all $z$ in the right subtree of $x$, $z."key" >= x."key"$.
]

- The in-order traversal: $L -> x -> R$.
- The pre-order traversal: $x -> L -> R$.
- The post-order traversal: $L -> R -> x$.

#subsection[BST Operations]
- *Search:*
  ```pcode
  procedure BSTsearch(x, k):
    if k < x.key then return BSTsearch(x.left, k) end
    if k > x.key then return BSTsearch(x.right, k) end
    return x
  ```
- *Minimum/Maximum:*
  ```pcode
  procedure BSTminimum(x):
    while x.left != NIL do x <- x.left end
    return x
  ```
- *Predecessor/Successor:*
  ```pcode
    procedure BSTpredecessor(x):
      if x.left != NIL then
        return BSTmaximum(x.left)
      end

      y = x.parent
      while y != NIL and x = y.left do
        x = y
        y = y.parent
      end
      return y
  ```

#colbreak()
#exr(count: false)[
  - Write the pseudocode for the following operations:
    + Find a successor of $x$.
    + Insert a key into the BST.
    + Delete a key from the BST.
  - Calculate the complexity of search, insert, delete, minimum, maximum each run in $O(h)$ time where $h$ is the height of the tree.
]

#section[Graph Coloring]

#def(name: "Proper Vertex Coloring/Chromatic Number", ovcount: false)[
  A proper vertex coloring of a graph $G$ is a function $c: V(G) -> {1, dots, k}$ such that $forall (u, v) in E(G), c(u) != c(v)$. The minimum number of colors for which we can obtain a proper vertex coloring exists, denoted $chi(G)$.
]

#thm(ovcount: false)[
  - $chi(G) >= omega(G)$ where $omega(G)$ is the clique number.
  - $chi(G) <= Delta(G) + 1$.
  - $chi(G) <= n$.
]

#exr(count: false)[Prove the theorem]

```pcode
procedure GreedyColoring(G):
  initialize all vertices to uncolored
  for v in V(G) do
    - find the smallest color not used by any neighbor
    - assign this color for v
  end
```
