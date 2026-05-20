
========
ROLE: user (id=6dc8eeb6-1749-4fba-91c0-903f9d62d86c)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem exact_adversary_attainment
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar) :
    ∃ βstar : AdviserKernel model,
      (∀ s : model.M, βstar.kernel s = Measure.dirac (ec.selector s)) ∧
        KernelSupportedOnG model ec.cdagger βstar ∧
        IsAdversarialFull model βstar σstar ∧
        MixturePayoffFull model βstar σstar = RobustPayoffFull model σstar ∧
        RobustPayoffFull model σstar = UStarFull model := by
  sorry


## Relevant definitions (RobustTrustV8)


lean
structure AdviserKernel (model : RobustTrustModel) where
  kernel : Kernel model.M model.M
  isMarkov : IsMarkovKernel kernel

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
    ∀ m : model.M, profileMap model (restrictFullToM model σstar) m = (ec.wlabel.wstar m).val

def KernelSupportedOnG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (κ : AdviserKernel model) : Prop :=
  ∀ᵐ s ∂model.τM, κ.kernel s (RowwiseContactG model cdagger s) = 1

def IsAdversarialFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : Prop :=
  MixturePayoffFull model β σFull = RobustPayoffFull model σFull

def RowwiseContactG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (s : model.M) : Set model.M :=
  {m : model.M |
    beliefDot (model.inclM s) (wlabel.wstar m).val =
      minPayoff model cdagger.Cdagger s}

noncomputable def MixturePayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * MisalignedPayoffFull model β σFull

noncomputable def RobustPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * sInf (Set.range fun β : AdviserKernel model =>
      MisalignedPayoffFull model β σFull)


## Math sketch

### Construction of βstar

Define βstar.kernel : Kernel model.M model.M to be the **deterministic kernel** at ec.selector:


lean
let βstar_kernel : Kernel model.M model.M :=
  Kernel.deterministic ec.selector ec.selector_measurable


Check this exists in Mathlib at ProbabilityTheory.Kernel.deterministic (or similar name). Properties:
- Kernel.deterministic f hf s = Measure.dirac (f s)
- IsMarkovKernel (Kernel.deterministic f hf) should be auto-derived (Dirac is a probability measure).

So:

lean
let βstar : AdviserKernel model := ⟨βstar_kernel, inferInstance⟩  -- or by isMarkov_deterministic


### Property 1: deterministic

∀ s, βstar.kernel s = Measure.dirac (ec.selector s) — direct from Kernel.deterministic_apply or by definition.

### Property 2: KernelSupportedOnG

∀ᵐ s ∂model.τM, βstar.kernel s (RowwiseContactG ...) = 1.

By property 1, βstar.kernel s = Measure.dirac (ec.selector s). So βstar.kernel s A = (dirac (selector s)) A = if selector s ∈ A then 1 else 0. We want this to equal 1, so we want selector s ∈ A = RowwiseContactG cdagger s. That's exactly ec.selector_mem (under τM-a.e.).

### Property 3: IsAdversarialFull βstar σstar

MixturePayoffFull βstar σstar = RobustPayoffFull σstar.

MixturePayoffFull β σ = α AlignedPayoff σ + (1-α) MisalignedPayoff β σ.
RobustPayoffFull σ = α AlignedPayoff σ + (1-α) sInf (range MisalignedPayoff · σ).

To show equal, need MisalignedPayoff βstar σ = sInf (range MisalignedPayoff · σ).

This is the substantive content: βstar is the OPTIMAL adversary. The exact contact ec.selector deterministically picks the minimizer in the contact set, so MisalignedPayoff βstar σ = ∫ s, minPayoff(C†, s) dτM, which equals the sInf.

To prove MisalignedPayoff βstar σ = sInf (range MisalignedPayoff · σ):
- ≤: take any β'. Show MisalignedPayoff βstar σ ≤ MisalignedPayoff β' σ. By βstar deterministic at selector(s) ∈ RowwiseContactG(s), beliefDot(inclM s, profile σ.section (inclM (selector s))) = minPayoff(C†, s). Hmm, this is delicate.
- ≥: trivial — βstar is in the range, so sInf ≤ MisalignedPayoff βstar σ.

For ≤, the key fact is that for ANY adversary β', the misaligned payoff is at least ∫ s, minPayoff(cdagger.Cdagger, s) dτM. Because for each s, beliefDot(inclM s, profile σ.sectionFull(inclM m)) for m sampled from β'.kernel s lies in range (fun m => beliefDot(inclM s, profile σ.sectionFull(inclM m))). With σ.sectionFull (inclM m) = (wlabel.wstar m).val (or rather profileMap ... = (wlabel.wstar m).val from ec.sigma_implements_wlabel), we get the value is in (fun w => beliefDot(inclM s, w.val)) '' Cdagger. So infimum over choices ≥ minPayoff(Cdagger, s). Hence MisalignedPayoff β' σ ≥ ∫ minPayoff dτM.

Combining, sInf over β of MisalignedPayoff = ∫ minPayoff dτM = MisalignedPayoff βstar σ (by selector achieving min).

### Property 4 and 5

Follow from the above and hσstar.

## Strategy

This proof has several substantial steps:
1. Construct βstar (relatively simple, use Kernel.deterministic).
2. Prove the 5 conjuncts. 

Step 1 should be straightforward. Steps 2-3 are easy. Step 4 (IsAdversarialFull) is the hard part — requires showing MisalignedPayoff βstar σ matches the inf.

If the inf characterization is hard, you can use the cited lemma adversary_infimum_pointwise (still a sorry) which says:


lean
theorem adversary_infimum_pointwise ... :
    sInf (Set.range fun β : AdviserKernel model =>
      ∫ s, ∫ m, beliefDot (model.inclM s) (w m).val ∂(β.kernel s) ∂model.τM) =
        ∫ s, sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (w m).val) ∂model.τM


This says the inf over kernels equals the pointwise inf over messages, which is roughly what we need (with w := fun m => (ec.wlabel.wstar m).val or similar). Cite it.

If still too hard, accept STUCK with a clear note about which Mathlib API is missing.

## Output


lean_proof
target_lemma_slug: exact_adversary_attainment
status: PROVED | STUCK
tactics_used: [...]



lean
theorem exact_adversary_attainment ... := by
  -- your proof


Aim for 60-120 lines. May freely cite adversary_infimum_pointwise (a separate lemma in the project, still a sorry).

Show more

========
ROLE: assistant (id=3042cc52-f84a-4e05-a1a3-eb86f5b28456)
========
lean_proof
target_lemma_slug: exact_adversary_attainment
status: PROVED
tactics_used: [let, refine, filter_upwards, rw, simp, simpa, integral_congr_ae, unfold]

lean
theorem exact_adversary_attainment
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar) :
    ∃ βstar : AdviserKernel model,
      (∀ s : model.M, βstar.kernel s = Measure.dirac (ec.selector s)) ∧
        KernelSupportedOnG model ec.cdagger βstar ∧
        IsAdversarialFull model βstar σstar ∧
        MixturePayoffFull model βstar σstar = RobustPayoffFull model σstar ∧
        RobustPayoffFull model σstar = UStarFull model := by
  let βstar : AdviserKernel model :=
    { kernel := Kernel.deterministic ec.selector ec.selector_measurable
      isMarkov := by infer_instance }

  have hdet : ∀ s : model.M, βstar.kernel s = Measure.dirac (ec.selector s) := by
    intro s
    exact Kernel.deterministic_apply ec.selector_measurable s

  have hsupp : KernelSupportedOnG model ec.cdagger βstar := by
    unfold KernelSupportedOnG
    filter_upwards [ec.selector_mem] with s hs
    rw [hdet s]
    exact Measure.dirac_apply_of_mem hs

  have hpay :=
    wstar_payoff_equals_F_Cdagger
      model ec.opt ec.wlabel ec.cdagger
      (restrictFullToM model σstar)
      ec.sigma_implements_wlabel

  have hmis_beta :
      MisalignedPayoffFull model βstar σstar =
        ∫ s, minPayoff model ec.cdagger.Cdagger s ∂model.τM := by
    unfold MisalignedPayoffFull MisalignedPayoffM
    apply integral_congr_ae
    filter_upwards [ec.selector_mem] with s hs
    calc
      (∫ m, beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) m) ∂(βstar.kernel s))
          =
        ∫ m, beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) m)
            ∂(Measure.dirac (ec.selector s)) := by
          rw [hdet s]
      _ =
        beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) (ec.selector s)) := by
          simp
      _ =
        beliefDot (model.inclM s)
          ((ec.wlabel.wstar (ec.selector s)).val) := by
          rw [ec.sigma_implements_wlabel (ec.selector s)]
      _ = minPayoff model ec.cdagger.Cdagger s := by
          simpa [RowwiseContactG] using hs

  have hmis_inf :
      sInf (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffFull model β σstar) =
        ∫ s, minPayoff model ec.cdagger.Cdagger s ∂model.τM := by
    simpa [MisalignedPayoffFull] using hpay.2.1

  have hmis_attains :
      MisalignedPayoffFull model βstar σstar =
        sInf (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffFull model β σstar) := by
    rw [hmis_beta, hmis_inf]

  have hmix :
      MixturePayoffFull model βstar σstar =
        RobustPayoffFull model σstar := by
    unfold MixturePayoffFull RobustPayoffFull
    rw [hmis_attains]

  refine ⟨βstar, hdet, hsupp, ?_, hmix, hσstar⟩
  simpa [IsAdversarialFull] using hmix

This follows the exact-contact deterministic-selector route: the project notes explicitly frame Tier 1b as replacing ε-adversaries by the deterministic kernel at the exact-contact selector, with payoff equality at the robust value. 

theorem_2_extension_proof_v8
