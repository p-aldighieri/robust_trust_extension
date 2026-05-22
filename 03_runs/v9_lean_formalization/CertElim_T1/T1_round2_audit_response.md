Round-2 T1 cert-elim smuggling audit

Static audit only: I inspected /mnt/data/v9_appendix.lean by line number. I could not run lake build because Lean/Lake is not installed in this container. So this is a ledger/smuggling audit, not a compile verdict.

T1 verdict: ACCEPT. The three Round-1 smuggled fields are not simply moved into ParetoMenuPrimitives; the T1 refactor is substantially honest.
T1 severity: LOW. The only low-grade concern is that the new product normal-cone projection axiom is powerful, but it is structural and properly parameterized, not a direct downstream certificate.
Appendix-wide residual severity: HIGH outside T1. Binary/FBNF/Hall still contain conclusion-shaped witness fields and should remain quarantined from any “proved theorem” claim.

1. ProductClarkeFermatPrimitive

Verdict: PASS for T1.

ProductClarkeFermatPrimitive contains:

objective, productPayoff_closed, objective_lipschitz, localMaxOn, subgradient, subgradient_mem, and negative_subgradient_represents_g; see v9_appendix.lean:L394-L410.

That is the right kind of bundle for this refactor. It does not contain the old downstream certificates:

normal_cone_inequality, g_nonneg, or mass_balance.

The potentially sensitive fields are subgradient_mem and negative_subgradient_represents_g. Those are not the downstream normal-cone inequality; they are the Clarke-output plus representation of the chosen product subgradient in the finite-product profile coordinates. The final per-label normal-cone inequality is still derived later through the Clarke-Fermat axiom and the projection bridge, not stored here. Evidence: the product primitive only gives membership in ClarkeSubdiff and the equality representation of -subgradient; it does not assert ∀ i v, ... ≤ 0 directly. See v9_appendix.lean:L404-L410.

2. clarke_product_normal_cone_projection_bridge

Verdict: PASS with LOW documentation note.

The axiom is stated at v9_appendix.lean:L420-L432. Its inputs are:

η ∈ ClarkeNormalCone (ProductPayoffProfileSet model k) w, plus a representation condition mapping coordinate updates to the finite inner product with g; see v9_appendix.lean:L424-L431.

Its conclusion is:

∀ i, NormalConeW model (w i) (g i), see v9_appendix.lean:L432-L432.

This is a product normal-cone projection statement, not just the exact downstream theorem. The downstream inequality only appears later after the theorem unfolds NormalConeW and applies it to v; see v9_appendix.lean:L819-L829.

The citation is real at the source level. Clarke’s Optimization and Nonsmooth Analysis is a SIAM Classics book by Frank H. Clarke, published in 1990, with a chapter on mathematical programming and nonsmooth analysis machinery. 
SIAM
 Aubin–Frankowska’s Set-Valued Analysis is also real; its table of contents explicitly includes tangent cones, normal cones, epiderivatives, and generalized gradients. 
Goettingen State and University Library

Small documentation nit: the code comment cites “Aubin–Frankowska Ch. 6” for the component projection rule. The TOC shows normal cones in Ch. 4.4 and generalized gradients in Ch. 6.4, so I would change the comment to “Aubin–Frankowska Chs. 4 and 6” to avoid bibliographic fuzz. That is not a smuggling issue.

3. ParetoMenuPrimitives: all remaining fields

Verdict: PASS.

The remaining fields at v9_appendix.lean:L724-L767 are:

Field	Lines	Classification
paretoMenu	725-726	raw input menu
inWP	727-728	regularity/feasibility of input
localMax	729-730	optimization hypothesis input
paretoCompleted	731-732	optimization/regularity input
lamPlus	733-736	Clarke-Danskin multiplier output
lamPlus_nonneg	737	simplex property of multiplier
lamPlus_sum_one	738	simplex property of multiplier
lamPlus_measurable	739	measurability regularity
lamMinus	740-741	Clarke-Danskin multiplier output
lamMinus_nonneg	742	simplex property of multiplier
lamMinus_sum_one	743	simplex property of multiplier
lamMinus_measurable	744	measurability regularity
lamPlus_coord_integrable	745-751	analytic side condition for Fubini/sum-integral exchange
lamMinus_coord_integrable	752-755	analytic side condition for Fubini/sum-integral exchange
g_bounded	756-760	boundedness/regularity of derived gOf
clarkeFermatProduct	761-767	product-level Clarke-Fermat primitive bundle

The Round-1 contraband fields are absent here. There is no normal_cone_inequality, no g_nonneg, and no mass_balance in ParetoMenuPrimitives.

4. g_nonneg, mass_balance, normal_cone_inequality theorem bodies

Verdict: PASS.

g_nonneg is a theorem, not a projection. It invokes gOf_nonneg with lamPlus_nonneg, lamMinus_nonneg, and α ∈ [0,1]; see v9_appendix.lean:L779-L784. The underlying proof of gOf_nonneg uses integral_nonneg and the nonnegativity of beliefs; see v9_appendix.lean:L293-L315.

mass_balance is a theorem, not a projection. It invokes mass_balance_gOf_qOf; see v9_appendix.lean:L793-L797. The underlying derivation is real: it exchanges finite sums and integrals via integral_finset_sum, uses the simplex sum of each belief, unfolds gOf/qOf, and rewrites to the target equality; see v9_appendix.lean:L334-L388.

normal_cone_inequality is a theorem, not exact prim.<field>. It applies clarke_fermat_normal_cone to obtain a product Clarke-normal element, then applies clarke_product_normal_cone_projection_bridge, then extracts the per-label NormalConeW inequality; see v9_appendix.lean:L799-L829.

This is the important bit: the theorem body is not “field projection in a trench coat.” It is a small proof pipeline with two external nonsmooth-analysis hammers.

5. FiniteMenuData.fromParetoMenu

Verdict: PASS.

fromParetoMenu uses derived definitions and theorems, not the removed primitive fields.

Assignments:

g := ParetoMenuPrimitives.g prim and q := ParetoMenuPrimitives.q prim; see v9_appendix.lean:L867-L868.

q_nonneg := ParetoMenuPrimitives.q_nonneg prim; see v9_appendix.lean:L875-L877.

normal_cone_inequality := ParetoMenuPrimitives.normal_cone_inequality prim; see v9_appendix.lean:L878-L879.

normalized_nonneg is derived from ParetoMenuPrimitives.g_nonneg; see v9_appendix.lean:L890-L894.

normalized_sum_one is derived from ParetoMenuPrimitives.mass_balance; see v9_appendix.lean:L895-L904.

So the constructor no longer reads prim.normal_cone_inequality, prim.g_nonneg, or prim.mass_balance. I also searched for direct projections like prim.normal_cone_inequality, prim.g_nonneg, and prim.mass_balance; none occur.

One nuance: FiniteMenuData itself still has fields named normal_cone_inequality, normalized_nonneg, and normalized_sum_one; see v9_appendix.lean:L627-L684. That is acceptable only if FiniteMenuData is treated as an output/certificate record and canonical construction goes through fromParetoMenu. The T1 refactor specifically fixes the primitive-input side.

6. Other smuggling sweep
New sorry

No executable sorry found. The literal sorry hits are comments documenting a previously reverted T2 gap; see v9_appendix.lean:L224-L227 and v9_appendix.lean:L1717-L1790. The current AlphaZeroSingletonData_exists body is filled with an attempted measure/disintegration proof; see v9_appendix.lean:L1791-L2052.

New axioms / opaque objects

There are opaque/external objects:

ClarkeSubdiff, ClarkeNormalCone; see v9_appendix.lean:L43-L51.

External axioms:

clarke_danskin_stationarity, clarke_fermat_normal_cone, strassen_marginals, farkas_lp_duality_conic, hausdorff_alexandroff_continuous_surjection; see v9_appendix.lean:L93-L122, v9_appendix.lean:L151-L157, v9_appendix.lean:L185-L188, and v9_appendix.lean:L208-L211.

New T1-specific axiom:

clarke_product_normal_cone_projection_bridge; see v9_appendix.lean:L420-L432.

The T1-specific one is acceptable as a structural inventory axiom, not a smuggled T1 certificate. The broader Inventory surface is still large, but not newly suspicious for this T1 check.

Classical.choice / arbitrary picks

No actual Classical.choice use appears in code; it appears only in comments around the T2 construction. There is Classical.arbitrary for constantMessage; see v9_appendix.lean:L914-L916. That is not T1-related and is not a certificate-elim issue.

noncomputable section

There is a module-level noncomputable section; see v9_appendix.lean:L236-L236. The noncomputability is expected for integrals, sSup, choice-like selectors, and external analysis objects. I do not see it hiding a T1 certificate.

Bare Prop / conclusion-shaped fields outside T1

This is the big caveat. The appendix still has many non-T1 witness fields that are conclusion-shaped. Examples:

Binary capstone has capstoneWitness : HasRobustRationalizableStrategy model pd; see v9_appendix.lean:L1071-L1075. The theorem binary-L_B6-capstone returns that witness directly; see v9_appendix.lean:L2146-L2163.

FBNF has capstoneWitness; see v9_appendix.lean:L1200-L1204, and FBNF-F4-capstone returns it directly; see v9_appendix.lean:L2217-L2233.

Hall/Reg has hallG2cWitness, hallBiconditionalWitness, and bridgeWitness; see v9_appendix.lean:L1275-L1295, and theorems project them at v9_appendix.lean:L2257-L2292.

P2/P3/P4 contain psiNonposWitness; see v9_appendix.lean:L1365-L1392.

Graph FBNF has capstoneWitness; see v9_appendix.lean:L1413-L1422.

Spherical/MLR/polyhedral primitive classes have capstoneWitness; see v9_appendix.lean:L1434-L1493.

These are not part of the T1 cert-elim patch, but appendix-wide they remain high-severity certificate-style scaffolding if anyone tries to claim those theorems as derived. They should stay marked FURTHER_DERIVE.

Findings
ID	Severity	Location	Finding	Action
T1-01	NONE	L724-L767	Old smuggled fields removed from ParetoMenuPrimitives.	Accept
T1-02	NONE	L779-L829	g_nonneg, mass_balance, and normal_cone_inequality are real theorem bodies.	Accept
T1-03	LOW	L420-L432	Product normal-cone projection bridge is powerful but structural and properly parameterized.	Keep, maybe improve source comment
T1-04	NONE	L855-L905	fromParetoMenu populates fields using new theorems, not primitive projections.	Accept
DOC-01	LOW	L412-L419	Aubin–Frankowska citation should say Chs. 4 and 6, not just Ch. 6.	Patch comment
NON-T1-01	HIGH	L1021-L1075, L1166-L1204, L1247-L1295, etc.	Binary/FBNF/Hall/P-class witness fields remain conclusion-shaped.	Further derive, but do not revert T1
Final verdict

OVERALL for T1 cert-elim round 2: Honest. The smuggling did not simply move deeper into ParetoMenuPrimitives. The old certificates were replaced by definitional gOf/qOf, elementary g_nonneg and mass-balance derivations, and a structurally standard Clarke product-normal-cone bridge.

Severity: LOW for T1, because of the new structural axiom and a minor citation-documentation issue.
Recommended next step: ACCEPT the T1 cert-elim refactor. Keep Binary/FBNF/Hall witness fields on a separate FURTHER_DERIVE ledger.