# Robust Trust extension

This repository records attempts to extend the existence direction of
Dworczak and Smolin, *Robust Trust* (2026), Theorem 2 beyond the finite
setting.

## Current Status

The current terminal artifact is `theorem_2_extension_proof_v8.md`, now filed
under `02_proof_history/theorem_versions/`. It gives a three-tier conditional
infinite-extension:

- Tier 1a: unconditional value-optimal agent strategy plus epsilon-adversaries.
- Tier 1b: exact adversary under exact-contact.
- Tier 2: robust rationalizability under exact-contact plus menu-Hall.

This is not a proof of the unrestricted infinite theorem and not a primitive
counterexample. The remaining bottleneck is a deletion-compatible Hall duality
theorem connecting sourcewise deletion certificates with messagewise
Bayes-calibration constraints.

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
