You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem closure_pruning_value_preservation
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt) :
    ∃ cdagger : PrunedMenuCdagger model wlabel,
      (↑cdagger.Cdagger : Set (ProfileInW model)) ⊆
          (↑opt.Cstar : Set (ProfileInW model)) ∧
        MenuFunctionalF model cdagger.Cdagger = MenuFunctionalF model opt.Cstar ∧
        MenuFunctionalF model opt.Cstar = UStarM model := by
  sorry
```

## Relevant definitions

```lean
structure OptimalMenuCstar (model : RobustTrustModel) where
  Cstar : CompactMenu model
  optimal : ∀ C : CompactMenu model, MenuFunctionalF model C ≤ MenuFunctionalF model Cstar
  value_eq : MenuFunctionalF model Cstar = UStarM model

structure AlignedBestLabelingWstar (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) where
  wstar : model.M → ProfileInW model
  measurable_wstar : Measurable wstar
  mem_Cstar : ∀ m : model.M, wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))
  is_argmax :
    ∀ m : model.M,
      IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
        (↑opt.Cstar : Set (ProfileInW model)) (wstar m)

structure PrunedMenuCdagger (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    (wlabel : AlignedBestLabelingWstar model opt) where
  Cdagger : CompactMenu model
  pruned_subset : (↑Cdagger : Set (ProfileInW model)) ⊆ (↑opt.Cstar : Set (ProfileInW model))
  closure_subset_Cdagger :
    closure (Set.range wlabel.wstar) ⊆ (↑Cdagger : Set (ProfileInW model))
  Cdagger_subset_closure :
    (↑Cdagger : Set (ProfileInW model)) ⊆ closure (Set.range wlabel.wstar)
  value_preserved : MenuFunctionalF model Cdagger = MenuFunctionalF model opt.Cstar
```

## Math sketch

Construct `cdagger.Cdagger := closure(Set.range wlabel.wstar) ∩ ↑opt.Cstar`, or more simply just `closure(Set.range wlabel.wstar)` if it's automatically inside Cstar.

Since:
- `wlabel.wstar m ∈ ↑opt.Cstar` for all m (by `wlabel.mem_Cstar`).
- `Set.range wlabel.wstar ⊆ ↑opt.Cstar`.
- `↑opt.Cstar` is compact, hence closed.
- `closure (Set.range wlabel.wstar) ⊆ closure ↑opt.Cstar = ↑opt.Cstar`.

So `Cdagger := closure(Set.range wstar)` is a compact subset of `↑opt.Cstar`.

For Cdagger to be a `NonemptyCompacts (ProfileInW model)`:
- Nonempty: range wstar nonempty (since model.M nonempty), closure of nonempty is nonempty.
- Compact: closure of bounded set in a complete metric space... actually closure of an arbitrary set isn't always compact. We need `closure (range wstar)` ⊆ ↑opt.Cstar (a compact, hence bounded) — closed subset of compact is compact.

So `Cdagger := ⟨⟨closure (Set.range wlabel.wstar), is_compact⟩, is_nonempty⟩`.

Where:
- `is_compact`: `IsCompact.closure_of_subset opt.Cstar.isCompact ...` or via `IsClosed.isCompact (isClosed_closure) ...` ⊓ subset.
- Actually: `closure (range wstar) ⊆ ↑Cstar` (closed subset of compact = compact).

### Value preservation `MenuFunctionalF model Cdagger = MenuFunctionalF model opt.Cstar`

This is the substantive part:
`F(Cdagger) = ∫ α maxPayoff(Cdagger,s) + (1-α) minPayoff(Cdagger,s) dτM`
`F(Cstar) = ∫ α maxPayoff(Cstar,s) + (1-α) minPayoff(Cstar,s) dτM`

For each s:
- `maxPayoff(Cdagger, s) = maxPayoff(Cstar, s)`: 
  - ≤ by Cdagger ⊆ Cstar.
  - ≥ because wstar s ∈ Cdagger (via closure_subset_Cdagger from range wstar), and `beliefDot (inclM s) (wstar s).val = maxPayoff(Cstar, s)` (by `wlabel.is_argmax` + `IsMaxOn.sSup_eq` or similar).
- `minPayoff(Cdagger, s) = minPayoff(Cstar, s)`:
  - ≥ by Cdagger ⊆ Cstar (smaller set, sInf bigger).
  - ≤ this direction is NOT generally true. Cdagger = closure(range wstar), and the min over closure(range wstar) might differ from min over Cstar. **But** Cstar is the original menu and the adversary picks ANY w ∈ Cstar to minimize. Pruning to closure(range wstar) gives a possibly larger min.

Hmm, the value preservation requires more delicate argument. Maybe Cdagger should be `Cstar` itself with a specific "labeling" that's the range wstar... but that's not what the structure asks.

Actually reading the structure carefully — `Cdagger_subset_closure` says ↑Cdagger ⊆ closure (range wstar). And `closure_subset_Cdagger` says closure (range wstar) ⊆ ↑Cdagger. So `↑Cdagger = closure (range wstar)`. So Cdagger is uniquely determined as closure(range wstar).

For F(Cdagger) = F(Cstar):
- Max preserved: ✓ as above.
- Min: less obvious. 

Actually here's the key insight from the v8 proof: F preservation holds because the OPTIMAL MENU functional value over Cstar coincides with the value over closure(range wstar). The min part needs that closure(range wstar) is "wide enough" to realize the min. Specifically, by optimality of Cstar and wstar's role as aligned-best, the wstar trajectory captures both extrema.

In fact in v8: by Cstar OPTIMALITY (F(Cstar) ≥ F(C) for all C), pruning to any subset C† ⊆ Cstar can only decrease F. So `F(Cdagger) ≤ F(Cstar)`. The reverse direction is what we need.

`F(Cdagger) ≥ F(Cstar)` requires that the integral `∫ α max + (1-α) min` is preserved. This uses the v8 proof's specific min-attainment property.

**Alternative**: maybe the value preservation can be proved differently — by re-applying optimality. Specifically, opt.value_eq says F(Cstar) = UStarM. If we can show F(Cdagger) ≥ UStarM (using some structural fact), then F(Cdagger) ≥ F(Cstar). Combined with ≤, get equality.

In v8 proof, the "pruning preservation" is a substantive lemma that uses the closure construction and the aligned-best property. Mainly the **min direction**: ∀ s, minPayoff(closure(range wstar), s) = minPayoff(Cstar, s).

Actually this min equality is subtle. The adversary minimizes over Cstar; the pruned menu allows minimizing only over closure(range wstar). If the original min was achieved at some w_min ∈ Cstar that's not in closure(range wstar), then pruning loses information.

But by closure(range wstar) being a "Bayes-cone-aligned" pruning, the v8 proof shows this preserves the min. The argument relies on:
- For each s, the minPayoff(Cstar, s) value equals beliefDot (inclM s) (wlabel.wstar (some s')) for some s' (because the adversary's min coincides with the aligned-best's image at some other state).

This is non-trivial. May STUCK.

## Strategy

Construct cdagger.Cdagger = closure(range wstar) with the right NonemptyCompacts wrap. Prove value_preserved by case-splitting max/min:
- Max: explicit by wstar s ∈ Cdagger achieving max.
- Min: NON-TRIVIAL. The v8 proof needs a SPECIFIC adversary-min equivalence. If you can't close this in-thread, STUCK with the precise gap.

## Output

```
lean_proof
target_lemma_slug: closure_pruning_value_preservation
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem closure_pruning_value_preservation ... := by
  -- your proof
```

Aim for 80-150 lines. If value_preserved (specifically min direction) requires a non-trivial v8-specific argument that's not derivable from the given structure, return STUCK with the precise statement of the auxiliary lemma you'd need.
