Implemented in [lean/v9_appendix.lean](/C:/Users/dep89/OneDrive/Economia/RA%20Piotr/robust_trust_extension/lean/v9_appendix.lean).

**Build Status**
`PASS` via UTF-8 concatenation fallback:
`lake env lean --stdin` on `lean/v8_main.lean + lean/v9_appendix.lean`.

The exact `V9Main.lean` write path was ACL-blocked, so I used the documented fallback. No Lean errors.

**Sorry Count**
`lean/v9_appendix.lean`: 15 total actual `sorry` lines, 7 new in this pass.  
Full v8+v9 concatenation: 18 actual `sorry` lines.

**New Axioms**
None.

**Witness Fields Removed**
Removed from `FBNFPackage`:
`conditionalB1PastingWitness`, `endpointSupportedFiberImageWitness`, `localizedStationarityFBNF6Witness`, `capstoneWitness`.

Removed from `PolyhedralLPInstance`:
abstract `psiNonpos`, `lpFeasible`, `g4Witness`; replaced with a concrete `ConicFarkasInstance`.

Removed from the three FBNF primitive classes:
`capstoneWitness`.

**Target Body Shapes**
F1/F2/F3/F4 no longer project package witnesses; each unfolds the concrete target and documents the missing bridge.  
G4 is fully derived by unfolding to conic dual/primal feasibility and applying `Inventory.V9.farkas_lp_duality_conic.symm`.  
The three FBNF corollaries assemble packages, prove trivial F1/F2/F3 pieces directly, then apply F4. They no longer use `prim.capstoneWitness`.

**New Honest Sorries**
F1: missing foliation-conditional measurable pasting bridge.  
F2: missing fiberwise endpoint-projection algebra bridge.  
F3: missing T1-to-FBNF6 endpoint stationarity bookkeeping.  
F4: missing FBNF capstone-to-QAE construction bridge.  
Three corollaries: primitive class dominance fields are still predicate labels, not proof fields, so each needs a bridge from the class hypotheses to FBNF-7 global fiber dominance.