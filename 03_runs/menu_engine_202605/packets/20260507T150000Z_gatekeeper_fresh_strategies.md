# Gatekeeper fourth pass — fresh strategy search after Strategies 1–5 worked through

You are the **Gatekeeper**, but this pass is framed differently from the previous three. Previous passes evaluated incremental state changes:
- Pass 1 (on v7): caught NARROWED, proposed Strategies 1–5.
- Pass 2 (on v7+nodust): NARROWED with sharper diagnosis after Strategies 1, 2, classification (b).
- Pass 3 (on v8 after Strategy 3 stalled): NARROWED with explicit STOP-AND-COMMIT.

This is a **fresh strategy search**, not a fourth incremental evaluation. Read v8, the closure memo, and the strategic record as the **input state** — facts about what is known and what is blocked — and decide whether there are **genuinely new attack surfaces** that were not proposable from v7-state but become viable now that Strategies 1, 2, 3 have been worked through.

## What's known now that wasn't known at Pass 1

1. **Definition 2's "for all m" reads $q_\beta$-a.e.** in the infinite setting (Strategy 1 result). Adversaries are not τ-absolutely-continuous; null-message dust is admissible but no-free-dust closes that escape in WTA ternary.

2. **The v7/v8 ternary witness is a menu-engine artefact**, not a primitive counterexample (classification (b)). The witness's trust region $T = \{\mu : \mu(0) \le 0.4\}$ is behaviorally equivalent to $T = \Delta(\Omega)$.

3. **Cone intersection lemma + no-free-dust theorem** (Strategy 2 results) cover all support patterns $I \subseteq \{0,1,2\}$ uniformly. Any future obstruction must look fundamentally different from "atoms at the uniform prior" or it falls into the same trap.

4. **Lemma A.2 (uncalibrated minimal menu pruning) is blocked at three named structural gaps** under standing + exact-contact:
   - **Label-saturation:** exact-contact does not imply touching one $C^*$-minimizer for $s$ removes all of them.
   - **Replacement-index mismatch:** menu-Hall dual is messagewise (Bayes calibration at received $m$); deletion improvement is sourcewise (best retained minimizer for $s$).
   - **Borel→compact gap:** $\overline{c(M\setminus E)} = C^*$ can hold for τ-positive Borel $E$ (fat-Cantor witness).

These are not vague obstructions; they are precisely-posed bridge requirements for any future "canonicality implies menu-Hall" theorem.

## The new question

Are there strategies that **become viable now** that weren't visible from v7-state?

The renaming test from the Strategy-3 breakdown applies up-front: a candidate strategy passes only if its primitive condition is checkable WITHOUT referring to (i) existence of a kernel κ supported on rowwise minimizers, (ii) any disintegration posterior membership, or (iii) any direct Bayes-cone inclusion at messages.

## Candidate categories I want you to consider

You may use these as starting points or propose entirely different ones. Not all need to be alive; honestly mark which fail.

### (N1) Joint-law-first reformulations

Strategy 3's A.2 stall identified a sourcewise/messagewise index mismatch. A reformulation that works directly with **joint laws** $\gamma$ on $M \times M$ (or on source × message × induced-posterior triples) might bypass the mismatch by never disintegrating until calibration is already encoded. The literature has martingale optimal transport, Strassen with cone constraints, and Kellerer with dominance constraints. Is there a route here that doesn't already exist as "menu-Hall in costume"?

### (N2) Approximate-rationalizability target relaxation

The current target is exact per-message Bayes-optimality (q-a.e.). A *meaningful* relaxation — not a trivial one — would be: $\hat\sigma^*(m) \in \arg\max_{\hat\sigma'}\,U(\hat\sigma',\,P_{\beta^*}(\cdot\mid m))$ up to some primitive ε with a clean interpretation. If ε can be made model-primitive (depending on $\tau$, $u$, $\alpha$ but not on the kernel choice), this might be a publishable extension of Theorem 2 that genuinely escapes menu-Hall while preserving the spirit of Definition 2. Or it might be cheap; you decide.

### (N3) Closed-graph regularity sharpening

Reviewer 3 said Unblocker B (closed graph + u.h.c. + uniqueness + label regularity) is "directionally right but not sufficient as stated" — the replacement-index problem persists. **What is the minimal regularity that does suffice?** Is there a clean primitive condition on $u$, $\tau$, $T$ (e.g., strict convexity of the trust region's support function plus τ density) that forces all three of label-saturation, sourcewise minimization, and Borel→compact closure simultaneously?

### (N4) Literature search for deletion-compatible duality

The closure memo names "deletion-compatible Hall duality theorem" as the missing object but does not search for it. Recent transport theory (Ghoussoub–Kim–Lim, Beiglböck–Juillet, Backhoff-Veraguas, etc. on adapted/causal transport, weak optimal transport, martingale OT with constraints) may already contain something close. Even if not directly applicable, a *targeted* literature pass might import a duality theorem we'd otherwise have to prove from scratch.

### (N5) Different formalization target

The closure memo says "v8 is publishable as a conditional theorem." But a different formal target might be reachable unconditionally. Examples: weak/distributional convergence statements that don't need pointwise Bayes optimality; equilibrium-existence theorems for a relaxed "approximately on-path" condition; or a duality statement (the value function decomposes a particular way) that has Theorem-2-like content but is not identified with Definition 2's literal statement.

### (N6) Anything else genuinely new

If a category I missed dominates these, propose it.

## What you MUST do

1. For each candidate (N1–N6 plus your own additions), apply the renaming test honestly.
2. State whether the candidate is **genuinely new** (would not have been proposable from v7-state) or is a **re-skin of a previously-considered route**.
3. Rank only the genuinely-new candidates that pass the renaming test.
4. **Allow "no genuinely new attack surface" as a valid verdict.** This pass is a structural check, not an obligation to produce more strategies.

## What you MUST NOT do

- Do not re-litigate Strategies 1, 2, 3, 4, 5. They are closed.
- Do not propose new sharpness witnesses; the cone intersection lemma + no-free-dust theorem cover all support patterns uniformly.
- Do not propose strategies that fail the renaming test. If your candidate's primitive condition is "there exists a kernel κ such that menu-Hall holds," it is dead on arrival.
- Do not return OBJECTIVE_NARROWED again unless you also produce at least one genuinely-new candidate. If no candidate is genuinely new, return OBJECTIVE_NARROWED with the explicit verdict that the structural search is exhausted, and recommend the project stay at v8.

## Output Format

````markdown
```gatekeeper_control
verdict: OBJECTIVE_NARROWED / OBJECTIVE_MET_WITH_TRIVIAL_REGULARITY / OBJECTIVE_MET / OBJECTIVE_MISSED
sources_status: tidy / cluttered
search_status: genuinely_new_routes_found / structural_search_exhausted
```

## Verdict
VERDICT: ...

## Candidate Audit
For each candidate (N1–N6 plus your own):
- Genuinely new (yes/no): justification
- Renaming test (pass/fail): justification
- Brief assessment if alive

## Ranking of Genuinely-New Routes
(If any. Otherwise omit.)

## Honest Assessment
(One paragraph. Either: "here are 1–3 genuinely new routes worth one prover pass each" — and rank them — or: "the structural search is exhausted; v8 is the right terminal state and any further work belongs in special-geometry exposition notes, not new theorem attempts.")
````

Length: 1500–2200 words.
