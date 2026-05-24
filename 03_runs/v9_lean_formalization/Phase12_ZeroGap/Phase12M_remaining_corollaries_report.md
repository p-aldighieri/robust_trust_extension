Implemented in [lean/v9_appendix.lean](<C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean>).

Build status: `lake build MathlibStarter.V9Main` passed with exit 0 in `C:\Users\dep89\.codex\memories\phase12l_mathlibstarter` after UTF-8 syncing `lean/main.lean` and `MathlibStarter/V9Main.lean`.

Sorry delta: `0`. Appendix proof sorries remain `12`; main proof sorries remain `15`.

Axioms: unchanged. No axiom or opaque declaration diff; the 9 v9 axiom declarations remain the same.

Refactor summary: affine MLR and polyhedral scalarizable primitives now carry the missing real FBNF package data: pasting weights, endpoint projections, FBNF6 stationarity, dominance margins, trust bands, fiberwise balance, foliation projection, fiber charts, `tauFiber`, and B/G alignment. Their corollaries now populate `FBNFPackage` from `prim.affineFoliation` / `prim.polyhedralFacetFoliation` plus those primitive fields, matching the Phase 12L spherical pattern.

Deleted the obsolete `fbnf_trivial_*` helper block entirely, plus the degenerate band helpers that only supported those placeholders. `rg` finds no remaining `fbnf_trivial_` or `fbnf_degenerate_band_` references in the synced Lean targets.