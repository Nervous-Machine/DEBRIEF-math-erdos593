/-
Cycle 1 worked examples, Eric Li's development (ericlisg/erdos-593-1177-lean at 5dcb6e49,
Lean v4.28.0, Mathlib 8f9d9cff). WRITTEN, NOT YET RUN BY LEAN. No output is claimed.
To run: place in the repository root of the pinned checkout and run `lake env lean Trace.lean`
after `lake build RequestProject`; record the output as trace.txt beside this file.
-/
import RequestProject.PublicationCertificate

open Erdos593 Cardinal

-- The statement (B2) and its packaging.
#check @Erdos593.classification_unconditional
#print Erdos593.FullResolution
#print axioms Erdos593.full_resolution_unconditional
#print axioms Erdos593.classification_unconditional

-- Every definition in Part C of the trace.
#print Erdos593.Hypergraph
#print Erdos593.Hypergraph.ProperColoring
#print Erdos593.Hypergraph.ColorableBy
#print Erdos593.Hypergraph.UncountablyChromatic
#print Erdos593.Hypergraph.IsTripleSystem
#print Erdos593.FTS
#print Erdos593.FTS.Embeds
#print Erdos593.FTS.Obligatory
#print Erdos593.FTS.Isolated
#print Erdos593.FTS.reduce
#print Erdos593.FTS.Linear
#print Erdos593.BergeCycle
#print Erdos593.OnBergeCycle
#print Erdos593.IsBridgeInc
#print Erdos593.FTS.IntrinsicObligatory
#print Erdos593.Bclass
#print Erdos593.graphExpansion

-- Example 1: a single triple on Fin 3.
def oneEdge : FTS where
  V := Fin 3
  edges := {Finset.univ}
  card3 := by decide

example : oneEdge.Linear := by
  unfold FTS.Linear oneEdge; decide

-- Example 2: two triples sharing a pair (formal-conjectures' `commonPair`) are not linear.
def commonPair : FTS where
  V := Fin 4
  edges := {{0, 1, 2}, {0, 1, 3}}
  card3 := by decide

example : ¬ commonPair.Linear := by
  unfold FTS.Linear commonPair; decide

-- Example 3: an edgeless system is in the class B.
def edgeless4 : FTS where
  V := Fin 4
  edges := ∅
  card3 := by simp

example : Bclass edgeless4 := Bclass.edgeless _ rfl

-- Example 4: the threshold. ℵ₀ < ℵ₁, and ℵ₁ is the successor of ℵ₀ (the 1177 file uses this).
example : ℵ₀ < aleph 1 := aleph0_lt_aleph_one
#check @Cardinal.succ_aleph0
