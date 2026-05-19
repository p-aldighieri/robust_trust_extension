You are the Lean Prover. Close ONE specific `sorry`.

## Target lemma

```lean
theorem compact_menu_space_compact
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    CompactSpace (CompactMenu model) := by
  sorry
```

(In namespace `RobustTrustV8`. Imports: `import Mathlib`.)

## Relevant definitions

```lean
abbrev Profile (model : RobustTrustModel) : Type := model.Ω → ℝ
def PayoffProfileSet (model : RobustTrustModel) : Set (Profile model) :=
  Set.range model.profileOfPrivate
abbrev ProfileInW (model : RobustTrustModel) : Type :=
  {w : Profile model // w ∈ PayoffProfileSet model}
abbrev CompactMenu (model : RobustTrustModel) : Type :=
  TopologicalSpace.NonemptyCompacts (ProfileInW model)
```

And `prs.W_compact : IsCompact (PayoffProfileSet model)`.

## Math

`ProfileInW` is the subtype of `Profile model = model.Ω → ℝ` (pi topology) restricted to `PayoffProfileSet`. Since `model.Ω` is `Fintype`, `Profile model` is a finite-dim function space (with the pi topology = product Euclidean topology).

`IsCompact (PayoffProfileSet model)` ⇒ the subtype `ProfileInW` is a CompactSpace (via `isCompact_iff_compactSpace` or `Subtype.compactSpace`).

`NonemptyCompacts X` for X a CompactSpace + T2Space + MetricSpace gives a CompactSpace via `TopologicalSpace.NonemptyCompacts.instCompactSpace` (Blaschke / Vietoris compactness).

The challenge: `Profile model = model.Ω → ℝ` may not auto-derive `MetricSpace`/`T2Space`/`SecondCountableTopology` instances. We may need explicit `haveI` declarations.

## Suggested Mathlib API

- `isCompact_iff_compactSpace : IsCompact s ↔ CompactSpace s` (for subtype)
- `Subtype.compactSpace` — auto-instance when the underlying set is compact
- `TopologicalSpace.NonemptyCompacts.instCompactSpace`
- `Pi.t2Space`, `Pi.metricSpace` — auto-derive on pi types

## Output

```lean_proof
target_lemma_slug: compact_menu_space_compact
status: PROVED
tactics_used: [...]
proof_length_lines: <int>
introduces_have_clauses: <int>
```

```lean
theorem compact_menu_space_compact
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    CompactSpace (CompactMenu model) := by
  -- your proof
  sorry
```

Aim for short. If you hit a missing instance issue you can't resolve, return STUCK with the specific instance you need.
