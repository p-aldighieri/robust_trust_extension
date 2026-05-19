# Lean Formalization State

## Meta
- Proof repo: /Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension
- Source proof (absolute): /Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/02_proof_history/theorem_versions/theorem_2_extension_proof_v8.md
- Source provenance: hand-consolidated v8 — three-tier infinite extension of Dworczak–Smolin Robust Trust Theorem 2 (existence direction), terminal per project README and `01_deliverables/closure/project_closure_memo.md`. This proof repo predates the MathPipeProver consolidator workflow, so the source proof is selected directly rather than picked up from `runs/<id>/branches/<branch>/context/final_report.md`.
- Provenance slug: robust-trust-v8 (use for stable codex thread ids in /lean-verify-deps)
- Initialized: 2026-05-19T03:00:01Z
- Current phase: deps_proposing
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
_(populated by /lean-structure; populated 2026-05-19 from pass-3 PASS decomposition)_

| Slug | declared | proved | reviewed | merged | permanent_stub |
|---|---|---|---|---|---|
| posterior-law-barycenter-identities | ⧗ | | | | |
| strategy-restriction-to-M | ⧗ | | | | |
| restricted-agent-strategy-extends-to-full | ⧗ | | | | |
| outside-M-messages-irrelevant | ⧗ | | | | |
| adversary-kernels-restrict-to-M | ⧗ | | | | |
| full-restricted-Ustar-equivalence | ⧗ | | | | |
| q-dominates-tau-when-alpha-pos | ⧗ | | | | |
| payoff-profile-set-compact-convex | ⧗ | | | | |
| profile-map-has-borel-right-inverse | ⧗ | | | | |
| borel-profile-map-implemented-by-agent-strategy | ⧗ | | | | |
| profile-payoff-decomposition-aligned | ⧗ | | | | |
| profile-payoff-decomposition-misaligned | ⧗ | | | | |
| mixture-payoff-decomposition | ⧗ | | | | |
| adversary-infimum-pointwise | ⧗ | | | | |
| strategy-value-le-menu-sup | ⧗ | | | | |
| menu-value-le-strategy-sup | ⧗ | | | | |
| menu-value-equivalence | ⧗ | | | | |
| compact-menu-space-compact | ⧗ | | | | |
| menu-extrema-Hausdorff-Lipschitz | ⧗ | | | | |
| menu-functional-continuity | ⧗ | | | | |
| optimal-menu-exists | ⧗ | | | | |
| aligned-best-labeling-selection | ⧗ | | | | |
| closure-pruning-value-preservation | ⧗ | | | | |
| wstar-profile-map-implemented | ⧗ | | | | |
| wstar-payoff-equals-F-Cdagger | ⧗ | | | | |
| sigma-star-robust-optimal | ⧗ | | | | |
| Geps-nonempty | ⧗ | | | | |
| Geps-graph-measurable | ⧗ | | | | |
| Geps-selector-exists | ⧗ | | | | |
| epsilon-adversary-realization | ⧗ | | | | |
| exact-contact-selector-unpack | ⧗ | | | | |
| exact-adversary-attainment | ⧗ | | | | |
| menuHall-adversary-kernel-identity | ⧗ | | | | |
| menu-Hall-posterior-calibration-unpack | ⧗ | | | | |
| menu-Hall-support-implies-exact-adversary | ⧗ | | | | |
| per-message-Bayes-optimality | ⧗ | | | | |
| posterior-disintegration-menuHall-kernel-coincides | ⧗ | | | | |
| support-function-pointwise-membership-equivalence | ⧗ | | | | |
| support-function-integrated-Hall-equivalence | ⧗ | | | | |
| tier1a-value-optimality-and-epsilon-adversary | ⧗ | | | | |
| tier1b-exact-adversary-under-exact-contact | ⧗ | | | | |
| tier2-qae-robust-rationalizability-under-menu-Hall | ⧗ | | | | |
| WTA-payoff-dot-product-identity | ⧗ | | | | |
| WTA-rowwise-minimizer-and-Bayes-cone-identification | ⧗ | | | | |
| wta-cone-intersection | ⧗ | | | | |
| dust-disintegration-over-subtype-N | ⧗ | | | | |
| qN-supported-on-N | ⧗ | | | | |
| dust-rowwise-support-implies-cone-support | ⧗ | | | | |
| dust-Bayes-calibration-gives-cone-barycenter | ⧗ | | | | |
| dust-conditional-sources-satisfy-cones | ⧗ | | | | |
| cone-intersection-applied-to-dust | ⧗ | | | | |
| positive-dust-mass-impossible-when-alpha-one | ⧗ | | | | |
| dust-positive-mass-forces-mu0-atom | ⧗ | | | | |
| wta-no-free-dust | ⧗ | | | | |
| sharpness-corollary | ⧗ | | | | |
| halfspace-contains-beliefs-inducing-all-vertices | ⧗ | | | | |
| halfspace-induced-effective-menu-equals-full-vertices | ⧗ | | | | |
| halfspace-behavior-equivalent-to-full-simplex | ⧗ | | | | |
| halfspace-witness-menu-engine-artifact | ⧗ | | | | |

Legend: ⧗ = declared in decomposition (not yet formalized). Will be populated to ✓ as `/lean-formalize` and `/lean-prove-lemma <slug>` complete each row.

## Recent History
- 2026-05-19T03:00:01Z  /lean-formalize-init  bootstrapped from hand-consolidated v8 (terminal artifact per project README and closure memo)
- 2026-05-19T03:18:00Z  /lean-structure pass 1  structurer returned (54.5k chars, 14 min wall-clock); 36 objects, 29 lemmas, 14 externals, 16 implicit assumptions, 5 non-Mathlib stubs. Saved as lean/decomposition.md. Phase init → structuring. Awaiting reviewer.
- 2026-05-19T11:00Z  /lean-structure pass 1 reviewer (harvested on resume; Windows host, port 9227)  verdict PATCH_BIG. implicit_assumptions_absorbed: 4, object_definition_concerns: 6. Major flags: payoff-layer ambiguity (root); Tier 2 adversary identity κ vs deterministic selector; profile-realization not bundled; Jankov–von Neumann gives universally-measurable not Borel; atomlessness misattributed to cone-intersection; monolithic main theorem; missing predicates (KernelSupportedOnG, RowwiseSupport, BayesConeCalibration); nonemptiness of A/Θ/M/W not surfaced. Saved as lean/diagnostics/lean_structurer_reviewer_response_1.md.
- 2026-05-19T11:05Z  /lean-structure pass 2 submitted  patch prompt rendered with 18 explicit fix items + reviewer feedback + prior decomposition + source proof (105k chars). Chat URL: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0c50ba-2718-83ea-8401-301ac439f03b. Generating on Extended Pro. Awaiting structurer pass 2 response.
- 2026-05-19T11:20Z  /lean-structure pass 2 RESPONSE harvested  structurer returned 73.5k chars in ~12 min. main_theorem renamed `robust-trust-infinite-extension-v8-package`; object_count 36→50, lemma_count 29→50, external_count 14→17, implicit_assumption_count 16→20, non_mathlib_count 5→10. Decomposition saved to lean/decomposition.md (1125 lines). Key positives visible in header: atomlessness scoped to WTA only ("positive tiers do not assume atomlessness"); Bayes-plausibility consistency added; ΔΩ → M restriction bridge added as object; payoff layer split (AlignedPayoff, MisalignedPayoff, MixturePayoff, RobustPayoff, U_star, IsAdversarial); profile-realization bundled; JvN scope corrected. Saved as lean/diagnostics/lean_structurer_response_2.md.
- 2026-05-19T11:21Z  /lean-structure pass 2 reviewer submitted  reviewer prompt rendered (104k chars: header + source proof + revised decomposition). Pass-2-specific instructions added (verify each of 18 fix items addressed; watch for over-correction; spot-check new objects/lemmas; verify NON_MATHLIB count rise from 5 to 10 is justified). Chat URL: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0c558a-6884-83ea-9a86-16079fae5403. Generating on Extended Pro. (Note: cdp_submit had a fill-timeout issue mid-script; recovered by clicking send manually via Playwright after composer was filled.)
- 2026-05-19T11:50Z  /lean-structure pass 2 reviewer RESPONSE harvested  verdict PATCH_BIG (narrower). implicit_assumptions_absorbed: 3 (down from 4), object_definition_concerns: 5 (down from 6). Reviewer explicitly confirmed 90% of pass-1 issues addressed (payoff layer split, κ identity, Bayes-plausibility, ProfileRealizationSetup, JvN scope, main theorem split, Definition2QAEPredicate, etc.). Four remaining seams: (i) reverse strategy lift (M-restricted → full Σ on Δ Ω) missing; (ii) Tier 2 posterior identity Pκ = Pγα missing; (iii) atomlessness still over-bundled in WTA-ternary-environment; (iv) dust-label typing (λ, wN, I defined on N but used in predicates over all M). Plus α-case split surfaced in prose not DAG; Belief definition wants coordinatewise nonneg; standard-borel-disintegration may now be MATHLIB_CANDIDATE.
- 2026-05-19T11:55Z  /lean-structure pass 3 submitted  patch prompt with 12 explicit narrow fix items (reverse lift, posterior identity, WTA atomlessness split, dust subtype discipline, null-dust-data new fields, α-case lemma, Geps selector pick, σ*-realization split, dust-disintegration-over-subtype-N, Mathlib reclassification, Belief fix, main-theorem full-Σ exposure). 117k chars. Chat URL: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0c5a97-2d00-83ea-a6b8-052fb0660739. NOTE: pass 3 is the cap (3 retries). If pass-3 reviewer still PATCHes, escalate to Pedro.
- 2026-05-19T12:25Z  /lean-structure pass 3 RESPONSE harvested  81.5k chars in ~30 min on Pro 5.5. object_count 50→53 (+3), lemma_count 50→59 (+9), external_count 17 (same), implicit_assumption_count 3→0, non_mathlib_count 10→9 (standard-borel-disintegration reclassified). Spot-check confirms all 12 patch items addressed by slug presence: restricted-agent-strategy-extends-to-full, full-restricted-Ustar-equivalence, posterior-disintegration-menuHall-kernel-coincides, WTA-ternary-algebra (split from WTA-ternary-environment), AtomlessTauSharpness (separate), wN_eq_mixed_label, positive-dust-mass-impossible-when-alpha-one, dust-disintegration-over-subtype-N, wstar-profile-map-implemented, wstar-payoff-equals-F-Cdagger, sigma-star-robust-optimal. Belief definition fixed (coordinatewise nonneg). Atomlessness explicitly scoped ("Exact-contact, menu-Hall, and atomlessness are not standing fields"). Saved as lean/diagnostics/lean_structurer_response_3.md and lean/decomposition.md (2343 lines).
- 2026-05-19T12:27Z  /lean-structure pass 3 reviewer submitted  reviewer prompt 109k chars: header + source proof + revised decomposition. Pass-3-specific tracker added (audit each of 4 seams + smaller items as: addressed | partially | not | regressed). Chat URL: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0c6070-45f4-83ea-a359-8ebe0ec3cdbb. Generating on Extended Pro. (cdp_submit fill timeout again; recovered by clicking send manually.)
- 2026-05-19T12:40Z  /lean-structure pass 3 reviewer RESPONSE: **PASS**. ready_for_dep_audit: true, recommended_next_phase: LEAN_DEP_AUDIT, implicit_assumptions_absorbed: 0, object_definition_concerns: 0. All 4 pass-2 seams addressed; no regressions detected. Reviewer also confirmed: payoff layer split intact; κ identity intact; ProfileRealizationSetup intact; ΔΩ→M bridge now complete (improved); JvN scope intact; α-case split present; σ*-realization split correctly; dust subtype discipline applied; standard-borel-disintegration reclassified to MATHLIB_CANDIDATE; Belief definition coordinatewise; Geps selector total Borel via explicit JvN+Borel-upgrade. Decomposition is structurally ready for dependency audit. Saved to lean/diagnostics/lean_structurer_reviewer_response_3.md. Phase structuring → deps_proposing. Lemma Status table populated with 58 lemma slugs.
- 2026-05-19T12:45Z  /lean-dep-audit submitted  dep-audit prompt 108k chars: header + revised decomposition + source proof. Header includes toolchain-context note pointing to recently-added Mathlib modules (StandardBorel disintegration, HausdorffDistance, etc.). Chat URL: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0c63f5-6974-83ea-8612-a364bcf13f15. Generating on Extended Pro. Expected 30-90 min wall-clock per lean_formalization.md. (cdp_submit fill timeout pattern persists; recovered via manual click again — pattern is consistent enough that we should consider patching cdp_submit.mjs after the wet run.)
