# Searcher pass 02 — Primitive sufficient conditions for (D2)

## Role

You are the Searcher (final long-shot pass). The Pareto-frontier route
has hit the same locked gate as v8's deletion-compatible Hall duality,
but in the cleaner Lagrange-multiplier coordinates of (D2) finite-fiber
calibrated matching.

This pass asks: **is there a primitive sufficient condition for (D2)
strictly weaker than menu-Hall?**

If yes → the route extends to original-game Theorem 2 under a
publishable economic primitive.

If no → we honestly conclude the locked gate is structural across all
known reformulations, and accept the conditional theorem architecture.

## What (D2) requires (recap from `prover_03_response.md`)

**Setup.** Finite menu \(C^* = \{w_1,\ldots,w_k\}\subseteq W^P\) a
Pareto-completed ambient local maximizer of \(F_k\). Multipliers
\(\lambda^\pm:M\to\Delta(k)\) from Lemma 8. Fibers \(F_i := (w^*)^{-1}(\{w_i\})\)
of the aligned-best labeling \(w^*:M\to C^*\).

**(D2) condition.** There exists a Borel kernel \(\hat\beta^*: M \to \Delta(M)\)
with:

- (D2.1) For τ-a.e.\ \(s\), \(\hat\beta^*(F_i\mid s) = \lambda^-_i(s)\)
  (first marginal of misaligned label-routing matches Lemma 8's
  multiplier).
- (D2.2) Rowwise-minimizer support: \(\hat\beta^*(F_i\mid s) > 0\)
  implies \(w_i \in \arg\min_j s\!\cdot\!w_j\) τ-a.e.
- (D2.3) Messagewise Bayes-cone calibration: the disintegration
  posterior \(P_{\hat\beta^*}(\cdot\mid m)\) lies in \(B_W(w^*(m))\)
  for \(q\)-a.e. \(m\in M\).

(D2) is essentially the assertion that a calibrated kernel exists with
the prescribed label-flow profile.

## Candidate primitive conditions for (D2)

Rank these and propose new ones:

### C1. Atomless τ + fiber-richness
Each fiber \(F_i\) has positive \(\tau\)-mass: \(\tau(F_i) > 0\) for
every \(i\) with \(q^-_i > 0\). Combined with atomless \(\tau\): there's
"room" inside each fiber to redistribute mass for calibration.

**Question**: under C1, does a fiber-rich splitting theorem with
vector-balance inequalities deliver a calibrated kernel?
References: Lyapunov convexity theorem for atomless vector measures;
Dvoretsky-Wald-Wolfowitz on purification.

### C2. Single-valued Gauss map at \(C^*\)
The supporting Bayes belief at each \(w_i\) is unique:
\(N_W(w_i)\cap\Delta(\Omega) = \{\mu_i\}\) for each \(i\). Then (D2.3)
collapses to a single equation per label: \(P_{\hat\beta^*}(\cdot\mid m_i)\)
equals \(\mu_i\) for τ-a.e. \(m_i \in F_i\) with \(q\)-mass. Maybe this
forces the kernel structure.

**Question**: does this case admit a clean construction?

### C3. Diagonal τ-symmetry
Some symmetry condition on \(\tau\) (radial, orbit-invariant under
group action on \(\Delta(\Omega)\)) plus matching symmetry on \(W^P\)
forces (D2.3) by symmetry-averaging.

**Question**: what's the minimal symmetry condition?

### C4. Smooth + strictly convex \(W^P\)
\(W^P\) is a smooth (\(C^1\)) submanifold of \(W\) and \(W\) is strictly
convex. Then the active-face cells \(I_-(s)\) are singletons τ-a.e.,
\(\lambda^-(s)\) is a Dirac, and the rowwise-minimizer correspondence
\(G(s)\) is a single point at each \(s\). Maybe this gives (D2) for
free.

**Question**: does the v8 sharpness witness (WTA ternary) have smooth
strictly-convex \(W^P\)? No — WTA ternary has a vertex-only \(W^P\)
which is the 0-dimensional polytope vertex set. So C4 would rule out
WTA-style witnesses by construction. Verify this and check whether C4
is genuinely meaningful or whether it just rules out the hard cases.

### C5. Product / separable utility
\(u(a, \omega, \theta) = u_1(a, \omega) + u_2(a, \theta)\) or similar.
Then \(W\) inherits a tensor structure and the calibration may follow
from finite-dimensional intersection theory.

**Question**: how restrictive is this on actual robust-trust applications?

### C6. Coarsening / pure-aligned-redirect
For \(\alpha > 0\), modify the agent's labeling \(w^*\) by **coarsening**:
some messages \(m\) are sent to a single "default" label, removing
aligned mass from the fibers that the adversary uses. If the agent can
choose her labeling to make aligned and misaligned mass disjoint
(modulo a calibration adjustment), (D2.1) becomes trivial.

**Question**: does this give a clean primitive condition? The route
memo and v8 closure flag "exact-contact + atomless τ" as a related
condition. How does C6 compare?

### C7. Fiber-rich Lyapunov + Lagrangian transport
Combine C1 with Lyapunov's convexity theorem on atomless vector measures:
the achievable set of (mean, mass) pairs over Borel subsets of \(F_i\)
is convex. So we can find a sub-kernel within each fiber that achieves
any target conditional mean in the convex hull. If the target Bayes-
cone vector \(\mu_i\) is in the convex hull of \(\{s : s \in F_i\}\),
calibration follows.

**Question**: is "target \(\mu_i\) is in the convex hull of source-
beliefs in \(F_i\)" the primitive condition we want?

## Your job

1. **Evaluate each candidate** C1-C7 (and propose new ones).
2. **Rank** by: economic meaningfulness, strictness-relative-to-menu-Hall,
   compatibility with v8 sharpness package.
3. **Verdict**: is any candidate a genuinely primitive sufficient
   condition for (D2) that is strictly weaker than menu-Hall?
4. **If yes**: state the precise theorem and recommend the next prover.
5. **If no**: state that honestly. The route's final architecture is
   then:
   - Finite-menu Pareto-Hall (unconditional).
   - α=0 original-game Theorem 2 (unconditional).
   - α>0 original-game Theorem 2 (conditional on (D2) ≡ menu-Hall;
     not weaker).
   - Compact-menu Pareto-Hall (conditional on R1+R2-FES or R3-FCA/PK).
   And the locked gate is structural.

## Constraints

- The v8 closure memo explicitly named the deletion-compatible Hall
  duality as "the single most consequential open question." If you
  find a primitive sufficient condition, you'd be solving that.
- Don't smuggle in calibration as an output-dependent assumption. The
  primitive must be stated on \((\tau, W, \alpha)\) or related
  primitives, NOT on \(C^*\) or \(\lambda^\pm\).
- v8 sharpness package binds: the WTA ternary witness cannot have
  calibration unless the new primitive rules it out.

## Output Contract

- Inline as plain markdown.
- Be honest. If C1-C7 all fail to give a strictly weaker primitive,
  say so.
- End with: (a) one-line verdict, (b) one-paragraph recommendation
  to the orchestrator: continue / consolidate / accept architecture.
