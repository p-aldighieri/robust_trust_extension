# Prover pass — L6: Lift to measurable deviations (the core Phil-Lusin contradiction)

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L6** of `phil_reny_route_memo.md`: any unrestricted
measurable adversarial deviation $\beta\in B$ that beats the
restricted-game value $V^* = \inf_\varphi U_F(\sigma^*,\varphi) = \max_\sigma\inf_\varphi U_F(\sigma,\varphi)$
can be **converted** into a $\tau$-dominated $\varphi\in F$ that beats
the same $V^*$, contradicting L3+L4.

Combined with L1-L5, this gives that $\sigma^*$ (after Lusin
modification) **secures the value $V^*$ against all unrestricted
measurable adviser strategies** — i.e., $\inf_{\beta\in B} U(\beta,\sigma^*) \ge V^*$.

This is the **core new step** in Phil's argument. Do it carefully.

## Inputs

- `phil_reny_route_memo.md` — live route memo. **L1–L5, L7 PROVED**
  (L5 conditional on (A5)).
- `phil_reny_bundle.md` — Phil's email contains the contradiction sketch.
- `prior_attempts_digest.md` — dead routes (don't invoke).
- Paper PDF.

## Target

**L6 (Lusin lift contradiction).** Under standing hypotheses + (A5):
For any measurable $\beta\in B$ and any $\varepsilon>0$, there exists a
$\tau$-dominated $\varphi_\varepsilon\in F$ with

$$
U(\beta,\sigma^*) \;\ge\; U_F(\sigma^*,\varphi_\varepsilon) - \varepsilon.
$$

Consequently, since $U_F(\sigma^*,\varphi_\varepsilon) \ge V^*$ for every
$\varphi_\varepsilon\in F$ (by L3+L4 saying $\sigma^*$ achieves
$\max_\sigma\inf_\varphi U_F$), we get $U(\beta,\sigma^*) \ge V^* - \varepsilon$
for every $\varepsilon$, hence $U(\beta,\sigma^*) \ge V^*$.

Equivalently and more memorably: **$\sigma^*$ secures the value $V^*$
against all unrestricted measurable adversaries.**

## Argument structure (for guidance, NOT to copy verbatim)

Phil's email gives a contrapositive argument: assume $d:M\to M$
measurable with $U(\delta_d,\sigma^*) < V^*$, derive a contradiction.
The same idea works for general kernels $\beta$ via measurable selection
or by directly constructing the τ-dominated approximation.

Two-case structure (after the L5 modification of $\sigma^*$ off $K^*$):

**Case A — deviation supported off $K^*$.** If $\beta$ sends mass into
$M\setminus K^*$ from messages $s$, then since $\sigma^*$ is constant on
$M\setminus K^*$ (= $\sigma_0^*(\cdot\mid m_0,\theta)$), the corresponding
$U$-contribution is the same as using $m_0$ as the message — which is
also achievable via a $\tau$-dominated $\varphi$ (e.g., approximate Dirac
at $m_0$ within $K^*$).

**Case B — deviation supported in $K^*$.** Then for $\pi(\cdot\mid\omega)$-a.e.
$s$, $\beta(\cdot\mid s)$ puts mass in some $K_n$. Use Lusin continuity
of $\sigma^*\restriction K_n$ + support-thickness to construct
$\varphi_\varepsilon$ as follows: for each $s$, replace the kernel
$\beta(\cdot\mid s)$ by a $\tau$-dominated density supported in a
neighborhood $O_\varepsilon(s)$ of $\beta$'s effective image, where
$\sigma^*$ is approximately constant. Specifically, if
$\beta(\cdot\mid s) = \delta_{d(s)}$ for some $d(s)\in K_n$, take
$\varphi_\varepsilon(m\mid s) = \mathbf 1_{O_\varepsilon(d(s))\cap K_n}(m) / \tau(O_\varepsilon(d(s))\cap K_n)$,
which is $\tau$-dominated (well-defined by support-thickness:
$\tau(O_\varepsilon(d(s))\cap K_n)>0$). For non-Dirac $\beta$, integrate.

## Subquestions you MUST address

1. **Reduction of stochastic kernels to measurable maps.** The argument
   above is cleanest for $\beta(\cdot\mid s) = \delta_{d(s)}$ (Dirac
   kernels, equivalent to measurable maps $d:M\to M$). Show that the
   inf $\inf_{\beta\in B} U(\beta,\sigma^*)$ is unchanged if we
   restrict to deterministic kernels — OR show that the lift argument
   works for general $\beta$ via Tonelli without going through Dirac.
   (Hint: $U$ is affine in $\beta$, so $\inf_\beta U = \inf_d U|_{\text{Diracs}}$
   if $\sigma^*$ doesn't see "shape" of $\beta$ beyond its image
   distribution.)
2. **Approximation precision.** Pick the right neighborhood structure on
   $K_n$. Since $K_n$ is compact metric, use balls of radius $\varepsilon$
   (in any compatible metric on $M$, e.g., total-variation on $\Delta(\Omega)$).
   Use the Lusin continuity of $\hat\sigma^*$ on $K_n$ (private-strategy
   topology = continuity of $m\mapsto[\theta\mapsto\hat\sigma^*(\cdot\mid m,\theta)]$
   into the Balder stable space $Y$) to bound the payoff difference.
3. **Pointwise vs uniform.** The Lusin continuity is uniform on each
   compact $K_n$ (continuous functions on compact metric spaces are
   uniformly continuous). Use this to get a *uniform* $\varepsilon$-bound
   across $s\in K_n$.
4. **Measurable selection of $\varphi_\varepsilon$.** $\varphi_\varepsilon(m\mid s)$
   defined pointwise must be **jointly measurable** in $(m,s)$. Justify
   the joint measurability — possibly by noting that the radius-$\varepsilon$
   ball in a compact metric space is a closed (hence Borel) function of
   the center, so the indicator is jointly measurable.
5. **What about $s\in M\setminus K^*$?** Since $\pi(M\setminus K^*\mid\omega) = 0$,
   the integral over $s$ doesn't see this set. But $\varphi_\varepsilon(\cdot\mid s)$
   must still be defined for τ-a.e. $s$. Set it arbitrarily on $M\setminus K^*$
   (e.g., to a fixed reference density). Verify the integrand is
   τ-integrable.
6. **Stitching across $n$.** For deviation $d:M\to M$ with $d(s)$ varying
   across $K_n$ for different $s$, you may need to choose $n = n(s)$
   measurably. Use that $K_n\uparrow K^*$ to handle.
7. **Stochastic case.** If you reduce to Dirac kernels in subquestion 1,
   confirm the reduction is rigorous. Otherwise, repeat the construction
   integrating against the kernel measure.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L6 — Lusin lift contradiction

**Claim:** (Restate L6 with all hypotheses, including (A5).)

**Argument:**

Step 1: (Reduction to deterministic / Dirac kernels, if applicable.)
Justification: ...

Step 2: (For deterministic $d$ supported in $K^*$, construct
$\varphi_\varepsilon$ neighborhood-by-neighborhood.)
Justification: ...

Step 3: (Verify joint measurability of $\varphi_\varepsilon$.)
Justification: ...

Step 4: (Bound the payoff difference $|U(\delta_d,\sigma^*) - U_F(\sigma^*,\varphi_\varepsilon)|$
using Lusin uniform continuity on $K_n$.)
Justification: ...

Step 5: (Handle $d$ off $K^*$ via the modification.)
Justification: ...

Step 6: (Lift to general $\beta\in B$ if step 1 used a reduction.)
Justification: ...

[DERIVED] (State exactly what was established.)

### Target 2: Subquestion answers

(Crisp paragraph for each of subquestions 1–7.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if route memo needs repair)

## Status Summary

- L6 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.

## Exact Next Obstacle

(Should be the **Branch A capstone consolidator**: assemble
"$\sigma^*$ secures $V^*$ against all measurable $\beta\in B$" from
L1+L2+L3+L4+L5+L6+L7, identifying $V^* = U^*$ as the unrestricted-game
value. Or, if more is needed to identify $V^*$ with $U^*$, surface that
as a missing lemma. After this, Branch A is complete and Branch B (L8
adversary attainment) becomes the only remaining task.)
```

## Non-Negotiable Rules

- The two-case structure (Case A: off $K^*$; Case B: in $K^*$) should be
  explicit.
- Every measurability claim needs a one-sentence justification.
- Use the (A5)-driven support-thickness from L5 — do not assume more.
- Do not invoke any of the dead-route machinery in
  `prior_attempts_digest.md`.
- Length budget: 2500–4000 words. L6 is a long lemma; this is a
  legitimately hard step.

## Scope Policy

One target per pass. **Do not** attempt L8 (adversary $\beta^*$
attainment) or L9 (per-message Bayes-optimality). Those are Branch B.
After L6 is reviewer-cleared, the next pass is the Branch A consolidator.
