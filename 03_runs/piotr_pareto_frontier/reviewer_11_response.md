
========
ROLE: user (id=c53808e8-23a9-42ba-846f-5ca17c3c5667)
========
# Reviewer pass 11 — Verify G1 finite cone-Hall + WTA dual certificate

## Role

Fresh-chat reviewer on Prover 12's G1 finite cone-Hall theorem
(prover_12_response.md). The headline claims:

1. G1 holds with the SIGN-CORRECTED dual inequality (≤0 form).
2. For v8 WTA ternary witness with τ uniform on Δ({0,1,2}), α=1/2,
   the dual price y_j = 1 - 2e_j gives **Ψ(y) = 2/9 > 0**, an
   explicit dual certificate that excludes WTA from cone-Hall
   feasibility.
3. With positive aligned baseline, G1 yields a CONCRETE threshold
   inequality for whether WTA reopens.

## What you're verifying

### Theorem (G1, corrected): For finite S = {s_i}, M = {m_j}, weights τ_i, τ_j^M, rowwise support R(i), Bayes cones B_j, α ∈ (0,1):

Nonneg flows x_ij satisfying support+source marginal+cone calibration
exist ⟺ for every dual price vector $(y_j)_{j=1}^J \subset \R^{|Ω|}$,
\[
\Psi(y) := \alpha\sum_j\tau_j^M[y_j\!\cdot m_j - h_{B_j}(y_j)] + (1-\alpha)\sum_i\tau_i\min_{j\in R(i)}[y_j\!\cdot s_i - h_{B_j}(y_j)] \le 0.
\]

### WTA ternary computation

Verify line-by-line:
- $B_j = \{p : p_j \ge p_k\,\forall k\}$ — Bayes cone at vertex profile $v_j$.
- $K_j^- = \{s : s_j \le s_k\,\forall k\}$ — rowwise-minimizer region for $j$.
- $h_{B_j}(y_j) = \max_{p\in B_j} y_j\cdot p$.
- With $y_j = 1 - 2e_j$ (vector of all 1's except $-1$ in slot $j$):
  - $y_j\cdot \mu = 1 - 2\mu_j$ for any $\mu\in\Delta(\Omega)$.
  - $\mu_j$ minimized on $B_j$ at $\mu_0 = (1/3, 1/3, 1/3)$ (boundary
    of the cone), so $h_{B_j}(y_j) = 1 - 2/3 = 1/3$. ✓
- For $s \in K_j^-$: $y_j\cdot s - h_{B_j}(y_j) = (1 - 2s_j) - 1/3 = 2/3 - 2s_j$.
- $\E[s_j | s \in K_j^-]$ under uniform τ on the 2-simplex: $\E[\min(s_0, s_1, s_2)] = 1/9$. ✓
- $\int_{K_j^-}(2/3 - 2s_j)\,d\tau = (1/3)(2/3 - 2/9) = 4/27$. ✓
- Sum over $j = 0, 1, 2$: $\sum = 4/9$. ✓
- $\Psi(y) = (1-\alpha)\cdot 4/9 = 2/9$ at $\alpha = 1/2$. ✓
- $\Psi(y) = 2/9 > 0$, contradicts G1's ≤ 0 requirement, so WTA is
  excluded by explicit dual certificate. ✓

Verify each step. Look for arithmetic errors.

## Specific checks

### Sign convention

The theorem's dual inequality is ≤ 0, not ≥ 0 as originally stated.
Verify the prover's argument that under the support-function
convention $h_{B_j}(y) = \sup_{\mu\in B_j} y\cdot\mu$, feasibility
forces ≤ 0. Spot-check with a degenerate case (e.g., $B_j$ = all of
$\Delta(\Omega)$ → $h_{B_j}(y) = $ max coord of $y$ → constraint
trivially satisfied).

### Farkas/LP duality

Verify the LP formulation:
- Variables: $x_{ij} \ge 0$, $j \in R(i)$.
- Constraints (linearized cone via $y_j$): for every $y_j$,
  $y_j\cdot n_j \le h_{B_j}(y_j)\cdot q_j$.
- Source marginal: $\sum_j x_{ij} = (1-\alpha)\tau_i$.

The LP-dual / Farkas theorem gives feasibility iff the dual certificate
fails to certify infeasibility — i.e., $\Psi(y) \le 0$ for all $y$.

### Bayes cone of vertex profile

Critical step: verify $B_W(w^*(\mu)) \cap \Delta(\Omega)$ for $\mu$ at
vertex $v_j$ equals $\{p : p_j \ge p_k\,\forall k\}$. This is the
plurality cone in WTA. Cite paper Lemma 2 or v8 §8.

### Conditional expectation

$\E[s_j | s \in K_j^-]$ where $K_j^- = \{s : s_j = \min(s_0, s_1, s_2)\}$,
$s$ uniform on the 2-simplex. By symmetry, $\E[\min(s_0, s_1, s_2)] = ?$
- The simplex is $\{s_0 + s_1 + s_2 = 1, s_i \ge 0\}$ with uniform measure.
- $\E[s_0 + s_1 + s_2] = 1$, so $\E[s_j] = 1/3$ for each $j$.
- $\E[\min] + \E[\text{mid}] + \E[\max] = 1$.
- Standard result: for the Dirichlet(1,1,1) = uniform on 2-simplex,
  $\E[\min] = 1/9$, $\E[\text{mid}] = 2/9$ (wait, check this), $\E[\max] = 1 - 1/9 - 2/9 = 6/9 = 2/3$.
- Actually for order statistics of Dirichlet(1,1,1): $\E[X_{(k)}]$ has
  a closed form. Verify $\E[\min] = 1/9$ specifically.

(If $\E[\min] \ne 1/9$, the numerical value of $\Psi$ changes but the
qualitative conclusion that WTA fails G1 should still hold for any
$\E[\min] < 1/3$.)

### Conclusion

If everything checks out, G1 is PASS and the v8 WTA ternary witness
is excluded by an explicit dual certificate — STRONGER than FBNF-7's
hypothesis-class exclusion, because we have a concrete witness for
the obstruction.

## Verdict format

- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- End with one-line verdict + next-step (G2 Borel extension next?).

## Critical question

Does the WTA dual certificate ALSO tell us when WTA REOPENS — i.e.,
under what aligned-baseline structure $(τ_j^M, m_j)$ is the threshold
$\Psi(y) \le 0$ achievable? The prover hints at this; verify and
report the precise threshold.

## Constraints

- Banned tools list applies.
- This is a finite, computable theorem — no Borel pathology.
- Verify the WTA dual is the right test, not just some test.

Show more

========
ROLE: assistant (id=1e40c61e-1e42-4e45-bf7c-ea963043109d)
========
I’ll first verify the finite LP/Farkas sign convention, then independently recompute the ternary WTA certificate and aligned-baseline reopening threshold, watching for support-function and baseline-term pitfalls.

========
ROLE: assistant (id=17cf88c8-d160-40ca-b1bd-2c37e2b836aa)
========
The proof core is checking out after the sign flip; I’m now treating the minimax step as finite-dimensional convex separation/Fan-Sion rather than literal finite-constraint LP duality.

========
ROLE: assistant (id=476e73e4-04de-4850-b79d-93fcb2093b27)
========
Verdict: PASS

G1 is correct with the sign-corrected ≤0 dual inequality. The WTA ternary computation checks out: y
j
	​

=1−2e
j
	​

 gives Ψ(y)=2/9>0 at α=1/2 with no aligned atom at the vertex labels, so WTA is excluded by an explicit dual certificate.

There are two reviewer notes, neither fatal:

The WTA uniform-on-simplex calculation is formally the continuum analogue of finite G1. The necessity direction, which is all a positive dual certificate needs, carries over directly by integration. The full finite iff theorem itself is finite.

The baseline threshold from this one y-certificate tells when this certificate stops excluding WTA. Actual feasibility still means all G1 inequalities pass, unless one is in a symmetric vertex-baseline case where the direct posterior check matches this threshold.

1. Sign convention

The prover’s sign correction is right. With

h
B
j
	​

	​

(y)=
μ∈B
j
	​

sup
	​

y⋅μ,

cone calibration n
j
	​

/q
j
	​

∈B
j
	​

 gives

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

So feasibility forces the Hall functional to be nonpositive, not nonnegative. Prover 12 explicitly identifies this patch and states that the original ≥0 version must be replaced by ≤0. 

prover_12_response

The corrected finite statement is exactly:

α
j
∑
	​

τ
j
M
	​

[y
j
	​

⋅m
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

)]+(1−α)
i
∑
	​

τ
i
	​

j∈R(i)
min
	​

[y
j
	​

⋅s
i
	​

−h
B
j
	​

	​

(y
j
	​

)]≤0

for all price vectors y
j
	​

. 

prover_12_response

The degenerate sanity check also agrees. If B
j
	​

=Δ(Ω), then h
B
j
	​

	​

(y)=max
ω
	​

y
ω
	​

, so for every belief μ, y⋅μ−h
B
j
	​

	​

(y)≤0. Both aligned and source-min terms are therefore ≤0, so the condition is automatically satisfied, as it should be.

2. LP / conic duality

The finite proof is sound. The clean version is the support-function minimax proof:

Φ(x,y)=
j
∑
	​

[y
j
	​

⋅n
j
	​

(x)−h
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

(x)].

A flow is calibrated iff Φ(x,y)≤0 for every y. Prover 12 spells this out via the support-function characterization of closed convex sets. 

prover_12_response

The forward direction is immediate: feasible x gives Φ(x,y)≤0, and the source marginal constraints let one lower-bound each row by the rowwise minimum, yielding the corrected cone-Hall inequality. 

prover_12_response

The backward direction is also valid: rowwise minimization over X produces the displayed Hall expression; Fan-Sion then gives an x
∗
 with sup
y
	​

Φ(x
∗
,y)≤0, hence messagewise cone calibration. 

prover_12_response

The product-cone formulation is a useful cross-check:

K
j
	​

={(q,n)∈R
+
	​

×R
N
:n∈qB
j
	​

}.

Separation from ∏
j
	​

K
j
	​

 gives polar inequalities λ
j
	​

+h
B
j
	​

	​

(y
j
	​

)≤0, and choosing λ
j
	​

=−h
B
j
	​

	​

(y
j
	​

) recovers the same Hall inequality. 

prover_12_response

One typo in Prover 12: the line “Feasibility is A(X)∩K

=∅” is visually garbled in the local transcript as A(X)∩K

=∅ versus =∅, but the surrounding separation paragraph clearly means feasibility is intersection nonempty, infeasibility is separation. No mathematical damage.

3. WTA cones

The WTA cone definitions are correct. In v8, for a mixed WTA profile with support I,

K
I
−
	​

={s:s
i
	​

≤s
k
	​

 ∀i∈I,∀k},

and

B
I
	​

={p:p
i
	​

≥p
k
	​

 ∀i∈I,∀k}.

The note also records the identity s⋅w
λ
	​

=2∑
i
	​

λ
i
	​

s
i
	​

−1, which is exactly why the minimizer region is “smallest coordinate” and the Bayes cone is “largest coordinate.” 

theorem_2_extension_proof_v8

For the pure vertex label j, this gives:

B
j
	​

={p:p
j
	​

≥p
k
	​

 ∀k},K
j
−
	​

={s:s
j
	​

≤s
k
	​

 ∀k}.

So the Bayes cone and rowwise-minimizer region used in Prover 12 are the right WTA objects.

4. WTA arithmetic

All arithmetic in the certificate checks out.

For y
j
	​

=1−2e
j
	​

, the coordinates are −1 in slot j and +1 in the other two slots, so

y
j
	​

⋅μ=1−2μ
j
	​

.

On B
j
	​

, μ
j
	​

≥1/3, and the maximum of 1−2μ
j
	​

 occurs at μ
0
	​

=(1/3,1/3,1/3). Thus

h
B
j
	​

	​

(y
j
	​

)=1−
3
2
	​

=
3
1
	​

.

For s∈K
j
−
	​

,

y
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

)=(1−2s
j
	​

)−
3
1
	​

=
3
2
	​

−2s
j
	​

.

This is exactly Prover 12’s computation. 

prover_12_response

For s∼Dirichlet(1,1,1),

E[min(s
0
	​

,s
1
	​

,s
2
	​

)]=∫
0
1/3
	​

(1−3t)
2
dt=
9
1
	​

.

So

∫
K
j
−
	​

	​

(
3
2
	​

−2s
j
	​

)dτ=
3
1
	​

(
3
2
	​

−
9
2
	​

)=
27
4
	​

.

Summing over j=0,1,2 gives 4/9. Prover 12 records the same sequence. 

prover_12_response

Tiny side note: the prompt’s parenthetical “mid =2/9, max =2/3” is not correct for the Dirichlet broken-stick order statistics. The correct values are

E[min]=
9
1
	​

,E[mid]=
18
5
	​

,E[max]=
18
11
	​

.

Only E[min]=1/9 is used here, and it is correct.

5. WTA exclusion at α=1/2

With no aligned atom at the three vertex labels, τ
j
M
	​

=0, so the aligned term vanishes. At α=1/2,

Ψ(y)=(1−α)
9
4
	​

=
2
1
	​

⋅
9
4
	​

=
9
2
	​

>0.

Since G1 requires Ψ(y)≤0, this single price vector is an explicit dual certificate of infeasibility. Prover 12 states exactly this. 

prover_12_response

This is stronger than the old no-free-dust obstruction in the sense that it is a concrete separating price, not merely a dust impossibility. The v8 no-free-dust result says null-message dust cannot repair the WTA obstruction, but the current certificate prices the obstruction directly. 

theorem_2_extension_proof_v8

It also stays consistent with v8’s classification: the old halfspace witness is a menu-engine artefact, not a primitive counterexample to unrestricted Theorem 2. 

theorem_2_extension_proof_v8

6. Positive aligned baseline: exact threshold from this certificate

Prover 12’s threshold expression is correct:

Ψ(y)=α
j
∑
	​

τ
j
M
	​

[(1−2(m
j
	​

)
j
	​

)−
3
1
	​

]+(1−α)
9
4
	​

.

Equivalently,

Ψ(y)=−2α
j
∑
	​

τ
j
M
	​

((m
j
	​

)
j
	​

−
3
1
	​

)+
9
4
	​

(1−α).

Prover 12 records this same baseline-adjusted certificate. 

prover_12_response

Define the aligned “correct-coordinate surplus”

D:=
j
∑
	​

τ
j
M
	​

((m
j
	​

)
j
	​

−
3
1
	​

).

Then the certificate no longer excludes WTA exactly when

Ψ(y)≤0⟺D≥
9α
2(1−α)
	​

.

If D>0, solve for α:

α≥
2+9D
2
	​

.

So the aligned baseline must put enough mass in the right Bayes cones, in the strong quantitative sense that the average label-correct coordinate exceeds 1/3 by at least 2(1−α)/(9α).

Special cases:

If there is no aligned baseline at the vertex labels, D=0, so the inequality fails for every α<1.

If the aligned baseline is fully at the correct vertices m
j
	​

=e
j
	​

 and ∑
j
	​

τ
j
M
	​

=1, then

D=
j
∑
	​

τ
j
M
	​

(1−
3
1
	​

)=
3
2
	​

,

so the threshold is

α≥
2+9(2/3)
2
	​

=
4
1
	​

.

Thus perfect vertex-aligned baseline reopens this specific WTA obstruction exactly at α=1/4.

If the total aligned mass placed on correct vertices is b≤1, then D=2b/3, so the threshold becomes

α≥
1+3b
1
	​

.

Important nuance: Ψ(y)≤0 is the threshold for this explicit dual certificate to stop excluding WTA. In a finite G1 instance, actual feasibility is equivalent to all dual inequalities holding. In the symmetric correct-vertex baseline case, the same α≥1/4 threshold is also the direct posterior-calibration threshold, because the posterior at each label has coordinate j at least as large as the two symmetric non-j coordinates.

Final

PASS - G1 finite cone-Hall is correct with the ≤0 sign; WTA no-baseline is excluded by Ψ=2/9>0; positive aligned baseline removes this certificate exactly when D≥2(1−α)/(9α). Next step: G2 standard-Borel cone-Hall extension, with WTA as the first stress test.
