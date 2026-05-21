
========
ROLE: user (id=7cac55a4-5a15-41cc-8cb0-23c789d96e36)
========
# Math sanity-check chunk 3 — Hall biconditional + P2*/P3/P4 + G4 LP

## Role

Fresh-chat independent broad math review. Read consolidator_01_response.md
(durable source) and check the most technical theorem block for
soundness:

1. **G1 finite cone-Hall theorem** — Farkas/LP duality with cone-valued
   constraints. Sign convention to ≤0 form. WTA dual certificate
   $\Psi(y) = 2/9 > 0$.
2. **G2c compact-closed Borel extension** — conic separation; avoids
   v8 obstacles O1/O2/O3.
3. **G3 Robust Trust Hall biconditional** — Theorem 2 ⟺ Ψ(y) ≤ 0 under
   regularity (Reg-1) + (Reg-2).
4. **P2*/P3/P4 primitive sufficient classes** — cone-margin, polyhedral
   with cone-margin, radial symmetry.
5. **G4 finite-facet polyhedral LP threshold** — finite LP feasibility
   check.
6. **Worked examples** (WTA ternary, plurality, finite-experiment).
7. **Phase (b) verdict** — regularity not eliminable, automatic under
   smooth-frontier primitives.

## What to check

### G1 (cone-Hall LP duality)
- Farkas / LP-dual derivation: is the sign convention correct?
- Support function $h_{B_j}(y) = \sup_{\mu\in B_j} y\cdot \mu$ orientation.
- WTA computation:
  - $y_j = 1 - 2e_j$ extreme dual price.
  - $h_{B_j}(y_j) = 1/3$ at $\mu_0 = (1/3,1/3,1/3)$.
  - $\E[s_j | s\in K_j^-] = 1/9$ under uniform τ.
  - $\int_{K_j^-}(2/3 - 2s_j)d\tau = (1/3)(2/3 - 2/9) = 4/27$. Per-vertex.
  - Sum × 3 = 4/9. Times $(1-\alpha) = 1/2$: $\Psi = 2/9$.
  Verify EVERY step.

### G2c (Borel extension)
- Conic separation argument: any LP-duality gap?
- v8 obstacle avoidance: O1 (Borel→compact), O2 (cell-flow), O3 (slack
  discipline). Verify each.

### G3 (biconditional)
- Forward direction (Theorem 2 ⇒ Ψ ≤ 0).
- Reverse direction (Ψ ≤ 0 ⇒ Theorem 2).
- Regularity package (Reg-1)+(Reg-2) usage.

### P2*/P3/P4
- (P1) HOLD: WTA is a counterexample. Verify.
- (P2*) bounded-jamming cone-margin: is this a genuine primitive?
- (P3) polyhedral with cone-margin: is the cone-margin condition
  meaningful?
- (P4) radial: spherical models — does symmetry-averaging close cleanly?

### G4 (LP threshold)
- Finite-cell tie-discipline: necessary?
- WTA recovery: G4 reduces to G1's threshold $D \ge 2(1-\alpha)/(9\alpha)$.
- Plurality + finite-experiment: extrapolation correct?

### Phase (b)
- "Regularity not eliminable from standing alone" — counterexample
  argument under compact M? Or just absence of a derivation?
- "Smooth-frontier primitives": precise statement of what's needed.

## Output

- Soundness verdict for each block.
- Critical: the WTA dual computation arithmetic. If $\Psi \ne 2/9$
  for the stated dual price, everything downstream breaks.
- End with: safe to send to Piotr?

## Constraints

- Banned tools list applies.
- This is the most technical chunk. Be the most skeptical here.

Show more

========
ROLE: assistant (id=8bde2c65-5206-4761-8191-fec5f29c650b)
========
I’ll audit this as a skeptical proof referee: first pin the consolidated claims, then test cone-Hall signs and WTA arithmetic, before checking Borel/G3 regularity, primitive classes, and LP thresholds.

========
ROLE: assistant (id=e50c3e15-0810-4432-afde-f5ffa5bc46c0)
========
According to the May 21, 2026 consolidation/prover files, my verdict is: core G1–G3 is mathematically sound under the stated compact-regular hypotheses, and the WTA dual computation really gives Ψ=2/9>0 at α=1/2. But the consolidated block is not safe to send to Piotr as-is because the G4/WTA/plurality threshold formulas are internally inconsistent in the later worked-example text, and a few scope statements need tightening.

Executive verdict by block
Block	Verdict	Notes
G1 finite cone-Hall	PASS with sign convention fixed	Correct inequality is Ψ(y)≤0, not ≥0. Support-function orientation is right.
WTA arithmetic	PASS	The stated computation gives Ψ=2/9 for α=1/2. This is the bright red sanity-check, and it survives.
G2c compact-closed Borel extension	PASS under Reg/no-escape assumptions	Conic separation route is plausible and avoids old v8 O1/O2/O3. Bare standard-Borel version is false.
G3 Hall biconditional	PASS, but fixed-label only	Must state: for a fixed optimal labeling w
∗
, RR ⟺Ψ
w
∗
	​

≤0. Existence version is ∃w
∗
 satisfying the condition.
P2*/P3/P4	P2*: PATCH_SMALL; P3/P4: PASS with caveats	P2* has a displayed fraction that should be corrected. P3 is computational, not automatic. P4 works constructively, not by symmetrizing arbitrary dual prices.
G4 finite-facet LP	PASS as theorem; PATCH required in examples	LP reduction is sound under finite-cell/tie discipline. WTA/plurality thresholds have a normalization/sign inversion in some text.
Finite-experiment example	HOLD as formal example	The LP template is fine; the Doval-Smolin-style worked example is too under-sourced / contaminated to send as a theorem-quality example.
Phase (b)	PASS with wording patch	Reg is not automatic from standing alone. Compact M kills boundary escape, not label/cone jumps. Smooth-frontier primitives make Reg automatic, not Ψ≤0.
G1: finite cone-Hall LP duality

Sound. The correction to the sign is essential and correct. With

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

the calibration condition

q
j
	​

n
j
	​

	​

∈B
j
	​


is equivalent to

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

≤0∀y
j
	​

.

So the Hall inequality must be ≤0, not ≥0. The prover explicitly catches this and restates the corrected finite theorem with ≤0. 

prover_12_response

The proof structure is also okay: define the row-flow polytope X, define

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

(x)],

then use the row constraints to get the min over allowed messages in the dual expression. The forward direction is immediate; the backward direction via Fan-Sion/separation is acceptable in finite dimension, provided rows with positive mass have nonempty R(i). 

prover_12_response

Tiny caveat: In the final writeup, I would present the backward direction by finite-dimensional separation/Farkas rather than Fan-Sion over noncompact Y=R
NJ
. The Fan-Sion version is defensible, but separation is cleaner and less likely to attract reviewer gnats.

Critical WTA computation

This is the most important check. It works.

For WTA ternary:

y
j
	​

=1−2e
j
	​

,

so y
j
	​

 has coordinate −1 at j and +1 at the other two states. For

B
j
	​

={p:p
j
	​

≥p
k
	​

 ∀k},

we have

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

, the smallest possible μ
j
	​

 is 1/3, attained at μ
0
	​

=(1/3,1/3,1/3), so

h
B
j
	​

	​

(y
j
	​

)=1−2/3=1/3.

This matches the stored WTA computation. 

prover_12_response

On the rowwise minimizer cone

K
j
−
	​

={s:s
j
	​

≤s
k
	​

 ∀k},
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

)−1/3=2/3−2s
j
	​

.

For uniform τ on Δ
2
,

τ(K
j
−
	​

)=1/3,E[s
j
	​

∣K
j
−
	​

]=1/9.

Hence per vertex:

∫
K
j
−
	​

	​

(2/3−2s
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
3
1
	​

⋅
9
4
	​

=
27
4
	​

.

Sum over three vertices:

3⋅
27
4
	​

=
9
4
	​

.

At α=1/2, no aligned baseline:

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

So the user’s target arithmetic is correct. The dual certificate really violates the required Ψ≤0. The document’s WTA line also records the same components: h=1/3, τ(K
j
−
	​

)=1/3, E[s
j
	​

∣K
j
−
	​

]=1/9, per-label 4/27, total 4/9. 

prover_16_response

Patch needed: Some later worked-example snippets invert the baseline threshold. The invariant inequality is:

−2αD+(1−α)
9
4
	​

≤0.

Therefore

D≥
9α
2(1−α)
	​

.

At α=1/2, this is D≥2/9. Any occurrence of

D≥
2(1−α)
9α
	​


is wrong under the stated D=∑
j
	​

∫
A
j
	​

	​

(m
j
	​

−1/3)dτ normalization. The same file later gives the correct table value K=3:2(1−α)/(9α), so this is an internal consistency patch, not a theorem failure. 

prover_17_response

 

prover_17_response

G2c compact-closed Borel extension

Sound under the stated regularity package. The compact-closed theorem is not “standard Borel for free”; it uses exactly the right no-escape hypotheses: compact M, closed graph R, compact nonempty sections, and continuity of m↦h
B(m)
	​

(a). Under those assumptions, the feasible coupling set is compact, the calibration cone is closed, and separation gives the dual price. 

prover_13_response

The old v8 obstacles are genuinely avoided in G2c:

O1 Borel→compact non-monotonicity: avoided because the proof uses global conic separation, not compact-patch deletion.

O2 cell-flow lift gap: avoided because the primal variable is already a measure π on GrR, and disintegration gives the kernel.

O3 slack discipline: avoided because no ε-net or n(ε)ρ
ε
	​

 bookkeeping is used; failure gives an exact separating price. 

prover_13_response

Important caveat: The bare standard-Borel theorem is false. The proof record explicitly says finite partitions can chase a missing boundary point, so one needs compact closed support or equivalent no-escape regularity. 

prover_13_response

So G2c is not an unconditional Borel LP theorem. It is a compact/no-escape conic Hall theorem. That is exactly how it should be advertised.

G3 Hall biconditional

Sound, but the scope must be written precisely.

Correct statement:

For a fixed G2c-admissible optimal labeling w
∗
,σ
∗
(w
∗
) is RR⟺Ψ
w
∗
	​

(y)≤0 ∀y.

The document correctly notes this fixed-labeling scope: a robustly rationalizable optimum for some other optimal labeling does not imply the inequality for an unrelated w
∗
. 

prover_14_response

Forward direction is sound. If β
∗
 is adversarial and Bayes-rationalizing, then β
∗
 is supported on R(s) a.e. by exact rowwise minimization, and posterior membership P
β
∗
	​

(⋅∣m)∈B(m) gives the cone inequalities. This is exactly G2c necessity.

Reverse direction is sound under G2c. If Ψ≤0, G2c supplies a Borel kernel κ supported on R(s), with posterior in B(m) q-a.e.; setting β
∗
=κ makes the adversary exact, and B(m)=B
W
	​

(w
∗
(m)) gives Bayes-optimality. 

prover_14_response

The q-a.e. interpretation is correct and should stay. Since the posterior is only defined under the actual mixture message marginal, literal-all is wrong in infinite spaces. The proof also observes q=ατ+(1−α)β
#
	​

τ and q≥ατ, but the real on-path condition is q-a.e., not merely τ-a.e. 

prover_14_response

P2*/P3/P4 primitive sufficient classes
P1: HOLD

The correct conclusion is: smoothness/atomlessness alone is a regularity engine, not a Hall certificate. It may give closed R and continuous cone support functions, but it does not automatically force Ψ≤0. The pass explicitly says P1 gives the “topological half” only. 

prover_15_response

However, be careful with the phrasing “WTA is a counterexample” if P1 is stated as strictly smooth, strictly concave, unique Bayes action. WTA is a finite-action/polyhedral example, not literally a C
2
 strictly convex frontier. It is a counterexample to “regular-looking / atomless / polyhedral finite-action is enough,” not a literal disproof of a strong smooth-full-support theorem. A strong smooth theorem remains a conjectural island, not killed by WTA.

P2*: bounded-jamming cone-margin

This is a genuine sufficient class, but patch the algebra.

The idea is right: if truthful messages lie uniformly inside their Bayes cones and a rowwise-minimizer kernel spreads adversarial mass with density g=dρ/dτ≤C, then the induced posterior

p(m)=
α+(1−α)g(m)
αm+(1−α)g(m)b(m)
	​


stays near m. The correct displacement is

p(m)−m=
α+(1−α)g(m)
(1−α)g(m)
	​

(b(m)−m).

So the sufficient cone-margin condition should be

α+(1−α)C
(1−α)C
	​

diam(Δ(Ω))≤η.

If the memo has the reciprocal fraction, fix it. The conceptual theorem is sound; the displayed coefficient needs the little algebra goblin removed. The pass’s intended result is that bounded-jamming plus cone-margin constructs a feasible primal kernel, hence Ψ≤0 by G2c. 

prover_15_response

P3: polyhedral

Raw polyhedrality is not enough. This is important. Polyhedral W gives a finite computation, not automatic success. The WTA ternary example is exactly the warning: finite vertices can still fail Ψ≤0. The pass itself says P3 needs either finite-facet LP verification or the cone-margin/bounded-jamming condition. 

prover_15_response

P4: radial / antipodal

P4 is sound if proved constructively: build the antipodal/radial kernel, verify posterior calibration, then invoke G2c. Do not claim arbitrary dual prices can be symmetrized without loss; that is not generally valid. The pass itself says P4 should be proved by constructive primal calibration, not by symmetrizing arbitrary y. 

prover_15_response

G4 finite-facet polyhedral LP threshold

The theorem is sound under finite-cell/tie-free hypotheses. The LP condition is:

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

,∀j,ℓ,

with

q
j
	​

=ατ(A
j
	​

)+(1−α)τ(S
j
	​

),
n
j
	​

=α∫
A
j
	​

	​

mdτ+(1−α)∫
S
j
	​

	​

sdτ.

Equivalently,

αλ
j
	​

(g
jℓ
	​

⋅
m
ˉ
j
	​

−c
jℓ
	​

)+(1−α)μ
j
	​

(g
jℓ
	​

⋅
s
ˉ
j
	​

−c
jℓ
	​

)≤0.

The finite-facet reduction is justified by the support-function characterization of B
j
	​

, and the normal fan collapses the continuum of dual prices to finitely many facet inequalities. 

prover_16_response

Tie discipline is necessary for equivalence. If rowwise minimizers tie on positive mass, the stated per-cell LP is sufficient after fixing a tie-breaking partition but not necessary. The correct fix is to add tie-splitting variables. The G4 proof says exactly that. 

prover_16_response

WTA recovery

Correct with the threshold patch:

Ψ=−2αD+(1−α)
9
4
	​

.

So:

D≥
9α
2(1−α)
	​

.

At α=1/2:

D≥2/9.
Plurality K

The symmetric calculation should be:

misaligned contribution=
K
2
2(K−1)
	​

,
Ψ=−2αD
K
	​

+(1−α)
K
2
2(K−1)
	​

.

Therefore:

D
K
	​

≥
α
1−α
	​

⋅
K
2
K−1
	​

.

For K=3, this becomes

D
3
	​

≥
9α
2(1−α)
	​

.

The table has this correct formula, but some surrounding prose appears inverted. Patch all prose to match the table. 

prover_17_response

 

prover_17_response

Finite-experiment example

The LP template is implementable and sound. But the finite-experiment worked example is not ready as a formal example. The snippet includes a “Squarespace +1” artifact and a Doval-Smolin-style construction that has not been independently verified in the consolidation. 

prover_17_response

Recommendation: keep the WTA and plurality worked examples; either remove the finite-experiment example or label it “illustrative, needs independent source-check.”

Phase (b): regularity package

The correct verdict is not eliminable from standing alone.

The old noncompact boundary-escape counterexample does not apply to Robust Trust because M=suppτ is compact. But compactness only kills missing-boundary escape. It does not force w
∗
 to be continuous, R to have closed graph, or m↦h
B(m)
	​

(a) to be continuous. The pass gives a compact M=[0,1] label-jump example where R(s)=[0,1/2) is not closed and the Bayes-cone support function jumps. 

prover_18_response

So this is more than “absence of a derivation” for fixed-label G3. It is an explicit compact-label-jump obstruction to deriving Reg-1/Reg-2 from standing hypotheses alone.

But be precise: this does not prove a primitive model where every optimal labeling violates regularity. It proves the standing assumptions do not automatically give regularity for an arbitrary Borel optimal labeling. That is enough to justify keeping Reg in G3.

Smooth-frontier primitives should be stated as:

unique Bayes-optimal private strategy for each belief;

continuous payoff-profile selection w
∗
;

C
1
 exposed Pareto frontier W
P
;

continuous Gauss/normal map, equivalently support-function continuity of B(m).

Those primitives make Reg-1/Reg-2 automatic. They do not by themselves imply Ψ≤0. For Ψ≤0, one still needs cone-margin/bounded-jamming, radial symmetry, finite-facet LP feasibility, or another calibration mechanism. 

prover_18_response

Final patch list before sending to Piotr

Fix all WTA threshold formulas to the invariant inequality

−2αD+(1−α)4/9≤0.

With the stated D, this is

D≥2(1−α)/(9α).

Fix plurality threshold to

D
K
	​

≥
α
1−α
	​

K
2
K−1
	​

.

Patch P2* displacement coefficient to

α+(1−α)C
(1−α)C
	​

.

State G3 as fixed-label biconditional:

σ(w
∗
) RR⟺Ψ
w
∗
	​

≤0.

The existence version is:

∃w
∗
 optimal and Reg-admissible with Ψ
w
∗
	​

≤0.

Add tie-positive caveat to G4: finite LP is necessary and sufficient only with finite cells and tie discipline, or with explicit tie-splitting variables.

Downgrade finite-experiment worked example to illustrative unless independently verified.

Safe to send to Piotr?

Not safe as-is.
Safe after the patches above. The core math machinery, especially G1/G2c/G3 and the WTA Ψ=2/9 certificate, is sound. The current draft’s main danger is not the theorem spine; it is inconsistent threshold normalization and a few over-broad scope statements.
