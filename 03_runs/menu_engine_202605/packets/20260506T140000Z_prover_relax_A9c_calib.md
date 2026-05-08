# Prover pass — Relax (A9c-calib) via TRE-to-calibration structural theorem

You are the Prover in the soft-scaffolding workflow.

## Goal

Per the scoper recommendation, attempt to relax **(A9c-calib)** —
the calibrated worst-message coupling — by deriving it from a
**structural condition on $\sigma^*$** (specifically, a generalized
trust-region structure).

The scoper's candidate:

> *If $\sigma^*$ is a closed trust-region strategy with single-valued
> continuous Bregman projection, $\tau$ is atomless with full support,
> and the worst-message correspondence has monotone or ray-like fibers
> satisfying Hall-type mass inequalities, then a calibrated $\gamma_\alpha$
> exists.*

This generalizes the paper's **Appendix A.6 binary quadratic quantile
transport** to higher-dimensional state spaces. The binary case is
1-dimensional; the question is whether the same monotone-rearrangement
machinery works for general finite $\Omega$.

## Inputs

- `theorem_2_extension_proof.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF
  (especially Section 4 / Theorem 1 trust-region characterization,
  Section 5 / "TRE", Appendix A.6 quantile transport).
- L9b logs and reviewer notes.
- Scoper output recommendation #5 for (A9c-calib).

## Targets

### Target 1: Define a generalized TRE structure

For finite $\Omega$ with $|\Omega| \ge 2$:

**(TRE-gen).** $\sigma^*$ is a **trust-region strategy** in the
following sense:
- There exists a closed convex set $T\subseteq\Delta(\Omega)$ (the
  trust region).
- A continuous projection $P_T: \Delta(\Omega) \to T$ (e.g., Bregman
  projection w.r.t. the relative entropy, or the Euclidean projection
  on the simplex with the natural metric).
- $\hat\sigma^*(m) = $ Bayes-optimal action(s) at $P_T(m)$ for every
  $m\in M$.
- The worst-message map $m^*(s) := \arg\min_m\ell_{\sigma^*}(m,s)$ is
  single-valued for τ-a.e. $s$ AND **monotone** (in some appropriate
  partial order on $M$ inherited from the simplex structure).

State (TRE-gen) precisely. Verify it gives a closed-graph $\sigma^*$
hence (A8c-attain) automatically.

### Target 2: TRE-gen ⇒ (A9c-calib)

Under (TRE-gen) + (A5-thick) + atomless $\tau$ with full support on $M$:
construct the calibrated coupling $\gamma_\alpha$ explicitly.

The candidate construction:
- **Misaligned mass on outside-trust-region messages:** for each
  $s\notin T$, $m^*(s)$ is the closest trust-region boundary point.
  The misaligned adviser concentrates its $s$-mass on $m^*(s)$.
- **Posterior calibration:** the posterior at message $m$ is
  $$
  P_{\gamma_\alpha}(\omega\mid m) = \frac{\alpha m(\omega)\tau(dm) + (1-\alpha)\int_{m^*(s) = m}s(\omega)\tau(ds)}{\alpha\tau(dm) + (1-\alpha)((m^*)_\#\tau)(dm)}.
  $$
  This is a barycenter of $m$ (truthful) and the average source $s$ that
  $m^*$ maps to $m$ (misaligned).
- **Calibration claim:** if $m\in T$ (interior trust-region), the
  truthful $m$ already lies in $C(m)$, and the misaligned average $\bar s_m$
  also does — so the barycenter does. If $m\in\partial T$ (boundary), $m^*$
  maps a positive set of $s$ to $m$, with $\bar s_m$ on the boundary
  side; $\hat\sigma^*(m)$ is the Bayes-action at $m$ which equals $P_T(m) = m$,
  so $m\in C(m)$; need to check $\bar s_m\in C(m)$ as well.

**Verify this construction explicitly.**

### Target 3: Hall-type mass inequalities

Identify the Hall-type / Strassen-type mass inequalities that ensure
the coupling exists. For binary $\Omega = \{0,1\}$ with $T = [\underline\mu,\bar\mu]$:
- Mass-balance: $\int_{(\bar\mu, 1]}\tau(ds) = \int$ (mass of $\bar\mu$
  receiving misaligned mass from above).
- Quantile transport: τ-mass above $\bar\mu$ matches the mass that gets
  pushed to $\bar\mu$.

For $|\Omega| \ge 3$: state the multi-dimensional analog. Possibly via
optimal transport (Monge-Kantorovich) with cost = posterior-calibration
discrepancy.

### Target 4: Honest scope

State precisely:
- **(TRE-gen)** is a real structural restriction. It says $\sigma^*$
  has a trust-region characterization.
- **The paper's Theorem 1** establishes (TRE-gen) for finite $M, \Theta$.
  The **infinite-extension question** is whether Theorem 1 itself
  generalizes to infinite $M, \Theta$ — this is a separate open question
  beyond the current pass.
- **Conditional result:** if the infinite-extension of Theorem 1
  delivers (TRE-gen), then (A9c-calib) becomes a corollary, NOT a
  primitive assumption.
- **Honest abort:** if the full TRE-gen ⇒ (A9c-calib) implication
  cannot be established for general finite $\Omega$, identify the exact
  obstruction (likely the multi-dimensional mass-balance / Hall
  inequality).

### Target 5: Concrete verification

Verify (A9c-calib) is implied by (TRE-gen) + (A5-thick) at least in:
- Binary $\Omega = \{0,1\}$ — should reproduce paper's Appendix A.6.
- Ternary $\Omega = \{0,1,2\}$ — multi-dimensional generalization.

If ternary verification fails, surface the obstruction.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: Define (TRE-gen)
(Precise statement.)

### Target 2: TRE-gen + (A5-thick) ⇒ (A9c-calib)
(Construction of $\gamma_\alpha$; verification of calibration.)

### Target 3: Hall/mass-balance inequalities
(Binary case; multi-dim generalization.)

### Target 4: Honest scope
(Connection to paper's Theorem 1; statement of remaining open question.)

### Target 5: Concrete verification
(Binary: ✓ via Appendix A.6. Ternary: ✓ or honest failure diagnosis.)

[DERIVED] (A9c-calib) is implied by (TRE-gen) + (A5-thick), with the
caveat that (TRE-gen) itself is the new substantive structural condition.

## Assumption Changes

- [ASSUMPTION-] (A9c-calib) replaced by (TRE-gen).
- [ASSUMPTION+] (TRE-gen) — generalized trust-region structure with
  monotone worst-message map.

## Breakdown Amendments

- [BREAKDOWN_AMEND] Update theorem statement to use (TRE-gen).
- [BREAKDOWN_AMEND] Note that (TRE-gen) ↔ infinite-extension of paper's
  Theorem 1 — separate open question.

## Status Summary

- L9b status: PROVED-CONDITIONAL on (A5-thick) + (A8c-attain) + (TRE-gen).
- (A9c-calib) replaced by (TRE-gen) — substantive but more interpretable.

## Exact Next Obstacle

(Reviewer pass on this. If PASS, the relaxation cycle is complete:
all three added assumptions have been weakened to more interpretable
primitive/structural conditions, and the final theorem reads "Branch B
closes under standing + (A5-thick) + (A8c-attain) + (TRE-gen)".)
```

## Non-Negotiable Rules

- **Be HONEST about whether (TRE-gen) really delivers (A9c-calib).**
  If multi-dimensional mass-balance fails, say so plainly.
- Cite the paper's Theorem 1 / Section 4 / Appendix A.6 explicitly.
- Cite optimal transport literature (Villani, Santambrogio) for the
  multi-dimensional case if needed.
- Length budget: 2500–3500 words.

## Scope Policy

Focused on (A9c-calib) relaxation only. The deliverable is the structural
theorem TRE-gen ⇒ (A9c-calib).
