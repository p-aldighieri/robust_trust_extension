# Lean Formalization State

## Meta
- Proof repo: /Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension
- Source proof (absolute): /Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/02_proof_history/theorem_versions/theorem_2_extension_proof_v8.md
- Source provenance: hand-consolidated v8 — three-tier infinite extension of Dworczak–Smolin Robust Trust Theorem 2 (existence direction), terminal per project README and `01_deliverables/closure/project_closure_memo.md`. This proof repo predates the MathPipeProver consolidator workflow, so the source proof is selected directly rather than picked up from `runs/<id>/branches/<branch>/context/final_report.md`.
- Provenance slug: robust-trust-v8 (use for stable codex thread ids in /lean-verify-deps)
- Initialized: 2026-05-19T03:00:01Z
- Current phase: structuring
- Target Lean toolchain: lean-4.29.0
- AXLE log: lean/axle_log.jsonl

## Scope

Formalize the **positive content of v8** (per Pedro's scope decision 2026-05-18):

- **Tier 1a (unconditional under standing hypotheses):** value-optimal σ* with U(σ*) = U*; ε-adversary for every ε > 0. Lemmas 1–4 (menu-value equivalence, menu existence, closure-pruning value preservation, ε-adversary realization).
- **Tier 1b (+ exact-contact):** exact β* with U(β*, σ*) = U*. Lemma 5.
- **Tier 2 (+ exact-contact + menu-Hall):** q-a.e. robust rationalizability. Lemma 6.
- **Sharpness package:** Lemma 7 (cone intersection) and Theorem 8 (no-free-dust) — the technical heart of "menu-Hall is necessary inside the menu engine".

**Deferred / out of scope:**
- §9 witness classification (qualitative discussion, not a theorem with a checkable target).
- §12 remaining-directions roadmap.

## Artifacts
- Source proof: lean/source_proof.md
- Main Lean file: lean/main.lean (skeleton)
- INVENTORY.lean: lean/support/INVENTORY.lean (empty)
- Diagnostics: lean/diagnostics/
- Per-lemma proofs: lean/lemmas/ (empty)

## Lemma Status
_(populated by /lean-structure)_

## Recent History
- 2026-05-19T03:00:01Z  /lean-formalize-init  bootstrapped from hand-consolidated v8 (terminal artifact per project README and closure memo)
- 2026-05-19T03:18:00Z  /lean-structure pass 1  structurer returned (54.5k chars, 14 min wall-clock); 36 objects, 29 lemmas, 14 externals, 16 implicit assumptions, 5 non-Mathlib stubs. Saved as lean/decomposition.md. Phase init → structuring. Awaiting reviewer.
