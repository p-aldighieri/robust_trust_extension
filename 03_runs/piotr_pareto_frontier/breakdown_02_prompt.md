# Breakdown pass 02 — Compact-menu lift roadmap

## Role

You are the Breakdown role. The **finite-menu Pareto-Hall calibration
theorem** has just been proved (Lemmas 6+7+8 reviewer-PASS'd; see
durable sources `prover_02_response.md`, `reviewer_02_response.md`).

The remaining big step is the **compact-menu lift**: extend Pareto-
Hall calibration from finite menus \(C^* = \{w_1,\ldots,w_k\}\) to
general compact \(C^*\subseteq W^P\). The route memo's plan was:

- **Step 1**: stratified-compact via Gauss-map regularity.
- **Step 2**: general compact via Painlevé-Kuratowski stability.

The original-message lift (Lemma 12, finite case) is being handled in
a parallel prover pass; **do not duplicate that work** here. Focus on
the compact-menu extension.

## Your job

Produce a lemma chain that decomposes the compact-menu lift into
prover-sized chunks. The chain should culminate in:

**Target theorem (compact-menu Pareto-Hall calibration).** Let
\(C^*\in\arg\max_{C\in\mathcal K(W^P)}\,V_P(C)\) be a global maximizer
of the value functional
\[V_P(C) = \int_M[\alpha h^+_C(s) + (1-\alpha)h^-_C(s)]\,\tau(ds)\]
on the hyperspace \(\mathcal K(W^P)\). Then there exists a Borel kernel
\(\kappa: M\to\Delta(C^*)\) (or, more precisely, a Borel \(\beta^*:M\to W^P\)
with \(\beta^*(s)\in\arg\min_{w\in C^*}\,s\!\cdot\!w\) for τ-a.e.\ \(s\))
such that the disintegration posterior \(p_C(w) := \E[s\mid \text{label} = w]\)
on \(C^*\) satisfies \(p_C(w)\in B_W(w)\) for "\(\tilde q\)-a.e."\ \(w\in C^*\),
where \(\tilde q\) is the appropriate label-marginal under the joint
\(\tilde\gamma_\alpha\).

The hypothesis ledger should identify what's needed beyond standing
assumptions. Candidates:

- (R1) \(W^P\) is a stratified \(C^1\) manifold, with finitely many
  strata, each smooth. Gauss map \(n:W^P\to\Delta(\Omega)\) is single-
  valued (continuous) on each stratum interior.
- (R2) Local finiteness of active-face structure: at \(C^*\), only
  finitely many "exposed" labels carry positive \(q\)-mass. (Economically
  meaningful: the agent's effective response is finite-menu, even when
  C* is a continuum.)
- (R3) Painlevé-Kuratowski stability of the rowwise-minimizer
  correspondence as the menu varies.

## Tools and references

- **Hyperspace variational analysis**: Aubin-Frankowska (1990) Ch.7-8
  on set-valued maps; Rockafellar-Wets (1998) §4 (Painlevé-Kuratowski
  convergence), §5 (set-valued continuity), §6 (normal cones).
- **Gauss map / supporting hyperplane regularity**: Schneider (1993)
  *Convex Bodies* Ch.2 on the spherical image and Gauss map of convex
  bodies; Aliprantis-Border (2006) §7.
- **Approximation by finite menus**: Beer (1993) on Hausdorff
  convergence of compact sets; \(C\) approximable by finite \(C_n\) in
  \(d_H\), but the calibration must pass to the limit.
- **Painlevé-Kuratowski limits of normal cones**: Rockafellar-Wets §6.E.
- **Persuasion / payoff-set tools** (auxiliary): Doval-Smolin (2024),
  Dworczak-Kolotilin (2024).

## Output ordering

```
# Compact-menu lift roadmap

## Target theorem (compact-menu Pareto-Hall calibration)
(Restate precisely.)

## Hypothesis ledger
- Standing.
- New (R1, R2, R3, or alternatives).

## Step 1 — Stratified-compact lift

### Lemma A — Stratification of W^P
W^P decomposes into finitely many strata; on each stratum the Gauss
map is single-valued. (Cite Rockafellar-Wets Ex.2.39 or Schneider Ch.2.)
This is for the case of polyhedral W; if W is general convex compact,
state the required regularity for stratification.

### Lemma B — Finite-active-face reduction
At a global maximizer C* ∈ K(W^P), only finitely many "active" payoff
profiles carry positive τ-supported aligned-mass and positive
adversarial-mass. (Use the Gauss-map decomposition + integrability.)

### Lemma C — Stratified Clarke-Danskin
On each stratum, the finite-menu Pareto-Hall theorem applies to the
finite active profiles, yielding stratum-local calibration.

### Lemma D — Stratum-stitching
Stitch the stratum-local calibrations into a global Borel kernel on C*.

## Step 2 — General compact lift

### Lemma E — Approximation by finite menus
Show that an arbitrary C* ∈ argmax V_P is approximable in d_H by a
sequence C_n of finite menus with V_P(C_n) → V_P(C*).

### Lemma F — Calibration passes to the PK-limit
The finite-menu calibrations κ_n associated with C_n converge (in
some hyperspace narrow topology) to a calibrated kernel κ* on C*.

### Lemma G — Closedness of the normal-cone correspondence
Use Rockafellar-Wets §6.E to show n ↦ N_W(w_n) is closed under
Painlevé-Kuratowski convergence w_n → w in W^P. Apply to the limit
calibrated kernel.

## Step 3 — Original-message lift (handled in Prover 03; cross-reference only)

Cross-reference the finite-case original-message lift work; identify
the lift hypothesis needed for the compact-menu generalization.

## Capstone (compact-menu Pareto-Hall calibration theorem)
(Combined statement.)

## Prover marching order
First prover target after this breakdown: which lemma, what scope.

## Anticipated review traps
3-5 specific issues a reviewer will probably push back on.
```

## Output Contract

- Return everything inline as plain markdown.
- Be precise about regularity hypotheses; flag which are economically
  meaningful and which are technical.
- The big risk is that the compact-menu lift quietly reintroduces
  menu-Hall through a back door (e.g., requiring calibration at every
  point of an exposed face). Be vigilant.
- If you decide the lift cannot be made unconditional and requires
  e.g. (R1)+(R3), state the resulting theorem precisely and verify
  it is meaningfully weaker than v8's menu-Hall.

## Constraints

- Banned re-proposals: see `prior_attempts_digest.md`. Especially
  do not re-import canonical/minimal pruning under standing alone.
- Don't redo the finite-menu work — it's done.
- Per user instruction: push to a meaningful conclusion. If a
  primitive sufficient condition for compact menus exists that is
  strictly weaker than menu-Hall, the theorem is publishable.
