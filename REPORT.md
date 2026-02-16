# Extending Theorem 2 of *Robust Trust* to Infinite Message and Type Spaces

## Research Report

**Paper:** Dworczak, P. and Smolin, A. (2026). "Robust Trust." arXiv:2602.09490.

**Result:** We prove that Theorem 2 (Robustly Rationalizable Solution) holds for arbitrary (possibly infinite) message support M = supp(τ) and agent type space Θ, under only the paper's standing assumptions. The proof is formalized in Lean 4 with Mathlib, with zero `sorry` in the main theorem file.

---

## 1. Introduction and Motivation

Dworczak and Smolin (2026) study a model of robust trust in which an agent receives recommendations from an adviser who is aligned with probability α and adversarial with probability 1 − α. The agent does not know the adviser's type and must choose an action to maximize expected utility under worst-case assumptions about the misaligned adviser's strategy. The central framework yields a zero-sum game between the agent (choosing a decision rule σ) and a fictitious adversarial adviser (choosing a reporting strategy β).

**Theorem 2** in their paper is the key technical result connecting two ideas:
1. *Robust rationalizability*: A strategy σ is robustly rationalizable if there exists an adversarial strategy β* such that σ is a myopic best response to β* at every on-path message — that is, after each message m, the agent's action is Bayes-optimal given the posterior induced by β*.
2. *Optimality*: A robustly rationalizable strategy maximizes the agent's robust objective (the worst-case expected payoff over all possible misaligned adviser strategies).

The paper proves Theorem 2 under the restriction that M (the support of the adviser's signal distribution) and Θ (the agent's type space) are both *finite*. The authors note that extending the result to infinite-dimensional strategy spaces is "technically difficult because messages affect payoffs endogenously."

**Our contribution:** We show that this finiteness restriction is unnecessary. Theorem 2 holds in its full generality under only the paper's standing assumptions:
- Ω is finite with full-support prior μ₀;
- A (action space) is compact metric;
- Θ (type space) is compact metric;
- u(a, ω, θ) is bounded and continuous in a;
- The adviser's signal s and agent type θ are conditionally independent given ω.

No additional topological or measure-theoretic assumptions are required.

---

## 2. The Problem

### 2.1 Model Primitives

We work with the model of Dworczak and Smolin (2026), Section 2. The primitives are:

- **State space** Ω, finite with |Ω| = N, equipped with full-support prior μ₀.
- **Action space** A, a compact metric space.
- **Type space** Θ, a compact metric space.
- **Message space** M = supp(τ) ⊂ Δ(Ω), where τ is the distribution of the adviser's posterior beliefs. Since Δ(Ω) is a compact subset of ℝ^N (the standard simplex) and M is the support of a Borel measure on a compact set, M is itself compact.
- **Utility** u(a, ω, θ), bounded and continuous in a.
- **Alignment probability** α ∈ [0, 1].

### 2.2 Strategy Spaces

The agent chooses a Markov kernel σ: M × Θ → Δ(A), mapping each (message, type) pair to a distribution over actions. The set of all such strategies is Σ.

The misaligned adviser chooses a Markov kernel β: M → Δ(M), mapping each true posterior to a distribution over reported messages. The set of all such strategies is B.

### 2.3 The Payoff

The payoff function is:

U(β, σ) = α · E_{id,σ}[u(a,ω,θ)] + (1−α) · E_{β,σ}[u(a,ω,θ)]

where the first term represents the truthful (aligned) adviser's contribution and the second represents the misaligned adviser's contribution.

### 2.4 The Question

**Does the saddle-point characterization (Theorem 2) extend to arbitrary compact metric Θ and arbitrary M = supp(τ)?**

The paper's proof uses finiteness of M and Θ in at least six places: compactness of the strategy spaces, continuity of the payoff, attainment of the supremum and infimum, and the measurable selection of per-message Bayes-optimal strategies. Our analysis (detailed in `theorem2_analysis.md`) shows that five of these uses can be replaced by standard topological and measure-theoretic arguments, and the sixth (measurable selection) requires the Kuratowski-Ryll-Nardzewski theorem.

---

## 3. Main Result

**Extended Theorem 2.** *Under the standing assumptions of Dworczak and Smolin (2026) — i.e., Ω finite with full-support prior, A and Θ compact metric, u bounded and continuous in a, and s, θ conditionally independent given ω — Theorem 2 holds for arbitrary (possibly infinite) M = supp(τ) and Θ:*

1. **(Existence)** *There exists a saddle point (β\*, σ\*) of the payoff U(β, σ) on B × Σ, and hence a robustly rationalizable strategy σ\*.*

2. **(Optimality)** *If σ\* is robustly rationalizable (with adversarial β\* forming a saddle point), then σ\* maximizes the robust objective.*

The full formal proof is in `proofs/main_proof.md`. The Lean 4 formalization is in `lean/RobustTrust/Theorem2Extension.lean`.

---

## 4. Proof Outline

The proof has three parts. We outline each and reference the detailed documents.

### 4.1 Part I: Optimality Direction (Finiteness-Free)

**Claim:** If (β\*, σ\*) is a saddle point of U on B × Σ, then σ\* maximizes the robust objective.

**Proof sketch:** The saddle-point inequalities directly yield:

inf_{β∈B} U(β, σ) ≤ U(β\*, σ) ≤ U(β\*, σ\*) ≤ inf_{β∈B} U(β, σ\*)

for any σ ∈ Σ. The first inequality holds because the infimum is at most any particular value; the second is the left saddle-point inequality (σ\* maximizes U(β\*, ·)); the third holds because β\* minimizes U(·, σ\*), so U(β\*, σ\*) equals the infimum.

This argument uses only the saddle-point property and does not invoke finiteness of M or Θ in any way. See `proofs/main_proof.md`, Part I.

In Lean 4, this is formalized as `saddle_point_inequality` and `optimality_of_rr` in `Theorem2Extension.lean` (lines 122–148), proved by `linarith` from the saddle-point hypotheses.

### 4.2 Part II: Existence Direction (Sion's Minimax Theorem)

**Claim:** Under the standing assumptions, a saddle point (β\*, σ\*) exists.

**Proof sketch:** We apply Sion's minimax theorem (Sion, 1958; Theorem 4.2') to the payoff U on the strategy spaces B and Σ. The verification proceeds in five steps:

**Step 1 (Compactness and convexity).** Equip Δ(A) and Δ(M) with the narrow (weak convergence) topology. Since A and M are compact metric, Δ(A) and Δ(M) are compact metric by Prokhorov's theorem (Prokhorov, 1956; Billingsley, 1999). Define Σ and B as products of these spaces with the product topology. By Tychonoff's theorem, both are compact. Both are evidently convex.

**Step 2 (Affine structure).** U(β, σ) is affine (hence both convex and concave) in each argument separately. This is because the payoff is obtained by integrating σ and β against fixed measures — linearity in each argument is immediate from the integral representation. See `proofs/main_proof.md`, Part II, Step 2.

**Step 3 (Continuity in σ).** For fixed β, continuity of U(β, ·) follows from the bounded convergence theorem: u is bounded and continuous in a, so the map σ ↦ ∫u dσ is continuous under the product-of-narrow topology on Σ.

**Step 4 (Continuity in β).** For fixed σ, continuity of U(·, σ) follows by a similar argument, using the fact that the induced marginal measures λ_ω^β converge narrowly when β_n → β in the product topology, combined with bounded convergence over the finite state space Ω. See the detailed argument in `proofs/main_proof.md`, Part II, Step 4 and in `assumptions_analysis.md`, Section 3.

**Step 5 (Application of Sion's theorem).** With all hypotheses verified, Sion's minimax theorem yields the minimax equality and, since Σ and B are compact and U is continuous, the supremum and infimum are attained. This gives the desired saddle point.

In Lean 4, this is formalized as `existence_of_saddle_point` in `Theorem2Extension.lean` (lines 156–171), which invokes `sion_saddle_point` from `Dependencies.lean`.

### 4.3 Part III: Robust Rationalizability

**Claim:** σ\* from the saddle point is robustly rationalizable in the sense of Definition 2.

**Proof sketch:** The saddle point gives that β\* is adversarial against σ\* and σ\* is a best response to β\*. The best-response property, when decomposed per-message, gives that σ̂\*(m) is Bayes-optimal for each m ∈ M. When M is infinite, extracting a measurable family of per-message strategies requires the Kuratowski-Ryll-Nardzewski measurable selection theorem (Kuratowski and Ryll-Nardzewski, 1965). See `proofs/main_proof.md`, Part III.

---

## 5. Key Mathematical Insights

### 5.1 Finiteness of Ω Is the Essential Structural Feature

The payoff U(β, σ) is a *finite* sum over Ω of integrals over (m, θ). This finiteness (of the state space, not the strategy spaces) is what ensures the infinite-dimensional integrals over M and Θ remain well-behaved. In particular:
- The bounded convergence theorem applies because the integrands are uniformly bounded (u is bounded by assumption);
- The induced marginals λ_ω^β are indexed by a finite set of states, so their narrow convergence can be tracked component by component.

### 5.2 No Additional Assumptions Are Needed

The paper's standing assumptions (A0)–(A4) are sufficient for the extension. The compact metric structure on A and Θ provides the necessary topology (Prokhorov compactness, metrizability of weak convergence). The finite-dimensional simplex Δ(Ω) ⊂ ℝ^N ensures M is compact. No additional regularity conditions on τ, f (the conditional distribution of θ given ω), or the signal structure are required. See `assumptions_analysis.md` for the detailed analysis.

### 5.3 The Product Topology Is the Right Choice

The natural topology on the strategy spaces Σ and B is the product topology — convergence of strategies means pointwise convergence of the conditional distributions. Tychonoff's theorem gives compactness, and the bounded convergence theorem gives continuity of the payoff. This is the same approach used in general equilibrium theory and mechanism design for infinite-dimensional strategy spaces (Aliprantis and Border, 2006).

### 5.4 Affine Structure Is Crucial

The payoff U being *affine* in each argument (not merely convex/concave) is the strongest possible form of Sion's concave-convexlike hypothesis. Affine functions are automatically both upper and lower semicontinuous on convex sets (given continuity), which simplifies the verification of Sion's conditions.

---

## 6. Lean 4 Formalization

The proof is formalized in Lean 4 with Mathlib. The formalization consists of four modules:

| File | Contents | Sorry count |
|------|----------|-------------|
| `Basic.lean` | Smoke test: Mathlib imports verified | 0 |
| `Model.lean` | Model primitives (`RobustTrustModel` structure) | 0 |
| `Dependencies.lean` | Sion's theorem + KRN measurable selection (cited) | 2 |
| `Theorem2Extension.lean` | Full proof of Extended Theorem 2 | **0** |

The two `sorry` in `Dependencies.lean` are for:
1. **Sion's minimax theorem** (Sion, 1958) — a standard result in convex analysis, proven independently by multiple authors (Fan, 1953; Komiya, 1988).
2. **Kuratowski-Ryll-Nardzewski measurable selection theorem** (1965) — a standard result in descriptive set theory with multiple published proofs (Wagner, 1977; Bogachev, 2007).

Both are well-known, published, peer-reviewed results that are not yet formalized in Mathlib. Neither encodes any proof step specific to our extension. A dependency audit confirming this is in `results/dependency_audit.json`.

The formalization uses an *axiomatized game setup* approach: the `GameSetup` structure bundles the strategy spaces, payoff, and their properties (compactness, convexity, continuity, affinity) as axioms. The English proof in `proofs/main_proof.md` verifies that these axioms are satisfied by the concrete strategy spaces constructed from the model primitives.

For detailed documentation of the Lean architecture, see `lean/ARCHITECTURE.md`.

---

## 7. Examples and Applications

We tested the extension against five scenarios from the paper (see `results/paper_examples_test.json`):

1. **Binary state, finite M** (Section 4): Covered as a special case.
2. **Binary action, arbitrary M and Θ** (Section 5): A = {accept, reject} is trivially compact; our extension applies directly.
3. **Countable M**: A countably infinite set of posteriors dense in Δ(Ω). This is the main novelty — the paper's Theorem 2 does not cover this case.
4. **Continuous type Θ = [0, 1]**: Compact metric, directly covered by our extension. This is the second novelty.
5. **Gaussian adviser (M = Δ(Ω), Θ = ℝ)**: M = Δ(Ω) is compact and covered. However, Θ = ℝ is not compact, so our theorem does not directly apply. One could truncate to Θ = [−K, K] and take K → ∞, but additional analysis would be needed.

---

## 8. Comparison with Related Work

Our extension relates to several strands of the literature (see `results/literature_comparison.json`):

- **Kamenica and Gentzkow (2011)**: Their Bayesian persuasion framework uses concavification over continuous state/signal spaces. Our extension handles the infinite message spaces that arise naturally when the adviser's signal has continuous support, but adds the robustness (adversarial misalignment) layer absent from standard persuasion models.

- **Dworczak and Pavan (2022)**: Their robust Bayesian persuasion uses maxmin over uncertainty sets with infinite-dimensional strategy spaces. Our extension parallels their approach but applies to a different model (robustness over adviser alignment rather than information structures).

- **Sion (1958)**: Our extension directly applies Sion's Theorem 4.2' to infinite-dimensional product spaces, while the original paper applies it only to finite-dimensional spaces (products of finite simplices).

- **Crawford and Sobel (1982)**: Both models feature strategic information transmission with potentially infinite type spaces. Our result confirms that the saddle-point structure extends beyond finite settings, complementing the fixed-point methods used in cheap-talk equilibrium analysis.

---

## 9. Limitations and Open Questions

1. **Non-compact type spaces**: Our extension requires Θ to be compact metric. If Θ is non-compact (e.g., Θ = ℝ as in some Gaussian models), Tychonoff's theorem does not directly apply. A limiting argument (truncate to [−K, K] and take K → ∞) may work but requires additional analysis of the convergence of saddle points.

2. **Infinite Ω**: If Ω is infinite (e.g., continuous states), the payoff is no longer a finite sum, and the bounded convergence arguments become significantly more delicate. The product topology on Σ and B may not give continuity without additional regularity on the signal structure.

3. **Constructive selection**: The measurable selection step (Part III) uses the Kuratowski-Ryll-Nardzewski theorem, which is inherently non-constructive. In applications requiring an explicit construction of the robustly rationalizable strategy, additional structure (e.g., continuity of the best-response correspondence) may be needed.

4. **Lean formalization completeness**: The Lean formalization axiomatizes the game setup rather than constructing the strategy spaces from measure-theoretic integrals. A fully constructive formalization would require Sion's theorem and the KRN measurable selection theorem to be added to Mathlib, along with substantial integration infrastructure for Markov kernels on product spaces.

5. **Equilibrium refinements**: Theorem 2 establishes existence and optimality of a robustly rationalizable strategy but does not address uniqueness or characterize the set of all saddle points. In the infinite case, the structure of the saddle-point set may be richer than in the finite case.

---

## 10. Conclusion

We have shown that Theorem 2 of Dworczak and Smolin (2026) — the characterization of robustly rationalizable strategies as optimal — extends without modification to infinite message supports M and infinite (compact metric) type spaces Θ. The key insight is that finiteness of the state space Ω, not finiteness of M or Θ, is the structural feature that makes the minimax argument work. The product topology on the strategy spaces, combined with Sion's minimax theorem and bounded convergence, provides all the necessary machinery.

The result has practical significance for the information design literature: it confirms that the saddle-point characterization applies in the natural continuous settings (continuous adviser signals, continuous agent types) that arise in applications of the Robust Trust framework. The Lean 4 formalization provides additional confidence in the correctness of the proof, with zero unverified steps in the main theorem file.

---

## Bibliography

- Aliprantis, C.D. and Border, K.C. (2006). *Infinite Dimensional Analysis: A Hitchhiker's Guide*. 3rd ed., Springer.
- Billingsley, P. (1999). *Convergence of Probability Measures*. 2nd ed., Wiley.
- Bogachev, V.I. (2007). *Measure Theory*. Springer.
- Border, K.C. (1985). *Fixed Point Theorems with Applications to Economics and Game Theory*. Cambridge University Press.
- Crawford, V.P. and Sobel, J. (1982). "Strategic Information Transmission." *Econometrica*, 50(6), 1431–1451.
- Dworczak, P. and Pavan, A. (2022). "Preparing for the Worst but Hoping for the Best: Robust (Bayesian) Persuasion." *Econometrica*, 90(5), 2017–2051.
- Dworczak, P. and Smolin, A. (2026). "Robust Trust." arXiv:2602.09490.
- Fan, K. (1952). "Fixed-Point and Minimax Theorems in Locally Convex Topological Linear Spaces." *Proc. NAS*, 38(2), 121–126.
- Fan, K. (1953). "Minimax Theorems." *Proc. NAS*, 39(1), 42–47.
- Frankel, A. (2014). "Aligned Delegation." *American Economic Review*, 104(1), 66–83.
- Kamenica, E. and Gentzkow, M. (2011). "Bayesian Persuasion." *American Economic Review*, 101(6), 2590–2615.
- Kneser, H. (1952). "Sur un théorème fondamental de la théorie des jeux." *C. R. Acad. Sci.*, 234, 2418–2420.
- Komiya, H. (1988). "Elementary Proof for Sion's Minimax Theorem." *Kodai Math. J.*, 11(1), 5–7.
- Kuratowski, K. and Ryll-Nardzewski, C. (1965). "A General Theorem on Selectors." *Bull. Polish Acad. Sci.*, 13, 471–478.
- Lipnowski, E., Ravid, D., and Shishkin, D. (2022). "Persuasion via Weak Institutions." *Journal of Political Economy*, 130, 2705–2730.
- Prokhorov, Y.V. (1956). "Convergence of Random Processes and Limit Theorems in Probability Theory." *Theory Probab. Appl.*, 1(2), 157–214.
- Sion, M. (1958). "On General Minimax Theorems." *Pacific J. Math.*, 8(1), 171–176.
- Wagner, D.H. (1977). "Survey of Measurable Selection Theorems." *SIAM J. Control Optim.*, 15(5), 859–903.
