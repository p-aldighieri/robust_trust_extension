# Project closure memo — Robust Trust Theorem 2 infinite extension

**Status:** terminal at v8. Gatekeeper-blessed (three passes; final verdict `OBJECTIVE_NARROWED` with explicit STOP-AND-COMMIT recommendation).

**Date closed:** 2026-05-07.

## What v8 is

A three-tier conditional infinite-extension of Theorem 2 from Dworczak–Smolin, *Robust Trust* (2026, arXiv:2602.09490), under standing hypotheses (Ω finite, full-support prior, A and Θ compact metric, u bounded continuous in a, conditional independence of s and θ given ω, Borel measurability) but **without** finite M or Θ:

- **Tier 1a (standing alone).** Existence of σ* ∈ Σ with U(σ*) = U*, plus ε-adversaries for every ε > 0. **No added hypotheses.**
- **Tier 1b (+ exact-contact).** Exact β* ∈ B with U(β*, σ*) = U*. The exact-contact assumption is endogenous to the optimal labeling w*.
- **Tier 2 (+ exact-contact + menu-Hall).** Full robust rationalizability in the q_β-a.e. sense (the natural infinite-space reading of Definition 2; equivalent to τ-a.e. when α > 0). The menu-Hall assumption is set-valued, strictly milder than v5's deterministic TRE-gen-Hall.

Sharpness package:
- **Lemma 7 (cone intersection).** In WTA ternary, for every nonempty support I ⊆ {0,1,2}, the only Borel probability ρ on Δ(Ω) with ρ(K_I^-) = 1 and barycenter in B_I is δ_{(1/3,1/3,1/3)}.
- **Theorem 8 (no-free-dust).** Under atomless τ in WTA ternary, no Borel τ-null dust set + labeling + adversarial kernel can simultaneously satisfy positive q-mass and Bayes-cone calibration.

Classification of the witness:
- The trust region T = {μ : μ(0) ≤ 0.4} used in §8 is **not primitive, minimal, or load-bearing**. Its induced payoff-profile menu is the full vertex menu, behaviorally equivalent to T = Δ(Ω). The witness shows menu-Hall is genuinely needed inside the menu engine **but is not a primitive counterexample to unrestricted Theorem 2.**

## What v8 is NOT

**v8 is not a proof of unrestricted Theorem 2.** Tier 2 carries menu-Hall as an additional hypothesis. The gatekeeper classified menu-Hall as scope-changing because it installs the equilibrium calibration that Definition 2 demands; weaker than deterministic TRE-gen-Hall is not the same as primitive.

**v8 is not a counterexample to unrestricted Theorem 2.** The §8 witness is a menu-engine artefact (classification (b)). No primitive optimization with standing assumptions has been shown to force the witness's geometry.

## Strategic record

| Strategy | Outcome |
|---|---|
| 1. Formalizer reread of Definition 2 on-path semantics | Closed. q_β-a.e. confirmed as the natural reading; v8 narrowing real under any reasonable reading. |
| 2. Null-message dust | Closed (negative). No-free-dust theorem (reviewer-PASS) shows τ-null dust cannot repair menu-Hall in WTA ternary under atomless τ. |
| Classification (b) of v7 ternary witness | Banked. Witness is menu-engine artefact, not primitive counterexample. |
| 3a. C1 behavioral-minimality canonical menu | Stalled. Critical Lemma A.2 (uncalibrated minimal menu pruning) blocked at three named structural gaps: label-saturation, replacement-index mismatch, Borel→compact gap. |
| 3b. C2 exposed-extreme | Not pursued; reviewer judged needs its own analog of A.2. |
| 3c. C3 primitive TR-minimality | Not pursued; reviewer judged useful for ruling out scenery (already in v8 §9) but doesn't solve index mismatch. |
| 3d. C4 radial/orbit symmetry | Not pursued; reviewer judged best islands (binary, spherical) already covered by paper Appendices A.6, A.10. |
| 4. Finite RR equilibria → joint-law limits | Not pursued; searcher ranked low (close to prior failed limit/lifting routes). |
| 5. Trust-region geometry general | Not pursued; positive cases already in paper. |

## The single most consequential open question

A **deletion-compatible Hall duality theorem.** Existing Hall-style constraints are messagewise (Bayes calibration imposed at received m); deletion arguments are sourcewise (best retained minimizer for s). The missing theorem would need a dual certificate that prices deletion by source while enforcing calibration by message. It would also need to handle the Borel→compact gap: deleting a τ-positive Borel set need not shrink the closure of the labeling image.

If such a theorem exists, Strategy 3 may reopen with real force and Tier 2 could become unconditional for behaviorally minimal canonical menus. Until then, **do not restart canonical pruning without it.**

## What future contributors should not redo

- **Do not** propose new sharpness witnesses for menu-Hall. The cone intersection lemma + no-free-dust theorem cover all support patterns and all dust regimes uniformly.
- **Do not** treat the v7 ternary witness as evidence against unrestricted Theorem 2. Classification (b) closes that interpretation.
- **Do not** restart canonical/minimal menu pruning under standing + exact-contact. Lemma A.2 is blocked at named structural gaps; the route requires Unblocker A (deletion-compatible Hall duality) or Unblocker B+ (regularity strictly stronger than closed-graph + uniqueness, with explicit label-regularity tied to compact patches).
- **Do not** silently re-import infinite-dimensional saddle/minimax architectures (Sion, Tychonoff, Balder-Mertens-Lusin in the original Phil Reny form). These were tried in v3-v6 and superseded by the menu engine for clean reasons.

## Path to publication

The cleanest framing for an exposition or paper: *"Three-tier infinite-extension of Theorem 2 with sharpness. Tier 1a unconditional value optimality + ε-adversaries. Tier 1b exact adversary under a clean endogenous exact-contact condition. Tier 2 robust rationalizability under a set-valued menu-Hall calibration. menu-Hall is sharply needed inside the menu engine (cone intersection lemma + no-free-dust theorem), but the known obstruction is a menu-engine artefact, not a primitive counterexample to unrestricted Theorem 2. The unrestricted infinite extension remains open; the bottleneck is a deletion-compatible Hall duality theorem."*

## Pipeline metadata

- **Tool:** MathPipeProver, smart-scaffolding mode.
- **External engine:** ChatGPT Extended Pro.
- **Project URL:** https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957/project
- **Active CDP port:** 9224 (chrome-debug-profile-npiv).
- **Pipeline phases used:** formalizer (reread), searcher, breakdown, prover, reviewer, consolidator (manual local), gatekeeper (3 passes — first-ever runs of the gatekeeper role on any project).

## Durable sources at closure

- `objective_statement.md` — original claim-parsing and dependency map.
- `prior_attempts_digest.md` — failed architectures (Sion/Tychonoff/KRN, FOC/envelope, Phil-Reny global-saddle versions). Prevents repetition.
- `Robust_trust_Dworczak_Smolin.pdf` — primary paper.
- `theorem_2_extension_proof_v8.md` — terminal proof artifact.
- `project_closure_memo.md` (this file) — to prevent future contributors from misremembering v8 as proof or counterexample.
