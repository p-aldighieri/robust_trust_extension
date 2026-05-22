According to a document from 2026-05-22, here is the final-pass smuggling audit.

LEAN_SMUGGLING_AUDIT

Target: /mnt/data/v9_appendix.lean
Mode: static textual audit, not a lake build replay
Overall clean: NO
Severity: CRITICAL

The patch closes the visible AlphaZeroSingletonData_exists gap by introducing two unwhitelisted axioms that sit exactly on the proof path of the α=0 theorem. One of them is a missing-hypothesis existence theorem disguised as Inventory; the other is a proof-specific posterior-collapse goal. The second is especially direct contraband: it is materially the same proposition as the AlphaZeroSingletonData.posteriorAtConstantMessageIsPrior field, then applied verbatim to fill that field. The whitelist in the source-proof ledger contains Clarke/Fermat, Strassen, Farkas, Hausdorff–Alexandroff, and v8 selection stubs, but not these two new axioms. 

source_proof

CRITICAL FINDING 1 — Inventory.V9.bayes_best_response_exists

Location: v9_appendix.lean:L226-L228

lean
axiom bayes_best_response_exists
    (model : RobustTrustV8.RobustTrustModel) (μ : RobustTrustV8.Belief model.Ω) :
    ∃ σ : model.PrivateStrategy, RobustTrustV8.IsBayesOptimal model σ μ

Classification: SMUGGLED_AXIOM / MISSING_HYPOTHESIS_EXTERNAL

This is adjacent to a standard theorem, but it is not stated in standard theorem form. The mathematical result one would want is a Weierstrass/Berge maximum theorem: a continuous payoff functional on a compact strategy space attains its maximum. The axiom as written asserts the conclusion for every RobustTrustModel, but the v8 model only carries compactness/nonemptiness of PrivateStrategy and boundedness of profileOfPrivate; it does not carry continuity of profileOfPrivate or continuity of σ ↦ PrivatePayoff model σ μ. In v8, the missing continuity lives in ProfileRealizationSetup, whose fields include Φ_eq_profile, Φ_continuous, compactness/convexity of W, and realization/fiber hypotheses. That setup is not an argument to the axiom.

The code itself acknowledges the gap: the comment at v9_appendix.lean:L1220-L1226 says the existence is downstream of compactness plus continuity of profileOfPrivate, and that this continuity is “not a field of RobustTrustModel” but only available in intended instances. The axiom is then used at v9_appendix.lean:L1234-L1237 to create hBayes, and Classical.choose selects the witness at L1238-L1240.

Answers to requested scrutiny:

Named external theorem? Not as written. A properly stated Weierstrass/Berge lemma would be acceptable only with explicit compactness and continuity hypotheses.

Derivable from v8 primitives + continuity hypothesis? Yes. It should be proved from CompactSpace model.PrivateStrategy plus Continuous fun σ => PrivatePayoff model σ μ, or from ProfileRealizationSetup plus continuity of beliefDot μ.

Same as a proof goal? It is the exact local existential needed to construct sigma0 in AlphaZeroSingletonData_exists, so it is proof-target-shaped even though not identical to the final theorem.

Verdict: reject as Inventory. Refactor into a theorem with explicit continuity / ProfileRealizationSetup hypotheses, or add those hypotheses to AlphaZeroSingletonData_exists.

CRITICAL FINDING 2 — Inventory.V9.alpha_zero_posterior_collapse

Location: v9_appendix.lean:L230-L239

lean
axiom alpha_zero_posterior_collapse
    (model : RobustTrustV8.RobustTrustModel)
    (_hα : model.α = 0)
    (c₀ : model.M)
    (β : RobustTrustV8.AdviserKernel model)
    (hβ : ∀ s : model.M, β.kernel s = MeasureTheory.Measure.dirac c₀)
    (pd : RobustTrustV8.PosteriorDisintegration model)
    (μ0 : RobustTrustV8.Belief model.Ω)
    (hμ0 : μ0.val = model.μ0) :
    ∀ᵐ m ∂ (RobustTrustV8.MixtureMessageLaw model β), pd.Pβ β m = μ0

Classification: SMUGGLED_AXIOM / PROOF_GOAL_AS_AXIOM

This is not a named external theorem. It is a bespoke α=0 posterior-calculation lemma for this exact proof. Worse, it is materially the same as the certificate field it fills.

AlphaZeroSingletonData.posteriorAtConstantMessageIsPrior is defined at v9_appendix.lean:L527-L532 as:

lean
posteriorAtConstantMessageIsPrior :
  ∀ pd : PosteriorDisintegration model,
    ∀ᵐ m ∂MixtureMessageLaw model constantAdversary,
      pd.Pβ constantAdversary m = priorBelief model

Then AlphaZeroSingletonData_exists proves this field by applying the axiom directly at v9_appendix.lean:L1300-L1310. That is exactly the user’s red-flag category: a conclusion-like field is acceptable as a certificate ledger pattern, but an axiom whose conclusion is the field body is not.

There is also a missing-hypothesis concern. The axiom claims posterior collapse to model.μ0 for arbitrary RobustTrustModel and arbitrary PosteriorDisintegration. In v8, the relation between the adviser-posterior law and the prior is packaged separately as PosteriorLawConsistency.barycenter_eq_prior; it is not a field of RobustTrustModel. The axiom’s comment says pd.conditional_barycenter pins the posterior to the prior, but conditional_barycenter only identifies the posterior with the barycenter of a conditional source law. To identify that barycenter with μ0, the proof still needs the prior/barycenter law.

Answers to requested scrutiny:

Named external theorem? No. This is an internal derivation from mixture-law algebra, a constant Dirac kernel, disintegration, and prior/barycenter consistency.

Same as proof goal? Yes. It is the body of AlphaZeroSingletonData.posteriorAtConstantMessageIsPrior, modulo the explicit parameters. Direct match: field at L529-L532, axiom at L230-L239, application at L1308-L1310.

Derivable in-scope from pd.conditional_barycenter + pd.sourceLawβ_disintegrates? Partly, but not from those alone. A correct proof needs:

model.α = 0;

β.kernel s = dirac c₀;

a lemma that MixtureMessageLaw model β = dirac c₀;

pd.sourceLawβ_disintegrates to identify the conditional source law;

pd.conditional_barycenter to identify the posterior with the conditional barycenter;

a prior-law consistency hypothesis, such as PosteriorLawConsistency.barycenter_eq_prior or the corresponding τM barycenter statement.

The source project’s own framing treats the α=0 singleton theorem as a degenerate endpoint and the posterior equality as q-a.e. Bayes calibration, not as an external named theorem. 

decomposition

Verdict: reject as Inventory. Revert and prove it as a local lemma from v8 posterior-disintegration identities plus an explicit posterior-law-consistency hypothesis.

Other smuggling sweep

sorry: no live sorry token in proof bodies. The only hit is a stale comment at v9_appendix.lean:L1172 saying AlphaZeroSingletonData_exists was “declared with sorry.” The actual theorem now has no sorry.

Other axiom: the full Inventory.V9 axiom list is:

clarke_danskin_stationarity, L90-L101, whitelisted.

clarke_fermat_normal_cone, L106-L116, whitelisted.

strassen_marginals, L145-L151, whitelisted.

farkas_lp_duality_conic, L179-L182, whitelisted.

hausdorff_alexandroff_continuous_surjection, L196-L199, whitelisted by name, but its current statement is only Prop; if ever used, that should be sharpened.

bayes_best_response_exists, L226-L228, not whitelisted, smuggled.

alpha_zero_posterior_collapse, L230-L239, not whitelisted, smuggled.

opaque: ClarkeSubdiff at L43-L45 and ClarkeNormalCone at L49-L51. These are support objects for the whitelisted Clarke axioms, not proof-specific theorem axioms. Still, they should be documented in the Inventory ledger as benign opaque mathematical primitives.

constant: no Lean constant declarations found. Occurrences are comments or identifiers such as constantMessage.

Classical.arbitrary / Classical.choose:

constantMessage := Classical.arbitrary model.M at L503-L505 is legitimate, matching the user’s note: it picks a default message from a nonempty type.

Classical.choose at L1238-L1240 is ordinary witness extraction, but its source is the smuggled bayes_best_response_exists axiom, so the extraction itself is not the problem.

noncomputable section: L248-L1083, normal for this development.

unsafe, set_option linter ... false, admit, exact?: no live hits.

Structure fields of type Prop: the permitted certificate-verifier ledger pattern is still present. AlphaZeroSingletonData now uses concrete propositions for priorOptimal, posteriorAtConstantMessageIsPrior, and adversaryOptimal at L520-L536. The issue is not that these fields exist; the issue is that one of them is filled by a same-shaped axiom. Other conclusion-as-field packages are within the user-supplied permitted category.

Per-construct final classification
Construct	Status	Reason
Inventory.V9.bayes_best_response_exists L226-L228	SMUGGLED_AXIOM	Weierstrass/Berge-shaped but missing continuity hypotheses; used exactly to create the prior Bayes strategy in AlphaZeroSingletonData_exists.
Inventory.V9.alpha_zero_posterior_collapse L230-L239	SMUGGLED_AXIOM	Not external; it is the same as posteriorAtConstantMessageIsPrior and is applied directly to fill that field.
Whitelisted Clarke / Strassen / Farkas / Hausdorff axioms	PASS subject to whitelist	Names match expected Inventory dependencies, though Hausdorff–Alexandroff’s Prop statement is weak if used.
Classical.arbitrary model.M	PASS	Benign default-message choice.
Classical.choose hBayes	CONDITIONAL	Normal extraction, but hBayes comes from a smuggled axiom.
noncomputable section	PASS	Expected.
sorry	PASS	No live proof sorry; stale comment only.
Final recommendation

Do not accept and merely document these two new axioms in source_proof.md. bayes_best_response_exists should be refactored with stronger model-field hypotheses, preferably ProfileRealizationSetup or an explicit continuity assumption, then proved by a Weierstrass/Berge-style maximum theorem. alpha_zero_posterior_collapse should be reverted as an axiom and proved from v8 primitives: constant-Dirac kernel algebra, MixtureMessageLaw, PosteriorDisintegration.sourceLawβ_disintegrates, PosteriorDisintegration.conditional_barycenter, and an explicit prior/barycenter consistency hypothesis. As patched, the source-sorry has been replaced by two trapdoor axioms. The proof goblin has simply moved under a nicer rug.