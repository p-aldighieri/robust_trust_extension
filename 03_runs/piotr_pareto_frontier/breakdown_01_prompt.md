# Breakdown pass 01 — Finite-menu Pareto-Hall calibration via Clarke-Danskin stationarity

## Role

You are the Breakdown role for a smart-scaffolding proof project. The
formalizer, literature, and searcher passes have agreed: attack
Pareto-Hall calibration via **Clarke-Danskin stationarity at a finite
Pareto-frontier menu**. The full thread is in
`formalizer_01_response.md`, `literature_01_response.md`, and
`searcher_01_response.md` (now also present as durable session artifacts).

## Convergent plan to break down

**The hinge claim (searcher's primary route, "the first theorem").**

Let \(C^* = \{w_1,\ldots,w_k\}\subset W^P\) be a **finite** local maximizer
of
\[
F_k(w_1,\ldots,w_k) \;=\; \int_M\!\big[\alpha\,\max_i s\!\cdot\!w_i \;+\; (1-\alpha)\,\min_i s\!\cdot\!w_i\big]\,\tau(ds)
\]
over the constraint \(w_i\in W^P\), **with the further constraint that no
\(w_i\) can be replaced by a Pareto-dominator in \(W\)** (Lemma 2 of the
paper's Theorem 1 proof — wlog Bayes-optimal profiles).

Then there exist measurable active-face weights
\[
\lambda_i^+(s)\in\Delta(\arg\max_j\,s\!\cdot\!w_j), \quad
\lambda_i^-(s)\in\Delta(\arg\min_j\,s\!\cdot\!w_j),
\]
such that the Clarke subdifferential components
\[
g_i \;:=\; \alpha\!\int_M \lambda_i^+(s)\,s\,\tau(ds) \;+\; (1-\alpha)\!\int_M \lambda_i^-(s)\,s\,\tau(ds)
\]
lie in the normal cone \(N_W(w_i)\) of \(W\) at \(w_i\), for every
\(i\in\{1,\ldots,k\}\). The induced posterior at label \(w_i\) is
\[
p_i \;:=\; \frac{g_i}{q_i}, \quad q_i \;:=\; \alpha\!\int_M \lambda_i^+\,d\tau + (1-\alpha)\!\int_M \lambda_i^-\,d\tau,
\]
and \(p_i\in N_W(w_i)\cap\Delta(\Omega)\) whenever \(q_i>0\) — which is
exactly Pareto-Hall calibration at label \(w_i\).

The adversarial kernel \(\hat\beta^*\) in the original game is constructed
by routing source signals \(s\) to message labels with weights
\(\lambda_i^-(s)\). The aligned-truthful term concentrates aligned mass on
label \(w^*(s)\in\arg\max_j s\!\cdot\!w_j\), with weights \(\lambda_i^+(s)\)
when there are ties.

## Your job

Produce a **lemma chain** that decomposes the hinge claim into
prover-sized chunks. Each lemma should:

- Be self-contained (precise hypotheses, statement, expected proof tools).
- Be sized for ~1 Extended Pro prover pass (i.e., 1-2 explicit
  mathematical objects).
- Have an explicit verification target (what a reviewer would check).
- Identify which earlier lemmas it depends on.

The chain should culminate in the finite-menu Pareto-Hall theorem above.
After that, identify the lift to general \(C^*\) (stratified compact
menus, then full \(\mathcal K(W^P)\)) as separate downstream theorems.

## Output ordering

```
# Breakdown: Finite-menu Pareto-Hall calibration via Clarke-Danskin stationarity

## Theorem target (finite-menu Pareto-Hall)

Restate the hinge claim in fully formal language. Define every symbol.
Decide which version of "local maximizer" you use: pure local max in
\(W^k\), local max up to Pareto-dominating replacement, etc.

## Hypothesis ledger

List every standing/auxiliary hypothesis (Ω finite, full-support μ_0,
A and Θ compact metric, u bounded continuous in a, conditional
independence, Borel measurability) and any new hypothesis you need
(finiteness of optimal menu, regularity of W^P, atomless τ, ...). Tag
each as STANDING, INHERITED-FROM-V8 (e.g., exact-contact), or
NEW. Be explicit about which NEW hypotheses are "economically meaningful"
and which are technical.

## Lemma chain (numbered, in proof order)

For each lemma:

### Lemma X — <name>

**Hypotheses.**  
**Statement.**  
**Tools needed.** (Cite by name; reference earlier lemmas explicitly.)  
**Proof outline.** (1-2 paragraphs.)  
**Reviewer verification target.** (What would a reviewer check first?)  
**Risk.** (One short paragraph on where this could fail.)

## Capstone theorem

Re-state the finite-menu Pareto-Hall theorem as the conclusion of the
chain. Identify which lemmas plug into which step.

## Lift roadmap (post-capstone)

- (Step 1) Extension from finite \(C^*\) to **stratified-compact** \(C^*\)
  (finite stratification on which the Gauss map is single-valued).
- (Step 2) Extension to general compact \(C^*\subseteq W^P\) (limit
  argument using compactness of \(\mathcal K(W^P)\) + closedness of
  normal-cone correspondence).
- (Step 3) Translation of \(\hat\beta^*\) (payoff-vector kernel) into the
  original-game message kernel via the labeling \(w^*:M\to C^*\). Note
  the "original-message lift" gap (formalizer §6 Tier 1b) — may require
  an auxiliary measurable-selection lemma on \((w^*)^{-1}(\beta^*(s))\).

For each lift step, identify the candidate tool (Gauss-map regularity,
normal-current calculus, Painlevé-Kuratowski stability, KRN measurable
selection).

## Prover marching order

State the **single first prover target** — pick one specific lemma from
the chain. State precisely what the prover should produce.

## Anticipated review traps

List 3-5 specific places the reviewer will probably push back. For each,
state how the breakdown handles it pre-emptively.

## Output Contract

- Return everything inline in this chat as plain markdown.
- Stick to the section ordering above exactly.
- Be precise about hypotheses. Do not silently inherit "atomless τ" or
  "exact-contact" — list them as explicit hypotheses in the ledger.
- The hinge of the route is that Clarke multipliers are exactly the
  calibration kernel. Make this load-bearing step its own lemma.
- Pay attention to ties: \(s\mapsto\arg\max_j s\!\cdot w_j\) is single-
  valued except on a measure-zero set in the generic case, but the
  proof must handle the tie set explicitly. The searcher noted this is
  a porcupine — state how the breakdown handles it.

## Constraints

- **Banned re-proposals**: see `prior_attempts_digest.md`. In particular:
  no product-of-narrow Sion, no τ-AC restriction \(F\subset B\), no FOC
  + envelope on the original strategy game, no axiomatized Lean
  GameSetup, no ε-menu-Hall as primary, no canonical/minimal pruning
  without deletion-compatible Hall.
- **Sharpness compatibility**: any final theorem must not contradict
  v8 Lemma 7 (cone intersection) + Theorem 8 (no-free-dust) on the WTA
  ternary witness. The witness is a menu-engine artefact, not a
  primitive counterexample, so a primitive sufficient condition that
  rules it out is acceptable.
- **Per user instruction**: do not stop at a partial theorem. The
  target is OBJECTIVE_MET or OBJECTIVE_MET_WITH_TRIVIAL_REGULARITY where
  the regularity is an economically meaningful primitive condition
  strictly weaker than menu-Hall.
