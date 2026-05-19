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