# Proof History

This directory preserves the version history of the proof attempt and the
route memos needed to avoid redoing blocked work.

## Version Guide

- `theorem_versions/theorem_2_extension_proof_v5.md`: Phil-Reny style route with
  strong auxiliary assumptions such as deterministic TRE-gen-Hall.
- `theorem_versions/theorem_2_extension_proof_v6.md`: menu-engine transition;
  useful but overreaches relative to the final state.
- `theorem_versions/theorem_2_extension_proof_v7.md`: three-tier correction and
  menu-Hall framing.
- `theorem_versions/theorem_2_extension_proof_v8.md`: terminal proof artifact.

The older `theorem_2_extension_proof*.md` files are retained for provenance,
not because they supersede v8.

## Route Records

- `prior_attempts_digest.md`: failed architectures and why they should not be
  restarted without new information. Updated 2026-05-21 with Pass 3 (Pareto-
  frontier route) results.
- `route_memos/phil_reny_route_memo.md`: durable memo for the Phil-Reny
  restricted-game and Lusin-lift approach.
- `route_memos/piotr_pareto_frontier_route_memo.md`: working hypothesis for
  Piotr's 2026-05-20 reformulation (subsets of $W^P$).
- `route_memos/piotr_pareto_frontier_results.md`: first-attempt closure
  summary (overridden by user 2026-05-21).
- `route_memos/piotr_pareto_frontier_pass3_chronicle.md`: Pass 3 chronicle
  with all positive contributions and the honest (D2)≡menu-Hall finding.

## Pass 3 deliverables (2026-05-21)

- `01_deliverables/exposition/exposition_v9.tex`: $v9$ exposition combining
  the $v8$ menu engine with Pass 3's Clarke-Danskin finite-menu Pareto-Hall,
  $\alpha=0$ unconditional, and compact-menu under (R1)+(R2-FES).
- `03_runs/piotr_pareto_frontier/`: full pipeline trace (12 prompt/response
  pairs across formalizer, literature, searcher×2, breakdown×2, prover×3,
  reviewer×3).
