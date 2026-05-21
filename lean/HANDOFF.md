# v9 Lean Formalization — Handoff

If you are a future orchestrator session, read this first.

## What this is

v9 of the Robust Trust Theorem 2 infinite-extension package, formalized in Lean 4 / Mathlib. The proof is a **classification + sufficient-conditions architecture**, not an unrestricted proof. Five theorems + corollaries + G addendum.

The math is already proved on paper; this is the formalization pass.

## Where to start

1. Read `source_proof.md` — pointer to the three input documents.
2. Read `lean_state.md` — current state, lemma ledger, phase log.
3. Read `decomposition.md` (once it exists) — Extended Pro's Lean-ready skeleton.
4. If `main.lean` exists, read it. If not, the decomposition is still in flight.

## Files

| Path                          | What                                                                   |
|-------------------------------|------------------------------------------------------------------------|
| `source_proof.md`             | Pointer to the three input documents (consolidated, exposition, paper) |
| `lean_state.md`               | Phase, scope, lemma ledger                                             |
| `decomposition.md`            | Lean-ready skeleton (from Extended Pro)                                |
| `dep_audit.md`                | Mathlib dependency audit, Inventory axioms needed                      |
| `main.lean`                   | v9 main file (namespace `RobustTrustV9`)                               |
| `lemmas/`                     | Per-lemma proof files                                                  |
| `support/INVENTORY.lean`      | Inventory axioms (new v9 ones + reused v8 ones)                        |
| `axle_log.jsonl`              | Append-only log of AXLE checks                                         |
| `diagnostics/`                | `lake build` outputs, `#print axioms` audits                           |
| `v8_*`                        | v8 artifacts preserved as ancestors                                    |

## Pipeline discipline

CDP browser on port 9227 (Robust Trust Extension Chrome profile).
- Decomposition + writing review: Extended Pro (`gpt-5-5-pro`).
- Per-lemma math proof + verify: Opus subagent (math template).
- Every claim → fresh-session reviewer pass before merge.
- Fan-out batches of 3.
- Paste proofs verbatim into reviewer prompts; do not sketch.
- AXLE + `lake build` clean + `#print axioms` audit per merge.
- Cap retries at 5 per lemma.

## Heartbeat

15-minute orchestrator loop, job `ffa61811`. On wake: check browser for pending submissions, advance pipeline, fix glitches, do not wait for the user.

## v9 scope (locked)

T1 (Clarke–Danskin calibration, axiomatized), T2 (α=0 singleton), Binary capstone, FBNF capstone + 3 corollaries, Hall biconditional + WTA certificate, G4 LP threshold, P2*/P3/P4 primitive classes, G addendum sharpenings. See `source_proof.md §Scope` for the full surface.
