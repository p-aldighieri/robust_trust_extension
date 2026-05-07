# Prover pass — Phase C equivalence lemma: menu-formulation gives the original $V^*$

You are the Prover. Establish the foundational equivalence:

**Lemma (menu-value equivalence).** Under the standing hypotheses of
\emph{Robust Trust} (and possibly mild additional regularity to be
identified), the original max–min value $U^*$ of the agent's robust
problem equals the supremum of $F(C) := \int_M [\alpha \max_{w\in C} s\cdot w + (1-\alpha) \min_{w\in C} s\cdot w]\,\tau(ds)$
over compact subsets $C\subseteq W$ of the paper's payoff-profile set
$W := \{w\in\R^{|\Omega|} : \exists\,\hat\sigma,\ w(\omega) = \E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}$.

This justifies that the menu engine is studying the right object —
not a relaxation, not a different game.

## Inputs

- Paper PDF: Section 3.2 / Theorem 1 / Appendix A.1 for the $W$ set
  characterization.
- Phase C breakdown:
  `logs/20260507T000000Z_breakdown_phase_C_menu_engine_response.md`.

## What you must produce

### Target 1: precise statement of the equivalence

State the lemma with all quantifiers explicit. In particular:
- Range of $C$: nonempty compact subsets of $W$, OR a more restrictive
  class (e.g., the image of a measurable strategy)?
- The misaligned-term derivation: the original $\inf_\beta\E_{\beta,\sigma}[u]$
  becomes $\int_M \min_{w\in C} s\cdot w\,\tau(ds)$ for $C$ = image
  of $\sigma$ — derive this.
- The aligned-term derivation: $\E_{\mathrm{id},\sigma}[u]$ becomes
  $\int_M \max_{w\in C(s)} s\cdot w\,\tau(ds)$ if the agent can pick
  freely after seeing the truthful posterior $s$. **Or** the agent
  commits to a per-message strategy and the aligned term becomes
  $\int_M s\cdot w(s)\,\tau(ds)$ for $w(s)$ chosen by the labeling.
  Resolve the right form.

### Target 2: derivation chain from $U^*$ to $\sup_C F(C)$

Step-by-step:

1. Start from the definition $U^* = \sup_\sigma U(\sigma) = \sup_\sigma [\alpha\E_{\mathrm{id},\sigma}[u] + (1-\alpha)\inf_\beta \E_{\beta,\sigma}[u]]$.

2. Re-express $\sigma$ as a measurable function $w_\sigma:M\to W$
   (the agent's profile choice at each message). Justify why every
   $\sigma$ corresponds to such a $w_\sigma$ and conversely (the
   "profile realization" question — flag it as a sub-lemma if it's
   non-trivial).

3. Express $\E_{\beta,\sigma}[u]$ as $\int_M\int_M s\cdot w_\sigma(m)\,\beta(dm\mid s)\,\tau(ds)$,
   so the misaligned term is $\inf_\beta \int s\cdot w_\sigma(m)\,\beta(dm\mid s)\tau(ds) = \int_M \min_{m\in M}\,s\cdot w_\sigma(m)\,\tau(ds) = \int_M\min_{w\in w_\sigma(M)}\,s\cdot w\,\tau(ds)$.
   Verify this rewriting: from $\beta$ over $M$ to a min over the
   essential range $w_\sigma(M)\subseteq W$.

4. Express $\E_{\mathrm{id},\sigma}[u]$: aligned posterior $s$, agent
   plays $\hat\sigma(s)$ giving profile $w_\sigma(s)$, expected payoff
   $s\cdot w_\sigma(s)$. So aligned term $= \int_M s\cdot w_\sigma(s)\,\tau(ds)$.

5. Optimize over $w_\sigma:M\to W$. The aligned term is maximized
   pointwise by $w_\sigma(s) = \arg\max_{w\in C}\,s\cdot w$ for $C$
   the image; the misaligned term is determined by the image set $C$.
   So the joint optimization decouples into: pick a compact
   $C\subseteq W$, then assign $w_\sigma$ as the aligned-best
   selection from $C$.

6. Conclude $U^* = \sup_{C\in\mathcal K(W)} F(C)$ where $\mathcal K(W)$
   is the set of nonempty compact subsets of $W$ and $F(C) = \int_M[\alpha\max_{w\in C}\,s\cdot w + (1-\alpha)\min_{w\in C}\,s\cdot w]\,\tau(ds)$.

### Target 3: identify any regularity gap

Specifically:
- Is $w_\sigma:M\to W$ a Borel measurable function? Does this require
  any regularity on $\sigma$ or the model primitives?
- Does $\sup_\sigma$ correspond to $\sup_C$, or only to
  $\sup$-over-images-of-measurable-strategies? If a smaller class,
  identify the gap.
- The measurable-selection step from "compact $C\subseteq W$" back
  to "$\sigma\in\Si$" implementing $C$ — is this always possible?
  (See breakdown's Risk #1: profile realization.)

### Target 4: (sub-lemma if needed) profile realization

If the equivalence requires a profile-realization sub-lemma — given
$w:M\to W$ Borel, exists $\sigma\in\Si$ with $w_\sigma = w$ a.e.? —
state and sketch it.

## Output Format

```markdown
## Statement
(Precise lemma.)

## Derivation: $U^* = \sup_C F(C)$
(Steps 1–6.)

## Regularity gap diagnosis
(Where the equivalence might leak.)

## Profile realization sub-lemma
(If needed.)

## Status
- Equivalence lemma: PROVED / PROVED-CONDITIONAL / GAP-FOUND.
```

## Discipline

- Use paper notation.
- Distinguish carefully between $\sigma$ as a (private-strategy-valued)
  kernel vs $w_\sigma$ as a profile-valued map.
- Length: 1800–2800 words.
