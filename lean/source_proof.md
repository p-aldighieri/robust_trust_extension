# v9 Source Proof Pointer

This file is a pointer to the three input documents that the v9 formalization
treats as authoritative. None of the three is the single canonical source on
its own; together, they are the formalization brief that prover/reviewer
sessions cross-validate against.

## Source documents

### Primary master: `01_deliverables/closure/v9_consolidated.md`

- 2019 lines.
- Master consolidated memo, reviewer-PASS'd across the v9 pipeline.
- Canonical for: **detailed per-lemma proofs**, dependency graph (D), open-problem
  ledger (F), hypothesis ledger (C), Section G v9.2 sharpenings.
- This is the proof memo a reviewer would read end-to-end if they wanted to check
  every step.

### Canonical statements: `01_deliverables/exposition/exposition_v9.tex`

- 905 lines, LaTeX-compiled to a clean theorem-organized exposition.
- Canonical for: **theorem and lemma statements**, the exact wording of T1, T2,
  Binary capstone, FBNF capstone, Hall biconditional, G4 LP threshold, corollaries.
- Use this when you need the exact statement to formalize.

### Long-form positioning: `01_deliverables/exposition/exposition_v9_paper.tex`

- 900 lines, 19-page PDF.
- Canonical for: **framing, positioning, Section G addendum prose, the executive
  summary**.
- Use this for the writing-template reviewer pass and to sanity-check that the
  Lean formalization scope matches the paper's claims.

## Canonical-for-what map

| Object                                | Canonical source                                         |
|---------------------------------------|----------------------------------------------------------|
| Theorem statements                    | exposition_v9.tex                                        |
| Lemma statements                      | exposition_v9.tex; expanded in v9_consolidated.md        |
| Detailed proofs                       | v9_consolidated.md                                       |
| Hypothesis ledger (Reg, primitive)    | v9_consolidated.md §C                                    |
| Dependency graph (lemma → uses)       | v9_consolidated.md §D                                    |
| Open problems / what is NOT proved    | v9_consolidated.md §F                                    |
| Section G v9.2 sharpenings            | v9_consolidated.md §G                                    |
| Framing / honest claims               | exposition_v9.tex §preamble; exposition_v9_paper.tex     |
| Headline executive summary            | 01_deliverables/closure/v9_executive_summary.md          |

## Provenance

- Source provenance: hand-consolidated v9 — five-theorem infinite extension of
  Dworczak–Smolin Robust Trust Theorem 2 (Pareto-frontier reformulation, due to
  Piotr Dworczak 2026-05-20; Clarke–Danskin calibration mechanism identified
  2026-05-21).
- Provenance slug: `robust-trust-v9` (use for stable codex thread IDs in
  /lean-verify-deps and the MathPipeProver run cache).
- Predecessor: v8 formalization (preserved in `lean/v8_*` files, branch ancestor
  before `83848a3`). Reuse of v8 namespace `RobustTrustV8` is intentional —
  the model primitives (Belief, Profile, RobustTrustModel, MenuHall,
  ExactContact, WTA machinery, Inventory axioms KRN/Borel-right-inverse/
  kernel-epsilon-selection) carry over without modification.

## Scope (formalization brief, locked 2026-05-21)

v9 in Lean targets the full v9 surface:

1. **T1** finite-menu Pareto-Hall calibration via Clarke–Danskin (axiomatize
   Clarke–Danskin stationarity in Inventory; prove multiplier → Bayes-cone
   calibration consequence).
2. **T2** α=0 singleton infinite-extension.
3. **Binary capstone** (|Ω|=2, α∈(0,1), (R-EE)+(R-TD)+(R-IES)), six sub-lemmas
   B1–B6.
4. **FBNF capstone** (|Ω|≥3, FBNF-1..5,7, FBNF-6 derived), F1–F4 lemmas plus
   three corollaries: spherical/radial, affine MLR, polyhedral-scalarizable.
5. **Hall biconditional** (deletion-compatible Hall duality solved) + WTA dual
   certificate Ψ=2/9 + reopening threshold D ≥ 2(1−α)/(9α).
6. **G4** finite-facet polyhedral LP threshold (P3 sufficient class).
7. **Primitive sufficient classes** P2*/P3/P4.
8. **Section G addendum** v9.2 sharpenings: binary tie-splitting, variable-margin
   P2.*, P6_G finite-graph FBNF.

Deferred / out of scope:
- The Robust Trust paper's own Theorem 1 (paper-internal; v9 imports it via
  Lemma 2 of its proof as a stated dependency, not as a Lean theorem to
  re-prove).
- Section F open-problem ledger items (unrestricted |Ω|≥3 wilderness — these
  are explicitly NOT claimed by v9).

## Inventory axioms expected

Reusable from v8 `Inventory` namespace:
- `measurable_argmax_selector` (KRN)
- `krn_borel_right_inverse`
- `kernel_infimum_epsilon_selection`

New v9 Inventory axioms (Mathlib does not have these; we axiomatize per v8 pattern):
- Clarke–Danskin stationarity (Clarke subdifferential calculus on Lipschitz
  value functionals; needed for T1).
- Strassen marginals theorem (1965; coupling existence under marginal
  dominance; needed for Hall biconditional G2c).
- Farkas / LP duality in conic form (for G1 finite cone-Hall and G4 LP
  threshold).
- Berge maximum theorem for set-valued correspondences (some uses in T4 and
  FBNF F1; check if Mathlib's version suffices before axiomatizing).
- Hausdorff–Alexandroff continuous surjection (reused from v8 Theorem 9 atomless
  τ Cantor canvas; if not lifted to Inventory in v8, lift now).
- Clarke–Fermat normal-cone stationarity (Clarke subdifferential at a local
  extremum is contained in the normal cone — likely a consequence of
  Clarke–Danskin but may need its own Inventory entry).

Each new Inventory axiom must have:
- Precise Lean statement.
- Citation to standard reference (Clarke 1990, Strassen 1965, Aliprantis–Border,
  Castaing–Valadier, Kechris 1995).
- One-paragraph justification of why Mathlib's current state forces
  axiomatization rather than proof.
