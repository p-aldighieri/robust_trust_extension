Follow-up to your PARTIALLY-ON-TOPIC verdict (accepted).

I want to check ONE more thing now: do the **actual Lean theorem statements** faithfully encode the v8 English claims **as you have just characterized them**? In other words — granting your verdict that v8 is a tiered, conditional infinite-space formalization (not an unconditional Theorem 2 extension):

1. Does each Lean statement say what its corresponding v8 English claim says?
2. Are there any Lean-side definitional drifts that make a tier *appear* stronger or weaker than the v8 English exposition claims?
3. Are the structures (`Tier1aResult`, `Tier1bResult`, `Tier2Result`, `RobustTrustInfiniteExtensionV8Package`, `ExactContact`, `MenuHall`) faithful encodings of what the v8 text says they should bundle?

I am NOT asking you to re-litigate Tier 2's calibration-oracle worry — that's a v8 substance question, not a Lean-vs-English fidelity question. I just want to know if the Lean text matches the v8 text.

Below are the headliner Lean statements + the relevant supporting structures (Inventory and infrastructure lemmas omitted).

```lean
-- ============================================================
-- BOUND ASSUMPTION STRUCTURES (Tier 1b/2 use these as parameters)
-- ============================================================

structure ExactContact (model : RobustTrustModel)
    (σstar : AgentStrategyFull model) where
  opt : OptimalMenuCstar model
  wlabel : AlignedBestLabelingWstar model opt
  cdagger : PrunedMenuCdagger model wlabel
  selector : model.M → model.M
  selector_measurable : Measurable selector
  selector_mem :
    ∀ᵐ s ∂model.τM, selector s ∈ RowwiseContactG model cdagger s
  sigma_implements_wlabel :
    ∀ m : model.M,
      profileMap model (restrictFullToM model σstar) m = (wlabel.wstar m).val

structure MenuHall (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model) where
  q : Measure model.M
  q_eq_qκ : q = MixtureMessageLaw model κ
  q_eq_gamma_second : q = (MixtureCouplingGammaAlpha model κ).map Prod.snd
  calibration :
    ∀ᵐ m ∂q,
      pd.Pγα κ m ∈ BayesOptimalityBeliefCorrespondenceBm model σstar m

-- ============================================================
-- TIER RESULT DEFINITIONS (what each tier delivers)
-- ============================================================

def Tier1aResult (model : RobustTrustModel)
    (σstar : AgentStrategyFull model) : Prop :=
  RobustPayoffFull model σstar = UStarFull model ∧
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε

structure Tier1bResult (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar) where
  βstar : AdviserKernel model
  deterministic : ∀ s : model.M, βstar.kernel s = Measure.dirac (ec.selector s)
  supported_on_G : KernelSupportedOnG model ec.cdagger βstar
  adversarial : IsAdversarialFull model βstar σstar
  value : MixturePayoffFull model βstar σstar = UStarFull model

def Tier2Result (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) : Prop :=
  (let βstar : AdviserKernel model := κ;
    βstar = κ ∧
      mh.q = MixtureMessageLaw model κ ∧
      mh.q = (MixtureCouplingGammaAlpha model κ).map Prod.snd) ∧
  IsAdversarialFull model κ σstar ∧
  MixturePayoffFull model κ σstar = UStarFull model ∧
  (model.α > 0 →
    ∀ᵐ m ∂model.τM,
      IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m))

def WTA_ConeIntersectionStatement : Prop := ...  -- cone-intersection lemma for ternary WTA
def WTA_NoFreeDustStatement : Prop := ...        -- no-free-dust theorem
def HalfspaceWitnessStatement : Prop := ...      -- halfspace = menu-engine artefact

def RobustTrustInfiniteExtensionV8Package
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model) : Prop :=
  ∃ σstar : AgentStrategyFull model,
    Tier1aResult model σstar ∧
      (∀ ec : ExactContact model σstar, Nonempty (Tier1bResult model σstar ec)) ∧
      (∀ (pd : PosteriorDisintegration model)
         (ec : ExactContact model σstar)
         (κ : AdviserKernel model)
         (mh : MenuHall model pd σstar ec κ),
          Tier2Result model pd σstar ec κ mh) ∧
      WTA_ConeIntersectionStatement ∧
      WTA_NoFreeDustStatement ∧
      HalfspaceWitnessStatement

-- ============================================================
-- HEADLINER THEOREMS
-- ============================================================

theorem tier1a_value_optimality_and_epsilon_adversary
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model) :
    ∃ σstar : AgentStrategyFull model, Tier1aResult model σstar

theorem tier1b_exact_adversary_under_exact_contact
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar) :
    Nonempty (Tier1bResult model σstar ec)

theorem tier2_qae_robust_rationalizability_under_menu_Hall
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (prs : ProfileRealizationSetup model)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    Tier2Result model pd σstar ec κ mh

theorem wta_cone_intersection ... : WTA_ConeIntersectionStatement
theorem wta_no_free_dust ... : ∀ wta, AtomlessTauSharpness wta → ...
theorem halfspace_witness_menu_engine_artifact : HalfspaceWitnessStatement
theorem sharpness_corollary ... : ...

theorem robust_trust_infinite_extension_v8_package
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model) :
    RobustTrustInfiniteExtensionV8Package model plc msupp bridge prs
```

## Question

For each headliner — does the Lean statement faithfully encode what the v8 English claim says? Flag any of these:

- **Lean-stronger-than-English**: Lean theorem proves more than v8 claims (would be a bug — we'd be overclaiming).
- **Lean-weaker-than-English**: Lean theorem proves less than v8 claims (would be a real concern — we'd be underdelivering).
- **Lean-says-something-different**: Lean theorem's conclusion differs from v8's English conclusion in substance (most concerning).
- **Lean-faithful-but-renamed**: same content, different name (cosmetic).
- **Trivial-conjunct concern**: the first conjunct of `Tier2Result` is `let βstar := κ; βstar = κ ∧ mh.q = ... ∧ mh.q = ...` — this is decorative. Is it harmless or does it dilute the statement?

Output:
```
PER-HEADLINER VERDICT:
  tier1a_value_optimality_and_epsilon_adversary: FAITHFUL | STRONGER | WEAKER | DIFFERENT
    note: ...
  tier1b: ...
  tier2: ...
  wta_cone_intersection: ...
  wta_no_free_dust: ...
  halfspace_witness_menu_engine_artifact: ...
  sharpness_corollary: ...
  robust_trust_infinite_extension_v8_package: ...
  ExactContact (structure): ...
  MenuHall (structure): ...

OVERALL: FAITHFUL | DRIFT-DETECTED
```
