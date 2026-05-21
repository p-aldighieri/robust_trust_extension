FOCUSED MATHLIB API QUESTION. No proof required, just the right term.

## Question

In Lean 4 Mathlib 4.29 (toolchain `lean-4.29.0`), given:
```
variable (Ω : Type) [Fintype Ω]
example : FiniteDimensional ℝ ((Ω → ℝ) →L[ℝ] ℝ) := inferInstance  -- works
```

What is the correct way to derive:
```
example : TopologicalSpace.SeparableSpace ((Ω → ℝ) →L[ℝ] ℝ) := by
  ??
```

I've tried:
- `inferInstance` — fails
- `FiniteDimensional.separableSpace ℝ _` — doesn't typecheck or wrong name
- `ProperSpace.secondCountableTopology.to_separableSpace` — `ProperSpace` doesn't have `secondCountableTopology` field

The dual `(Ω → ℝ) →L[ℝ] ℝ` is finite-dim ℝ-normed (dim |Ω|), hence linearly isometric to ℝ^|Ω|, hence SeparableSpace. What's the Mathlib path?

Possible directions:
1. Direct named instance: `TopologicalSpace.SeparableSpace` for finite-dim normed spaces.
2. Via `SecondCountableTopology`: chain `FiniteDimensional → SecondCountableTopology → SeparableSpace`.
3. Via explicit linear isometry to `EuclideanSpace ℝ (Fin n)` or `Ω → ℝ`.
4. Via `Module.Free` + countable basis.

## Output

Give the exact Lean 4 Mathlib 4.29 term/tactic, e.g.:

```lean
example (Ω : Type) [Fintype Ω] : TopologicalSpace.SeparableSpace ((Ω → ℝ) →L[ℝ] ℝ) := by
  -- precise Lean 4 expression
```

Or if there's no clean path, suggest the cleanest manual construction (e.g., rational-coefficient functionals enumeration with Density proof).

Keep response under 60 lines.
