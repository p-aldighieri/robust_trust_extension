# Formalizer pass — Route 2 calibration-defect target theorem

You are the **Formalizer**. The Route 2 literature pass returned BUILD with multi-pass strategy and named ingredients. Your job: pin down the precise candidate statement of the calibration-defect theorem in primitive terms. Apply the renaming test up front. Surface the tautological-vs-aggressive risk that the literature flagged.

## State going into Route 2

Route 1 closed at honest stall: (H_del) is too weak to generate an LP contradiction (pointwise-strict ≠ uniform). Route 2 reframes from "find a kernel" to "quantify the gap."

**The shape of the target theorem (per the gatekeeper + literature):**

> **Calibration-defect theorem (target).** Define a primitive defect functional $\Delta_\text{del}(C^*, w^*)$ measuring "improvement detectable by sourcewise compact-patch deletions and primitive payoff-profile replacements." Then:
> $$\text{Best-attainable distributional Bayes-regret}(C^*, w^*) \le \Phi(\Delta_\text{del}(C^*, w^*)).$$
> Furthermore $\Delta_\text{del} = 0 \Leftrightarrow$ exact Tier 2 (full robust rationalizability) holds.

**Two crucial features:**
- **Quantitative:** the bound is a real-valued function of a real-valued defect; if Δ_del > 0, you get a positive regret bound, not a contradiction.
- **Primitive:** the defect uses only $F$, $w^*$, $\tau$, $\alpha$, compact source patches.

## Tautological-vs-aggressive risk

The literature warned: *"Unless Δ_del genuinely prices the sourcewise deletion versus messagewise calibration mismatch, the theorem will either be false or tautological."*

**Tautological end:** If Δ_del is defined as "the actual Bayes-regret achievable by the best κ", the theorem becomes regret ≤ regret, vacuous.

**Aggressive end:** If Δ_del is defined as "deletion-only improvement" with no sourcewise/messagewise mismatch handling, the theorem may bound regret by a quantity that doesn't actually capture calibration failure — the theorem is false or only true with massive slack.

**The right Δ_del must:**
- Be computable from the labeled menu primitive data (passes renaming test).
- Capture the sourcewise/messagewise mismatch genuinely (not tautologically).
- Have $\Delta_\text{del} = 0$ when calibration is feasible (so it recovers exact Tier 2 in the limit).

## Your task

Produce a precise candidate statement of the calibration-defect theorem with explicit definitions and quantifiers. Audit it against the renaming test. Surface every ambiguity.

### Step 1 — Candidate Δ_del (precise definition)

Propose **one or two** candidate definitions of $\Delta_\text{del}(C^*, w^*)$. Natural starting points:

**(D1) Deletion-improvement defect.** Sup over compact-source-patch deletions of how much $F$ can be raised (or stayed at) by deletion plus replacement:
$$\Delta_\text{del}^{(1)} := \sup\{F(D_E) - F(C^*) + (\text{replacement gain}) : E \in \mathcal B(M),\,\tau(E)>0\},$$
clipped at zero. (Specify "replacement gain" precisely — it should price what's lost by deletion against what's gained by relabeling on the deleted patch.)

**(D2) Worst sourcewise gap.** Sup over $s$ and $v \in W$ of how much $s\cdot(v - w^*(s))$ can exceed the menu-engine optimum, integrated over $\tau$ with appropriate weights.

**(D3) Hall residual.** The minimum violation of menu-Hall over admissible κ, expressed as a primitive integral. Be careful: this might be tautological.

For each candidate:
- Write the precise definition with quantifiers.
- Apply the renaming test.
- State whether the candidate is at risk of being tautological (defined via the conclusion) or aggressive (omits a piece of the mismatch).

### Step 2 — Candidate Φ (precise)

Propose the bound function $\Phi: [0, \infty) \to [0, \infty)$ that converts defect to regret. Natural shapes:
- **Linear:** $\Phi(\delta) = K\delta$ for some constant $K = K(W, \tau, \alpha)$.
- **Hölder:** $\Phi(\delta) = K\delta^p$ for some $p \in (0, 1]$.
- **Piecewise:** $\Phi$ vanishes for $\delta = 0$ but linear above.

For each shape, identify what hypotheses on $u$, $\tau$, $W$ would make it work.

### Step 3 — "Distributional Bayes-regret" precise definition

What is the LHS of the inequality? Natural candidates:
- $\inf_\kappa \int |P_{\gamma_\alpha}(\cdot \mid m) - \pi_{B(m)}|\,q(dm)$ where $\pi_{B(m)}$ is the closest point in $B(m)$.
- $\inf_\kappa \mathbb E_{m \sim q}\,\mathrm{dist}(P_{\gamma_\alpha}(\cdot \mid m), B(m))$.
- A regret in agent payoff: $U(\sigma^*) - \sup_\kappa \int U(\hat\sigma_{B(m)}, P_{\gamma_\alpha}(\cdot|m))\,q(dm)$ where $\hat\sigma_{B(m)}$ is the agent's best response under each posterior.

Pin down exactly which one is the target and why. Verify it is primitive (renaming test).

### Step 4 — The biconditional Δ_del = 0 ⇔ exact Tier 2

The target says: $\Delta_\text{del} = 0$ recovers exact Tier 2.

Is this tautologically true (because of how Δ_del was defined) or substantive (because it requires a non-trivial duality)?

If tautological: that's a problem — the theorem is then vacuous in this direction.

If substantive: state precisely what the biconditional asserts and what would need to be proved. The forward direction (exact Tier 2 ⇒ Δ_del = 0) is usually easy. The reverse (Δ_del = 0 ⇒ exact Tier 2) is the substantive content.

### Step 5 — Renaming-test audit

Review your candidate Δ_del, Φ, and Bayes-regret definitions:
- Does any reference $G(s)$, $\kappa$, $\gamma$, $P_\gamma$, $B(m)$, $h_{B(m)}$, or any analog?
- The Bayes-regret LHS is allowed to reference the Bayes cone $B(m)$ (it's the conclusion). But Δ_del must NOT.

### Step 6 — Surfaced ambiguities

Address:
1. **Behavioral minimality:** is Δ_del defined for all labeled menus, or only for behaviorally minimal ones (closure-pruning $C^* = \overline{w^*(M)}$ )?
2. **Continuum-mass label fibers:** does Δ_del's definition require $\tau(L_u) > 0$ for sampled labels, or does it work for atomless / continuum labelings?
3. **Borel→compact gap:** does Δ_del's deletion-improvement formulation hit the same Borel→compact issue as Route 1, or does it explicitly handle it?
4. **(H_del) connection:** is (H_del) implied by Δ_del < ∞? By Δ_del finite? Is (H_del) needed at all?

### Step 7 — Output candidate target

Produce the candidate theorem in clean form, with all definitions, quantifiers, and explicit hypothesis/conclusion split.

## What you MUST NOT do

- Do not propose proofs.
- Do not let Δ_del implicitly assume the existence of a calibrated kernel.
- Do not silently strengthen to (H_del), (H_C1), or any earlier Route 1 hypothesis.
- Do not conflate "regret in agent payoff" with "regret in posterior alignment" — they're different.

## Output Format

```markdown
## Plain-Language Reading

(One paragraph: what the target theorem says.)

## Formal Candidate Statement

**Setting:** ...
**Side definitions:** ...

**Theorem (calibration-defect, candidate).**
Under (...), Best-attainable distributional Bayes-regret ≤ Φ(Δ_del).

## Δ_del Candidates (Step 1)

- (D1) ... [renaming test, tautological/aggressive risk]
- (D2) ...
- (D3) ...

## Φ Candidates (Step 2)

- Linear: ...
- Hölder: ...
- Piecewise: ...

## Distributional Bayes-Regret (Step 3)

(Precise definition, renaming test.)

## The Biconditional Δ_del = 0 ⇔ Exact Tier 2 (Step 4)

(Tautological or substantive? What needs to be proved?)

## Renaming Test Audit (Step 5)

(Step-by-step.)

## Surfaced Ambiguities (Step 6)

(Numbered list with the question, why it matters, alternative readings.)

## What This Theorem Would Buy Us

(One paragraph. Is this a publishable conditional theorem? Does it interpolate between v8 and unrestricted Theorem 2? When is the bound tight, when is it loose?)
```

Length: 1500–2200 words.
