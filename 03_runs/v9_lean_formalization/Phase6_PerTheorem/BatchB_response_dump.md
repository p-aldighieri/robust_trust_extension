
========
ROLE: user (id=70f9e5a2-4ac8-46c5-bbf6-d9f2c5540dfb)
========
ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro (gpt-5.5-pro-xhigh).# Contextv9 formalization in v9_appendix.lean at zero sorries, 9 paper-cited axioms. Verify per-theorem translation/smuggling/scope vs v9 paper.# Batch B — T2 / AlphaZero block (3 theorems)Audit these:1. **AlphaZeroSingletonData_exists** (v9_appendix.lean ~L2508)2. **AlphaZeroSingletonData.to_hasRobustRationalizableStrategy** (~L2442)3. **«T2-alpha-zero-singleton-prior-strategy»** (~L2777)The v9 paper §B.2 / exposition_v9.tex §4 covers the α=0 unconditional infinite-extension theorem.# Audit per theorem1. Quote Lean signature + proof body.2. Quote v9 paper English statement + proof (look up in v9_consolidated.md §B.2 / exposition_v9_paper.tex §4).3. Translation: PASS / SCOPE_NARROWED / SCOPE_WEAKENED / CONCLUSION_DIFFERS / HIDDEN_ASSUMPTIONS.4. Smuggling: does the proof body derive honestly?5. Verdict per theorem: PASS / SCOPE_DRIFT / SMUGGLING_FLAG / CRITICAL.Note: The v9 paper's T2 is the "α=0 unconditional" case — the agent simply ignores the adviser and plays Bayes-optimal at the prior. The Lean proof should reflect this construction.# Output formatPer theorem block as in Batch A. End with batch verdict: PASS / NEEDS_FIX.
Show more

========
ROLE: assistant (id=6525c7e5-345c-4a25-a497-1c9e526b55a0)
========
Textual audit of /mnt/data/v9_appendix.lean; I did not re-run lake build. The α=0 construction is recognizably the v9 paper construction: pick a prior-Bayes continuation, ignore the adviser, make the adversary send a constant message, use Bayes plausibility to get posterior μ
0
	​

, and use message-independence to make the constant adversary adversarial. The paper-side target is exactly that: v9 says that when α=0, the agent ignores the adviser, plays Bayes-optimal at the prior, the adversary sends a constant message, and the single on-path posterior is μ
0
	​

. It also marks this as a complete infinite-M,Θ theorem but a degenerate endpoint, not the substantive α∈(0,1) case.

1. AlphaZeroSingletonData_exists
Lean signature and proof body

From /mnt/data/v9_appendix.lean L2508-L2768:

lean
theorem AlphaZeroSingletonData_exists
    {model : RobustTrustModel}
    (_hα : model.α = 0)
    (_plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (prs : ProfileRealizationSetup model) :
    Nonempty (AlphaZeroSingletonData model) := by
  classical
  -- (1) Bayes-best existence at the prior, from compactness of
  --     `model.PrivateStrategy` + continuity of `profileOfPrivate`
  --     (via `prs.Φ_continuous` and `prs.Φ_eq_profile`).
  have hΦ_cont : Continuous (model.profileOfPrivate) := by
    have := prs.Φ_continuous
    rw [prs.Φ_eq_profile] at this
    exact this
  have hPay_cont :
      Continuous (fun σ : model.PrivateStrategy =>
        PrivatePayoff model σ (priorBelief model)) := by
    unfold PrivatePayoff beliefDot
    refine continuous_finset_sum Finset.univ ?_
    intro ω _
    exact (continuous_const).mul ((continuous_apply ω).comp hΦ_cont)

  have hcpct : IsCompact (Set.univ : Set model.PrivateStrategy) := isCompact_univ
  have hne : (Set.univ : Set model.PrivateStrategy).Nonempty := Set.univ_nonempty
  obtain ⟨sigma0, _hsigma0_mem, hsigma0_max⟩ :=
    hcpct.exists_isMaxOn hne hPay_cont.continuousOn

  have hsigma0_opt :
      IsBayesOptimal model sigma0 (priorBelief model) := by
    intro σ'
    exact hsigma0_max (Set.mem_univ σ')

  let priorStrategy : AgentStrategyFull model :=
    { sectionFull := fun _ => sigma0
      measurable_sectionFull := measurable_const }

  let constantAdversary : AdviserKernel model :=
    { kernel := ProbabilityTheory.Kernel.const model.M
                  (Measure.dirac (constantMessage (model := model)))
      isMarkov := by
        haveI : IsProbabilityMeasure
            (Measure.dirac (constantMessage (model := model))) :=
          MeasureTheory.Measure.dirac.isProbabilityMeasure
        infer_instance }

  have hMis_const :
      ∀ β : AdviserKernel model,
        MisalignedPayoffFull model β priorStrategy =
          ∫ s, beliefDot (model.inclM s)
                (model.profileOfPrivate sigma0) ∂model.τM := by
    intro β
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    unfold MisalignedPayoffFull MisalignedPayoffM restrictFullToM profileMap
    apply MeasureTheory.integral_congr_ae
    refine Filter.Eventually.of_forall ?_
    intro s
    haveI : IsProbabilityMeasure (β.kernel s) :=
      β.isMarkov.isProbabilityMeasure s
    simp [priorStrategy]

  have hMix_const :
      ∀ β : AdviserKernel model,
        MixturePayoffFull model β priorStrategy =
          model.α * AlignedPayoffFull model priorStrategy +
          (1 - model.α) *
            ∫ s, beliefDot (model.inclM s)
                  (model.profileOfPrivate sigma0) ∂model.τM := by
    intro β
    unfold MixturePayoffFull
    rw [hMis_const β]

  refine ⟨{
    priorStrategy := priorStrategy
    constantAdversary := constantAdversary
    priorOptimal := ?_
    posteriorAtConstantMessageIsPrior := ?_
    adversaryOptimal := ?_ }⟩

  · intro m
    simpa [priorStrategy] using hsigma0_opt

  · intro pd
    classical
    haveI : IsProbabilityMeasure model.τM := model.τM_prob
    haveI : ProbabilityTheory.IsMarkovKernel constantAdversary.kernel := constantAdversary.isMarkov
    haveI : IsProbabilityMeasure
        (Measure.dirac (constantMessage (model := model))) :=
      MeasureTheory.Measure.dirac.isProbabilityMeasure
    haveI hSingletonM : MeasurableSingletonClass model.M := by infer_instance
    have hα0 : model.α = 0 := _hα

    have hτMprodSnd :
        ((model.τM.compProd
            (ProbabilityTheory.Kernel.const model.M
              (Measure.dirac (constantMessage (model := model))))).map
              Prod.snd) =
            Measure.dirac (constantMessage (model := model)) := by
      rw [Measure.compProd_const, Measure.map_snd_prod]
      have hτuniv : model.τM Set.univ = 1 := measure_univ
      rw [hτuniv, one_smul]

    have hMix :
        MixtureMessageLaw model constantAdversary =
          Measure.dirac (constantMessage (model := model)) := by
      unfold MixtureMessageLaw
      show (ENNReal.ofReal model.α) • model.τM +
          (ENNReal.ofReal (1 - model.α)) •
            ((model.τM.compProd constantAdversary.kernel).map Prod.snd) =
          Measure.dirac (constantMessage (model := model))
      rw [hα0]
      simp only [sub_zero, ENNReal.ofReal_zero, ENNReal.ofReal_one,
        zero_smul, zero_add, one_smul]
      exact hτMprodSnd

    have hCoup :
        MixtureCouplingGammaAlpha model constantAdversary =
          model.τM.prod (Measure.dirac (constantMessage (model := model))) := by
      unfold MixtureCouplingGammaAlpha
      show (ENNReal.ofReal model.α) • (model.τM.map (fun s : model.M => (s, s))) +
          (ENNReal.ofReal (1 - model.α)) •
            (model.τM.compProd constantAdversary.kernel) =
          model.τM.prod (Measure.dirac (constantMessage (model := model)))
      rw [hα0]
      simp only [sub_zero, ENNReal.ofReal_zero, ENNReal.ofReal_one,
        zero_smul, zero_add, one_smul]
      exact Measure.compProd_const

    have hDis := pd.sourceLawβ_disintegrates constantAdversary
    have hmeas1 : Measurable
        (fun s : model.M => (s, constantMessage (model := model))) :=
      measurable_id.prodMk measurable_const
    have hmeas2 : Measurable
        (fun p : model.M × model.M => (p.2, model.inclM p.1)) :=
      measurable_snd.prodMk (model.inclM_measurable.comp measurable_fst)

    have hLHS :
        (MixtureCouplingGammaAlpha model constantAdversary).map
          (fun p : model.M × model.M => (p.2, model.inclM p.1)) =
        (Measure.dirac (constantMessage (model := model))).prod
          (model.τM.map model.inclM) := by
      rw [hCoup, Measure.prod_dirac, Measure.map_map hmeas2 hmeas1,
        Measure.dirac_prod,
        Measure.map_map measurable_prodMk_left model.inclM_measurable]
      rfl

    rw [hLHS, hMix] at hDis

    haveI hSL_markov : ProbabilityTheory.IsMarkovKernel
        (pd.sourceLawβ constantAdversary) :=
      pd.sourceLawβ_markov constantAdversary
    haveI hSL_sfin : ProbabilityTheory.IsSFiniteKernel
        (pd.sourceLawβ constantAdversary) := by infer_instance

    have hDiracCompProd :
        (Measure.dirac (constantMessage (model := model))).compProd
            (pd.sourceLawβ constantAdversary) =
          (pd.sourceLawβ constantAdversary
              (constantMessage (model := model))).map
            (Prod.mk (constantMessage (model := model))) := by
      ext s hs
      rw [Measure.dirac_compProd_apply hs,
          Measure.map_apply measurable_prodMk_left hs]

    rw [hDiracCompProd, Measure.dirac_prod] at hDis

    have hEmb : MeasurableEmbedding
        (Prod.mk (constantMessage (model := model)) :
          Belief model.Ω → model.M × Belief model.Ω) :=
      measurableEmbedding_prodMk_left (constantMessage (model := model))

    have hSource :
        pd.sourceLawβ constantAdversary
            (constantMessage (model := model)) =
          model.τM.map model.inclM := by
      exact (hEmb.map_injective hDis).symm

    have hCB := pd.conditional_barycenter constantAdversary
    rw [hMix] at hCB
    rw [MeasureTheory.ae_dirac_eq] at hCB

    have hCB_at_c0 :
        beliefBarycenter
            ((pd.sourceLawβ constantAdversary)
              (constantMessage (model := model))) =
          beliefAsProfile
            (pd.Pβ constantAdversary
              (constantMessage (model := model))) := by
      simpa [Filter.eventually_pure] using hCB

    have hBary :
        beliefBarycenter
            ((pd.sourceLawβ constantAdversary)
              (constantMessage (model := model))) =
          model.μ0 := by
      rw [hSource, msupp.τM_pushforward]
      exact _plc.barycenter_eq_prior

    have hProfile :
        beliefAsProfile
          (pd.Pβ constantAdversary
            (constantMessage (model := model))) = model.μ0 := by
      rw [← hCB_at_c0]; exact hBary

    have hAtC0 :
        pd.Pβ constantAdversary
          (constantMessage (model := model)) = priorBelief model := by
      apply Subtype.ext
      funext ω
      have := congrFun hProfile ω
      simpa [beliefAsProfile, priorBelief] using this

    rw [hMix, MeasureTheory.ae_dirac_eq]
    simpa [Filter.eventually_pure] using hAtC0

  · unfold IsAdversarialFull RobustPayoffFull
    have hRange :
        Set.range (fun β : AdviserKernel model =>
          MixturePayoffFull model β priorStrategy) =
        {MixturePayoffFull model constantAdversary priorStrategy} := by
      ext x
      refine ⟨?_, ?_⟩
      · rintro ⟨β, hβ⟩
        have hxβ : x = MixturePayoffFull model β priorStrategy := hβ.symm
        have heq : MixturePayoffFull model β priorStrategy =
            MixturePayoffFull model constantAdversary priorStrategy := by
          rw [hMix_const β, hMix_const constantAdversary]
        exact Set.mem_singleton_iff.mpr (by rw [hxβ, heq])
      · rintro rfl
        exact ⟨constantAdversary, rfl⟩
    rw [hRange, csInf_singleton]

The supporting certificate type is also load-bearing. From L1047-L1070:

lean
structure AlphaZeroSingletonData where
  priorStrategy : AgentStrategyFull model
  constantAdversary : AdviserKernel model
  priorOptimal :
    ∀ m : model.M,
      IsBayesOptimal model
        (priorStrategy.sectionFull (model.inclM m))
        (priorBelief model)
  posteriorAtConstantMessageIsPrior :
    ∀ pd : PosteriorDisintegration model,
      ∀ᵐ m ∂MixtureMessageLaw model constantAdversary,
        pd.Pβ constantAdversary m = priorBelief model
  adversaryOptimal :
    IsAdversarialFull model constantAdversary priorStrategy
v9 paper statement and proof

exposition_v9.tex §4 states:

TeX
Under the standing hypotheses and $\alpha=0$ (pure adversarial adviser),
there exists a robustly rationalizable optimal strategy without any
finiteness of $M$ or $\Th$.
...
Pick $w_0\in\argmax_{w\in W}\mu_0\!\cdot w$ ...
Set $\hat\sigma^*(m) := R(w_0)$ for every $m\in M$ ...
Pick any fixed $m_0\in M$ and set $\beta^*(\cdot\mid s) := \delta_{m_0}$ ...
Then $\beta^*$ is adversarial against $\sigma^*$ ...
the unique $q$-positive message is $m_0$, and the disintegration posterior there
is $\mu_0$ ...
Definition~2 holds.

exposition_v9_paper.tex gives the same proof in prose: choose w
0
	​

∈argmax
W
	​

μ
0
	​

⋅w, define 
σ
^
∗
(m)=ρ
W
	​

(w
0
	​

), send a constant message m
0
	​

, use message-independence for adversariality, and use the barycenter μ
0
	​

 for posterior calibration. This is also summarized in the consolidated v9 proof ledger.

Translation

SCOPE_NARROWED. The mathematical construction is the correct α=0 singleton construction. The Lean proof explicitly constructs:

a prior-Bayes private strategy sigma0,

a message-ignoring full strategy priorStrategy,

a constant Dirac adversary constantAdversary,

posterior collapse to the prior at the constant message,

adversariality from β-independence of the payoff.

That is exactly the paper proof’s little lighthouse: ignore the adviser, play prior-Bayes, constant message, posterior equals prior.

The scope drift is in the signature. The v9 theorem is stated under “standing hypotheses and α=0” with no finiteness of M,Θ. The Lean theorem additionally requires

lean
(_plc : PosteriorLawConsistency model)
(msupp : MessageSupportM model)
(prs : ProfileRealizationSetup model)

and the eventual wrapper also requires a PosteriorDisintegration model. These are explicit, not hidden, but they are not named in the paper theorem statement. Economically they look like formal encodings of Bayes plausibility, support/pushforward consistency, and profile-realization compactness/continuity; still, as Lean theorem parameters, they narrow the surface theorem unless they are declared part of the Lean “standing model” package. The v9 ledger itself classifies T2 as using standing assumptions plus a standard Bayes selector, with α=0 as a scope-changing endpoint. 

v9_consolidated

There is also a mild conclusion mismatch: AlphaZeroSingletonData_exists returns a certificate, not HasRobustRationalizableStrategy. That is fine as an internal lemma, since the next theorem consumes it.

Smuggling

No proof-body smuggling found. The proof does not conjure the paper conclusion. It derives each certificate field:

priorOptimal comes from an extreme-value theorem on PrivatePayoff.

posteriorAtConstantMessageIsPrior is derived by collapsing MixtureMessageLaw and MixtureCouplingGammaAlpha at α=0, then using pd.sourceLawβ_disintegrates, pd.conditional_barycenter, _plc.barycenter_eq_prior, and msupp.τM_pushforward.

adversaryOptimal is derived from payoff independence in β.

The proof body is honest relative to its explicit infrastructure inputs. The only goblin is a stale comment above the theorem saying the posterior field “remains an honest in-construction sorry.” The actual body closes the field. That comment should be removed because it now lies like a fossilized TODO.

Verdict

SCOPE_DRIFT. Internally sound and construction-faithful, but not a literal “standing hypotheses only” Lean theorem because of explicit plc, msupp, and prs arguments.

2. AlphaZeroSingletonData.to_hasRobustRationalizableStrategy
Lean signature and proof body

From /mnt/data/v9_appendix.lean L2438-L2450:

lean
/-- Helper: given an `AlphaZeroSingletonData` certificate (constant adversary,
prior-Bayes strategy uniformly Bayes-optimal at the prior, q-a.e. posterior
collapse to μ_0, and adversarial-infimum attainment), construct a robustly
rationalizable strategy. Pure certificate-verification: does not use `α=0`. -/
theorem AlphaZeroSingletonData.to_hasRobustRationalizableStrategy
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (data : AlphaZeroSingletonData model) :
    HasRobustRationalizableStrategy model pd := by
  refine ⟨data.constantAdversary, data.priorStrategy,
    data.adversaryOptimal, ?_⟩
  filter_upwards [data.posteriorAtConstantMessageIsPrior pd] with m hmPost
  simpa [hmPost] using data.priorOptimal m
v9 paper statement and proof

The paper-side proof says the chosen continuation is Bayes-optimal at the unique on-path posterior μ
0
	​

, and the constant kernel is adversarial because the agent’s payoff is message-independent. This helper is exactly the last assembly step of that proof: adversariality plus q-a.e. posterior collapse plus prior Bayes-optimality imply robust rationalizability. The infinite-space reading must be q-a.e., because the conditional posterior is defined only under the actual mixture message marginal; the v8/v9 exposition explicitly records this q-a.e. reading.

Translation

PASS. This theorem is not trying to re-prove α=0. It is a certificate eliminator:

lean
AlphaZeroSingletonData → HasRobustRationalizableStrategy

That is exactly what the paper proof needs after constructing the prior strategy and constant adversary.

It correctly does not use hα : model.α = 0, because the α=0 content is already baked into the certificate fields.

Smuggling

No smuggling. The theorem simply unwraps explicit fields:

data.adversaryOptimal,

data.posteriorAtConstantMessageIsPrior pd,

data.priorOptimal.

This is proof by certificate, not proof by fairy dust. The certificate type is concrete enough that the helper is safe.

Verdict

PASS.

3. «T2-alpha-zero-singleton-prior-strategy»
Lean signature and proof body

From /mnt/data/v9_appendix.lean L2770-L2786:

lean
/-- v9 α=0 endpoint: unconditional infinite-extension of Robust Trust
Theorem 2 in the pure-adversarial regime.

**Signature update 2026-05-22:** now takes `plc : PosteriorLawConsistency
model` and `prs : ProfileRealizationSetup model` as additional arguments,
threading them through to `AlphaZeroSingletonData_exists` whose proof
relies on them honestly (no Inventory axiom). -/
theorem «T2-alpha-zero-singleton-prior-strategy»
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (hα : model.α = 0)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (prs : ProfileRealizationSetup model) :
    HasRobustRationalizableStrategy model pd := by
  obtain ⟨data⟩ := AlphaZeroSingletonData_exists (model := model) hα plc msupp prs
  exact AlphaZeroSingletonData.to_hasRobustRationalizableStrategy pd data
v9 paper statement and proof

exposition_v9_paper.tex §4 says:

TeX
Under the standing assumptions and $\alpha=0$, there exists a robustly
rationalizable optimal strategy without assuming $M$ or $\Theta$ finite.
...
Choose $w_0\in\argmax_{w\in W}\mu_0\cdot w$, attained by compactness.
Define $\hat\sigma^*(m)=\rho_W(w_0)$ for every $m$.
The agent ignores advice. Let the adversary send a constant message
$m_0\in M$, so $\beta^*(\cdot\mid s)=\delta_{m_0}$.
...
the unique on-path posterior is ... $\mu_0$.

The consolidated source repeats the same construction and explicitly says this is a complete infinite-M,Θ existence theorem for α=0, but a scope-changing degenerate endpoint.

Translation

SCOPE_NARROWED. The wrapper faithfully composes the two internal Lean lemmas. It proves robust-rationalizable strategy existence in the α=0 case.

But against the paper statement, two scope issues remain:

Extra explicit infrastructure parameters. The wrapper is not just

lean
(hα : model.α = 0) :
  HasRobustRationalizableStrategy model pd

It requires pd, plc, msupp, and prs. pd is expected for the q-a.e. formalization of Definition 2, but plc, msupp, and prs are additional visible hypotheses unless the formalization declares them part of the standing model.

Optimality is not in the conclusion. The paper-shaped statement says “robustly rationalizable optimal strategy.” This Lean theorem concludes only

lean
HasRobustRationalizableStrategy model pd

Since the original Theorem 2 optimality direction says robustly rationalizable strategies are optimal, this can be recovered by composing with the separate optimality theorem, but it is not bundled here. The original paper’s Theorem 2 includes the optimality direction and finite existence statement, and the v9 α=0 endpoint is using that same robust rationalizability-to-optimality bridge. 

objective_statement

Smuggling

No wrapper-level smuggling. The theorem merely obtains the certificate from AlphaZeroSingletonData_exists and applies the certificate eliminator. The body is almost a paperclip:

lean
obtain ⟨data⟩ := ...
exact ...

The only scope issue is in the signature, not hidden in the proof body.

Verdict

SCOPE_DRIFT. Mathematically faithful to the α=0 construction, but not an exact paper-surface theorem unless the added infrastructure arguments are officially part of the Lean standing hypotheses and optimality is recovered by a named corollary.

Batch verdict: NEEDS_FIX

The AlphaZero block captures the intended α=0 construction. No “agent secretly trusts advice” bug, no finite M or finite Θ reimport, and no proof-body shortcut to the conclusion. The agent really ignores the adviser; the adversary really sends a constant message; the posterior is proved to be the prior; adversariality really follows from message-independence.

The batch still needs a paper-fidelity fix:

Either fold PosteriorLawConsistency, MessageSupportM, ProfileRealizationSetup, and the chosen PosteriorDisintegration into the formalized standing-hypotheses package, or rename the theorem as an infrastructure-conditional α=0 theorem.

Add a final corollary composing HasRobustRationalizableStrategy with the optimality direction if the Lean theorem is meant to match the “robustly rationalizable optimal strategy” wording.

Delete the stale local comment claiming a remaining sorry in posteriorAtConstantMessageIsPrior.

Once those are patched, this batch should become PASS.
