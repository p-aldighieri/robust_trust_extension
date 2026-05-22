ROLE — Lean 4 / Mathlib formalization architect. Produce a Lean-ready decomposition of the v9 Robust Trust Theorem 2 infinite-extension package. Sources: `v9_consolidated.md` (master, 2019 lines), `exposition_v9.tex` (canonical statements, 905 lines), `exposition_v9_paper.tex` (long-form, 900 lines), `v9_executive_summary.md`, plus the v8 baseline `v8_main.lean` (4981 lines, the predecessor Lean file in namespace `RobustTrustV8`).

# The task

Produce **one Lean-ready decomposition document** for the full v9 surface. This document will be saved as `lean/decomposition.md` and will drive the per-lemma formalization rounds. The document is the **skeleton** — not the proofs. Proofs come in subsequent prover-session passes, one lemma at a time.

# What "Lean-ready" means

For each theorem/lemma:

1. **Slug** in kebab-case (e.g. `binary-L_B5-endpoint-stationarity`). Must match the ledger in `lean_state.md`.
2. **Lean statement** in Lean 4 / Mathlib syntax, using the `RobustTrustV8` namespace primitives (`RobustTrustModel`, `Belief`, `Profile`, `PayoffProfileSet`, `MenuHall`, `ExactContact`, etc.) where they apply. New v9 primitives (Pareto frontier `WP`, finite-menu functional `Fk`, cone-Hall dual `Psi`, FBNF foliation `Foliation`, regularity package `RegPackage`, primitive class predicates) must be **declared first** in a `RobustTrustV9` namespace at the top of `main.lean` before the theorem statements.
3. **Dependency list**: which other lemmas in this decomposition does this one use, and which **Inventory axioms** (Mathlib-unprovable, axiomatized in `support/INVENTORY.lean`) does it consume. For each Inventory axiom, give a one-line citation (Clarke 1990, Strassen 1965, Aliprantis–Border, Castaing–Valadier, Kechris 1995).
4. **Proof outline** in 3–8 bullet points (math-level, not Lean tactics yet). Should be specific enough that a downstream prover session can fill in the tactics.
5. **Estimated difficulty**: SMALL (≤ 50 lines Lean), MEDIUM (50–200), LARGE (200–500), HUGE (500+).
6. **Source-doc anchor**: page or section reference in `v9_consolidated.md` and `exposition_v9.tex`.

# The full v9 surface (full scope is locked)

Decompose all of:

**A. Inventory axioms (new in v9; add to `support/INVENTORY.lean` alongside reused v8 axioms):**
- `clarke_danskin_stationarity` — Clarke subdifferential of an integral / Danskin's theorem applied to a value functional; needed for T1.
- `clarke_fermat_normal_cone` — Clarke subdifferential at a local extremum lies in the normal cone.
- `strassen_marginals` — Strassen 1965 coupling existence under marginal dominance / Kantorovich–Rubinstein duality form; needed for Hall biconditional G2c.
- `farkas_lp_duality_conic` — Farkas' lemma / strong LP duality in conic form; needed for G1 finite cone-Hall and G4 LP threshold.
- `berge_maximum_set_valued` — Berge's maximum theorem for set-valued correspondences; if Mathlib's `IsCompact.isClosed_argmax` family suffices, do NOT axiomatize; flag this as a Mathlib audit task.
- `hausdorff_alexandroff_continuous_surjection` — continuous surjection from the Cantor space onto any compact metric space; reused from v8 atomless τ work if available, else lift to Inventory.

Reused from v8 `Inventory` (do not redeclare; just note that v9 lemmas consume them):
- `measurable_argmax_selector` (KRN)
- `krn_borel_right_inverse`
- `kernel_infimum_epsilon_selection`

**B. Theorems and lemmas (the full v9 surface):**

1. **T1 — Finite-menu Pareto-Hall calibration via Clarke–Danskin** (`exposition_v9.tex §3`, `v9_consolidated.md §B.1`)
   - `T1-clarke-danskin-multiplier-bayes-cone` — given Clarke–Danskin stationarity (axiom), the resulting multipliers λ⁺, λ⁻ satisfy p_i = g_i/q_i ∈ B_W(w_i). This is the consequence we actually prove.
   - Plus the integral Clarke–Danskin representation (L6), Clarke–Fermat stationarity (L7), and multipliers-are-calibration-kernel (L8) sub-lemmas.

2. **T2 — α=0 unconditional infinite extension via singleton strategy** (`exposition_v9.tex §4`, `v9_consolidated.md §B.2`)
   - `T2-alpha-zero-singleton-prior-strategy` — when α=0, the optimal payoff-profile menu collapses to a singleton; the constant adversarial message induces μ_0; Bayes-optimal at prior gives robust rationalizability.
   - Sub-lemmas as in the proof.

3. **Binary capstone** (`exposition_v9.tex §8`, `v9_consolidated.md §B.3`)
   - `binary-L_B1-endpoint-fiber-lift` — Borel kernel realizing scalar calibration under total-balance η(A_-) = ν(S_+).
   - `binary-L_B2-TRS-interval-reduction` — paper Theorem 1 lift.
   - `binary-L_B3-endpoint-only-image` — misaligned BR concentrates on {L, R}.
   - `binary-L_B4-interior-message-calibration` — under TRS, interior messages aligned-only, posterior = message.
   - `binary-L_B5-endpoint-stationarity-total-balance` — Clarke–Danskin Fermat with k≤2 active labels gives the integral equations.
   - `binary-L_B6-capstone` — assemble B1+B3+B5 into the theorem.

4. **FBNF capstone + 3 corollaries** (`exposition_v9.tex §9`, `v9_consolidated.md §B.4`)
   - `FBNF-F1-conditional-B1-measurable-pasting`
   - `FBNF-F2-endpoint-only-fiber-image`
   - `FBNF-F3-localized-stationarity-FBNF6` (derives FBNF-6 from optimality)
   - `FBNF-F4-capstone`
   - `FBNF-corollary-spherical-radial`
   - `FBNF-corollary-affine-MLR-single-crossing`
   - `FBNF-corollary-polyhedral-scalarizable`

5. **Hall biconditional + WTA certificate** (`exposition_v9.tex §11`, `v9_consolidated.md §B.5`)
   - `Hall-G1-finite-cone-hall-farkas-LP` — finite cone-Hall via Farkas/LP duality.
   - `Hall-G2c-borel-extension` — Borel extension from finite to general measurable (no compact-patch deletion, no cell-flow, no ε-net slack).
   - `Hall-biconditional` — (a) ⟺ Ψ(y) ≤ 0 for all bounded Borel y, under (Reg-1)+(Reg-2).
   - `Hall-WTA-dual-certificate-psi-two-ninths` — explicit Ψ(y) = 2/9 for WTA ternary uniform.
   - `Hall-WTA-reopening-threshold-D` — D ≥ 2(1−α)/(9α) reopening condition.

6. **G4 finite-facet polyhedral LP threshold** (`exposition_v9.tex §13`, `v9_consolidated.md §B.5.G4`)
   - `G4-finite-facet-polyhedral-LP-threshold` — Ψ ≤ 0 ⟺ explicit finite LP feasibility a_j + b_j ≤ 0 at extreme directions of the polyhedral normal fan.

7. **Primitive sufficient classes** (`exposition_v9.tex §12`, `v9_consolidated.md §B.7`)
   - `P2-star-cone-margin-bounded-jamming` — (P1) + uniform cone margin η + sufficient aligned baseline mass D → Ψ ≤ 0.
   - `P3-polyhedral-cone-margin` — polyhedral W, finite-vertex C*, supporting cones with positive margin → finite LP feasibility.
   - `P4-radial-antipodal-tau-symmetry` — τ-symmetric, u equivariant → Ψ ≤ 0 via primal symmetry construction.

8. **Section G v9.2 sharpenings** (`v9_consolidated.md §G`)
   - `G-addendum-binary-tie-splitting` — relax R-TD: atom at endpoint indifference belief → measurable tie-splitting preserves calibration.
   - `G-addendum-variable-margin-P2-star-prime` — uniform cone-margin η weakened to Borel-positive margin η(m) > 0 with local cap on adversarial target density.
   - `G-addendum-P6_G-finite-graph-FBNF` — FBNF extends to finite graphs of affine arcs with Kirchhoff node balance at shared vertices.

# Cross-cutting structural questions to address up front

Before listing per-lemma decomposition, the document should open with a **§0 Structural questions** answering:

Q1. **Pareto frontier WP as a Lean type**: Is `WP : Set (Profile model)` (subset of W) sufficient, or do we need a coercion `WP → CompactConvex` with the Pareto-dominance order? Recommend the simplest that closes the proofs.

Q2. **`KCompact W` for the Pareto-frontier game** `\mathcal G_P`: how to formalize "compact set of compact subsets of W^P under Hausdorff distance". Mathlib has `EMetric.Hausdorff`, `TopologicalSpace.NonemptyCompacts`, `Blaschke selection`. Pick the cleanest.

Q3. **Cone-Hall dual functional `Psi`**: signature, domain. Likely `Psi : (M → ℝ^|Ω|) → ℝ` for bounded Borel `y`. How to encode "bounded Borel" — `BoundedContinuousFunction` is too narrow; need `BoundedBorelFunction` or `BddBelow ∩ BddAbove ∧ Measurable`. Recommend.

Q4. **Regularity package**: `(Reg-1)` closed-graph rowwise-minimizer correspondence + `(Reg-2)` continuous support function. Structure or two separate hypotheses? Recommend.

Q5. **FBNF foliation**: how to encode a measurable affine 1-d foliation of Δ(Ω) over a standard Borel base. Structure `Foliation` with fields `(Z : StandardBorel, embed : Z → [a, b] → Belief, disintegration : ...)` style.

Q6. **Clarke subdifferential** in Lean: Mathlib has `Lipschitz` and `ConvexOn` but no Clarke subdifferential calculus. Treat as a black box: declare an `axiom` of the form `clarke_danskin_stationarity : ... → ∃ multipliers, ...` and consume it directly.

Q7. **Reuse from v8**: which v8 namespace declarations are imported verbatim, and which need v9-specific refinements? List the imports needed.

Q8. **`Inventory` axioms naming convention**: stay consistent with v8 (`Inventory.measurable_argmax_selector` etc.). New v9 axioms live in `Inventory` namespace or a new `Inventory.V9` sub-namespace? Recommend.

# Output format

Produce a single coherent markdown document (NOT a chat reply, a document) with these sections:

```
# v9 Lean decomposition

§0 Structural questions (Q1–Q8 above with concrete answers)
§1 New Inventory axioms (6 new + 3 reused from v8)
§2 RobustTrustV9 namespace: new primitives (Pareto frontier, game G_P, regularity, FBNF, Psi)
§3 Theorem T1 + sub-lemmas L6/L7/L8
§4 Theorem T2
§5 Binary capstone L_B1 ... L_B6
§6 FBNF F1 ... F4 + 3 corollaries
§7 Hall biconditional G1, G2c, Hall, WTA Psi=2/9, WTA threshold D
§8 G4 polyhedral LP threshold
§9 Primitive sufficient classes P2*, P3, P4
§10 Section G sharpenings (3 sub-lemmas)
§11 Proving order recommendation (dependency-DAG topological sort)
§12 Mathlib dep audit: list every Mathlib lemma the formalization will likely need; flag any that are open issues or unstable APIs.
§13 Open questions / blocker risks
```

For each lemma in §3–§10, use the per-lemma template:
```
### <slug>
**Statement (Lean):**
\`\`\`lean
theorem <slug> ... := by sorry
\`\`\`
**Depends on:** <list of slugs + Inventory axioms>
**Source anchor:** v9_consolidated.md §..., exposition_v9.tex §...
**Proof outline:** 3–8 bullets.
**Difficulty:** SMALL/MEDIUM/LARGE/HUGE.
```

Be exhaustive on dependencies. Be conservative on Lean syntax — if you're unsure of an exact Mathlib name, write a comment with the expected lemma name and flag it in §12. The goal is a document I can hand to per-lemma prover sessions, not a finished Lean file.

Use as much reasoning time as needed. Adversarial: if any v9 theorem statement is unclear or has gaps that the formalization will expose, flag them in §13 with a specific question for me.

Output the full document. No summary, no apologies. Just the decomposition.
