
========
ROLE: user (id=5dcdd608-0490-4865-b01e-ad54fac0848f)
========
You are the Lean Prover. Close ONE specific sorry: strategy_value_le_menu_sup at line 1286 of main.lean.

## Target


lean
theorem strategy_value_le_menu_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)) := by
  sorry


## Key building block (just PROVED at line 1204): adversary_infimum_pointwise

For w : M → ProfileInW with measurability + boundedness + integrability hypotheses,

sInf (range β => ∫ s, ∫ m, beliefDot (inclM s) (w m).val ∂(β.kernel s) ∂τM)
  = ∫ s, sInf (range m => beliefDot (inclM s) (w m).val) ∂τM


## Math sketch

Construct C* := closed convex hull of range w_of_σ ⊆ ProfileInW, where
w_of_σ m := ⟨profileMap σM m, ⟨σM.sectionM m, rfl⟩⟩ : ProfileInW model (always in PayoffProfileSet).

For each s, since beliefDot (inclM s) · is linear in second arg:
- sup over closed conv hull of range = sup over range
- inf over closed conv hull of range = inf over range

So:
- maxPayoff C* s = sup_m beliefDot (inclM s) (profileMap σM m)
- minPayoff C* s = inf_m beliefDot (inclM s) (profileMap σM m) = sInf_m

Then:
- AlignedPayoffM σM = ∫ beliefDot(inclM s, profileMap σM s) dτM
  ≤ ∫ sup_m beliefDot(inclM s, profileMap σM m) dτM
  = ∫ maxPayoff C* dτM
- sInf_β MisalignedPayoffM β σM = ∫ sInf_m beliefDot(...) dτM  [adversary_infimum_pointwise]
  = ∫ minPayoff C* dτM
- RobustPayoff σM = sInf_β MixturePayoffM β σM = α A + (1-α) sInf_β M_β
  ≤ α ∫ max C* + (1-α) ∫ min C* = MenuFunctionalF C*
  ≤ sSup (range MenuFunctionalF)

For BddAbove (range MenuFunctionalF): mirror menu_value_le_strategy_sup_robust_range_bddAbove.
Use the uniform |beliefDot| ≤ B bound, every MenuFunctionalF C ∈ [-B, B].

## Definitions


lean
abbrev ProfileInW (model) := {w : Profile model // w ∈ PayoffProfileSet model}
abbrev CompactMenu (model) := TopologicalSpace.NonemptyCompacts (ProfileInW model)
noncomputable def maxPayoff (model) (C) (s) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) '' (↑C : Set _))
noncomputable def minPayoff (model) (C) (s) : ℝ := sInf (...)
noncomputable def MenuFunctionalF (model) (C) : ℝ :=
  ∫ s, model.α * maxPayoff C s + (1 - model.α) * minPayoff C s ∂model.τM


Available helpers in scope:
- profileMap_measurable_for_kernel_bound model setup σM : Measurable (fun m => profileMap σM m)
- beliefDot_profileMap_uncurry_measurable model setup σM : Measurable (...) (line ~1605)
- beliefDot_profileMap_uniform_bound model σM : ∃ B, ∀ s m, ‖...‖ ≤ B
- integral_Icc_of_forall_abs_le_prob
- beliefDot_ProfileInW_abs_le_private_bound model : ∃ B ≥ 0, ∀ b w, |beliefDot b w.val| ≤ B
- maxPayoff_integrable, minPayoff_integrable model C (for any C)
- compact_menu_aligned_selection model C : ∃ wC ... (line 1292)
- adversary_infimum_pointwise (line 1204, PROVED)
- model.private_profile_bounded, setup.W_compact, setup.W_convex, setup.Φ_eq_profile, setup.Φ_continuous

Mathlib helpers: IsCompact.closure_subset_of_isClosed, subset_closure, IsClosed.closure_eq, IsLinearMap.csSup_convexHull, Convex.csInf_convexHull (for sup/inf over conv hull = sup/inf over set, via linear functional).

## Strategy

1. **Build C***: C* := closure (range w_of_σ) ⊆ ProfileInW model.
   - IsCompact via setup.W_compact.image (inclusion) or setup.W_compact restricted to subtype, combined with IsCompact.closure.
   - Or simpler: C* := setupNonemptyCompactsOfSetWInRange ....
   - The natural "full menu" is Set.univ : Set (ProfileInW model) if CompactSpace inst exists.
   - Use IsCompact_univ.

2. **Bounds**:
   - hmax_bound s : beliefDot (inclM s) (profileMap σM s) ≤ maxPayoff C* s
   - hmin_bound s : minPayoff C* s ≤ sInf_m beliefDot (inclM s) (profileMap σM m)
   (Both via membership of profileMap σM m in C*.)

3. **AlignedPayoff bound**: integrate hmax_bound.

4. **sInf MisalignedPayoff = ∫ sInf_m**: apply adversary_infimum_pointwise with w := w_of_σ and verify the 6 hypotheses (measurability of w, measurability of g, boundedness of g, measurability of sInf, integrability of sInf, integrability of g under compProd).

5. **RobustPayoff bound**: combine the additive decomposition. Need
   sInf_β (α A + (1-α) M_β) = α A + (1-α) sInf_β M_β — use Real.sInf_const_add or general ciInf_add_const after rewriting.

6. **MenuFunctionalF bound**: linearity (integral_add) + comparison.

7. **sSup**: use le_csSup with C* ∈ range and BddAbove (proved analogously to robust_range_bddAbove).

Aim for 150-400 lines. May add private helpers. If genuinely STUCK on Step 1 (compact menu construction), state STUCK with the precise mathlib lemma needed.

## Output


lean_proof
target_lemma_slug: strategy_value_le_menu_sup
status: PROVED | STUCK
tactics_used: [...]



lean
theorem strategy_value_le_menu_sup ... := by
  -- your proof


CRITICAL: model fields are model.α/model.τM (Greek). AdviserKernel.kernel is the field; β.isMarkov is Markov instance witness.

Show more

========
ROLE: assistant (id=0ef78f4d-f0e5-4e96-9fde-07d94b495303)
========
lean_proof
target_lemma_slug: strategy_value_le_menu_sup
status: STUCK
tactics_used: [let-binding menu from closure of range, subtype membership, le_csSup, adversary_infimum_pointwise, integral_mono, csSup range bound]

I can reduce the theorem cleanly to one missing closure-extrema lemma. The blocker is not the compact-menu construction itself, but the exact Mathlib/API lemma needed to identify the extrema of a continuous linear payoff over closure (range wσ) with the sSup/sInf over the original range.

The missing lemma I need is essentially:

lean
/-- Continuous real-valued functions have the same sup/inf on a nonempty set and its closure. -/
lemma continuous_extrema_image_closure_eq
    {X : Type*} [TopologicalSpace X]
    {S : Set X} (hS : S.Nonempty)
    {f : X → ℝ} (hf : Continuous f)
    (hBddAbove : BddAbove (f '' S))
    (hBddBelow : BddBelow (f '' S)) :
    sSup (f '' closure S) = sSup (f '' S) ∧
    sInf (f '' closure S) = sInf (f '' S)

or directly in this file’s vocabulary:

lean
lemma closure_range_profileMap_extrema
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model)
    (wσ : model.M → ProfileInW model)
    (Cσ : CompactMenu model)
    (hCσ : (↑Cσ : Set (ProfileInW model)) = closure (Set.range wσ)) :
    (∀ s : model.M,
      maxPayoff model Cσ s =
        sSup (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (wσ m).val)) ∧
    (∀ s : model.M,
      minPayoff model Cσ s =
        sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (wσ m).val))

Here is the reduced proof skeleton, with the precise blocked line marked.

lean
theorem strategy_value_le_menu_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)) := by
  classical

  let wσ : model.M → ProfileInW model :=
    fun m =>
      ⟨profileMap model σM m,
        by
          unfold profileMap PayoffProfileSet
          exact ⟨σM.sectionM m, rfl⟩⟩

  have hwσ_meas : Measurable wσ := by
    refine (profileMap_measurable_for_kernel_bound model setup σM).subtype_mk ?_
    intro m
    unfold PayoffProfileSet profileMap
    exact ⟨σM.sectionM m, rfl⟩

  -- Compactness of the subtype `ProfileInW model`, coming from compactness of W.
  letI : CompactSpace (ProfileInW model) := setup.W_compact.compactSpace

  let Cσ : CompactMenu model :=
    { carrier := closure (Set.range wσ)
      isCompact' := isClosed_closure.isCompact
      nonempty' := by
        obtain ⟨m0⟩ := inferInstanceAs (Nonempty model.M)
        exact ⟨wσ m0, subset_closure (Set.mem_range_self m0)⟩ }

  have hCσ_def :
      (↑Cσ : Set (ProfileInW model)) = closure (Set.range wσ) := rfl

  have hwσ_mem_Cσ : ∀ m : model.M, wσ m ∈ (↑Cσ : Set (ProfileInW model)) := by
    intro m
    exact subset_closure (Set.mem_range_self m)

  /-
    BLOCKER.

    Need the lemma described above:
      extrema over closure(range wσ) = extrema over range wσ.

    This follows mathematically from continuity of
      w ↦ beliefDot (model.inclM s) w.val
    and the order-topology lemmas
      `isLUB_iff_of_subset_of_subset_closure`
      `isGLB_iff_of_subset_of_subset_closure`,
    or equivalently from dense-subtype `ciSup`/`ciInf`.
  -/
  have h_extrema :
      (∀ s : model.M,
        maxPayoff model Cσ s =
          sSup (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wσ m).val)) ∧
      (∀ s : model.M,
        minPayoff model Cσ s =
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wσ m).val)) := by
    exact closure_range_profileMap_extrema model setup σM wσ Cσ hCσ_def

  rcases h_extrema with ⟨hmax_eq, hmin_eq⟩

  have hmax_bound :
      ∀ s : model.M,
        beliefDot (model.inclM s) (profileMap model σM s) ≤
          maxPayoff model Cσ s := by
    intro s
    rw [hmax_eq s]
    refine le_csSup ?_ ?_
    · obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
      refine ⟨B, ?_⟩
      rintro x ⟨m, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) (wσ m))).2
    · exact ⟨s, rfl⟩

  have hAligned_le :
      AlignedPayoffM model σM ≤
        ∫ s, maxPayoff model Cσ s ∂model.τM := by
    unfold AlignedPayoffM
    refine integral_mono ?_ (maxPayoff_integrable model Cσ) ?_
    · exact
        integral_Icc_of_forall_abs_le_prob
          model.τM
          (fun s => beliefDot (model.inclM s) (profileMap model σM s))
          (by
            simpa using
              (beliefDot_profileMap_diag_measurable model setup σM))
          (by
            obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
            exact ⟨B, fun s => by
              simpa [Real.norm_eq_abs] using hB s s⟩)
    · exact Filter.Eventually.of_forall hmax_bound

  have hMisInf :
      sInf (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffM model β σM) =
        ∫ s, minPayoff model Cσ s ∂model.τM := by
    have hpoint :=
      adversary_infimum_pointwise
        model
        wσ
        hwσ_meas
        (by
          simpa [wσ] using
            beliefDot_profileMap_uncurry_measurable model setup σM)
        (by
          obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
          exact ⟨B, fun s m => by
            simpa [wσ, Real.norm_eq_abs] using hB s m⟩)
        (by
          have hmin_meas := (minPayoff_integrable model Cσ).measurable
          simpa [hmin_eq] using hmin_meas)
        (by
          simpa [hmin_eq] using minPayoff_integrable model Cσ)
        (by
          intro β
          exact
            integral_Icc_of_forall_abs_le_prob
              (model.τM.compProd β.kernel)
              (fun p : model.M × model.M =>
                beliefDot (model.inclM p.1) (wσ p.2).val)
              (by
                simpa [wσ] using
                  beliefDot_profileMap_uncurry_measurable model setup σM)
              (by
                obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
                exact ⟨B, fun p => by
                  simpa [wσ, Real.norm_eq_abs] using hB p.1 p.2⟩))
    simpa [MisalignedPayoffM, wσ, hmin_eq] using hpoint

  have hRobust_decomp :
      RobustPayoffM model σM =
        model.α * AlignedPayoffM model σM +
          (1 - model.α) *
            sInf (Set.range fun β : AdviserKernel model =>
              MisalignedPayoffM model β σM) := by
    unfold RobustPayoffM MixturePayoffM
    have hnonneg : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    rw [Real.sInf_const_add]
    rw [Real.sInf_mul_of_nonneg hnonneg]
    ring

  have hF_split :
      MenuFunctionalF model Cσ =
        model.α * (∫ s, maxPayoff model Cσ s ∂model.τM) +
          (1 - model.α) *
            (∫ s, minPayoff model Cσ s ∂model.τM) := by
    unfold MenuFunctionalF
    rw [integral_add]
    · rw [integral_const_mul, integral_const_mul]
    · exact (maxPayoff_integrable model Cσ).const_mul model.α
    · exact (minPayoff_integrable model Cσ).const_mul (1 - model.α)

  have hRobust_le_F :
      RobustPayoffM model σM ≤ MenuFunctionalF model Cσ := by
    rw [hRobust_decomp, hMisInf, hF_split]
    have hα_nonneg : 0 ≤ model.α := model.α_nonneg
    have h1α_nonneg : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    nlinarith [mul_le_mul_of_nonneg_left hAligned_le hα_nonneg]

  have hMenu_bdd :
      BddAbove (Set.range (MenuFunctionalF model)) := by
    exact menu_value_le_strategy_sup_robust_range_bddAbove model

  exact le_trans hRobust_le_F
    (le_csSup hMenu_bdd ⟨Cσ, rfl⟩)

The proof should close once the closure_range_profileMap_extrema lemma is available. Its mathematical content is small, but it is the exact Lean hinge for moving from the strategy’s measurable range to a compact menu.
