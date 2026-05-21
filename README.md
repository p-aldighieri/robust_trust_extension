# Robust Trust extension

This repository records attempts to extend the existence direction of
Dworczak and Smolin, *Robust Trust* (2026), Theorem 2 beyond the finite
setting.

## Current Status (2026-05-21, v9)

Pass 3+ produced a substantial advance: the v8 closure-memo's
**deletion-compatible Hall duality theorem** is **proved as a biconditional**,
plus three primitive sufficient classes. After a six-pass verification block,
the honest framing is a **strong conditional / classification result**, not
an unconditional proof of unrestricted infinite-M Theorem 2 under standing alone.

**Five reviewer-PASS'd theorems**:
- (T1) Finite-menu Pareto-Hall calibration via Clarke-Danskin.
- (T2) α=0 singleton (degenerate).
- **Binary capstone** (|Ω|=2 unconditional under R-EE+R-TD+R-IES).
- **FBNF capstone** (|Ω|≥3 foliated unconditional under FBNF-1...5+FBNF-7).
- **G3 Hall biconditional + P2*/P3/P4 primitive sufficient classes + G4 LP threshold**.

Plus the explicit WTA ternary dual certificate Ψ(y) = 2/9 > 0 (failure
without baseline) and threshold $D \ge 2(1-\alpha)/(9\alpha)$ for reopening.

**Read first (v9)**:
- `01_deliverables/exposition/exposition_v9.pdf` — 14-page polished LaTeX exposition.
- `01_deliverables/closure/v9_consolidated.md` — full detailed consolidated proof memo (28k chars).
- `02_proof_history/route_memos/piotr_pareto_frontier_pass3_chronicle.md` — pass 3 chronicle.
- `03_runs/piotr_pareto_frontier/` — full pipeline trace (60+ prompt/response files).

## Earlier (v8) status

The previous terminal artifact is `theorem_2_extension_proof_v8.md` in
`02_proof_history/theorem_versions/`. It gave a three-tier conditional
infinite-extension:

- Tier 1a: unconditional value-optimal agent strategy plus epsilon-adversaries.
- Tier 1b: exact adversary under exact-contact.
- Tier 2: robust rationalizability under exact-contact plus menu-Hall.

The remaining bottleneck was a deletion-compatible Hall duality
theorem — **proved in v9 as a biconditional**.

## Read First

- `01_deliverables/exposition/exposition.pdf`: polished technical exposition.
- `01_deliverables/summaries/final_state_math_major_summary.pdf`: plain-language
  summary of the final proof state and remaining gap.
- `01_deliverables/summaries/phil_reny_route_math_major_summary.pdf`: summary of
  the earlier Phil-Reny route and why it stalled.
- `01_deliverables/chronicle/chronicle.pdf`: project chronicle.
- `01_deliverables/closure/project_closure_memo.md`: final state, route audit,
  and instructions on what not to redo.

## Repository Layout

- `00_inputs/`: raw inputs and durable source documents.
  - `primary_paper/`: local copy of *Robust Trust*.
  - `objective/`: project statement and project brief.
  - `external_suggestions/`: Phil Reny's suggestion and supporting references.
  - `durable_sources/`: bundled source documents used for model/project runs.
- `01_deliverables/`: polished outputs meant for reading or sharing.
  - `exposition/`: latest exposition source and rendered PDFs.
  - `chronicle/`: chronicle source and rendered PDF.
  - `summaries/`: math-major summaries and PDFs.
  - `closure/`: closure memo.
- `02_proof_history/`: versioned proof artifacts and route memos.
  - `theorem_versions/`: successive theorem-proof drafts.
  - `route_memos/`: durable route-specific planning and postmortem notes.
- `03_runs/`: raw proof-run workspaces, prompt packets, logs, and scripts.
  These are evidence and provenance, not polished exposition.
- `04_references/`: reserved for reference notes that are not already part of a
  raw input bundle.

## Build Policy

Track source files and final rendered PDFs. Do not track generated LaTeX
byproducts such as `.aux`, `.log`, `.out`, or `.toc`; these are ignored at the
repository root.
