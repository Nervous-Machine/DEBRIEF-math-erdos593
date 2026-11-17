/-
Cycle 1 worked examples, Samuil Petkov's development (SamPetkov/Erdos593 at 70675e5c,
formalization/, Lean v4.32.0, Mathlib 81a5d257). WRITTEN, NOT YET RUN BY LEAN. No output is claimed.
To run: from formalization/ of the pinned checkout, after building, `lake env lean TracePetkov.lean`.
-/
import Erdos593

open Erdos593 Erdos593.TripleSystem

-- The statements (B3).
#check @Erdos593.TripleSystem.isObligatory_iff_isolatedReduction_intrinsic
#check @Erdos593.TripleSystem.isObligatory_iff_constructible_isolatedReduction
#print axioms Erdos593.TripleSystem.isObligatory_iff_isolatedReduction_intrinsic
#print axioms Erdos593.TripleSystem.isObligatory_iff_constructible_isolatedReduction

-- Every definition in Part C of the trace.
#print Erdos593.TripleSystem
#print Erdos593.TripleSystem.Linear
#print Erdos593.TripleSystem.Embedding
#print Erdos593.TripleSystem.IsProperColoring
#print Erdos593.TripleSystem.chromaticCardinal
#print Erdos593.TripleSystem.Appears
#print Erdos593.TripleSystem.IsObligatory
#print Erdos593.TripleSystem.IsIsolated
#print Erdos593.TripleSystem.isolatedReduction
#print Erdos593.TripleSystem.levi
#print Erdos593.SimpleGraph.bridgeEdges
#print Erdos593.TripleSystem.BridgeAtEveryEdge
#print Erdos593.TripleSystem.EvenBergeCycles
#print Erdos593.TripleSystem.Intrinsic
#print Erdos593.TripleSystem.Constructible
#print Erdos593.TripleSystem.privateVertexExpansion

-- The Mathlib facts the trace leans on (D9).
#check @SimpleGraph.isBridge_iff_forall_cycle_notMem
#print SimpleGraph.IsBridge
#print SimpleGraph.Walk.IsCycle
