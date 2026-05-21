# Prover pass 11 — F4 FBNF capstone assembly

## Role

You are the Prover. Assemble F1+F2+F3 into the **FBNF capstone theorem**
for |Ω|≥3, with FBNF-7 (global fiber dominance) added as a primitive
class condition per Reviewer 08's recommendation.

## The FBNF class (final form)

Primitive class conditions on $(u, A, \Omega, \Theta, \tau, \ell)$:

- **(FBNF-1) Measurable affine foliation.** Standard Borel base $Z$,
  Borel disintegration $\tau(ds) = \int_Z \tau_z(dt)\lambda(dz)$, affine
  embeddings $\ell_z:[a_z, b_z]\to\Delta(\Omega)$ jointly Borel,
  covering $M$ τ-a.e.
- **(FBNF-2) Fiber-preserving TRS.** The optimal trust region admits
  the form $T = \bigcup_z \ell_z([L(z), R(z)])$; Bregman projection
  preserves fibers.
- **(FBNF-3) Endpoint-only fiber image** (proven as F2 from primitive
  condition P, e.g., concavity-on-fiber or supporting-line domination):
  rowwise minimization over $T_z$ supported on $\{\ell_z(L(z)), \ell_z(R(z))\}$.
- **(FBNF-4) Fiberwise endpoint exposure**: $B_W(w_{z,L})\cap\ell_z([a_z, b_z]) = \{\ell_z(L(z))\}$,
  symmetric for $R(z)$.
- **(FBNF-5) Fiberwise tie discipline**: $\tau_z$ no atom at the fiber
  tie point.
- **(FBNF-6) Local endpoint stationarity** — **DERIVED** from optimality
  + (FBNF-1..5) + two-sided localized perturbations (F3).
- **(FBNF-7) Global fiber dominance.** For τ-a.e. $s\in M$ in fiber $z$,
  $\min_{\mu\in T}s\cdot w^*(\mu) = \min_{\mu\in T_z}s\cdot w^*(\mu)$.
  I.e., cross-fiber messages cannot dominate the in-fiber endpoint
  minimum. Spherical (radial fibers through center) and affine-MLR
  satisfy this; WTA ternary fails it.

## Capstone theorem (F4)

**Theorem (FBNF infinite-extension of Theorem 2).** Under standing
hypotheses, $|\Omega|\ge 3$, $\alpha\in(0,1)$, and primitive FBNF-1
through FBNF-5 and FBNF-7, there exists a robustly rationalizable
optimal strategy for arbitrary measurable $M$ and $\Theta$.

Specifically, define the FBNF-induced adversarial kernel
$\hat\beta^*:M\to\Delta(M)$ by pasting fiberwise B1 kernels
$\kappa_{L,z}, \kappa_{R,z}$ from F1, with truthful interior
reporting in the aligned channel. Then for $q$-a.e. $m\in M$, the
TRS continuation $\hat\sigma^*(m) = R(w^*(\Pi_T(m)))$ is Bayes-optimal
under $P_{\hat\beta^*}(\cdot\mid m)$.

## Proof structure

1. **Step 1** — TRS exists by paper Theorem 1; (FBNF-2) gives its
   fibered form.
2. **Step 2** — FBNF-3 (F2) gives within-fiber endpoint-only image.
   FBNF-7 lifts this to GLOBAL endpoint-only image: the adversary's
   true best response sends mass only to fiber endpoints
   $\bigcup_z\{\ell_z(L(z)), \ell_z(R(z))\}$.
3. **Step 3** — FBNF-6 (F3) gives fiberwise total balance from
   optimality.
4. **Step 4** — F1 (conditional B1 + measurable pasting) constructs
   the global adversarial kernel from fiberwise B1 kernels.
5. **Step 5** — FBNF-4 (fiberwise endpoint exposure) gives
   Bayes-optimality of TRS continuation at endpoint-fiber messages.
   Interior messages are aligned-truthful with posterior = m.
6. **Step 6** — Definition 2 holds $q$-a.e.

## What to produce

Full rigorous proof in this structure:

```
# Theorem (FBNF infinite-extension of Theorem 2)

## Statement
## Hypotheses (FBNF-1..5, FBNF-7; standing; |Ω|≥3; α∈(0,1))

## Proof (Steps 1-6)

## Economic interpretation of primitives
- FBNF-1: signal posteriors live on a 1-d family.
- FBNF-2: trust region respects the foliation.
- FBNF-3 (via P): fiber arcs are well-shaped (concavity / single-cross).
- FBNF-4: unique Bayes belief at each fiber endpoint label.
- FBNF-5: τ_z no atom at tie point.
- FBNF-7: cross-fiber messages don't beat in-fiber endpoints.

## Coverage examples
- Spherical models (paper §5.2, App A.10): fibers = radial diameters
  through center.
- Affine MLR / single-crossing: posteriors lie on an affine 1-d arc.
- Polyhedral W with scalarizable faces: each Bayes face is a 1-d arc.

## Comparison with v8 menu-Hall + binary capstone
- v8 Tier 2 = menu-Hall postulated as calibration.
- v9 binary = (R-EE)+(R-TD)+(R-IES) primitive, calibration derived.
- v9 FBNF |Ω|≥3 = FBNF-1..5+FBNF-7 primitive, calibration derived.

## Sharpness compatibility
WTA ternary fails FBNF-7 (cross-vertex dominance). The witness is
correctly excluded by the FBNF class.

## Open
- Non-affine foliations.
- General curved MLR.
- Polyhedral W without scalarizable faces.
```

## Output Contract

- Inline markdown.
- Use F1, F2, F3 verbatim as proven.
- End with verdict + next-step signal.

## Constraints

- Banned tools list applies.
- Per user: do not stop. If F4 fails, identify the missing ingredient.
