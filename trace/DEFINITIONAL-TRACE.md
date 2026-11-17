# Definitional trace of the formal statements of Erdős Problem #593

**For:** a mathematician willing to spend forty-five minutes to an hour, not a day, deciding whether three formal
statements of Erdős Problem #593 say what Erdős asked, and whether the two claimants' statements say the same thing.
Those are the open questions on this record that no machine settles (gaps EG2 and EG4). Unlike records 306 and 768,
nothing here has been built or kernel-checked by Nervous Machine yet (gap EG1 is open for both developments).

**What this is.** The problem as posed; three formal statements verbatim (the third-party one in Google DeepMind's
formal-conjectures, Eric Li's, Samuil Petkov's); every definition they depend on, traced to the claimants' own files and
to Mathlib with file and line; a plain-language rendering of each piece; the differences between the three; and a
sign-off checklist. The renderings are the reading of the operating agent (Claude Code, for Nervous Machine) on
17 November 2026. They are an aid, not a check.

**What this is not.** Not an independent human semantic review, and it changes no standing. Not a build: no repository
was cloned or built, no lake command and no claimant code was run. The worked examples in `cycles/trace-1/` are written
but **not yet run by Lean**; nothing below is reported as checked by Lean. It says nothing about either paper's argument
(gap EG3) or about problem 1177, which shares Li's repository.

**Sources, pinned, fetched read-only by commit.**

| source | pin | toolchain and Mathlib it declares |
|---|---|---|
| formal-conjectures `FormalConjectures/ErdosProblems/593.lean` and `FormalConjecturesForMathlib/Combinatorics/Hypergraph/{Basic,Uniform}.lean` | commit `e028240a61822d970c933f4656f51da025cf200b`; 593.lean blob `732d1dc4`, sha256 `047a5c215d08…` | `leanprover/lean4:v4.33.1`, Mathlib `0df444a360eaa60ab8c11dca51a86af692955474` |
| Eric Li, ericlisg/erdos-593-1177-lean, `RequestProject/{PublicationCertificate,FinalResultsUnconditional,Defs,Structures,Reduce,Lift}.lean` | commit `5dcb6e4906df03f2e4294b21be73b55db7736f5a` | root `lakefile.toml`, `leanprover/lean4:v4.28.0`, Mathlib `8f9d9cff6bd728b17a24e163c9402775d9e6a365` |
| Samuil Petkov, SamPetkov/Erdos593, `formalization/Erdos593/TripleSystem/{ObligatoryClassification,Basic,Obligatory,Embedding,Isolated,Intrinsic,Levi,Constructive,Expansion}.lean`, `formalization/Erdos593/Graph/Bridge.lean` | commit `70675e5ce5646718df4e6fd4f93c509ef3447a77` | no lakefile at the root; `formalization/lakefile.toml`, `formalization/lean-toolchain` = `leanprover/lean4:v4.32.0`, `formalization/lake-manifest.json` Mathlib `81a5d257c8e410db227a6665ed08f64fea08e997` (D11) |
| Mathlib, read at each of the three revisions above | | `SetTheory/Cardinal/{Defs,Order}.lean`, `Data/Set/Card.lean`, `Combinatorics/Hypergraph/Basic.lean` (formal-conjectures revision only; absent at Li's), `Combinatorics/SimpleGraph/{Basic,Paths,Coloring/Vertex,Connectivity/Connected}.lean` (Petkov's revision), `Combinatorics/SimpleGraph/Coloring.lean` (Li's revision) |

Problem page: https://www.erdosproblems.com/593 as read on 2026-11-17. Pre-registration for this trace:
`prereg_trace.yaml` (hashed 2026-11-17T18:06:43Z, committed alone before any definition was read).

---

## 0. Conventions a reviewer has to know

| convention | where | what it means here |
|---|---|---|
| `#α` is the cardinality of a type; `ℵ₀ = lift #ℕ` | Mathlib `SetTheory/Cardinal/Defs.lean` l.87 (`mk`), l.478 (`aleph0`) at 0df444a3 and 81a5d257; l.85, l.476 at 8f9d9cff | the usual cardinal arithmetic of ZFC with choice |
| `sInf` on cardinals | `SetTheory/Cardinal/Order.lean` l.378, `ConditionallyCompleteLinearOrderBot Cardinal` | the least element of a nonempty set of cardinals (cardinals are well-ordered); `sInf ∅ = 0` |
| `Set.ncard s`, `Set.encard s` | `Data/Set/Card.lean` l.67 (`encard`), l.614 / l.570 / l.615 (`ncard`, at the three revisions) | number of elements; `ncard` of an infinite set is 0, so `ncard e = 3` forces `e` finite with three elements |
| Universes | Lean core | `Type u` is a universe of types. A statement "for all hosts `W : Type u`" covers every hypergraph whose vertex type lives in universe `u`. Each development fixes or quantifies `u` differently (D3). |
| Weak proper colouring | all three developments | "proper" means no edge is monochromatic: every edge has two vertices of different colours. This is the usual hypergraph chromatic number. |
| `SimpleGraph.fromRel r` | `Combinatorics/SimpleGraph/Basic.lean` l.133 at 81a5d257: `Adj a b := a ≠ b ∧ (r a b ∨ r b a)` | the symmetric irreflexive closure of a relation; Petkov builds the Levi graph with it |
| `G.IsBridge e` | `Combinatorics/SimpleGraph/Connectivity/Connected.lean` l.759 at 81a5d257: deleting `e` disconnects its endpoints | does not by itself say `e` is an edge; Petkov's `bridgeEdges` adds that (`Graph/Bridge.lean` l.20). Mathlib l.850, `isBridge_iff_forall_cycle_notMem`: an edge is a bridge iff it lies on no cycle. |
| `p.IsCycle` for a walk `p : G.Walk u u` | `Combinatorics/SimpleGraph/Paths.lean` l.84 at 81a5d257: a nonempty closed trail whose only repeated vertex is the start | in a simple graph a cycle has length at least 3; in a bipartite graph, even length at least 4 |
| `G.Colorable 2` | `Coloring/Vertex.lean` l.167 at 81a5d257; `Coloring.lean` l.158 at 8f9d9cff | `G` is bipartite |

---

## Part A. The problem as posed

**A1. The problem page**, verbatim (erdosproblems.com/593, citing [Er95d], a $500 problem):

> Characterize those finite 3-uniform hypergraphs which appear in every 3-uniform hypergraph of chromatic number
> $>\aleph_0$.

The page adds: "Similar problems were investigated by Erdős, Galvin, and Hajnal [EGH75]. Erdős claims that for graphs
the problem is completely solved: a graph of chromatic number $\geq \aleph_1$ must contain all finite bipartite graphs
but need not contain any fixed odd cycle." The page lists two proof claims and marks neither accepted.

**A2. Words the page leaves to the reader.** "Appear in" (as a subhypergraph, induced or not), "chromatic number" (of a
hypergraph: weak colourings, i.e. no monochromatic edge) and "characterize" (what counts as an answer). Every formal
statement below has to choose; Part E records each choice.

**What the trace does not check.** Whether the page's sentence is a faithful rendering of [Er95d] or [EGH75]. The
operating agent did not consult either. A reviewer with them can sign or refuse checklist item A0.

---

## Part B. The formal statements, verbatim

**B1. formal-conjectures** (`FormalConjectures/ErdosProblems/593.lean` l.44 and l.63–66, inside `open Cardinal Set
SimpleGraph`, namespace `Erdos593`):

```lean
def erdos_593.answer : Set ((n : ℕ) × UniformHypergraph (Fin n) 3) := sorry

@[category research open, question value, AMS 5]
theorem erdos_593 :
    {p : Σ n : ℕ, UniformHypergraph (Fin n) 3 | p.2.IsObligatory} = erdos_593.answer := by
  sorry
```

The answer is a blank (`sorry`). The file states the question "which labelled finite triple systems on `Fin n` are
obligatory?"; it does not state any answer, so no claimant theorem can close it as written (D1). The file also states,
with proofs left `sorry` and tagged solved, that obligatory implies 2-colourable (l.79–82) and that two triples sharing a
pair are not obligatory (l.118–119); these constrain any answer and both claimants' answers satisfy them in the agent's
reading (linearity excludes the shared pair).

**B2. Eric Li** (`RequestProject/PublicationCertificate.lean` l.40–42, field `problem593` of `FullResolution`, proved by
`full_resolution_unconditional` at l.67 with no hypotheses; the same statement is
`classification_unconditional` in `FinalResultsUnconditional.lean` l.28–29):

```lean
  problem593 : ∀ F : FTS,
    (FTS.Obligatory.{u} F ↔ Bclass F) ∧
      (Bclass F ↔ F.reduce.IntrinsicObligatory)
```

**B3. Samuil Petkov** (`formalization/Erdos593/TripleSystem/ObligatoryClassification.lean` l.20–22 and l.39–41):

```lean
theorem isObligatory_iff_isolatedReduction_intrinsic
    {V E : Type u} (F : TripleSystem V E) [Fintype V] [Fintype E] :
    F.IsObligatory ↔ F.isolatedReduction.Intrinsic

theorem isObligatory_iff_constructible_isolatedReduction
    {V E : Type u} (F : TripleSystem V E) [Fintype V] [Fintype E] :
    F.IsObligatory ↔ Constructible F.isolatedReduction
```

**B4. Side by side, in the agent's reading.** All three ask the same question: which finite triple systems $F$ embed
in every triple system that has no proper colouring with countably many colours. B2 and B3 each answer it with the same
two equivalent descriptions: (i) after deleting isolated vertices, $F$ is linear, every hyperedge-node of its Levi graph
meets a bridge, and every Berge cycle has even length; (ii) $F$ lies in the class generated by private-vertex
expansions of finite bipartite graphs and edgeless systems under isomorphism, disjoint union and one-point
amalgamation. The pairwise answer for gap EG4:

| pair | identical text? | same proposition? (agent's reading) | why |
|---|---|---|---|
| Li B2 vs Petkov B3 | no | **equivalent**: same notion of obligatory, same two descriptions of the answer | D3–D9 |
| Li B2 vs formal-conjectures B1 | no | B2's left side is B1's left side; B2 fills B1's blank | D1, D3–D7 |
| Petkov B3 vs formal-conjectures B1 | no | same as the line above | D1, D3–D7 |

No pair is identical, and none has been connected by a Lean proof: each lives on a different Lean and Mathlib version
(D2), and neither claimant imports formal-conjectures. "Equivalent" here is an argument a reader can check, not a
kernel fact.

---

## Part C. Every piece, traced

### C1. "Finite 3-uniform hypergraph" (the source $F$)

| statement | definition, with source | agent's reading |
|---|---|---|
| B1 | `UniformHypergraph V k` (`Hypergraph/Uniform.lean` l.42–46) extends Mathlib's `Hypergraph V` (`Combinatorics/Hypergraph/Basic.lean` l.73–79 at 0df444a3: `vertexSet : Set V`, `edgeSet : Set (Set V)`, edges inside the vertex set) with `vertexSet = Set.univ` and `IsUniform k` (`Hypergraph/Basic.lean` l.33: every edge has `encard = k`). Sources are on `Fin n`. | a set of 3-element subsets of $\{0,\dots,n-1\}$; isolated vertices kept |
| B2 | `structure FTS` (`Defs.lean` l.50–58): `V : Type` with `Fintype`, `DecidableEq`, `edges : Finset (Finset V)`, `card3 : ∀ e ∈ edges, e.card = 3` | a finite vertex type with a finite set of 3-element subsets; isolated vertices kept |
| B3 | `structure TripleSystem V E` (`TripleSystem/Basic.lean` l.17–23): `Inc : V → E → Prop`, `edge_ncard : ∀ e, ncard {x | Inc x e} = 3`, `simple : Injective (fun e => {x | Inc x e})`; B3 adds `[Fintype V] [Fintype E]` | an edge-indexed incidence structure; `simple` says distinct indices are distinct triples, so `E` is a labelling of a set of triples, not a multiset (D6) |

### C2. "3-uniform hypergraph" (the host)

| statement | definition | agent's reading |
|---|---|---|
| B1 | `H : UniformHypergraph V 3`, `V : Type u` with `[DecidableEq V]` | any set of 3-subsets of a type |
| B2 | `H : Hypergraph W` (Li's own structure, `Lift.lean` l.37–38: `edges : Set (Set W)`) with `H.IsTripleSystem` (`Defs.lean` l.38–39: every edge has `ncard = 3`) | the same; `ncard = 3` excludes infinite edges |
| B3 | `H : TripleSystem W D`, `W D` in the universes of `V E`, `[DecidableEq W]` | the same, with edges indexed by `D` |

### C3. "Chromatic number $> \aleph_0$"

| statement | definition | agent's reading |
|---|---|---|
| B1 | `ℵ₀ < H.chromaticCardinal`; `chromaticCardinal := sInf {κ | ∃ (C : Type u), #C = κ ∧ ∃ f : V → C, H.IsProperColoring f}` (`Uniform.lean` l.91–92); `IsProperColoring f := ∀ e ∈ H.edgeSet, ∃ u ∈ e, ∃ v ∈ e, f u ≠ f v` (`Hypergraph/Basic.lean` l.37–38, via `Uniform.lean` l.74–76) | the least number of colours in a colouring with no monochromatic edge exceeds $\aleph_0$ |
| B2 | `H.UncountablyChromatic := ¬ H.ColorableBy ℵ₀` (`Defs.lean` l.43–44); `ColorableBy θ := ∃ c : V → θ.out, H.ProperColoring c` (`Lift.lean` l.48–50); `ProperColoring c := ∀ e ∈ H.edges, ∃ u ∈ e, ∃ v ∈ e, c u ≠ c v` (l.42–44) | there is no colouring by a countably infinite set of colours with no monochromatic edge |
| B3 | `ℵ₀ < H.chromaticCardinal`, with `chromaticCardinal` and `IsProperColoring` defined exactly as in B1 on Petkov's structure (`TripleSystem/Obligatory.lean` l.27–33) | as B1 |

All three say the same thing (D4): a colouring with at most $\aleph_0$ colours can be read as one with exactly
$\aleph_0$ colours by injecting the colour set into $\mathbb{N}$, which keeps different colours different; and the
identity colouring is proper for 3-uniform hosts, so the set under `sInf` is never empty.

### C4. "Appear in"

| statement | definition | agent's reading |
|---|---|---|
| B1 | `F.Appears H := ∃ φ : W → V, Injective φ ∧ (F.toHypergraph.image φ).edgeSet ⊆ H.edgeSet` (`Uniform.lean` l.105–108); Mathlib `Hypergraph.image` (`Combinatorics/Hypergraph/Basic.lean` l.156–158 at 0df444a3: edges are the images of edges) | an injective vertex map sending every edge of $F$ to an edge of $H$; other host edges among the image are allowed (not induced) |
| B2 | `F.Embeds H := ∃ f : F.V → W, Injective f ∧ ∀ e ∈ F.edges, f '' ↑e ∈ H.edges` (`Defs.lean` l.73–75) | the same |
| B3 | `F.Appears H := Nonempty (F.Embedding H)` (`Obligatory.lean` l.36–38); `Embedding` (`Embedding.lean` l.18–25): `vertex : V ↪ W`, `edge : E → D`, `map_edge : ∀ e, vertex '' F.edgeSet e = H.edgeSet (edge e)` | the same; the edge map is forced to be injective because both systems are simple (D7) |

### C5. "Appear in every …" (obligatory)

| statement | definition | agent's reading |
|---|---|---|
| B1 | `IsObligatory F := ∀ (V : Type u) [DecidableEq V] (H : UniformHypergraph V k), ℵ₀ < H.chromaticCardinal → F.Appears H` (`Uniform.lean` l.132–134), `u` = universe of the source; `Fin n : Type`, so `u = 0` | $F$ appears in every 3-uniform hypergraph of chromatic number $> \aleph_0$ whose vertex type is in `Type` |
| B2 | `FTS.Obligatory F := ∀ {W : Type u} (H : Hypergraph W), H.IsTripleSystem → H.UncountablyChromatic → F.Embeds H` (`Defs.lean` l.79–81); B2 holds for every `u` | the same, for hosts in any one universe `u` |
| B3 | `IsObligatory := ∀ (W : Type u) (D : Type v) [DecidableEq W] (H : TripleSystem W D), ℵ₀ < H.chromaticCardinal → F.Appears H` (`Obligatory.lean` l.46–48); B3 has `u = v`, any `u` | the same, for hosts in the universe of $F$ |

### C6. The answer, description (i): the intrinsic conditions

| piece | Li (B2) | Petkov (B3) | agent's reading |
|---|---|---|---|
| delete isolated vertices | `FTS.reduce` (`Reduce.lean` l.18–22): vertex type `{x // ¬ F.Isolated x}`, `Isolated x := ∀ e ∈ F.edges, x ∉ e` (`Defs.lean` l.63–64) | `isolatedReduction` (`Isolated.lean` l.37–42): vertex type `{x // ¬ F.IsIsolated x}`, same edge indices; `IsIsolated x := ∀ e, ¬ F.Inc x e` (`Basic.lean` l.30–31) | $F^\circ$, $F$ with isolated vertices removed |
| linear | `FTS.Linear := ∀ e₁ ∈ edges, ∀ e₂ ∈ edges, e₁ ≠ e₂ → (e₁ ∩ e₂).card ≤ 1` (`Defs.lean` l.67–68) | `Linear := ∀ e f x y, e ≠ f → Inc x e → Inc x f → Inc y e → Inc y f → x = y` (`Basic.lean` l.34–36) | two distinct edges share at most one vertex |
| a bridge at every hyperedge-node | `∀ ed, ∃ w ∈ ed, IsBridgeInc F w ed`; `IsBridgeInc F w ed := w ∈ ed ∧ ¬ OnBergeCycle F w ed` (`Structures.lean` l.41–42, l.55): the incidence lies on no Berge cycle | `BridgeAtEveryEdge := ∀ e, ∃ x, s(inl x, inr e) ∈ bridgeEdges F.levi` (`Intrinsic.lean` l.22–24); `levi := fromRel incidenceRel` on `V ⊕ E` (`Levi.lean` l.20–26); `bridgeEdges G := {e | e ∈ G.edgeSet ∧ G.IsBridge e}` (`Graph/Bridge.lean` l.20–21) | in the bipartite point/edge incidence (Levi) graph, every edge-node has an incident Levi edge that is a bridge |
| every Berge cycle even | `∀ c : BergeCycle F, Even c.m`; `BergeCycle` (`Structures.lean` l.24–32): `m ≥ 2`, injective `v : ZMod m → F.V` and `e : ZMod m → edges`, `v i, v (i+1) ∈ e i` | `EvenBergeCycles := ∀ z (c : F.levi.Walk z z), c.IsCycle → 4 ∣ c.length` (`Intrinsic.lean` l.27–28) | every Berge cycle $v_0 e_0 v_1 e_1 \dots$ (distinct points, distinct edges) has an even number of edges; a Berge cycle of length $m$ is a Levi cycle of length $2m$, so "even $m$" is "$4 \mid$ Levi length" (D9) |
| packaged | `IntrinsicObligatory := Linear ∧ (bridge) ∧ (even)` (`Structures.lean` l.53–56), applied to `F.reduce` | `Intrinsic := Linear ∧ BridgeAtEveryEdge ∧ EvenBergeCycles` (`Intrinsic.lean` l.31–32), applied to `F.isolatedReduction` | as the claim summaries say |

### C7. The answer, description (ii): the constructive class

| piece | Li `Bclass` (`Structures.lean` l.116–122) | Petkov `Constructible` (`Constructive.lean` l.35–50) |
|---|---|---|
| base: edgeless | `edgeless F (h : F.edges = ∅)` | `ofEdgeless V`, `[Fintype V]` |
| base: expansion | `expansion J (hJ : J.Colorable 2)`, `graphExpansion J` (l.88–92): vertices of `J` plus one private vertex per edge, edges `{x, y, p_xy}` | `ofExpansion G (hG : G.Colorable 2)`, `privateVertexExpansion G` (`Expansion.lean` l.92–96, `Inc` l.47–50): the same construction |
| closed under | `iso`, `union` (`disjUnion`, l.61), `amalg` (`amalgamate`, l.73: identify one vertex of each) | `disjointUnion`, `amalgam`, `ofIso` |
| applied to | `F` itself (first conjunct of B2) | `F.isolatedReduction` (second line of B3) |

The agent read the definitions of `disjUnion`, `amalgamate`, `graphExpansion`, `FTS.Iso` (Li) and
`privateVertexExpansion` (Petkov) in full; Petkov's `disjointUnion`, `OnePointAmalgamation.amalgam` and `Iso` were
located by name (`DisjointUnion.lean` l.29, `OnePointAmalgamation.lean` l.311, `Isomorph.lean` l.23) and not read in
full. Applying `Bclass` to $F$ and `Constructible` to $F^\circ$ give the same class, because both classes contain
edgeless systems and are closed under disjoint union (D8).

---

## Part D. Worked examples, written for Lean, not yet run

`cycles/trace-1/` holds three files, one per environment, because the three statements live on three different Lean
and Mathlib versions and no single file can import them all: `Trace.lean` (to run inside Li's development),
`TracePetkov.lean` (inside Petkov's `formalization/`), `TraceFC.lean` (inside formal-conjectures at the pinned
commit). They contain `#check` of B1–B3, `#print` of every definition in Part C, `#print axioms` of each main theorem,
and small decidable examples: a single triple is linear; two triples sharing a pair (formal-conjectures' `commonPair`)
are not linear; an edgeless system is in `Bclass`; `ℵ₀ < ℵ₁`. **None of this has been run.** No output is claimed;
whoever runs them under the pinned toolchains (a rerun for gap EG1 is the natural moment) should record the transcript
as `trace.txt` beside them.

---

## Part E. Discrepancies and observations

| id | observation | kind | effect, in the agent's reading |
|---|---|---|---|
| D1 | formal-conjectures leaves the answer blank (`erdos_593.answer := sorry`) and tags the problem `research open`. Neither claimant states or imports it. | shape of the third-party statement | none on meaning. It does mean the "machine comparison" route in EG2 is not available as for 306: someone has to fill the blank with a claimant's answer and prove the set equality from that claimant's theorem. |
| D2 | Three different environments: formal-conjectures Lean v4.33.1 / Mathlib `0df444a3`; Li v4.28.0 / `8f9d9cff`; Petkov v4.32.0 / `81a5d257`. Mathlib's `Hypergraph` (used by formal-conjectures) does not exist at Li's revision. | environment | none on meaning; any machine bridge between the statements needs a port first. |
| D3 | Universe of hosts. formal-conjectures: hosts in `Type` (the universe of `Fin n`). Li: hosts in any one universe `u`, sources in `Type`, statement holds for every `u`. Petkov: hosts in the universe of the source, any `u`. The problem quantifies over all hypergraphs. | universe convention | none: each claimant's right-hand side does not mention universes, so their theorems make "obligatory" the same at every universe; at `u = 0` they speak about the formal-conjectures notion's hosts. |
| D4 | Threshold: formal-conjectures and Petkov say `ℵ₀ < chromaticCardinal` (an `sInf`); Li says "not colourable by `ℵ₀.out`". The page says "$> \aleph_0$" and, for graphs, "$\geq \aleph_1$". All three use weak colourings (no monochromatic edge). | encoding | equivalent (Part C3). |
| D5 | Sources: labelled on `Fin n` (formal-conjectures), any finite `Type` (Li), any finite `Type u` with a finite edge-index type (Petkov). | representation | none; every finite triple system is isomorphic to one on `Fin n`, and "obligatory" is invariant under isomorphism (Li proves it as `obligatory_iso`, `Structures.lean` l.134; for the other two the agent did not look for a lemma, but it follows by composing the embedding with the isomorphism). |
| D6 | Petkov indexes edges by a type `E`; repeated edges would be possible but are excluded by the field `simple`. Hosts likewise. | representation | none. |
| D7 | "Appear" is a non-induced copy in all three (injective vertex map, edges to edges, extra host edges allowed). The page does not say which. formal-conjectures' docstring (l.129–131) chooses non-induced to match the [EGH75] graph result. | interpretation | none between the three. Whether non-induced is Erdős's meaning is the one reading a mathematician has to supply (checklist A1). |
| D8 | Li states `Obligatory F ↔ Bclass F` (no reduction) and `Bclass F ↔ F.reduce.IntrinsicObligatory`; Petkov states both descriptions on `F.isolatedReduction`. Li's docstring (l.49–52) says the intrinsic properties are unaffected by isolated vertices but the theorem applies them to `F.reduce`. | statement shape | none: chaining Li's two conjuncts gives Petkov's first line; the two class descriptions agree as in C7. |
| D9 | Berge cycles and bridges: Li defines them directly on the triple system; Petkov through Mathlib's Levi graph (a bridge is a Mathlib `IsBridge` edge; evenness is `4 ∣` the Levi cycle length). | encoding | equivalent: a Levi cycle of length $2m$ ($m \ge 2$) is a Berge cycle of length $m$ and conversely, and a graph edge is a bridge iff it lies on no cycle (Mathlib `isBridge_iff_forall_cycle_notMem`, `Connectivity/Connected.lean` l.850 at 81a5d257). The agent's argument, not a Lean proof. |
| D10 | Petkov's `Obligatory.lean` docstring (l.8–9) says it is compatible with a formal-conjectures file `.../Hypergraph/ThreeUniform.lean`; at the pinned formal-conjectures commit the definitions are in `Uniform.lean`. | revision drift | none; Petkov does not import it, and the definitions match (C3–C5). |
| D11 | This record's claim file says Petkov's repository has no lakefile. It has none at the root, but `formalization/` holds `lakefile.toml`, `lean-toolchain` (v4.32.0) and `lake-manifest.json` (Mathlib `81a5d257`). The 551 `.lean` files include scratch files under `formalization/tmp/`. | record correction | none on meaning. A rerun for EG1 should build in `formalization/`. |
| D12 | Gap EG4's text says the two claimants reached the characterisation "independently". Petkov's README states that his negative direction uses Li's one-apex lift and bridge-trace architecture, makes no priority claim, and that neither his manuscript nor repository claims full informational independence from Li. | record framing | none on the statements. It narrows what agreement shows: two separately written Lean developments of the same statement, not two independent discoveries. EG4's text is corrected in this cycle. |
| D13 | "Characterize": formal-conjectures leaves the form of the answer open. Both claimants give a property of $F$ that is decidable for finite $F$ (description i) and a generating construction (description ii). | interpretation | none seen; whether that is a characterisation in Erdős's sense is a human judgment (checklist A3). |

No discrepancy that changes the meaning was seen by the agent. No anomaly is opened.

---

## Part F. Sign-off checklist

For a reviewer who is prepared to put their name to a reading. Each line is a yes/no. Send it with the **Semantic read**
issue form on this repository (it becomes a `read` cycle under your name), or anywhere public; the ledger records it by
date. Two independent signatures with no refusal close gap EG2; one refusal reopens it.

- [ ] A0 (optional, needs [Er95d] or [EGH75]): the page's sentence is Erdős's problem.
- [ ] A1: "appear in" means a not-necessarily-induced copy (an injective vertex map sending edges to edges), as all three formal statements read it (C4, D7).
- [ ] A2: "chromatic number $> \aleph_0$" is "no colouring with countably many colours leaves every edge non-monochromatic", as all three read it, with hosts in one Lean universe (C3, C5, D3, D4).
- [ ] A3: "after deleting isolated vertices, linear, a Levi bridge at every hyperedge-node, every Berge cycle even" is a characterisation in the sense the problem asks for (C6, D13).
- [ ] A4: Li's `Bclass` / `IntrinsicObligatory` and Petkov's `Constructible` / `Intrinsic` describe the same class, so B2 and B3 state the same theorem (C6, C7, D8, D9).
- [ ] B (optional): the formal-conjectures statement B1 with its blank filled by that class is the problem; B2 and B3 would then each prove it after a port (D1, D2).

A reviewer who signs A1 to A4 has closed the semantic question for both claims at once, and answered gap EG4.
