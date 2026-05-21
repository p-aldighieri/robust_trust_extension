# Prover pass 12 — G1: Finite aligned-baseline cone-Hall theorem

## Role

You are the Prover. Searcher 05 surveyed seven attack vectors for the
unrestricted |Ω|≥3 case (beyond FBNF-7) and identified **Attack G:
Cone-valued Hall duality** as the top candidate — a genuinely new
finite Hall-type theorem with aligned baseline that the v8 Routes 1+2
did not try.

Prove the finite case (G1). If G1 PASSes, this is the gate-unlocking
theorem for unrestricted |Ω|≥3: it would let us either reopen WTA
ternary as primitively calibrable for specific $(\alpha, \tau)$, OR
exclude WTA by an explicit dual price certificate (rather than
merely by hypothesis class as FBNF-7 does).

## The theorem to prove

**Setup.** Let:
- $S = \{s_1, \ldots, s_I\}\subset\Delta(\Omega)$ — source posteriors with
  weights $\tau_i\ge 0$.
- $M_{\text{msg}} = \{m_1, \ldots, m_J\}\subset\Delta(\Omega)$ — messages,
  with aligned baseline mass $\alpha\tau_j^M\ge 0$ at message $m_j$.
- $R: \{1,\ldots,I\}\to 2^{\{1,\ldots,J\}}$ — rowwise-minimizer support
  correspondence (sources $i$ can route mass only to messages
  $j\in R(i)$).
- For each $j$, $B_j\subseteq\Delta(\Omega)$ a closed convex Bayes cone
  (the set of beliefs at which the agent's chosen action at message
  $m_j$ is Bayes-optimal).
- $\alpha\in(0,1)$.

**G1 (cone-Hall feasibility).** There exist nonneg flows $x_{ij}\ge 0$
such that:
1. **Support**: $x_{ij} = 0$ if $j\notin R(i)$.
2. **Source marginal**: $\sum_j x_{ij} = (1-\alpha)\tau_i$ for every $i$.
3. **Cone calibration**: for every $j$ with $q_j > 0$,
   \[
   \frac{n_j}{q_j}\in B_j, \quad
   n_j := \alpha\tau_j^M\,m_j + \sum_i x_{ij}\,s_i, \quad
   q_j := \alpha\tau_j^M + \sum_i x_{ij}.
   \]
**iff** the dual cone-Hall inequality holds:
\[
\forall (y_j)_{j=1}^J\subset\R^{|\Omega|},\quad
\alpha\sum_j\tau_j^M[y_j\cdot m_j - h_{B_j}(y_j)] + (1-\alpha)\sum_i\tau_i\,\min_{j\in R(i)}[y_j\cdot s_i - h_{B_j}(y_j)] \;\ge\; 0,
\]
where $h_{B_j}(y) := \sup_{\mu\in B_j}y\cdot\mu$ is the support function
of the cone $B_j$.

## Proof technique (your job to rigorize)

This is a Farkas-style theorem with cone-valued constraints. Standard
tools:

1. **Linearize the cone constraint**: $n_j/q_j\in B_j \Leftrightarrow \forall y_j, y_j\cdot n_j\le h_{B_j}(y_j)\cdot q_j$.

2. **Linear programming feasibility**: the flow problem is a finite
   LP in variables $x_{ij}\ge 0$, with linear constraints (support,
   source marginal, cone calibration written as the family of dual
   inequalities). Farkas' lemma / LP duality gives feasibility iff
   the dual certificate fails to certify infeasibility.

3. **Dual variables**: introduce dual prices $y_j\in\R^{|\Omega|}$ for
   each cone-calibration inequality. Write the LP-dual feasibility
   condition. The condition becomes the displayed cone-Hall inequality.

4. **Support functions**: $h_{B_j}(y_j)$ enters naturally as the optimal
   value of the cone-membership LP.

5. **min in dual**: the rowwise minimum $\min_{j\in R(i)}[\cdot]$ comes
   from the source-marginal constraint: for each source $i$, the dual
   constraint says the "row price" must be at least the minimum cost
   among allowed messages.

## What I want you to produce

A rigorous proof of the equivalence, structured as:

```
# G1 (Finite cone-Hall theorem)

## Statement (re-state precisely)

## Setup
(Define S, M, τ_i, τ_j^M, R, B_j, α.)

## Forward direction (feasibility ⇒ dual inequality)
Plug in any feasible flow {x_ij} and dual prices {y_j}; show the
dual sum is nonnegative.

## Backward direction (dual inequality ⇒ feasibility)
Use Farkas' lemma / LP duality / Fan's inequality on the appropriate
conic LP. Spell out the LP and its dual.

## Equivalent formulations
- support-function cone-Hall (as displayed).
- separation-of-flow-polytope-from-product-cone (alternative).
- finite Strassen-style coupling existence.

## WTA ternary as test case
For the v8 WTA ternary witness with τ uniform on Δ({0,1,2}), α=1/2,
$B_j = $ vertex Bayes cone, compute the dual inequality.
- If it holds: WTA is calibrable, contradicting v8 closure-memo's
  "no calibration" claim — surprise!
- If it fails: WTA is excluded by an explicit dual price certificate.

## Open issues
- Infinite-S extension: Borel S, Borel R, Borel B_j. The finite
  theorem extends via finite approximation + tightness?
- Cone-valued vs. set-valued: standard Hall handles set-valued; cone-
  valued is the new ingredient.
```

## Output Contract

- Inline markdown.
- Be precise about the LP and its dual. This is finite-dimensional;
  no Borel pathology.
- Test the dual on WTA ternary as the killer sanity check.
- End with verdict (PASS/PATCH/HOLD) + next-step signal:
  - If PASS + WTA dual holds → WTA reopens; pursue infinite extension.
  - If PASS + WTA dual fails → explicit dual certificate; pursue
    infinite extension and characterize the excluded class.

## Constraints

- Banned tools: see prior_attempts_digest.md.
- This is a finite theorem; use LP duality / Farkas / convex
  separation. No need for measure theory or sophisticated topology yet.
- Per user: keep going.
