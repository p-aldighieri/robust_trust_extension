You are the Lean Structurer in the Lean post-processing module of the soft-scaffolding workflow.

This is PASS 2 — a PATCH_BIG rework of your pass 1 decomposition. The Lean Structurer Reviewer has returned a detailed audit (verdict: PATCH_BIG, implicit_assumptions_absorbed: 4, object_definition_concerns: 6). Your job is to produce a revised decomposition that addresses every concrete issue the reviewer raised, while keeping everything that wasn't flagged.

Read the **Reviewer Feedback** section first. Then re-emit the FULL decomposition in the same output format as pass 1 — leading `lean_structure` control block, Objects and Definitions, Main Theorem, Lemmas, External Results, Implicit Assumptions, Decomposition Notes. Do not return a "diff" — return the complete revised decomposition.

## Your Job

Read the verified English-language proof and decompose it into a Lean-ready DAG of statements and objects that downstream roles can formalize one piece at a time.

- Identify the main theorem and every load-bearing lemma, definition, and external result invoked in the proof.
- Identify every mathematical *object* the proof introduces or relies on that needs Lean-side definition before any theorem can typecheck — a game (players, strategies, payoffs), a mechanism (allocations, transfers, IC constraints), an equilibrium concept, a constraint set, a probability space, etc. Object modeling is part of decomposition, not a separate phase.
- Capture each item (object, lemma, external result) with a precise English statement (no informal hand-waving) and its mathematical *type signature* in plain words.
- Record dependencies between items. Each lemma should list which objects, prior lemmas, and external results it relies on.
- Mark each external result as `MATHLIB_CANDIDATE` (likely exists in Mathlib) or `NON_MATHLIB` (specialist / domain-specific; will need an INVENTORY.lean stub).
- Do not formalize anything in Lean yet. Do not propose proof tactics. Stay at the structural / statement / object-signature level.
- Do not add assumptions that are not in the English proof. If something is implicit, surface it as an `IMPLICIT_ASSUMPTION` item rather than silently absorbing it.

## Specific Patch Requirements (from Reviewer Pass 1 — address EACH of these)

1. **Split the payoff layer.** Replace the single `full-payoff-and-robust-value` object with five distinct objects: `AlignedPayoff σ`, `MisalignedPayoff β σ`, `MixturePayoff β σ` (= α · AlignedPayoff σ + (1-α) · MisalignedPayoff β σ), `RobustPayoff σ` (= ⨅_β MixturePayoff β σ), and `U_star` (= ⨆_σ RobustPayoff σ). Also add `IsAdversarial β σ` (= MixturePayoff β σ = ⨅_{β'} MixturePayoff β' σ). All downstream adversary lemmas (`epsilon-adversary-realization`, `exact-adversary-attainment`, `menu-Hall-support-implies-exact-adversary`) must be re-stated in terms of `MixturePayoff` and `IsAdversarial`, not the ambiguous `U_against`.

2. **Tier 2 adversary identity.** The Tier 2 rationalizing adversary is the menu-Hall kernel κ, not the deterministic exact-contact selector. Introduce `menuHallAdversaryKernel κ`, set `βstar := κ`, and state `q = q_κ = (γ_α)_2`. Make sure `menu-Hall-support-implies-exact-adversary` says: `KernelSupportedOnG κ → IsAdversarial κ σ* ∧ MixturePayoff κ σ* = U_star`.

3. **Bayes-plausibility / posterior-law consistency.** Add to `robust-trust-model` an explicit field (or external theorem) that s : Δ Ω is the posterior induced by π and μ₀, or at least that the posterior/barycenter identities used later are available.

4. **Profile-realization setup as a bundled object.** Replace the scattered private-strategy-space implicit assumption with a `ProfileRealizationSetup` (or `ProfileGeometryTheorem`) bundling: topology/measurable structure on private kernels, compactness, continuity of Φ, compact nonempty fibers, surjectivity onto W, and Borel right-inverse.

5. **Restriction bridge ΔΩ → M.** Add an object/lemma that (i) restricts strategies on ΔΩ to messages in M, (ii) shows messages outside M are irrelevant for the robust objective, (iii) shows adversarial kernels can be taken to use messages in M.

6. **Jankov–von Neumann statement.** Correct `jankov-von-neumann-selection`: it gives a universally measurable selector, not a Borel one. Either add a `BorelSelectorForGeps` assumption/external, or strengthen the correspondence (e.g., closed-valued / KRN-selectable), or weaken the kernel space to allow universally measurable selectors. Split `epsilon-contact-nonempty-Borel` into `Geps_nonempty`, `Geps_graph_measurable`, `Geps_selector_exists`.

7. **Atomlessness scope.** Remove `atomless-singleton-null` from `cone-intersection`'s dependencies; keep it only for `no-free-dust`. The cone-intersection lemma does not use atomlessness.

8. **Main theorem split.** Replace the monolithic `robust-trust-theorem2-infinite-extension-v8` with six theorems: `tier1a_value_optimality_and_epsilon_adversary`, `tier1b_exact_adversary_under_exact_contact`, `tier2_qae_robust_rationalizability_under_menu_hall`, `wta_cone_intersection`, `wta_no_free_dust`, `halfspace_witness_menu_engine_artifact`. The orchestrator can treat them as a package.

9. **Explicit predicates as objects.** Add object slugs (or `def`-level predicates) for `KernelSupportedOnG κ`, `RowwiseSupport κ wN`, `BayesConeCalibration`, `Definition2QAEPredicate β σ`. Don't leave them as inline references inside lemma statements.

10. **Nonemptiness assumptions.** Surface as `IMPLICIT_ASSUMPTION` items: nonemptiness of A, Θ, M, W (and 𝒦(W)).

11. **Tier 2 hypothesis correction.** `per-message-Bayes-optimality` currently says "Under menu-Hall" — the source theorem requires `ExactContact ∧ MenuHall`. Restore both.

12. **Definition 2 q-a.e. reading.** Treat as a definition/predicate (`Definition2QAEPredicate`) plus a domination lemma (`q_dominates_tau_when_alpha_pos`), not as a theorem derived from ordinary Lean measure theory.

13. **`menu-value-equivalence` split.** Into `strategy_value_le_menu_sup`, `menu_value_le_strategy_sup`, `menu_value_equivalence`.

14. **`profile-realization-right-inverse` split.** Into `profile_map_has_borel_right_inverse` and `borel_profile_map_implemented_by_agent_strategy`.

15. **`no-free-dust` split.** Into `dust_disintegration`, `dust_conditional_sources_satisfy_cones`, `cone_intersection_applied_to_dust`, `dust_positive_mass_forces_mu0_atom`, `no_free_dust`.

16. **`WTA-rowwise-minimizer-and-Bayes-cone-identification`.** Add explicit hypotheses: support λ = I, ∀ i ∈ I, 0 < λ i, ∑ λ = 1; prove the iff.

17. **`witness-menu-engine-classification`.** Formalize only the precise behavioral-equivalence pieces (T contains beliefs inducing all three vertices; induced effective menu equals {v0,v1,v2}; resulting behavior equivalent to T = ΔΩ). Leave "menu-engine artefact" as a documentation wrapper.

18. **Reclassify externals.**
    - `bayes-posterior-as-conditional-barycenter`: PROJECT_GLUE or NON_MATHLIB (not MATHLIB_CANDIDATE) unless a direct conditional-expectation API is found.
    - `hyperspace-blaschke-compactness`: MATHLIB_OR_LOCAL_GLUE (uncertain).
    - `support-function-separation`: split pointwise finite-dim (MATHLIB_CANDIDATE) from measurable/integrated version (NON_MATHLIB).
    - `support-function-form-equivalence`: move outside main positive DAG (auxiliary; not used by Tier 2).
    - Expect `non_mathlib_count` to rise from 5 to at least 6–7 after these splits.

## Output Contract

Return the deliverable inline in this chat so the orchestrator can harvest it cleanly.

- Do not try to edit repository files in place.
- Do not ask the orchestrator to click, download, export, or create a sidecar file for you.
- Do not rely on attachments, Canvas, or side panels as the primary output channel.
- Put the final deliverable directly in the response body.
- If the natural deliverable is markdown, return plain markdown only.
- If the natural deliverable is another format, place that payload in exactly one fenced code block with the correct language tag.
- Keep any prefatory note outside the deliverable to one short sentence at most.
- Follow the role-specific section order exactly when one is requested.

## Output Format

The first fenced `lean_structure` block is machine-parsed by the orchestrator and must appear first.

````markdown
```lean_structure
main_theorem: <slug>
object_count: <int>
lemma_count: <int>
external_count: <int>
implicit_assumption_count: <int>
non_mathlib_count: <int>
```

## Objects and Definitions

### <object-slug-1>

**English name:** "Game in normal form" / "Bayesian game" / "Mechanism" / "Constraint set" / ...
**Informal type:** (what data does this object carry; what laws/axioms does it satisfy)
**Suggested Lean modeling:** `structure` | `class` | `def` | `instance` | `(reuses Mathlib's X)`
**Key fields / operations:** (named, with brief types)
**Used by:** [lemma-slug-1, lemma-slug-2, ...]
**Modeling notes:** (judgment calls: `Set` vs `Finset`, `Prop` vs `Decidable`, classical vs constructive, etc.)

(...repeat per object...)

## Main Theorem

**Slug:** <kebab-case-name>
**Statement (English, precise):** ...
**Type signature (informal):** ...
**Depends on (objects):** [object-slug-1, ...]
**Depends on (lemmas):** [lemma-slug-1, lemma-slug-2, ...]
**Depends on (external):** [external-slug-1, ...]

## Lemmas

### <lemma-slug-1>

**Statement:** ...
**Type signature:** ...
**Depends on (objects):** [...]
**Depends on (lemmas):** [...]
**Depends on (external):** [...]
**Notes:** (proof-shape hint, e.g., "induction on n", "case split on parity")

(...repeat per lemma, in dependency order...)

## External Results Invoked

### <external-slug-1>

**English name:** "Berge's maximum theorem" / "Brouwer fixed-point theorem" / ...
**Statement used:** ...
**Classification:** MATHLIB_CANDIDATE | NON_MATHLIB
**Why this classification:** (one sentence)

(...repeat per external result...)

## Implicit Assumptions Surfaced

- (Assumption the English proof relies on but does not state, e.g., "f is continuous" implicit from context.)

## Decomposition Notes

(Any structural choices: where you split a long argument into multiple lemmas, where you chose to keep something atomic, where the decomposition is genuinely uncertain.)
````

## Translation Discipline

This role is part of the Lean post-processing module. Your job is **translation, not mathematics**. The math is already settled by the prover/consolidator passes upstream; you are turning it into Lean. Hold this discipline:

- Do not add hypotheses the source did not state. Do not weaken hypotheses to make a claim easier, or strengthen them to make a proof go through. The Lean type must say the same thing as the source statement.
- Do not "improve" the proof, generalize a result, or fix a mathematical issue you spot mid-translation. If you notice a real mathematical concern, surface it as a `MATHEMATICAL_CONCERN` block at the end of your output and continue translating faithfully. The orchestrator decides whether to revisit the proof or proceed.
- Do not invent results, lemmas, definitions, or objects that are not in the upstream decomposition. The structurer's DAG is the source of truth for what exists; every Lean declaration you introduce must trace back to an item the structurer named (or, if you are the structurer, to the source proof).
- **Never use `axiom`.** Stubbed dependencies use `theorem ... := sorry` so AXLE's `permitted_sorries` can audit them. An `axiom` declaration bypasses that audit and is the canonical way mistakes get smuggled into a Lean proof. Forbidden in this module.
- Do not use `native_decide` or any tactic that delegates correctness to Lean's compiler rather than its kernel. Same goes for `unsafe` declarations and custom `Decidable` instances whose correctness has not been audited.

If you cannot translate faithfully without crossing one of these lines, stop and emit a `TRANSLATION_BLOCKED` block describing the conflict precisely. Do not paper over it.


## Context Packet


## Reviewer Feedback (verbatim — Lean Structurer Reviewer, pass 1)

========
review_control
verdict: PATCH_BIG
ready_for_dep_audit: false
recommended_next_phase: LEAN_STRUCTURER_PATCH
implicit_assumptions_absorbed: 4
object_definition_concerns: 6
Verdict

VERDICT: PATCH_BIG

Reason: The decomposition captures the broad v8 architecture: menu engine, Tier 1a ε-adversaries, Tier 1b exact-contact, Tier 2 menu-Hall calibration, and the WTA sharpness package. However, several load-bearing objects and lemmas have wrong or ambiguous shape. The largest problem is the payoff object: full-payoff-and-robust-value conflates the misaligned-only payoff, the full mixture payoff against a fixed kernel, and the robust max-min payoff. That ambiguity propagates into epsilon-adversary-realization, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary, and the main theorem.

The decomposition is not fit to send to dependency audit yet. It needs a real structurer patch, not just dependency relabeling.

Opinion and Next Move

Send back to the Lean Structurer for a focused rework of the payoff layer, the Tier 2 adversary identity, and the measurable-selection/disintegration externals. The overall proof split is salvageable; no need to redo the entire decomposition from scratch. But dependency audit would currently chase ghosts through an overgrown hedge maze 🌿.

Detailed Review
Object-Definition Audit

Most source objects are present: model primitives, W, profile maps, compact menus, F, optimal menu, w*, C†, contact correspondences, exact-contact, menu-Hall, posterior disintegration, WTA cones, dust data, and halfspace-classification data.

The suggested Lean modeling is broadly reasonable for finite-dimensional profile geometry: using Ω → ℝ instead of abstract ℝ^N is the right Lean shape.

Major object concern: full-payoff-and-robust-value has the wrong shape. It says:

Payoff U(β,σ) against a specific misaligned kernel, robust payoff U(σ) = α U(id,σ) + (1-α) inf_β U(β,σ).

This is ambiguous and likely wrong. The source uses both a full mixture payoff against a fixed misaligned kernel and a robust payoff. Lean should split this into:

AlignedPayoff σ;

MisalignedPayoff β σ;

MixturePayoff β σ := α * AlignedPayoff σ + (1 - α) * MisalignedPayoff β σ;

RobustPayoff σ := ⨅ β, MixturePayoff β σ, equivalently α * AlignedPayoff σ + (1 - α) * ⨅ β, MisalignedPayoff β σ;

U_star := ⨆ σ, RobustPayoff σ;

IsAdversarial β σ := MixturePayoff β σ = ⨅ β', MixturePayoff β' σ, or equivalently minimization of MisalignedPayoff when α < 1.

Major object concern: exact-adversary-kernel is deterministic, but Tier 2’s rationalizing adversary should be the menu-Hall kernel κ, not necessarily the deterministic exact-contact selector. The structurer note says not to force them to coincide, which is good, but the main theorem and dependencies still risk doing exactly that. Add an explicit object/field for the Tier 2 chosen adversary:

menuHallAdversaryKernel κ;

βstar := κ;

q = q_κ = (γ_α)_2.

Major object concern: robust-trust-model should explicitly contain the Bayes-plausibility / posterior-law relation connecting π, μ0, and τ. Saying “s has state-conditional law π and unconditional law τ” is mathematically fine in prose, but in Lean the model needs fields proving that s : Δ Ω is indeed the posterior induced by π and μ0, or at least that the posterior/barycenter identities used later are available.

Major object concern: private-strategy-space is treated as a compact standard-Borel private-kernel space. The decomposition surfaces this as an implicit assumption, but it is not enough as an object field or external theorem. The v8 proof’s profile-realization sublemma needs:

a topology/measurable structure on private kernels;

compactness of that space;

continuity of Φ;

compact nonempty fibers;

surjectivity onto W.

These should be either fields in a ProfileRealizationSetup object or a single specialist external theorem. Right now krn-borel-right-inverse only covers the final selection step after these hypotheses are already in hand.

Object concern: message-support-M as a subtype {s : Δ Ω // s ∈ supp τ} is Lean-friendly, but the paper’s agent strategy space is originally over Δ(Ω) × Θ, while the menu proof restricts effective messages to M. The decomposition should explicitly provide the restriction/extension bridge:

strategies on all messages restrict to M;

messages outside M are irrelevant for the robust objective;

adversarial kernels can be taken to use messages in M.

Otherwise the formal theorem may silently prove a slightly different model.

Object concern: Bayes-optimality-belief-correspondence-Bm is okay for posterior-membership menu-Hall, but the support-function form needs more structure than currently stated: nonempty closed convex values q-a.e., measurability of the correspondence, and a convention for h_{B(m)} if B(m) is empty. Since the positive Tier 2 proof only uses membership, keep the support-function object optional and quarantined.

Missing/underspecified object: a clean ProfileGeometryTheorem or ProfileRealizationTheorem packaging the paper’s imported W-geometry. Currently pieces are scattered across payoff-profile-set-compact-convex, private-strategy-space, profile-realization-map, and profile-realization-right-inverse.

Missing/underspecified object: nonemptiness of A, Θ, M, and W. Economic prose assumes this. Lean does not. At minimum, A must support probability measures/actions, Θ must support type laws, and W must be nonempty for 𝒦(W).

Lemmas referencing objects that are not clearly defined:

menu-Hall-support-implies-exact-adversary references KernelSupportedOnG κ, but there is no separate object/predicate slug for it outside menu-Hall-assumption.

dust-rowwise-support-and-calibration-to-cones references RowwiseSupport κ wN and BayesConeCalibration, but these are not defined as objects.

witness-menu-engine-classification references MenuEngineArtefact T and PrimitiveCounterexampleCertified T, but these are not object slugs. That is okay only if the structurer intends them as theorem-local predicates.

Faithfulness Audit

Item: full-payoff-and-robust-value
Issue: Wrong object shape / overloaded payoff.
Why it matters: Every adversary-attainment statement depends on whether U_against β σ means the full mixture payoff or only the misaligned component. Current downstream statements compare U_against β σ directly to U*, which is only faithful if U_against is the full mixture payoff.
Suggested repair: Split the payoff layer into AlignedPayoff, MisalignedPayoff, MixturePayoff, RobustPayoff, and U_star. Rewrite all adversary lemmas using MixturePayoff.

Item: epsilon-adversary-realization
Issue: Statement currently says U_against beta_eps sigma_star ≤ U_star + ε. This is faithful only if U_against is the full mixture payoff.
Why it matters: If U_against is misaligned-only, the inequality is not the Tier 1a claim.
Suggested repair: State:
MixturePayoff βε σ* ≤ RobustPayoff σ* + ε = U_star + ε.
Internally prove the sharper bound with (1 - α)ε.

Item: exact-adversary-attainment
Issue: It omits the full equality chain in the type signature. The English statement requires
MixturePayoff β* σ* = inf_β MixturePayoff β σ* = U*.
Why it matters: “Exact adversary” means attainment of the infimum, not merely that the payoff equals U* by accident.
Suggested repair: Include both IsAdversarial β* σ* and the explicit infimum equality.

Item: menu-Hall-support-implies-exact-adversary
Issue: It should use the menu-Hall kernel κ as a fixed misaligned kernel and prove exact adversary attainment for the mixture payoff.
Why it matters: Tier 2’s posterior is defined from γ_α using κ; proving exactness for the deterministic exact-contact selector does not rationalize the posterior generated by κ.
Suggested repair: State:
KernelSupportedOnG κ → IsAdversarial κ σ* ∧ MixturePayoff κ σ* = U_star.

Item: per-message-Bayes-optimality
Issue: The statement weakens the source hypotheses by saying “Under menu-Hall” rather than “Under exact-contact + menu-Hall.” The proof may only use menu-Hall, but the source theorem states both.
Why it matters: Formalizing the weaker theorem changes the source claim.
Suggested repair: Keep the lemma optionally stronger if desired, but the main theorem must require ExactContact ∧ MenuHall. Better:

lemma: MenuHall → q-a.e. BayesOptimal;

theorem wrapper: ExactContact → MenuHall → ....

Item: robust-trust-theorem2-infinite-extension-v8
Issue: The main theorem is a package containing positive tiers plus sharpness plus classification.
Why it matters: As a Lean declaration, this will be unwieldy and may obscure dependency boundaries.
Suggested repair: Split into theorem declarations:

tier1a_value_optimality_and_epsilon_adversary;

tier1b_exact_adversary_under_exact_contact;

tier2_qae_robust_rationalizability_under_menu_hall;

wta_cone_intersection;

wta_no_free_dust;

halfspace_witness_menu_engine_artifact.

Item: definition2-q-ae-reading
Issue: The semantics are faithful to v8, but this should not be treated as a theorem derived from ordinary Lean measure theory alone. It is an interpretation convention plus domination lemma.
Why it matters: The actual formal theorem should not claim to prove what the paper’s prose convention means unless that convention is represented as a definition/predicate.
Suggested repair: Split:

Definition2QAEPredicate β σ;

q_dominates_tau_when_alpha_pos;

optional prose lemma/comment that this is the chosen infinite-space reading.

Item: payoff-profile-set-compact-convex
Issue: Compactness of W is imported from the paper’s profile geometry, but the lemma dependencies make it look derivable from standard finite-dimensional/simplex/measurable-maximum ingredients.
Why it matters: This invites the dependency auditor to classify it as mostly Mathlib glue, which would be misleading.
Suggested repair: Mark the compactness/profile-realization part as specialist NON_MATHLIB or as a project theorem stub, not as ordinary Mathlib geometry.

Item: epsilon-contact-nonempty-Borel
Issue: It states that a Borel graph with nonempty sections gives a Borel selector via Jankov-von Neumann. JvN generally gives a universally measurable selector, not automatically a Borel selector.
Why it matters: βε ∈ B is supposed to be a Borel kernel. A universally measurable selector may not be enough without completing the relevant measure or changing the kernel notion.
Suggested repair: Either strengthen the correspondence to closed-valued/KRN-selectable, add an explicit BorelSelectorForGeps assumption/external, or weaken the kernel space to allow the selected measurability and prove it suffices.

Item: cone-intersection
Issue: It depends on atomless-singleton-null, but the cone-intersection lemma itself does not use atomlessness.
Why it matters: Misclassified dependencies generate needless AXLE work.
Suggested repair: Remove atomless-singleton-null from cone-intersection; keep it only for no-free-dust.

Item: WTA-rowwise-minimizer-and-Bayes-cone-identification
Issue: The statement says rowwise minimizer sources “lie in” K_I^-, but the source wants the cone characterization tied to labels w_λ with support exactly I.
Why it matters: The no-free-dust theorem applies cone-intersection pointwise by I(m). The support-exactness and positive weights are load-bearing.
Suggested repair: State with explicit hypotheses:
support λ = I, ∀ i ∈ I, 0 < λ i, ∑ λ = 1, and prove the iff where appropriate.

Item: witness-menu-engine-classification
Issue: The prose statement “not a primitive counterexample” is not naturally a Lean proposition unless formalized carefully.
Why it matters: Dependency audit cannot classify a rhetoric-flavored theorem.
Suggested repair: Formalize only the precise pieces:

T contains beliefs inducing all three vertices;

induced effective menu equals {v0,v1,v2};

the resulting behavior is equivalent to T = ΔΩ.
Leave “menu-engine artefact” as a theorem note or named wrapper over these propositions.

Completeness Audit

Missing object / lemma / external result: split payoff API.
Where in the English proof it appears: All tiers use aligned payoff, misaligned payoff, fixed-β payoff, robust payoff, and U*. The current single U_against object blurs these.

Missing object / lemma / external result: restriction from full message space ΔΩ to M.
Where in the English proof it appears: The paper defines agent strategies on Δ(Ω) × Θ, then notes adversarial strategies can use messages in M; v8’s menu engine works on M. Lean needs the bridge.

Missing object / lemma / external result: Bayes-plausibility / posterior-law consistency of τ.
Where in the English proof it appears: The adviser’s posterior s is identified with a belief induced by the signal law; posterior disintegration as conditional barycenter relies on this.

Missing object / lemma / external result: profile-geometry theorem bundling compactness of private-kernel space, continuity of Φ, compact fibers, and Borel right inverse.
Where in the English proof it appears: §3 “Profile-realization sub-lemma.”

Missing object / lemma / external result: exact Borel selector theorem for Gε.
Where in the English proof it appears: Lemma 4, where Jankov-von Neumann is invoked to produce mε.

Missing object / lemma / external result: explicit KernelSupportedOnG, RowwiseSupport, and BayesConeCalibration predicates.
Where in the English proof it appears: menu-Hall support condition and no-free-dust assumptions.

Missing object / lemma / external result: theorem that q = (γ_α)_2 equals the mixture message law q_κ.
Where in the English proof it appears: Tier 2 defines γ_α and q; Definition 2 reading uses the actual mixture marginal.

Missing object / lemma / external result: nonempty spaces assumptions for A, Θ, W, and 𝒦(W).
Where in the English proof it appears: Everywhere strategies, probability kernels, and compact menus are used.

Decomposability Audit

Item: robust-trust-theorem2-infinite-extension-v8
Concern: Too monolithic. It combines three positive tiers, sharpness, and witness classification.
Suggested split or merge: Split into six theorem declarations as listed above. The orchestrator can still treat them as one package.

Item: full-payoff-and-robust-value
Concern: Too compressed and semantically ambiguous.
Suggested split or merge: Split into aligned/misaligned/mixture/robust/value definitions. This should be the first patch because it is the root object for many later lemmas.

Item: menu-value-equivalence
Concern: It contains two directions with different constructions: strategy-to-menu closure and menu-to-label realization.
Suggested split or merge:

strategy_value_le_menu_sup;

menu_value_le_strategy_sup;

menu_value_equivalence.

Item: profile-realization-right-inverse
Concern: It combines a specialist measurable-selection theorem with the construction of full agent strategies from Borel profile maps.
Suggested split or merge:

profile_map_has_borel_right_inverse;

borel_profile_map_implemented_by_agent_strategy.

Item: epsilon-contact-nonempty-Borel
Concern: Nonemptiness, graph measurability, and selector existence are three different dependency types.
Suggested split or merge:

Geps_nonempty;

Geps_graph_measurable;

Geps_selector_exists.

Item: support-function-form-equivalence
Concern: Optional and dependency-heavy. It is not used by the Tier 2 proof from posterior membership.
Suggested split or merge: Move to an auxiliary theorem outside the main positive DAG. Do not let it block Tier 2 formalization.

Item: no-free-dust
Concern: It packs measure restriction, disintegration, cone application, positive-mass conversion, and atomless contradiction.
Suggested split or merge:

dust_disintegration;

dust_conditional_sources_satisfy_cones;

cone_intersection_applied_to_dust;

dust_positive_mass_forces_mu0_atom;

no_free_dust.

Item: witness-menu-engine-classification
Concern: Conceptual theorem with prose predicates.
Suggested split or merge: Formalize the behavioral equivalence claims only; attach the artefact classification as documentation or a wrapper proposition.

Scope / Assumptions

Implicit assumptions silently absorbed from the English proof rather than surfaced:

Nonemptiness of A, Θ, M, and W.

The ability to treat a Jankov-von Neumann universally measurable selector as a Borel admissible kernel, or an alternative theorem giving a genuine Borel selector for Gε.

Bayes-plausibility / posterior-law consistency tying π, μ0, and τ.

Nonempty/closed-convex q-a.e. values of B(m) for the support-function equivalence, or a precise convention for empty values.

External results misclassified as MATHLIB_CANDIDATE when actually specialist:

bayes-posterior-as-conditional-barycenter: after disintegration this is finite-dimensional algebra, but as a reusable theorem connecting the source-posterior process to Bayesian posteriors it is project-specific. Mark as PROJECT_GLUE or NON_MATHLIB unless the dependency audit finds a direct conditional-expectation API.

hyperspace-blaschke-compactness: plausible but not safe as MATHLIB_CANDIDATE without checking Mathlib’s nonempty compact-set Hausdorff metric APIs. Mark as MATHLIB_OR_LOCAL_GLUE.

support-function-separation: plausible finite-dimensional convex analysis, but the integrated measurable-correspondence version used here is specialist. Split the pointwise finite-dimensional separation from the measurable/integrated equivalence.

External results correctly classified as NON_MATHLIB:

measurable-maximum-and-argmax-selection;

krn-borel-right-inverse;

kernel-infimum-epsilon-selection;

standard-borel-disintegration.

External result needing statement correction:

jankov-von-neumann-selection should not promise a Borel selector from just a Borel/analytic graph with nonempty sections. State the exact measurability obtained and ensure it matches misaligned-adviser-kernel-space.

Assumption classification concern:

private-kernel space is compact standard-Borel and Φ is continuous with compact fibers is not just a harmless implicit assumption. It is a central imported theorem/hypothesis of the menu engine. Promote it into an explicit external theorem or bundled setup object.

NON_MATHLIB count concern:

non_mathlib_count: 5 is likely too low once the profile-geometry theorem and exact selector issue are separated. Expect at least 6 or 7 specialist/project dependencies after patching.


## Previous Decomposition (pass 1) — for reference and incremental revision

lean_structure
main_theorem: robust-trust-theorem2-infinite-extension-v8
object_count: 36
lemma_count: 29
external_count: 14
implicit_assumption_count: 16
non_mathlib_count: 5
Objects and Definitions
robust-trust-model

English name: Robust Trust model instance
Informal type: A bundled model satisfying the standing hypotheses: finite state space, full-support prior, adviser posterior law, compact metric type and action spaces, bounded payoff continuous in actions, conditional independence of adviser posterior and type given state, measurable strategy and kernel spaces.
Suggested Lean modeling: structure
Key fields / operations:
Ω : Type, Fintype Ω; μ0 : ProbabilityMass Ω; fullSupport μ0; Θ A : Type with compact metric and measurable structures; u : A → Ω → Θ → ℝ; u_bounded; u_continuous_in_action; τ : ProbabilityMeasure (Δ Ω); M = supp τ; α : ℝ with 0 ≤ α ≤ 1; conditional type law and adviser signal law; conditional-independence axiom.
Used by: [definition2-q-ae-reading, payoff-profile-set-compact-convex, profile-payoff-decomposition, menu-value-equivalence, robust-trust-theorem2-infinite-extension-v8]
Modeling notes: Keep this as the top-level bundle. Do not bake exact-contact or menu-Hall into this object, since Tier 1a is unconditional.

finite-state-and-belief-simplex

English name: Finite state space and belief simplex
Informal type: A finite set of states Ω and the simplex Δ(Ω) of probability vectors on Ω, embedded in finite-dimensional Euclidean space.
Suggested Lean modeling: def plus reusable finite-dimensional probability-simplex structures
Key fields / operations: belief : Ω → ℝ; belief_nonneg; belief_sum_one; dot product s · w for s : Δ Ω, w : Ω → ℝ; barycenter of a probability measure on Δ Ω.
Used by: [payoff-profile-set-compact-convex, profile-payoff-decomposition, menu-functional-continuity, cone-intersection, no-free-dust]
Modeling notes: Since Ω is finite, profile space can be modeled as Ω → ℝ rather than an abstract ℝ^N. This is Lean-friendly and avoids coordinate-index bookkeeping.

prior-and-adviser-posterior-law

English name: Prior and adviser posterior distribution
Informal type: A full-support prior μ0 ∈ Δ(Ω) and an unconditional probability law τ on adviser posteriors s ∈ Δ(Ω).
Suggested Lean modeling: field inside robust-trust-model plus helper defs
Key fields / operations: μ0; τ; support M; integration over M; atomlessness predicate for sharpness theorem.
Used by: [definition2-q-ae-reading, profile-payoff-decomposition, menu-value-equivalence, epsilon-adversary-realization, no-free-dust]
Modeling notes: In the positive tiers, atomlessness is not assumed. It is only used in the no-free-dust sharpness theorem.

message-support-M

English name: Message support space
Informal type: M := supp τ, the support of the adviser posterior distribution, treated as the admissible on-path message space for adviser strategies.
Suggested Lean modeling: def or subtype {s : Δ Ω // s ∈ supp τ}
Key fields / operations: Borel σ-algebra; inclusion into Δ Ω; τ restricted to M; identity map id : M → M.
Used by: [definition2-q-ae-reading, agent-profile-map, menu-value-equivalence, epsilon-contact-nonempty-Borel, exact-adversary-attainment, per-message-Bayes-optimality]
Modeling notes: Subtype modeling makes kernels M → ProbabilityMeasure M clean. The proof also uses M as a compact standard Borel space.

type-action-payoff-primitives

English name: Agent type, action, and payoff primitives
Informal type: Compact metric type space Θ, compact metric action space A, and bounded payoff u(a,ω,θ) continuous in action.
Suggested Lean modeling: fields inside robust-trust-model
Key fields / operations: type law conditional on state; action distributions Δ(A); expected payoff under private strategies.
Used by: [private-payoff-functional, payoff-profile-set-compact-convex, profile-realization-right-inverse]
Modeling notes: The source proof only assumes continuity in a, not in θ. Do not silently strengthen this.

private-strategy-space

English name: Private strategy space
Informal type: Measurable kernels or measurable maps hatσ : Θ → Δ(A) prescribing an action distribution for each private type.
Suggested Lean modeling: structure for measurable kernels
Key fields / operations: actKernel : Θ → ProbabilityMeasure A; measurability; integration against conditional type law.
Used by: [private-payoff-functional, payoff-profile-set-compact-convex, profile-realization-right-inverse, Bayes-optimality-belief-correspondence-Bm]
Modeling notes: The proof treats this as a compact standard Borel private-kernel space. That compactness/topology should be explicit, not inferred by magic dust.

agent-strategy-space

English name: Full agent strategy space
Informal type: Measurable strategies σ : M × Θ → Δ(A), equivalently message-indexed private strategies m ↦ hatσ(m).
Suggested Lean modeling: structure for measurable kernels from M × Θ to A, with derived private section
Key fields / operations: section : M → private-strategy-space; σ(da | m, θ); measurability in (m,θ).
Used by: [profile-payoff-decomposition, menu-value-equivalence, sigma-star-realization-and-optimality, robust-trust-theorem2-infinite-extension-v8]
Modeling notes: The menu engine formalization should mostly work through the profile map wσ : M → W, then realize it back into this space.

misaligned-adviser-kernel-space

English name: Misaligned adviser kernel space
Informal type: Borel kernels β : M → Δ(M) mapping the adviser’s true posterior s to a distribution over messages m.
Suggested Lean modeling: structure for Markov kernels
Key fields / operations: β(dm | s); deterministic kernel δ_{m(s)}; pushforward and product measure τ ⊗ β.
Used by: [definition2-q-ae-reading, profile-payoff-decomposition, adversary-infimum-pointwise, epsilon-adversary-realization, exact-adversary-attainment, no-free-dust]
Modeling notes: Do not impose absolute continuity with respect to τ. The proof explicitly allows β to place mass on τ-null Borel sets.

private-payoff-functional

English name: Private-strategy payoff at belief
Informal type: For hatσ and belief μ ∈ Δ(Ω), the expected payoff U(hatσ, μ) after integrating over states and private types.
Suggested Lean modeling: def
Key fields / operations: U_private : PrivateStrategy → Δ Ω → ℝ; Bayes-optimality predicate IsBayesOptimal hatσ μ.
Used by: [Bayes-optimality-belief-correspondence-Bm, robust-rationalizability-q-ae-predicate, per-message-Bayes-optimality]
Modeling notes: Keep separate from the full robust objective, since Definition 2 quantifies over private strategies after a message.

full-payoff-and-robust-value

English name: Full strategy payoff and robust value
Informal type: Payoff U(β,σ) against a specific misaligned kernel, robust payoff U(σ) = α U(id,σ) + (1-α) inf_β U(β,σ), and value U* = sup_σ U(σ).
Suggested Lean modeling: def
Key fields / operations: U_against : AdviserKernel → AgentStrategy → ℝ; U_robust : AgentStrategy → ℝ; U_star : ℝ; adversarial predicate IsAdversarial β σ.
Used by: [profile-payoff-decomposition, menu-value-equivalence, epsilon-adversary-realization, exact-adversary-attainment, robust-trust-theorem2-infinite-extension-v8]
Modeling notes: The proof’s menu engine replaces direct compactness of the full strategy space. Do not model U_star through a Sion minimax theorem.

mixture-message-law

English name: Mixture message marginal
Informal type: For a kernel β, the marginal distribution of observed messages under aligned truth-telling with probability α and misaligned reporting with probability 1-α.
Suggested Lean modeling: def
Key fields / operations:
q_β := α τ + (1-α) (τ ⊗ β)_2; domination q_β ≥ α τ; restriction to dust sets.
Used by: [definition2-q-ae-reading, per-message-Bayes-optimality, no-free-dust]
Modeling notes: This is the correct almost-everywhere measure for Definition 2 in the infinite setting.

posterior-disintegration

English name: Bayesian posterior after a message
Informal type: A regular conditional probability P_β(· | m) over Ω or equivalently the conditional barycenter of source posteriors given message m, defined q_β-almost everywhere.
Suggested Lean modeling: def using a disintegration theorem, likely stubbed theorem dependency
Key fields / operations: Pβ : M → Δ Ω; defined up to q_β-a.e.; posterior under γ_α; conditional source barycenter.
Used by: [definition2-q-ae-reading, menu-Hall-posterior-calibration-unpack, per-message-Bayes-optimality]
Modeling notes: Since Ω is finite, a posterior can be represented by coordinate-wise conditional expectations.

robust-rationalizability-q-ae-predicate

English name: Robust rationalizability, q-a.e. infinite-space reading
Informal type: A predicate on (σ,β) saying β is adversarial against σ and hatσ(m) is Bayes-optimal for P_β(·|m) for q_β-almost every message.
Suggested Lean modeling: def / Prop
Key fields / operations: IsAdversarial β σ; ∀ᵐ m ∂q_β, IsBayesOptimal (hatσ m) (Pβ m).
Used by: [definition2-q-ae-reading, per-message-Bayes-optimality, robust-trust-theorem2-infinite-extension-v8]
Modeling notes: This replaces literal ∀ m ∈ M in the infinite setting. In the finite case with α > 0, the readings coincide under full support.

payoff-profile-set-W

English name: Payoff-profile set
Informal type: The set W ⊆ ℝ^Ω of state-contingent payoff profiles implementable by some private strategy.
Suggested Lean modeling: def as a Set (Ω → ℝ) plus bundled compact convex subtype
Key fields / operations: w(ω) = E[u(a,ω,θ) | ω]; membership witness private strategy; convex combinations; compactness.
Used by: [payoff-profile-set-compact-convex, profile-realization-right-inverse, compact-menu-space, menu-functional-F, WTA-payoff-vertices-and-mixed-labels]
Modeling notes: This is the central geometry object. Most of the proof happens in W, not directly in strategy space.

agent-profile-map

English name: Agent strategy profile map
Informal type: For an agent strategy σ, the measurable map wσ : M → W assigning to each message its induced state-contingent payoff profile.
Suggested Lean modeling: def
Key fields / operations: wσ m : Ω → ℝ; measurability; s · wσ(m) equals expected payoff conditional on adviser posterior s and message m.
Used by: [profile-payoff-decomposition, adversary-infimum-pointwise, menu-value-equivalence]
Modeling notes: This object is the bridge from kernels to finite-dimensional menu geometry.

profile-realization-map

English name: Profile realization right inverse
Informal type: A Borel map R : W → PrivateStrategy selecting a private strategy that realizes each payoff profile w ∈ W.
Suggested Lean modeling: def plus theorem giving right-inverse property
Key fields / operations: Φ : PrivateStrategy → W; Φ(R(w)) = w; Borel measurability of R; induced strategy from Borel w : M → W.
Used by: [profile-realization-right-inverse, menu-value-equivalence, sigma-star-realization-and-optimality]
Modeling notes: This will likely be an INVENTORY.lean theorem stub, since it uses a measurable-selection theorem not usually packaged for this exact setting.

compact-menu-space

English name: Compact menu space
Informal type: 𝒦(W), the space of nonempty compact subsets of W, equipped with Hausdorff distance.
Suggested Lean modeling: subtype of compact nonempty sets, possibly reusing Mathlib compact-set/Hausdorff distance APIs
Key fields / operations: membership w ∈ C; Hausdorff distance d_H; compactness of 𝒦(W).
Used by: [menu-value-equivalence, compact-menu-space-compact, menu-extrema-Hausdorff-Lipschitz, optimal-menu-exists]
Modeling notes: Use nonempty compact sets only, since max/min over the menu are required.

menu-functional-F

English name: Menu value functional
Informal type: Functional on compact menus
F(C) = ∫_M [α max_{w∈C} s·w + (1-α) min_{w∈C} s·w] τ(ds).
Suggested Lean modeling: def
Key fields / operations: maxPayoff C s; minPayoff C s; integral over τ; continuity in Hausdorff distance.
Used by: [menu-value-equivalence, menu-functional-continuity, optimal-menu-exists, closure-pruning-value-preservation]
Modeling notes: Because Ω is finite and W compact, max/min are real-valued and attained.

optimal-menu-Cstar

English name: Optimal compact menu
Informal type: A maximizer C* ∈ 𝒦(W) of F.
Suggested Lean modeling: def chosen by existence theorem, or theorem existential witness
Key fields / operations: Cstar_nonempty_compact; ∀ C, F C ≤ F Cstar; F Cstar = U*.
Used by: [aligned-best-labeling-selection, closure-pruning-value-preservation, sigma-star-realization-and-optimality]
Modeling notes: In Lean, prefer existential statements unless a global choice object is acceptable under classical choice.

aligned-best-labeling-wstar

English name: Aligned-best labeling
Informal type: A Borel selector w* : M → C* satisfying w*(m) ∈ argmax_{w∈C*} m·w.
Suggested Lean modeling: def plus selection theorem
Key fields / operations: wstar m; argmax property; measurability.
Used by: [closure-pruning-value-preservation, sigma-star-realization-and-optimality, epsilon-contact-nonempty-Borel, exact-contact-assumption, menu-Hall-assumption]
Modeling notes: The source says single-valued τ-a.e. if unique, otherwise KRN selects. Formalize directly as a selected measurable maximizer.

pruned-menu-Cdagger

English name: Closure-pruned menu
Informal type: C† := closure (w*(M)), a compact subset of C*.
Suggested Lean modeling: def
Key fields / operations: subset C† ⊆ C*; closure/density property; max over C† agrees with selected aligned payoff; min over C† weakly higher than over C*.
Used by: [closure-pruning-value-preservation, epsilon-contact-nonempty-Borel, exact-adversary-attainment, menu-Hall-assumption]
Modeling notes: Since C† is a closure of the selected labels, it is the actual realized menu used by σ*.

rowwise-contact-correspondence-G

English name: Rowwise contact set
Informal type: For each source posterior s,
G(s) := {m ∈ M : s·w*(m) = min_{z∈C†} s·z}.
Suggested Lean modeling: def as a set-valued correspondence
Key fields / operations: membership predicate; rowwise minimizer support condition; measurable graph if needed.
Used by: [exact-contact-selector-unpack, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary, no-free-dust]
Modeling notes: Exact-contact assumes nonempty selector on τ-a.e. rows. Menu-Hall assumes a kernel supported on G(s).

epsilon-contact-correspondence-Geps

English name: ε-contact set
Informal type: For ε > 0,
Gε(s) := {m ∈ M : s·w*(m) ≤ min_{z∈C†} s·z + ε}.
Suggested Lean modeling: def
Key fields / operations: nonempty; Borel graph; selector mε(s); deterministic kernel δ_{mε(s)}.
Used by: [epsilon-contact-nonempty-Borel, epsilon-adversary-realization]
Modeling notes: The selector gives approximate adversaries without exact-contact.

exact-contact-assumption

English name: Exact-contact assumption
Informal type: A hypothesis that for τ-almost every s, G(s) is nonempty and admits a measurable selector m*(s) ∈ G(s).
Suggested Lean modeling: Prop
Key fields / operations: mstar : M → M; measurable; ∀ᵐ s ∂τ, mstar s ∈ G(s).
Used by: [exact-contact-selector-unpack, exact-adversary-attainment, robust-trust-theorem2-infinite-extension-v8]
Modeling notes: This is an added Tier 1b hypothesis, not part of standing assumptions.

exact-adversary-kernel

English name: Exact deterministic adversary
Informal type: Kernel β*(·|s) := δ_{m*(s)} induced by an exact-contact selector.
Suggested Lean modeling: def
Key fields / operations: deterministic Dirac kernel; exact rowwise minimization; adversarial attainment.
Used by: [exact-adversary-attainment, robust-trust-theorem2-infinite-extension-v8]
Modeling notes: In Tier 2, the exact adversary may instead be the menu-Hall kernel κ; do not force the deterministic selector and κ to coincide.

menu-Hall-assumption

English name: Menu-Hall calibration assumption
Informal type: There exists a Borel kernel κ(·|s) on M, supported on G(s) for τ-a.e. s, such that the posterior induced by the mixture coupling lies in the Bayes-optimality belief set B(m) for q-a.e. m.
Suggested Lean modeling: Prop with existential kernel
Key fields / operations: κ; support condition κ(G(s)|s)=1; coupling γ_α; marginal q; posterior condition P_{γ_α}(·|m) ∈ B(m).
Used by: [menu-Hall-support-implies-exact-adversary, menu-Hall-posterior-calibration-unpack, per-message-Bayes-optimality, robust-trust-theorem2-infinite-extension-v8]
Modeling notes: This is the Tier 2 extra hypothesis. It is set-valued and allows mixing over G(s).

mixture-coupling-gamma-alpha

English name: Mixture source-message coupling
Informal type:
γ_α := α (id,id)#τ + (1-α) τ ⊗ κ on M × M, with second marginal q := (γ_α)_2.
Suggested Lean modeling: def
Key fields / operations: first coordinate source posterior; second coordinate message; second marginal; disintegration posterior.
Used by: [menu-Hall-posterior-calibration-unpack, support-function-form-equivalence, per-message-Bayes-optimality]
Modeling notes: This object is the cleanest way to define the posterior in Tier 2.

Bayes-optimality-belief-correspondence-Bm

English name: Bayes-optimality belief correspondence
Informal type: For each message m,
B(m) := { μ ∈ Δ(Ω) : hatσ*(m) ∈ argmax_{hatσ'} U(hatσ', μ) }.
Suggested Lean modeling: def as set-valued map M → Set (Δ Ω)
Key fields / operations: membership as Bayes-optimality; support function h_{B(m)}; closed convex values if used in support-function equivalence.
Used by: [menu-Hall-assumption, menu-Hall-posterior-calibration-unpack, support-function-form-equivalence, per-message-Bayes-optimality]
Modeling notes: The proof uses membership only. The support-function form needs convexity and closedness.

support-function-Hall-form

English name: Support-function form of menu-Hall
Informal type: The inequality form: for every measurable E ⊆ M and continuous affine φ : Δ(Ω) → ℝ,
α ∫_E φ(m)dτ + (1-α) ∫_M φ(s) κ(E|s)dτ ≤ ∫_E h_{B(m)}(φ)dq.
Suggested Lean modeling: Prop plus equivalence theorem
Key fields / operations: support function; event quantification; affine test functions.
Used by: [support-function-form-equivalence]
Modeling notes: Since the positive proof uses posterior membership, this can be formalized later as an optional equivalent specification.

WTA-ternary-environment

English name: Winner-takes-all ternary sharpness environment
Informal type: Sharpness model with Ω = {0,1,2}, actions {a0,a1,a2}, payoff u(aω,ω)=1 and u(aω,ω')=-1 for ω'≠ω, prior (1/3,1/3,1/3), and atomless full-support τ on Δ(Ω).
Suggested Lean modeling: structure or specialized namespace constants
Key fields / operations: three coordinates; plurality action rule; atomlessness of τ.
Used by: [WTA-rowwise-minimizer-and-Bayes-cone-identification, cone-intersection, no-free-dust, halfspace-induces-full-vertex-menu]
Modeling notes: Keep this separate from the general model. It is a sharpness witness, not part of the positive theorem.

WTA-payoff-vertices-and-mixed-labels

English name: WTA vertex profiles and mixed labels
Informal type: Vertex payoff profiles v_i with v_i(i)=1 and v_i(k)=-1 for k≠i; mixed profile w_λ := Σ_{i∈I} λ_i v_i for a probability vector with support I.
Suggested Lean modeling: def
Key fields / operations: v : Fin 3 → (Fin 3 → ℝ); wλ; support I; identity s·wλ = 2 Σ_i λ_i s_i - 1.
Used by: [WTA-rowwise-minimizer-and-Bayes-cone-identification, cone-intersection, no-free-dust]
Modeling notes: Coordinates over Fin 3 will make the cone proof short and exact.

WTA-cones-Kminus-and-B

English name: WTA rowwise-minimizer and Bayes-optimality cones
Informal type: For nonempty I ⊆ {0,1,2},
K_I^- := {s : s_i ≤ s_k for all i∈I, k} and
B_I := {p : p_i ≥ p_k for all i∈I, k}.
Suggested Lean modeling: def
Key fields / operations: membership predicates; nonempty support index; cone conditions.
Used by: [WTA-rowwise-minimizer-and-Bayes-cone-identification, cone-intersection, dust-rowwise-support-and-calibration-to-cones, no-free-dust]
Modeling notes: These are polyhedral subsets of the simplex, so finite quantification over indices suffices.

null-dust-data

English name: Null-message dust data
Informal type: A Borel set N ⊆ M with τ(N)=0, a Borel dust labeling w_N : N → W, and a label-support map I(m) encoded by w_N(m)=w_{λ(m)}.
Suggested Lean modeling: structure
Key fields / operations: N; N_borel; τ N = 0; wN; λ(m); I(m)=support λ(m); measurability.
Used by: [dust-disintegration, dust-rowwise-support-and-calibration-to-cones, no-free-dust]
Modeling notes: The proof needs enough measurability of I(m) or a finite partition by possible support sets.

adversarial-flow-disintegration-data

English name: Adversarial flow and dust disintegration
Informal type: Measure ν(ds,dm)=τ(ds)κ(dm|s), restricted dust measure ν_N, dust marginal q_N=(ν_N)_2, and conditional source laws ρ_m over Δ(Ω).
Suggested Lean modeling: structure plus disintegration theorem
Key fields / operations: ν; ν_N; q_N; ρ_m; barycenter bar_s(m); equation ν_N(A×E)=∫_E ρ_m(A) q_N(dm).
Used by: [dust-disintegration, dust-rowwise-support-and-calibration-to-cones, no-free-dust]
Modeling notes: This is the measure-theoretic core of no-free-dust.

halfspace-witness-trust-region

English name: Halfspace trust-region witness
Informal type: The set T := { μ ∈ Δ(Ω) : μ(0) ≤ 0.4 } in the WTA ternary environment.
Suggested Lean modeling: def
Key fields / operations: membership predicate; example beliefs (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8); plurality labels.
Used by: [halfspace-induces-full-vertex-menu, witness-menu-engine-classification]
Modeling notes: The proof classifies this witness as representational scenery, not a primitive obstruction.

effective-menu-equivalence-data

English name: Effective menu equivalence data
Informal type: Data showing that the halfspace trust region induces the full vertex menu {v0,v1,v2} and behaves like T = Δ(Ω) under WTA plurality continuation.
Suggested Lean modeling: def or theorem-local construction
Key fields / operations: full vertex menu; plurality map; off-T projection collapse; behavioral equivalence relation.
Used by: [halfspace-induces-full-vertex-menu, witness-menu-engine-classification]
Modeling notes: This is more semantic than the positive tiers. It may be easier to state as a theorem rather than a reusable object.

Main Theorem

Slug: robust-trust-theorem2-infinite-extension-v8
Statement (English, precise):
Under the standing Robust Trust hypotheses, without assuming M or Θ finite, the following theorem package holds.

Tier 1a: There exists an agent strategy σ* ∈ Σ such that U(σ*) = U*. Moreover, for every ε > 0, there exists a Borel misaligned-adviser kernel βε ∈ B such that U(βε, σ*) ≤ U* + ε.

Tier 1b: If exact-contact holds for the optimal menu labeling used to construct σ*, then there exists an exact adversarial kernel β* ∈ B such that
U(β*, σ*) = inf_{β∈B} U(β, σ*) = U*.

Tier 2: If exact-contact and menu-Hall hold, then (σ*,β*) can be chosen so that, when α > 0,
hatσ*(m) ∈ argmax_{hatσ'} U(hatσ', P_{β*}(·|m)) for q-almost every m, where q is the mixture message marginal induced by the aligned identity rule and the chosen adversarial kernel. Since q ≥ α τ, this also holds τ-almost everywhere.

Sharpness package: In the WTA ternary environment, the cone intersection lemma holds for every nonempty support I ⊆ {0,1,2}; under atomless τ, no τ-null dust set with a Borel labeling and adversarial kernel supported on rowwise minimizers can both receive positive mixture message mass and satisfy Bayes-cone calibration. The halfspace witness T={μ: μ(0)≤0.4} is a menu-engine artefact: it induces the full vertex menu and is behaviorally equivalent to T=Δ(Ω), so it is not a primitive counterexample to unrestricted Theorem 2.

Type signature (informal):
For every model : RobustTrustModel, produce an existence theorem for σ* and ε-adversaries. Given additionally ExactContact model C* w*, produce exact adversary attainment. Given additionally MenuHall model C† w*, produce robust rationalizability in the q-a.e. sense for α > 0. Separately, for WTA_Ternary_Model with atomless τ, prove cone-intersection and no-free-dust obstruction and classify the halfspace witness.

Depends on (objects): [robust-trust-model, finite-state-and-belief-simplex, prior-and-adviser-posterior-law, message-support-M, type-action-payoff-primitives, private-strategy-space, agent-strategy-space, misaligned-adviser-kernel-space, full-payoff-and-robust-value, mixture-message-law, posterior-disintegration, robust-rationalizability-q-ae-predicate, payoff-profile-set-W, profile-realization-map, compact-menu-space, menu-functional-F, optimal-menu-Cstar, aligned-best-labeling-wstar, pruned-menu-Cdagger, rowwise-contact-correspondence-G, exact-contact-assumption, menu-Hall-assumption, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm, WTA-ternary-environment, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B, null-dust-data, adversarial-flow-disintegration-data, halfspace-witness-trust-region, effective-menu-equivalence-data]
Depends on (lemmas): [definition2-q-ae-reading, payoff-profile-set-compact-convex, profile-realization-right-inverse, profile-payoff-decomposition, adversary-infimum-pointwise, menu-value-equivalence, compact-menu-space-compact, menu-extrema-Hausdorff-Lipschitz, menu-functional-continuity, optimal-menu-exists, aligned-best-labeling-selection, closure-pruning-value-preservation, sigma-star-realization-and-optimality, epsilon-contact-nonempty-Borel, epsilon-adversary-realization, exact-contact-selector-unpack, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary, menu-Hall-posterior-calibration-unpack, support-function-form-equivalence, per-message-Bayes-optimality, WTA-rowwise-minimizer-and-Bayes-cone-identification, cone-intersection, dust-disintegration, dust-rowwise-support-and-calibration-to-cones, no-free-dust, sharpness-corollary, halfspace-induces-full-vertex-menu, witness-menu-engine-classification]
Depends on (external): [finite-dimensional-simplex-compactness, measurable-maximum-and-argmax-selection, krn-borel-right-inverse, fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection, hyperspace-blaschke-compactness, hausdorff-support-function-lipschitz, weierstrass-extreme-value, jankov-von-neumann-selection, standard-borel-disintegration, bayes-posterior-as-conditional-barycenter, support-function-separation, nonnegative-integral-zero, atomless-singleton-null]

Lemmas
definition2-q-ae-reading

Statement: In the infinite-message setting, the phrase “for all m ∈ M” in Definition 2 is interpreted as “for q_β-almost every m,” where
q_β = α τ + (1-α)(τ ⊗ β)_2 is the actual mixture message marginal. The posterior P_β(·|m) is defined only q_β-almost everywhere. If α > 0, then q_β ≥ α τ, so any q_β-a.e. Bayes-optimality statement implies the corresponding τ-a.e. statement.
Type signature: For a model and kernel β, define q_β; prove the a.e. interpretation predicate and domination implication AE q_β P → AE τ P under α>0.
Depends on (objects): [mixture-message-law, posterior-disintegration, robust-rationalizability-q-ae-predicate]
Depends on (lemmas): []
Depends on (external): [standard-borel-disintegration]
Notes: This is a semantics lemma, not a new economic assumption.

payoff-profile-set-compact-convex

Statement: The set W of payoff profiles implementable by private strategies is a compact convex subset of ℝ^Ω.
Type signature: Given the standing model, IsCompact W ∧ Convex W.
Depends on (objects): [robust-trust-model, finite-state-and-belief-simplex, type-action-payoff-primitives, private-strategy-space, payoff-profile-set-W]
Depends on (lemmas): []
Depends on (external): [finite-dimensional-simplex-compactness, measurable-maximum-and-argmax-selection, weierstrass-extreme-value]
Notes: Convexity is by randomized private strategies. Compactness is imported from the paper’s Theorem 1/Appendix A.1 profile geometry.

profile-realization-right-inverse

Statement: Let Φ : PrivateStrategy → W map a private strategy to its payoff profile. The map Φ admits a Borel right inverse R : W → PrivateStrategy; hence every Borel map w : M → W is implementable by an agent strategy σ(da|m,θ)=R(w(m))(da|θ).
Type signature: ∃ R, Measurable R ∧ ∀ w∈W, Φ(R w)=w, and for every Borel wMap : M → W, ∃ σ, profileMap σ = wMap.
Depends on (objects): [private-strategy-space, payoff-profile-set-W, profile-realization-map, agent-strategy-space]
Depends on (lemmas): [payoff-profile-set-compact-convex]
Depends on (external): [krn-borel-right-inverse]
Notes: This is the main implementation bridge from menu geometry back to strategies.

profile-payoff-decomposition

Statement: For any agent strategy σ with profile map wσ, the expected payoff conditional on adviser posterior s and received message m is s · wσ(m). The aligned component equals ∫_M s·wσ(s) τ(ds). The misaligned component against a kernel β equals ∫_M ∫_M s·wσ(m) β(dm|s) τ(ds).
Type signature: For σ, define wσ; prove the aligned and misaligned payoff identities.
Depends on (objects): [agent-strategy-space, misaligned-adviser-kernel-space, agent-profile-map, full-payoff-and-robust-value]
Depends on (lemmas): []
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: Conditional independence of s and θ given ω is used here to make s·w the correct conditional payoff.

adversary-infimum-pointwise

Statement: For any measurable profile map w : M → W,
inf_β ∫_M∫_M s·w(m) β(dm|s) τ(ds) = ∫_M inf_{m∈M} s·w(m) τ(ds).
Equivalently, the adversary’s minimization collapses row by row.
Type signature: For bounded measurable g(s,m)=s·w(m), the infimum over Markov kernels from M to M equals the integral of pointwise infima over messages.
Depends on (objects): [misaligned-adviser-kernel-space, agent-profile-map, message-support-M]
Depends on (lemmas): [profile-payoff-decomposition]
Depends on (external): [fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection]
Notes: Exact rowwise minimizers need not exist. The equality can be shown using ε-selectors.

menu-value-equivalence

Statement: The robust value equals the supremum of the menu functional over nonempty compact menus:
U* = sup_{C∈𝒦(W)} F(C).
Type signature: U_star model = sSup {F C | C : 𝒦(W)}.
Depends on (objects): [full-payoff-and-robust-value, payoff-profile-set-W, compact-menu-space, menu-functional-F, profile-realization-map]
Depends on (lemmas): [profile-realization-right-inverse, profile-payoff-decomposition, adversary-infimum-pointwise]
Depends on (external): [measurable-maximum-and-argmax-selection]
Notes: One direction sends a strategy to the closure of its profile image. The other direction selects an aligned-best label from a compact menu and realizes it by R.

compact-menu-space-compact

Statement: If W is compact metric, then 𝒦(W), the space of nonempty compact subsets of W, is compact metrizable under Hausdorff distance.
Type signature: CompactSpace (NonemptyCompactSubsets W with HausdorffMetric).
Depends on (objects): [payoff-profile-set-W, compact-menu-space]
Depends on (lemmas): [payoff-profile-set-compact-convex]
Depends on (external): [hyperspace-blaschke-compactness]
Notes: This is the compactness engine replacing Sion/Tychonoff strategy-space compactness.

menu-extrema-Hausdorff-Lipschitz

Statement: For each s ∈ M, the maps
C ↦ max_{w∈C} s·w and C ↦ min_{w∈C} s·w are Lipschitz in Hausdorff distance, uniformly in s up to the finite-dimensional norm bound on beliefs.
Type signature: For C,D ∈ 𝒦(W),
|max_C s·w - max_D s·w| ≤ L d_H(C,D) and similarly for minima.
Depends on (objects): [finite-state-and-belief-simplex, compact-menu-space, menu-functional-F]
Depends on (lemmas): []
Depends on (external): [hausdorff-support-function-lipschitz]
Notes: The source says “1-Lipschitz”; the Lean constant depends on the chosen norm and embedding.

menu-functional-continuity

Statement: The menu functional F : 𝒦(W) → ℝ is continuous in Hausdorff distance.
Type signature: Continuous F.
Depends on (objects): [menu-functional-F, compact-menu-space]
Depends on (lemmas): [menu-extrema-Hausdorff-Lipschitz]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: Boundedness gives integrability, and the Lipschitz bound permits direct continuity of the integral.

optimal-menu-exists

Statement: The supremum of F over 𝒦(W) is attained by some compact menu C*.
Type signature: ∃ Cstar : 𝒦(W), ∀ C : 𝒦(W), F C ≤ F Cstar.
Depends on (objects): [compact-menu-space, menu-functional-F, optimal-menu-Cstar]
Depends on (lemmas): [compact-menu-space-compact, menu-functional-continuity]
Depends on (external): [weierstrass-extreme-value]
Notes: This delivers the menu optimizer for Tier 1a.

aligned-best-labeling-selection

Statement: For an optimal menu C*, there exists a Borel map w* : M → C* such that w*(m) ∈ argmax_{w∈C*} m·w for every m where the selector is defined, with equality m·w*(m)=max_{w∈C*}m·w.
Type signature: ∃ wstar, Measurable wstar ∧ ∀ m, wstar m ∈ Cstar ∧ IsArgMax (fun w => m·w) Cstar (wstar m).
Depends on (objects): [optimal-menu-Cstar, aligned-best-labeling-wstar, message-support-M]
Depends on (lemmas): [optimal-menu-exists]
Depends on (external): [measurable-maximum-and-argmax-selection]
Notes: If uniqueness fails, the proof uses a measurable selector.

closure-pruning-value-preservation

Statement: Let C† := closure(w*(M)). Then C† ⊆ C* and
F(C†) = F(C*) = U*.
Type signature: For selected w*, define Cdagger; prove subset and value equality.
Depends on (objects): [aligned-best-labeling-wstar, pruned-menu-Cdagger, menu-functional-F, optimal-menu-Cstar]
Depends on (lemmas): [menu-value-equivalence, optimal-menu-exists, aligned-best-labeling-selection]
Depends on (external): [weierstrass-extreme-value]
Notes: Aligned payoff is unchanged. Misaligned payoff weakly rises because C†⊆C*; optimality forces equality.

sigma-star-realization-and-optimality

Statement: The selected labeling w* : M → C† is realized by an agent strategy σ*, and this strategy attains the robust value: U(σ*) = U*.
Type signature: ∃ σstar, profileMap σstar = wstar ∧ U_robust σstar = U_star.
Depends on (objects): [agent-strategy-space, profile-realization-map, aligned-best-labeling-wstar, pruned-menu-Cdagger, full-payoff-and-robust-value]
Depends on (lemmas): [profile-realization-right-inverse, menu-value-equivalence, closure-pruning-value-preservation]
Depends on (external): []
Notes: This is the Tier 1a existence half before ε-adversaries.

epsilon-contact-nonempty-Borel

Statement: For every ε > 0 and every s, the set
Gε(s) = {m : s·w*(m) ≤ min_{z∈C†} s·z + ε} is nonempty and has a Borel measurable graph; hence it admits a Borel selector mε(s) ∈ Gε(s).
Type signature: ε>0 → ∃ m_eps, Measurable m_eps ∧ ∀ s, m_eps s ∈ G_eps s.
Depends on (objects): [epsilon-contact-correspondence-Geps, aligned-best-labeling-wstar, pruned-menu-Cdagger]
Depends on (lemmas): [closure-pruning-value-preservation]
Depends on (external): [jankov-von-neumann-selection]
Notes: Nonemptiness uses density of w*(M) in C† and continuity of m ↦ s·w*(m) through the selected profile values.

epsilon-adversary-realization

Statement: For every ε > 0, the deterministic kernel βε(·|s)=δ_{mε(s)} satisfies
U(βε,σ*) ≤ U* + (1-α)ε ≤ U* + ε.
Type signature: ε>0 → ∃ beta_eps : AdviserKernel, U_against beta_eps sigma_star ≤ U_star + ε.
Depends on (objects): [epsilon-contact-correspondence-Geps, misaligned-adviser-kernel-space, full-payoff-and-robust-value]
Depends on (lemmas): [sigma-star-realization-and-optimality, epsilon-contact-nonempty-Borel]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: This completes Tier 1a.

exact-contact-selector-unpack

Statement: Under exact-contact, there exists a Borel selector m* : M → M such that m*(s) ∈ G(s) for τ-almost every s.
Type signature: ExactContact Cdagger wstar → ∃ mstar, Measurable mstar ∧ ∀ᵐ s ∂τ, mstar s ∈ G s.
Depends on (objects): [exact-contact-assumption, rowwise-contact-correspondence-G]
Depends on (lemmas): []
Depends on (external): []
Notes: This is just the formal unpacking of the Tier 1b assumption.

exact-adversary-attainment

Statement: Under exact-contact, the deterministic kernel β*(·|s)=δ_{m*(s)} is adversarial against σ* and satisfies
U(β*,σ*) = inf_{β∈B} U(β,σ*) = U*.
Type signature: ExactContact → ∃ betastar, IsAdversarial betastar sigma_star ∧ U_against betastar sigma_star = U_star.
Depends on (objects): [exact-contact-assumption, exact-adversary-kernel, rowwise-contact-correspondence-G, full-payoff-and-robust-value]
Depends on (lemmas): [sigma-star-realization-and-optimality, exact-contact-selector-unpack, closure-pruning-value-preservation]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: The equality inf_m s·w*(m)=min_{z∈C†}s·z is used rowwise.

menu-Hall-support-implies-exact-adversary

Statement: If a kernel κ is supported on G(s) for τ-almost every s, then using κ as the misaligned-adviser kernel attains the same rowwise minimum as the exact-contact selector; hence it is an exact adversary for σ*.
Type signature: KernelSupportedOnG κ → IsAdversarial κ sigma_star ∧ U_against κ sigma_star = U_star.
Depends on (objects): [menu-Hall-assumption, rowwise-contact-correspondence-G, mixture-coupling-gamma-alpha, full-payoff-and-robust-value]
Depends on (lemmas): [sigma-star-realization-and-optimality, closure-pruning-value-preservation]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: This explains how the Tier 2 kernel is adversarial even if it is not deterministic.

menu-Hall-posterior-calibration-unpack

Statement: Under menu-Hall, the disintegration posterior induced by γ_α satisfies
P_{γ_α}(·|m) ∈ B(m) for q-almost every m, where q=(γ_α)_2.
Type signature: MenuHall κ → ∀ᵐ m ∂q, P_gamma m ∈ Bm m.
Depends on (objects): [menu-Hall-assumption, mixture-coupling-gamma-alpha, posterior-disintegration, Bayes-optimality-belief-correspondence-Bm]
Depends on (lemmas): []
Depends on (external): [standard-borel-disintegration]
Notes: This is the calibration half of menu-Hall, separated from the support-on-G half.

support-function-form-equivalence

Statement: The posterior-calibration condition P_{γ_α}(·|m) ∈ B(m) for q-almost every m is equivalent to the stated support-function inequalities over all measurable events E⊆M and continuous affine functions φ : Δ(Ω) → ℝ.
Type signature: PosteriorCalibration γ B q ↔ SupportFunctionHallInequalities γ B q.
Depends on (objects): [support-function-Hall-form, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm]
Depends on (lemmas): [menu-Hall-posterior-calibration-unpack]
Depends on (external): [support-function-separation, bayes-posterior-as-conditional-barycenter]
Notes: The main proof can use the posterior form directly. This lemma is needed only if downstream Lean wants to formalize the alternative support-function statement.

per-message-Bayes-optimality

Statement: Under menu-Hall, hatσ*(m) is Bayes-optimal under the posterior P_{γ_α}(·|m) for q-almost every m. If α>0, the same holds τ-almost everywhere.
Type signature: MenuHall → (∀ᵐ m ∂q, IsBayesOptimal (hatσstar m) (P_gamma m)) ∧ (α>0 → ∀ᵐ m ∂τ, IsBayesOptimal ...).
Depends on (objects): [robust-rationalizability-q-ae-predicate, Bayes-optimality-belief-correspondence-Bm, mixture-message-law, posterior-disintegration]
Depends on (lemmas): [definition2-q-ae-reading, menu-Hall-posterior-calibration-unpack]
Depends on (external): []
Notes: This is the Tier 2 Definition 2 condition.

WTA-rowwise-minimizer-and-Bayes-cone-identification

Statement: In the WTA ternary environment, for a mixed profile w_λ with support I,
s·w_λ = 2 Σ_{i∈I} λ_i s_i - 1. Therefore rowwise minimizer sources for label support I lie in K_I^-, and beliefs under which w_λ is Bayes-optimal lie in B_I.
Type signature: For nonempty I and supported λ, prove the dot-product identity and the two cone characterizations.
Depends on (objects): [WTA-ternary-environment, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B]
Depends on (lemmas): []
Depends on (external): [finite-dimensional-simplex-compactness]
Notes: This is finite coordinate algebra over Fin 3.

cone-intersection

Statement: For every nonempty I⊆{0,1,2}, if ρ is a Borel probability measure on Δ(Ω) with ρ(K_I^-)=1 and barycenter bar s ∈ B_I, then ρ = δ_{μ0} where μ0=(1/3,1/3,1/3).
Type signature: I.Nonempty → ρ(Kminus I)=1 → barycenter ρ ∈ Bcone I → ρ = dirac mu0.
Depends on (objects): [WTA-ternary-environment, WTA-cones-Kminus-and-B]
Depends on (lemmas): [WTA-rowwise-minimizer-and-Bayes-cone-identification]
Depends on (external): [nonnegative-integral-zero, atomless-singleton-null]
Notes: Proof fixes i∈I; nonnegative variables s_k-s_i have nonpositive expectation, so they vanish a.e.; coordinates sum to one.

dust-disintegration

Statement: For the measure ν(ds,dm)=τ(ds)κ(dm|s) and dust restriction ν_N, there exists a disintegration over its second marginal q_N, namely Borel kernels ρ_m such that
ν_N(A×E)=∫_E ρ_m(A) q_N(dm) for Borel A,E.
Type signature: For standard Borel ΔΩ × M, finite measure ν_N, produce q_N and conditional kernel ρ.
Depends on (objects): [null-dust-data, adversarial-flow-disintegration-data]
Depends on (lemmas): []
Depends on (external): [standard-borel-disintegration]
Notes: This is the key measure decomposition for no-free-dust.

dust-rowwise-support-and-calibration-to-cones

Statement: If κ is supported on rowwise minimizers and dust labels have support I(m), then ρ_m(K_{I(m)}^-)=1 for q_N-almost every m. If Bayes-cone calibration holds, the barycenter of ρ_m lies in B_{I(m)} for q_N-almost every m.
Type signature: RowwiseSupport κ wN → BayesConeCalibration → ∀ᵐ m ∂q_N, ρ_m(Kminus (I m))=1 ∧ barycenter(ρ_m)∈Bcone(I m).
Depends on (objects): [null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]
Depends on (lemmas): [dust-disintegration, WTA-rowwise-minimizer-and-Bayes-cone-identification]
Depends on (external): [bayes-posterior-as-conditional-barycenter]
Notes: This lemma converts the economic calibration condition into the hypotheses of cone-intersection.

no-free-dust

Statement: Under atomless τ in the WTA ternary environment, no Borel τ-null set N, no Borel labeling w_N : N → W, and no adversarial kernel κ supported on rowwise minimizers can simultaneously satisfy:
(a) q_β(N)>0;
(b) Bayes-cone calibration at q_N-almost every m∈N.
Type signature: Atomless τ → ¬ ∃ N wN κ, TauNull N ∧ PositiveQMass N κ ∧ RowwiseSupport κ wN ∧ BayesConeCalibration N wN κ.
Depends on (objects): [WTA-ternary-environment, null-dust-data, adversarial-flow-disintegration-data, mixture-message-law]
Depends on (lemmas): [cone-intersection, dust-disintegration, dust-rowwise-support-and-calibration-to-cones]
Depends on (external): [standard-borel-disintegration, atomless-singleton-null]
Notes: Cone-intersection gives ρ_m=δ_{μ0} on dust. Then ν({μ0}×N)=q_N(N)>0, contradicting the first marginal τ and atomlessness.

sharpness-corollary

Statement: Taking I={0} in cone-intersection recovers the pointwise v7 obstruction at t0=(0.4,0.3,0.3). Together with no-free-dust, no null-message dust construction can repair the obstruction; menu-Hall is genuinely required inside this menu geometry.
Type signature: Specialized consequence of cone-intersection and no-free-dust for singleton support {0}.
Depends on (objects): [WTA-ternary-environment, WTA-cones-Kminus-and-B]
Depends on (lemmas): [cone-intersection, no-free-dust]
Depends on (external): []
Notes: This is a sharpness result for the menu engine, not a primitive counterexample.

halfspace-induces-full-vertex-menu

Statement: In the WTA ternary environment, the halfspace trust region T={μ: μ(0)≤0.4} contains beliefs whose plurality labels are respectively a0, a1, and a2; hence any plurality-vertex continuation on T induces the full vertex menu {v0,v1,v2}. Off-T projection over this full vertex menu collapses to ordinary plurality.
Type signature: Define T; prove existence of the three labeled beliefs in T; prove induced effective menu equals full vertex menu and the projection behavior agrees with T=ΔΩ.
Depends on (objects): [WTA-ternary-environment, halfspace-witness-trust-region, effective-menu-equivalence-data, WTA-payoff-vertices-and-mixed-labels]
Depends on (lemmas): [WTA-rowwise-minimizer-and-Bayes-cone-identification]
Depends on (external): [finite-dimensional-simplex-compactness]
Notes: Finite coordinate checking: (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8).

witness-menu-engine-classification

Statement: The halfspace witness is a menu-engine artefact. It demonstrates that menu-Hall is needed inside the F-functional menu optimization, but it does not falsify unrestricted Theorem 2 because the halfspace trust region is behaviorally equivalent to the full-simplex trust region in the WTA model.
Type signature: From full-vertex-menu equivalence and sharpness, derive the classification statement: MenuEngineArtefact T ∧ ¬ PrimitiveCounterexampleCertified T.
Depends on (objects): [halfspace-witness-trust-region, effective-menu-equivalence-data]
Depends on (lemmas): [sharpness-corollary, halfspace-induces-full-vertex-menu]
Depends on (external): []
Notes: This is a conceptual classification theorem. In Lean, it may be represented as two precise propositions rather than a prose label.

External Results Invoked
finite-dimensional-simplex-compactness

English name: Compact convex geometry of a finite-dimensional probability simplex
Statement used: For finite Ω, Δ(Ω) is a compact convex subset of Euclidean space; continuous affine functions attain maxima and minima on compact subsets.
Classification: MATHLIB_CANDIDATE
Why this classification: Mathlib has finite-dimensional topology, convexity, compactness, and probability-vector APIs, though glue lemmas may be needed.

measurable-maximum-and-argmax-selection

English name: Measurable maximum theorem and measurable argmax selection
Statement used: A measurable compact-valued correspondence with continuous objective admits a measurable selector from the argmax correspondence.
Classification: NON_MATHLIB
Why this classification: This is a descriptive-set/measurable-selection theorem in the Aliprantis-Border ecosystem, not usually available as a ready Mathlib theorem.

krn-borel-right-inverse

English name: Kuratowski-Ryll-Nardzewski Borel right inverse theorem
Statement used: A continuous map from a compact standard-Borel private-kernel space onto W, with compact nonempty fibers, admits a Borel right inverse.
Classification: NON_MATHLIB
Why this classification: Specialist measurable-selection theorem, cited as Aliprantis-Border 18.13 in the source.

fubini-tonelli-kernel-integrals

English name: Fubini/Tonelli and kernel integration identities
Statement used: Iterated integration against τ(ds)β(dm|s) is valid, and expected payoffs can be rearranged over finite states, types, actions, messages, and kernels.
Classification: MATHLIB_CANDIDATE
Why this classification: Mathlib has substantial measure and kernel integration infrastructure, even if some Markov-kernel wrappers may need local lemmas.

kernel-infimum-epsilon-selection

English name: Rowwise infimum over Markov kernels via ε-selectors
Statement used: The infimum over all measurable kernels of ∫∫ g(s,m)β(dm|s)τ(ds) equals ∫ inf_m g(s,m)τ(ds) for bounded measurable g, using measurable ε-minimizing selectors.
Classification: NON_MATHLIB
Why this classification: It combines measurable selection with kernel optimization and is unlikely to exist in Mathlib as a packaged theorem.

hyperspace-blaschke-compactness

English name: Blaschke compactness theorem for nonempty compact subsets
Statement used: The hyperspace of nonempty compact subsets of a compact metric space is compact under Hausdorff distance.
Classification: MATHLIB_CANDIDATE
Why this classification: This is general topology/metric geometry and plausible in or near Mathlib’s compact-set and Hausdorff-distance libraries.

hausdorff-support-function-lipschitz

English name: Hausdorff Lipschitz continuity of support functions
Statement used: For a bounded linear functional, max and min over compact sets vary Lipschitz-continuously with Hausdorff distance.
Classification: MATHLIB_CANDIDATE
Why this classification: This is elementary metric/linear analysis over finite-dimensional spaces and should be formalizable from Mathlib primitives.

weierstrass-extreme-value

English name: Extreme value theorem on compact spaces
Statement used: A continuous real-valued function on a compact space attains its maximum and minimum.
Classification: MATHLIB_CANDIDATE
Why this classification: Standard Mathlib theorem.

jankov-von-neumann-selection

English name: Jankov-von Neumann measurable selection theorem
Statement used: A Borel set with nonempty vertical sections in standard Borel spaces admits a universally/Borel measurable selector sufficient for constructing mε(s).
Classification: NON_MATHLIB
Why this classification: Specialist descriptive-set-theoretic selection theorem, not expected to be directly available in Mathlib.

standard-borel-disintegration

English name: Disintegration theorem for standard Borel spaces
Statement used: A finite measure on a product of standard Borel spaces admits regular conditional probabilities over either marginal, used for posteriors and dust conditional source laws ρ_m.
Classification: NON_MATHLIB
Why this classification: Mathlib has measure theory, but full standard-Borel disintegration is specialist and typically stubbed in formal projects.

bayes-posterior-as-conditional-barycenter

English name: Bayesian posterior as conditional barycenter
Statement used: For finite Ω, the posterior over states after message m equals the barycenter of the conditional distribution of source posteriors given m.
Classification: MATHLIB_CANDIDATE
Why this classification: Once disintegration exists, this is finite-dimensional conditional expectation algebra.

support-function-separation

English name: Support-function characterization of closed convex membership
Statement used: A point lies in a closed convex set iff every continuous affine functional is bounded above by that set’s support function; integrated versions yield the menu-Hall support-function form.
Classification: MATHLIB_CANDIDATE
Why this classification: Separation theorems and support functions for finite-dimensional convex sets are within Mathlib’s plausible geometry library.

nonnegative-integral-zero

English name: Nonnegative function with zero or nonpositive expectation vanishes a.e.
Statement used: If X ≥ 0 a.e. and ∫ X dρ ≤ 0, then X=0 a.e.
Classification: MATHLIB_CANDIDATE
Why this classification: Standard measure-theory lemma.

atomless-singleton-null

English name: Atomless measures assign zero mass to singletons
Statement used: Under atomless τ, τ({μ0})=0; this contradicts positive mass forced by dust calibration.
Classification: MATHLIB_CANDIDATE
Why this classification: Standard measure-theory result.

Implicit Assumptions Surfaced

M = supp τ is treated as a compact standard Borel subset of Δ(Ω), not merely as an arbitrary measurable support.

α lies in [0,1]; the implication from q-a.e. to τ-a.e. in Tier 2 requires α>0.

In the no-free-dust proof, the step from qβ(N)>0 and τ(N)=0 to q_N(N)>0 requires α<1; when α=1, condition (a) is impossible because qβ=τ.

All strategy and kernel objects are Borel measurable, and all payoff integrands are measurable and integrable.

The private-kernel space hatΣ is assumed to carry a compact standard-Borel topology for which the profile map Φ is continuous with compact fibers.

Compactness of W and the profile-realization right inverse are imported as standard profile-realization facts; they are not derived from scratch in the v8 proof.

The aligned-best selector w* is a fixed Borel representative; changes on null sets may change C†=closure(w*(M)), so the representative must be chosen before defining C†.

The equality inf_{m∈M} s·w*(m) = min_{z∈C†} s·z uses density of w*(M) in C† and continuity of the dot product.

The graphs of G(s) and Gε(s) are treated as Borel or analytically selectable; this must be an explicit theorem or hypothesis in Lean.

Misaligned kernels are not assumed absolutely continuous with respect to τ; they may send positive mass to τ-null message sets.

Regular conditional posteriors are only defined up to the relevant message marginal, so all posterior statements must be phrased almost everywhere.

The Bayes-optimality correspondence B(m) must have enough measurability and closed-convex structure for the support-function form of menu-Hall.

In the WTA dust theorem, the dust label w_N(m)=w_{λ(m)} requires a measurable encoding of λ(m) and its support I(m), or equivalently a measurable finite partition by supports.

Atomlessness of τ in the sharpness theorem includes τ({μ0})=0.

Tier 1b’s deterministic exact adversary and Tier 2’s menu-Hall kernel are both exact adversaries, but they need not be the same kernel.

The statement “menu-Hall is strictly milder than deterministic TRE-gen-Hall” is a comparison claim, not used as a proof dependency for the positive tiers.

Decomposition Notes

The DAG splits the proof into three layers.

First, the menu engine: define W, realize Borel profile maps, prove menu-value equivalence, compactness of 𝒦(W), continuity of F, and existence of an optimal menu. This is the main escape hatch from infinite-dimensional minimax compactness.

Second, the adversary layer: closure-prune the optimal menu, realize σ*, build ε-adversaries unconditionally, then add exact-contact for exact deterministic attainment. Menu-Hall adds a possibly mixed kernel supported on the same rowwise minimizer sets and supplies posterior calibration.

Third, the sharpness layer: specialize to WTA ternary, identify the relevant cones, prove cone intersection, disintegrate the dust flow, and derive no-free-dust. The final witness-classification lemma should likely be formalized as precise behavioral equivalence of induced menus rather than as prose about artefacts.

The support-function version of menu-Hall is structurally optional for proving Tier 2 from the posterior-membership form. It is included because the source states it as an equivalent formulation, and downstream roles may want the dual form for later transport/Hall work.

No unrestricted infinite Theorem 2 is encoded here. The Lean structure should reflect the v8 theorem exactly: Tier 1a unconditional, Tier 1b under exact-contact, Tier 2 under exact-contact plus menu-Hall, with sharpness showing that menu-Hall is not removable inside the menu engine.

## English source proof (v8) — ground truth

# Robust Trust Theorem 2 — infinite-$M$, $\Theta$ extension via the payoff-profile menu engine (v8, three-tier + sharpness package)

*Final consolidator. Replaces v7. The previous v7 three-tier proof
(menu engine in $W$-geometry) is preserved; v8 integrates three
items v7 left implicit or under-developed: (i) the precise q-a.e.
reading of Definition 2 in the infinite setting; (ii) a sharpened
version of the Tier-2 sharpness witness (cone intersection lemma +
no-free-dust theorem); (iii) classification of the ternary witness
as a menu-engine artefact, not a primitive counterexample to
unrestricted Theorem 2.*

## 1. Setting and the question

Standard Robust-Trust setup (Dworczak–Smolin 2026, §2). $\Omega$ finite
with full-support prior $\mu_0$; $s\in\Delta(\Omega)$ has state-conditional
law $\pi(\cdot\mid\omega)$ and unconditional law $\tau$;
$M = \operatorname{supp}\tau$; $\theta\in\Theta$ (compact metric);
$A$ compact metric; $u(a,\omega,\theta)$ bounded continuous in $a$;
conditional independence of $s,\theta$ given $\omega$. $\Sigma$ =
agent's measurable strategies, $B$ = misaligned-adviser measurable
kernels. With probability $\alpha$ aligned (truthful), with probability
$1-\alpha$ misaligned. $U^* = \sup_\sigma U(\sigma)$.

The question: existence direction of Theorem 2 for infinite $M$ and
$\Theta$.

## 2. Reading Definition 2 in the infinite setting

The paper's Section 2 convention says that for infinite spaces,
"statements involving 'for all' should be interpreted as 'for almost
all' with respect to the underlying distributions." Definition 2
quantifies $\hat\sigma(m)\in\arg\max_{\hat\sigma'}U(\hat\sigma',P_{\beta^*}(\cdot\mid m))$
"for all $m\in M$". The natural underlying distribution is **not**
$\tau$ but the actual mixture message marginal under $\beta^*$:
$$
q_{\beta^*} \;:=\; \alpha\,\tau \;+\; (1-\alpha)\!\!\int_M\!\beta^*(\cdot\mid s)\,\tau(ds).
$$
Two key consequences:

- **The right reading of Definition 2 is $q_{\beta^*}$-a.e.**, not
  $\tau$-a.e. and not literal-all. $P_{\beta^*}(\cdot\mid m)$ is itself
  a regular conditional probability defined $q_{\beta^*}$-a.e.
- **The adversary is not required to be $\tau$-absolutely continuous.**
  $\beta^*$ may place positive mass on $\tau$-null Borel sets $N\subseteq M$,
  in which case $q_{\beta^*}(N)>0$ and those messages are on-path
  for the mixture law.

In the finite paper proof, $\alpha>0$ ensures every $m\in M$ has
positive mixture mass, so literal-all, $\tau$-a.e., and
$q_{\beta^*}$-a.e. coincide. In infinite $M$, $\tau$-null but
$q_{\beta^*}$-positive messages are admissible and **must satisfy
the Bayes-optimality condition** if the adversary uses them.

## 3. The menu engine

The paper's Theorem 1 / Appendix A.1 introduces the **payoff-profile set**
$$
W \;:=\; \{w\in\R^{|\Omega|} : \exists\,\hat\sigma:\Theta\to\Delta(A)\ \text{measurable},\ w(\omega) = \E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}.
$$
$W$ is **compact convex in $\R^{|\Omega|}$** (boundedness + compact $A$ +
continuity in $a$). An agent strategy $\sigma$ corresponds to a
measurable map $w_\sigma: M\to W$, the message-conditional payoff
profile, and conversely (modulo the standard profile-realization
sub-lemma below).

The agent's choice variable is therefore a compact subset $C\subseteq W$
("menu") together with a labeling $w: M\to C$. The objective decomposes
cleanly:
$$
F(C) \;:=\; \int_M \!\Big[\alpha\,\max_{w\in C}\,s\cdot w \;+\; (1-\alpha)\,\min_{w\in C}\,s\cdot w\Big]\,\tau(ds).
$$

**Menu-value equivalence.**
$$
U^* \;=\; \sup_{C\in\mathcal K(W)}\,F(C),
$$
where $\mathcal K(W)$ is the set of nonempty compact subsets of $W$.

**Profile-realization sub-lemma (standard).** $\Phi:\hat\Sigma\to W$
from the compact standard-Borel private-kernel space $\hat\Sigma$ to
$W$ is continuous with compact fibers. By Aliprantis–Border 18.13
(Kuratowski–Ryll-Nardzewski) it admits a Borel right inverse
$R: W\to\hat\Sigma$. Every Borel $w: M\to W$ is implementable as a
measurable agent strategy $\sigma(da\mid m,\theta) = R(w(m))(da\mid\theta)$.

## 4. Main theorem (three tiers)

### Theorem (Tier 1a — value optimality + ε-adversary, unconditional)

*Under the standing hypotheses of Dworczak–Smolin (2026), there exists
$\sigma^*\in\Sigma$ with*
$$
U(\sigma^*) \;=\; U^*.
$$
*Moreover, for every $\eps>0$ there exists $\beta_\eps\in B$ with*
$$
U(\beta_\eps,\sigma^*) \;\le\; U^* + \eps.
$$

**No added hypotheses for Tier 1a.**

### Theorem (Tier 1b — exact adversary attainment)

*Under standing hypotheses + Assumption (exact-contact), the
ε-adversary above can be replaced by an exact $\beta^*\in B$ with*
$$
U(\beta^*,\sigma^*) \;=\; \inf_{\beta\in B}\,U(\beta,\sigma^*) \;=\; U^*.
$$

\paragraph{Assumption (exact-contact).}
Let $C^\dagger := \overline{w^*(M)}$ where $w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$
is the aligned-best labeling at the optimal menu $C^*$. Then for
$\tau$-a.e. $s\in M$, the rowwise contact set
$$
G(s) \;:=\; \big\{m\in M : s\cdot w^*(m) = \min_{z\in C^\dagger}\,s\cdot z\big\}
$$
is **nonempty and admits a measurable selector**.

Sufficient routes (each implies exact-contact): $w^*(M)$ closed; the
strategy correspondence has closed graph; the agent's Bayes-action
correspondence is upper-hemicontinuous with closed compact values.

### Theorem (Tier 2 — full robust rationalizability)

*Under standing + (exact-contact) + Assumption (menu-Hall),
$(\sigma^*,\beta^*)$ can be chosen so that, when $\alpha>0$,*
$$
\hat\sigma^*(m) \;\in\; \arg\max_{\hat\sigma'}\,U\big(\hat\sigma',\,P_{\beta^*}(\cdot\mid m)\big) \quad \text{for $q$-a.e.\ }m\in M,
$$
*where $q := (\gamma_\alpha)_2$. Since $q\ge\alpha\tau$ when $\alpha>0$,
the conclusion also holds $\tau$-a.e.*

\paragraph{Assumption (menu-Hall).}
There exists a kernel $\kappa(\cdot\mid s)$ on $M$ supported on
$G(s)$ for $\tau$-a.e. $s$ such that, with
$\gamma_\alpha := \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\kappa$
and $q := (\gamma_\alpha)_2$, the disintegration posterior
$P_{\gamma_\alpha}(\cdot\mid m) \in B(m)$ for $q$-a.e.\ $m$, where
$$
B(m) \;:=\; \{\mu\in\Delta(\Omega) : \hat\sigma^*(m)\in\arg\max_{\hat\sigma'}\,U(\hat\sigma',\mu)\}.
$$

Equivalently (support-function form): for every measurable $E\subseteq M$
and every continuous affine $\phi:\Delta(\Omega)\to\R$,
$$
\alpha\!\int_E\!\phi(m)\,\tau(dm) + (1-\alpha)\!\int_M\!\phi(s)\,\kappa(E\mid s)\,\tau(ds) \;\le\; \int_E\!h_{B(m)}(\phi)\,q(dm).
$$

This is **strictly milder** than v5's deterministic TRE-gen-Hall:
$\kappa$ may mix over $G(s)$ (set-valued mixing).

## 5. Proof — Tier 1a (unconditional)

### Lemma 1 (menu-value equivalence)

$U^* = \sup_{C\in\mathcal K(W)}\,F(C)$.

\paragraph{Proof.} For fixed $\sigma$ with profile-map $w_\sigma:M\to W$:
the misaligned term satisfies $\inf_\beta\!\int\!\!\int s\cdot w_\sigma(m)\,\beta(dm\mid s)\,\tau(ds) = \int_M\inf_{m\in M}\,s\cdot w_\sigma(m)\,\tau(ds) = \int_M\inf_{w\in w_\sigma(M)}\,s\cdot w\,\tau(ds)$.
The aligned term is $\int s\cdot w_\sigma(s)\,d\tau$. Optimizing
$w_\sigma$ jointly: pick a compact $C\subseteq W$ for the image, then
take $w_\sigma(s) = \arg\max_{w\in C}\,s\cdot w$. By the
profile-realization sub-lemma, every such pair $(C, w_\sigma)$
corresponds to some $\sigma\in\Sigma$.

### Lemma 2 (menu existence)

$\sup_{C\in\mathcal K(W)}\,F(C)$ is attained.

\paragraph{Proof.} $\mathcal K(W)$ is compact metrizable in Hausdorff
distance. The maps $C\mapsto\max_{w\in C}\,s\cdot w$ and
$C\mapsto\min_{w\in C}\,s\cdot w$ are 1-Lipschitz in $d_H$ uniformly
in $s$. Hence $F$ is continuous in $C$, and a compactness argument
gives a maximizer $C^*\in\mathcal K(W)$.

### Lemma 3 (closure-pruning value preservation)

Let $w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$ (single-valued $\tau$-a.e.,
else KRN selects). Set $C^\dagger := \overline{w^*(M)} \subseteq C^*$.
Then $F(C^\dagger) = F(C^*) = U^*$.

\paragraph{Proof.} Aligned term unchanged: $\max_{w\in C^*}\,m\cdot w = m\cdot w^*(m) \le \max_{w\in C^\dagger}\,m\cdot w \le \max_{w\in C^*}\,m\cdot w$.
Misaligned: $C^\dagger\subseteq C^*\Rightarrow \min_{C^\dagger}\,s\cdot w \ge \min_{C^*}\,s\cdot w$,
so $F(C^\dagger) \ge F(C^*)$. Optimality forces equality.

### Lemma 4 (ε-adversary realization, unconditional)

For every $\eps>0$, there exists Borel $\beta_\eps\in B$ with
$U(\beta_\eps,\sigma^*) \le U^* + \eps$.

\paragraph{Proof.} For each $s$, the set
$G_\eps(s) := \{m\in M : s\cdot w^*(m) \le \min_{z\in C^\dagger}\,s\cdot z + \eps\}$
is nonempty (definition of inf) and has Borel-measurable graph.
Jankov–von Neumann gives a Borel selector $m_\eps(s)\in G_\eps(s)$.
$\beta_\eps(\cdot\mid s) := \delta_{m_\eps(s)}$ achieves
$U(\beta_\eps,\sigma^*) \le U^* + (1-\alpha)\eps$.

### Tier 1a capstone

Lemma 1 + Lemma 2 + profile-realization sub-lemma deliver $\sigma^*\in\Sigma$
with $U(\sigma^*) = U^*$. Lemma 4 delivers ε-adversaries. ∎

## 6. Proof — Tier 1b (under exact-contact)

### Lemma 5 (exact adversary)

Under (exact-contact), the deterministic kernel $\beta^*(\cdot\mid s) := \delta_{m^*(s)}$
satisfies $U(\beta^*,\sigma^*) = U^*$.

\paragraph{Proof.} (exact-contact) gives Borel $m^*: M\to M$ with
$m^*(s)\in G(s)$ τ-a.e. By Lemma 3 plus continuity,
$\inf_{m\in M}\,s\cdot w^*(m) = \min_{z\in C^\dagger}\,s\cdot z$,
attained by $m^*(s)$.

## 7. Proof — Tier 2 (under exact-contact + menu-Hall)

### Lemma 6 (per-message Bayes-optimality)

Under (exact-contact) + (menu-Hall), $\hat\sigma^*(m)$ is Bayes-optimal
under $P_{\gamma_\alpha}(\cdot\mid m)$ for $q$-a.e. $m$.

\paragraph{Proof.} (menu-Hall) gives the disintegration posterior in
$B(m)$ q-a.e. By definition of $B(m)$,
$\hat\sigma^*(m)\in\arg\max\,U(\hat\sigma',P_{\gamma_\alpha}(\cdot\mid m))$.
When $\alpha>0$, $q\ge\alpha\tau$, so q-a.e. ⇒ τ-a.e.

This delivers the $q$-a.e. version of Definition 2's condition,
which by §2 is the right reading in the infinite setting.

## 8. Sharpness of menu-Hall

The structural calibration condition (menu-Hall) cannot be derived
from standing + (exact-contact) alone. The witness below shows this
in winner-takes-all ternary; the cone intersection lemma and
no-free-dust theorem strengthen v7's earlier pointwise version into
a uniform obstruction.

\paragraph{Setting.} $\Omega = \{0,1,2\}$, $A = \{a_0,a_1,a_2\}$
winner-takes-all ($u(a_\omega,\omega) = 1$, $-1$ otherwise), prior
$\mu_0 = (1/3, 1/3, 1/3)$, atomless full-support $\tau$ on
$\Delta(\Omega)$, trust region $T = \{\mu : \mu(0)\le 0.4\}$. The
induced payoff-profile menu under any plurality continuation is the
full vertex set $C^\dagger = \{v_0, v_1, v_2\}$ where
$v_\omega(\omega) = 1$ and $v_\omega(\omega') = -1$ for $\omega'\ne\omega$.

For each nonempty $I\subseteq\{0,1,2\}$, define the **rowwise
minimizer cone** and **Bayes-optimality cone** of the mixed profile
$w_\lambda := \sum_{i\in I}\lambda_i v_i$ (with $\mathrm{supp}\,\lambda = I$):
$$
K_I^- \;=\; \{s\in\Delta(\Omega) : s_i\le s_k\,\,\forall i\in I,\,\forall k\in\{0,1,2\}\},
$$
$$
B_I \;=\; \{p\in\Delta(\Omega) : p_i\ge p_k\,\,\forall i\in I,\,\forall k\in\{0,1,2\}\}.
$$
($K_I^-$ uses the identity $s\cdot w_\lambda = 2\sum_i\lambda_i s_i - 1$
to identify rowwise minimizers; $B_I$ similarly.)

### Lemma 7 (cone intersection)

For every nonempty $I\subseteq\{0,1,2\}$, if $\rho$ is a Borel probability
on $\Delta(\Omega)$ with $\rho(K_I^-) = 1$ and barycenter $\bar s\in B_I$,
then $\rho = \delta_{\mu_0}$ where $\mu_0 = (1/3, 1/3, 1/3)$.

\paragraph{Proof.} Fix $i\in I$. $\rho$-a.s., $s_k - s_i \ge 0$ for
every $k$. Since $\bar s\in B_I$, $\bar s_i\ge\bar s_k$, so
$\int(s_k - s_i)\,d\rho \le 0$. A bounded nonnegative Borel random
variable with nonpositive expectation is zero a.s., hence $s_k = s_i$
$\rho$-a.s. for every $k$. Coordinates summing to one force
$s = (1/3, 1/3, 1/3)$ $\rho$-a.s.

### Theorem 8 (no-free-dust)

Under atomless $\tau$, no Borel $\tau$-null set $N\subseteq M$, no
Borel labeling $w_N: N\to W$, and no adversarial kernel $\kappa$
supported on rowwise minimizers can simultaneously satisfy:
(a) $q_\beta(N) > 0$, where $q_\beta = \alpha\tau + (1-\alpha)(\tau\otimes\kappa)_2$;
(b) Bayes-cone calibration: at $q_N$-a.e. $m\in N$, the conditional
source barycenter $\bar s(m)$ lies in $B_{I(m)}$ where $I(m) := \mathrm{supp}\,\lambda(m)$
encodes the dust label $w_N(m) = w_{\lambda(m)}$.

\paragraph{Proof.} Define $\nu(ds, dm) := \tau(ds)\,\kappa(dm\mid s)$
on $\Delta(\Omega)\times M$, and let $\nu_N := \nu\!\restriction_{\Delta(\Omega)\times N}$.
Since $\Delta(\Omega)\times M$ is standard Borel, disintegrate $\nu_N$
over its second marginal $q_N := (\nu_N)_2$:
$$
\nu_N(A\times E) \;=\; \int_E\!\rho_m(A)\,q_N(dm)
$$
for Borel kernels $\rho_m$ on $\Delta(\Omega)$, $q_N$-a.e. $m\in N$.
The rowwise-minimizer support condition gives $\rho_m(K_{I(m)}^-) = 1$
$q_N$-a.e. The Bayes-cone calibration (b) gives the barycenter of
$\rho_m$ in $B_{I(m)}$. By Lemma 7, $\rho_m = \delta_{\mu_0}$ q_N-a.e.
Hence
$$
\nu(\{\mu_0\}\times N) \;=\; \int_N\rho_m(\{\mu_0\})\,q_N(dm) \;=\; q_N(N).
$$
Now $\tau(N) = 0$, so $q_\beta(N) = (1-\alpha)\,q_N(N)$. Assumption (a)
gives $q_N(N) > 0$ (assuming $\alpha < 1$; $\alpha = 1$ rules out
adversarial dust trivially). On the other hand, $\nu$ has first marginal
$\tau$, so
$$
\nu(\{\mu_0\}\times N) \;\le\; \nu(\{\mu_0\}\times\Delta(\Omega)) \;=\; \tau(\{\mu_0\}) \;=\; 0
$$
(atomlessness). Contradiction.

\paragraph{Significance.} The proof never counts messages. It works
identically for finite, countable, or uncountable continuum dust.
Diffuse glitter dust does not help. Combined with Lemma 7's
all-supports-uniform statement, the obstruction is **invariant** to:
deterministic vs. mixed kernel, pure vs. mixed dust labels, atomic vs.
diffuse dust, single boundary message vs. continuum of dust messages.

### Corollary (sharpness for v7's witness).

Setting $I = \{0\}$ in Lemma 7 recovers v7's pointwise sharpness at
$t_0 = (0.4, 0.3, 0.3)$. Theorem 8 then shows no null-message dust
construction can repair the obstruction. menu-Hall is therefore
genuinely required for Tier 2 in this geometry.

## 9. Classification of the witness — menu-engine artefact

Lemma 7 + Theorem 8 strengthen menu-Hall's necessity inside the menu
engine. They do **not** falsify unrestricted Theorem 2 (existence
direction with infinite $M$, $\Theta$).

\paragraph{Claim.} The trust region $T = \{\mu : \mu(0)\le 0.4\}$ used
above is **not a primitive, minimal, or load-bearing trust region**
for the WTA model. Its induced payoff-profile menu is the full vertex
menu $\{v_0, v_1, v_2\}$, behaviorally equivalent to $T = \Delta(\Omega)$.

\paragraph{Justification.} $T$ contains beliefs with each plurality
label: $(0.4, 0.3, 0.3)\mapsto a_0$, $(0.1, 0.8, 0.1)\mapsto a_1$,
$(0.1, 0.1, 0.8)\mapsto a_2$. So any plurality-vertex continuation on
$T$ produces all three pure profiles $v_0, v_1, v_2$. The induced
effective menu is the full vertex menu. The off-$T$ Bregman/TRS
projection chooses an interior point of $T$ whose induced profile
maximizes $m\cdot w$ over the in-$T$ menu — but since the in-$T$ menu
is already the full vertex set, the projection collapses to ordinary
plurality at $m$. Thus every $m\in\Delta(\Omega)$ inside or outside
$T$ induces the same Bayes-optimal WTA vertex, identically to
$T = \Delta(\Omega)$.

If the full menu $\{v_0, v_1, v_2\}$ is optimal under some primitive
$(\alpha, \tau, \Theta, f, u, A)$, then the same behavior is
representable as $T = \Delta(\Omega)$. If the full menu is not optimal,
neither is the halfspace. Either way, the boundary number $0.4$ and
the boundary point $t_0$ are **representational scenery, not
load-bearing beams**.

\paragraph{Consequence.} The witness is a **menu-engine artefact**.
It demonstrates that menu-Hall is genuinely needed inside the
$F$-functional optimization (i.e., choosing among compact menus in
$\mathcal K(W)$), but it does not certify that **every primitive
optimal solution** must hit the same obstruction. There is no known
primitive WTA robust optimization under standing assumptions in which
this halfspace $T$ is genuinely binding **and** recovers the v7 cone
geometry. To recover the obstruction, the strategy would need to
label a τ-null boundary point by $v_0$ while sourcing it from $K_0^-$ —
but the same trust region already contains all three vertices, so the
primitive induced menu is full.

## 10. Comparison with v5

| Quantity | v5 (Phil-Reny route) | v7 (menu engine) | v8 (= v7 + sharpness package) |
|---|---|---|---|
| Tier 1 hypotheses | standing + A5-thick + A8c-attain | standing alone | standing alone |
| Exact β* hypotheses | + A5-thick + A8c-attain | standing + exact-contact | standing + exact-contact |
| Tier 2 hypotheses | + TRE-gen-Hall (deterministic) | + menu-Hall (set-valued) | + menu-Hall (set-valued) |
| Engine | Balder + Mertens + Lusin | Hausdorff on $\mathcal K(W)$ | same |
| Sharpness | pointwise ternary witness | pointwise + set-valued | **uniform across all supports + no-free-dust** |
| Witness status | claimed obstruction to unrestricted Th. 2 | same | **menu-engine artefact, not a primitive counterexample** |

## 11. What v8 has and has not done

\paragraph{What v8 proves (positive).}
- Tier 1a unconditionally: existence of value-optimal $\sigma^*$ plus
  ε-adversaries under standing assumptions alone.
- Tier 1b under (exact-contact): exact $\beta^*$.
- Tier 2 under (exact-contact) + (menu-Hall): full robust
  rationalizability, $q$-a.e. (the natural reading of Definition 2 in
  the infinite setting), hence $\tau$-a.e. when $\alpha>0$.

\paragraph{What v8 sharpens (sharpness).}
- Cone intersection lemma: uniform statement covering all support
  patterns, not just the singleton $I = \{0\}$.
- No-free-dust theorem: no Borel $\tau$-null dust + adversarial
  kernel can repair menu-Hall in WTA ternary, regardless of how
  diffuse or how many dust messages are used.

\paragraph{What v8 does not prove (open).}
- Whether menu-Hall is derivable under additional **primitive**
  structural conditions on $C^\dagger$, the agent's strategy
  correspondence, or the trust-region geometry of $T$. Open candidates:
  primitive optimal $C^\dagger$ that is automatically calibrated;
  trust-region-induced geometric symmetries (radial, zonotopal,
  group-invariant) that force calibration.
- Whether unrestricted infinite Theorem 2 holds without any added
  hypothesis. v8 narrows the question to: does a primitive optimal
  agent strategy in the infinite-$M$, $\Theta$ setting always admit a
  set-valued adversarial kernel with Bayes-cone-consistent
  disintegration posterior? The witness in §8 demonstrates this
  question has bite inside the menu engine; classification (b) shows
  the witness does not settle the primitive question.

## 12. Remaining directions

- **Canonical/minimal menu route.** Identify a "primitive" or
  "behaviorally minimal" payoff-profile menu (not merely an
  $F$-optimal menu in $\mathcal K(W)$) and show calibration follows
  from canonicality. Risk: must not simply rename menu-Hall.
- **Trust-region geometry.** Radial symmetry, zonotopal alignment,
  group-invariant $T$. Each may force menu-Hall automatically. Best
  positive islands: binary state (paper Appendix A.6) and spherical
  (paper §5.2 + Appendix A.10).
- **Constrained-persuasion transport.** Recast the adversarial flow
  as a Strassen/Kellerer transport problem with Bayes-cone
  constraints. Could yield either a transport rescue or a decisive
  dual certificate that menu-Hall is unavoidable.
- **Closed-graph constructive labelings.** Identify which model
  primitives force $w^*$ to admit a closed-graph representative
  (sufficient for exact-contact without assumption).

## References

- **Dworczak, P. and Smolin, A.** (2026). "Robust Trust." arXiv:2602.09490.
- **Aliprantis, C. D. and Border, K. C.** (2006). *Infinite Dimensional Analysis*, 3rd ed. Springer.
- **Bogachev, V. I.** (2007). *Measure Theory*. Standard-Borel disintegration.

---

*v8 supersedes v7. Cone intersection lemma + no-free-dust theorem +
classification of the ternary witness as a menu-engine artefact added.*
