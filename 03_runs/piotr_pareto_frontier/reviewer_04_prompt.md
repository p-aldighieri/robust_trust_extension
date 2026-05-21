# Reviewer pass 04 — Verify Lemma B1 (binary scalar endpoint-fiber lift)

## Role

You are an independent Reviewer (fresh chat). You are reading a proof of
**Lemma B1 (Binary scalar endpoint-fiber lift)** from
`prover_05_response.md` (durable source). The prover self-verdicted
PATCH_SMALL with two technical stipulations folded into the proof:
empty-target convention, and no-extra-fiber-traffic.

## Why this lemma matters

Lemma B1 is the **gate-unlocking cog** identified by Searcher 03 for the
binary-state route to the original-game existence direction of
Theorem 2 (infinite \(M\), \(\Theta\), any \(\alpha\in(0,1)\)). If B1
PASSes, the remaining five lemmas in the binary chain (TRS interval
reduction, endpoint-only adversarial image, interior calibration,
endpoint stationarity, capstone assembly) are interval geometry plus
standard citations.

## What you are reviewing

**Lemma B1 (statement, with stipulations as folded in by the prover).**

Let \(p\in[0,1]\), \(A_-\subseteq M\cap[0, p]\), \(S_+\subseteq M\cap[p, 1]\)
be Borel. Let \(\alpha\in(0,1)\). Define finite positive measures
\[
\eta(X) = \alpha\!\int_{X\cap A_-}\!(p-m)\,\tau(dm), \quad
\nu(Y) = (1-\alpha)\!\int_{Y\cap S_+}\!(s-p)\,\tau(ds).
\]
Assume \(\eta(A_-) = \nu(S_+) < \infty\). Then:

**Claim 1**: There exists a Borel kernel \(\kappa: S_+\to\Delta(A_-)\)
realizing the balance identity
\[
(1-\alpha)\!\int_{S_+}\!(s-p)\,\kappa(X\mid s)\,\tau(ds) = \alpha\!\int_X\!(p-m)\,\tau(dm), \quad X\in\mathcal B(A_-),
\]
**under the empty-target convention** (when \(A_-=\emptyset\) and
\(\nu(S_+)=0\), the kernel is the empty kernel; when \(\nu(S_+)>0\) but
\(A_-=\emptyset\), no kernel exists — substantive case is \(A_-\ne\emptyset\)
or \(\nu(S_+)=0\)).

**Claim 2**: With \(\hat\beta(\cdot\mid s) = \kappa(\cdot\mid s)\) for
\(s\in S_+\) and \(\hat\beta(\cdot\mid s)\) **NOT routing into \(A_-\)**
for \(s\notin S_+\) ("no extra fiber traffic" stipulation), the
disintegration posterior at \(q\)-a.e. \(m\in A_-\) is the constant \(p\).

**Claim 3**: Symmetric statement on \(A_+\subseteq M\cap[p,1]\) and
\(S_-\subseteq M\cap[0,p]\), with signs flipped.

## Specific checks

### Step 1 — Balance as a transport problem
- Verify the prover's reduction of Claim 1 to coupling existence.
- Cite: Kallenberg 1997 Thm 6.10 or Aliprantis-Border Ch.19 — confirm
  the prover used the right citation.

### Step 2 — Disintegrate to get \(\kappa\)
- Verify the rescaling step (\(\nu/\bar\nu\) gives the (1-α)(s-p)
  weighting). The rescaling factor enters the balance identity.
- Confirm the kernel is Borel (standard from Polish-space disintegration).

### Step 3 — Compute the posterior on \(\Omega=\{0,1\}\)
- Verify the prover's Bayes-rule calculation using the joint measure
  on \((s, m, \omega)\) under the adversary kernel.
- Confirm \([P_{\hat\beta}(\omega=1\mid m)]\) integrates correctly via
  Radon-Nikodym.

### Step 4 — Use the balance identity
- This is the load-bearing computation. Verify that
  \(\alpha\!\int_X\!m\,\tau(dm) + (1-\alpha)\!\int_{S_+}\!\kappa(X\mid s)\,s\,\tau(ds) = p\,q(X)\)
  follows from the balance identity by simple algebra.
- Therefore \(\E[\omega=1\mid m\in X] = p\) for \(q\)-positive \(X\subseteq A_-\).

### Step 5 — Symmetric (Claim 3)
- Verify the sign-flip carefully. \(A_+\) is on the high side of \(p\),
  \(S_-\) on the low side.

### Cross-cutting

- **No atomlessness**: verify the proof doesn't sneak it in.
- **No density**: verify no \(d\tau/dm\) is used.
- **Empty-target convention**: confirm the prover handles edge cases
  cleanly.
- **No-extra-fiber-traffic**: confirm Claim 2 is read correctly in the
  presence of this stipulation.

### Sanity check
- Verify the prover's worked example (τ uniform on [0,1], p=1/2, etc.)
  gives a coupling with posterior 1/2 on the left fiber.

## Verdict format

- **PASS** — proof is correct, stipulations are reasonable.
- **PATCH_SMALL** — small fixes needed (state and how).
- **PATCH_BIG** — substantive gap.
- **DISPROVED** — counterexample.
- **HOLD** — need more info.

## Output Contract

- Inline as plain markdown.
- This is fresh-context review; do not trust prover's claims.
- End with one-line verdict + next-step signal.

## Constraints

- Banned tools list applies.
- Stay focused on B1; do NOT redo the v9 finite-menu theorem.
