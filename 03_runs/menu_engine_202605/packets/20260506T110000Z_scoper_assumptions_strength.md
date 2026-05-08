# Scoper pass — strength and economic plausibility of the three added assumptions

You are advising on the **scope** of the Theorem 2 conditional extension.
The proof landed (see `theorem_2_extension_proof.md`) under standing
hypotheses plus three added assumptions:

- **(A5) Common posterior null sets:** $\pi(\cdot\mid\omega)\sim\tau$ for
  every $\omega\in\Omega$.
- **(A8c-lsc) Rowwise lower semicontinuity:** for the Branch-A
  maximizer's value-preserving representative, $m\mapsto\ell_{\sigma^*}(m,s) = \sum_\omega s(\omega)p_\omega(m)$
  is l.s.c. on $M$ for τ-a.e. $s$.
- **(A9c-calib) Calibrated worst-message transport:** existence of a
  posterior-calibrated coupling $\gamma_\alpha$ on $M\times M$ (the
  formal expression that "the paper's TRE/Appendix A.6 quantile
  transport generalizes").

This is **not** a proof pass. It is a **scoping pass**. For each
assumption, I want an honest evaluation of:
1. **Mathematical strength** — what does it require, and is it tight?
2. **Economic interpretation** — what does it mean for the model? In
   what economic settings is it natural vs. restrictive?
3. **Scope of the extension** — which class of models in the
   information-design / cheap-talk / robust-persuasion literature does
   it cover? Which models are excluded?
4. **Compared to the paper's standing assumptions** — is it a "free"
   regularity assumption (free in the sense of being almost always
   true in applications) or a substantive restriction?

Then **rank** the three assumptions from least to most restrictive,
with explicit reasoning.

## Inputs (durable sources)

- `theorem_2_extension_proof.md` — the landed proof.
- `phil_reny_route_memo.md` — live route memo with all PROVED statuses
  and counterexamples.
- `phil_reny_bundle.md` — Phil Reny's contribution.
- `prior_attempts_digest.md` — what the dead routes were.
- `Robust_trust_Dworczak_Smolin.pdf` — the paper, especially Sections 3
  (model, Theorem 2), 4 (binary quadratic example, Theorem 1 / TRE),
  and Appendix A.6 (quantile transport).

## What you must produce

A markdown deliverable in the response body, with **exactly** these
sections:

```markdown
## 1. (A5) Common posterior null sets

**Statement.** $\pi(\cdot\mid\omega)\sim\tau$ for every $\omega$.

### 1a. Mathematical strength
(How strong is this technically? What's the gap between (A5) and
weaker variants like "$\tau\ll\pi(\cdot\mid\omega)$ for SOME $\omega$"?
Is (A5) tight for L5? Is there a weaker condition that would still
give Lusin-thick compacts?)

### 1b. Economic interpretation
(What does (A5) mean for the signal structure $\pi$? When is it
natural? Specifically:
- (A5) is automatic for any signal structure with strictly positive
  density against a common reference.
- (A5) FAILS for perfect-revelation signals (each $\omega$ produces a
  unique posterior with no overlap with other states).
- (A5) FAILS for partition signals (each posterior is supported on a
  state-dependent subset).
Identify the economic class of signal structures (A5) excludes.)

### 1c. Scope
(Which standard information-design models satisfy/violate (A5)?
Examples:
- Bayesian persuasion (Kamenica-Gentzkow): typically satisfies (A5)
  if the sender's experiment has full-support marginals.
- Strategic info transmission (Crawford-Sobel): partition equilibria
  violate (A5).
- Robust persuasion (Dworczak-Pavan): the uncertainty set may include
  partition-violating signals.
Be honest about which strands are excluded.)

### 1d. Comparison to standing hypotheses
(Is (A5) "free" (almost always true in applications) or "substantive"?)

## 2. (A8c-lsc) Rowwise lower semicontinuity

**Statement.** $m\mapsto\ell_{\sigma^*}(m,s)$ l.s.c. on $M$ for τ-a.e. $s$.

### 2a. Mathematical strength
(How strong is l.s.c. of $\ell_{\sigma^*}$? Is this a property of the
PRIMITIVES — $u$, $f$, $\pi$ — or only of the optimal strategy
$\sigma^*$? Specifically:
- $\ell$ depends on $\sigma^*$ via $p_\omega(m) = \int u\,\sigma^*(da\mid m,\theta)\,f(d\theta\mid\omega)$.
- L.s.c. of $\ell$ in $m$ requires the kernel $\sigma^*(\cdot\mid m,\cdot)$
  to be "well-behaved" in $m$.
- This is a property of the equilibrium representative, not the model
  primitives.
What primitive conditions force (A8c-lsc)? E.g., "agent's optimal
action is upper-hemicontinuous in $m$", or "the trust region is closed".)

### 2b. Economic interpretation
(What does (A8c-lsc) mean economically? It says the agent's optimal
strategy doesn't have "upward jumps in payoff exposure" at τ-null
boundaries — the worst the adversary can do at any $m$ is at least the
nearby worst. Discuss connection to TRE: in the paper's TRE, the
strategy outside the trust region is the "closest safe action" at the
boundary, which is naturally l.s.c. — so (A8c-lsc) is essentially
"$\sigma^*$ has TRE-like structure or is well-behaved at boundaries".)

### 2c. Scope
(Which models naturally satisfy (A8c-lsc)?
- TRE-style strategies (paper's Theorem 1): yes, by construction.
- Continuous best-response models: typically yes.
- Discontinuous-best-response models: not necessarily.
Be specific.)

### 2d. Comparison to standing hypotheses
(The standing hypothesis on $u$ is "continuous in $a$, bounded".
(A8c-lsc) adds a continuity/regularity requirement on the BEST RESPONSE
in $m$, which is one level deeper. Is this free or substantive?)

## 3. (A9c-calib) Calibrated worst-message transport

**Statement.** ∃ coupling $\gamma_\alpha = \alpha(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\gamma$
on $M\times M$ with $\gamma$ first-marginal-τ, support in $\{(s,m): m\in D(s)\}$,
posterior calibration $P_{\gamma_\alpha}(\cdot\mid m)\in C(m)$ q-a.e.

### 3a. Mathematical strength
(How strong is (A9c-calib)? It's a Hall/Strassen-type transport
feasibility condition. Compare:
- The paper's binary-quadratic case (Appendix A.6) verifies it via
  quantile transport. This is essentially the **strongest** model where
  (A9c-calib) is provable from primitives.
- General-Ω, general-payoff: (A9c-calib) is NOT free. It's an
  implicit "TRE generalizes" assumption.
Identify the gap between "trust-region structure of $\sigma^*$" and
(A9c-calib). Is there a substantive class where one holds without
the other?)

### 3b. Economic interpretation
(What does (A9c-calib) mean? It's the requirement that the misaligned
adversary can be "talked into" a Bayes-rationalizing posterior at every
on-path message. This is the heart of robust rationalizability. In the
finite case, Sion's theorem provides this for free; in the infinite
case, it must be IMPOSED.)

### 3c. Scope
(Which models satisfy (A9c-calib)?
- Paper's binary-quadratic + TRE: yes.
- Models where $\sigma^*$ has the trust-region/clipped-action structure
  with sufficient regularity: yes.
- Models where the optimal $\sigma^*$ is qualitatively different from
  TRE (e.g., randomized over multiple "branches"): unclear.
Be honest about the unknown territory.)

### 3d. Comparison to standing hypotheses
(This is the substantively strongest of the three added assumptions.
It substitutes for the upper saddle inequality that Sion gives for free
in the finite case. State this clearly.)

## 4. Comparison and ranking

(Rank from **least restrictive (mildest)** to **most restrictive
(strongest)**. Justify the ranking with explicit reasoning. Identify
which assumption(s) are most plausible to relax in a future research
cycle.)

## 5. Recommendation for the relaxation cycle

(For each assumption, identify one concrete relaxation candidate:
- For (A5): is there a weaker "approximate equivalence" or "support
  thickness on a generic set" that suffices for L5?
- For (A8c-lsc): can we exhibit conditions on the primitives that
  force l.s.c. of $\ell_{\sigma^*}$? Or relax to "l.s.c. except at a
  τ-null set" (which is automatic anyway)?
- For (A9c-calib): is there a structural condition on $\sigma^*$ (e.g.,
  trust-region) that makes calibration automatic?)
```

## Discipline

- Use paper-canonical notation.
- Cite Dworczak–Smolin sections explicitly when referencing the paper's
  TRE / Theorem 1 / Section 4 / Appendix A.6.
- Be concrete about model classes: don't write "for some models";
  name them.
- Honest opinion encouraged. If an assumption is essentially "free in
  applications" say so; if it's a real restriction, say that too.
- Length budget: 2000–3000 words.

## Scope Policy

This is a scoping/strategy pass. Do NOT prove anything. The output is
an honest critical assessment that will inform the next set of
prover/reviewer cycles attempting to relax the strongest assumption(s).
