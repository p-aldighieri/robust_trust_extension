# Reviewer pass 03 — Verify α=0 unconditional + (D2)≡menu-Hall

## Role

You are an independent Reviewer (fresh chat). You are verifying two
load-bearing claims from `prover_03_response.md` (durable source):

1. **α=0 unconditional claim.** Under standing assumptions + (H3:
   each fiber \((w^*)^{-1}(\{w_i\})\) is nonempty Borel for each label
   \(w_i\) with positive mass), and **\(\alpha = 0\)**, the original-
   message lift closes. Specifically, the kernel \(\hat\beta^*(\cdot\mid s) = \sum_i \lambda^-_i(s)\,\delta_{m_i}\)
   with deterministic representatives \(m_i \in (w^*)^{-1}(\{w_i\})\)
   satisfies original-game Definition 2 robust rationalizability,
   yielding an unconditional infinite-\(M\), infinite-\(\Theta\) Theorem 2
   for the pure adversarial case.

2. **(D2) ≡ menu-Hall claim.** For \(\alpha > 0\), the lift requires
   (D2) finite-fiber calibrated matching, and (D2) is essentially the
   finite-label restriction of the v8 menu-Hall condition (not strictly
   weaker as a primitive assumption).

## Why these claims matter

If (1) is correct: we have a clean unconditional infinite-\(M\)
Theorem 2 for the pure adversarial case. This is publishable as a
strict generalization of the paper's finite-\(M\) Theorem 2 in the
\(\alpha=0\) regime.

If (2) is correct: the route has reached the same locked gate as v8's
deletion-compatible Hall duality, just in different coordinates. We
need to honestly report this so the team doesn't oversell.

## Your job — adversarial review

### For Claim 1 (α=0 unconditional)

Verify rigorously. Specific checks:

- **Aligned term vanishes.** When \(\alpha = 0\), the aligned-truthful
  contribution to the message marginal \(q\) and to the disintegration
  posterior is zero. The full posterior at message \(m_i\) is the
  misaligned-conditional posterior \(\mu^-_i := \int s \lambda^-_i(s)\,d\tau / q^-_i\).
- **Lemma 7 normality gives the right calibration.** With \(\alpha = 0\),
  \(g_i = \int \lambda^-_i(s) s\,d\tau\) (just the misaligned integral).
  Lemma 7 says \(g_i \in N_W(w_i)\). So \(\mu^-_i = g_i / q^-_i \in N_W(w_i) \cap \Delta(\Omega) = B_W(w_i)\).
  Verify each step.
- **Representative hypothesis (H3) suffices.** With \(\alpha=0\), the
  prover claims (H3) — nonempty Borel fibers — is enough. Verify there's
  no hidden additional matching condition.
- **Bayes-optimality of \(\hat\sigma^*\).** \(\hat\sigma^*(m_i) = R(w_i)\)
  is Bayes-optimal at \(\mu^-_i \in B_W(w_i)\) by definition of
  \(B_W\). For \(m \in M \setminus \{m_i\}\): with \(\alpha = 0\), such
  messages have \(q\)-mass zero (aligned contribution is zero,
  misaligned only puts mass on representatives). So Definition 2 is
  vacuously satisfied off the representatives.
- **Compact-menu extension for α=0.** Does the α=0 unconditional
  result lift from finite menus to general compact \(C^*\)? The
  breakdown 02 (durable source) addresses this. Verify whether the
  α=0 case extends cleanly under (R1) + (R2-FES) or even without those
  conditions.

### For Claim 2 ((D2) ≡ menu-Hall)

Verify the prover's argument that (D2) is structurally equivalent to
menu-Hall:

- (D2.1) Misaligned first-marginal matching condition.
- (D2.2) Rowwise-minimizer support condition.
- (D2.3) Messagewise Bayes-cone calibration.

Specifically, does (D2.3) restated in terms of original-game variables
(τ, β̂*, w*) match v8's menu-Hall condition (menu-Hall asks for a kernel
supported on G(s) ⊆ M with posterior in B(m) q-a.e.)?

If yes, (D2) is not a strictly weaker primitive — it's the same
Hall duality condition.

If no, identify the precise difference. Could (D2) be MEANINGFULLY weaker
in some structural sense (e.g., only requires calibration on
finitely many active labels rather than on all q-positive messages)?

## Specific question for the reviewer

Beyond verifying the prover's claims, give one paragraph on:

> **Is the (D2) condition genuinely different from v8's menu-Hall in
> any structurally meaningful way?** Specifically: in v8, menu-Hall is
> a condition on a kernel \(\kappa: M \to \Delta(M)\). In the Pareto-
> frontier route, (D2) is a condition on a kernel \(\eta\) on
> \(M \times \{1, \ldots, k\}\). Could the finite-label coarsening
> dissolve some difficulty present in the messagewise version, even
> if the abstract feasibility question is the same?

This is the orchestrator's specific concern: maybe (D2) for finite k
is genuinely easier than full menu-Hall, even if both are "Hall-type"
conditions. Adjudicate.

## Verdict format

State your verdict on each claim:

- **Claim 1 (α=0):** PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- **Claim 2 (D2≡menu-Hall):** PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.

If PASS on both: state the resulting publishable theorem cleanly.

If DISPROVED on Claim 2 (i.e., (D2) IS strictly weaker than menu-Hall):
this is a positive surprise — sharpen the difference and identify the
next prover target.

## Output Contract

- Inline as plain markdown.
- Be specific.
- End with one-line verdict on each claim + next-step signal for the
  orchestrator.

## Constraints

- Banned tools list applies.
- Stay focused; do not redo the finite-menu proofs.
