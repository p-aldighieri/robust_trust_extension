# Prover pass — L8a: Restricted dual attainment in $F$

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Decide whether the restricted-game dual is attained in $F$:

$$
\exists\,\varphi^*\in F : \quad U_F(\sigma^*,\varphi^*) \;=\; \inf_{\varphi\in F}\,U_F(\sigma^*,\varphi) \;=\; V^*.
$$

If YES, prove it and immediately deliver the **L8 barycenter bridge**:
$\beta^* := \beta_{\varphi^*}\in B$ achieves $U(\beta^*,\sigma^*) = U^*$,
closing L8 in one short corollary.

If NO, identify the **exact missing ingredient** (e.g., compactness of
$F$ in some payoff-relevant topology, or u.s.c. of $-U_F(\sigma^*,\cdot)$
in some compatible topology), so the orchestrator can pivot to Route 3c
(coarsened class $B'$).

This is the central next step for Branch B. **Be honest.**

## Inputs

- `phil_reny_route_memo.md` — live route memo. **Branch A complete.**
  Branch B planning ranks 3b (this) primary; 3c backup.
- `phil_reny_bundle.md` — Phil's contribution + Mertens (1986) Cor B.
- `prior_attempts_digest.md` — dead routes; do NOT re-propose
  product-narrow attainment in $\prod_\mu\Delta(M)$.
- Logs of Branch A reviewer-cleared lemmas (route memo carries the
  recovered statements).
- Paper PDF.

## Target

Decide attainment of $\inf_{\varphi\in F} U_F(\sigma^*,\varphi)$ at the
specific $\sigma^*\in\Sigma$ produced by L3+L4.

## Subquestions you MUST address

1. **$U_F(\sigma^*,\cdot)$ is affine on convex $F$.** Standard fact: an
   affine function on a convex set may or may not attain its infimum.
   Attainment requires either compactness of $F$ in a topology where
   $U_F(\sigma^*,\cdot)$ is upper semicontinuous (for the **negative**;
   we want $\inf$ to be attained), OR a specific argument exploiting the
   problem structure.

2. **Possible compactness of $F$ in a payoff-relevant topology.** $F$
   sits inside the cone of nonnegative measurable functions on $M\times M$
   normalized so that $\int_M\varphi(m\mid s)\,\tau(dm) = 1$ for $\tau$-a.e. $s$.
   - Is $F$ closed and convex in the **weak topology** on $L^1(\tau\otimes\tau)$?
     (Probably yes — closedness comes from the linear normalization; need
     to handle unbounded densities.)
   - Is $F$ **bounded** in $L^1(\tau\otimes\tau)$? Yes:
     $\int\int \varphi\,d(\tau\otimes\tau) = \int 1\,d\tau = 1$ (after Tonelli).
     So $F$ has $L^1$-norm $= 1$, hence is bounded.
   - Is $F$ **uniformly integrable**? This is the critical condition for
     weak compactness in $L^1$ (Dunford-Pettis theorem). Generally NO —
     $F$ contains highly concentrated densities approximating Diracs.
   - Hence: $F$ is generally **not weakly $L^1$-compact**.
3. **Are Dirac kernels limits of $F$?** Consider $\beta_d(dm\mid s) = \delta_{d(s)}(dm)$
   for measurable $d:M\to M$. This kernel is in $B$ but generally **not**
   in $F$ (Dirac is not τ-dominated unless τ has atoms). However,
   $\beta_d$ may be a $\tau$-a.e.-marginal limit of $\beta_{\varphi_n}$
   for narrow approximations $\varphi_n\to\delta_{d(s)}$. So the
   **closure** of the image $\{\beta_\varphi:\varphi\in F\}$ in some
   topology of kernels may include all (or many) elements of $B$.
4. **Connection to L6.** L6 already gives: for every $\beta\in B$ and
   every $\varepsilon>0$, $\exists\varphi_\varepsilon\in F$ with
   $U_F(\sigma^*,\varphi_\varepsilon) \le U(\beta,\sigma^*) + \varepsilon$.
   - This says the **infimum image** $\{U(\beta,\sigma^*):\beta\in B\}$
     and $\{U_F(\sigma^*,\varphi):\varphi\in F\}$ are dense **at the
     bottom**: $\inf_F U_F(\sigma^*,\cdot) = \inf_B U(\cdot,\sigma^*) = U^*$.
   - But density-at-the-bottom does NOT immediately give attainment.
5. **What if attainment fails?** Then one of three things:
   (a) The Mertens-side dual minimum is never attained in $F$ even though
       it's a clean-looking infimum;
   (b) Attainment requires extending to a coarsened class $B'$ (Route
       3c);
   (c) Attainment is achievable in $F$ via a measurable selection
       argument that bypasses compactness — e.g., via a direct
       construction from $\sigma^*$'s structure.
6. **Possible direct construction.** Since $U_F(\sigma^*,\varphi) = (1-\alpha)\sum_\omega\mu_0(\omega)\int_M\int_M p_{\omega,\sigma^*}(m)\varphi(m\mid s)\tau(dm)\pi(ds\mid\omega)$
   plus the aligned constant, the φ-minimum at fixed $\sigma^*$ is
   attained by **concentrating $\varphi(\cdot\mid s)$ on the $\tau$-essential
   minimum of $m\mapsto p_{\omega,\sigma^*}(m)$**. Specifically:
   - Define $m^*(s) := \arg\min_m \tilde p_\sigma^*(m,s)$ where
     $\tilde p_{\sigma^*}(m,s) = \sum_\omega \mu_0(\omega) p_{\omega,\sigma^*}(m) \frac{d\pi(\cdot\mid\omega)}{d\tau}(s)$
     or similar. (Adjust the formula — be careful with the conditional
     structure.)
   - Then $\varphi^*(m\mid s) = \delta_{m^*(s)}(m)/\tau(\{m^*(s)\})$ — but
     this is Dirac-like, not τ-dominated.
   - **However:** if the essential minimum is attained on a set of
     positive τ-measure (a "flat region"), $\varphi^*$ can be a uniform
     density on that set, which IS in $F$. So attainment depends on the
     **geometry of the level sets of $\tilde p_{\sigma^*}$**.
   - Investigate this carefully. Honest answer expected.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L8a — Restricted dual attainment

**Verdict:** ATTAINED in $F$ / NOT ATTAINED in $F$ / CONDITIONAL.

**Argument:**

(Investigate the structure described in subquestion 6, with the
correct conditional structure. State precisely whether attainment holds
or fails.)

If ATTAINED:

### Target 2: L8 barycenter bridge

**Claim:** Take $\beta^* := \beta_{\varphi^*}$. Then $\beta^*\in B$ and
$U(\beta^*,\sigma^*) = U^*$.

**Proof:** (Short corollary using affineness.)

[DERIVED] L8 holds.

If NOT ATTAINED:

### Target 2: Diagnosis of failure

**Exact missing ingredient:** ...

(Identify what would close L8 — e.g., a coarsened adversary class,
an additional compactness assumption, or measurable selection structure.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (route memo updates if needed)

## Status Summary

- L8a status: PROVED-ATTAINED / PROVED-NOT-ATTAINED / OPEN.
- L8 status (conditional on L8a): PROVED / OPEN.

## Exact Next Obstacle

(If L8 closes via barycenter: L9 — per-message Bayes-optimality. If L8a
fails: pivot to Route 3c — coarsened class $B'$.)
```

## Non-Negotiable Rules

- **Be honest.** If attainment fails, say so plainly. Do not paper over.
- Do NOT use product-narrow Sion or any dead-route machinery.
- Length budget: 2000–3500 words.

## Scope Policy

L8a is one focused question. If you find a clean attainment, also
deliver the L8 barycenter bridge as Target 2. Do NOT attempt L9.
