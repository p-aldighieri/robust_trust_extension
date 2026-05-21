
========
ROLE: user (id=f9aac24b-1664-4eb6-88f9-c15835762721)
========
You are the Lean Prover. Close ONE specific sorry: support_function_integrated_Hall_equivalence ⇐ direction (line 4675 of main.lean).

## Target — only the ⇐ direction inside the iff


lean
theorem support_function_integrated_Hall_equivalence
    (model : RobustTrustModel)
    (q : Measure model.M) [IsFiniteMeasure q]
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model)
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : model.M × Profile model | p.2 ∈ B p.1})
    (hsupp_meas : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Integrable (fun m => ℓ (P m)) q) :
    PosteriorCalibrationProfiles model q B P ↔
      SupportFunctionHallInequalities model q B P := by
  constructor
  · ...  -- ⇒ direction already PROVED (uses csSup_le + integrals)
  · intro hHall
    classical
    sorry  -- TARGET ⇐ direction


Where:
- PosteriorCalibrationProfiles model q B P := ∀ᵐ m ∂q, P m ∈ B m
- SupportFunctionHallInequalities model q B P := ∀ E measurable, q E ≠ 0 → ∀ ℓ, ∫_E ℓ(P m) ≤ ∫_E sSup (ℓ '' B m)

(Actually, please check the exact definitions in the file if needed — they're around line 4500.)

## Math sketch

This is the substantive Hahn-Banach direction:

1. **Use Hall inequalities pointwise per ℓ**: For each fixed continuous linear functional ℓ
   on Profile model (= Ω → ℝ, finite-dim), Hall says ∀ E (positive measure),
   ∫_E ℓ(P m) dq ≤ ∫_E sSup (ℓ '' B m) dq. By radon-nikodym / Lebesgue differentiation
   on positive measure sets, derive: ∀ᵐ m ∂q, ℓ(P m) ≤ sSup (ℓ '' B m).

2. **Upgrade "for each ℓ, a.e." to "a.e., for all ℓ"**: Profile model = (Ω → ℝ) with Ω finite,
   so Profile model is finite-dimensional ℝ^n. Its dual (Profile model →L[ℝ] ℝ) is also
   finite-dim, hence separable. Pick a countable dense subset {ℓ_n} of the dual unit sphere.
   For each ℓ_n, get full-measure set S_n where ℓ_n(P m) ≤ sSup (ℓ_n '' B m).
   Intersect: S := ⋂_n S_n has full measure (countable intersection).

3. **Conclude P m ∈ B m a.e.**: For m ∈ S, suppose P m ∉ B m. By closed-convex hull + 
   finite-dim Hahn-Banach (geometric_hahn_banach_closed_point or similar), ∃ continuous
   linear ℓ with ℓ(P m) > sSup (ℓ '' B m). By continuity of ℓ ↦ ℓ(P m) and ℓ ↦ sSup (ℓ '' B m)
   (on bounded closed convex B m, both continuous on dual norm), approximate ℓ by some ℓ_n
   close enough that ℓ_n(P m) > sSup (ℓ_n '' B m) — contradicting m ∈ S_n. Hence P m ∈ B m.

## Mathlib lemmas you may need

- geometric_hahn_banach_closed_point or inner_le_iff for closed convex separation
- Metric.dense_iff_iUnion_ball for countable dense set
- Module.Finite.finiteDimensional for finite-dim Profile
- MeasureTheory.ae_iff for the upgrade
- MeasureTheory.ae_of_forall_measure_lt_top_ae (or whatever the precise name is)

If any of these aren't directly available in Lean 4.29 Mathlib, identify substitutes or
declare STUCK at that point with the precise missing lemma.

## Substantive challenge

This proof has several deep components:
- Step 1 requires careful Radon-Nikodym / Lebesgue point argument.
- Step 2 requires explicit countable dense construction in finite-dim dual.
- Step 3 requires Hahn-Banach + continuity-of-sup-functional argument.

If genuinely intractable in one Pro pass, declare STUCK with a precise diagnostic of
which step is the blocker.

## Output


lean_proof
target_lemma_slug: support_function_integrated_Hall_equivalence_mpr
status: PROVED | STUCK
tactics_used: [...]



lean
-- Just provide the ⇐ direction body (the `intro hHall; classical; ...` part)
intro hHall
classical
-- your proof


Aim 150-500 lines. If STUCK, clearly identify the step where you stalled and what Mathlib
infrastructure is missing.

Show more

========
ROLE: assistant (id=125ca969-916d-47da-8180-7f3b5407f821)
========
lean_proof
target_lemma_slug: support_function_integrated_Hall_equivalence_mpr
status: STUCK
tactics_used: [intro, classical, have, refine, by_cases, rw, filter_upwards]

lean
intro hHall
classical

-- I can reduce the target to one clean missing geometric lemma.
-- Let L be the continuous dual of the profile space.
let L := Profile model →L[ℝ] ℝ

-- Step 1: Hall inequalities imply, for each fixed functional ℓ,
--         the pointwise support inequality holds q-a.e.
have hℓ_ae :
    ∀ ℓ : L,
      (fun m => ℓ (P m)) ≤ᵐ[q] (fun m => sSup (ℓ '' B m)) := by
  intro ℓ
  refine MeasureTheory.ae_le_of_forall_setIntegral_le (hP_int ℓ) (hsupp_int ℓ) ?_
  intro E hE hEfin
  by_cases hqE : q E = 0
  · -- This branch should close by the standard “set integral over a null set is zero”
    -- simp [hqE]
    -- Exact local name is file/import dependent:
    --   setIntegral_eq_zero_of_measure_zero
    -- or a `[simp]` lemma for `(q.restrict E) = 0`.
    have h₁ : ∫ m in E, ℓ (P m) ∂q = 0 := by
      -- STUCK only on local lemma name without main.lean/import context.
      -- expected: exact setIntegral_eq_zero_of_measure_zero hqE
      admit
    have h₂ : ∫ m in E, sSup (ℓ '' B m) ∂q = 0 := by
      -- expected: exact setIntegral_eq_zero_of_measure_zero hqE
      admit
    simpa [h₁, h₂]
  · exact hHall E hE hqE ℓ

-- Step 2: take a countable dense family in the dual and intersect the
--         corresponding full-measure sets.
--
-- This requires `[SeparableSpace L]`, which should follow from finite-dimensionality
-- of `Profile model`. The exact instance path is file-dependent.
let D : ℕ → L := TopologicalSpace.denseSeq L
have hD_dense : DenseRange D := TopologicalSpace.denseRange_denseSeq L

have hD_ae :
    ∀ᵐ m ∂q, ∀ n : ℕ,
      D n (P m) ≤ sSup ((D n) '' B m) := by
  rw [MeasureTheory.ae_all_iff]
  intro n
  exact hℓ_ae (D n)

-- Step 3 would finish with the following missing geometric lemma:
--
-- lemma closed_convex_mem_of_dense_support_le
--   {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
--   (D : ℕ → E →L[ℝ] ℝ) (hD : DenseRange D)
--   {S : Set E} {x : E}
--   (hS_closed : IsClosed S)
--   (hS_convex : Convex ℝ S)
--   (hS_nonempty : S.Nonempty)
--   (hS_bounded : Bornology.IsBounded S)
--   (hineq : ∀ n, D n x ≤ sSup ((D n) '' S)) :
--   x ∈ S
--
-- Applying it would be:
filter_upwards [hD_ae] with m hm
exact
  closed_convex_mem_of_dense_support_le
    D hD_dense
    (hB_closed m) (hB_convex m) (hB_nonempty m) (hB_bounded m)
    hm

The blocker is not the measure-theory step. Mathlib has exactly the integral-to-a.e. lemma needed here: MeasureTheory.ae_le_of_forall_setIntegral_le, which turns ordered set integrals of integrable real functions into an a.e. inequality. It is documented with the statement f ≤ᵐ[μ] g. 
Lean Community

The real missing bridge is the pointwise geometric lemma closed_convex_mem_of_dense_support_le above. Its proof is mathematically straightforward: if x ∉ S, geometric_hahn_banach_closed_point gives a strict separating continuous linear functional, and density plus boundedness of S ∪ {x} lets one approximate that separator by some D n, contradicting the dense support inequality. Mathlib has the Hahn-Banach separator available. 
Lean Community

I also checked the nearby countable-halfspace theorem. RCLike.iInter_countable_halfSpaces_eq gives a countable halfspace representation for a fixed closed convex set, but the countable family depends on that set. Here B m varies with m, so that theorem does not supply a single countable family of functionals usable under the q-a.e. countable intersection. 
Lean Community

So the proof stalls at the “dense dual support inequalities imply closed-convex membership” lemma, plus minor local-name uncertainty for null set-integrals because the actual main.lean/imports were not available in the workspace.
