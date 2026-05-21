
========
ROLE: user (id=46873cd3-33bc-4521-ae9d-ca4b608b25a5)
========
# Reviewer pass 02 — Verify Lemmas 7 and 8 (Fermat + calibration hinge)

## Role

You are an independent Reviewer for a smart-scaffolding proof project.
You are reading proofs of **Lemma 7** (Clarke Fermat → normal-cone
stationarity) and **Lemma 8** (Clarke multipliers ARE the calibration
kernel) produced by a different Prover session.

This is a **fresh chat**. You have not seen the Prover's work before.
The proofs are in durable source prover_02_response.md. Context: the
full route memo piotr_pareto_frontier_route_memo.md; the breakdown
breakdown_01_response.md; the patched Lemma 6 prover_01_response.md
+ reviewer_01_response.md.

Lemma 8 part (c) is **the load-bearing claim of the entire route** —
that the Bayes-calibration condition \(p_i\in N_W(w_i)\cap\Delta(\Omega)\)
follows automatically from Fermat stationarity, by the identity
\(p_i = g_i / q_i\) and the cone closure of \(N_W(w_i)\) under positive
rescaling. If this step is correct, finite-menu Pareto-Hall closes.

## What you are reviewing

### Lemma 7
**Statement.** \(W\) closed convex compact, \(\bar w\in W^k\) is an
ambient local maximizer of \(F_k\) over \(W^k\). Then there exists
\(g\in\partial_C F_k(\bar w)\) with \(g\in N_{W^k}(\bar w) = \prod_i N_W(w_i)\).
I.e., \(g_i\in N_W(w_i)\) for every \(i\).

### Lemma 8 (the hinge)
**Statement.** Given Lemmas 6 (patched) and 7. Let \(g\) be the normal
subgradient from Lemma 7, with multipliers \(\lambda^\pm:M\to\Delta(k)\)
from Lemma 6. Define
\(q_i := \alpha\int\lambda_i^+(s)d\tau + (1-\alpha)\int\lambda_i^-(s)d\tau\).
Then:

- (a) **Mass balance.** \(\sum_i q_i = 1\); each \(q_i\ge 0\).
- (b) **Posterior in simplex.** When \(q_i>0\), \(p_i := g_i / q_i\in\Delta(\Omega)\).
- (c) **Calibration.** \(p_i\in N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\).
- (d) **Kernel realization.** The finite-label adversarial kernel
  \(\hat\kappa(\{i\}\mid s) := \lambda_i^-(s)\) combined with the
  aligned tie-routing weights \(\lambda^+_i(s)\) generates a joint law
  whose disintegrated posterior is exactly \(p_i\), with calibration
  \(p_i\in B_W(w_i)\) τ̃-a.e.

Plus the **finite-menu Pareto-Hall calibration theorem** as the combined
conclusion.

## Specific checks

### For Lemma 7

1. **Sign convention.** Clarke's necessary condition for a minimum of
   \(f\) on \(C\) is \(0\in\partial_C f(x_0) + N_C(x_0)\). The prover
   minimizes \(-F_k\) over \(W^k\). Verify: this gives
   \(0\in\partial_C(-F_k)(\bar w) + N_{W^k}(\bar w)\), and
   \(\partial_C(-F_k) = -\partial_C F_k\) (true for locally Lipschitz).
   So \(\exists g\in\partial_C F_k\) with \(g\in N_{W^k}\). The sign is
   not negated; check the proof's bookkeeping.

2. **Product normal cone.** Verify the claim
   \(N_{W^k}(\bar w) = \prod_i N_W(w_i)\) — cite Rockafellar 1970 §16,
   or note that any normal direction to a product splits coordinate-wise.

3. **Local Lipschitz of \(F_k\).** Verify by Lemma 2 / direct argument
   (max+min of linear functionals + bounded integrand).

4. **Ambient vs frontier.** The proof should make explicit that local
   maximality is on the ambient \(W^k\), not on the frontier \((W^P)^k\).
   This depends on L3 (ambientization certificate), which is cited.

### For Lemma 8

1. **Mass balance (a).** Verify \(\sum_i \lambda^+_i(s) = 1\) and
   \(\sum_i \lambda^-_i(s) = 1\) τ-a.e. (from \(\lambda^\pm:M\to\Delta(k)\)),
   so \(\sum_i q_i = \alpha + (1-\alpha) = 1\). Trivial but check.

2. **Posterior in simplex (b).** The proof's argument:
   \(\sum_\omega g_i(\omega) = \alpha\int\lambda_i^+(s)\sum_\omega s(\omega)\,d\tau + (1-\alpha)\int\lambda_i^-(s)\sum_\omega s(\omega)\,d\tau\).
   Since \(\sum_\omega s(\omega) = 1\) (as \(s\in\Delta(\Omega)\)), this
   collapses to \(q_i\), so \(\sum_\omega [p_i]_\omega = 1\). Each
   coordinate is nonneg because \(s\ge 0\) and \(\lambda^\pm\ge 0\).
   Verify this calculation rigorously.

3. **Calibration (c).** **THE LOAD-BEARING STEP.** The argument:
   \(g_i\in N_W(w_i)\) by Lemma 7. \(N_W(w_i)\) is a convex cone.
   \(p_i = g_i / q_i\), a positive scalar multiple of \(g_i\) when
   \(q_i>0\). So \(p_i\in N_W(w_i)\). Combined with (b),
   \(p_i\in N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\) (cite L1).

   **Verify the cone closure under positive rescaling.** \(N_W(w_i)\)
   is defined as \(\{\xi: \xi\cdot(v-w_i)\le 0\,\forall v\in W\}\).
   If \(\xi\in N_W(w_i)\) and \(c > 0\), then \(c\xi\cdot(v-w_i) = c(\xi\cdot(v-w_i))\le 0\),
   so \(c\xi\in N_W(w_i)\). Trivial but central.

   **Verify the identification \(N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\).**
   This is L1 (cited without re-proving). \(B_W(w) := \{\mu\in\Delta(\Omega):w\in\arg\max_{v\in W}\mu\cdot v\}\).
   The equivalence is by supporting hyperplane theorem: \(\mu\in B_W(w)\)
   iff \(\mu\cdot v\le\mu\cdot w\,\forall v\in W\) iff \(\mu\cdot(v-w)\le 0\)
   iff \(\mu\in N_W(w)\). When \(\mu\in\Delta(\Omega)\), the equivalence
   gives \(B_W(w) = N_W(w)\cap\Delta(\Omega)\). Trivial but central.

4. **Kernel realization (d).** Verify the joint law
   \(\tilde\gamma_\alpha = \alpha\cdot(\lambda^+)_\#\tau + (1-\alpha)\cdot(\lambda^-)_\#\tau\)
   (suitably defined as Borel measure on \(M\times\{1,...,k\}\)) has
   disintegrated posterior \(p_i\). Bayes' rule on finite spaces:
   \(P(\omega\mid I=i) = P(\omega, I=i) / P(I=i)\). Compute:
   \(P(\omega, I=i) = \alpha\int s(\omega)\lambda_i^+(s) d\tau + (1-\alpha)\int s(\omega)\lambda_i^-(s) d\tau = g_i(\omega)\).
   \(P(I=i) = q_i\). So \(P(\omega\mid I=i) = g_i(\omega)/q_i = [p_i]_\omega\).

5. **Sanity check.** The proof should compute the k=2, N=2 example
   from L6's sanity check, verifying calibration holds. Check the
   computation.

6. **No hidden hypotheses.** Verify the proof does NOT silently use:
   - atomless τ;
   - generic no-tie behavior;
   - strict convexity of \(W\) or smoothness of \(W^P\);
   - any condition on \(\tau\) beyond it being a probability measure;
   - any condition on \(W\) beyond closed convex compact.

7. **Banned tool audit.** Cross-check: no product-of-narrow Sion, no
   τ-AC restriction, no FOC + envelope, no canonical/minimal pruning,
   no ε-menu-Hall as primary.

### Verdict format

State your verdict as one of:

- **PASS** — both proofs correct, route closes finite-menu Pareto-Hall.
- **PATCH_SMALL** — proofs morally correct, small fixes needed.
- **PATCH_BIG** — substantive gap requires real remediation.
- **DISPROVED** — at least one lemma is false, or a central step is
  irreparably broken.
- **HOLD** — need more information.

For non-PASS: be precise about which lemma, which step, and the fix.

## Critical sanity check

The route's BIG claim is that calibration **emerges from Lagrange
multipliers** rather than from external Hall duality. v8 has menu-Hall
as an **assumption**; this route claims calibration is a **consequence**
of finite-menu optimality. If Lemma 8(c) is correct, this is a genuine
new theorem.

Reviewer should specifically ask: **does the route's logic also apply
to the v8 sharpness witness (WTA ternary, atomless τ)?** If yes, then
the witness should have a calibrated kernel — but v8 Lemma 7 (cone
intersection) says it doesn't. Resolve the apparent contradiction. The
expected resolution: the v8 witness is **not** a finite-menu local
maximizer in the sense of Lemma 7 (it's an arbitrary menu, not an
ambient maximizer of \(F_k\)). Confirm this resolution.

## Output Contract

- Return everything inline in this chat as plain markdown.
- Be specific about line/step references.
- End with: (a) one-line verdict, (b) one-paragraph next-step signal.

## Constraints

- Banned tools list applies; check it's not snuck in.
- This is a fresh-context review; do not trust the Prover's claims
  without verifying.

Show more

========
ROLE: assistant (id=a4dad1b1-de8e-48cc-851f-c998acc341da)
========
Reviewer pass 02 — Lemmas 7 and 8
Verdict: PASS

Both Lemma 7 and Lemma 8 are correct as written, assuming the patched Lemma 6 conclusion from Reviewer pass 01. The finite-menu Pareto-Hall calibration theorem closes in payoff-label coordinates. It does not yet close the original-message lift or the compact-menu lift, and the prover correctly leaves those as downstream tasks.

Lemma 7 review — Clarke Fermat → normal-cone stationarity
1. Sign convention

The sign bookkeeping is correct. The proof converts the local maximum of F
k
	​

 over W
k
 into a local minimum of f=−F
k
	​

. Clarke Fermat gives

0∈∂
C
	​

(−F
k
	​

)(
w
ˉ
)+N
W
k
	​

(
w
ˉ
).

Since ∂
C
	​

(−F
k
	​

)(
w
ˉ
)=−∂
C
	​

F
k
	​

(
w
ˉ
), there exist g∈∂
C
	​

F
k
	​

(
w
ˉ
) and n∈N
W
k
	​

(
w
ˉ
) such that

0=−g+n.

So g=n∈N
W
k
	​

(
w
ˉ
). The proof explicitly flags that the sign is +N
W
k
	​

, not −N
W
k
	​

, and checks it against the differentiable condition ∇F
k
	​

(
w
ˉ
)⋅(
v
ˉ
−
w
ˉ
)≤0. That is the correct compass needle. 

prover_02_response

2. Product normal cone

The product normal cone proof is correct and even stronger than a citation-only argument. The prover derives directly that

g∈N
W
k
	​

(
w
ˉ
)⟺
i
∑
	​

g
i
	​

⋅(v
i
	​

−w
i
	​

)≤0∀(v
1
	​

,…,v
k
	​

)∈W
k
.

Fixing all but one coordinate gives g
i
	​

∈N
W
	​

(w
i
	​

); conversely, summing the coordinate inequalities gives the product condition. This proves

N
W
k
	​

(
w
ˉ
)=
i=1
∏
k
	​

N
W
	​

(w
i
	​

).

No hidden smoothness or regularity of W is being used here. Closed convexity is enough.

3. Local Lipschitz

The proof invokes the finite max/min structure of F
k
	​

 and the boundedness of s∈Δ(Ω). That is sufficient. The earlier breakdown also isolated local Lipschitzness as elementary: finite maxima/minima of linear maps, integrated against a probability law. 

breakdown_01_response

4. Ambient versus frontier

The proof correctly assumes ambient local maximality over W
k
, not merely local maximality on (W
P
)
k
. This is essential. The breakdown explicitly warned that frontier-local maximality alone only gives a frontier normal condition unless one proves an ambientization certificate. 

breakdown_01_response

So Lemma 7 passes.

Lemma 8 review — calibration is the multiplier
1. Dependence on patched Lemma 6

The proof uses exactly the patched Lemma 6 conclusion: for the same g∈∂
C
	​

F
k
	​

(
w
ˉ
) supplied by Lemma 7, there are Borel λ
±
:M→Δ(k) with active supports and

g
i
	​

=α∫λ
i
+
	​

(s)sdτ+(1−α)∫λ
i
−
	​

(s)sdτ.

This is important because Reviewer pass 01 found that the pointwise equality form of the Clarke sum rule at ties was too strong; the corrected proof uses the larger active-weight correspondence R(s), while preserving the final multiplier representation. 

reviewer_01_response

No downstream step in Lemma 8 re-imports the false equality-at-ties claim.

2. Mass balance

Correct. Since λ
+
(s),λ
−
(s)∈Δ(k),

i
∑
	​

λ
i
+
	​

(s)=1,
i
∑
	​

λ
i
−
	​

(s)=1

for τ-a.e. s. Therefore

i
∑
	​

q
i
	​

=α∫1dτ+(1−α)∫1dτ=1.

Each q
i
	​

≥0 because the weights are nonnegative. No atomlessness or no-tie assumption is used.

3. Posterior in the simplex

Correct. For each coordinate ω,

[g
i
	​

]
ω
	​

=α∫λ
i
+
	​

(s)s(ω)dτ+(1−α)∫λ
i
−
	​

(s)s(ω)dτ.

This is nonnegative because s(ω)≥0 and λ
i
±
	​

≥0. Summing over ω,

ω
∑
	​

[g
i
	​

]
ω
	​

=α∫λ
i
+
	​

(s)
ω
∑
	​

s(ω)dτ+(1−α)∫λ
i
−
	​

(s)
ω
∑
	​

s(ω)dτ=q
i
	​

,

because s∈Δ(Ω). Hence if q
i
	​

>0, p
i
	​

=g
i
	​

/q
i
	​

 has nonnegative coordinates summing to one. The prover also correctly notes that if q
i
	​

=0, then g
i
	​

=0, so there is no positive-mass posterior to normalize. 

prover_02_response

4. Calibration, the load-bearing hinge

This step is correct.

By Lemma 7,

g
i
	​

∈N
W
	​

(w
i
	​

).

With the normal cone convention,

g
i
	​

∈N
W
	​

(w
i
	​

)⟺g
i
	​

⋅(v−w
i
	​

)≤0∀v∈W.

If q
i
	​

>0, then p
i
	​

=g
i
	​

/q
i
	​

, so for every v∈W,

p
i
	​

⋅(v−w
i
	​

)=
q
i
	​

1
	​

g
i
	​

⋅(v−w
i
	​

)≤0.

Thus

p
i
	​

∈N
W
	​

(w
i
	​

).

Step 2 already proved p
i
	​

∈Δ(Ω). Therefore

p
i
	​

∈N
W
	​

(w
i
	​

)∩Δ(Ω).

By L1, this is exactly the Bayes cone

B
W
	​

(w
i
	​

)={μ∈Δ(Ω):w
i
	​

∈arg
v∈W
max
	​

μ⋅v}.

The cone-rescaling argument is the tiny hinge that swings the door, and the proof nails it. 

prover_02_response

5. Kernel realization

Correct in finite payoff-label coordinates. The prover defines

κ
^
({i}∣s)=λ
i
−
	​

(s)

and the joint source-label law

γ
~
	​

α
	​

(A×{i})=α∫
A
	​

λ
i
+
	​

(s)dτ+(1−α)∫
A
	​

λ
i
−
	​

(s)dτ.

This is a probability measure because the label masses sum to one. Its second marginal is q
i
	​

. The induced state-label numerator is

P(ω,I=i)=α∫λ
i
+
	​

(s)s(ω)dτ+(1−α)∫λ
i
−
	​

(s)s(ω)dτ=[g
i
	​

]
ω
	​

.

So for q
i
	​

>0,

P(ω∣I=i)=
q
i
	​

[g
i
	​

]
ω
	​

	​

=[p
i
	​

]
ω
	​

.

Combined with the calibration step, P(⋅∣I=i)∈B
W
	​

(w
i
	​

) for every positive-mass label. This proves finite-label Pareto-Hall calibration. 

prover_02_response

One precision note: this is still the payoff-label kernel. The prover correctly does not claim the original-message kernel has been constructed. The original-message lift through w
∗
:M→C
∗
 remains separate. 

breakdown_01_response

Sanity check

The k=2,N=2 computation is correct. With w
1
	​

=(1,0), w
2
	​

=(0,1), s=(p,1−p), and p∼Unif(0,1),

I
−
=∫
0
1/2
	​

(p,1−p)dp=(1/8,3/8),
I
+
=∫
1/2
1
	​

(p,1−p)dp=(3/8,1/8).

The prover’s formulas

g
1
	​

=αI
+
+(1−α)I
−
,g
2
	​

=αI
−
+(1−α)I
+

and q
1
	​

=q
2
	​

=1/2 are right. At α=1/2, both p
1
	​

,p
2
	​

 equal (1/2,1/2), which lies in both Bayes cones at the tie. For α>1/2, p
1
	​

 favors state 1 and p
2
	​

 favors state 2, matching the intended calibration picture. 

prover_02_response

Hidden-hypothesis audit

No hidden atomlessness is used. Ties are handled by λ
±
, including possible positive-measure tie sets. This is consistent with the patched Lemma 6 review, which explicitly notes that tie supports survive without atomlessness or genericity. 

reviewer_01_response

No strict convexity or smoothness of W is used. Lemma 7 needs only closed convex W; Lemma 8 needs only the cone property of N
W
	​

(w
i
	​

) and the Bayes-cone identification.

No condition on τ beyond being a probability law on posteriors is used.

No banned route is smuggled in: there is no product-of-narrow Sion, no τ-AC restriction, no FOC/envelope argument on the original strategy game, no canonical/minimal pruning, and no ε-menu-Hall primary argument. The proof is finite-dimensional Clarke-Danskin plus Fermat, as advertised.

Sharpness compatibility and the v8 witness

There is no contradiction with the v8 WTA ternary witness.

If the v8 witness were a finite ambient local maximizer of F
k
	​

 in the Lemma 7 sense, then Lemmas 7 and 8 would force calibrated finite-label posteriors. But v8’s cone-intersection/no-free-dust package says that the relevant ternary geometry cannot be repaired by null-message dust, and v8 also classifies the trust-region witness as a menu-engine artefact, not a primitive counterexample to unrestricted Theorem 2. In particular, the halfspace trust region T={μ:μ(0)≤0.4} induces the full vertex menu and is behaviorally equivalent to T=Δ(Ω); the boundary number 0.4 is representational scenery, not a load-bearing optimum. 

theorem_2_extension_proof_v8

So the expected resolution is correct: the v8 sharpness witness is not a finite-menu ambient local maximizer of the kind Lemma 7 assumes. It is an arbitrary menu-engine witness showing menu-Hall has bite, not a counterexample to this finite-stationarity theorem.

What exactly has closed

The finite-menu Pareto-Hall calibration theorem is now proven in payoff-label coordinates:

p
i
	​

=
q
i
	​

g
i
	​

	​

∈B
W
	​

(w
i
	​

)for every i with q
i
	​

>0.

This is the core calibration hinge. The remaining downstream gaps are the ones the prover correctly lists: original-message lift and compact-menu extension. 

prover_02_response

One-line verdict: PASS — Lemmas 7 and 8 are correct, and the finite-menu Pareto-Hall calibration route closes in payoff-label coordinates.

Next-step signal: Consolidate the patched Lemma 6 wording into the durable proof record, then move to the finite original-message lift under explicit representative/fiber hypotheses. Do not claim full original-game robust rationalizability until the label-to-message lift is proved; that is the next little bridge over the ravine.
