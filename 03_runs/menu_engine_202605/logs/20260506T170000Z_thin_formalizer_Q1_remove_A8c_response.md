
========
ROLE: user (id=f53dc883-d096-403b-b8a9-ac734fa5defb)
========
# Thin formalizer — Q1: Can (A8c-attain) be removed for Branch B Tier 1?

You are the Formalizer. **Keep this pass thin.** The route memo and
theorem_2_extension_proof_v4.md already have the precise machinery.
The only deliverable for this pass is a **crisp formal statement of
Open Question 1**, with explicit quantifiers, hypotheses, and known
inputs from the existing proof record.

## Inputs

- theorem_2_extension_proof_v4.md, phil_reny_route_memo.md,
  phil_reny_bundle.md, prior_attempts_digest.md, paper PDF.

## Target

State **Open Question 1 (Q1)** precisely.

## Output Format


markdown
## Q1 — Removing (A8c-attain) for Branch B Tier 1

### Setting (recall)

(One paragraph: standing hypotheses + (A5-thick); Branch A landed
giving $\sigma^*\in\Sigma$ with $U(\sigma^*) = U^*$ and
$\inf_{\beta\in B} U(\beta,\sigma^*) = U^*$ via L6 bottom-density; what
(A8c-attain) was doing in Branch B Tier 1 — providing a Borel selector
$m^*$ from the rowwise argmin correspondence $D(s)$, hence the Dirac
adversary $\beta^* = \delta_{m^*(s)}$.)

### What's known without (A8c-attain)

(One paragraph: under standing + (A5-thick) alone, $\inf_B U(\cdot,\sigma^*) = U^*$
holds — that's L6. The question is whether this infimum is **attained**.
$D(s)$ may be empty for a positive-τ set of $s$ when $\ell(\cdot,s)$
is not l.s.c. and pointwise inf is not realized.)

### Q1 (formal)

**Question.** Under the standing hypotheses of Dworczak–Smolin (2026)
+ (A5-thick), does there exist $\beta^*\in B$ such that
$U(\beta^*,\sigma^*) = U^*$?

Equivalently: is the infimum
$\inf_{\beta\in B} U(\beta,\sigma^*) = U^*$ **attained** in the
unrestricted measurable-kernel space $B$?

(Note: any positive answer must work even when the rowwise argmin
correspondence $D(s)$ is empty on a positive-τ set — i.e., $\beta^*$
cannot be Dirac-shaped.)

### Open subquestions / scope of plausible attacks

1. **Stochastic kernel attainment.** Can a non-Dirac $\beta^*$ attain
   the inf via integration when no pointwise rowwise argmin exists?
2. **Tightness/compactness of $B$.** Is there a topology on $B$ in
   which $U(\cdot,\sigma^*)$ is l.s.c. AND $B$ is compact, distinct
   from the dead product-narrow Sion route?
3. **Honest negative.** Counterexample: a model satisfying standing
   + (A5-thick) where $\sigma^*$ is the Branch-A maximizer and
   $\inf_B U(\cdot,\sigma^*) = U^*$ is **not attained** in $B$.

### Things this pass will NOT attempt

(One sentence: this is a thin formalizer; literature search,
breakdown, and proof attempts come in subsequent passes.)


## Discipline

- Length budget: 400–800 words. Be crisp.
- Use paper-canonical notation throughout.
- Don't propose strategies — just state Q1 precisely.
- Identify the "scope of plausible attacks" enumeration as a roadmap
  for the literature/breakdown passes that come next, not as
  conjectures.

Show more

========
ROLE: assistant (id=65f33680-61ee-42e2-a8b4-efe9cde1ec77)
========
Q1 — Removing (A8c-attain) for Branch B Tier 1
Setting (recall)

Fix the Dworczak–Smolin standing hypotheses: finite $\Omega$ with full-support prior $\mu_0$, compact metric $A$ and $\Theta$, bounded Borel payoff $u(a,\omega,\theta)$ continuous in $a$, conditional independence of $s$ and $\theta$ given $\omega$, $M=\operatorname{supp}(\tau)$, $\Sigma$ the measurable agent kernels, and $B$ the unrestricted measurable kernels $\beta:M\to\Delta(M)$. Assume also (A5-thick). Branch A has landed: there is a proof-record strategy $\sigma^*\in\Sigma$ such that

U(σ
∗
)=U
∗
,
β∈B
inf
	​

U(β,σ
∗
)=U
∗
,

indeed $U(\beta,\sigma^)\ge U^$ for every $\beta\in B$, using L6 bottom-density / Lusin lift. Define

p
ω
	​

(m):=∫
Θ
	​

∫
A
	​

u(a,ω,θ)σ
∗
(da∣m,θ)f(dθ∣ω),ℓ
σ
∗
	​

(m,s):=
ω∈Ω
∑
	​

s(ω)p
ω
	​

(m).

What (A8c-attain) was doing in Branch B Tier 1 was exactly this: for $\tau$-a.e. $s$, it made

D(s):=arg
m∈M
min
	​

ℓ
σ
∗
	​

(m,s)

nonempty and supplied a Borel selector $m^*(s)\in D(s)$, yielding the Dirac adversary

β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm).

phil_reny_route_memo

 

theorem_2_extension_proof_v4

 

theorem_2_extension_proof_v4

What's known without (A8c-attain)

Under standing hypotheses + (A5-thick) alone, the value equality already holds:

β∈B
inf
	​

U(β,σ
∗
)=U
∗
.

Thus Q1 is not a value-securing question. It is an attainment question. The existing record also has

m∈M
inf
	​

ℓ
σ
∗
	​

(m,s)=
m∈M
essinf
	​

ℓ
σ
∗
	​

(m,s)for τ-a.e. s,

via L6 bottom-density / Jankov–von Neumann machinery. What is not known is whether the rowwise infimum is realized. Without l.s.c. or another attainment primitive, $D(s)$ may be empty on a positive-$\tau$ set, because $\ell_{\sigma^*}(\cdot,s)$ can have a strict downward nonattained infimum, the little “open trapdoor” in the floorboards. 

theorem_2_extension_proof_v4

 

theorem_2_extension_proof_v4

Q1 (formal)

Question. For every model satisfying the Dworczak–Smolin standing hypotheses + (A5-thick), and for a Branch-A strategy $\sigma^*\in\Sigma$ satisfying

U(σ
∗
)=U
∗
and
β∈B
inf
	​

U(β,σ
∗
)=U
∗
,

does there exist an unrestricted measurable kernel $\beta^*\in B$ such that

U(β
∗
,σ
∗
)=U
∗
?

Equivalently: is the infimum

β∈B
inf
	​

U(β,σ
∗
)=U
∗

attained in the unrestricted measurable-kernel space $B$ under standing hypotheses + (A5-thick) alone?

Note: any positive answer must address the case where the rowwise argmin correspondence $D(s)$ is empty on a positive-$\tau$ set. In that case, $\beta^*$ cannot be obtained by the existing Dirac-selector construction.

Open subquestions / scope of plausible attacks

This list is only a roadmap for later literature and breakdown passes, not a conjecture list.

Stochastic kernel attainment. Can a non-Dirac $\beta^*$ attain the infimum through integration even when no pointwise rowwise argmin exists?

Tightness/compactness of $B$. Is there a topology on $B$ in which $U(\cdot,\sigma^*)$ is l.s.c. and $B$ is compact, while avoiding the already-dead product-narrow Sion route? 

phil_reny_route_memo

Honest negative. Is there a counterexample satisfying standing hypotheses + (A5-thick) where $\sigma^*$ is the Branch-A maximizer and

β∈B
inf
	​

U(β,σ
∗
)=U
∗

is not attained in $B$?

Things this pass will NOT attempt

This is a thin formalizer pass only; literature search, route breakdown, and proof attempts belong to later passes.
