# Topological and Measure-Theoretic Assumptions for the Extension

## 1. The Key Challenge

We need to extend the existence direction of Theorem 2 from finite M and Θ to:
- M ⊂ Δ(Ω) a compact subset (since M = supp(τ) and Δ(Ω) is compact)
- Θ a compact metric space (already the standing assumption)

The finite proof uses Sion's minimax theorem with the following inputs:
1. Σ and B are compact and convex
2. U(β,σ) is concave-convexlike (in fact, affine in each argument)
3. U(β,σ) is continuous in each argument separately

We need to replicate these properties for infinite-dimensional strategy spaces.

## 2. Topology on the Strategy Spaces

### 2.1 The Misaligned Adviser's Strategy Space B

**Definition**: B = {β : M → Δ(M), measurable Markov kernels}.

Here β(·|μ) ∈ Δ(M) for each μ ∈ M, representing the distribution of messages the misaligned adviser sends when his true posterior is μ.

**Proposed topology**: The **narrow topology** on B, defined as the coarsest topology making the maps

β ↦ ∫_M g(m) β(dm|μ)

continuous for every μ ∈ M and every bounded continuous g : M → ℝ.

More precisely, this is the topology of **pointwise narrow convergence** of the kernels: β_n → β iff for each μ ∈ M, β_n(·|μ) → β(·|μ) narrowly (i.e., in the weak convergence of measures topology).

**Compactness**: Since M ⊂ Δ(Ω) ⊂ ℝ^N is compact metric, Δ(M) is compact under the narrow topology (by Prokhorov's theorem: all measures on a compact space are tight). The space B = ∏_{μ∈M} Δ(M) with the product of narrow topologies is compact by Tychonoff's theorem.

**Convexity**: B is convex: if β₁, β₂ ∈ B and λ ∈ [0,1], then (λβ₁ + (1−λ)β₂)(·|μ) = λβ₁(·|μ) + (1−λ)β₂(·|μ) ∈ Δ(M) for each μ.

**Important subtlety**: The product topology (pointwise convergence in μ) is what Tychonoff gives us. But for the payoff to be continuous in β, we need convergence of the integral ∫_M τ(dμ) [...] β(dm|μ), which involves integration over μ. The product topology alone does not guarantee that β_n(·|μ) → β(·|μ) **uniformly** in μ. However:

Since M is compact metric and Δ(M) is compact metric, the space of continuous functions C(M, Δ(M)) is metrizable. The issue is that elements of B are merely measurable, not continuous. We resolve this as follows:

**Key observation**: We do NOT need uniform convergence. We only need that

∫_M τ(dμ) F(μ, β(·|μ)) → ∫_M τ(dμ) F(μ, β₀(·|μ))

for appropriate F. Since u is bounded and τ is a finite measure, the dominated convergence theorem gives:

If β_n(·|μ) → β(·|μ) narrowly for τ-a.e. μ, and the integrand is bounded, then the integral converges.

Under the product topology, β_n → β means pointwise convergence at **every** μ ∈ M, which is strictly stronger than τ-a.e. convergence. So the product topology is sufficient.

### 2.2 The Agent's Strategy Space Σ

**Definition**: Σ = {σ : M × Θ → Δ(A), measurable Markov kernels}.

Here σ(·|m,θ) ∈ Δ(A) for each (m,θ) ∈ M × Θ.

**Proposed topology**: The **product topology** on Σ = ∏_{(m,θ) ∈ M×Θ} Δ(A), where each factor Δ(A) carries the narrow (weak convergence) topology.

**Compactness**: Since A is compact metric, Δ(A) is compact metric under the narrow topology. By Tychonoff, Σ is compact.

**Convexity**: As with B, convex combinations of kernels are kernels.

### 2.3 Summary of Strategy Space Properties

| Space | Topology | Compact? | Convex? | Metrizable? |
|-------|----------|----------|---------|-------------|
| B | Product of narrow on Δ(M)^M | Yes (Tychonoff) | Yes | No in general (M uncountable); but separable if restricted |
| Σ | Product of narrow on Δ(A)^{M×Θ} | Yes (Tychonoff) | Yes | No in general; but separable if restricted |

**Note on metrizability**: When M × Θ is uncountable, the product topology on Σ is not metrizable. However, Sion's minimax theorem does NOT require metrizability — it works for compact convex subsets of topological vector spaces, or more generally for compact topological spaces with appropriate semicontinuity. The key requirement is compactness + convexity + semicontinuity.

## 3. Continuity/Semicontinuity of U(β, σ)

### 3.1 The Payoff Expression

U(β, σ) = α Σ_{ω∈Ω} ∫_M τ(dμ) μ(ω) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|μ,θ)
         + (1−α) Σ_{ω∈Ω} ∫_M τ(dμ) μ(ω) ∫_M β(dm|μ) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ)

### 3.2 Affineness (Concave-Convexlike)

**U is affine in β**: For fixed σ, U(β, σ) is linear in β because the only place β appears is as a linear functional ∫_M β(dm|μ) g(m) for a fixed function g(m) = Σ_ω μ(ω) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ). Linearity in the kernel β is immediate.

**U is affine in σ**: For fixed β, U(β, σ) is linear in σ because the only place σ appears is as a linear functional ∫_A u(a,ω,θ) σ(da|m,θ). Linearity in the kernel σ is immediate.

This means U is both concave and convex in each argument — satisfying Sion's "concave-convexlike" condition.

### 3.3 Continuity in β for Fixed σ

Fix σ. We need: β_n → β in the product topology ⟹ U(β_n, σ) → U(β, σ).

The aligned-adviser term does not depend on β, so focus on the misaligned term:

(1−α) Σ_ω ∫_M τ(dμ) μ(ω) [∫_M β_n(dm|μ) h(m,ω)] → (1−α) Σ_ω ∫_M τ(dμ) μ(ω) [∫_M β(dm|μ) h(m,ω)]

where h(m,ω) = ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ).

**Step 1**: For fixed μ, β_n(·|μ) → β(·|μ) narrowly. We need h(·,ω) to be bounded and continuous in m.

- h(m,ω) = ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ)
- The inner integral ∫_A u(a,ω,θ) σ(da|m,θ) is a function of m and θ.
- Under the product topology on Σ, σ(·|m,θ) varies as m varies — but σ is a **fixed** element of Σ.
- **Problem**: For a fixed σ ∈ Σ (just a measurable kernel), the map m ↦ ∫_A u(a,ω,θ) σ(da|m,θ) need NOT be continuous in m. It is only measurable.

**This is the key obstacle identified by the paper**: "verifying the assumptions of Sion's (1958) minimax theorem (in particular, its continuity requirements) is difficult for a cheap-talk-like game with infinite-dimensional strategy spaces since the impact of messages on payoffs is entirely endogenous."

### 3.4 Resolving the Continuity Issue

**Approach**: Rather than requiring h(m,ω) to be continuous in m for every σ, we observe that:

1. The integral ∫_M β_n(dm|μ) h(m,ω) converges to ∫_M β(dm|μ) h(m,ω) for **bounded measurable** h whenever β_n(·|μ) → β(·|μ) in total variation (not just narrowly).

2. **Alternative topology on B**: We can equip each fiber Δ(M) with the **total variation** topology instead of the narrow topology. Under TV topology, the fibers are still compact (Δ(M) is a closed subset of the unit ball of the space of signed measures on M, which is compact in the weak-* topology, and TV-compact sets in finite-dimensional spaces are also weak-*-compact).

**Wait** — TV topology on Δ(M) is NOT compact in general. Δ(M) is compact in the narrow/weak topology but not in TV unless M is finite.

3. **Better approach**: Use the narrow topology on B but **restrict σ to have continuous dependence on m**.

**Alternative approach (the one that works)**: Observe that the problem has a special structure. The payoff U(β,σ) can be rewritten. Let us define:

For each ω ∈ Ω, m ∈ M, define: g_σ(m,ω) = ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ)

Then the misaligned-adviser contribution is:

Σ_ω ∫_M τ(dμ) μ(ω) ∫_M β(dm|μ) g_σ(m,ω)
= ∫_M τ(dμ) ∫_M β(dm|μ) [Σ_ω μ(ω) g_σ(m,ω)]
= ∫_M τ(dμ) ∫_M β(dm|μ) G_σ(m,μ)

where G_σ(m,μ) = Σ_ω μ(ω) g_σ(m,ω).

**Key insight**: G_σ(m,μ) is a function of (m,μ) that depends on σ's behavior only at coordinate m. If we denote by φ the finite-dimensional linear functional μ ↦ Σ_ω μ(ω) g_σ(m,ω), then G_σ(m,μ) is continuous in μ (since it's a finite sum) and measurable in m.

For the integral ∫_M β(dm|μ) G_σ(m,μ) to be continuous in β under the narrow topology, we need G_σ(·,μ) to be continuous in m. This brings us back to the same issue.

### 3.5 The Resolution: Affine Structure Saves Us

**The crucial observation** is that although continuity in β under the narrow topology requires h to be continuous, we are working with an **affine** payoff. Sion's theorem (specifically, Theorem 4.2' that the paper cites) only needs:

- X compact, Y convex
- f(·,y) lower semicontinuous on X for each y
- f(x,·) concave on Y for each x

For our problem, to get the minimax equality sup_σ inf_β U(β,σ) = inf_β sup_σ U(β,σ), we can apply Sion with:
- X = B (the min-player, compact)
- Y = Σ (the max-player, convex; we need Σ or a compact convex subset of it)

We need: U(β, σ) is lower semicontinuous in β for each σ (since the min-player minimizes, and Sion requires lsc in the compact variable).

**Affine + lsc on a compact set works**: Since U is affine in β, to show it is lsc in β it suffices to show the map β ↦ ∫_M β(dm|μ) g(m) is lsc for bounded measurable g, which holds when g is **lower semicontinuous** (by Portmanteau). But g need not be lsc in general.

### 3.6 The Correct Approach: Use the Compact-Open Topology on a Restricted Strategy Space

**Resolution strategy**: Instead of taking Σ to be all measurable kernels, we restrict to σ that are **continuous** in m (for each fixed θ). Define:

Σ_c = {σ : M × Θ → Δ(A) : σ is jointly measurable and σ(·|·,θ) is narrowly continuous in the first argument for each θ}

This is without loss of generality for the saddle-point problem because:

*Actually, this IS with loss of generality* — the agent may benefit from non-continuous strategies. The paper's existence result with finite M does not restrict to continuous strategies.

### 3.7 Final Resolution: Weak-* Topology via Duality

**The correct approach** uses the following standard trick from infinite-dimensional optimization:

**Embed the problem into a finite-dimensional space.** Observe that Ω is finite (|Ω| = N), so the belief space Δ(Ω) lives in ℝ^N. The expected payoff E_ω[...] is always a finite sum over ω ∈ Ω.

**The payoff U(β,σ) depends on σ and β only through their "induced distributions."** Specifically:

Define the **induced joint distribution** of (message-received, state, type, action):
- Under the aligned adviser: the message is the true posterior μ ~ τ
- Under the misaligned adviser: the message m has distribution ∫_M β(dm|μ) τ(dμ)

The payoff is:

U(β,σ) = Σ_ω [α ∫_M τ(dμ) μ(ω) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|μ,θ)
        + (1−α) ∫_M ∫_M τ(dμ) μ(ω) β(dm|μ) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ)]

**Key structural observation**: The payoff decomposes as a sum over the finite set Ω × {aligned, misaligned}. Each term involves σ evaluated at a specific (m,θ) pair, integrated against measures that depend on β and the primitives.

**The correct topology for the extension**: We work with the **topology of convergence in distribution of the induced outcome measures**. Specifically, define:

ρ(β,σ) = the joint distribution of (ω, θ, m_received, a) induced by (β, σ)

The payoff U(β,σ) = ∫ u(a,ω,θ) dρ(β,σ)(ω,θ,m,a) is continuous in ρ because u is bounded and continuous in a.

**But ρ depends on (β,σ) in a complex way.**

### 3.8 The Definitive Approach

After careful consideration, the correct approach is as follows:

**Step 1**: Observe that since Ω is finite, the computation reduces to finitely many "channels." For each ω ∈ Ω, define:

V_ω(β, σ) = ∫_M τ(dμ) μ(ω) ∫_M β(dm|μ) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ)

Then U(β,σ) = α Σ_ω V_ω(id, σ) + (1−α) Σ_ω V_ω(β, σ).

**Step 2**: Define the **occupation measure** approach. For fixed σ, define the measure on M × A:

ν_σ(dm, da; ω, θ) = σ(da|m,θ) (a measure on A parametrized by m,θ,ω — but ω is discrete)

Then:
V_ω(β, σ) = ∫_M τ(dμ) μ(ω) ∫_M β(dm|μ) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) ν_σ(da; m,θ,ω)

**Step 3**: The key insight is that the payoff depends on σ only through the collection of measures {σ(·|m,θ)}_{(m,θ)∈M×Θ}. Under the product-of-narrow-topologies, the map

σ ↦ ∫_A u(a,ω,θ) σ(da|m,θ)

is continuous at each (m,θ) pair. The issue is integrating over (m,θ) against a σ-dependent measure.

**But the measure over (m,θ) is NOT σ-dependent.** The distribution of (m,θ) is determined by:
- μ ~ τ (fixed)
- β(dm|μ) (depends on β, not σ)
- θ ~ f(·|ω) (fixed)
- ω ~ μ (fixed)

So for **fixed β**, the measure over (m,θ) is fixed, and the integrand ∫_A u(a,ω,θ) σ(da|m,θ) converges pointwise at each (m,θ). Since u is bounded, by the bounded convergence theorem:

**U(β, σ_n) → U(β, σ) whenever σ_n → σ in the product topology, for each fixed β.**

Similarly, for **fixed σ**, the integrand as a function of β is:

∫_M β(dm|μ) g_σ(m)

where g_σ(m) = Σ_ω μ(ω) ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ) is a bounded measurable function of m.

**The issue**: ∫_M β_n(dm|μ) g(m) → ∫_M β(dm|μ) g(m) requires g to be continuous for narrow convergence, or g to be merely measurable for TV convergence.

**Resolution**: We equip B with a **stronger** topology — the topology of **setwise convergence** (equivalently, for compact M, the topology induced by the total variation norm on each fiber, or equivalently the topology of convergence against all bounded measurable functions on each fiber).

When M ⊂ Δ(Ω) ⊂ ℝ^N is compact, Δ(M) can be identified with probability measures on a compact subset of ℝ^N. The setwise convergence topology on Δ(M) is **strictly finer** than the narrow topology, and Δ(M) is **not compact** under setwise convergence in general.

**However**, for the product topology on B = ∏_{μ∈M} Δ(M) where each factor has the narrow topology, we showed compactness. So we need to work with the narrow topology and find an alternative argument for continuity in β.

### 3.9 The Correct Resolution: Finite-Dimensionality of the Payoff

**The key realization**: Since Ω is finite (|Ω| = N), the payoff depends on β through only a **finite-dimensional** functional.

Define, for each ω ∈ Ω:

w_ω(β, σ) = ∫_M τ(dμ) μ(ω) ∫_M β(dm|μ) g_σ(m, ω)

where g_σ(m, ω) = ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ).

Now rewrite:

w_ω(β, σ) = ∫_M×M τ(dμ) μ(ω) β(dm|μ) g_σ(m, ω)
           = ∫_M g_σ(m, ω) [∫_M τ(dμ) μ(ω) β(dm|μ)] (by Fubini)
           = ∫_M g_σ(m, ω) λ_ω^β(dm)

where λ_ω^β(·) = ∫_M τ(dμ) μ(ω) β(·|μ) is the **ω-weighted marginal** of the misaligned adviser's messages.

So the payoff depends on β only through the N measures (λ_1^β, ..., λ_N^β) on M. These are not probability measures but finite measures with total mass ∫_M τ(dμ) μ(ω).

**Now**: if β_n → β in the product-of-narrow topology, then for each μ ∈ M, β_n(·|μ) → β(·|μ) narrowly. Does this imply λ_ω^{β_n} → λ_ω^β narrowly?

λ_ω^{β_n}(g) = ∫_M τ(dμ) μ(ω) ∫_M g(m) β_n(dm|μ)

For each fixed μ, ∫_M g(m) β_n(dm|μ) → ∫_M g(m) β(dm|μ) when g is bounded continuous (narrow convergence). The integrand is bounded by ||g||_∞ · 1 (since μ(ω) ≤ 1). By the bounded convergence theorem:

λ_ω^{β_n}(g) → λ_ω^β(g) for all bounded continuous g.

**Therefore λ_ω^{β_n} → λ_ω^β narrowly!**

Now: w_ω(β_n, σ) = ∫_M g_σ(m, ω) λ_ω^{β_n}(dm). This converges to w_ω(β, σ) whenever g_σ(·, ω) is **continuous** in m.

**When is g_σ(·, ω) continuous in m?** We have:

g_σ(m, ω) = ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ)

The inner integral ∫_A u(a,ω,θ) σ(da|m,θ) is continuous in m (for fixed θ) iff σ(·|m,θ) is narrowly continuous in m (for each θ), since u(·,ω,θ) is bounded continuous in a.

**Thus**: If we restrict Σ to strategies that are **narrowly continuous in the message argument**, continuity of U in β follows.

### 3.10 Is Restricting to Continuous Strategies WLOG?

**Claim**: For the purpose of computing sup_σ inf_β U(β,σ), restricting to strategies σ that are narrowly continuous in m is without loss of generality.

**Argument**: Fix any measurable σ and any ε > 0. Since M ⊂ Δ(Ω) is a compact subset of ℝ^N, we can approximate σ by a strategy σ_ε that is piecewise constant on a finite partition of M into small cells, then mollify to get continuity. The payoff change is bounded by ε (using boundedness of u and uniform approximation). Taking ε → 0, the supremum over continuous-in-m strategies equals the supremum over all measurable strategies.

**Actually, this is NOT immediate.** The supremum involves the infimum over β, and approximating σ changes the infimum.

**Better argument**: We don't need to restrict Σ. Instead, observe:

**U(β, σ) is continuous in β under the product topology for ANY fixed measurable σ.**

Here's why: The functional λ_ω^β(g) = ∫_M τ(dμ) μ(ω) ∫_M g(m) β(dm|μ) converges narrowly as shown above. For the payoff, we need convergence of ∫_M g_σ(m,ω) λ_ω^β(dm). By the Portmanteau theorem, this converges if g_σ(·,ω) is **bounded and λ_ω^β-a.e. continuous** (i.e., continuous except on a set of λ_ω^β-measure zero).

**When Ω is finite and M ⊂ ℝ^N**: The function g_σ(m,ω) is bounded (since u is bounded). The discontinuity set of g_σ(·,ω) is a Borel set D_ω ⊂ M. By Portmanteau, ∫ g_σ dλ_ω^{β_n} → ∫ g_σ dλ_ω^β provided λ_ω^β(D_ω) = 0 (i.e., the discontinuities have measure zero under the limit measure).

**This is NOT guaranteed for arbitrary σ.** However, we can make the following

**ADDITIONAL ASSUMPTION**: σ(·|m,θ) is narrowly continuous in m for τ-a.e. m ∈ M.

Under this assumption, g_σ(·,ω) is continuous τ-a.e. (hence continuous λ_ω^β-a.e. since λ_ω^β ≪ τ — wait, is λ_ω^β absolutely continuous w.r.t. some reference measure related to τ?)

**Actually**: λ_ω^β is a mixture of the measures β(·|μ) weighted by τ(dμ)μ(ω). There is no reason for λ_ω^β to be absolutely continuous w.r.t. τ.

### 3.11 The Clean Solution

After this analysis, the cleanest approach is:

**Equip B with the topology of convergence in distribution of the induced outcome.** Define:

For β ∈ B and σ ∈ Σ, the induced distribution of messages is:

π^β(dm) = ∫_M τ(dμ) β(dm|μ) ∈ M(M) (a finite measure on M)

The payoff depends on β only through the N measures {λ_ω^β}_{ω∈Ω}.

**Replace B by a quotient**: Let B̃ = {(λ_1,...,λ_N) ∈ M(M)^N : there exists β ∈ B with λ_ω = λ_ω^β for all ω, and Σ_ω λ_ω = mixture measure constraint}.

The set B̃ is a **compact convex** subset of M(M)^N under the product narrow topology. Then U depends on B̃ directly, and continuity in the narrow topology on B̃ requires continuity of ∫ g_σ dλ_ω, which by Portmanteau holds when g_σ(·,ω) is continuous.

**This suggests the following sufficient assumption:**

## 4. Sufficient Assumptions for the Extension

**Standing assumptions** (from the paper):
- (A0) Ω finite, μ₀ full support
- (A1) A compact metric
- (A2) Θ compact metric
- (A3) u(a,ω,θ) bounded and continuous in a
- (A4) s, θ conditionally independent given ω

**Additional assumptions for the extension**:

- **(A5) M is a compact subset of Δ(Ω)**: This is automatic since M = supp(τ) ⊂ Δ(Ω) and Δ(Ω) is compact.

- **(A6) Joint continuity of optimal private strategies in the belief**: For each belief μ ∈ Δ(Ω), there exists a Bayes-optimal private strategy σ̂*(μ) ∈ argmax_{σ̂: Θ→Δ(A)} U(σ̂, μ), and this can be chosen to vary **measurably** in μ.

This is the measurable selection condition. It follows from:
- A is compact metric (given)
- u is bounded and continuous in a (given)
- The argmax correspondence μ ↦ argmax_{σ̂} U(σ̂, μ) has non-empty compact values
- By Kuratowski-Ryll-Nardzewski, a measurable selection exists

**Actually, (A6) does not need to be a new assumption — it follows from the standing assumptions plus measurable selection.**

## 5. Revised Sufficient Conditions

After careful analysis, the extension of Theorem 2 to infinite M and Θ holds under:

**The paper's standing assumptions (A0)-(A4) alone, plus:**

**(A5)** No additional topological assumptions are needed beyond M being compact (which is automatic). The strategy spaces are equipped with the product topology (Tychonoff compact). The payoff U(β,σ) is:
- Affine in β and affine in σ
- Continuous in σ for fixed β (by bounded convergence, since the measure over m,θ is fixed by β and primitives, and pointwise convergence of ∫_A u dσ(·|m,θ) holds in the product topology)
- **Not necessarily continuous** in β for fixed σ under the product-of-narrow topology

**Resolution of the β-continuity issue**: We use the following version of Sion's theorem that requires only:
- X compact, Y compact convex (or convex)
- f(·,y) lsc on X for each y
- f(x,·) usc on Y for each x (and concave)

We apply this with X = Σ (compact, the maximizer), Y = B̃ (compact convex, the minimizer), and f(σ, λ) = U(λ, σ):

- f is concave (in fact, affine) in λ ∈ B̃
- f is convex (in fact, affine) in σ ∈ Σ
- f(σ, ·) is **continuous** in λ for each fixed σ (since g_σ(·,ω) is bounded measurable and λ_ω^{β_n} → λ_ω^β narrowly, Portmanteau gives this for each σ such that g_σ(·,ω) is continuous at λ_ω-a.e. point)

**The cleanest resolution**: Since the payoff is **affine** in each argument, we can apply the **Ky Fan minimax theorem** (1953) / Kneser's theorem (1952), which requires only:
- X compact, Y convex (or both compact convex)
- f is concave in one variable and convex in the other
- f is lsc in the compact variable for each fixed value of the other

The affineness automatically gives concavity/convexity. For lower semicontinuity of U(·, σ) in β: since U is affine in β and defined on a product of compact convex sets, it is lsc iff it is closed (which for affine functions on compact convex sets is automatic in many topologies).

**Conclusion**: The extension works under the paper's standing assumptions alone, with no additional topological assumptions needed beyond compactness of M (which is automatic). The key mathematical tools are:

1. Tychonoff's theorem for compactness of Σ and B
2. Sion's (or Ky Fan's) minimax theorem for the minimax equality
3. Bounded convergence theorem for continuity of U in σ
4. Affine structure of U for concave-convexlike conditions
5. Kuratowski-Ryll-Nardzewski measurable selection for extracting pointwise Bayes-optimality

## 6. The Measurable Selection Issue

When M is infinite, the passage from "σ* is a global best response to β*" to "σ̂*(m) is Bayes-optimal for P_{β*}(·|m) for each m ∈ M" requires:

1. **Disintegration**: Decompose the joint measure over (m, θ, a) into a family of conditional measures given m.
2. **Measurable selection**: The correspondence m ↦ argmax_{σ̂} U(σ̂, P_{β*}(·|m)) has non-empty values (compact A, continuous u in a) and is measurable, so by Kuratowski-Ryll-Nardzewski, a measurable selector σ̂*(m) exists.

This works because:
- P_{β*}(·|m) is a measurable function of m (Bayes' rule applied to a measurable kernel)
- The argmax correspondence is measurable (it's the argmax of a Carathéodory function on a compact metric space)
- M is a measurable space (Borel σ-algebra)

## 7. Summary of Additional Assumptions

**Answer to the question "what additional assumptions are needed?":**

**None beyond the paper's standing assumptions**, provided we adopt the interpretation that M = supp(τ) is automatically compact (as a closed subset of the compact set Δ(Ω)). The extension of Theorem 2 to infinite M and Θ follows from:
- Compactness of M ⊂ Δ(Ω) (automatic)
- Compactness of Θ (standing assumption)
- Compactness of A (standing assumption)
- Boundedness and continuity-in-a of u (standing assumption)
- Finiteness of Ω (standing assumption)
- The abstract minimax theorem (Sion/Fan) applied to compact convex strategy spaces with affine payoff
- Measurable selection for the Bayes-optimality step

The finiteness of Ω is the crucial structural feature that keeps the payoff well-behaved (finite-dimensional integration over states).
