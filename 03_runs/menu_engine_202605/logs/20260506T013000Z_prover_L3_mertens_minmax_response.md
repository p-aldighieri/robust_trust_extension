
========
ROLE: user (id=df52c9cb-2189-4431-b297-04562561e3c6)
========
# Prover pass — L3: Mertens minmax checklist

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L3** of phil_reny_route_memo.md: Mertens (1986) Corollary B
applies to the restricted game, hypothesis-by-hypothesis, and yields the
asymmetric minmax equality

$$
\max_{\sigma \in \Sigma}\,\inf_{\varphi \in F}\,U_F(\sigma,\varphi) \;=\; \inf_{\varphi \in F}\,\max_{\sigma \in \Sigma}\,U_F(\sigma,\varphi).
$$

## Inputs

- phil_reny_route_memo.md — live route memo. **L1 PROVED, L2 PROVED, L7 VERIFIED.**
- phil_reny_bundle.md — Phil's contribution + Mertens (1986) précis.
  Mertens Corollary B verbatim:
  > Let $T$ be an arbitrary set, $f(s,t)$ u.s.c. on $S$ for each $t \in T$. Then
  > $\max_\sigma \inf_\tau f(\sigma,\tau) = \inf_\tau \max_\sigma f(\sigma,\tau)$,
  > where $\sigma$ ranges over all regular Borel probabilities on $S$ and
  > $\tau$ over all probabilities with finite support on $T$.
- prior_attempts_digest.md — dead routes (don't invoke).
- Paper PDF.

## Target

**L3 (Mertens minmax checklist).** With:
- $S := \Sigma$ (kernel space) endowed with $T_\lambda$ (compact by L2),
- $T := F$ (arbitrary set; convex; carries no topology in Mertens's setup),
- $f(\sigma, \varphi) := U_F(\sigma, \varphi)$,

the hypotheses of Mertens (1986) Corollary B are satisfied, and the
equality holds. Pure-strategy maximizer for the agent exists in $\Sigma$
(no need to mix); the equality holds with $\sigma$ a regular Borel
probability over $\Sigma$ on one side and $\varphi$ ranging over finitely
supported probabilities on $F$ on the other side, but **convexity of $F$
collapses agent-side mixtures back into $\Sigma$ and adversary-side
finite-support probabilities back into $F$**.

## Subquestions you MUST address

1. **Compactness and Hausdorff.** Mertens needs $S$ compact Hausdorff.
   Verify $T_\lambda$ on $\Sigma$ is Hausdorff (Balder kernel topology
   should be Hausdorff under the standing hypotheses). Cite the relevant
   Balder result.
2. **U.s.c. in $\sigma$ for each $\varphi$.** From L1, $U_F(\sigma,\varphi)$
   is **continuous** in $\sigma$ for each $\varphi\in F$, hence u.s.c.
   Confirm this transfers cleanly.
3. **Bounded payoff.** Mertens needs the payoff to be bounded "from above
   or from below". Verify $|U_F(\sigma,\varphi)| \le \|u\|_\infty$ for
   every $(\sigma,\varphi)$.
4. **Convexity collapse on the $F$ side.** Mertens Cor B yields
   $\max_\sigma \inf_\tau f = \inf_\tau \max_\sigma f$ where $\tau$
   ranges over **finitely supported probabilities on $F$**, not over $F$
   itself. Show that, since $F$ is convex and $U_F$ is **affine** in
   $\varphi$, $\inf_{\text{finitely-supported probabilities on }F}\,\mathbb E[U_F(\sigma,\varphi)] = \inf_{\varphi\in F}\,U_F(\sigma,\varphi)$.
5. **Convexity collapse on the $\Sigma$ side.** Similarly, Mertens
   delivers the maximum over **regular Borel probabilities on $\Sigma$**.
   Show that since $\Sigma$ is convex and $U_F$ is **affine** in $\sigma$,
   the max over Borel mixtures equals the max over pure $\sigma\in\Sigma$.
6. **Affineness verification.** Confirm $U_F(\sigma,\varphi)$ is affine
   in $\sigma$ (linear integration against $\sigma$) and affine in
   $\varphi$ (linear in the density). State this as a lemma if helpful.
7. **Attainment of the agent-side maximum.** Mertens guarantees the
   value exists and the agent has $\varepsilon$-optimal strategies with
   finite support. Use compactness of $\Sigma$ + continuity of $U_F$
   in $\sigma$ to upgrade to **attainment**: there exists $\sigma^*\in\Sigma$
   with $\inf_F U_F(\sigma^*, \varphi) = \max_\sigma \inf_F U_F(\sigma, \varphi)$.

## Output Format


markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L3 — Mertens minmax checklist

**Claim:** (Restate L3 with all hypotheses explicit.)

**Argument:**

Step 1: (Verify $\Sigma$ compact Hausdorff in $T_\lambda$.)
Justification: ...

Step 2: (Verify $U_F$ continuous, hence u.s.c., in $\sigma$ for each $\varphi$.)
Justification: ...

Step 3: (Verify boundedness.)
Justification: ...

Step 4: (Apply Mertens Cor B.)
Justification: ...

Step 5: (Affineness lemma + adversary-side convexity collapse.)
Justification: ...

Step 6: (Agent-side convexity collapse + pure-strategy attainment.)
Justification: ...

[DERIVED] (State exactly what was established, including attainment of $\sigma^*$.)

### Target 2: Subquestion answers

(Crisp paragraph for each of subquestions 1–7.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if route memo needs repair)

## Status Summary

- L3 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.

## Exact Next Obstacle

(Should point to L4 — the existence and characterization of $\sigma^*$ —
which becomes a near-corollary once L3 lands. Or directly to L5 if you
fold L4 into L3.)


## Non-Negotiable Rules

- Cite Mertens (1986) by section/page number for the exact statement of
  Corollary B used.
- Cite Balder (1988) for the Hausdorff property of $T_\lambda$ if needed.
- Do NOT invoke any of the dead-route machinery in
  prior_attempts_digest.md (no Sion + Tychonoff, no adversary-side
  attainment in $\prod_\mu \Delta(M)$).
- Length budget: 2000–3000 words.

## Scope Policy

One target per pass. L3 should be tight — L4 (existence of $\sigma^*$)
follows almost mechanically once L3 lands and may be folded in if it
fits. Do not attempt L5 (Lusin compacts) or beyond.


========
ROLE: assistant (id=8055c3ba-5029-482a-9a74-c52f7b09712c)
========
Goal for This Pass

Establish L3 for the restricted absolutely-continuous adviser game: take the agent’s strategy space S:=Σ with Balder’s T
λ
	​

 kernel topology, take the adversary’s pure set T:=F with no topology, and set f(σ,φ):=U
F
	​

(σ,φ). The objective is to verify Mertens’s hypotheses one by one, apply Mertens (1986), §2, Corollary B, p. 238, and then collapse both sides of Mertens’s mixed-strategy statement back to the pure restricted-game equality by convexity and affineness. The pass stays inside the restricted F-game; it does not attempt the Lusin lift to unrestricted adviser kernels.

Main Work
Target 1: L3 — Mertens minmax checklist

Claim: In the restricted game where the misaligned adviser uses densities φ(m∣s) with respect to 
G
ˉ
:=∑
ω
	​

μ
0
	​

(ω)G(⋅∣ω), the payoff U
F
	​

:Σ×F→R satisfies Mertens’s hypotheses. Therefore,

σ∈Σ
max
	​

φ∈F
inf
	​

U
F
	​

(σ,φ)=
φ∈F
inf
	​

σ∈Σ
max
	​

U
F
	​

(σ,φ).

Moreover, the left-hand maximum is attained by some pure kernel σ
∗
∈Σ.

Argument:

Step 1: Σ is compact Hausdorff in T
λ
	​

.
By L2, Σ is compact in the Balder topology T
λ
	​

. Here T
λ
	​

 is the topology of weak convergence of the induced joint measures σG(⋅∣ω), for each ω, exactly as in Phil’s note: σ
n
	​

→σ iff σ
n
	​

G(⋅∣ω) weak
∗
-converges to σG(⋅∣ω) for each ω, and Phil records that Σ is compact under this topology. 

phil_reny_bundle

For Hausdorffness, use Balder’s quotient formulation of kernel weak convergence. Balder defines the null subspace X and the quotient map, and states that because X is weakly closed, the quotient space is a Hausdorff topological vector space and is locally convex. 
ResearchGate
 In the game application, Balder then records that the relevant strategy image R
i
	​

 is a compact convex subset of that Hausdorff locally convex space, citing Theorem 2.3(a). 
ResearchGate
 This is exactly the kernel-space point needed here: Σ should be read as the Balder quotient of kernels modulo 
G
ˉ
-a.e. equality. Since μ
0
	​

 has full support, 
G
ˉ
-null sets are precisely the sets null for every G(⋅∣ω), so the finite family (G(⋅∣ω))
ω∈Ω
	​

 separates the same payoff-relevant equivalence classes. On raw pointwise representatives the topology would generally fail to be Hausdorff, because kernels differing only on 
G
ˉ
-null messages cannot be separated. On the Balder quotient, it is Hausdorff.

Step 2: U
F
	​

(σ,φ) is continuous, hence u.s.c., in σ for each φ∈F.
This is precisely L1. Phil’s payoff rewrite for the restricted game is

U
F
	​

(σ,φ)=
ω
∑
	​

μ
0
	​

(ω)[α∫
A×S
	​

u(a,ω)σ(da∣s)G(ds∣ω)+(1−α)∫
A×M
	​

u(a,ω)(∫
S
	​

φ(m∣s)G(ds∣ω))σ(da∣m)
G
ˉ
(dm)],

and Phil notes that this function is continuous in σ for each fixed φ∈F under T
λ
	​

. 

phil_reny_bundle

 The Balder ingredient is the constant-marginal trick: even if the integrand is merely measurable in the message variable, continuity in the action variable plus the fixed 
G
ˉ
-marginal gives convergence of the integrals. 

phil_reny_bundle

 Thus Mertens’s u.s.c.-in-s hypothesis is satisfied, with room to spare.

Step 3: U
F
	​

 is bounded from above and below.
The model’s primitive payoff u is bounded, and α∈[0,1]. 

Robust_trust_Dworczak_Smolin

 Each term in U
F
	​

 is an expectation of u under a probability law, and the two terms are combined with weights α and 1−α. Hence, for every (σ,φ),

−∥u∥
∞
	​

≤U
F
	​

(σ,φ)≤∥u∥
∞
	​

,∣U
F
	​

(σ,φ)∣≤∥u∥
∞
	​

.

So Mertens’s one-sided boundedness requirement is satisfied in both directions.

Step 4: Apply Mertens Corollary B.
Mertens’s article is The minmax theorem for U.S.C.-L.S.C. payoff functions, International Journal of Game Theory 15, pp. 237–250. 
Springer Link
 The specific result used here is Mertens (1986), §2, Corollary B, p. 238: for compact Hausdorff S, arbitrary T, and f(s,t) u.s.c. on S for each t∈T,

ρ
max
	​

τ
inf
	​

f(ρ,τ)=
τ
inf
	​

ρ
max
	​

f(ρ,τ),

where ρ ranges over regular Borel probabilities on S, and τ ranges over finitely supported probabilities on T. 

phil_reny_bundle

 Applying this with S=Σ, T=F, and f=U
F
	​

 yields

ρ∈P
R
	​

(Σ)
max
	​

τ∈Δ
f
	​

(F)
inf
	​

U
ˉ
(ρ,τ)=
τ∈Δ
f
	​

(F)
inf
	​

ρ∈P
R
	​

(Σ)
max
	​

U
ˉ
(ρ,τ),
(M)

where

U
ˉ
(ρ,τ)=∫
Σ
	​

i=1
∑
n
	​

p
i
	​

U
F
	​

(σ,φ
i
	​

)ρ(dσ)if τ=
i=1
∑
n
	​

p
i
	​

δ
φ
i
	​

	​

.

Step 5: Affineness lemma and adversary-side convexity collapse.
For fixed φ, U
F
	​

(⋅,φ) is affine in σ, because σ enters only through linear integration against the kernel σ(da∣m). For fixed σ, U
F
	​

(σ,⋅) is affine in φ, because φ enters only through the density term

m↦∫
S
	​

φ(m∣s)G(ds∣ω),

and integration is linear. Thus, for τ=∑
i
	​

p
i
	​

δ
φ
i
	​

	​

, define the finite barycenter

φ
ˉ
	​

τ
	​

:=
i
∑
	​

p
i
	​

φ
i
	​

.

Since F is convex, 
φ
ˉ
	​

τ
	​

∈F, and by affineness,

i
∑
	​

p
i
	​

U
F
	​

(σ,φ
i
	​

)=U
F
	​

(σ,
φ
ˉ
	​

τ
	​

).

Therefore, for any fixed σ,

τ∈Δ
f
	​

(F)
inf
	​

i
∑
	​

p
i
	​

U
F
	​

(σ,φ
i
	​

)=
φ∈F
inf
	​

U
F
	​

(σ,φ),

because every finite mixture has a barycenter in F, and every φ∈F is represented by the Dirac mixture δ
φ
	​

. The same identity holds after integrating over any ρ∈P
R
	​

(Σ).

Step 6: Agent-side convexity collapse and pure-strategy attainment.
Because Σ is a compact convex subset of Balder’s Hausdorff locally convex quotient space, every regular Borel probability ρ∈P
R
	​

(Σ) has a barycenter b(ρ)∈Σ. For every continuous affine function h on Σ,

∫
Σ
	​

h(σ)ρ(dσ)=h(b(ρ)).

Applying this to h(σ)=U
F
	​

(σ,φ) gives

∫
Σ
	​

U
F
	​

(σ,φ)ρ(dσ)=U
F
	​

(b(ρ),φ).

Now collapse the left side of (M):

ρ∈P
R
	​

(Σ)
max
	​

τ∈Δ
f
	​

(F)
inf
	​

U
ˉ
(ρ,τ)=
ρ∈P
R
	​

(Σ)
max
	​

φ∈F
inf
	​

U
F
	​

(b(ρ),φ)=
σ∈Σ
max
	​

φ∈F
inf
	​

U
F
	​

(σ,φ),

where the final equality uses that every σ∈Σ is b(δ
σ
	​

). Similarly,

τ∈Δ
f
	​

(F)
inf
	​

ρ∈P
R
	​

(Σ)
max
	​

U
ˉ
(ρ,τ)=
φ∈F
inf
	​

σ∈Σ
max
	​

U
F
	​

(σ,φ).

Substituting these two collapses into (M) yields the desired restricted-game minmax identity.

Finally, define

V(σ):=
φ∈F
inf
	​

U
F
	​

(σ,φ).

Since V is the infimum of continuous functions of σ, V is upper semicontinuous. Since Σ is compact, V attains its maximum. Hence there exists σ
∗
∈Σ such that

φ∈F
inf
	​

U
F
	​

(σ
∗
,φ)=
σ∈Σ
max
	​

φ∈F
inf
	​

U
F
	​

(σ,φ).

[DERIVED] L3 is established for the restricted F-game:

σ∈Σ
max
	​

φ∈F
inf
	​

U
F
	​

(σ,φ)=
φ∈F
inf
	​

σ∈Σ
max
	​

U
F
	​

(σ,φ)
	​


and the agent-side maximum is attained by a pure kernel σ
∗
∈Σ. Mertens’s regular-Borel mixing over Σ and finite-support mixing over F are both smoke that disperses under convexity and affineness.

Target 2: Subquestion answers

1. Compactness and Hausdorff.
Compactness is L2 and is also recorded in Phil’s note for the topology where σ
n
	​

G(⋅∣ω) weak
∗
-converges for every ω. 

phil_reny_bundle

 Hausdorffness holds on the Balder quotient kernel space: Balder’s §2 quotient by the null subspace is Hausdorff and locally convex, and the game-theoretic strategy image is then a compact convex subset of that Hausdorff locally convex space. 
ResearchGate
+1
 The quotient caveat is essential only if Σ was written as raw kernels rather than payoff-relevant equivalence classes.

2. U.s.c. in σ for each φ.
L1 gives continuity of σ↦U
F
	​

(σ,φ) for each φ∈F. Continuity implies upper semicontinuity immediately. The constant-marginal Balder point is exactly why the restricted payoff is continuous even though the message variable need not be a continuity variable. 

phil_reny_bundle

3. Bounded payoff.
Because u is bounded and U
F
	​

 is a convex combination of expectations of u, one has ∣U
F
	​

(σ,φ)∣≤∥u∥
∞
	​

 for all (σ,φ). This verifies Mertens’s boundedness condition.

4. Convexity collapse on the F side.
For τ=∑
i
	​

p
i
	​

δ
φ
i
	​

	​

∈Δ
f
	​

(F), set 
φ
ˉ
	​

τ
	​

=∑
i
	​

p
i
	​

φ
i
	​

. Since F is convex, 
φ
ˉ
	​

τ
	​

∈F, and since U
F
	​

 is affine in φ,

E
τ
	​

[U
F
	​

(σ,φ)]=U
F
	​

(σ,
φ
ˉ
	​

τ
	​

).

Dirac measures give the reverse inclusion, so finite-support adversary mixtures and pure elements of F generate the same infimum.

5. Convexity collapse on the Σ side.
For a regular Borel probability ρ on compact convex Σ, let b(ρ)∈Σ be its barycenter. Since U
F
	​

(⋅,φ) is continuous affine,

∫
Σ
	​

U
F
	​

(σ,φ)ρ(dσ)=U
F
	​

(b(ρ),φ).

Thus player-1 mixtures over kernels collapse back to a pure kernel. Conversely, every pure kernel is the barycenter of its Dirac law.

6. Affineness verification.
The payoff is affine in σ because σ appears only inside integrals of the form ∫
A
	​

u(a,ω)σ(da∣m). It is affine in φ because the restricted adviser kernel is φ(m∣s)
G
ˉ
(dm), and the payoff depends linearly on that density. Convex combinations of kernels and convex combinations of densities therefore produce the corresponding convex combination of payoffs.

7. Agent-side maximum attainment.
The value function V(σ)=inf
φ∈F
	​

U
F
	​

(σ,φ) is an infimum of continuous functions, hence upper semicontinuous. On compact Σ, an upper semicontinuous real-valued function attains its maximum. Therefore a pure σ
∗
∈Σ exists and secures the restricted value.

Assumption Changes

[ASSUMPTION-] No new model assumption is needed.

[ASSUMPTION-] No topology on F is introduced; Mertens explicitly allows T=F to be an arbitrary set.

Breakdown Amendments

[BREAKDOWN_AMEND] Make explicit in the route memo that Σ is the Balder quotient kernel space, i.e. kernels are identified when they agree 
G
ˉ
-a.e. Equivalently, work only with payoff-relevant kernel classes. Without this standard identification, T
λ
	​

 can fail Hausdorff on raw representatives because null-set modifications cannot be separated. This amendment changes no payoff and adds no primitive assumption.

Status Summary

L3 status: PROVED, with the standard Balder quotient clarification for Hausdorffness.

Exact Next Obstacle

L4 is now almost mechanical on the existence side: define σ
∗
∈argmax
σ∈Σ
	​

inf
φ∈F
	​

U
F
	​

(σ,φ) using the attainment just proved, then record its restricted-game value guarantee. If L4 also asks for more characterization than existence, that characterization is the next live obstacle; otherwise the next substantive obstacle is L5, the Lusin-compact lift from F back to unrestricted measurable adviser deviations.
