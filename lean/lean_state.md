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
- 2026-05-19T11:00Z  /lean-structure pass 1 reviewer (harvested on resume; Windows host, port 9227)  verdict PATCH_BIG. implicit_assumptions_absorbed: 4, object_definition_concerns: 6. Major flags: payoff-layer ambiguity (root); Tier 2 adversary identity κ vs deterministic selector; profile-realization not bundled; Jankov–von Neumann gives universally-measurable not Borel; atomlessness misattributed to cone-intersection; monolithic main theorem; missing predicates (KernelSupportedOnG, RowwiseSupport, BayesConeCalibration); nonemptiness of A/Θ/M/W not surfaced. Saved as lean/diagnostics/lean_structurer_reviewer_response_1.md.
- 2026-05-19T11:05Z  /lean-structure pass 2 submitted  patch prompt rendered with 18 explicit fix items + reviewer feedback + prior decomposition + source proof (105k chars). Chat URL: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0c50ba-2718-83ea-8401-301ac439f03b. Generating on Extended Pro. Awaiting structurer pass 2 response.
- 2026-05-19T11:20Z  /lean-structure pass 2 RESPONSE harvested  structurer returned 73.5k chars in ~12 min. main_theorem renamed `robust-trust-infinite-extension-v8-package`; object_count 36→50, lemma_count 29→50, external_count 14→17, implicit_assumption_count 16→20, non_mathlib_count 5→10. Decomposition saved to lean/decomposition.md (1125 lines). Key positives visible in header: atomlessness scoped to WTA only ("positive tiers do not assume atomlessness"); Bayes-plausibility consistency added; ΔΩ → M restriction bridge added as object; payoff layer split (AlignedPayoff, MisalignedPayoff, MixturePayoff, RobustPayoff, U_star, IsAdversarial); profile-realization bundled; JvN scope corrected. Saved as lean/diagnostics/lean_structurer_response_2.md.
- 2026-05-19T11:21Z  /lean-structure pass 2 reviewer submitted  reviewer prompt rendered (104k chars: header + source proof + revised decomposition). Pass-2-specific instructions added (verify each of 18 fix items addressed; watch for over-correction; spot-check new objects/lemmas; verify NON_MATHLIB count rise from 5 to 10 is justified). Chat URL: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0c558a-6884-83ea-9a86-16079fae5403. Generating on Extended Pro. (Note: cdp_submit had a fill-timeout issue mid-script; recovered by clicking send manually via Playwright after composer was filled.)
