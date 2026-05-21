
========
ROLE: user (id=a164d3dd-9c1b-4a4a-9fe8-dcaa07d31969)
========
# Reviewer pass 15 — Verify G4 polyhedral LP threshold

## Role

Fresh-chat reviewer on Prover 16's G4 finite-facet polyhedral LP
threshold theorem (prover_16_response.md). Verdict from Prover 16:
**PASS** under finite-cell/tie-discipline hypotheses.

## What's being verified

For finite-action multi-state models with polyhedral $W$, the cone-Hall
dual inequality $\Psi(y) \le 0$ from G3 reduces to a finite LP
feasibility check.

### G4 Theorem statement (paraphrase)
- $|\Omega| \ge 3$, $W$ polyhedral with finitely many vertices.
- Optimal menu $C^* = \{w_1, \ldots, w_k\}$ at finitely many vertices.
- Polyhedral normal fan of $W$ partitions dual prices into finitely many
  extreme directions.
- Per-vertex piecewise-linear decomposition gives finitely many
  inequalities $a_j(y) + b_j(y) \le 0$ that suffice.
- For WTA ternary with uniform τ, α=1/2, the threshold $D \ge 2(1-\alpha)/(9\alpha)$
  emerges as expected.

## Specific checks

### 1. Polyhedral normal fan
Verify $W$ polyhedral ⇒ piecewise-constant rowwise-minimizer behavior.

### 2. Reduction to finite extreme prices
Verify the LP feasibility iff a finite collection of inequalities holds.

### 3. Per-vertex decomposition
Verify the piecewise-linear formulas for $a_j, b_j$.

### 4. WTA test
Verify WTA recovery: G4's threshold matches G1's $\Psi(y) = 2/9 > 0$.

### 5. Other applications
Verify the proof extends cleanly to plurality voting, finite-experiment
design, and ordered MLR (or at least gestures at these as concrete
examples).

### 6. Tie-discipline
Verify the finite-cell/tie-discipline hypotheses are necessary and
sufficient.

## Verdict

- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.

End with one-line + next-step.

## Constraints

- Banned tools list applies.
- The LP must be CHECKABLE: given finite (u, A, Ω, Θ, τ) inputs,
  one can decide feasibility.

Show more

========
ROLE: assistant (id=9c2e7cca-1e3b-4e67-9298-9b2e53165edd)
========
I’ll audit Prover 16 against the cone-Hall/G2/G3/G4 chain, focusing on whether finite-cell/tie assumptions truly justify a checkable finite LP. I’ll also verify the WTA arithmetic, sign conventions, examples, and whether arbitrary Borel dual prices improperly exceed finite extreme-price reductions.

========
ROLE: assistant (id=84141e7c-da0f-43b5-b063-97701d2a7bc1)
========
According to a document from 2026-05-21, verdict: PASS, with one wording caveat. G4 is correct as a finite-facet, finite-cell/tie-disciplined LP reduction of cone-Hall. It should not be read as saying “raw polyhedrality alone” proves Theorem 2; it says polyhedrality makes the cone-Hall certificate finitely checkable, and success/failure is decided by the resulting LP.

Checks

1. Polyhedral normal fan. Pass. Prover 16 correctly uses that each Bayes cone B
j
	​

 is polyhedral, so its support function h
B
j
	​

	​

 is piecewise-linear and the price space is partitioned into finitely many cone cells. The reduction to extreme rays/facets is valid because Φ
j
	​

(y)=y⋅n
j
	​

−q
j
	​

h
B
j
	​

	​

(y) is linear on each fan cell. 

prover_16_response

2. Finite extreme prices / finite LP. Pass under the finite-cell reading. The exact LP is

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

∀j,ℓ,

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

),n
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

This is the right finite-facet reduction: n
j
	​

/q
j
	​

∈B
j
	​

 iff all facet inequalities hold. 

prover_16_response

The caveat is important: this is exact for finite messages / finite quotient / finite label cells. If messages vary continuously inside a label cell, arbitrary bounded Borel prices can vary inside that cell, so full G2c is still needed unless a finite quotient or no-escape/continuous-cone hypothesis is imposed. Prover 16 states that caveat explicitly. 

prover_16_response

3. Per-vertex decomposition. Pass. Under tie discipline R(s)={j} on S
j
	​

 a.e., Ψ(y) decomposes as

Ψ(y)=
j
∑
	​

(a
j
	​

(y
j
	​

)+b
j
	​

(y
j
	​

)),

so the independent price variables reduce the check to per-label facet inequalities. The displayed LP threshold

g
jℓ
	​

⋅[αλ
j
	​

m
ˉ
j
	​

+(1−α)μ
j
	​

s
ˉ
j
	​

]≤c
jℓ
	​

[αλ
j
	​

+(1−α)μ
j
	​

]

is exactly the checkable form. 

prover_16_response

4. WTA test. Pass. For ternary WTA, Prover 16 identifies the row-minimizer cone K
j
−
	​

={s:s
j
	​

≤s
k
	​

 ∀k}, Bayes cone B
j
	​

={p:p
j
	​

≥p
k
	​

 ∀k}, and the symmetric dual price y
j
	​

=1−2e
j
	​

. The uniform-simplex computation gives the positive no-baseline certificate, so with α=1/2 this recovers the expected Ψ(y)=2/9>0 obstruction. With aligned depth D,

Ψ(y)=−2αD+(1−α)
9
4
	​

,

so the obstruction is killed iff

D≥
9α
2(1−α)
	​

.

The fraction rendering in the retrieved text is visually awkward, but the invariant inequality −2αD+(1−α)4/9≤0 is the correct one. 

prover_16_response

5. Other applications. Pass as concrete templates, not full worked examples. Plurality voting reduces to N(N−1) facet inequalities; finite-experiment / finite-menu models reduce to enumerating active vertices, normal cones, row-minimizer cells, barycenters, and solving the LP; ordered finite-action / MLR models reduce to two inequalities per active action in the typical chain/fan geometry. 

prover_16_response

6. Tie discipline. Pass with clarification. Tie discipline is necessary for the collapsed per-cell LP to be necessary and sufficient. If tie sets have positive mass, the same inequalities remain sufficient after a tie-breaking rule, but are not necessary unless the tie-breaking is part of the model. The repair is straightforward: add tie-splitting variables x
sj
	​

≥0 for j∈R(s), or impose tie discipline. 

prover_16_response

Bottom line

PASS for G4 as a finite-facet, finite-cell/tie-disciplined LP theorem. Next step: write the implementable LP template with inputs (g
jℓ
	​

,c
jℓ
	​

,λ
j
	​

,
m
ˉ
j
	​

,μ
j
	​

,
s
ˉ
j
	​

), then run the table for WTA, plurality, and one finite-experiment design.
