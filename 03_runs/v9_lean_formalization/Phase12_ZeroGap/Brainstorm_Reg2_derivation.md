ROLE — Math strategist for zero-gap Lean formalization. Extended Pro.

# Task

The v9 paper's Reg-1 + Reg-2 setup makes several relations between G (rowwise minimizer correspondence) and B (Bayes cone correspondence) IMPLICIT. The Lean formalization currently treats one such relation as a primitive:

```lean
G_rowwise_carries_prior_to_bayes_cone :
  ∀ s m', m' ∈ G s → model.inclM s ∈ bayesConeFromPrior (model.inclM m')
```

User directive: this should be DERIVED from more primitive structural data, not assumed. The Lean should match or exceed the v9 paper's primitive depth.

# Available primitive structural data in RegPackage

Per v9 §B.5 Reg-1 + Reg-2:
- `G : M → Set M` — rowwise minimizer correspondence (set-valued).
- `G_closedGraph : IsClosed {(s, m) | m ∈ G s}` — Reg-1 closed-graph.
- `G_nonempty : ∀ s, (G s).Nonempty` — Reg-1 nonemptiness.
- `G_compact : ∀ s, IsCompact (G s)` — Reg-1 compact values.
- `G_rowwise_minimizer` — Reg-1 minimizer characterization (some specific form like "m' ∈ G(s) ↔ y(m')·s = min over feasible y(m)·s").
- `B : M → Set (Belief Ω)` — Bayes cone correspondence.
- `B_closed : ∀ m, IsClosed (B m)` — Reg-2 closedness.
- `B_convex_profile : ∀ m, Convex ℝ (beliefAsProfile '' B m)` — Reg-2 convexity.
- `B_support_continuous : ∀ y, Continuous (fun m => supportFunction (B m) y)` — Reg-2 support-continuity.
- `B_bayes_optimal : ∀ m μ, μ ∈ B m → IsBayesOptimal σstar μ` — Reg-2 Bayes-optimality.
- `bayesConeFromPrior : Belief Ω → Set (Belief Ω)` — Reg-2 construction map.
- `bayesConeFromPrior_self : ∀ μ, μ ∈ bayesConeFromPrior μ` — Reg-2 self-consistency.
- `B_eq_bayesConeFromPrior_at_inclM : ∀ m, B m = bayesConeFromPrior (inclM m)` — B's defining identity.

# Question

Derive `G_rowwise_carries_prior_to_bayes_cone` from a SMALLER set of structural primitives.

Possible routes:

**Route 1 (preferred): Direct from G's definition.**

G(s) is the rowwise minimizer correspondence at source s. By definition in v9, m' ∈ G(s) means m' is a minimizer of the adversary's optimization given source belief s. The minimization is OVER messages m such that the agent's choice at m is optimal — which means s is in the Bayes cone at m's belief. So `m' ∈ G(s) ⟹ s ∈ B(m')` IS the minimizer's feasibility constraint.

What more primitive structural data would expose this? E.g., a "feasibility" Prop on G:
```lean
G_feasibility : ∀ s m, m ∈ G s → model.inclM s ∈ bayesConeFromPrior (model.inclM m)
```
But this is just renaming the field. Not deriving.

**Route 2: Use G's closed-graph + B's construction map.**

If B is constructed FROM Reg-1 (e.g., B(m) := {μ : ∃ s, m ∈ G(s) ∧ μ = inclM s} ∪ {inclM m}^closure_convex), then `m' ∈ G(s) → inclM s ∈ B(m')` follows from B's definition. This requires reframing B as derived from G via a closed-convex-hull construction.

What concretely: introduce a new Reg-2 primitive `bayesConeFromPrior` as a `def` that constructs B from G:
```lean
noncomputable def bayesConeFromPriorFromG (μ : Belief Ω) : Set (Belief Ω) :=
  closedConvexHull (... constructed from G ...)
```
Then `G_rowwise_carries_prior_to_bayes_cone` is a theorem about this construction.

**Route 3: Define G as a function of B + payoff data, derive carries-prior automatically.**

If G is constructed as `G(s) := argmin over m s.t. <agent's strategy at m is optimal>`, and "optimal" means posterior in B, then the construction makes the carries-prior identity automatic. Requires:
- An underlying payoff functional and strategy that determine G.
- The Bayes cone B as a function of strategy / payoff.

# Output

Recommend the cleanest route to make `G_rowwise_carries_prior_to_bayes_cone` a derived theorem. Propose:
1. New structural primitives to add (or restructure).
2. Lemma statements + proof skeletons.
3. What v9 paper assumes that we're now expressing more carefully.

Goal: in the resulting Lean, NO `G_rowwise_carries_prior_to_bayes_cone` field exists. It's a derived `lemma` from more elementary structural primitives.

Cite v9_consolidated.md §B.5.
