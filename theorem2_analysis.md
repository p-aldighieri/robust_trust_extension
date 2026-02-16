# Analysis of Theorem 2 and Its Proof in Appendix A.2

## 1. Full Formal Statement of Theorem 2

### 1.1 Fixed Primitives (Standing Assumptions from Section 2)

- **State space**: Finite set Ω with |Ω| = N, prior μ₀ ∈ Δ(Ω) with full support.
- **Adviser's signal**: Posterior s ∈ Δ(Ω) with distribution τ, support M = supp(τ).
- **Action space**: A is a compact metric space.
- **Type space**: Θ is a compact metric space.
- **Utility**: u(a, ω, θ) is bounded and continuous in a.
- **Conditional independence**: s and θ are conditionally independent given ω.
- **Alignment probability**: α ∈ [0, 1].
- **Measurability**: All infinite spaces carry the Borel σ-algebra; "for all" means "for almost all" where needed.

### 1.2 Strategy Spaces

- **Agent strategies**: Σ = {σ : Δ(Ω) × Θ → Δ(A), measurable}, mapping (message, type) pairs to action distributions.
- **Misaligned adviser strategies**: B = {β : M → Δ(Δ(Ω)), measurable}, mapping adviser posteriors to distributions over messages (wlog restricted to messages in M).

### 1.3 Payoff and Objective

For (β, σ) ∈ B × Σ:

U(β, σ) = α · E_{id,σ}[u(a,ω,θ)] + (1−α) · E_{β,σ}[u(a,ω,θ)]

The robust objective: U(σ) = α · E_{id,σ}[u(a,ω,θ)] + (1−α) · inf_{β∈B} E_{β,σ}[u(a,ω,θ)]

The optimal value: U* = sup_{σ∈Σ} U(σ)

### 1.4 Adversarial Strategy

β* ∈ B is **adversarial against σ** if β* ∈ argmin_{β∈B} E_{β,σ}[u(a,ω,θ)].

### 1.5 Robust Rationalizability (Definition 2)

Write σ ~ (σ̂(m))_{m∈Δ(Ω)} where σ̂(m): Θ → Δ(A) is the private strategy at message m.

σ is **robustly rationalizable** if there exists β* adversarial against σ such that for all m ∈ M:
  σ̂(m) ∈ argmax_{σ̂'} U(σ̂', P_{β*}(·|m))

where P_{β*}(·|m) is the Bayesian posterior over Ω given message m under strategy β*.

### 1.6 Theorem 2 (Robustly Rationalizable Solution)

**(Optimality direction)** For any M and Θ: If σ is robustly rationalizable, then U(σ) = U*.

**(Existence direction)** If M and Θ are finite: There exists a robustly rationalizable strategy.

---

## 2. Detailed Proof Structure (Appendix A.2)

The proof proceeds in two parts:

### Part I: Existence Direction (M, Θ finite)

**Step 1: Express payoff as explicit sums.**
Since M and Θ are finite:

U(β, σ) = α Σ_{μ∈M,ω∈Ω,θ∈Θ} τ(μ)μ(ω)f(θ|ω) ∫_A u(a,ω,θ)σ(da|μ,θ)
         + (1−α) Σ_{μ,m∈M,ω∈Ω,θ∈Θ} τ(μ)μ(ω)β(m|μ)f(θ|ω) ∫_A u(a,ω,θ)σ(da|m,θ)

**Step 2: Establish compactness and convexity of strategy spaces.**
- B = ×_{m∈M} Δ(M) is compact (finite product of simplices) and convex.
- Σ = ×_{m∈M,θ∈Θ} Δ(A) is compact (finite product of weak-* compact sets) and convex.

**Step 3: Verify payoff properties.**
- U(β, σ) is affine in β (hence concave-convexlike).
- U(β, σ) is affine in σ (hence concave-convexlike).
- U(β, σ) is continuous in β for fixed σ.
- U(β, σ) is continuous in σ for fixed β.

**Step 4: Apply Sion's minimax theorem (Theorem 4.2', Sion 1958).**
Conclude: sup_σ inf_β U(β,σ) = inf_β sup_σ U(β,σ).

**Step 5: Construct saddle point.**
- ϕ(β) = sup_σ U(β,σ) is attained (Σ compact, U continuous in σ) and lower-semicontinuous.
- ψ(σ) = inf_β U(β,σ) is attained (B compact, U continuous in β) and upper-semicontinuous.
- σ* ∈ argmax_σ ψ(σ) and β* ∈ argmin_β ϕ(β) form a saddle point.

**Step 6: Conclude robust rationalizability.**
- β* is adversarial against σ* (from the saddle-point right inequality).
- σ* is a best-response to β* (from the saddle-point left inequality).
- Since α > 0 and all m ∈ M are on-path, σ̂*(m) is Bayes-optimal given P_{β*}(·|m) for all m ∈ M.

### Part II: Optimality Direction (general M, Θ)

Given (σ*, β*) with σ* robustly rationalizable and β* adversarial against σ*, for any σ ∈ Σ:

U(σ) = inf_β U(β,σ) ≤ U(β*,σ) ≤ U(β*,σ*) = min_β U(β,σ*) = U(σ*)

The key chain:
- First ≤: infimum is ≤ any particular value.
- Second ≤: saddle-point property.
- Equalities: β* adversarial against σ*.

---

## 3. Points Where Finiteness of M or Θ Is Invoked

### Use 1: Compactness of B (finiteness of M)

**Location**: Step 2 of existence proof.
**How finiteness is used**: B = ×_{μ∈M} Δ(M). When M is finite, this is a finite product of finite-dimensional simplices, hence compact in the Euclidean topology.
**Classification**: **Replaceable.** When M is a compact metric space, β: M → Δ(M) is a Markov kernel from M to M. The space of such kernels can be given the narrow (weak) topology and is compact by Prokhorov-type arguments (the space of probability measures on a compact metric space is compact in the narrow topology, and spaces of kernels inherit compactness under appropriate topologies). However, this requires care: compactness of the space of Markov kernels from a compact space to itself under the narrow topology on the fibers needs the "stable topology" or the topology of convergence in distribution uniformly over the source space, which is metrizable when M is compact metric.

### Use 2: Compactness of Σ (finiteness of M and Θ)

**Location**: Step 2 of existence proof.
**How finiteness is used**: Σ = ×_{m∈M, θ∈Θ} Δ(A). When M and Θ are finite, this is a finite product of copies of Δ(A), which is weak-* compact. By Tychonoff's theorem, a finite product of compact spaces is compact. But even for an infinite product, Tychonoff applies.
**Classification**: **Replaceable, but subtle.** For infinite M × Θ, Σ is a product ∏_{(m,θ) ∈ M×Θ} Δ(A) with the product topology (pointwise convergence of kernels). By Tychonoff's theorem, this is compact. However, the issue is that the product topology is too weak for the payoff U(β,σ) to be continuous in σ. What is needed is continuity of the integral ∫ u(a,ω,θ) σ(da|m,θ) in σ, which under the product topology only gives pointwise convergence — but the payoff involves integration over (m, θ), so we need some form of dominated convergence or uniform integrability. The correct approach is to view σ as a Markov kernel from M × Θ to A, equip the space with the narrow topology (weak convergence of the induced joint measures), and establish compactness via Prokhorov's theorem.

### Use 3: Continuity of U(β,σ) in β (finiteness of M)

**Location**: Step 3 of existence proof.
**How finiteness is used**: When M is finite, β is a vector in ∏_{μ∈M} Δ(M) and U(β,σ) is a finite sum over μ∈M with terms linear in β(m|μ), so continuity (indeed, affineness) is immediate.
**Classification**: **Replaceable, with additional assumptions.** For infinite M, the sum becomes an integral:

(1−α) ∫_M τ(dμ) Σ_{ω∈Ω} μ(ω) ∫_M β(dm|μ) f(θ|ω) ∫_A u(a,ω,θ) σ(da|m,θ)

Continuity in β requires that the map β ↦ ∫_M β(dm|μ) g(m) is continuous for the chosen topology on B, where g(m) = Σ_{ω,θ} μ(ω)f(θ|ω) ∫_A u(a,ω,θ) σ(da|m,θ). This holds in the narrow topology on fibers if g is bounded continuous in m, which requires continuity of σ(·|m,θ) in m — a measurable selection issue that needs attention. Affineness in β is preserved regardless of finiteness.

### Use 4: Continuity of U(β,σ) in σ (finiteness of M and Θ)

**Location**: Step 3 of existence proof.
**How finiteness is used**: When M and Θ are finite, σ is a finite collection of measures {σ(·|m,θ)}_{m∈M,θ∈Θ} and U is a finite sum of integrals ∫_A u(a,ω,θ) σ(da|m,θ), each continuous in σ(·|m,θ) under weak-*.
**Classification**: **Replaceable, with additional assumptions.** For infinite M×Θ, continuity of U in σ under the narrow topology on kernels requires: (a) u(a,ω,θ) bounded and continuous in a (given); (b) the integration over m and θ is well-behaved, i.e., the map σ ↦ ∫∫ g(m,θ) [∫_A u(a,ω,θ) σ(da|m,θ)] τ⊗f(d(m,θ)) is continuous when σ converges narrowly. This follows from bounded convergence if u is bounded (given) and ∫_A u(a,ω,θ) σ(da|m,θ) converges pointwise in (m,θ) — which holds if σ_n(·|m,θ) → σ(·|m,θ) weakly for a.e. (m,θ). The key issue is whether the chosen topology on Σ guarantees this a.e. pointwise weak convergence.

### Use 5: Attainment of supremum/infimum (finiteness enabling compactness + continuity)

**Location**: Step 5 of existence proof.
**How finiteness is used**: The facts that sup_σ U(β,σ) is attained and inf_β U(β,σ) is attained rely on compactness of Σ and B together with continuity of U. Both facts use finiteness via Uses 1-4.
**Classification**: **Replaceable if Uses 1-4 are resolved.** Once compactness and (semi)continuity are established for infinite spaces, attainment follows from standard extreme value theorems.

### Use 6: All m ∈ M are on-path (concluding robust rationalizability)

**Location**: Step 6 of existence proof.
**How finiteness is used**: The argument that σ* is robustly rationalizable uses that "since α > 0 and all m ∈ M are on-path" — meaning the aligned adviser uses identity, so every m ∈ M has positive probability. This step does **not** use finiteness of M per se, but the conclusion that σ̂*(m) is Bayes-optimal for P_{β*}(·|m) "for all m ∈ M" needs to be interpreted carefully when M is infinite. With finite M, "for all m" is just universal quantification over a finite set. With infinite M, the saddle-point property gives a global best-response property, and extracting pointwise Bayes-optimality at each m requires a **measurable selection** argument.
**Classification**: **Genuine obstruction requiring measurable selection.** When M is infinite, decomposing the global best-response σ* into pointwise-optimal private strategies σ̂*(m) for τ-almost every m requires the disintegration theorem and possibly measurable selection (Kuratowski-Ryll-Nardzewski or Jankov-von Neumann). This is the most subtle step in the extension.

---

## 4. Summary Classification

| # | Use of Finiteness | Replaceable? | Replacement Strategy |
|---|---|---|---|
| 1 | Compactness of B | Yes | Prokhorov/narrow topology on kernels |
| 2 | Compactness of Σ | Yes (subtle) | Narrow topology + Prokhorov; or product topology + Tychonoff with additional continuity |
| 3 | Continuity of U in β | Yes (with assumptions) | Narrow convergence + bounded convergence theorem |
| 4 | Continuity of U in σ | Yes (with assumptions) | Narrow convergence + bounded convergence theorem |
| 5 | Attainment of sup/inf | Yes (derived) | Follows from 1-4 |
| 6 | Pointwise Bayes-optimality for all m | Genuine obstruction | Measurable selection theorem |

**Key finding**: There are 6 distinct points where finiteness is used. Five are replaceable by standard functional-analytic arguments under appropriate topological assumptions on the strategy spaces. The sixth (pointwise Bayes-optimality for infinite M) requires a measurable selection theorem to extract message-by-message optimality from the global saddle-point property.

---

## 5. The Optimality Direction Is Finiteness-Free

The optimality direction (robustly rationalizable ⟹ optimal) does **not** use finiteness of M or Θ at all. The proof is a direct chain of inequalities:

U(σ) = inf_β U(β,σ) ≤ U(β*,σ) ≤ U(β*,σ*) = min_β U(β,σ*) = U(σ*)

This only requires:
- That β* is adversarial against σ* (attains the infimum).
- The saddle-point inequality U(β*,σ) ≤ U(β*,σ*).

Neither of these uses finiteness. The optimality direction holds for arbitrary M and Θ as long as the relevant saddle-point/adversarial pair exists.

---

## 6. Accuracy Verification Against the PDF

All statements above have been verified against the PDF text of Appendix A.2 (pages 29-32 of the paper):
- The payoff formula matches equation on p. 30 (beginning of A.2).
- The compactness and convexity claims match p. 31, para 1.
- The concave-convexlike / Sion reference matches p. 31, para 1.
- The saddle-point construction matches equation (12) on p. 31.
- The robust-rationalizability conclusion matches p. 31, bottom paragraph.
- The optimality-direction proof matches p. 32, top.
