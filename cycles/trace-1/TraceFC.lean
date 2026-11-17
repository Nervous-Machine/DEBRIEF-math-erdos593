/-
Cycle 1 worked examples, formal-conjectures (google-deepmind/formal-conjectures at e028240a,
Lean v4.33.1, Mathlib 0df444a3). WRITTEN, NOT YET RUN BY LEAN. No output is claimed.
To run: inside the pinned checkout, after building, `lake env lean TraceFC.lean`.
-/
import FormalConjectures.ErdosProblems.«593»

open Erdos593 Cardinal

-- The statement (B1); its answer is `sorry`, so `#print axioms` will list `sorryAx`.
#check @Erdos593.erdos_593
#print Erdos593.erdos_593.answer
#print axioms Erdos593.erdos_593

-- Every definition in Part C of the trace.
#print UniformHypergraph
#print Hypergraph
#print Hypergraph.IsUniform
#print Hypergraph.IsProperColoring
#print Hypergraph.image
#print UniformHypergraph.chromaticCardinal
#print UniformHypergraph.Appears
#print UniformHypergraph.IsObligatory

-- Example: the file's own `commonPair` is 2-colourable (proved in the file, l.106).
#check @Erdos593.erdos_593.variants.commonPair_isTwoColorable
