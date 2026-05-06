
========
ROLE: user (id=c8a512b2-98ac-40bb-9474-e1178999f740)
========
# Prover pass — L1: Constant-marginal continuity (Balder hammer)

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L1** of phil_reny_route_memo.md rigorously and report whether
the density set $F$ must be restricted (e.g., to bounded densities).

## Inputs (durable sources + this packet's attachments)

- Paper PDF (Robust_trust_Dworczak_Smolin.pdf) for the canonical model.
- phil_reny_route_memo.md — the live route memo, including the precise
  statement of L1 and the joint-transition-law topology on $\Sigma$.
- phil_reny_bundle.md — Phil's contribution and the Balder/Mertens
  précis.
- prior_attempts_digest.md — list of routes that are dead. Do not invoke
  the dead-route machinery in your proof.
- (Composer attachment, this pass) full Balder (1988) text.

## Target

**L1 (constant-marginal continuity).** Under the standing assumptions
($\Omega$ finite, $A$ compact metric, $\Theta$ Borel, $u$ bounded and
continuous in $a$, conditional independence of $s$ and $\theta$ given
$\omega$), and for fixed $\varphi\in F$:

If $\sigma_n\to\sigma$ in the joint-transition-law topology — i.e., for
every $\omega\in\Omega$, the joint laws

$$
\sigma_n(da\mid s,\theta)\,\pi(ds\mid\omega)\,f(d\theta\mid\omega) \;\xrightharpoonup{w^*}\; \sigma(da\mid s,\theta)\,\pi(ds\mid\omega)\,f(d\theta\mid\omega) \quad \text{on } A\times M\times \Theta,
$$

and likewise

$$
\sigma_n(da\mid m,\theta)\,\tau(dm)\,f(d\theta\mid\omega) \;\xrightharpoonup{w^*}\; \sigma(da\mid m,\theta)\,\tau(dm)\,f(d\theta\mid\omega) \quad \text{on } A\times M\times \Theta,
$$

— then for every fixed $\varphi\in F$,

$$
U_F(\sigma_n,\varphi) \longrightarrow U_F(\sigma,\varphi),
$$

where $U_F(\sigma,\varphi) := U(\beta_\varphi,\sigma)$ for
$\beta_\varphi(dm\mid s) := \varphi(m\mid s)\,\tau(dm)$ and $U$ is the paper's
payoff (eq. (1) of the paper, with the misaligned-term written as a
$\tau$-dominated integral).

Identify the **exact** Balder (1988) result invoked (theorem number, page).

## Subquestions you MUST address

1. Does the result hold for **all** $\varphi\in F$, or does it require
   $\varphi$ to be bounded ($\varphi\in L^\infty(\tau\otimes\tau)$ in some
   suitable sense)? If the latter, propose the mildest restriction (e.g.,
   $F_K := \{\varphi : \|\varphi\|_\infty \le K\}$) and state how the
   route memo must update.
2. Is the topology on $\Sigma$ described in the route memo equivalent to
   Balder's product weak topology on transition probabilities for the
   family $\{\sigma\,\pi(\cdot\mid\omega)\,f(\cdot\mid\omega)\}_{\omega\in\Omega}\cup\{\sigma\,\tau\,f(\cdot\mid\omega)\}_{\omega\in\Omega}$,
   or is it strictly weaker/stronger? If different, state which we should use.
3. Does the result need $\theta$-continuity? Phil's note suppresses
   $\theta$. We do **not** want to assume continuity in $\theta$; we want
   only measurability in $(s,\theta)$ or $(m,\theta)$, plus continuity in
   $a$. Verify Balder allows that.
4. Is there a "regular conditional probability" hypothesis needed on
   $f(\cdot\mid\omega)$? If so, is it automatic from $\Theta$ compact metric
   + Borel?

## Output Format


markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L1 — Constant-marginal continuity

**Claim:** (Restate L1 with all hypotheses explicit.)

**Argument:**

Step 1: (Recall the relevant Balder result by section/theorem number.)
Justification: (Cite Balder 1988, exact location.)

Step 2: (Verify hypotheses of Balder's result against our setup.)
Justification: ...

Step 3: (Apply Balder to derive continuity.)
Justification: ...

Step 4: (Combine the aligned and misaligned terms; reduce to two Balder
applications, one with marginal $\pi(\cdot\mid\omega)\,f(\cdot\mid\omega)$
and one with marginal $\tau\,f(\cdot\mid\omega)$.)
Justification: ...

[DERIVED] (State exactly what was established.)

### Target 2: Subquestion answers

(One short paragraph for each of the four subquestions above. Crisp
verdicts, not hedges.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if the route memo needs repair — e.g., if F
  must be restricted to bounded densities)

## Status Summary

- L1 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.

## Exact Next Obstacle

(Name the next real blocker — should point to L2.)


## Non-Negotiable Rules

- Every material step needs an explicit justification with a Balder citation
  by page/theorem number where Balder is invoked.
- Do not hand-wave with "clearly", "obviously", "by Balder".
- Do not silently weaken the target. If $F$ must be bounded, say so loudly
  in §Breakdown Amendments.
- Do not invoke any of the dead-route machinery in prior_attempts_digest.md.
- Length budget: 1500–2500 words. Do not exceed 3000.

## Scope Policy

One target lemma per pass. If you discover that L1 forces a non-trivial
amendment to the route memo (e.g., bounded densities only), STOP at the
amendment line — do not also try to re-prove L2 in this pass.


========
ROLE: assistant (id=4eaa4d1a-d6cb-4503-904c-88a29d9ac58e)
========
Goal for This Pass

This pass proves L1, the continuity of the restricted-game payoff in the agent strategy under the joint-transition-law topology. The only real trap is the misaligned term: after fixing a density φ, it becomes an integral against the fixed marginal τ(dm)f(dθ∣ω), but with a possibly ugly measurable weight in m. Balder’s weak convergence of transition probabilities is exactly the hammer for this nail: it permits measurable dependence on the base variable and continuity only in the action coordinate.

Main Work
Target 1: L1 — Constant-marginal continuity

Claim: Under the standing model assumptions in the paper, namely finite Ω, compact metric A, Borel/standard Borel Θ with f(⋅∣ω) a probability law, u(a,ω,θ) bounded, measurable, and continuous in a, and conditional independence of s and θ given ω, fix a restricted adviser density φ∈F. If for every ω∈Ω,

σ
n
	​

(da∣s,θ)π(ds∣ω)f(dθ∣ω)⇒σ(da∣s,θ)π(ds∣ω)f(dθ∣ω),

and

σ
n
	​

(da∣m,θ)τ(dm)f(dθ∣ω)⇒σ(da∣m,θ)τ(dm)f(dθ∣ω),

where these convergences are understood as Balder/stable weak convergence of kernels, equivalently ordinary weak convergence of the joint laws when M×Θ is compact metric and the displayed base marginals are fixed, then

U
F
	​

(σ
n
	​

,φ)→U
F
	​

(σ,φ).

Argument:

Step 1: The relevant Balder result is Theorem 2.2, p. 268, not primarily Theorem 2.5. Balder defines a Carathéodory integrand g:T×Z→R as measurable in the base variable t, continuous in the action variable z, and dominated by an integrable function of t. He defines the weak topology on transition probabilities as the coarsest topology making all such integral functionals continuous. In Theorem 2.2, p. 268, he gives the portmanteau characterization: the weak topology is equivalently characterized by continuity of all I
g
	​

 for g∈G
C
. 
ResearchGate
+1

Justification: Balder’s setup is designed precisely to avoid topologizing the type/base space. His introduction explicitly says the theory imposes no topological restrictions on type spaces and no continuity restrictions in the type coordinate of payoff functions. 
ResearchGate
 This matches the route memo’s need: (s,θ) or (m,θ) may enter only measurably, while a is the continuous coordinate. The paper’s canonical model likewise assumes Borel measurability for infinite spaces, compact metric A,Θ, bounded payoff, and continuity in a. 

Robust_trust_Dworczak_Smolin

Step 2: Verify Balder’s hypotheses for the aligned term. Fix ω. Let

X
ω
π
	​

:=M×Θ,λ
ω
π
	​

(ds,dθ):=π(ds∣ω)f(dθ∣ω),

and view σ
n
	​

(⋅∣s,θ) as transition probabilities from X
ω
π
	​

 to A. Define

g
ω
π
	​

((s,θ),a):=u(a,ω,θ).

This is measurable in (s,θ), continuous in a, and bounded by ∥u∥
∞
	​

. Hence it is a Balder Carathéodory integrand with integrable bound ∥u∥
∞
	​

. By Balder Theorem 2.2, convergence of the transition probabilities in Balder’s weak topology implies

∫g
ω
π
	​

((s,θ),a)σ
n
	​

(da∣s,θ)λ
ω
π
	​

(ds,dθ)→∫g
ω
π
	​

((s,θ),a)σ(da∣s,θ)λ
ω
π
	​

(ds,dθ).

Justification: Balder’s definition of Carathéodory integrands requires exactly continuity in the action coordinate and measurability in the base coordinate, with an integrable bound; Theorem 2.2 then makes the corresponding integral functional continuous. 
ResearchGate
+1

Step 3: Rewrite the misaligned term with a fixed marginal. For φ∈F,

β
φ
	​

(dm∣s)=φ(m∣s)τ(dm),

and the misaligned payoff contribution for state ω is

∫
M×M×Θ×A
	​

u(a,ω,θ)σ(da∣m,θ)φ(m∣s)τ(dm)π(ds∣ω)f(dθ∣ω).

By Tonelli, define

r
ω
φ
	​

(m):=∫
M
	​

φ(m∣s)π(ds∣ω).

Because μ
0
	​

 has full support and τ=∑
ω
	​

μ
0
	​

(ω)π(⋅∣ω), we have π(⋅∣ω)≪τ for every ω. Since ∫
M
	​

φ(m∣s)τ(dm)=1 for τ-a.e. s, the same normalization holds for π(⋅∣ω)-a.e. s, and therefore

∫
M
	​

r
ω
φ
	​

(m)τ(dm)=1.

Thus r
ω
φ
	​

∈L
1
(τ), though it need not be bounded. The misaligned term becomes

∫
M×Θ×A
	​

u(a,ω,θ)r
ω
φ
	​

(m)σ(da∣m,θ)τ(dm)f(dθ∣ω).

Justification: The route memo states the restricted class F as τ-dominated kernels β
φ
	​

(dm∣s)=φ(m∣s)τ(dm) with φ jointly measurable and normalized τ-a.s. 

phil_reny_route_memo

 The full-support prior and definition of τ are part of the paper-canonical notation in the route memo. 

phil_reny_route_memo

Step 4: Apply Balder to the misaligned term. Fix ω again and set

X
ω
τ
	​

:=M×Θ,λ
ω
τ
	​

(dm,dθ):=τ(dm)f(dθ∣ω).

Define

g
ω,φ
τ
	​

((m,θ),a):=u(a,ω,θ)r
ω
φ
	​

(m).

This function is measurable in (m,θ) and continuous in a. It is dominated by

∥u∥
∞
	​

r
ω
φ
	​

(m),

which is λ
ω
τ
	​

-integrable because r
ω
φ
	​

∈L
1
(τ) and f(⋅∣ω) is a probability measure. Hence g
ω,φ
τ
	​

 is a Balder Carathéodory integrand even if r
ω
φ
	​

 is unbounded. Balder Theorem 2.2 therefore gives

∫g
ω,φ
τ
	​

((m,θ),a)σ
n
	​

(da∣m,θ)λ
ω
τ
	​

(dm,dθ)→∫g
ω,φ
τ
	​

((m,θ),a)σ(da∣m,θ)λ
ω
τ
	​

(dm,dθ).

Justification: Balder’s definition allows domination by an L
1
(T) function, not only by a uniform constant. The Carathéodory definition includes the condition ∣g∣<φ for some φ∈L
1
(T), and Theorem 2.2 makes all such I
g
	​

 continuous. 
ResearchGate
+1
 This is the little door through which unbounded densities can safely pass.

Step 5: Combine states and alignment weights. Since Ω is finite and both aligned and misaligned statewise integrals converge, multiplying by μ
0
	​

(ω), α, and 1−α, then summing over ω, preserves convergence. Hence

U
F
	​

(σ
n
	​

,φ)→U
F
	​

(σ,φ).

Justification: The paper’s payoff is exactly the aligned truthful expectation plus (1−α) times the misaligned expectation, and Ω is finite in the canonical model. 

Robust_trust_Dworczak_Smolin

[DERIVED] L1 is proved for every fixed φ∈F, provided the convergence assumption is read as Balder/stable weak convergence of the relevant kernels, or equivalently as ordinary weak convergence of the corresponding joint laws when the base space is compact metric and the base marginal is fixed.

Target 2: Subquestion answers

Does F need bounded densities? No. L1 holds for all φ∈F, not only for L
∞
-bounded densities. The only needed object is r
ω
φ
	​

∈L
1
(τ), and that follows from normalization plus π(⋅∣ω)≪τ. Balder’s Carathéodory class permits an integrable bound, so bounded densities are unnecessary. No F
K
	​

 restriction is needed for L1.

Topology verdict. If M×Θ is compact metric and the displayed base marginals are fixed, the route memo’s joint-law weak topology is equivalent to Balder’s weak topology on the transition kernels for the family

{σπ(⋅∣ω)f(⋅∣ω)}
ω
	​

∪{στf(⋅∣ω)}
ω
	​

.

The fixed marginal is the magic ink: it lets ordinary weak convergence of joint laws upgrade to convergence against bounded measurable-base/continuous-action test functions. If Θ is only a measurable standard Borel space with no topology, ordinary weak convergence on A×M×Θ is not well-defined; then the route should explicitly use Balder’s product weak/stable topology.

Need θ-continuity? No. Balder does not require continuity in θ. In the aligned term the base variable is (s,θ); in the misaligned term it is (m,θ). Balder’s Carathéodory integrands require measurability in the base variable and continuity only in the action variable. Phil’s suppression of θ is harmless for L1.

Regular conditional probability hypothesis? No extra hypothesis is needed for L1 beyond having the state-conditional laws f(⋅∣ω). Since Ω is finite, f(⋅∣ω) is simply a finite family of probability measures on Θ. If one derives these laws from a joint distribution, regular conditional probabilities are automatic when Θ is compact metric, hence standard Borel.

Assumption Changes

[ASSUMPTION-] No bounded-density restriction is needed for L1.

[ASSUMPTION+] If Θ is not topologized, state the topology on Σ directly as Balder weak/stable convergence rather than ordinary joint-law weak convergence.

Breakdown Amendments

[BREAKDOWN_AMEND] Replace “Balder §2 Theorem 2.5 / Proposition 2.6” for L1 with: “Balder (1988), Theorem 2.2, p. 268, applied to the fixed-marginal kernels; Theorem 2.5, pp. 270–271, is relevant for product-kernel continuity elsewhere, but it is not the core constant-marginal continuity result.”

Status Summary

L1 status: PROVED.

Exact Next Obstacle

L2: compactness of Σ in the product Balder/stable topology, including the common-kernel issue across the finitely many ω-indexed marginals.
