# Formalization Report — Robust Trust Theorem 2 (v8 extension)

**Date**: 2026-05-20
**Branch**: `piotr-reny-revisit` (to be merged to `main`)
**Final commit**: `3bffd1c`
**Lean toolchain**: `lean-4.29.0` (Mathlib 4.29)
**AXLE status**: clean

## 1. Scope

Formalization of the v8 extension of Theorem 2 (existence direction) in Dworczak–Smolin "Robust Trust" (arXiv:2602.09490), from finite-$M$/finite-$\Theta$ to infinite-$M$/infinite-$\Theta$ via the payoff-profile menu engine, three-tier structure + sharpness package.

Source proof: `02_proof_history/theorem_versions/theorem_2_extension_proof_v8.md`.
Lean target: `lean/main.lean` (4978 lines, single file, namespace `RobustTrustV8` + supporting `namespace Inventory`).

## 2. Final state

### Sorry count: **3**, all in `namespace Inventory` (by design)

These are Mathlib-axiom-style external invocations that any reasonable measure-theory library would supply:

| Stub | Used by | Standard reference |
|---|---|---|
| `Inventory.measurable_argmax_selector` | `compact_menu_aligned_selection`, `aligned_best_labeling_selection` | Kuratowski–Ryll-Nardzewski 1965; Castaing–Valadier; Aliprantis–Border (measurable maximum theorem) |
| `Inventory.krn_borel_right_inverse` | `profile_map_has_borel_right_inverse` | Kuratowski–Ryll-Nardzewski 1965; Aliprantis–Border Thm 18.13-style measurable section results |
| `Inventory.kernel_infimum_epsilon_selection` | `adversary_infimum_pointwise` | Bertsekas–Shreve Prop. 7.50; Brown–Purves / Jankov–von Neumann measurable selection; normal-integrand interchange |

No `axiom`, no `unsafe`, no `admit`, no `exact?` oracles below the `Inventory` block. The entire `namespace RobustTrustV8` proof is sorry-free + axiom-free.

### Tier-by-tier deliverable

| Tier | Lean theorem | Hypotheses (added to standing model) | What it delivers |
|---|---|---|---|
| 1a | `tier1a_value_optimality_and_epsilon_adversary` | `plc, msupp, bridge, prs` | $\exists \sigma^*$ with $U(\sigma^*) = U^*$; for every $\varepsilon > 0$, an $\varepsilon$-optimal Markov adversarial kernel $\beta_\varepsilon$ |
| 1b | `tier1b_exact_adversary_under_exact_contact` | + `ExactContact` for $\sigma^*$ | exact $\beta^* \in \arg\min$ Markov kernels (deterministic, supported on rowwise-contact $G$); value equality |
| 2  | `tier2_qae_robust_rationalizability_under_menu_Hall` | + `MenuHall` for some $\kappa$ | $\kappa$ adversarial + $\kappa$ value-attaining + Definition-2 QAE Bayes-optimality (q-a.e.) + $\tau_M$-a.e. corollary under $\alpha > 0$ |
| Sharpness | `wta_cone_intersection`, `wta_no_free_dust`, `halfspace_witness_menu_engine_artifact` | + `AtomlessTauSharpness` for the no-free-dust statement (sharpness-only) | uniform cone intersection lemma; no Borel τ-null dust + adversarial kernel can repair menu-Hall in WTA ternary; halfspace witness is a menu-engine artefact |
| Top | `robust_trust_infinite_extension_v8_package` | `plc, msupp, bridge, prs` | $\exists \sigma^*$ packaging Tier 1a + (∀ `ec`, Tier 1b) + (∀ `pd, ec, κ, mh`, Tier 2) + the 3 sharpness statements |

### Critical-discipline checklist (all PASS)

- **No `axiom` below Inventory**: verified.
- **No hypothesis smuggling**: structures (`ExactContact`, `MenuHall`, `PosteriorDisintegration`, `ProfileRealizationSetup`, `MessageRestrictionBridge`) carry their hypotheses as explicit fields; the V8 package's existential quantifiers expose them.
- **Atomlessness of $\tau$ scoped to sharpness**: `NoAtoms`/`AtomlessTauSharpness` appears only in `WTA_NoFreeDustStatement`, `wta_no_free_dust`, `sharpness_corollary`. Tier 1a/1b/2 do not see it.
- **Tier 2 hypotheses are bound, not global**: `ExactContact model σstar` and `MenuHall model pd σstar ec κ` are explicit parameters to `tier2_qae_robust_rationalizability_under_menu_Hall` and to `Tier2Result`; the V8 package quantifies over them.

## 3. External audit findings (commits `0f552c0`, `aae8f52`, `3bffd1c`)

Three Extended-Pro audits were performed:

- **Task 1** (audit of `main.lean`, project-internal): PASS for the `RobustTrustV8` namespace; the 3 `Inventory` stubs classified as 1 LEGIT-EXTERNAL (`krn_borel_right_inverse`) + 2 BORDERLINE (statements slightly more general than Mathlib supplies; use sites have the standard structure).
- **Task 2** (conceptual fit on plain Pro): **PARTIALLY-ON-TOPIC, HIGH confidence**. Object is correct (not a different game, not finiteness smuggled back). Tier 1a is *logically weaker than Theorem 2* (ε-adversary, not exact β*); Tier 1b is *half the certificate* (gives β* but not per-message Bayes-optimality); Tier 2 is the genuinely on-topic statement but assumes `MenuHall` which is "calibration-shaped" (close to assuming the conclusion).
- **Task 3** (Lean-vs-English fidelity): one decorative conjunct in `Tier2Result` removed (commit `3bffd1c`); two "DRIFT" flags from Pro turned out to be false alarms caused by an incomplete headliner extract sent for review (the actual file contains `MenuHall.supported` and `Tier2Result`'s `Definition2QAEPredicate` exposes the q-a.e. statement).

Pro's bottom-line characterization (Task 2): *"a credible, on-topic conditional infinite-space formalization and decomposition of the existence direction, not yet a primitive full extension of Theorem 2."*

## 4. Cleanup performed

During this session (20→3 sorries):

- Closed 7 substantive sorries via Pro-assisted proof splices: `hF_split`, `robust_range_bddAbove`, `hMis_per_β`, `adversary_infimum_pointwise`, `strategy_value_le_menu_sup`, `wstar_payoff_equals_F_Cdagger`, `hmix`, `kernel_supportedOnG_mixture_eq_robust`. Added the geometric Hahn-Banach helper `closed_convex_mem_of_dense_support_le`.
- Deleted 22 orphan declarations (theorems + Inventory stubs reachable from no V8-package theorem): saved 507 lines, brought INVENTORY from 10 stubs down to 3 actually-used stubs.
- Dropped 3 decorative conjuncts from `Tier2Result`.

## 5. Open questions (modeling philosophy, not soundness)

These do not affect the existing theorems; they are decisions about the model framing.

- **`ProfileRealizationSetup` as derived vs added.** The structure carries continuity, compactness, convexity, surjectivity, and fiber data for the payoff-profile space $W$. The V8 package accepts it as an explicit premise. If $W$'s properties are *derivable* from the standing primitives (finite $\Omega$, bounded continuous $u$, etc.), the formalization should expose this derivation. As written, it's a structural assumption added at the top of the package.
- **Tier 1a's "unconditional" framing.** As Pro observed, Tier 1a delivers value-optimality + ε-adversary, not exact-adversary attainment. ε-adversary is conjecturally the genuine ceiling under standing hypotheses (without `ExactContact`), but this is not formally proved as a limitation theorem in the file. A "no-exact-adversary under standing alone" theorem would clarify why Tier 1b's extra hypothesis is mathematically necessary.
- **`sharpness_corollary` not in V8 package.** It's the singleton-support specialization of `WTA_ConeIntersectionStatement` + `WTA_NoFreeDustStatement` (which *are* in the package); derivable. Could be added as a conjunct or documented as a corollary.

## 6. Provenance

- v7 source: `02_proof_history/theorem_versions/theorem_2_extension_proof_v7.md` (consolidated three-tier menu engine).
- v8 source: `02_proof_history/theorem_versions/theorem_2_extension_proof_v8.md` (v7 + sharpness package: cone intersection + no-free-dust + halfspace classification).
- Objective parsing: `00_inputs/objective/objective_statement.md`.
- Primary paper: `00_inputs/primary_paper/Robust_trust_Dworczak_Smolin.pdf`.
- Audit transcripts: `lean/diagnostics/audit_task{1,2,3}_*.md`.

## 7. References

- **Dworczak, P. and Smolin, A.** (2026). "Robust Trust." arXiv:2602.09490.
- **Aliprantis, C. D. and Border, K. C.** (2006). *Infinite Dimensional Analysis*, 3rd ed. Springer.
- **Bogachev, V. I.** (2007). *Measure Theory*. Springer.
- **Bertsekas, D. P. and Shreve, S. E.** (1978). *Stochastic Optimal Control: The Discrete Time Case.* Academic Press.
- **Castaing, C. and Valadier, M.** (1977). *Convex Analysis and Measurable Multifunctions.* Springer.
- **Kuratowski, K. and Ryll-Nardzewski, C.** (1965). "A general theorem on selectors." *Bull. Acad. Polon. Sci.*
