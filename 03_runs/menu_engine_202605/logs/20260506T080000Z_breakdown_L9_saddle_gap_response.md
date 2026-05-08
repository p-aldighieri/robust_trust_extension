
========
ROLE: user (id=dc10cef9-c637-47e9-a34e-a2119690e0f7)
========
# Breakdown pass — Closing the L9 saddle gap

You are the Breakdown role for the soft-scaffolding workflow.

## Context

The Branch B final consolidator review caught a real gap in L9
(logs/20260506T073000Z_rereview_branch_B_consolidator_response.md).

**The gap:** Branch A + L8 deliver:
- $\sigma^* \in \arg\max_\sigma\inf_\beta U(\beta,\sigma)$ (maximin).
- $U(\beta^*, \sigma^*) = \inf_\beta U(\beta, \sigma^*) = U^*$ (β* rowwise
  adversarial against σ*).

L9's standard contradiction argument silently invokes the **upper
saddle inequality**
$$
U(\beta^*, \sigma) \le U(\beta^*, \sigma^*) \quad \forall \sigma,
$$
i.e., σ* is a best response to β*. **This does NOT follow from Branch
A + L8** in general: a minimum against a maximin strategy need not be
a minimax strategy. Without the upper saddle, an improving deviation
$\hat\sigma'$ on a positive-q-measure set $E$ doesn't contradict
anything: it improves $U(\beta^*, \cdot)$ but $\sigma^*$ wasn't claimed
optimal against β*.

This pass evaluates three candidate fixes and picks the next prover
target.

## Inputs

- phil_reny_route_memo.md, phil_reny_bundle.md,
  prior_attempts_digest.md, paper PDF.
- L9 logs and reviewer logs.
- theorem_2_extension_proof.md (final consolidator output).

## Three candidate fixes

### Fix A: Strengthen L8 to a minimax β*

Construct $\beta^*$ that is **both** rowwise adversarial against σ*
AND the agent-side maximizer's value coincides:
$\sup_\sigma U(\beta^*, \sigma) = U^*$.

This makes $(\sigma^*, \beta^*)$ a true saddle and L9's contradiction
goes through directly.

**Honest evaluation:** Sion-style approaches (which would deliver this)
were ruled out in prior_attempts_digest.md. Mertens Cor B's RHS gives
$\inf_\varphi \max_\sigma U_F(\sigma, \varphi)$ over **finite-support
mixtures** of $F$; via affineness this collapses to $\inf_\varphi$ over
$F$, and the $\inf$ may not be attained (L8a's verdict). Without
attainment of an $F$-side or $B$-side dual minimizer that's also
minimax, this fix is structurally hard.

**Question for the breakdown:** Can L8c's selector $\beta^* = \delta_{m^*(s)}$
be **augmented** or **regularized** into a minimax adversary, e.g.,
by taking a convex combination with an aligned strategy or by
building a saddle structure on the level set?

### Fix B: Replace σ* with a Bayes-optimal σ** under P_β*

Define
$$
\hat\sigma^{**}(m) := \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))
$$
for τ-a.e. m (existence by KRN under standing hypotheses; A compact metric).

**Honest evaluation:** σ** is Bayes-optimal under P_β* by construction.
The question is whether σ** still secures U*:
- $U(\beta^*, \sigma^{**}) \ge U(\beta^*, \sigma^*) = U^*$ (pointwise
  per message + integration).
- $U(\sigma^{**}) = \alpha\,\text{aligned}(\sigma^{**}) + (1-\alpha)\,\inf_\beta E_{\beta,\sigma^{**}}[u]$.
- We need $U(\sigma^{**}) \ge U^*$.
- The aligned part $\text{aligned}(\sigma^{**})$ may differ from
  $\text{aligned}(\sigma^*)$. The misaligned $\inf_\beta$ may also
  differ.
- **Risk:** σ** is constructed to maximize against β*, not against
  the aligned + worst-case mixture. It may UNDER-secure $U^*$ if it
  sacrifices aligned-side performance.

**Question for the breakdown:** Is there an argument that σ** can be
chosen to preserve the maximin value? E.g., by restricting σ** to
agree with σ* off the failure set $E$.

### Fix C: Different per-message argument bypassing upper saddle

Instead of invoking saddle, argue per-message Bayes-optimality from
the structure of L8c's construction directly:
- $\beta^* = \delta_{m^*(s)}$ where $m^*(s) \in \arg\min_m \ell_{\sigma^*}(m,s)$.
- $\ell_{\sigma^*}(m,s)$ is constructed FROM σ*'s message payoffs.
- Hence the posterior $P_{\beta^*}(\cdot\mid m)$ at any "active" message
  $m$ in the image of $m^*$ has a specific structure that may force
  Bayes-optimality of $\hat\sigma^*(m)$ at that m.

**Honest evaluation:** The active messages under β* form a set
$M^* := \{m^*(s) : s\in M\}$ which is τ-null in general (the pushforward
$(m^*)_\#\tau$ may be supported on a thin set). For $m\in M^*$, the
posterior $P_{\beta^*}(\cdot\mid m)$ is determined by which $s$
satisfy $m^*(s) = m$. Definition 2 needs Bayes-optimality at every (or
τ-a.e.) on-path m, including aligned-only messages where
$P_{\beta^*}(\cdot\mid m) = m$ (the truthful posterior).

**Question for the breakdown:** Can we separate aligned-only messages
(where Bayes-optimality is trivial since the posterior IS the message)
from misaligned messages (where σ* may need to match a specific
target)? At aligned messages, σ* is automatically Bayes-optimal under
P_β*(·|m) = m (truthful posterior) IF σ* was already chosen as the
aligned-Bayes-optimal at every m, which is a separate property.

## What you must produce

A markdown deliverable with **exactly** the following sections:


markdown
## 1. The exact gap precisely

(One paragraph stating the gap. Include the full chain: what L9 needs,
what Branch A + L8 give, where the upper saddle should appear.)

## 2. Evaluate each fix honestly

### 2a. Fix A — strengthen L8 to minimax β*
(Diagnose. Is the L8c selector or some augmentation actually minimax?
What additional structure is needed?)

### 2b. Fix B — replace σ* with Bayes-optimal σ** under P_β*
(Diagnose. Does σ** still secure U*? What's the cleanest argument?
Is there a "splice" σ_E that agrees with σ* outside the failure set
and is Bayes-optimal on E?)

### 2c. Fix C — per-message argument bypassing upper saddle
(Diagnose. Can the structure of m*(s) and the aligned/misaligned
decomposition give Bayes-optimality directly without saddle?)

## 3. Ranked recommendation

(Pick the most viable. Identify the next prover target as a single
focused lemma.)

## 4. Risk: theorem may need to be weakened

(If none of A/B/C close the gap cleanly, the published theorem must
state only Branch A + L8 attainment, dropping the Definition 2
robust-rationalizability conclusion. State this honestly as the
fallback.)


## Discipline

- Use paper-canonical notation.
- Cite Aliprantis-Border, Bogachev where relevant.
- Length budget: 1500–2500 words.
- This is a planning pass. No proofs in detail.


========
ROLE: assistant (id=46179cdf-ef53-497e-80bd-bad102c68fed)
========
1. The exact gap precisely

L9 needs the upper saddle inequality U(β
∗
,σ)≤U(β
∗
,σ
∗
) for every agent strategy σ: if 
σ
^
∗
(m) fails Bayes-optimality under P
β
∗
	​

(⋅∣m) on a q-positive set E, a Kuratowski–Ryll-Nardzewski selection of improving private strategies can be spliced into σ
∗
 on E, yielding U(β
∗
,σ
′
)>U(β
∗
,σ
∗
), and this contradicts L9 only if σ
∗
 is already a best response to β
∗
. Branch A + L8 give a different, one-sided chain: σ
∗
∈argmax
σ
	​

inf
β
	​

U(β,σ), U(β
∗
,σ
∗
)=inf
β
	​

U(β,σ
∗
)=U
∗
, hence U(β,σ
∗
)≥U(β
∗
,σ
∗
) for all β. That is the lower saddle inequality, not the upper one. The finite proof in Appendix A.2 gets both inequalities from Sion and compactness; the infinite route deliberately avoided that unavailable saddle machinery, using Balder, Mertens, Lusin smoothing, and rowwise adversary attainment instead. The final L9 writeup therefore smuggles in the missing minimax-best-response half when it says Branch A + L8 provide the “saddle inequality.” They provide adversary attainment against σ
∗
, not agent optimality against β
∗
. 

Robust_trust_Dworczak_Smolin

 

phil_reny_route_memo

 

theorem_2_extension_proof

2. Evaluate each fix honestly
2a. Fix A — strengthen L8 to minimax β*

Fix A is mathematically clean: if one can find β
∗
 such that

U(β
∗
,σ)≤U(β
∗
,σ
∗
)=U
∗
≤U(β,σ
∗
)∀(β,σ),

then L9 is repaired immediately. This is exactly what the finite proof obtains from Sion. But the present infinite route was built precisely because the full B-side compactness/continuity needed for that saddle is not available; prior attempts record both the product-narrow continuity failure and genuine escape-of-mass obstructions on adversary-side attainment. 

prior_attempts_digest

The L8c selector β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm) is not secretly minimax. It solves the rowwise problem

m
∗
(s)∈arg
m
min
	​

ℓ
σ
∗
	​

(m,s),ℓ
σ
∗
	​

(m,s)=
ω
∑
	​

s(ω)p
ω
	​

(m),

for the fixed payoff profile generated by σ
∗
. A minimax adversary must instead minimize the envelope

G(β):=
σ
sup
	​

U(β,σ),

which ranges over all feasible private-strategy payoff profiles, not just the already-installed message profile p(m). These are different beasts: L8c finds a tooth in the current gear; Fix A needs a governor for the whole engine.

Convex combination does not cure this. If 
β
~
	​

 is not also adversarial against σ
∗
, then λβ
∗
+(1−λ)
β
~
	​

 generally raises U(⋅,σ
∗
) above U
∗
, losing the lower saddle. If 
β
~
	​

 is also adversarial, affineness preserves U(⋅,σ
∗
)=U
∗
, but gives no control over sup
σ
	​

U(⋅,σ). Mixing can just as easily create profitable directions for the agent. “Regularizing” the Dirac selector into τ-dominated densities has the same problem: L6-style smoothing approximates payoffs at σ
∗
, but it does not control the agent’s best-response envelope.

The only viable version of Fix A needs an additional dual-attainment structure: for example, an F-side minimizer φ
0
 attaining inf
φ∈F
	​

max
σ
	​

U
F
	​

(σ,φ), plus a lift to B, or a compact/tight level set on which G(β) attains its infimum. The route memo’s L8a analysis already says the restricted dual infimum is generically unattained unless rowwise minimizer sets have positive τ-mass. So Fix A is a correct target under stronger assumptions, but it is not reachable from L8c by augmentation alone. 

phil_reny_route_memo

2b. Fix B — replace σ* with Bayes-optimal σ** under P_β*

The pointwise construction of σ
∗∗
 is feasible. Given β
∗
, disintegrate the induced state-message law to obtain P
β
∗
	​

(⋅∣m), then select

σ
^
∗∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,P
β
∗
	​

(⋅∣m)).

The needed measurable selection is standard under the compact metric hypotheses: use the measurable maximum theorem and Kuratowski–Ryll-Nardzewski selection as in Aliprantis–Border; use Bogachev for regular conditional probabilities/disintegration on standard Borel spaces.

But this only gives

U(β
∗
,σ
∗∗
)≥U(β
∗
,σ
∗
)=U
∗
.

The robust payoff is

U(σ
∗∗
)=
β∈B
inf
	​

U(β,σ
∗∗
),

and β
∗
 need not be worst-case for σ
∗∗
. A best response to one adversary column can be disastrous against another. This is not a technical nuisance; it is the elementary maximin pathology hiding under a velvet rug.

The splice version has the same flaw. Let E be the q-positive set where 
σ
^
∗
(m) is not Bayes-optimal under P
β
∗
	​

(⋅∣m), and define σ
E
	​

 to agree with σ
∗
 outside E and improve inside E. Then

U(β
∗
,σ
E
	​

)>U(β
∗
,σ
∗
).

But another β can route misaligned messages into E and exploit the new private-strategy profile. Even if E is τ-null, unrestricted misaligned kernels may assign it positive probability; τ-null does not mean adversary-invisible. If E has positive aligned mass, the splice can also reduce truthful-side performance, because Bayes-optimality for P
β
∗
	​

(⋅∣m) need not be Bayes-optimality for the truthful posterior m.

A splice would preserve the value only under a much stronger “safe improvement” condition: the replacement payoff vector w
′
(m) must weakly dominate w
∗
(m) against every posterior s∈M, i.e. s⋅w
′
(m)≥s⋅w
∗
(m) for all s. Bayes improvement at one posterior P
β
∗
	​

(⋅∣m) supplies only one linear inequality, not statewise or M-wide dominance. Thus Fix B is not a clean repair; it can manufacture myopic optimality by burning the maximin guarantee.

2c. Fix C — per-message argument bypassing upper saddle

The raw L8c structure is too weak to force Bayes-optimality. The selector m
∗
(s) says: for each true adviser posterior s, the message m
∗
(s) minimizes the current payoff s⋅p(m) over the message profiles already present in σ
∗
. Bayes-optimality at a received message m asks something different: p(m) must maximize μ⋅w over the entire feasible private payoff set W at μ=P
β
∗
	​

(⋅∣m). In convex-analytic language,

P
β
∗
	​

(⋅∣m)∈N
W
	​

(p(m)),

the normal cone of W at p(m). Rowwise minimization gives a lower-envelope condition over the installed message menu {p(m
′
)}; Bayes-optimality is an upper-support condition over W. Wrong sign, wrong feasible set, wrong object.

The aligned/misaligned split exposes the same issue. Under β
∗
=δ
m
∗
(s)
	​

, the message marginal is

q=ατ+(1−α)(m
∗
)
#
	​

τ.

When α>0, q≥ατ, so every τ-relevant aligned message remains on path. If a message m is aligned-only, then P
β
∗
	​

(⋅∣m)=m, and robust rationalizability requires 
σ
^
∗
(m) to be Bayes-optimal at m. Branch A does not guarantee this. Theorem 1 can often replace an optimal strategy by an equivalent TRS, but even a TRS is Bayes-optimal at m only inside its trust region. Outside the trust region, it is Bayes-optimal at the clipped belief P(m), so the misaligned adviser must also send mass to m in exactly the right proportions to make Bayes’ rule produce P(m). The L8c rowwise selector neither ensures that outside-trust messages are hit nor calibrates fiber averages correctly.

So raw Fix C does not bypass the upper saddle. Its useful residue is a sharper target: not “L8c implies Bayes-optimality,” but “construct β
∗
 with both worst-message support and posterior calibration.” That is a transport problem, not a saddle shortcut. It resembles the paper’s explicit TRE constructions in the binary and spherical cases, where adversarial indifference is broken to make Bayes’ rule match the trust-region projection. 

Robust_trust_Dworczak_Smolin

3. Ranked recommendation

The most viable next target is a calibrated adversarial transport lemma, a repaired version of Fix C rather than raw Fix C. Fix A is clean but runs straight into the already-diagnosed minimax-attainment wall. Fix B is unsafe because best-responding to β
∗
 can destroy the maximin guarantee. The calibrated-transport route attacks the missing implication directly and avoids pretending that L8 produced a full saddle.

Next prover target:

Lemma — calibrated worst-message transport. Let σ
∗
 be the Branch-A optimal strategy, preferably chosen in an equivalent Bayes-frontier/TRS representative. Define

D(s):=arg
m∈M
min
	​

ℓ
σ
∗
	​

(m,s),

and

C(m):={μ∈Δ(Ω):
σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,μ)}.

Prove or disprove that there exists a measurable kernel β
∗
∈B such that

β
∗
(D(s)∣s)=1τ-a.e. s,

and, for q=ατ+(1−α)∫β
∗
(⋅∣s)τ(ds),

P
β
∗
	​

(⋅∣m)∈C(m)q-a.e. m.

If this lemma holds, L8 and L9 close without the missing upper saddle: support on D(s) gives adversariality against σ
∗
, and posterior calibration gives Definition 2 directly. The proof tools would be Aliprantis–Border for measurable correspondences/selections and Bogachev for disintegration plus vector-measure transport. The first prover step should be to derive necessary Hall/Strassen-style vector-measure inequalities for this kernel. If those inequalities fail in a small finite or compact example, the theorem really must be weakened.

4. Risk: theorem may need to be weakened

At present, none of A/B/C closes the gap cleanly. The safe result is: Branch A gives a maximin σ
∗
 securing U
∗
; L8, under its added rowwise-attainment/l.s.c. hypothesis, gives an adversarial β
∗
 attaining inf
β
	​

U(β,σ
∗
). That is not robust rationalizability unless the upper saddle or calibrated posterior condition is also proved.

So the fallback theorem should state only:

σ
∗
∈arg
σ
max
	​

β
inf
	​

U(β,σ),U(β
∗
,σ
∗
)=
β
inf
	​

U(β,σ
∗
)=U
∗
,

with no Definition 2 conclusion. In words: existence of an optimal robust strategy, and possibly an attained worst-case adversary, but not necessarily an ex-post Bayes-optimal/TRE implementation. Dropping the robust-rationalizability claim is the honest fallback unless the calibrated transport lemma or a genuine minimax β
∗
 is established.
