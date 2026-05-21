
========
ROLE: user (id=baefe666-3cb4-430f-930a-4e20ddde0ef2)
========
# Reviewer pass 12 — Verify G2c (compact-closed cone-Hall)

## Role

Fresh-chat reviewer on Prover 13's G2c (compact-closed cone-Hall
extension) from prover_13_response.md. The headline claim:

- **G2 (bare standard-Borel) FAILS** by a boundary-escape counterexample.
- **G2c (compact closed M) PASSES**, and all three v8 closure-memo
  obstacles (O1 Borel→compact, O2 cell-flow lift, O3 slack discipline)
  are genuinely avoided by cone-Hall's bounded-Borel dual variables +
  global conic separation.

**Critical for the project**: in Robust Trust, $M = \operatorname{supp}\tau \subseteq \Delta(\Omega)$
is automatically compact (closed subset of the compact simplex
$\Delta(\Omega)$). So G2c applies directly to Robust Trust, giving an
**unconditional Borel cone-Hall theorem** for the actual paper setup.

## What you're verifying

**G2c Theorem statement**: For compact metric $M$, Polish $S$,
Borel $R: S \rightrightarrows M$ with closed values, Borel $B: M \rightrightarrows \Delta(\Omega)$
with closed convex values, $\alpha\in(0,1)$, $\tau\in\Delta(S)$,
$\mu_M\in\Delta(M)$:

Exists a Borel kernel $\kappa: S\to\Delta(M)$ with $\kappa(R(s)|s) = 1$
τ-a.e. and disintegration posterior $\in B(m)$ q-a.e.

**iff**

$\Psi(y) := \alpha\int_M[y(m)\cdot m - h_{B(m)}(y(m))]\,\mu_M(dm) + (1-\alpha)\int_S\inf_{m\in R(s)}[y(m)\cdot s - h_{B(m)}(y(m))]\,\tau(ds) \le 0$

for every bounded Borel $y: M \to \R^{|\Omega|}$.

## Specific checks

### 1. The compact-closed proof
Verify the conic separation argument on the primal flow polytope $T(\Pi_R)$
(transport polytope on the graph of R) vs the product cone $C$ (cone of
admissible posteriors).

### 2. Obstacles audit

- **O1 Borel→compact**: prover claims the dual variable is a global
  Borel function on M, not a compact patch. Verify.
- **O2 Cell-flow lift**: prover claims the primal is already a measure
  on Gr R (the joint), and disintegration gives the kernel directly.
  Verify (no cell-flow lift needed).
- **O3 Slack discipline**: prover claims no ε-net; separation gives
  one continuous price. Verify.

### 3. Boundary-escape counterexample
Verify the prover's counterexample to bare standard-Borel G2. Confirm
the counterexample's M is genuinely non-compact (not closed in a
compact ambient space).

### 4. Applicability to Robust Trust
**Critical**: in Robust Trust, $M = \operatorname{supp}\tau$ is a closed subset of
$\Delta(\Omega)$ (since support is always closed). $\Delta(\Omega)$ is
the compact simplex in $\R^{|\Omega|}$ (since $|\Omega|$ finite). So
$M$ is automatically compact in Robust Trust.

Therefore G2c applies UNCONDITIONALLY to Robust Trust, and there's no
boundary-escape issue for the actual setup.

Verify this claim. If correct, G2c is the **deletion-compatible Hall
duality theorem** named in v8 closure memo as the single open object.

### 5. WTA test
G2c WTA test should give the same explicit dual certificate Ψ(y) = 2/9 > 0
as G1 (since compact uniform is the simplest case). Verify.

## Verdict format

- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- If PASS: confirm this is the **deletion-compatible Hall duality
  theorem** the v8 closure memo named.
- End with next-step (P14 applies to Robust Trust Theorem 2 biconditional).

Show more

========
ROLE: assistant (id=780de31c-46b1-420a-be44-530cf6df58b4)
========
I’ll audit Prover 13’s G2c proof as a theorem-level referee pass, focusing on compactness, conic separation, obstacle avoidance, the noncompact counterexample, Robust Trust applicability, and the WTA certificate.

========
ROLE: assistant (id=a4c859e0-f84b-4753-b759-1ae65bdbae4d)
========
A key issue has surfaced: Prover 13 may be using assumptions slightly stronger than the stated G2c theorem, so I’m checking whether this is a wording patch or a real gap.

========
ROLE: assistant (id=10671bd3-c249-4178-be1d-b24632c03e2e)
========
Verdict: PATCH_BIG

Core finding: Prover 13’s actual compact-closed/continuous G2c proof is sound, but the theorem statement in this reviewer prompt is too broad. Compactness of M alone does not give the full Borel cone-Hall theorem with merely Borel R and Borel B. The proof passes only after adding the no-escape/closedness package Prover 13 actually used: compact M, closed graph/compact values for R, and enough continuity of m↦h
B(m)
	​

(a) to make the calibration cone weakly closed. Prover 13 itself distinguishes “bare standard-Borel G2: false” from “compact-closed/continuous G2: true by direct conic separation.” 

prover_13_response

So: PASS for G2c as Prover 13 actually proved it; PATCH_BIG for the prompt’s broader G2c statement and for the claimed unconditional Robust Trust application.

1. Compact-closed proof audit

The conic separation architecture is correct under the stronger compact-closed/continuous assumptions.

The proof sets up Π
R
	​

, the measures π on S×M with first marginal τ and support on GrR. Under compact M and closed GrR, Π
R
	​

 is tight, weakly closed, hence compact convex. Each π disintegrates into a Borel kernel κ supported on R(s), and the proof defines the message marginal q
π
	​

 and numerator measure n
π
	​

. 

prover_13_response

The calibration cone

C={(q,n):n≪q,dn/dq(m)∈B(m) q-a.e.}

is convex and weakly closed because the proof assumes continuity of m↦h
B(m)
	​

(a) and then tests cone membership with countably many rational a’s and nonnegative continuous ϕ’s. 

prover_13_response

Sufficiency is then the right separation argument: if no feasible π exists, separate compact K={(q
π
	​

,n
π
	​

):π∈Π
R
	​

} from closed convex C. The polar condition turns the separator into the support-function price −h
B(m)
	​

(y(m)). Minimizing over Π
R
	​

 converts the integral into ∫
S
	​

min
m∈R(s)
	​

[⋯]dτ, giving Ψ(y)>0, contradicting the dual inequality. 

prover_13_response

That proof is a clean little conic lighthouse. It is not the old finite-cell route in a new cloak.

2. The prompt’s G2c statement is too weak

The prompt states G2c with R merely Borel with closed values and B merely Borel with closed convex values. That is not what Prover 13 proved. The proof needs at least:

GrR closed,R(s) compact,m↦h
B(m)
	​

(a) continuous for each a.

Without the continuity/closed-graph package, compactness of M does not prevent all escape. For example, even with compact M={0}∪{1/n:n≥1}, one can set a Borel but discontinuous cone correspondence B(0)={1}, B(1/n)={1/n}, source s=0, and R(s)=M. No calibrated kernel exists, but bounded Borel dual prices cannot force a positive Ψ because 1/n→0 makes the obstruction vanish along the sequence. This is the same boundary-ghost phenomenon, now hiding inside B’s discontinuity rather than outside M.

So the patch is not cosmetic. It is not enough to say “M compact.” The cone field and support relation must also be closed enough for the conic separation cone to be closed.

3. Obstacles audit

O1 Borel→compact. Avoided in Prover 13’s actual G2c. The proof does not patch Borel violations by compact deletions. It separates the global flow image K=T(Π
R
	​

) from the global calibration cone C. The separating y is a global message-price function, not a compact patch. 

prover_13_response

O2 cell-flow lift. Avoided in the actual G2c. The primal object is already π∈Π
R
	​

, a measure on GrR. Once π exists, disintegration gives the Borel kernel κ. There is no averaged cell-flow object to lift back. 

prover_13_response

O3 slack discipline. Avoided in the actual G2c. No ε-net, no n(ε)ρ
ε
	​

, no slack bookkeeping. If feasibility fails, separation gives one exact price with Ψ(y)>0. 

prover_13_response

So the three v8 obstacles are genuinely avoided inside the compact-closed/continuous theorem. They are not avoided for the broader Borel-only theorem.

4. Boundary-escape counterexample

Prover 13’s bare standard-Borel counterexample is valid. It uses

S={0},τ=δ
0
	​

,M=(0,1],μ
M
	​

=0,R(0)=M,B(m)={m}.

For any bounded Borel dual y, the dual infimum can chase m↓0, so Ψ(y)≤0. But the primal cannot route to 0, because 0∈
/
M, and any positive-q message has posterior (1,0), which belongs to B(m)={m} only if m=0. Thus no feasible kernel exists. 

prover_13_response

This M=(0,1] is genuinely noncompact in the usual topology and is not closed in the compact ambient interval [0,1]. So the counterexample confirms that bare standard-Borel G2 fails by boundary escape.

5. Applicability to Robust Trust

The compactness part is correct: in Robust Trust, Ω is finite, adviser posteriors live in Δ(Ω), and M=suppτ. 

objective_statement

 Since Δ(Ω) is a finite-dimensional compact simplex and supports are closed, M is compact.

But the conclusion “therefore G2c applies unconditionally to Robust Trust” is not yet verified. Compact M handles the missing-boundary counterexample, but G2c as actually proved also needs the rowwise-minimizer graph and Bayes-cone field to have the closed/continuous structure used in the separation proof. Robust rationalizability itself requires an adversarial β
∗
 whose induced posterior makes each continuation Bayes-optimal on path; the paper’s existing existence proof only establishes this under finite M,Θ, via a finite Sion argument. 

objective_statement

So the correct project-level statement is:

G2c is the right deletion-compatible Hall theorem once the relevant Robust Trust R and B correspondences satisfy closed-graph/support-function-continuity conditions. Compactness of M=suppτ is necessary and automatically available, but not by itself sufficient for an unconditional Robust Trust Theorem 2 extension.

That is the little trapdoor in the cathedral floor.

6. WTA test

The WTA test checks out. For the full-vertex ternary WTA instance, the dual price

y
j
	​

=1−2e
j
	​


gives h
B
j
	​

	​

(y
j
	​

)=1/3. On the rowwise minimizer cone K
j
−
	​

, the integrand is 2/3−2s
j
	​

. Under uniform τ on Δ
2
, E[s
j
	​

∣s∈K
j
−
	​

]=1/9, giving per-cell integral 4/27, total 4/9, and with α=1/2,

Ψ(y)=
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

Since the corrected cone-Hall theorem requires Ψ(y)≤0, this is an explicit dual obstruction. 

prover_12_response

So WTA remains excluded in the no-baseline full-vertex test by a clean cone-Hall certificate, not by dust folklore.

Bottom line

PATCH_BIG.

Prover 13 did produce the long-sought deletion-compatible Hall duality theorem in a compact-closed/continuous form: global conic separation, Borel kernel via disintegration, no cell-flow lift, no compact patching, no slack-net bookkeeping. But the theorem in the prompt is missing the closed-graph/continuity assumptions that make the calibration cone closed. Therefore the “unconditional Robust Trust” claim does not yet follow from compactness of M alone.

Next step: P14 should specialize the actual Robust Trust R(s) and B(m) and prove the missing regularity package: closed GrR and continuity/closed graph of the Bayes-cone support function. If that passes, then the Theorem 2 biconditional can be assembled.
