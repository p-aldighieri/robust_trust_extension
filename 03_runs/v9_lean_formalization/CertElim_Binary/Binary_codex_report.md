Implemented in `lean/v9_appendix.lean`.

**Build**
- Requested MathlibStarter copy path was ACL-blocked: `V9Main.lean` write denied.
- Fallback check passed: byte-preserving concatenation of `lean/v8_main.lean` + `lean/v9_appendix.lean`, then `lake env lean ...` from MathlibStarter. Exit 0.

**Binary Cert-Elim**
- Removed all 6 `BinaryCapstoneData` witness fields:
  `endpointFiberLiftWitness`, `trsIntervalReductionWitness`, `endpointOnlyProjectedImageWitness`, `interiorMessageCalibrationWitness`, `endpointStationarityTotalBalanceWitness`, `capstoneWitness`.
- No `exact data.<witness>` projections remain for the Binary targets.
- Added no new axioms.

**Theorem Bodies**
- B1 invokes `Inventory.V9.strassen_marginals` via `endpointDominanceFromBalance`, then assembles scalar calibration from primitive scalar facts.
- B2 assembles `0 ≤ lL ∧ lL ≤ rR ∧ rR ≤ 1`.
- B3 derives endpoint image by case-splitting on `projSide`.
- B4 unfolds TRS/endpoint hypotheses, then honest `sorry`: missing `binary_interior_message_calibration`.
- B5 invokes `_hT1 2 data.endpointMenu`, then honest `sorry`: missing `binary_t1_multiplier_balance`.
- B6 assembles B1/B3/B5 and B2/B4 inputs, then honest `sorry`: missing `binary_capstone_to_qae`.

**Sorry Count**
- `lean/v9_appendix.lean`: 8 actual `sorry`s total.
- New Binary sorries: 3 (`B4`, `B5`, `B6`).
- Existing non-Binary sorries unchanged: 5.

**Downstream**
- `FBNF-F1-conditional-B1-measurable-pasting` typechecks in the full fallback check.
- `G-addendum-binary-tie-splitting` now calls Binary B1 directly and typechecks.