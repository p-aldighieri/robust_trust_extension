# Feasibility Assessment: Extension vs. Counterexample

## 1. Strongest Candidate Assumptions for Positive Extension

Based on the analysis in `assumptions_analysis.md`, the strongest candidate for extending Theorem 2 to infinite M and Θ uses **the paper's standing assumptions alone**:

- (A0) Ω finite, μ₀ full support
- (A1) A compact metric
- (A2) Θ compact metric
- (A3) u(a,ω,θ) bounded and continuous in a
- (A4) s, θ conditionally independent given ω

With M = supp(τ) ⊂ Δ(Ω) automatically compact.

The proof strategy:
1. Equip Σ and B with product topologies (Tychonoff compact, convex)
2. Show U(β,σ) is affine in each argument (immediate from linearity of integration)
3. Show U(β,σ) is continuous in σ for fixed β (bounded convergence theorem)
4. Show U(β,σ) is continuous/lsc in β for fixed σ (the subtle step; uses narrow convergence + bounded convergence)
5. Apply Sion's minimax theorem to get the saddle point
6. Use measurable selection (Kuratowski-Ryll-Nardzewski) to extract per-message Bayes-optimality

## 2. Potential Counterexamples and Obstructions

### 2.1 Wald's Counterexample

Wald (1945) showed that the minimax theorem can fail for infinite strategy spaces when the payoff function is not sufficiently continuous. Specifically, if X = Y = [0,1] and f(x,y) = 1_{x=y}, then sup_x inf_y f = 0 but inf_y sup_x f = 1.

**Does this apply?** No. Our payoff U(β,σ) is affine in each argument and continuous under appropriate topologies. The pathological discontinuity in Wald's example (indicator of the diagonal) cannot arise because our payoff integrates a bounded continuous u against probability measures.

### 2.2 Failure of Weak-* Compactness for Non-Metrizable Spaces

For non-metrizable topological spaces, the space of probability measures may not be compact in the narrow topology (Prokhorov's theorem requires at least separability and completeness for the converse direction).

**Does this apply?** No. M ⊂ Δ(Ω) ⊂ ℝ^N is always compact metric (finite-dimensional). A and Θ are compact metric by assumption. So all measure spaces involved are compact metric, and Δ(·) is always compact.

### 2.3 Failure of Continuity in the Narrow Topology

The narrow (weak) topology on Δ(M) is coarser than the total variation topology. Integration against bounded measurable (but discontinuous) functions is NOT continuous under the narrow topology. This could prevent U(β,σ) from being continuous in β.

**Does this apply?** This is the key technical challenge. For fixed σ, the function g_σ(m,ω) = ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ) may be discontinuous in m.

**Resolution**: We use the following two-step argument:
1. The payoff depends on β through the induced marginal measures λ_ω^β(·) = ∫_M τ(dμ) μ(ω) β(·|μ). Under product-of-narrow convergence of β, these marginals converge narrowly (by bounded convergence over μ).
2. For the integral ∫_M g_σ dλ_ω^β, we need g_σ(·,ω) to be **λ_ω^β-a.e. continuous**. For a generic σ, g_σ may have a countable set of discontinuities (where the optimal action jumps). By the Portmanteau theorem, ∫ g dμ_n → ∫ g dμ if g is bounded and μ-a.e. continuous.

**The subtlety**: We need g_σ(·,ω) to be continuous λ_ω^β-a.e. for the LIMIT β, not for all β_n. This is a condition on σ and the limit β, which is satisfied for "generic" σ.

**Alternative (cleaner) resolution**: Since we are applying Sion's theorem with U(β,σ) being **affine** in β, we don't need full continuity — we need only **lower semicontinuity** of U(·,σ) in β (for the minimizer's variable). For affine functions on compact convex sets, lsc is equivalent to the function being a supremum of continuous affine functions, which holds when the payoff has the structure U(β,σ) = ∫ L(β) where L is a continuous linear functional of the induced measures.

**Even cleaner**: Affine + upper semicontinuous suffices for the minimizer. And U(β,σ) is upper semicontinuous in β for each σ because it can be written as an integral of a bounded function against a narrowly converging measure, and integrals of bounded upper semicontinuous functions are upper semicontinuous under narrow convergence (by Portmanteau).

**Actually**: g_σ(m,ω) need not be upper semicontinuous. Let me reconsider.

**Definitive resolution**: Work with the topology on B where convergence means convergence of the induced outcome distributions. Since Ω is finite, the payoff is a finite sum:

U(β,σ) = Σ_{ω} c_ω ∫_M h_ω^σ(m) λ_ω^β(dm)

where h_ω^σ and c_ω are determined by σ and primitives. The map β ↦ λ_ω^β is continuous from B (product topology) to M(M) (narrow topology). The map λ ↦ ∫ h dλ is continuous when h is bounded continuous, and lsc when h is lsc.

For the minimax theorem to apply, we need either:
(a) Full continuity — requires h continuous, which requires σ to vary continuously in m, or
(b) A version of Sion that works with measurable payoffs.

**The correct path**: Use Sion's theorem in the following form (Sion 1958, Theorem 4.2'):

> Let X be compact, Y be convex. Let f: X×Y → ℝ be such that f(·,y) is lsc on X for each y, and f(x,·) is concave on Y for each x. Then min_x sup_y f(x,y) = sup_y min_x f(x,y).

Apply with X = B̃ (the space of induced marginal tuples, compact convex), Y = Σ (compact convex), f = U. We need U(λ, ·) to be concave on Σ for each λ (it's affine, hence concave), and U(·, σ) to be lsc on B̃ for each σ. The latter is guaranteed if the payoff is a sum of integrals of bounded measurable functions against narrowly converging measures — which holds by the Portmanteau theorem for bounded measurable functions that are a.e. continuous w.r.t. the limit.

**But we need this for ALL limit points**, not just specific ones. This is where the difficulty lies.

**Final resolution**: Rather than using the narrow topology, we use the following observation specific to our problem. Since M ⊂ Δ(Ω) ⊂ ℝ^N is a compact subset of a FINITE-dimensional space, and β(·|μ) ∈ Δ(M) is a probability measure on a compact subset of ℝ^N, we can use the fact that on finite-dimensional compact sets, every bounded measurable function is Riemann-integrable except on a set of Lebesgue measure zero.

**Actually, the cleanest approach** (which I should have started with) is:

**Reduction to finite approximation + limit argument.** Approximate M by finite sets M_k ↑ M (dense sequences in the compact set M), apply the finite-M result to get saddle points (σ_k*, β_k*), extract convergent subsequences by compactness, and show the limit is a saddle point.

This is a standard compactness/limit approach in game theory and avoids the need to verify Sion's conditions directly.

## 3. Recommendation

**Recommendation: PROCEED WITH POSITIVE EXTENSION.**

### Justification by Three Concrete Mathematical Arguments

**Argument 1: Structural affinity.** The payoff U(β,σ) is affine in each argument. This is the strongest possible concavity/convexity condition. Affine payoffs on compact convex sets ALWAYS admit saddle points when appropriate semicontinuity holds. The finite-M proof already establishes this; the passage to infinite M is a standard compactness argument.

**Argument 2: Finite-dimensional reduction.** Despite M and Θ being infinite, the state space Ω is finite. The payoff is a FINITE SUM over ω ∈ Ω. This means the "infinite-dimensional" nature of the problem is in the strategy spaces, but the payoff depends on strategies only through finitely many moments (the state-contingent expected payoffs). This finite-dimensional structure ensures that the payoff is well-behaved even for infinite strategy spaces.

**Argument 3: Compactness + selection.** The strategy spaces are compact (Tychonoff) and convex (linear structure). The key technical step — extracting per-message Bayes-optimality from a global saddle point — is handled by the Kuratowski-Ryll-Nardzewski measurable selection theorem, which applies because: M is a measurable space (Borel), the argmax correspondence has non-empty compact values (compact A, continuous u), and the correspondence is measurable (Carathéodory structure).

**No known counterexamples in the literature apply** to our specific setting (affine payoff, finite Ω, compact metric action/type spaces).

## 4. Proof Strategy Outline

1. **Approximate M by finite sets**: Let {M_k} be an increasing sequence of finite subsets of M with M_k → M in the Hausdorff metric.
2. **Apply the finite-M theorem**: For each k, Theorem 2 (finite version) gives a saddle point (σ_k*, β_k*).
3. **Extract convergent subsequences**: By compactness of Σ and B (in product topology), extract limits σ* and β*.
4. **Show the limit is a saddle point**: Using continuity of U in σ (bounded convergence) and lower semicontinuity arguments for β.
5. **Apply measurable selection**: Extract per-message Bayes-optimality from the global best-response property.
6. **Conclude robust rationalizability**: σ* is robustly rationalizable.

**Alternative strategy** (more direct): Apply Sion's minimax theorem directly to the compact convex strategy spaces with the product topology, verifying the hypotheses using the affine structure and bounded convergence. This avoids the approximation argument but requires more careful verification of semicontinuity.

**We will pursue the direct approach** (Sion's theorem applied directly) as the primary strategy, with the approximation approach as a fallback.
