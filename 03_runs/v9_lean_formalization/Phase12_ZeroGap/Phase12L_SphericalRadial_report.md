Implemented in [lean/v9_appendix.lean](C:/Users/dep89/OneDrive/Economia/RA%20Piotr/robust_trust_extension/lean/v9_appendix.lean:3095).

Build: `lake build MathlibStarter.V9Main` passed with exit 0 in the synced scratch Lake mirror at `C:\Users\dep89\.codex\memories\phase12l_mathlibstarter`. I used the existing local public mathlib checkout because the repo’s OneDrive `.lake` artifacts are reparse placeholders.

Sorry delta: `0`. Existing appendix proof sorries remain `12`; no new `sorry`.

Axioms: unchanged. The v9 axiom count remains `9`; the existing `opaque` declarations are also unchanged.

Spherical-radial refactor: `FBNF-corollary-spherical-radial` no longer populates the package with `fbnf_trivial_*`, `1/1` weights, zero FBNF6 scalars, `True` balances, trivial charts/measures, or `rfl`. It now uses `prim.radialFoliation` for the real foliation/base/integrand and new spherical-radial primitive fields for antipodal pasting weights, endpoint projection, FBNF6 stationarity, radial trust bands, fiberwise balance, projection, chart, `tauFiber`, and B/G alignment, with citations to v9 §11.P4 plus Choquet/Bauer on `Δ(Ω)`.

Helper deletions: removed the unused `fbnf_trivial_fiberPsiIntegrand` helper and its three lemmas. The remaining `fbnf_trivial_*` helpers are still referenced by the affine-MLR and polyhedral corollaries, so I left them in place.