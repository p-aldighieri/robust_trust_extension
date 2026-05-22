T1 BLOCK PROVER REVIEW — VERDICT: PATCH

Line references below are to /mnt/data/v9_appendix.lean. I treated this as a source-level audit; I did not run lake build.

R1 — Predicates and data-witness fields

Verdict: PATCH

IsCalibrationMultiplierKernel

Not source-adequate. It only states that lamPlus and lamMinus are nonnegative, sum to one, and are measurable:

v9_appendix.lean:L290-L298

That is a simplex-valued measurable-kernel predicate, not the v9 §B.1 Clarke-Danskin representation. It omits the key source content:

support of λ⁺(s) on argmax_i s · w_i

support of λ⁻(s) on argmin_i s · w_i

the formulas defining g_i and q_i from λ⁺, λ⁻

the dependence on α and τ

The file comment explicitly says active support is “suppressed in the formal statement” and “implicit” in the construction:

v9_appendix.lean:L285-L289

That is the red flag. Source T1 requires active-face support and the integral identities; it does not merely require two measurable simplex maps. 

breakdown_01_response

ClarkeFermatAtMenu

Partly OK, but over-named. It states exactly:

∀ i, NormalConeW model (w i) (g i)

at:

v9_appendix.lean:L305-L309

That is a useful per-label normal-cone certificate. But it does not say “the Clarke subgradient at the menu maximizer lies in the negative normal cone of WP^k.” It does not mention ClarkeSubdiff, ClarkeNormalCone, WP^k, the finite-menu objective, or local maximality. It is a post-translation certificate, not Clarke-Fermat itself.

IsBorelCalibrationKernel

Not source-adequate. It only states boundedness of g and nonnegativity of q:

v9_appendix.lean:L316-L321

This does not encode “active-face weights are Borel measurable; integrals define g_i, q_i.” Borel measurability of λ± lives in IsCalibrationMultiplierKernel, but the bridge from λ± to g,q is absent.

MultiplierInBayesCone

OK as a final certificate. This one does express the final normalized-multiplier claim:

∀ i, 0 < q i → ∃ p : Belief model.Ω, p.val ω = g i ω / q i ∧ p ∈ BayesConeW model (w i)

at:

v9_appendix.lean:L326-L334

This matches the important formula p_i = g_i / q_i ∈ BayesConeW model (w_i). It is still a witness field, not a derivation.

Data-witness fields

The fields are sufficient for the current Lean theorem conclusions because the current theorem conclusions are just aliases for those fields:

v9_appendix.lean:L352-L362 and v9_appendix.lean:L368-L384

But they are not sufficient as formal encodings of v9 §B.1. Important content is still abstract, implicit, or missing:

localMax : Prop

paretoCompleted : Prop

active support of λ±

integral equations for g,q

mass balance ∑ i q_i = 1

the actual Inventory-to-witness derivation

The comments even mention bundled fields clarkeDanskinHyp and clarkeFermatLip, but those fields do not exist in FiniteMenuData:

v9_appendix.lean:L273-L283

That comment should be patched. Right now it describes a stronger implementation than the file contains.

R2 — Theorem statements vs source

Verdict: PATCH

The hypotheses _hLocal and _hPareto are parametrically present in L6 and L7:

v9_appendix.lean:L688-L694 and v9_appendix.lean:L706-L713

But they are unused. The underscores are honest little breadcrumbs: the proof does not consume local maximality or Pareto completion.

L6

The source claim is an integral Clarke-Danskin representation with active λ⁺, λ⁻, support on max/min faces, and integral definitions of g_i. The Lean theorem concludes only data.clarkeDanskinRepresentation, which unfolds to simplex-valued measurable λ±:

v9_appendix.lean:L370-L371

Missing: active support and integral representation.

L7

The source claim is Clarke-Fermat stationarity at the constrained menu maximizer. The Lean theorem concludes only the post-translated coordinate certificate NormalConeW model (w i) (g i):

v9_appendix.lean:L375-L376

This is useful, but the theorem statement does not expose the Clarke subgradient or the normal cone to WP^k.

L8

The source claim says the active-face weights are Borel measurable and that integrals define g_i, q_i. The Lean theorem concludes boundedness of g and nonnegativity of q:

v9_appendix.lean:L378-L380

That is much weaker. The integrals are in the docstring:

v9_appendix.lean:L715-L722

but not in the theorem type. Docstrings are decorative lanterns; Lean does not follow them into the cave.

T1 final

The final theorem matches the source conclusion only at the final certificate layer:

p_i = g_i / q_i ∈ BayesConeW model (w_i) is encoded in MultiplierInBayesCone:

v9_appendix.lean:L326-L334

The source theorem’s advertised route, Clarke-Danskin → Fermat → multiplier calibration, is not present in the theorem type or proof body.

R3 — Theorem proofs

Verdict: FLAG / PATCH

The four T1 proofs are verifier-style projections:

L6: data.multiplierKernelData
v9_appendix.lean:L688-L694

L7: data.fermatCertificate
v9_appendix.lean:L706-L713

L8: data.calibrationKernelData
v9_appendix.lean:L723-L729

T1 final: data.bayesConeCertificate
v9_appendix.lean:L740-L747

This is acceptable only if the ledger says: “Given a FiniteMenuData certificate, these theorem names verify the certificate.” It is not acceptable if the ledger claims: “T1 has been proved from the Inventory Clarke-Danskin and Clarke-Fermat axioms.”

The Inventory axioms exist:

v9_appendix.lean:L77-L105

but they are not invoked in the T1 proof bodies. That is not merely cosmetic. It means the α/(1-α) mixture computation, measurable active-face selection, and normal-cone-to-Bayes-cone step all live inside data fields.

Precise patch options:

Verifier patch: rename or document the theorems as certificate projections. For example:

FiniteMenuData.verify_clarkeDanskinRepresentation

FiniteMenuData.verify_multiplierBayesCone

Then the current proofs are fine, and the ledger should explicitly say T1 is a certificate interface.

Mathematical T1 patch: keep theorem names, but strengthen FiniteMenuData with concrete hypotheses and prove the fields from Inventory:

active-support predicates

integral equations for g,q

local-max/closed-feasible-set hypotheses

normal-cone translation

Bayes-cone normalization

Right now the code is halfway between those two stories. That is the patch smell.

R4 — Missing Inventory bridge

Verdict: OK / FLAG

The prover’s caveat is correct. The existing Inventory hammers are too abstract for the concrete T1 conclusion. clarke_danskin_stationarity gives an abstract Clarke subgradient in a closed convex hull:

v9_appendix.lean:L77-L90

clarke_fermat_normal_cone gives a Clarke normal-cone inclusion:

v9_appendix.lean:L92-L105

Neither one supplies:

a measurable active-face selector s ↦ (λ⁺(s), λ⁻(s))

Aumann/integral subdifferential interchange for the finite-menu integrand

active max/min support after ties

coordinate projection from W^k normality to labelwise NormalConeW

the translation ClarkeNormalCone ↔ NormalConeW

the normalization proof g_i/q_i ∈ Δ(Ω)

So the gap is correctly identified, but I would add one more bridge to the prover’s list: product normal-cone decomposition for W^k, i.e. turning the menu-level normal condition into ∀ i, NormalConeW model (w i) (g i).

Follow-up Inventory hammer:

A clean, honest one-piece axiom would be:

lean
axiom finite_menu_clarke_danskin_pareto_hall
  {model : RobustTrustModel} {k : Nat}
  (data : RawFiniteMenuModel model k)
  (hLocal : ParetoCompletedAmbientLocalMax data)
  :
  ∃ lamPlus lamMinus g q,
    ActiveSupportedSimplexKernels model data.w lamPlus lamMinus ∧
    IntegralMultiplierEquations model data.w lamPlus lamMinus g q ∧
    ClarkeFermatAtMenu model data.w g ∧
    MultiplierInBayesCone model data.w g q

Better, if the team wants less black-boxing, split it into three hammers:

lean
clarke_integral_active_selector
clarke_fermat_to_NormalConeW_product
normal_multiplier_to_BayesConeW

The source-proof brief expected Clarke-Danskin and Clarke-Fermat as Inventory axioms, with precise Lean statements and citations; the current T1 block consumes neither in proof bodies. 

source_proof

R5 — Consistency with T1 / Binary / FBNF dependencies

Verdict: OK as ledger semantics, FLAG as theorem semantics

The downstream dependencies are exactly as you described.

binary-L_B5-endpoint-stationarity-total-balance takes:

_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone

at:

v9_appendix.lean:L834-L842

FBNF-F3-localized-stationarity-FBNF6 takes the same universal hypothesis:

v9_appendix.lean:L872-L879

Since fd.multiplierBayesCone unfolds to MultiplierInBayesCone model fd.w fd.g fd.q, and FiniteMenuData already stores bayesConeCertificate, this universal hypothesis is trivially feedable by:

lean
fun k fd => fd.bayesConeCertificate

So yes: B5 and F3 are “fed by hypothesis = data” in the current design. This is acceptable for v9 ledger semantics only if the ledger explicitly treats these as theorem slots parameterized by certificate-bearing data. It is not acceptable as a claim that Binary/FBNF stationarity now derives from Clarke-Danskin in Lean.

The v9 source dependency graph says T1 is used in binary/FBNF stationarity, but the formal implementation has converted that dependency into a data-certificate interface. 

v9_consolidated

R6 — Anything missed

Verdict: PATCH

Several v9 §B.1 / §3 contents are missing or too hidden:

Active max/min support of λ±: missing.
The formal predicate suppresses it by comment rather than type:

v9_appendix.lean:L285-L289

Integral formulas for g_i and q_i: missing.
The formulas appear only in docstrings:

v9_appendix.lean:L715-L722

They do not appear in IsBorelCalibrationKernel.

Role of Pareto completion: unused.
localMax and paretoCompleted are fields:

v9_appendix.lean:L339-L343

and hypotheses:

v9_appendix.lean:L690-L693, v9_appendix.lean:L708-L712

but no proof consumes them.

Mass balance ∑ i q_i = 1: missing.
IsBorelCalibrationKernel only has q_i ≥ 0:

v9_appendix.lean:L316-L321

“Borel calibration kernel” is misnamed.
There is no kernel, no Borel map, and no calibration in IsBorelCalibrationKernel; it is bounded numerator plus nonnegative mass.

Clarke-Fermat sign is not visible.
NormalConeW is defined by ∑ nω*(vω-wω) ≤ 0:

v9_appendix.lean:L223-L228

That sign is compatible with w maximizing under a belief-like normal, but the theorem does not expose the passage from -ξ ∈ ClarkeNormalCone to this sign convention.

Original-message lift is not part of T1, correctly.
This is good. The source theorem is payoff-label calibration, not a full Definition-2 adversarial kernel. The broader project explicitly separates the original-message lift from the finite-label calibration theorem. 

prover_02_response

OVERALL

Are the four T1 theorems mergeable to v9-formalization?

Not as source-level T1. They are mergeable only as a clearly labeled certificate-verifier block. In their present form, the theorem names overpromise: they read like Clarke-Danskin and Clarke-Fermat have been invoked, but the proofs are direct projections from data fields. The current block is a tidy filing cabinet, not the factory that manufactures the certificates.

Confidence: HIGH

The Lean file confirms the prover’s caveat exactly. The formal T1 block does not derive the multipliers from Inventory.clarke_danskin_stationarity or derive Bayes-cone membership from Inventory.clarke_fermat_normal_cone. It stores the multiplier, Fermat, calibration, and Bayes-cone conclusions as fields of FiniteMenuData, then re-emits them. The final MultiplierInBayesCone predicate is source-aligned, but L6/L8 are too weak, active support and integral equations are absent from the types, and localMax/paretoCompleted are unused Prop flags.

Follow-up Inventory / measurable-selection hammer needed

Add either a single finite-menu calibration hammer or a three-step bridge:

lean
-- 1. Clarke-Danskin integral active selector
clarke_integral_active_selector :
  ... →
  ∃ lamPlus lamMinus g q,
    ActiveSupportedSimplexKernels ... ∧
    IntegralMultiplierEquations ...

-- 2. Clarke-Fermat/product normal bridge
clarke_fermat_to_NormalConeW_product :
  ... →
  ∀ i, NormalConeW model (w i) (g i)

-- 3. Normal multiplier to Bayes cone
normal_multiplier_to_BayesConeW :
  IntegralMultiplierEquations ... →
  (∀ i, NormalConeW model (w i) (g i)) →
  MultiplierInBayesCone model w g q

The missing heavy mathematical ingredient is the measurable active-face selector for compact-convex correspondences, plus the ClarkeNormalCone to NormalConeW translation for PayoffProfileSet model. Until that bridge is installed, this T1 block should wear a certificate-verifier badge, not a “proved from Inventory” crown.