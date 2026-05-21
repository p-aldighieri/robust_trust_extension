# Prover pass 06 — Binary chain Lemmas L_B3 + L_B5

## Role

You are the Prover. Lemma B1 (binary scalar endpoint-fiber lift) is
in flight to fresh-chat reviewer 04. While that's checked, your job
is to prove the two remaining substantive lemmas in the binary chain:

- **L_B3 (Endpoint-only adversarial image)**.
- **L_B5 (Endpoint stationarity / total-balance condition)**.

The two remaining trivial lemmas (L_B2 TRS interval reduction = direct
cite of paper Theorem 1; L_B4 interior calibration = free under TRS)
plus the capstone assembly L_B6 will follow in a downstream pass.

Context: durable sources include `prover_05_response.md` (B1),
`searcher_03_response.md` (Island 1 detail), `piotr_pareto_frontier_route_memo.md`,
`exposition_v9.tex`/.pdf (v9 with finite-menu T1), the paper PDF.

## Setup (binary state, recap)

- \(\Omega = \{0,1\}\); beliefs \(\mu\in[0,1]\); source posterior
  \(s\in[0,1]\sim\tau\); \(M = \operatorname{supp}\tau\subseteq[0,1]\).
- \(A, \Theta\) compact metric; \(u(a,\omega,\theta)\) bounded continuous in \(a\).
- \(\alpha\in(0,1)\) (substantive regime).
- Paper Theorem 1: optimal \(\sigma^*\) is a TRS with connected trust
  region \(T = [L, R]\), \(0\le L\le R\le 1\).
- \(W = \{w\in\R^2 : \exists\hat\sigma, w(\omega) = \E_{\hat\sigma}[u\mid\omega]\}\)
  convex compact in \(\R^2\). \(W^P\) = upper boundary curve.
- For each interior belief \(\mu\in[0,1]\), let \(w^*(\mu)\in\arg\max_{w\in W}\mu\cdot w\)
  (Bayes-optimal profile at \(\mu\)). \(w^*\) is upper-hemicontinuous;
  single-valued except at finitely many "kink" beliefs (paper Lemma 1
  of Appendix A.6 in the smooth case).

## Lemma L_B3 — Endpoint-only adversarial image

**Hypotheses.** Standing + \(|\Omega|=2\) + TRS with \(T=[L,R]\),
\(L<R\) (the case \(L=R\) is degenerate). \(\sigma^*\) is the TRS
strategy: \(\hat\sigma^*(m) = R(w^*(\Pi_T(m)))\) where \(\Pi_T:[0,1]\to[L,R]\)
is the Bregman projection.

**Statement.** Among all Borel kernels \(\beta:M\to\Delta(M)\), there
exists an adversarial best response \(\beta^*\) (i.e., one attaining
the infimum of the misaligned-term in \(U\)) such that for
\(\tau\)-a.e.\ \(s\in[0,1]\),
\[
\operatorname{supp}\beta^*(\cdot\mid s) \;\subseteq\; \{L, R\}.
\]

In words: the optimal adversary sends only the two trust-region
endpoints, never an interior message.

**Tools.** Paper Lemma 1 (Appendix A.6, smooth case) gives the smooth
version. For the nonsmooth case, use:

1. **Convexity of \(w\mapsto s\cdot w\)** on each row \(s\in[0,1]\):
   it's linear in \(w\), so over the compact menu \(C^* = w^*(T)\),
   the min is attained at an extreme point. \(C^*\) is the image of
   the interval \(T = [L, R]\) under \(w^*\); since \(w^*\) is
   continuous on \(T\) with image on the upper boundary of \(W\), \(C^*\)
   is a continuous curve on the upper boundary, parametrized by
   \(\mu\in[L,R]\).
2. The function \(\mu\mapsto s\cdot w^*(\mu)\) is **concave** on \([L,R]\)
   (because the support function of \(W^P\) restricted to a 1-parameter
   family of beliefs is concave). Therefore its minimum on \([L,R]\) is
   attained at an endpoint: either \(\mu = L\) or \(\mu = R\).
3. Conclude: \(s\cdot w^*(\mu)\) is minimized at \(\{L, R\}\) for every
   \(s\), with potential ties at intermediate \(\mu\) only on a
   \(\tau\)-null set.

**Proof outline.**
- Step 1: \(w^*\) is continuous on \([L,R]\) (standard from
  upper-hemicontinuity of supporting profile + connectedness of
  \([L,R]\)). The image \(C^* = w^*([L,R])\) is a connected curve.
- Step 2: \(\mu\mapsto s\cdot w^*(\mu)\) is concave on \([L,R]\). To see
  this: \(s\cdot w^*(\mu) = \max_{w\in W} s\cdot w\) restricted to
  \(w\) supporting at \(\mu\). By envelope theorem (Milgrom-Segal),
  this is the support function \(h_W(s)\) ... wait this isn't quite right.

  More carefully: \(s\cdot w^*(\mu)\) is the value of the BAYES action
  at belief \(\mu\), evaluated at the TRUE state distribution \(s\).
  This is the function \(s\cdot w^*(\mu) = \E_{R(w^*(\mu))}[u\mid s]\),
  where the expectation is over actions chosen by the agent assuming
  belief \(\mu\) but states distributed by \(s\). This is a difference
  between actual and assumed beliefs.

  Claim: \(\mu\mapsto s\cdot w^*(\mu)\) is concave in \(\mu\) for fixed \(s\).
  Reason: \(w^*(\mu)\) is the upper envelope of linear functionals
  \(\mu\mapsto\mu\cdot w\) over \(w\in W\); but we're evaluating
  \(s\cdot w^*(\mu)\), not \(\mu\cdot w^*(\mu)\). So the concavity
  argument needs care.

  Alternative: in binary state, \(W^P\) is a 1-d curve with parameter
  \(\mu\). The map \(\mu\mapsto w^*(\mu)\in\R^2\) is a monotone arc:
  one component increases, the other decreases (since you move along
  the upper-right boundary of \(W\)). Therefore \(s\cdot w^*(\mu)\) is
  a difference of monotone scalar functions in \(\mu\), making it
  monotone or unimodal but possibly NOT concave.
- Verify carefully. If the unimodality / endpoint-min claim fails for
  generic \(s\), state the precise structural condition needed.

\paragraph{Alternative attack via Theorem 1.} Paper Theorem 1's proof
already analyzes the adversary's BR in binary. Specifically, paper
Section 4.2 / Appendix A.6 derives the endpoint-only adversary in the
smooth case. The nonsmooth extension is by upper-semicontinuity of
the min over closed sets.

\paragraph{Cleanest path.} Use the binary-state argument from paper
Section 4.2 plus standard nonsmooth-envelope-theorem tools
(Aubin-Frankowska §8). If the smooth case suffices for our application
under standing+regularity, state that.

## Lemma L_B5 — Endpoint stationarity (total-balance)

**Hypotheses.** Standing + \(|\Omega|=2\) + TRS \([L,R]\) is the optimal
trust region (so \([L,R]\in\arg\max_{[L,R]\subset[0,1]} F([L,R])\) where
\(F([L,R]) = \int[\alpha\max_{w\in C^*}s\cdot w + (1-\alpha)\min_{w\in C^*}s\cdot w]\,d\tau\)
with \(C^* = w^*([L,R])\)). \(\alpha\in(0,1)\).

**Statement.** Define the high-source rowwise-minimizer region
\(S_+ = \{s\in[0,1]: w^*(L) = \arg\min_{w\in C^*}s\cdot w\}\) and the
low-source rowwise-minimizer region \(S_- = \{s\in[0,1]: w^*(R) = \arg\min\}\).
Then:
\[
\alpha\!\int_{[0,L]}\!(L-m)\,\tau(dm) \;=\; (1-\alpha)\!\int_{S_+}\!(s-L)\,\tau(ds),
\]
\[
\alpha\!\int_{[R,1]}\!(m-R)\,\tau(dm) \;=\; (1-\alpha)\!\int_{S_-}\!(R-s)\,\tau(ds).
\]

In words: at the optimal trust region, the "aligned deficit" (the
mass aligned-truthful sources put below the trust-interval endpoint
\(L\), weighted by signed distance) equals the "misaligned surplus"
(the high-source mass routed to \(L\), weighted by signed distance);
symmetric for the right endpoint \(R\).

**Tools.** Apply Theorem T1 from v9 (finite-menu Pareto-Hall calibration
via Clarke-Danskin) with \(k\le 2\) (since \(C^*\) is the curve
\(w^*([L,R])\) but the active argmin/argmax cells force the multipliers
to be supported on at most the two endpoint profiles \(\{w^*(L), w^*(R)\}\)).
The total-balance equation is the Lagrange-multiplier balance condition
from T1's Step 5 / Lemma 8 in v9.

**Alternative**: paper Equations (6)-(7) in Appendix A.6 give the
smooth-density version directly (FOC of \(F\) with respect to \(L\) and
\(R\) — interior partial derivatives equal zero at the optimum).

**Proof outline.**
- Step 1: identify the active labels as \(\{w^*(L), w^*(R)\}\) under TRS.
  Aligned mass on interior \([L,R]\) routes to the corresponding
  interior label \(w^*(m)\), which is NOT active for argmin.
- Step 2: the only argmin-active labels are \(w^*(L)\) and \(w^*(R)\),
  carrying weights \(\lambda^-_L\) and \(\lambda^-_R\). Their normalized
  posteriors must be in \(B_W(w^*(L))\) and \(B_W(w^*(R))\) respectively.
- Step 3: in binary, \(B_W(w^*(L)) = \{L\}\) and \(B_W(w^*(R)) = \{R\}\)
  (the Bayes belief is uniquely \(L\) for \(w^*(L)\)). So the
  normalized posterior at label \(L\) must equal \(L\), which gives
  the stationarity equation.
- Step 4: rearrange the equation in terms of \(\tau\) integrals to
  get the displayed total-balance form.

## What I want you to produce

For both L_B3 and L_B5, produce fully rigorous proofs.

```
# Lemma L_B3 — Endpoint-only adversarial image

## Statement
(Restate.)

## Hypotheses (standing + binary + TRS [L,R] with L<R)

## Proof
- Step 1: w*: [L,R] → W^P continuous, monotone arc.
- Step 2: μ ↦ s·w*(μ) structural property; verify endpoint-min for τ-a.e. s.
- Step 3: conclude adversary's BR is concentrated on {L, R}.

## Compatibility with paper Lemma 1 of Appendix A.6
(Confirm and identify how this extends to nonsmooth U.)

# Lemma L_B5 — Endpoint stationarity (total-balance)

## Statement
(Restate.)

## Hypotheses (standing + binary + TRS [L,R] is the optimal trust region)

## Proof (via v9 T1)
- Step 1: active labels under TRS are {w*(L), w*(R)}.
- Step 2: Lagrange multipliers from v9 T1 give λ^- supported on {L,R}.
- Step 3: B_W(w*(endpoint)) = singleton {endpoint}.
- Step 4: rearrange to total-balance form.

## Compatibility with paper equations (6)-(7) in Appendix A.6
(Confirm consistency in the smooth-density case.)

# Combined corollary

Total-balance condition holds:
- η_L(M) = ν_L(M) for the left endpoint.
- η_R(M) = ν_R(M) for the right endpoint.

Where η_L, ν_L are as in Lemma B1 with p=L, and η_R, ν_R as in B1 with p=R.

Therefore Lemma B1 applies on each endpoint fiber, yielding kernels
κ_L, κ_R lifting to the original game.
```

## Output Contract

- Inline as plain markdown.
- Be rigorous about Step 2 of L_B3 (the structural claim about
  μ↦s·w*(μ)). This is the load-bearing nonsmooth step.
- L_B5 follows from v9 T1 + binary geometry — should be clean.
- End with one-line verdict on YOUR own proofs + next-step signal
  (probably: "fire capstone assembly L_B6").

## Constraints

- Banned re-proposals: see prior_attempts_digest.md.
- Use v9 T1 for L_B5 (citation to v9 exposition).
- Keep binary throughout — do not generalize to |Ω|≥3 here.
- Per user instruction: do not stop, if either lemma fails, identify
  the missing ingredient.
