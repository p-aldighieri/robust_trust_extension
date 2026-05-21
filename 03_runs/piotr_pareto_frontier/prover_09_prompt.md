# Prover pass 09 — F2: Endpoint-only fiber image (|Ω|≥3 / FBNF)

## Role

You are the Prover. F1 (conditional B1 + measurable pasting) is now
patched and reviewer 07 in flight. While that runs, prove **F2 — the
endpoint-only fiber image theorem** for the FBNF class.

This is the |Ω|≥3 fibered analog of L_B3 (binary endpoint-only
adversarial image). It says: under FBNF-1+2+3 primitive conditions,
the misaligned BR on each fiber is rowwise-minimizer supported on the
two fiber endpoints.

If F2 PASSes, three of four FBNF lemmas are in hand. F3 (localized
stationarity → fiberwise balance) and F4 (capstone assembly) remain.

## Setup recap — FBNF class

(See `searcher_04_response.md` and `prover_08_response.md` durable
sources for full definitions.)

- (FBNF-1) Measurable affine foliation: $\tau(ds) = \int_Z \tau_z(dt)\lambda(dz)$ with
  affine embeddings $\ell_z: [a_z, b_z] \to \Delta(\Omega)$.
- (FBNF-2) Fiber-preserving TRS: $T = \bigcup_z \ell_z([L(z), R(z)])$;
  Bregman projection stays in same fiber.
- (FBNF-3) Endpoint-only fiberwise rowwise minimization (TO PROVE
  as a CONSEQUENCE of more primitive conditions in F2 OR to STATE
  as a primitive condition on the model — adjudicate).
- (FBNF-4), (FBNF-5), (FBNF-6) as before.

## Lemma F2 — Endpoint-only fiber image

There are two reasonable readings:

**(F2-A) FBNF-3 as primitive class condition.** F2 says:
**(FBNF-3) is well-defined and consistent with FBNF-1+2** — i.e., the
condition is meaningful and not vacuous. In this reading, F2 is mostly
a measurability/regularity check.

**(F2-B) FBNF-3 as derived.** F2 PROVES (FBNF-3) from more primitive
conditions on $(u, A, W, \tau)$ — e.g., from the structure of $W^P$
and the foliation $\ell$. In this reading, F2 is a substantive theorem
showing certain primitive geometries automatically give endpoint-only
fiber image.

**Choose your reading**: my preferred reading is **(F2-B)** so the
FBNF class is genuinely primitive (not output-dependent). State the
PRIMITIVE conditions on $(u, A, W, \tau)$ that imply (FBNF-3), and
prove the implication.

## Concrete primitive condition candidates

Candidate primitive conditions on $(u, A, W, \tau, \ell)$:

### (P1) Foliation by "lines" in W^P

The agent's payoff-profile menu $C^* = w^*(T)$ admits a 1-parameter
description: $C^*$ is the image of $T$ under $w^*$, and the foliation
$\ell$ pulls back to a foliation on $C^*$. The Pareto-frontier curve
$\mu\mapsto w^*(\mu)$ restricted to a fiber $T_z = \ell_z([L(z), R(z)])$
is a 1-dim arc on $W^P$.

For (FBNF-3) to hold, the function $\mu\mapsto s\cdot w^*(\mu)$
should be **monotone or unimodal** on each fiber arc, with minimum
at one of the endpoints.

### (P2) Concavity-on-fiber

For τ_z-a.e.\ $s = \ell_z(t)$, the function $\mu\mapsto s\cdot w^*(\mu)$
is **concave** on $T_z$. Then it attains its minimum on the boundary
$\{L(z), R(z)\}$.

This is a primitive condition on $(u, A, W)$ via the structure of $W^P$.
In binary, this reduces to the monotone arc on $W^P\subseteq\R^2$.

### (P3) Supporting-line domination (analog of L_B3 binary)

For every interior $\mu\in (L(z), R(z))$ and every $s = \ell_z(t)$ with
$t\in[a_z, b_z]$,
\[
s\cdot w^*(\mu) \;\ge\; \min\{s\cdot w^*(L(z)), s\cdot w^*(R(z))\}.
\]
This is the direct supporting-line analog of L_B3 Step 2.

## What I want you to produce

A rigorous proof in the structure:

```
# Lemma F2 — Endpoint-only fiber image (FBNF class)

## Statement (F2-B reading)
Under FBNF-1, FBNF-2, and some chosen primitive condition (P1, P2, or
P3 above), the conclusion (FBNF-3) holds: for τ_z-a.e. t and $s = \ell_z(t)$,
the rowwise minimizer over $T_z$ is one of the two fiber endpoints.

## Choice of primitive condition

Pick the cleanest condition (likely P3 or P2). Justify the choice
economically (i.e., how restrictive is it? What models satisfy it?).

## Proof
- Step 1: structural setup (fiber arc on $W^P$).
- Step 2: convexity/concavity / supporting-line argument.
- Step 3: endpoint attainment of the min.

## Compatibility with v8 sharpness package
WTA ternary has W^P = vertex set, no 1-d foliation. Under FBNF-1+P,
the witness is excluded by hypothesis. Verify.

## Coverage examples
- Spherical model (paper §5.2, Appendix A.10): W^P is a sphere
  with rotational symmetry. Each great-circle arc is a fiber.
- MLR / single-crossing utility: μ ↦ s·w*(μ) has monotone structure.
- Binary state with extended type: |Ω|=2, |A|≥2, type Θ; fibers are
  trivially [0,1].

## Open issues
- Does the primitive condition P uniquely determine the foliation
  $\ell$? Or is $\ell$ part of the FBNF data?
- Generalization to non-affine foliations.

## End
Verdict on your own work + next-step signal (F3 next? F4 capstone?
or back to drawing board for a different primitive P?).
```

## Output Contract

- Inline markdown.
- Be honest about which primitive (P1, P2, P3, or a new P*) gives the
  cleanest derivation.
- Per user: keep going. If F2 fails under all primitives, propose a
  fresh route.

## Constraints

- Banned tools list applies.
- v9 T1, L_B1, binary capstone may be cited.
- FBNF foliation structure is the working hypothesis; don't try to
  generalize beyond it in this pass.
