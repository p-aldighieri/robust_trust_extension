
========
ROLE: user (id=c6dccce8-3a2a-4725-baa5-576b54ad7e1f)
========
# Reviewer pass 09 — Verify F3 (localized stationarity → fiberwise balance)

## Role

Fresh-chat reviewer on **F3** from prover_10_response.md (durable
source). Verdict from Prover 10: **PASS with regularity caveat** —
FBNF-6 (fiberwise total balance) is derived from optimality plus
localized two-sided perturbations of the FBNF trust band; if the
model has boundary endpoints or lacks two-sided perturbations,
replace equality by KKT inequalities.

## What's being verified

Under standing + FBNF-1+2+3+4+5 + the optimal TRS being a global
maximizer of $V_P$ within the FBNF class, the fiberwise total-balance
equations hold for λ-a.e. z:

$\alpha\int_{a_z}^{L(z)}(L(z)-t)\tau_z(dt) = (1-\alpha)\int_{S_+(z)}(t-L(z))\tau_z(dt)$,
symmetric for $R(z)$.

## Specific checks

- **Differentiability of $V_P(T_\eps)$**: verify the perturbed value
  is differentiable in $\eps$ via the binary perturbation calculus
  applied pointwise in z.
- **λ-a.e. Fermat from Borel-patch testing**: verify the localization
  argument is rigorous (Lebesgue differentiation / monotone class).
- **KKT caveat**: when does equality fail and one-sided inequality is
  the right form? Confirm this is BOUNDARY only (L(z)=0 or R(z)=1),
  not a generic gap.
- **FBNF-6 is DERIVED**, not assumed: confirm this is the cleaner
  primitive class.

## Verdict
- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- One-line + next-step signal.

Show more

========
ROLE: assistant (id=81b776f1-f18f-490c-b0fb-77693bd65f13)
========
Reviewer pass 09 verdict: PASS

One-line signal: F3 is valid as a localized Clarke-Fermat stationarity theorem; fire F4, but keep the boundary/KKT language and state “Clarke/directional stationarity” unless smooth differentiability is explicitly assumed.

The proof passes the key checks.

Differentiability / stationarity check. Prover 10 does not prove classical differentiability in full nonsmooth generality. It correctly downgrades the engine to local Lipschitz plus Clarke-Danskin stationarity: smooth-density cases give the ordinary derivative, while nonsmooth cases use the v9 T1 multiplier mechanism instead of pretending ties or kinks are smooth. That is the right formulation. The proof explicitly says boundedness of W and unit conditional mass give local Lipschitzness, with classical differentiability only under smooth-density assumptions, and Clarke-Danskin otherwise. 

prover_10_response

λ-a.e. Fermat from Borel-patch testing. This is rigorous. Once V
P
	​

(L,R)=∫
Z
	​

V
z
	​

(L(z),R(z))λ(dz) is decomposable, bounded Borel perturbations supported on arbitrary Borel patches give the usual “fundamental lemma” argument: if Φ
L
	​

 or Φ
R
	​

 had a strict sign on a positive-measure patch, a signed local perturbation would improve value, contradicting optimality. Prover 10 states this explicitly and notes that patch testing prevents cancellation across fibers. 

prover_10_response

 

prover_10_response

Balance derivation. The core algebra is sound. The localized T1 condition gives the normalized endpoint posterior p
L
	​

(z)=g
L
	​

(z)/q
L
	​

(z)∈B
W
	​

(w
z,L
	​

), and FBNF-4 collapses this Bayes cone on the fiber to ℓ
z
	​

(L(z)). Since ℓ
z
	​

(t)=p
z
	​

+td
z
	​

, this says the scalar conditional mean equals L(z); multiplying out gives exactly

α∫
a
z
	​

L(z)
	​

(L(z)−t)τ
z
	​

(dt)=(1−α)∫
S
+
	​

(z)
	​

(t−L(z))τ
z
	​

(dt),

with the right endpoint identical by sign reversal. 

prover_10_response

 

prover_10_response

KKT caveat. Correct and boundary-only, modulo fiber notation. In FBNF the boundary cases are L(z)=a
z
	​

 or R(z)=b
z
	​

, which specialize to L=0 or R=1 in normalized binary fibers. If two-sided localized perturbations are unavailable, equality should become the corresponding one-sided KKT inequality. This is not a generic gap; it is exactly the usual boundary constraint caveat. 

prover_10_response

FBNF-6 status. FBNF-6 is derived, not primitive, for the regular interior class. The clean primitive package is FBNF-1 through FBNF-5 plus local two-sided perturbability and optimality within the FBNF class. Prover 10’s hidden-hypothesis audit tracks the dependencies correctly: FBNF-1 decomposes over Z, FBNF-2 identifies endpoint labels, FBNF-3/F2 reduces the active image to endpoints, FBNF-4 collapses cone membership to scalar endpoint equality, and FBNF-5 removes tie-split weights. 

prover_10_response

Patch note for F4: state the capstone with “regular interior FBNF” or include one-sided KKT variants for boundary fibers. Also keep Reviewer 08’s global fiber-dominance/cross-fiber exclusion requirement in F4 so the fiberwise minimizer does not quietly turn into a full-message minimizer without permission.

Next step: fire F4 capstone assembly using patched F1, F2, and this F3.
