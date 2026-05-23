ROLE — Lean 4 / Mathlib prover, Phase 4c BUILD FIX. Opus.

# Mission

Phase 4b restated the KR axiom correctly but the build FAILS with 2 Lean errors. The subagent only verified via `lake env lean` without checking the actual build, missing these.

# Errors

## Error 1 (line 3147 of v9_appendix.lean)

```
error: Type mismatch
  (model.inclM s).property.right
has type
  ∑ ω ∈ @Finset.univ model.Ω model.Ω_fintype, ↑(model.inclM s) ω = 1
but is expected to have type
  ∑ ω ∈ @Finset.univ model.Ω this✝, ↑(model.inclM s) ω = 1
```

Cause: `Belief` uses a different Fintype instance than `model.Ω_fintype` in some context. Lean picked an anonymous instance `this✝` that doesn't unify with `model.Ω_fintype`.

Fix: provide the explicit Fintype instance, OR rewrite `(model.inclM s).property.2` differently to match. Alternatives:
- Use `Belief`'s own sum-one lemma.
- Provide `(inferInstance : Fintype model.Ω)` explicitly.
- Use `simp` to handle the instance.

## Error 2 (line 3216)

```
Tactic `rfl` failed: The left-hand side
  model.α * ∫ (m : model.M), ∑ v, incl m v * y m v - σ m (y m) ∂model.τM +
    (1 - model.α) * ∫ (s : model.M), sInf ((fun m' => ∑ v, incl s v * y m' v - σ m' (y m')) '' {m' | (s, m') ∈ R}) ∂model.τM
is not definitionally equal to the right-hand side
  model.α * ...  [regPsi unfolded form]
```

Cause: `regPsi` unfolds to a slightly different form than the bridge's vector-Hall hypothesis. `rfl` doesn't close the gap.

Fix:
- Use `simp only [regPsi, beliefDot, ...]` to unfold both sides.
- Or use `congr 1` and prove each integral matches.
- Or rewrite the form to match `regPsi` definition byte-by-byte.

Check `regPsi` definition (line ~1350 of v9_appendix.lean) to see exact form, then adjust either the bridge's vector-Hall statement or the rewrite tactic.

# Constraints

- Build MUST PASS: `lake build MathlibStarter.V9Main` (not just `lake env lean`).
- After concat+cp, the actual command is:
  ```
  cd "C:/Users/Public/Documents/Lean/MathlibStarter"
  lake build MathlibStarter.V9Main
  ```
  Verify EXIT CODE 0.
- No new axioms, no new sorries.
- Edit only lean/v9_appendix.lean.
- Cap 5 iterations.

# Files

- Edit: `lean/v9_appendix.lean`

# Output

Short report: build status (verified with `lake build`, not `lake env lean`), the 2 error fixes applied.
