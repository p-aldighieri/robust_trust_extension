# Phil-Reny strategy revisited: the τ-AC restriction kills attainment

*Author: orchestrator. Date: 2026-05-19. Status: durable analysis note,
filed alongside `phil_reny_route_memo.md`. Records and adjudicates Piotr's
2026-05-19 objection ("ChatGPT-share/6a0525e5") to Phil Reny's
restricted-game / Lusin-lift strategy.*

## 1. Piotr's objection, stated cleanly

Reny's note proves Theorem 2's existence direction via two moves:
1. **Restrict** the misaligned adviser to densities against $\bar G$
   (equivalently, against $\tau$ in this repo's notation):
   $$
   F \;=\; \{\,\varphi:M\times M \to [0,\infty)\;\text{measurable},\;
   \int_M \varphi(m\mid s)\,\tau(dm)=1\ \tau\text{-a.s.}\,\},
   \qquad \beta_\varphi(dm\mid s):=\varphi(m\mid s)\,\tau(dm).
   $$
2. Get a restricted-game maximizer $\sigma^*$ by Mertens minmax + Balder
   continuity (because the misaligned-term integrates against the fixed
   marginal $\tau$, the payoff is continuous in $\sigma$). Then **lift**
   $\sigma^*$ to the unrestricted game via Lusin smoothing.

Piotr's observation, in his own words and as confirmed by ChatGPT in
the share:

> Suppose $\bar G$ ($=\tau$) is a nice continuous distribution with full
> support on $\Delta(\Omega)$. Then the restriction
> $\pi(dm\mid s)=f(m\mid s)\bar G(dm)$ rules out every adversarial
> kernel that is singular w.r.t. $\tau$. But for $|\Omega|\ge 3$, the
> paper's results imply that, after seeing source belief $s$, the
> optimal worst-case adversary must send a message $m$ that is mapped
> through $P$ (Bregman projection onto the trust region $T$) to a
> *unique* point $\mu\in T$ — and the set of $m\in\Delta(\Omega)$
> Bregman-closest to a fixed $\mu$ is a **lower-dimensional** subset of
> the simplex (1-dimensional in the 3-state case). A τ-AC kernel cannot
> sit on such a Bregman fiber, so $F$ cannot contain the optimal $\beta^*$.

ChatGPT's verdict: yes, the objection is real. For payoff *value* the
restriction might be harmless modulo Lusin-tube approximation; for
attainment of $\beta^*$ — and hence for the saddle-point /
robust-rationalizability content of Theorem 2 — it is "much more
damaging" and "the proposed proof strategy cannot prove the full
infinite-$M$ version of Theorem 2 as stated."

## 2. Verdict

**Piotr is right** — with one important refinement on what "right"
means at each layer of the argument.

### 2.1 What the objection does NOT kill (Branch A — value optimality)

Reny's strategy, as stated, only ever claimed:
> "this establishes the existence of an optimal strategy for player 1,
> but not for player 2."

The phrase "for player 1" means: existence of $\sigma^*\in\Sigma$ with
$U(\sigma^*)=U^*$. This is the **value-optimal agent strategy**, not the
saddle point. Piotr's geometric objection does **not** kill this layer,
provided the Lusin-lift step closes. The reason is that the singular
$\beta^*$ on a Bregman fiber can be approximated **in payoff** by
$\tau$-AC kernels concentrating density in thin tubes around the fiber.
If
- $\sigma^*$ is τ-a.e. continuous on a Lusin-thick compact $K^*$, and
- the fiber meets $K^*$ with positive τ-mass in every τ-neighborhood,
then tubes of vanishing width recover the singular payoff in the limit.
The repo's L6 (lift via smoothing-kernels) is exactly this argument.
Net: **value matches** between the restricted and unrestricted games.

The repo's Branch A capstone (route memo §3, L6) records this under
hypothesis **(A5)**: $\pi(\cdot\mid\omega)\sim\tau$ for every
$\omega\in\Omega$. (A5) is precisely the structural piece that makes
the tubes' positive-mass requirement uniform in $\omega$.

### 2.2 What the objection DOES kill (Branch B as Reny stated it)

For the **saddle point / Definition 2 robust rationalizability**, one
needs not just $U(\sigma^*)=U^*$ but an actual $\beta^*\in B$ attaining
$\inf_\beta U(\beta,\sigma^*)$, with per-message Bayes-optimality of
$\hat\sigma^*$ under the posterior $P_{\beta^*}(\cdot\mid m)$.

If the inf is taken inside the restricted class $F$, then under Piotr's
3-state Bregman geometry **no $\varphi\in F$ attains** — the optimizer
generically pushes mass arbitrarily close to a $\tau$-null Bregman
fiber but never onto it. The restricted dual value is given by an
essential infimum (see L8a in the route memo:
$\inf_F U_F(\sigma^*,\varphi) = \text{const}+(1-\alpha)\int_M
\operatorname*{essinf}_m\ell_{\sigma^*}(m,s)\,\tau(ds)$); attainment
inside $F$ requires $\tau(Z(s))>0$ for τ-a.e. $s$, which Piotr's
geometry violates by construction.

**Hence: Reny's strategy as stated does *not* deliver Theorem 2's
existence direction.** It delivers value optimality and ε-adversaries,
not the saddle attainer. This matches Reny's own caveat and Piotr's
objection sharpens it into a structural reason.

## 3. How the in-repo work side-stepped this (the L8 patch)

The route memo's L8 endgame **does not stay inside $F$**. After Branch
A secures value optimality ($U(\sigma^*)=U^*=V^*$ unrestricted), the
production of $\beta^*$ is moved entirely outside the Reny framework:

- $\ell_{\sigma^*}(m,s) := \sum_\omega s(\omega)p_\omega(m)$ where
  $p_\omega(m)=\int_\Theta\int_A u(a,\omega,\theta)\,\hat\sigma^*(da\mid
  m,\theta)\,f(d\theta\mid\omega)$ is the per-message payoff.
- Under hypothesis **(A8c-lsc)** — rowwise lower-semicontinuity of
  $\ell_{\sigma^*}(\cdot,s)$ for τ-a.e. $s$ — the pointwise minimum is
  attained τ-a.e., equals the essential inf, and admits a measurable
  selector $m^*:M\to M$ by Kuratowski–Ryll-Nardzewski applied to the
  rowwise minimizer correspondence $G(s)=\arg\min_m \ell_{\sigma^*}(m,s)$.
- Set $\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$.

This $\beta^*$ is a **Dirac kernel** — singular w.r.t. $\tau$ exactly
where Piotr predicted the optimal $\beta^*$ must live. It is in $B$,
**not** in $F$. The Reny restricted-game machinery is used as a *value
witness* for $\sigma^*$ only; the attainer is built directly on the
unrestricted side via measurable selection. L9 then promotes Branch A
+ L8c into full Definition 2 robust rationalizability (q-a.e.; τ-a.e.
when α > 0).

So the in-repo patched chain is:

| Step                   | Where it lives             | Reny's geometry?         |
|------------------------|----------------------------|--------------------------|
| Restricted-game $\sigma^*$ | $F\subset B$ (τ-AC)        | YES — needed for Mertens |
| Lusin lift (value)     | crosses $F\to B$           | Reny's intended step     |
| Producing $\beta^*$    | direct measurable selection in $B$ | **outside $F$ entirely** |
| Per-message Bayes-opt. | disintegration of $\beta^*$ | n/a                      |

This **does** escape Piotr's objection, but at a cost: (A8c-lsc) is an
added structural assumption, not derivable from the paper's standing
hypotheses. Generically (e.g., $\ell(m,s)=m$ on $[0,1]$ with
$\ell(0,s)=1$) the pointwise min fails to be attained, even when the
essential inf is finite. Cf. the route memo's "Half 2 DISPROVED under
standing + (A5) alone" entry.

## 4. Connection to the v8 / menu-engine line and to the closure memo

The closure memo (2026-05-07) records the final disposition:

> "Do not silently re-import infinite-dimensional saddle/minimax
> architectures (Sion, Tychonoff, Balder-Mertens-Lusin in the original
> Phil Reny form). These were tried in v3–v6 and superseded by the
> menu engine for clean reasons."

Piotr's 2026-05-19 objection is one of those "clean reasons" made
precise: the τ-AC restriction is *structurally* incompatible with the
paper's own Bregman-projection geometry as soon as $|\Omega|\ge 3$.
The menu engine in v7/v8 avoids the issue entirely by replacing the
infinite-dimensional compactness problem with a finite-dimensional
payoff-profile problem in $W$ — never restricting the adversary to a
τ-AC class.

The repo's Lemma 7 (cone intersection, WTA ternary) and Theorem 8
(no-free-dust theorem) are the formal sharpenings of Piotr's
observation: in WTA ternary under atomless τ, no τ-null dust set +
labeling + adversarial kernel can simultaneously satisfy positive
q-mass and Bayes-cone calibration. That is exactly Piotr's "the
adversary must concentrate on a τ-null Bregman fiber" objection,
sharpened into an obstruction theorem.

## 5. Take-aways

1. **Piotr is right about Reny's strategy as stated.** The τ-AC
   restriction $F$ cannot contain the attaining $\beta^*$ once
   $|\Omega|\ge 3$; the strategy at best delivers value-optimal
   $\sigma^*$ and ε-adversaries, not a saddle point.

2. **ChatGPT's verdict in the share is correct.** The split between
   "value layer survives modulo approximation" and "saddle-point /
   robust-rationalizability layer is broken" is the right diagnosis.

3. **The in-repo L8 work doesn't restart the Reny route — it
   side-steps it.** $\beta^*$ is produced by direct measurable
   selection on the rowwise minimizer correspondence, outside $F$. The
   cost is (A8c-lsc), an added structural hypothesis on
   $\ell_{\sigma^*}(\cdot,s)$.

4. **v8 (menu engine) is not threatened by this objection.** It
   doesn't go through the τ-AC restriction; it works on the
   finite-dimensional payoff-profile manifold $W$ via the menu engine.
   The Bregman-fiber geometry Piotr identifies is the *content* of v8's
   sharpness package (Lemma 7 + Theorem 8), not a flaw.

5. **Practical implication for restart attempts.** If anyone tries to
   reopen the Reny line for unrestricted $\beta^*$ (i.e., as a real
   route to Theorem 2 instead of just to value optimality), Piotr's
   objection is now the canonical reason it cannot work without
   stepping outside $F$. Add to the route memo's "banned re-proposals"
   list: *"any attempt to obtain the attaining $\beta^*$ from
   within $F$ when $|\Omega|\ge 3$ and $\tau$ is full-support smooth
   on the simplex"* — structurally blocked by the Bregman-fiber
   dimension count.
