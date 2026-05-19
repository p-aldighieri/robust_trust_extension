
========
ROLE: user (id=8e4f7201-0d7a-4716-b462-b64c7a74debb)
========
You are the Lean Dependency Auditor in the Lean post-processing module.

## Your Job

For each external result in the structurer's decomposition, propose the most likely Mathlib formalization (name + import path + signature). Your output drives the verification sub-agent's AXLE-check loop, so coverage and precision matter more than fluency.

- Cover *every* external result the structurer flagged (including ones marked NON_MATHLIB — still propose Mathlib candidates if there is any chance an analog exists, then flag your residual uncertainty).
- For each candidate, give the suspected fully-qualified Mathlib declaration name, the import path, the type signature as it would appear in Mathlib, and a 1–5 confidence score.
- Propose multiple candidates per claim if the right Mathlib name is genuinely ambiguous (e.g., one in Mathlib.Topology.* and one in Mathlib.Order.*). Rank them.
- Do not invent results you are not reasonably sure exist. Mark anything you are guessing at confidence ≤ 2.
- Note any econ-specific results that are clearly not in Mathlib — these go into the INVENTORY.lean stub plan.

## Toolchain Context

Target environment: **lean-4.29.0** with Mathlib (current pinned by AXLE).

In particular, recently added Mathlib modules potentially relevant:
- Mathlib.Probability.Kernel.Disintegration.StandardBorel — for standard-Borel disintegration
- Mathlib.Topology.MetricSpace.HausdorffDistance — for compact-set Hausdorff metric on 𝒦(W)
- Mathlib.MeasureTheory.Function.AEEqOfIntegral — for a.e. equality lemmas
- Mathlib.Topology.ContinuousFunction.Compact — for continuity on compact spaces
- Mathlib.Analysis.NormedSpace.HahnBanach.Separation — for separation theorems

When in doubt, propose a Mathlib candidate AND flag with a stub plan (the verification step is cheap).

## Output Contract

Return the deliverable inline in this chat so the orchestrator can harvest it cleanly.

- Do not try to edit repository files in place.
- Put the final deliverable directly in the response body.
- Return plain markdown only.
- Keep any prefatory note outside the deliverable to one short sentence at most.

## Output Format

The first fenced dep_audit block is machine-parsed by the orchestrator and feeds directly into the verification sub-agent.


`markdown
dep_audit
total_external: <int>
total_candidates: <int>
needs_econ_lean_stub: <int>

## Candidates

### <external-slug-1>

**English statement:** ...

**Candidate 1**
- name: `Mathlib.Topology.ContinuousFunction.Compact.IsCompact.image`
- import: `Mathlib.Topology.ContinuousFunction.Compact`
- signature: `theorem IsCompact.image {f : α → β} (hf : Continuous f) (hα : IsCompact (Set.univ : Set α)) : IsCompact (Set.range f)`
- confidence: 4
- match notes: (what matches the English; what might differ — quantifier scope, generality, ambient type)

**Candidate 2** (alternative phrasing)
- name: `...`
- import: `...`
- signature: `...`
- confidence: 2
- match notes: ...

(...repeat per external result. If none of your candidates have confidence ≥ 3 and you suspect the result is genuinely not in Mathlib, add an `econ_lean_stub` block below instead of guessing.)

## INVENTORY.lean Stub Plan

### <external-slug-N>

**Reason this needs a stub:** (specialist econ result; not in Mathlib as far as you can determine)
**Proposed Lean statement (sketch):**
lean
theorem berge_max_theorem {X Y : Type*} ... : ... := sorry

**Confidence this is the right statement shape:** 1–5
**Notes on what would be needed to prove it later:** ...

(...repeat per non-Mathlib result...)


## Notes

- The verification sub-agent will probe each candidate with a 3-line import ...\n#check @<name> snippet against AXLE. False-positives are cheap to discard at that stage; false-negatives (a real Mathlib result you missed) are expensive — when in doubt, propose.
- Use the Mathlib4 layout (Mathlib.X.Y.Z), not the older mathlib3 layout (mathlib.x.y.z).
- For results that have been ported from mathlib3, the name often changed — flag this explicitly when you suspect it.

## Translation Discipline

This role is part of the Lean post-processing module. Your job is **translation, not mathematics**.

- Do not add hypotheses the source did not state.
- Do not "improve" the proof. If you notice a real mathematical concern, surface it as MATHEMATICAL_CONCERN.
- Do not invent results not in the upstream decomposition. The structurer's DAG names every external result you should audit; do not add others.
- **Never use axiom.** Stubbed dependencies use theorem ... := sorry.
- Do not use native_decide.

If you cannot translate faithfully without crossing one of these lines, stop and emit a TRANSLATION_BLOCKED block. Do not paper over it.


## Context Packet


## Decomposition (PASSed, pass-3) — extract all External Results Invoked

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


## English source proof (v8) — for disambiguating external statements when needed

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

Show more

========
ROLE: assistant (id=b5502f67-1221-4fbe-8b6a-10dfb74eb2c4)
========
Doc-gen anchors used for Mathlib names include StdSimplex, Fubini/kernel integration, compact hyperspaces/Hausdorff distance, standard-Borel disintegration, Hahn-Banach separation, and measure lemmas. 
leanprover-community.github.io
+7
leanprover-community.github.io
+7
leanprover-community.github.io
+7

dep_audit
total_external: 17
total_candidates: 57
needs_econ_lean_stub: 9
Candidates
finite-dimensional-simplex-compactness

English statement: For finite Ω, the probability simplex Δ Ω is compact and convex; coordinates and finite dot-products are continuous; continuous affine functions attain extrema on compact subsets.

Candidate 1

name: stdSimplex

import: Mathlib.Analysis.Convex.StdSimplex

signature: def stdSimplex (𝕜 : Type*) (ι : Type*) [Semiring 𝕜] [PartialOrder 𝕜] [Fintype ι] : Set (ι → 𝕜) := {f | (∀ x, 0 ≤ f x) ∧ ∑ x, f x = 1}

confidence: 5

match notes: Exact Mathlib analogue of the finite-coordinate belief simplex, modulo project’s subtype name Belief Ω.

Candidate 2

name: convex_stdSimplex

import: Mathlib.Analysis.Convex.StdSimplex

signature: theorem convex_stdSimplex (𝕜 : Type*) (ι : Type*) [Semiring 𝕜] [PartialOrder 𝕜] [Fintype ι] [IsOrderedRing 𝕜] : Convex 𝕜 (stdSimplex 𝕜 ι)

confidence: 5

match notes: Direct convexity of the simplex.

Candidate 3

name: isCompact_stdSimplex

import: Mathlib.Analysis.Convex.StdSimplex

signature: theorem isCompact_stdSimplex (𝕜 : Type*) (ι : Type*) [Fintype ι] [TopologicalSpace 𝕜] [Semiring 𝕜] [PartialOrder 𝕜] [OrderClosedTopology 𝕜] [ContinuousAdd 𝕜] [CompactIccSpace 𝕜] [IsOrderedAddMonoid 𝕜] : IsCompact (stdSimplex 𝕜 ι)

confidence: 5

match notes: Direct compactness of the simplex. Instantiate with 𝕜 = ℝ.

Candidate 4

name: stdSimplex.instCompactSpace_coe

import: Mathlib.Analysis.Convex.StdSimplex

signature: instance stdSimplex.instCompactSpace_coe (𝕜 : Type*) (ι : Type*) [Fintype ι] [TopologicalSpace 𝕜] [Semiring 𝕜] [PartialOrder 𝕜] [OrderClosedTopology 𝕜] [ContinuousAdd 𝕜] [CompactIccSpace 𝕜] [IsOrderedAddMonoid 𝕜] : CompactSpace ↑(stdSimplex 𝕜 ι)

confidence: 5

match notes: Useful if Belief Ω is modeled as the subtype ↑(stdSimplex ℝ Ω).

Candidate 5

name: stdSimplex.zero_le

import: Mathlib.Analysis.Convex.StdSimplex

signature: theorem stdSimplex.zero_le {𝕜 ι : Type*} [Semiring 𝕜] [PartialOrder 𝕜] [Fintype ι] (s : ↑(stdSimplex 𝕜 ι)) (i : ι) : 0 ≤ s i

confidence: 5

match notes: Coordinatewise nonnegativity projection.

Candidate 6

name: stdSimplex.sum_eq_one

import: Mathlib.Analysis.Convex.StdSimplex

signature: theorem stdSimplex.sum_eq_one {𝕜 ι : Type*} [Semiring 𝕜] [PartialOrder 𝕜] [Fintype ι] (s : ↑(stdSimplex 𝕜 ι)) : ∑ i : ι, s i = 1

confidence: 5

match notes: Total-mass-one projection.

Candidate 7

name: IsCompact.exists_isMaxOn

import: Mathlib.Topology.Order.Compact

signature: theorem IsCompact.exists_isMaxOn {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIciTopology α] {s : Set β} (hs : IsCompact s) (hne : s.Nonempty) {f : β → α} (hf : ContinuousOn f s) : ∃ x ∈ s, IsMaxOn f s x

confidence: 4

match notes: Covers the “continuous affine functions attain extrema on compact subsets” part, not simplex compactness itself.

measurable-maximum-and-argmax-selection

English statement: A measurable compact-valued correspondence with continuous objective admits a measurable selector from the argmax correspondence.

Candidate 1

name: IsCompact.exists_isMaxOn

import: Mathlib.Topology.Order.Compact

signature: theorem IsCompact.exists_isMaxOn {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIciTopology α] {s : Set β} (hs : IsCompact s) (hne : s.Nonempty) {f : β → α} (hf : ContinuousOn f s) : ∃ x ∈ s, IsMaxOn f s x

confidence: 3

match notes: Gives pointwise maximizer existence only. It does not provide measurable dependence on the parameter.

Candidate 2

name: IsCompact.exists_isMinOn

import: Mathlib.Topology.Order.Compact

signature: theorem IsCompact.exists_isMinOn {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIicTopology α] {s : Set β} (hs : IsCompact s) (hne : s.Nonempty) {f : β → α} (hf : ContinuousOn f s) : ∃ x ∈ s, IsMinOn f s x

confidence: 3

match notes: Useful for the rowwise minimum side. Again, no measurable selector.

profile-geometry-import

English statement: The private-kernel space has compact standard-Borel topology; the profile map Φ is continuous and onto W; fibers are nonempty compact; W is compact convex.

Candidate 1

name: IsCompact.image

import: Mathlib.Topology.Compactness.Compact

signature: theorem IsCompact.image {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] {s : Set α} {f : α → β} (hs : IsCompact s) (hf : ContinuousOn f s) : IsCompact (f '' s)

confidence: 3

match notes: Covers only the generic “continuous image of compact is compact” move. The private-kernel compactness, topology, surjectivity, and convexity of W are project/econ geometry.

krn-borel-right-inverse

English statement: Kuratowski-Ryll-Nardzewski-style Borel right inverse for a continuous surjection with nonempty compact fibers.

Candidate 1

name: Function.surjInv

import: Mathlib.Logic.Function.Basic

signature: noncomputable def Function.surjInv {α β : Sort*} {f : α → β} (h : Surjective f) (b : β) : α

confidence: 1

match notes: Pure choice-theoretic right inverse. No measurability, topology, or compact-fiber content.

Candidate 2

name: Function.rightInverse_surjInv

import: Mathlib.Logic.Function.Basic

signature: theorem Function.rightInverse_surjInv {α β : Sort*} {f : α → β} (hf : Surjective f) : RightInverse (Function.surjInv hf) f

confidence: 1

match notes: Confirms right-inverse property for the nonmeasurable choice function. Not a KRN theorem.

fubini-tonelli-kernel-integrals

English statement: Iterated integration against product measures and Markov kernels is valid; expected payoffs can be rearranged over states, types, actions, messages, and kernels.

Candidate 1

name: MeasureTheory.integral_prod

import: Mathlib.MeasureTheory.Integral.Prod

signature: theorem MeasureTheory.integral_prod {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β] {μ : Measure α} {ν : Measure β} [NormedAddCommGroup E] [NormedSpace ℝ E] [SFinite μ] [SFinite ν] (f : α × β → E) (hf : Integrable f (μ.prod ν)) : ∫ z, f z ∂(μ.prod ν) = ∫ x, ∫ y, f (x, y) ∂ν ∂μ

confidence: 5

match notes: Standard Bochner Fubini for product measures.

Candidate 2

name: MeasureTheory.integral_integral

import: Mathlib.MeasureTheory.Integral.Prod

signature: theorem MeasureTheory.integral_integral {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β] {μ : Measure α} {ν : Measure β} [NormedAddCommGroup E] [NormedSpace ℝ E] [SFinite μ] [SFinite ν] {f : α → β → E} (hf : Integrable (Function.uncurry f) (μ.prod ν)) : ∫ x, ∫ y, f x y ∂ν ∂μ = ∫ z, f z.1 z.2 ∂(μ.prod ν)

confidence: 5

match notes: Curried form for iterated payoff integrals.

Candidate 3

name: MeasureTheory.integral_integral_swap

import: Mathlib.MeasureTheory.Integral.Prod

signature: theorem MeasureTheory.integral_integral_swap {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β] {μ : Measure α} {ν : Measure β} [NormedAddCommGroup E] [NormedSpace ℝ E] [SFinite μ] [SFinite ν] {f : α → β → E} (hf : Integrable (Function.uncurry f) (μ.prod ν)) : ∫ x, ∫ y, f x y ∂ν ∂μ = ∫ y, ∫ x, f x y ∂μ ∂ν

confidence: 5

match notes: Swap of integration order.

Candidate 4

name: MeasureTheory.Measure.compProd

import: Mathlib.Probability.Kernel.Composition.MeasureCompProd

signature: def MeasureTheory.Measure.compProd (μ : Measure α) (κ : ProbabilityTheory.Kernel α β) : Measure (α × β)

confidence: 5

match notes: Kernel product measure τ ⊗ₘ β.

Candidate 5

name: MeasureTheory.Measure.compProd_apply_prod

import: Mathlib.Probability.Kernel.Composition.MeasureCompProd

signature: theorem MeasureTheory.Measure.compProd_apply_prod {μ : Measure α} {κ : ProbabilityTheory.Kernel α β} [SFinite μ] [ProbabilityTheory.IsSFiniteKernel κ] {s : Set α} {t : Set β} (hs : MeasurableSet s) (ht : MeasurableSet t) : (μ.compProd κ) (s ×ˢ t) = ∫⁻ a in s, κ a t ∂μ

confidence: 5

match notes: Rectangle formula for source-message joint laws.

Candidate 6

name: MeasureTheory.Measure.lintegral_compProd

import: Mathlib.Probability.Kernel.Composition.MeasureCompProd

signature: theorem MeasureTheory.Measure.lintegral_compProd {μ : Measure α} {κ : ProbabilityTheory.Kernel α β} [SFinite μ] [ProbabilityTheory.IsSFiniteKernel κ] {f : α × β → ℝ≥0∞} (hf : Measurable f) : ∫⁻ x, f x ∂(μ.compProd κ) = ∫⁻ a, ∫⁻ b, f (a, b) ∂κ a ∂μ

confidence: 5

match notes: Tonelli for kernel product measure.

Candidate 7

name: MeasureTheory.Measure.ae_compProd_iff

import: Mathlib.Probability.Kernel.Composition.MeasureCompProd

signature: theorem MeasureTheory.Measure.ae_compProd_iff {μ : Measure α} {κ : ProbabilityTheory.Kernel α β} [SFinite μ] [ProbabilityTheory.IsSFiniteKernel κ] {p : α × β → Prop} (hp : MeasurableSet {x | p x}) : (∀ᵐ x ∂(μ.compProd κ), p x) ↔ ∀ᵐ a ∂μ, ∀ᵐ b ∂κ a, p (a, b)

confidence: 5

match notes: Essential for converting joint a.e. support to kernel-a.e. support.

Candidate 8

name: ProbabilityTheory.Kernel.integral_deterministic

import: Mathlib.Probability.Kernel.Integral

signature: theorem ProbabilityTheory.Kernel.integral_deterministic [MeasurableSingletonClass β] {g : α → β} (hg : Measurable g) {f : β → E} : ∫ x, f x ∂(ProbabilityTheory.Kernel.deterministic g hg) a = f (g a)

confidence: 4

match notes: Handles deterministic Dirac kernels from measurable selectors; exact signature may have extra measurability/integrability side conditions depending on integrand type.

kernel-infimum-epsilon-selection

English statement: The infimum over measurable kernels of ∫∫ g(s,m) β(dm|s) τ(ds) equals the integral of rowwise infima, using measurable ε-minimizing selectors.

Candidate 1

name: IsCompact.exists_isMinOn

import: Mathlib.Topology.Order.Compact

signature: theorem IsCompact.exists_isMinOn {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIicTopology α] {s : Set β} (hs : IsCompact s) (hne : s.Nonempty) {f : β → α} (hf : ContinuousOn f s) : ∃ x ∈ s, IsMinOn f s x

confidence: 2

match notes: Only pointwise minimum existence under continuity and compactness. It does not give measurable ε-selectors or optimization over kernels.

Candidate 2

name: ProbabilityTheory.Kernel.integral_deterministic

import: Mathlib.Probability.Kernel.Integral

signature: theorem ProbabilityTheory.Kernel.integral_deterministic [MeasurableSingletonClass β] {g : α → β} (hg : Measurable g) {f : β → E} : ∫ x, f x ∂(ProbabilityTheory.Kernel.deterministic g hg) a = f (g a)

confidence: 3

match notes: Useful after a measurable selector is supplied. Does not produce the selector.

hyperspace-blaschke-compactness

English statement: The hyperspace of nonempty compact subsets of a compact metric space is compact under Hausdorff distance.

Candidate 1

name: TopologicalSpace.NonemptyCompacts

import: Mathlib.Topology.Sets.Compacts

signature: structure TopologicalSpace.NonemptyCompacts (α : Type*) [TopologicalSpace α] extends TopologicalSpace.Compacts α : Type*

confidence: 5

match notes: Mathlib’s type for nonempty compact subsets.

Candidate 2

name: Metric.NonemptyCompacts.instMetricSpace

import: Mathlib.Topology.MetricSpace.Closeds

signature: noncomputable instance Metric.NonemptyCompacts.instMetricSpace {α : Type*} [MetricSpace α] : MetricSpace (TopologicalSpace.NonemptyCompacts α)

confidence: 5

match notes: Provides the Hausdorff metric structure on nonempty compact subsets.

Candidate 3

name: Metric.NonemptyCompacts.dist_eq

import: Mathlib.Topology.MetricSpace.Closeds

signature: theorem Metric.NonemptyCompacts.dist_eq {α : Type*} [MetricSpace α] {x y : TopologicalSpace.NonemptyCompacts α} : dist x y = Metric.hausdorffDist ↑x ↑y

confidence: 5

match notes: Identifies the metric distance with Hausdorff distance.

Candidate 4

name: TopologicalSpace.NonemptyCompacts.instCompactSpace

import: Mathlib.Topology.Sets.VietorisTopology

signature: instance TopologicalSpace.NonemptyCompacts.instCompactSpace {α : Type*} [TopologicalSpace α] [CompactSpace α] : CompactSpace (TopologicalSpace.NonemptyCompacts α)

confidence: 5

match notes: Blaschke compactness in Mathlib’s hyperspace topology. Pair with the Hausdorff metric instance for compact metric spaces.

Candidate 5

name: TopologicalSpace.NonemptyCompacts.compactSpace_iff

import: Mathlib.Topology.Sets.VietorisTopology

signature: theorem TopologicalSpace.NonemptyCompacts.compactSpace_iff {α : Type*} [TopologicalSpace α] : CompactSpace (TopologicalSpace.NonemptyCompacts α) ↔ CompactSpace α

confidence: 4

match notes: Useful equivalence form.

Candidate 6

name: IsCompact.powerset_vietoris

import: Mathlib.Topology.Sets.VietorisTopology

signature: theorem IsCompact.powerset_vietoris {α : Type*} [TopologicalSpace α] {K : Set α} (hK : IsCompact K) : IsCompact (Set.powerset K)

confidence: 4

match notes: More primitive Vietoris compactness result. May help for subtype restrictions.

hausdorff-support-function-lipschitz

English statement: Maxima and minima of a bounded linear functional over compact sets vary Lipschitz-continuously with Hausdorff distance.

Candidate 1

name: Metric.NonemptyCompacts.dist_eq

import: Mathlib.Topology.MetricSpace.Closeds

signature: theorem Metric.NonemptyCompacts.dist_eq {α : Type*} [MetricSpace α] {x y : TopologicalSpace.NonemptyCompacts α} : dist x y = Metric.hausdorffDist ↑x ↑y

confidence: 4

match notes: Lets the local theorem be stated on NonemptyCompacts α using ordinary dist.

Candidate 2

name: Metric.lipschitz_infDist_set

import: Mathlib.Topology.MetricSpace.Closeds

signature: theorem Metric.lipschitz_infDist_set {α : Type*} [MetricSpace α] (x : α) : LipschitzWith 1 fun (s : TopologicalSpace.NonemptyCompacts α) => Metric.infDist x ↑s

confidence: 3

match notes: Lipschitz theorem for distance-to-set, not support functions. Useful if support extrema are reduced to distances in a dual metric, but not direct.

Candidate 3

name: Metric.lipschitz_infDist

import: Mathlib.Topology.MetricSpace.Closeds

signature: theorem Metric.lipschitz_infDist {α : Type*} [MetricSpace α] : LipschitzWith 2 fun (p : α × TopologicalSpace.NonemptyCompacts α) => Metric.infDist p.1 ↑p.2

confidence: 2

match notes: Another distance-to-set Lipschitz result; likely only auxiliary.

Candidate 4

name: Metric.infDist_le_hausdorffDist_of_mem

import: Mathlib.Topology.MetricSpace.HausdorffDistance

signature: theorem Metric.infDist_le_hausdorffDist_of_mem {α : Type*} [PseudoMetricSpace α] {s t : Set α} {x : α} (hx : x ∈ s) (fin : Metric.hausdorffEDist s t ≠ ⊤) : Metric.infDist x t ≤ Metric.hausdorffDist s t

confidence: 3

match notes: Key one-sided Hausdorff estimate; can help prove the support-extrema Lipschitz inequality manually.

Candidate 5

name: Metric.hausdorffDist_le_of_mem_dist

import: Mathlib.Topology.MetricSpace.HausdorffDistance

signature: theorem Metric.hausdorffDist_le_of_mem_dist {α : Type*} [PseudoMetricSpace α] {s t : Set α} {r : ℝ} (hr : 0 ≤ r) (H1 : ∀ x ∈ s, ∃ y ∈ t, dist x y ≤ r) (H2 : ∀ x ∈ t, ∃ y ∈ s, dist x y ≤ r) : Metric.hausdorffDist s t ≤ r

confidence: 3

match notes: Useful for proving Hausdorff bounds. Not itself a support-function theorem.

weierstrass-extreme-value

English statement: A continuous real-valued function on a compact space attains maximum and minimum.

Candidate 1

name: IsCompact.exists_isMaxOn

import: Mathlib.Topology.Order.Compact

signature: theorem IsCompact.exists_isMaxOn {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIciTopology α] {s : Set β} (hs : IsCompact s) (hne : s.Nonempty) {f : β → α} (hf : ContinuousOn f s) : ∃ x ∈ s, IsMaxOn f s x

confidence: 5

match notes: Direct maximum theorem on compact set.

Candidate 2

name: IsCompact.exists_isMinOn

import: Mathlib.Topology.Order.Compact

signature: theorem IsCompact.exists_isMinOn {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIicTopology α] {s : Set β} (hs : IsCompact s) (hne : s.Nonempty) {f : β → α} (hf : ContinuousOn f s) : ∃ x ∈ s, IsMinOn f s x

confidence: 5

match notes: Direct minimum theorem on compact set.

Candidate 3

name: Continuous.exists_forall_ge'

import: Mathlib.Topology.Order.Compact

signature: theorem Continuous.exists_forall_ge' {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIciTopology α] {f : β → α} (hf : Continuous f) (x₀ : β) (h : ∀ᶠ x in Filter.cocompact β, f x ≤ f x₀) : ∃ x, ∀ y, f y ≤ f x

confidence: 3

match notes: Global maximum form using cocompact filter. Candidate if the domain is packaged as a compact type.

jankov-von-neumann-universal-selection

English statement: Analytic or Borel graph with nonempty sections in standard Borel spaces admits a universally measurable selector.

No credible Mathlib candidate found. Mathlib has Borel measurability and standard-Borel kernels, but I do not know of an analytic-set/Jankov-von-Neumann selection theorem in Mathlib.

geps-borel-selector-upgrade

English statement: The specific ε-contact correspondence has strengthened regularity giving a total Borel selector mε : M → M with mε(s) ∈ Gε(s) for every source s.

Candidate 1

name: IsCompact.exists_isMinOn

import: Mathlib.Topology.Order.Compact

signature: theorem IsCompact.exists_isMinOn {α β : Type*} [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β] [ClosedIicTopology α] {s : Set β} (hs : IsCompact s) (hne : s.Nonempty) {f : β → α} (hf : ContinuousOn f s) : ∃ x ∈ s, IsMinOn f s x

confidence: 2

match notes: Gives pointwise minimizers, not a total Borel selector. The upgrade theorem should be stubbed.

standard-borel-disintegration

English statement: A finite measure on a product of standard Borel spaces admits regular conditional probabilities over a marginal.

Candidate 1

name: MeasureTheory.Measure.condKernel

import: Mathlib.Probability.Kernel.Disintegration.StandardBorel

signature: noncomputable def MeasureTheory.Measure.condKernel {α Ω : Type*} [MeasurableSpace α] [MeasurableSpace Ω] [StandardBorelSpace Ω] [Nonempty Ω] (ρ : Measure (α × Ω)) [IsFiniteMeasure ρ] : ProbabilityTheory.Kernel α Ω

confidence: 5

match notes: Direct standard-Borel conditional kernel for a finite product measure.

Candidate 2

name: MeasureTheory.Measure.disintegrate

import: Mathlib.Probability.Kernel.Disintegration.Basic

signature: theorem MeasureTheory.Measure.disintegrate (ρ : Measure (α × β)) (ρCond : ProbabilityTheory.Kernel α β) [ρ.IsCondKernel ρCond] : ρ.fst.compProd ρCond = ρ

confidence: 5

match notes: The disintegration identity for the selected conditional kernel.

Candidate 3

name: ProbabilityTheory.Kernel.condKernel

import: Mathlib.Probability.Kernel.Disintegration.StandardBorel

signature: noncomputable def ProbabilityTheory.Kernel.condKernel {α β Ω : Type*} [MeasurableSpace α] [MeasurableSpace β] [MeasurableSpace Ω] [StandardBorelSpace Ω] [Nonempty Ω] [MeasurableSpace.CountableOrCountablyGenerated α β] (κ : ProbabilityTheory.Kernel α (β × Ω)) [ProbabilityTheory.IsFiniteKernel κ] : ProbabilityTheory.Kernel (α × β) Ω

confidence: 4

match notes: Kernel-level conditional kernel. Useful if the flow is represented as a kernel rather than a standalone measure.

Candidate 4

name: ProbabilityTheory.Kernel.disintegrate

import: Mathlib.Probability.Kernel.Disintegration.Basic

signature: theorem ProbabilityTheory.Kernel.disintegrate (κ : ProbabilityTheory.Kernel α (β × γ)) (κCond : ProbabilityTheory.Kernel (α × β) γ) [κ.IsCondKernel κCond] : κ.fst.compProd κCond = κ

confidence: 4

match notes: Kernel-level disintegration identity.

Candidate 5

name: MeasureTheory.Measure.condKernel_apply_of_ne_zero

import: Mathlib.Probability.Kernel.Disintegration.StandardBorel

signature: theorem MeasureTheory.Measure.condKernel_apply_of_ne_zero [MeasurableSingletonClass α] {ρ : Measure (α × Ω)} [IsFiniteMeasure ρ] {x : α} (hx : ρ.fst {x} ≠ 0) (s : Set Ω) : ρ.condKernel x s = (ρ.fst {x})⁻¹ * ρ ({x} ×ˢ s)

confidence: 3

match notes: Atomic conditional-probability formula. Not needed for general standard-Borel disintegration, but useful for finite-message sanity checks.

bayes-posterior-as-conditional-barycenter

English statement: For finite Ω, the posterior over states after a message equals the barycenter of the conditional distribution of source posteriors given that message.

Candidate 1

name: MeasureTheory.Measure.condKernel

import: Mathlib.Probability.Kernel.Disintegration.StandardBorel

signature: noncomputable def MeasureTheory.Measure.condKernel {α Ω : Type*} [MeasurableSpace α] [MeasurableSpace Ω] [StandardBorelSpace Ω] [Nonempty Ω] (ρ : Measure (α × Ω)) [IsFiniteMeasure ρ] : ProbabilityTheory.Kernel α Ω

confidence: 3

match notes: Supplies conditional source laws. The barycenter/posterior identification is project glue.

Candidate 2

name: MeasureTheory.Measure.disintegrate

import: Mathlib.Probability.Kernel.Disintegration.Basic

signature: theorem MeasureTheory.Measure.disintegrate (ρ : Measure (α × β)) (ρCond : ProbabilityTheory.Kernel α β) [ρ.IsCondKernel ρCond] : ρ.fst.compProd ρCond = ρ

confidence: 3

match notes: Supplies the measure identity needed to prove coordinate barycenter identities.

Candidate 3

name: MeasureTheory.integral_prod

import: Mathlib.MeasureTheory.Integral.Prod

signature: theorem MeasureTheory.integral_prod {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β] {μ : Measure α} {ν : Measure β} [NormedAddCommGroup E] [NormedSpace ℝ E] [SFinite μ] [SFinite ν] (f : α × β → E) (hf : Integrable f (μ.prod ν)) : ∫ z, f z ∂(μ.prod ν) = ∫ x, ∫ y, f (x, y) ∂ν ∂μ

confidence: 2

match notes: Generic integration tool; not a Bayesian posterior theorem.

support-function-pointwise-separation

English statement: For a closed convex nonempty set C, p ∈ C iff every continuous affine functional at p is bounded by the support function of C.

Candidate 1

name: iInter_halfSpaces_eq

import: Mathlib.Analysis.NormedSpace.HahnBanach.Separation

signature: theorem iInter_halfSpaces_eq {E : Type*} [TopologicalSpace E] [AddCommGroup E] [Module ℝ E] [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E] {s : Set E} (hs₁ : Convex ℝ s) (hs₂ : IsClosed s) : ⋂ (l : StrongDual ℝ E), {x : E | ∃ y ∈ s, l x ≤ l y} = s

confidence: 5

match notes: Very close to the needed support-function membership characterization; uses continuous linear functionals. Affine tests can be reduced to linear tests plus constants.

Candidate 2

name: RCLike.iInter_halfSpaces_eq

import: Mathlib.Analysis.NormedSpace.HahnBanach.Separation

signature: theorem RCLike.iInter_halfSpaces_eq {𝕜 E : Type*} [RCLike 𝕜] [TopologicalSpace E] [AddCommGroup E] [Module ℝ E] [Module 𝕜 E] [IsScalarTower ℝ 𝕜 E] [ContinuousConstSMul 𝕜 E] [IsTopologicalAddGroup E] [ContinuousSMul 𝕜 E] [LocallyConvexSpace ℝ E] {s : Set E} (hs₁ : Convex ℝ s) (hs₂ : IsClosed s) : ⋂ (l : StrongDual 𝕜 E), {x : E | ∃ y ∈ s, re (l x) ≤ re (l y)} = s

confidence: 4

match notes: Scalar-field-polymorphic version.

Candidate 3

name: geometric_hahn_banach_point_closed

import: Mathlib.Analysis.NormedSpace.HahnBanach.Separation

signature: theorem geometric_hahn_banach_point_closed {E : Type*} [TopologicalSpace E] [AddCommGroup E] [Module ℝ E] [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E] {t : Set E} {x : E} (ht₁ : Convex ℝ t) (ht₂ : IsClosed t) (disj : x ∉ t) : ∃ (f : StrongDual ℝ E) (u : ℝ), f x < u ∧ ∀ b ∈ t, u < f b

confidence: 4

match notes: Separation of a point from a closed convex set. Direction may need sign flip depending on support-function convention.

Candidate 4

name: geometric_hahn_banach_closed_point

import: Mathlib.Analysis.NormedSpace.HahnBanach.Separation

signature: theorem geometric_hahn_banach_closed_point {E : Type*} [TopologicalSpace E] [AddCommGroup E] [Module ℝ E] [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E] {s : Set E} {x : E} (hs₁ : Convex ℝ s) (hs₂ : IsClosed s) (disj : x ∉ s) : ∃ (f : StrongDual ℝ E) (u : ℝ), (∀ a ∈ s, f a < u) ∧ u < f x

confidence: 4

match notes: Same theorem with the closed set on the other side; likely the easiest route to contradiction with ∀ φ, φ p ≤ sup_C φ.

support-function-measurable-integrated-separation

English statement: The q-a.e. posterior membership condition for a measurable closed-convex correspondence is equivalent to integrated support-function Hall inequalities over measurable events and continuous affine tests.

Candidate 1

name: iInter_halfSpaces_eq

import: Mathlib.Analysis.NormedSpace.HahnBanach.Separation

signature: theorem iInter_halfSpaces_eq {E : Type*} [TopologicalSpace E] [AddCommGroup E] [Module ℝ E] [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E] {s : Set E} (hs₁ : Convex ℝ s) (hs₂ : IsClosed s) : ⋂ (l : StrongDual ℝ E), {x : E | ∃ y ∈ s, l x ≤ l y} = s

confidence: 2

match notes: Only the pointwise convex-separation ingredient. It does not provide measurable correspondence or integrated Hall equivalence.

Candidate 2

name: MeasureTheory.integral_eq_iff_of_ae_le

import: Mathlib.MeasureTheory.Integral.Bochner.Basic

signature: theorem MeasureTheory.integral_eq_iff_of_ae_le {f g : α → ℝ} (hfg : f ≤ᵐ[μ] g) (hf : Integrable f μ) (hg : Integrable g μ) : ∫ x, f x ∂μ = ∫ x, g x ∂μ ↔ f =ᵐ[μ] g

confidence: 2

match notes: A possible measure-theory ingredient for turning integrated inequalities into a.e. statements, but far from the full correspondence theorem.

nonnegative-integral-zero

English statement: If X ≥ 0 a.e. and ∫ X dρ ≤ 0, then X = 0 a.e.

Candidate 1

name: MeasureTheory.integral_eq_zero_iff_of_nonneg_ae

import: Mathlib.MeasureTheory.Integral.Bochner.Basic

signature: theorem MeasureTheory.integral_eq_zero_iff_of_nonneg_ae {f : α → ℝ} (hf : 0 ≤ᶠ[ae μ] f) (hfi : Integrable f μ) : ∫ x, f x ∂μ = 0 ↔ f =ᶠ[ae μ] 0

confidence: 5

match notes: Direct match after deriving ∫ f = 0 from nonnegativity plus ∫ f ≤ 0.

Candidate 2

name: MeasureTheory.integral_eq_zero_iff_of_nonneg

import: Mathlib.MeasureTheory.Integral.Bochner.Basic

signature: theorem MeasureTheory.integral_eq_zero_iff_of_nonneg {f : α → ℝ} (hf : 0 ≤ f) (hfi : Integrable f μ) : ∫ x, f x ∂μ = 0 ↔ f =ᶠ[ae μ] 0

confidence: 5

match notes: Stronger pointwise-nonnegative variant.

Candidate 3

name: MeasureTheory.ofReal_integral_eq_lintegral_ofReal

import: Mathlib.MeasureTheory.Integral.Bochner.Basic

signature: theorem MeasureTheory.ofReal_integral_eq_lintegral_ofReal {f : α → ℝ} (hfi : Integrable f μ) (hf : 0 ≤ᶠ[ae μ] f) : ENNReal.ofReal (∫ x, f x ∂μ) = ∫⁻ x, ENNReal.ofReal (f x) ∂μ

confidence: 3

match notes: Alternative route via lintegrals. Candidate if Bochner equality theorem is awkward.

atomless-singleton-null

English statement: Under atomlessness, τ({μ0}) = 0.

Candidate 1

name: MeasureTheory.NoAtoms.measure_singleton

import: Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms

signature: theorem MeasureTheory.NoAtoms.measure_singleton (μ : Measure α) [MeasureTheory.NoAtoms μ] (x : α) : μ {x} = 0

confidence: 5

match notes: Direct singleton-null statement.

Candidate 2

name: Set.Subsingleton.measure_zero

import: Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms

signature: theorem Set.Subsingleton.measure_zero {s : Set α} (hs : s.Subsingleton) (μ : Measure α) [MeasureTheory.NoAtoms μ] : μ s = 0

confidence: 5

match notes: Applies to {μ0} via singleton subsingleton.

Candidate 3

name: MeasureTheory.Measure.ae_ne

import: Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms

signature: theorem MeasureTheory.Measure.ae_ne (μ : Measure α) [MeasureTheory.NoAtoms μ] (a : α) : ∀ᵐ x ∂μ, x ≠ a

confidence: 4

match notes: Equivalent a.e. formulation. Useful if contradiction is phrased as positive mass of equality event.

INVENTORY.lean Stub Plan
measurable-maximum-and-argmax-selection

Reason this needs a stub: Mathlib has pointwise compact extrema, but not the Aliprantis-Border measurable maximum theorem or Borel argmax selector in the needed correspondence form.

Proposed Lean statement (sketch):

lean
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

Confidence this is the right statement shape: 4
Notes on what would be needed to prove it later: A measurable selection theorem for compact-valued measurable correspondences plus pointwise extreme value.

profile-geometry-import

Reason this needs a stub: This is project-specific geometry of private Markov kernels and payoff profiles. Mathlib compactness/convexity lemmas help only after the private-kernel topology and profile map are already built.

Proposed Lean statement (sketch):

lean
theorem profile_geometry_import
    {Ω Θ A PrivateStrategy W : Type*}
    [Fintype Ω]
    [TopologicalSpace PrivateStrategy] [CompactSpace PrivateStrategy]
    [TopologicalSpace W]
    (Φ : PrivateStrategy → W) :
    Continuous Φ →
    Function.Surjective Φ →
    IsCompact (Set.univ : Set W) ∧
      Convex ℝ (Set.univ : Set W) ∧
      (∀ w : W, IsCompact {σ : PrivateStrategy | Φ σ = w}) := by
  sorry

Confidence this is the right statement shape: 3
Notes on what would be needed to prove it later: Concrete topology on private kernels, compactness/tightness of kernel space, continuity of expected payoff map, convexity under private randomization, and quotient/subtype bookkeeping for W.

krn-borel-right-inverse

Reason this needs a stub: Mathlib has choice-theoretic right inverses, but not Kuratowski-Ryll-Nardzewski Borel right inverses for compact fibers.

Proposed Lean statement (sketch):

lean
theorem krn_borel_right_inverse
    {X Y : Type*}
    [TopologicalSpace X] [MeasurableSpace X]
    [TopologicalSpace Y] [MeasurableSpace Y]
    [CompactSpace X]
    (Φ : X → Y)
    (hΦ_cont : Continuous Φ)
    (hΦ_surj : Function.Surjective Φ)
    (hfib_compact : ∀ y, IsCompact {x : X | Φ x = y}) :
    ∃ R : Y → X, Measurable R ∧ ∀ y, Φ (R y) = y := by
  sorry

Confidence this is the right statement shape: 4
Notes on what would be needed to prove it later: Standard-Borel hypotheses may need to be explicit. The real theorem is a measurable selection theorem applied to the inverse-image correspondence.

kernel-infimum-epsilon-selection

Reason this needs a stub: Combines measurable ε-minimizing selection with deterministic kernels and an integral infimum identity. Mathlib has the integration and deterministic-kernel pieces but not the packaged optimization theorem.

Proposed Lean statement (sketch):

lean
theorem kernel_infimum_epsilon_selection
    {S M : Type*}
    [MeasurableSpace S] [MeasurableSpace M]
    [TopologicalSpace M] [CompactSpace M] [Nonempty M]
    (τ : MeasureTheory.Measure S)
    (g : S → M → ℝ)
    (hg_meas : Measurable fun p : S × M => g p.1 p.2)
    (hg_cont : ∀ s, Continuous fun m => g s m)
    (hg_bdd : ∃ C, ∀ s m, |g s m| ≤ C) :
    (⨅ β : ProbabilityTheory.Kernel S M,
        ∫ s, ∫ m, g s m ∂β s ∂τ)
      =
    ∫ s, sInf ((fun m => g s m) '' Set.univ) ∂τ := by
  sorry

Confidence this is the right statement shape: 3
Notes on what would be needed to prove it later: Need precise order-complete target for ⨅, integrability, and a measurable ε-minimizer. In the project, using an ε-version may be easier than exact equality.

hausdorff-support-function-lipschitz

Reason this needs a stub: Mathlib has Hausdorff distance and distance-to-set Lipschitz lemmas, but I do not know of a ready-made theorem for support extrema of continuous linear functionals over compact sets.

Proposed Lean statement (sketch):

lean
theorem hausdorff_support_function_lipschitz
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MetricSpace E]
    (ℓ : E →L[ℝ] ℝ) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ C D : TopologicalSpace.NonemptyCompacts E,
        |(sSup (ℓ '' (↑C : Set E))) - (sSup (ℓ '' (↑D : Set E)))|
          ≤ L * dist C D := by
  sorry

Confidence this is the right statement shape: 3
Notes on what would be needed to prove it later: In finite dimension, take L = ‖ℓ‖; use Hausdorff closeness to transport almost-maximizers between compact sets. A matching minimum theorem follows by applying the maximum theorem to -ℓ.

jankov-von-neumann-universal-selection

Reason this needs a stub: This is descriptive set theory. Mathlib does not appear to expose analytic sets or Jankov-von-Neumann selection in the needed form.

Proposed Lean statement (sketch):

lean
theorem jankov_von_neumann_universal_selection
    {X Y : Type*}
    [MeasurableSpace X] [MeasurableSpace Y]
    [TopologicalSpace X] [TopologicalSpace Y]
    -- StandardBorel/analytic hypotheses should be refined.
    {G : Set (X × Y)}
    (hG_analytic : True)
    (hsections : ∀ x, ∃ y, (x, y) ∈ G) :
    ∃ f : X → Y,
      -- Universally measurable placeholder.
      True ∧ ∀ x, (x, f x) ∈ G := by
  sorry

Confidence this is the right statement shape: 2
Notes on what would be needed to prove it later: Would require a Mathlib development of analytic sets and universal measurability, or a project-specific replacement avoiding JvN.

geps-borel-selector-upgrade

Reason this needs a stub: This is the exact patch beyond JvN: the particular ε-contact graph must have enough regularity for a total Borel selector.

Proposed Lean statement (sketch):

lean
theorem geps_borel_selector_upgrade
    {M : Type*}
    [TopologicalSpace M] [MeasurableSpace M]
    {Gε : ℝ → M → Set M}
    {ε : ℝ}
    (hε : 0 < ε)
    (hne : ∀ s : M, (Gε ε s).Nonempty)
    (hgraph : MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1})
    -- strengthened regularity hypotheses for this correspondence
    (hregular : True) :
    ∃ mε : M → M,
      Measurable mε ∧ ∀ s : M, mε s ∈ Gε ε s := by
  sorry

Confidence this is the right statement shape: 4
Notes on what would be needed to prove it later: Replace hregular : True with the actual closed-valued/σ-compact/standard-Borel regularity used by the ε-contact correspondence.

bayes-posterior-as-conditional-barycenter

Reason this needs a stub: This is project glue: it identifies a Bayesian posterior over finite states with the coordinatewise barycenter of a conditional law over source posteriors. Mathlib supplies disintegration and integration, not the posterior-process semantics.

Proposed Lean statement (sketch):

lean
theorem bayes_posterior_as_conditional_barycenter
    {Ω M : Type*}
    [Fintype Ω] [MeasurableSpace M]
    (q : MeasureTheory.Measure M)
    (ρ : M → MeasureTheory.Measure (Ω → ℝ))
    (P : M → Ω → ℝ) :
    -- `ρ m` is the conditional source-posterior law after message `m`.
    -- `P m` is the Bayesian posterior over states after message `m`.
    (∀ᵐ m ∂q, ∀ ω : Ω,
      P m ω = ∫ s, s ω ∂ρ m) := by
  sorry

Confidence this is the right statement shape: 3
Notes on what would be needed to prove it later: Need the exact model’s joint law, posterior-law consistency, disintegration identity, and finite-coordinate integration lemmas.

support-function-measurable-integrated-separation

Reason this needs a stub: The pointwise separation theorem is in Mathlib, but the measurable-correspondence/integrated Hall equivalence is specialist and not a standard packaged theorem.

Proposed Lean statement (sketch):

lean
theorem support_function_measurable_integrated_separation
    {M E : Type*}
    [MeasurableSpace M]
    [TopologicalSpace E] [AddCommGroup E] [Module ℝ E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E]
    [LocallyConvexSpace ℝ E]
    (q : MeasureTheory.Measure M)
    (B : M → Set E)
    (P : M → E)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hmeas : True) :
    ((∀ᵐ m ∂q, P m ∈ B m) ↔
      True) := by
  sorry

Confidence this is the right statement shape: 2
Notes on what would be needed to prove it later: Replace the right side with the project’s exact support-function Hall inequalities over measurable events and continuous affine tests. Requires measurable selection/separation for the violation set.
