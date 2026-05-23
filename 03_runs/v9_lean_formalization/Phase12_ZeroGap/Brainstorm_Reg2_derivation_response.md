Below is the refactor I would implement. The short rule: each class package should carry geometry, routing, stationarity, and balance data only. The regPsi_le_* field becomes a theorem. The v9 proof ledger already treats the Hall functional as the classification object: under Reg-1/Reg-2, robust rationalizability is equivalent to Ψ(y) ≤ 0 for all bounded Borel prices, and the reverse direction constructs a calibrated Borel kernel supported on rowwise minimizers. 

v9_consolidated

 The v9 dependency graph also records that P2*/P3/P4 should feed through the Hall biconditional, while Binary and FBNF use scalar B1 endpoint-fiber calibration rather than postulated menu-Hall. 

v9_consolidated

0. Common Lean pattern

Delete every field of the form:

lean
regPsi_le_X_integral : ∀ y, regPsi reg y ≤ X y

Replace it with three reusable lemmas.

lean
def localSlack (reg : RegPackage model) (y : BoundedBorelProfile model)
    (m : model.M) (p : Belief model.Ω) : ℝ :=
  beliefDot p (y.toFun m) - supportFunction model (reg.B m) (y.toFun m)

lemma localSlack_nonpos_of_mem_B
    (hp : p ∈ reg.B m) :
    localSlack reg y m p ≤ 0 := ...

lemma regPsi_le_integral_localSlack_of_kernel
    (κ : AdviserKernel model)
    (hκG : κ supported_on reg.G)
    (hpost : ∀ᵐ m ∂qκ, postκ m = p m) :
    regPsi reg y ≤ ∫ m, localSlack reg y m (p m) ∂qκ := ...

lemma regPsi_nonpos_of_calibrated_kernel
    (κ : AdviserKernel model)
    (hκG : κ supported_on reg.G)
    (hcal : ∀ᵐ m ∂qκ, postκ m ∈ reg.B m) :
    ∀ y, regPsi reg y ≤ 0 := ...

For classes with a paper-style intermediate integral, add a class-specific majorization theorem:

lean
theorem P2Star.regPsi_le_jam_minus_eta_integral
    (H : P2StarGeom model) :
    ∀ y, regPsi H.reg y ≤ H.α * ∫ m, (H.jam m - H.eta) ∂model.τM := ...

but it is a theorem, not a field.

A key Lean hygiene point: do not replace the old upper-bound fields with conclusion fields like calibratedKernelExists, capstoneConclusion, or graphEdgeIntegrand_nonpos_ae. The decomposition review flags those as vacuous “theorem-shaped trapdoors,” and asks for concrete mathematical statements instead. 

decomposition_review_response

1. P2* cone-margin plus bounded jamming
New primitives

Replace regPsi_le_jam_minus_eta_integral by:

lean
structure P2StarGeom (model : RobustTrustModel) where
  reg : RegPackage model

  eta : ℝ
  eta_pos : 0 < eta

  -- geometric cone margin
  coneMargin_ae :
    ∀ᵐ m ∂model.τM,
      Metric.closedBall (reg.messageBelief m) eta ⊆ reg.B m

  -- rowwise minimizer kernel
  κ0 : AdviserKernel model
  κ0_supported_G :
    ∀ᵐ s ∂model.τM, ∀ᵐ m ∂(κ0.kernel s), m ∈ reg.G s

  -- target marginal of κ0
  rho : Measure model.M
  rho_def :
    rho = targetMarginal model κ0
  rho_ac_tau :
    rho ≪ model.τM

  -- corrected orientation: dρ/dτ, not dτ/dρ
  C_rho : ℝ
  C_rho_nonneg : 0 ≤ C_rho
  rho_density_le :
    ∀ᵐ m ∂model.τM,
      (rho.rnDeriv model.τM m).toReal ≤ C_rho

  -- actual posterior displacement bound
  jam : model.M → ℝ
  jam_measurable : Measurable jam
  posterior_displacement_le_jam :
    ∀ᵐ m ∂messageMarginal model κ0,
      ‖posterior model κ0 m - reg.messageBelief m‖ ≤ jam m

  jam_le_eta_ae :
    ∀ᵐ m ∂messageMarginal model κ0, jam m ≤ eta

The density direction is load-bearing. The review explicitly says the proof needs the adversarial target marginal controlled relative to the truthful law, dρ/dτ, and not dτ/dρ. 

decomposition_review_response

Derived chain

Mixture posterior formula. Let ρ = τ.bind κ0. For the mixture message law

q=ατ+(1−α)ρ,

define the vector numerator

n(E)=α∫
E
	​

mdτ(m)+(1−α)∫
M
	​

∫
E
	​

sκ
0
	​

(dm∣s)dτ(s).

The posterior is dn/dq, componentwise over finite Ω.

Density cap gives jamming control. Since dρ/dτ ≤ Cρ, the adversarial component at a message cannot outweigh aligned truthful mass by more than the cap. With DΔ = diam Δ(Ω):

∥P
κ
0
	​

	​

(⋅∣m)−m∥≤
α+(1−α)g(m)
(1−α)g(m)
	​

D
Δ
	​

≤jam(m).

Cone margin absorbs jamming. If closedBall m eta ⊆ B(m) and ‖postκ(m)-m‖ ≤ jam(m) ≤ eta, then postκ(m) ∈ B(m).

Support-function inequality. If p ∈ B(m), then

y(m)⋅p−h
B(m)
	​

(y(m))≤0.

For the paper’s intermediate bound, use the sharper cone-margin estimate:

h
B(m)
	​

(y)≥y⋅m+η∥y∥
∗
	​

,y⋅p≤y⋅m+jam(m)∥y∥
∗
	​

.

If regPsi is normalized to ‖y(m)‖_*≤1, this gives:

y⋅p−h
B(m)
	​

(y)≤jam(m)−η.

Integrate.

lean
theorem P2StarGeom.regPsi_le_jam_minus_eta_integral
    (H : P2StarGeom model) :
    ∀ y, regPsi H.reg y ≤
      model.α * ∫ m, (H.jam m - H.eta) ∂model.τM := ...

The v9 P2* class is exactly described as Reg plus density/domination of rowwise traffic, cone margin, bounded jamming, and enough aligned mass. 

v9_consolidated

 The current v9 memo also describes the P2* path as keeping mixture posteriors inside Bayes cones, after which Ψ≤0 and G3 give robust rationalizability. 

v9_consolidated

Mathlib and gaps

Use Mathlib for Measure.rnDeriv, withDensity, Measure.bind, Measure.map, integral_mono_ae, integral_congr_ae, finite-dimensional Finset.sum, norm inequalities, and sSup support-function estimates.

Inventory only if you construct the posterior/disintegration rather than using the existing v8 PosteriorDisintegration. The decomposition warns not to hardcode the Radon-Nikodym orientation and to route posterior identities through the existing posterior-disintegration package. 

decomposition_review_response

2. P3 polyhedral cone-margin
New primitives

The P3 package should carry finite combinatorial geometry and LP data, not the finite equalities as fields.

lean
structure P3FiniteMenu where
  J : Type
  fintypeJ : Fintype J
  w : J → Profile model
  w_in_WP : ∀ j, w j ∈ WP model

structure P3AlignedCells where
  label : model.M → J
  A : J → Set model.M
  A_def : ∀ j, A j = {m | label m = j}
  measurable_A : ∀ j, MeasurableSet (A j)
  partition_A : IsPartition (Set.univ) A

structure P3RowwiseCells where
  S : J → Set model.M
  S_measurable : ∀ j, MeasurableSet (S j)
  S_subset_minimizers :
    ∀ᵐ s ∂model.τM, s ∈ S j → label j is rowwise_minimizer_at s
  tieSplit : Option TieSplitData

structure P3BayesConeFacets where
  L : J → Type
  fintypeL : ∀ j, Fintype (L j)
  g : ∀ j, L j → Profile model
  c : ∀ j, L j → ℝ
  facet_repr :
    ∀ j p, p ∈ B_j j ↔ ∀ ℓ, beliefDot p (g j ℓ) ≤ c j ℓ

structure P3LPData where
  q : J → ℝ
  n : J → BeliefNumerator model
  q_def :
    q j = model.α * model.τM (A j) +
          (1-model.α) * model.τM (S j)
  n_def :
    n j = model.α • ∫ m in A j, m ∂model.τM +
          (1-model.α) • ∫ s in S j, s ∂model.τM
  facet_feasible :
    ∀ j ℓ, beliefDotNumerator (n j) (g j ℓ) ≤ c j ℓ * q j

Remove:

lean
lp.regPsi_eq_finite
dual_eval_eq_finitePsi
finiteLPFeasible : Prop   -- if it is just an opaque pass/fail field
Derived chain

Derive lp.regPsi_eq_finite. Unfold regPsi, split the aligned integral over A_j and the rowwise-minimizer integral over S_j, and collapse to finite sums:

Ψ(y)=
j
∑
	​

α∫
A
j
	​

	​

[y
j
	​

⋅m−h
B
j
	​

	​

(y
j
	​

)]dτ+(1−α)
j
∑
	​

∫
S
j
	​

	​

[y
j
	​

⋅s−h
B
j
	​

	​

(y
j
	​

)]dτ.

This is pure finite-partition algebra.

Derive dual_eval_eq_finitePsi. Use the facet representation:

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

Then the finite Hall constraints are exactly:

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

LP feasibility implies posterior-in-cone. If q_j>0, set p_j=n_j/q_j. The facet inequalities give p_j∈B_j. If q_j=0, the cell contributes zero and is discharged separately.

Integrate support-function inequalities. Since p_j∈B_j,

y
j
	​

⋅n
j
	​

−h
B
j
	​

	​

(y
j
	​

)q
j
	​

≤0.

Summing over j proves regPsi≤0. If you want the exact current finite expression, define it as the finite sum of facet slacks and prove:

lean
theorem P3.regPsi_eq_finite : ...
theorem P3.regPsi_le_finiteFacetSlack : ...

The v9 P3/G4 section already states the finite-facet LP formula with q_j, n_j, and inequalities g_jℓ⋅n_j≤c_jℓ q_j, and warns that raw polyhedrality is not enough, since finite vertices can still fail the cone-Hall test. 

v9_consolidated

Mathlib and gaps

Mathlib: Finset.sum_*, Fintype, Measure.restrict, MeasurableSet.indicator, integral_finset_sum, linarith, matrices if you encode the LP matrix-style.

Genuine gap: finite conic Farkas/LP duality if you prove finite cone-Hall from the dual rather than just checking the facet inequalities. The v9 formalization brief lists Farkas/LP duality as a new Inventory axiom for G1 and G4. 

source_proof

3. P4 radial-antipodal τ-symmetry
New primitives

Replace regPsi_le_reflectionBalance_integral by:

lean
structure P4RadialGeom where
  reg : RegPackage model

  σ : model.M → model.M
  σ_measurable : Measurable σ
  σ_involutive_ae : ∀ᵐ m ∂model.τM, σ (σ m) = m
  σ_measurePreserving : MeasurePreserving σ model.τM model.τM

  reflectBelief : Belief model.Ω → Belief model.Ω
  reflect_affine_isometry : AffineIsometry reflectBelief
  message_reflection :
    ∀ᵐ m ∂model.τM, reg.messageBelief (σ m) = reflectBelief (reg.messageBelief m)

  bayesCone_reflection :
    ∀ᵐ m ∂model.τM,
      reg.B (σ m) = reflectBelief '' reg.B m

  rowwise_reflection :
    ∀ᵐ s ∂model.τM, reg.G (σ s) = σ '' reg.G s

  scalarRadialBalance : RadialBalance reg σ

reflectionBalance should be a definition:

lean
def reflectionBalance (H : P4RadialGeom) (y) (m) :=
  localSlack reg y m (p m) + localSlack reg y (H.σ m) (p (H.σ m))

not a field.

Derived chain

Construct antipodal/radial primal kernel. The adversary routes a source to the antipodal boundary point, or to the reflected endpoint on the radial line. v9 explicitly says P4 is handled constructively, not by averaging arbitrary dual prices. 

v9_consolidated

Reflection compatibility gives antisymmetry.

f
y
	​

(σm)=−f
y
	​

(m)

for the local Hall slack or the paired reflection-balance density.

Change variables. Since σ is measure-preserving:

∫f
y
	​

(σm)dτ(m)=∫f
y
	​

(m)dτ(m).

Pair cancellation.

2∫f
y
	​

dτ=∫(f
y
	​

+f
y
	​

∘σ)dτ=0.

Upper-bound theorem.

lean
theorem P4.regPsi_le_reflectionBalance_integral
    (H : P4RadialGeom) :
    ∀ y, regPsi H.reg y ≤
      ∫ m, reflectionBalance H y m ∂model.τM := ...

Final nonpositivity. The reflection integral is zero by the involution and MeasurePreserving.

Mathlib and gaps

Mathlib: MeasurePreserving, integral_map, Measure.map, integral_comp_measurable, integral_add, integral_neg, integral_congr_ae.

No major Inventory axiom is needed once the involution, preservation, and reflection compatibility are primitives. If you want to derive the radial trust ball and antipodal kernel from compact-group symmetry, that should be a separate primitive theorem, not a hidden axiom.

4. VariableMargin P2*′
New primitives

This is P2* with η pointwise.

lean
structure VariableMarginP2Geom where
  reg : RegPackage model

  eta : model.M → ℝ
  eta_measurable : Measurable eta
  eta_pos_ae : ∀ᵐ m ∂model.τM, 0 < eta m

  variableConeMargin :
    ∀ᵐ m ∂model.τM,
      Metric.closedBall (reg.messageBelief m) (eta m) ⊆ reg.B m

  κ0 : AdviserKernel model
  κ0_supported_G : ...
  rho_ac_tau : rho ≪ model.τM

  densityCapFn : model.M → ℝ
  densityCap_measurable : Measurable densityCapFn
  densityCap_nonneg_ae : ∀ᵐ m ∂model.τM, 0 ≤ densityCapFn m

  -- corrected orientation
  rho_density_le_cap :
    ∀ᵐ m ∂model.τM,
      (rho.rnDeriv model.τM m).toReal ≤ densityCapFn m

  displacement_le_cap :
    ∀ᵐ m ∂messageMarginal model κ0,
      ‖posterior model κ0 m - reg.messageBelief m‖ ≤ densityCapFn m

  cap_le_eta_ae :
    ∀ᵐ m ∂messageMarginal model κ0, densityCapFn m ≤ eta m

The decomposition explicitly says the variable-margin proof should use dρ/dτ bounded locally, not dτ/dρ. 

decomposition_review_response

Derived chain

Use the same mixture posterior calculation as P2*, but with a pointwise cap.

Prove:

∥P
κ
0
	​

	​

(⋅∣m)−m∥≤densityCapFn(m).

Use closedBall m (η m)⊆B(m) to place the posterior inside B(m).

Use the support-function margin:

y⋅p−h
B(m)
	​

(y)≤(densityCapFn(m)−η(m))∥y∥
∗
	​

.

With normalized prices:

lean
theorem VariableMargin.regPsi_le_densityCap_minus_eta_integral
    (H : VariableMarginP2Geom model) :
    ∀ y, regPsi H.reg y ≤
      model.α * ∫ m, (H.densityCapFn m - H.eta m) ∂model.τM := ...

The variable-margin pass is recorded as replacing the uniform scalar margin by a variable capacity, with the corrected density orientation g=dρ/dτ for the displacement calculation. 

prover_22_response

Mathlib and gaps

Same as P2*, plus Integrable.sub, AEStronglyMeasurable, and a pointwise a.e. radius argument. No Strassen/Farkas gap unless you construct κ0.

5. GraphFBNF finite-graph FBNF
New primitives

Remove:

lean
graphEdgeIntegrand_nonpos_ae
regPsi_le_graphEdgeIntegrand_integral

Keep or add:

lean
structure GraphFBNFGeom where
  reg : RegPackage model

  V E : Type
  fintypeV : Fintype V
  fintypeE : Fintype E

  src tgt : E → V

  edgeChart : ∀ e, EdgeInterval e → Belief model.Ω
  edgeChart_affine : ∀ e, AffineOn (edgeChart e)
  finiteBorelGraphChart : BorelGraphChart edgeChart model.τM
  quotientConsistentAtVertices : Prop

  L R : ∀ e, EdgeInterval e
  LR_order : ∀ e, L e ≤ R e

  graphPreservingTRS :
    ∀ e t, ΠT (edgeChart e t) =
      edgeChart e (clip (L e) (R e) t)

  endpointExposure :
    ∀ e endpoint, BayesConeExposureOnEdge reg e endpoint

  edgeTieDiscipline :
    ∀ e, EndpointTieSet e is τ_e-null
  -- or explicit tieSplit data

  edgewiseEndpointBalance :
    ∀ e endpoint, ScalarB1Balance e endpoint

  kirchhoffNodeBalance :
    ∀ v, sum_incident_aligned_deficit v =
         sum_incident_misaligned_surplus v

  crossEdgeDominance :
    ∀ᵐ s ∂model.τM,
      edgewise_minimizer_is_global_rowwise_minimizer reg s

The finite-graph class should be the patched P6_G, not raw “finite union of arcs”: the sharpening audit says raw arc support is too weak, and the usable class needs Borel charting, endpoint-fiber transports, Kirchhoff node balance, and cross-arc dominance. 

searcher_07_response

Derived chain

Arc-wise B1. On each edge e, identify a scalar binary subproblem with endpoint regions and source regions.

Endpoint-fiber transport. Apply Binary B1 on each edge to get kernels:

κ
e,L
	​

:S
e,+
	​

→Δ(A
e,L
	​

),κ
e,R
	​

:S
e,−
	​

→Δ(A
e,R
	​

).

Kirchhoff at shared vertices. Sum edge endpoint balances over incident edges. The node equation cancels unmatched surplus/deficit at shared vertices. This is the graph version of binary endpoint balance. The prover target states it as the new structural ingredient: at each interior vertex, the sum of aligned deficits minus misaligned surplus over incident edges is zero. 

prover_19_response

Measurable finite pasting. Since the graph is finite, paste kernels by finite if/then or Finset sums. Quotient consistency makes shared vertices well-defined.

Cross-edge dominance. Edgewise minimizers become global rowwise minimizers, so the pasted kernel is adversarial in the original game.

Define graph edge integrand. It is not a field:

lean
def graphEdgeIntegrand (H : GraphFBNFGeom) (y) (m) : ℝ := ...

Upper-bound theorem.

lean
theorem GraphFBNF.regPsi_le_graphEdgeIntegrand_integral
    (H : GraphFBNFGeom model) :
    ∀ y, regPsi H.reg y ≤
      model.α * ∫ m, graphEdgeIntegrand H y m ∂model.τM := ...

Nonpositivity lemma.

lean
theorem GraphFBNF.graphEdgeIntegrand_nonpos_ae
    (H : GraphFBNFGeom model) :
    ∀ y, ∀ᵐ m ∂model.τM, graphEdgeIntegrand H y m ≤ 0 := ...

This is derived from B1 calibration, Kirchhoff balance, and cross-edge dominance.

Mathlib and gaps

Mathlib: Finset.sum, finite incidence sums, Measure.restrict, Measure.map, Measure.compProd, Measurable.ite, finite kernel pasting, integral_finset_sum.

Inventory: Binary B1 uses Strassen/coupling and disintegration; v9 lists Strassen marginals as an expected Inventory axiom. 

source_proof

 KRN/right-inverse selectors are reused from v8.

6. FBNF F4 capstone
New primitives

Remove:

lean
fiberPsiIntegrand_nonpos_ae
regPsi_le_fiber_integral

Carry:

lean
structure FBNFGeom where
  reg : RegPackage model

  -- FBNF-1
  Z : Type
  measurableZ : MeasurableSpace Z
  standardBorelZ : StandardBorel Z
  a b : Z → ℝ
  ell : ∀ z, {t : ℝ // a z ≤ t ∧ t ≤ b z} → Belief model.Ω
  ell_affine : ∀ z, AffineOn (ell z)
  chartMeasurable : Prop
  tauBase : Measure Z
  tauFiber : Z → Measure ℝ
  disintegration : model.τM = pushForwardFoliation tauBase tauFiber ell
  quotientConsistent : Prop

  -- FBNF-2
  fiberPreservingTRS : Prop

  -- FBNF-3/F2
  endpointSupportedFiberImage : Prop

  -- FBNF-4/5
  fiberEndpointExposure : Prop
  fiberTieDiscipline : Prop
  tieSplitData : Option FiberTieSplitData

  -- FBNF-6 derived from stationarity
  localTwoSidedPerturbability : Prop

  -- FBNF-7
  globalFiberDominance :
    ∀ᵐ zt ∂tauBar,
      min_over_T_equals_min_over_own_fiber reg zt

The source is emphatic that FBNF needs a Borel affine chart or quotient consistency, not a bare cover, and that endpoint-fiber support is used rather than singleton endpoint messages. 

decomposition

Derived chain

Disintegrate τ.
Rewrite:

∫
M
	​

⋯dτ=∫
Z
	​

∫
[a
z
	​

,b
z
	​

]
	​

⋯dτ
z
	​

dλ(z).

F2 endpoint-supported fiber image. Along each affine fiber, reduce the rowwise minimization to the two endpoints. The statement should be endpoint-supported, not “the argmin set is contained in endpoints,” unless strict no-interior-flatness is added.

F3 localized stationarity. Use Clarke-Danskin/Fermat from T1 and local two-sided endpoint perturbability to derive the fiberwise balance equations:

α∫
a
z
	​

L(z)
	​

(L(z)−t)dτ
z
	​

=(1−α)∫
S
+
	​

(z)
	​

(t−L(z))dτ
z
	​

,

and the analogous right-end equation. v9 warns that without two-sided perturbability the result is only one-sided KKT, not equality. 

v9_consolidated

F1 conditional B1 and measurable pasting. Apply Binary B1 fiberwise and paste kernels over z.

F4 capstone. Use global fiber dominance to upgrade fiberwise rowwise minimizers to true global rowwise minimizers.

Define fiber integrand.

lean
def fiberPsiIntegrand (H : FBNFGeom) (y) (z : H.Z) : ℝ := ...

Upper-bound theorem.

lean
theorem FBNF.regPsi_le_fiber_integral
    (H : FBNFGeom model) :
    ∀ y, regPsi H.reg y ≤
      ∫ z, fiberPsiIntegrand H y z ∂H.tauBase := ...

Derived nonpositivity.

lean
theorem FBNF.fiberPsiIntegrand_nonpos_ae
    (H : FBNFGeom model) :
    ∀ y, ∀ᵐ z ∂H.tauBase, fiberPsiIntegrand H y z ≤ 0 := ...

The v9 FBNF conclusion states that under FBNF-1 through FBNF-5, local two-sided perturbability, and FBNF-7, the adversarial kernel has endpoint-fiber support, projected payoff image at the two endpoint labels, and q-a.e. Bayes-optimality. 

v9_consolidated

Mathlib and gaps

Mathlib: Measure.compProd, Measure.map, Measure.restrict, Fubini/Tonelli, lintegral_compProd, integral_mono_ae, finite-dimensional dot products.

Gaps: standard-Borel disintegration and measurable family of kernels should remain an explicit primitive or Inventory lemma. Binary B1 uses Strassen. F3 uses Clarke-Danskin/Fermat Inventory. The v9 source proof lists exactly these as expected Inventory axioms. 

source_proof

7. Binary B6 capstone
New primitives

Remove:

lean
binaryIntegrand_nonpos_ae
regPsi_le_binaryIntegrand_integral

Carry:

lean
structure BinaryB6Geom where
  reg : RegPackage model
  binaryStates : Fintype.card model.Ω = 2

  L R : Belief model.Ω
  L_lt_R : L < R

  -- B2
  trsIntervalReduction : TRSIntervalReduction reg L R
  -- or import paper Theorem 1 as dependency

  -- R-EE
  endpointExposure :
    BayesConeW (wL) = {L} ∧ BayesConeW (wR) = {R}

  -- R-TD or tie-splitting
  tieDiscipline : TieSetNull wL wR
  tieSplit : Option BinaryTieSplit

  -- R-IES
  interiorEndpointStationarity : 0 < L ∧ R < 1

  -- endpoint cells and source cells
  A_L A_R S_plus S_minus : Set model.M
  cells_measurable : ...

  -- B5 derived target
  endpointBalance_L :
    model.α * ∫ m in A_L, (L - m) ∂model.τM =
      (1-model.α) * ∫ s in S_plus, (s - L) ∂model.τM

  endpointBalance_R :
    model.α * ∫ m in A_R, (m - R) ∂model.τM =
      (1-model.α) * ∫ s in S_minus, (R - s) ∂model.τM

Actually, for zero-gap Lean, even endpointBalance_L/R should be derived by binary_L_B5_endpoint_stationarity_total_balance from T1 plus R-IES. If you want a two-stage proof, define a BinaryB5StationarityData carrying primitive stationarity/perturbability, and prove the balance equations as lemmas.

Derived chain

B2 interval reduction. From Theorem 1/TRS: the binary trust region is [L,R].

B3 endpoint-only projected image. Convexity/subgradient monotonicity shows any interior supporting line is dominated, for minimization, by one endpoint. This gives the projected endpoint-only image.

B5 endpoint stationarity. Apply T1/Clarke-Danskin to the two active endpoint menu and use interior stationarity to get equality balances rather than one-sided inequalities.

B1 scalar endpoint-fiber lift. The balances produce kernels:

κ
L
	​

:S
+
	​

→Δ(A
L
	​

),κ
R
	​

:S
−
	​

→Δ(A
R
	​

),

with posteriors equal to L and R q-a.e. on endpoint fibers.

B4 interior calibration. No adversarial traffic is sent to (L,R)∩M, so the posterior equals the truthful message q-a.e.

Define binary integrand.

lean
def binaryIntegrand (H : BinaryB6Geom) (y) (m) : ℝ := ...

Upper-bound theorem.

lean
theorem Binary.regPsi_le_binaryIntegrand_integral
    (H : BinaryB6Geom model) :
    ∀ y, regPsi H.reg y ≤
      model.α * ∫ m, binaryIntegrand H y m ∂model.τM := ...

Derived nonpositivity.

lean
theorem Binary.binaryIntegrand_nonpos_ae
    (H : BinaryB6Geom model) :
    ∀ y, ∀ᵐ m ∂model.τM, binaryIntegrand H y m ≤ 0 := ...

The v9 binary capstone gives exactly this route: endpoint exposure, tie discipline, and interior endpoint stationarity, with adversarial construction over endpoint fibers A_L=[0,L]∩M and A_R=[R,1]∩M, endpoint-balance equations, endpoint-fiber kernels, and truthful interior calibration. 

v9_consolidated

Mathlib and gaps

Mathlib: interval measurability, Measure.restrict, RN derivative through the posterior package, finite sums over two endpoints, linarith, integral_mono_ae.

Gaps:

Paper Theorem 1 / binary TRS interval reduction is imported, not reproved in v9’s Lean scope. The source proof says Theorem 1 is deferred/out of scope and imported via its Lemma 2 dependency. 

source_proof

B1 endpoint-fiber lift uses Strassen/coupling and disintegration.

B5 uses Clarke-Danskin/Fermat Inventory.

Lean implementation order

The proof queue should be:

Common support-function and posterior lemmas.

lean
localSlack_nonpos_of_mem_B
regPsi_le_integral_localSlack_of_kernel
regPsi_nonpos_of_calibrated_kernel

Binary B1/B3/B5/B6. Binary is the scalar engine.

FBNF F1/F2/F3/F4. Use Binary B1 fiberwise.

GraphFBNF. Use Binary B1 edgewise plus finite graph pasting and Kirchhoff.

P2 and VariableMargin.* Use posterior displacement plus cone margin.

P3. Prove finite reduction and LP/Farkas equivalence.

P4. Construct the antipodal kernel or prove reflection cancellation.

This mirrors the v9 dependency graph: Binary uses interval reduction, endpoint-only image, stationarity, B1, and capstone; FBNF uses endpoint-supported fiber image, localized stationarity, conditional B1 plus pasting, and capstone; Hall/G2c/G3 then feeds P2*/P3/P4/G4. 

v9_consolidated

Inventory axioms: keep them narrow

Use Inventory only for real external hammers:

Gap	Use
Inventory.clarke_danskin_stationarity	T1 finite-menu calibration, Binary B5, FBNF F3
Inventory.clarke_fermat_normal_cone	Stationarity to normal-cone/Bayes-cone calibration
Inventory.strassen_marginals	Binary B1, FBNF F1, GraphFBNF edge transports
Inventory.farkas_lp_duality_conic	P3/G4 finite cone-Hall LP

Do not axiomatize Berge as a vague theorem returning Prop; the review says compact argmax/min existence should be derived from Mathlib’s compact extreme-value lemmas, reserving KRN only for genuine measurable selection. 

decomposition_review_response

 Also do not derive Reg-1/Reg-2 from standing assumptions: v9 records that compactness of M does not force continuity of w*, closed graph of G, or support-continuity of Bayes cones. 

v9_consolidated

The final Lean end-state is:

lean
-- no P-class contains:
regPsi_le_X_integral : ...

-- instead:
theorem P2StarGeom.regPsi_le_jam_minus_eta_integral : ...
theorem P3Geom.regPsi_eq_finite : ...
theorem P3Geom.dual_eval_eq_finitePsi : ...
theorem P4RadialGeom.regPsi_le_reflectionBalance_integral : ...
theorem VariableMarginP2Geom.regPsi_le_densityCap_minus_eta_integral : ...
theorem GraphFBNFGeom.regPsi_le_graphEdgeIntegrand_integral : ...
theorem FBNFGeom.regPsi_le_fiber_integral : ...
theorem BinaryB6Geom.regPsi_le_binaryIntegrand_integral : ...

That gives the zero-gap direction the user directive wants: every class-specific upper bound becomes a derived lemma from geometry, routing, and balance, with the remaining non-Mathlib pieces fenced as small, named Inventory axioms rather than hidden “bound fields.”