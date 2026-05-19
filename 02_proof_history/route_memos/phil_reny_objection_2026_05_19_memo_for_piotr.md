# For Piotr — on the Reny-strategy objection

*Short answer: yes, your objection is correct as stated, and ChatGPT
read it right. The longer answer separates two layers of Theorem 2.*

## What you noticed

Phil's strategy restricts the misaligned adviser to densities
against the truthful marginal: $\pi(dm\mid s) = f(m\mid s)\bar G(dm)$.
You pointed out that for $|\Omega|\ge 3$ this rules out exactly the
optimal-adversary behavior we already know from the paper's
commitment-solution: bad AI, after seeing $s$, must concentrate on
messages that Bregman-project to a *single* trust-region point — and
the set of such messages is a lower-dimensional Bregman fiber inside
$\Delta(\Omega)$ (1-dimensional in the 3-state case). If $\bar G$ has
a smooth full-support density on the simplex, that fiber is
$\bar G$-null, so no $\beta_\varphi\in F$ can sit on it.

## What it kills, and what it doesn't

**Layer 1 — value of the agent's max-min problem.** Your objection
does *not* automatically kill this layer. Even if the optimal
$\beta^*$ is genuinely singular, you can still approximate its payoff
contribution by an absolutely-continuous kernel that concentrates
density in vanishing tubes around the singular support. This is
exactly what Reny's Lusin-lift step is supposed to deliver, and it
does — under the condition that $\sigma^*$ is approximately continuous
on a Lusin-thick compact and every state-conditional law sees the same
common-support compact. In the route memo this is called (A5)
($\pi(\cdot\mid\omega)\sim\tau$ for every $\omega$). Under (A5),
Branch A — existence of $\sigma^*$ with $U(\sigma^*)=U^*$ — does close.

**Layer 2 — the saddle point / robustly rationalizable strategy.**
Here your objection bites hard. Theorem 2 doesn't just want
$U(\sigma^*)=U^*$; it wants an actual $\beta^*\in B$ attaining the
infimum and inducing posteriors that justify $\hat\sigma^*$
message-by-message. If you ask whether $\beta^*\in F$, the answer is
*no* in any non-trivial multi-state geometry — the restricted dual
inf is an essential infimum over τ-AC kernels, and your Bregman-fiber
observation is the geometric reason it generically fails to be
attained inside $F$. So **Reny's strategy as literally stated cannot
deliver Theorem 2's existence direction.** Reny acknowledged this
("this gives an optimal strategy for player 1, but not for player 2")
without giving the geometric reason; you supplied it.

## What we did in the repo, and why it doesn't contradict you

After Branch A closed under (A5), we never tried to get $\beta^*$ from
inside $F$. We built it directly on the unrestricted side. Under one
additional hypothesis — (A8c-lsc), rowwise lower-semicontinuity of
the message-payoff function $\ell_{\sigma^*}(\cdot,s)$ for τ-a.e. $s$
— Kuratowski–Ryll-Nardzewski applied to the rowwise minimizer
correspondence $\arg\min_m \ell_{\sigma^*}(m,s)$ produces a measurable
selector $m^*(s)$, and we set
$$
\beta^*(dm\mid s) \;=\; \delta_{m^*(s)}(dm).
$$
This $\beta^*$ is a Dirac kernel — singular w.r.t. $\tau$, exactly
where your objection says the optimal $\beta^*$ must live. It is in
$B$, not in $F$. So the route's β\*-existence step deliberately leaves
the Reny restriction behind; (A8c-lsc) is the price we paid to do that
cleanly. (A8c-lsc) is real: it fails generically, and our reviewer in
fact disproved unconditional pointwise attainment under (A5) alone via
an explicit row counterexample.

The closure memo ultimately moved off this entire architecture
(menu engine in $W$-geometry instead) for exactly the reason your
objection makes precise: anything starting from "restrict the
adversary to a τ-AC class and recover the saddle by lifting"
encounters this Bregman-fiber dimension count as a structural wall.
Lemma 7 (cone intersection, WTA ternary) and Theorem 8 (no-free-dust)
in v8 are the formal sharpening of your observation: the optimal
adversary's mass cannot escape into a τ-null dust set without
breaking Bayes-cone calibration.

## Bottom line

1. **Your objection is correct** for Reny's strategy as stated, and
   the failure is at the attainment / saddle-point layer, not at the
   value layer.
2. **It does not threaten v8** (the menu engine doesn't go through
   the τ-AC restriction at all — its sharpness package is in fact the
   formal version of your observation).
3. **It does explain why we eventually abandoned the Reny line**: the
   in-repo patch needed (A5) + (A8c-lsc), neither of which is
   derivable from the paper's standing hypotheses, and the second one
   provably fails in general.

The longer, self-contained durable analysis is on disk at
`02_proof_history/route_memos/phil_reny_objection_2026_05_19.md`.
