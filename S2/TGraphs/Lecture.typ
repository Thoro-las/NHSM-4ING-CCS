#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: "Advanced Graph Theory",
    writer: "HADIOUCHE Azouaou",
    disclaimer: [This document contains the lectures given by Dr. MEHDAOUI.],
  ),
)

#let card = math.op("#")

#chapter("Fundamental Concepts")[]

#section[Definitions & Notations]
#subsection[Types Of Graphs]
#def(name: "Undirected Graph", ovcount: false)[
  An undirected graph $G$ is an ordered pair $G=(V, E)$ where $V$ is a finite set called the vertex set (vertices) and $E subset {{u, v} | u, v in V}$ called the set of edges.
]

#def(name: "Directed Graph", ovcount: false)[
  A directed graph $G$ is an ordered pair $G=(V, A)$ where $V$ is the set of vertices and $A subset V times V$ called the set of arcs or directed edges.
]

#def(name: "Unweighted Graph", ovcount: false)[
  An unweighted graph $G$ is a graph is a graph where all edges are considered equal.
]

#def(name: "Weighted Graph", ovcount: false)[
  A weighted graph $G=(V, E)$ is a graph where there is a function $w: E -> RR$ where for each edge $e in E$, the weight of $e$ is $w(e)$.
]

#subsection("Concepts On Vertices & Edges")
#def(name: "Adjacent/Incident/Isolated", ovcount: false)[
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

#lem(name: "Handshake", ovcount: false)[
  For an undirected graph $G=(V, E)$ then $ sum_(v in V) deg(v) = 2 card E $
]

#prf[
  Every edge ${u, v} in E$ contributes exactly $1$ to $deg(u)$ and $1$ to $deg(v)$ thus adding $2$ to $sum_(v in V) deg(v)$, so all edges counted twice in the sum of all edges.
]

#thm(ovcount: false)[
  The number of vertices with odd degree is even.
]

#prf[
  Let $V_o = {v in V | d(v) "odd"}$ and $V_e = {v in V | d(v) "even"}$, by the handshake lemma we have $ 2 card E = sum_(v in V) deg(v) & = sum_(v in V_o) deg(v) + sum_(v in V_e) deg(v) $ given that $2 card E$ is even and $sum_(v in V_e) deg(V)$ is even then necessarily $sum_(v in V_o) deg(v)$ is even, and since the sum of odd numbers is even if and only if the number of odd numbers is even then $card V_o$ is even so there is an even number of odd degree vertices.
]

#subsection[Simple & Multigraphs]
#def(name: "Simple/Multi Graph", ovcount: false)[
  A graph $G$ is said to be simple if it has no loops and no multiple edges. A multigraph is a graph that may have loops and have multiple edges.
]

#thm(ovcount: false)[
  In any simple graph $G$ with order $n >= 2$, there exists at least two vertices with same degree.
]

#prf[
  The possible degrees in a simple graph is ${0, dots, n-1}$, however a graph cannot have a vertex with degree $0$ and $n-1$ at the same time, so either it has vertices of degree ${1, dots, n-1}$ or ${0, dots, n-2}$, and since there are $n$ vertices and $n-1$ choices for degrees, then by the pigeonhole principle, there are at least two vertices with the same degrees.
]

#pro[
  There are $binom(n, 2)$ maximum edges in a simple graph.
]

#def(name: "Walk/Trail", ovcount: false)[
  Let $G=(V, E)$ be a graph
  + A walk of length $k$ is a sequence $v_1, e_2, v_2, dots, e_k, v_k$ with $e_i = {v_(i-1), v_i} in E$.
  + A trail is a walk with no repeated edges.
  + A path is a walk with no repeated vertices.
  + A walk is closed if $v_0 = v_k$.
]

#thm(ovcount: false)[
  If there is a walk from vertex $u$ to $v$ then there is also a path from $u$ to $v$.
]

#prf[
  By induction on the length of the walk $n$. For $n = 1$, it is trivial since any $1$-walk is a path, now consider a walk of length $n$, $v_1, e_1, v_2, dots, v_(n-1), e_n, v_n$ , if $forall i, j in [|1, n|], i != j => v_i != v_j$ then it is a path, otherwise there exists $i, j$ such that $v_i = v_j$, we consider the new walk $v_1, e_1, v_2, dots, e_i, v_i, e_j, dots, e_n, v_n$, this walk has a strictly less length then the original, and thus by induction hypothesis, there is a walk from $v_1$ to $v_n$.
]

#def(name: "Circuit/Cycle", ovcount: false)[
  + A circuit is a closed trail.
  + A cycle is a closed path.
  + A cycle of length $k$ is denoted $C_k$, unless otherwise specified.
  + The length of the cycle is the number of edges in it.
  + A graph $G$ is connected if for every pair of vertices $u, v in V$ there exists a path from $u$ to $v$, otherwise it is disconnected.
  + A subgraph $H$ of $G$ is a graph such that $V(H) subset V(G)$ and $E(H) subset E(G)$.
  + A connected component of $G$ is a maximum connected subgraph of $G$.
  + A spanning subgraph $H$ of $G$ is a subgraph such that $V(H) = V(G)$.
]

#thm(ovcount: false)[
  In a connected graph, for any two longest paths in the graph, there exists a vertex they intersect in.
]

#prf[
  Suppose that there is a graph where two longest paths do not share a vertex, denote them $v_1, e_1, dots, e_(n-1), v_n$ and $v'_1, e'_1, dots, e'_(n-1), v'_n$, given that the graph is connected, then there is a path from some $v_i$ to $v'_j$ that does not intersect with the previous paths. Consider the path that goes through the furthest endpoint $v_1$ or $v_n$ from $v_i$, the path until $v_i$, then the path from $v_i$ to $v'_j$ and lastly to the furthest endpoint $v'_1$ or $v'_n$ from $v'_j$.
]

#def(ovcount: false, name: "Induced/Complement Graph")[
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
Let $G=(V, E)$ be a graph with $V = {v_1, dots, v_n}$, the adjacency matrix of $G$ is an $n times n$ matrix $A = (a_(i j))$ where $ a_(i j) = cases(
  1 & "if" v_i v_j in E(G),
  0 & "otherwise"
) $

#exm[
  Here is a simple graph with its adjacency matrix
  #align(center, grid(
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
    $A = mat(0, 1, 0, 0; 1, 0, 1, 1; 0, 1, 0, 1; 0, 1, 1, 0)$,
  ))
]
For weighted graphs we take the adjacency matrix would be $ a_(i j) = cases(
  w(v_i v_j) & "if" v_i v_j in E,
  "None" & "otherwise"
) $
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

#def(name: "Sparse/Dense Graph", ovcount: false)[
  Let $G=(V, E)$ a graph, we say that $G$ is a sparse graph if $card E << card V^2$ and we call it dense if $card E approx Theta(card V^2)$.
]

In sparse graphs the adjacency list is preferred, while in dense graphs the adjacency matrix is preferred.

#subsection[Incidence Matrix]
Given a graph $G=(V, E)$, the incidence matrix $M$ is defined as follows $ M_(i j) = cases(
  1 & "if" v_i "is incident to" e_j,
  0 & "otherwise"
) $
#align(center, grid(
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
  $M = mat(1, 0, 0, 0, 1; 1, 1, 0, 1, 0; 0, 1, 1, 0, 0; 0, 0, 1, 1, 1)$,
))

For a directed graph, we define the following representation $ M_(i j) = cases(
  +1 & "if" e_j "enters the vertex" v_i,
  -1 & "if" e_j "leaves the vertex" v_i,
  0 & "otherwise"
) $
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
    [Adjacency matrix: $ A = mat(
        0, 1, 1, 1, 0, 0, 0;
        0, 0, 0, 1, 0, 0, 0;
        0, 0, 0, 1, 0, 0, 1;
        0, 0, 0, 0, 1, 1, 0;
        0, 0, 0, 0, 0, 0, 1;
        0, 0, 1, 0, 1, 0, 0;
        0, 0, 0, 0, 0, 0, 0;
      ) $],
    [Adjacency list: $ & "Adj" = [ \
      & quad 1 -> {2, 3, 4}, 2 -> {4}, 3 -> {4, 7}, \
      & quad 4 -> {5, 6}, 5 -> {7}, 6 -> {5}, 7 -> {} \
      & ] $],
  )

  #align(center)[
    #table(
      columns: 4,
      table.header([Operation], [Adjacency Matrix], [Adjacency List], [Incidence Matrix]),
      [Space], $O(n^2)$, $O(n + m)$, $O(n dot.c m)$,
      [Check if edge exists], $O(1)$, $O(d(v))$, $O(m)$,
      [Find all neighbors], $O(n)$, $O(d(v))$, $O(m)$,
      [Add Edge], $O(1)$, $O(1)$, $O(n)$,
    )
  ]
]

#colbreak()
#section[Graph Traversal Algorithms]
Graph traversal algorithms systematically explores the vertices of the graph. They are fundamental building blocks for many other graph algorithms.

#subsection[Breadth-First Search]
Fundamental graph traversal algorithm explores a graph layer by layer, starting from a source vertex, it visits all its directed neighbors (vertices at distance 1) before moving on to the neighbors of those neighbors, (vertices at distance 2) and so on. BFS uses a Queue data structure (First-In First-Out) to manage the order of exploration. The goal of BFS is to discover all vertices reachable from source $s$ and compute the shortest path distance $s$ to each reachable vertex.

```pcode
procedure BFS(G, s):
  - Create a queue Q.
  - Create a set visited.
  - Create a map distance with values infinity.

  visited.add(s)
  distance[s] = 0
  Q.enqueue(s)

  while Q not empty do
    v = Q.dequeue()
    - Process vertex v.

    for each neighbor w of v
      if w is not visited then
        visited.add(w)
        distance[w] = distance[v] + 1
        Q.enqueue(w)
      end
    end
  end

  return distance
```

Global complexity with adjacency list is $O(n+m)$, and space complexity is $O(n)$.

#colbreak()
#exm[
  Let us apply BFS to the following graph $G=(V, E)$
  $
    V & = {A, B, C, D, E, F, G, H} \
    E & = {(A, B), (A, C), (B, D), (B, E), (C, F) \
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
      },
    )
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
    columns: (1.3cm,) * 9,
    $v$, $A$, $B$, $C$, $D$, $E$, $F$, $G$, $H$,
    $d(v)$, $0$, $1$, $1$, $2$, $2$, $2$, $3$, $3$,
    $P[v]$, "None", $A$, $A$, $B$, $B$, $C$, $D$, $E$,
  )
]

#exr(count: false)[
  Rewrite the BFS algorithm assuming the graph $G=(V, E)$ is represented by its adjacency matrix $A$ and provide its complexity.
]

#lem(ovcount: false)[
  Let $G=(V, E)$ be a directed or undirected graph, and let $s in V$ be a fixed source point. For every edge $(u, v) in E$, we have $ delta(s, v) <= delta(s, u) + 1 $ where $delta(s, x)$ denotes the length of the shortest path.
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
  Using induction on the shortest path $delta(s, v) = k$, because for $k = 0$ the only vertex $v$ such that $delta(s, v) = 0$ is $s$ itself. BFS initialize $d[s] = 0$ thus $d[s] = delta(s, s) = 0$. By induction, assume that forall vertices $u$ with $delta(s, u) = k$, BFS assign correctly $d[u] = k$, consider a vertex $v$ such that $delta(s, v) = k + 1$. By definition of shortest distance there exists a vertex $u$ such that $(u, v) in E$ and $delta(s, u) = k$. By inductive step $d[u]=k$. When $u$ is dequeued, the algorithm examines all neighbors of $v$ is undiscovered. BFS sets $d[v] = d[u] + 1$. Since BFS explores vertices in non-decreasing order of distance, $v$ cannot have been discovered at a distance smaller than $k + 1$ (otherwise a shortest path to $v$ would be contradicting $delta(s, v) = k + 1$. Thus, the first time $v$ is reached, it is assigned $d[v] = k + 1$.
]

#exr(count: false)[
  The diameter of a tree $T=(V, E)$ is defined as $ max_(u, v in V) delta(u, v) $ that is the longest of all shortest path distances in the tree. Give an efficient algorithm to compute the diameter of a tree and analyze its complexity.
]

```pcode
procedure BFSmodified(T, s):
  - create a queue Q
  - create distances d
  - initialize d for all vertices to infinity

  d[s] = 0
  Q.enqueue(s)
  while Q not empty do
    v = Q.dequeue()
    for each neighbor w of v do
      if d[w] = infinity then
        d[w] = d[v] + 1
        Q.enqueue(w)
      end
    end
  end

  x = argmax(d)
  return (x, d[x])
```

Now that we have the modified BFS, we can use it to search the diameter of the tree, that is, we start with a random vertex, go to the furthest vertex, and from that vertex, we apply the same thing again, which will give us the longest path.

```pcode
procedure TREEdiameter(T)
  - chose an arbitrary vertex s in V
  (u, _) = BFSmodified(T, s)
  (v, d) = BFSmodified(T, u)
  return d
```
The complexity of the pseudocode $O(n)$.

The BFS builds a BFS-Tree as it searches the graph. The tree corresponds to the $p$ attributes. For a graph $G=(V, E)$ with sources. Let $G_p = (V_p, E_p)$ where $V_p = {v in V | p(v) != "Nil"} union {s}$ and $E_p = {(p(v),v) | v in V_p \\ {s}}$. The predecessor subgraph $G_q$ is a BFS tree if $V_p$ consists of the vertices reachable from $s$ and for all $v in V_p$, the subgraph $G_p$ contains a unique simple path from $s$ to $v$, that is the shortest path from $s$ to $v$ in $G$. A BFS-Tree is in fact a tree, since it is connected by construction and $|E_p| = |V_p| - 1$.

#exr(count: false)[
  Show that if a graph is connected and it has $n-1$ edges then the graph is a tree.
]

#exr(count: false)[
  Run the BFS algorithm on the following graph and give the BFS tree starting from vertex $A$.

  #align(center, diagram({
    node((0cm, 0cm), $A$, stroke: 0.5pt, name: "A", radius: 0.4cm)
    node((2cm, 0cm), $B$, stroke: 0.5pt, name: "B", radius: 0.4cm)
    node((4cm, 0cm), $C$, stroke: 0.5pt, name: "C", radius: 0.4cm)
    node((6cm, 0cm), $D$, stroke: 0.5pt, name: "D", radius: 0.4cm)
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
  node((0cm, 0cm), $A$, stroke: 0.5pt, name: "A", radius: 0.4cm)
  node((2cm, 0cm), $B$, stroke: 0.5pt, name: "B", radius: 0.4cm)
  node((4cm, 0cm), $C$, stroke: 0.5pt, name: "C", radius: 0.4cm)
  node((6cm, 0cm), $D$, stroke: 0.5pt, name: "D", radius: 0.4cm)
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


#subsection[Depth-First Search]
DFS is a graph traversal algorithm that explores as far as possible along each branch before backtracking. DFS uses stack data structure (LIFO) to manage the exploration path.

There are two ways to implement DFS, either recursive or iterative.

- *Recursive*
  ```pcode
  procedure DFSvisit(G, v, visited):
    visited.add(v)

    for each neighbor w of v do
      if w not visited then
        P[w] = v
        DFSvisit(G, w, visited)
      end
    end

  procedure DFS(G):
    - create a set visited
    - create a parent array P

    for each v in G do
      if v not visited then
        DFSvisit(G, v, visited)
      end
    end
  ```

- *Iterative*
  ```pcode
  procedure DFS(G, s):
    - create a stack S
    - create a set visited
    - create a parent array P

    while S not empty do
      v = S.pop()
      if v not visited then
        visited.add(v)
        - Process vertex v
        for neighborhood w of v in reverse order do
          if w not visited then
            P[w] = v
            S.push(w)
          end
        end
      end
    end
  ```

#exm[
  We consider the following graph, and we apply the DFS starting from the vertex $S$.
  #align(center, diagram({
    node((0cm, 0cm), $S$, stroke: 0.5pt, name: "S", radius: 0.4cm)
    node((3cm, 0cm), $A$, stroke: 0.5pt, name: "A", radius: 0.4cm)
    node((6cm, 0cm), $C$, stroke: 0.5pt, name: "C", radius: 0.4cm)
    node((9cm, 0cm), $E$, stroke: 0.5pt, name: "E", radius: 0.4cm)
    node((0cm, -3cm), $B$, stroke: 0.5pt, name: "B", radius: 0.4cm)
    node((3cm, -3cm), $D$, stroke: 0.5pt, name: "D", radius: 0.4cm)
    node((6cm, -3cm), $F$, stroke: 0.5pt, name: "F", radius: 0.4cm)
    node((9cm, -3cm), $G$, stroke: 0.5pt, name: "G", radius: 0.4cm)

    edge(label("S"), label("A"), "->")
    edge(label("S"), label("B"), "->")
    edge(label("A"), label("C"), "->")
    edge(label("A"), label("D"), "->")
    edge(label("A"), label("F"), "->")
    edge(label("C"), label("E"), "->")
    edge(label("E"), label("G"), "->")
    edge(label("B"), label("C"), "->")
    edge(label("B"), label("D"), "->")
    edge(label("D"), label("C"), "->")
    edge(label("F"), label("C"), "->")
    edge(label("F"), label("G"), "->")
    edge(label("G"), label("C"), "->")
  }))
  #colbreak()

  #grid(
    columns: (1fr, 1fr),
    [
      + Initialization:
        - $Q = [S]$
        - $"visited" = {}$
        - $P[S] = "None"$
      + Step 1: Pop $S$
        - Neighbors $A$, $B$
        - $"visited" = {S}$.
        - $P[A] = S, P[B] = S$.
        - $S = [B, A]$.
      + Step 2: Pop $A$
        - Neighbors $D$, $F$.
        - $"visited" = {S, A}$.
        - $P[D] = A, P[F] = A$.
        - $S = [B, F, D]$.
      + Step 3: Pop $D$
        - Neighbors $C$.
        - $"visited" = {S, A, D}$.
        - $P[C] = D$.
        - $S = [B, F, C]$.
      + Step 4: Pop $C$
        - Neighbors $E$.
        - $"visited" = {S, A, D, C}$.
        - $P[E] = C$.
        - $S = [B, F, E]$.
    ],
    [
      + Step $5$: Pop $E$
        - Neighbors $G$.
        - $"visited" = {S, A, D, C, E}$.
        - $P[G] = E$.
        - $S = [B, F, G]$.
      + Step $6$: Pop $G$
        - Neighbors $C$, $F$.
        - All visited.
        - $S = [B, F]$.
      + Step $7$: Pop $F$
        - Neighbors $C$, $G$.
        - All visited.
        - $"visited" = {S, A, D, C, E, G, F}$.
        - $S = [B]$.
      + Step $8$: Pop $B$
        - Neighbors $C$, $D$
        - All visited.
        - $S = []$.
    ],
  )
]

*Discovering And Finishing Time:*
#def(name: "Discovering/Finishing Time", ovcount: false)[
  We define the following functions:
  - $d[U]$: the time when $U$ was visited first.
  - $f[U]$: the time when the exploration of $U$ adjacency list is completed.
]

It is clear that $d[U] < f[U]$ for any vertex $U$.

#def(name: "Edge Classification", ovcount: false)[
  Let $(u, v)$ be an edge of a direct graph explored during DFS, then we define the following classes:
  - Tree edge: if $v$ is first discovered when exploring $u$, $P[v] = u$.
  - Back edge: if $v$ is an ancestor of $u$.
  - Forward edge: if $v$ is a descendent of $u$, $d[u] < d[v]$.
  - Cross edge: $d[u] > d[v]$ and $u, v$ are in different branches.
]

*Pranthesis Structure:* A fundamental property of DFS is that discovery and finishing times of vertices follow a parenthesis structure, more precisely, if we denote the discovering of a vertex by $(u$ and its finishing time by $u)$ then the sequence of events produced by a DFS forms a properly parenthesized expression.

#exm[
  #align(center, diagram({
    node((0cm, 0cm), $Y$, stroke: 0.5pt, name: "Y", radius: 0.4cm)
    node((2cm, 0cm), $Z$, stroke: 0.5pt, name: "Z", radius: 0.4cm)
    node((4cm, 0cm), $S$, stroke: 0.5pt, name: "S", radius: 0.4cm)
    node((6cm, 0cm), $T$, stroke: 0.5pt, name: "T", radius: 0.4cm)
    node((0cm, -1.5cm), $X$, stroke: 0.5pt, name: "X", radius: 0.4cm)
    node((2cm, -1.5cm), $W$, stroke: 0.5pt, name: "W", radius: 0.4cm)
    node((4cm, -1.5cm), $V$, stroke: 0.5pt, name: "V", radius: 0.4cm)
    node((6cm, -1.5cm), $U$, stroke: 0.5pt, name: "U", radius: 0.4cm)

    edge(label("Y"), label("X"), "->")
    edge(label("Z"), label("W"), "->")
    edge(label("Z"), label("Y"), "->")
    edge(label("S"), label("Z"), "->")
    edge(label("S"), label("W"), "->")
    edge(label("T"), label("V"), "->")
    edge(label("T"), label("U"), "->")
    edge(label("X"), label("Z"), "->")
    edge(label("W"), label("X"), "->")
    edge(label("V"), label("W"), "->")
    edge(label("V"), label("S"), "->")
    edge(label("U"), label("V"), "->")
  }))
  we get the following expression $ (S(Z(Y(X X)Y)(W W)Z)S)(T(U(V V)U)T) $
]

#thm(ovcount: false)[
  Int a DFS of a graph $G$ for any two vertices $u$ and $v$ exactly one of the following holds:
  + $[d[u], f[u]$ and $[d[v], f[v]]$ are entirely disjoint.
  + $[d[u], f[u]] subset [d[v], f[v]]$.
  + $[d[v], f[v]] subset [d[u], f[v]]$.
]

#prf[
  Without loss of generality, assume $d[u] < d[v]$, since all timestamps are distinct (the clock increments before each assignment, so all $2|V|$ timestamps are distinct). There are two subcases according to wether $d[v] < f[u]$ or not.
  - Case 1: $d[v] < f[u]$, so $v$ is discovered while $u$ is still open (not finished), which implies that $v$ is a descendent of $u$. Moreover, since $v$ is discovered after $u$ it is finished before $u$, hence $[d[v], f[v]] subset [d[u], f[u]]$.
  - Case 2: $d[v] > f[u]$ then $d[u] < f[u] < d[v] < f[v]$, thus the intervals are entirely disjoint no vertex is a descendent of another, it is obtained by the symmetry $d[v] < d[u]$.
]

#thm(ovcount: false, name: "Cycle Detection")[
  A directed graph contains a cycle if and only if DFS discovered a back edge.
]

#prf[
  $arrow.double.l$ Suppose DFS discovers a back edge $u v$, by definition of back edge in DFS, the vertex $v$ is an ancestor of $u$ in the DFS tree. Therefore, there exists a path from $v$ to $u$ consisting of tree edges in DFS tree, together with the edge $u v$, we get a cycle.
  $=>$ suppose the graph contains a directed cycle $v_1 -> v_2 -> dots v_k -> v_1$, let $v_1$ be the first vertex of this cycle discovered by DFS, when DFS visits $v_1$ all other vertices of the cycle are still undiscovered, DFS will explore along the cycle through tree edge until it reaches the vertex $v_K$ that has an edge back to $v_1$, since $v_1$ is still active in the recursive stack, this edge points to an ancestor in DFS tree therefore it is a back edge.
]

#exr(ovcount: false)[
  Prove the following theorem.
  #thm(count: false)[
    In a DFS of an undirected graph $G$, every edge of $G$ is either a tree edge or a back edge.
  ]
]

#subsection[Application Of Traversal Algorithms]
- *Finding The Shortest Path:* using BFS we can find the shortest path from a starting vertex $s$ to an end vertex $e$.
  ```pcode
  procedure BFSshortpath(G, s, e):
    BFS(G, s)
    if P[e] = NIL and e ≠ s then return "No Path" end
    return BFSreconstructpath(P, s, e)

  procedure BFSreconstructpath(P, s, e):
    path = []
    current = e

    while current ≠ NIL do
      path.add(current)
      current = P[current]
    end

    return path
  ```
- *Connected Components:* a connected components of an undirected graph $G$ is a maximal subset $C subset V$ such that for every pair $u, v in C$, there is a path from $u$ to $v$ in $G$. We can use BFS/DFS to find connected components.
  ```pcode
  procedure FSfindcomponents(G):
    - initialize components array to -1 for vertices.
    count = 0

    for vertex v in G do
      if component[v] = -1 then
        count = count + 1
        FSlabelcomponent(G, v, count)
      end
    end

    return count, components

  procedure FSlabelcomponent(G, s, label):
    - use BFS/DFS starting from s
    for vertex v in visited do
      components[v] = label
    end
  ```
- *Topological Sort:* Let $G$ be a direct acyclic graph "DAG" is a linear ordering of all its vertices such that $u v in E(G) => u <= v$.
  #lem(ovcount: false)[
    A directed graph $G$ is acyclic if and only if DFS produces no back edge.
  ]
  #prf[
    $=>$ if DFS produces a back edge $u v$ then there is a cycle. $arrow.double.l$ if $G$ contains a cycle, DFS will eventually discover a back edge.
  ]

  ```pcode
  procedure DFStopsort(G):
    - initialize empty list L
    - Run DFS in G and compute the finishing times f[v]
    - as each vertex if finished insert it in front of L
    return L
  ```
- *Trees:*
  #def(name: "Tree", ovcount: false)[
    A tree is a connected non-cyclic graph.
    - we say it is rooted if it has one designated vertex called a root.
    - the depth of a vertex is the length from the root to the vertex.
    - the height of the tree is the maximum depth of any vertex.
    - spanning tree: a spanning tree of a connected graph $G$ is a subgraph $T$ such that $T$ is a tree and contains all vertices of $G$.
  ]

  #thm(ovcount: false)[
    Every connected graph has at least one spanning tree.
  ]

  #prf[
    Let $G$ a connected graph, for any cycle, remove an edge from the cycle, the graph remains connected. Repeat until no cycles remain, which is a tree.
  ]

  ```pcode
  procedure FSspanningtree(G, s):
    - run BFS/DFS on G starting from S
    return FSconstructtree(P)

  procedure FSconstructtree(P):
    - Initialize T = (V, {})
    for v in V do
      if P[v] ≠ NIL then
        - add edge(P[v], v) to T
      end
    end

    return T
  ```

#colbreak()
#exr(ovcount: false, name: "The Word Transformer")[
  + Each word $D union {S}$ is a vertex. An edge links two vertices (words) differencing in exactly one letter.
  + All edges are weight $1$, any valid transformation sequence is a path in $G$ and the shortest path gives the minimum chain length which BFS guarantee.
  +
]

#section[Minimum Spanning Tree]

Given a connected weighted graph $G=(V, E, W)$ where $W: E -> RR$. A minimum spanning tree is a spanning tree $T$ such that $sum_(e in E(T)) W(e)$ is minimized.

#subsection[Prim's Algorithm]
Prim's algorithm grows the MST one vertex at a time from a source $s$, at every step it selects the cheapest edge.
```pcode
procedure PrimMST(G, r):
  for each v in V do
    key[v] = ∞
    P[v] = NIL
  end

  key[r] = 0
  Q = V

  while Q not empty do
    u = extractmin(Q)
    for each neighbor v of u do
      if v in Q and w(uv) < key(v) then
        key[v] = w(uv)
        P[v] = u
      end
    end
  end

  return P
```

#subsection[Kruskal's Algorithm]
Kruskals algorithm process the edges in increasing weight order and greedily includes each edges in the MST as long as it does not form a cycle with edges already selected.

```pcode
T = ∅
for v in V do makeset(v) end

- sort E in non-decreasing order of weight

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

#exr(count: false)[
  - Write the pseudocode for the following operations:
    + Find a successor of $x$.
    + Insert a key into the BST.
    + Delete a key from the BST.
  - Calculate the complexity of search, insert, delete, minimum, maximum each run in $O(h)$ time where $h$ is the height of the tree.
]

#colbreak()
#section[Graph Coloring]

#def(name: "Proper Vertex Coloring/Chromatic Number", ovcount: false)[
  A proper vertex coloring of a graph $G$ is a function $c: V(G) -> {1, dots, k}$ such that $forall (u, v) in E(G), c(u) != c(v)$. The minimum number of colors for which we can obtain a proper vertex coloring exists, denoted $chi(G)$.
]

#subsection[Vertex Coloring]

#thm(ovcount: false)[
  - $chi(G) >= omega(G)$ where $omega(G)$ is the clique number.
  - $chi(G) <= Delta(G) + 1$.
  - $chi(G) <= n$.
]

```pcode
procedure GreedyColoring(G):
  - initialize all vertices to uncolored
  for v in V(G) do
    - find the smallest color not used by any neighbor
    - assign this color for v
  end
```

#subsection[Edge Coloring]
Edge coloring is an assignment of colors to the edges of a graph such that no adjacent edges have the same color. The chromatic $chi' (G)$ of a graph $G$ is the minimum number of colors needed for a proper edge coloring.
```pcode
procedure EdgeColoring(G):
  - initialize the color of each edge to uncolored
for each edge e1 in E do
  create an empty set called used_color
  for each edge e2 adjacent of e1 do
    if e2 is already colored then
      - add the color e2 to used_color
    end
  end
  - choose the smallest positive color that is not used in used_colors
  - assign this color to edge e1
end
```


#chapter[Advanced Problems In Graph Theory][
  In many real world scenarios, we're interested not just in whether a path exists between points, but finding the most efficient or optimal path. For example, the shortest path problem: given a weighted graph, find a path between two vertices such that the sum of the weights of its edges is minimized.
]

#section[Djikstra's Algorithm]
Djikstra's algorithm solves the single source shortest path problem. The algorithm works for weighted graphs with non-negative weighted edges.

```pcode
procedure Djikstra(G, s):
  - initialize distance d[v] = ∞ for all vertices v
  - initialize d[s] = 0.4
  - create a parent array P
  - create a distance priority queue with all vertices

  while Q not empty do
    - extract vertex u with minimum distance from Q
    for each neighbor v of u do
      alt = d[u] + weight(u, v)
      if alt < d[v] then
        d[v] = alt
        P[v] = u
        - update priority v in Q
      end
    end
  end
```

The complexity of the Djikstra algorithm is dependent on the implementation of the extract min function
- if it is array-based with normal search, the extraction is $O(n)$ and thus the total complexity is $O(n^2 + m) tilde.eq O(n^2)$.
- if it is implemented as binary heap, then extramin will be in $O(log(n))$ and decreasing key is $O(log(n))$ and thus the total complexity is $O((n+m)log(n))$.

#thm(name: "Djikstra's Algorithm Correctness", ovcount: false)[
  Djikstra's algorithm gives the shortest algorithm on a postive weighted graph.
]

#prf[
  We proceed by induction on $S$.
  - $S = emptyset$, the first extracted vertex is $S$, $d[s] = 0 = delta(s, s)$, holds.
  - Assume for all vertices $x in S$ we have $d[x] = delta(s, x)$. Let $v in S$ be the next vertex extracted from the priority queue. By definition $d[v] = min_(x in.not S) d[x]$, assume by contradiction that $d[v] > delta(s, v)$, consider a shortest path from $s$ to $v$ and $(x, y))$ be the first edge on this path such that $x in S$, $y in.not S$, by inductive hypothesis $d[x] = delta(s, x)$, when $x$ is processed, the relaxation step ensures that $d[y] <= d[x] + w(x, y) = delta(s, x) + w(x, y) = delta(s, y)$. Since all weights are non-negative, the remaining path from $y$ to $v$ cannot decrease the distance so $delta(s, y) <= delta(s, v)$ thus $d[y] <= delta(s, v)$. But since $v$ is chosen to be the minimum then $d[x] <= d[y]$ since $y in.not S$, thus $d[v] <= d[y] <= delta(s, y) <= delta(s, v)$ which contradicts the assumption of $d[v] > delta(s, v)$.
]

#section[Bellman-Ford Algorithm]
Which Djikstra's algorithm works efficiently for graphs with non-negative weights if fails when negative weights are present. The Bellman-Ford algorithm solves this single source.

```pcode
procedure Bellman-Ford(G, s):
  - initilize distances d[v] to infinity
  for v vertex in G do
    d[s] = 0
  end

  for i = 1 to #V - 1 do
    for each edge (v, u) with weight w in G do
      if d[v] + w < d[v] do
        d[v] = d[u] + w
        p[v] = u
      end
    end
  end

  for each edge (u, v) with weight w in G do
    if d[u] + w < d[v] then
      return "negative cycle"
    end
  end

  return d[], p[]
```

#exr(ovcount: false)[
  Prove the correctness of Bellman-Ford algorithm (assuming that there are no negative cycles).
]

Let $p$ be the shortest path from $s$ to $v$
- base case $d[s] = 0 = delta(s, s)$.
- Assume that all shortest path of length $k$ are determined in iteration $1$, all shortest path of length $1$ are determined, same for the next iteration, then continuing each iteration, we have that $d[v] <= d[v_k] + w(v_k, v)$. Hence all shortest path of length $<= k+1$ edges are correctly identified.

#section[Floyd-Wrashall Algorithm]
Sometimes we need to find shortest paths between all pairs of vertices while we could run Djikstra's algorithm $card V$ times, the Floyd-Warshall algorithm offers an elegant solution.

```pcode
procedure FloydWarshall(G):
  - Create distance matrix
  - d[i, j] = w(i, j), d[i, i] = 0
  for k = 1 to #V do
    for j = 1 to #V do
      for i = 1 to #V do
        if d[i, k] + d[k, j] < d[i, j] then
          d[i, j] = d[i, k] + d[k, j]
        end
      end
    end
  end

  return d
```

#exr(ovcount: false)[
  Add an instruction to the pseudocode to reconstruct all shortest paths.
]

#section[Maximum Flow & Min Cuts]
Many engineering and optimization problems can be modeled as movement of a material through a network of conducts from a source to a sink. The fundamental algorithmic question is what is the maximum rate at which material can be shipped from source to sink, respecting the capacity of each conduct.

#def(name: "Flow Network", ovcount: false)[
  A flow network is a directed graph $G=(V, E)$ together with a capacity function $C: V times V -> RR$ satisfying:
  + $forall u v in E, C(u, v) >= 0$.
  + $forall u v in.not E, C(u, v) = 0$
  + No self loops, no anti-parallel pairs.
  + Two distinguied vertices a source $s$ and sink $t$.
  + Every vertex $v in V$ lies on a source path $s -> v -> t$.
]

#def(name: "Flow", ovcount: false)[
  Let $G = (V, E)$ be a directed graph and $C: V times V -> RR$ a capacity function. A flow in $G$ is a function $f: V times V -> RR$ satisfying the two following properties
  - Capacity constraint: $forall u, v in V, 0 <= f(u, v) <= C(u, v)$.
  - Flow conservation: $forall u in V \\ {s, t}, sum_(v in V) f(u, v) = sum_(v in V) f(v, u)$
  The value of a flow is $|f| = sum_(v in V) f(s, v) - sum_(v in V) f(v, s)$.
]

What if the problem has several sources ${s_1, dots, s_n}$ and several sinks ${t_1, dots, t_n}$? Given a flow $f$ in $G$, the residual network $G_f = (V, E_f)$ captures how additional flow can be pushed away each edge in either directions.

#def(name: "Residual Capacity/Residual Network", ovcount: false)[
  Let $G = (V, E)$ be a flow network, for vertices $u, v in V$ the residual capacities are defined as $ C_f (u, v) = cases(
    C(u, v) - f(u, v) & "if" u v in E_f "(Forward residual edge)",
    f(v, u) & "if" v u in E_f "(Backward residual edge)",
    0 & "otherwise"
  ) $
  The residual network is $G_f = (V, E_f)$ where $ E_f = {(u, v) in V times V | C_f (u, v) > 0} $
]

#def(name: "Augmenting Path", ovcount: false)[
  Let $G$ be a flow network, an augmenting path $p$ is a simple path from $s$ to $t$ in the residual network $G_f$, the residual capacity of $p$ is $C_f (p) = min_((u, v) in p) C_f (u, v)$.
]
