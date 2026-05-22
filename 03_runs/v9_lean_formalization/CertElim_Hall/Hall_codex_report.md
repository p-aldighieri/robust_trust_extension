Build status: PASS. MathlibStarter copy was ACL-blocked, and repo-local `lake env lean lean/main.lean` cannot resolve `Mathlib`; verified with MathlibStarter’s lake env against the generated absolute `lean/main.lean`.

Changed only `lean/v9_appendix.lean` content. `lean/main.lean` content hash matches HEAD after verification.

Summary:
- Removed Hall witness fields from `RegPackage` and `FiniteConeHallInstance`.
- Added concrete `regPsi`; `PsiNonpos` now quantifies over `regPsi`.
- Replaced finite Hall instance with concrete `Inventory.V9.ConicFarkasInstance`.
- `Hall-G1` now fully proves via `Inventory.V9.farkas_lp_duality_conic`.
- `Hall-G2c` now builds a graph relation from `reg.G`, uses closed graph measurability, constructs `StrassenMarginalDominance`, and invokes `Inventory.V9.strassen_marginals`.
- `Hall-biconditional` now proves reverse via G2c and begins the forward kernel/support-function derivation.
- `robustRationalizableKernelExists_to_strategy` now destructs the calibrated kernel and uses `reg.σstar`, `B_bayes_optimal`, and v8 disintegration/barycenter fields.

Sorry count: 5 Hall-block `sorry` placeholders across 3 declarations.

New axioms added: 0.

Honest gaps:
- Hall dual-to-Strassen scalar test-function bridge.
- Disintegrating Strassen coupling into `AdviserKernel` plus posterior calibration.
- Local support-function `le_csSup` boundedness lemma.
- Integration/rowwise-infimum comparison for forward Hall.
- QAE bridge adversariality plus `Pβ = Pγα` transfer.

Downstream status: P2*/P3/P4/G-addendum consumers typecheck in the final Lean verification.