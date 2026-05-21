# Prover pass 14 — G3: Robust Trust Theorem 2 biconditional via G2c

## Role

You are the Prover. **G1 and G2c are proved + reviewer-verified
(reviewer 11 PASS; reviewer 12 in flight)**. Apply these to **Robust
Trust** to derive the Theorem 2 biconditional characterization.

## The theorem to prove (G3)

**Theorem (Robust Trust Theorem 2 — Hall biconditional, |Ω|≥3, full
general case).** Under the standing hypotheses of *Robust Trust* with
$|\Omega|\ge 3$, $\alpha\in(0,1)$, arbitrary measurable $M$ (which is
automatically compact as a closed subset of $\Delta(\Omega)$), arbitrary
compact metric $\Theta$, the following are equivalent:

(a) **Theorem 2 holds**: there exists a robustly rationalizable optimal
strategy $\sigma^*\in\Sigma$, i.e., $\sigma^*$ attains $U^*$ and there
exists $\beta^*\in B$ with $U(\beta^*, \sigma^*) = U^*$ and
$\hat\sigma^*(m)$ Bayes-optimal under $P_{\beta^*}(\cdot|m)$ for q-a.e.
m.

(b) **Cone-Hall dual inequality**: for the optimal labeling
$w^*: M \to W^P$ (Bayes-optimal Pareto-frontier selection), with
$B(m) := B_W(w^*(m)) = N_W(w^*(m))\cap\Delta(\Omega)$ and rowwise
minimizer correspondence $R(s) := \{m\in M : s\cdot w^*(m) = \min_{z\in C^*} s\cdot z\}$,
the inequality
\[
\Psi(y) := \alpha\!\int_M[y(m)\cdot m - h_{B(m)}(y(m))]\,\tau(dm) + (1-\alpha)\!\int_M\inf_{m'\in R(s)}[y(m')\cdot s - h_{B(m')}(y(m'))]\,\tau(ds) \le 0
\]
for every bounded Borel $y: M \to \R^{|\Omega|}$.

(Note: the aligned baseline measure in G2c is $\mu_M = \tau$ for the
Robust Trust setup, since the aligned adviser sends $m = s$ truthfully.)

## Proof structure

### Step 1 — Set up Robust Trust as G2c instance
- $S = M = \operatorname{supp}\tau \subseteq \Delta(\Omega)$, which is COMPACT (closed
  subset of compact simplex).
- $\mu_M = \tau$, $\alpha$ as given.
- $R(s) = $ rowwise minimizers of $w^*$ at source $s$ (Borel correspondence
  by Borel measurability of $w^*$).
- $B(m) = B_W(w^*(m)) \cap \Delta(\Omega) = N_W(w^*(m)) \cap \Delta(\Omega)$,
  the Bayes cone (Borel correspondence).

### Step 2 — (a) ⇒ (b): primal feasibility implies dual ≤ 0
If $\beta^* \in B$ exists with the Definition-2 properties, then it
gives a Borel kernel $\kappa: S \to \Delta(M)$ with the right
properties. G2c's (⇒) direction gives $\Psi(y) \le 0$ for every $y$.

### Step 3 — (b) ⇒ (a): dual ≤ 0 implies primal feasibility
If $\Psi(y) \le 0$ for every Borel $y$, then by G2c there exists a
Borel kernel $\kappa: M \to \Delta(M)$ with the right properties.
Translate $\kappa$ into a Robust Trust adversary kernel $\beta^* \in B$
(direct: $\beta^*(\cdot|s) := \kappa(\cdot|s)$). Apply Definition 2 to
verify the agent's TRS continuation $\hat\sigma^*(m) := R(w^*(m))$ is
Bayes-optimal under $P_{\beta^*}(\cdot|m)$ for q-a.e. m, by Bayes cone
membership of the posterior.

### Step 4 — Optimality
For the agent: $U(\sigma^*) = U^*$ follows from v8 Tier 1a (value
optimality unconditional). With $\beta^*$ from Step 3 giving the
attainer, $\sigma^*$ is also a maximizer in the original game.

### Step 5 — Verify Definition 2 reading
The conclusion is q-a.e., not literal-all. Verify q is the appropriate
infinite-space mixture marginal.

## Coverage of v8 closure memo

The closure memo names the deletion-compatible Hall duality theorem
as the single open object:

> Take an optimal compact menu/labeling pair (C*, w*), a rowwise-
> minimizer correspondence G(s), and Bayes-optimality cones B(m).
> Give NECESSARY AND SUFFICIENT CONDITIONS IN PRIMITIVE TERMS under
> which there exists a Borel kernel κ supported on G(s) τ-a.e. such
> that the induced posterior lies in B(m) for q-a.e. m.

G3 IS this theorem. The "necessary and sufficient conditions in
primitive terms" are the cone-Hall dual inequality $\Psi(y) \le 0$
for all bounded Borel $y$. This is a CHECKABLE characterization in
terms of primitives $(\tau, w^*, \alpha)$ + the Borel/topological
data on $\Delta(\Omega)$.

## What I want

A rigorous proof of G3, in the structure:

```
# Theorem (Robust Trust Theorem 2 biconditional via cone-Hall)

## Statement
(a) Theorem 2 existence ⟺ (b) Cone-Hall dual inequality

## Hypotheses
- Standing.
- |Ω| ≥ 3.
- α ∈ (0,1).
- M, Θ measurable (M automatically compact).

## Proof
### Step 1 — Robust Trust as G2c instance
### Step 2 — Primal ⇒ dual (a ⇒ b)
### Step 3 — Dual ⇒ primal (b ⇒ a)
### Step 4 — Optimality
### Step 5 — q-a.e. reading

## Compatibility with v8 closure memo
This is the deletion-compatible Hall duality theorem proved.

## Compatibility with sharpness package
The v8 WTA ternary witness fails Ψ(y) ≤ 0 (Ψ(y) = 2/9 by G1
computation, transferred to G2c). So Theorem 2 fails for WTA uniform.

With positive aligned baseline (threshold D ≥ 2(1-α)/(9α)), Ψ(y) ≤ 0,
and Theorem 2 holds.

## Implications
- Theorem 2 is now characterizable by a checkable inequality.
- Sufficient primitive conditions for Theorem 2 are sufficient
  conditions for $\Psi(y) \le 0$.
- Necessary obstacle conditions for Theorem 2 are explicit dual
  prices y with Ψ(y) > 0.

## Open
- Primitive sufficient conditions for Ψ(y) ≤ 0 (when does the dual
  inequality hold easily?).
- Conjecture: for "smooth" models (smooth utility, atomless τ with
  full support, smooth W^P), the dual inequality holds — give a
  precise theorem.
```

## Output Contract

- Inline markdown.
- Be rigorous about Step 2 (a ⇒ b) and Step 3 (b ⇒ a). These are the
  biconditional directions.
- End with verdict + next-step.

## Constraints

- Banned tools list applies.
- v9 T1, FBNF capstone, binary capstone, G1, G2c may be cited.
- Per user: relentless. If G3 closes, push further to identify
  primitive sufficient conditions for $\Psi(y) \le 0$.
