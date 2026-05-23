According to a document from 2026-05-22, the prior review already treated conclusion-fields and arbitrary Prop certificate fields as load-bearing smuggling risks, specifically warning to remove fields such as capstoneConclusion, calibratedKernelExists, and robustRationalizableLabeling and make theorem conclusions state the actual target directly. 

decomposition_review_response

 On that standard, my final adversarial verdict is:

Clean: NO
Severity: HIGH
Reason: the build is zero-sorry, but the central B5 and capstone routes now close by projecting certificate fields rather than deriving the intended math from the advertised primitives. This is not a mere paper-citation/Inventory issue. It is a proof-shape issue: the last dragon was not slain; it was invited inside and renamed regBridge.

The paper’s Theorem 2 requires an adversarial strategy and messagewise Bayes optimality under the posterior induced by that strategy; the finite paper theorem gets existence via a finite saddle point, and the infinite extension’s hard part is precisely producing that saddle/calibration object. 

Robust_trust_Dworczak_Smolin

 The v9 ledger also frames the result as conditional/classificatory, with Reg/Ψ conditions nontrivial and not automatic; it explicitly says Ψ≤0, if assumed, is close to the conclusion, while as a biconditional it is a classification theorem. 

v9_consolidated

A. Scalar equality fields for B5

Classification: SMUGGLED.

These fields are CONCLUSION_AS_FIELD / SMUGGLED_CERTIFICATE under the 2026-05-22 policy.

The decisive point is not that the fields are “plain Eq on ℝ.” The decisive point is that the theorem’s target is definitionally:

lean
lhsL = rhsL ∧ lhsR = rhsR

and the package fields are exactly:

lean
binary_lhsL_rhsL_eq : lhsL = rhsL
binary_lhsR_rhsR_eq : lhsR = rhsR

so the proof is just:

lean
exact ⟨data.binary_lhsL_rhsL_eq, data.binary_lhsR_rhsR_eq⟩

That is not hypothesis-bundling in the acceptable sense. It proves “if the endpoint stationarity balance equations are fields, then endpoint stationarity balance holds.” The paper’s binary TRE construction treats balance equations as substantive calibration equations: posterior averages induced by message regions must equal the trust-region endpoints, and the adversary has to break indifference so that the posterior identity holds on whole message regions. 

Robust_trust_Dworczak_Smolin

 Projecting the two scalar equations skips exactly that work.

What should be done: remove the two equality fields from BinaryCapstoneData. Prove B5 from the advertised inputs: two-label Clarke-Danskin/T1 stationarity, TRS interval reduction, endpoint-only projected image, and interior endpoint stationarity. If that proof is not available, rename/demote the theorem to something like:

lean
binary_endpoint_stationarity_total_balance_assuming_scalar_balance

and do not count B5 as proved.

B. regBridge : RegPackage model fields

Classification: SMUGGLED.

RegPackage is legitimate as an explicit conditional Hall/regularity theorem input. It is not legitimate as a hidden field inside FBNFPackage, BinaryCapstoneData, and GraphFBNFPackage when the capstone proofs then ignore the geometric primitives.

The current route is:

lean
set reg := data.regBridge
have hPsi := PsiNonpos_of_regPackage reg
have hKernel := (Hall-biconditional reg).mpr hPsi
exact bridge reg hKernel

That means the advertised primitives, such as endpoint-fiber lift, TRS interval reduction, endpoint stationarity, fiber dominance, Kirchhoff balance, and local perturbability, are not doing the work. They become stage scenery while regBridge carries the real certificate.

This conflicts with the v9 dependency graph, which says the binary capstone should proceed through:

TRS interval → endpoint-only image → endpoint stationarity → B1 scalar endpoint-fiber lift → binary capstone

and FBNF should proceed through:

endpoint-supported fiber image → localized stationarity → conditional B1 + pasting → F4 capstone

not through a preloaded RegPackage. 

v9_consolidated

 It also conflicts with the intended Hall architecture: G3 is a fixed-label biconditional under Reg, where Ψ≤0 is the classification condition, and the reverse direction constructs the adversarial kernel and Bayes-cone posterior calibration. 

v9_consolidated

The “against” argument is only half-right. Yes, RegPackage is structural data syntactically. But semantically it contains the missing certificate: Bayes-cone membership and rowwise-minimizer/Bayes-cone consistency strong enough for PsiNonpos_of_regPackage to fire. Once every capstone package carries such a RegPackage, the proof has routed around the primitive theorem.

What should be done: remove regBridge as a field from the geometric packages. Replace it with constructor theorems that actually derive it:

lean
binary_primitives_to_RegPackage :
  BinaryCapstoneData model → ... → RegPackage model

fbnf_primitives_to_RegPackage :
  FBNFPackage model → ... → RegPackage model

graph_fbnf_primitives_to_RegPackage :
  GraphFBNFPackage model → ... → RegPackage model

Then the capstones may use PsiNonpos_of_regPackage. Until that constructor exists, any theorem using regBridge should be renamed as a Reg-conditional theorem, for example:

lean
binary_capstone_under_RegPackage_bridge
fbnf_capstone_under_RegPackage_bridge
graph_fbnf_under_RegPackage_bridge

and not advertised as a proof from the binary/FBNF/graph primitives.

C. PsiNonpos_of_regPackage

Classification: LEGITIMATE, with an upstream warning.

The lemma itself is legitimate. It is a proved support-function calculation, not an axiom and not a function-field shortcut. If reg.message_in_bayes_cone gives the truthful message posterior in the right Bayes cone, and reg.source_in_rowwise_bayes_cone gives source posteriors in the Bayes cone of rowwise-minimizer messages, then each term in the Hall dual functional is nonpositive. That is honest Lean math.

But the lemma is a diagnostic flare: any RegPackage implies PsiNonpos. So RegPackage is no longer merely “regularity” in the lightweight topological sense. It is a Reg-Hall certificate package. The v9 ledger already marks Reg/Ψ as nontrivial: Reg-1/Reg-2 are real restrictions, and Ψ≤0 is the exact cone-Hall feasibility condition when used as a biconditional. 

v9_consolidated

So I do not classify C as smuggled. I classify the lemma as legitimate, but it makes B smuggled whenever RegPackage is simply bundled into a capstone instead of derived from the capstone primitives.

Recommended hygiene: rename the structure or split it.

lean
RegTopologicalPackage      -- closed graph, compact values, support continuity
RegBayesConeCertificate    -- message/source Bayes-cone fields
RegPackage = both

Then PsiNonpos_of_regPackage should depend on the certificate part, not look like a free consequence of mere regularity.

D. The 9 Inventory.V9 axioms

Classification: mostly LEGITIMATE; three are BORDERLINE-LEGITIMATE and should stay under audit.

I textually inspected the final Lean surface you described as having exactly the 9 Inventory axioms. I am taking the reported Build PASS as given. The axiom count and names look consistent with the intended “external mathematical hammer” approach, provided their final Lean statements are precise and not arbitrary Prop → Prop trapdoors. The source-proof brief explicitly requires every new Inventory axiom to have a precise Lean statement, citation, and justification for why Mathlib does not cover it. 

source_proof

 A prior decomposition review warned that abstract Prop-shaped axioms such as unconstrained Farkas/Strassen/Clarke hypotheses were trapdoors and had to be replaced by concrete mathematical statements. 

decomposition_review_response

My per-axiom classification:

Axiom	Classification	Audit note
clarke_danskin_stationarity	LEGITIMATE	Standard nonsmooth-analysis external. Fine if stated as a Clarke-Danskin subgradient theorem with real hypotheses.
clarke_fermat_normal_cone	LEGITIMATE	Standard Clarke-Fermat constrained stationarity. Fine if not theorem-specific.
strassen_marginals	LEGITIMATE	Standard coupling/marginal theorem. Fine if stated with real measurable relation and marginal dominance hypotheses.
bogachev_kernel_factorization	LEGITIMATE	Standard disintegration/kernel factorization style external. Fine as an Inventory theorem.
farkas_lp_duality_conic	LEGITIMATE	Standard finite conic Farkas/LP duality. It must not be the old arbitrary primalFeasible : Prop ↔ dualNonpositive : Prop form.
hausdorff_alexandroff_continuous_surjection	LEGITIMATE	Standard topology external. Not suspicious by itself.
clarke_product_normal_cone_projection_bridge	BORDERLINE-LEGITIMATE	Plausible Clarke product-normal/projection calculus, but v9-shaped. Keep only if stated generally enough, not as “the normal cone fact needed here.”
kantorovich_rubinstein_scalar_bridge	BORDERLINE-LEGITIMATE	Standard scalar transport duality flavor, but because it is a “bridge,” audit its exact statement for theorem-specific packaging.
bayesian_barycenter_in_closed_convex	BORDERLINE-LEGITIMATE	The math is standard, but the Lean shape is v9-specific. Acceptable if it says only: barycenter of a probability measure supported in a closed convex subset of a finite-dimensional belief simplex lies in that subset.

I do not see the listed Inventory axioms as the main smuggling problem. The main problem is that B5 and the capstone theorems now consume certificate fields.

Final per-construct classifications
Construct	Classification	Reason
A. B5 scalar equality fields	SMUGGLED	Exact theorem conclusion is stored as fields.
B. regBridge : RegPackage model in capstone packages	SMUGGLED	Carries the Hall/Bayes-cone certificate; geometric primitives become decorative.
C. PsiNonpos_of_regPackage	LEGITIMATE	Proved lemma; it honestly follows from strong RegPackage fields. The upstream fields are the issue.
D. 9 Inventory axioms	LEGITIMATE / BORDERLINE-LEGITIMATE	Acceptable external axiom layer if statements are concrete and cited; not the central smuggling vector.
Bottom line

Clean: NO.
Severity: HIGH.

The formalization is not “zero-sorry but clean.” It is zero-sorry with certificate relocation. The proof object now passes by replacing hard derivations with fields that already contain the endpoint balance or the Hall/Bayes-cone certificate. That violates the 2026-05-22 anti-smuggling policy.

The fix is clear and local, but load-bearing: delete conclusion/certificate fields from theorem data structures, prove constructors from primitives into Reg/Hall objects, and only then let PsiNonpos_of_regPackage and the Hall biconditional do their job.