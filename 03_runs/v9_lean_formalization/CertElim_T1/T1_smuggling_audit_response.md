I could not inspect v9_appendix.lean directly because it is not present in the mounted/uploaded workspace, so I cannot honestly certify a literal grep sweep or verify exact line numbers beyond the anchors you supplied: ParetoMenuPrimitives at reported v9_appendix.lean:559 and FiniteMenuData.fromParetoMenu at reported v9_appendix.lean:636.

OVERALL

verdict: FAIL as a ledger-sound T1 refactor
severity: HIGH
smuggled_certificates: 3 confirmed from the described ParetoMenuPrimitives fields
T1 theorem-body certificate-verifier eliminated? Likely YES, syntactically, assuming the four theorem bodies no longer end in exact data.<conclusion-field>.
T1 ledger soundness preserved? NO. The certificate-verifier pattern appears to have been moved into ParetoMenuPrimitives and FiniteMenuData.fromParetoMenu.

The v9 proof brief says T1 is supposed to “axiomatize Clarke–Danskin stationarity in Inventory” but then prove the multiplier-to-Bayes-cone calibration consequence, not assume it as a record field. 

source_proof

 The consolidated proof states T1 as a theorem where Clarke–Danskin stationarity produces multipliers, then defines g_i and q_i, and proves p_i = g_i / q_i ∈ B_W(w_i). 

v9_consolidated

 So fields that already assert the normal-cone inequality, nonnegativity of g, or mass balance are not harmless bookkeeping. They are little theorem capsules with hats and false mustaches.

T1 certificate-elim round 1
item	verdict
The four T1 theorem bodies no longer directly do exact data.<field>	Likely PASS syntactically, based on your description
ParetoMenuPrimitives as “atomic primitive” bundle	FAIL
FiniteMenuData.fromParetoMenu constructor	Suspicious / likely CERTIFICATE_VERIFIER, if it copies the three fields into FiniteMenuData proof slots
Overall next step	DERIVE specific fields
Accept as honest partial?	Only as a syntax cleanup, not as a soundness-preserving proof refactor
Finding 1: normal_cone_inequality is SMUGGLED_CERTIFICATE

reported location: v9_appendix.lean:559 inside ParetoMenuPrimitives

lean
normal_cone_inequality :
  ∀ i v, v ∈ PayoffProfileSet model →
    (∑ ω, g i ω * (v ω - paretoMenu i ω)) ≤ 0

classification: SMUGGLED_CERTIFICATE

This is not primitive data. It is exactly the labelwise normal-cone conclusion:

lean
g i ∈ N_W (paretoMenu i)

spelled out as an inequality. The decomposition of T1 says the L7 theorem should consume Inventory.clarke_fermat_normal_cone, apply Clarke-Fermat at a Pareto-completed local maximizer, and translate the result into “one normal-cone inequality per active label.” 

decomposition

 That is precisely this field.

So the answer to your question is YES: this should be derived from Inventory.V9.clarke_fermat_normal_cone plus a projection/product-normal-cone lemma, not bundled.

Required replacement:

lean
theorem normal_cone_inequality_from_clarke_fermat
  (...) :
  ∀ i v, v ∈ PayoffProfileSet model →
    (∑ ω, g i ω * (v ω - paretoMenu i ω)) ≤ 0 := by
  -- 1. Clarke-Fermat on W^k
  -- 2. product normal cone projection
  -- 3. unfold NormalConeW

If ParetoMenuPrimitives keeps this field, the T1 theorem bodies are clean only because the proof was hidden in the input record.

Finding 2: g_nonneg is ASSUMPTION_SMUGGLING

reported location: v9_appendix.lean:559 inside ParetoMenuPrimitives

lean
g_nonneg : ∀ i ω, 0 ≤ g i ω

classification: DERIVABLE_FACT_AS_FIELD

This should be a small algebraic lemma once g is defined as

g
i
	​

=α∫λ
i
+
	​

(s)sdτ+(1−α)∫λ
i
−
	​

(s)sdτ.

The v9 proof outline explicitly defines g_i from the Clarke multipliers and q_i from scalar masses, then proves the normalized posterior belongs to the simplex. 

v9_consolidated

 The decomposition likewise says T1-L8 must “define the vector numerator g_i and mass q_i,” prove nonnegativity, prove p_i := g_i / q_i is a belief, and then use the normal-cone inequality. 

decomposition

Best repair: make g a definition, not a free field. Then prove:

lean
theorem g_nonneg_from_lam
  (hα0 : 0 ≤ model.α)
  (hα1 : model.α ≤ 1)
  (hplus : ∀ s i, 0 ≤ lamPlus s i)
  (hminus : ∀ s i, 0 ≤ lamMinus s i)
  (hs : ∀ s ω, 0 ≤ s ω) :
  ∀ i ω, 0 ≤ g i ω := by
  -- integral nonneg + scalar nonneg

If g remains an arbitrary field and g_nonneg is supplied as a proof field, the record is certifying that g behaves like the intended integral without actually deriving it.

Finding 3: mass_balance is ASSUMPTION_SMUGGLING

reported location: v9_appendix.lean:559 inside ParetoMenuPrimitives

lean
mass_balance : ∀ i, (∑ ω, g i ω) = q i

classification: DERIVABLE_FACT_AS_FIELD

This should be derived from the definitions of g, q, and s ∈ Δ(Ω), not provided as an input. The intended Lemma 8 proof says mass balance follows from ∑ᵢ λ_i^\pm(s) = 1 and Fubini, while posterior-in-simplex follows because the numerator is nonnegative and its coordinates sum to q_i. 

prover_02_response

 The more detailed statement defines q_i, defines p_i = g_i/q_i, and asserts mass balance and p_i ∈ Δ(Ω) as proof obligations of the lemma, not as primitive assumptions. 

prover_02_response

Required replacement:

lean
theorem mass_balance_from_def
  (...) :
  ∀ i, (∑ ω, g i ω) = q i := by
  -- unfold g q
  -- exchange finite sum and integral
  -- use ∑ω s ω = 1
  -- scalar arithmetic

If g and q are not definitional expressions but independent fields, then mass_balance is even more suspicious: it is a consistency certificate tying unrelated inputs together.

FiniteMenuData.fromParetoMenu at reported L636

If the constructor does anything like:

lean
clarkeFermatStationarity := prim.normal_cone_inequality
multipliersAreCalibrationKernel := ...
g_nonneg := prim.g_nonneg
mass_balance := prim.mass_balance

then it is a constructor-level certificate verifier. The smuggling is no longer visible in the four theorem bodies because it moved to the record assembly layer.

The prior decomposition review already flagged this family of pattern as dangerous: bare Prop fields in structures like FiniteMenuData, BinaryCapstoneData, and RegPackage can make theorems vacuous, and conclusion fields should be removed so the theorem concludes the target directly. 

decomposition_review_response

 That criticism applies here with extra force because the new fields are not merely broad assumptions; they are the exact proof obligations T1 was supposed to establish.

Other smuggling categories

I cannot certify the following without the actual v9_appendix.lean file, but here is the adversarial checklist result based on the described design and the v9 scaffold.

category	result
CONCLUSION_AS_FIELD / SMUGGLED_CERTIFICATE	At least 3, all in ParetoMenuPrimitives
T1 theorem-body exact data.<field>	Likely 0, based on your description only
constructor-level verifier	Likely present at FiniteMenuData.fromParetoMenu, if it transports these fields
new sorry	Not auditable, file missing
new axiom, opaque, constant	Not auditable, file missing
Classical.choice abuse	Not auditable, file missing
bare Prop fields in Binary/FBNF/Hall packages	Known risk from the v9 decomposition; previous review says these must be expanded or removed

Inventory axioms are allowed only for real external dependencies with precise statements. The source proof explicitly requires each new Inventory axiom to have a precise Lean statement, a standard reference, and a justification for why Mathlib cannot supply it. 

source_proof

 A later structural patch makes the same point: abstract Prop-shaped external hammers were trapdoors and needed concrete mathematical hypotheses. 

structural_refinement_response

Counter block
certificate_verifiers_in_T1_bodies: 0 likely, unverified
constructor_level_certificate_verifiers: 1 likely
smuggled_certificates: 3
conclusion_as_field: at least 3
new_sorry: unknown, file unavailable
new_axiom_constant_opaque: unknown, file unavailable
Classical.choice_abuse: unknown, file unavailable
bare_Prop_hypothesis_structures: present in prior scaffold; must re-audit actual file
Recommended next step

DERIVE specific fields. Do not accept the refactor as ledger-sound. Do not revert unless the derivations fail.

Patch plan:

Keep ParetoMenuPrimitives only for genuinely primitive inputs: menu, multipliers, support constraints, simplex properties, local maximality, Pareto completion, and definitions of g and q.

Remove:

lean
normal_cone_inequality
g_nonneg
mass_balance

from ParetoMenuPrimitives.

Add derived lemmas:

lean
normal_cone_inequality_from_clarke_fermat
g_nonneg_from_lam_integral
mass_balance_from_g_q_def

Make FiniteMenuData.fromParetoMenu call these lemmas, not copy proof fields.

Re-run:

Bash
grep -R "exact .*\\.\\(normal_cone_inequality\\|g_nonneg\\|mass_balance\\|multiplierBayesCone\\|clarkeFermatStationarity\\|multipliersAreCalibrationKernel\\)" .
grep -R "axiom\\|opaque\\|constant\\|sorry\\|Classical.choice" v9_appendix.lean

Run #print axioms on the four T1 theorems and the constructor output.

Final verdict: the T1 theorem-body cleanup is an honest syntactic partial, but the current ParetoMenuPrimitives design pushes the certificate into the basement. Accept only after the three fields are derived in Lean.