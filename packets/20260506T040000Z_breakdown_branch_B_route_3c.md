# Breakdown pass — Branch B Route 3c (after L8a blocked)

You are the Breakdown role for the soft-scaffolding workflow.

## Context

L8a (`logs/20260506T033000Z_prover_L8a_dual_attainment_response.md`,
reviewer `logs/20260506T034500Z_reviewer_L8a_dual_attainment_response.md`)
established that Route 3b (restricted-dual barycenter bridge) is **blocked
unconditionally** — generic failure of (A8-flat). Reviewer recommends a
breakdown pass on Route 3c.

The L8a reviewer also explicitly **rejected** my optimistic observation
that L5's "$\sigma^*$ continuous on each $K_n$" gives continuity on
$K^* = \bigcup_n K_n$. Sequences can cross shells; no global continuity
follows.

The reviewer proposed three precise sub-target upgrades. **This pass
must rank them and pick the next prover target.**

## Inputs

- `phil_reny_route_memo.md` — live route memo. Branch A complete.
  Route 3b blocked; Route 3c primary.
- `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- L8a logs (above).

## Sub-target candidates (from L8a reviewer)

### (i) Strengthened Lusin exhaustion — global continuity on a full-measure invariant domain

The idea: instead of just continuity on each $K_n$ separately, build a
**single** compact-or-Polish set $E\subseteq M$ with $\tau(E) = 1$ on
which $\hat\sigma^*$ is **globally continuous** (not just on shells).
Equivalently: there exists a measurable representative whose
discontinuity set is τ-null AND such that the continuous part can be
viewed as a continuous map on a full-measure subspace.

For a Polish-target measurable map, this is a **strong Lusin theorem**:
any measurable map $h:M\to Y$ ($Y$ Polish) has a Borel restriction to a
full-measure subset on which it is continuous. This is Bogachev's
"$\tau$-perfect" theorem. Question: is this strong enough for Route 3c?

### (ii) Lower-semicontinuous modification of $\ell$ preserving value

Replace $\ell(m,s)$ by a lower-semicontinuous (in $m$) function
$\tilde\ell(m,s)\le\ell(m,s)$ such that
$\inf_F U_{\tilde F}(\sigma^*,\cdot) = \inf_F U_F(\sigma^*,\cdot) = U^*$.
Then minimize over the closed convex set of joint measures with first
marginal τ; minimum attained by Berge / Aliprantis-Border because $\tilde\ell$
is l.s.c.

The l.s.c. envelope of $\ell$ is $\check\ell(m,s) := \liminf_{m'\to m}\ell(m',s)$.
This is l.s.c. by construction. **Question:** does $\inf_{\check\beta}\int\check\ell\,d(\check\beta\otimes\tau)$
equal $\inf_\beta\int\ell\,d(\beta\otimes\tau)$? This is essentially asking
whether $\check\ell$-minimization gives the same value as $\ell$-minimization.

### (iii) Rowwise measurable argmin

If for τ-a.e. $s$, the pointwise minimum $\min_m\ell(m,s)$ is attained
AND equals the essential infimum $\operatorname*{essinf}_m\ell(m,s)$,
then a measurable selector $m^*:M\to M$ exists with $m^*(s)\in\arg\min_m\ell(\cdot,s)$,
and $\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)\in B$ achieves $U(\beta^*,\sigma^*) = U^*$
directly — bypassing restricted-dual attainment entirely.

The pointwise min $\min_m\ell(m,s)$ is attained when $\ell(\cdot,s)$ is
**lower semicontinuous** on $M$ (compact). The pointwise min equals the
essential inf when there are no "isolated" essential-null minimizers
that contradict pointwise behavior — true if $\ell$ is continuous on a
τ-conull set, or l.s.c. globally.

## What you must produce

A single markdown deliverable in the response body, with **exactly**
the following sections:

```markdown
## 1. The exact L8 problem after L8a

(Restate L8 cleanly given that Branch A gives $\inf_B U(\cdot,\sigma^*) = U^*$
and L6 gives bottom-density. The remaining task is **attainment** of
$\inf_B U(\beta,\sigma^*)$ at some $\beta^*\in B$.)

## 2. Evaluate each sub-target honestly

### 2a. Strengthened Lusin exhaustion (sub-target i)

(Diagnose. Does Bogachev's strong Lusin theorem give global continuity
on a full-measure subset of $M$? If yes, can the resulting Polish
subspace be used as the message space for a Balder-stable compactness
on $B$ with τ-source marginal? Identify the precise theorem and the
gap, if any.)

### 2b. Lower-semicontinuous modification (sub-target ii)

(Diagnose. Is $\check\ell(m,s) := \liminf_{m'\to m}\ell(m',s)$ a
suitable replacement? Specifically: is
$\inf_\beta\int\check\ell\,d(\beta\otimes\tau)$ equal to
$\inf_\beta\int\ell\,d(\beta\otimes\tau)$? If yes, attainment is via
Aliprantis-Border / Bogachev for l.s.c. integrands on compact joint
measures. If no, what's the gap?)

### 2c. Rowwise measurable argmin (sub-target iii)

(Diagnose. Is the pointwise min of $\ell(\cdot,s)$ attained for τ-a.e.
$s$? Does it equal the essential inf? If yes, measurable selection
(Kuratowski–Ryll-Nardzewski) gives $m^*(s)$ and the Dirac kernel
closes L8. The crucial step is showing pointwise min = essential inf.)

## 3. Ranked recommendation

(Pick the most viable. Justify. Identify the precise next prover
target as a single well-formed lemma.)

## 4. Risks and aborts

(What's the abort condition? Which sub-target has the highest a priori
risk of failing? If all three fail, what's the honest endpoint?)
```

## Discipline

- Use paper-canonical notation throughout.
- Cite Bogachev, Aliprantis-Border, Kuratowski-Ryll-Nardzewski by
  exact section/theorem when invoking.
- Do NOT propose product-narrow Sion or any dead-route machinery.
- Length budget: 1500–2500 words.
- This is a planning pass. Do **not** prove anything in detail. Sketches
  to the level of "this would close because..." are sufficient.
