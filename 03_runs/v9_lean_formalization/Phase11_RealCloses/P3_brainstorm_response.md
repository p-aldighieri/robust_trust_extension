Recommendation

Refactor P3Hyp into a finite cone-Hall LP certificate over real structural data, not a bundle of named propositions. The current shape

lean
polyhedralW : Prop
finiteVertexMenu : Prop
positiveConeMargin : Prop
finiteLPFeasible : Prop

is exactly the kind of “looks mathematical but proves anything if named generously” scaffolding the v9 reviewer warned against: opaque Prop fields in P3Hyp and sibling structures make theorem statements vacuous unless expanded into concrete data and target conclusions. 

decomposition_review_response

The canonical replacement should expose:

a finite active payoff menu;

finite coordinates for the relevant beliefs/messages;

finite facet descriptions of the Bayes cones;

a finite rowwise-minimizer/flow LP;

a concrete Farkas instance or primal certificate;

a reduction lemma showing the actual reg.Psi is the dual functional of that finite LP.

The mathematical target is exactly v9’s P3/G4 statement: polyhedral W, finite active menu, finite-facet Bayes cones, and an LP pass; raw polyhedrality is not enough, and the LP is the pass/fail certificate. 

v9_executive_summary

1. Proposed structural primitives

I would split P3Hyp into five records. This keeps the little dragon cages labeled: geometry, quotient, cones, LP, and margin.

A. Finite active menu

This is the finite C* = {w₁,…,wₖ} object.

lean
structure P3FiniteMenu (model : RobustTrustModel) (reg : RegPackage model) where
  J : Type
  instFintypeJ : Fintype J
  instDecEqJ : DecidableEq J

  /-- Active payoff vertices, i.e. the finite menu C*. -/
  w : J → Profile model
  w_in_WP : ∀ j, w j ∈ WP model

  /-- Message/belief representative for each active label. -/
  m : J → model.M
  μ : J → Belief model.Ω
  μ_eq_message : ∀ j, μ j = model.inclM (m j)

  /-- The regular labeling factors through this finite menu. -/
  label : model.M → J
  label_measurable : Measurable label
  wstar_eq : ∀ᵐ x ∂model.τM, reg.wstar x = w (label x)

For the strict finite-LP proof over all bounded Borel y : M → ℝ^Ω, you need a finite quotient strong enough to reduce reg.Psi y to a finite dual expression. The safest Lean version is finite atomic support:

lean
  /-- Exact finite support, not just finite labels. -/
  finite_support_exact : ∀ᵐ x ∂model.τM, m (label x) = x

A weaker non-atomic quotient can be used, but then it must carry proved Jensen/infimum reduction lemmas. Without that, Borel prices can vary inside a cell and the finite LP no longer controls ∀ y. This is where old “finite cell” arguments tend to leak glitter.

B. Polyhedral feasible payoff set W

Replace polyhedralW : Prop with an actual halfspace representation.

lean
structure P3PolyhedralW (model : RobustTrustModel) where
  H : Type
  instFintypeH : Fintype H
  instDecEqH : DecidableEq H

  A : H → Profile model
  b : H → ℝ

  /-- W is exactly this finite halfspace intersection. -/
  W_eq :
    ∀ z : Profile model,
      z ∈ PayoffProfileSet model ↔
        ∀ h : H, dotProfile (A h) z ≤ b h

  W_nonempty : (PayoffProfileSet model).Nonempty
  W_compact : IsCompact (PayoffProfileSet model)
  W_convex : Convex ℝ (PayoffProfileSet model)

This lets clarke_product_normal_cone_projection_generic or standard polyhedral normal-cone facts derive the normal/Bayes cone at each active vertex. Do not store “polyhedralW” as an incantation.

C. Finite-facet Bayes cone data

The P3/G4 memo explicitly uses finite-facet Bayes cones

B
j
	​

={p∈Δ(Ω):g
jℓ
	​

⋅p≤c
jℓ
	​

}.

It then defines q_j, n_j, and checks

g
jℓ
	​

⋅n
j
	​

≤c
jℓ
	​

q
j
	​

.

v9_consolidated

In Lean:

lean
structure P3BayesConeFacets
    (model : RobustTrustModel)
    (reg : RegPackage model)
    (menu : P3FiniteMenu model reg) where

  Facet : menu.J → Type
  instFintypeFacet : ∀ j, Fintype (Facet j)
  instDecEqFacet : ∀ j, DecidableEq (Facet j)

  g : ∀ j, Facet j → Profile model
  c : ∀ j, Facet j → ℝ

  /-- Finite facet representation of the Bayes cone for label j. -/
  cone_eq :
    ∀ j p,
      p ∈ BayesConeW model (menu.w j) ↔
        (∀ ℓ : Facet j, beliefDot p (g j ℓ) ≤ c j ℓ)

  /-- The regular package's B is exactly this Bayes cone on active messages. -/
  reg_B_eq :
    ∀ᵐ x ∂model.τM,
      reg.B x = BayesConeW model (menu.w (menu.label x))

The proof of cone_eq should be derived from P3PolyhedralW plus the normal-cone projection theorem, not asserted by a ghost field in P3Hyp.

D. Rowwise minimizer relation and tie splitting

Tie discipline is useful, but it cannot be the theorem. Generic no-tie assumptions only help measurability and do not repair vector-balance failure; the finite-facet LP may still fail. 

searcher_07_response

Use either deterministic rowwise minimizers or explicit tie splitting.

lean
structure P3RowwiseRouting
    (model : RobustTrustModel)
    (reg : RegPackage model)
    (menu : P3FiniteMenu model reg) where

  /-- Source label for finite/atomic source messages. -/
  sourceLabel : model.M → menu.J
  sourceLabel_measurable : Measurable sourceLabel
  source_support_exact : ∀ᵐ s ∂model.τM, menu.m (sourceLabel s) = s

  /-- Allowed rowwise-minimizer relation. -/
  allowed : menu.J → menu.J → Prop
  allowed_decidable : ∀ i j, Decidable (allowed i j)

  allowed_iff_min :
    ∀ i j,
      allowed i j ↔
        ∀ j' : menu.J,
          beliefDot (menu.μ i) (menu.w j) ≤
            beliefDot (menu.μ i) (menu.w j')

  /-- Compatibility with reg.G. -/
  reg_G_eq :
    ∀ᵐ s ∂model.τM,
      reg.G s =
        {x : model.M | allowed (sourceLabel s) (menu.label x)}

For positive-mass ties, add a finite tie-splitting variable rather than pretending there are no ties:

lean
  split : menu.J → menu.J → ℝ
  split_nonneg : ∀ i j, 0 ≤ split i j
  split_support : ∀ i j, split i j ≠ 0 → allowed i j
  split_sum : ∀ i, ∑ j, split i j = 1

This splitting is structural: it says how adversarial source mass is routed among rowwise minimizers.

E. Concrete finite LP and Farkas instance

The finite cone-Hall theorem is a Farkas-style finite LP: nonnegative flows x_ij, supported on rowwise minimizers, satisfy source balance and cone calibration. The record states the flow constraints

x
ij
	​

≥0,x
ij
	​

=0 if j∈
/
R(i),
j
∑
	​

x
ij
	​

=(1−α)τ
i
	​

,

and

n
j
	​

/q
j
	​

∈B
j
	​

,n
j
	​

=ατ
j
M
	​

m
j
	​

+
i
∑
	​

x
ij
	​

s
i
	​

,q
j
	​

=ατ
j
M
	​

+
i
∑
	​

x
ij
	​

.

prover_12_response

Use actual variables.

lean
structure P3FiniteFlowLP
    (model : RobustTrustModel)
    (reg : RegPackage model)
    (menu : P3FiniteMenu model reg)
    (cones : P3BayesConeFacets model reg menu)
    (routing : P3RowwiseRouting model reg menu) where

  /-- Mass of source/aligned atom i. -/
  τmass : menu.J → ℝ
  τmass_nonneg : ∀ i, 0 ≤ τmass i
  τmass_eq :
    ∀ i,
      τmass i = model.τM {s | routing.sourceLabel s = i}

  /-- Flow variable: misaligned mass from source i to active label j. -/
  x : menu.J → menu.J → ℝ
  x_nonneg : ∀ i j, 0 ≤ x i j
  x_support : ∀ i j, ¬ routing.allowed i j → x i j = 0

  /-- Source marginal: every misaligned source mass is routed. -/
  source_balance :
    ∀ i,
      ∑ j, x i j = (1 - model.α) * τmass i

  /-- Target total mass q_j. -/
  q : menu.J → ℝ
  q_eq :
    ∀ j,
      q j =
        model.α * τmass j + ∑ i, x i j

  /-- Target vector numerator n_j. -/
  n : menu.J → Profile model
  n_eq :
    ∀ j,
      n j =
        model.α • (τmass j • beliefProfile (menu.μ j)) +
          ∑ i, x i j • beliefProfile (menu.μ i)

  /-- Finite-facet cone calibration. -/
  facet_feasible :
    ∀ j (ℓ : cones.Facet j),
      dotProfile (cones.g j ℓ) (n j) ≤ cones.c j ℓ * q j

For Farkas, add an encoding, not a truthy finiteLPFeasible.

lean
  Constraint : Type
  Ray : Type
  instFintypeConstraint : Fintype Constraint
  instFintypeRay : Fintype Ray

  farkasInst : Inventory.V9.ConicFarkasInstance Constraint Ray

  /-- The above concrete flow is encoded as a primal feasible point. -/
  farkas_primal :
    Inventory.V9.conicPrimalFeasible farkasInst

  /-- Algebraic identification between the Farkas dual and finite cone-Hall dual. -/
  dual_eval_eq_finitePsi :
    ∀ Y : menu.J → Profile model,
      finiteDualEval model menu cones routing Y =
        Inventory.V9.conicDualEval farkasInst
          (encodeP3Dual model menu cones routing Y)

The dual_eval_eq_finitePsi field is acceptable only if it is a definitional algebra lemma over your concrete matrices. It must not mention PsiNonpos.

F. Positive margin

A scalar polyhedralConeMarginScalar is too lonely. Give it coordinates.

lean
structure P3ConeMargin
    (model : RobustTrustModel)
    (reg : RegPackage model)
    (menu : P3FiniteMenu model reg)
    (cones : P3BayesConeFacets model reg menu)
    (lp : P3FiniteFlowLP model reg menu cones routing) where

  ε : ℝ
  ε_pos : 0 < ε

  /-- Strict finite-facet slack, useful for numerical/robust variants. -/
  strict_slack :
    ∀ j (ℓ : cones.Facet j),
      dotProfile (cones.g j ℓ) (lp.n j) + ε * lp.q j
        ≤ cones.c j ℓ * lp.q j

This margin is not logically required for non-strict Ψ≤0 once facet_feasible is present, but it is the right structural version of “positive polyhedral cone-margin.”

Final P3Hyp
lean
structure P3Hyp (model : RobustTrustModel) where
  reg : RegPackage model

  menu : P3FiniteMenu model reg
  polyW : P3PolyhedralW model
  cones : P3BayesConeFacets model reg menu
  routing : P3RowwiseRouting model reg menu
  lp : P3FiniteFlowLP model reg menu cones routing
  margin : P3ConeMargin model reg menu cones lp

  /-- Polyhedral normal-cone theorem connects polyW to cones. -/
  cones_from_polyW :
    P3ConesAreNormalConeProjection model reg menu polyW cones

The important absence: no finiteLPFeasible : Prop, no positiveConeMargin : Prop, no polyhedralW : Prop, no PsiNonpos, no regBridge.

2. Proof skeleton for PsiNonpos_of_P3Hyp
lean
theorem PsiNonpos_of_P3Hyp
    {model : RobustTrustModel}
    (hyp : P3Hyp model) :
    PsiNonpos model hyp.reg := by
  intro y
  ...
Step 1: Reduce arbitrary Borel prices to finite prices

In the finite-atomic version:

lean
let Y : hyp.menu.J → Profile model :=
  fun j => y.toFun (hyp.menu.m j)

Then prove:

lean
have hPsi_eq :
  hyp.reg.Psi y =
    finiteConeHallPsi model hyp.menu hyp.cones hyp.routing Y := ...

This uses finite_support_exact, wstar_eq, reg_B_eq, and reg_G_eq. If the theorem is not finite-atomic, replace equality with a proved reduction inequality:

lean
have hPsi_le :
  hyp.reg.Psi y ≤
    finiteConeHallPsi model hyp.menu hyp.cones hyp.routing Y := ...

Do not store this as a bare field. Prove it from the quotient data. This is the most common place to smuggle, because reg.Psi quantifies over bounded Borel functions, while the LP is finite.

Step 2: Show finite cone-Hall dual nonpositivity

Use the concrete Farkas axiom:

lean
have hDual :
  Inventory.V9.conicDualNonpositive hyp.lp.farkasInst :=
    (Inventory.V9.farkas_lp_duality_conic hyp.lp.farkasInst).mp
      hyp.lp.farkas_primal

The structural refinement patch gives the right shape of this axiom: a finite matrix A, vector b, primal feasibility as ∃ x ≥ 0, A x = b, and dual no-separation as every dual functional nonpositive on columns is nonpositive on b. 

structural_refinement_response

Step 3: Identify Farkas dual with finite Ψ
lean
have hFinite :
  finiteConeHallPsi model hyp.menu hyp.cones hyp.routing Y ≤ 0 := by
  rw [hyp.lp.dual_eval_eq_finitePsi Y]
  exact hDual (encodeP3Dual_admissible ...)

This is the finite cone-Hall theorem. The sign must be ≤ 0: v9 explicitly corrected the sign convention, with support function

h
B
	​

(y)=
μ∈B
sup
	​

y⋅μ

and calibration equivalent to

y⋅n−h
B
	​

(y)q≤0.

v9_consolidated

Step 4: Conclude
lean
exact le_trans hPsi_le hFinite

or if finite-atomic:

lean
rw [hPsi_eq]
exact hFinite

That closes PsiNonpos. If you then want the full strategy theorem, plug this into Hall/G3. v9’s Hall biconditional says the calibrated adversarial kernel exists exactly when Ψ(y)≤0 for all bounded Borel y; the reverse direction constructs a kernel supported on rowwise minimizers and gives posterior-in-Bayes-cone calibration q-a.e. 

v9_consolidated

3. Why this is not smuggling

The refactor replaces every suspicious Prop with a concrete object.

Old field	Problem	Replacement
polyhedralW : Prop	No coordinates for normal cones.	P3PolyhedralW with finite halfspaces A h, b h, and W_eq.
finiteVertexMenu : Prop	No actual vertices, labels, or factorization of wstar.	P3FiniteMenu with finite J, w : J → Profile, m : J → M, label : M → J.
positiveConeMargin : Prop	No slack inequalities.	P3ConeMargin with ε > 0 and facet slack inequalities.
finiteLPFeasible : Prop	A theorem-shaped trapdoor.	Concrete x i j, constraints, and/or concrete ConicFarkasInstance with conicPrimalFeasible.
Hidden “Borel to finite” step	The dangerous goblin.	Finite support/quotient data plus a proved reduction from reg.Psi y to finite cone-Hall Ψ.

The review specifically says opaque Prop fields in P3Hyp and similar records are not acceptable for mergeable Lean, and that theorem conclusions must state the target rather than be carried as fields. 

decomposition_review_response

4. Irreducible external axioms
A. Inventory.V9.farkas_lp_duality_conic

Needed. This is the finite LP/conic separation hammer for G1/G4. It should have the concrete matrix form from the structural patch, not arbitrary Prop fields. 

structural_refinement_response

Citation: standard finite-dimensional Farkas lemma / strong conic LP duality.

B. Inventory.V9.clarke_product_normal_cone_projection_generic

Needed only to derive the finite-facet Bayes cone representation from the polyhedral W data, especially when the normal cone is obtained by projecting a product/active-face normal cone. It is not needed if you carry and prove cone_eq directly from Mathlib polyhedral convex analysis.

Citation: Clarke normal cone / polyhedral normal cone calculus. The v9 source already expects Clarke-Fermat and Clarke-Danskin as Inventory-level hammers because Mathlib does not expose theorem-ready Clarke generalized gradients and normal cones. 

structural_refinement_response

C. Borel Hall / Strassen-style axiom

Not needed for the finite-atomic PsiNonpos_of_P3Hyp proof. Needed only if P3 is meant to construct an actual Borel adversarial kernel or if the quotient is not finite atomic and you go through G2c. v9’s G2c requires compact/closed no-escape regularity: compact metric M, closed graph/compact-valued G, and support-continuity of B. 

v9_consolidated

D. Do not axiomatize Berge maximum theorem as ... : Prop

The review says to remove a bare berge_maximum_set_valued : Prop axiom and use Mathlib compact extreme-value lemmas for pointwise argmax/argmin where possible. 

decomposition_review_response

Lean-side theorem sequence

The clean route is:

lean
theorem P3_bayesCones_polyhedral
    (hyp : P3Hyp model) :
    P3ConesAreNormalConeProjection model ... := ...

theorem P3_finiteConeHall_dual_nonpos
    (hyp : P3Hyp model)
    (Y : hyp.menu.J → Profile model) :
    finiteConeHallPsi model hyp.menu hyp.cones hyp.routing Y ≤ 0 := ...

theorem P3_Psi_le_finiteConeHall
    (hyp : P3Hyp model)
    (y : BoundedBorelProfile model) :
    hyp.reg.Psi y ≤
      finiteConeHallPsi model hyp.menu hyp.cones hyp.routing
        (compressP3Price hyp y) := ...

theorem PsiNonpos_of_P3Hyp
    (hyp : P3Hyp model) :
    PsiNonpos model hyp.reg := by
  intro y
  exact le_trans
    (P3_Psi_le_finiteConeHall hyp y)
    (P3_finiteConeHall_dual_nonpos hyp (compressP3Price hyp y))

The finite LP becomes a little constellation of matrices and measures, not a magic scroll. That is exactly what Lean wants: no whispered “LP feasible” oracle, no regBridge, no theorem-shaped confetti.