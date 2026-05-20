You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem strategy_value_le_menu_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)) := by
  sorry
```

## Math sketch

For any agent strategy σM, construct a compact menu `C_σ ⊆ PayoffProfileSet model` from σM such that `RobustPayoffM σM ≤ MenuFunctionalF C_σ`. Then `RobustPayoffM σM ≤ sSup (range F)` via `le_csSup`.

**Construction of C_σ**: Take C_σ := closure(image of M under `s ↦ profileMap σM s`). 
- profileMap σM s = profileOfPrivate (σM.sectionM s) ∈ PayoffProfileSet.
- So range (profileMap σM) ⊆ PayoffProfileSet model = ↑PayoffProfileSet ⊆ ProfileInW model (subtype).
- Hmm, we want C_σ : CompactMenu model = NonemptyCompacts (ProfileInW model).

Subtle: profileMap σM : model.M → Profile model, but ProfileInW is a subtype. Each value is in PayoffProfileSet, so we can lift to ProfileInW. Lift: `fun s => (⟨profileMap σM s, ⟨σM.sectionM s, rfl⟩⟩ : ProfileInW model)`.

Then range (lifted) ⊆ ProfileInW model is fine. Closure of this range in ProfileInW model.

Need closure compact: range may not be compact. Image of model.M (compact) under continuous lift function would be compact, but is profileMap continuous? profileOfPrivate continuous (per setup), σM.sectionM is measurable but maybe not continuous.

If σM.sectionM not continuous, image might not be compact. Then closure of range might not be compact either.

Hmm. The structure requires C_σ to be compact. We need to be careful.

**Alternative**: Take C_σ := all of PayoffProfileSet (lifted to ProfileInW). It's compact (by prs.W_compact). Then F(C_σ) ≥ ??? Not obvious.

**Cleaner**: Define σM-induced menu = closure(range of σM ∘ profileOfPrivate restricted to image). 

Actually rethinking: the v8 argument is:
- Pick C_σ := PayoffProfileSet (or any menu containing range profileMap σM).
- maxPayoff(C_σ, s) ≥ beliefDot(inclM s) (profileMap σM s).
- AlignedPayoffM σM = ∫ beliefDot(inclM s) (profileMap σM s) dτ ≤ ∫ maxPayoff(C_σ, s) dτ.
- For adversary: MisalignedPayoffM β σM ≥ ∫ minPayoff(C_σ, s) dτ (with appropriate Markov kernel argument).
- So RobustPayoffM σM = α A + (1-α) sInf_β M ≤ α ∫ max + (1-α) sInf_β [∫ ∫ beliefDot ...] = ??

Hmm. sInf_β over kernels: the adversary picks β to minimize. β can pick any m, including the worst one. So sInf_β MisalignedPayoffM β σM ≥ ∫ minPayoff(C_σ, s) dτ — wait, opposite direction.

Actually: MisalignedPayoffM β σM = ∫ ∫ beliefDot(inclM s, profileMap σM m) dβ(s, m) dτ. For each (s, m), beliefDot... ≥ minPayoff(C_σ, s) (where C_σ contains the range profileMap σM, so the value at any m is ≥ inf). So MisalignedPayoffM β σM ≥ ∫ minPayoff(C_σ, s) dτ.

Then sInf_β ≥ ∫ minPayoff(C_σ, s) dτ.

α A + (1-α) sInf_β M ≤ α ∫ max C_σ + ??? Hmm wait, we want ≤ for RobustPayoffM σM ≤ F(C_σ). Let me re-derive.

F(C_σ) = ∫ α max C_σ + (1-α) min C_σ dτ.
RobustPayoffM σM = α A + (1-α) sInf_β M.

For RobustPayoffM σM ≤ F(C_σ): need α A ≤ α ∫ max AND (1-α) sInf_β M ≤ (1-α) ∫ min.

α A = α ∫ beliefDot(inclM s, profileMap σM s) dτ.
α ∫ max C_σ = α ∫ sSup ((beliefDot (inclM s)) '' lifted profileMap σM range across some menu).

If C_σ ⊇ image of profileMap σM, then profileMap σM s ∈ C_σ for each s, so beliefDot(inclM s, profileMap σM s) ≤ max C_σ s. So A ≤ ∫ max C_σ. Then α A ≤ α ∫ max C_σ. ✓

For (1-α) sInf_β M ≤ (1-α) ∫ min C_σ: sInf_β M ≤ ∫ min C_σ. We need to construct an adversary kernel βargmin such that MisalignedPayoffM βargmin σM = ∫ min C_σ.

βargmin would pick m* ∈ argmin_{m'} beliefDot(inclM s, profileMap σM m') for each s. Since profileMap σM m can attain min C_σ at some m (because C_σ = range profileMap σM has min as element), βargmin exists.

Actually wait — min C_σ s = sInf {beliefDot(inclM s, w) : w ∈ C_σ}. If C_σ = closure(range profileMap σM), the sInf is attained on the closure but maybe not on the range itself. So we may need approximation: ∃ sequence m_n with beliefDot(inclM s, profileMap σM m_n) → min C_σ s.

Then βargmin chooses an ε-minimizer. By a similar argument to epsilon_adversary_realization, sInf_β M ≤ ∫ min C_σ + ε for any ε > 0. Taking ε → 0: sInf_β M ≤ ∫ min C_σ.

This is non-trivial. Skip detailed proof and stub the key intermediate. The substantive content involves:
1. Build C_σ : CompactMenu model. (Requires closure of range under lifting, ensuring compactness.)
2. Show MenuFunctionalF C_σ ≥ RobustPayoffM σM via the bounds above.
3. Use `le_csSup` with BddAbove witness for `range (MenuFunctionalF model)`.

For step 3: BddAbove of `range F` requires uniform upper bound on F(C). By the same private_profile_bounded argument, |F(C)| ≤ C_bnd for any C. So range F is bounded above.

## Strategy

This is substantively similar to `menu_value_le_strategy_sup` (which we proved). The structural pattern:
- σM-induced menu construction
- Per-s/per-m pointwise inequality between beliefDot and max/min payoff
- Integration via le_csSup over kernels + le_csSup over menus

Provide the cleanest version you can. If certain steps require non-trivial machinery (e.g., closure of range needs continuity of profileMap which we don't have), use STUCK with the precise gap.

## Output

```
lean_proof
target_lemma_slug: strategy_value_le_menu_sup
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem strategy_value_le_menu_sup ... := by
  -- your proof
```

Aim for 100-200 lines.
