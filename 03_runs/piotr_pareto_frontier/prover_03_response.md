
========
ROLE: user (id=e2968557-2f4c-4cd0-b225-abd9515110f9)
========
# Prover pass 03 — Lemma 12: Original-message lift (finite case)

## Role

You are the Prover. Lemmas 6 (patched), 7, and 8 are reviewer-PASS'd —
the **finite-menu Pareto-Hall calibration theorem** closes in payoff-
label coordinates. Now we need to lift the finite-label kernel back to
the original message space \(M\), so the conclusion becomes a statement
about the original-game adversarial kernel \(\hat\beta^*:M\to\Delta(M)\)
that Definition 2 requires.

Context: durable sources prover_02_response.md (Lemmas 7+8 proofs),
prover_01_response.md (Lemma 6 with patch note), reviewer_01_response.md
(L6 PATCH_SMALL), reviewer_02_response.md (L7+L8 PASS), and the
breakdown / route memo.

## Setup recap

Finite menu \(C^* = \{w_1,\ldots,w_k\}\subseteq W^P\). Borel labeling
\(w^*:M\to C^*\) defined by
\[
w^*(m) \;\in\; \arg\max_{w\in C^*}\,m\!\cdot\!w,
\]
with measurable selection on ties via KRN. The finite-label adversarial
kernel from Lemma 8 is
\[
\hat\kappa(\{i\}\mid s) \;:=\; \lambda^-_i(s), \quad s\in M, \; i\in\{1,\ldots,k\}.
\]

We need to construct a Borel **original-game adversarial message kernel**
\(\hat\beta^*:M\to\Delta(M)\), supported on the "rowwise-minimizer
messages" \(G(s) := \{m\in M : w^*(m)\in\arg\min_{w\in C^*}\,s\!\cdot\!w\}\),
such that the induced posterior \(P_{\hat\beta^*}(\cdot\mid m)\)
satisfies \(\hat\sigma^*(m)\) Bayes-optimal under \(P_{\hat\beta^*}(\cdot\mid m)\)
for \(q\)-a.e. \(m\) (Definition 2, infinite-space reading).

## Lemma 12 — Original-message lift

**Hypotheses.**
- (H1) Standing assumptions.
- (H2) Finite \(C^* = \{w_1,\ldots,w_k\}\subseteq W^P\) is a Pareto-
  completed ambient local maximizer of \(F_k\); calibration multipliers
  \(\lambda^\pm:M\to\Delta(k)\) and posterior \(p_i = g_i/q_i\in B_W(w_i)\)
  are as in Lemma 8.
- (H3) **Representative hypothesis (R):** for every \(i\in\{1,\ldots,k\}\)
  with \(q_i > 0\), the fiber \((w^*)^{-1}(\{w_i\}) := \{m\in M: w^*(m) = w_i\}\)
  is nonempty Borel. (This is the lift-feasibility condition; flag it
  as economically meaningful — it says each payoff label has at least
  one representative message.)

**Statement.** Under (H1)–(H3), there exists a Borel kernel
\(\hat\beta^*: M \to \Delta(M)\) with the following properties:

(a) **Support on rowwise minimizers.** For τ-a.e. \(s\in M\),
\(\hat\beta^*(\{m\}\mid s) > 0\) implies \(w^*(m)\in\arg\min_{w\in C^*}\,s\!\cdot\!w\).
Equivalently, \(\hat\beta^*(\cdot\mid s)\) is supported on \(G(s)\) τ-a.e.

(b) **Calibration on positive-mass labels.** Define
\(q := \alpha\,\tau + (1-\alpha)\,\tau\star\hat\beta^*\) (message marginal
of the joint distribution \(\gamma_\alpha = \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\hat\beta^*\)).
Then the disintegration posterior on \(\Omega\),
\[
P_{\hat\beta^*}(\cdot\mid m) \;=\; \E_{\gamma_\alpha}[s\mid m\text{ observed}],
\]
satisfies \(P_{\hat\beta^*}(\cdot\mid m)\in B_W(w^*(m))\) for \(q\)-a.e. \(m\in M\).

(c) **Bayes-optimality of \(\hat\sigma^*\).** \(\hat\sigma^*(m) := R(w^*(m))\)
(where \(R\) is the profile-realization right inverse, paper §3) is
Bayes-optimal under \(P_{\hat\beta^*}(\cdot\mid m)\) for \(q\)-a.e. \(m\).

## Proof outline

The construction is **direct measurable selection + measure pushforward**.

### Step 1 — Per-label representative selector

For each \(i\) with \(q_i > 0\), apply KRN to the fiber
\((w^*)^{-1}(\{w_i\}) \cap M\) (nonempty by (H3), Borel since \(w^*\) is
Borel). Get a deterministic Borel selector \(m_i \in (w^*)^{-1}(\{w_i\})\).
(A single representative per label suffices in the finite case;
in the compact-menu lift it becomes a kernel.)

### Step 2 — Define the original-game kernel

Define
\[
\hat\beta^*(\cdot\mid s) \;:=\; \sum_{i=1}^k \lambda^-_i(s)\,\delta_{m_i}.
\]
Verify Borel measurability of \(s\mapsto\hat\beta^*(\cdot\mid s)\)
(follows from Borel measurability of \(\lambda^-_i\) and constancy of
\(m_i\)).

### Step 3 — Support on rowwise minimizers (verify (a))

For each \(s\), the support of \(\hat\beta^*(\cdot\mid s)\) is
\(\{m_i : \lambda^-_i(s) > 0\}\). By Lemma 8 / patched Lemma 6,
\(\operatorname{supp}\lambda^-(s)\subseteq\arg\min_j s\!\cdot\!w_j\) τ-a.e.
For such \(i\), \(w^*(m_i) = w_i\in\arg\min_j s\!\cdot\!w_j\), so
\(m_i\in G(s)\). QED.

### Step 4 — Compute the message marginal \(q\)

Compute \(q\) explicitly. The aligned term contributes
\(\alpha\,\tau\); the misaligned term contributes
\((1-\alpha)\,\sum_i [\int_M\lambda^-_i(s)\,\tau(ds)]\,\delta_{m_i} = (1-\alpha)\sum_i (q^-_i)\delta_{m_i}\)
where \(q^-_i := \int\lambda^-_i d\tau\).

Note: \(q\) has both a continuous part (\(\alpha\tau\)) and atomic part
(\((1-\alpha)\sum_i q^-_i \delta_{m_i}\)). The atomic part puts mass
\((1-\alpha)q^-_i\) on the representative \(m_i\) (for those \(i\) with
\(q^-_i > 0\)).

### Step 5 — Compute the posterior \(P_{\hat\beta^*}(\cdot\mid m)\)

Two cases for \(q\)-a.e. \(m\):

**Case A: \(m\notin\{m_1,\ldots,m_k\}\).** \(q\)-measure of such \(m\)
is \(\alpha\cdot\tau(M\setminus\{m_1,\ldots,m_k\}) = \alpha\) (assuming
representatives are τ-null, which holds if \(\tau\) is atomless OR if
\(m_i\) are chosen avoiding atoms of \(\tau\)). For such \(m\) (truthful
aligned source), the posterior is \(\delta_m\) on \(s = m\). Verify:
\(\hat\sigma^*(m) = R(w^*(m))\) is Bayes-optimal at \(\delta_m\) iff
\(w^*(m)\in\arg\max_{w\in W} m\cdot w\) — which holds by definition of
\(w^*\). So calibration (c) holds at \(m\in M\setminus\{m_i\}\).

**Case B: \(m = m_i\).** \(q(\{m_i\}) = \alpha\tau(\{m_i\}) + (1-\alpha)q^-_i\).
Disintegration: the conditional posterior over states given \(m = m_i\)
is the mixture of:
- aligned-truthful at \(s = m_i\) (weight \(\alpha\tau(\{m_i\})\)),
- misaligned at \(s\sim\lambda^-_i\cdot\tau/q^-_i\) (weight \((1-\alpha)q^-_i\)).

Compute the conditional barycenter of \(s\) given \(m = m_i\). Under
the assumption that \(\tau(\{m_i\}) = 0\) (representatives chosen
τ-null, or τ atomless), the aligned term vanishes and the posterior
equals
\[
\E[s\mid m = m_i] \;=\; \frac{\int s\,\lambda^-_i(s)\,\tau(ds)}{q^-_i}.
\]

Compare to \(p_i = g_i/q_i\) from Lemma 8. Recall
\(g_i = \alpha\int\lambda^+_i(s)s\,d\tau + (1-\alpha)\int\lambda^-_i(s)s\,d\tau\)
and \(q_i = \alpha\int\lambda^+_i d\tau + (1-\alpha)\int\lambda^-_i d\tau\).

This is NOT immediately equal to \(\int s\lambda^-_i d\tau / q^-_i\)
unless \(\alpha = 0\) or \(\lambda^+_i = \lambda^-_i\). **There is a
mismatch.** Spell it out: in the finite-label setting, the posterior
\(p_i\) from Lemma 8 was computed by collapsing aligned-and-misaligned
contributions to a single payoff label \(i\), via the aligned tie-routing
weights \(\lambda^+_i\). In the original-message lift, the aligned
contribution is at the actual truthful message \(s\), not at the
representative \(m_i\) — these are different messages.

**This is the structural issue with the finite-menu lift.** The
finite-label calibration in Lemma 8 assumed the aligned agent reacts
to the label \(i\) (not to the truthful belief \(s\)) — i.e., the
agent's "message space" in the reduced game is the label set. In the
original game, aligned-truthful and misaligned messages live in the
same space \(M\), and the agent reacts to the message, not the label.

### Step 6 — The resolution

Two paths:

**(I) Aligned messages distinct from misaligned representatives.** If
\(\tau(\{m_i\}) = 0\) for all \(i\) (e.g., τ atomless and \(m_i\)
chosen τ-null), then the aligned and misaligned messages have
disjoint \(q\)-support modulo a \(q\)-null set. The posterior splits:
- At \(m\in M\setminus\{m_i\}\) (aligned-only): \(P_{\hat\beta^*}(\cdot\mid m) = \delta_m\).
  Bayes-optimality of \(\hat\sigma^*(m) = R(w^*(m))\) at \(\delta_m\) iff
  \(w^*(m)\in\arg\max_W m\cdot w\). YES by definition.
- At \(m_i\) (misaligned-only): \(P_{\hat\beta^*}(\cdot\mid m_i) = \int s\lambda^-_i\,d\tau/q^-_i\).
  Bayes-optimality of \(\hat\sigma^*(m_i) = R(w_i)\) at this posterior
  requires the posterior to be in \(B_W(w_i)\).

The misaligned-only posterior \(\int s\lambda^-_i d\tau / q^-_i\) is
NOT the same as \(p_i = g_i/q_i\) but is closely related. Specifically,
\(p_i = (\alpha q^+_i \cdot \mu^+_i + (1-\alpha) q^-_i \cdot \mu^-_i) / q_i\),
where \(\mu^\pm_i := \int s\lambda^\pm_i d\tau / q^\pm_i\). So
\(\mu^-_i\) is the misaligned-only posterior.

**The right calibration claim for the original-message lift is:**
\(\mu^-_i \in B_W(w_i)\). Is this true?

By Lemma 7, \(g_i\in N_W(w_i)\), so
\(\alpha\int\lambda^+_i(s)s d\tau + (1-\alpha)\int\lambda^-_i(s)s d\tau \in N_W(w_i)\).
This does NOT immediately give the misaligned-only part \(\int\lambda^-_i s d\tau \in N_W(w_i)\)
— normal cones aren't generally closed under taking convex parts.

**There's a real issue here that needs care.** The prover should:
- Either prove that \(\int\lambda^-_i s d\tau\in N_W(w_i)\) using a separate
  argument (e.g., a second Clarke Fermat on the misaligned-term-only
  subobjective);
- Or identify a stronger primitive condition (e.g., \(\alpha = 0\),
  the pure-adversarial case) under which the issue dissolves.

**(II) Aligned messages share representatives.** If we allow \(m_i\)
to coincide with actual truthful messages (i.e., a typical
\(s\in M\) with \(w^*(s) = w_i\)), then the aligned-and-misaligned
contributions at \(m_i\) co-mingle. The disintegration posterior at
\(m_i\) becomes:
\[
P_{\hat\beta^*}(\cdot\mid m_i) \;=\; \frac{\alpha\delta_{m_i} + (1-\alpha)\int s\lambda^-_i d\tau / q^-_i}{\alpha + (1-\alpha)q^-_i/q^-_i}
\]
... actually this needs more care. The correct route: define \(m_i\)
NOT as a deterministic representative but via a measurable selector
from \(\arg\max_{m'\in(w^*)^{-1}(w_i)}\) (matching the aligned-side
distribution conditional on label \(i\)). Then aligned and misaligned
distributions at \(m_i\) match \(p_i\).

## What I want you to produce

Produce a careful proof that:

1. Identifies the precise hypothesis needed for the lift (likely (H3)
   plus an additional fiber-richness or matching condition).
2. Constructs the original-game kernel \(\hat\beta^*\) explicitly.
3. Verifies (a), (b), (c) RIGOROUSLY, handling the aligned/misaligned
   mismatch identified in Step 5–6.
4. Reports cleanly whether the lift closes UNCONDITIONALLY under (H1)–(H3),
   or requires an additional primitive hypothesis (e.g., \(\tau\)
   atomless, or representatives matching aligned conditional law, or
   a uniformity condition on \(\lambda^+, \lambda^-\)).
5. Compares the resulting hypothesis with v8's exact-contact + menu-Hall,
   and verifies it is meaningfully weaker (i.e., a primitive condition
   that does NOT presuppose the labeling \(w^*\) is calibrated, only
   that the fibers are nonempty / matched).

If the lift requires a strictly stronger condition than (H3) alone,
state it as a "(D2) condition" with name, and check it is still
strictly weaker than menu-Hall.

## Output Contract

- Return everything inline as plain markdown.
- Be honest about whether the lift closes; do not hand-wave.
- The aligned/misaligned mismatch at \(m_i\) is real — engage with it
  directly. The cleanest resolution may be: pick \(m_i\) so that the
  aligned-conditional-on-label-\(i\) distribution matches the
  misaligned-conditional-on-label-\(i\), via a measurable matching
  argument; or restrict to \(\alpha = 0\) (pure adversarial) where
  the issue dissolves; or impose τ atomless + null-representative
  trick.
- End with the one-line **verdict** (lift closes / closes-under-X /
  blocked) plus a **next-step signal**.

## Constraints

- Banned moves: see prior_attempts_digest.md.
- This is the lift step that has historically broken (closure memo:
  "label-fiber lift gap" in Routes 1/2). Be careful.
- If the lift requires a hypothesis that resurrects deletion-compatible
  Hall duality, flag it explicitly — that means the route has reached
  the same closed gate.

Show more

========
ROLE: assistant (id=502640dc-7e42-4a7a-8eb7-21fb6bc23be8)
========
Prover pass 03 — Lemma 12: Original-message lift, finite case
Executive verdict

The lift does not close under (H1)–(H3) for α>0. The representative hypothesis (R) is enough to choose messages carrying the finite labels, but it is not enough to make the original-message posterior match the finite-label posterior from Lemma 8. The obstruction is exactly the aligned/misaligned mismatch: the finite-label proof routes aligned mass by λ
+
, while the original game routes aligned mass to the literal truthful message m=s.

There are two honest positive statements:

Pure adversarial case α=0: (H1)–(H3) are enough. The deterministic representative lift works cleanly.

General α>0: the lift closes under a finite-fiber matching condition, stated below as (D2) finite-fiber calibrated matching. But (D2) is essentially the finite-fiber version of menu-Hall, not a genuinely weaker primitive substitute. This is the same locked gate identified in the closure memo: find primitive conditions for a kernel supported on G(s) whose induced posterior lies in the Bayes cone messagewise. The project record names this as the deletion-compatible Hall duality problem and explicitly includes the “label-fiber lift” as one of its hard sub-obstructions. 

project_closure_memo

This matches the prior capstone: finite-label calibration is complete, but the original-message lift was already marked as a separate measurable-selection and calibration step, not a free corollary. 

breakdown_01_response

1. Notation

Let

F
i
	​

:=(w
∗
)
−1
({w
i
	​

})={m∈M:w
∗
(m)=w
i
	​

},

so the F
i
	​

’s are disjoint Borel fibers. Let

I
−
	​

(s):=arg
j≤k
min
	​

s⋅w
j
	​

,I
+
	​

(s):=arg
j≤k
max
	​

s⋅w
j
	​

.

Let

B
i
	​

:=B
W
	​

(w
i
	​

)=N
W
	​

(w
i
	​

)∩Δ(Ω)

be the Bayes cone of label w
i
	​

. Lemma 8 gives Borel multipliers λ
±
:M→Δ(k) with

suppλ
−
(s)⊆I
−
	​

(s),suppλ
+
(s)⊆I
+
	​

(s)τ-a.e.,

and

g
i
	​

=α∫λ
i
+
	​

(s)sτ(ds)+(1−α)∫λ
i
−
	​

(s)sτ(ds)∈N
W
	​

(w
i
	​

).

The finite-label posterior is

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

,q
i
	​

=α∫λ
i
+
	​

dτ+(1−α)∫λ
i
−
	​

dτ,

and Lemma 8 proves p
i
	​

∈B
i
	​

 whenever q
i
	​

>0. The finite-label theorem is therefore already Bayes-calibrated in label coordinates. 

breakdown_01_response

For an original-message kernel β:M→Δ(M), write

γ
β
	​

(ds,dm)=αδ
s
	​

(dm)τ(ds)+(1−α)β(dm∣s)τ(ds),

and let q
β
	​

=(γ
β
	​

)
2
	​

 be the observed-message marginal. Since the infinite-space reading of Definition 2 is q
β
∗
	​

-a.e., all q
β
	​

-positive messages, including τ-null messages used by the adversary, must satisfy Bayes-optimality. 

theorem_2_extension_proof_v8

2. Why the deterministic representative construction fails for α>0

Assume (H3). For every i with q
i
	​

>0, choose a representative

m
i
	​

∈F
i
	​

.

The proposed deterministic lift is

β
0
(⋅∣s):=
i=1
∑
k
	​

λ
i
−
	​

(s)δ
m
i
	​

	​

.

This kernel is Borel. Its support property is fine: if λ
i
−
	​

(s)>0, then i∈I
−
	​

(s), and since w
∗
(m
i
	​

)=w
i
	​

, we get

m
i
	​

∈G(s)={m:w
∗
(m)∈I
−
	​

(s)}.

So property (a) works.

The problem is the posterior.

Let

q
i
−
	​

:=∫
M
	​

λ
i
−
	​

(s)τ(ds),h
i
−
	​

:=∫
M
	​

λ
i
−
	​

(s)sτ(ds).

Under β
0
,

q
β
0
	​

=ατ+(1−α)
i
∑
	​

q
i
−
	​

δ
m
i
	​

	​

.

For a message m∈
/
{m
1
	​

,…,m
k
	​

} which receives no adversarial mass, the posterior is

P
β
0
	​

(⋅∣m)=m

for q
β
0
	​

-a.e. such m. Thus Bayes-optimality would require

m∈B
w
∗
(m)
	​

for τ-a.e. non-representative m.

This is not implied by w
∗
(m)∈argmax
w∈C
∗
	​

m⋅w. That condition says w
∗
(m) maximizes over the finite menu C
∗
, not over all feasible payoff profiles W. Bayes-optimality requires w
∗
(m)∈argmax
w∈W
	​

m⋅w, equivalently m∈N
W
	​

(w
∗
(m)). The finite-menu argmax is a smaller test. This is the first crack in the vase.

At a representative m
i
	​

, the posterior is

P
β
0
	​

(⋅∣m
i
	​

)=
ατ({m
i
	​

})+(1−α)q
i
−
	​

ατ({m
i
	​

})m
i
	​

+(1−α)h
i
−
	​

	​


when the denominator is positive. If τ({m
i
	​

})=0, this reduces to

μ
i
−
	​

:=
q
i
−
	​

h
i
−
	​

	​

.

But Lemma 8 calibrated

p
i
	​

=
α∫λ
i
+
	​

dτ+(1−α)q
i
−
	​

α∫λ
i
+
	​

(s)sτ(ds)+(1−α)h
i
−
	​

	​

,

not μ
i
−
	​

. There is no general implication

p
i
	​

∈B
i
	​

⟹μ
i
−
	​

∈B
i
	​

.

Normal cones are convex cones, but a convex combination lying in a cone does not force each component of that combination to lie in the cone. So the deterministic representative trick loses the exact object that Lemma 8 calibrated.

There is also a second mismatch: in the original game, aligned mass goes to the actual truthful message m=s, hence to the deterministic fiber F
i
	​

 when s∈F
i
	​

. In the finite-label proof, aligned mass is routed by λ
i
+
	​

(s). Unless

λ
i
+
	​

(s)=1
{s∈F
i
	​

}
	​

τ-a.e.,

the finite-label aligned flow and the original aligned flow are different objects. Tie-routing by λ
+
 is legal in label coordinates; it is not automatically implementable by a deterministic original-message labeling.

So (H3) gives representatives, but not calibration. The lift needs a messagewise transport condition, not just a label representative condition.

3. Positive result I: pure adversarial case α=0

Here the mismatch disappears because there is no aligned truthful component.

Lemma 12A — Original-message lift for α=0

Hypotheses. Assume (H1)–(H3), and α=0. Let λ
−
:M→Δ(k) and p
i
	​

 be supplied by Lemma 8. For each i with

q
i
	​

=q
i
−
	​

:=∫λ
i
−
	​

(s)τ(ds)>0,

choose m
i
	​

∈F
i
	​

, possible by (H3). For labels with q
i
	​

=0, choose any default m
i
	​

∈M; their choice is irrelevant.

Construction.

β
^
	​

∗
(⋅∣s):=
i=1
∑
k
	​

λ
i
−
	​

(s)δ
m
i
	​

	​

.

Proof.

Borelness is immediate because λ
i
−
	​

 are Borel and the support points are fixed.

For support, if λ
i
−
	​

(s)>0, then i∈I
−
	​

(s) for τ-a.e. s. Since w
∗
(m
i
	​

)=w
i
	​

, we have

w
∗
(m
i
	​

)∈arg
w∈C
∗
min
	​

s⋅w,

so 
β
^
	​

∗
(⋅∣s) is supported on G(s) for τ-a.e. s.

Since α=0,

γ
β
^
	​

∗
	​

(ds,dm)=τ(ds)
β
^
	​

∗
(dm∣s)=
i
∑
	​

λ
i
−
	​

(s)τ(ds)δ
m
i
	​

	​

(dm).

The message marginal is

q
β
^
	​

∗
	​

=
i
∑
	​

q
i
−
	​

δ
m
i
	​

	​

.

For q
i
−
	​

>0, the posterior at m
i
	​

 is

P
β
^
	​

∗
	​

(⋅∣m
i
	​

)=
q
i
−
	​

∫λ
i
−
	​

(s)sτ(ds)
	​

.

When α=0, Lemma 8 gives

g
i
	​

=∫λ
i
−
	​

(s)sτ(ds),q
i
	​

=q
i
−
	​

,p
i
	​

=
q
i
−
	​

g
i
	​

	​

∈B
i
	​

.

Thus

P
β
^
	​

∗
	​

(⋅∣m
i
	​

)=p
i
	​

∈B
i
	​

=B
W
	​

(w
i
	​

).

Since 
σ
^
∗
(m
i
	​

)=R(w
i
	​

), the continuation is Bayes-optimal at every q
β
^
	​

∗
	​

-positive representative. Labels with q
i
	​

=0 are q
β
^
	​

∗
	​

-null. This proves (a), (b), and (c) in the pure adversarial case.

Conclusion. Under (H1)–(H3), Lemma 12 closes for α=0. This is the clean finite case where the finite-label posterior and original-message posterior are the same critter wearing the same hat.

4. A correct general-α lift condition: (D2) finite-fiber calibrated matching

For α>0, the right finite-message lift condition is not “there is one representative per label.” It is “the fibers are rich enough to absorb adversarial flow so that the posterior is calibrated message by message.”

(D2) Finite-fiber calibrated matching

For each label i, there exists a finite Borel measure

η
i
	​

∈M
+
	​

(M×F
i
	​

)

such that:

(D2.1) Misaligned first marginal matches the Lemma 8 adversarial label flow.

(π
1
	​

)
#
	​

η
i
	​

(ds)=λ
i
−
	​

(s)τ(ds).

Equivalently, the amount of misaligned source s routed into fiber F
i
	​

 is exactly λ
i
−
	​

(s).

(D2.2) Rowwise-minimizer support. Since suppλ
−
(s)⊆I
−
	​

(s) τ-a.e., (D2.1) already implies that η
i
	​

-a.e. (s,m) satisfies

w
∗
(m)=w
i
	​

∈I
−
	​

(s),

hence m∈G(s).

(D2.3) Messagewise Bayes-cone calibration. Define the label-i source-message measure

Γ
i
	​

:=α(id,id)
#
	​

(τ∣
F
i
	​

	​

)+(1−α)η
i
	​

on M×F
i
	​

.

Let

q
i
M
	​

:=(π
2
	​

)
#
	​

Γ
i
	​


and define the vector measure

n
i
	​

(E):=∫
M×E
	​

sΓ
i
	​

(ds,dm),E⊆F
i
	​

 Borel.

Then

n
i
	​

≪q
i
M
	​

,

and its Radon-Nikodym derivative

r
i
	​

(m):=
dq
i
M
	​

dn
i
	​

	​

(m)

satisfies

r
i
	​

(m)∈B
i
	​

for q
i
M
	​

-a.e. m∈F
i
	​

.

This is the finite-fiber matching condition. It says: once aligned truthful mass is fixed on the diagonal m=s, there is enough adversarial mass entering each label fiber to make the posterior at almost every used message lie in the Bayes cone of that fiber’s payoff label.

A stronger but often easier-to-check sufficient version is the constant-posterior split:

r
i
	​

(m)=p
i
	​

q
i
M
	​

-a.e. on F
i
	​

.

Equivalently, for every Borel E⊆F
i
	​

,

α∫
E
	​

(m−p
i
	​

)τ(dm)+(1−α)∫
M×E
	​

(s−p
i
	​

)η
i
	​

(ds,dm)=0.

This version exactly says the adversarial flow cancels the aligned residual so every message in fiber F
i
	​

 induces the finite-label stationary posterior p
i
	​

.

5. Lemma 12B — Original-message lift under (D2)

Hypotheses. Assume (H1)–(H3), Lemmas 6–8, and (D2).

Statement. There exists a Borel kernel 
β
^
	​

∗
:M→Δ(M) such that:

(a) 
β
^
	​

∗
(⋅∣s) is supported on G(s) for τ-a.e. s;

(b) with

γ
α
	​

=α(id,id)
#
	​

τ+(1−α)τ⊗
β
^
	​

∗

and q=(γ
α
	​

)
2
	​

, the posterior satisfies

P
β
^
	​

∗
	​

(⋅∣m)∈B
W
	​

(w
∗
(m))q-a.e.;

(c) 
σ
^
∗
(m)=R(w
∗
(m)) is Bayes-optimal under P
β
^
	​

∗
	​

(⋅∣m) for q-a.e. m.

Proof.

Set

η:=
i=1
∑
k
	​

η
i
	​

.

By (D2.1),

(π
1
	​

)
#
	​

η=
i
∑
	​

λ
i
−
	​

(s)τ(ds)=τ(ds),

because λ
−
(s)∈Δ(k). Since M is standard Borel, disintegrate η with respect to its first marginal:

η(ds,dm)=τ(ds)
β
^
	​

∗
(dm∣s).

This gives a Borel Markov kernel 
β
^
	​

∗
:M→Δ(M).

For support, η
i
	​

 is supported on M×F
i
	​

, and by (D2.1) plus the active support of λ
−
, it only routes positive mass from s into F
i
	​

 when i∈I
−
	​

(s). Therefore

β
^
	​

∗
(G(s)∣s)=1τ-a.e.

This proves (a).

Now compute the induced joint measure:

γ
α
	​

=α(id,id)
#
	​

τ+(1−α)η.

Since the F
i
	​

’s partition M, the restriction of γ
α
	​

 to M×F
i
	​

 is precisely

Γ
i
	​

=α(id,id)
#
	​

(τ∣
F
i
	​

	​

)+(1−α)η
i
	​

.

Its second marginal is q
i
M
	​

. By (D2.3), the conditional source barycenter on F
i
	​

 is

r
i
	​

(m)=
dq
i
M
	​

dn
i
	​

	​

(m)∈B
i
	​

q
i
M
	​

-a.e.

But for m∈F
i
	​

,

w
∗
(m)=w
i
	​

,B
W
	​

(w
∗
(m))=B
i
	​

.

Hence

P
β
^
	​

∗
	​

(⋅∣m)=r
i
	​

(m)∈B
W
	​

(w
∗
(m))q
i
M
	​

-a.e. on F
i
	​

.

Summing over finitely many fibers gives

P
β
^
	​

∗
	​

(⋅∣m)∈B
W
	​

(w
∗
(m))q-a.e. on M.

This proves (b).

Finally, 
σ
^
∗
(m)=R(w
∗
(m)) realizes payoff profile w
∗
(m). Since the posterior lies in the Bayes cone B
W
	​

(w
∗
(m)), 
σ
^
∗
(m) is Bayes-optimal under that posterior. This proves (c).

6. Why (D2) is not a “free” or strictly weaker replacement for menu-Hall

The v8 Tier 2 assumption, menu-Hall, asks for a kernel supported on G(s) whose induced disintegration posterior lies in the Bayes cone B(m) for q-a.e. m. 

theorem_2_extension_proof_v8

For the present finite labeling, B(m)=B
i
	​

 on F
i
	​

. Thus (D2) is exactly a fiberwise transport form of the same requirement, with the extra restriction that the adversarial flow into label i has first marginal λ
i
−
	​

(s)τ(ds). In fact:

If (D2) holds, the proof above constructs a menu-Hall kernel.

If a menu-Hall kernel κ additionally satisfies κ(F
i
	​

∣s)=λ
i
−
	​

(s), then setting

η
i
	​

(ds,dm)=τ(ds)κ(dm∣s)1
F
i
	​

	​

(m)

gives (D2).

So (D2) is not strictly weaker than menu-Hall. With fixed Clarke multipliers, it is a more structured finite-fiber version of menu-Hall. This is useful as a proof object, but not a primitive breakthrough.

That matters because the project closure memo explicitly identifies the missing theorem as a deletion-compatible Hall duality theorem: primitive conditions under which a kernel supported on G(s) induces Bayes-cone posteriors q-a.e., while handling the label-fiber lift. 

project_closure_memo

 The subsequent route audit reports that attempts to derive this from deletion-style primitives stalled at the same family of obstructions, including the label-fiber/cell-flow lift gap. 

project_closure_memo

So the honest comparison is:

(H3) is a representative/exact-contact condition: it says the relevant fibers are nonempty.

(D2) is a calibration/transport condition: it says those fibers can be used to match posteriors messagewise.

v8 exact-contact + menu-Hall is exactly this split at the compact-menu level: exact-contact gives rowwise support, menu-Hall gives messagewise Bayes calibration. 

theorem_2_extension_proof_v8

Therefore (D2) is economically interpretable, but it is not meaningfully weaker than menu-Hall in the finite-label setting. It is the same dragon, just wearing finite-dimensional glasses. 🐉

7. The null-representative trick: what it really proves

Suppose τ({m
i
	​

})=0 and we use the deterministic representative kernel

β
0
(⋅∣s)=
i
∑
	​

λ
i
−
	​

(s)δ
m
i
	​

	​

.

Then:

At non-representative messages, the posterior is m itself.

At representative m
i
	​

, the posterior is μ
i
−
	​

:=h
i
−
	​

/q
i
−
	​

.

Thus the deterministic null-representative construction closes only under the additional conditions

m∈B
W
	​

(w
∗
(m))τ-a.e. on M∖{m
i
	​

},

and

μ
i
−
	​

=
∫λ
i
−
	​

(s)τ(ds)
∫λ
i
−
	​

(s)sτ(ds)
	​

∈B
i
	​

for every i with q
i
−
	​

>0.

These are not consequences of Lemma 8. Lemma 8 gives p
i
	​

∈B
i
	​

, where p
i
	​

 includes both the aligned λ
+
-term and the adversarial λ
−
-term. It does not give adversarial-only calibration μ
i
−
	​

∈B
i
	​

.

The null-representative trick is therefore a valid special sufficient route, but only under a strong extra “aligned-only and adversarial-only are separately calibrated” condition. It does not solve the general lift.

8. Comparison with v8 sharpness

Nothing here contradicts the v8 sharpness package. The finite-label Clarke theorem gives calibrated posteriors in payoff-label coordinates, but v8’s no-free-dust result shows that routing mass through τ-null messages cannot generally repair messagewise calibration failures in the WTA ternary geometry. 

theorem_2_extension_proof_v8

 The present analysis explains why: finite-label calibration is an aggregate statement, while Definition 2 requires q-a.e. messagewise calibration.

The project record also classifies the WTA witness as a menu-engine artifact rather than a primitive counterexample to unrestricted Theorem 2, so the right conclusion is not “the theorem is false”; it is that the original-message lift needs an additional fiberwise calibration theorem. 

theorem_2_extension_proof_v8

Final verdict

Verdict: closes-under-α=0; blocked under (H1)–(H3) for α>0; closes under (D2) finite-fiber calibrated matching, but (D2) is finite menu-Hall, not a strictly weaker primitive condition.

Next-step signal: The next useful pass should not try another deterministic representative proof. It should either prove a genuinely primitive sufficient condition for (D2), such as a fiber-rich atomless splitting theorem with vector-balance inequalities, or explicitly mark the finite-message lift as reaching the deletion-compatible Hall gate.
