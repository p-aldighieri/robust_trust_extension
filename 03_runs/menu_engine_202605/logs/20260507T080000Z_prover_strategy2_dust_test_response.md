
========
ROLE: user (id=b250dfca-b5ed-4cde-a327-859d1692cedd)
========
# Prover pass — Strategy 2 sharp test on the v7 ternary witness

You are the **Prover** in the soft-scaffolding workflow. This is a **single focused test** of the most actionable post-formalizer strategy. The result determines whether Strategy 2 (null-message dust) is alive or dead, and whether the v7 ternary witness is a true obstruction or merely a witness inside the menu engine.

## The setting (verbatim from v7's sharpness witness)

- $\Om = \{0,1,2\}$, $\mu_0 = (1/3, 1/3, 1/3)$.
- $A = \{a_0, a_1, a_2\}$ with payoff $u(a_\omega, \omega) = 1$ and $u(a_i, \omega) = -1$ for $i \ne \omega$.
- $\tau$ atomless full-support on $\Delta(\Om)$.
- Trust region $T = \{\mu \in \Delta(\Om) : \mu(0) \le 0.4\}$, non-radial.
- Aligned-best label $\hat\sigma^*(m) = $ plurality vertex of $P_T(m)$.
- Boundary message $t_0 = (0.4, 0.3, 0.3)$ with $\hat\sigma^*(t_0) = a_0$, payoff profile $v_0$.
- Rowwise minimizers $R(t_0) = \{v_1, v_2\}$.
- Bayes cone $B(t_0) = \{p : p_0 \ge p_1, p_0 \ge p_2\}$.
- Source cone $K_0^- = \{s : s_0 \le s_1, s_0 \le s_2\}$.
- The v7 obstruction: $K_0^- \cap B(t_0) = \{(1/3, 1/3, 1/3)\}$, atomless $\tau \Rightarrow$ no positive q-mass calibration possible at $t_0$.

## The test

Strategy 2 says: place adversary-only payoff profiles on a Borel $\tau$-null set $N \subseteq M$, decoupling the aligned labeling from the adversarial labeling. Determine whether this **repairs** the obstruction at $t_0$, or whether a **no-free-dust** lemma holds.

### Step 1 — Try to construct dust that repairs the witness.

Look for a Borel $\tau$-null $N \subseteq M$, a labeling $w_N : N \to W$, and an adversarial kernel $\kappa(\cdot \mid s)$ supported on $G(s) := \{m : s \cdot w(m) = \min_{C^\dagger} s \cdot w\}$ where the labeling now extends $w^*$ on the original support and $w_N$ on the dust, such that:

- the menu engine's optimality is preserved (dust does not change the aligned payoff because $\tau(N) = 0$);
- the adversary uses dust messages with positive q-probability ($q_\beta(N) > 0$ via $\int \kappa(N \mid s) \tau(ds) > 0$);
- at every dust message $m \in N$ used with positive q-probability, the conditional source barycenter $\E_{q_\beta}[s \mid m]$ lies in $B(w_N(m))$.

Be concrete. If a construction exists, exhibit it explicitly: which messages, which labels, which kernel, which Bayes cones, and verify the calibration inequalities.

### Step 2 — If Step 1 fails, prove a no-free-dust lemma.

The natural form of the lemma:

> **No-free-dust (proposed).** For the v7 ternary winner-takes-all witness with non-radial $T$ and atomless $\tau$, no Borel $\tau$-null labeling $w_N : N \to W$ and no adversarial kernel $\kappa$ can satisfy simultaneously: (a) rowwise-minimizer support, (b) positive $q$-mass on $N$, (c) Bayes-cone calibration at every dust message used.

The proof should isolate WHY the obstruction is not relocated by null-set decoupling. Candidate lever: for every payoff profile $v \in W$, the source cone $K_v^- := \{s : v \in R(s)\}$ has barycenter $\bar s \in K_v^-$ that is **separated** from the Bayes cone $B(v)$ in the sense that $K_v^- \cap B(v) \ne \emptyset$ only at degenerate points (e.g., the uniform prior). If this separation is uniform across all admissible $v$, no dust can rescue calibration in winner-takes-all ternary.

Be explicit: state the cones, compute their intersections, show separation, and exhibit the resulting barycenter inequality that no calibration can satisfy.

### Step 3 — If a no-free-dust lemma holds in this witness, classify the witness.

Three possibilities, choose the right one with justification:

(a) **Witness is purely a menu-engine artefact.** Strategy 3 (constrained-persuasion transport) or Strategy 5 (trust-region geometry) might still escape it.

(b) **Witness reveals a structural calibration obstruction in winner-takes-all ternary**, but the trust region $T = \{\mu : \mu(0) \le 0.4\}$ is not a primitive trust region (i.e., not arising from any sensible robust optimization with the given $u$). In that case, the witness is real but does not falsify Theorem 2 unrestricted.

(c) **Witness reveals a structural obstruction realizable as a primitive optimal trust region.** In that case, the original Theorem 2 (for $|\Om| \ge 3$ with non-radial $T$) does **not** generalize from the finite case without additional structural hypotheses, regardless of route choice. This would be a genuine counterexample to the unrestricted infinite extension — a definitive negative result.

To distinguish (b) from (c), check whether $T = \{\mu : \mu(0) \le 0.4\}$ can arise as the optimal trust region under standing primitives (some choice of $\alpha$, $\tau$, $\Theta$, $f$, $u$, $A$) in the v7 witness setup. If yes, (c). If no, (b).

## What you MUST do

- Pick one outcome: (Step 1 success), (Step 2 success → Step 3 (a/b/c)), or honest stall with named obstacle.
- Be concrete with cones, barycenters, and inequalities. No hand-waving.
- If the construction succeeds, verify it. If the lemma holds, prove it. If neither works in this pass, name the precise step that blocks.

## What you MUST NOT do

- Do not pivot to a different strategy mid-pass.
- Do not declare the project complete or terminal.
- Do not invoke menu-Hall as if it were a standing hypothesis — the whole point is to determine whether dust escapes it.

## Output Format


markdown
## Verdict
PROVED / DISPROVED / STALLED

## Outcome
Step 1 succeeded / Step 2 succeeded / Step 3 (a/b/c) / honest stall

## Construction or Proof

(If Step 1: explicit dust construction with verification.
If Step 2: no-free-dust lemma with proof.
If Step 3: classification with justification.
If stalled: named obstacle and what would unblock it.)

## Implication for the Project

(One paragraph. What does this tell us about whether the original infinite Theorem 2 has a non-narrowed proof?)


Length: 1500–2200 words.

## Reference

The v7 sharpness witness is in theorem_2_extension_proof_v7.md (durable source). The formalizer reread (q_β-a.e. semantics, adversary atoms on τ-null messages allowed) is in logs/20260507T060000Z_formalizer_reread_def2_response.md if needed for reference. The searcher's ranking and the calibration-invariant remark are in logs/20260507T070000Z_searcher_post_formalizer_response.md.

Show more

========
ROLE: assistant (id=a3221c1d-2422-4191-9a94-c65705c33e8f)
========
Verdict

PROVED

Outcome

Step 2 succeeded → Step 3(b). Strategy 2, null-message dust, is dead for the v7 ternary witness.

Construction or Proof

I use the v7 menu-engine framing and the paper’s payoff-profile reduction: the relevant object is the finite-dimensional payoff-profile set W, and robust rationalizability requires a rowwise-minimizing adversarial kernel plus Bayes-cone calibration on the messages that are actually used. 

theorem_2_extension_proof_v7

 The finite-paper Theorem 2 obtains that calibration from a finite saddle point; v7 isolates it as the menu-Hall condition in the infinite case. 

Robust_trust_Dworczak_Smolin

For the winner-takes-all ternary problem,

v
0
	​

=(1,−1,−1),v
1
	​

=(−1,1,−1),v
2
	​

=(−1,−1,1),

and every payoff profile in W is a unique mixture

w
λ
	​

=λ
0
	​

v
0
	​

+λ
1
	​

v
1
	​

+λ
2
	​

v
2
	​

,λ∈Δ({0,1,2}).

Equivalently,

s⋅w
λ
	​

=2
i
∑
	​

λ
i
	​

s
i
	​

−1.

The original v7 labeling on the full-support message space already uses all three pure labels, so the menu contains {v
0
	​

,v
1
	​

,v
2
	​

}. Adding dust profiles w
λ
	​

∈W cannot create a new strictly lower rowwise value without lowering the adversarial payoff and destroying the original menu optimality. Thus any dust profile used by a rowwise-minimizing adversary must tie the existing vertex minimum.

Let

I(λ):={i:λ
i
	​

>0}.

A profile w
λ
	​

 is a rowwise minimizer at source s iff

i
∑
	​

λ
i
	​

s
i
	​

=
j
min
	​

s
j
	​

.

Since this is a convex average of the coordinates s
i
	​

, equality holds iff every coordinate in the support of λ is minimal. Thus the source cone for w
λ
	​

 is

K
I
−
	​

={s∈Δ(Ω):s
i
	​

≤s
k
	​

 for every i∈I, k∈{0,1,2}}.

This includes equality among all supported coordinates. For example,

K
{0}
−
	​

={s:s
0
	​

≤s
1
	​

, s
0
	​

≤s
2
	​

},

which is the v7 cone K
0
−
	​

. For an edge mixture, say I={1,2},

K
{1,2}
−
	​

={s:s
1
	​

=s
2
	​

≤s
0
	​

}.

The Bayes cone for w
λ
	​

 points in the opposite direction. A mixed action with support I is Bayes-optimal at posterior p iff every action in I is a plurality maximizer:

B
I
	​

={p∈Δ(Ω):p
i
	​

≥p
k
	​

 for every i∈I, k∈{0,1,2}},

again with equality among supported coordinates. For the v7 boundary message t
0
	​

, the label is v
0
	​

, so

B(t
0
	​

)=B
{0}
	​

={p:p
0
	​

≥p
1
	​

, p
0
	​

≥p
2
	​

}.

Now comes the whole lock-click.

Cone intersection lemma. For every nonempty support I⊆{0,1,2}, if a probability measure ρ on Δ(Ω) is supported on K
I
−
	​

, and its barycenter

s
ˉ
:=∫sdρ(s)

lies in B
I
	​

, then ρ=δ
μ
0
	​

	​

, where

μ
0
	​

=(1/3,1/3,1/3).

Proof: choose any i∈I. Since ρ is supported on K
I
−
	​

,

s
k
	​

−s
i
	​

≥0ρ-a.s. for every k.

Since 
s
ˉ
∈B
I
	​

,

s
ˉ
i
	​

≥
s
ˉ
k
	​

for every k,

so

∫(s
k
	​

−s
i
	​

)dρ(s)=
s
ˉ
k
	​

−
s
ˉ
i
	​

≤0.

A nonnegative random variable with nonpositive expectation is zero a.s. Hence s
k
	​

=s
i
	​

 ρ-a.s. for every k. Since the coordinates sum to one, s=(1/3,1/3,1/3) ρ-a.s. This proves the lemma.

The v7 obstruction is the special case I={0}:

K
0
−
	​

∩B
0
	​

={(1/3,1/3,1/3)},

but the lemma is stronger: it kills pure dust, edge-mixture dust, and full-mixture dust. The dust has nowhere to hide. It cannot average its way from “i is a minimum” to “i is a maximum” unless every coordinate is tied pointwise.

Now suppose, toward contradiction, that Strategy 2 succeeds. Let N⊆M be Borel with τ(N)=0, let w
N
	​

:N→W be a Borel dust labeling, and let κ(⋅∣s) be an adversarial kernel supported on rowwise minimizers of the extended labeling. Assume

q
β
	​

(N)>0.

Since τ(N)=0, the aligned adviser contributes no mass to N. Thus every unit of q-mass on N comes from the adversary. Let

ν(ds,dm):=τ(ds)κ(dm∣s)

be the adversarial source-message joint law. Then

ν(Δ(Ω)×N)>0.

Disintegrate ν over dust messages:

ν(ds,dm)
	​

Δ(Ω)×N
	​

=ρ
m
	​

(ds)q
N
	​

(dm),

where q
N
	​

 is the dust message marginal. For q
N
	​

-a.e. m∈N, write

w
N
	​

(m)=w
λ(m)
	​

,I(m)=suppλ(m).

Rowwise-minimizer support gives

ρ
m
	​

(K
I(m)
−
	​

)=1

for q
N
	​

-a.e. m. Bayes-cone calibration at dust message m requires the conditional source barycenter

s
ˉ
(m):=∫sdρ
m
	​

(s)

to satisfy

s
ˉ
(m)∈B
I(m)
	​

.

By the cone intersection lemma,

ρ
m
	​

=δ
μ
0
	​

	​


for q
N
	​

-a.e. m∈N. Therefore the first marginal of ν assigns positive mass to the singleton {μ
0
	​

}:

ν({μ
0
	​

}×N)=ν(Δ(Ω)×N)>0.

But the first marginal of ν is τ, and τ is atomless. Hence

ν({μ
0
	​

}×N)≤τ({μ
0
	​

})=0,

a contradiction.

So no Borel null dust set, no dust labeling, and no adversarial kernel can simultaneously satisfy rowwise-minimizer support, positive adversarial q-mass on dust, and Bayes-cone calibration on the used dust messages. This also covers diffuse dust, not only atomic dust: the disintegration argument works q
N
	​

-a.e., so spreading the dust into a glitter-cloud does not help.

For Step 3, the right classification is (b).

The obstruction is real as a calibration fact: in ternary winner-takes-all, adversary-only messages labeled by a payoff profile w
λ
	​

 can only draw from sources where the support of λ is coordinate-minimal, while Bayes optimality requires that same support to be coordinate-maximal. Averaging cannot reverse those inequalities except at the uniform prior.

But the specific halfspace

T={μ:μ(0)≤0.4}

is not a primitive optimal trust region for the given winner-takes-all u. In this environment, payoff profiles only remember which action, or mixed action, is used. The halfspace T contains messages whose plurality labels are 0,1,2, so its induced payoff-profile menu is already

C
†
={v
0
	​

,v
1
	​

,v
2
	​

},

the full pure-action menu. The robust menu objective sees C
†
, not the geometric cut μ(0)=0.4. If the full menu is optimal for some α,τ, then the same behavior is equivalently represented by the full simplex T=Δ(Ω); if the full menu is not optimal, then this halfspace representation is not optimal either. Either way, the number 0.4 and the boundary point t
0
	​

 are not pinned down by the primitive robust optimization. They are representational scenery, not load-bearing beams.

Thus this is not a definitive counterexample to unrestricted infinite Theorem 2. It is a genuine “no free dust” obstruction inside the v7 menu witness, but the witness does not yet certify that every primitive optimal solution must hit the same obstruction.

Implication for the Project

Strategy 2 should be retired for this witness: null-message dust cannot repair menu-Hall failure in ternary winner-takes-all. The failure is invariant to deterministic versus mixed kernels and to pure versus mixed dust labels. However, this does not prove the original infinite Theorem 2 false. It says that any non-narrowed proof cannot rely on adversary-only τ-null messages as calibration spackle. A surviving route must get calibration from primitive optimal geometry, constrained-persuasion transport, or additional structure ensuring that the Bayes cones and rowwise-minimizer cones are matched before dust is even considered.
