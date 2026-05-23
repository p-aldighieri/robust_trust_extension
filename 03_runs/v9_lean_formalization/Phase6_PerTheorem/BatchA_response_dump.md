
========
ROLE: user (id=82d64835-0835-4d6d-a9b8-ca8e4cf5f32b)
========
ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro (gpt-5.5-pro-xhigh).# Contextv9 formalization in v9_appendix.lean is at zero sorries with 9 paper-cited Inventory.V9 axioms. User wants every theorem audited for: (a) proper Lean ↔ English translation, (b) no smuggling/trapdoors, (c) scope/generality — Lean statement adds no extra assumptions beyond English.The v9 paper sources are in project context: v9_consolidated.md, exposition_v9.tex, exposition_v9_paper.tex (especially §B.1 for T1 block).# Batch A — T1 block (4 theorems + supporting lemmas)Audit these:1. **«T1-L6-integral-clarke-danskin-representation»** (v9_appendix.lean ~L2237)2. **«T1-L7-clarke-fermat-stationarity»** (~L2270)3. **«T1-L8-multipliers-are-calibration-kernel»** (~L2302)4. **«T1-clarke-danskin-multiplier-bayes-cone»** (~L2336, this is the headline T1)Supporting lemmas to audit briefly:- g_nonneg, q_nonneg, mass_balance, normal_cone_inequality (~L901-921)- gOf_nonneg, qOf_nonneg, mass_balance_gOf_qOf (~L319-360)- FiniteMenuData.fromParetoMenu constructor# Audit task per theoremFor EACH of the 4 headline theorems:1. **Quote the Lean signature + proof body** from v9_appendix.lean.2. **Quote the v9 paper English statement + proof** from v9_consolidated.md §B.1 / exposition_v9_paper.tex §3 (Clarke–Danskin section).3. **Translation check** — does the Lean statement faithfully capture the English claim? Note any:   - Extra hypotheses in Lean not in English (SCOPE_NARROWED).   - Weakened hypotheses in Lean (SCOPE_WEAKENED).   - Different conclusion shape (CONCLUSION_DIFFERS).   - Extra side conditions hidden in primitives (HIDDEN_ASSUMPTIONS).4. **Smuggling check** — does the Lean proof body honestly derive the conclusion, or does it project from a data-witness field / arbitrary Prop / invariant axiom shape?5. **Verdict per theorem**: PASS / SCOPE_DRIFT / SMUGGLING_FLAG / CRITICAL.# Output format
## T1-L6Lean: <quoted signature + first lines of proof>English (v9_consolidated.md §X.Y): <quoted statement + proof sketch>Translation: <PASS / drift category>Smuggling: <PASS / flag>Verdict: <PASS / SCOPE_DRIFT / SMUGGLING_FLAG>Notes: <details>## T1-L7...
End with overall batch verdict: PASS / NEEDS_FIX. Cite v9_appendix.lean line numbers.
Show more

========
ROLE: assistant (id=db1bbde5-6e34-4589-883e-7a852ae6ab5c)
========
T1-L6

Lean (v9_appendix.lean:L2237-L2248):

lean
theorem «T1-L6-integral-clarke-danskin-representation»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeDanskinRepresentation := by
  -- Unfold the goal and assemble from primitives.
  unfold FiniteMenuData.clarkeDanskinRepresentation
    IsCalibrationMultiplierKernel
  exact ⟨data.lamPlus_nonneg, data.lamMinus_nonneg,
    data.lamPlus_sum_one, data.lamMinus_sum_one,
    data.lamPlus_measurable, data.lamMinus_measurable⟩

English (exposition_v9.tex:L203-L219):

TeX
\begin{lemma}[Integral Clarke--Danskin representation]\label{lem:L6}
Every $g\in\partial_C F_k(\bar w)$ admits Borel multipliers
$\lambda^\pm:M\to\Delta(k)$ with $\suppset\lambda^\pm(s)$ in the active
max/min faces and the integral representation above.
\end{lemma}

\noindent Proof outline. Apply Clarke's integral subdifferential
interchange (Clarke 1983, \S2.7) to obtain
$\partial_C F_k(\bar w)\subseteq\int_M\partial_C\phi_s(\bar w)\,d\tau$
(Aumann integral closed in finite dimension; uniform Lipschitz
$L(s)=\|s\|_\infty\le 1$). Use the larger active-weight correspondence
$R(s)\supseteq\partial_C\phi_s(\bar w)$ rather than equality
(\emph{patched after reviewer pass~01}: equality fails on positive-measure
tie sets in general). Select a Borel measurable selector
$\xi(s)\in R(s)$ on the Borel partition $\{E_{I,J}\}$ of $M$ into
active-cell strata, apply Kuratowski--Ryll-Nardzewski to decompose
$\xi(s)$ into $\lambda^+(s)\in\Delta(I)$ and $\lambda^-(s)\in\Delta(J)$.

Translation: CONCLUSION_DIFFERS + HIDDEN_ASSUMPTIONS + SCOPE_NARROWED. The English L6 says a Clarke subgradient admits Borel multipliers supported on active max/min faces and giving the integral representation. The Lean target data.clarkeDanskinRepresentation unfolds only to IsCalibrationMultiplierKernel, whose formal content is nonnegativity, sum-one, and measurability of lamPlus and lamMinus (v9_appendix.lean:L669-L682). The formal definition explicitly suppresses active-label support, saying it is “implicit” in construction (v9_appendix.lean:L669-L673). It also does not assert the integral representation or the premise g ∈ ∂_C F_k(\bar w).

Smuggling: SMUGGLING_FLAG. The proof obtains the conclusion by projecting data.lamPlus_nonneg, data.lamMinus_nonneg, data.lamPlus_sum_one, data.lamMinus_sum_one, and measurability fields from the FiniteMenuData record. These are exactly the formal conclusion components. The local-max and Pareto-completion arguments are passed as _hLocal and _hPareto but are unused.

Verdict: CRITICAL.

Notes: This is not a Lean proof of the English Clarke-Danskin representation. It is a record-field unpacking theorem. The gap is not merely cosmetic: active-face support and the integral subgradient representation are the economic and mathematical payload of L6, but they are not present in the Lean conclusion.

T1-L7

Lean (v9_appendix.lean:L2270-L2284):

lean
theorem «T1-L7-clarke-fermat-stationarity»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeFermatStationarity := by
  -- Unfold the goal and assemble the per-label NormalConeW witness
  -- from primitive atomic fields: `w_feasible` (the feasibility leg)
  -- and `normal_cone_inequality` (the inner-product inequality leg).
  unfold FiniteMenuData.clarkeFermatStationarity ClarkeFermatAtMenu NormalConeW
  intro i
  refine ⟨data.w_feasible i, ?_⟩
  intro v hv
  exact data.normal_cone_inequality i v hv

English (exposition_v9.tex:L221-L231):

TeX
\begin{lemma}[Clarke--Fermat normal-cone stationarity]\label{lem:L7}
If $\bar w$ is an ambient local maximizer of $F_k$ on $W^k$, then there
exists $g\in\partial_C F_k(\bar w)$ with $g\in N_{W^k}(\bar w) = \prod_i N_W(w_i)$.
\end{lemma}

\noindent Proof outline. Apply Clarke's necessary condition for the
constrained minimum of $-F_k$ on $W^k$, yielding
$0\in\partial_C(-F_k)(\bar w) + N_{W^k}(\bar w)$, and use the product
normal-cone formula. The ambient (rather than frontier-only) local-max
hypothesis is essential for $N_W$-normality and is delivered by Lemma~2
of Theorem~1's proof under standard Pareto-completion.

Translation: CONCLUSION_DIFFERS + HIDDEN_ASSUMPTIONS + SCOPE_NARROWED. The English L7 has an existential stationarity statement: from an ambient local maximizer, there exists a Clarke subgradient lying in the product normal cone. The Lean theorem does not assert existence of g ∈ ∂_C F_k(\bar w). It assumes a FiniteMenuData record already containing g, w_feasible, and the per-label normal-cone inequality. The formal conclusion data.clarkeFermatStationarity is only ∀ i, NormalConeW model (data.w i) (data.g i) (v9_appendix.lean:L816-L820).

Smuggling: SMUGGLING_FLAG. The proof is a direct projection from data.normal_cone_inequality, with data.w_feasible for the feasibility leg. The hypotheses _h6, _hLocal, and _hPareto are unused. That means the theorem body does not derive Fermat stationarity from Clarke-Fermat; it consumes a field that already is the concrete normal-cone inequality.

Verdict: CRITICAL.

Notes: There is a better supporting lemma nearby: ParetoMenuPrimitives.normal_cone_inequality actually invokes Inventory.V9.clarke_fermat_normal_cone and the product normal-cone projection bridge (v9_appendix.lean:L921-L952). But the headline L7 theorem is not restricted to data produced by that route; it accepts arbitrary FiniteMenuData.

T1-L8

Lean (v9_appendix.lean:L2302-L2310):

lean
theorem «T1-L8-multipliers-are-calibration-kernel»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_h7 : data.clarkeFermatStationarity) :
    data.multipliersAreCalibrationKernel := by
  unfold FiniteMenuData.multipliersAreCalibrationKernel
    IsBorelCalibrationKernel
  exact ⟨data.g_bounded, data.q_nonneg⟩

English (exposition_v9.tex:L233-L245):

TeX
\begin{lemma}[Multipliers are the calibration kernel]\label{lem:L8}
With $g$ from Lemma~\ref{lem:L7} and $\lambda^\pm$ from Lemma~\ref{lem:L6},
the mass balance $\sum_i q_i = 1$ holds, $p_i := g_i/q_i\in\Delta(\Om)$
for $q_i>0$, and $p_i\in B_W(w_i)$.
\end{lemma}

\noindent Proof outline. \emph{Mass balance}: integrate
$\sum_i\lambda^\pm_i = 1$ against $\tau$. \emph{Posterior in simplex}:
$\sum_\omega[g_i]_\omega = \alpha\!\int\lambda^+_i\sum_\omega s(\omega)\,d\tau + (1-\alpha)\!\int\lambda^-_i\sum_\omega s(\omega)\,d\tau = q_i$
since $s\in\Delta(\Om)$; nonneg entries by $s\ge 0$ and $\lambda^\pm\ge 0$.
\emph{Calibration}: $g_i\in N_W(w_i)$ by Lemma~\ref{lem:L7};
$N_W(w_i)$ is a convex cone; positive rescaling $p_i = g_i/q_i$
preserves cone membership; intersection with $\Delta(\Om)$ gives $B_W(w_i)$.

English mechanism (exposition_v9.tex:L247-L257):

TeX
The Clarke multipliers $\lambda^\pm$ are not bookkeeping: they encode
\emph{both} the aligned tie-routing weights ... and the adversarial
tie-routing weights ... The normalization $p_i = g_i/q_i$ is the
disintegration posterior at label~$i$ ... Fermat normality of $g_i$
in $N_W(w_i)$ is therefore \emph{equivalent} to Bayes-optimality of the
disintegrated posterior at $w_i$: calibration emerges from the
finite-menu optimization itself, not from an external Hall assumption.

Translation: CONCLUSION_DIFFERS + HIDDEN_ASSUMPTIONS. The Lean conclusion data.multipliersAreCalibrationKernel unfolds to IsBorelCalibrationKernel, which is only boundedness of g plus q ≥ 0 (v9_appendix.lean:L695-L705). The English L8 conclusion is much stronger: mass balance, normalized posterior in the simplex, and Bayes-cone membership.

Smuggling: SMUGGLING_FLAG. The Lean proof returns data.g_bounded and data.q_nonneg. It does not prove mass balance, posterior normalization, or Bayes-cone calibration. It also ignores _h6 and _h7.

Verdict: CRITICAL.

Notes: The supporting algebraic lemmas do prove some real pieces: mass_balance_gOf_qOf proves ∑ω g_i(ω)=q_i for definitional gOf/qOf under integrability assumptions (v9_appendix.lean:L360-L415), and fromParetoMenu uses that to build normalized_sum_one (v9_appendix.lean:L1018-L1027). But L8 itself does not expose those facts in its conclusion.

T1-clarke-danskin-multiplier-bayes-cone

Lean (v9_appendix.lean:L2336-L2425):

lean
theorem «T1-clarke-danskin-multiplier-bayes-cone»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_h7 : data.clarkeFermatStationarity)
    (_h8 : data.multipliersAreCalibrationKernel) :
    data.multiplierBayesCone := by
  -- The proof actually constructs `p_i := g_i / q_i` as a `Belief`
  -- (using the simplex-validity primitives `normalized_nonneg` and
  -- `normalized_sum_one`), and derives Bayes-cone membership by
  -- dividing the Clarke–Fermat inner-product inequality
  -- `∑ ω, (g i ω) * (v ω - (w i) ω) ≤ 0`
  -- (primitive `normal_cone_inequality`) by `q i > 0`.
  unfold FiniteMenuData.multiplierBayesCone MultiplierInBayesCone
  intro i hqi
  classical
  -- Build the normalized belief.
  refine ⟨⟨fun ω => data.g i ω / data.q i,
    ?_, ?_⟩, ?_, ?_⟩
  · -- nonneg components of `p_i`
    exact data.normalized_nonneg i hqi
  · -- components sum to 1
    exact data.normalized_sum_one i hqi
  · -- defining equation `p.val ω = g i ω / q i`
    intro ω; rfl
  · -- `p ∈ BayesConeW model (w i)`: feasibility leg + dominance leg.
    refine ⟨data.w_feasible i, ?_⟩
    intro v hv
    -- Goal: `beliefDot p v ≤ beliefDot p (w i)` where `p ω = g i ω / q i`.
    -- Equivalent to `∑ ω, (g i ω / q i) * (v ω - (w i) ω) ≤ 0`.
    -- By the primitive `normal_cone_inequality`,
    --   `∑ ω, g i ω * (v ω - (w i) ω) ≤ 0`.
    -- Dividing by `q i > 0` (Mathlib `div_le_iff₀` / sum factoring)
    -- preserves the inequality.
    have hcone :
        (∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω)) ≤ 0 :=
      data.normal_cone_inequality i v hv
    -- Multiply both sides of `beliefDot p v ≤ beliefDot p (w i)` by `q i`
    -- to reduce to `hcone`.
    have hqi_pos : (0 : ℝ) < data.q i := hqi
    have hqi_ne : data.q i ≠ 0 := ne_of_gt hqi_pos
    -- Compute `beliefDot p v - beliefDot p (w i) = (1/q i) · hcone-sum`.
    have hsum_factor :
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * (v ω - data.w i ω))
          = (1 / data.q i)
              * ∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω) := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl ?_
      intro ω _
      field_simp
    have hquot_nonpos :
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * (v ω - data.w i ω)) ≤ 0 := by
      rw [hsum_factor]
      have h_inv_nn : 0 ≤ 1 / data.q i := by positivity
      exact mul_nonpos_of_nonneg_of_nonpos h_inv_nn hcone
    -- Translate to `beliefDot` inequality.
    show beliefDot
        (⟨fun ω => data.g i ω / data.q i,
          data.normalized_nonneg i hqi,
          data.normalized_sum_one i hqi⟩ : Belief model.Ω)
        v
      ≤ beliefDot
        (⟨fun ω => data.g i ω / data.q i,
          data.normalized_nonneg i hqi,
          data.normalized_sum_one i hqi⟩ : Belief model.Ω)
        (data.w i)
    unfold beliefDot
    -- Reduce to a single sum inequality.
    have hdiff :
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * v ω)
          -
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * data.w i ω)
          ≤ 0 := by
      rw [← Finset.sum_sub_distrib]
      have hsumform :
          (∑ ω : model.Ω,
              ((data.g i ω / data.q i) * v ω
                - (data.g i ω / data.q i) * data.w i ω))
            =
          (∑ ω : model.Ω,
              (data.g i ω / data.q i) * (v ω - data.w i ω)) := by
        refine Finset.sum_congr rfl ?_
        intro ω _; ring
      rw [hsumform]
      exact hquot_nonpos
    linarith

English theorem and proof (exposition_v9_paper.tex:L173-L207):

TeX
\begin{theorem}[Finite-menu Pareto-Hall via Clarke--Danskin]\label{thm:T1}
Let $\bar w=(w_1,\ldots,w_k)\in(W^P)^k$ be a Pareto-completed ambient local maximizer of $F_k$ over $W^k$. Then there exist Borel active-face weights
\[
  \lambda^+,\lambda^-:M\to\Delta(k)
\]
with
\[
  \suppset\lambda^+(s)\subseteq\argmax_i s\cdot w_i,
  \qquad
  \suppset\lambda^-(s)\subseteq\argmin_i s\cdot w_i
\]
for $\tau$-a.e. $s$, such that for each $i$
...
Whenever $q_i>0$,
\[
  p_i=\frac{g_i}{q_i}\in B_W(w_i).
\]
\end{theorem}

\begin{proof}
For each $s$, the integrand in \eqref{eq:Fk} is Lipschitz in $\bar w$ and has Clarke subdifferential contained in the convex hull of active max and min gradients. The integral subdifferential theorem of Clarke ..., together with the Aumann integral of a measurable multifunction ..., gives Borel weights $\lambda^\pm$ representing a Clarke subgradient $g\in\partial_C F_k(\bar w)$. Positive-measure ties are handled by simplex-valued active weights; no atomlessness is used.

Clarke--Fermat stationarity for maximizing $F_k$ on the compact convex ambient set $W^k$ yields a subgradient $g$ with $g_i\in N_W(w_i)$ for every coordinate. Since each $s$ is a probability vector, $\sum_\omega[g_i]_\omega=q_i$ and $g_i\ge0$. Thus $p_i=g_i/q_i$ lies in $\Delta(\Om)$. Because $N_W(w_i)$ is a cone, $p_i\in N_W(w_i)\cap\Delta(\Om)=B_W(w_i)$.
\end{proof}

English scoping note (v9_consolidated.md §B.1:L573): T1 is a payoff-label theorem and “not by itself a full original-message Theorem 2 result.”

Translation: SCOPE_NARROWED + CONCLUSION_DIFFERS + HIDDEN_ASSUMPTIONS. The Lean headline theorem proves only the final normalized Bayes-cone clause:
∀ i, 0 < q i → ∃ p, p = g_i/q_i ∧ p ∈ BayesConeW(w_i) (formalized as MultiplierInBayesCone, v9_appendix.lean:L707-L718). It does not prove the full English theorem: existence of Borel active-face weights, active support, the integral definitions of g_i and q_i, or the Clarke subgradient provenance. These are buried in the FiniteMenuData argument or absent from the formal conclusion.

Smuggling: SMUGGLING_FLAG, but with a real algebraic core. Unlike L6-L8, the proof does perform meaningful algebra: it builds the normalized belief and rescales the normal-cone inequality into the Bayes-cone inequality. However, the hard premises are record fields: normalized_nonneg, normalized_sum_one, w_feasible, and normal_cone_inequality. The theorem’s explicit dependencies _h6, _h7, and _h8 are not used. So the final algebra is honest, but the theorem is not chained through the named L6/L7/L8 hypotheses in Lean.

Verdict: SMUGGLING_FLAG.

Notes: If every FiniteMenuData used downstream is produced by FiniteMenuData.fromParetoMenu, then some hidden-field risk is reduced. That constructor defines g := gOf ... and q := qOf ..., fills q_nonneg via qOf_nonneg, fills normal_cone_inequality via ParetoMenuPrimitives.normal_cone_inequality, and derives normalization from mass_balance (v9_appendix.lean:L978-L1028). But the headline theorem does not require data = fromParetoMenu prim prs, so the public theorem statement still allows arbitrary data with preloaded hard fields. A theorem about arbitrary treasure chests cannot claim it mined the gold.

Supporting lemmas audit

gOf_nonneg, qOf_nonneg, mass_balance_gOf_qOf (v9_appendix.lean:L319-L415): PASS. These are honest algebraic/integral lemmas. gOf_nonneg and qOf_nonneg use α ≥ 0, α ≤ 1, and multiplier nonnegativity. mass_balance_gOf_qOf uses finite sum/integral exchange and the fact that each model.inclM s is a belief with coordinates summing to one.

g_nonneg, q_nonneg, mass_balance (v9_appendix.lean:L901-L919): PASS. These are clean wrappers around the definitional gOf/qOf lemmas for ParetoMenuPrimitives.

normal_cone_inequality (v9_appendix.lean:L921-L952): PASS modulo Inventory axioms. This one is much healthier than the L7 headline theorem. It invokes Inventory.V9.clarke_fermat_normal_cone and the product normal-cone projection bridge, then returns the concrete NormalConeW inequality. The proof relies on explicit ProductClarkeFermatPrimitive fields, not on a conclusion field named clarkeFermatStationarity.

FiniteMenuData.fromParetoMenu (v9_appendix.lean:L978-L1028): PARTIAL PASS. It constructs FiniteMenuData from ParetoMenuPrimitives, sets g and q to the definitional integrals, imports the honest normal_cone_inequality, and proves normalized nonnegativity/sum-one from the supporting lemmas. But it still copies lamPlus_nonneg, lamPlus_sum_one, lamPlus_measurable, lamMinus_*, and g_bounded from prim, and the active-face support condition is not a field of FiniteMenuData.clarkeDanskinRepresentation. The constructor is a useful safety rail, not a complete proof of the English T1 theorem.

Overall batch verdict: NEEDS_FIX

The T1 block does not currently pass a per-theorem Lean ↔ paper audit. The recurring issue is a record-field trapdoor: the Lean theorems are stated over data : FiniteMenuData model k, and FiniteMenuData already contains many of the hard facts that the English proof is supposed to derive. L6, L7, and L8 are especially fragile because their proof bodies simply project the target components from data.

The cleanest repair is to restate the headline theorem over ParetoMenuPrimitives or over an explicit data = FiniteMenuData.fromParetoMenu prim prs construction, then make L6/L7/L8 conclusions include the missing English content: active support, integral representation, mass balance, posterior-in-simplex, and Bayes-cone calibration.
