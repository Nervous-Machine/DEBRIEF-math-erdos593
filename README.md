# DEBRIEF-math-erdos593

A DEBRIEF mission record (protocol https://github.com/Nervous-Machine/DEBRIEF) for **The claimed solutions of Erdős Problem #593 (finite triple systems forced by uncountable chromatic number)**.

**Standing.** Certified 0. Accepted 0. Refuted 0. Open gaps 4. This record is at tier zero: the claim and its public artifacts are pinned, the checks still owed are listed, and nothing has been run or read yet. The first contribution is open.

## The problem

A 3-uniform hypergraph has chromatic number greater than aleph-null if its vertices cannot be coloured with countably many colours without a monochromatic edge. Which finite 3-uniform hypergraphs appear inside every such hypergraph? For ordinary graphs Erdős considered the question solved: uncountably chromatic graphs contain every finite bipartite graph but need not contain any fixed odd cycle.

Source: https://www.erdosproblems.com/593 (posed: Erdős (1995), after Erdős, Galvin and Hajnal (1975); a $500 prize problem).

A third-party formalization of the problem statement exists: `FormalConjectures/ErdosProblems/593.lean` in github.com/google-deepmind/formal-conjectures at commit `e028240a61822d970c933f4656f51da025cf200b` (blob `732d1dc4915bc2943419f520991cbb9cbf6e0c53`). It is the natural reference for whether a claimant's Lean theorem states this problem.

## The claims

**Samuil Petkov**, using ChatGPT 5.6 Sol Pro (as listed by the claimant), submitted 2026-07-15 at https://www.erdosproblems.com/forum/thread/593/proof-claims.

The claim characterises the obligatory finite triple systems: after deleting isolated vertices, exactly the linear systems in which every hyperedge-node meets a bridge in the Levi graph and every Berge cycle has even length. The author states that the argument was checked by AI models several times and not by an expert, and that a formalisation was under way at submission; the repository now holds a Lean formalisation.

Artifacts, pinned:

- a public repository: github.com/SamPetkov/Erdos593 at commit 70675e5ce5646718df4e6fd4f93c509ef3447a77 (2026-10-14); licence CC-BY-4.0; 551 Lean files; no lakefile at the root
- a PDF write-up: https://github.com/SamPetkov/Erdos593/blob/main/erdos593_obligatory_triple_systems.pdf (in the repository at the pinned commit)

**Eric Li**, using GPT-5.5 Pro (as listed by the claimant), submitted 2026-07-17 at https://www.erdosproblems.com/forum/thread/593/proof-claims.

The claim resolves problems 593 and 1177 together. The obligatory finite triple systems are exactly the class generated from private-vertex expansions of finite bipartite graphs by finite disjoint unions and one-point amalgamations, equivalently the linear systems with a bridge at every hyperedge-node of the Levi graph and only even Berge cycles. The proof uses an exact bridge-trace theorem for one-apex sequence lifts, and also constructs, for every uncountable cardinal, a linear triple system of exactly that chromatic number. The author states the paper was public on arXiv on June 23, 2026, before any other proof of 593 or 1177, and welcomes others to join the formalisation.

Artifacts, pinned:

- an arXiv preprint: arXiv:2606.24882v2 "A Resolution of Erdős Problems 593 and 1177: Obligatory Triple Systems and Exact Spectra" (published 2026-06-23, last revised 2026-07-23)
- a public repository: github.com/ericlisg/erdos-593-1177-lean at commit 5dcb6e4906df03f2e4294b21be73b55db7736f5a (2026-07-23); licence Apache-2.0; 65 Lean files; has a lakefile

Status on the problem page as of 2026-11-14: listed as two proof claims; neither marked accepted by the site.

## What is owed

Each open gap is in `ASKS.md` with what closes it and who could act. In order:

1. **The Lean development has not been built or kernel-checked by anyone outside the claimant** (EG1): A rerun of the Lean build on an independent machine, written down first.
2. **Do the formal statements say what the problem asks?** (EG2): A reading of the formal statement against the problem as posed, by someone who did not write it.
3. **No independent mathematician has reported reading the proof, and there is no referee report** (EG3): Someone in the field reads it and says, under their name, what holds and what does not.
4. **Do the two claims' main theorems state the same thing?** (EG4): a trace setting the two main theorem statements and the third-party formal statement side by side, with any difference named

## Contributing

- **Rerun** (if there is a Lean development): copy `prereg_rerun.yaml`, fill in your predictions, register it with `tools/prereg.py register` from the protocol repository and commit it *before* running anything. Run. Report with the **Rerun report** issue form; it becomes a `rerun` cycle under your name.
- **Read**: a trace (reading guide) does not exist yet. Writing one is itself a `trace` cycle. Once it exists, the **Semantic read** form takes signatures and refusals.
- **Anything else**: open a plain issue.

Rules and templates: https://github.com/Nervous-Machine/DEBRIEF/blob/main/CONTRIBUTING.md. Every contribution is one dated cycle under your own name and goes into `CITATION.cff` and the next release.

## Layout

```
ledger/erdos593.json   the ledger (protocol 0.1.0)
claim.yaml            the pinned claim this record was opened from
SCORECARD.md / ASKS.md  generated from the ledger
prereg_rerun.yaml     a pre-registration template for the first rerun (unregistered)
cycles/               contributed cycles, one file each
```

## Words

This record never calls the claim proved, verified or a theorem. It records what was claimed, what was checked by whom under what rule, and what is still open. Nothing here has standing until a cycle gives it one.
