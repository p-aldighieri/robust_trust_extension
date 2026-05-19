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

**v2 PATCH 2026-05-19** — Candidate ordering re-synchronised with the verified dep_audit.md. The PRIMARY name is now `MeasureTheory.Measure.integral_compProd` (kernel-side Bochner Fubini for `Measure.compProd`), matching what the use sites actually consume (joint source-message law as `τ.compProd β`). Ordinary product Fubini (`MeasureTheory.integral_prod`) is retained as a fallback.

Candidate 1 (PRIMARY, kernel-side Bochner)

name: MeasureTheory.Measure.integral_compProd

import: Mathlib.Probability.Kernel.Composition.MeasureCompProd

signature: theorem MeasureTheory.Measure.integral_compProd {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β] [NormedAddCommGroup E] [NormedSpace ℝ E] {μ : Measure α} {κ : ProbabilityTheory.Kernel α β} [SFinite μ] [ProbabilityTheory.IsSFiniteKernel κ] {f : α × β → E} (hf : Integrable f (μ.compProd κ)) : ∫ z, f z ∂(μ.compProd κ) = ∫ a, ∫ b, f (a, b) ∂κ a ∂μ

confidence: 5

match notes: This is the Bochner Fubini for the joint law τ ⊗ κ used everywhere in profile-payoff-decomposition-misaligned, mixture-payoff-decomposition, adversary-infimum-pointwise. AXLE-confirmed at lean-4.29.0.

Candidate 1-bis (fallback / ordinary product Fubini)

name: MeasureTheory.integral_prod

import: Mathlib.MeasureTheory.Integral.Prod

signature: theorem MeasureTheory.integral_prod {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β] {μ : Measure α} {ν : Measure β} [NormedAddCommGroup E] [NormedSpace ℝ E] [SFinite μ] [SFinite ν] (f : α × β → E) (hf : Integrable f (μ.prod ν)) : ∫ z, f z ∂(μ.prod ν) = ∫ x, ∫ y, f (x, y) ∂ν ∂μ

confidence: 5

match notes: Standard Bochner Fubini for product measures. Use as fallback when the joint law has already been expanded via Kernel.compProd_apply or is genuinely a product measure.

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

Proposed Lean statement (sketch) — PATCHED 2026-05-19 v2 (added explicit convex-realization hypothesis; reviewer noted that Set.range Φ isn't convex from compactness + continuity alone):

lean
theorem profile_geometry_import
    {Ω PrivateStrategy : Type*}
    [Fintype Ω]
    [TopologicalSpace PrivateStrategy] [CompactSpace PrivateStrategy] [Nonempty PrivateStrategy]
    [MeasurableSpace PrivateStrategy] [BorelSpace PrivateStrategy]
    (Φ : PrivateStrategy → (Ω → ℝ))
    (hΦ_cont : Continuous Φ)
    -- The convexity of the profile range W comes from PRIVATE RANDOMIZATION:
    -- if w1 = Φ σ1 and w2 = Φ σ2, then for every t ∈ [0,1] there is a randomized
    -- private strategy σt whose profile is the convex combination t • w1 + (1-t) • w2.
    -- In the model, this corresponds to the agent randomizing privately between σ1 and σ2.
    (hconvex_realization :
      ∀ σ1 σ2 : PrivateStrategy, ∀ t : ℝ, 0 ≤ t → t ≤ 1 →
        ∃ σt : PrivateStrategy,
          Φ σt = (fun ω => t * Φ σ1 ω + (1 - t) * Φ σ2 ω)) :
    let W : Set (Ω → ℝ) := Set.range Φ
    IsCompact W ∧
    Convex ℝ W ∧
    (∀ w ∈ W, (Φ ⁻¹' {w}).Nonempty ∧ IsCompact (Φ ⁻¹' {w})) := by
  sorry

Confidence this is the right statement shape: 4
Notes on what would be needed to prove it later: With `hconvex_realization` made an explicit hypothesis, convexity of W follows by direct construction. Compactness uses continuity + CompactSpace PrivateStrategy. Nonempty fibers are immediate from `w ∈ Set.range Φ`. The compactness of fibers needs that they are closed in a compact space (closed because Φ is continuous and singletons are closed in a Hausdorff target — Ω → ℝ is Hausdorff as a finite product of ℝ).

krn-borel-right-inverse

Reason this needs a stub: Mathlib has choice-theoretic right inverses, but not Kuratowski-Ryll-Nardzewski Borel right inverses for compact fibers.

Proposed Lean statement (sketch) — PATCHED 2026-05-19 (standard-Borel hypotheses + explicit nonempty fibers):

lean
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

Confidence this is the right statement shape: 4
Notes on what would be needed to prove it later: Now states the StandardBorelSpace hypotheses (the canonical setting for measurable selection), explicit nonempty compact fibers, and the conclusion of a Borel right inverse. The proof would apply a Kuratowski-Ryll-Nardzewski-type theorem to the inverse-image correspondence. If Mathlib eventually gets a measurable selection theorem for upper semi-continuous correspondences with compact values, the stub can be retired.

kernel-infimum-epsilon-selection

Reason this needs a stub: Combines measurable ε-minimizing selection with deterministic kernels and an integral infimum identity. Mathlib has the integration and deterministic-kernel pieces but not the packaged optimization theorem.

Proposed Lean statement (sketch) — PATCHED 2026-05-19 v2 (dropped `Continuous fun m => g s m` — use sites only have Borel measurability; added StandardBorel + section-nonempty hypotheses for measurable selector existence):

lean
theorem kernel_infimum_epsilon_selection
    {S M : Type*}
    [MeasurableSpace S] [MeasurableSpace M]
    [TopologicalSpace M] [StandardBorelSpace M] [Nonempty M]
    (τ : MeasureTheory.Measure S)
    [MeasureTheory.IsFiniteMeasure τ]
    (g : S → M → ℝ)
    (hg_meas : Measurable fun p : S × M => g p.1 p.2)
    -- Boundedness: enough for integrability against finite τ; no continuity needed.
    (hg_bdd : ∃ C, ∀ s m, |g s m| ≤ C)
    -- Section infimum is measurable as a function of s. The standard-Borel + bounded
    -- + jointly-measurable hypotheses suffice (via measurable selection of an
    -- ε-net under hg_bdd) — this hypothesis is the contract delivered to the use site.
    (hinf_meas : Measurable fun s => sInf (Set.range (g s))) :
    -- ε-selection inequality + matching lower bound.
    (∀ ε > 0, ∃ β : ProbabilityTheory.Kernel S M,
        ProbabilityTheory.IsMarkovKernel β ∧
        ∫ s, ∫ m, g s m ∂(β s) ∂τ
          ≤ (∫ s, sInf (Set.range (g s)) ∂τ) + ε) ∧
    (∀ β : ProbabilityTheory.Kernel S M, ProbabilityTheory.IsMarkovKernel β →
        (∫ s, sInf (Set.range (g s)) ∂τ)
          ≤ ∫ s, ∫ m, g s m ∂(β s) ∂τ) := by
  sorry

Confidence this is the right statement shape: 4
Notes on what would be needed to prove it later: The patch matches the actual use site adversary-infimum-pointwise where the integrand is `g s m = s · w(m)` with w : M → W Borel (measurable, NOT continuous in m). The proof of the ε-selection direction constructs a measurable ε-minimizer m_ε via measurable selection of `{m : g s m ≤ sInf (g s) + ε}` — non-empty by hg_bdd, measurable graph from hg_meas, in a standard-Borel target — then promotes m_ε to a deterministic Markov kernel β_ε. The lower bound is pointwise inf swap and monotonicity of ∫. `hinf_meas` is included as a hypothesis because the function `s ↦ sInf (Set.range (g s))` requires a measurable-selection argument to establish; carrying it as a hypothesis isolates that part from this theorem's responsibility.

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

Reason this needs a stub: This is descriptive set theory. Mathlib exposes `MeasureTheory.AnalyticSet` and related analytic-set infrastructure (per pass-1 reviewer correction), but does NOT supply the Jankov-von-Neumann universally measurable selection theorem in the form needed here.

Proposed Lean statement (sketch) — PATCHED 2026-05-19 (replaces `True` placeholders with real analytic-set + universal-measurability predicates):

lean
-- Universal measurability of a function w.r.t. a target σ-algebra: f is measurable when X is
-- equipped with the completion of its Borel σ-algebra by every (σ-finite) Borel measure.
-- Project-local definition until Mathlib formalises descriptive-set-theoretic universal measurability.
def UniversallyMeasurable {X Y : Type*} [TopologicalSpace X] [MeasurableSpace X]
    [MeasurableSpace Y] (f : X → Y) : Prop :=
  ∀ μ : MeasureTheory.Measure X, MeasureTheory.IsFiniteMeasure μ →
    MeasureTheory.AEMeasurable f μ

theorem jankov_von_neumann_universal_selection
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace X] [BorelSpace X] [StandardBorelSpace X]
    [MeasurableSpace Y] [TopologicalSpace Y] [BorelSpace Y] [StandardBorelSpace Y] [Nonempty Y]
    -- v2: BorelSpace instances added per reviewer (Mathlib AnalyticSet API needs them).
    (G : Set (X × Y))
    (hG_analytic : MeasureTheory.AnalyticSet G)
    (hsections : ∀ x, ∃ y, (x, y) ∈ G) :
    ∃ f : X → Y,
      UniversallyMeasurable f ∧ ∀ x, (x, f x) ∈ G := by
  sorry

Confidence this is the right statement shape: 3
Notes on what would be needed to prove it later: The classical JvN theorem says: every analytic set in a product of standard-Borel spaces with nonempty x-sections admits a universally measurable y-uniformisation. Project may bypass JvN by using `geps_borel_selector_upgrade` (which delivers a Borel selector under stronger regularity) — that path is preferred. This stub is retained for the case where the project later needs the general JvN theorem, e.g., in `Geps-selector-exists` if the regularity upgrade isn't available.

geps-borel-selector-upgrade

Reason this needs a stub: This is the exact patch beyond JvN: the particular ε-contact graph must have enough regularity for a total Borel selector.

Proposed Lean statement (sketch) — PATCHED 2026-05-19 (replaces `hregular : True` with a structured GepsRegularity predicate):

lean
-- The regularity profile that the ε-contact correspondence Gε enjoys in v8.
-- Bundles closed-valued, measurable-graph, and section-measurability hypotheses.
structure GepsRegularity {M : Type*} [TopologicalSpace M] [MeasurableSpace M]
    (Gε : ℝ → M → Set M) (ε : ℝ) : Prop where
  closed_valued : ∀ s : M, IsClosed (Gε ε s)
  graph_measurable : MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}
  sections_measurable : ∀ s : M, MeasurableSet (Gε ε s)

theorem geps_borel_selector_upgrade
    {M : Type*}
    [TopologicalSpace M] [MeasurableSpace M] [BorelSpace M] [StandardBorelSpace M]
    [TopologicalSpace.SecondCountableTopology M]
    [CompactSpace M]  -- v2 patch: section selection needs σ-compactness; CompactSpace suffices
    {Gε : ℝ → M → Set M}
    {ε : ℝ}
    (hε : 0 < ε)
    (hne : ∀ s : M, (Gε ε s).Nonempty)
    (hregular : GepsRegularity Gε ε) :
    ∃ mε : M → M,
      Measurable mε ∧ ∀ s : M, mε s ∈ Gε ε s := by
  sorry

Confidence this is the right statement shape: 4
Notes on what would be needed to prove it later: With closed-valued sections in a compact standard-Borel second-countable space and measurable graph, the Kuratowski-Ryll-Nardzewski selection theorem yields a Borel selector. CompactSpace M makes each section compact (closed + compact ambient), giving the σ-compactness needed for KRN. The structure GepsRegularity makes the hypothesis bundle reusable across Gε-uses in the proof (Geps-selector-exists, epsilon-adversary-realization, etc.). v2 added `CompactSpace M` per reviewer; the actual use site has M = supp τ in a compact metric ambient, so this hypothesis is faithful to the source.

bayes-posterior-as-conditional-barycenter

Reason this needs a stub: This is project glue: it identifies a Bayesian posterior over finite states with the coordinatewise barycenter of a conditional law over source posteriors. Mathlib supplies disintegration and integration, not the posterior-process semantics.

Proposed Lean statement (sketch) — PATCHED 2026-05-19 v2 (removed the "painted door": `hP_post` no longer assumes the conclusion. P is now defined via Bayes' rule from the joint law, and the conclusion follows from disintegration + posterior-law-consistency.):

lean
theorem bayes_posterior_as_conditional_barycenter
    {Ω : Type*} [Fintype Ω]
    {Belief : Type*} [MeasurableSpace Belief]
    {M : Type*} [MeasurableSpace M]
    -- Belief is the source-posterior space; coord s ω = s(ω).
    (coord : Belief → Ω → ℝ)
    (hcoord_meas : ∀ ω, Measurable (fun s => coord s ω))
    (hcoord_nonneg : ∀ s ω, 0 ≤ coord s ω)
    -- Prior over states.
    (μ0 : Ω → ℝ) (hμ0_nonneg : ∀ ω, 0 ≤ μ0 ω) (hμ0_sum : ∑ ω, μ0 ω = 1)
    -- State-conditional source law π(·|ω) and unconditional source law τ.
    (π : Ω → MeasureTheory.Measure Belief)
    (τ : MeasureTheory.Measure Belief)
    [MeasureTheory.IsFiniteMeasure τ]
    -- Standing posterior-law consistency: μ0(ω) • π ω equals τ weighted by the
    -- coordinate function s ↦ s(ω). This is the v8 posterior-law-consistency-field.
    (hposterior_consistency :
      ∀ ω, (μ0 ω) • (π ω) =
        τ.withDensity (fun s => ENNReal.ofReal (coord s ω)))
    -- Message-marginal law q and a Markov kernel χ : Belief → M describing how
    -- the message m is drawn given the source posterior s (e.g., the misaligned
    -- adversary kernel β, or the menu-Hall kernel κ).
    (q : MeasureTheory.Measure M)
    (χ : ProbabilityTheory.Kernel Belief M)
    [ProbabilityTheory.IsMarkovKernel χ]
    -- The joint law on Belief × M is τ ⊗ χ; q is its M-marginal.
    (hq_marginal : q = (τ.compProd χ).map Prod.snd)
    -- ρ is the disintegration of (τ ⊗ χ) along the M-coordinate.
    (ρ : ProbabilityTheory.Kernel M Belief)
    [ProbabilityTheory.IsMarkovKernel ρ]
    (hρ_disintegration :
      τ.compProd χ
        = q.compProd (ρ.map (fun s => (s, default : Belief × Unit))  -- placeholder shape; see notes
        ).map (fun p : M × (Belief × Unit) => (p.2.1, p.1)))
    -- P m ω is defined as the Bayes' posterior at state ω given message m, derived
    -- from the joint law via P m ω := (μ0 ω) * (dπ_ω / dq)(m) / (normalisation).
    -- The dep-auditor's stub bundles the Bayes' definition into a hypothesis predicate.
    (P : M → Ω → ℝ)
    (hP_meas : ∀ ω, Measurable (fun m => P m ω))
    (hP_bayes_definition :
      -- P is the joint-law conditional probability of state ω given message m:
      -- ∀ ω, ∀ᵐ m ∂q, P m ω = Pr(state = ω | message = m)
      ∀ ω : Ω, ∀ᵐ m ∂q,
        P m ω = (μ0 ω) *
                ((((π ω).map (fun s : Belief => s)).compProd χ).map Prod.snd).rnDeriv q m
                |>.toReal)
    :
    -- Conclusion: q-a.e. message m, the joint-law posterior over states P m equals
    -- the coordinate-barycenter ∫ s ω ∂(ρ m) of the disintegration source-posterior law.
    -- Derives from posterior-law-consistency + disintegration; NOT assumed.
    ∀ᵐ m ∂q, ∀ ω : Ω, P m ω = ∫ s, coord s ω ∂(ρ m) := by
  sorry

Confidence this is the right statement shape: 3
Notes on what would be needed to prove it later: The painted-door concern in v1 was that `hP_post` assumed the conclusion verbatim. v2 fixes this by defining P (via `hP_bayes_definition`) as the joint-law conditional probability of state given message — a Radon-Nikodym derivative shape that does NOT contain the barycenter identity. The conclusion ∀ᵐ m, P m ω = ∫ s ω ∂(ρ m) then follows by combining (i) posterior-law-consistency to express joint measures in terms of τ + coord, (ii) the disintegration ρ identifying conditional source-posterior laws given m, and (iii) Fubini against τ.compProd χ to commute the integrations. The disintegration relation `hρ_disintegration` is admittedly clunky in Lean — the right encoding will use `MeasureTheory.Measure.condKernel` once the formalizer pins down the precise signature; this stub records the project's logical requirement. If the formalizer simplifies the joint-law modeling, the hypothesis bundle can be tightened.

support-function-measurable-integrated-separation

Reason this needs a stub: The pointwise separation theorem is in Mathlib (`iInter_halfSpaces_eq`, `geometric_hahn_banach_point_closed`), but the measurable-correspondence/integrated Hall equivalence is specialist and not a standard packaged theorem.

Proposed Lean statement (sketch) — PATCHED 2026-05-19 v2 (specialized to the actual use site E = Ω → ℝ with Ω finite; finite-dim ambient sidesteps the `∀ ℓ, ∀ᵐ m` vs `∀ᵐ m, ∀ ℓ` quantifier-swap pathology since the dual `(Ω → ℝ) →L[ℝ] ℝ` is also finite-dim with a countable dense subset):

lean
theorem support_function_measurable_integrated_separation
    {Ω : Type*} [Fintype Ω]
    {M : Type*} [MeasurableSpace M]
    (q : MeasureTheory.Measure M)
    [MeasureTheory.IsFiniteMeasure q]
    -- The ambient space is the finite-dimensional payoff/profile space (Ω → ℝ),
    -- matching the v8 use site (B m ⊆ W ⊆ Ω → ℝ).
    (B : M → Set (Ω → ℝ))
    (P : M → (Ω → ℝ))
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : M × (Ω → ℝ) | p.2 ∈ B p.1}) :
    -- Strong (pointwise a.e.) equivalence — in finite-dim, ∀ ℓ inside ∀ᵐ m
    -- can be promoted via a countable dense subset of the dual `(Ω → ℝ) →L[ℝ] ℝ`.
    (∀ᵐ m ∂q, P m ∈ B m) ↔
      (∀ᵐ m ∂q, ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, ℓ (P m) ≤ sSup (ℓ '' B m)) := by
  sorry

Confidence this is the right statement shape: 3
Notes on what would be needed to prove it later: Forward direction is direct from pointwise support-function separation applied a.e. Reverse direction needs the pointwise version of Hahn-Banach (`iInter_halfSpaces_eq` or `geometric_hahn_banach_point_closed`) applied at q-a.e. m. The finite-dim restriction is faithful to the use site (the v8 separation lemmas operate on payoff profiles in Ω → ℝ with Ω finite). v2 quantifier-swap: with Ω finite, (Ω → ℝ) is `EuclideanSpace ℝ Ω`-isomorphic, and `(Ω → ℝ) →L[ℝ] ℝ` is also finite-dim — so `∀ ℓ ∀ᵐ m` and `∀ᵐ m ∀ ℓ` are equivalent (a single null set covers all functionals via density / continuity arguments). If a later general-position result requires the infinite-dim version, restate as `∀ᵐ m, ∀ ℓ` with a countable separating dual family hypothesis.
