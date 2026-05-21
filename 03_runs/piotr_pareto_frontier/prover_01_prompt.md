# Prover pass 01 — Lemma 6: Integral Clarke-Danskin representation

## Role

You are the Prover for a smart-scaffolding proof project. Your job in
this pass is to produce a **fully rigorous proof** of one lemma, sized
to be checked by a separate reviewer on a fresh chat.

The full lemma chain is in `breakdown_01_response.md` (durable session
artifact, also available inline below). The breakdown recommends
Lemma 6 as the first prover target. Stay focused on it.

## Setup (shared with the rest of the chain)

Standing assumptions (paper, durable source `Robust_trust_Dworczak_Smolin.pdf`):

- \(\Omega\) finite, \(|\Omega|=N\); full-support prior \(\mu_0\in\Delta(\Omega)\).
- \(M\subseteq\Delta(\Omega)\) Borel; \(\tau\in\Delta(M)\) is the unconditional
  law of the adviser's posterior \(s\), with \(M = \operatorname{supp}\tau\).
- \(A\) compact metric (action space); \(\Theta\) compact metric (private
  type); \(u:A\times\Omega\times\Theta\to\R\) bounded, continuous in \(a\);
  \(s,\theta\) conditionally independent given \(\omega\); \(\alpha\in[0,1]\).
- \(W := \{w\in\R^N : \exists\,\hat\sigma:\Theta\to\Delta(A)\text{ Borel},\;w(\omega)=\E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}\).
  By paper Lemma 2 (Theorem 1 proof, p. 27): \(W\) is **convex compact**
  in \(\R^N\), and \(W^P:=\{w\in W:\not\exists v\in W,\,v(\omega)>w(\omega)\,\forall\omega\}\)
  is its weak Pareto frontier (closed in \(W\); compact).

The finite-menu value functional is
\[
F_k(\bar w) \;:=\; \int_M\!\phi_s(\bar w)\,\tau(ds), \quad
\phi_s(\bar w) \;:=\; \alpha\max_i s\!\cdot w_i + (1-\alpha)\min_i s\!\cdot w_i,
\]
for \(\bar w=(w_1,\ldots,w_k)\in(\R^N)^k\) and \(k\ge 1\) fixed.

## Ambient lemmas (statements only; cite as needed without re-proving)

**L1 — Payoff-profile normal cone equals Bayes cone.** For \(w\in W\),
\(N_W(w)\cap\R^N_{\ge0}\cap\{\mu:\sum_\omega\mu(\omega)=1\} = B_W(w)\)
where \(B_W(w) := \{\mu\in\Delta(\Omega): w\in\arg\max_{v\in W}\mu\!\cdot v\}\).
**Proof source:** supporting hyperplane theorem + paper Lemma 2. May be assumed.

**L2 — Lipschitz & Pareto-monotone.** For each fixed \(s\in M\), the map
\(\phi_s:(\R^N)^k\to\R\) is \(\|s\|_\infty\)-Lipschitz (max+min of linear
maps in coordinates of \(\bar w\)); \(\phi_s\) is also monotone under
componentwise increase of any \(w_i\) (because \(s\in\Delta(\Omega)\) has
nonnegative coordinates). **Proof source:** elementary; may be assumed.

**L3 — Frontier-local maximality needs ambientization.** A local
maximizer of \(F_k\) over \((W^P)^k\) is also a local maximizer of
\(F_k\) over \(W^k\), under the additional Pareto-completion certificate
that no \(w_i\) can be replaced by a Pareto-dominator without leaving
the optimum. This follows from paper Lemma 2 (any improvement by
Pareto-dominator would weakly improve both terms of \(\phi_s\)). May
be assumed for this pass.

**L4 — Active faces and tie simplices are measurable.** For fixed
\(\bar w\in(\R^N)^k\), the correspondences
\(s\mapsto\arg\max_i s\!\cdot w_i\subseteq\{1,\ldots,k\}\) and
\(s\mapsto\arg\min_i s\!\cdot w_i\subseteq\{1,\ldots,k\}\) have Borel
graphs (finite-valued, defined by piecewise-linear inequalities in
\(s\)). The "tie set" \(T_+\) on which \(|\arg\max| \ge 2\) is Borel, and
similarly \(T_-\). Any active-face simplex correspondence
\(s\mapsto\Delta(\arg\max_i s\!\cdot w_i)\) (resp. \(\arg\min\)) is
Borel-measurable; measurable selections exist by Kuratowski-Ryll-Nardzewski.
May be assumed.

**L5 — Pointwise Clarke-Danskin active-weight representation.** For
fixed \(s\in M\), the Clarke subdifferential of
\(\phi_s:(\R^N)^k\to\R\) at \(\bar w\) is
\[
\partial_C\phi_s(\bar w) \;=\; \alpha\,\operatorname{co}\big\{e_i\otimes s : i\in\arg\max_j s\!\cdot w_j\big\}
\;+\; (1-\alpha)\,\operatorname{co}\big\{e_i\otimes s : i\in\arg\min_j s\!\cdot w_j\big\},
\]
where \(\operatorname{co}\) is the convex hull and \(e_i\otimes s\in(\R^N)^k\)
is zero in all components except the \(i\)-th, which equals \(s\).
Equivalently: every \(\xi\in\partial_C\phi_s(\bar w)\) admits
\(\lambda^+(s),\lambda^-(s)\in\Delta(k)\) (the \((k-1)\)-simplex) with
\(\operatorname{supp}\lambda^+(s)\subseteq\arg\max_j s\!\cdot w_j\),
\(\operatorname{supp}\lambda^-(s)\subseteq\arg\min_j s\!\cdot w_j\), and
\[
\xi_i \;=\; \alpha\,\lambda_i^+(s)\,s \;+\; (1-\alpha)\,\lambda_i^-(s)\,s.
\]
**Proof source:** Clarke (1983, Optimization and Nonsmooth Analysis,
Cor 2.8.6 chain rule for max-type functions); Danskin (1967) theorem.
May be assumed.

## The lemma to prove (Lemma 6)

**Lemma 6 — Integral Clarke-Danskin representation.**

Fix \(k\ge 1\) and \(\bar w = (w_1,\ldots,w_k)\in(\R^N)^k\). Let
\(F_k(\bar w) = \int_M\phi_s(\bar w)\,\tau(ds)\) as above. Then for every
Clarke subgradient
\[
g \;=\; (g_1,\ldots,g_k) \;\in\; \partial_C F_k(\bar w) \;\subseteq\; (\R^N)^k,
\]
there exist Borel measurable maps
\[
\lambda^+:M\to\Delta(k), \quad \lambda^-:M\to\Delta(k),
\]
such that for τ-a.e. \(s\in M\),
\[
\operatorname{supp}\lambda^+(s)\subseteq\arg\max_j s\!\cdot w_j, \quad
\operatorname{supp}\lambda^-(s)\subseteq\arg\min_j s\!\cdot w_j,
\]
and for every \(i\in\{1,\ldots,k\}\),
\[
g_i \;=\; \alpha\!\int_M\lambda_i^+(s)\,s\,\tau(ds) \;+\; (1-\alpha)\!\int_M\lambda_i^-(s)\,s\,\tau(ds).
\]

## Proof technique (sketch — your job is to make it fully rigorous)

The expected proof uses:

1. **Clarke's integral subdifferential interchange** (Clarke 1983 §2.7).
   For \(F_k(\bar w)=\int_M\phi_s(\bar w)\,\tau(ds)\) with \(\phi_s\)
   uniformly Lipschitz in \(\bar w\) (uniform constant \(\sup_{s\in M}\|s\|_\infty\le 1\)
   since \(s\in\Delta(\Omega)\)) and \(\phi_s(\bar w)\) Borel measurable
   in \(s\) for each \(\bar w\), one has the inclusion
   \[
   \partial_C F_k(\bar w) \;\subseteq\; \int_M\partial_C\phi_s(\bar w)\,\tau(ds),
   \]
   where the right-hand side is the **Aumann integral** of the set-valued
   correspondence \(s\mapsto\partial_C\phi_s(\bar w)\).
2. **Closedness of the Aumann integral** in finite dimension. Since
   \(\partial_C\phi_s(\bar w)\) is compact convex in \((\R^N)^k\) (a
   finite-dimensional space) and uniformly bounded (by Lipschitz),
   its Aumann integral is closed; the inclusion becomes an
   equality with measurable witnesses.
3. **Pointwise representation by L5.** For each \(s\), every element
   of \(\partial_C\phi_s(\bar w)\) is a convex combination of "active
   tile" vectors \(e_i\otimes s\) (the L5 statement).
4. **Measurable selection by L4 + Castaing representation.** Given
   the integral representation \(g\in\int\partial_C\phi_s\,d\tau\),
   write \(g\) as the integral of a measurable selector
   \(\xi(s)\in\partial_C\phi_s(\bar w)\) (KRN / Castaing). Then for
   each \(s\), choose Borel \(\lambda^\pm(s)\) decomposing \(\xi(s)\)
   per L5. Measurability of the decomposition follows from L4 plus
   continuous-in-\(s\) parametrization.

## What I want you to produce

Produce a **fully rigorous proof of Lemma 6**, in the following structure:

```
# Lemma 6 — Integral Clarke-Danskin representation

## Statement
(Restate exactly the lemma above.)

## Standing hypotheses used
(Ω finite, M Borel, τ probability measure on M, k≥1, w̄∈(R^N)^k.)

## Ambient lemmas cited
- L1 (cite as needed).
- L4 (active faces measurable; KRN selection).
- L5 (pointwise active-weight representation).

## Proof

### Step 1 — Clarke's integral subdifferential interchange
Statement of the theorem used (cite Clarke 1983 §2.7, Theorem 2.7.2 or
equivalent), with explicit verification of hypotheses:
- Borel measurability of (s, w̄) ↦ φ_s(w̄).
- Uniform local Lipschitz of w̄ ↦ φ_s(w̄), uniform constant w.r.t. s
  (use s ∈ Δ(Ω) ⇒ ‖s‖₁ = 1 ⇒ ‖s‖_∞ ≤ 1; the Lipschitz constant of
  ̄w ↦ φ_s(w̄) is ≤ ‖s‖_∞).
- τ being a finite Borel measure on M (compact metric Borel = standard
  Borel).

Conclude:
∂_C F_k(w̄) ⊆ ∫_M ∂_C φ_s(w̄) τ(ds).

### Step 2 — Closedness of the Aumann integral in finite dimension
State and verify: under uniform compactness of the integrand values
and a finite-dimensional ambient space, the Aumann integral is closed.
Cite Aumann (1965), Hildenbrand (1974), or Aubin-Frankowska (1990) §8.

In particular: ∫_M ∂_C φ_s(w̄) τ(ds) is closed (and convex), so the
inclusion in Step 1 holds with measurable witnesses g(s) ∈ ∂_C φ_s(w̄).

### Step 3 — Pointwise decomposition via L5
For each s ∈ M, decompose every ξ ∈ ∂_C φ_s(w̄) as α (e ⊗ s)(λ^+(s)) +
(1-α)(e ⊗ s)(λ^-(s)) with λ^±(s) ∈ Δ(k) supported on the active faces.

### Step 4 — Measurable selection of (λ^+, λ^-)
Given the measurable witness ξ(s) from Step 2, exhibit Borel maps
λ^±:M → Δ(k) realizing the decomposition. Use:
- L4 (active-face Borel correspondences).
- Castaing measurable selection theorem (Aliprantis-Border 18.13 / KRN).
- Standard tensor-decomposition argument: in coordinates,
  λ^+_i(s) is determined by ξ_i(s) and s up to choice within ties.
  When the active face is single-valued, λ^+_i(s) is the obvious
  Kronecker δ; on tie sets, use a measurable selection.

State the precise selection theorem invoked, and the precise
measurability of the resulting λ^±.

### Step 5 — Putting it together
Conclude g_i = α ∫_M λ_i^+(s) s τ(ds) + (1-α) ∫_M λ_i^-(s) s τ(ds) for
every i, by integrating the pointwise identity in Step 3 against τ.

## Sanity check (counterexample-resistant)
Verify the lemma on a small explicit example, e.g. k=2, N=2,
w_1 = (1,0), w_2 = (0,1), τ uniform on the relative interior of Δ({0,1}).
Compute λ^± and g_i and verify they match the integral formula.

## Open issues left for downstream lemmas
- Lemma 6 does NOT establish g_i ∈ N_W(w_i). That is Lemma 7 (Fermat).
- Lemma 6 does NOT establish posterior calibration. That is Lemma 9
  (normalization) + L10 + L11.
```

## Output contract

- Return everything inline in this chat as plain markdown.
- Stick to the section ordering above.
- Be rigorous about measurability — name every selection theorem you
  use and verify its hypotheses explicitly. Reviewers will check.
- The Castaing representation step is the most error-prone — handle
  the tie set explicitly. If λ^+(s) is non-unique on the tie set
  (because the active argmax has \(\ge 2\) elements), exhibit a
  measurable selection from \(\Delta(\text{active})\) and verify
  Borel measurability.
- Do not assume atomless τ. Do not assume genericity (no ties).
- Do not appeal to envelope-theorem language — this is a Clarke-Danskin
  argument, not a smooth envelope.

## Constraints

- **Banned re-proposals** (see `prior_attempts_digest.md`): no product-of-narrow
  Sion, no τ-AC restriction, no FOC + envelope, no canonical-pruning,
  no ε-menu-Hall as primary, no axiomatized Lean GameSetup.
- **Soft scaffolding**: do NOT prove Lemma 7 or beyond in this pass.
  Stay focused on Lemma 6. If you find a gap in L4 or L5 that you
  cannot work around, flag it and stop — the orchestrator will route
  a remediation pass.

## End-of-response signal

After the proof, write a one-paragraph **next-step signal** stating
whether you believe the proof is reviewer-ready, what the most
fragile step is, and what Lemma the next prover pass should attack.
