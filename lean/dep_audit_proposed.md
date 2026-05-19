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
