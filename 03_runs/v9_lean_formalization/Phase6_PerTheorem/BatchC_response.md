Batch F audit verdict

Batch verdict: PASS for proof routing, with hypothesis-fidelity caveats on the P-class theorem structures.

The Lean bodies for P2*, P3, P4, and variable-margin P2* are consistent with the intended “Reg-package-first” architecture: the real load-bearing theorem is hyp.reg; the body obtains PsiNonpos from PsiNonpos_of_regPackage, applies the reverse direction of Hall-biconditional, then uses the bridge to HasRobustRationalizableStrategy. This matches the v9 architecture in which G3 feeds P2*/P3/P4 and G4, while Reg-1/Reg-2 are nontrivial added regularity rather than consequences of standing assumptions. 

v9_consolidated

The caveat: the geometric P-class fields are mostly documentary/summary-level, not full primitive derivations of Ψ≤0. That is acceptable under the current Lean design, but it should be stated plainly. The v9 source itself classifies P2*, P3/G4, and P4 as meaningful but real restrictions, and says Ψ≤0 is an exact Hall condition when used as a diagnostic. 

v9_consolidated

1. «P2-star-cone-margin-bounded-jamming»

Verdict: PASS, with a documentation-fidelity patch recommended.

Lean route. Correct. The theorem follows the intended skeleton:

lean
set reg := hyp.reg
have hPsi : PsiNonpos model reg := PsiNonpos_of_regPackage reg
have hKernel : reg.robustRationalizableKernelExists :=
  («Hall-biconditional» reg).mpr hPsi
exact robustRationalizableKernelExists_to_strategy reg hKernel

So the theorem is not trying to reprove cone-margin geometry inside the body. It is using RegPackage as the certified structural package, which is exactly the requested architecture.

Hypothesis encoding. Mostly correct at the high level: the structure has cone-margin, bounded-jamming, enough-aligned-baseline fields, plus scalar margin/jamming witnesses. However, the v9 paper’s P2* description is more concrete: truthful messages lie uniformly inside Bayes cones, there is rowwise-minimizer traffic with a dominated target marginal, and a quantitative displacement bound keeps the mixture posterior inside the Bayes cone. The v9 memo’s displayed P2* condition includes cone margin, bounded rowwise jamming, and a high-aligned-mass inequality. 

v9_consolidated

Patch recommended. Add comments or fields documenting the actual P2* ingredients: rowwise-minimizer kernel κ₀, target marginal ρ, corrected density orientation dρ/dτ ≤ C, and the D_Δ displacement inequality. The proof remains unchanged.

2. «P3-polyhedral-cone-margin»

Verdict: PASS for the Reg/Hall route; PATCH_SMALL for statement fidelity.

Lean route. Correct and parallel to P2*: hyp.reg → PsiNonpos_of_regPackage → Hall-biconditional.mpr → bridge.

Hypothesis encoding. The structure records the right headline ingredients: polyhedralW, finiteVertexMenu, positiveConeMargin, and finiteLPFeasible. That aligns with the v9 ledger, where P3/G4 is the finite-facet/polyhedral LP sufficient class. 

v9_consolidated

What is missing. The paper-level P3/G4 statement is more explicit: finite active menu, finite facet representation of each Bayes cone, aligned-message cells, rowwise-minimizer cells, masses/means, and facet inequalities. The v9 memo explicitly warns that raw polyhedrality is not enough; the LP is the pass/fail certificate. 

v9_consolidated

Patch recommended. Keep theorem body as-is, but enrich P3Hyp with either:

a structured PolyhedralLPInstance, or

comments tying finiteLPFeasible to the G4 finite-facet LP theorem.

Without that, P3 is mathematically routed correctly but underspecified as a primitive-class statement.

3. «P4-radial-antipodal-tau-symmetry»

Verdict: PASS, with minor hypothesis-detail patch.

Lean route. Correct. Same Reg/Hall/bridge route as P2 and P3.

Hypothesis encoding. The fields capture the intended P4 headline: radial τ, utility equivariance, constructed antipodal kernel, scalar radial balance, and a measurable involution. This matches the paper’s radial/antipodal story: P4 is constructive, not a generic symmetry-averaging theorem. The v9 source emphasizes that radial/spherical models are handled by constructing a primal calibrated kernel through antipodal boundary routing and scalar radial balance. 

searcher_04_response

Patch recommended. Add a τ-invariance or measure-preserving field for the radial involution/group action. Current fields show measurability and involutivity, but not explicitly that the symmetry preserves the adviser-belief law. Also consider adding fields for radial center/ball trust region if the theorem is meant to mirror the paper statement more literally.

4. «G-addendum-binary-tie-splitting»

Verdict: PASS.

Lean route. Correct. The theorem applies Binary B1 directly by feeding it the post-split endpoint balance:

lean
«binary-L_B1-endpoint-fiber-lift» hyp.data hyp.endpointBalanceAfterSplit

This matches the intended addendum: tie mass is split first, then the usual endpoint-fiber lift is invoked. The Section G summary says binary tie-splitting relaxes the no-atom tie condition by dividing the tie atom between left and right endpoint transports while preserving endpoint calibration. 

v9_executive_summary

Special focus check. B1 is the correct dependency: Binary B1 is the scalar endpoint-fiber lift, and in the Lean file its transport/coupling step is routed through the Strassen-style marginal theorem via endpoint dominance. This is exactly the intended “tie-splitting derivation then Binary B1” pattern.

Scope note. This theorem proves endpointFiberLift, not the whole binary capstone. That is appropriate for an addendum sharpening of B1, not a standalone full robust-rationalizability theorem.

5. «G-addendum-variable-margin-P2-star-prime»

Verdict: PASS for proof route; PATCH_SMALL for density-cap fidelity.

Lean route. Correct. It follows the same Reg/Hall/bridge path as P2*:

lean
set reg := hyp.reg
have hPsi : PsiNonpos model reg := PsiNonpos_of_regPackage reg
have hKernel := («Hall-biconditional» reg).mpr hPsi
exact robustRationalizableKernelExists_to_strategy reg hKernel

Hypothesis encoding. The structure has the requested high-level pieces: η, positivity a.e., local density cap, variable cone margin, an η floor, a density cap scalar, and a domination inequality. This matches the user’s target summary: “η floor + density cap.”

Important fidelity issue. The variable-margin source says the valid weakening is local capacity domination, equivalently dρ/dτ ≤ Γ_η a.e.; a single averaged margin is not enough. It also explicitly warns that the density orientation should be adversarial target marginal dominated by truthful mass, i.e. dρ/dτ, not dτ/dρ. 

prover_22_response

 The Lean structure’s localDensityCap : Prop is too opaque to verify that exact orientation or the pointwise capacity inequality.

Patch recommended. Add a named field/comment tying localDensityCap to the corrected condition:

ρ(E) ≤ ∫_E Γη(m) dτ(m)    for all Borel E

or equivalently dρ/dτ ≤ Γη a.e. The body can still route through reg.

6. «G-addendum-P6_G-finite-graph-FBNF»

Verdict: PASS for the regBridge corollary pattern; PATCH_SMALL for graph primitive granularity.

Lean route. Correct in spirit. The theorem is a graph-FBNF corollary packaged through a RegPackage bridge, analogous to the F4 corollary pattern. It should not attempt to rebuild the graph transport in the theorem body once pkg.regBridge has already certified the Hall/Reg structure.

Graph-FBNF setup. The Lean package has the right top-level fields: finite graph, affine arc charts, endpoint-fiber transports on edges, Kirchhoff node balance, and cross-edge dominance. Those are the exact ingredients identified for patched P6ᴳ: finite Borel affine graph, endpoint-fiber transports, Kirchhoff/node balance, and cross-edge dominance. 

searcher_07_response

What is missing. The fields are mostly Prop summaries. The paper-level graph-FBNF setup is more explicit: finite graph G = (V,E), edge charts ℓ_e : [a_e,b_e] → Δ(Ω), trust restrictions [L_e,R_e], endpoint exposure, tie discipline, Kirchhoff node balance, Borel chart/quotient consistency, and cross-arc dominance. 

searcher_04_response

Patch recommended. If this theorem is meant to be primitive-facing rather than only a Reg-bridge corollary, add actual edge/node/chart fields: edge incidence, endpoint maps, Borel chart/quotient consistency, and endpoint-exposure/tie-discipline fields. If it remains a regBridge corollary, the current structure is acceptable as a documentary wrapper.

Cross-batch notes

The P-class bodies are deliberately “thin”: they do not use geometric fields to prove Hall. This is consistent with the decomposition rule that Hall/G3 feeds P2*/P3/P4 and G4. 

decomposition

 The geometric assumptions are therefore not load-bearing in Lean; RegPackage is the load-bearing object.

No mismatch was found in the proof-routing shape: all P-class and variable-margin P2* theorems route through hyp.reg; tie-splitting routes through Binary B1; finite-graph FBNF routes through the Reg bridge. The only issues are statement granularity and documentation fidelity, not proof failure.