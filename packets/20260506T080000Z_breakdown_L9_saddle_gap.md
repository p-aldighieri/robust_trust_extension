# Breakdown pass — Closing the L9 saddle gap

You are the Breakdown role for the soft-scaffolding workflow.

## Context

The Branch B final consolidator review caught a real gap in L9
(`logs/20260506T073000Z_rereview_branch_B_consolidator_response.md`).

**The gap:** Branch A + L8 deliver:
- $\sigma^* \in \arg\max_\sigma\inf_\beta U(\beta,\sigma)$ (maximin).
- $U(\beta^*, \sigma^*) = \inf_\beta U(\beta, \sigma^*) = U^*$ (β* rowwise
  adversarial against σ*).

L9's standard contradiction argument silently invokes the **upper
saddle inequality**
$$
U(\beta^*, \sigma) \le U(\beta^*, \sigma^*) \quad \forall \sigma,
$$
i.e., σ* is a best response to β*. **This does NOT follow from Branch
A + L8** in general: a minimum against a maximin strategy need not be
a minimax strategy. Without the upper saddle, an improving deviation
$\hat\sigma'$ on a positive-q-measure set $E$ doesn't contradict
anything: it improves $U(\beta^*, \cdot)$ but $\sigma^*$ wasn't claimed
optimal against β*.

This pass evaluates three candidate fixes and picks the next prover
target.

## Inputs

- `phil_reny_route_memo.md`, `phil_reny_bundle.md`,
  `prior_attempts_digest.md`, paper PDF.
- L9 logs and reviewer logs.
- `theorem_2_extension_proof.md` (final consolidator output).

## Three candidate fixes

### Fix A: Strengthen L8 to a minimax β*

Construct $\beta^*$ that is **both** rowwise adversarial against σ*
AND the agent-side maximizer's value coincides:
$\sup_\sigma U(\beta^*, \sigma) = U^*$.

This makes $(\sigma^*, \beta^*)$ a true saddle and L9's contradiction
goes through directly.

**Honest evaluation:** Sion-style approaches (which would deliver this)
were ruled out in `prior_attempts_digest.md`. Mertens Cor B's RHS gives
$\inf_\varphi \max_\sigma U_F(\sigma, \varphi)$ over **finite-support
mixtures** of $F$; via affineness this collapses to $\inf_\varphi$ over
$F$, and the $\inf$ may not be attained (L8a's verdict). Without
attainment of an $F$-side or $B$-side dual minimizer that's also
minimax, this fix is structurally hard.

**Question for the breakdown:** Can L8c's selector $\beta^* = \delta_{m^*(s)}$
be **augmented** or **regularized** into a minimax adversary, e.g.,
by taking a convex combination with an aligned strategy or by
building a saddle structure on the level set?

### Fix B: Replace σ* with a Bayes-optimal σ** under P_β*

Define
$$
\hat\sigma^{**}(m) := \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))
$$
for τ-a.e. m (existence by KRN under standing hypotheses; A compact metric).

**Honest evaluation:** σ** is Bayes-optimal under P_β* by construction.
The question is whether σ** still secures U*:
- $U(\beta^*, \sigma^{**}) \ge U(\beta^*, \sigma^*) = U^*$ (pointwise
  per message + integration).
- $U(\sigma^{**}) = \alpha\,\text{aligned}(\sigma^{**}) + (1-\alpha)\,\inf_\beta E_{\beta,\sigma^{**}}[u]$.
- We need $U(\sigma^{**}) \ge U^*$.
- The aligned part $\text{aligned}(\sigma^{**})$ may differ from
  $\text{aligned}(\sigma^*)$. The misaligned $\inf_\beta$ may also
  differ.
- **Risk:** σ** is constructed to maximize against β*, not against
  the aligned + worst-case mixture. It may UNDER-secure $U^*$ if it
  sacrifices aligned-side performance.

**Question for the breakdown:** Is there an argument that σ** can be
chosen to preserve the maximin value? E.g., by restricting σ** to
agree with σ* off the failure set $E$.

### Fix C: Different per-message argument bypassing upper saddle

Instead of invoking saddle, argue per-message Bayes-optimality from
the structure of L8c's construction directly:
- $\beta^* = \delta_{m^*(s)}$ where $m^*(s) \in \arg\min_m \ell_{\sigma^*}(m,s)$.
- $\ell_{\sigma^*}(m,s)$ is constructed FROM σ*'s message payoffs.
- Hence the posterior $P_{\beta^*}(\cdot\mid m)$ at any "active" message
  $m$ in the image of $m^*$ has a specific structure that may force
  Bayes-optimality of $\hat\sigma^*(m)$ at that m.

**Honest evaluation:** The active messages under β* form a set
$M^* := \{m^*(s) : s\in M\}$ which is τ-null in general (the pushforward
$(m^*)_\#\tau$ may be supported on a thin set). For $m\in M^*$, the
posterior $P_{\beta^*}(\cdot\mid m)$ is determined by which $s$
satisfy $m^*(s) = m$. Definition 2 needs Bayes-optimality at every (or
τ-a.e.) on-path m, including aligned-only messages where
$P_{\beta^*}(\cdot\mid m) = m$ (the truthful posterior).

**Question for the breakdown:** Can we separate aligned-only messages
(where Bayes-optimality is trivial since the posterior IS the message)
from misaligned messages (where σ* may need to match a specific
target)? At aligned messages, σ* is automatically Bayes-optimal under
P_β*(·|m) = m (truthful posterior) IF σ* was already chosen as the
aligned-Bayes-optimal at every m, which is a separate property.

## What you must produce

A markdown deliverable with **exactly** the following sections:

```markdown
## 1. The exact gap precisely

(One paragraph stating the gap. Include the full chain: what L9 needs,
what Branch A + L8 give, where the upper saddle should appear.)

## 2. Evaluate each fix honestly

### 2a. Fix A — strengthen L8 to minimax β*
(Diagnose. Is the L8c selector or some augmentation actually minimax?
What additional structure is needed?)

### 2b. Fix B — replace σ* with Bayes-optimal σ** under P_β*
(Diagnose. Does σ** still secure U*? What's the cleanest argument?
Is there a "splice" σ_E that agrees with σ* outside the failure set
and is Bayes-optimal on E?)

### 2c. Fix C — per-message argument bypassing upper saddle
(Diagnose. Can the structure of m*(s) and the aligned/misaligned
decomposition give Bayes-optimality directly without saddle?)

## 3. Ranked recommendation

(Pick the most viable. Identify the next prover target as a single
focused lemma.)

## 4. Risk: theorem may need to be weakened

(If none of A/B/C close the gap cleanly, the published theorem must
state only Branch A + L8 attainment, dropping the Definition 2
robust-rationalizability conclusion. State this honestly as the
fallback.)
```

## Discipline

- Use paper-canonical notation.
- Cite Aliprantis-Border, Bogachev where relevant.
- Length budget: 1500–2500 words.
- This is a planning pass. No proofs in detail.
