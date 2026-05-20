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

---

## Pro second opinion (Extended Pro, two-pass prover + reviewer)

We ran the question through ChatGPT Extended Pro on two independent
sessions: a *prover* asked for a fresh adversarial verdict (chats:
`6a0ce500-c980-...`), and a *reviewer* on a separate session asked to
challenge the prover (`6a0ce8de-4fa8-...`). Both responses are on disk
in `02_proof_history/route_memos/pro_prover_response.md` and
`pro_reviewer_response.md`. Verdicts converge: the in-repo position
above is correct in substance, with four specific tightenings flagged
by the reviewer.

### Where prover and reviewer agree (PATCH_SMALL on all four)

- **Piotr's objection is right against exact $F$-attainment**, under
  precise conditions: $|\Omega|\ge 3$, $\tau$ equivalent to
  $d$-dimensional Lebesgue on a full-dimensional region of
  $\Delta(\Omega)$, regular trust-region boundary, uniqueness of the
  rowwise minimizer $\mu(s)$ on a positive-$\tau$ set, $P^{-1}(\mu(s))$
  contained in lower-dimensional $C^1$ submanifolds, strict
  off-fiber payoff. Under those conditions exact $F$-attainment is
  impossible; the optimal $\beta^*$ must be singular (Dirac in $B$).
- **Branch A value-optimality survives**: a Lusin-thick stratified
  $\tau$-AC tube construction approximates any $\beta\in B$ in payoff
  against $\sigma^*$, so the restricted-game value lifts.
- **L8c's Dirac selector genuinely escapes the objection at the
  attainment layer.** It moves the singularity from a forbidden class
  $F$ to the admissible $B$. (A8c-lsc) is a strong, non-generic
  regularity assumption, not derivable from (A5).
- **Full robust rationalizability is not free.** Rowwise minimization
  + lsc does not imply Bayes-cone calibration after message pooling;
  that gap is precisely menu-Hall in v8 (or, more generally,
  deletion-compatible Hall duality in the closure memo's open-object
  language).

### What the reviewer tightened (the four PATCH_SMALL items)

1. **Claim 1 — "rich-private-strategy geometry" is too broad.** The
   null-fiber conclusion needs explicit full-dimensional $\tau$ + a
   regular trust-region boundary + strict off-fiber payoff + a
   genuine lower-dimensional fiber. The paper's *baseline* hypotheses
   do not include differentiability / strict convexity of $U$; those
   come from the rich-strategy section. Also, missed cases: $M$
   supported on a lower-dimensional subset; atomic / mixed $\tau$;
   non-smooth corners with full-dim normal cones; degenerate decision
   problems (flat indirect utility); $\alpha = 1$ (objection becomes
   formal, not substantive).
2. **Claim 2 — L6 needs a *stratified* tube construction.**
   "Continuity on each $K_n$" is not uniform across $\bigcup_n K_n$;
   the smoothing kernel $q_\varepsilon(\cdot\mid y)$ must concentrate
   inside a *single* compact stratum where the payoff coordinates
   $p_\omega$ are continuous. The reviewer gives the explicit safe
   construction: assign each $y$ to its first stratum $i(y)$, set
   $q_\varepsilon(z\mid y) = \mathbf{1}\{z\in B_\varepsilon(y)\cap K_{i(y)}\}/\tau(B_\varepsilon(y)\cap K_{i(y)})$,
   anchor off-$K^*$ at a fixed $s_0$. The denominator is positive by
   support-thickness on each stratum. (A5) is overstrong; a leaner
   "Lusin-thick support-thickness for $\tau$" suffices.
3. **Claim 3 — escape is genuine but narrow.** L8c gives *exact
   rowwise adversary attainment*; it does NOT give a saddle point
   with calibration. The label-regularity (tie-breaking on Bayes-cone
   boundaries) is the small knife the prover missed. Also: the
   "$\ell$ is a Borel normal integrand" step requires lsc on a Borel
   full-measure set, not merely on an unspecified $\tau$-a.e. set —
   else the argmin graph can be analytic and only Jankov–von Neumann
   selection (universal measurability) applies; that is fine for
   $q$-a.e. statements but not for everywhere-Borel ones.
4. **Synthesis — the open object is sharper than "Hall duality."**
   The reviewer reframes it as an *endogenous-marginal constrained
   weak-transport theorem with obedience cones*: it is not plain
   Strassen/Kellerer (the second marginal $q$ is endogenous to $\kappa$),
   not plain martingale or weak OT (rowwise-support constraint
   $m\in G(s)$ and Bayes-cone conditional-barycenter constraint are
   coupled), and not plain persuasion duality (sourcewise deletion
   certificates must match messagewise calibration). Also: exact
   Dirac selection is too rigid — set-valued mixing over $G(s)$ is
   the right level of generality, which is exactly what v8's
   menu-Hall already allows.

### What did NOT survive examination

Nothing was refuted. No PATCH_BIG was issued. Both passes converge on
the same overall reading.

### Net answer to Piotr

Your objection is correct. ChatGPT's read in your share is correct.
The route's L8c patch escapes it at the attainment layer (by leaving
$F$), but the calibration layer — making the message posterior land
in the agent's Bayes cone after pooling sources — does not come along
for the ride, and that is exactly the gap the closure memo named as
the deletion-compatible Hall duality theorem (the reviewer suggests
the sharper framing: an *endogenous-marginal constrained
weak-transport theorem with obedience cones*). v8's menu engine is
the cleaner architecture for the value side and is not threatened by
your objection; v8's sharpness package (Lemma 7 + Theorem 8) is the
formal version of your geometric observation.

The two recommendations both passes converge on, if anyone tries to
revive the Reny line:
1. Press on **L9 (calibration), not L6 (value)** — value approximates
   via tubes; calibration does not.
2. Look for a **constrained weak-transport / Hall theorem with
   Bayes-cone obedience**, not another absolutely-continuous minimax.
