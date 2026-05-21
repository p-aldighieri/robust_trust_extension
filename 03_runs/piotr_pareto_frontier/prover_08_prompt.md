# Prover pass 08 — F1: Conditional B1 + measurable pasting (FBNF route to |Ω|≥3)

## Role

You are the Prover. The binary case |Ω|=2 capstone is fully verified
(`prover_07_response.md`, `reviewer_06_response.md`). Searcher 04
identified the primary attack route for |Ω|≥3: **G3′/FBNF — Fibered
Binary Normal Fan**. Treat Δ(Ω) as foliated by 1D affine "binary
fibers" and apply the binary capstone conditionally on each fiber.

Searcher 04's lemma chain has 4 lemmas. Your job: prove **F1, the
gate-unlocking conditional-pasting lemma**.

If F1 PASSes, the FBNF route is alive for |Ω|≥3. F2 (endpoint-only
fiber image) and F3 (localized stationarity → fiberwise balance) come
next; F4 is the capstone assembly.

## Setup — the FBNF class

**FBNF primitives** (5 conditions defining the class):

- **(FBNF-1) Measurable affine foliation.** Standard Borel base $Z$,
  Borel disintegration
  $\tau(ds) = \int_Z \tau_z(dt)\,\lambda(dz)$
  and measurable affine embeddings $\ell_z:[a_z, b_z]\to\Delta(\Omega)$
  such that $M$ is covered τ-a.e. by the fibers $\ell_z([a_z, b_z])$.
- **(FBNF-2) Fiber-preserving TRS.** The optimal trust region is fiberwise:
  $T = \bigcup_z \ell_z([L(z), R(z)])$, and the Bregman projection stays
  in the same fiber: $\Pi_T(\ell_z(t)) = \ell_z(\Pi_{[L(z), R(z)]}(t))$.
- **(FBNF-3) Endpoint-only fiberwise rowwise minimization.** For τ_z-a.e.\ $t$,
  $\arg\min_{\mu\in T_z} s\cdot w^*(\mu) \subseteq \{\ell_z(L(z)), \ell_z(R(z))\}$.
- **(FBNF-4) Fiberwise endpoint exposure.** At each active endpoint,
  $B_W(w_{z,L}) \cap \ell_z([a_z, b_z]) = \{\ell_z(L(z))\}$, and
  symmetrically for $R(z)$.
- **(FBNF-5) Fiberwise tie discipline.** $\tau_z$ assigns zero mass to
  the endpoint tie point $b(z)$.
- **(FBNF-6) Local endpoint stationarity.** For λ-a.e.\ $z$, the
  fiberwise total-balance equations hold:
  $\alpha\!\int_{a_z}^{L(z)}\!(L(z)-t)\,\tau_z(dt) = (1-\alpha)\!\int_{S_+(z)}\!(t-L(z))\,\tau_z(dt)$,
  and the symmetric right-endpoint equation.

The substantive case is $\alpha\in(0,1)$.

## Lemma F1 — Conditional B1 + measurable pasting

**Hypotheses.** Standing assumptions + FBNF-1 through FBNF-6.

**Statement.** There exists a global Borel adversarial kernel
$\hat\beta^*: M\to\Delta(M)$ such that:

(a) **Fiber-preserving rowwise-minimizer support.** For τ-a.e.\ $s = \ell_z(t)$,
$\operatorname{supp}\hat\beta^*(\cdot\mid s)\subseteq \{\ell_z(L(z)), \ell_z(R(z))\}$
(the two fiber endpoints).

(b) **Fiberwise calibration.** Define $\gamma_\alpha = \alpha(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\tau\otimes\hat\beta^*$
and $q := (\gamma_\alpha)_2$. The disintegration posterior on $\Omega$,
$P_{\gamma_\alpha}(\cdot\mid m)$, satisfies:
- For $q$-a.e.\ message $m = \ell_z(L(z))$ (left fiber endpoint):
  $P_{\gamma_\alpha}(\cdot\mid m) = \ell_z(L(z))$ (identified with a belief in $\Delta(\Omega)$).
- For $q$-a.e.\ message $m = \ell_z(R(z))$: $P_{\gamma_\alpha}(\cdot\mid m) = \ell_z(R(z))$.
- For $q$-a.e.\ interior message $m = \ell_z(t)$ with $t\in(L(z), R(z))$:
  $P_{\gamma_\alpha}(\cdot\mid m) = \ell_z(t)$ (truthful, by no-extra-fiber-traffic).

(c) **Bayes-optimality.** $\hat\sigma^*(m) := R(w^*(\Pi_T(m)))$ is
Bayes-optimal under $P_{\gamma_\alpha}(\cdot\mid m)$ for $q$-a.e.\ $m\in M$.

## Proof structure (your job to rigorize)

### Step 1 — Disintegrate τ via FBNF-1

$\tau$ disintegrates via $\ell$ into $\tau(ds) = \int_Z \tau_z(dt)\,\lambda(dz)$.
Use standard Polish-space disintegration (Kallenberg 1997 Thm 6.10) on
the Borel surjection $(z, t)\mapsto \ell_z(t)$ from $\{(z, t): z\in Z, t\in[a_z, b_z]\}$
to $M\subseteq\Delta(\Omega)$.

### Step 2 — Apply L_B1 fiberwise

For λ-a.e.\ $z$, the conditional measure $\tau_z$ on $[a_z, b_z]$
satisfies the fiberwise total-balance equations (FBNF-6) at the
endpoints $L(z), R(z)$.

Apply L_B1 (durable source `prover_05_response.md`) with $p = L(z)$,
$A_- = [a_z, L(z)] \cap \operatorname{supp}\tau_z$, $S_+ = \{t\in[L(z), b_z]: \text{left-minimizer at }t\}$:
- Total-balance gives the L_B1 hypothesis $\eta_z(A_-) = \nu_z(S_+) < \infty$.
- L_B1 supplies a Borel kernel $\kappa_{L,z}: S_+ \to \Delta(A_-)$
  realizing the fiberwise balance, with posterior = $L(z)$ at every
  left-fiber endpoint message.

Apply the symmetric version for $R(z)$.

### Step 3 — Measurable pasting

Show that the family $\{(\kappa_{L,z}, \kappa_{R,z})\}_{z\in Z}$ can be
glued into a single Borel kernel $\hat\beta^*: M\to\Delta(M)$ via the
foliation $\ell$.

**Tool**: standard measurable-pasting / Borel-isomorphism arguments
on standard Borel spaces. Specifically, the joint object
$(z, t, \text{adversarial message})\in Z\times\R\times M$ has Borel
structure inherited from products and measurable selections.

The pasted kernel:
- For $s = \ell_z(t)$ with $t\in S_+(z)$ (high source): route to fiber
  left endpoint $\ell_z(L(z))$ via $\kappa_{L,z}$.
- For $s = \ell_z(t)$ with $t\in S_-(z)$ (low source): route to fiber
  right endpoint $\ell_z(R(z))$ via $\kappa_{R,z}$.
- For $s$ in fiber tie point (FBNF-5: λ-a.e. zero mass): arbitrary
  (default to truthful $\delta_s$).
- For $s\notin M$: arbitrary, $q$-null.

Verify Borel measurability of $z\mapsto \kappa_{L,z}$ and
$z\mapsto \kappa_{R,z}$ (standard kernel measurability under
parameter $z$, by KRN or Aliprantis-Border 18.13).

### Step 4 — Verify (a) — fiber-preserving support

The pasted kernel sends every $s = \ell_z(t)$ to mass on
$\{\ell_z(L(z)), \ell_z(R(z))\}$ by construction (Step 3 + L_B1 support).
This is FBNF-2 + fiber-preserving construction.

### Step 5 — Verify (b) — calibration

For a $q$-positive left-fiber-endpoint message $m = \ell_z(L(z))$:

The conditional posterior at $m$ on $\Omega$ is:
\[
P_{\gamma_\alpha}(\omega\mid m) = \frac{\alpha\,m(\omega)\,\tau(\{m\}) + (1-\alpha)\!\int s(\omega)\,\kappa_{L,z}(\{m\}\mid s)\,\tau(ds)}{q(\{m\})}.
\]

By L_B1 Claim 2 applied to fiber $z$: the conditional barycenter on
the left fiber equals $L(z)$ in the fiber coordinate. Pull back via
$\ell_z$: the posterior belief equals $\ell_z(L(z))$ in $\Delta(\Omega)$.

For interior messages $m = \ell_z(t)$ with $t\in(L(z), R(z))$: the
no-extra-fiber-traffic stipulation (Step 3 routing) ensures
$\hat\beta^*$ sends no mass to interior $m$ from other fibers; only
aligned-truthful mass at $s = m$. Posterior is $\delta_m$ on
beliefs, i.e., the belief $m$ itself.

### Step 6 — Verify (c) — Bayes-optimality

For each $m$:
- Interior $m = \ell_z(t)$: posterior is $\ell_z(t)$; TRS continuation
  $\hat\sigma^*(\ell_z(t)) = R(w^*(\ell_z(t)))$ is Bayes-optimal at
  $\ell_z(t)$ by definition of $w^*$.
- Endpoint $m = \ell_z(L(z))$: posterior is $\ell_z(L(z))$; by FBNF-4
  fiberwise endpoint exposure, $w_{z,L} = w^*(\ell_z(L(z)))$ is
  Bayes-optimal exactly at $\ell_z(L(z))$. TRS continuation
  $\hat\sigma^*(\ell_z(L(z))) = R(w_{z,L})$ is Bayes-optimal there.
- Endpoint $m = \ell_z(R(z))$: symmetric.

Definition 2 holds $q$-a.e.

## What I want you to produce

A FULLY RIGOROUS proof of F1, in the structure:

```
# Lemma F1 — Conditional B1 + measurable pasting

## Statement (a), (b), (c) restated

## Hypotheses (FBNF-1 through FBNF-6)

## Proof
### Step 1 — Disintegrate τ via FBNF-1
### Step 2 — Apply L_B1 fiberwise
### Step 3 — Measurable pasting (verify Borel structure carefully)
### Step 4 — Fiber-preserving support
### Step 5 — Calibration via L_B1 Claim 2 pull-back
### Step 6 — Bayes-optimality via FBNF-4 endpoint exposure

## Hidden-hypothesis audit
- Use of FBNF-1 (foliation): essential.
- FBNF-2 (fiber-preserving TRS): essential.
- FBNF-3 (endpoint-only fiber image): used in Step 2.
- FBNF-4 (fiberwise endpoint exposure): used in Step 6.
- FBNF-5 (fiberwise tie discipline): used in Step 2 to avoid B1 boundary issues.
- FBNF-6 (local endpoint stationarity): essential, provides B1 hypothesis.

## Compatibility with v8 sharpness package
WTA ternary witness has |Ω|=3 but is NOT fibered binary in the FBNF-1
sense: the witness's normal fan is 2-dimensional with three vertex
labels {v_0, v_1, v_2}, not a 1-parameter family. So FBNF rules out
the witness by hypothesis.

## Open issues
- F2 (endpoint-only fiber image): the "fiber-restricted" analog of
  L_B3 in higher dimensions. Need to prove (FBNF-3) follows from
  primitive conditions on (u, A) under the foliation.
- F3 (localized endpoint stationarity): (FBNF-6) needs to follow from
  optimality + foliation structure. This may need a localized v9 T1
  Clarke-Danskin theorem.
- F4 (capstone assembly): once F1+F2+F3 are clear, this is bookkeeping.
- Construction of the foliation ℓ from primitives: the FBNF
  hypothesis is non-trivial to verify in practice. Examples worth
  listing: spherical models, MLR families, fan-induced normal cones.
```

## Output Contract

- Inline as plain markdown.
- Use L_B1 verbatim as proven.
- Be rigorous about measurability — name every selection theorem you use.
- End with verdict (PASS / PATCH_SMALL / PATCH_BIG / HOLD) on your own
  work + next-step signal.

## Constraints

- Banned tools: see prior_attempts_digest.md.
- v9 T1 may be cited as proven.
- L_B1 may be cited verbatim from prover_05_response.md.
- Per user: keep going. If F1 fails, identify the missing measure-
  theoretic ingredient and propose a fix.
