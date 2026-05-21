# Prover pass 10 — F3: Localized stationarity → fiberwise balance

## Role

You are the Prover. F1 (Conditional B1 + pasting) and F2 (Endpoint-only
fiber image) are both PASS in their corrected forms. Prove the third
FBNF lemma: **F3 — localized endpoint stationarity implies fiberwise
total balance**.

This is the |Ω|≥3 fibered analog of L_B5 (binary endpoint stationarity).

## Setup

FBNF class (see `searcher_04_response.md`, `prover_08_response.md`).
Assume FBNF-1+2+3+4+5. Adjudicate whether FBNF-6 should be:
- (FBNF-6-derived) a CONSEQUENCE of optimality + local perturbations
  (this lemma), OR
- (FBNF-6-primitive) a hypothesis on the model.

**Preferred: derived.** F3 should prove that AT THE OPTIMAL TRS, the
fiberwise total-balance equations hold for λ-a.e. z, by combining
local endpoint perturbations $L(z)\mapsto L(z)+\eps h(z)$,
$R(z)\mapsto R(z)+\eps k(z)$ with the v9 T1 Clarke-Danskin Fermat
applied conditionally.

## Lemma F3 — Localized stationarity

**Hypotheses.** Standing + |Ω| ≥ 3 + FBNF-1+2+3+4+5 + the optimal TRS
$T = \bigcup_z \ell_z([L(z), R(z)])$ is the argmax of $V_P$ on
$\K(W^P)$ within the FBNF class.

**Statement.** For λ-a.e. z, the fiberwise total-balance equations
hold:
\[
\alpha\!\int_{a_z}^{L(z)}(L(z)-t)\,\tau_z(dt) = (1-\alpha)\!\int_{S_+(z)}(t-L(z))\,\tau_z(dt),
\]
and the symmetric right-endpoint equation.

## Proof structure

### Step 1 — Localized perturbations

Consider perturbations of the trust band:
$L_\eps(z) = L(z) + \eps h(z)$, $R_\eps(z) = R(z) + \eps k(z)$
for Borel bounded $h, k:Z\to\R$.

Verify that the perturbed trust region $T_\eps = \bigcup_z \ell_z([L_\eps(z), R_\eps(z)])$
is admissible (FBNF-2 preserved) and that $V_P(T_\eps)$ is differentiable
in $\eps$ at $\eps=0$.

### Step 2 — Value functional derivative

Use the binary case's perturbation calculus pointwise in z (paper
Equations (6)-(7) in Appendix A.6 give the smooth-density version).

$\frac{d}{d\eps}\Big|_{\eps=0} V_P(T_\eps) = \int_Z [h(z)\Phi_L(z) + k(z)\Phi_R(z)]\,\lambda(dz)$,
where $\Phi_L(z), \Phi_R(z)$ are the fiberwise stationarity
expressions (LHS minus RHS of the displayed balance equation).

### Step 3 — λ-a.e. Fermat

Optimality at the unperturbed trust region: the derivative is ≤ 0 for
every admissible (h, k). By choosing $h, k$ supported on Borel patches
and using positive/negative tests, conclude $\Phi_L(z) = \Phi_R(z) = 0$
for λ-a.e. z.

This is the conditional v9 T1 Clarke-Danskin Fermat applied fiberwise.

### Step 4 — Verify FBNF-6 is derived, not primitive

Conclude that under FBNF-1+2+3+4+5 plus optimality, the fiberwise
total balance equations (i.e., FBNF-6) hold automatically. So FBNF
is a 5-primitive class, with FBNF-6 derived.

## What I want you to produce

A rigorous proof of F3, in the structure above. Key checks:
- Differentiability of $V_P(T_\eps)$ in $\eps$ (use bounded τ_z mass
  and the binary perturbation calculus).
- λ-a.e. Fermat (use Borel-patch testing).
- FBNF-6 follows from FBNF-1..5 + optimality, not assumed.

## Output Contract

- Inline markdown.
- End with verdict + next-step (F4 capstone assembly next).
