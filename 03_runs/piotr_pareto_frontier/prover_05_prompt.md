# Prover pass 05 — Lemma B1: Binary scalar endpoint-fiber lift

## Role

You are the Prover. Pass 3+'s Prover 04 (strict convexity + TRS) failed at
Step 5: the Bregman normal direction does not in general equal the
supporting hyperplane direction at \(w^*(m)\). Searcher 03 surveyed
four special primitive islands and identified **binary state |Ω|=2**
as the only island that genuinely changes the type of the locked gate.
In binary, the original-message Hall lift becomes two scalar endpoint
transports on the real line — no multidimensional Bayes cones.

This pass attacks the gate-unlocking lemma identified by Searcher 03.

## Setup recap

**Binary state primitive (\(H_{bin}\))**:
- \(\Omega = \{0, 1\}\); beliefs \(\mu\in\Delta(\Omega)\) identified with
  \(\mu(1) \in [0,1]\). Source posterior \(s\in[0,1]\), distribution \(\tau\),
  \(M = \operatorname{supp}\tau\subseteq[0,1]\).
- \(A\), \(\Theta\) compact metric; \(u(a, \omega, \theta)\) bounded
  continuous in \(a\). \(\alpha\in(0,1)\) (the substantive regime; \(\alpha=0,1\)
  are degenerate peels).
- Paper Theorem 1: optimal \(\sigma^*\) is a TRS with **connected trust
  region** \(T\subseteq[0,1]\). Connected closed in \([0,1]\) means
  \(T = [L, R]\) for some \(0\le L \le R\le 1\).
- By paper Section 4.2 / Appendix A.6, misaligned adviser's optimal
  response in the smooth-density case has image only at the endpoints
  \(\{L, R\}\): high sources \(s > b\) (for some threshold \(b\)) route
  to \(L\), low sources \(s < b\) route to \(R\), in expectation.

## The lemma to prove

**Lemma B1 (Binary scalar endpoint-fiber lift).**

Let \(p\in[0,1]\), \(A_-\subseteq M\cap(-\infty, p]\), and \(S_+\subseteq M\cap[p, \infty)\)
be Borel. Let \(\alpha\in(0,1)\). Define finite positive measures on \(A_-\)
and \(S_+\) respectively:
\[
\eta(X) \;=\; \alpha\!\int_{X\cap A_-}\!(p - m)\,\tau(dm), \qquad \nu(Y) \;=\; (1-\alpha)\!\int_{Y\cap S_+}\!(s - p)\,\tau(ds).
\]

Assume the **total-balance condition**:
\[
\eta(A_-) \;=\; \nu(S_+) \;<\; \infty.
\]

**Claim 1 (existence of balanced coupling).** There exists a Borel
kernel \(\kappa: S_+\to\Delta(A_-)\) such that for every Borel
\(X\subseteq A_-\),
\[
(1-\alpha)\!\int_{S_+}\!(s - p)\,\kappa(X\mid s)\,\tau(ds) \;=\; \alpha\!\int_X\!(p - m)\,\tau(dm).
\]

**Claim 2 (posterior calibration).** Define the joint adversary law
\(\hat\beta(\cdot\mid s) = \kappa(\cdot\mid s)\) on \(S_+\) (and arbitrary
elsewhere). With \(\gamma_\alpha = \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\hat\beta\)
and \(q := (\gamma_\alpha)_2\), the disintegration posterior on
\(\Omega = \{0, 1\}\) satisfies
\[
P_{\hat\beta}(\cdot\mid m) \;=\; p \;\equiv\; \delta_p \text{ in $\Delta(\Omega)$-coordinates}, \qquad \text{for $q$-a.e. $m\in A_-$.}
\]

**Claim 3 (symmetric version).** State and prove the symmetric
version on \(A_+\subseteq M\cap[p, \infty)\), \(S_-\subseteq M\cap(-\infty, p]\),
with the roles of \(\eta\) and \(\nu\) reversed.

## Why this is the gate-unlocking step

In v8 and Pass 3, the lift from payoff-label calibration to original-game
messagewise calibration required (D2)/menu-Hall — a multidimensional
transport problem that hits Borel→compact non-monotonicity, label-fiber
lift gaps, and slack discipline issues. In binary state, both fibers
\(A_-\) (left endpoint) and \(A_+\) (right endpoint) are 1-dimensional
subsets of \([0,1]\); the lift is a pair of 1D measure-coupling problems.
Standard tools (Kantorovich-Rubinstein, Strassen, even just standard
kernel disintegration on Polish spaces) should give existence
unconditionally.

## Proof outline

### Step 1 — Balance equation as a transport problem

Restate Claim 1 in transport form. Define probability measures
\(\bar\eta = \eta / \eta(A_-)\) on \(A_-\) and \(\bar\nu = \nu / \nu(S_+)\)
on \(S_+\). Since the total masses agree, any coupling
\(\gamma\in\Gamma(\bar\nu, \bar\eta)\) (joint law on \(S_+\times A_-\)
with marginals \(\bar\nu, \bar\eta\)) gives an admissible \(\kappa\)
via disintegration:
\[
\gamma(ds, dm) \;=\; \bar\nu(ds)\,\bar\kappa(dm\mid s), \qquad \kappa(dm\mid s) := \bar\kappa(dm\mid s).
\]
Verify the displayed balance identity reduces to "the coupling has
correct marginals after rescaling by \(s - p\) (resp.\ \(p - m\))".

**Tool**: standard coupling existence on Polish spaces (Kallenberg
*Foundations of Modern Probability* 1997, Thm 6.10, or
Aliprantis-Border Ch.19). Any coupling works; uniqueness not needed.

### Step 2 — Disintegrate to get \(\kappa\)

From the coupling \(\gamma\), disintegrate over its first marginal
\(\bar\nu\) (on a standard Borel space) to get a Borel kernel
\(\bar\kappa: S_+\to\Delta(A_-)\). Compose with the rescaling to
recover \(\kappa\) satisfying Claim 1.

**Subtlety**: the rescaling \(\nu / \tau = (1-\alpha)(s-p)\) is not a
probability density — it's a finite positive density. The kernel
\(\kappa\) satisfies the balance equation **including** the rescaling.
Spell this out carefully.

### Step 3 — Compute the posterior on \(\Omega\)

The joint measure on \((s, m, \omega) \in S_+\times A_-\times\Omega\)
under the adversary kernel decomposes as:
\[
\Pr(s, m, \omega) \;=\; \mu_0(\omega)\,\pi(s\mid\omega)\,\hat\beta(m\mid s).
\]
But more usefully, write the conditional posterior at message \(m\) using
the joint marginal law of \((s, m)\):

\[
P_{\hat\beta}(\omega = 1\mid m) \;=\; \frac{\alpha\,m\,\tau(\{m\})\,\mathbf{1}_{A_-}(m) + (1-\alpha)\!\int_{S_+}\!s\,\kappa(\{m\}\mid s)\,\tau(ds)}{\alpha\,\tau(\{m\})\,\mathbf{1}_{A_-}(m) + (1-\alpha)\!\int_{S_+}\!\kappa(\{m\}\mid s)\,\tau(ds)}.
\]

For \(\tau\) atomless OR for \(m\) outside \(M\), set things up with
densities or with Bayes' rule via Radon-Nikodym on the joint law over
\((s, m)\). In any case, the posterior at \(m\in A_-\) should equal
\(p\). Verify this calculation directly.

### Step 4 — Use the balance identity

From the balance identity (Claim 1) plus the definition of \(\eta\) on
\(A_-\):

\[
(1-\alpha)\!\int_{S_+}\!\kappa(X\mid s)(s - p)\,\tau(ds) \;=\; \alpha\!\int_X\!(p - m)\,\tau(dm)
\]

for every Borel \(X\subseteq A_-\). Rearranging:

\[
\alpha\!\int_X\!m\,\tau(dm) + (1-\alpha)\!\int_{S_+}\!\kappa(X\mid s)\,s\,\tau(ds) \;=\; p\,\Big[\alpha\!\int_X\!\tau(dm) + (1-\alpha)\!\int_{S_+}\!\kappa(X\mid s)\,\tau(ds)\Big].
\]

The LHS is the numerator of the posterior expectation \(\E[\omega = 1\mid m\in X]\)
under the joint law. The bracket on the RHS is the message marginal mass
\(q(X)\). Therefore \(\E[\omega = 1\mid m\in X] = p\) for every Borel
\(X\subseteq A_-\) with \(q(X) > 0\).

This is exactly "posterior at every left-fiber message equals \(p\)".

### Step 5 — Symmetric (Claim 3)

State and prove the symmetric \(A_+, S_-\) version. The argument is
identical with signs flipped: aligned mass on \(A_+\) with weight
\(\alpha(m - p)\), misaligned routing from \(S_-\) with weight
\((1-\alpha)(p - s)\). Balance \(\bar\eta_+(A_+) = \bar\nu_-(S_-)\)
gives a coupling, disintegration gives \(\kappa_R: S_-\to\Delta(A_+)\),
balance identity gives \(\E[\omega = 1\mid m\in X] = p\) for
\(X\subseteq A_+\). \(\square\)

## What I want you to produce

A FULLY RIGOROUS proof of Lemma B1, in the following structure:

```
# Lemma B1 — Binary scalar endpoint-fiber lift

## Statement (Claims 1, 2, 3)
(Restate exactly.)

## Hypotheses used
- p ∈ [0,1].
- A_-, S_+ Borel subsets of [0,1] (M is standard Borel).
- α ∈ (0,1).
- η(A_-) = ν(S_+) < ∞ (total-balance condition).
- τ is a Borel probability measure on M; NO atomlessness assumed; NO
  density assumed.

## Tools cited
- Disintegration on Polish spaces (Kallenberg 1997 Thm 6.10).
- Standard coupling existence (Aliprantis-Border Ch.19).
- Bayes' rule on finite state space + Radon-Nikodym.

## Proof
### Step 1 — Balance as transport
### Step 2 — Disintegrate
### Step 3 — Compute posterior
### Step 4 — Use balance identity
### Step 5 — Symmetric version

## Sanity check
Take τ = uniform on [0,1], p = 1/2, A_- = [0, 1/2], S_+ = [1/2, 1],
α = 1/2. Compute η, ν explicitly. Verify balance, exhibit a coupling
(e.g., the comonotone one), compute the posterior. Confirm it equals
1/2 on A_-.

## Compatibility with v8 sharpness package
The WTA ternary witness is multi-state |Ω|=3. Lemma B1 is binary
|Ω|=2 only. No conflict.

## Open issues
- Lemma B1 is the GATE for binary. Remaining lemmas in the 6-lemma
  binary chain: TRS interval reduction (Theorem 1, direct cite),
  endpoint-only adversarial image (Lemma 1 of paper Appendix A.6,
  needs nonsmooth extension), interior message calibration (free),
  endpoint stationarity (k≤2 Clarke-Danskin from T1 of v9), assemble
  β*, q-a.e. Bayes verification.
```

## Output Contract

- Inline as plain markdown.
- This is a CLEAN measure-theoretic lemma. The proof should be ~2-3 pages.
- Do NOT use atomless τ unless you must.
- Do NOT use smoothness or density of τ.
- Cite the standard tools precisely.
- End with a one-line verdict (PASS/PATCH_SMALL/PATCH_BIG/HOLD) on
  YOUR OWN work — but the actual review will be on a fresh reviewer
  chat. Plus a next-step signal for the next prover (which remaining
  lemma in the binary chain to attack).

## Constraints

- Banned re-proposals: see `prior_attempts_digest.md`.
- This lemma is genuinely new — it's not in v8 and not in the
  closure-memo Routes 1+2.
- Per user instruction: if the lemma fails, go back to the drawing
  board and try another angle. Do NOT stop.
