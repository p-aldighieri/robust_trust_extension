You are the Lean Formalizer in the Lean post-processing module. This is **PASS 3** (cap retry) — a focused rewrite of object definitions and signatures in `main.lean`. Pass-2 compiled cleanly but the formalizer-reviewer issued **REDO** with 24 signature issues and 13 object definition issues.

The good news: pass-2 has the right architecture (Tier 1a/1b/2 split, payoff layer split, κ identity, atomlessness scope, Tier 2 bundle ExactContact ∧ MenuHall, posterior_disintegration_menuHall_kernel_coincides in place, all 9 INVENTORY stubs preserved, no axioms/native_decide/unsafe). PRESERVE all of that.

The problem: **"definition smuggling"** — load-bearing identities replaced with opaque `Prop` fields or `True`, plus missing linkages between objects (ExactContact ↔ σstar especially), plus a tautological WTA cone identification.

Re-emit a fresh full main.lean. Don't return a diff. The new file must address every item below.

## Required fixes

### A) Replace vacuous fields with real predicates

1. **`PriorAdviserPosteriorLaw.support_is_range`** — current: `Set.range model.inclM = Set.univ ∨ True` (trivially true). Replace with the actual support identity, e.g.:
   ```lean
   support_is_msupp :
     ∀ s : Belief model.Ω, s ∈ Set.range model.inclM ↔ s ∈ MeasureTheory.Measure.support model.τ
   ```
   Or if the support equality is too strong, drop the field entirely.

2. **`NullDustData.lam_measurable`** — current: `True`. Replace with real coordinatewise measurability on the dust subtype:
   ```lean
   lam_measurable : ∀ i : WTAΩ, Measurable (fun m : N => lam m i)
   ```

3. **`PosteriorDisintegration.conditional_barycenter`** — current: `Prop` (opaque). Replace with the actual identity tying Pβ, Pγα, MixtureMessageLaw, MixtureCouplingGammaAlpha:
   ```lean
   conditional_barycenter :
     ∀ β : AdviserKernel model, ∀ᵐ m ∂(MixtureMessageLaw model pd β),
       beliefBarycenter (Pβ β m) = beliefAsProfile m
   ```
   Adjust to match the structurer's intent; the point is that it must be an actual equation.

4. **`AdversarialFlowDisintegrationData.disintegration_identity`** — current: `Prop` (opaque). Replace with the typed assertions tying ν, νN, qN, ρ:
   ```lean
   nu_eq_compProd : ν = model.τ.compProd κ.kernel
   nuN_eq_restrict : νN = ν.restrict {p | p.2 ∈ N}
   qN_eq_marginal : qN = νN.map Prod.snd
   rho_disintegrates_nuN :
     νN.map (fun p => (p.2, p.1)) = qN.compProd ρ
   ```
   Make each a separate field so they can be invoked independently.

### B) Connect ExactContact and Tier1bResult to σstar / the implemented strategy

5. **`ExactContact`** — currently bundles `opt, wlabel, cdagger, selector`. Add a field tying the wlabel to a strategy:
   ```lean
   structure ExactContact (model : RobustTrustModel) (σstar : AgentStrategyFull model) where
     opt : OptimalMenuCstar model
     wlabel : AlignedBestLabelingWstar model opt
     cdagger : PrunedMenuCdagger model opt wlabel
     selector : ...  -- existing
     -- NEW: σstar implements wlabel via profileMap
     sigma_implements_wlabel :
       ∀ m : MessageSupportM model, profileMap σstar m.val = wlabel.selectorFn m
   ```
   (Use whatever the profile-map name is in your file; the point is the assertion that σstar realizes wlabel.)

   This will change the signature of every theorem that takes ExactContact — including `exact_adversary_attainment`, `menu_hall_support_implies_exact_adversary`, `tier1b_exact_adversary_under_exact_contact`, `tier2_qae_robust_rationalizability_under_menu_Hall`. They should now take both `σstar : AgentStrategyFull` and `ec : ExactContact model σstar`.

6. **`ExactAdversaryKernel`** — should assert the deterministic Dirac kernel:
   ```lean
   structure ExactAdversaryKernel (model : RobustTrustModel) (ec : ExactContact ...) where
     β : AdviserKernel model
     deterministic :
       ∀ s : MessageSupportM model, β.kernel s = MeasureTheory.Measure.dirac (ec.selector s)
     supported_on_G : KernelSupportedOnG model ec.cdagger β
   ```

7. **`Tier1bResult`** — must require βstar to be deterministic exact-contact + supported on G:
   ```lean
   structure Tier1bResult (model : RobustTrustModel) (σstar : AgentStrategyFull model)
       (ec : ExactContact model σstar) where
     βstar : AdviserKernel model
     deterministic : ∀ s, βstar.kernel s = Measure.dirac (ec.selector s)
     supported_on_G : KernelSupportedOnG model ec.cdagger βstar
     adversarial : IsAdversarial model σstar βstar
     value : MixturePayoffFull model σstar βstar = UStarFull model
   ```

### C) Fix the tautological WTA mixed-label predicates

8. **`WTARowwiseMinimizer`, `WTABayesOptimalWTA`** — currently defined as cone membership, making `wta_rowwise_minimizer_and_Bayes_cone_identification` a definitional echo. Replace with real payoff comparisons referencing `WTA_mixedLabel lam`:
   ```lean
   def WTARowwiseMinimizer (I : Set WTAΩ) (lam : WTAΩ → ℝ) (s : WTABelief) (m : WTAProfile) : Prop :=
     -- m minimizes the rowwise misaligned payoff under the mixed label
     ∀ m' : WTAProfile, beliefDot s m ≤ beliefDot s m'
     -- (use whatever the rowwise payoff is; the point: NOT cone membership by definition)

   def WTABayesOptimalWTA (I : Set WTAΩ) (lam : WTAΩ → ℝ) (s : WTABelief) (m : WTAProfile) : Prop :=
     -- aligned-best property in the mixed-label sense
     ∀ m' : WTAProfile, beliefDot s (WTA_mixedLabel lam) ≤ beliefDot s m'
     -- Again, not by-definition equal to cone membership.
   ```
   Then `wta_rowwise_minimizer_and_Bayes_cone_identification` becomes a real theorem connecting these payoff predicates to cone membership.

### D) Add λ/support profile to `wta_cone_intersection`

9. **`WTA_ConeIntersectionStatement`** (and `wta_cone_intersection`) — add explicit λ/support hypotheses:
   ```lean
   theorem wta_cone_intersection
     (I : Set WTAΩ)
     (lam : WTAΩ → ℝ)
     (h_support_eq : WTASupport lam = I)
     (h_pos_on_I : ∀ i ∈ I, 0 < lam i)
     (h_sum_one : ∑ i : WTAΩ, lam i = 1)
     ... :
     ... := sorry
   ```

### E) Fix `dust_disintegration_over_subtype_N` to be an actual disintegration

10. Replace the current "∃ ρ, probabilities ∧ ρ = flow.ρ" with the actual disintegration identity:
    ```lean
    theorem dust_disintegration_over_subtype_N
      (model : RobustTrustModel) (mh : MenuHall ...) (flow : AdversarialFlowDisintegrationData ...) :
      flow.νN.map (fun p : (Belief model.Ω) × M => (p.2, p.1)) =
        flow.qN.compProd flow.ρ := sorry
    ```

### F) Add probability/support fields to RobustTrustModel

11. Add to `RobustTrustModel`:
    ```lean
    [π_prob : ∀ ω, IsProbabilityMeasure (π ω)]
    ```
    (Use `[...]` for typeclass-instance-style or just `(... : ...)` for explicit hypothesis — pick whatever Lean accepts; the point is the assertion.)

### G) Require MessageSupportM in bridge lemmas + main theorem

12. **`adversary_kernels_restrict_to_M`**, **`full_restricted_Ustar_equivalence`**, **`sigma_star_robust_optimal`** — all should take `(bridge : MessageRestrictionBridge model)` and/or `(msupp : MessageSupportM model)` as a hypothesis.
13. **`robust_trust_infinite_extension_v8_package`** (main theorem) — add `(msupp : MessageSupportM model)` and `(bridge : MessageRestrictionBridge model)` as parameters.

### H) Add missing setup hypotheses to menu/realization lemmas

14. **`strategy_value_le_menu_sup`, `menu_value_le_strategy_sup`, `menu_value_equivalence`, `menu_functional_continuity`, `optimal_menu_exists`, `wstar_profile_map_implemented`** — each takes `(setup : ProfileRealizationSetup model)` (and `prm : ProfileRealizationMap model setup` where needed for Borel right inverse).

### I) Restore hypotheses to `support_function_integrated_Hall_equivalence`

15. Re-add `hsupp_meas`, `hsupp_int`, `hP_int` hypotheses (matching the inlined `Inventory.support_function_integrated_separation` stub signature).

### J) Fix flow.α vs external α

16. **`wta_no_free_dust`** uses external `α` but `AdversarialFlowDisintegrationData` has its own `flow.α`. Add a hypothesis tying them: `(h_alpha_eq : flow.α = model.α)`. Or remove `flow.α` and reuse `model.α` directly.

### K) `adversary_infimum_pointwise` hypothesis profile

17. Add measurable-infimum + integrability hypotheses to match the `Inventory.kernel_infimum_epsilon_selection` stub it depends on.

## What to KEEP unchanged

- All 9 inlined INVENTORY stubs (PASS in pass-2 audit).
- Atomlessness scope (only in AtomlessTauSharpness; never in Tier 1a/1b/2 or wta_cone_intersection).
- Tier 2's choice of κ as βstar (PASS).
- posterior_disintegration_menuHall_kernel_coincides (PASS).
- Payoff layer split (PASS).
- Halfspace witness objects (PASS).
- The `Type` (not `Type*`) universe choice (this fixed pass-1).
- All 59 lemma slugs must be present.

## Output Contract (same as before)

Return a fresh full main.lean in the standard `lean_formalization` + `lean` fenced-block format. Don't return a diff.

````markdown
```lean_formalization
target_environment: lean-4.29.0
main_theorem_slug: robust_trust_infinite_extension_v8_package
lemma_count: 59
sorry_count: <int>
econ_lean_stubs_inlined: 9
imports_count: 1
signature_concerns: 0
```

```lean
import Mathlib

namespace Inventory
-- 9 inlined stubs unchanged
end Inventory

namespace RobustTrustV8

-- rebuilt objects + signatures + all 59 lemmas + 6 sub-theorems + main package
-- Body of every theorem: := sorry

end RobustTrustV8
```

## Signature Concerns
None.

## Notes on Pass-3 Fixes
(Describe how you addressed each of the 17 items in A–K above.)
````

## Translation Discipline (unchanged)

Translation, not mathematics. Never use `axiom`, `native_decide`, `unsafe`. Don't add hypotheses the source didn't state. If you cannot translate faithfully, emit `TRANSLATION_BLOCKED`. The reviewer specifically called this pass's failure mode "definition smuggling" — replacing real identities with `True` or opaque `Prop`. Don't repeat that.


## Context Packet


## Reviewer feedback (verbatim — formalizer-reviewer)

ROLE: assistant (id=5c0c7ada-b17e-491f-8dee-2fda37a7706c)
========
review_control
verdict: REDO
ready_for_axle_skeleton_verify: false
recommended_next_phase: RETURN_TO_FORMALIZER_FOR_SIGNATURE_AND_OBJECT_REWRITE
signature_issues_count: 24
object_definition_issues: 13
axiom_declarations_introduced: []
native_decide_used: []
unsafe_tactics_used: []
unsafe_declarations_introduced: []
hidden_sorries_outside_sorry_bodies: 0
Verdict

VERDICT: REDO

Reason: The file typechecks, and the key Tier 1a/Tier 2 public shape is partly recognizable, but the skeleton contains several semantic trapdoors: vacuous object fields, exact-contact data not tied to the strategy it is supposed to certify, dust-flow data not tied to the mixture law it is supposed to disintegrate, and WTA cone/rowwise lemmas that are either missing the label-support profile or made tautological by definition. These are not proof gaps. They are statement-shape gaps. Tiny goblins in the type layer have already opened the pantry.

The most serious failures are:

Vacuous object definitions: PriorAdviserPosteriorLaw.support_is_range : Set.range model.inclM = Set.univ ∨ True, NullDustData.lam_measurable : True, PosteriorDisintegration.conditional_barycenter : Prop, and AdversarialFlowDisintegrationData.disintegration_identity : Prop are smoke-machines rather than mathematical content.

Exact-contact not connected to σ*: ExactContact carries its own opt, wlabel, and cdagger, but there is no assertion that the public σstar implements that wlabel. This infects exact_adversary_attainment, menu_hall_support_implies_exact_adversary, Tier 1b, and Tier 2.

Tier 1b result forgets exactness: Tier1bResult only says there exists some adversarial kernel; it does not say the kernel is deterministic, induced by the exact-contact selector, or supported on G.

WTA mixed-label cone lemma is tautological: WTARowwiseMinimizer and WTABayesOptimalWTA are defined directly as membership in the cones, so wta_rowwise_minimizer_and_Bayes_cone_identification proves a definitional echo, not the mixed-label payoff fact.

WTA cone intersection does not carry the λ/support profile requested in the audit brief.

Dust disintegration is not a disintegration: dust_disintegration_over_subtype_N only recovers flow.ρ; it does not state the product/restriction/marginal identity.

The model lacks required probability/support fields: π : Ω → Measure (Belief Ω) has no probability field in RobustTrustModel, and the main theorem does not require the MessageSupportM/bridge facts that make M actually be support.

Support-function integrated Hall equivalence drops measurability/integrability hypotheses from the external stub.

The v8 target explicitly separates Tier 1a, Tier 1b, and Tier 2, with Tier 1a standing alone, Tier 1b under exact-contact, and Tier 2 under exact-contact plus set-valued menu-Hall; the supporting documents also stress that the correct infinite-space Definition 2 reading is qβ-a.e., not literal-all or merely τ-a.e. 

theorem_2_extension_proof_v8

 The formalization recognizes that broad architecture, but its internal objects are too leaky for proof-skeleton verification.

Opinion and Next Move

Do not send this to AXLE proof-skeleton verification. It will generate a beautiful fossil record of proofs for the wrong statements.

The next pass should rewrite the signatures and objects before any proof effort. The rewrite should especially rebuild:

ExactContact, PrunedMenuCdagger, and AlignedBestLabelingWstar so the exact-contact object is explicitly tied to the implemented σstar.

Tier1bResult so it asserts the exact-contact kernel property, not merely existence of some adversary.

PosteriorDisintegration and AdversarialFlowDisintegrationData so the conditional laws are tied to actual couplings/marginals.

WTA mixed-label predicates so they refer to the mixed label WTA_mixedLabel lam, not merely to the cones by definition.

NullDustData measurability and qN/νN disintegration as real fields, not True/opaque Prop.

Object-Definition Audit
Core model objects

Belief, beliefCoord, beliefDot, beliefBarycenter
Mostly faithful. beliefBarycenter returns a raw profile Ω → ℝ, not a Belief Ω. That is acceptable for barycenter identities, but downstream cone statements must remember to assert simplex properties when needed.

RobustTrustModel
PATCH needed.

π : Ω → Measure (Belief Ω) is missing π_prob : ∀ ω, IsProbabilityMeasure (π ω). The external posterior lemma expects state-conditional probability laws.

inclM, τM, and τM_prob exist, but the model does not assert that M is the support of τ, nor that τM.map inclM = τ. Those facts are only in MessageSupportM, and the main theorem does not require MessageSupportM.

conditional_independence : Prop is opaque. This may be acceptable as a named standing assumption, but it is not connected to typeLaw, π, or payoff decompositions.

The change from Type* to Type is not itself a semantic weakening for the target theorem. It is a universe restriction, not a mistranslation.

PriorAdviserPosteriorLaw
FAIL. support_is_range : Set.range model.inclM = Set.univ ∨ True is vacuous. This should be removed or replaced with actual support/range content. As written, it is a parchment mask with True painted on the back.

PosteriorLawConsistency
Mostly OK for the intended posterior-law identities. It has the coordinate identity, barycenter identity, and τ-a.e. posterior identity. It does not supply probability of π; that belongs in the model.

MessageSupportM
Good as a structure, but it is not threaded through the public theorem or key bridge lemmas consistently. The theorem can currently speak about arbitrary model.M, not necessarily the support space.

TypeActionPayoffPrimitives
Faithful but redundant with model fields. No immediate signature bug.

PrivateStrategySpace
Weak. It defines an action kernel family, but RobustTrustModel.profileOfPrivate is not tied to actKernel or to expected utilities. The private payoff layer is therefore profile-only. This may be intentional scaffolding, but it is not the paper’s private-strategy object unless a realization axiom connects it to u, typeLaw, and kernels.

AgentStrategyFull and AgentStrategyM
Structurally acceptable. The full strategy is represented as a section Belief Ω → PrivateStrategy, which matches the “message-indexed private strategy” viewpoint.

MessageRestrictionBridge
Partly faithful, but not integrated. It contains the needed extension/restriction maps, yet full_restricted_Ustar_equivalence and sigma_star_robust_optimal do not require it. offSupportIrrelevant : Prop is opaque and unused.

AdviserKernel and FullMessageAdviserKernel
Reasonable. AdviserKernel correctly targets M → M. FullMessageAdviserKernel targets M → Belief Ω, matching the full-message adversary comparison.

Payoff layer

PrivatePayoff, IsBayesOptimal
Faithful to the profile abstraction.

AlignedPayoffM, MisalignedPayoffM, MixturePayoffM, RobustPayoffM, UStarM
Good. The payoff layers are distinct, as requested.

AlignedPayoffFull, MisalignedPayoffFull, MixturePayoffFull, RobustPayoffFull, UStarFull
Good. Full layer is routed through restriction to M.

MixtureMessageLaw, PositiveQMass
Good shape. This is the right qβ-a.e. basis for Definition 2.

Posterior and QAE objects

PosteriorDisintegration
FAIL. Pβ, Pγα, and measurability fields are present, but conditional_barycenter : Prop is opaque. There is no typed connection between Pβ β, Pγα, MixtureMessageLaw, MixtureCouplingGammaAlpha, and regular conditional laws. The v8 proof needs these identities because Definition 2 is a qβ-a.e. posterior statement. 

theorem_2_extension_proof_v8

Definition2QAEPredicate
Good shape: adversariality plus qβ-a.e. Bayes optimality using Pβ β. This is one of the better translations.

Menu engine objects

PayoffProfileSet, ProfileInW, ProfileRealizationSetup, ProfileRealizationMap
Mostly faithful. ProfileRealizationSetup carries compactness, convexity, continuity, fibers, and surjectivity.

CompactMenu, maxPayoff, minPayoff, MenuFunctionalF
Faithful to the menu engine.

OptimalMenuCstar
Good. Includes optimality and value equality.

AlignedBestLabelingWstar
Good as a selector structure.

PrunedMenuCdagger
Good. It carries subset, closure/range density, and value preservation.

RowwiseContactG, EpsilonContactGeps, KernelSupportedOnG
Faithful.

ExactContact
FAIL by missing linkage. It bundles opt, wlabel, cdagger, and a selector, but does not say that the public strategy σstar implements wlabel. Exact contact is supposed to be contact for the menu/labeling behind σ*. Without that tie, the exact-contact kernel may be exact for a decorative menu, not for σ*.

ExactAdversaryKernel
Misnamed/weakened. It does not assert that β is the deterministic Dirac kernel induced by mstar; it only asserts existence of a selector and support on G. If deterministic exact-contact is intended, this needs a field tying β.kernel s = Measure.dirac (mstar s) a.e.

MenuHallAdversaryKernel
OK but unused; the actual MenuHall structure carries κ.

MenuHall
Mostly faithful. It takes pd, σFull, ec, and κ, includes support, q = qκ, q = (γα)_2, and calibration. This satisfies the required Tier 2 hypothesis bundle shape.

BayesOptimalityBeliefCorrespondenceBm
Faithful.

PosteriorCalibrationProfiles, SupportFunctionHallInequalities, SupportFunctionHallForm
Acceptable as auxiliary predicates, but the integrated theorem using them drops needed integrability hypotheses.

WTA and sharpness objects

WTATernaryAlgebra, AtomlessTauSharpness
Good separation. Atomlessness is not bundled into WTA algebra.

WTA_vertex, WTA_mixedLabel, WTASupport, WTAKminus, WTABcone, WTABconeProfile
Definitions match the intended cones. WTABconeProfile is a raw-profile version, which is fine for barycenters.

WTARowwiseMinimizer, WTABayesOptimalWTA
FAIL. These definitions are tautological cone memberships and ignore the mixed label payoff comparison. This makes the identification theorem vacuous.

NullDustData
Mixed.

Good: wN, lam, and I are indexed over {m // m ∈ N}. Dust label typing passes the subtype audit.

FAIL: lam_measurable : True is vacuous. It must be a real measurability condition, likely coordinatewise measurability on the dust subtype.

Good: support positivity is encoded as i ∈ I m ↔ 0 < lam m i.

AdversarialFlowDisintegrationData
FAIL. ν, νN, qN, and ρ are present, but disintegration_identity : Prop is opaque. There is no typed assertion that ν = τ ⊗ κ, that νN is the restriction to dust, that qN is the second marginal, or that ρ disintegrates νN. This is the dust proof’s load-bearing bridge, and it currently has the density of fog.

Also, flow.α is separate from the α quantified in wta_no_free_dust; the statement uses external α in WTAPositiveQMass but the flow object has its own α. Either remove flow.α or require flow.α = α.

RowwiseSupport, BayesConeCalibration, WTAMixtureMessageLaw, WTAPositiveQMass
The shapes are good, modulo the broken flow-disintegration object.

Halfspace witness objects

HalfspaceTrustRegion, FullSimplexTrustRegion, WTAInducesVertex, ContainsBeliefsForAllVertices, FullWTAVertexMenu, InducedEffectiveMenu, BehaviorEquivalentTrustRegion, MenuEngineArtifact, EffectiveMenuEquivalenceData
Faithful to the v8 classification of the halfspace witness as a menu-engine artifact rather than a primitive counterexample. The closure memo explicitly warns not to treat that witness as a counterexample to unrestricted Theorem 2. 

project_closure_memo

Package statement definitions

Tier1aResult
Good. It exposes σstar : AgentStrategyFull and includes ε-adversaries.

Tier1bResult
FAIL. It forgets exact contact. It should assert that βstar is the deterministic exact-contact kernel, or at least KernelSupportedOnG model ec.cdagger βstar, and should be parameterized by ec. Current Tier1bResult model σstar ignores ec.

Tier2Result
Mostly good. It chooses βstar := κ, includes βstar = κ, q identities, adversariality, value equality, Definition 2 predicate, and the α > 0 → τM a.e. upgrade. This matches the intended q-a.e. Tier 2 architecture. The supporting v8 text also states Tier 2 as exact-contact plus menu-Hall with q-a.e. robust rationalizability. 

theorem_2_extension_proof_v8

WTA_ConeIntersectionStatement
Questionable. It matches the v8 pure cone statement, but it does not satisfy the audit brief’s requested λ/support profile. Since the user explicitly asked to verify λ support, this must be patched.

WTA_NoFreeDustStatement
Mostly good high-level shape, but inherits the flow.α/external α mismatch and the opaque disintegration defect.

HalfspaceWitnessStatement
Good.

RobustTrustInfiniteExtensionV8Package
High-level architecture is recognizable, but because Tier1bResult and exact-contact linkage are wrong, the package is semantically weaker than intended in Tier 1b. It also does not require MessageSupportM or MessageRestrictionBridge, despite the bridge being load-bearing in the English decomposition.

Per-Signature Audit
Inventory stubs

All 9 inlined Inventory stubs match the supplied source INVENTORY.lean shape closely enough for this pass.

measurable_argmax_selector: PASS.

profile_geometry_import: PASS.

krn_borel_right_inverse: PASS.

kernel_infimum_epsilon_selection: PASS.

hausdorff_support_function_lipschitz: PASS.

UniversallyMeasurable: PASS.

jankov_von_neumann_universal_selection: PASS.

GepsRegularity: PASS.

geps_borel_selector_upgrade: PASS.

bayes_posterior_as_conditional_barycenter: PASS.

support_function_ae_pointwise_separation: PASS.

support_function_integrated_separation: PASS.

Bridge and posterior lemmas

posterior_law_barycenter_identities
PASS. Faithfully unpacks PosteriorLawConsistency.

strategy_restriction_to_M
PASS. It restricts full strategies to M.

restricted_agent_strategy_extends_to_full
PASS shape, because it explicitly takes MessageRestrictionBridge.

outside_M_messages_irrelevant
PASS shape.

adversary_kernels_restrict_to_M
PATCH. It does not take MessageRestrictionBridge or MessageSupportM, even though the English statement is about the without-loss restriction to the support message space.

full_restricted_Ustar_equivalence
PATCH. Missing MessageRestrictionBridge. The English statement depends on restriction/extension and off-support irrelevance; current theorem asserts it for every model.

q_dominates_tau_when_alpha_pos
PASS.

Profile/menu engine lemmas

payoff_profile_set_compact_convex
PASS.

profile_map_has_borel_right_inverse
PASS.

borel_profile_map_implemented_by_agent_strategy
PASS.

profile_payoff_decomposition_aligned
PASS, though plc is unused because the definition already equals the RHS.

profile_payoff_decomposition_misaligned
PASS, same caveat.

mixture_payoff_decomposition
PASS.

adversary_infimum_pointwise
PATCH. It omits measurable-infimum and integrability hypotheses that the external kernel-infimum theorem requires. It may be intended as a packaged theorem, but it is stronger than the English dependency profile.

strategy_value_le_menu_sup
PATCH. Missing profile-realization/setup hypotheses. It asserts the menu bound for any model.

menu_value_le_strategy_sup
PATCH. Missing ProfileRealizationMap or existence of a Borel right inverse. The English proof needs implementation of Borel menu labelings.

menu_value_equivalence
PATCH. Same missing realization/setup dependencies.

compact_menu_space_compact
PASS.

menu_extrema_Hausdorff_Lipschitz
PASS-ish. It is stronger than the English statement because no compactness/setup assumptions are exposed, but the compact-menu type may internalize enough.

menu_functional_continuity
PATCH. Missing boundedness/integrability/setup assumptions.

optimal_menu_exists
PATCH. Missing compact menu-space and continuity assumptions as explicit inputs.

aligned_best_labeling_selection
PASS. The , True tail is harmless but ungainly.

closure_pruning_value_preservation
PASS. The structure witness carries the closure/density fields.

wstar_profile_map_implemented
PATCH. Missing ProfileRealizationMap or Borel right-inverse witness. The English lemma uses the right inverse.

wstar_payoff_equals_F_Cdagger
PASS shape.

sigma_star_robust_optimal
PATCH. Missing MessageRestrictionBridge. This is the reverse-lift seam; the theorem should not magically extend restricted strategies without bridge data.

ε-contact and exact-contact lemmas

geps_nonempty
PASS.

geps_graph_measurable
PASS.

geps_selector_exists
PASS.

epsilon_adversary_realization
PASS for Tier 1a shape. It is broad, but ε-attainment of an infimum is plausible as a packaged result.

exact_contact_selector_unpack
PASS.

exact_adversary_attainment
FAIL. It takes ec, but the conclusion only gives some adversary and does not say the kernel is deterministic or supported on RowwiseContactG. Worse, ec is not tied to σstar.

menuHall_adversary_kernel_identity
PASS. It correctly chooses κ as the Tier 2 adversary and records the q identities.

menu_hall_posterior_calibration_unpack
PASS.

menu_hall_support_implies_exact_adversary
FAIL. It claims support on ec.cdagger makes κ adversarial for arbitrary robust-optimal σstar, but there is no hypothesis that σstar implements ec.wlabel.

per_message_Bayes_optimality
PASS shape. It retains exact-contact and menu-Hall and gives q-a.e. plus τ-a.e. under α > 0.

posterior_disintegration_menuHall_kernel_coincides
PASS. This required lemma exists and is placed before Tier 2.

Support-function lemmas

support_function_pointwise_membership_equivalence
PASS.

support_function_integrated_Hall_equivalence
FAIL/PATCH. It drops hsupp_meas, hsupp_int, and hP_int, which are explicit in the inlined external stub. This is a quantifier/hypothesis mismatch.

Tier capstones

tier1a_value_optimality_and_epsilon_adversary
PASS on the public witness: it concludes ∃ σstar : AgentStrategyFull. No atomlessness regression.

tier1b_exact_adversary_under_exact_contact
FAIL. It does not assert the returned β is deterministic exact-contact, supported on G, or tied to ec. It only returns adversariality/value.

tier2_qae_robust_rationalizability_under_menu_Hall
PASS on the specific audit items: it takes both ExactContact and MenuHall, chooses κ via Tier2Result, and no atomlessness is present. Its correctness still depends on fixing the exact-contact/strategy linkage in the objects.

WTA sharpness lemmas

wta_payoff_dot_product_identity
PASS.

wta_rowwise_minimizer_and_Bayes_cone_identification
FAIL. Because WTARowwiseMinimizer and WTABayesOptimalWTA are defined as cone membership, this theorem is tautological. It should connect the mixed label WTA_mixedLabel lam to rowwise minimization and Bayes optimality.

wta_cone_intersection
PATCH/FAIL under the specific audit brief. It has no atomlessness, which is good. But it lacks the λ/support hypotheses requested for Lemma 7 auditing: support λ = I, positive weights on I, and sum λ = 1. If the intended final statement is the pure cone version from v8, this is acceptable; if the orchestrator’s item 7 is binding, this must be rewritten.

dust_disintegration_over_subtype_N
FAIL. It is not a disintegration theorem. It merely says ∃ ρ, probabilities ∧ ρ = flow.ρ.

qN_supported_on_N
PASS, and it is subtype-disciplined.

dust_rowwise_support_implies_cone_support
PASS shape, assuming the flow object is repaired.

dust_Bayes_calibration_gives_cone_barycenter
PASS shape.

dust_conditional_sources_satisfy_cones
PASS shape.

cone_intersection_applied_to_dust
PASS shape, but inherits the wta_cone_intersection λ-profile issue.

positive_dust_mass_impossible_when_alpha_one
PASS shape.

dust_positive_mass_forces_mu0_atom
PASS shape.

wta_no_free_dust
PATCH. Atomlessness scope is correct, but the theorem uses external α while the flow has its own flow.α. The flow object must be tied to the same α.

sharpness_corollary
PASS, with the caveat that it has an atomlessness hypothesis because it bundles no-free-dust. It does not contaminate Tier 1/Tier 2.

Halfspace witness lemmas

halfspace_contains_beliefs_inducing_all_vertices
PASS.

halfspace_induced_effective_menu_equals_full_vertices
PASS.

halfspace_behavior_equivalent_to_full_simplex
PASS.

halfspace_witness_menu_engine_artifact
PASS.

Main theorem

robust_trust_infinite_extension_v8_package
PATCH/FAIL. The top-level architecture matches the six-package story, but the underlying package definition inherits the broken Tier1bResult, the missing support/bridge hypotheses, and the vacuous dust/posterior objects. The theorem is therefore not ready for skeleton verification.

Specific Requested-Item Audit

Atomlessness scope: PASS. No atomlessness in Tier 1a, Tier 1b, or Tier 2. wta_cone_intersection has no atomlessness. wta_no_free_dust has AtomlessTauSharpness.

Tier 2 hypothesis bundle: PASS. tier2_qae_robust_rationalizability_under_menu_Hall takes both ec : ExactContact model and mh : MenuHall model pd σstar ec κ.

Reverse strategy lift: PARTIAL PASS. Tier 1a exposes AgentStrategyFull, and the bridge lemmas are present. But sigma_star_robust_optimal and full_restricted_Ustar_equivalence omit the bridge hypothesis.

Tier 2 posterior identity: PASS. posterior_disintegration_menuHall_kernel_coincides exists and appears between per_message_Bayes_optimality and Tier 2.

κ identity for Tier 2: PASS. Tier2Result and menuHall_adversary_kernel_identity choose βstar := κ, not the deterministic selector.

Payoff layer: PASS. Aligned, misaligned, mixture, and robust payoffs are distinct, with M and full versions.

WTA cone intersection: FAIL under the audit brief. Current signature lacks lam, support equality, strict positivity on support, and sum-one hypotheses.

Dust label typing: PARTIAL PASS. Labels live on subtype NDust; good. But lam_measurable : True and opaque flow disintegration break the dust layer.

INVENTORY stubs: PASS. The inlined stubs match the v3 source shape.

Translation-Discipline Audit

axiom declarations introduced: none found.

native_decide / unsafe / custom Decidable: none found.

unsafe declarations: none found.

hidden sorries outside theorem bodies: none found.

all proof holes are ordinary sorry bodies on theorem declarations.

MATHEMATICAL_CONCERN blocks: none found.

The discipline problem is not axiom smuggling. It is “definition smuggling”: replacing load-bearing mathematical identities with opaque Prop fields or True.

Import Audit

import Mathlib is acceptable for a single-file skeleton. The non-Mathlib dependencies are inlined under namespace Inventory, which matches the AXLE requirement.

No import mismatch requiring immediate action. The issue is not import availability; it is that several external theorem hypotheses were later dropped by local theorem signatures.

INVENTORY.lean Stub Audit

The 9 non-Mathlib externals were inlined, and the signatures match the supplied INVENTORY.lean stubs:

measurable maximum/argmax selection: OK

profile geometry import: OK

KRN/Borel right inverse: OK

kernel infimum ε-selection: OK

Hausdorff support-function Lipschitz: OK

JvN universal selection plus universal measurability definition: OK

Gε Borel selector upgrade: OK

Bayesian posterior as conditional barycenter: OK

support-function measurable integrated separation, split into pointwise and integrated forms: OK

The downstream local theorem support_function_integrated_Hall_equivalence does not preserve all hypotheses from the stub, so the stub itself passes but its use-site signature does not.


## Pass-2 main.lean (AXLE-clean but REDO; the file to rewrite)

```lean
import Mathlib

/-!
Single-file Lean skeleton for the Robust Trust v8 package.
All non-Mathlib inventory stubs are inlined under top-level namespace `Inventory`.
-/

namespace Inventory

open MeasureTheory ProbabilityTheory
open scoped BigOperators ENNReal

/-! ## 1. measurable-maximum-and-argmax-selection -/

theorem measurable_argmax_selector
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace Y] [MeasurableSpace Y]
    [CompactSpace Y] [Nonempty Y]
    {Γ : X → Set Y} {f : X → Y → ℝ}
    (hΓ_meas : MeasurableSet {p : X × Y | p.2 ∈ Γ p.1})
    (hΓ_ne : ∀ x, (Γ x).Nonempty)
    (hΓ_compact : ∀ x, IsCompact (Γ x))
    (hf_meas : Measurable fun p : X × Y => f p.1 p.2)
    (hf_cont : ∀ x, ContinuousOn (fun y => f x y) (Γ x)) :
    ∃ sel : X → Y,
      Measurable sel ∧
      ∀ x, sel x ∈ Γ x ∧
        IsMaxOn (fun y => f x y) (Γ x) (sel x) := by
  sorry

/-! ## 2. profile-geometry-import -/

theorem profile_geometry_import
    {Ω PrivateStrategy : Type*}
    [Fintype Ω]
    [TopologicalSpace PrivateStrategy] [CompactSpace PrivateStrategy] [Nonempty PrivateStrategy]
    [MeasurableSpace PrivateStrategy] [BorelSpace PrivateStrategy]
    (Φ : PrivateStrategy → (Ω → ℝ))
    (hΦ_cont : Continuous Φ)
    (hconvex_realization :
      ∀ σ1 σ2 : PrivateStrategy, ∀ t : ℝ, 0 ≤ t → t ≤ 1 →
        ∃ σt : PrivateStrategy,
          Φ σt = (fun ω => t * Φ σ1 ω + (1 - t) * Φ σ2 ω)) :
    let W : Set (Ω → ℝ) := Set.range Φ
    IsCompact W ∧
    Convex ℝ W ∧
    (∀ w ∈ W, (Φ ⁻¹' {w}).Nonempty ∧ IsCompact (Φ ⁻¹' {w})) := by
  sorry

/-! ## 3. krn-borel-right-inverse -/

theorem krn_borel_right_inverse
    {X Y : Type*}
    [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X] [StandardBorelSpace X]
    [TopologicalSpace Y] [MeasurableSpace Y] [BorelSpace Y] [StandardBorelSpace Y]
    [CompactSpace X]
    (Φ : X → Y)
    (hΦ_cont : Continuous Φ)
    (hΦ_surj : Function.Surjective Φ)
    (hfib_compact : ∀ y, IsCompact (Φ ⁻¹' {y}))
    (hfib_ne : ∀ y, (Φ ⁻¹' {y}).Nonempty) :
    ∃ R : Y → X, Measurable R ∧ ∀ y, Φ (R y) = y := by
  sorry

/-! ## 4. kernel-infimum-epsilon-selection -/

theorem kernel_infimum_epsilon_selection
    {S M : Type*}
    [MeasurableSpace S] [TopologicalSpace S] [StandardBorelSpace S]
    [MeasurableSpace M] [TopologicalSpace M] [StandardBorelSpace M] [Nonempty M]
    (τ : Measure S)
    [IsFiniteMeasure τ]
    (g : S → M → ℝ)
    (hg_meas : Measurable fun p : S × M => g p.1 p.2)
    (hg_bdd : ∃ C, ∀ s m, |g s m| ≤ C)
    (hinf_meas : Measurable fun s => sInf (Set.range (g s))) :
    (∀ ε > 0, ∃ β : Kernel S M,
        IsMarkovKernel β ∧
        ∫ s, ∫ m, g s m ∂(β s) ∂τ
          ≤ (∫ s, sInf (Set.range (g s)) ∂τ) + ε) ∧
    (∀ β : Kernel S M, IsMarkovKernel β →
        (∫ s, sInf (Set.range (g s)) ∂τ)
          ≤ ∫ s, ∫ m, g s m ∂(β s) ∂τ) := by
  sorry

/-! ## 5. hausdorff-support-function-lipschitz -/

theorem hausdorff_support_function_lipschitz
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (ℓ : E →L[ℝ] ℝ) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ C D : TopologicalSpace.NonemptyCompacts E,
        |(sSup (ℓ '' (↑C : Set E))) - (sSup (ℓ '' (↑D : Set E)))|
          ≤ L * dist C D := by
  sorry

/-! ## 6. jankov-von-neumann-universal-selection -/

/-- Universal measurability: `f` is measurable with respect to every Borel completion. -/
def UniversallyMeasurable {X Y : Type*} [TopologicalSpace X] [MeasurableSpace X]
    [MeasurableSpace Y] (f : X → Y) : Prop :=
  ∀ μ : Measure X, IsFiniteMeasure μ → AEMeasurable f μ

theorem jankov_von_neumann_universal_selection
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace X] [BorelSpace X] [StandardBorelSpace X]
    [MeasurableSpace Y] [TopologicalSpace Y] [BorelSpace Y] [StandardBorelSpace Y] [Nonempty Y]
    (G : Set (X × Y))
    (hG_analytic : MeasureTheory.AnalyticSet G)
    (hsections : ∀ x, ∃ y, (x, y) ∈ G) :
    ∃ f : X → Y,
      UniversallyMeasurable f ∧ ∀ x, (x, f x) ∈ G := by
  sorry

/-! ## 7. geps-borel-selector-upgrade -/

structure GepsRegularity {M : Type*} [TopologicalSpace M] [MeasurableSpace M]
    (Gε : ℝ → M → Set M) (ε : ℝ) : Prop where
  closed_valued : ∀ s : M, IsClosed (Gε ε s)
  graph_measurable : MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}
  sections_measurable : ∀ s : M, MeasurableSet (Gε ε s)

theorem geps_borel_selector_upgrade
    {M : Type*}
    [MetricSpace M]
    [MeasurableSpace M] [BorelSpace M] [StandardBorelSpace M]
    [SecondCountableTopology M]
    [CompactSpace M]
    {Gε : ℝ → M → Set M}
    {ε : ℝ}
    (hε : 0 < ε)
    (hne : ∀ s : M, (Gε ε s).Nonempty)
    (hregular : GepsRegularity Gε ε) :
    ∃ mε : M → M,
      Measurable mε ∧ ∀ s : M, mε s ∈ Gε ε s := by
  sorry

/-! ## 8. bayes-posterior-as-conditional-barycenter -/

theorem bayes_posterior_as_conditional_barycenter
    {Ω : Type*} [Fintype Ω]
    {Belief : Type*} [TopologicalSpace Belief] [MeasurableSpace Belief]
    [BorelSpace Belief] [StandardBorelSpace Belief]
    {M : Type*} [TopologicalSpace M] [MeasurableSpace M] [BorelSpace M] [StandardBorelSpace M]
    (coord : Belief → Ω → ℝ)
    (hcoord_meas : ∀ ω, Measurable (fun s => coord s ω))
    (hcoord_nonneg : ∀ s ω, 0 ≤ coord s ω)
    (hcoord_sum : ∀ s, ∑ ω, coord s ω = 1)
    (μ0 : Ω → ℝ) (hμ0_nonneg : ∀ ω, 0 ≤ μ0 ω) (hμ0_sum : ∑ ω, μ0 ω = 1)
    (π : Ω → Measure Belief)
    [hπ_prob : ∀ ω, IsProbabilityMeasure (π ω)]
    (τ : Measure Belief)
    [IsProbabilityMeasure τ]
    (hposterior_consistency :
      ∀ ω, (ENNReal.ofReal (μ0 ω)) • (π ω) =
        τ.withDensity (fun s => ENNReal.ofReal (coord s ω)))
    (q : Measure M)
    [IsProbabilityMeasure q]
    (χ : Kernel Belief M)
    [IsMarkovKernel χ]
    (hq_marginal : q = (τ.compProd χ).map Prod.snd)
    (ρ : Kernel M Belief)
    [IsMarkovKernel ρ]
    (hρ_disintegration :
      q.compProd ρ =
        (τ.compProd χ).map (fun p : Belief × M => (p.2, p.1)))
    (P : M → Ω → ℝ)
    (hP_meas : ∀ ω, Measurable (fun m => P m ω))
    (hP_bayes_definition :
      ∀ ω : Ω, ∀ᵐ m ∂q,
        P m ω = (μ0 ω) *
          ((((π ω).compProd χ).map Prod.snd).rnDeriv q m).toReal) :
    ∀ᵐ m ∂q, ∀ ω : Ω, P m ω = ∫ s, coord s ω ∂(ρ m) := by
  sorry

/-! ## 9. support-function-measurable-integrated-separation -/

/-- A.e. pointwise version. -/
theorem support_function_ae_pointwise_separation
    {Ω : Type*} [Fintype Ω]
    {M : Type*} [MeasurableSpace M]
    (q : Measure M)
    [IsFiniteMeasure q]
    (B : M → Set (Ω → ℝ))
    (P : M → (Ω → ℝ))
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : M × (Ω → ℝ) | p.2 ∈ B p.1}) :
    (∀ᵐ m ∂q, P m ∈ B m) ↔
      (∀ᵐ m ∂q, ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, ℓ (P m) ≤ sSup (ℓ '' B m)) := by
  sorry

/-- Eventwise integrated Hall form. -/
theorem support_function_integrated_separation
    {Ω : Type*} [Fintype Ω]
    {M : Type*} [MeasurableSpace M]
    (q : Measure M)
    [IsFiniteMeasure q]
    (B : M → Set (Ω → ℝ))
    (P : M → (Ω → ℝ))
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : M × (Ω → ℝ) | p.2 ∈ B p.1})
    (hsupp_meas : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Integrable (fun m => ℓ (P m)) q) :
    ∀ E : Set M, MeasurableSet E → q E ≠ 0 →
      ((∀ᵐ m ∂q.restrict E, P m ∈ B m) ↔
        (∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ,
          ∫ m in E, ℓ (P m) ∂q ≤ ∫ m in E, sSup (ℓ '' B m) ∂q)) := by
  sorry

end Inventory

namespace RobustTrustV8

open MeasureTheory ProbabilityTheory
open scoped BigOperators ENNReal

noncomputable section

/-! ## Finite state simplex and generic model primitives -/

abbrev Belief (Ω : Type) [Fintype Ω] : Type :=
  {s : Ω → ℝ // (∀ ω : Ω, 0 ≤ s ω) ∧ (∑ ω : Ω, s ω) = 1}

def beliefCoord {Ω : Type} [Fintype Ω] (s : Belief Ω) (ω : Ω) : ℝ :=
  s.val ω

def beliefDot {Ω : Type} [Fintype Ω] (s : Belief Ω) (w : Ω → ℝ) : ℝ :=
  ∑ ω : Ω, s.val ω * w ω

def beliefAsProfile {Ω : Type} [Fintype Ω] (s : Belief Ω) : Ω → ℝ :=
  fun ω => s.val ω

noncomputable def beliefBarycenter {Ω : Type} [Fintype Ω]
    [MeasurableSpace (Belief Ω)] (ρ : Measure (Belief Ω)) : Ω → ℝ :=
  fun ω => ∫ s, s.val ω ∂ρ

structure RobustTrustModel where
  Ω : Type
  [Ω_fintype : Fintype Ω]
  [Ω_measurable : MeasurableSpace Ω]
  [Ω_nonempty : Nonempty Ω]

  Θ : Type
  [Θ_metric : MetricSpace Θ]
  [Θ_measurable : MeasurableSpace Θ]
  [Θ_borel : BorelSpace Θ]
  [Θ_standardBorel : StandardBorelSpace Θ]
  [Θ_secondCountable : SecondCountableTopology Θ]
  [Θ_compact : CompactSpace Θ]
  [Θ_nonempty : Nonempty Θ]

  A : Type
  [A_metric : MetricSpace A]
  [A_measurable : MeasurableSpace A]
  [A_borel : BorelSpace A]
  [A_standardBorel : StandardBorelSpace A]
  [A_secondCountable : SecondCountableTopology A]
  [A_compact : CompactSpace A]
  [A_nonempty : Nonempty A]

  M : Type
  [M_metric : MetricSpace M]
  [M_measurable : MeasurableSpace M]
  [M_borel : BorelSpace M]
  [M_standardBorel : StandardBorelSpace M]
  [M_secondCountable : SecondCountableTopology M]
  [M_compact : CompactSpace M]
  [M_nonempty : Nonempty M]

  PrivateStrategy : Type
  [PrivateStrategy_topological : TopologicalSpace PrivateStrategy]
  [PrivateStrategy_measurable : MeasurableSpace PrivateStrategy]
  [PrivateStrategy_borel : BorelSpace PrivateStrategy]
  [PrivateStrategy_standardBorel : StandardBorelSpace PrivateStrategy]
  [PrivateStrategy_compact : CompactSpace PrivateStrategy]
  [PrivateStrategy_nonempty : Nonempty PrivateStrategy]

  μ0 : Ω → ℝ
  μ0_nonneg : ∀ ω : Ω, 0 ≤ μ0 ω
  μ0_sum : ∑ ω : Ω, μ0 ω = 1
  μ0_fullSupport : ∀ ω : Ω, 0 < μ0 ω

  π : Ω → Measure (Belief Ω)
  τ : Measure (Belief Ω)
  τ_prob : IsProbabilityMeasure τ

  inclM : M → Belief Ω
  inclM_measurable : Measurable inclM
  τM : Measure M
  τM_prob : IsProbabilityMeasure τM

  typeLaw : Ω → Measure Θ
  typeLaw_prob : ∀ ω : Ω, IsProbabilityMeasure (typeLaw ω)

  u : A → Ω → Θ → ℝ
  payoff_bounded : ∃ C : ℝ, ∀ a ω θ, |u a ω θ| ≤ C
  payoff_continuous_in_action : ∀ ω θ, Continuous fun a => u a ω θ
  payoff_measurable : Measurable fun p : A × Ω × Θ => u p.1 p.2.1 p.2.2
  conditional_independence : Prop

  α : ℝ
  α_nonneg : 0 ≤ α
  α_le_one : α ≤ 1

  profileOfPrivate : PrivateStrategy → Ω → ℝ
  private_profile_bounded : ∃ C : ℝ, ∀ σ ω, |profileOfPrivate σ ω| ≤ C

attribute [instance]
  RobustTrustModel.Ω_fintype
  RobustTrustModel.Ω_measurable
  RobustTrustModel.Ω_nonempty
  RobustTrustModel.Θ_metric
  RobustTrustModel.Θ_measurable
  RobustTrustModel.Θ_borel
  RobustTrustModel.Θ_standardBorel
  RobustTrustModel.Θ_secondCountable
  RobustTrustModel.Θ_compact
  RobustTrustModel.Θ_nonempty
  RobustTrustModel.A_metric
  RobustTrustModel.A_measurable
  RobustTrustModel.A_borel
  RobustTrustModel.A_standardBorel
  RobustTrustModel.A_secondCountable
  RobustTrustModel.A_compact
  RobustTrustModel.A_nonempty
  RobustTrustModel.M_metric
  RobustTrustModel.M_measurable
  RobustTrustModel.M_borel
  RobustTrustModel.M_standardBorel
  RobustTrustModel.M_secondCountable
  RobustTrustModel.M_compact
  RobustTrustModel.M_nonempty
  RobustTrustModel.PrivateStrategy_topological
  RobustTrustModel.PrivateStrategy_measurable
  RobustTrustModel.PrivateStrategy_borel
  RobustTrustModel.PrivateStrategy_standardBorel
  RobustTrustModel.PrivateStrategy_compact
  RobustTrustModel.PrivateStrategy_nonempty

abbrev Profile (model : RobustTrustModel) : Type :=
  model.Ω → ℝ

structure PriorAdviserPosteriorLaw (model : RobustTrustModel) where
  unconditional_law_identity :
    model.τ = ∑ ω : model.Ω, (ENNReal.ofReal (model.μ0 ω)) • model.π ω
  support_is_range : Set.range model.inclM = Set.univ ∨ True

structure PosteriorLawConsistency (model : RobustTrustModel) where
  coordinate_measure_identity :
    ∀ ω : model.Ω,
      (ENNReal.ofReal (model.μ0 ω)) • model.π ω =
        model.τ.withDensity (fun s => ENNReal.ofReal (beliefCoord s ω))
  barycenter_eq_prior : beliefBarycenter model.τ = model.μ0
  posteriorAfterAdviser : Belief model.Ω → Belief model.Ω
  posterior_after_adviser_ae :
    ∀ᵐ s ∂model.τ, posteriorAfterAdviser s = s

structure MessageSupportM (model : RobustTrustModel) where
  supportSet : Set (Belief model.Ω)
  support_eq_range : supportSet = Set.range model.inclM
  support_closed : IsClosed supportSet
  support_measurable : MeasurableSet supportSet
  τM_pushforward : model.τM.map model.inclM = model.τ

structure TypeActionPayoffPrimitives (model : RobustTrustModel) : Prop where
  bounded : ∃ C : ℝ, ∀ a ω θ, |model.u a ω θ| ≤ C
  continuous_in_action : ∀ ω θ, Continuous fun a => model.u a ω θ
  measurable_payoff : Measurable fun p : model.A × model.Ω × model.Θ =>
    model.u p.1 p.2.1 p.2.2
  conditional_independence : model.conditional_independence

structure PrivateStrategySpace (model : RobustTrustModel) where
  actKernel : model.PrivateStrategy → Kernel model.Θ model.A
  actKernel_markov : ∀ σ, IsMarkovKernel (actKernel σ)
  defaultPrivateStrategy : model.PrivateStrategy
  profile_eq : model.PrivateStrategy → Profile model

structure AgentStrategyFull (model : RobustTrustModel) where
  sectionFull : Belief model.Ω → model.PrivateStrategy
  measurable_sectionFull : Measurable sectionFull

structure AgentStrategyM (model : RobustTrustModel) where
  sectionM : model.M → model.PrivateStrategy
  measurable_sectionM : Measurable sectionM

def restrictFullToM (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : AgentStrategyM model :=
  { sectionM := fun m => σFull.sectionFull (model.inclM m)
    measurable_sectionM := σFull.measurable_sectionFull.comp model.inclM_measurable }

structure MessageRestrictionBridge (model : RobustTrustModel) where
  support : MessageSupportM model
  defaultPrivateStrategy : model.PrivateStrategy
  restrictFull : AgentStrategyFull model → AgentStrategyM model
  restrictFull_eq : ∀ σ m, (restrictFull σ).sectionM m = σ.sectionFull (model.inclM m)
  extendRestricted : AgentStrategyM model → AgentStrategyFull model
  extendRestricted_eq :
    ∀ σM m, (extendRestricted σM).sectionFull (model.inclM m) = σM.sectionM m
  offSupportIrrelevant : Prop

structure AdviserKernel (model : RobustTrustModel) where
  kernel : Kernel model.M model.M
  isMarkov : IsMarkovKernel kernel

structure FullMessageAdviserKernel (model : RobustTrustModel) where
  kernel : Kernel model.M (Belief model.Ω)
  isMarkov : IsMarkovKernel kernel

noncomputable def PrivatePayoff (model : RobustTrustModel)
    (σhat : model.PrivateStrategy) (μ : Belief model.Ω) : ℝ :=
  beliefDot μ (model.profileOfPrivate σhat)

def IsBayesOptimal (model : RobustTrustModel)
    (σhat : model.PrivateStrategy) (μ : Belief model.Ω) : Prop :=
  ∀ σhat' : model.PrivateStrategy,
    PrivatePayoff model σhat' μ ≤ PrivatePayoff model σhat μ

noncomputable def profileMap (model : RobustTrustModel)
    (σM : AgentStrategyM model) (m : model.M) : Profile model :=
  model.profileOfPrivate (σM.sectionM m)

noncomputable def AlignedPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM

noncomputable def MisalignedPayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM

noncomputable def MixturePayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  model.α * AlignedPayoffM model σM +
    (1 - model.α) * MisalignedPayoffM model β σM

noncomputable def RobustPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM)

noncomputable def UStarM (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σM : AgentStrategyM model => RobustPayoffM model σM)

noncomputable def AlignedPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  AlignedPayoffM model (restrictFullToM model σFull)

noncomputable def MisalignedPayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  MisalignedPayoffM model β (restrictFullToM model σFull)

noncomputable def MixturePayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * MisalignedPayoffFull model β σFull

noncomputable def RobustPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffFull model β σFull)

noncomputable def UStarFull (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σFull : AgentStrategyFull model => RobustPayoffFull model σFull)

noncomputable def MisalignedPayoffFullRaw (model : RobustTrustModel)
    (βFull : FullMessageAdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s)
      (model.profileOfPrivate (σFull.sectionFull m)) ∂(βFull.kernel s) ∂model.τM

noncomputable def MixturePayoffFullRaw (model : RobustTrustModel)
    (βFull : FullMessageAdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * MisalignedPayoffFullRaw model βFull σFull

def IsAdversarialFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : Prop :=
  MixturePayoffFull model β σFull = RobustPayoffFull model σFull

def IsAdversarialM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : Prop :=
  MixturePayoffM model β σM = RobustPayoffM model σM

noncomputable def MixtureMessageLaw (model : RobustTrustModel)
    (β : AdviserKernel model) : Measure model.M :=
  (ENNReal.ofReal model.α) • model.τM +
    (ENNReal.ofReal (1 - model.α)) • ((model.τM.compProd β.kernel).map Prod.snd)

def PositiveQMass (model : RobustTrustModel)
    (N : Set model.M) (β : AdviserKernel model) : Prop :=
  0 < MixtureMessageLaw model β N

structure PosteriorDisintegration (model : RobustTrustModel) where
  Pβ : AdviserKernel model → model.M → Belief model.Ω
  Pγα : model.M → Belief model.Ω
  Pβ_measurable : ∀ β, Measurable (Pβ β)
  Pγα_measurable : Measurable Pγα
  conditional_barycenter : Prop

def Definition2QAEPredicate (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : Prop :=
  IsAdversarialFull model β σFull ∧
    ∀ᵐ m ∂MixtureMessageLaw model β,
      IsBayesOptimal model (σFull.sectionFull (model.inclM m)) (pd.Pβ β m)

/-! ## Payoff-profile menu engine objects -/

def PayoffProfileSet (model : RobustTrustModel) : Set (Profile model) :=
  Set.range model.profileOfPrivate

abbrev ProfileInW (model : RobustTrustModel) : Type :=
  {w : Profile model // w ∈ PayoffProfileSet model}

structure ProfileRealizationSetup (model : RobustTrustModel) where
  Φ : model.PrivateStrategy → Profile model
  Φ_eq_profile : Φ = model.profileOfPrivate
  Φ_continuous : Continuous Φ
  W_compact : IsCompact (PayoffProfileSet model)
  W_convex : Convex ℝ (PayoffProfileSet model)
  Φ_surjective_onto_W :
    ∀ w : Profile model, w ∈ PayoffProfileSet model → ∃ σ, Φ σ = w
  fibers_compact : ∀ w : Profile model, IsCompact (Φ ⁻¹' {w})
  fibers_nonempty : ∀ w : Profile model, w ∈ PayoffProfileSet model →
    (Φ ⁻¹' {w}).Nonempty

structure ProfileRealizationMap (model : RobustTrustModel) where
  R : ProfileInW model → model.PrivateStrategy
  measurable_R : Measurable R
  right_inverse : ∀ w : ProfileInW model, model.profileOfPrivate (R w) = w.val

abbrev CompactMenu (model : RobustTrustModel) : Type :=
  TopologicalSpace.NonemptyCompacts (ProfileInW model)

noncomputable def maxPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def minPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sInf ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def MenuFunctionalF (model : RobustTrustModel)
    (C : CompactMenu model) : ℝ :=
  ∫ s, model.α * maxPayoff model C s +
    (1 - model.α) * minPayoff model C s ∂model.τM

structure OptimalMenuCstar (model : RobustTrustModel) where
  Cstar : CompactMenu model
  optimal : ∀ C : CompactMenu model, MenuFunctionalF model C ≤ MenuFunctionalF model Cstar
  value_eq : MenuFunctionalF model Cstar = UStarM model

structure AlignedBestLabelingWstar (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) where
  wstar : model.M → ProfileInW model
  measurable_wstar : Measurable wstar
  mem_Cstar : ∀ m : model.M, wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))
  is_argmax :
    ∀ m : model.M,
      IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
        (↑opt.Cstar : Set (ProfileInW model)) (wstar m)

structure PrunedMenuCdagger (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    (wlabel : AlignedBestLabelingWstar model opt) where
  Cdagger : CompactMenu model
  subset_Cstar :
    (↑Cdagger : Set (ProfileInW model)) ⊆ (↑opt.Cstar : Set (ProfileInW model))
  closure_range_subset :
    closure (Set.range wlabel.wstar) ⊆ (↑Cdagger : Set (ProfileInW model))
  range_dense :
    (↑Cdagger : Set (ProfileInW model)) ⊆ closure (Set.range wlabel.wstar)
  value_preserved : MenuFunctionalF model Cdagger = MenuFunctionalF model opt.Cstar

def RowwiseContactG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (s : model.M) : Set model.M :=
  {m : model.M |
    beliefDot (model.inclM s) (wlabel.wstar m).val =
      minPayoff model cdagger.Cdagger s}

def EpsilonContactGeps (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (ε : ℝ) (s : model.M) : Set model.M :=
  {m : model.M |
    beliefDot (model.inclM s) (wlabel.wstar m).val ≤
      minPayoff model cdagger.Cdagger s + ε}

structure ExactContact (model : RobustTrustModel) where
  opt : OptimalMenuCstar model
  wlabel : AlignedBestLabelingWstar model opt
  cdagger : PrunedMenuCdagger model wlabel
  selector : model.M → model.M
  selector_measurable : Measurable selector
  selector_mem :
    ∀ᵐ s ∂model.τM, selector s ∈ RowwiseContactG model cdagger s

def KernelSupportedOnG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (κ : AdviserKernel model) : Prop :=
  ∀ᵐ s ∂model.τM, κ.kernel s (RowwiseContactG model cdagger s) = 1

structure ExactAdversaryKernel (model : RobustTrustModel)
    (ec : ExactContact model) (β : AdviserKernel model) : Prop where
  deterministic_selector :
    ∃ mstar : model.M → model.M,
      Measurable mstar ∧
      ∀ᵐ s ∂model.τM, mstar s ∈ RowwiseContactG model ec.cdagger s
  supported_exact : KernelSupportedOnG model ec.cdagger β

structure MenuHallAdversaryKernel (model : RobustTrustModel)
    (ec : ExactContact model) where
  κ : AdviserKernel model
  supported : KernelSupportedOnG model ec.cdagger κ

noncomputable def MixtureCouplingGammaAlpha (model : RobustTrustModel)
    (κ : AdviserKernel model) : Measure (model.M × model.M) :=
  (ENNReal.ofReal model.α) • (model.τM.map (fun s : model.M => (s, s))) +
    (ENNReal.ofReal (1 - model.α)) • (model.τM.compProd κ.kernel)

def BayesOptimalityBeliefCorrespondenceBm (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) (m : model.M) : Set (Belief model.Ω) :=
  {μ : Belief model.Ω |
    IsBayesOptimal model (σFull.sectionFull (model.inclM m)) μ}

structure MenuHall (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σFull : AgentStrategyFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model) where
  supported : KernelSupportedOnG model ec.cdagger κ
  q : Measure model.M
  q_eq_qκ : q = MixtureMessageLaw model κ
  q_eq_gamma_second : q = (MixtureCouplingGammaAlpha model κ).map Prod.snd
  calibration :
    ∀ᵐ m ∂q, pd.Pγα m ∈ BayesOptimalityBeliefCorrespondenceBm model σFull m

def PosteriorCalibrationProfiles (model : RobustTrustModel)
    (q : Measure model.M)
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model) : Prop :=
  ∀ᵐ m ∂q, P m ∈ B m

def SupportFunctionHallInequalities (model : RobustTrustModel)
    (q : Measure model.M)
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model) : Prop :=
  ∀ E : Set model.M, MeasurableSet E → q E ≠ 0 →
    ∀ ℓ : Profile model →L[ℝ] ℝ,
      ∫ m in E, ℓ (P m) ∂q ≤ ∫ m in E, sSup (ℓ '' B m) ∂q

structure SupportFunctionHallForm (model : RobustTrustModel) where
  q : Measure model.M
  B : model.M → Set (Profile model)
  P : model.M → Profile model
  hall : SupportFunctionHallInequalities model q B P

/-! ## WTA sharpness objects -/

abbrev WTAΩ : Type := Fin 3
abbrev WTAProfile : Type := WTAΩ → ℝ
abbrev WTABelief : Type := Belief WTAΩ

structure WTATernaryAlgebra where
  μ0 : WTABelief
  μ0_coord : ∀ i : WTAΩ, μ0.val i = (1 : ℝ) / 3
  τ : Measure WTABelief
  τ_prob : IsProbabilityMeasure τ

structure AtomlessTauSharpness (wta : WTATernaryAlgebra) where
  noAtoms : NoAtoms wta.τ

def WTA_vertex (i : WTAΩ) : WTAProfile :=
  fun j => if i = j then 1 else -1

def WTA_mixedLabel (lam : WTAΩ → ℝ) : WTAProfile :=
  fun j => ∑ i : WTAΩ, lam i * WTA_vertex i j

def WTASupport (lam : WTAΩ → ℝ) : Set WTAΩ :=
  {i : WTAΩ | 0 < lam i}

def WTAKminus (I : Set WTAΩ) : Set WTABelief :=
  {s : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, s.val i ≤ s.val k}

def WTABcone (I : Set WTAΩ) : Set WTABelief :=
  {p : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p.val k ≤ p.val i}

def WTABconeProfile (I : Set WTAΩ) : Set WTAProfile :=
  {p : WTAProfile | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p k ≤ p i}

def WTARowwiseMinimizer (I : Set WTAΩ) (lam : WTAΩ → ℝ)
    (s : WTABelief) : Prop :=
  s ∈ WTAKminus I

def WTABayesOptimalWTA (I : Set WTAΩ) (lam : WTAΩ → ℝ)
    (p : WTABelief) : Prop :=
  p ∈ WTABcone I

structure NullDustData (wta : WTATernaryAlgebra) where
  N : Set WTABelief
  measurable_N : MeasurableSet N
  tau_null : wta.τ N = 0
  wN : {m : WTABelief // m ∈ N} → WTAProfile
  lam : {m : WTABelief // m ∈ N} → WTAΩ → ℝ
  I : {m : WTABelief // m ∈ N} → Set WTAΩ
  lam_measurable : True
  lam_nonneg : ∀ m i, 0 ≤ lam m i
  lam_sum_one : ∀ m, ∑ i : WTAΩ, lam m i = 1
  lam_support_nonempty : ∀ m, (I m).Nonempty
  lam_support_positive : ∀ m i, i ∈ I m ↔ 0 < lam m i
  wN_eq_mixed_label : ∀ m, wN m = WTA_mixedLabel (lam m)

abbrev NDust {wta : WTATernaryAlgebra} (dust : NullDustData wta) : Type :=
  {m : WTABelief // m ∈ dust.N}

structure AdversarialFlowDisintegrationData
    (wta : WTATernaryAlgebra) (dust : NullDustData wta) where
  α : ℝ
  α_nonneg : 0 ≤ α
  α_le_one : α ≤ 1
  κ : Kernel WTABelief WTABelief
  κ_markov : IsMarkovKernel κ
  ν : Measure (WTABelief × WTABelief)
  νN : Measure (WTABelief × NDust dust)
  qN : Measure (NDust dust)
  ρ : NDust dust → Measure WTABelief
  ρ_prob : ∀ m, IsProbabilityMeasure (ρ m)
  disintegration_identity : Prop

def RowwiseSupport (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) : Prop :=
  ∀ᵐ p ∂flow.νN, p.1 ∈ WTAKminus (dust.I p.2)

def BayesConeCalibration (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) : Prop :=
  ∀ᵐ m ∂flow.qN, beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m)

noncomputable def WTAMixtureMessageLaw (wta : WTATernaryAlgebra)
    (α : ℝ) (κ : Kernel WTABelief WTABelief) : Measure WTABelief :=
  (ENNReal.ofReal α) • wta.τ +
    (ENNReal.ofReal (1 - α)) • ((wta.τ.compProd κ).map Prod.snd)

def WTAPositiveQMass (wta : WTATernaryAlgebra)
    (α : ℝ) (N : Set WTABelief) (κ : Kernel WTABelief WTABelief) : Prop :=
  0 < WTAMixtureMessageLaw wta α κ N

/-! ## Halfspace witness objects -/

def HalfspaceTrustRegion : Set WTABelief :=
  {μ : WTABelief | μ.val (0 : Fin 3) ≤ (2 : ℝ) / 5}

def FullSimplexTrustRegion : Set WTABelief :=
  Set.univ

def WTAInducesVertex (μ : WTABelief) (i : WTAΩ) : Prop :=
  ∀ k : WTAΩ, μ.val k ≤ μ.val i

def ContainsBeliefsForAllVertices (T : Set WTABelief) : Prop :=
  ∀ i : WTAΩ, ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i

def FullWTAVertexMenu : Set WTAProfile :=
  Set.range WTA_vertex

def InducedEffectiveMenu (T : Set WTABelief) : Set WTAProfile :=
  {v : WTAProfile |
    ∃ i : WTAΩ, v = WTA_vertex i ∧ ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i}

def BehaviorEquivalentTrustRegion (T U : Set WTABelief) : Prop :=
  InducedEffectiveMenu T = InducedEffectiveMenu U

def MenuEngineArtifact (T : Set WTABelief) : Prop :=
  ContainsBeliefsForAllVertices T ∧
    InducedEffectiveMenu T = FullWTAVertexMenu ∧
    BehaviorEquivalentTrustRegion T FullSimplexTrustRegion

structure EffectiveMenuEquivalenceData where
  T : Set WTABelief
  contains_all_vertices : ContainsBeliefsForAllVertices T
  induced_full_vertices : InducedEffectiveMenu T = FullWTAVertexMenu
  behavior_equivalent : BehaviorEquivalentTrustRegion T FullSimplexTrustRegion

/-! ## Package statement definitions -/

def Tier1aResult (model : RobustTrustModel)
    (σstar : AgentStrategyFull model) : Prop :=
  RobustPayoffFull model σstar = UStarFull model ∧
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε

def Tier1bResult (model : RobustTrustModel)
    (σstar : AgentStrategyFull model) : Prop :=
  ∃ βstar : AdviserKernel model,
    IsAdversarialFull model βstar σstar ∧
      MixturePayoffFull model βstar σstar = RobustPayoffFull model σstar ∧
      RobustPayoffFull model σstar = UStarFull model

def Tier2Result (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) : Prop :=
  (let βstar : AdviserKernel model := κ;
    βstar = κ ∧
      mh.q = MixtureMessageLaw model κ ∧
      mh.q = (MixtureCouplingGammaAlpha model κ).map Prod.snd ∧
      IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model ∧
      Definition2QAEPredicate model pd κ σstar ∧
      (0 < model.α →
        ∀ᵐ m ∂model.τM,
          IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα m)))

def WTA_ConeIntersectionStatement : Prop :=
  ∀ (wta : WTATernaryAlgebra) (I : Set WTAΩ), I.Nonempty →
    ∀ ρ : Measure WTABelief, IsProbabilityMeasure ρ →
      ρ (WTAKminus I) = 1 →
      beliefBarycenter ρ ∈ WTABconeProfile I →
      ρ = Measure.dirac wta.μ0

def WTA_NoFreeDustStatement : Prop :=
  ∀ (wta : WTATernaryAlgebra), AtomlessTauSharpness wta →
    ∀ α : ℝ, 0 ≤ α → α ≤ 1 →
      ¬ ∃ (dust : NullDustData wta)
          (flow : AdversarialFlowDisintegrationData wta dust),
        WTAPositiveQMass wta α dust.N flow.κ ∧
          RowwiseSupport wta dust flow ∧
          BayesConeCalibration wta dust flow

def HalfspaceWitnessStatement : Prop :=
  ContainsBeliefsForAllVertices HalfspaceTrustRegion ∧
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu ∧
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion

def RobustTrustInfiniteExtensionV8Package
    (model : RobustTrustModel)
    (_plc : PosteriorLawConsistency model)
    (_prs : ProfileRealizationSetup model) : Prop :=
  ∃ σstar : AgentStrategyFull model,
    Tier1aResult model σstar ∧
      (∀ ec : ExactContact model, Tier1bResult model σstar) ∧
      (∀ (pd : PosteriorDisintegration model)
          (ec : ExactContact model)
          (κ : AdviserKernel model)
          (mh : MenuHall model pd σstar ec κ),
        Tier2Result model pd σstar ec κ mh) ∧
      WTA_ConeIntersectionStatement ∧
      WTA_NoFreeDustStatement ∧
      HalfspaceWitnessStatement

/-! ## 59 theorem declarations in dependency order -/

theorem posterior_law_barycenter_identities
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model) :
    beliefBarycenter model.τ = model.μ0 ∧
      (∀ ω : model.Ω,
        (ENNReal.ofReal (model.μ0 ω)) • model.π ω =
          model.τ.withDensity (fun s => ENNReal.ofReal (beliefCoord s ω))) ∧
      (∀ᵐ s ∂model.τ, plc.posteriorAfterAdviser s = s) := by
  sorry

theorem strategy_restriction_to_M
    (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, σM.sectionM m = σFull.sectionFull (model.inclM m) := by
  sorry

theorem restricted_agent_strategy_extends_to_full
    (model : RobustTrustModel)
    (bridge : MessageRestrictionBridge model)
    (σM : AgentStrategyM model) :
    ∃ σFull : AgentStrategyFull model,
      ∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m := by
  sorry

theorem outside_M_messages_irrelevant
    (model : RobustTrustModel)
    (σ₁ σ₂ : AgentStrategyFull model)
    (hagree : ∀ m : model.M,
      σ₁.sectionFull (model.inclM m) = σ₂.sectionFull (model.inclM m))
    (β : AdviserKernel model) :
    AlignedPayoffFull model σ₁ = AlignedPayoffFull model σ₂ ∧
      MisalignedPayoffFull model β σ₁ = MisalignedPayoffFull model β σ₂ ∧
      MixturePayoffFull model β σ₁ = MixturePayoffFull model β σ₂ ∧
      RobustPayoffFull model σ₁ = RobustPayoffFull model σ₂ := by
  sorry

theorem adversary_kernels_restrict_to_M
    (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) :
    sInf (Set.range fun βFull : FullMessageAdviserKernel model =>
        MixturePayoffFullRaw model βFull σFull) =
      sInf (Set.range fun βM : AdviserKernel model =>
        MixturePayoffFull model βM σFull) ∧
    RobustPayoffFull model σFull =
      RobustPayoffM model (restrictFullToM model σFull) := by
  sorry

theorem full_restricted_Ustar_equivalence
    (model : RobustTrustModel) :
    UStarFull model = UStarM model ∧
      ∀ (σFull : AgentStrategyFull model) (σM : AgentStrategyM model),
        (∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m) →
          RobustPayoffFull model σFull = RobustPayoffM model σM := by
  sorry

theorem q_dominates_tau_when_alpha_pos
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    {P : model.M → Prop}
    (hα : 0 < model.α)
    (hP : ∀ᵐ m ∂MixtureMessageLaw model β, P m) :
    ∀ᵐ m ∂model.τM, P m := by
  sorry

theorem payoff_profile_set_compact_convex
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    IsCompact (PayoffProfileSet model) ∧
      Convex ℝ (PayoffProfileSet model) ∧
      (∀ w : Profile model, w ∈ PayoffProfileSet model →
        ∃ σ : model.PrivateStrategy, model.profileOfPrivate σ = w) := by
  sorry

theorem profile_map_has_borel_right_inverse
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    ∃ R : ProfileInW model → model.PrivateStrategy,
      Measurable R ∧
        ∀ w : ProfileInW model, model.profileOfPrivate (R w) = w.val := by
  sorry

theorem borel_profile_map_implemented_by_agent_strategy
    (model : RobustTrustModel)
    (R : ProfileRealizationMap model)
    (wMap : model.M → ProfileInW model)
    (hwMap : Measurable wMap) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, profileMap model σM m = (wMap m).val := by
  sorry

theorem profile_payoff_decomposition_aligned
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (σM : AgentStrategyM model) :
    AlignedPayoffM model σM =
      ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM := by
  sorry

theorem profile_payoff_decomposition_misaligned
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (β : AdviserKernel model)
    (σM : AgentStrategyM model) :
    MisalignedPayoffM model β σM =
      ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM := by
  sorry

theorem mixture_payoff_decomposition
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    (σM : AgentStrategyM model)
    (σFull : AgentStrategyFull model) :
    MixturePayoffM model β σM =
        model.α * AlignedPayoffM model σM +
          (1 - model.α) * MisalignedPayoffM model β σM ∧
      MixturePayoffFull model β σFull =
        model.α * AlignedPayoffFull model σFull +
          (1 - model.α) * MisalignedPayoffFull model β σFull := by
  sorry

theorem adversary_infimum_pointwise
    (model : RobustTrustModel)
    (w : model.M → ProfileInW model)
    (hw_meas : Measurable w)
    (hw_bdd :
      ∃ C : ℝ, ∀ s m : model.M,
        |beliefDot (model.inclM s) (w m).val| ≤ C) :
    sInf (Set.range fun β : AdviserKernel model =>
      ∫ s, ∫ m, beliefDot (model.inclM s) (w m).val ∂(β.kernel s) ∂model.τM) =
        ∫ s, sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (w m).val) ∂model.τM := by
  sorry

theorem strategy_value_le_menu_sup
    (model : RobustTrustModel)
    (σM : AgentStrategyM model) :
    RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)) := by
  sorry

theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  sorry

theorem menu_value_equivalence
    (model : RobustTrustModel) :
    UStarM model = sSup (Set.range (MenuFunctionalF model)) := by
  sorry

theorem compact_menu_space_compact
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    CompactSpace (CompactMenu model) := by
  sorry

theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D := by
  sorry

theorem menu_functional_continuity
    (model : RobustTrustModel) :
    Continuous (MenuFunctionalF model) := by
  sorry

theorem optimal_menu_exists
    (model : RobustTrustModel) :
    ∃ Cstar : CompactMenu model,
      ∀ C : CompactMenu model, MenuFunctionalF model C ≤ MenuFunctionalF model Cstar := by
  sorry

theorem aligned_best_labeling_selection
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) :
    ∃ wstar : AlignedBestLabelingWstar model opt, True := by
  sorry

theorem closure_pruning_value_preservation
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt) :
    ∃ cdagger : PrunedMenuCdagger model wlabel,
      (↑cdagger.Cdagger : Set (ProfileInW model)) ⊆
          (↑opt.Cstar : Set (ProfileInW model)) ∧
        MenuFunctionalF model cdagger.Cdagger = MenuFunctionalF model opt.Cstar ∧
        MenuFunctionalF model opt.Cstar = UStarM model := by
  sorry

theorem wstar_profile_map_implemented
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, profileMap model σM m = (wlabel.wstar m).val := by
  sorry

theorem wstar_payoff_equals_F_Cdagger
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    (σM : AgentStrategyM model)
    (hprofile : ∀ m : model.M, profileMap model σM m = (wlabel.wstar m).val) :
    AlignedPayoffM model σM =
        ∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM ∧
      sInf (Set.range fun β : AdviserKernel model => MisalignedPayoffM model β σM) =
        ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM ∧
      RobustPayoffM model σM = MenuFunctionalF model cdagger.Cdagger := by
  sorry

theorem sigma_star_robust_optimal
    (model : RobustTrustModel)
    (σstarM : AgentStrategyM model)
    (hσstarM : RobustPayoffM model σstarM = UStarM model) :
    ∃ σstarFull : AgentStrategyFull model,
      RobustPayoffFull model σstarFull = UStarFull model ∧
        ∀ m : model.M, σstarFull.sectionFull (model.inclM m) = σstarM.sectionM m := by
  sorry

theorem geps_nonempty
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    ∀ s : model.M, (EpsilonContactGeps model cdagger ε s).Nonempty := by
  sorry

theorem geps_graph_measurable
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    MeasurableSet
      {p : model.M × model.M | p.2 ∈ EpsilonContactGeps model cdagger ε p.1} := by
  sorry

theorem geps_selector_exists
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    ∃ mε : model.M → model.M,
      Measurable mε ∧
        ∀ s : model.M, mε s ∈ EpsilonContactGeps model cdagger ε s := by
  sorry

theorem epsilon_adversary_realization
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model) :
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε := by
  sorry

theorem exact_contact_selector_unpack
    (model : RobustTrustModel)
    (ec : ExactContact model) :
    ∃ mstar : model.M → model.M,
      Measurable mstar ∧
        ∀ᵐ s ∂model.τM, mstar s ∈ RowwiseContactG model ec.cdagger s := by
  sorry

theorem exact_adversary_attainment
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model) :
    ∃ βstar : AdviserKernel model,
      IsAdversarialFull model βstar σstar ∧
        MixturePayoffFull model βstar σstar = RobustPayoffFull model σstar ∧
        RobustPayoffFull model σstar = UStarFull model := by
  sorry

theorem menuHall_adversary_kernel_identity
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    (let βstar : AdviserKernel model := κ;
      βstar = κ ∧
        mh.q = MixtureMessageLaw model κ ∧
        mh.q = (MixtureCouplingGammaAlpha model κ).map Prod.snd) := by
  sorry

theorem menu_hall_posterior_calibration_unpack
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂mh.q, pd.Pγα m ∈ BayesOptimalityBeliefCorrespondenceBm model σstar m := by
  sorry

theorem menu_hall_support_implies_exact_adversary
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model := by
  sorry

theorem per_message_Bayes_optimality
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    (∀ᵐ m ∂mh.q,
      IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα m)) ∧
    (0 < model.α →
      ∀ᵐ m ∂model.τM,
        IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα m)) := by
  sorry

theorem posterior_disintegration_menuHall_kernel_coincides
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂MixtureMessageLaw model κ, pd.Pβ κ m = pd.Pγα m := by
  sorry

theorem support_function_pointwise_membership_equivalence
    (model : RobustTrustModel)
    (q : Measure model.M)
    [IsFiniteMeasure q]
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model)
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : model.M × Profile model | p.2 ∈ B p.1}) :
    (∀ᵐ m ∂q, P m ∈ B m) ↔
      (∀ᵐ m ∂q, ∀ ℓ : Profile model →L[ℝ] ℝ,
        ℓ (P m) ≤ sSup (ℓ '' B m)) := by
  sorry

theorem support_function_integrated_Hall_equivalence
    (model : RobustTrustModel)
    (q : Measure model.M)
    [IsFiniteMeasure q]
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model)
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : model.M × Profile model | p.2 ∈ B p.1}) :
    PosteriorCalibrationProfiles model q B P ↔
      SupportFunctionHallInequalities model q B P := by
  sorry

theorem tier1a_value_optimality_and_epsilon_adversary
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (prs : ProfileRealizationSetup model) :
    ∃ σstar : AgentStrategyFull model, Tier1aResult model σstar := by
  sorry

theorem tier1b_exact_adversary_under_exact_contact
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (prs : ProfileRealizationSetup model)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model) :
    ∃ βstar : AdviserKernel model,
      IsAdversarialFull model βstar σstar ∧
        MixturePayoffFull model βstar σstar = UStarFull model := by
  sorry

theorem tier2_qae_robust_rationalizability_under_menu_Hall
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (prs : ProfileRealizationSetup model)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    Tier2Result model pd σstar ec κ mh := by
  sorry

theorem wta_payoff_dot_product_identity
    (lam : WTAΩ → ℝ)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s : WTABelief) :
    beliefDot s (WTA_mixedLabel lam) =
      2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
  sorry

theorem wta_rowwise_minimizer_and_Bayes_cone_identification
    (I : Set WTAΩ)
    (lam : WTAΩ → ℝ)
    (hI : I.Nonempty)
    (hsupport : ∀ i : WTAΩ, i ∈ I ↔ 0 < lam i)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s p : WTABelief) :
    (WTARowwiseMinimizer I lam s ↔ s ∈ WTAKminus I) ∧
      (WTABayesOptimalWTA I lam p ↔ p ∈ WTABcone I) := by
  sorry

theorem wta_cone_intersection
    (wta : WTATernaryAlgebra)
    (I : Set WTAΩ)
    (hI : I.Nonempty)
    (ρ : Measure WTABelief)
    [IsProbabilityMeasure ρ]
    (hρ_support : ρ (WTAKminus I) = 1)
    (hbary : beliefBarycenter ρ ∈ WTABconeProfile I) :
    ρ = Measure.dirac wta.μ0 := by
  sorry

theorem dust_disintegration_over_subtype_N
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) :
    ∃ ρ : NDust dust → Measure WTABelief,
      (∀ m, IsProbabilityMeasure (ρ m)) ∧ ρ = flow.ρ := by
  sorry

theorem qN_supported_on_N
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) :
    ∀ᵐ m ∂flow.qN, (m.val : WTABelief) ∈ dust.N := by
  sorry

theorem dust_rowwise_support_implies_cone_support
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m (WTAKminus (dust.I m)) = 1 := by
  sorry

theorem dust_Bayes_calibration_gives_cone_barycenter
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN, beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m) := by
  sorry

theorem dust_conditional_sources_satisfy_cones
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN,
      flow.ρ m (WTAKminus (dust.I m)) = 1 ∧
        beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m) := by
  sorry

theorem cone_intersection_applied_to_dust
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0 := by
  sorry

theorem positive_dust_mass_impossible_when_alpha_one
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hα : flow.α = 1) :
    ¬ WTAPositiveQMass wta flow.α dust.N flow.κ := by
  sorry

theorem dust_positive_mass_forces_mu0_atom
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hpos : WTAPositiveQMass wta flow.α dust.N flow.κ)
    (hα : flow.α < 1)
    (hdirac : ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0) :
    0 < wta.τ ({wta.μ0} : Set WTABelief) := by
  sorry

theorem wta_no_free_dust
    (wta : WTATernaryAlgebra)
    (sharp : AtomlessTauSharpness wta)
    (α : ℝ)
    (hα0 : 0 ≤ α)
    (hα1 : α ≤ 1) :
    ¬ ∃ (dust : NullDustData wta)
        (flow : AdversarialFlowDisintegrationData wta dust),
      WTAPositiveQMass wta α dust.N flow.κ ∧
        RowwiseSupport wta dust flow ∧
        BayesConeCalibration wta dust flow := by
  sorry

theorem sharpness_corollary
    (wta : WTATernaryAlgebra)
    (sharp : AtomlessTauSharpness wta)
    (α : ℝ)
    (hα0 : 0 ≤ α)
    (hα1 : α ≤ 1) :
    (∀ ρ : Measure WTABelief, IsProbabilityMeasure ρ →
      ρ (WTAKminus ({(0 : Fin 3)} : Set WTAΩ)) = 1 →
      beliefBarycenter ρ ∈ WTABconeProfile ({(0 : Fin 3)} : Set WTAΩ) →
      ρ = Measure.dirac wta.μ0) ∧
    (¬ ∃ (dust : NullDustData wta)
        (flow : AdversarialFlowDisintegrationData wta dust),
      WTAPositiveQMass wta α dust.N flow.κ ∧
        RowwiseSupport wta dust flow ∧
        BayesConeCalibration wta dust flow) := by
  sorry

theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := by
  sorry

theorem halfspace_induced_effective_menu_equals_full_vertices :
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu := by
  sorry

theorem halfspace_behavior_equivalent_to_full_simplex :
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion := by
  sorry

theorem halfspace_witness_menu_engine_artifact :
    HalfspaceWitnessStatement := by
  sorry

/-! ## Main theorem package -/

theorem robust_trust_infinite_extension_v8_package
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (prs : ProfileRealizationSetup model) :
    RobustTrustInfiniteExtensionV8Package model plc prs := by
  sorry

end

end RobustTrustV8

```

## Decomposition (structurer DAG — ground truth)

lean_structure
main_theorem: robust-trust-infinite-extension-v8-package
object_count: 53
lemma_count: 59
external_count: 17
implicit_assumption_count: 0
non_mathlib_count: 9
Objects and Definitions
robust-trust-model

English name: Robust Trust model instance

Informal type: A bundled model satisfying the standing Robust Trust hypotheses: finite state space, full-support prior, adviser posterior process, compact metric type and action spaces, bounded payoff continuous in action, conditional independence of adviser posterior and type given state, and alignment probability.

Suggested Lean modeling: structure

Key fields / operations:
Ω : Type, [Fintype Ω]; μ0 : ProbabilityMass Ω; fullSupport μ0; Belief Ω := {s : Ω → ℝ // (∀ ω, 0 ≤ s ω) ∧ ∑ ω, s ω = 1}; π : Ω → ProbabilityMeasure (Belief Ω); τ : ProbabilityMeasure (Belief Ω); Θ A : Type; compact metric and standard-Borel structures; [Nonempty Θ]; [Nonempty A]; u : A → Ω → Θ → ℝ; boundedness; continuity in action; measurability; conditional type laws; conditional independence of adviser posterior and type given state; α : ℝ; 0 ≤ α; α ≤ 1.

Used by: all positive-tier objects and WTA specialization objects.

Modeling notes: Exact-contact, menu-Hall, and atomlessness are not standing fields. They remain theorem-level hypotheses or separate sharpness objects.

finite-state-and-belief-simplex

English name: Finite state space and belief simplex

Informal type: A finite state space Ω and the finite-dimensional probability simplex Δ Ω.

Suggested Lean modeling: subtype of Ω → ℝ.

Key fields / operations:
Belief Ω := {s : Ω → ℝ // (∀ ω, 0 ≤ s ω) ∧ ∑ ω, s ω = 1}; coordinate projections; dot product dot : Belief Ω → (Ω → ℝ) → ℝ; barycenter of a probability law on Belief Ω; finite sums over Ω.

Used by: posterior-law identities, payoff decompositions, menu extrema, WTA cone intersection.

Modeling notes: The nonnegativity condition is coordinatewise: ∀ ω, 0 ≤ s ω. Do not model it as a scalar inequality 0 ≤ s.

prior-and-adviser-posterior-law

English name: Prior and adviser posterior law

Informal type: The prior, state-conditional adviser-posterior laws, unconditional posterior law, and message support.

Suggested Lean modeling: fields inside robust-trust-model plus helper definitions.

Key fields / operations:
μ0; π; τ; unconditional law identity τ = ∑ ω, μ0 ω • π ω; support M := supp τ; inclusion M → Belief Ω; integration over τ.

Used by: posterior-law-barycenter-identities, message-support-M, mixture-message-law, posterior-disintegration, sharpness dust objects.

Modeling notes: Atomlessness is not part of this object. It is separated into AtomlessTauSharpness.

posterior-law-consistency-field

English name: Bayes-plausibility and posterior-law consistency

Informal type: A field asserting that the random variable s : Δ Ω is the Bayesian posterior generated by π and μ0.

Suggested Lean modeling: field in robust-trust-model or separate structure parameterized by the model.

Key fields / operations:
For each state coordinate ω, finite-measure identity
μ0 ω • π ω = (fun s => s ω) • τ;
barycenter identity ∫ s ∂τ = μ0;
posterior identity after observing adviser posterior s is s, τ-a.e.;
conditional barycenter identities after disintegration.

Used by: posterior-law-barycenter-identities, payoff-profile decompositions, menu-Hall posterior calibration, dust disintegration.

Modeling notes: This prevents silently treating an arbitrary law on Δ Ω as a posterior law.

message-support-M

English name: Message support space

Informal type: M := supp τ, treated as the on-path message space for aligned reports and as the restricted codomain for adversarial reports.

Suggested Lean modeling: subtype {s : Belief Ω // s ∈ supp τ}.

Key fields / operations:
inclM : M → Belief Ω; τM; M Borel and compact as closed support in compact simplex; standard-Borel structure; truthful identity report on M.

Used by: full and restricted strategy bridge, adversary kernels, mixture message law, contact correspondences.

Modeling notes: Using a subtype prevents kernels from accidentally using off-support messages in restricted arguments.

message-restriction-bridge

English name: Full-message to support-message bridge

Informal type: Data and propositions connecting the paper’s full message space Δ Ω to the menu engine’s support-message space M.

Suggested Lean modeling: structure plus bridge lemmas.

Key fields / operations:
restriction of full strategies to M; extension of restricted strategies to full Δ Ω by a default private strategy outside M; proof that M is Borel; proof that off-M values do not affect on-path payoffs; proof that adversarial kernels can be restricted to M without changing the robust value.

Used by: strategy-restriction-to-M, restricted-agent-strategy-extends-to-full, outside-M-messages-irrelevant, adversary-kernels-restrict-to-M, full-restricted-Ustar-equivalence.

Modeling notes: This is the formal bridge for the paper’s “without loss, adversarial strategies only use messages in M” line.

type-action-payoff-primitives

English name: Agent type, action, and payoff primitives

Informal type: Compact metric type space, compact metric action space, bounded payoff, and conditional type laws.

Suggested Lean modeling: fields inside robust-trust-model.

Key fields / operations:
Θ; A; nonemptiness; compact metric and measurable structures; typeLaw : Ω → ProbabilityMeasure Θ; u : A → Ω → Θ → ℝ; boundedness; continuity in action; measurability in all variables.

Used by: private-payoff-functional, payoff-profile-set-W, profile-realization-setup.

Modeling notes: Do not strengthen to continuity in type unless the source proof explicitly adds it.

private-strategy-space

English name: Private strategy space

Informal type: Measurable kernels or maps hatσ : Θ → Δ A.

Suggested Lean modeling: structure for measurable Markov kernels from Θ to A.

Key fields / operations:
actKernel : Θ → ProbabilityMeasure A; measurability; expected payoff against a belief; profile map Φ; nonempty default private strategy for full-message extension.

Used by: private-payoff-functional, profile-realization-setup, Bayes-optimality-belief-correspondence-Bm.

Modeling notes: Compactness/topology of this space comes through profile-realization-setup.

agent-strategy-full

English name: Full agent strategy space

Informal type: The paper’s strategy space Σ, measurable strategies on Δ Ω × Θ.

Suggested Lean modeling: structure for measurable kernels from Belief Ω × Θ to A, equivalently a measurable section from full messages to private strategies.

Key fields / operations:
sectionFull : Belief Ω → PrivateStrategy; measurability of (m, θ) ↦ action kernel; restriction to M.

Used by: definition2-qae-predicate, full payoff layer, restricted-agent-strategy-extends-to-full, full-restricted-Ustar-equivalence, main theorem package.

Modeling notes: The final Tier 1a and Tier 2 statements quantify over this object, not merely over the restricted menu-engine strategy.

agent-strategy-M

English name: Restricted agent strategy space on M

Informal type: Measurable strategies indexed only by messages in M, used internally by the menu engine.

Suggested Lean modeling: structure for measurable sections M → PrivateStrategy.

Key fields / operations:
sectionM : M → PrivateStrategy; profile map on M; induced restricted payoff objects; extension to full Σ.

Used by: menu-value equivalence, wstar-profile-map-implemented, sigma-star-robust-optimal.

Modeling notes: This is an auxiliary engine object. It is not the public strategy space of the theorem.

misaligned-adviser-kernel-space

English name: Misaligned adviser kernel space

Informal type: Borel Markov kernels β : M → Δ M mapping a source posterior to a distribution over reported messages.

Suggested Lean modeling: structure for measurable Markov kernels.

Key fields / operations:
β(dm | s); deterministic Dirac kernels; product measure τ ⊗ β; second marginal; support predicates; no absolute-continuity requirement with respect to τ.

Used by: misaligned-payoff, mixture-message-law, is-adversarial, exact and ε-adversaries, menu-Hall.

Modeling notes: Null-message dust is allowed, so do not impose β s ≪ τ.

private-payoff-functional

English name: Private-strategy payoff at a belief

Informal type: Expected payoff of a private strategy under a belief.

Suggested Lean modeling: definition.

Key fields / operations:
PrivatePayoff : PrivateStrategy → Belief Ω → ℝ;
IsBayesOptimal hatσ μ := ∀ hatσ', PrivatePayoff hatσ' μ ≤ PrivatePayoff hatσ μ.

Used by: Bayes-optimality-belief-correspondence-Bm, per-message-Bayes-optimality, definition2-qae-predicate.

Modeling notes: This is separate from the full robust payoff.

aligned-payoff

English name: Aligned payoff

Informal type: Payoff when the adviser is aligned and reports truthfully.

Suggested Lean modeling: two definitions, full and restricted, connected by bridge lemmas.

Key fields / operations:
AlignedPayoffFull σFull; AlignedPayoffM σM; profile form ∫_M s · wσ(s) τ(ds).

Used by: mixture-payoff, profile-payoff-decomposition-aligned, menu-value equivalence.

Modeling notes: This component is independent of any adversarial kernel.

misaligned-payoff

English name: Misaligned payoff against a kernel

Informal type: Payoff when the misaligned adviser uses kernel β.

Suggested Lean modeling: two definitions, full and restricted.

Key fields / operations:
MisalignedPayoffFull β σFull;
MisalignedPayoffM β σM;
profile form ∫_M ∫_M s · wσ(m) β(dm|s) τ(ds).

Used by: mixture-payoff, adversary-infimum-pointwise, exact-adversary-attainment.

Modeling notes: This is the misaligned component only, not the mixture payoff.

mixture-payoff

English name: Full mixture payoff against a fixed adversary

Informal type: Payoff against a specific misaligned kernel, including aligned and misaligned regimes.

Suggested Lean modeling: two definitions, full and restricted.

Key fields / operations:
MixturePayoffFull β σFull := α * AlignedPayoffFull σFull + (1 - α) * MisalignedPayoffFull β σFull;
MixturePayoffM β σM := α * AlignedPayoffM σM + (1 - α) * MisalignedPayoffM β σM.

Used by: robust-payoff, is-adversarial, epsilon-adversary-realization, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary.

Modeling notes: All adversary-attainment statements compare this object to robust payoff and U_star.

robust-payoff

English name: Robust payoff of an agent strategy

Informal type: Worst-case full mixture payoff over misaligned kernels.

Suggested Lean modeling: two definitions, full and restricted.

Key fields / operations:
RobustPayoffFull σFull := ⨅ β, MixturePayoffFull β σFull;
RobustPayoffM σM := ⨅ β, MixturePayoffM β σM.

Used by: U-star, is-adversarial, sigma-star-robust-optimal, tier1a.

Modeling notes: The full object is the paper object. The restricted object is the menu-engine auxiliary object.

U-star

English name: Robust value

Informal type: Supremum of robust payoff over agent strategies.

Suggested Lean modeling: two definitions plus equivalence theorem.

Key fields / operations:
UStarFull := ⨆ σFull : AgentStrategyFull, RobustPayoffFull σFull;
UStarM := ⨆ σM : AgentStrategyM, RobustPayoffM σM;
menu equivalent ⨆ C : 𝒦(W), F C.

Used by: menu-value-equivalence, full-restricted-Ustar-equivalence, sigma-star-robust-optimal, main theorem package.

Modeling notes: The theorem package exposes UStarFull.

is-adversarial

English name: Adversarial kernel predicate

Informal type: Predicate saying a kernel attains the worst-case mixture payoff against a strategy.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
IsAdversarialFull β σFull := MixturePayoffFull β σFull = RobustPayoffFull σFull;
restricted analogue for engine proofs.

Used by: definition2-qae-predicate, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary, tier2.

Modeling notes: This replaces ambiguous “adversarial against σ” prose.

mixture-message-law

English name: Mixture message marginal

Informal type: For a misaligned kernel β, the marginal law of observed messages under aligned truth-telling plus misaligned reporting.

Suggested Lean modeling: definition.

Key fields / operations:
q_β := α • τM + (1 - α) • (τ ⊗ β)_2;
domination α • τ ≤ q_β; restriction to dust sets;
PositiveQMass N κ := 0 < q_κ(N).

Used by: q-dominates-tau-when-alpha-pos, posterior-disintegration, definition2-qae-predicate, wta-no-free-dust.

Modeling notes: This is the underlying distribution for Definition 2 in infinite M.

posterior-disintegration

English name: Bayesian posterior after a message

Informal type: Regular conditional posterior over Ω after observing message m under the mixture law induced by β or by γα.

Suggested Lean modeling: definitions backed by disintegration theorem, with a.e. uniqueness.

Key fields / operations:
Pβ : AdviserKernel → M → Belief Ω;
Pγα : M → Belief Ω;
conditional source barycenter representation;
a.e. equality statements for chosen versions.

Used by: definition2-qae-predicate, menu-Hall-posterior-calibration-unpack, posterior-disintegration-menuHall-kernel-coincides, dust-conditional-sources-satisfy-cones.

Modeling notes: Since Ω is finite, posteriors can be represented coordinatewise by conditional expectations or barycenters.

definition2-qae-predicate

English name: Definition 2 q-a.e. robust rationalizability predicate

Informal type: Infinite-space reading of Definition 2 as a predicate on (β, σFull).

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
Definition2QAEPredicate β σFull := IsAdversarialFull β σFull ∧ ∀ᵐ m ∂q_β, IsBayesOptimal (σFull.sectionFull (inclM m)) (Pβ β m).

Used by: tier2-qae-robust-rationalizability-under-menu-Hall.

Modeling notes: The a.e. measure is q_β, not τ and not literal all messages.

payoff-profile-set-W

English name: Payoff-profile set

Informal type: Set W ⊆ Ω → ℝ of state-contingent payoff profiles implementable by private strategies.

Suggested Lean modeling: definition plus compact convex subtype.

Key fields / operations:
w(ω) = E[u(a,ω,θ) | ω]; membership witness private strategy; compactness; convexity; nonemptiness.

Used by: payoff-profile-set-compact-convex, profile-realization-setup, compact-menu-space, WTA vertices.

Modeling notes: Compactness is imported through profile geometry, not derived solely from simplex compactness.

profile-realization-setup

English name: Profile realization setup

Informal type: Bundled geometric theorem and hypotheses for the private-kernel space and profile map.

Suggested Lean modeling: structure.

Key fields / operations:
topology and measurable structure on PrivateStrategy; compactness; Φ : PrivateStrategy → W; continuity of Φ; surjectivity; nonempty compact fibers; measurable/Borel fiber structure.

Used by: payoff-profile-set-compact-convex, profile-map-has-borel-right-inverse, borel-profile-map-implemented-by-agent-strategy.

Modeling notes: This replaces scattered implicit compactness and selection assumptions.

agent-profile-map

English name: Agent strategy profile map

Informal type: For a restricted strategy, the measurable map wσ : M → W.

Suggested Lean modeling: definition.

Key fields / operations:
profileMap σM m : Ω → ℝ; membership in W; measurability; payoff identity s · profileMap σM m.

Used by: payoff decompositions, adversary-infimum-pointwise, menu-value equivalence.

Modeling notes: This is the finite-dimensional bridge from strategies to menu geometry.

profile-realization-map

English name: Profile realization right inverse

Informal type: A Borel map R : W → PrivateStrategy selecting a private strategy realizing each payoff profile.

Suggested Lean modeling: theorem-provided definition or local witness.

Key fields / operations:
R; Measurable R; Φ (R w) = w; implementation of Borel maps M → W.

Used by: profile-map-has-borel-right-inverse, borel-profile-map-implemented-by-agent-strategy, wstar-profile-map-implemented.

Modeling notes: Split the existence of R from its use.

compact-menu-space

English name: Compact menu space

Informal type: 𝒦(W), the nonempty compact subsets of W with Hausdorff metric.

Suggested Lean modeling: subtype of nonempty compact sets.

Key fields / operations:
membership w ∈ C; nonemptiness; compactness; Hausdorff distance; hyperspace topology.

Used by: compact-menu-space-compact, menu-functional-F, optimal-menu-exists.

Modeling notes: Menus are nonempty because maxima and minima are used.

menu-functional-F

English name: Menu value functional

Informal type: Functional on compact menus:
F(C) = ∫_M [α max_{w∈C} s·w + (1-α) min_{w∈C} s·w] τ(ds).

Suggested Lean modeling: definition.

Key fields / operations:
maxPayoff C s; minPayoff C s; integral over τ; Hausdorff continuity.

Used by: menu-value equivalence, optimal-menu-exists, closure-pruning-value-preservation, wstar-payoff-equals-F-Cdagger.

Modeling notes: Finite-dimensional Ω makes s · w continuous.

optimal-menu-Cstar

English name: Optimal compact menu

Informal type: A maximizer C* ∈ 𝒦(W) of F.

Suggested Lean modeling: theorem-local existential witness or bundled structure.

Key fields / operations:
Cstar_nonempty; Cstar_compact; ∀ C, F C ≤ F Cstar; F Cstar = UStarM.

Used by: aligned-best-labeling-selection, closure-pruning-value-preservation, sigma-star-robust-optimal.

Modeling notes: Prefer theorem-local packaging to global choice unless downstream code wants named data.

aligned-best-labeling-wstar

English name: Aligned-best labeling

Informal type: A Borel selector w* : M → C* satisfying w*(m) ∈ argmax_{w∈C*} m·w.

Suggested Lean modeling: definition plus selection theorem witness.

Key fields / operations:
wstar; measurability; membership in C*; argmax equality.

Used by: closure-pruning-value-preservation, wstar-profile-map-implemented, contact correspondences.

Modeling notes: Fix this representative before defining C†.

pruned-menu-Cdagger

English name: Closure-pruned menu

Informal type: C† := closure (w*(M)), a compact subset of C*.

Suggested Lean modeling: definition as compact-menu object.

Key fields / operations:
Cdagger ⊆ Cstar; density of w*(M) in Cdagger; value preservation F Cdagger = F Cstar; rowwise minima over Cdagger.

Used by: closure-pruning-value-preservation, Geps-nonempty, exact-adversary-attainment, wstar-payoff-equals-F-Cdagger.

Modeling notes: This is the realized menu behind σ*.

rowwise-contact-correspondence-G

English name: Rowwise exact contact set

Informal type: For source posterior s, the messages whose selected labels attain the C† rowwise minimum.

Suggested Lean modeling: set-valued correspondence.

Key fields / operations:
G(s) := {m : s · w*(m) = min_{z∈C†} s · z}; graph; support condition.

Used by: exact-contact-selector-unpack, kernel-supported-on-G, menu-Hall-assumption, exact-adversary-attainment.

Modeling notes: Exact-contact asserts measurable selection from this correspondence. Menu-Hall asserts a kernel supported on it.

epsilon-contact-correspondence-Geps

English name: ε-contact correspondence

Informal type: For ε > 0, messages whose selected labels are within ε of the rowwise minimum.

Suggested Lean modeling: set-valued correspondence.

Key fields / operations:
Gε(s) := {m : s·w*(m) ≤ min_{z∈C†} s·z + ε}; nonempty sections; graph measurability; total Borel selector.

Used by: Geps-nonempty, Geps-graph-measurable, Geps-selector-exists, epsilon-adversary-realization.

Modeling notes: The selector target is total Borel: ∀ s : M, mε s ∈ Gε s.

exact-contact-assumption

English name: Exact-contact assumption

Informal type: For τ-a.e. source posterior s, G(s) is nonempty and admits a measurable selector.

Suggested Lean modeling: proposition or structure.

Key fields / operations:
existence of mstar : M → M; measurability; ∀ᵐ s ∂τ, mstar s ∈ G(s).

Used by: exact-contact-selector-unpack, exact-adversary-attainment, tier1b, tier2.

Modeling notes: This is a Tier 1b and Tier 2 hypothesis, not standing.

exact-adversary-kernel

English name: Deterministic exact-contact adversary

Informal type: Kernel induced by an exact-contact selector: β*(·|s) = δ_{m*(s)}.

Suggested Lean modeling: definition.

Key fields / operations:
deterministic Dirac kernel; measurability; rowwise exact minimization.

Used by: exact-adversary-attainment.

Modeling notes: This deterministic kernel is not the Tier 2 adversary unless it equals the menu-Hall kernel.

kernel-supported-on-G

English name: Kernel support on exact contact

Informal type: Predicate saying a kernel sends τ-a.e. source posterior only to exact-contact messages.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
KernelSupportedOnG κ := ∀ᵐ s ∂τ, κ(s)(G(s)) = 1.

Used by: menu-Hall-assumption, menu-Hall-support-implies-exact-adversary, menuHall-adversary-kernel-identity.

Modeling notes: This names the support component of menu-Hall.

menuHall-adversary-kernel

English name: Menu-Hall adversary kernel

Informal type: The specific kernel κ supplied by menu-Hall and chosen as the Tier 2 adversary.

Suggested Lean modeling: local object or projection from MenuHall.

Key fields / operations:
κ : AdviserKernel; βstar := κ; q_κ; γα; support on G; posterior calibration.

Used by: menuHall-adversary-kernel-identity, menu-Hall-support-implies-exact-adversary, posterior-disintegration-menuHall-kernel-coincides, tier2.

Modeling notes: This prevents replacing κ with the deterministic exact-contact selector.

menu-Hall-assumption

English name: Menu-Hall calibration assumption

Informal type: There exists a kernel κ supported on G(s) τ-a.e. such that the mixture posterior lies in the Bayes-optimality belief set B(m) q-a.e.

Suggested Lean modeling: structure or proposition with explicit kernel.

Key fields / operations:
κ; KernelSupportedOnG κ; γα := α(id,id)#τ + (1-α) τ⊗κ; q := (γα)_2; posterior Pγα; calibration ∀ᵐ m ∂q, Pγα m ∈ B(m).

Used by: menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack, posterior-disintegration-menuHall-kernel-coincides, tier2.

Modeling notes: The kernel may mix over G(s). It is set-valued, not deterministic.

mixture-coupling-gamma-alpha

English name: Mixture source-message coupling

Informal type: The joint law of source posterior and reported message under aligned truth-telling plus the menu-Hall kernel.

Suggested Lean modeling: definition.

Key fields / operations:
γα := α • (id,id)#τ + (1 - α) • (τ ⊗ κ); first marginal; second marginal q; equality q = q_κ.

Used by: menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack, posterior-disintegration-menuHall-kernel-coincides.

Modeling notes: This is the canonical posterior law for Tier 2.

Bayes-optimality-belief-correspondence-Bm

English name: Bayes-optimality belief correspondence

Informal type: For each message m, the set of beliefs under which σ*’s private strategy at m is Bayes-optimal.

Suggested Lean modeling: definition M → Set (Belief Ω).

Key fields / operations:
B(m) := {μ : IsBayesOptimal (σstar.sectionFull (inclM m)) μ}; closed convex values when used in support-function form.

Used by: menu-Hall-assumption, menu-Hall-posterior-calibration-unpack, per-message-Bayes-optimality, support-function lemmas.

Modeling notes: The main Tier 2 proof uses membership only.

support-function-Hall-form

English name: Support-function form of menu-Hall

Informal type: Inequality formulation of posterior calibration using support functions of B(m).

Suggested Lean modeling: proposition.

Key fields / operations:
support function h_{B(m)}(φ); measurable-event quantification; continuous affine tests φ : Belief Ω → ℝ; integrated inequality.

Used by: support-function-pointwise-membership-equivalence, support-function-integrated-Hall-equivalence.

Modeling notes: Auxiliary, quarantined from the main positive Tier 2 DAG.

WTA-ternary-algebra

English name: Winner-takes-all ternary finite-coordinate algebra

Informal type: Specialized finite-coordinate WTA algebra with three states, three pure payoff vertices, symmetric prior, and coordinate cones.

Suggested Lean modeling: structure or namespace over Fin 3.

Key fields / operations:
Ω = Fin 3; prior μ0 = (1/3,1/3,1/3); WTA payoff vertices; coordinate algebra; finite sums; simplex identities.

Used by: WTA-payoff-dot-product-identity, WTA-rowwise-minimizer-and-Bayes-cone-identification, wta-cone-intersection, halfspace witness.

Modeling notes: This object does not contain atomlessness.

AtomlessTauSharpness

English name: Atomlessness hypothesis for WTA sharpness

Informal type: The separate hypothesis that τ is atomless in the WTA sharpness setting.

Suggested Lean modeling: proposition or structure field used only by no-free-dust.

Key fields / operations:
Atomless τ; hence τ({μ0}) = 0.

Used by: wta-no-free-dust.

Modeling notes: Not used by wta-cone-intersection.

WTA-payoff-vertices-and-mixed-labels

English name: WTA vertex profiles and mixed labels

Informal type: Vertex payoff profiles v_i and mixed profile labels w_λ.

Suggested Lean modeling: definitions over Fin 3.

Key fields / operations:
v_i(j) = 1 if i = j, -1 otherwise;
wλ := ∑ i, λ i • v_i;
support I = {i : λ i > 0};
dot-product identity.

Used by: WTA-payoff-dot-product-identity, WTA-rowwise-minimizer-and-Bayes-cone-identification, null-dust-data.

Modeling notes: Use finite sums over Fin 3.

WTA-cones-Kminus-and-B

English name: WTA rowwise-minimizer and Bayes-optimality cones

Informal type: For nonempty I ⊆ Fin 3, rowwise minimizer cone K_I^- and Bayes cone B_I.

Suggested Lean modeling: definitions.

Key fields / operations:
Kminus I := {s : ∀ i∈I, ∀ k, s i ≤ s k};
Bcone I := {p : ∀ i∈I, ∀ k, p i ≥ p k}.

Used by: WTA-rowwise-minimizer-and-Bayes-cone-identification, wta-cone-intersection, dust cone lemmas.

Modeling notes: All quantification is finite.

null-dust-data

English name: Null-message dust data on subtype N

Informal type: A τ-null Borel dust set N, a subtype-indexed dust labeling, and measurable mixed-label encoding.

Suggested Lean modeling: structure.

Key fields / operations:
N : Set M; MeasurableSet N; τ(N)=0;
NDust := {m : M // m ∈ N};
wN : NDust → W;
λ : NDust → (Fin 3 → ℝ);
I : NDust → Set (Fin 3) with I m = {i | 0 < λ m i};
λ_measurable;
λ_nonneg : ∀ m i, 0 ≤ λ m i;
λ_sum_one : ∀ m, ∑ i, λ m i = 1;
λ_support_nonempty : ∀ m, (I m).Nonempty;
λ_support_positive : ∀ m i, i ∈ I m ↔ 0 < λ m i;
wN_eq_mixed_label : ∀ m : NDust, wN m = wλ (λ m).

Used by: rowwise-support, Bayes-cone-calibration, adversarial-flow-disintegration-data, wta-no-free-dust.

Modeling notes: wN, λ, and I are never used on all of M; they live on the subtype NDust.

dust-subtype-qN

English name: Dust subtype measure

Informal type: The dust message marginal q_N as a finite measure on the subtype NDust.

Suggested Lean modeling: definition attached to null-dust-data and the dust flow.

Key fields / operations:
NDust := {m : M // m ∈ N};
qN : Measure NDust;
coercion map NDust → M;
support on N is definitional by subtype.

Used by: Bayes-cone-calibration, adversarial-flow-disintegration-data, dust-disintegration-over-subtype-N, qN-supported-on-N.

Modeling notes: This is the chosen Lean shape for dust typing. No arbitrary labels outside N.

rowwise-support

English name: WTA rowwise-support predicate over dust subtype

Informal type: Predicate saying the dust-restricted adversarial flow is supported on rowwise-minimizer cones for the actual dust label.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
Over m : NDust, require the source coordinate s to lie in Kminus (I m) for the ν_N-a.e. pair (s,m), equivalently the restricted kernel sends dust messages only to labels whose cones contain the source.

Used by: dust-rowwise-support-implies-cone-support, wta-no-free-dust.

Modeling notes: The predicate is subtype-disciplined. It never refers to I m for m : M without a proof m ∈ N.

Bayes-cone-calibration

English name: WTA Bayes-cone calibration over dust subtype

Informal type: Predicate saying dust conditional source barycenters lie in the Bayes-optimality cone corresponding to the dust label support.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
BayesConeCalibration dust flow := ∀ᵐ m : NDust ∂qN, barycenter (ρ m) ∈ Bcone (I m).

Used by: dust-Bayes-calibration-gives-cone-barycenter, dust-conditional-sources-satisfy-cones, wta-no-free-dust.

Modeling notes: The measure domain is NDust, not all of M.

adversarial-flow-disintegration-data

English name: Adversarial flow and dust disintegration over subtype N

Informal type: The measure flow induced by ν(ds,dm)=τ(ds)κ(dm|s), restricted to dust and disintegrated over dust messages.

Suggested Lean modeling: structure produced by disintegration theorem.

Key fields / operations:
ν : Measure (Belief Ω × M);
νN : Measure (Belief Ω × NDust);
qN := secondMarginal νN;
ρ : NDust → ProbabilityMeasure (Belief Ω);
disintegration identity νN(A × E) = ∫_{m∈E} ρ m A ∂qN;
conditional barycenter bar_s(m).

Used by: dust-disintegration-over-subtype-N, dust cone lemmas, dust-positive-mass-forces-mu0-atom.

Modeling notes: This is the measure-theoretic engine of no-free-dust.

positive-q-mass

English name: Positive mixture dust mass

Informal type: Predicate saying the mixture message law assigns positive mass to the dust set.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
PositiveQMass N κ := 0 < q_κ(N).

Used by: positive-dust-mass-impossible-when-alpha-one, dust-positive-mass-forces-mu0-atom, wta-no-free-dust.

Modeling notes: This names condition (a) of the no-free-dust theorem.

halfspace-witness-trust-region

English name: Halfspace trust-region witness

Informal type: The WTA halfspace T := {μ : μ(0) ≤ 0.4} used in the menu-engine witness.

Suggested Lean modeling: definition.

Key fields / operations:
membership predicate; witness beliefs (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8); plurality labels.

Used by: halfspace-contains-beliefs-inducing-all-vertices, halfspace-witness-menu-engine-artifact.

Modeling notes: The boundary number 0.4 is not formalized as a primitive obstruction.

effective-menu-equivalence-data

English name: Effective menu equivalence data

Informal type: Data showing the halfspace trust region induces the full WTA vertex menu and the same behavior as the full simplex.

Suggested Lean modeling: structure or theorem-local data.

Key fields / operations:
induced menu; full vertex set {v0,v1,v2}; plurality continuation; off-T projection behavior; behavioral equivalence relation.

Used by: halfspace-induced-effective-menu-equals-full-vertices, halfspace-behavior-equivalent-to-full-simplex.

Modeling notes: Formalize behavioral equivalence, not rhetoric about primitive counterexamples.

halfspace-behavioral-equivalence-predicates

English name: Halfspace behavioral equivalence predicates

Informal type: Precise predicates replacing prose “menu-engine artefact.”

Suggested Lean modeling: definitions returning Prop.

Key fields / operations:
ContainsBeliefsForAllVertices T;
InducedEffectiveMenu T = {v0,v1,v2};
BehaviorEquivalent T FullSimplexTrustRegion;
optional documentation wrapper MenuEngineArtifact T.

Used by: halfspace witness lemmas and theorem package.

Modeling notes: Do not formalize “not a primitive counterexample” unless the project already has that predicate.

Main Theorem
robust-trust-infinite-extension-v8-package

Statement (English, precise):
Under the standing Robust Trust hypotheses, posterior-law consistency, and profile-realization setup, the infinite-M, infinite-Θ extension is a package of six theorem declarations.

tier1a-value-optimality-and-epsilon-adversary:
There exists a full paper strategy σ* : AgentStrategyFull such that
RobustPayoffFull σ* = UStarFull.
For every ε > 0, there exists a Borel adversary kernel βε : AdviserKernel with
MixturePayoffFull βε σ* ≤ RobustPayoffFull σ* + (1 - α) * ε,
hence MixturePayoffFull βε σ* ≤ UStarFull + ε.
The menu engine may construct an internal restricted strategy first, but the theorem exposes the full Σ strategy.

tier1b-exact-adversary-under-exact-contact:
Under exact-contact, there exists a deterministic exact-contact kernel β* such that
IsAdversarialFull β* σ* and
MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.

tier2-qae-robust-rationalizability-under-menu-Hall:
Under exact-contact and menu-Hall, choose the Tier 2 adversary to be the menu-Hall kernel κ. Set βstar := κ. Then
q = q_κ = (γα)_2,
IsAdversarialFull κ σ*,
MixturePayoffFull κ σ* = UStarFull,
and Definition2QAEPredicate κ σ*.
If α > 0, the Bayes-optimality part also holds τ-a.e. by domination.

wta-cone-intersection:
In the WTA ternary algebra, for every nonempty support I, if a Borel probability ρ is supported on K_I^- and has barycenter in B_I, then ρ = δ_{μ0}.

wta-no-free-dust:
In WTA ternary, under the separate atomlessness hypothesis on τ, no τ-null dust set, subtype-indexed dust label, and adversarial kernel can simultaneously have positive mixture dust mass, rowwise minimizer support, and Bayes-cone calibration.

halfspace-witness-menu-engine-artifact:
In the WTA halfspace witness, the precise behavioral facts hold: T contains beliefs inducing all three WTA vertices, its induced effective menu is exactly {v0,v1,v2}, and the resulting continuation behavior is equivalent to the full-simplex trust region.

Type signature (informal):
For model : RobustTrustModel, with PosteriorLawConsistency model and ProfileRealizationSetup model, produce a full strategy σstar : AgentStrategyFull satisfying Tier 1a. Add ExactContact for Tier 1b. Add MenuHall κ for Tier 2, with βstar = κ. Separately, for WTA-ternary-algebra, prove cone intersection; with AtomlessTauSharpness, prove no-free-dust; prove the halfspace behavioral package.

Depends on (objects):
[robust-trust-model, posterior-law-consistency-field, message-restriction-bridge, agent-strategy-full, agent-strategy-M, aligned-payoff, misaligned-payoff, mixture-payoff, robust-payoff, U-star, is-adversarial, mixture-message-law, posterior-disintegration, definition2-qae-predicate, payoff-profile-set-W, profile-realization-setup, compact-menu-space, menu-functional-F, optimal-menu-Cstar, aligned-best-labeling-wstar, pruned-menu-Cdagger, rowwise-contact-correspondence-G, exact-contact-assumption, kernel-supported-on-G, menuHall-adversary-kernel, menu-Hall-assumption, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm, WTA-ternary-algebra, AtomlessTauSharpness, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B, null-dust-data, dust-subtype-qN, rowwise-support, Bayes-cone-calibration, adversarial-flow-disintegration-data, positive-q-mass, halfspace-witness-trust-region, halfspace-behavioral-equivalence-predicates]

Depends on (lemmas):
[tier1a-value-optimality-and-epsilon-adversary, tier1b-exact-adversary-under-exact-contact, tier2-qae-robust-rationalizability-under-menu-Hall, wta-cone-intersection, wta-no-free-dust, halfspace-witness-menu-engine-artifact]

Depends on (external):
[profile-geometry-import, krn-borel-right-inverse, fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection, hyperspace-blaschke-compactness, geps-borel-selector-upgrade, standard-borel-disintegration, bayes-posterior-as-conditional-barycenter, nonnegative-integral-zero, atomless-singleton-null]

Lemmas
posterior-law-barycenter-identities

Statement:
The posterior-law consistency field implies that τ has barycenter μ0 and that, for each state coordinate ω, the finite measure of state-ω sources is represented by s(ω) τ(ds). Consequently, the posterior after observing adviser posterior s is s, τ-a.e.

Type signature:
From posterior-law-consistency-field, prove barycenter τ = μ0 and coordinate finite-measure identities μ0(ω) • π ω = (fun s => s ω) • τ.

Depends on (objects):
[robust-trust-model, finite-state-and-belief-simplex, posterior-law-consistency-field]

Depends on (lemmas):
[]

Depends on (external):
[bayes-posterior-as-conditional-barycenter]

Notes:
Project glue, not simplex algebra alone.

strategy-restriction-to-M

Statement:
Every full agent strategy on Δ Ω × Θ restricts to a measurable restricted agent strategy on M × Θ.

Type signature:
σFull : AgentStrategyFull → ∃ σM : AgentStrategyM, ∀ m : M, σM.sectionM m = σFull.sectionFull (inclM m).

Depends on (objects):
[agent-strategy-full, agent-strategy-M, message-support-M, message-restriction-bridge]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Pure subtype restriction and measurability.

restricted-agent-strategy-extends-to-full

Statement:
Every restricted Borel agent strategy on M extends to a full paper strategy on Δ Ω by arbitrary/default completion outside M.

Type signature:
∀ σM : AgentStrategyM, ∃ σFull : AgentStrategyFull, restrict σFull = σM.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, message-support-M, message-restriction-bridge, private-strategy-space]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
The extension uses the Borel set M and a default private strategy outside M.

outside-M-messages-irrelevant

Statement:
Values of a full agent strategy on messages outside M do not affect aligned payoff, misaligned payoff against M-supported adversaries, mixture payoff, or robust payoff after restriction.

Type signature:
If two full strategies agree on M, then all full payoff objects computed against kernels into M coincide.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, message-support-M, message-restriction-bridge, aligned-payoff, misaligned-payoff, mixture-payoff, robust-payoff]

Depends on (lemmas):
[strategy-restriction-to-M]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This prevents proving only a restricted-game theorem.

adversary-kernels-restrict-to-M

Statement:
For the robust objective, the infimum over full-message adversarial kernels equals the infimum over Borel kernels into M.

Type signature:
⨅ βFull, MixturePayoffFullRaw βFull σFull = ⨅ βM, MixturePayoffFull βM σFull, and the right-hand side equals the restricted payoff of restrict σFull.

Depends on (objects):
[message-support-M, message-restriction-bridge, misaligned-adviser-kernel-space, mixture-payoff, robust-payoff]

Depends on (lemmas):
[outside-M-messages-irrelevant]

Depends on (external):
[kernel-infimum-epsilon-selection]

Notes:
Formalizes the paper’s without-loss restriction of adversarial messages to M.

full-restricted-Ustar-equivalence

Statement:
The full paper robust value and the restricted menu-engine robust value are equal, and restricted payoff optimality lifts to full payoff optimality under any full extension.

Type signature:
UStarFull = UStarM, and if restrict σFull = σM, then RobustPayoffFull σFull = RobustPayoffM σM.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, robust-payoff, U-star, message-restriction-bridge]

Depends on (lemmas):
[strategy-restriction-to-M, restricted-agent-strategy-extends-to-full, outside-M-messages-irrelevant, adversary-kernels-restrict-to-M]

Depends on (external):
[]

Notes:
This is the reverse strategy lift seam required for Tier 1a to expose σ* ∈ Σ.

q-dominates-tau-when-alpha-pos

Statement:
For every adversarial kernel β, if α > 0, then q_β dominates τ: every q_β-null set is τ-null. Hence any q_β-a.e. predicate holds τ-a.e.

Type signature:
0 < α → (∀ᵐ m ∂q_β, P m) → (∀ᵐ m ∂τ, P m).

Depends on (objects):
[mixture-message-law]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
This is the domination lemma for the q-a.e. reading of Definition 2.

payoff-profile-set-compact-convex

Statement:
The payoff-profile set W is a compact convex subset of Ω → ℝ, and the profile map from private strategies is surjective onto W.

Type signature:
IsCompact W ∧ Convex ℝ W ∧ Surjective Φ.

Depends on (objects):
[robust-trust-model, type-action-payoff-primitives, private-strategy-space, payoff-profile-set-W, profile-realization-setup]

Depends on (lemmas):
[]

Depends on (external):
[profile-geometry-import]

Notes:
Specialist imported profile geometry.

profile-map-has-borel-right-inverse

Statement:
The continuous surjective profile map Φ : PrivateStrategy → W with compact nonempty fibers admits a Borel right inverse R : W → PrivateStrategy.

Type signature:
∃ R, Measurable R ∧ ∀ w ∈ W, Φ (R w) = w.

Depends on (objects):
[profile-realization-setup, profile-realization-map, payoff-profile-set-W]

Depends on (lemmas):
[payoff-profile-set-compact-convex]

Depends on (external):
[krn-borel-right-inverse]

Notes:
First half of the profile-realization split.

borel-profile-map-implemented-by-agent-strategy

Statement:
Every Borel map wMap : M → W is implemented by a measurable restricted agent strategy using the Borel right inverse R.

Type signature:
Measurable wMap → ∃ σM : AgentStrategyM, profileMap σM = wMap.

Depends on (objects):
[profile-realization-map, agent-strategy-M, agent-profile-map, message-support-M]

Depends on (lemmas):
[profile-map-has-borel-right-inverse]

Depends on (external):
[]

Notes:
Second half of the profile-realization split.

profile-payoff-decomposition-aligned

Statement:
For any restricted agent strategy σM with profile map wσ, the aligned payoff equals ∫_M s · wσ(s) τ(ds).

Type signature:
AlignedPayoffM σM = ∫ s, dot s (profileMap σM s) ∂τ.

Depends on (objects):
[aligned-payoff, agent-profile-map, agent-strategy-M, posterior-law-consistency-field]

Depends on (lemmas):
[posterior-law-barycenter-identities]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Uses conditional independence and posterior-law consistency.

profile-payoff-decomposition-misaligned

Statement:
For any restricted agent strategy σM and adversary kernel β, the misaligned payoff equals ∫_M ∫_M s · wσ(m) β(dm|s) τ(ds).

Type signature:
MisalignedPayoffM β σM = ∫ s, ∫ m, dot s (profileMap σM m) ∂β s ∂τ.

Depends on (objects):
[misaligned-payoff, misaligned-adviser-kernel-space, agent-profile-map, agent-strategy-M]

Depends on (lemmas):
[posterior-law-barycenter-identities]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This isolates the misaligned-only component.

mixture-payoff-decomposition

Statement:
The full payoff against a fixed kernel decomposes as aligned profile integral plus misaligned profile integral with weights α and 1 - α.

Type signature:
MixturePayoffM β σM = α * AlignedPayoffM σM + (1 - α) * MisalignedPayoffM β σM, with profile identities substituted. Full analogue follows through restriction.

Depends on (objects):
[mixture-payoff, aligned-payoff, misaligned-payoff]

Depends on (lemmas):
[profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned]

Depends on (external):
[]

Notes:
Payoff API root for adversary lemmas.

adversary-infimum-pointwise

Statement:
For any bounded measurable profile map w : M → W, the infimum of the misaligned profile integral over Borel kernels equals the integral of rowwise infima:
inf_β ∫∫ s·w(m) β(dm|s) τ(ds) = ∫ inf_m s·w(m) τ(ds).

Type signature:
For bounded measurable g(s,m)=s·w(m),
⨅ β, ∫∫ g s m ∂β s ∂τ = ∫ s, ⨅ m, g s m ∂τ.

Depends on (objects):
[misaligned-adviser-kernel-space, agent-profile-map, message-support-M]

Depends on (lemmas):
[profile-payoff-decomposition-misaligned]

Depends on (external):
[fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection]

Notes:
Exact minimizers are not required. ε-selectors suffice.

strategy-value-le-menu-sup

Statement:
Every restricted agent strategy generates a compact menu closure Cσ := closure (range wσ) such that RobustPayoffM σ ≤ F(Cσ) ≤ sup_C F(C).

Type signature:
∀ σM, RobustPayoffM σM ≤ ⨆ C : 𝒦(W), F C.

Depends on (objects):
[robust-payoff, agent-profile-map, compact-menu-space, menu-functional-F]

Depends on (lemmas):
[mixture-payoff-decomposition, adversary-infimum-pointwise]

Depends on (external):
[measurable-maximum-and-argmax-selection]

Notes:
One direction of menu-value equivalence.

menu-value-le-strategy-sup

Statement:
For every nonempty compact menu C, an aligned-best Borel labeling into C can be realized by a restricted agent strategy σC with F(C) ≤ RobustPayoffM σC.

Type signature:
∀ C : 𝒦(W), F C ≤ UStarM.

Depends on (objects):
[compact-menu-space, menu-functional-F, profile-realization-map, robust-payoff, U-star]

Depends on (lemmas):
[borel-profile-map-implemented-by-agent-strategy, adversary-infimum-pointwise]

Depends on (external):
[measurable-maximum-and-argmax-selection]

Notes:
Other direction of menu-value equivalence.

menu-value-equivalence

Statement:
The restricted robust value equals the supremum of the menu functional over nonempty compact menus:
UStarM = ⨆ C : 𝒦(W), F C.

Type signature:
UStarM model = sSup {F C | C : 𝒦(W)}.

Depends on (objects):
[U-star, compact-menu-space, menu-functional-F]

Depends on (lemmas):
[strategy-value-le-menu-sup, menu-value-le-strategy-sup]

Depends on (external):
[]

Notes:
The full equality follows later from full-restricted-Ustar-equivalence.

compact-menu-space-compact

Statement:
If W is compact metric, then 𝒦(W) is compact under Hausdorff distance.

Type signature:
CompactSpace (NonemptyCompactSubsets W with HausdorffMetric).

Depends on (objects):
[payoff-profile-set-W, compact-menu-space]

Depends on (lemmas):
[payoff-profile-set-compact-convex]

Depends on (external):
[hyperspace-blaschke-compactness]

Notes:
Conservatively local unless Mathlib compact-set Hausdorff APIs are confirmed.

menu-extrema-Hausdorff-Lipschitz

Statement:
For each belief s, maps C ↦ max_{w∈C} s·w and C ↦ min_{w∈C} s·w are Lipschitz in Hausdorff distance.

Type signature:
|maxPayoff C s - maxPayoff D s| ≤ L * dH C D, and similarly for minima.

Depends on (objects):
[finite-state-and-belief-simplex, compact-menu-space, menu-functional-F]

Depends on (lemmas):
[]

Depends on (external):
[hausdorff-support-function-lipschitz]

Notes:
The source’s “1-Lipschitz” depends on norm convention.

menu-functional-continuity

Statement:
The menu functional F : 𝒦(W) → ℝ is continuous in Hausdorff distance.

Type signature:
Continuous F.

Depends on (objects):
[compact-menu-space, menu-functional-F]

Depends on (lemmas):
[menu-extrema-Hausdorff-Lipschitz]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Boundedness gives integrability; Lipschitz extrema give continuity.

optimal-menu-exists

Statement:
The supremum of F over 𝒦(W) is attained by some compact menu C*.

Type signature:
∃ Cstar : 𝒦(W), ∀ C : 𝒦(W), F C ≤ F Cstar.

Depends on (objects):
[compact-menu-space, menu-functional-F, optimal-menu-Cstar]

Depends on (lemmas):
[compact-menu-space-compact, menu-functional-continuity]

Depends on (external):
[weierstrass-extreme-value]

Notes:
Menu existence.

aligned-best-labeling-selection

Statement:
For an optimal menu C*, there exists a Borel selector w* : M → C* such that w*(m) maximizes m·w over C*.

Type signature:
∃ wstar, Measurable wstar ∧ ∀ m, wstar m ∈ Cstar ∧ IsArgMax (fun w => dot m w) Cstar (wstar m).

Depends on (objects):
[message-support-M, optimal-menu-Cstar, aligned-best-labeling-wstar]

Depends on (lemmas):
[optimal-menu-exists]

Depends on (external):
[measurable-maximum-and-argmax-selection]

Notes:
The selector is fixed before defining C†.

closure-pruning-value-preservation

Statement:
Let C† := closure (w*(M)). Then C† ⊆ C* and F(C†) = F(C*) = UStarM.

Type signature:
For selected wstar, define Cdagger; prove subset and value equality.

Depends on (objects):
[aligned-best-labeling-wstar, pruned-menu-Cdagger, menu-functional-F, U-star]

Depends on (lemmas):
[menu-value-equivalence, optimal-menu-exists, aligned-best-labeling-selection]

Depends on (external):
[weierstrass-extreme-value]

Notes:
Aligned term unchanged; misaligned term weakly rises; optimality forces equality.

wstar-profile-map-implemented

Statement:
The selected labeling w* : M → C† ⊆ W is Borel and is implemented by a restricted agent strategy.

Type signature:
Measurable wstar → ∃ σM : AgentStrategyM, profileMap σM = wstar.

Depends on (objects):
[agent-strategy-M, profile-realization-map, aligned-best-labeling-wstar, pruned-menu-Cdagger, agent-profile-map]

Depends on (lemmas):
[borel-profile-map-implemented-by-agent-strategy, aligned-best-labeling-selection, closure-pruning-value-preservation]

Depends on (external):
[]

Notes:
First split of the old bundled sigma-star-realization-and-optimality.

wstar-payoff-equals-F-Cdagger

Statement:
For a restricted strategy implementing w*, the aligned payoff equals the integral of the rowwise maxima over C†, and the misaligned infimum equals the integral of the rowwise minima over C†. Hence the restricted robust payoff equals F(C†).

Type signature:
If profileMap σM = wstar, then
AlignedPayoffM σM = ∫ s, max_{w∈C†} dot s w ∂τ,
(⨅ β, MisalignedPayoffM β σM) = ∫ s, min_{z∈C†} dot s z ∂τ,
and RobustPayoffM σM = F Cdagger.

Depends on (objects):
[agent-strategy-M, aligned-payoff, misaligned-payoff, robust-payoff, menu-functional-F, pruned-menu-Cdagger]

Depends on (lemmas):
[profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned, adversary-infimum-pointwise, closure-pruning-value-preservation]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This makes the payoff identity visible rather than hiding it inside realization.

sigma-star-robust-optimal

Statement:
A full extension of the restricted strategy implementing w* attains the full paper robust value.

Type signature:
∃ σstarFull : AgentStrategyFull, RobustPayoffFull σstarFull = UStarFull ∧ restrict σstarFull = σstarM.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, robust-payoff, U-star, message-restriction-bridge]

Depends on (lemmas):
[wstar-profile-map-implemented, wstar-payoff-equals-F-Cdagger, closure-pruning-value-preservation, menu-value-equivalence, restricted-agent-strategy-extends-to-full, full-restricted-Ustar-equivalence]

Depends on (external):
[]

Notes:
This is the full-Σ optimality lemma used by Tier 1a.

Geps-nonempty

Statement:
For every ε > 0 and every source posterior s, the ε-contact set Gε(s) is nonempty.

Type signature:
ε > 0 → ∀ s : M, (Gε ε s).Nonempty.

Depends on (objects):
[epsilon-contact-correspondence-Geps, pruned-menu-Cdagger, aligned-best-labeling-wstar]

Depends on (lemmas):
[closure-pruning-value-preservation]

Depends on (external):
[]

Notes:
Uses density of w*(M) in C† and continuity of dot products.

Geps-graph-measurable

Statement:
For each ε > 0, the graph {(s,m) : m ∈ Gε(s)} is Borel or has the stronger selectable regularity required by the Borel selector theorem.

Type signature:
ε > 0 → MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}.

Depends on (objects):
[epsilon-contact-correspondence-Geps, aligned-best-labeling-wstar, pruned-menu-Cdagger]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Separated from selector existence.

Geps-selector-exists

Statement:
For every ε > 0, there exists a total admissible Borel selector mε : M → M with mε(s) ∈ Gε(s) for every s.

Type signature:
ε > 0 → ∃ mε : M → M, Measurable mε ∧ ∀ s : M, mε s ∈ Gε ε s.

Depends on (objects):
[epsilon-contact-correspondence-Geps, misaligned-adviser-kernel-space]

Depends on (lemmas):
[Geps-nonempty, Geps-graph-measurable]

Depends on (external):
[jankov-von-neumann-universal-selection, geps-borel-selector-upgrade]

Notes:
The selected formal target is total Borel. JvN alone is not enough; the Borel upgrade is explicit.

epsilon-adversary-realization

Statement:
For every ε > 0, the deterministic kernel βε(·|s)=δ_{mε(s)} satisfies
MixturePayoffFull βε σ* ≤ RobustPayoffFull σ* + (1 - α) * ε, hence MixturePayoffFull βε σ* ≤ UStarFull + ε.

Type signature:
ε > 0 → ∃ βε : AdviserKernel, MixturePayoffFull βε σstar ≤ RobustPayoffFull σstar + (1 - α) * ε ∧ MixturePayoffFull βε σstar ≤ UStarFull + ε.

Depends on (objects):
[epsilon-contact-correspondence-Geps, misaligned-adviser-kernel-space, mixture-payoff, robust-payoff, U-star]

Depends on (lemmas):
[sigma-star-robust-optimal, Geps-selector-exists, mixture-payoff-decomposition, full-restricted-Ustar-equivalence]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Restated with MixturePayoffFull, not an ambiguous payoff symbol.

exact-contact-selector-unpack

Statement:
Exact-contact gives a Borel selector m* : M → M such that m*(s) ∈ G(s) for τ-a.e. s.

Type signature:
ExactContact → ∃ mstar, Measurable mstar ∧ ∀ᵐ s ∂τ, mstar s ∈ G s.

Depends on (objects):
[exact-contact-assumption, rowwise-contact-correspondence-G]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Unpacking a hypothesis.

exact-adversary-attainment

Statement:
Under exact-contact, the deterministic kernel induced by the exact-contact selector is adversarial and attains the full mixture infimum:
MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.

Type signature:
ExactContact → ∃ βstar, IsAdversarialFull βstar σstar ∧ MixturePayoffFull βstar σstar = RobustPayoffFull σstar ∧ RobustPayoffFull σstar = UStarFull.

Depends on (objects):
[exact-contact-assumption, exact-adversary-kernel, rowwise-contact-correspondence-G, mixture-payoff, robust-payoff, U-star, is-adversarial]

Depends on (lemmas):
[sigma-star-robust-optimal, exact-contact-selector-unpack, wstar-payoff-equals-F-Cdagger, closure-pruning-value-preservation, mixture-payoff-decomposition, full-restricted-Ustar-equivalence]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Includes the equality chain required by the source theorem.

menuHall-adversary-kernel-identity

Statement:
Under menu-Hall, the Tier 2 adversary is the menu-Hall kernel κ, and the message marginal used in Definition 2 is exactly both q_κ and (γα)_2.

Type signature:
MenuHall κ → βstar = κ ∧ q = q_κ ∧ q = secondMarginal γα.

Depends on (objects):
[menuHall-adversary-kernel, menu-Hall-assumption, mixture-message-law, mixture-coupling-gamma-alpha]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
This prevents accidental substitution of the deterministic exact-contact selector.

menu-Hall-posterior-calibration-unpack

Statement:
Under menu-Hall, the disintegration posterior induced by γα satisfies Pγα(m) ∈ B(m) for q-a.e. m.

Type signature:
MenuHall κ → ∀ᵐ m ∂q, Pγα m ∈ Bm m.

Depends on (objects):
[menu-Hall-assumption, mixture-coupling-gamma-alpha, posterior-disintegration, Bayes-optimality-belief-correspondence-Bm]

Depends on (lemmas):
[menuHall-adversary-kernel-identity]

Depends on (external):
[standard-borel-disintegration]

Notes:
Calibration half of menu-Hall.

menu-Hall-support-implies-exact-adversary

Statement:
If the menu-Hall kernel κ is supported on G(s), then κ is an exact adversary for σ* in the full mixture payoff sense, and its mixture payoff equals UStarFull.

Type signature:
KernelSupportedOnG κ → IsAdversarialFull κ σstar ∧ MixturePayoffFull κ σstar = UStarFull.

Depends on (objects):
[kernel-supported-on-G, menuHall-adversary-kernel, rowwise-contact-correspondence-G, mixture-payoff, robust-payoff, U-star, is-adversarial]

Depends on (lemmas):
[sigma-star-robust-optimal, wstar-payoff-equals-F-Cdagger, closure-pruning-value-preservation, mixture-payoff-decomposition, full-restricted-Ustar-equivalence]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This is the Tier 2 adversary-attainment statement for κ.

per-message-Bayes-optimality

Statement:
Under exact-contact and menu-Hall, σ*’s private strategy is Bayes-optimal under Pγα(m) for q-a.e. m. If α > 0, it is also Bayes-optimal τ-a.e.

Type signature:
ExactContact → MenuHall κ → (∀ᵐ m ∂q, IsBayesOptimal (σstar.sectionFull (inclM m)) (Pγα m)) ∧ (0 < α → ∀ᵐ m ∂τ, IsBayesOptimal (σstar.sectionFull (inclM m)) (Pγα m)).

Depends on (objects):
[exact-contact-assumption, menu-Hall-assumption, Bayes-optimality-belief-correspondence-Bm, posterior-disintegration]

Depends on (lemmas):
[menu-Hall-posterior-calibration-unpack, q-dominates-tau-when-alpha-pos]

Depends on (external):
[]

Notes:
Exact-contact is retained to match the source theorem, though menu-Hall drives the membership step.

posterior-disintegration-menuHall-kernel-coincides

Statement:
For the menu-Hall kernel κ, the posterior object Pβ κ used by Definition2QAEPredicate is q_κ-a.e. equal to the posterior Pγα supplied by menu-Hall.

Type signature:
MenuHall κ → ∀ᵐ m ∂q_κ, Pβ κ m = Pγα m.

Depends on (objects):
[posterior-disintegration, menuHall-adversary-kernel, menu-Hall-assumption, mixture-message-law, mixture-coupling-gamma-alpha]

Depends on (lemmas):
[menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack]

Depends on (external):
[standard-borel-disintegration]

Notes:
This is the load-bearing posterior identity between Definition 2 and menu-Hall. Alternatively, downstream formalization may define Pβ κ by the same coupling γα, making this definitional.

support-function-pointwise-membership-equivalence

Statement:
For closed convex nonempty values B(m), a belief p lies in B(m) iff every continuous affine functional is bounded above by the support function of B(m).

Type signature:
p ∈ B m ↔ ∀ φ, φ p ≤ h_{B(m)} φ.

Depends on (objects):
[Bayes-optimality-belief-correspondence-Bm, support-function-Hall-form]

Depends on (lemmas):
[]

Depends on (external):
[support-function-pointwise-separation]

Notes:
Auxiliary finite-dimensional convex analysis.

support-function-integrated-Hall-equivalence

Statement:
Under measurability, closed-convex, and nonempty-value hypotheses for B(m), posterior calibration Pγα(m) ∈ B(m) q-a.e. is equivalent to support-function Hall inequalities over measurable events and continuous affine tests.

Type signature:
PosteriorCalibration γα B q ↔ SupportFunctionHallInequalities γα B q.

Depends on (objects):
[support-function-Hall-form, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm]

Depends on (lemmas):
[support-function-pointwise-membership-equivalence]

Depends on (external):
[support-function-measurable-integrated-separation, bayes-posterior-as-conditional-barycenter]

Notes:
Auxiliary and outside the main positive Tier 2 DAG.

tier1a-value-optimality-and-epsilon-adversary

Statement:
Under standing hypotheses, there exists a full paper strategy σ* : AgentStrategyFull with RobustPayoffFull σ* = UStarFull. For every ε > 0, there exists a Borel kernel βε with MixturePayoffFull βε σ* ≤ UStarFull + ε.

Type signature:
∃ σstar : AgentStrategyFull, RobustPayoffFull σstar = UStarFull ∧ ∀ ε > 0, ∃ βε, MixturePayoffFull βε σstar ≤ UStarFull + ε.

Depends on (objects):
[robust-trust-model, profile-realization-setup, agent-strategy-full, mixture-payoff, robust-payoff, U-star]

Depends on (lemmas):
[menu-value-equivalence, optimal-menu-exists, aligned-best-labeling-selection, closure-pruning-value-preservation, wstar-profile-map-implemented, wstar-payoff-equals-F-Cdagger, restricted-agent-strategy-extends-to-full, full-restricted-Ustar-equivalence, sigma-star-robust-optimal, epsilon-adversary-realization]

Depends on (external):
[]

Notes:
First component theorem. The public witness is full Σ, not merely restricted.

tier1b-exact-adversary-under-exact-contact

Statement:
Under standing hypotheses plus exact-contact, there exists an exact adversarial kernel β* with MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.

Type signature:
ExactContact → ∃ βstar, IsAdversarialFull βstar σstar ∧ MixturePayoffFull βstar σstar = UStarFull.

Depends on (objects):
[exact-contact-assumption, exact-adversary-kernel, agent-strategy-full, mixture-payoff, robust-payoff, U-star, is-adversarial]

Depends on (lemmas):
[tier1a-value-optimality-and-epsilon-adversary, exact-adversary-attainment]

Depends on (external):
[]

Notes:
Second component theorem.

tier2-qae-robust-rationalizability-under-menu-Hall

Statement:
Under standing hypotheses plus exact-contact and menu-Hall, choose βstar := κ, the menu-Hall kernel. Then q = qκ = (γα)_2, κ is adversarial against full σ*, MixturePayoffFull κ σ* = UStarFull, and Definition2QAEPredicate κ σ* holds. If α > 0, the Bayes-optimality condition also holds τ-a.e.

Type signature:
ExactContact → MenuHall κ → βstar = κ ∧ IsAdversarialFull κ σstar ∧ MixturePayoffFull κ σstar = UStarFull ∧ Definition2QAEPredicate κ σstar ∧ (0 < α → τAE_BayesOptimal).

Depends on (objects):
[exact-contact-assumption, menu-Hall-assumption, menuHall-adversary-kernel, agent-strategy-full, mixture-message-law, mixture-coupling-gamma-alpha, definition2-qae-predicate, is-adversarial]

Depends on (lemmas):
[menuHall-adversary-kernel-identity, menu-Hall-support-implies-exact-adversary, per-message-Bayes-optimality, posterior-disintegration-menuHall-kernel-coincides]

Depends on (external):
[]

Notes:
Third component theorem. The posterior identity is inserted before invoking Definition2QAEPredicate.

WTA-payoff-dot-product-identity

Statement:
In WTA ternary, for a mixed profile wλ = ∑ i, λ i • v_i, s · wλ = 2 * ∑ i, λ i * s_i - 1.

Type signature:
For λ : Fin 3 → ℝ, λ_i ≥ 0, ∑ λ_i = 1, prove the coordinate identity.

Depends on (objects):
[WTA-ternary-algebra, WTA-payoff-vertices-and-mixed-labels]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Finite coordinate algebra.

WTA-rowwise-minimizer-and-Bayes-cone-identification

Statement:
In WTA ternary, let I be nonempty and let λ satisfy support λ = I, positive weights exactly on I, and ∑ i, λ i = 1. Then the mixed label wλ is a rowwise minimizer exactly for source beliefs in K_I^-, and Bayes-optimal exactly for beliefs in B_I.

Type signature:
I.Nonempty → support λ = I → (∀ i∈I, 0 < λ i) → (∀ i∉I, λ i = 0) → ∑ λ = 1 → (RowwiseMinimizer s wλ ↔ s ∈ Kminus I) ∧ (BayesOptimalWTA p wλ ↔ p ∈ Bcone I).

Depends on (objects):
[WTA-ternary-algebra, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[WTA-payoff-dot-product-identity]

Depends on (external):
[finite-dimensional-simplex-compactness]

Notes:
Uses exact support and positive-weight hypotheses.

wta-cone-intersection

Statement:
For every nonempty I ⊆ Fin 3, if a Borel probability ρ on Δ Ω satisfies ρ(K_I^-)=1 and has barycenter in B_I, then ρ = δ_{μ0} where μ0=(1/3,1/3,1/3).

Type signature:
I.Nonempty → ρ(Kminus I)=1 → barycenter ρ ∈ Bcone I → ρ = dirac μ0.

Depends on (objects):
[WTA-ternary-algebra, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[WTA-rowwise-minimizer-and-Bayes-cone-identification]

Depends on (external):
[nonnegative-integral-zero]

Notes:
No atomlessness dependency. This is purely finite-coordinate probability algebra.

dust-disintegration-over-subtype-N

Statement:
For ν(ds,dm)=τ(ds)κ(dm|s) and dust restriction over NDust, there exists a disintegration over the second marginal qN : Measure NDust, with conditional source laws ρ_m.

Type signature:
∃ ρ : NDust → ProbabilityMeasure (Belief Ω), ∀ A E, νN(A × E) = ∫ m in E, ρ m A ∂qN.

Depends on (objects):
[null-dust-data, dust-subtype-qN, adversarial-flow-disintegration-data]

Depends on (lemmas):
[]

Depends on (external):
[standard-borel-disintegration]

Notes:
First split of no-free-dust. The measure domain is the subtype NDust.

qN-supported-on-N

Statement:
The dust marginal qN is supported on the dust set by construction, since it is a measure on the subtype NDust.

Type signature:
For the coercion ι : NDust → M, (ι # qN) is supported on N; equivalently every m : NDust carries a proof m.val ∈ N.

Depends on (objects):
[dust-subtype-qN, null-dust-data]

Depends on (lemmas):
[dust-disintegration-over-subtype-N]

Depends on (external):
[]

Notes:
This eliminates repeated a.e. coercion goblins.

dust-rowwise-support-implies-cone-support

Statement:
If the dust flow satisfies rowwise-support, then for qN-a.e. dust message m : NDust, the conditional source law ρ_m is supported on Kminus (I m).

Type signature:
RowwiseSupport dust κ flow → ∀ᵐ m : NDust ∂qN, ρ m (Kminus (I m)) = 1.

Depends on (objects):
[rowwise-support, null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[dust-disintegration-over-subtype-N, qN-supported-on-N]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Cone support is over m : NDust.

dust-Bayes-calibration-gives-cone-barycenter

Statement:
Bayes-cone calibration gives that for qN-a.e. dust message m : NDust, the barycenter of ρ_m lies in Bcone (I m).

Type signature:
BayesConeCalibration dust flow → ∀ᵐ m : NDust ∂qN, barycenter (ρ m) ∈ Bcone (I m).

Depends on (objects):
[Bayes-cone-calibration, null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[dust-disintegration-over-subtype-N]

Depends on (external):
[bayes-posterior-as-conditional-barycenter]

Notes:
Barycenter calibration is subtype-indexed.

dust-conditional-sources-satisfy-cones

Statement:
If rowwise-support and Bayes-cone calibration hold, then for qN-a.e. m : NDust, ρ_m(K_{I(m)}^-)=1 and barycenter(ρ_m) ∈ B_{I(m)}.

Type signature:
RowwiseSupport dust κ flow → BayesConeCalibration dust flow → ∀ᵐ m : NDust ∂qN, ρ m (Kminus (I m)) = 1 ∧ barycenter (ρ m) ∈ Bcone (I m).

Depends on (objects):
[rowwise-support, Bayes-cone-calibration, null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[dust-rowwise-support-implies-cone-support, dust-Bayes-calibration-gives-cone-barycenter, WTA-rowwise-minimizer-and-Bayes-cone-identification]

Depends on (external):
[]

Notes:
This is now a clean product of two subtype lemmas.

cone-intersection-applied-to-dust

Statement:
Under the cone conditions from dust disintegration, ρ_m = δ_{μ0} for qN-a.e. dust message m : NDust.

Type signature:
∀ᵐ m : NDust ∂qN, ρ m = dirac μ0.

Depends on (objects):
[adversarial-flow-disintegration-data, WTA-ternary-algebra]

Depends on (lemmas):
[dust-conditional-sources-satisfy-cones, wta-cone-intersection]

Depends on (external):
[]

Notes:
Applies cone intersection pointwise over the dust subtype.

positive-dust-mass-impossible-when-alpha-one

Statement:
If α = 1 and τ(N)=0, then no adversarial kernel can give positive mixture mass to the dust set N.

Type signature:
α = 1 → τ N = 0 → ¬ PositiveQMass N κ.

Depends on (objects):
[mixture-message-law, positive-q-mass, null-dust-data]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
This is the explicit α = 1 branch of no-free-dust.

dust-positive-mass-forces-mu0-atom

Statement:
If dust has positive mixture message mass, τ(N)=0, and α < 1, then the dust disintegration plus ρ_m = δ_{μ0} forces positive ν-mass on {μ0} × N, hence positive τ-mass on {μ0}.

Type signature:
τ N = 0 → PositiveQMass N κ → α < 1 → (∀ᵐ m : NDust ∂qN, ρ m = dirac μ0) → 0 < τ({μ0}).

Depends on (objects):
[null-dust-data, dust-subtype-qN, adversarial-flow-disintegration-data, mixture-message-law, positive-q-mass, WTA-ternary-algebra]

Depends on (lemmas):
[cone-intersection-applied-to-dust]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This is only the α < 1 branch.

wta-no-free-dust

Statement:
Under atomless τ in WTA ternary, there do not exist τ-null dust data, a subtype-indexed Borel dust labeling, and an adversarial kernel satisfying positive mixture dust mass, rowwise support, and Bayes-cone calibration.

Type signature:
AtomlessTauSharpness → ¬ ∃ dust κ flow, TauNull dust.N ∧ PositiveQMass dust.N κ ∧ RowwiseSupport dust κ flow ∧ BayesConeCalibration dust flow.

Depends on (objects):
[WTA-ternary-algebra, AtomlessTauSharpness, null-dust-data, rowwise-support, Bayes-cone-calibration, adversarial-flow-disintegration-data, mixture-message-law, positive-q-mass]

Depends on (lemmas):
[dust-disintegration-over-subtype-N, dust-conditional-sources-satisfy-cones, cone-intersection-applied-to-dust, positive-dust-mass-impossible-when-alpha-one, dust-positive-mass-forces-mu0-atom]

Depends on (external):
[atomless-singleton-null]

Notes:
The proof splits on α = 1 ∨ α < 1. Atomlessness appears only here, not in wta-cone-intersection.

sharpness-corollary

Statement:
Taking I={0} in the cone intersection theorem recovers the pointwise v7 obstruction at t0=(0.4,0.3,0.3), and no-free-dust rules out repairing it with τ-null dust.

Type signature:
Specialized consequence for singleton support {0}.

Depends on (objects):
[WTA-ternary-algebra, AtomlessTauSharpness, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[wta-cone-intersection, wta-no-free-dust]

Depends on (external):
[]

Notes:
Sharpness statement, not a positive-tier dependency.

halfspace-contains-beliefs-inducing-all-vertices

Statement:
The halfspace T={μ : μ(0)≤0.4} contains beliefs whose WTA plurality labels induce each of the three vertex profiles.

Type signature:
∃ μ0T μ1T μ2T ∈ T, Label μ0T = v0 ∧ Label μ1T = v1 ∧ Label μ2T = v2.

Depends on (objects):
[halfspace-witness-trust-region, WTA-ternary-algebra, WTA-payoff-vertices-and-mixed-labels, halfspace-behavioral-equivalence-predicates]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Coordinate checks using (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8).

halfspace-induced-effective-menu-equals-full-vertices

Statement:
Any plurality-vertex continuation on the halfspace T induces the effective menu {v0,v1,v2}.

Type signature:
InducedEffectiveMenu T = {v0,v1,v2}.

Depends on (objects):
[effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates, WTA-payoff-vertices-and-mixed-labels]

Depends on (lemmas):
[halfspace-contains-beliefs-inducing-all-vertices]

Depends on (external):
[]

Notes:
Formalizes the menu piece of the classification.

halfspace-behavior-equivalent-to-full-simplex

Statement:
Since the induced in-T menu is already the full WTA vertex menu, the off-T projection/continuation behavior is the same as ordinary plurality over the full simplex.

Type signature:
BehaviorEquivalent T FullSimplexTrustRegion.

Depends on (objects):
[effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates, halfspace-witness-trust-region]

Depends on (lemmas):
[halfspace-induced-effective-menu-equals-full-vertices]

Depends on (external):
[]

Notes:
Avoids formalizing “not a primitive counterexample” as a rhetoric-flavored theorem.

halfspace-witness-menu-engine-artifact

Statement:
The halfspace witness satisfies the precise behavioral-equivalence package: it contains beliefs inducing all three vertices, its effective menu is the full vertex menu, and its behavior is equivalent to the full-simplex trust region.

Type signature:
ContainsBeliefsForAllVertices T ∧ InducedEffectiveMenu T = {v0,v1,v2} ∧ BehaviorEquivalent T FullSimplexTrustRegion.

Depends on (objects):
[halfspace-witness-trust-region, effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates]

Depends on (lemmas):
[halfspace-contains-beliefs-inducing-all-vertices, halfspace-induced-effective-menu-equals-full-vertices, halfspace-behavior-equivalent-to-full-simplex]

Depends on (external):
[]

Notes:
Sixth component theorem.

External Results Invoked
finite-dimensional-simplex-compactness

English name: Compact convex geometry of a finite-dimensional probability simplex

Statement used:
For finite Ω, Δ Ω is compact and convex; coordinate functions and dot products are continuous; continuous affine functions attain extrema on compact subsets.

Classification: MATHLIB_CANDIDATE

Why this classification:
Mathlib has finite-dimensional topology, convexity, compactness, and finite-sum APIs, though simplex glue may be needed.

measurable-maximum-and-argmax-selection

English name: Measurable maximum theorem and measurable argmax selection

Statement used:
A measurable compact-valued correspondence with continuous objective admits a measurable selector from the argmax correspondence.

Classification: NON_MATHLIB

Why this classification:
This is a specialist measurable-selection theorem, unlikely to be packaged directly in Mathlib.

profile-geometry-import

English name: Profile geometry theorem for private kernels

Statement used:
The private-kernel space has a compact standard-Borel topology; the profile map Φ is continuous and onto W; fibers are nonempty compact; W is compact convex.

Classification: NON_MATHLIB

Why this classification:
This is imported project geometry from the paper’s profile construction, not standard Mathlib convexity alone.

krn-borel-right-inverse

English name: Kuratowski-Ryll-Nardzewski Borel right inverse theorem

Statement used:
A continuous map from a compact standard-Borel space onto W, with nonempty compact fibers, admits a Borel right inverse.

Classification: NON_MATHLIB

Why this classification:
Specialist measurable-selection theorem.

fubini-tonelli-kernel-integrals

English name: Fubini/Tonelli and kernel integration identities

Statement used:
Iterated integration against Markov kernels is valid and expected payoffs can be rearranged over states, types, actions, messages, and kernels.

Classification: MATHLIB_CANDIDATE

Why this classification:
Mathlib has substantial measure-theory infrastructure, although local Markov-kernel wrappers may be needed.

kernel-infimum-epsilon-selection

English name: Rowwise infimum over Markov kernels via ε-selectors

Statement used:
The infimum over measurable kernels of ∫∫ g(s,m) β(dm|s) τ(ds) equals ∫ inf_m g(s,m) τ(ds) for bounded measurable g, using measurable ε-minimizing selectors.

Classification: NON_MATHLIB

Why this classification:
Combines measurable selection and kernel optimization in a domain-specific packaged theorem.

hyperspace-blaschke-compactness

English name: Blaschke compactness for nonempty compact subsets

Statement used:
The hyperspace of nonempty compact subsets of a compact metric space is compact under Hausdorff distance.

Classification: NON_MATHLIB

Why this classification:
This may become Mathlib-or-local glue, but until compact-set Hausdorff APIs are confirmed it should be stubbed locally.

hausdorff-support-function-lipschitz

English name: Hausdorff Lipschitz continuity of support extrema

Statement used:
Maxima and minima of a bounded linear functional over compact sets vary Lipschitz-continuously with Hausdorff distance.

Classification: MATHLIB_CANDIDATE

Why this classification:
Elementary metric and finite-dimensional linear analysis.

weierstrass-extreme-value

English name: Extreme value theorem on compact spaces

Statement used:
A continuous real-valued function on a compact space attains maximum and minimum.

Classification: MATHLIB_CANDIDATE

Why this classification:
Standard Mathlib theorem.

jankov-von-neumann-universal-selection

English name: Jankov-von Neumann universally measurable selection theorem

Statement used:
An analytic or Borel graph with nonempty sections in standard Borel spaces admits a universally measurable selector.

Classification: NON_MATHLIB

Why this classification:
Specialist descriptive-set result, and it does not by itself give a Borel selector.

geps-borel-selector-upgrade

English name: Borel selector theorem for the ε-contact correspondence

Statement used:
The specific Gε correspondence has enough strengthened regularity to admit a total admissible Borel selector mε : M → M with mε(s) ∈ Gε(s) for every s.

Classification: NON_MATHLIB

Why this classification:
This is the exact patch beyond ordinary JvN and should be explicitly audited.

standard-borel-disintegration

English name: Disintegration theorem for standard Borel spaces

Statement used:
A finite measure on a product of standard Borel spaces admits regular conditional probabilities over a marginal.

Classification: MATHLIB_CANDIDATE

Why this classification:
Flagged as Mathlib-or-partial-import. Mathlib 4 appears to have standard-Borel disintegration infrastructure, including Mathlib.Probability.Kernel.Disintegration.StandardBorel; final import status is for dependency audit.

bayes-posterior-as-conditional-barycenter

English name: Bayesian posterior as conditional barycenter

Statement used:
For finite Ω, the posterior over states after a message equals the barycenter of the conditional distribution of source posteriors given that message.

Classification: NON_MATHLIB

Why this classification:
Project glue connecting the source-posterior process to Bayesian posteriors, even though finite-coordinate algebra follows after disintegration.

support-function-pointwise-separation

English name: Pointwise support-function characterization of closed convex membership

Statement used:
In finite dimension, p ∈ C for a closed convex set C iff all continuous affine functionals at p are bounded by the support function of C.

Classification: MATHLIB_CANDIDATE

Why this classification:
Finite-dimensional separation and convexity are plausible Mathlib material.

support-function-measurable-integrated-separation

English name: Measurable integrated support-function Hall equivalence

Statement used:
The q-a.e. posterior membership condition for a measurable closed-convex correspondence is equivalent to integrated support-function inequalities over measurable events.

Classification: NON_MATHLIB

Why this classification:
The measurable-correspondence and integrated inequality version is specialist.

nonnegative-integral-zero

English name: Nonnegative function with nonpositive expectation vanishes a.e.

Statement used:
If X ≥ 0 a.e. and ∫ X dρ ≤ 0, then X=0 a.e.

Classification: MATHLIB_CANDIDATE

Why this classification:
Standard measure-theory lemma.

atomless-singleton-null

English name: Atomless measures assign zero mass to singletons

Statement used:
Under atomless τ, τ({μ0})=0; this contradicts positive mass forced by dust calibration.

Classification: MATHLIB_CANDIDATE

Why this classification:
Standard measure-theory result.

Implicit Assumptions Surfaced

No unresolved implicit-assumption items remain. The following previously implicit premises are explicit object fields, theorem hypotheses, or named lemmas in the DAG:

Nonemptiness of A, Θ, M, W, and 𝒦(W) is represented in type-action-payoff-primitives, message-support-M, payoff-profile-set-W, and compact-menu-space.

α ∈ [0,1] is a field of robust-trust-model; the τ-a.e. upgrade separately requires 0 < α.

The α = 1 dust branch is explicit in positive-dust-mass-impossible-when-alpha-one; the α < 1 branch is explicit in dust-positive-mass-forces-mu0-atom.

All strategy, profile, and kernel maps carry Borel measurability as fields of their objects or conclusions of selection lemmas.

M is a Borel, compact, standard-Borel support subspace through message-support-M.

Bayes-plausibility/posterior-law consistency is explicit in posterior-law-consistency-field.

The compact standard-Borel topology on private kernels, continuity of Φ, compact nonempty fibers, and surjectivity onto W are bundled in profile-realization-setup.

The ε-contact selector target is total Borel in Geps-selector-exists; JvN plus the Borel upgrade are named externals.

Misaligned kernels are not assumed absolutely continuous with respect to τ.

Regular conditional posteriors are a.e. objects, with the Tier 2 identification handled by posterior-disintegration-menuHall-kernel-coincides.

Support-function Hall requires its own closed-convex, nonempty-value, and measurability hypotheses and is kept auxiliary.

Dust labels live on the subtype NDust; wN, λ, and I are not partial functions on all of M.

Atomlessness of τ is separated into AtomlessTauSharpness and used only in wta-no-free-dust.

The aligned-best selector w* is fixed before defining C†.

The equality between rowwise infimum over w*(M) and minimum over C† is carried by closure-pruning and continuity lemmas.

The deterministic exact-contact adversary and the menu-Hall kernel κ are distinct objects; Tier 2 explicitly chooses κ.

Decomposition Notes

The pass-3 DAG keeps the pass-2 fixes and patches the four remaining load-bearing seams.

First, the full/restricted strategy seam is closed. The menu engine still runs over M, but restricted-agent-strategy-extends-to-full and full-restricted-Ustar-equivalence lift the result back to a full paper strategy σ* : AgentStrategyFull. The main theorem and Tier 1a no longer expose a merely restricted strategy.

Second, the Tier 2 posterior seam is closed. posterior-disintegration-menuHall-kernel-coincides connects the posterior used inside Definition2QAEPredicate κ σ* to the Pγα posterior supplied by menu-Hall.

Third, the WTA sharpness environment is split. WTA-ternary-algebra contains only finite-coordinate WTA algebra. AtomlessTauSharpness is a separate hypothesis used only by wta-no-free-dust. Consequently wta-cone-intersection has no atomlessness dependency.

Fourth, dust labels are subtype-disciplined. NDust := {m : M // m ∈ N} is the domain of wN, λ, and I; qN is a measure on NDust; rowwise support, Bayes-cone calibration, disintegration, and cone conclusions are all stated over m : NDust.

The old bundled sigma-star-realization-and-optimality is split into wstar-profile-map-implemented, wstar-payoff-equals-F-Cdagger, and sigma-star-robust-optimal. The payoff equality at C† is now a visible load-bearing lemma.

The old dust cone lemma is split into dust-disintegration-over-subtype-N, dust-rowwise-support-implies-cone-support, dust-Bayes-calibration-gives-cone-barycenter, and dust-conditional-sources-satisfy-cones. This avoids repeated a.e. coercions.

standard-borel-disintegration is reclassified as MATHLIB_CANDIDATE, flagged as Mathlib-or-partial-import for dependency audit.

The support-function Hall equivalence remains auxiliary and outside the main positive Tier 2 DAG.


## Source INVENTORY.lean (keep stub signatures unchanged)

```lean
/-
INVENTORY.lean — persistent stub file for results invoked by the proof
but not available in Mathlib at the pinned toolchain. Stubs may be
refined into proved statements over time. Inlined into every AXLE
submission since AXLE cannot import non-Mathlib libraries.

Populated 2026-05-19 from `dep_audit_proposed.md` (v3 stub statements).
All 9 NON_MATHLIB externals from the verified dep_audit.md are
represented here; the formalizer (84_lean_formalizer_soft) may refine
signatures when writing main.lean. ALL bodies are `sorry` — the
formalizer / prover roles are responsible for filling them; orchestrator
escalation note for /lean-final-check: every entry in this file must be
listed in `permitted_sorries` if it is genuinely a permanent stub.
-/

import Mathlib

namespace Inventory

open MeasureTheory ProbabilityTheory

/-! ## 1. measurable-maximum-and-argmax-selection (Aliprantis-Border style) -/

theorem measurable_argmax_selector
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace Y] [MeasurableSpace Y]
    [CompactSpace Y] [Nonempty Y]
    {Γ : X → Set Y} {f : X → Y → ℝ}
    (hΓ_meas : MeasurableSet {p : X × Y | p.2 ∈ Γ p.1})
    (hΓ_ne : ∀ x, (Γ x).Nonempty)
    (hΓ_compact : ∀ x, IsCompact (Γ x))
    (hf_meas : Measurable fun p : X × Y => f p.1 p.2)
    (hf_cont : ∀ x, ContinuousOn (fun y => f x y) (Γ x)) :
    ∃ sel : X → Y,
      Measurable sel ∧
      ∀ x, sel x ∈ Γ x ∧
        IsMaxOn (fun y => f x y) (Γ x) (sel x) := by
  sorry

/-! ## 2. profile-geometry-import (private-randomization profile geometry) -/

theorem profile_geometry_import
    {Ω PrivateStrategy : Type*}
    [Fintype Ω]
    [TopologicalSpace PrivateStrategy] [CompactSpace PrivateStrategy] [Nonempty PrivateStrategy]
    [MeasurableSpace PrivateStrategy] [BorelSpace PrivateStrategy]
    (Φ : PrivateStrategy → (Ω → ℝ))
    (hΦ_cont : Continuous Φ)
    (hconvex_realization :
      ∀ σ1 σ2 : PrivateStrategy, ∀ t : ℝ, 0 ≤ t → t ≤ 1 →
        ∃ σt : PrivateStrategy,
          Φ σt = (fun ω => t * Φ σ1 ω + (1 - t) * Φ σ2 ω)) :
    let W : Set (Ω → ℝ) := Set.range Φ
    IsCompact W ∧
    Convex ℝ W ∧
    (∀ w ∈ W, (Φ ⁻¹' {w}).Nonempty ∧ IsCompact (Φ ⁻¹' {w})) := by
  sorry

/-! ## 3. krn-borel-right-inverse (Kuratowski-Ryll-Nardzewski) -/

theorem krn_borel_right_inverse
    {X Y : Type*}
    [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X] [StandardBorelSpace X]
    [TopologicalSpace Y] [MeasurableSpace Y] [BorelSpace Y] [StandardBorelSpace Y]
    [CompactSpace X]
    (Φ : X → Y)
    (hΦ_cont : Continuous Φ)
    (hΦ_surj : Function.Surjective Φ)
    (hfib_compact : ∀ y, IsCompact (Φ ⁻¹' {y}))
    (hfib_ne : ∀ y, (Φ ⁻¹' {y}).Nonempty) :
    ∃ R : Y → X, Measurable R ∧ ∀ y, Φ (R y) = y := by
  sorry

/-! ## 4. kernel-infimum-epsilon-selection (packaged kernel optimisation) -/

theorem kernel_infimum_epsilon_selection
    {S M : Type*}
    [MeasurableSpace S] [TopologicalSpace S] [StandardBorelSpace S]
    [MeasurableSpace M] [TopologicalSpace M] [StandardBorelSpace M] [Nonempty M]
    (τ : Measure S)
    [IsFiniteMeasure τ]
    (g : S → M → ℝ)
    (hg_meas : Measurable fun p : S × M => g p.1 p.2)
    (hg_bdd : ∃ C, ∀ s m, |g s m| ≤ C)
    (hinf_meas : Measurable fun s => sInf (Set.range (g s))) :
    (∀ ε > 0, ∃ β : Kernel S M,
        IsMarkovKernel β ∧
        ∫ s, ∫ m, g s m ∂(β s) ∂τ
          ≤ (∫ s, sInf (Set.range (g s)) ∂τ) + ε) ∧
    (∀ β : Kernel S M, IsMarkovKernel β →
        (∫ s, sInf (Set.range (g s)) ∂τ)
          ≤ ∫ s, ∫ m, g s m ∂(β s) ∂τ) := by
  sorry

/-! ## 5. hausdorff-support-function-lipschitz -/

theorem hausdorff_support_function_lipschitz
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (ℓ : E →L[ℝ] ℝ) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ C D : TopologicalSpace.NonemptyCompacts E,
        |(sSup (ℓ '' (↑C : Set E))) - (sSup (ℓ '' (↑D : Set E)))|
          ≤ L * dist C D := by
  sorry

/-! ## 6. jankov-von-neumann-universal-selection -/

/-- Universal measurability: f is measurable w.r.t. every Borel completion. -/
def UniversallyMeasurable {X Y : Type*} [TopologicalSpace X] [MeasurableSpace X]
    [MeasurableSpace Y] (f : X → Y) : Prop :=
  ∀ μ : Measure X, IsFiniteMeasure μ → AEMeasurable f μ

theorem jankov_von_neumann_universal_selection
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace X] [BorelSpace X] [StandardBorelSpace X]
    [MeasurableSpace Y] [TopologicalSpace Y] [BorelSpace Y] [StandardBorelSpace Y] [Nonempty Y]
    (G : Set (X × Y))
    (hG_analytic : MeasureTheory.AnalyticSet G)
    (hsections : ∀ x, ∃ y, (x, y) ∈ G) :
    ∃ f : X → Y,
      UniversallyMeasurable f ∧ ∀ x, (x, f x) ∈ G := by
  sorry

/-! ## 7. geps-borel-selector-upgrade (KRN with regularity structure) -/

structure GepsRegularity {M : Type*} [TopologicalSpace M] [MeasurableSpace M]
    (Gε : ℝ → M → Set M) (ε : ℝ) : Prop where
  closed_valued : ∀ s : M, IsClosed (Gε ε s)
  graph_measurable : MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}
  sections_measurable : ∀ s : M, MeasurableSet (Gε ε s)

theorem geps_borel_selector_upgrade
    {M : Type*}
    [MetricSpace M]
    [MeasurableSpace M] [BorelSpace M] [StandardBorelSpace M]
    [SecondCountableTopology M]
    [CompactSpace M]
    {Gε : ℝ → M → Set M}
    {ε : ℝ}
    (hε : 0 < ε)
    (hne : ∀ s : M, (Gε ε s).Nonempty)
    (hregular : GepsRegularity Gε ε) :
    ∃ mε : M → M,
      Measurable mε ∧ ∀ s : M, mε s ∈ Gε ε s := by
  sorry

/-! ## 8. bayes-posterior-as-conditional-barycenter -/

theorem bayes_posterior_as_conditional_barycenter
    {Ω : Type*} [Fintype Ω]
    {Belief : Type*} [TopologicalSpace Belief] [MeasurableSpace Belief]
    [BorelSpace Belief] [StandardBorelSpace Belief]
    {M : Type*} [TopologicalSpace M] [MeasurableSpace M] [BorelSpace M] [StandardBorelSpace M]
    (coord : Belief → Ω → ℝ)
    (hcoord_meas : ∀ ω, Measurable (fun s => coord s ω))
    (hcoord_nonneg : ∀ s ω, 0 ≤ coord s ω)
    (hcoord_sum : ∀ s, ∑ ω, coord s ω = 1)
    (μ0 : Ω → ℝ) (hμ0_nonneg : ∀ ω, 0 ≤ μ0 ω) (hμ0_sum : ∑ ω, μ0 ω = 1)
    (π : Ω → Measure Belief)
    [hπ_prob : ∀ ω, IsProbabilityMeasure (π ω)]
    (τ : Measure Belief)
    [IsProbabilityMeasure τ]
    (hposterior_consistency :
      ∀ ω, (ENNReal.ofReal (μ0 ω)) • (π ω) =
        τ.withDensity (fun s => ENNReal.ofReal (coord s ω)))
    (q : Measure M)
    [IsProbabilityMeasure q]
    (χ : Kernel Belief M)
    [IsMarkovKernel χ]
    (hq_marginal : q = (τ.compProd χ).map Prod.snd)
    (ρ : Kernel M Belief)
    [IsMarkovKernel ρ]
    (hρ_disintegration :
      q.compProd ρ =
        (τ.compProd χ).map (fun p : Belief × M => (p.2, p.1)))
    (P : M → Ω → ℝ)
    (hP_meas : ∀ ω, Measurable (fun m => P m ω))
    (hP_bayes_definition :
      ∀ ω : Ω, ∀ᵐ m ∂q,
        P m ω = (μ0 ω) *
                ((((π ω).compProd χ).map Prod.snd).rnDeriv q m).toReal) :
    ∀ᵐ m ∂q, ∀ ω : Ω, P m ω = ∫ s, coord s ω ∂(ρ m) := by
  sorry

/-! ## 9. support-function-measurable-integrated-separation (split v3) -/

/-- A.e. pointwise version (what most use sites need). -/
theorem support_function_ae_pointwise_separation
    {Ω : Type*} [Fintype Ω]
    {M : Type*} [MeasurableSpace M]
    (q : Measure M)
    [IsFiniteMeasure q]
    (B : M → Set (Ω → ℝ))
    (P : M → (Ω → ℝ))
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : M × (Ω → ℝ) | p.2 ∈ B p.1}) :
    (∀ᵐ m ∂q, P m ∈ B m) ↔
      (∀ᵐ m ∂q, ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, ℓ (P m) ≤ sSup (ℓ '' B m)) := by
  sorry

/-- Eventwise integrated Hall form (uncertain stub — formalizer to refine). -/
theorem support_function_integrated_separation
    {Ω : Type*} [Fintype Ω]
    {M : Type*} [MeasurableSpace M]
    (q : Measure M)
    [IsFiniteMeasure q]
    (B : M → Set (Ω → ℝ))
    (P : M → (Ω → ℝ))
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : M × (Ω → ℝ) | p.2 ∈ B p.1})
    (hsupp_meas : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Integrable (fun m => ℓ (P m)) q) :
    ∀ E : Set M, MeasurableSet E → q E ≠ 0 →
      ((∀ᵐ m ∂q.restrict E, P m ∈ B m) ↔
        (∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ,
          ∫ m in E, ℓ (P m) ∂q ≤ ∫ m in E, sSup (ℓ '' B m) ∂q)) := by
  sorry

end Inventory

```
